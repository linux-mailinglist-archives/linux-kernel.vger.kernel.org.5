Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40627D3A88
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjJWPRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJWPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:17:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7FFDD;
        Mon, 23 Oct 2023 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698074260; x=1729610260;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pphEJiS3nqmtlobnO12yCKXXZ3R+xIadP5ryMjqKN94=;
  b=njrTo0wybrw0Ipm/5mneo7+a5vxyfEGSNnvAhcb0USd/Np4p0id8LHtL
   p1A/5afDgim2Ymn/fVZwXkmCFrtNmRqva4wSe/bhJwrE3e47QT0BvM+1t
   cRFrzV4LX8aYAjfnrnYnUcZoo/DdNsZN/EdRAOW60olqvtHo7D8AxZ9Ew
   8lcPemMkNQPuAYsI5vAGOqPBtki4TE+FUNbRm0TKuW/UZlDzHEhnlZgwO
   Qw7MxT2yEU2vgztMjbN4AIA5e6aUtkdATmdQUQK6aHiPB0hmP2l2auO18
   lgksLiC2gkaYLpAAxGixL6rNVPJVmla5Hi/sj8ymXCnTFgwDiHRRoG0f6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="377240399"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="377240399"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 08:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="881802367"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="881802367"
Received: from foliveix-mobl5.amr.corp.intel.com ([10.251.211.194])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 08:17:38 -0700
Date:   Mon, 23 Oct 2023 18:17:36 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V4 09/17] platform/x86/intel/pmc: Allow pmc_core_ssram_init
 to fail
In-Reply-To: <20231018231624.1044633-10-david.e.box@linux.intel.com>
Message-ID: <86b2f0a2-535a-5c5e-9f8c-8036a022b3a7@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com> <20231018231624.1044633-10-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1039076446-1698074259=:1721"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1039076446-1698074259=:1721
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 18 Oct 2023, David E. Box wrote:

> Currently, if the PMC SSRAM initialization fails, no error is returned and
> the only indication is that a PMC device has not been created.  Instead,
> allow an error to be returned and handled directly by the caller. Don't use
> the return value yet. This is in preparation for a future rework of
> pmc_core_sram_init().
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.


> ---
> V4 - Remove return value check in mtl.c. Proper use of the value would
>      require returning an error status from pmc_core_add_pmc(). But
>      the function that calls it will be removed in the next patch so wait
>      to use it then.
> 
> V3 - New patch split from V2 PATCH 9
>    - Add dev_warn on pmc_core_ssram_init fail
> 
>  drivers/platform/x86/intel/pmc/core.h       |  2 +-
>  drivers/platform/x86/intel/pmc/core_ssram.c | 21 +++++++++++++--------
>  2 files changed, 14 insertions(+), 9 deletions(-)
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
> 
--8323329-1039076446-1698074259=:1721--
