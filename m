Return-Path: <linux-kernel+bounces-83685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A9A869D44
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B851C2154A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A8495CB;
	Tue, 27 Feb 2024 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVED4zJo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AFA47A7D;
	Tue, 27 Feb 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053928; cv=none; b=rPL/ery3XZ2iSbEKOho2Fp3Zv1AKq0RuskiHqMBIer9DqzzVT3r4j1VTy040D5orJpJKoi7NaBT/i6TFa81qX0XFiqYGEK8hbQMCSIcEJ5Nn5Ds1gY991QbL36jssYAur3+PqUqVTP99cUe/VG8PDefPXjsD59Nd8QTsCu03IMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053928; c=relaxed/simple;
	bh=4o7yMAvYJyQcMeGv3WKMeln+uo+IYka9fWH0EbkQvCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZSmmRlYx/VOx6tPNRHqlMPXkLr+4pcrksWdSszKCfwLa178LL/NQkvekkuqefEiT+kEqeka/VYu5Ftdlxh0t2Dfh+UmJLATJMSofN0M4xUJAYR9x3lh8SxGAgLV6JY7Apy/GMEQeTVOwve5/JKKi8PR23lCUzjsTAnlxxjhSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVED4zJo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709053927; x=1740589927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4o7yMAvYJyQcMeGv3WKMeln+uo+IYka9fWH0EbkQvCc=;
  b=nVED4zJoL5aLyk4cuI/OvRhyOQWkggtWuES7Bac4AFxdne6UhGXk9H1Y
   Y3rg72Ea0pnNgd6nkYEdEpbFXtzWzADXh0AT+S3cRmSA+Yy4vIDL+/vmP
   cJRIPdPIissthWWr48DiJwx8szfd1P6XAqtvb2rGVWWdC0CIT7EX9OIa7
   wOatHqX99ClPxVDb0BctKblWla6wBHBbI78Av/irpB8Ts6cIz3iV9bGnE
   bYQTvEs6+nNnpZtYLe+7t5WECk2heLWmUwsoFF3HboJlrq1EaLRFTIgmw
   ym1qvZgL16ZAfTkQ9to2lVCGqq0d35ezC/7/m9xIXYFK1NhWbmEfjm23b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7219492"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7219492"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 09:12:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913917380"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="913917380"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 09:12:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rf0zl-000000080L1-1443;
	Tue, 27 Feb 2024 19:11:57 +0200
Date: Tue, 27 Feb 2024 19:11:56 +0200
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
Subject: Re: [PATCH v8 03/10] clk: eyeq5: add platform driver, and init
 routine at of_clk_init()
Message-ID: <Zd4X3NnBoEl0wu2H@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-3-c57fbda7664a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227-mbly-clk-v8-3-c57fbda7664a@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 27, 2024 at 03:55:24PM +0100, Théo Lebrun wrote:
> Add the Mobileye EyeQ5 clock controller driver. It might grow to add
> support for other platforms from Mobileye.
> 
> It handles 10 read-only PLLs derived from the main crystal on board. It

If you wrap 'It' to the next line, overall text will look better.

> exposes a table-based divider clock used for OSPI. Other platform
> clocks are not configurable and therefore kept as fixed-factor
> devicetree nodes.
> 
> Two PLLs are required early on and are therefore registered at
> of_clk_init(). Those are pll-cpu for the GIC timer and pll-per for the

Ditto for 'the'

> UARTs.

..

> +config COMMON_CLK_EYEQ5
> +	bool "Clock driver for the Mobileye EyeQ5 platform"

> +	depends on OF

Since it's a functional dependency, why not allow compile test without OF being
enabled?

> +	depends on MACH_EYEQ5 || COMPILE_TEST
> +	default MACH_EYEQ5
> +	help
> +	  This driver provides the clocks found on the Mobileye EyeQ5 SoC. Its
> +	  registers live in a shared register region called OLB. It provides 10
> +	  read-only PLLs derived from the main crystal clock which must be constant
> +	  and one divider clock based on one PLL.

..

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/err.h>

+ errno.h (yes, you need both)

> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>

+ overflow.h

> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>

..

> +struct eq5c_pll {
> +	int		index;

Index can be negative? Any comment about this case?

> +	const char	*name;
> +	u32		reg;	/* next 8 bytes are r0 and r1 */

Not sure this comments gives any clarification to a mere reader of the code.
Perhaps you want to name this as reg64 (at least it will show that you have
8 bytes, but I have no clue what is the semantic relationship between r0 and
r1, it's quite cryptic to me). Or maybe it should be reg_0_1?

> +};

..

> +static int eq5c_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;

> +	struct device_node *np = dev->of_node;

It's used only once. Why not just use dev->of_node there?

> +	void __iomem *base_plls, *base_ospi;
> +	struct clk_hw *hw;
> +	int i;
> +
> +	/* Return potential error from eq5c_init(). */
> +	if (IS_ERR(eq5c_clk_data))
> +		return PTR_ERR(eq5c_clk_data);

> +	/* Return an error if eq5c_init() did not get called. */
> +	else if (!eq5c_clk_data)

Redundant 'else'

> +		return -EINVAL;

I didn't get. If eq5c_init() was finished successfully, why do you need to
seems repeat what it already done? What did I miss?

> +	base_plls = devm_platform_ioremap_resource_byname(pdev, "plls");
> +	if (IS_ERR(base_plls))
> +		return PTR_ERR(base_plls);
> +
> +	base_ospi = devm_platform_ioremap_resource_byname(pdev, "ospi");
> +	if (IS_ERR(base_ospi))
> +		return PTR_ERR(base_ospi);
> +
> +	for (i = 0; i < ARRAY_SIZE(eq5c_plls); i++) {
> +		const struct eq5c_pll *pll = &eq5c_plls[i];
> +		unsigned long mult, div, acc;
> +		u32 r0, r1;
> +		int ret;
> +
> +		r0 = readl(base_plls + pll->reg);
> +		r1 = readl(base_plls + pll->reg + sizeof(r0));
> +
> +		ret = eq5c_pll_parse_registers(r0, r1, &mult, &div, &acc);
> +		if (ret) {
> +			dev_warn(dev, "failed parsing state of %s\n", pll->name);
> +			eq5c_clk_data->hws[pll->index] = ERR_PTR(ret);
> +			continue;
> +		}
> +
> +		hw = clk_hw_register_fixed_factor_with_accuracy_fwname(dev, np,
> +				pll->name, "ref", 0, mult, div, acc);
> +		eq5c_clk_data->hws[pll->index] = hw;
> +		if (IS_ERR(hw))

> +			dev_err_probe(dev, PTR_ERR(hw), "failed registering %s\n",
> +				      pll->name);

Missed return statement?

> +	}
> +
> +	hw = clk_hw_register_divider_table_parent_hw(dev, EQ5C_OSPI_DIV_CLK_NAME,
> +			eq5c_clk_data->hws[EQ5C_PLL_PER], 0,
> +			base_ospi, 0, EQ5C_OSPI_DIV_WIDTH, 0,
> +			eq5c_ospi_div_table, NULL);
> +	eq5c_clk_data->hws[EQ5C_DIV_OSPI] = hw;
> +	if (IS_ERR(hw))
> +		dev_err_probe(dev, PTR_ERR(hw), "failed registering %s\n",
> +			      EQ5C_OSPI_DIV_CLK_NAME);

Ditto.

> +	return 0;
> +}

> +static void __init eq5c_init(struct device_node *np)
> +{
> +	void __iomem *base_plls, *base_ospi;
> +	int index_plls, index_ospi;
> +	int i, ret;

Why is i signed?

> +	eq5c_clk_data = kzalloc(struct_size(eq5c_clk_data, hws, EQ5C_NB_CLKS),
> +				GFP_KERNEL);
> +	if (!eq5c_clk_data) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	eq5c_clk_data->num = EQ5C_NB_CLKS;
> +
> +	/*
> +	 * Mark all clocks as deferred. We register some now and others at
> +	 * platform device probe.
> +	 */
> +	for (i = 0; i < EQ5C_NB_CLKS; i++)
> +		eq5c_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);

> +	index_plls = of_property_match_string(np, "reg-names", "plls");
> +	if (index_plls < 0) {
> +		ret = index_plls;
> +		goto err;
> +	}

Better pattern is to avoid the output pollution in the error case. Hence

	ret = of_property_match_string(np, "reg-names", "plls");
	if (ret < 0)
		goto err;
	index_plls = ret;

> +	index_ospi = of_property_match_string(np, "reg-names", "ospi");
> +	if (index_ospi < 0) {
> +		ret = index_ospi;
> +		goto err;
> +	}

Ditto.

> +	base_plls = of_iomap(np, index_plls);
> +	base_ospi = of_iomap(np, index_ospi);
> +	if (!base_plls || !base_ospi) {
> +		ret = -ENODEV;
> +		goto err;
> +	}

> +	for (i = 0; i < ARRAY_SIZE(eq5c_early_plls); i++) {
> +		const struct eq5c_pll *pll = &eq5c_early_plls[i];
> +		unsigned long mult, div, acc;
> +		struct clk_hw *hw;
> +		u32 r0, r1;
> +
> +		r0 = readl(base_plls + pll->reg);
> +		r1 = readl(base_plls + pll->reg + sizeof(r0));
> +
> +		ret = eq5c_pll_parse_registers(r0, r1, &mult, &div, &acc);
> +		if (ret) {
> +			pr_warn("failed parsing state of %s\n", pll->name);
> +			eq5c_clk_data->hws[pll->index] = ERR_PTR(ret);
> +			continue;
> +		}
> +
> +		hw = clk_hw_register_fixed_factor_with_accuracy_fwname(NULL,
> +				np, pll->name, "ref", 0, mult, div, acc);
> +		eq5c_clk_data->hws[pll->index] = hw;
> +		if (IS_ERR(hw))
> +			pr_err("failed registering %s: %ld\n",

%pe ?

> +			       pll->name, PTR_ERR(hw));

Is the error not critical? Is it fine? How is it supposed to work at such
circumstances?

> +	}
> +
> +	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, eq5c_clk_data);
> +	if (ret) {
> +		pr_err("failed registering clk provider: %d\n", ret);
> +		goto err;
> +	}
> +
> +	return;
> +
> +err:
> +	kfree(eq5c_clk_data);
> +	/* Signal to platform driver probe that we failed init. */
> +	eq5c_clk_data = ERR_PTR(ret);
> +}
> +
> +CLK_OF_DECLARE_DRIVER(eq5c, "mobileye,eyeq5-clk", eq5c_init);

-- 
With Best Regards,
Andy Shevchenko



