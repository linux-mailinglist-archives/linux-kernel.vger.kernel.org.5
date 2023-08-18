Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA5E780E97
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377962AbjHRPIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377941AbjHRPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:08:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB82114;
        Fri, 18 Aug 2023 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692371294; x=1723907294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eCVHEnO3GvEJrJXUkXoZl1m2t3wixSi/HkUSKD/8fIY=;
  b=hVdAonv9m4Sv1o2C2+UsBhsor/XJDtnlU5z/jK82rEpaZGqWyUJabCDW
   QezlK9K5as8PN0q2e+49vwlvM6g5M2WM91knUST2OdDLRVeUzxeTBiAy7
   h8hFLrSDo4EQS5vHynda75IEA8brK5x/IMyaw6caehFbIAnTlrAnIXm/S
   LBNXavNde0MkQDeulB75T27e/NFIF07Y5dXIvjEQNpbY4AK2o4+IDCWo3
   QFdTQ0Tm1h2FoLoXO4+9Twk9Swb/UvpJNJSsTfgLh0UhAI6HAyXGpSJml
   RJ99AWQvzoSkBP4bQMrJJIIxmiUnaXkYwAVoxkXpzqujx9+/855CHyetF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="375898324"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="375898324"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="805187946"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="805187946"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2023 08:07:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qX14t-00DAwR-0F;
        Fri, 18 Aug 2023 18:07:55 +0300
Date:   Fri, 18 Aug 2023 18:07:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, sumitg@nvidia.com,
        arnd@arndb.de, pshete@nvidia.co, digetx@gmail.com,
        petlozup@nvidia.com, windhl@126.com, frank.li@vivo.com,
        robh@kernel.org, stefank@nvidia.com, pdeschrijver@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] soc/tegra: fuse: Add ACPI support for Tegra194 and
 Tegra234
Message-ID: <ZN+JSrT1nH/XMnGu@smile.fi.intel.com>
References: <20230818093028.7807-1-kkartik@nvidia.com>
 <20230818093028.7807-6-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818093028.7807-6-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 03:00:27PM +0530, Kartik wrote:
> Add tegra_fuse_acpi_probe() to initialize Tegra fuse while using ACPI.
> Also, drop '__init' keyword for tegra_soc_device_register() as this is also
> used by tegra_fuse_acpi_probe().
> 
> Note that as ACPI subsystem initialize at subsys init, function
> tegra_fuse_acpi_probe() also contains the necessary initialization
> that we are currently doing for device-tree boot as a part of
> early init.

...

> +#include <linux/acpi.h>

You meed mod_devicetable.h and possibly property.h, not this header
(see below).

...

> +static const struct acpi_device_id tegra_fuse_acpi_match[] = {
> +	{
> +		.id = "NVDA200F",
> +	},

Single line, no inner comma.

> +	{ /* sentinel */ },

The idea of sentinel is to guard, the trailing comma ruins this contract.

> +};

...

> +static int tegra_fuse_acpi_probe(struct platform_device *pdev)
> +{

Why you need a separate function?

> +	struct resource *res;
> +	u8 chip;
> +	int err;
> +
> +	tegra_acpi_init_apbmisc();
> +
> +	chip = tegra_get_chip_id();
> +	switch (chip) {
> +#if defined(CONFIG_ARCH_TEGRA_194_SOC)

Can we avoid ugly ifdeffery?

> +	case TEGRA194:
> +		fuse->soc = &tegra194_fuse_soc;
> +		break;
> +#endif
> +#if defined(CONFIG_ARCH_TEGRA_234_SOC)

Ditto.

> +	case TEGRA234:
> +		fuse->soc = &tegra234_fuse_soc;
> +		break;
> +#endif
> +	default:
> +		dev_err(&pdev->dev, "Unsupported SoC: %02x\n", chip);
> +		return -EINVAL;

		return dev_err_probe(...);

> +	}
> +
> +	fuse->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(fuse->base))
> +		return PTR_ERR(fuse->base);
> +	fuse->phys = res->start;

> +	platform_set_drvdata(pdev, fuse);

Is it being used?

> +	fuse->dev = &pdev->dev;
> +
> +	err = tegra_fuse_nvmem_register(fuse, &pdev->dev);
> +	if (err)
> +		return err;
> +
> +	fuse->soc->init(fuse);
> +	tegra_soc_device_register();
> +	tegra_fuse_pr_sku_info(&tegra_sku_info);
> +
> +	err = tegra_fuse_add_lookups(fuse);
> +	if (err) {

> +		dev_err(&pdev->dev, "failed to add FUSE lookups\n");
> +		return err;

		return dev_err_probe(...);

> +	}
> +
> +	return 0;
> +}

...

> +	if (has_acpi_companion(&pdev->dev))
> +		return tegra_fuse_acpi_probe(pdev);

Why is the ACPI so special here? Why you can't go same flow?

...

> +	/* fuse->clk is not required when ACPI is used. */
> +	if (!fuse->read || (!fuse->clk && !has_acpi_companion(fuse->dev)))

No, just make CLK optional and that's it.

>  		return -EPROBE_DEFER;

-- 
With Best Regards,
Andy Shevchenko


