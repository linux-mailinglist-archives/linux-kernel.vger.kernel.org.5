Return-Path: <linux-kernel+bounces-93089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D554872AF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DA528160B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08612A16A;
	Tue,  5 Mar 2024 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0zqhtIXS"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DCC79953
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680926; cv=none; b=pZV2fTm5f0Gfo2l7grHx9d9iTyHLm9Tx2oBVblxGqq05gT3hvqs+L965cD/1NNodUi/VoZrQdKc3yblxIdi3WPGB9G50Wv2bvvKZbEc1gHaUjmx9RbXz92UARFRp6oPBlqgUzb9KRjn8OpE+jgRuSV+sW44NeIRJctURf7xTPjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680926; c=relaxed/simple;
	bh=0QqKaja2wGQkp5VdpnZGiCLHufW+2W9QfUG8dJPnUnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oIAOTP1g59PSeqqtn0BljODU6LXdYYlnOWp5yq7TxTedBbrgosJQ1CP+ZTbR9Z6jyL4Algjpk0cLhGuyjW71zCBjanGCsqwIsW2hw+9RZOgH3CK1Amt+D3esqJSgeZdX3mnGMPCzLnnGSNEbboQfs+6BQht8exImp7uLwfmcBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0zqhtIXS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso9278386276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 15:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709680924; x=1710285724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+T4/DXA8g5wsjCQOI4d9Me0cBz3l8e073w7d7R7vr8=;
        b=0zqhtIXSHS/MzUXKzXkI8lwdQwjxmndjzB2XAla24oAV3eO3PEdMiL7rvN6ZrHMcGp
         xuMoLF14oeojSJr3ktYR8oHulKOaP0RSMC+Q6p80qcciKpraBqQoQInYKl+jSRGM/hqa
         sOD+BHYFgzKLax1SiFWXWy8TdEMhu8CIIYAQYLg39Zg693mqqPep78rJxXIRxs9sbud6
         6ASByKFdws9CodDFjJ6HrmDaFCbOFLwHDqfjj1WLdMA9cZu8H77J7LzwjTT+ooiiyJZz
         w7QWTWAn2bZoZ4NhgCxHjcEJ2hJpt75jddQFhByc9yw/SGp4/+7BJI23+5QufRJy8pb1
         ejvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709680924; x=1710285724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+T4/DXA8g5wsjCQOI4d9Me0cBz3l8e073w7d7R7vr8=;
        b=LB1E9HSeXpsj1fX6mu4AMC0Aba0wW9um0IFFCDtxRjnXGdO4I8V+byzG8txmImw0a+
         u01bSREL0vBfmoXPUW/Zi82XwUxNxgcHmNeyQcbkYmXKTAyuocW46mwFyHfNfAhMZYZq
         W8vVXZKgZfIyWA/Yg3dx3/QsIVsx9OyiQKDhbtvTkqhOx+AN7LfHAxiWtokgXPBQovmI
         bhTC5Gvvp+ikOWuKTQQrZ/yQ68ErS3za6NhGXSG+q3N1r6Vx/paDHjlbhei/GL6e17WU
         c5H2dkppNGmOxDb4UwPFPECPhyCZ+V7b6bRjQD8yddjfPFqDXGzcuEGFn0IxF64uwsj/
         bTpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW948ScSObTJ+VatwNdtbLXkV49OhH1pVuSZ6HJsAwDiDQuTQpnae6w9xc+elcPzxf2V0G62pwgZfFQZGDJsEsFJppehf0TvT9Xx6OY
X-Gm-Message-State: AOJu0Yx8wIvMkulP130BuW1jjbT51jHC7jTyvfwKfOm8SMUEZqWsoj1L
	WD9W+c+4zVEnlvxyw6KkSG5JTvhaHI8wbfgRnZwO3msQqEzGa342t1PaJORZ+B/JWvfDyVUg7E9
	tyQ==
X-Google-Smtp-Source: AGHT+IFkDwAHYCS99l3GSkk1EFfxwdOwqpDghQVC1M8Qt99OMUPaJBjB6sPk7lALPOP6nKY9i00G4WHXgm4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1821:b0:dc7:9218:df3b with SMTP id
 cf33-20020a056902182100b00dc79218df3bmr585948ybb.10.1709680923726; Tue, 05
 Mar 2024 15:22:03 -0800 (PST)
Date: Tue, 5 Mar 2024 15:22:02 -0800
In-Reply-To: <20230824020546.1108516-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230824020546.1108516-1-dapeng1.mi@linux.intel.com>
Message-ID: <ZeepGjHCeSfadANM@google.com>
Subject: Re: [Patch v3] KVM: x86/pmu: Manipulate FIXED_CTR_CTRL MSR with macros
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Like Xu <likexu@tencent.com>, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Zhang Xiong <xiong.y.zhang@intel.com>, Lv Zhiyuan <zhiyuan.lv@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="us-ascii"

+Mingwei

On Thu, Aug 24, 2023, Dapeng Mi wrote:
 diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 7d9ba301c090..ffda2ecc3a22 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -12,7 +12,8 @@
>  					  MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
>  
>  /* retrieve the 4 bits for EN and PMI out of IA32_FIXED_CTR_CTRL */
> -#define fixed_ctrl_field(ctrl_reg, idx) (((ctrl_reg) >> ((idx)*4)) & 0xf)
> +#define fixed_ctrl_field(ctrl_reg, idx) \
> +	(((ctrl_reg) >> ((idx) * INTEL_FIXED_BITS_STRIDE)) & INTEL_FIXED_BITS_MASK)
>  
>  #define VMWARE_BACKDOOR_PMC_HOST_TSC		0x10000
>  #define VMWARE_BACKDOOR_PMC_REAL_TIME		0x10001
> @@ -165,7 +166,8 @@ static inline bool pmc_speculative_in_use(struct kvm_pmc *pmc)
>  
>  	if (pmc_is_fixed(pmc))
>  		return fixed_ctrl_field(pmu->fixed_ctr_ctrl,
> -					pmc->idx - INTEL_PMC_IDX_FIXED) & 0x3;
> +					pmc->idx - INTEL_PMC_IDX_FIXED) &
> +					(INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER);
>  
>  	return pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE;
>  }
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index f2efa0bf7ae8..b0ac55891cb7 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -548,8 +548,13 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  		setup_fixed_pmc_eventsel(pmu);
>  	}
>  
> -	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
> -		pmu->fixed_ctr_ctrl_mask &= ~(0xbull << (i * 4));
> +	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
> +		pmu->fixed_ctr_ctrl_mask &=
> +			 ~intel_fixed_bits_by_idx(i,
> +						  INTEL_FIXED_0_KERNEL |
> +						  INTEL_FIXED_0_USER |
> +						  INTEL_FIXED_0_ENABLE_PMI);
> +	}
>  	counter_mask = ~(((1ull << pmu->nr_arch_gp_counters) - 1) |
>  		(((1ull << pmu->nr_arch_fixed_counters) - 1) << INTEL_PMC_IDX_FIXED));
>  	pmu->global_ctrl_mask = counter_mask;
> @@ -595,7 +600,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  			pmu->reserved_bits &= ~ICL_EVENTSEL_ADAPTIVE;
>  			for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
>  				pmu->fixed_ctr_ctrl_mask &=
> -					~(1ULL << (INTEL_PMC_IDX_FIXED + i * 4));

OMG, this might just win the award for most obfuscated PMU code in KVM, which is
saying something.  The fact that INTEL_PMC_IDX_FIXED happens to be 32, the same
bit number as ICL_FIXED_0_ADAPTIVE, is 100% coincidence.  Good riddance.

Argh, and this goofy code helped introduce a real bug.  reprogram_fixed_counters()
doesn't account for the upper 32 bits of IA32_FIXED_CTR_CTRL.

Wait, WTF?  Nothing in KVM accounts for the upper bits.  This can't possibly work.

IIUC, because KVM _always_ sets precise_ip to a non-zero bit for PEBS events,
perf will _always_ generate an adaptive record, even if the guest requested a
basic record.  Ugh, and KVM will always generate adaptive records even if the
guest doesn't support them.  This is all completely broken.  It probably kinda
sorta works because the Basic info is always stored in the record, and generating
more info requires a non-zero MSR_PEBS_DATA_CFG, but ugh.

Oh great, and it gets worse.  intel_pmu_disable_fixed() doesn't clear the upper
bits either, i.e. leaves ICL_FIXED_0_ADAPTIVE set.  Unless I'm misreading the code,
intel_pmu_enable_fixed() effectively doesn't clear ICL_FIXED_0_ADAPTIVE either,
as it only modifies the bit when it wants to set ICL_FIXED_0_ADAPTIVE.

*sigh*

I'm _very_ tempted to disable KVM PEBS support for the current PMU, and make it
available only when the so-called passthrough PMU is available[*].  Because I
don't see how this is can possibly be functionally correct, nor do I see a way
to make it functionally correct without a rather large and invasive series.

Ouch.  And after chatting with Mingwei, who asked the very good question of
"can this leak host state?", I am pretty sure that yes, this can leak host state.

When PERF_CAP_PEBS_BASELINE is enabled for the guest, i.e. when the guest has
access to adaptive records, KVM gives the guest full access to MSR_PEBS_DATA_CFG

	pmu->pebs_data_cfg_mask = ~0xff00000full;

which makes sense in a vacuum, because AFAICT the architecture doesn't allow
exposing a subset of the four adaptive controls.

GPRs and XMMs are always context switched and thus benign, but IIUC, Memory Info
provides data that might now otherwise be available to the guest, e.g. if host
userspace has disallowed equivalent events via KVM_SET_PMU_EVENT_FILTER.

And unless I'm missing something, LBRs are a full leak of host state.  Nothing
in the SDM suggests that PEBS records honor MSR intercepts, so unless KVM is
also passing through LBRs, i.e. is context switching all LBR MSRs, the guest can
use PEBS to read host LBRs at will.

Unless someone chimes in to point out how PEBS virtualization isn't a broken mess,
I will post a patch to effectively disable PEBS virtualization.

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 41a4533f9989..a2f827fa0ca1 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -392,7 +392,7 @@ static inline bool vmx_pt_mode_is_host_guest(void)
 
 static inline bool vmx_pebs_supported(void)
 {
-       return boot_cpu_has(X86_FEATURE_PEBS) && kvm_pmu_cap.pebs_ept;
+       return false;
 }
 
 static inline bool cpu_has_notify_vmexit(void)

