Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A137A9ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjIUSul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjIUSuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:50:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0835E1FC9;
        Thu, 21 Sep 2023 09:58:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C2CC3279A;
        Thu, 21 Sep 2023 10:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695292389;
        bh=znMmmtUolq/3rZ6hqAdIblfLa4SGUSETXPL9cWzpQkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YpOw0dpzNu0HppSGdiZHRtAQkjjG7fQ779n1Loo09yhPoN/PPxmQPkuok5HU1g1NV
         fYIp7QmV4/uanrScQLNZHoEiGH+HDxBeZKllxrpJZKB+HRRYxWiCwQSCIy3yS/i80i
         LD4/yVZQmwqRUpsrprIgmd8PaxQEVP3gjaMSNKm16vtCawfqbUVWzUu3hopLbRmACC
         Mqyt1beqP2Hk7GLvgAr65kBor6SlE343RcEpJB/JK6yQXoyJN0hktXfdPaQjlAsm6t
         06P/zLogLS90CmBOle70T+ljRSObvjVoV1QEd6Y9C6icqbQ3837xuwUyn8mgeqAtIi
         ImyDIdAVAiu6A==
Date:   Thu, 21 Sep 2023 11:33:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v4] leds: max5970: Add support for max5970
Message-ID: <20230921103305.GC3449785@google.com>
References: <20230921091255.3792179-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230921091255.3792179-1-naresh.solanki@9elements.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023, Naresh Solanki wrote:

> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> The MAX5970 is hot swap controller and has 4 indication LED.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> Reviewed-by: Lee Jones <lee@kernel.org>
> ---
> Changes in V4:
> - Compact declaration of variable to single line
> - Use sizeof(*ddata) instead of sizeof(struct max5970_led).
> - Use the shorter 'dev' version whilst it's available
> Changes in V3:
> - Drop array for ddata variable.
> Changes in V2:
> - Add of_node_put before return.
> - Code cleanup
> - Refactor code & remove max5970_setup_led function.
> ---
>  drivers/leds/Kconfig        |  11 ++++
>  drivers/leds/Makefile       |   1 +
>  drivers/leds/leds-max5970.c | 109 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)
>  create mode 100644 drivers/leds/leds-max5970.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index b92208eccdea..03ef527cc545 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -637,6 +637,17 @@ config LEDS_ADP5520
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called leds-adp5520.
>  
> +config LEDS_MAX5970
> +	tristate "LED Support for Maxim 5970"
> +	depends on LEDS_CLASS
> +	depends on MFD_MAX5970
> +	help
> +	  This option enables support for the Maxim MAX5970 & MAX5978 smart
> +	  switch indication LEDs via the I2C bus.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called leds-max5970.
> +
>  config LEDS_MC13783
>  	tristate "LED Support for MC13XXX PMIC"
>  	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index d7348e8bc019..6eaee0a753c6 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_LP8501)		+= leds-lp8501.o
>  obj-$(CONFIG_LEDS_LP8788)		+= leds-lp8788.o
>  obj-$(CONFIG_LEDS_LP8860)		+= leds-lp8860.o
>  obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
> +obj-$(CONFIG_LEDS_MAX5970)		+= leds-max5970.o
>  obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
>  obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
>  obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
> diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max5970.c
> new file mode 100644
> index 000000000000..5b87f078af85
> --- /dev/null
> +++ b/drivers/leds/leds-max5970.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device driver for leds in MAX5970 and MAX5978 IC
> + *
> + * Copyright (c) 2022 9elements GmbH
> + *
> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> + */
> +
> +#include <linux/leds.h>
> +#include <linux/mfd/max5970.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define ldev_to_maxled(c)       container_of(c, struct max5970_led, cdev)
> +
> +struct max5970_led {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct led_classdev cdev;
> +	unsigned int index;
> +};
> +
> +static int max5970_led_set_brightness(struct led_classdev *cdev,
> +				      enum led_brightness brightness)
> +{
> +	struct max5970_led *ddata = ldev_to_maxled(cdev);
> +	int ret, val;
> +
> +	/* Set/clear corresponding bit for given led index */
> +	val = !brightness ? BIT(ddata->index) : 0;
> +
> +	ret = regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, BIT(ddata->index), val);
> +	if (ret < 0)
> +		dev_err(cdev->dev, "failed to set brightness %d", ret);
> +
> +	return ret;
> +}
> +
> +static int max5970_led_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev_of_node(dev->parent);
> +	struct regmap *regmap;
> +	struct device_node *led_node, *child;
> +	struct max5970_led *ddata;
> +	int ret = -ENODEV, num_leds = 0;
> +
> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap)
> +		return -EPROBE_DEFER;

You're too quick off the mark.

Let's finish the discussion about this first.

-- 
Lee Jones [李琼斯]
