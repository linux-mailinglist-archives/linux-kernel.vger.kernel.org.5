Return-Path: <linux-kernel+bounces-141636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130758A2100
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9AA1C238BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD7D3B295;
	Thu, 11 Apr 2024 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ynSWdYrh"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BAD2E3EF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712871369; cv=none; b=awSes+WaQnVSiqNDHly0lp3P985dnoazAtDPGUo/JtLMSEShVvGUYys+Bl6hXX/MS64pOngPmtGWsdHP2Gy7chWdYiripX9Bij/7NlS0adKF9fCten4Bw5KK3qwWVuRfCRhDdOi7PhTi7wKPXHPPpLNeRJKXpyPQAN8SHsjI7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712871369; c=relaxed/simple;
	bh=i20kViclVoU910FhgD4850gArucbSEi6mTUIiZzLMgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kd0z453v/mSgqZnBMXQ3AL7DpEBU/3YquBVv2W5ijpewb4C/kAkHnxTUADip+C+oB01Z14Xqr08KNWxw0SOfe+gOU0TjvNhBSZnqv5NkdM8lt/2pBlJXxB58ya+yxjWNgq4mkgL7+auhsETsh9eVCkVrC32jLo4a2/tItIb0I6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ynSWdYrh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6187588d2a7so4968597b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712871367; x=1713476167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2t/yhHavryfHLTVYj1u8BqInFBj/5xKyOtI6EEMp6kY=;
        b=ynSWdYrh7C6tSJa/muuA7UmUKl1SrAO4dl9VTraIazRA0fAU4boYpYKqWvMkcf2qM1
         20c/NHUmL0YkeyUx2PcwKKQ8QqX/m8MlicYrjAwDQ79ZKxFjoPdM7t0TgJKDEwIdmYcL
         OjeG+75zPFRpqlxnkh+rhM/3p+Y0jr0wlzn+s1pnrkv7Evzf+JN9sWKFcw0xnOCId6MO
         U99m4uy6t9K4xFKn/EtgeMpnSIcYYUf8jn8rUO1DzFVRFpmfezK+ri3aTFq7TYrNdP3T
         agHvYTjZcdj9a4z/io6ELqVhGdlMhZGphWy4vRolOru/uL6HHkkWFdhBJZXWJSDJoHy3
         z+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712871367; x=1713476167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2t/yhHavryfHLTVYj1u8BqInFBj/5xKyOtI6EEMp6kY=;
        b=aw3fzSt5fngYO0UNiasDkGDeT3iTjCpQK7iA25KIzo1sNsXuIq6nhGVY3MCtZirylA
         jrgGm+3qtjlHBttsPF08mts2NMpsbbssKVAYcew5NZTCQf9FwMEZAw7SWHQF1wmGe9f7
         L4P/i61NlILtGeElD57sGSpN269laJTtwuT8omi+n3z9Ye4j3DXXGVaAeUUktcjvHtoU
         4x2XBMFqnGBZw5Z6N4iJMbBjtzv2jV4rpRVVQAzB63iC5v1n1LbqIQW7GXAfUxTqReF5
         GjtRF116Nyn3+xK5yesfGuf+ApBb1SHXV7P98KByPqIRXkkPWVMEN7mtquyVBIFW0eoH
         nTEg==
X-Forwarded-Encrypted: i=1; AJvYcCUWjWWhLxojgV+vyJibCR16f6p4xwiy4u+pCeqmHrrLNpYit9KXjZW5+gm1dta/R4HMUmlmq3zFTbcS9fEsEuHmNz/FG1454HZQZGrL
X-Gm-Message-State: AOJu0YyVJarqg4iPIO4FkDl5DKz2MEEYPO48clkT9qkz5FW8c5eP4UtI
	p2l6a803D5EGqw0dnIu1nEBKV7vXlwTM47srEJvrW8aMmSUfklvF5klCb85+H3CtJsjHw0cZW+1
	Fsg==
X-Google-Smtp-Source: AGHT+IHOnBnVhBGz76zEM73ew/BnSB+dc6+KJZYmdSqjoxgILellc26j5dgSKSbo3MKBLVz44DL/AVjXFss=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ca56:0:b0:615:80c8:94f3 with SMTP id
 m83-20020a0dca56000000b0061580c894f3mr161673ywd.6.1712871367327; Thu, 11 Apr
 2024 14:36:07 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:36:05 -0700
In-Reply-To: <20240126085444.324918-25-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-25-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhhXxV3Z1UHLp1M1@google.com>
Subject: Re: [RFC PATCH 24/41] KVM: x86/pmu: Zero out unexposed
 Counters/Selectors to avoid information leakage
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
> Zero out unexposed counters/selectors because even though KVM intercepts
> all accesses to unexposed PMU MSRs, it does pass through RDPMC instruction
> which allows guest to read all GP counters and fixed counters. So, zero out
> unexposed counter values which might contain critical information for the
> host.

This belongs in the previous patch, it's effectively a bug fix.  I appreciate
the push for finer granularity, but introducing a blatant bug and then immediately
fixing it goes too far.

> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index f79bebe7093d..4b4da7f17895 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -895,11 +895,27 @@ static void intel_restore_pmu_context(struct kvm_vcpu *vcpu)
>  		wrmsrl(MSR_ARCH_PERFMON_EVENTSEL0 + i, pmc->eventsel);
>  	}
>  
> +	/*
> +	 * Zero out unexposed GP counters/selectors to avoid information leakage
> +	 * since passthrough PMU does not intercept RDPMC.

Zeroing the selectors is unnecessary.  KVM still intercepts MSR_CORE_PERF_GLOBAL_CTRL,
so just ensure the PMCs that aren't exposed the guest are globally enabled.

> +	 */
> +	for (i = pmu->nr_arch_gp_counters; i < kvm_pmu_cap.num_counters_gp; i++) {
> +		wrmsrl(MSR_IA32_PMC0 + i, 0);
> +		wrmsrl(MSR_ARCH_PERFMON_EVENTSEL0 + i, 0);
> +	}
> +
>  	wrmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl);
>  	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
>  		pmc = &pmu->fixed_counters[i];
>  		wrmsrl(MSR_CORE_PERF_FIXED_CTR0 + i, pmc->counter);
>  	}
> +
> +	/*
> +	 * Zero out unexposed fixed counters to avoid information leakage
> +	 * since passthrough PMU does not intercept RDPMC.

I would call out that RDPMC interception is all or nothing, i.e. KVM can't
selectively intercept _some_ PMCs, and the MSR bitmaps don't apply to RDPMC.

> +	 */
> +	for (i = pmu->nr_arch_fixed_counters; i < kvm_pmu_cap.num_counters_fixed; i++)
> +		wrmsrl(MSR_CORE_PERF_FIXED_CTR0 + i, 0);
>  }
>  
>  struct kvm_pmu_ops intel_pmu_ops __initdata = {
> -- 
> 2.34.1
> 

