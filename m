Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0436784D75
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjHVXq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjHVXq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:46:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645E9CFE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692748016; x=1724284016;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LuupoI8LgWADL54KhU16HNxSRfRpUNzvuMRfQ6WO8xc=;
  b=K/dym4BuZdEsQcQ4o45MQl1yAWwe49UNDHL02QsnUVenWxhtar6wGb4+
   JmDwtMuPLR0qdvo4mGVbHw8xN1AItNIbOS/5jqyxzM/fSptErNMoGEwff
   CRIkPpG5p7kU2aUcCOF9i0FfyNlnlWW6DWZotSf5x3qINw6292HJEBZb5
   8mMmolT+AWkp4qkaKoX2BubM3UY46eQeZl8DQZMwyX0S20VSilw2ptbEk
   IrpsP4WU0nbY84uC6FeJoqejGBRLMGjM2GpUWSyu8U3n5O1EfnNGZ2/kn
   pPBVPjQu2dYkmsa1UVBq0yLbczWKqw5sEFxOgUmvjP1KOgD0I121DFYdm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="405021817"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="405021817"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 16:46:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="686225721"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="686225721"
Received: from tdairo-mobl.amr.corp.intel.com (HELO [10.212.178.80]) ([10.212.178.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 16:46:55 -0700
Message-ID: <e4b8bfa6-3029-4b47-968c-c148622c78c7@linux.intel.com>
Date:   Tue, 22 Aug 2023 16:46:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] x86/tdx: Mark TSC reliable
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230822231823.3205-1-kirill.shutemov@linux.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230822231823.3205-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2023 4:18 PM, Kirill A. Shutemov wrote:
> In x86 virtualization environments, including TDX, RDTSC instruction is
> handled without causing a VM exit, resulting in minimal overhead and
> jitters. On the other hand, other clock sources (such as HPET, ACPI
> timer, APIC, etc.) necessitate VM exits to implement, resulting in more
> fluctuating measurements compared to TSC. Thus, those clock sources are
> not effective for calibrating TSC.
> 
> In TD guests, TSC is virtualized by the TDX module, which ensures:
> 
>   - Virtual TSC values are consistent among all the TD’s VCPUs;
>   - Monotonously incrementing for any single VCPU;
>   - The frequency is determined by TD configuration. The host TSC is
>     invariant on platforms where TDX is available.
> 
> Reliable TSC is architectural guarantee for the TDX platform and it must
> work for any sane TDX implementation.
> 
> Use TSC as the only reliable clock source in TD guests, bypassing
> unstable calibration.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  v2:
>   - Slightly updated commit message;
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/coco/tdx/tdx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 1d6b863c42b0..1583ec64d92e 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -769,6 +769,9 @@ void __init tdx_early_init(void)
>  
>  	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>  
> +	/* TSC is the only reliable clock in TDX guest */
> +	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> +
>  	cc_vendor = CC_VENDOR_INTEL;
>  	tdx_parse_tdinfo(&cc_mask);
>  	cc_set_mask(cc_mask);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
