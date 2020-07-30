provider "aws" {
  region = "us-east-2"
}

data "aws_vpc" "default" {
  default = true
}


module "security_grup" {
  source = "../../"

  name        = var.sg_name
  description = "security group"
  vpc_id      = data.aws_vpc.default.id


  ingress_with_cidr_blocks = [
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "30.30.30.30/32"
    },
    {
      from_port   = 10
      to_port     = 20
      protocol    = 6
      description = "Service name"
      cidr_blocks = "10.10.0.0/20"
    },
  ]


  tags = {
    Service     = "test-basic"
    Managed_by  = "Terraform"
    Environment = "test"
  }

}


variable "sg_name" {}
