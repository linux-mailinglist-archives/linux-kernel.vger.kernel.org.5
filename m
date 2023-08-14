Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AA377C26B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjHNV3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjHNV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:29:18 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF04210F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:29:16 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 9dbe4f3b-3ae9-11ee-b3cf-005056bd6ce9;
        Tue, 15 Aug 2023 00:29:14 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 15 Aug 2023 00:29:14 +0300
To:     TY Chang <tychang@realtek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] pinctrl: realtek: Add common pinctrl driver for
 Realtek DHC RTD SoCs
Message-ID: <ZNqcqmwTXMpLxqIf@surfacebook.localdomain>
References: <20230726090409.16606-1-tychang@realtek.com>
 <20230726090409.16606-2-tychang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726090409.16606-2-tychang@realtek.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jul 26, 2023 at 05:04:03PM +0800, TY Chang kirjoitti:
> The RTD SoCs share a similar design for pinmux and pinconfig.
> This common pinctrl driver supports different variants within the RTD
> SoCs.

> +config PINCTRL_RTD
> +	tristate "Realtek DHC core pin controller driver"

Why is it user-visible?

> +	depends on ARCH_REALTEK

> +	default y

Why?

> +	select PINMUX
> +	select GENERIC_PINCONF

...

> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/module.h>

> +#include <linux/of.h>
> +#include <linux/of_address.h>

Not used or not needed, use proper platform driver APIs

> +#include <linux/pinctrl/machine.h>
> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>

Move this group outside generic headers...

> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>

+ Blank line. You have missing headers (like types.h)/

...here.

> +#include "../core.h"
> +#include "../pinctrl-utils.h"

+ Blank line.

> +#include "pinctrl-rtd.h"

...

> +static const struct pinconf_generic_params rtd_custom_bindings[] = {
> +	{"realtek,pdrive", RTD_P_DRIVE, 0},
> +	{"realtek,ndrive", RTD_N_DRIVE, 0},
> +	{"realtek,dcycle", RTD_D_CYCLE, 0},

Use C99 initializers.

> +};

...

> +static void rtd_pinctrl_dbg_show(struct pinctrl_dev *pcdev,
> +				 struct seq_file *s,
> +				 unsigned int offset)
> +{
> +	struct rtd_pinctrl *data = pinctrl_dev_get_drvdata(pcdev);
> +	const struct rtd_pin_desc *mux = &data->info->muxes[offset];
> +	const struct rtd_pin_mux_desc *func;
> +	u32 val;
> +	u32 mask;
> +	u32 pin_val;

> +	int is_map;

Actually it's boolean. Why int?

> +	if (!mux->name) {
> +		seq_puts(s, "[not defined]");
> +		return;
> +	}
> +	val = readl_relaxed(data->base + mux->mux_offset);
> +	mask = mux->mux_mask;
> +	pin_val = val & mask;
> +
> +	is_map = 0;
> +	func = &mux->functions[0];
> +	seq_puts(s, "function: ");

> +	while (func->name) {
> +		if (func->mux_value == pin_val) {
> +			is_map = 1;
> +			seq_printf(s, "[%s] ", func->name);
> +		} else {
> +			seq_printf(s, "%s ", func->name);
> +		}
> +		func++;
> +	}

This can be a long list, why not simply print only mapped function?

> +	if (!is_map)
> +		seq_puts(s, "[not defined]");
> +}

...

> +static const struct rtd_pin_desc *rtd_pinctrl_find_mux(struct rtd_pinctrl *data, unsigned int pin)
> +{
> +	if (!data->info->muxes[pin].name)
> +		return &data->info->muxes[pin];
> +
> +	return NULL;

Can the error (?) case be handled first?

	if (data->info->muxes[pin].name)
		return NULL;

> +}

...

> +static void rtd_pinctrl_update_bits(struct rtd_pinctrl *data, unsigned int offset,
> +				    unsigned int mask, unsigned int val)
> +{
> +	unsigned int reg = readl_relaxed(data->base + offset);

> +	reg &= ~mask;
> +	reg |= (mask & val);

Please, use idiomatic one liner:

	reg = (reg & ~mask) | (val & mask);

> +	writel_relaxed(reg, data->base + offset);
> +}

...

> +static const struct pinctrl_pin_desc
> +	*rtd_pinctrl_get_pin_by_number(struct rtd_pinctrl *data, int number)

Weird indentation.

> +{
> +	int i;
> +
> +	for (i = 0; i < data->info->num_pins; i++) {
> +		if (data->info->pins[i].number == number)
> +			return &data->info->pins[i];
> +	}
> +
> +	return NULL;
> +}

...

> +static const struct rtd_pin_config_desc
> +	*rtd_pinctrl_find_config(struct rtd_pinctrl *data, unsigned int pin)
> +{
> +	if (!data->info->configs[pin].name)
> +		return &data->info->configs[pin];
> +
> +	return NULL;

	if (...)
		return NULL;

> +}

...

> +	switch ((u32)param) {

Why casting?!

> +	case PIN_CONFIG_INPUT_SCHMITT:
> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +		if (config_desc->smt_offset == NA) {

> +			dev_err(data->dev, "Not support input schmitt for pin: %s\n", name);

In all cases like this, why do you need the message to be printed?

> +			return -ENOTSUPP;
> +		}
> +		smt_off = config_desc->base_bit + config_desc->smt_offset;
> +		set_val = arg;
> +
> +		mask = BIT(smt_off);
> +		val = set_val ? BIT(smt_off) : 0;
> +		rtd_pinctrl_update_bits(data, config_desc->reg_offset, mask, val);
> +		break;

...

> +	case PIN_CONFIG_DRIVE_STRENGTH:
> +		curr_off = config_desc->base_bit + config_desc->curr_offset;
> +		strength = arg;

> +		val = 0;

How is this assignment being used?

> +		switch (config_desc->curr_type) {
> +		case PADDRI_4_8:
> +			if (strength == 4)

BIT() ?

> +				val = 0;
> +			else if (strength == 8)

Ditto.

> +				val = BIT(curr_off);
> +			else
> +				return -EINVAL;
> +			break;
> +		case PADDRI_2_4:
> +			if (strength == 2)

Ditto.

> +				val = 0;
> +			else if (strength == 4)

Ditto.

> +				val = BIT(curr_off);
> +			else
> +				return -EINVAL;
> +			break;
> +		case NA:
> +			dev_err(data->dev, "Not support drive strength for pin: %s\n", name);
> +			return -ENOTSUPP;
> +		default:
> +			return -EINVAL;
> +		}
> +		mask = BIT(curr_off);
> +		rtd_pinctrl_update_bits(data, config_desc->reg_offset, mask, val);
> +		break;
> +
> +	case PIN_CONFIG_POWER_SOURCE:
> +		if (config_desc->power_offset == NA) {
> +			dev_err(data->dev, "Not support power source for pin: %s\n", name);
> +			return -ENOTSUPP;
> +		}
> +		reg_off = config_desc->reg_offset;
> +		pow_off = config_desc->base_bit + config_desc->power_offset;
> +		if (pow_off >= 32) {
> +			reg_off += 0x4;
> +			pow_off -= 32;
> +		}

Less error prone is to use division and multiplication. Something like

		pow_bit = config_desc->base_bit + config_desc->power_offset;
		reg_off = config_desc->reg_offset + 4 * (pow_bit / 32);
		pow_off = pow_bit % 32;

> +		set_val = arg;
> +		mask = BIT(pow_off);
> +		val = set_val ? mask : 0;
> +		rtd_pinctrl_update_bits(data, reg_off, mask, val);
> +		break;
> +
> +	case RTD_P_DRIVE:
> +		sconfig_desc = rtd_pinctrl_find_sconfig(data, pinnr);
> +		if (!sconfig_desc) {
> +			dev_err(data->dev, "Not support P driving for pin: %s\n", name);
> +			return -ENOTSUPP;
> +		}
> +		set_val = arg;
> +		reg_off = sconfig_desc->reg_offset;
> +		p_off = sconfig_desc->pdrive_offset;
> +		if (p_off >= 32) {
> +			reg_off += 0x4;
> +			p_off -= 32;
> +		}

Ditto.

> +		mask = GENMASK(p_off + sconfig_desc->pdrive_maskbits - 1, p_off);

No, this is suboptimal, better

		mask = GENMASK(sconfig_desc->pdrive_maskbits - 1, 0) << p_off;

> +		val = set_val << p_off;
> +		rtd_pinctrl_update_bits(data, reg_off, mask, val);
> +		break;
> +
> +	case RTD_N_DRIVE:
> +		sconfig_desc = rtd_pinctrl_find_sconfig(data, pinnr);
> +		if (!sconfig_desc) {
> +			dev_err(data->dev, "Not support N driving for pin: %s\n", name);
> +			return -ENOTSUPP;
> +		}
> +		set_val = arg;
> +		reg_off = sconfig_desc->reg_offset;
> +		n_off = sconfig_desc->ndrive_offset;
> +		if (n_off >= 32) {
> +			reg_off += 0x4;
> +			n_off -= 32;
> +		}

As per above.

> +		mask = GENMASK(n_off + sconfig_desc->ndrive_maskbits - 1, n_off);

As per above.

> +		val = set_val << n_off;
> +		rtd_pinctrl_update_bits(data, reg_off, mask, val);
> +		break;

> +	case RTD_D_CYCLE:
> +		sconfig_desc = rtd_pinctrl_find_sconfig(data, pinnr);
> +		if (!sconfig_desc || sconfig_desc->dcycle_offset == NA) {
> +			dev_err(data->dev, "Not support duty cycle for pin: %s\n", name);
> +			return -ENOTSUPP;
> +		}
> +		set_val = arg;
> +		mask = GENMASK(sconfig_desc->dcycle_offset +
> +		sconfig_desc->dcycle_maskbits - 1, sconfig_desc->dcycle_offset);

Broken indentation and see above.

> +		val = set_val << sconfig_desc->dcycle_offset;
> +		rtd_pinctrl_update_bits(data, sconfig_desc->reg_offset, mask, val);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}

...

> +static int rtd_pin_config_get(struct pinctrl_dev *pcdev, unsigned int pinnr,
> +			      unsigned long *config)
> +{
> +	unsigned int param = pinconf_to_config_param(*config);

> +	unsigned int arg = 0;

How is this assignment being used?

> +
> +	switch (param) {
> +	default:
> +		return -ENOTSUPP;
> +	}

> +	*config = pinconf_to_config_packed(param, arg);
> +	return 0;

This is a dead code, why?!

> +}

...

> +static int rtd_pin_config_set(struct pinctrl_dev *pcdev, unsigned int pinnr,
> +			      unsigned long *configs, unsigned int num_configs)
> +{
> +	struct rtd_pinctrl *data = pinctrl_dev_get_drvdata(pcdev);
> +	int i;

> +	int ret = 0;

How is this assignment being used?

> +	for (i = 0; i < num_configs; i++) {
> +		ret = rtd_pconf_parse_conf(data, pinnr,
> +					   pinconf_to_config_param(configs[i]),
> +					   pinconf_to_config_argument(configs[i]));
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

...

> +int rtd_pinctrl_probe(struct platform_device *pdev, const struct rtd_pinctrl_desc *desc)
> +{
> +	struct rtd_pinctrl *data;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->base = of_iomap(pdev->dev.of_node, 0);

Use proper platform driver API.
Also, why not devm_*()?

> +	if (IS_ERR(data->base))
> +		return PTR_ERR(data->base);
> +
> +	data->dev = &pdev->dev;
> +	data->info = desc;
> +	data->desc.name = dev_name(&pdev->dev);
> +	data->desc.pins = data->info->pins;
> +	data->desc.npins = data->info->num_pins;
> +	data->desc.pctlops = &rtd_pinctrl_ops;
> +	data->desc.pmxops = &rtd_pinmux_ops;
> +	data->desc.confops = &rtd_pinconf_ops;
> +	data->desc.custom_params = rtd_custom_bindings;
> +	data->desc.num_custom_params = ARRAY_SIZE(rtd_custom_bindings);
> +	data->desc.owner = THIS_MODULE;
> +
> +	data->pcdev = pinctrl_register(&data->desc, &pdev->dev, data);

Why not devm_*()?

> +	if (!data->pcdev)
> +		return -ENOMEM;

> +	platform_set_drvdata(pdev, data);

Is this used anyhow?

> +	dev_dbg(&pdev->dev, "probed\n");
> +
> +	return 0;
> +}

...

> +EXPORT_SYMBOL(rtd_pinctrl_probe);

Use namespace.

...

> +/*
> + * Copyright (c) 2023 Realtek Semiconductor Corp.
> + */

One line.

...

No ifdeffery guard?

...

> +#define NA 0xffffffff

What is this? Bit mask? U32_MAX? -1? 

> +#define PADDRI_4_8 1
> +#define PADDRI_2_4 0

...

> +struct rtd_pin_group_desc {
> +	const char *name;
> +	const unsigned int *pins;
> +	unsigned int num_pins;
> +};
> +
> +struct rtd_pin_func_desc {
> +	const char *name;
> +	const char * const *groups;
> +	unsigned int num_groups;
> +};

NIH struct pingroup, struct pinfunction.

-- 
With Best Regards,
Andy Shevchenko


