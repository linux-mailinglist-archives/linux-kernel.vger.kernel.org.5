Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3900B7D8F22
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbjJ0HCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0HCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:02:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3993C116
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:02:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56451C433C8;
        Fri, 27 Oct 2023 07:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698390161;
        bh=Ds+sU4YwFpvA1SBMBRqBpy7PrakErGkYN8PFxMYfJOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4LxcO1yT9a4Cwqk7hs8XRZlC1eEL4dKKdysCeSAKLJKlf7v0D0fwOX66O94yX7+i
         CMAfkoFpf/odmuwSbgFIBi0cr7Nbu9DSXGcH3ZlINh7N7HIMpZHZnw60NuZ6Zykd2X
         m9kIcoAV0E9lNqQ1Mny0QyUZM3uQlHxqDzYWdsa8=
Date:   Fri, 27 Oct 2023 09:02:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
Cc:     linux-kernel@vger.kernel.org, lee@kernel.org, arnd@arndb.de
Subject: Re: [PATCH v1 2/3] drivers: mfd: Add support for TPS65224 i2c driver
Message-ID: <2023102713-jigsaw-straw-34f2@gregkh>
References: <20231026133226.290040-1-sirisha.gairuboina@Ltts.com>
 <20231026133226.290040-3-sirisha.gairuboina@Ltts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026133226.290040-3-sirisha.gairuboina@Ltts.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 07:02:25PM +0530, Gairuboina Sirisha wrote:
> From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> 
> Added MFD driver that enables I2C communication with and without CRC
> 
> Signed-off-by: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> ---
>  drivers/mfd/Kconfig        |  14 +++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/tps65224-i2c.c | 245 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 260 insertions(+)
>  create mode 100644 drivers/mfd/tps65224-i2c.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2e4906484eed..943d85d49fc5 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1767,12 +1767,26 @@ config MFD_TPS6594_SPI
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called tps6594-spi.
> +

That line should have been added in the first patch.


>  config MFD_TPS65224
>          tristate
>          select MFD_CORE
>          select REGMAP
>          select REGMAP_IRQ
>  
> +config MFD_TPS65224_I2C
> +        tristate "TI TPS65224 Power Management chip with I2C"
> +        select MFD_TPS65224
> +        select REGMAP_I2C
> +        select CRC8
> +        depends on I2C
> +        help
> +          If you say yes here you get support for the TPS65224 series of
> +          PM chips with I2C interface.
> +
> +          This driver can also be built as a module.  If so, the module
> +          will be called tps65224-i2c.
> +
>  config TWL4030_CORE
>  	bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
>  	depends on I2C=y
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index ff4e158fa4db..4963fecd3e93 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -103,6 +103,7 @@ obj-$(CONFIG_MFD_TPS6594)	+= tps6594-core.o
>  obj-$(CONFIG_MFD_TPS6594_I2C)	+= tps6594-i2c.o
>  obj-$(CONFIG_MFD_TPS6594_SPI)	+= tps6594-spi.o
>  obj-$(CONFIG_MFD_TPS65224)      += tps65224-core.o
> +obj-$(CONFIG_MFD_TPS65224)      += tps65224-i2c.o
>  obj-$(CONFIG_MENELAUS)		+= menelaus.o
>  
>  obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
> diff --git a/drivers/mfd/tps65224-i2c.c b/drivers/mfd/tps65224-i2c.c
> new file mode 100644
> index 000000000000..c6300138ce4c
> --- /dev/null
> +++ b/drivers/mfd/tps65224-i2c.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * I2C access driver for TI TPS65224 PMIC
> + *
> + * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/

Again, check your copyright lines please.

thanks,

greg k-h
