Return-Path: <linux-kernel+bounces-77698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AA5860929
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650191F24DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B12C2C6;
	Fri, 23 Feb 2024 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfdyFT9H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E348BA5F;
	Fri, 23 Feb 2024 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657564; cv=none; b=EbocOiQsN869SooPLiKdu9tHE1z9fvAS1hXgw4jJYtQ40+eI1qknUi2jwDpZ0yHOjJqudMKBSraH3222eIHz2DMT2B82+jje1h+mlM/XIqmHAU1QdiysGS3/KlcaXgFTfh1h/8/SrK6hmrFRoGzOFZz/Xv6M+2o8lRaTCvmFJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657564; c=relaxed/simple;
	bh=OgyyQNj1iIb8cFeci7AJOlWCj1b6bU2md/JnIYp+HTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PunyCSbgeVNEpTgaIJUa7OYVZTezqDvAvnbTJFXerZaGjZtAf6qtKUwVRCbk1fMQjnjO+gXmoItNMkgEZS7P40WOFV/SE4cvW4g7msEvPG7C17PtXYYsNLvNJToCLVGqk2HXH2aEJaHWNnSeB9N6RvJIp4pMhrM28ird8A36H5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfdyFT9H; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708657563; x=1740193563;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=OgyyQNj1iIb8cFeci7AJOlWCj1b6bU2md/JnIYp+HTM=;
  b=dfdyFT9Hzoa+QMuyP99CwPt85vNdkV/CoVS46vf2Pw8E4ZASOmBYQm9B
   Lt8aia9qKP00yovGzb/sbgsobDuDPRzAejE1vuS+EhvfImR3aWlLadyFL
   kBNeUfbp1URCFkmMLD1hoedsK9IN7UL277EXyMElEaD7Qyr66HoXrwTN3
   rdXcj/lQMM+c8uD2HKQO0juEtbB/McluEFVnII8QgV1DT7ukKJkKj0VON
   gPeEUq0+KYTSoY7ssYs14ljUDoKQTL9dRCHGm13zq0eoU8W7QZLRYYbBD
   QEM/70kUwGmn+o/4mwAp8Q60cgShkaO/KzM+eCa5kEMYMrCMa29MllGyQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2839968"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2839968"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 19:06:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10426688"
Received: from rdegger-desk1.amr.corp.intel.com (HELO [10.209.74.18]) ([10.209.74.18])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 19:06:02 -0800
Message-ID: <98369369-9569-4c7a-8827-269fcc71a3de@linux.intel.com>
Date: Thu, 22 Feb 2024 19:06:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] platform/x86/intel/pmc/lnl: Remove SSRAM support
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>,
 rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
References: <20240221211204.515159-1-david.e.box@linux.intel.com>
 <20240221211204.515159-2-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240221211204.515159-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/21/24 1:12 PM, David E. Box wrote:
> A recent PMC firmware change in Lunar Lake caused the pmc_core driver to
> fail to probe. This is due to a change in the GUID for PMC telemetry
> coming from the SSRAM device. We are told the current update may change
> again before a final release so we can't upstream a fix just yet. In the
> meantime, remove SSRAM support for Lunar Lake so the driver can load and
> provide some basic functionality.

I would remove usage of "We" and just comment that that the value
is expected to change again. So disable the support till it is finalized.

>
> Fixes: 3748dfdae2a6 ("platform/x86/intel/pmc: Add Lunar Lake M support to intel_pmc_core driver")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---

Change looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>  drivers/platform/x86/intel/pmc/lnl.c | 38 +++-------------------------
>  1 file changed, 4 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
> index abad17cdd3d7..068d72504683 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -13,21 +13,6 @@
>  
>  #include "core.h"
>  
> -#define SOCM_LPM_REQ_GUID	0x11594920
> -
> -#define PMC_DEVID_SOCM	0xa87f
> -
> -static const u8 LNL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
> -
> -static struct pmc_info lnl_pmc_info_list[] = {
> -	{
> -		.guid	= SOCM_LPM_REQ_GUID,
> -		.devid	= PMC_DEVID_SOCM,
> -		.map	= &lnl_socm_reg_map,
> -	},
> -	{}
> -};
> -
>  const struct pmc_bit_map lnl_ltr_show_map[] = {
>  	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
>  	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
> @@ -490,7 +475,6 @@ const struct pmc_reg_map lnl_socm_reg_map = {
>  	.lpm_sts = lnl_lpm_maps,
>  	.lpm_status_offset = MTL_LPM_STATUS_OFFSET,
>  	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
> -	.lpm_reg_index = LNL_LPM_REG_INDEX,
>  };
>  
>  #define LNL_NPU_PCI_DEV		0x643e
> @@ -517,33 +501,19 @@ static int lnl_resume(struct pmc_dev *pmcdev)
>  int lnl_core_init(struct pmc_dev *pmcdev)
>  {
>  	int ret;
> -	int func = 2;
> -	bool ssram_init = true;
>  	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
>  
>  	lnl_d3_fixup();
>  
>  	pmcdev->suspend = cnl_suspend;
>  	pmcdev->resume = lnl_resume;
> -	pmcdev->regmap_list = lnl_pmc_info_list;
> -	ret = pmc_core_ssram_init(pmcdev, func);
>  
> -	/* If regbase not assigned, set map and discover using legacy method */
> -	if (ret) {
> -		ssram_init = false;
> -		pmc->map = &lnl_socm_reg_map;
> -		ret = get_primary_reg_base(pmc);
> -		if (ret)
> -			return ret;
> -	}
> +	pmc->map = &lnl_socm_reg_map;
> +	ret = get_primary_reg_base(pmc);
> +	if (ret)
> +		return ret;
>  
>  	pmc_core_get_low_power_modes(pmcdev);
>  
> -	if (ssram_init) {
> -		ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	return 0;
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


