Return-Path: <linux-kernel+bounces-141641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 849FA8A211A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71611C219CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E43AC2B;
	Thu, 11 Apr 2024 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fz0dM8Qr"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B663BBC2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872152; cv=none; b=rbuuWNkp4tGdIfLtzlpaiGo7hzjVUWZ1Vvl4t9QKBIUZezfpzPGBE4kzrDhGkyyLeNccPbOPy9ccC6lxja4Ry02znAh0WcPk+xfI/WEAH09krqSIiMfow97Zo3iJwjV3TJUvjQzWmkbq3onLuxsX6cA+JMfZSNNuA+WI41NLEMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872152; c=relaxed/simple;
	bh=YNOXp9b/Jpb+es+bSQ62skx+KBDAECbNrG40A/IivHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oA0Pzb7lZA3kIge5ZgOeYgg2mn4hzGJJtx4csqtG23JE9SvhCAMVg7Ri4gTcGByYqOaoV6/5zUGo0bth3DtnP9ZoCs/u+m53fUM+MJQ5xUd58TH27vjVmiPzEQw53ULhUKR0EZnzf09xkTrWhJiZU/aLD7la95F5BVayxxeam4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fz0dM8Qr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd933a044baso1640591276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712872149; x=1713476949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E46uucbaaoqsuZZvyzOBFLngOEYFFwjcligp3RIvVUA=;
        b=fz0dM8QrZYckAcpi5DyJDPwgQSGXvY120TrbGeIwqVEckqJ8WjXLXe4KsufnIfIaZs
         hLrMZrrdPe7SYCoxmYtNiPvgd/kAKTNpdcRN1BPgCtKRvF1W6C7lfEShhzps2CV1zqRI
         bmyIZee7lQICCo7zgVvvTt/UnHXPxs7Hih6OaxNX4noSESUNyKH/m6QhfcbmTqv9PpHl
         MlnAv9zHx4CKbwdeW3fMjeSJrFG5saiFN9hyoWX+T2dQQ09i9eveNSvGkOCkyy+A3DH5
         BaipWAfEYEP55TyPEoD3sc86ptjgXRgCJIzylTHWMy5iFvryOVKU5BTQ9oC5IlUE8rKH
         L8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712872149; x=1713476949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E46uucbaaoqsuZZvyzOBFLngOEYFFwjcligp3RIvVUA=;
        b=n9B7iRo0IhvhAPfLv7cViEH9o4UbizGH6YuDVn5tpGPcod4YzUZZ+r5kygB6KKowHV
         4w6ZJtTco0thn5dZjjM0uCXIUTQooshaMH4w/gAG+2+y9mLF9VFkk4Ke6OoSoHQ5BlnR
         JIl4qbQfVlhrFlktFomjNoYmB0yveaKv2v7FltpH6zUMOckqdoJS/+PzMGQIkVW4o9jT
         9Oew212s+B/sSUuOibtV76EYKmgXJJpTUVBquvlXofgcPJPH/PN6paudAHdvAp6J8Gn6
         BCN3qOpKuqslzuwt17CQ/u1KAAep8C5CcGad38GAICn2xc1Std5hc0YSX9OHpVpVLWT3
         tQHg==
X-Forwarded-Encrypted: i=1; AJvYcCWo+iMCoi5rPbCyCdY2wyVh5hemoBmhp/A0MmmafhxwdeFFqv9t3ZOGHXHA793dKj0Uz2ij/dttWhyHd9r3x0LVvenYx6clOAuVjkT8
X-Gm-Message-State: AOJu0Yx7pZUazMrH2Yq941sKuH9KAF0oxKcfyza4Hsl5SnjiIci1L0xA
	Zd4SR6zmGsuh+AKjFFpGVpYTe0fZA4unGZqPrj5Fb5ch1D2SQbWMbm2Qrjr891imx7mn6agL19g
	oWQ==
X-Google-Smtp-Source: AGHT+IGck7OcujVjK4HXtTQv2Wbqqa7S9w3/FO991MY4XC3orGk6WQGzWdNyjeqNUn6MdpdyT3+lkMWbHpw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ab70:0:b0:dc7:463a:46d2 with SMTP id
 u103-20020a25ab70000000b00dc7463a46d2mr626352ybi.0.1712872149661; Thu, 11 Apr
 2024 14:49:09 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:49:08 -0700
In-Reply-To: <20240126085444.324918-27-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-27-xiong.y.zhang@linux.intel.com>
Message-ID: <Zhha1N61JU1x3c64@google.com>
Subject: Re: [RFC PATCH 26/41] KVM: x86/pmu: Add host_perf_cap field in
 kvm_caps to record host PMU capability
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
> Add host_perf_cap field in kvm_caps to record host PMU capability. This
> helps KVM recognize the PMU capability difference between host and guest.
> This awareness improves performance in PMU context switch. In particular,
> KVM will need to zero out all MSRs that guest PMU does not use but host PMU
> does use. Having the host PMU feature set cached in host_perf_cap in
> kvm_caps structure saves a rdmsrl() to IA32_PERF_CAPABILITY MSR on each PMU
> context switch. In addition, this is more convenient approach than open
> another API on the host perf subsystem side.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 17 +++++++++--------
>  arch/x86/kvm/x86.h     |  1 +
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 349954f90fe9..50100954cd92 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7896,32 +7896,33 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	vmx_update_exception_bitmap(vcpu);
>  }
>  
> -static u64 vmx_get_perf_capabilities(void)
> +static void vmx_get_perf_capabilities(void)
>  {
>  	u64 perf_cap = PMU_CAP_FW_WRITES;
>  	struct x86_pmu_lbr lbr;
> -	u64 host_perf_cap = 0;
> +
> +	kvm_caps.host_perf_cap = 0;
>  
>  	if (!enable_pmu)
> -		return 0;
> +		return;
>  
>  	if (boot_cpu_has(X86_FEATURE_PDCM))
> -		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
> +		rdmsrl(MSR_IA32_PERF_CAPABILITIES, kvm_caps.host_perf_cap);

I would strongly prefer KVM snapshot the host's MSR_IA32_PERF_CAPABILITIES, if
the CPU has PDMC, i.e. not leave it zero if the PMU is disabled.

>  
>  	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) &&
>  	    !enable_passthrough_pmu) {
>  		x86_perf_get_lbr(&lbr);
>  		if (lbr.nr)
> -			perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
> +			perf_cap |= kvm_caps.host_perf_cap & PMU_CAP_LBR_FMT;
>  	}
>  
>  	if (vmx_pebs_supported() && !enable_passthrough_pmu) {
> -		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
> +		perf_cap |= kvm_caps.host_perf_cap & PERF_CAP_PEBS_MASK;
>  		if ((perf_cap & PERF_CAP_PEBS_FORMAT) < 4)
>  			perf_cap &= ~PERF_CAP_PEBS_BASELINE;
>  	}
>  
> -	return perf_cap;
> +	kvm_caps.supported_perf_cap = perf_cap;
>  }
>  
>  static __init void vmx_set_cpu_caps(void)
> @@ -7946,7 +7947,7 @@ static __init void vmx_set_cpu_caps(void)
>  
>  	if (!enable_pmu)
>  		kvm_cpu_cap_clear(X86_FEATURE_PDCM);
> -	kvm_caps.supported_perf_cap = vmx_get_perf_capabilities();
> +	vmx_get_perf_capabilities();
>  
>  	if (!enable_sgx) {
>  		kvm_cpu_cap_clear(X86_FEATURE_SGX);
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 38b73e98eae9..a29eb0469d7e 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -28,6 +28,7 @@ struct kvm_caps {
>  	u64 supported_mce_cap;
>  	u64 supported_xcr0;
>  	u64 supported_xss;
> +	u64 host_perf_cap;
>  	u64 supported_perf_cap;

This is confusing, host_perf_cap doesn't track "capabilities" so much as it tracks
a raw host value.  Luckily, I have a series that I am going to post this week
that adds another struct for tracking host values, e.g. host_xss, host_efer, etc.

>  };
>  
> -- 
> 2.34.1
> 

