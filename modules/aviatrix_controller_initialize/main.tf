/**
 * # Aviatrix Controller Initialize
 *
 * This module executes the initialization script on the Aviatrix Controller.
 */

terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

locals {
  terraform_module_path = var.terraform_module_path == "" ? path.module : "${var.terraform_module_path}/aviatrix_controller_initialize"
}
resource "null_resource" "run_script" {
  provisioner "local-exec" {
    command = "python3 -W ignore ${local.terraform_module_path}/aviatrix_controller_init.py"
    environment = {
      HOSTNAME = var.avx_controller_public_ip
      PRIVATE_IP = var.avx_controller_private_ip
      ADMIN_EMAIL = var.avx_controller_admin_email
      NEW_ADMIN_PASSWORD = var.avx_controller_admin_password
      ARM_SUBSCRIPTION_ID = var.arm_subscription_id
      ARM_APPLICATION_CLIENT_ID = var.arm_application_id
      ARM_APPLICATION_CLIENT_SECRET = var.arm_application_key
      DIRECTORY_TENANT_ID = var.directory_id
      ACCOUNT_EMAIL = var.account_email
      ACCESS_ACCOUNT_NAME = var.access_account_name
      AVIATRIX_CUSTOMER_ID = var.aviatrix_customer_id
      CONTROLLER_VERSION = var.controller_version
     }
  }
}