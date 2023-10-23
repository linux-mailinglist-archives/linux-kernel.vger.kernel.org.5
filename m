Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545497D3BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjJWQCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjJWQCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:02:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA9F103;
        Mon, 23 Oct 2023 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698076920; x=1729612920;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=47p2DnbFJFIB8YHmN6OgskgJHRU2KmZYmsl/hUCGtgc=;
  b=Br85S+xzH94amrHmW7CFo1Wa7OR/HOSPh6x2JXMFPuWb6bVJOJnfzI6Z
   p1krd//BavkEtIw4z5XGi5j2wMoLsGtPeaA8A6H1jGW0pT8r/WA7XoTO1
   7n6S4YUGxQ9f8K9l9jmRI454AC5p0pLC8HeAYO0iJNWsg9dDWK4AfZ/6c
   mG/kEegee49XpzA/fwyCDNCViwzazu2fi+T5zGec3UdIS/FKLMejXQOW9
   8APV1N9bfAfDVKZtHuhb1pjW8vdf0DBGUGzutkVtpuCpNOW0F+q7lg18P
   dnmOG/y59+vOpGJysrFKM7WEP0JZfhhie2PxzwWEM+Enebtt7qupwRlHg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="367100575"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="367100575"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 09:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="758177541"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="758177541"
Received: from foliveix-mobl5.amr.corp.intel.com ([10.251.211.194])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 09:01:35 -0700
Date:   Mon, 23 Oct 2023 19:01:32 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V4 11/17] platform/x86/intel/pmc: Split
 pmc_core_ssram_get_pmc()
In-Reply-To: <20231018231624.1044633-12-david.e.box@linux.intel.com>
Message-ID: <b788487-df7c-78ac-e82a-fb48d36bbd26@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com> <20231018231624.1044633-12-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023, David E. Box wrote:

> On supported hardware, each PMC may have an associated SSRAM device for
> accessing additional counters.  However, only the SSRAM of the first
> (primary) PMC is discoverable as a PCI device to the OS. The remaining
> (secondary) devices are hidden but their BARs are still accessible and
> their addresses are stored in the BAR of the exposed device. Clean up the
> code handling the SSRAM discovery. Create two separate functions for
> accessing the primary and secondary SSRAM devices.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V4 - Add checking the return value from pmc_core_sram_init() to mtl.c
>    - Use iounmap cleanup from io.h
> 
> V3 - New patch split from previous PATCH 2
>    - Update changelog
>    - Use cleanup.h to cleanup ioremap
> 
> V2 - no change
> 
>  drivers/platform/x86/intel/pmc/core_ssram.c | 91 +++++++++++++--------
>  drivers/platform/x86/intel/pmc/mtl.c        | 12 ++-
>  2 files changed, 67 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
> index 815950713e25..ccb3748dbed9 100644
> --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> @@ -8,6 +8,7 @@
>   *
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/pci.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  
> @@ -65,44 +66,74 @@ pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
>  	return 0;
>  }
>  
> -static void
> -pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, void __iomem *ssram, u32 offset,
> -		       int pmc_idx)
> +static int
> +pmc_core_get_secondary_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
>  {
> -	u64 pwrm_base;
> +	struct pci_dev *ssram_pcidev = pmcdev->ssram_pcidev;
> +	void __iomem __free(iounmap) *main_ssram = NULL;
> +	void __iomem __free(iounmap) *secondary_ssram = NULL;
> +	const struct pmc_reg_map *map;
> +	u64 ssram_base, pwrm_base;
>  	u16 devid;
>  
> -	if (pmc_idx != PMC_IDX_SOC) {
> -		u64 ssram_base = get_base(ssram, offset);
> +	if (!pmcdev->regmap_list)
> +		return -ENOENT;
>  
> -		if (!ssram_base)
> -			return;
> +	/*
> +	 * The secondary PMC BARS (which are behind hidden PCI devices) are read
> +	 * from fixed offsets in MMIO of the primary PMC BAR.
> +	 */
> +	ssram_base = ssram_pcidev->resource[0].start;
> +	main_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
> +	if (!main_ssram)
> +		return -ENOMEM;
>  
> -		ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
> -		if (!ssram)
> -			return;
> -	}
> +	ssram_base = get_base(main_ssram, offset);
> +	secondary_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
> +	if (!secondary_ssram)
> +		return -ENOMEM;
> +
> +	pwrm_base = get_base(secondary_ssram, SSRAM_PWRM_OFFSET);
> +	devid = readw(secondary_ssram + SSRAM_DEVID_OFFSET);
> +
> +	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
> +	if (!map)
> +		return -ENODEV;
> +
> +	return pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
> +}
> +
> +static int
> +pmc_core_get_primary_pmc(struct pmc_dev *pmcdev)
> +{
> +	struct pci_dev *ssram_pcidev = pmcdev->ssram_pcidev;
> +	void __iomem __free(iounmap) *ssram;
> +	const struct pmc_reg_map *map;
> +	u64 ssram_base, pwrm_base;
> +	u16 devid;
> +
> +	if (!pmcdev->regmap_list)
> +		return -ENOENT;
> +
> +	/* The primary PMC (SOC die) BAR is BAR 0 in config space. */
> +	ssram_base = ssram_pcidev->resource[0].start;
> +	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
> +	if (!ssram)
> +		return -ENOMEM;
>  
>  	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
>  	devid = readw(ssram + SSRAM_DEVID_OFFSET);
>  
> -	if (pmcdev->regmap_list) {
> -		const struct pmc_reg_map *map;
> +	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
> +	if (!map)
> +		return -ENODEV;
>  
> -		map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
> -		if (map)
> -			pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
> -	}
> -
> -	if (pmc_idx != PMC_IDX_SOC)
> -		iounmap(ssram);
> +	return pmc_core_pmc_add(pmcdev, pwrm_base, map, PMC_IDX_MAIN);

While I very much like the new way pmc_core_get_*_pmc() is structured with 
early returns and use of cleanup.h, it feels somethat unnecessary to split 
the main logic into two functions given how little there is different.
I'd just handle the differences with if (secondary) { ... } and create 
pmc_ssram local variable so as much as possible can be kept in common.

It probably makes still sense to preserve 
pmc_core_get_primary/secondary_pmc() functions from the caller point so 
those two functions just become wrappers passing correct parameters to 
pmc_core_get_pmc().

-- 
 i.


>  }
>  
>  int pmc_core_ssram_init(struct pmc_dev *pmcdev)
>  {
> -	void __iomem *ssram;
>  	struct pci_dev *pcidev;
> -	u64 ssram_base;
>  	int ret;
>  
>  	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, 2));
> @@ -113,18 +144,14 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev)
>  	if (ret)
>  		goto release_dev;
>  
> -	ssram_base = pcidev->resource[0].start;
> -	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
> -	if (!ssram)
> -		goto disable_dev;
> -
>  	pmcdev->ssram_pcidev = pcidev;
>  
> -	pmc_core_ssram_get_pmc(pmcdev, ssram, 0, PMC_IDX_SOC);
> -	pmc_core_ssram_get_pmc(pmcdev, ssram, SSRAM_IOE_OFFSET, PMC_IDX_IOE);
> -	pmc_core_ssram_get_pmc(pmcdev, ssram, SSRAM_PCH_OFFSET, PMC_IDX_PCH);
> +	ret = pmc_core_get_primary_pmc(pmcdev);
> +	if (ret)
> +		goto disable_dev;
>  
> -	iounmap(ssram);
> +	pmc_core_get_secondary_pmc(pmcdev, PMC_IDX_IOE, SSRAM_IOE_OFFSET);
> +	pmc_core_get_secondary_pmc(pmcdev, PMC_IDX_PCH, SSRAM_PCH_OFFSET);
>  
>  	return 0;
>  
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index c3b5f4fe01d1..d1d3d33fb4b8 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -990,12 +990,16 @@ int mtl_core_init(struct pmc_dev *pmcdev)
>  	mtl_d3_fixup();
>  
>  	pmcdev->resume = mtl_resume;
> -
>  	pmcdev->regmap_list = mtl_pmc_info_list;
> -	pmc_core_ssram_init(pmcdev);
>  
> -	/* If regbase not assigned, set map and discover using legacy method */
> -	if (!pmc->regbase) {
> +	/*
> +	 * If ssram init fails use legacy method to at least get the
> +	 * primary PMC
> +	 */
> +	ret = pmc_core_ssram_init(pmcdev);
> +	if (ret) {
> +		dev_warn(&pmcdev->pdev->dev,
> +			 "ssram init failed, %d, using legacy init\n", ret);
>  		pmc->map = &mtl_socm_reg_map;
>  		ret = get_primary_reg_base(pmc);
>  		if (ret)
> 
