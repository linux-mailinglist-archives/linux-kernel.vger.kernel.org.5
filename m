Return-Path: <linux-kernel+bounces-141702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1558A2223
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6062D1C23083
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FFE481BF;
	Thu, 11 Apr 2024 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQd0YwFn"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6947A4C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877174; cv=none; b=gZCHCmRFBipRX3qOl2ZAcSBrAE5fTaykoh/ai7ecHNuHE5mqeonzj2Y7InS7mDGr/YLjghynFFm8+9hh+K8I86aZIL9SRzLI/Z791I87GfZT818op4SPvNsw20eT1PYZKFzDHrmmhwnjFDDvJMaw080nbhSeMhXSXEgN1dyCeZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877174; c=relaxed/simple;
	bh=ApfpEC/c9RwYMaMjNDvl7jqY9ffi1OuijzlkZrANZVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XIuOi+pkMEMQjGGwCtb1Yz75Js2O/+2BshW9EJ2P/RytVBA6VFacOkhGcQJLJgjJoGhLHIyiy4rlOKKnFciqznJCAwLTUvX+qjX7SyOYm3vbd3bxSTKI3NjAstcw2T0gy5Qez9r2M7Ux3QvsxnX+5M2rx4J9jgLAAOLgtoLlFSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQd0YwFn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e3c8d7d87cso10465205ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712877173; x=1713481973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZTULtIL+lV2ksfF5gqJAUFQ6w6cEIb56Yjey7qpWqE=;
        b=eQd0YwFn3ky4am18zwve5tKt87zC7mMgtFDwKJVWbNNpBUlxt8M2ngb+80C5pfXrDM
         1UdfxIKw66Wcdq8hj6cS/YwV0VpX29i5KbyvYdTvJvp1LB3/R0YAPxPJ32atDYD7q1vM
         7lPXvaoRhQlaVawrawKOgLW10MMhsI9zk0Ler+0fnI4rHjNwH0mUq66CHxQhjhj2VVek
         +IAmOABnFTE5Sp/EQVnNIyexAX60+o4UaBhvLiqtnBeQcSg4GtWe1VgjsZigGveOhZr+
         /yKyHBen+gFv51wn5CdL88uk9OFMFopVrmWTb5/u41a9jTw+Jj1Wg1X3UN28f3DwqFCZ
         i0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712877173; x=1713481973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZTULtIL+lV2ksfF5gqJAUFQ6w6cEIb56Yjey7qpWqE=;
        b=PScs7T1AYladxH+p+QvcvQzT15pc8BpkQP5yDjjq/wEummhWhCamx4G5DleDU5xyYy
         ZeqazkMCaZPqM+N0VuPhLotlcdUXaTOOoruT6iiqIOc2eacWSG/S7nwwTtPRvdikl4vJ
         DTIggxbOrtsx2xICnNXH4qnjEL7Mx90IE4n9gzIo7dZus8bhvREVgRmCEMslGi8DwKJk
         fn0ImGqcKQojZZNAgjlSI1sILA0K+h4KQH8b1Fb0VpmL+75wTGnjHhD5rmu034JELfjm
         GEA18Fnv58FmlBBefVMOb/QDWqSqbWoh3aKLm9BlCItI3OTZ8FNzt9syvvwWfVL9FRQm
         5/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYrlW7VQrmad9Rk8SZ6M9w41VV+oY1litbZNrVb7oS9PXvH1MP5G9JPm4DUHjuALBINgt2mzviZWNRe8DTOGaC+v8q2Va0rCOs2AS1
X-Gm-Message-State: AOJu0YzatY4p8U4BM33TX452NZxU+hHq393XJGg/hKIh5kaIQjPwe875
	AhTqc9h2zOmX1iCUYGUPOssZUqKzg0N+L1EXPFmCwKENg4yPLEtpPBR3ftDcR0MSt0FxrTLpPXu
	nhw==
X-Google-Smtp-Source: AGHT+IFb+VZR+ITSdRopsmDvE8d+//3f0B78BY1xTTOxM337UjQK0WSSN6/v0+aoWcSMkKSsajSBRlQJoQc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:788e:b0:1e3:d8de:9892 with SMTP id
 q14-20020a170902788e00b001e3d8de9892mr12004pll.4.1712877172477; Thu, 11 Apr
 2024 16:12:52 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:12:50 -0700
In-Reply-To: <20240126085444.324918-40-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-40-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhhucuZcaCKVPb5R@google.com>
Subject: Re: [RFC PATCH 39/41] KVM: x86/pmu: Implement emulated counter
 increment for passthrough PMU
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> From: Mingwei Zhang <mizhang@google.com>
> 
> Implement emulated counter increment for passthrough PMU under KVM_REQ_PMU.
> Defer the counter increment to KVM_REQ_PMU handler because counter
> increment requests come from kvm_pmu_trigger_event() which can be triggered
> within the KVM_RUN inner loop or outside of the inner loop. This means the
> counter increment could happen before or after PMU context switch.
> 
> So process counter increment in one place makes the implementation simple.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 ++
>  arch/x86/kvm/pmu.c              | 52 ++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/pmu.h              |  1 +
>  arch/x86/kvm/x86.c              |  8 +++--
>  4 files changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 869de0d81055..9080319751de 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -532,6 +532,7 @@ struct kvm_pmu {
>  	u64 fixed_ctr_ctrl_mask;
>  	u64 global_ctrl;
>  	u64 global_status;
> +	u64 synthesized_overflow;

There's no reason for this to be a per-PMU field, it's only ever used in
kvm_passthrough_pmu_handle_event().

>  	u64 counter_bitmask[2];
>  	u64 global_ctrl_mask;
>  	u64 global_status_mask;
> @@ -550,6 +551,7 @@ struct kvm_pmu {
>  		atomic64_t __reprogram_pmi;
>  	};
>  	DECLARE_BITMAP(all_valid_pmc_idx, X86_PMC_IDX_MAX);
> +	DECLARE_BITMAP(incremented_pmc_idx, X86_PMC_IDX_MAX);
>  	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
>  
>  	u64 ds_area;
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 7b0bac1ac4bf..9e62e96fe48a 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -449,6 +449,26 @@ static bool kvm_passthrough_pmu_incr_counter(struct kvm_pmc *pmc)
>  	return false;
>  }
>  
> +void kvm_passthrough_pmu_handle_event(struct kvm_vcpu *vcpu)

Huh.  Why do we call the existing helper kvm_pmu_handle_event()?  It's not handling
an event, it's reprogramming counters.

Can you add a patch to clean that up?  It doesn't matter terribly with the existing
code, but once kvm_handle_guest_pmi() exists, the name becomes quite confusing,
e.g. I was expecting this to be the handler for guest PMIs.

> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	int bit;
> +
> +	for_each_set_bit(bit, pmu->incremented_pmc_idx, X86_PMC_IDX_MAX) {

I don't love the "incremented_pmc_idx" name.  It's specifically for emulated
events, that should ideally be clear in the name.

And does the tracking the emulated counters actually buy anything?  Iterating
over all PMCs and checking emulated_counter doesn't seem like it'd be measurably
slow, especially not when this path is likely writing multiple MSRs.

Wait, why use that and not reprogram_pmi?


> +		struct kvm_pmc *pmc = static_call(kvm_x86_pmu_pmc_idx_to_pmc)(pmu, bit);
> +
> +		if (kvm_passthrough_pmu_incr_counter(pmc)) {

kvm_passthrough_pmu_incr_counter() is *super* misleading.  (a) it's not an
"increment" in standard x86 and kernel terminology, which is "Increment by 1",
and (b) it's not actually bumping the count, it's simply moving an *already*
incremented count from emulated_count to the pmc->counter.

To avoid bikeshedding, and because boolean returns are no fun, just open code it.

		if (!pmc->emulated_counter)
			continue;

		pmc->counter += pmc->emulated_counter;
		pmc->emulated_counter = 0;
		pmc->counter &= pmc_bitmask(pmc);

		/* comment goes here */
		if (pmc->counter)
			continue;

		if (pmc->eventsel & ARCH_PERFMON_EVENTSEL_INT)
			kvm_make_request(KVM_REQ_PMI, vcpu);

		pmu->global_status |= BIT_ULL(pmc->idx);

> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 6f44fe056368..0fc37a06fe48 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -277,6 +277,7 @@ static inline bool is_passthrough_pmu_enabled(struct kvm_vcpu *vcpu)
>  
>  void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
>  void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
> +void kvm_passthrough_pmu_handle_event(struct kvm_vcpu *vcpu);
>  int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
>  bool kvm_pmu_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx);
>  bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fe7da1a16c3b..1bbf312cbd73 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10726,8 +10726,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  		}
>  		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
>  			record_steal_time(vcpu);
> -		if (kvm_check_request(KVM_REQ_PMU, vcpu))
> -			kvm_pmu_handle_event(vcpu);
> +		if (kvm_check_request(KVM_REQ_PMU, vcpu)) {
> +			if (is_passthrough_pmu_enabled(vcpu))
> +				kvm_passthrough_pmu_handle_event(vcpu);
> +			else
> +				kvm_pmu_handle_event(vcpu);

This seems like a detail that belongs in the PMU code.  E.g. if we get to a point
where the two PMU flavors can share code (and I think we can/show), then there's
no need or desire for two separate APIs.

> +		}
>  		if (kvm_check_request(KVM_REQ_PMI, vcpu))
>  			kvm_pmu_deliver_pmi(vcpu);
>  #ifdef CONFIG_KVM_SMM
> -- 
> 2.34.1
> 

