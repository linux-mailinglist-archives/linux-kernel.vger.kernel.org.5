Return-Path: <linux-kernel+bounces-83806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177AF869EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91490284072
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38AD1487C6;
	Tue, 27 Feb 2024 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpfRyXaU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCCD4B5C1;
	Tue, 27 Feb 2024 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057709; cv=none; b=XHW9xwV5U9raIC45w3lKNzFDzExGIfHR6V5J0qQLlGKaKcqHkF4b9gt2Gh2UdSkf9DODnAut5CHFm+onmZN/7YrxQte7BejwlS/hrkHscvA+QvAAYuUHybU2WAS7q7WvR5ti9N2MBj9hIpY+iIRIsKzYAu7Fm2Fan8KHNpbz14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057709; c=relaxed/simple;
	bh=oQ5lgEqM93Az2/mBkEVI2NmWaWp+Sl8k1tCKiDAjuCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWK8joj2TBXrDvF1Xq8/m2ne/jCz1Ig1VEGmsFCfQlYACgc2x3dHsQi6wbmExksAWiDhttV9kqQxBO0ZzGkyKLypg0NU9QysneF42NRtDtnt0Axce3KbOIEIbVzCVWFCOEQLy18mA2UlK7HTUWjD0e0ed64J+UvmK93RkQc1K2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpfRyXaU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709057707; x=1740593707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oQ5lgEqM93Az2/mBkEVI2NmWaWp+Sl8k1tCKiDAjuCg=;
  b=dpfRyXaUygx7JYCjSDyXrQpRxIoDErLwIfVbhqgoVCbc69TlGWNJAAIi
   fHmGNMLX85ikuZ8VKKcMomtzTlY24THZnayavZaSDUBkVrolteB8bScq4
   H6oyg+5MvsgmNLwZsW4k93l3ut1khIctQIXNxseUxHWyEzHl+Rl5U+LB1
   5pn7CnrorWsAB+Oa6he/0L0CUE0SFPxNYSKbSpG9nEaC++uI00cuhIYpy
   qHucIQE45D7yGtKhIa5U2fUCGiP8nPQdOFbwPCZqpDO75cs3eOWekPU2b
   14zz7A6fvLL0UhMxLqRItVcwX4pbMuq/y9LfEHELzrISZehh/TrtK++tD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3580188"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3580188"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 10:15:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913918908"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="913918908"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 10:15:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rf1yj-000000081Ib-3XYd;
	Tue, 27 Feb 2024 20:14:57 +0200
Date: Tue, 27 Feb 2024 20:14:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v8 05/10] pinctrl: eyeq5: add platform driver
Message-ID: <Zd4moVd_-bY6Z_kL@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-5-c57fbda7664a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227-mbly-clk-v8-5-c57fbda7664a@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 27, 2024 at 03:55:26PM +0100, Théo Lebrun wrote:
> Add the Mobileye EyeQ5 pin controller driver. It might grow to add later
> support of other platforms from Mobileye. It belongs to a syscon region
> called OLB.
> 
> Existing pins and their function live statically in the driver code
> rather than in the devicetree, see compatible match data.

..

> +config PINCTRL_EYEQ5
> +	bool "Mobileye EyeQ5 pinctrl driver"

Can't be a module?

> +	depends on OF

It's even not needed for this software as far as I can tell from the code.

> +	depends on MACH_EYEQ5 || COMPILE_TEST
> +	select PINMUX
> +	select GENERIC_PINCONF
> +	select MFD_SYSCON
> +	default MACH_EYEQ5
> +	help
> +	  Pin controller driver for the Mobileye EyeQ5 platform. It does both
> +	  pin config & pin muxing. It does not handle GPIO.
> +
> +	  Pin muxing supports two functions for each pin: first is GPIO, second
> +	  is pin-dependent. Pin config is about bias & drive strength.

..

> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>

Semi-random list of the inclusions. Please, fix it.
While doing that, group out pinctrl/* ones as it's done in other drivers.

> +#include "core.h"
> +#include "pinctrl-utils.h"

..

> +struct eq5p_function {
> +	const char		*name;
> +	const char * const	*groups;
> +	unsigned int		ngroups;
> +};

We have struct pinfunction, use it instead.

..

> +static const char * const gpio_groups[] = {
> +	/* Bank A */
> +	"PA0", "PA1", "PA2", "PA3", "PA4", "PA5", "PA6", "PA7", "PA8", "PA9",
> +	"PA10", "PA11", "PA12", "PA13", "PA14", "PA15", "PA16", "PA17", "PA18",
> +	"PA19", "PA20", "PA21", "PA22", "PA23", "PA24", "PA25", "PA26", "PA27",
> +	"PA28",

For all arrays like this, please split them on 4/8/10/16 items per line as it's
much easier to count and refer by index when reading the code.

> +	/* Bank B */
> +	"PB0", "PB1", "PB2", "PB3", "PB4", "PB5", "PB6", "PB7", "PB8", "PB9",
> +	"PB10", "PB11", "PB12", "PB13", "PB14", "PB15", "PB16", "PB17", "PB18",
> +	"PB19", "PB20", "PB21", "PB22",
> +};

..

> +#define FUNCTION(a, b) { .name = a, .groups = b, .ngroups = ARRAY_SIZE(b) }

Use PINCTRL_PINFUNCTION() instead.

..

> +static bool eq5p_test_bit(const struct eq5p_pinctrl *pctrl,
> +			  enum eq5p_bank bank, enum eq5p_regs reg, int offset)
> +{
> +	u32 val = readl(pctrl->base + eq5p_regs[bank][reg]);

> +	if (WARN_ON(offset > 31))
> +		return false;

When this condition can be true?

> +	return (val & BIT(offset)) != 0;
> +}

..

> +static int eq5p_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
> +			    unsigned long *config);

Can't you avoid forward declarations?

..

> +	if (!eq5p_test_bit(pctrl, bank, EQ5P_IOCR, offset)) {

What's wrong with positive conditional?


> +	} else {

> +	}

..

> +static const struct pinctrl_ops eq5p_pinctrl_ops = {
> +	.get_groups_count	= eq5p_pinctrl_get_groups_count,
> +	.get_group_name		= eq5p_pinctrl_get_group_name,
> +	.get_group_pins		= eq5p_pinctrl_get_group_pins,
> +	.pin_dbg_show		= eq5p_pinctrl_pin_dbg_show,

> +	.dt_node_to_map		= pinconf_generic_dt_node_to_map_pin,
> +	.dt_free_map		= pinctrl_utils_free_map,

ifdef is missing for these... But the question is, isn't these a default when
OF is in use?

> +};

..

> +	dev_dbg(pctldev->dev, "%s: func=%s group=%s\n", __func__, func_name,
> +		group_name);

Drop __func__ from all debug messages. With Dynamic Debug enabled (which is
often the case) we can do it at run-time).

..

> +	mask = BIT(offset);
> +	val = is_gpio ? 0 : U32_MAX;

I think you meant something else (semantically) than U32_MAX.
Perhaps GENMASK(31, 0)?

..

> +static int eq5p_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
> +			    unsigned long *config)
> +{
> +	enum pin_config_param param = pinconf_to_config_param(*config);
> +	struct eq5p_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> +	unsigned int offset = eq5p_pin_to_offset(pin);
> +	enum eq5p_bank bank = eq5p_pin_to_bank(pin);
> +	u32 val_ds, arg = 0;

What's arg assignment for?

> +	bool pd, pu;
> +
> +	pd = eq5p_test_bit(pctrl, bank, EQ5P_PD, offset);
> +	pu = eq5p_test_bit(pctrl, bank, EQ5P_PU, offset);
> +
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_DISABLE:
> +		arg = !(pd || pu);
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		arg = pd;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		arg = pu;
> +		break;
> +	case PIN_CONFIG_DRIVE_STRENGTH:
> +		offset *= 2; /* two bits per pin */
> +		if (offset >= 32) {
> +			val_ds = readl(pctrl->base + eq5p_regs[bank][EQ5P_DS_HIGH]);
> +			offset -= 32;
> +		} else {
> +			val_ds = readl(pctrl->base + eq5p_regs[bank][EQ5P_DS_LOW]);
> +		}

I'm wondering why you can't use your helpers before multiplication?

> +		arg = (val_ds >> offset) & 0b11;

GENMASK(1, 0)

> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	*config = pinconf_to_config_packed(param, arg);
> +	return 0;
> +}

..

> +static int eq5p_pinconf_set_drive_strength(struct pinctrl_dev *pctldev,
> +					   unsigned int pin, u32 arg)
> +{
> +	struct eq5p_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> +	unsigned int offset = eq5p_pin_to_offset(pin);
> +	enum eq5p_bank bank = eq5p_pin_to_bank(pin);
> +	unsigned int reg;
> +	u32 mask, val;
> +
> +	if (arg > 3) {

Magic number.

> +		dev_err(pctldev->dev, "Unsupported drive strength: %u\n", arg);
> +		return -EINVAL;
> +	}
> +
> +	offset *= 2; /* two bits per pin */
> +
> +	if (offset >= 32) {
> +		reg = EQ5P_DS_HIGH;
> +		offset -= 32;
> +	} else {
> +		reg = EQ5P_DS_LOW;
> +	}

> +	mask = 0b11 << offset;
> +	val = arg << offset;
> +	eq5p_update_bits(pctrl, bank, reg, mask, val);

Similar comments as per previous function.

> +	return 0;
> +}

..

> +static const struct of_device_id eq5p_match[] = {
> +	{ .compatible = "mobileye,eyeq5-pinctrl" },
> +	{},

No comma in the terminator entry.

> +};

No MODULE_DEVICE_TABLE()?

> +static struct platform_driver eq5p_driver = {
> +	.driver = {
> +		.name = "eyeq5-pinctrl",
> +		.of_match_table = eq5p_match,
> +	},
> +	.probe = eq5p_probe,
> +};

> +

Unneeded blank line.

> +builtin_platform_driver(eq5p_driver);

-- 
With Best Regards,
Andy Shevchenko



