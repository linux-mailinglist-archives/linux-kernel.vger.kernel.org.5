Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864AC7F4E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbjKVRTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjKVRTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:19:30 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EA9C83;
        Wed, 22 Nov 2023 09:19:26 -0800 (PST)
Received: from [192.168.2.39] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id BF0E720B74C0;
        Wed, 22 Nov 2023 09:19:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF0E720B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1700673565;
        bh=3LZ9zzeuLYlI71EPLuHTSgdCNU++nYBhxEZHJbsDSlY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FNbbciuyWCaA9TZyyEjX7d7DkZgEQKBFsmxLo1LiA3Jvi+6vHmrWZOH1gV+NeKDDb
         awySjemfomgKj1xLIpgE4rr02YE7Le1qQnjEgZqb1n9SSbtUzvywHYQp/Eh9EIIvna
         vUDSo7AuFhfJhv42JxDDyPmWaLsJVvg8qBnw4i+E=
Message-ID: <0799b692-4b26-4e00-9cec-fdc4c929ea58@linux.microsoft.com>
Date:   Wed, 22 Nov 2023 18:19:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-hyperv@vger.kernel.org, stefan.bader@canonical.com,
        tim.gardner@canonical.com, roxana.nicolescu@canonical.com,
        cascardo@canonical.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, sashal@kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Kelley <mhkelley58@gmail.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Dexuan Cui <decui@microsoft.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2023 18:01, Jeremi Piotrowski wrote:
> Check for additional CPUID bits to identify TDX guests running with Trust
> Domain (TD) partitioning enabled. TD partitioning is like nested virtualization
> inside the Trust Domain so there is a L1 TD VM(M) and there can be L2 TD VM(s).
> 
> In this arrangement we are not guaranteed that the TDX_CPUID_LEAF_ID is visible
> to Linux running as an L2 TD VM. This is because a majority of TDX facilities
> are controlled by the L1 VMM and the L2 TDX guest needs to use TD partitioning
> aware mechanisms for what's left. So currently such guests do not have
> X86_FEATURE_TDX_GUEST set.
> 
> We want the kernel to have X86_FEATURE_TDX_GUEST set for all TDX guests so we
> need to check these additional CPUID bits, but we skip further initialization
> in the function as we aren't guaranteed access to TDX module calls.
> 
> Cc: <stable@vger.kernel.org> # v6.5+
> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> ---
>  arch/x86/coco/tdx/tdx.c    | 29 ++++++++++++++++++++++++++---
>  arch/x86/include/asm/tdx.h |  3 +++
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 1d6b863c42b0..c7bbbaaf654d 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -8,6 +8,7 @@
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <asm/coco.h>
> +#include <asm/hyperv-tlfs.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
>  #include <asm/insn.h>
> @@ -37,6 +38,8 @@
>  
>  #define TDREPORT_SUBTYPE_0	0
>  
> +bool tdx_partitioning_active;
> +
>  /* Called from __tdx_hypercall() for unrecoverable failure */
>  noinstr void __tdx_hypercall_failed(void)
>  {
> @@ -757,19 +760,38 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>  	return true;
>  }
>  
> +
> +static bool early_is_hv_tdx_partitioning(void)
> +{
> +	u32 eax, ebx, ecx, edx;
> +	cpuid(HYPERV_CPUID_ISOLATION_CONFIG, &eax, &ebx, &ecx, &edx);
> +	return eax & HV_PARAVISOR_PRESENT &&
> +	       (ebx & HV_ISOLATION_TYPE) == HV_ISOLATION_TYPE_TDX;
> +}
> +
>  void __init tdx_early_init(void)
>  {
>  	u64 cc_mask;
>  	u32 eax, sig[3];
>  
>  	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
> -
> -	if (memcmp(TDX_IDENT, sig, sizeof(sig)))
> -		return;
> +	if (memcmp(TDX_IDENT, sig, sizeof(sig))) {
> +		tdx_partitioning_active = early_is_hv_tdx_partitioning();
> +		if (!tdx_partitioning_active)
> +			return;
> +	}

Hi Borislav,

Just wanted to run another option by you. Instead of checking the CPUID here we
could accomplish the same result by doing _this_ in the hyperv cc init:

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 8c6bf07f7d2b..705794642d34 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -595,6 +595,8 @@ void __init hv_vtom_init(void)
 #endif
 
 	case HV_ISOLATION_TYPE_TDX:
+		setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
+		tdx_partitioning_active = true;
 		cc_vendor = CC_VENDOR_INTEL;
 		break;
 

Which approach do you prefer?

Thanks,
Jeremi

>  
>  	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>  
>  	cc_vendor = CC_VENDOR_INTEL;
> +
> +	/*
> +	 * Need to defer cc_mask and page visibility callback initializations
> +	 * to a TD-partitioning aware implementation.
> +	 */
> +	if (tdx_partitioning_active)
> +		goto exit;
> +
>  	tdx_parse_tdinfo(&cc_mask);
>  	cc_set_mask(cc_mask);
>  
> @@ -820,5 +842,6 @@ void __init tdx_early_init(void)
>  	 */
>  	x86_cpuinit.parallel_bringup = false;
>  
> +exit:
>  	pr_info("Guest detected\n");
>  }
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 603e6d1e9d4a..fe22f8675859 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -52,6 +52,7 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
>  
>  int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
>  
> +extern bool tdx_partitioning_active;
>  #else
>  
>  static inline void tdx_early_init(void) { };
> @@ -71,6 +72,8 @@ static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
>  {
>  	return -ENODEV;
>  }
> +
> +#define tdx_partitioning_active false
>  #endif /* CONFIG_INTEL_TDX_GUEST && CONFIG_KVM_GUEST */
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _ASM_X86_TDX_H */

