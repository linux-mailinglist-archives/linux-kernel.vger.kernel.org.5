Return-Path: <linux-kernel+bounces-30377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B294831DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9E91C21D68
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1080F2C6B2;
	Thu, 18 Jan 2024 16:56:34 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F62CCB8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596993; cv=none; b=jh4PwfMEi/WEGmckbxjOytxRuWAOYiRGParo2opJw5OoKwtFcN/HQM0nU9f/NLCzf74uP3Q1kUc9PJBWOl2pFgMO51LcHDccJS7oT2fV0j/paHaIMTbHTZFGigsPTwqsswFVcJrzpaEBCO4hUeXaWmcXcV1/ddog3JqyRisD8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596993; c=relaxed/simple;
	bh=YSyfdwR1IPYBXzTHw/MjQ4x/9dWs/nW2y8l13r8HVR4=;
	h=Received:From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=ujKZgc1+epFVBofkF9g1YJrfCGvHOMpC4KyN8E5O+dkQLL8501fMPCAk70EPyIBwqgerd2uWpyX41UZcB1R4Lf6fKgyvVhY33c14hkTNMnnEIiMEfwLR3J3/L5qbU5/6VkGHHCaDByBHldg6KDio5w7YbyDAIr8auuejQtmuoPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-108.elisa-laajakaista.fi [88.113.24.108])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 827d83ef-b622-11ee-b3cf-005056bd6ce9;
	Thu, 18 Jan 2024 18:56:23 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Thu, 18 Jan 2024 18:56:22 +0200
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/6] pinctrl: cs42l43: Add support for the cs42l43
Message-ID: <ZalYNhWSdf5onBpL@surfacebook.localdomain>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-5-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804104602.395892-5-ckeepax@opensource.cirrus.com>

Fri, Aug 04, 2023 at 11:46:00AM +0100, Charles Keepax kirjoitti:
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for
> loudspeakers, and two ADCs for wired headset microphone input or
> stereo line input. PDM inputs are provided for digital microphones.
> 
> Add a basic pinctrl driver which supports driver strength for the
> various pins, gpios, and pinmux for the 2 multi-function pins.

GPIOs

..

+ array_size.h

> +#include <linux/module.h>
> +#include <linux/of.h>

 + types.h

..

> +static int cs42l43_pin_set_mux(struct pinctrl_dev *pctldev,
> +			       unsigned int func_idx, unsigned int group_idx)
> +{
> +	struct cs42l43_pin *priv = pinctrl_dev_get_drvdata(pctldev);
> +	unsigned int reg, mask, val;
> +
> +	dev_dbg(priv->dev, "Setting %s to %s\n",
> +		cs42l43_pin_groups[group_idx].name, cs42l43_pin_funcs[func_idx]);
> +
> +	switch (func_idx) {
> +	case CS42L43_FUNC_MIC_SHT:
> +		reg = CS42L43_SHUTTER_CONTROL;
> +		mask = CS42L43_MIC_SHUTTER_CFG_MASK;
> +		val = 0x2 << (group_idx + CS42L43_MIC_SHUTTER_CFG_SHIFT);

BIT(1) ?

> +		break;
> +	case CS42L43_FUNC_SPK_SHT:
> +		reg = CS42L43_SHUTTER_CONTROL;
> +		mask = CS42L43_SPK_SHUTTER_CFG_MASK;
> +		val = 0x2 << (group_idx + CS42L43_SPK_SHUTTER_CFG_SHIFT);

Ditto.

> +		break;
> +	default:
> +		reg = CS42L43_GPIO_FN_SEL;
> +		mask = BIT(group_idx + CS42L43_GPIO1_FN_SEL_SHIFT);
> +		val = (func_idx == CS42L43_FUNC_GPIO) ?
> +				(0x1 << (group_idx + CS42L43_GPIO1_FN_SEL_SHIFT)) : 0;

BIT(0) ?

> +		break;
> +	}
> +
> +	if (priv->shutters_locked && reg == CS42L43_SHUTTER_CONTROL) {
> +		dev_err(priv->dev, "Shutter configuration not available\n");
> +		return -EPERM;
> +	}
> +
> +	return regmap_update_bits(priv->regmap, reg, mask, val);
> +}

..

> +static int cs42l43_gpio_set_direction(struct pinctrl_dev *pctldev,
> +				      struct pinctrl_gpio_range *range,
> +				      unsigned int offset, bool input)
> +{
> +	struct cs42l43_pin *priv = pinctrl_dev_get_drvdata(pctldev);
> +	unsigned int shift = offset + CS42L43_GPIO1_DIR_SHIFT;
> +	int ret;
> +
> +	dev_dbg(priv->dev, "Setting gpio%d to %s\n",
> +		offset + 1, input ? "input" : "output");

Probably candidate for str_input_output() in string_choises.h...

> +	ret = pm_runtime_resume_and_get(priv->dev);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to resume for direction: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(priv->regmap, CS42L43_GPIO_CTRL1,
> +				 BIT(shift), !!input << shift);
> +	if (ret)
> +		dev_err(priv->dev, "Failed to set gpio%d direction: %d\n",
> +			offset + 1, ret);

> +	pm_runtime_put(priv->dev);

Can't runtime PM be put before printing message (if needed)?

> +	return ret;
> +}

..

> +static inline int cs42l43_pin_set_drv_str(struct cs42l43_pin *priv, unsigned int pin,
> +					  unsigned int ma)
> +{
> +	const struct cs42l43_pin_data *pdat = cs42l43_pin_pins[pin].drv_data;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cs42l43_pin_drv_str_ma); i++) {
> +		if (ma == cs42l43_pin_drv_str_ma[i]) {

		if (ma != ...)
			continue;

and one level of indentation less with better readability of the code, no?

> +			if ((i << pdat->shift) > pdat->mask)
> +				goto err;
> +
> +			dev_dbg(priv->dev, "Set drive strength for %s to %d mA\n",
> +				cs42l43_pin_pins[pin].name, ma);
> +
> +			return regmap_update_bits(priv->regmap, pdat->reg,
> +						  pdat->mask, i << pdat->shift);
> +		}
> +	}
> +
> +err:
> +	dev_err(priv->dev, "Invalid drive strength for %s: %d mA\n",
> +		cs42l43_pin_pins[pin].name, ma);
> +	return -EINVAL;
> +}

..

> +static inline int cs42l43_pin_get_db(struct cs42l43_pin *priv, unsigned int pin)

Here and elsewhere these 'inline':s are redundant. Let compiler decide.

..

> +	dev_dbg(priv->dev, "Set debounce %s for %s\n",
> +		str_on_off(us), cs42l43_pin_pins[pin].name);

Probably you wanted to include string_choices.h instead of string_helpers.h?

..

> +	dev_dbg(priv->dev, "Setting gpio%d to %s\n",
> +		offset + 1, value ? "high" : "low");

str_high_low()

..

> +static int cs42l43_pin_probe(struct platform_device *pdev)
> +{

	struct device *dev = &pdev->dev;

will help to make code neater.

> +	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
> +	struct cs42l43_pin *priv;
> +	struct pinctrl_dev *pctldev;
> +	struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = &pdev->dev;
> +	priv->regmap = cs42l43->regmap;
> +
> +	priv->shutters_locked = cs42l43->hw_lock;
> +
> +	priv->gpio_chip.request = gpiochip_generic_request;
> +	priv->gpio_chip.free = gpiochip_generic_free;
> +	priv->gpio_chip.direction_input = cs42l43_gpio_direction_in;
> +	priv->gpio_chip.direction_output = cs42l43_gpio_direction_out;
> +	priv->gpio_chip.add_pin_ranges = cs42l43_gpio_add_pin_ranges;
> +	priv->gpio_chip.get = cs42l43_gpio_get;
> +	priv->gpio_chip.set = cs42l43_gpio_set;
> +	priv->gpio_chip.label = dev_name(priv->dev);
> +	priv->gpio_chip.parent = priv->dev;
> +	priv->gpio_chip.can_sleep = true;
> +	priv->gpio_chip.base = -1;
> +	priv->gpio_chip.ngpio = CS42L43_NUM_GPIOS;

..

> +	if (is_of_node(fwnode)) {
> +		fwnode = fwnode_get_named_child_node(fwnode, "pinctrl");
> +
> +		if (fwnode && !fwnode->dev)
> +			fwnode->dev = priv->dev;
> +	}

What the heck is this?
Why devlink field is set customly here? Please, figure out how to get rid of
this (it should be either global solution via devlink or pin control,
individual drivers must not even touch devlink fwnode fields without a huge
reason why.


> +	priv->gpio_chip.fwnode = fwnode;
> +
> +	device_set_node(priv->dev, fwnode);
> +
> +	devm_pm_runtime_enable(priv->dev);
> +	pm_runtime_idle(priv->dev);
> +
> +	pctldev = devm_pinctrl_register(priv->dev, &cs42l43_pin_desc, priv);
> +	if (IS_ERR(pctldev))
> +		return dev_err_probe(priv->dev, PTR_ERR(pctldev),
> +				     "Failed to register pinctrl\n");
> +
> +	ret = devm_gpiochip_add_data(priv->dev, &priv->gpio_chip, priv);
> +	if (ret)
> +		return dev_err_probe(priv->dev, ret,
> +				     "Failed to register gpiochip\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



