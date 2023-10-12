Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2347C70DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbjJLPCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjJLPCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:02:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52FB90;
        Thu, 12 Oct 2023 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697122919; x=1728658919;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dLXAThUg4mC4xwb/QLYtkIGsnVYBumf2JaYAcch2EPg=;
  b=gB4TKwezdaobVFOz5v64ZK6d+dlTx/BN04/jt+ArUzoOZodShpnsBPgK
   teZJra2kaA1Q+QkarwpA75BhluOtWoCfC6CHYSQzRmOEWMJrDZnyF+1hT
   y6u3/X6F+jK2VcEPAVvEFuU3oONQ6AC2osr1E36/zsQ5szDJifEgTLR5Y
   rGL+HwWP7uDOj70FGSVT3WD6eH23Q+smYpivyNgmH0gk+v9nizENAu+5E
   V2eMJajShNQMdvBkcaltOM7AVoa4OsNsn86IfRo/T9fL1D+EaHMAMhZG2
   OjnZAVagspZBofkGD5I0+0hQEcsgqWKOlmLfAk50+qSnkfuC6B1C2d5Tj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449131765"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="449131765"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 08:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="747908047"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="747908047"
Received: from asroczyn-mobl.ger.corp.intel.com ([10.249.36.107])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 08:01:26 -0700
Date:   Thu, 12 Oct 2023 18:01:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V3 09/16] platform/x86/intel/pmc: Allow pmc_core_ssram_init
 to fail
In-Reply-To: <20231012023840.3845703-10-david.e.box@linux.intel.com>
Message-ID: <ac7be397-bc9-a135-9498-72dfa1fe456d@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com> <20231012023840.3845703-10-david.e.box@linux.intel.com>
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

On Wed, 11 Oct 2023, David E. Box wrote:

> Currently, if the PMC SSRAM initialization fails, no error is returned and
> the only indication is that a PMC device has not been created.  Instead,
> allow an error to be returned and handled directly by the caller.

You might have a good reason for it but why isn't the call into 
pmc_core_pmc_add() changed in this patch to take the error value into 
account?

(I vaguely remember this was probably discussed in the context of some 
earlier patch touching this area that it was about the other code dealing 
with NULLs or something like that).

-- 
 i.

> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V3 - New patch split from V2 PATCH 9
>    - Add dev_warn on pmc_core_ssram_init fail
> 
>  drivers/platform/x86/intel/pmc/core.h       |  2 +-
>  drivers/platform/x86/intel/pmc/core.h       |  2 +-
>  drivers/platform/x86/intel/pmc/core_ssram.c | 21 +++++++++++++--------
>  drivers/platform/x86/intel/pmc/mtl.c        | 12 ++++++++----
>  3 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index ccf24e0f5e50..edaa70067e41 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -492,7 +492,7 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev);
>  int get_primary_reg_base(struct pmc *pmc);
>  extern void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev);
>  
> -extern void pmc_core_ssram_init(struct pmc_dev *pmcdev);
> +extern int pmc_core_ssram_init(struct pmc_dev *pmcdev);
>  
>  int spt_core_init(struct pmc_dev *pmcdev);
>  int cnp_core_init(struct pmc_dev *pmcdev);
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
> index 13fa16f0d52e..815950713e25 100644
> --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> @@ -35,20 +35,20 @@ static inline u64 get_base(void __iomem *addr, u32 offset)
>  	return lo_hi_readq(addr + offset) & GENMASK_ULL(63, 3);
>  }
>  
> -static void
> +static int
>  pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
>  		 const struct pmc_reg_map *reg_map, int pmc_index)
>  {
>  	struct pmc *pmc = pmcdev->pmcs[pmc_index];
>  
>  	if (!pwrm_base)
> -		return;
> +		return -ENODEV;
>  
>  	/* Memory for primary PMC has been allocated in core.c */
>  	if (!pmc) {
>  		pmc = devm_kzalloc(&pmcdev->pdev->dev, sizeof(*pmc), GFP_KERNEL);
>  		if (!pmc)
> -			return;
> +			return -ENOMEM;
>  	}
>  
>  	pmc->map = reg_map;
> @@ -57,10 +57,12 @@ pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
>  
>  	if (!pmc->regbase) {
>  		devm_kfree(&pmcdev->pdev->dev, pmc);
> -		return;
> +		return -ENOMEM;
>  	}
>  
>  	pmcdev->pmcs[pmc_index] = pmc;
> +
> +	return 0;
>  }
>  
>  static void
> @@ -96,7 +98,7 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, void __iomem *ssram, u32 offset,
>  		iounmap(ssram);
>  }
>  
> -void pmc_core_ssram_init(struct pmc_dev *pmcdev)
> +int pmc_core_ssram_init(struct pmc_dev *pmcdev)
>  {
>  	void __iomem *ssram;
>  	struct pci_dev *pcidev;
> @@ -105,7 +107,7 @@ void pmc_core_ssram_init(struct pmc_dev *pmcdev)
>  
>  	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, 2));
>  	if (!pcidev)
> -		goto out;
> +		return -ENODEV;
>  
>  	ret = pcim_enable_device(pcidev);
>  	if (ret)
> @@ -123,11 +125,14 @@ void pmc_core_ssram_init(struct pmc_dev *pmcdev)
>  	pmc_core_ssram_get_pmc(pmcdev, ssram, SSRAM_PCH_OFFSET, PMC_IDX_PCH);
>  
>  	iounmap(ssram);
> -out:
> -	return;
> +
> +	return 0;
>  
>  disable_dev:
> +	pmcdev->ssram_pcidev = NULL;
>  	pci_disable_device(pcidev);
>  release_dev:
>  	pci_dev_put(pcidev);
> +
> +	return ret;
>  }
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
