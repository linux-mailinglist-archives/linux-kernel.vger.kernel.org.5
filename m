Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E7797471
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbjIGPiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345245AbjIGPfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:35:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E0199A;
        Thu,  7 Sep 2023 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694100887; x=1725636887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MhqIK5YAKXJZsv4bnmMqXxfSdE2nyNKmOcmABMLBG2Q=;
  b=IVp+fRznrSWbWDH7ivavJpbUziLsaYNogw+JO1X+MNDyojC1RuYuF7CN
   UgmP5IdRxRKCqgB4OcsVqVQBVE/Ur7oJpHq8x/XJfpJixK/MGlOPli2jo
   N/anTQOfScifmu8ai1KPdbMhj2oL1HLN/EE2hUvmZlLk5F6kieaEnEbN6
   Dpcz9HW6sedvHDGhFENl3rae1kzkrNpxX0hXZWVAubVwoPlrRlGba+Eth
   rM0WJJGUjNhGd8VUIKp3ulO17jWTDSrReZMHdbGXJNLki9jZSYYDRQxFh
   WhGYrJIbcAXfPVpcEDIrIttA9X53y9rwjoIhQG+Q9Czi+JVVaEUakhn+3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="408366833"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="408366833"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="691804973"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="691804973"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 07:35:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qeG68-007Klz-0U;
        Thu, 07 Sep 2023 17:35:08 +0300
Date:   Thu, 7 Sep 2023 17:35:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, sumitg@nvidia.com,
        arnd@arndb.de, pshete@nvidia.com, digetx@gmail.com,
        petlozup@nvidia.com, windhl@126.com, frank.li@vivo.com,
        robh@kernel.org, stefank@nvidia.com, pdeschrijver@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] soc/tegra: fuse: Add function to add lookups
Message-ID: <ZPnfmxqI12OsQRPA@smile.fi.intel.com>
References: <20230907071052.3906-1-kkartik@nvidia.com>
 <20230907071052.3906-4-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907071052.3906-4-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 12:40:49PM +0530, Kartik wrote:
> Add helper function tegra_fuse_add_lookups() to register Tegra fuse
> nvmem lookups. So, this can be shared between tegra_fuse_init() and
> ACPI probe, which is to be introduced later.

...

> +static int tegra_fuse_add_lookups(struct tegra_fuse *fuse)
> +{
> +	size_t size;
> +
> +	if (!fuse->soc->lookups)
> +		return 0;

> +	size = size_mul(sizeof(*fuse->lookups), fuse->soc->num_lookups);
> +
> +	fuse->lookups = kmemdup(fuse->soc->lookups, size, GFP_KERNEL);
> +	if (!fuse->lookups)
> +		return -ENOMEM;

Why not introducing kmemdup_array()?

> +	nvmem_add_cell_lookups(fuse->lookups, fuse->soc->num_lookups);
> +
> +	return 0;
> +}

...

> +	err = tegra_fuse_add_lookups(fuse);
> +	if (err) {
> +		pr_err("failed to add FUSE lookups\n");

Why pr_err() and not dev_err()?

> +		return err;
>  	}
>  
>  	return 0;

These four lines can be just shortened to

	return err;

-- 
With Best Regards,
Andy Shevchenko


