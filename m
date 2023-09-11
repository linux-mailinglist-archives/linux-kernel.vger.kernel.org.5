Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8E279BF18
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349067AbjIKVcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbjIKKqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:46:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FE4EB;
        Mon, 11 Sep 2023 03:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694429206; x=1725965206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BcQ7+itQRZMJfkS1e/SgGehbRfqJ8zd0OXNPrAjfyYY=;
  b=gySb9ArUmv2KqyX0J3DKSp8Wf3bBddQOSbtXCUbWjkXTaDbXMMVUT9zk
   /GoTPelC8xHo0rJ6KT4Xu13IqR6jdUi15NTWxkPs7384m+B4JFQW5CgbS
   kVrcFBigm67TPeVZifd00pji3Ydk2tKCN+zX6mT3o7XVoFSBzAiGT8QkS
   JTjVovr0gmf7zkgIaL3vGifVYS4IRlLVJIy2nL2lSVacgQhoxmr4thCsq
   nIw2QvpVj6HX8arhWSW25cBr4DRpIqcbT72h0YbNevwva7tmmxJXNaIZj
   bTH/YF2iI1EwdnD32JuhJQkA5iSXdRXiF1uVuWeSWXV4xR8bFzfjcebsf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="381849633"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="381849633"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="778345396"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="778345396"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:46:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfeRD-008INp-1N;
        Mon, 11 Sep 2023 13:46:39 +0300
Date:   Mon, 11 Sep 2023 13:46:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, sumitg@nvidia.com,
        arnd@arndb.de, pshete@nvidia.com, digetx@gmail.com,
        petlozup@nvidia.com, windhl@126.com, frank.li@vivo.com,
        robh@kernel.org, stefank@nvidia.com, pdeschrijver@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] soc/tegra: fuse: Add ACPI support for Tegra194
 and Tegra234
Message-ID: <ZP7wDm5w/b5RIlIq@smile.fi.intel.com>
References: <20230907071052.3906-1-kkartik@nvidia.com>
 <20230907071052.3906-6-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907071052.3906-6-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 12:40:51PM +0530, Kartik wrote:
> Add ACPI support for Tegra194 & Tegra243 SoC's. This requires
> following modifications to the probe when ACPI boot is used:
>  - Initialize soc data.
>  - Add nvmem lookups.
>  - Register soc device.
>  - use devm_clk_get_optional() instead of devm_clk_get() to get
>    fuse->clk, as fuse clocks are not required when using ACPI boot.
> 
> Also, drop '__init' keyword for tegra_soc_device_register() as this is also
> used by tegra_fuse_probe() and use dev_err_probe() wherever applicable.

...

> +static const struct acpi_device_id tegra_fuse_acpi_match[] = {
> +	{ "NVDA200F" },
> +	{ /* sentinel */ }
> +};

Where is NODULE_DEVICE_TABLE() for it? And why it's located here and not
at the its first user's location?

...

> +	if (is_acpi_node(pdev->dev.fwnode) && !fuse->soc) {

We do not dereference fwnode in struct device, use dev_fwnode() for that.

...

> +		return dev_err_probe(&pdev->dev, PTR_ERR(fuse->clk), "failed to get FUSE clock\n");

> +		return dev_err_probe(&pdev->dev, PTR_ERR(fuse->rst), "failed to get FUSE reset");

This requires a separate patch.

...

> +	/*
> +	 * Wait for fuse->clk to be initialized if device-tree boot is used.
> +	 */

> +	if (is_of_node(fuse->dev->fwnode) && !fuse->clk)

dev_fwnode()

The second check is questionable. If you get it NULL, it won't ever appear.
Did I miss anything?

> +		return -EPROBE_DEFER;

-- 
With Best Regards,
Andy Shevchenko


