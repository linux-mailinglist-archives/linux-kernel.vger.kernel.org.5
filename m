Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6248766182
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjG1BzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjG1BzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:55:01 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EEB19A1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690509300; x=1722045300;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ea11Ood4xUvAJBfxUoQpzhxEVLD1nG0C2OXp3e2JHKY=;
  b=MtgBsh8hrGuT/beNVSPpEHp5JQHSXKe8TJfnWh6PZJcfmrU51IQLoy1F
   dkWZmbds+fosquRQj8PEnCND0fSiGoFAZpkZrv3fGdNUZnLvEZgmIulQD
   re2SgeOzvcwUL8dYovwnoy2hg5MxI+zJUTHYqEe0mIvKLuRwvqre7LlPU
   Z4bvteXjQ3rfSJybvIN1mPg0fxCz+iDlcK6VfMn74kn1DJWgbCvEeQwc4
   kubhVDPYaWkTxqlhOk13+RIelY3LW3jvCfvVFCDKmUF6hJQbF+t6ohKC2
   krjkIXYEjFbzPoVqHyaeJQiQICYDQKTLgesNmwyunsQTtQJ/crf7XrPGe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="434768442"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="434768442"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 18:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="756960085"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="756960085"
Received: from rfergus1-mobl1.amr.corp.intel.com (HELO [10.212.250.57]) ([10.212.250.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 18:54:59 -0700
Message-ID: <b9fbbbb7-f855-5744-d6ad-c650b10ce135@linux.intel.com>
Date:   Thu, 27 Jul 2023 18:54:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/12] x86/tdx: Make macros of TDCALLs consistent with
 the spec
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        n.borisov.lkml@gmail.com
References: <cover.1690369495.git.kai.huang@intel.com>
 <b3f5a25e72094a11add22e1a7c5dda3ea91d0e98.1690369495.git.kai.huang@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <b3f5a25e72094a11add22e1a7c5dda3ea91d0e98.1690369495.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/23 4:25 AM, Kai Huang wrote:
> The TDX spec names all TDCALLs with prefix "TDG".  Currently, the kernel
> doesn't follow such convention for the macros of those TDCALLs but uses
> prefix "TDX_" for all of them.  Although it's arguable whether the TDX
> spec names those TDCALLs properly, it's better for the kernel to follow
> the spec when naming those macros.
> 
> Change all macros of TDCALLs to make them consistent with the spec.  As
> a bonus, they get distinguished easily from the host-side SEAMCALLs,
> which all have prefix "TDH".
> 
> No functional change intended.
> 

When upstreaming the TDX guest patches, there was a discussion about using
TDG vs TDX. Final agreement is to use TDX_ prefix. I think it makes sense
to align with the spec, but it is up to the maintainer.

What about the function name prefix? Are you planning to change them to tdg_*?

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
> 
> v2 -> v3:
>  - No change.
> 
> v1 -> v2:
>  - Rebase to 6.5-rc2.
> 
> ---
>  arch/x86/coco/tdx/tdx-shared.c    |  4 ++--
>  arch/x86/coco/tdx/tdx.c           |  8 ++++----
>  arch/x86/include/asm/shared/tdx.h | 10 +++++-----
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
> index ef20ddc37b58..f10cd3e4a04e 100644
> --- a/arch/x86/coco/tdx/tdx-shared.c
> +++ b/arch/x86/coco/tdx/tdx-shared.c
> @@ -35,7 +35,7 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
>  	}
>  
>  	tdcall_rcx = start | page_size;
> -	if (__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL))
> +	if (__tdx_module_call(TDG_MEM_PAGE_ACCEPT, tdcall_rcx, 0, 0, 0, NULL))
>  		return 0;
>  
>  	return accept_size;
> @@ -45,7 +45,7 @@ bool tdx_accept_memory(phys_addr_t start, phys_addr_t end)
>  {
>  	/*
>  	 * For shared->private conversion, accept the page using
> -	 * TDX_ACCEPT_PAGE TDX module call.
> +	 * TDG_MEM_PAGE_ACCEPT TDX module call.
>  	 */
>  	while (start < end) {
>  		unsigned long len = end - start;
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 1d6b863c42b0..05785df66b1c 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -91,7 +91,7 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
>  {
>  	u64 ret;
>  
> -	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
> +	ret = __tdx_module_call(TDG_MR_REPORT, virt_to_phys(tdreport),
>  				virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
>  				0, NULL);
>  	if (ret) {
> @@ -152,7 +152,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
>  	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
>  	 * [TDG.VP.INFO].
>  	 */
> -	tdx_module_call(TDX_GET_INFO, 0, 0, 0, 0, &out);
> +	tdx_module_call(TDG_VP_INFO, 0, 0, 0, 0, &out);
>  
>  	/*
>  	 * The highest bit of a guest physical address is the "sharing" bit.
> @@ -594,7 +594,7 @@ void tdx_get_ve_info(struct ve_info *ve)
>  	 * Note, the TDX module treats virtual NMIs as inhibited if the #VE
>  	 * valid flag is set. It means that NMI=>#VE will not result in a #DF.
>  	 */
> -	tdx_module_call(TDX_GET_VEINFO, 0, 0, 0, 0, &out);
> +	tdx_module_call(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
>  
>  	/* Transfer the output parameters */
>  	ve->exit_reason = out.rcx;
> @@ -774,7 +774,7 @@ void __init tdx_early_init(void)
>  	cc_set_mask(cc_mask);
>  
>  	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
> -	tdx_module_call(TDX_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
> +	tdx_module_call(TDG_VM_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
>  
>  	/*
>  	 * All bits above GPA width are reserved and kernel treats shared bit
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index 7513b3bb69b7..78f109446da6 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -11,11 +11,11 @@
>  #define TDX_IDENT		"IntelTDX    "
>  
>  /* TDX module Call Leaf IDs */
> -#define TDX_GET_INFO			1
> -#define TDX_GET_VEINFO			3
> -#define TDX_GET_REPORT			4
> -#define TDX_ACCEPT_PAGE			6
> -#define TDX_WR				8
> +#define TDG_VP_INFO			1
> +#define TDG_VP_VEINFO_GET		3
> +#define TDG_MR_REPORT			4
> +#define TDG_MEM_PAGE_ACCEPT		6
> +#define TDG_VM_WR			8
>  
>  /* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
>  #define TDCS_NOTIFY_ENABLES		0x9100000000000010

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
