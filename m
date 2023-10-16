Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54997CA840
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjJPMml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjJPMmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:42:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CC8E8;
        Mon, 16 Oct 2023 05:42:37 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="7079914"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="7079914"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="929336265"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="929336265"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:42:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andy@kernel.org>)
        id 1qsMvU-00000005zXU-35Id;
        Mon, 16 Oct 2023 15:42:28 +0300
Date:   Mon, 16 Oct 2023 15:42:28 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Kartik <kkartik@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        keescook@chromium.org, akpm@linux-foundation.org, arnd@arndb.de,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        pshete@nvidia.com, petlozup@nvidia.com, frank.li@vivo.com,
        robh@kernel.org, stefank@nvidia.com, pdeschrijver@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 7/8] soc/tegra: fuse: Add ACPI support for Tegra194
 and Tegra234
Message-ID: <ZS0vtOwDVwSMErK4@smile.fi.intel.com>
References: <20231016101436.7146-1-kkartik@nvidia.com>
 <20231016101436.7146-8-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016101436.7146-8-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 03:44:35PM +0530, Kartik wrote:
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

> +static const struct acpi_device_id __maybe_unused tegra_fuse_acpi_match[] = {

Drop __maybe_unused along with ACPI_PTR(), they are more confusing than helpful.

> +	{ "NVDA200F" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(acpi, tegra_fuse_acpi_match);
> +
>  static struct platform_driver tegra_fuse_driver = {
>  	.driver = {
>  		.name = "tegra-fuse",
>  		.of_match_table = tegra_fuse_match,
> +		.acpi_match_table = ACPI_PTR(tegra_fuse_acpi_match),
>  		.pm = &tegra_fuse_pm,
>  		.suppress_bind_attrs = true,
>  	},

-- 
With Best Regards,
Andy Shevchenko


