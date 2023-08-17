Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD40277FB4F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353390AbjHQP4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353420AbjHQP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:56:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB8C30F3;
        Thu, 17 Aug 2023 08:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74180611D9;
        Thu, 17 Aug 2023 15:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4631C433C8;
        Thu, 17 Aug 2023 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692287784;
        bh=Jn6sZJZQZRkxbiQrF3wXC+x7uSTxGKhcmcjjGexsvAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NyVvyXyBXhO8KojCdo4lmk7H943tN3GR/Rg5y4qZ2RmUQ174cXPKvLIiK4QVf+VHb
         wjyf9CsffOXtmfU+kSwwQcjs1poxFES2Wv16VIRcDRDhpr12NvAgJurbvrPjIxTy2N
         QSbNjhnHcvbDrr9PmYiqMqlYMoP5RSeTfA+WaqXaH8VkSyrI1Y0mQ8aGIWy7eqRiD1
         UjgydbqVsgyloxasmJlc5QfWOgMVFu95p0jxNGXwExLt3ybncbkWaibbw0WPOCqpKY
         EglXij6x8MvsJFnvS4+iLLgWulssshr5lqHUX88Kd8g5aLam5HSgSBilVVjGPDZfXu
         jDwoGSaYg3MSQ==
Received: (nullmailer pid 1265806 invoked by uid 1000);
        Thu, 17 Aug 2023 15:56:22 -0000
Date:   Thu, 17 Aug 2023 10:56:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        andrew@aj.id.au, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 14/14] fsi: Add I2C Responder SCOM driver
Message-ID: <20230817155622.GB1179394-robh@kernel.org>
References: <20230612195657.245125-1-eajames@linux.ibm.com>
 <20230612195657.245125-15-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612195657.245125-15-eajames@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 02:56:57PM -0500, Eddie James wrote:
> The I2CR has the capability to directly perform SCOM operations,
> circumventing the need to drive the FSI2PIB engine. Add a new
> driver to perform SCOM operations through the I2CR.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/fsi/Kconfig     |   8 +++
>  drivers/fsi/Makefile    |   1 +
>  drivers/fsi/i2cr-scom.c | 154 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 163 insertions(+)
>  create mode 100644 drivers/fsi/i2cr-scom.c
> 
> diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
> index 999be82720c5..79a31593618a 100644
> --- a/drivers/fsi/Kconfig
> +++ b/drivers/fsi/Kconfig
> @@ -94,4 +94,12 @@ config FSI_OCC
>  	provide the raw sensor data as well as perform thermal and power
>  	management on the system.
>  
> +config I2CR_SCOM
> +	tristate "IBM I2C Responder SCOM driver"
> +	depends on FSI_MASTER_I2CR
> +	help
> +	  This option enables an I2C Responder based SCOM device driver. The
> +	  I2CR has the capability to directly perform SCOM operations instead
> +	  of using the FSI2PIB engine.
> +
>  endif
> diff --git a/drivers/fsi/Makefile b/drivers/fsi/Makefile
> index 34dbaa1c452e..5550aa15e0b1 100644
> --- a/drivers/fsi/Makefile
> +++ b/drivers/fsi/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_FSI_MASTER_AST_CF) += fsi-master-ast-cf.o
>  obj-$(CONFIG_FSI_SCOM) += fsi-scom.o
>  obj-$(CONFIG_FSI_SBEFIFO) += fsi-sbefifo.o
>  obj-$(CONFIG_FSI_OCC) += fsi-occ.o
> +obj-$(CONFIG_I2CR_SCOM) += i2cr-scom.o
> diff --git a/drivers/fsi/i2cr-scom.c b/drivers/fsi/i2cr-scom.c
> new file mode 100644
> index 000000000000..cb7e02213032
> --- /dev/null
> +++ b/drivers/fsi/i2cr-scom.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) IBM Corporation 2023 */
> +
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/fsi.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +
> +#include "fsi-master-i2cr.h"
> +#include "fsi-slave.h"
> +
> +struct i2cr_scom {
> +	struct device dev;
> +	struct cdev cdev;
> +	struct fsi_master_i2cr *i2cr;
> +};
> +
> +static loff_t i2cr_scom_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	switch (whence) {
> +	case SEEK_CUR:
> +		break;
> +	case SEEK_SET:
> +		file->f_pos = offset;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return offset;
> +}
> +
> +static ssize_t i2cr_scom_read(struct file *filep, char __user *buf, size_t len, loff_t *offset)
> +{
> +	struct i2cr_scom *scom = filep->private_data;
> +	u64 data;
> +	int ret;
> +
> +	if (len != sizeof(data))
> +		return -EINVAL;
> +
> +	ret = fsi_master_i2cr_read(scom->i2cr, (u32)*offset, &data);
> +	if (ret)
> +		return ret;
> +
> +	ret = copy_to_user(buf, &data, len);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t i2cr_scom_write(struct file *filep, const char __user *buf, size_t len,
> +			       loff_t *offset)
> +{
> +	struct i2cr_scom *scom = filep->private_data;
> +	u64 data;
> +	int ret;
> +
> +	if (len != sizeof(data))
> +		return -EINVAL;
> +
> +	ret = copy_from_user(&data, buf, len);
> +	if (ret)
> +		return ret;
> +
> +	ret = fsi_master_i2cr_write(scom->i2cr, (u32)*offset, data);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static const struct file_operations i2cr_scom_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= simple_open,
> +	.llseek		= i2cr_scom_llseek,
> +	.read		= i2cr_scom_read,
> +	.write		= i2cr_scom_write,
> +};
> +
> +static int i2cr_scom_probe(struct device *dev)
> +{
> +	struct fsi_device *fsi_dev = to_fsi_dev(dev);
> +	struct i2cr_scom *scom;
> +	int didx;
> +	int ret;
> +
> +	if (!is_fsi_master_i2cr(fsi_dev->slave->master))
> +		return -ENODEV;
> +
> +	scom = devm_kzalloc(dev, sizeof(*scom), GFP_KERNEL);
> +	if (!scom)
> +		return -ENOMEM;
> +
> +	scom->i2cr = to_fsi_master_i2cr(fsi_dev->slave->master);
> +	dev_set_drvdata(dev, scom);
> +
> +	scom->dev.type = &fsi_cdev_type;
> +	scom->dev.parent = dev;
> +	device_initialize(&scom->dev);
> +
> +	ret = fsi_get_new_minor(fsi_dev, fsi_dev_scom, &scom->dev.devt, &didx);
> +	if (ret)
> +		return ret;
> +
> +	dev_set_name(&scom->dev, "scom%d", didx);
> +	cdev_init(&scom->cdev, &i2cr_scom_fops);
> +	ret = cdev_device_add(&scom->cdev, &scom->dev);
> +	if (ret)
> +		fsi_free_minor(scom->dev.devt);
> +
> +	return ret;
> +}
> +
> +static int i2cr_scom_remove(struct device *dev)
> +{
> +	struct i2cr_scom *scom = dev_get_drvdata(dev);
> +
> +	cdev_device_del(&scom->cdev, &scom->dev);
> +	fsi_free_minor(scom->dev.devt);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id i2cr_scom_of_ids[] = {
> +	{ .compatible = "ibm,i2cr-scom" },

This is not documented. Please add a binding.

Rob
