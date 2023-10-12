Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A567C711F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379164AbjJLPOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjJLPOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:14:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D8790;
        Thu, 12 Oct 2023 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697123646; x=1728659646;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YReKpfu8ZNxjCE3lHtGTJfMoUU6dmckeRaTCIcCJrHc=;
  b=fwIwaI+5jWHUNyKhHRMH28iH03gDZgaNIkk3bEGU6RlGZap5LMXyCXWN
   uSbs2NehwVoTlJSseSdZLpPopO9IONkmYh6GawvHDEZupGD3Xd1XsCQRc
   /wTFjvDMPsg4tzGqokmiTjWZjmKJ+h+moqiizxUypka5IEpz717I5tZcl
   x6a6l3xsFazAhoZ2ASXBSdkv5/kn0Nf0eXuIukaMMcxYVY9PqA08G6FKw
   aHNw3a8Qz0fs/GQ9aAsekkwbJ7hAHMoeJJ8L5m3kUnce276cNUouLPETm
   Ns020rvfAtvE0eaShTcYO7xlYtl6JQys0DUozfS1MBxCfhDEdVQDCTXRZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388815698"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="388815698"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 08:14:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="1001567495"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="1001567495"
Received: from asroczyn-mobl.ger.corp.intel.com ([10.249.36.107])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 08:14:05 -0700
Date:   Thu, 12 Oct 2023 18:14:02 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V3 10/16] platform/x86/intel/pmc: Split
 pmc_core_ssram_get_pmc()
In-Reply-To: <20231012023840.3845703-11-david.e.box@linux.intel.com>
Message-ID: <c66f2061-a7e6-8df7-928-da2a14a3cb49@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com> <20231012023840.3845703-11-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023, David E. Box wrote:

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
> V3 - New patch split from previous PATCH 2
>    - Update changelog
>    - Use cleanup.h to cleanup ioremap
> 
> V2 - no change
> 
>  drivers/platform/x86/intel/pmc/core_ssram.c | 93 ++++++++++++++-------
>  1 file changed, 61 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
> index 815950713e25..af405d11919f 100644
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
> @@ -21,6 +22,8 @@
>  #define SSRAM_IOE_OFFSET	0x68
>  #define SSRAM_DEVID_OFFSET	0x70
>  
> +DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
> +

Was it that adding

DEFINE_FREE(iounmap, void __iomem *, iounmap(_T));

into some header did not work for some reason or why this? (Perhaps 
because iounmap is also defined?)

-- 
 i.

>  static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
>  {
>  	for (; list->map; ++list)
> @@ -65,44 +68,74 @@ pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
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
> +	void __iomem __free(pmc_core_iounmap) *main_ssram = NULL;
> +	void __iomem __free(pmc_core_iounmap) *secondary_ssram = NULL;
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
> +	void __iomem __free(pmc_core_iounmap) *ssram;
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
> @@ -113,18 +146,14 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev)
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
> 
