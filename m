Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DAE7A82B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbjITNFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbjITNFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:05:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3D0CF;
        Wed, 20 Sep 2023 06:05:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BA0C433CA;
        Wed, 20 Sep 2023 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695215132;
        bh=WI94jAe83bYDoVs4qzGUTqHeVVXgXwGTtyrojt6IuZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGo2tSXAQQTTttxYWAjHaKXK8QhtOjG5uiRl8wgYPsPbiBSYHk/zSPePcL2QYkbEh
         i4ieUAg+61z0CDMA+vpz0Fz9PUNMUN3DwMq/kL/dT7WaghiVGC456Eqtw+X9C8aniQ
         fdBQTj8sr65gRcOUv/TtdI7u49x9OZgKVZcpGdVib24BTv9NzAQyfFbVciquY9G0/X
         +Et0LBTYL7n3gGxScAloqtrq0RjHkjgWDwrQc+D4AsyCtAp6G9HtMN1dbTlnmlvhnZ
         s0UPmf4h7E7qQsnOZj1ZU5I9sGgnT6YGTVMeurDMKzTvnVtSIIH0rmH51WcYAfqg8U
         7M4hGL7SMWlZA==
Date:   Wed, 20 Sep 2023 14:05:28 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [RESEND PATCH v3] leds: max5970: Add support for max5970
Message-ID: <20230920130528.GG13143@google.com>
References: <20230914114521.1491390-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914114521.1491390-1-naresh.solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023, Naresh Solanki wrote:

> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> The MAX5970 is hot swap controller and has 4 indication LED.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
> Changes in V3:
> - Drop array for ddata variable.
> Changes in V2:
> - Add of_node_put before return.
> - Code cleanup
> - Refactor code & remove max5970_setup_led function.
> ---
>  drivers/leds/Kconfig        |  11 ++++
>  drivers/leds/Makefile       |   1 +
>  drivers/leds/leds-max5970.c | 110 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 122 insertions(+)
>  create mode 100644 drivers/leds/leds-max5970.c

Couple of nits and you're good to go.

Once fixed please resubmit with my:

  Reviewed-by: Lee Jones <lee@kernel.org>

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
> index 000000000000..c9685990e26e
> --- /dev/null
> +++ b/drivers/leds/leds-max5970.c
> @@ -0,0 +1,110 @@
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
> +	struct device_node *led_node;
> +	struct device_node *child;

Nit: You can place these on the same line.

> +	struct max5970_led *ddata;
> +	int ret = -ENODEV, num_leds = 0;
> +
> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap)
> +		return -EPROBE_DEFER;

Why are you deferring here?

> +	led_node = of_get_child_by_name(np, "leds");
> +	if (!led_node)
> +		return -ENODEV;
> +
> +	for_each_available_child_of_node(led_node, child) {
> +		u32 reg;
> +
> +		if (of_property_read_u32(child, "reg", &reg))
> +			continue;
> +
> +		if (reg >= MAX5970_NUM_LEDS) {
> +			dev_err(dev, "invalid LED (%u >= %d)\n", reg, MAX5970_NUM_LEDS);
> +			continue;
> +		}
> +
> +		ddata = devm_kzalloc(dev, sizeof(struct max5970_led), GFP_KERNEL);

Nit: sizeof(*ddata)

> +		if (!ddata) {
> +			of_node_put(child);
> +			return -ENOMEM;
> +		}
> +
> +		ddata->index = reg;
> +		ddata->regmap = regmap;
> +		ddata->dev = dev;
> +
> +		if (of_property_read_string(child, "label", &ddata->cdev.name))
> +			ddata->cdev.name = child->name;
> +
> +		ddata->cdev.max_brightness = 1;
> +		ddata->cdev.brightness_set_blocking = max5970_led_set_brightness;
> +		ddata->cdev.default_trigger = "none";
> +
> +		ret = devm_led_classdev_register(ddata->dev, &ddata->cdev);

Nit: Use the shorter 'dev' version whilst it's available.

> +		if (ret < 0) {
> +			of_node_put(child);
> +			dev_err(dev, "Failed to initialize LED %u\n", reg);
> +			return ret;
> +		}
> +		num_leds++;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct platform_driver max5970_led_driver = {
> +	.driver = {
> +		.name = "max5970-led",
> +	},
> +	.probe = max5970_led_probe,
> +};
> +
> +module_platform_driver(max5970_led_driver);
> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> +MODULE_AUTHOR("Naresh Solanki <Naresh.Solanki@9elements.com>");
> +MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
> +MODULE_LICENSE("GPL");
> 
> base-commit: baca986e1f2c31f8e4b2a6d99d47c3bc844033e8
> -- 
> 2.41.0
> 

-- 
Lee Jones [李琼斯]
