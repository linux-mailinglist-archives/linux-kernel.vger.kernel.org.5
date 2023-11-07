Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC13E7E359E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjKGHQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjKGHP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:15:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4734711F;
        Mon,  6 Nov 2023 23:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699341354; x=1730877354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TyCAbVwX14pmdNrNARKvdC5oei0EiaO7XnUOLpcDubc=;
  b=H5terDM5HmCpnykOBUj/Nu6rtMKnRDrf0s8XC7c2yr+1oUSJAOGUsJZ2
   ps7iMLrxsbzj1j5RnQbQtgFhnot8nz/AgGKI6rACF+gIHEeXW2XBJoe30
   w9w0u49zrHUFFPn/E+ZXNo8O/G6bwtHyrIIL9AyIl6v0DhNMYNameKOP2
   ri00XbHG+719jMfmfpw0kE7Rid29Hq2ZS2IaavXE+FoGR26xTNjXYQDuG
   5q97ZF2kTOV4WfkNoN0xsZrmC+cLKD9VzPcSQsMlgGETRhqqjr7/kX6uM
   jODL5dNbb0+OHFy7ycYPR53cARKLzC+xOuMQtRrNGVXq1zLN0xGW6xSoB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="379839028"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="379839028"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 23:15:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="906327033"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="906327033"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.238.1.248]) ([10.238.1.248])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 23:15:49 -0800
Message-ID: <2537aa0b-8893-4df6-9cfc-c33bad9e7515@linux.intel.com>
Date:   Tue, 7 Nov 2023 15:15:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/20] KVM: x86/pmu: Allow programming events that
 match unsupported arch events
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>
References: <20231104000239.367005-1-seanjc@google.com>
 <20231104000239.367005-6-seanjc@google.com>
From:   "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20231104000239.367005-6-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/2023 8:02 AM, Sean Christopherson wrote:
> Remove KVM's bogus restriction that the guest can't program an event whose
> encoding matches an unsupported architectural event.  The enumeration of
> an architectural event only says that if a CPU supports an architectural
> event, then the event can be programmed using the architectural encoding.
> The enumeration does NOT say anything about the encoding when the CPU
> doesn't report support the architectural event.
>
> Preventing the guest from counting events whose encoding happens to match
> an architectural event breaks existing functionality whenever Intel adds
> an architectural encoding that was *ever* used for a CPU that doesn't
> enumerate support for the architectural event, even if the encoding is for
> the exact same event!
>
> E.g. the architectural encoding for Top-Down Slots is 0x01a4.  Broadwell
> CPUs, which do not support the Top-Down Slots architectural event, 0x10a4
> is a valid, model-specific event.  Denying guest usage of 0x01a4 if/when
> KVM adds support for Top-Down slots would break any Broadwell-based guest.
>
> Reported-by: Kan Liang <kan.liang@linux.intel.com>
> Closes: https://lore.kernel.org/all/2004baa6-b494-462c-a11f-8104ea152c6a@linux.intel.com
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Fixes: a21864486f7e ("KVM: x86/pmu: Fix available_event_types check for REF_CPU_CYCLES event")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/include/asm/kvm-x86-pmu-ops.h |  1 -
>   arch/x86/kvm/pmu.c                     |  1 -
>   arch/x86/kvm/pmu.h                     |  1 -
>   arch/x86/kvm/svm/pmu.c                 |  6 ----
>   arch/x86/kvm/vmx/pmu_intel.c           | 38 --------------------------
>   5 files changed, 47 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> index 6c98f4bb4228..884af8ef7657 100644
> --- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> @@ -12,7 +12,6 @@ BUILD_BUG_ON(1)
>    * a NULL definition, for example if "static_call_cond()" will be used
>    * at the call sites.
>    */
> -KVM_X86_PMU_OP(hw_event_available)
>   KVM_X86_PMU_OP(pmc_idx_to_pmc)
>   KVM_X86_PMU_OP(rdpmc_ecx_to_pmc)
>   KVM_X86_PMU_OP(msr_idx_to_pmc)
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 9ae07db6f0f6..99ed72966528 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -374,7 +374,6 @@ static bool check_pmu_event_filter(struct kvm_pmc *pmc)
>   static bool pmc_event_is_allowed(struct kvm_pmc *pmc)
>   {
>   	return pmc_is_globally_enabled(pmc) && pmc_speculative_in_use(pmc) &&
> -	       static_call(kvm_x86_pmu_hw_event_available)(pmc) &&
>   	       check_pmu_event_filter(pmc);
>   }
>   
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 5341e8f69a22..f3e7a356fd81 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -20,7 +20,6 @@
>   
>   struct kvm_pmu_ops {
>   	void (*init_pmu_capability)(void);
> -	bool (*hw_event_available)(struct kvm_pmc *pmc);
>   	struct kvm_pmc *(*pmc_idx_to_pmc)(struct kvm_pmu *pmu, int pmc_idx);
>   	struct kvm_pmc *(*rdpmc_ecx_to_pmc)(struct kvm_vcpu *vcpu,
>   		unsigned int idx, u64 *mask);
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 373ff6a6687b..5596fe816ea8 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -73,11 +73,6 @@ static inline struct kvm_pmc *get_gp_pmc_amd(struct kvm_pmu *pmu, u32 msr,
>   	return amd_pmc_idx_to_pmc(pmu, idx);
>   }
>   
> -static bool amd_hw_event_available(struct kvm_pmc *pmc)
> -{
> -	return true;
> -}
> -
>   static bool amd_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx)
>   {
>   	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -249,7 +244,6 @@ static void amd_pmu_reset(struct kvm_vcpu *vcpu)
>   }
>   
>   struct kvm_pmu_ops amd_pmu_ops __initdata = {
> -	.hw_event_available = amd_hw_event_available,
>   	.pmc_idx_to_pmc = amd_pmc_idx_to_pmc,
>   	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
>   	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index b239e7dbdc9b..9bf700da1e17 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -140,43 +140,6 @@ static struct kvm_pmc *intel_pmc_idx_to_pmc(struct kvm_pmu *pmu, int pmc_idx)
>   	}
>   }
>   
> -static bool intel_hw_event_available(struct kvm_pmc *pmc)
> -{
> -	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
> -	u8 event_select = pmc->eventsel & ARCH_PERFMON_EVENTSEL_EVENT;
> -	u8 unit_mask = (pmc->eventsel & ARCH_PERFMON_EVENTSEL_UMASK) >> 8;
> -	int i;
> -
> -	/*
> -	 * Fixed counters are always available if KVM reaches this point.  If a
> -	 * fixed counter is unsupported in hardware or guest CPUID, KVM doesn't
> -	 * allow the counter's corresponding MSR to be written.  KVM does use
> -	 * architectural events to program fixed counters, as the interface to
> -	 * perf doesn't allow requesting a specific fixed counter, e.g. perf
> -	 * may (sadly) back a guest fixed PMC with a general purposed counter.
> -	 * But if _hardware_ doesn't support the associated event, KVM simply
> -	 * doesn't enumerate support for the fixed counter.
> -	 */
> -	if (pmc_is_fixed(pmc))
> -		return true;
> -
> -	BUILD_BUG_ON(ARRAY_SIZE(intel_arch_events) != NR_INTEL_ARCH_EVENTS);
> -
> -	/*
> -	 * Disallow events reported as unavailable in guest CPUID.  Note, this
> -	 * doesn't apply to pseudo-architectural events (see above).
> -	 */
> -	for (i = 0; i < NR_REAL_INTEL_ARCH_EVENTS; i++) {
> -		if (intel_arch_events[i].eventsel != event_select ||
> -		    intel_arch_events[i].unit_mask != unit_mask)
> -			continue;
> -
> -		return pmu->available_event_types & BIT(i);
> -	}
> -
> -	return true;
> -}
> -
>   static bool intel_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx)
>   {
>   	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -842,7 +805,6 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
>   
>   struct kvm_pmu_ops intel_pmu_ops __initdata = {
>   	.init_pmu_capability = intel_init_pmu_capability,
> -	.hw_event_available = intel_hw_event_available,
>   	.pmc_idx_to_pmc = intel_pmc_idx_to_pmc,
>   	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
>   	.msr_idx_to_pmc = intel_msr_idx_to_pmc,


Reviewed-by:  Dapeng Mi <dapeng1.mi@linux.intel.com>

