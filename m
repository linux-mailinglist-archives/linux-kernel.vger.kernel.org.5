Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9060E7AF036
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjIZQFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIZQFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:05:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CFFFB;
        Tue, 26 Sep 2023 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695744328; x=1727280328;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3XLZRLic49mM1/96yZCR+aYRctRL43Q3/WxuTRHYK+M=;
  b=WnZbaAM9URGqQPL7cTCC+b4NN0N44eDl0WfdfVOCdeOuZIePtxBwpQC4
   wnig4Rj+Y3hMlsppN1UlzuVHKRshi0YBJ5rqxxUTWwyyxDmJ1i8CaLjep
   8vhU7MK+KFG0iHNvHIlcpDjkRLQ3Piiz7iPJ1bzc//jHV42j21ubJ2sA3
   SWTPfYfbfRe1s/HRMtj8xjqMMS+kALlO8S6RnSEJQ1WV3ide4LKUk1Tte
   pWklDWK5rPm4kJQNB2SWp1rON+BIm3FodD2NhcwGggTupuM8RdfHNUrKX
   Jaar5zz+GMXlszbIv0RvDDRuPh+PZDZiD3VZ69w3xYw48xVmEo8N2mye5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445732787"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="445732787"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752230168"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="752230168"
Received: from hhalmen-mobl.ger.corp.intel.com ([10.251.219.207])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:03:51 -0700
Date:   Tue, 26 Sep 2023 19:03:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH 10/11] platform/x86/intel/pmc: Read low power mode
 requirements for MTL-M and MTL-P
In-Reply-To: <20230922213032.1770590-11-david.e.box@linux.intel.com>
Message-ID: <a2f52dca-ffaf-31b0-c281-48fc193e6552@linux.intel.com>
References: <20230922213032.1770590-1-david.e.box@linux.intel.com> <20230922213032.1770590-11-david.e.box@linux.intel.com>
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

On Fri, 22 Sep 2023, David E. Box wrote:

> From: Xi Pardee <xi.pardee@intel.com>
> 
> Add support to read the low power mode requirements for Meteor Lake M and
> Meteor Lake P.
> 
> Signed-off-by: Xi Pardee <xi.pardee@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/mtl.c | 39 +++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index 780874142a90..c2ac50cfdd51 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -11,6 +11,13 @@
>  #include <linux/pci.h>
>  #include "core.h"
>  
> +/* PMC SSRAM PMT Telemetry GUIDS */
> +#define SOCP_LPM_REQ_GUID	0x2625030
> +#define IOEM_LPM_REQ_GUID	0x4357464
> +#define IOEP_LPM_REQ_GUID	0x5077612
> +
> +static const u8 MTL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
> +
>  /*
>   * Die Mapping to Product.
>   * Product SOCDie IOEDie PCHDie
> @@ -465,6 +472,7 @@ const struct pmc_reg_map mtl_socm_reg_map = {
>  	.lpm_sts = mtl_socm_lpm_maps,
>  	.lpm_status_offset = MTL_LPM_STATUS_OFFSET,
>  	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
> +	.lpm_reg_index = MTL_LPM_REG_INDEX,
>  };
>  
>  const struct pmc_bit_map mtl_ioep_pfear_map[] = {
> @@ -782,6 +790,13 @@ const struct pmc_reg_map mtl_ioep_reg_map = {
>  	.ltr_show_sts = mtl_ioep_ltr_show_map,
>  	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
>  	.ltr_ignore_max = ADL_NUM_IP_IGN_ALLOWED,
> +	.lpm_num_maps = ADL_LPM_NUM_MAPS,
> +	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
> +	.lpm_residency_offset = MTL_LPM_RESIDENCY_OFFSET,
> +	.lpm_priority_offset = MTL_LPM_PRI_OFFSET,
> +	.lpm_en_offset = MTL_LPM_EN_OFFSET,
> +	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
> +	.lpm_reg_index = MTL_LPM_REG_INDEX,
>  };
>  
>  const struct pmc_bit_map mtl_ioem_pfear_map[] = {
> @@ -922,6 +937,13 @@ const struct pmc_reg_map mtl_ioem_reg_map = {
>  	.ltr_show_sts = mtl_ioep_ltr_show_map,
>  	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
>  	.ltr_ignore_max = ADL_NUM_IP_IGN_ALLOWED,
> +	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
> +	.lpm_num_maps = ADL_LPM_NUM_MAPS,
> +	.lpm_priority_offset = MTL_LPM_PRI_OFFSET,
> +	.lpm_en_offset = MTL_LPM_EN_OFFSET,
> +	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
> +	.lpm_residency_offset = MTL_LPM_RESIDENCY_OFFSET,
> +	.lpm_reg_index = MTL_LPM_REG_INDEX,
>  };
>  
>  #define PMC_DEVID_SOCM	0x7e7f
> @@ -929,16 +951,19 @@ const struct pmc_reg_map mtl_ioem_reg_map = {
>  #define PMC_DEVID_IOEM	0x7ebf
>  static struct pmc_info mtl_pmc_info_list[] = {
>  	{
> -		.devid = PMC_DEVID_SOCM,
> -		.map = &mtl_socm_reg_map,
> +		.guid	= SOCP_LPM_REQ_GUID,
> +		.devid	= PMC_DEVID_SOCM,
> +		.map	= &mtl_socm_reg_map,
>  	},
>  	{
> -		.devid = PMC_DEVID_IOEP,
> -		.map = &mtl_ioep_reg_map,
> +		.guid	= IOEP_LPM_REQ_GUID,
> +		.devid	= PMC_DEVID_IOEP,
> +		.map	= &mtl_ioep_reg_map,
>  	},
>  	{
> -		.devid = PMC_DEVID_IOEM,
> -		.map = &mtl_ioem_reg_map
> +		.guid	= IOEM_LPM_REQ_GUID,
> +		.devid	= PMC_DEVID_IOEM,
> +		.map	= &mtl_ioem_reg_map
>  	},
>  	{}
>  };
> @@ -1012,5 +1037,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
>  	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
>  	pmc_core_send_ltr_ignore(pmcdev, 3);
>  
> +	ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
> +

Unused return value??

>  	return 0;
>  }
> 

-- 
 i.

