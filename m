Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B027CB188
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjJPRr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjJPRrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:47:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AD2EB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697478443; x=1729014443;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ikln8lrPWrqT1K1fc5FFD3ejuJYCL5iINlPw05Y0fnM=;
  b=h1/OQul1FkJSBYTpFdo4zxMHZn7zya0wJtjqraog2q9CPOxJHGTdflrT
   JWYr/Ori9SJxfmrz4XDF7VR/alxWnFSGMh+jK4vfcpmKFhXa10P2ya2gb
   bh7c6cCS6VbxbHI+y220/OkB9tEJyVyeeyJSjcXiXPfj2yco2PX5aCCpH
   o29UdvaP2MkOGbIQywZg7j3BMywcViA8zS0GgHuXabXupzVjGPEhFa9A8
   J/+KAhrNgfy4ii4enTGyjBOD0/WXsRLQv256s9KFDzSSH8YpYDD3Unig3
   2eNlWNWUlbshocAEnzOQx59nz8InMQ+vDQIIoG7hRNoykz8NzAjldk0nA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="389468084"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="389468084"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="846483277"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="846483277"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:47:22 -0700
Received: from [10.212.72.131] (kliang2-mobl1.ccr.corp.intel.com [10.212.72.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6021F580C4A;
        Mon, 16 Oct 2023 10:47:21 -0700 (PDT)
Message-ID: <b0695675-a68a-400c-a043-2aa383ec4384@linux.intel.com>
Date:   Mon, 16 Oct 2023 13:47:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] perf/x86/intel/uncore: Generic uncore_get_uncores and
 MMIO format of SPR
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com
References: <20231002150325.2025749-1-kan.liang@linux.intel.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231002150325.2025749-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter & Ingo,

Could you please share your comments for this series?

The series is to support the uncore PMU on GNR, SRF, and GRR.

Thanks,
Kan

On 2023-10-02 11:03 a.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Factor out SPR_UNCORE_MMIO_COMMON_FORMAT which can be reused by
> Granite Rapids in the following patch.
> 
> Granite Rapids have more uncore units than Sapphire Rapids. Add new
> parameters to support adjustable uncore units.
> 
> No functional change.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 34 +++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index d49e90dc04a4..cef51b83410a 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6079,13 +6079,16 @@ static struct uncore_event_desc spr_uncore_imc_events[] = {
>  	{ /* end: all zeroes */ },
>  };
>  
> +#define SPR_UNCORE_MMIO_COMMON_FORMAT()				\
> +	SPR_UNCORE_COMMON_FORMAT(),				\
> +	.ops			= &spr_uncore_mmio_ops
> +
>  static struct intel_uncore_type spr_uncore_imc = {
> -	SPR_UNCORE_COMMON_FORMAT(),
> +	SPR_UNCORE_MMIO_COMMON_FORMAT(),
>  	.name			= "imc",
>  	.fixed_ctr_bits		= 48,
>  	.fixed_ctr		= SNR_IMC_MMIO_PMON_FIXED_CTR,
>  	.fixed_ctl		= SNR_IMC_MMIO_PMON_FIXED_CTL,
> -	.ops			= &spr_uncore_mmio_ops,
>  	.event_descs		= spr_uncore_imc_events,
>  };
>  
> @@ -6412,7 +6415,8 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
>  
>  static struct intel_uncore_type **
>  uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
> -		    struct intel_uncore_type **extra)
> +		   struct intel_uncore_type **extra, int max_num_types,
> +		   struct intel_uncore_type **uncores)
>  {
>  	struct intel_uncore_type **types, **start_types;
>  	int i;
> @@ -6421,9 +6425,9 @@ uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
>  
>  	/* Only copy the customized features */
>  	for (; *types; types++) {
> -		if ((*types)->type_id >= UNCORE_SPR_NUM_UNCORE_TYPES)
> +		if ((*types)->type_id >= max_num_types)
>  			continue;
> -		uncore_type_customized_copy(*types, spr_uncores[(*types)->type_id]);
> +		uncore_type_customized_copy(*types, uncores[(*types)->type_id]);
>  	}
>  
>  	for (i = 0; i < num_extra; i++, types++)
> @@ -6470,7 +6474,9 @@ void spr_uncore_cpu_init(void)
>  
>  	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
>  						UNCORE_SPR_MSR_EXTRA_UNCORES,
> -						spr_msr_uncores);
> +						spr_msr_uncores,
> +						UNCORE_SPR_NUM_UNCORE_TYPES,
> +						spr_uncores);
>  
>  	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
>  	if (type) {
> @@ -6542,7 +6548,9 @@ int spr_uncore_pci_init(void)
>  	spr_update_device_location(UNCORE_SPR_M3UPI);
>  	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI,
>  						UNCORE_SPR_PCI_EXTRA_UNCORES,
> -						spr_pci_uncores);
> +						spr_pci_uncores,
> +						UNCORE_SPR_NUM_UNCORE_TYPES,
> +						spr_uncores);
>  	return 0;
>  }
>  
> @@ -6550,12 +6558,16 @@ void spr_uncore_mmio_init(void)
>  {
>  	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
>  
> -	if (ret)
> -		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL);
> -	else {
> +	if (ret) {
> +		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
> +							 UNCORE_SPR_NUM_UNCORE_TYPES,
> +							 spr_uncores);
> +	} else {
>  		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
>  							 UNCORE_SPR_MMIO_EXTRA_UNCORES,
> -							 spr_mmio_uncores);
> +							 spr_mmio_uncores,
> +							 UNCORE_SPR_NUM_UNCORE_TYPES,
> +							 spr_uncores);
>  
>  		spr_uncore_imc_free_running.num_boxes = uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_SPR_IMC) / 2;
>  	}
