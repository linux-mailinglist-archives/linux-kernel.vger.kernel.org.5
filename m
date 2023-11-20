Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9F27F11E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjKTLZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjKTLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:25:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA5A9C;
        Mon, 20 Nov 2023 03:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700479499; x=1732015499;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uTkB+Hje4wP8pbg2bIwSYaJnbqz6BREwOV4c29lulFg=;
  b=QbCgpi8FSHpVCXziDcRnAX7fDX5ugE5ZuVb1PkQMtZm0CnFRdpfA1jt+
   RTG67Jq63y//9uWV6kzrdCkpXNjdsrZNoyvZ9JQ5uZlVguOr/U0kNwUXI
   dqXQgzLAZUO8owRGlgJNfh9lDIO2clitF1bma769rosdYgmTXnY5ROTdp
   +n691hy/EYRmOoI1T6NksiVwaAmMfyIMECpM/ZGt4JqQ0rXnPfWPT5YTU
   L6wpyn88UPYn4WgPiGvvWdAtaiHnwNqMqei0evur1AoOibIVeLFX1MK/T
   Lx7F976kzkMKp+h9IoTAmE2qQICZgIWHOemwZyU+h5XgowlqbVrA3vZuU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="13153144"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="13153144"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:24:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="7524304"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.93.8.180]) ([10.93.8.180])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:24:54 -0800
Message-ID: <815d893b-63fc-4dec-8c04-6580344c7eef@linux.intel.com>
Date:   Mon, 20 Nov 2023 19:24:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/16] KVM: TDX: Pass desired page level in err code
 for page fault handler
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com,
        Xiaoyao Li <xiaoyao.li@intel.com>
References: <cover.1699368363.git.isaku.yamahata@intel.com>
 <71943490df987be8a3a3e131b12750e8c6d82afc.1699368363.git.isaku.yamahata@intel.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <71943490df987be8a3a3e131b12750e8c6d82afc.1699368363.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2023 11:00 PM, isaku.yamahata@intel.com wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
>
> For TDX, EPT violation can happen when TDG.MEM.PAGE.ACCEPT.
> And TDG.MEM.PAGE.ACCEPT contains the desired accept page level of TD guest.
>
> 1. KVM can map it with 4KB page while TD guest wants to accept 2MB page.
>
>    TD geust will get TDX_PAGE_SIZE_MISMATCH and it should try to accept
>    4KB size.
>
> 2. KVM can map it with 2MB page while TD guest wants to accept 4KB page.
>
>    KVM needs to honor it because
>    a) there is no way to tell guest KVM maps it as 2MB size. And
>    b) guest accepts it in 4KB size since guest knows some other 4KB page
>       in the same 2MB range will be used as shared page.
>
> For case 2, it need to pass desired page level to MMU's
> page_fault_handler. Use bit 29:31 of kvm PF error code for this purpose.
The shortlog is the same as patch 7/16..., I am a bit confused by the 
structure of this patch series...
Can this patch be squashed into 7/16?

>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   arch/x86/include/asm/kvm_host.h |  2 ++
>   arch/x86/kvm/vmx/common.h       |  2 +-
>   arch/x86/kvm/vmx/tdx.c          |  7 ++++++-
>   arch/x86/kvm/vmx/tdx.h          | 19 -------------------
>   arch/x86/kvm/vmx/tdx_arch.h     | 19 +++++++++++++++++++
>   arch/x86/kvm/vmx/vmx.c          |  2 +-
>   6 files changed, 29 insertions(+), 22 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index eed36c1eedb7..c16823f3326e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -285,6 +285,8 @@ enum x86_intercept_stage;
>   				 PFERR_WRITE_MASK |		\
>   				 PFERR_PRESENT_MASK)
>   
> +#define PFERR_LEVEL(err_code)	(((err_code) & PFERR_LEVEL_MASK) >> PFERR_LEVEL_START_BIT)
It's defined, but never used?


> +
>   /* apic attention bits */
>   #define KVM_APIC_CHECK_VAPIC	0
>   /*
> diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
> index bb00433932ee..787f59c44abc 100644
> --- a/arch/x86/kvm/vmx/common.h
> +++ b/arch/x86/kvm/vmx/common.h
> @@ -91,7 +91,7 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
>   	if (kvm_is_private_gpa(vcpu->kvm, gpa))
>   		error_code |= PFERR_GUEST_ENC_MASK;
>   
> -	if (err_page_level > 0)
> +	if (err_page_level > PG_LEVEL_NONE)
>   		error_code |= (err_page_level << PFERR_LEVEL_START_BIT) & PFERR_LEVEL_MASK;
>   
>   	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 7b81811eb404..c614ab20c191 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -2713,6 +2713,7 @@ static int tdx_init_mem_region(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>   	struct kvm_tdx_init_mem_region region;
>   	struct kvm_vcpu *vcpu;
>   	struct page *page;
> +	u64 error_code;
>   	int idx, ret = 0;
>   	bool added = false;
>   
> @@ -2770,7 +2771,11 @@ static int tdx_init_mem_region(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>   		kvm_tdx->source_pa = pfn_to_hpa(page_to_pfn(page)) |
>   				     (cmd->flags & KVM_TDX_MEASURE_MEMORY_REGION);
>   
> -		ret = kvm_mmu_map_tdp_page(vcpu, region.gpa, TDX_SEPT_PFERR,
> +		/* TODO: large page support. */
> +		error_code = TDX_SEPT_PFERR;
> +		error_code |= (PG_LEVEL_4K << PFERR_LEVEL_START_BIT) &
> +			PFERR_LEVEL_MASK;
> +		ret = kvm_mmu_map_tdp_page(vcpu, region.gpa, error_code,
>   					   PG_LEVEL_4K);
>   		put_page(page);
>   		if (ret)
> diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
> index 37ee944c36a1..54c3f6b83571 100644
> --- a/arch/x86/kvm/vmx/tdx.h
> +++ b/arch/x86/kvm/vmx/tdx.h
> @@ -72,25 +72,6 @@ union tdx_exit_reason {
>   	u64 full;
>   };
>   
> -union tdx_ext_exit_qualification {
> -	struct {
> -		u64 type		: 4;
> -		u64 reserved0		: 28;
> -		u64 req_sept_level	: 3;
> -		u64 err_sept_level	: 3;
> -		u64 err_sept_state	: 8;
> -		u64 err_sept_is_leaf	: 1;
> -		u64 reserved1		: 17;
> -	};
> -	u64 full;
> -};
> -
> -enum tdx_ext_exit_qualification_type {
> -	EXT_EXIT_QUAL_NONE,
> -	EXT_EXIT_QUAL_ACCEPT,
> -	NUM_EXT_EXIT_QUAL,
> -};
> -
>   struct vcpu_tdx {
>   	struct kvm_vcpu	vcpu;
>   
> diff --git a/arch/x86/kvm/vmx/tdx_arch.h b/arch/x86/kvm/vmx/tdx_arch.h
> index 9f93250d22b9..ba41fefa47ee 100644
> --- a/arch/x86/kvm/vmx/tdx_arch.h
> +++ b/arch/x86/kvm/vmx/tdx_arch.h
> @@ -218,4 +218,23 @@ union tdx_sept_level_state {
>   	u64 raw;
>   };
>   
> +union tdx_ext_exit_qualification {
> +	struct {
> +		u64 type		:  4;
> +		u64 reserved0		: 28;
> +		u64 req_sept_level	:  3;
> +		u64 err_sept_level	:  3;
> +		u64 err_sept_state	:  8;
> +		u64 err_sept_is_leaf	:  1;
> +		u64 reserved1		: 17;
> +	};
> +	u64 full;
> +};
> +
> +enum tdx_ext_exit_qualification_type {
> +	EXT_EXIT_QUAL_NONE = 0,
> +	EXT_EXIT_QUAL_ACCEPT,
Since this value should be fixed to 1, maybe better to initialize it to 
1 for future proof?

> +	NUM_EXT_EXIT_QUAL,
> +};
> +
>   #endif /* __KVM_X86_TDX_ARCH_H */
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ae9ba0731521..fb3913df6a5d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5753,7 +5753,7 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
>   	if (unlikely(allow_smaller_maxphyaddr && kvm_vcpu_is_illegal_gpa(vcpu, gpa)))
>   		return kvm_emulate_instruction(vcpu, 0);
>   
> -	return __vmx_handle_ept_violation(vcpu, gpa, exit_qualification, 0);
> +	return __vmx_handle_ept_violation(vcpu, gpa, exit_qualification, PG_LEVEL_NONE);
>   }
>   
>   static int handle_ept_misconfig(struct kvm_vcpu *vcpu)

