Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31426780C76
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377105AbjHRNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377091AbjHRNWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:22:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25122D50;
        Fri, 18 Aug 2023 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692364924; x=1723900924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vgxxsOfmDVAcjlOYZKLBE8eC4gwtXVJBmu+efUxvds0=;
  b=POM9KzhXjvxD8/vPPHUfsnUXEw7ofn/lEa1WafIo1MT8wou7EyCyo+u5
   4tjCxUosmWwH3V1mfCxFatnO24MK29YOQ/vkBU82Z7diqoIYESO7ZPZuA
   NLUK1DYH22jhvH/tvWaMglU8/YpUPvBfMkmQA2yBci3UqCslItGitwYk1
   w5LobOKrpf4b2HRfPwQwLnjHbekeiHCkijc24qk4OUzjPHL7ZMHT0OsWc
   LRxA06AIPfxarAWs0ugkCqzlFoTt8+QUk4+XjpKQVvf2QNjyvc3/79gYZ
   X+m+ZD3jVNuBxzYzRGI8HNrkBjXSHF4FujMZTI8MsXEoxT0Uluf5lvLrC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="376859494"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="376859494"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 06:22:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="805148491"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="805148491"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2023 06:21:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWzQL-009aaH-1X;
        Fri, 18 Aug 2023 16:21:57 +0300
Date:   Fri, 18 Aug 2023 16:21:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, sumitg@nvidia.com,
        arnd@arndb.de, pshete@nvidia.co, digetx@gmail.com,
        petlozup@nvidia.com, windhl@126.com, frank.li@vivo.com,
        robh@kernel.org, stefank@nvidia.com, pdeschrijver@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Message-ID: <ZN9wdTLK1rwnVK/e@smile.fi.intel.com>
References: <20230818093028.7807-1-kkartik@nvidia.com>
 <20230818093028.7807-2-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818093028.7807-2-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 03:00:23PM +0530, Kartik wrote:
> In preparation to ACPI support in Tegra fuse driver add function
> tegra_acpi_init_apbmisc() and move common code used for both ACPI and
> device-tree into a new helper function tegra_init_apbmisc_base().
> 
> Note that function tegra_acpi_init_apbmisc() is not placed in the __init
> section, because it will be called during probe.

...

>  void tegra_init_revision(void);
>  void tegra_init_apbmisc(void);
> +void tegra_acpi_init_apbmisc(void);

Why do you  need a separate function?

...

> +static const struct acpi_device_id apbmisc_acpi_match[] = {
> +	{ .id = "NVDA2010", 0 },

We rarely use C99 initializers for ACPI ID table.
Also 0 is not needed.

> +	{ /* sentinel */ }
> +};

...

> +	if (!apbmisc_base)
> +		pr_err("failed to map APBMISC registers\n");
> +	else
> +		chipid = readl_relaxed(apbmisc_base + 4);

Why not positive conditional as you have two branches anyway?

...

> +	if (!strapping_base) {
> +		pr_err("failed to map strapping options registers\n");
> +	} else {
> +		strapping = readl_relaxed(strapping_base);
> +		iounmap(strapping_base);
> +	}

Ditto.

...

> -	apbmisc_base = ioremap(apbmisc.start, resource_size(&apbmisc));
> -	if (!apbmisc_base) {
> -		pr_err("failed to map APBMISC registers\n");
> -	} else {
> -		chipid = readl_relaxed(apbmisc_base + 4);
> -	}
> -
> -	strapping_base = ioremap(straps.start, resource_size(&straps));
> -	if (!strapping_base) {
> -		pr_err("failed to map strapping options registers\n");
> -	} else {
> -		strapping = readl_relaxed(strapping_base);
> -		iounmap(strapping_base);
> -	}
> -
> +	tegra_init_apbmisc_base(&apbmisc, &straps);

This split can be done in a separate precursor patch.

...

> +void tegra_acpi_init_apbmisc(void)
> +{
> +	struct acpi_device *adev = NULL;
> +	struct resource *apbmisc, *straps;
> +	struct list_head resource_list;
> +	struct resource_entry *rentry;
> +	int rcount;
> +
> +	adev = acpi_dev_get_first_match_dev(apbmisc_acpi_match[0].id, NULL, -1);
> +	if (!adev)
> +		return;
> +
> +	INIT_LIST_HEAD(&resource_list);
> +
> +	rcount = acpi_dev_get_memory_resources(adev, &resource_list);
> +	if (rcount != 2) {
> +		pr_err("failed to get APBMISC memory resources");

(1)

> +		return;
> +	}

> +	rentry = list_first_entry(&resource_list, struct resource_entry, node);
> +	apbmisc = rentry->res;
> +	rentry = list_next_entry(rentry, node);
> +	straps = rentry->res;

We don't do like this, we walk through them and depending on the type and index
do something. The above if error prone and not scalable code.

> +	tegra_init_apbmisc_base(apbmisc, straps);

> +	acpi_dev_free_resource_list(&resource_list);

Not okay in (1).

> +	acpi_dev_put(adev);

Not okay in (1).

> +}

-- 
With Best Regards,
Andy Shevchenko


