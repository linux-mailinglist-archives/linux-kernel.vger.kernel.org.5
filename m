Return-Path: <linux-kernel+bounces-141642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D0E8A211C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1661F236B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B273B182;
	Thu, 11 Apr 2024 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKEzWTFn"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352A139AC3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872232; cv=none; b=ecLGgAhkUHeAnLMx2ss6vGc3GxpBggg8ADYWHdWYK+lYDYKAGVtO/7X0lztBtJZXTAG9YjW3PEK1z1kIWVMmxgR5BU8Yj1hnIVSy2n7EKrOvY6Kv2OqhIPD6X2ZFTukdXX0M2BVxmMbhside3P/M95lAVzgmTRkhhRPx+VRAJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872232; c=relaxed/simple;
	bh=PQIRuDalA81RPfew+1oM3M1PbSo25ZD+Ob2cgUdhwRI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PMBR+m39AS0yvycu2+A2CvJXtAmpTf7xfbyWg9jszwzjIkuyH0K7GzDl/E7cEJ9CteBlT3RuDqyBgWc6m7vCiGE8fdBYA1Gr80wpazo0ELrzrl6tGfEX3YzzPdePOMpX0sajaBRYDzMHJ3eVVZH3n4/Pidr5gk3qtOBaSlfcfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKEzWTFn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e45e04bb40so3338195ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712872230; x=1713477030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iaCjUmmDdIOzJKGmZpSSyoXs6qkh/GpGaJ06mDLpr1M=;
        b=GKEzWTFnf5sVuP0IUxt9A8GWbiHHX2Mhwox/3lpnLdb2vU1bICHLAOfcG/J2ZFYjil
         s09kZ5UdRAIiktwxg/vbbtLbEAA0GH9FaK+yKfZGXP15hQUlr1gooptkXJpAy7PDawaq
         45e3lpgP8bPE13sKW+G5oM1K2wLyppneMZO2cxpDJFX6VYuDZlnjKhDf6GqdSeSs5IOc
         XUKLlc5abihqtOUywwM88GIirK9qiqmC/ST3fINtcCIrCd3FOLxlU6R4MnYoTKX/a2L+
         xD9w0LUQWLUL/v3zL9GudEMtKl3nRZYD6P8jUtLFieblMj8EeVhg69CsHxKxzwfYdme5
         x6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712872230; x=1713477030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaCjUmmDdIOzJKGmZpSSyoXs6qkh/GpGaJ06mDLpr1M=;
        b=aK/naXOGcX4Slnp5WBDy79zZp98jEUbGzWxWilYiqCKWtzL/TxWUklc7FJ9yL6ru6E
         WPvJWLU64wp9OPilbl0F+JjL4ir0L+NX8PqUfFunWddCbd9YX3ngGmEfdscwMr6ae+wC
         /fjrCfRVKZLX5lccMbs4yqk6YSb4F83JHu4O+2fxZSC/lNYBPaAOrw7CQDhoYsZwaiiK
         T59I2+B8f/oXJbK2i7e2OYVbJs3h0Qk1D171RqUmpq5l9+NfCihveU6j4o1Nm9va5rvO
         jWYiiWhbkRzYzGHM/fYy06L5+TVnVHEb0+yFnXsrBaZp4uJ6ru/yhbhcwCIZvbYpfM67
         2VdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPUVTxyGcir9eSAtQ+3d3rnicbfyCQnW7LOosauu8QhxzCkGftHYPnpfpI32EER5fB/4qqNgXWJnV2I7G5U6pqVX8tuF4ubtO6AYfU
X-Gm-Message-State: AOJu0YzG7Sx+OJvnVKES3EKaG+HUzdpyvmuTNYK7ILWB/krpsVXhrcoX
	RCKXTlnAmZkk4omd3iDFlYhHvEgULd/7Bagc+Ip/OtMW3zwhrsQeTnaaiQTnJAuqgIxUGFHe26p
	rVg==
X-Google-Smtp-Source: AGHT+IHoU3vWBVtinqVLN1A8TwfMLrhsEG6lZ6A6/VWf1bt/DoqDl+FQZvyCl4pbADg3UfMsA+vwmkWh0kw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:128f:b0:2a4:8940:41c7 with SMTP id
 fw15-20020a17090b128f00b002a4894041c7mr2248pjb.4.1712872230439; Thu, 11 Apr
 2024 14:50:30 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:50:28 -0700
In-Reply-To: <20240126085444.324918-28-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-28-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhhbJCGcJ6Rshkfk@google.com>
Subject: Re: [RFC PATCH 27/41] KVM: x86/pmu: Clear PERF_METRICS MSR for guest
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
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Since perf topdown metrics feature is not supported yet, clear
> PERF_METRICS MSR for guest.

Please rewrite with --verbose, I have no idea what MSR_PERF_METRICS, and thus no
clue why it needs to be zeroed when loading guest context, e.g. it's not passed
through, so why does it matter?

> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 4b4da7f17895..ad0434646a29 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -916,6 +916,10 @@ static void intel_restore_pmu_context(struct kvm_vcpu *vcpu)
>  	 */
>  	for (i = pmu->nr_arch_fixed_counters; i < kvm_pmu_cap.num_counters_fixed; i++)
>  		wrmsrl(MSR_CORE_PERF_FIXED_CTR0 + i, 0);
> +
> +	/* Clear PERF_METRICS MSR since guest topdown metrics is not supported yet. */
> +	if (kvm_caps.host_perf_cap & PMU_CAP_PERF_METRICS)
> +		wrmsrl(MSR_PERF_METRICS, 0);
>  }
>  
>  struct kvm_pmu_ops intel_pmu_ops __initdata = {
> -- 
> 2.34.1
> 

