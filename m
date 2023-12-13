Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDF4811B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjLMRv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLMRvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:51:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7428D5;
        Wed, 13 Dec 2023 09:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702489890; x=1734025890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rEF+bIXymy5m74WPjfjq0rqR99CnFPj089dPgtd282Q=;
  b=TivckpyibG2deet/37GmiQekyIZ20FvVBby5pWegk/9cPsQOTCAqTQP5
   owZV1zzT45VUOsd2CZ8Oy0nqItXCLrxPXuzcQAve7oXJNFoEQJ2v1ZxiT
   w9FHiNBubv5d1W9r2JuFlNAb7FO+Q7mYytUfIFSfr1irll2Zc5k92WmSG
   wtrycivHic6WmskRlsCQn/RdWuEz8AX2fWPUWKVGxl0V8ePcKrcxZ4/Ti
   o0TpF+Gtkx5WSpem2koSi+NcNNhL7Yd3n0seDAjr2+Z7pqkF+mDrVZOmX
   jsTIBhwjY0rVYEeoXcYeu2sn0D+nlxWSw0ZpdMHNXooOVKo/VRusuXtTD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="459318857"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="459318857"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:51:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="844402016"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="844402016"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:51:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1rDTOH-00000005bDa-3pRL;
        Wed, 13 Dec 2023 19:51:25 +0200
Date:   Wed, 13 Dec 2023 19:51:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 05/40] pinctrl: add a Cirrus ep93xx SoC pin controller
Message-ID: <ZXnvHYjgnc3VsXnX@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-5-c307b8ac9aa8@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231212-ep93xx-v6-5-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:20:22AM +0300, Nikita Shubin wrote:
> Add a pin control (only multiplexing) driver for ep93xx SoC so
> we can fully convert ep93xx to device tree.
> 
> This driver is capable of muxing ep9301/ep9302/ep9307/ep9312/ep9315
> variants, this is chosen based on "compatible" in device tree.

Mostly nit-picks below, with the exception to setting device node.
See below.

...

> +/*
> + * There are several system configuration options selectable by the DeviceCfg and SysCfg
> + * registers. These registers provide the selection of several pin multiplexing options and also
> + * provide software access to the system reset configuration options. Please refer to the
> + * descriptions of the registers, “DeviceCfg” on page 5-25 and “SysCfg” on page 5-34, for a
> + * detailed explanation.
> + */
> +#define EP93XX_SYSCON_DEVCFG_D1ONG	BIT(30) /* not used */
> +#define EP93XX_SYSCON_DEVCFG_D0ONG	BIT(29) /* not used */
> +#define EP93XX_SYSCON_DEVCFG_IONU2	BIT(28) /* not used */
> +#define EP93XX_SYSCON_DEVCFG_GONK	BIT(27) /* done */
> +#define EP93XX_SYSCON_DEVCFG_TONG	BIT(26) /* not used */
> +#define EP93XX_SYSCON_DEVCFG_MONG	BIT(25) /* not used */
> +#define EP93XX_SYSCON_DEVCFG_A2ONG	BIT(22) /* not used */
> +#define EP93XX_SYSCON_DEVCFG_A1ONG	BIT(21) /* not used */
> +#define EP93XX_SYSCON_DEVCFG_HONIDE	BIT(11) /* done */
> +#define EP93XX_SYSCON_DEVCFG_GONIDE	BIT(10) /* done */
> +#define EP93XX_SYSCON_DEVCFG_PONG	BIT(9) /* done */
> +#define EP93XX_SYSCON_DEVCFG_EONIDE	BIT(8) /* done */
> +#define EP93XX_SYSCON_DEVCFG_I2SONSSP	BIT(7) /* done */
> +#define EP93XX_SYSCON_DEVCFG_I2SONAC97	BIT(6) /* done */
> +#define EP93XX_SYSCON_DEVCFG_RASONP3	BIT(4) /* done */

What are these comments supposed to mean?

...

> +static const struct pinctrl_ops ep93xx_pctrl_ops = {
> +	.get_groups_count = ep93xx_get_groups_count,
> +	.get_group_name = ep93xx_get_group_name,
> +	.get_group_pins = ep93xx_get_group_pins,

> +	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
> +	.dt_free_map = pinconf_generic_dt_free_map,

Hmm... Don you need to ifdef these fields?

> +};

...

> +static const struct pinfunction ep93xx_pmx_functions[] = {
> +	PINCTRL_PINFUNCTION("spi", spigrps, ARRAY_SIZE(spigrps)),

Is array_size.h being included?

> +	PINCTRL_PINFUNCTION("ac97", ac97grps, ARRAY_SIZE(ac97grps)),
> +	PINCTRL_PINFUNCTION("i2s", i2sgrps, ARRAY_SIZE(i2sgrps)),
> +	PINCTRL_PINFUNCTION("pwm", pwm1grps, ARRAY_SIZE(pwm1grps)),
> +	PINCTRL_PINFUNCTION("keypad", keypadgrps, ARRAY_SIZE(keypadgrps)),
> +	PINCTRL_PINFUNCTION("pata", idegrps, ARRAY_SIZE(idegrps)),
> +	PINCTRL_PINFUNCTION("lcd", rastergrps, ARRAY_SIZE(rastergrps)),
> +	PINCTRL_PINFUNCTION("gpio", gpiogrps, ARRAY_SIZE(gpiogrps)),
> +};

...

> +	switch (pmx->model) {
> +	case EP93XX_9301_PINCTRL:
> +		grp = &ep9301_pin_groups[group];
> +		break;
> +	case EP93XX_9307_PINCTRL:
> +		grp = &ep9307_pin_groups[group];
> +		break;
> +	case EP93XX_9312_PINCTRL:
> +		grp = &ep9312_pin_groups[group];
> +		break;

default?

> +	}

...

> +	pmx->model = (int)(uintptr_t)id->driver_data;

Is the model defined as int (signed)?

Otherwise can we use proper type?

...

> +	/* using parent of_node to match in get_pinctrl_dev_from_of_node() */
> +	device_set_of_node_from_dev(dev, adev->dev.parent);

Hmm... This takes references in comparison to device_set_node(). Is it intended?

...

> +	pmx->pctl = devm_pinctrl_register(dev, &ep93xx_pmx_desc, pmx);
> +	if (IS_ERR(pmx->pctl))
> +		return dev_err_probe(dev, PTR_ERR(pmx->pctl), "could not register pinmux driver\n");

It can be written as

	pmx->pctl = devm_pinctrl_register(dev, &ep93xx_pmx_desc, pmx);
	ret = PTR_ERR_OR_ZERO(...);
	if (ret)
		return dev_err_probe(dev, ret, "could not register pinmux driver\n");

(makes line shorter). But it's up to you.

-- 
With Best Regards,
Andy Shevchenko


