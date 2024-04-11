Return-Path: <linux-kernel+bounces-141522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 606418A1F60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01341F26744
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26BD15E8C;
	Thu, 11 Apr 2024 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HV0dDten"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF4168B9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863294; cv=none; b=qyMmu5zMtDOp97b6nWHswlCTp+835PWSyAsQTHNb5jFicGHgOeVRI8Z7ubqtjL9UstTXPFKPDEQyszdwt9Xdr+kvxbALuFZ4zeQDRWKzhS/TD4BFgJYPXErgrF5wKUaLBmv43i2we2JJGcFp90dJ4bL22HNxWpq7hDRZmMup2Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863294; c=relaxed/simple;
	bh=0iDrj2AwfZPdpvbdX9zswaCeouu1E0y3S0A8fzExlVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NEXB2p7x4sDWu3g7NbDw4Fm9s5K/GssrtSjjB+s71gHpOLHO9Un7O2Kv/xbgj12XnhGIySskG/UTCSyAtWgp8LmJQERNfgB7eh4K1XPTOTi8CqooIo96m6eKbiqOF5/q4hGQHBHqu7yv9z+SjA5Ab6QjY6pgaB+fbnykGDxGsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HV0dDten; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a2d197ac0aso109942a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712863292; x=1713468092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IuZWM+vvGhXI111nZezq7YkDGfyo2NaCVPFqmlVhiZg=;
        b=HV0dDtenLo7xoWt3tuGE+MsFQMFI68O+g88NMlCmQKr+x8ZRiUGCECNYs/6jKKwChQ
         JJXYDL7g+4v7xePFR0ZkxgAVUyYMR4F88GyBMSltXoz757Z0li4V93dpKTLmc0NeGWpP
         TLSYY3cTGxAIKRQUwBI2pWU8VaLGCygpmrAQK7tZx/de+8DRt4dZUnUcB6HRxtH++iXI
         5fR+HxsBgfm+CZ+En9OCBJYk7z0Bn+ingwGHgrwRUCFvbX4GDJFC2nFNrMATfF6oya0c
         b1ir/jaxDMz3zFtMwB9kP9LZjoj47DyjRkvhOMcnx+Ui2Kw8CRY+ZbfypYQUQiirvjWy
         A8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863292; x=1713468092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IuZWM+vvGhXI111nZezq7YkDGfyo2NaCVPFqmlVhiZg=;
        b=MYSa4I4CcqgT6WxRey08nGrUPrzog8/hd1tv2Et8TYVPhIIFkBz7UcMfwZjmu9++KW
         AaDwR1+xK/+K1EYLUe1BVOdV16MthwsX9+T7NslxriOoI/8DQgef2rjzYq03zEWIw94U
         V3v/WAGeFSP7rLyz9zrOc5FOfcUqx0oxxGfNQLiegZkqoWpD4boCiDsl+Uz7PA5keldj
         NFusw0F7LJmVh1pJ7YpP74bkyTtQZvaGPdMKeGF+h1wrHdXS7jLiXMdQFcLzDSdskZ5n
         Hnw0dZ1r/rB5FJz0ydqoHGR5361HzeCxUb9lI2cUj38B1hfP/tJe2FzSgn915rebHjqD
         CCXA==
X-Forwarded-Encrypted: i=1; AJvYcCVFl9Z2Vw7QBIg6g+FC7kCrl3wlaRAgbfyPFyDJzzN6JEWJUMWPEnOlwHE7RLrGFkwZK+s9X/Y+IJvxHUD6KgybSAxSzh5D/2OEFgzH
X-Gm-Message-State: AOJu0Yzt82IEgaPY8M5pLdCUiVNXauap1SDoE/kemry0N0L6racygce8
	XAAqK8NHEtEC5SY8RthVKec9Z+jzwbABPU9/EXDWgSmndNYfg2YWTaXKSMdN0xEI/7epp95eKAs
	djQ==
X-Google-Smtp-Source: AGHT+IHPgtVqy0nFz025gGkTnMo7Alsvac05GAyUWXxa4k7Ytx/BHJCnyE1o2+n0hRWW+1ji8QfCIZN6pMU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:fb94:b0:2a5:2428:2253 with SMTP id
 cp20-20020a17090afb9400b002a524282253mr1232pjb.8.1712863291990; Thu, 11 Apr
 2024 12:21:31 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:21:30 -0700
In-Reply-To: <20240126085444.324918-8-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-8-xiong.y.zhang@linux.intel.com>
Message-ID: <Zhg4Oph6yCpN0DeX@google.com>
Subject: Re: [RFC PATCH 07/41] perf/x86: Add interface to reflect virtual
 LVTPC_MASK bit onto HW
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com, Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> From: Xiong Zhang <xiong.y.zhang@intel.com>
> 
> When guest clear LVTPC_MASK bit in guest PMI handler at PMU passthrough
> mode, this bit should be reflected onto HW, otherwise HW couldn't generate
> PMI again during VM running until it is cleared.

This fixes a bug in the previous patch, i.e. this should not be a standalone
patch.

> 
> This commit set HW LVTPC_MASK bit at PMU vecctor switching to KVM PMI
> vector.
> 
> Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/events/core.c            | 9 +++++++--
>  arch/x86/include/asm/perf_event.h | 2 +-
>  arch/x86/kvm/lapic.h              | 1 -
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 3f87894d8c8e..ece042cfb470 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -709,13 +709,18 @@ void perf_guest_switch_to_host_pmi_vector(void)
>  }
>  EXPORT_SYMBOL_GPL(perf_guest_switch_to_host_pmi_vector);
>  
> -void perf_guest_switch_to_kvm_pmi_vector(void)
> +void perf_guest_switch_to_kvm_pmi_vector(bool mask)
>  {
>  	lockdep_assert_irqs_disabled();
>  
> -	apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_VPMU_VECTOR);
> +	if (mask)
> +		apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_VPMU_VECTOR |
> +			   APIC_LVT_MASKED);
> +	else
> +		apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_VPMU_VECTOR);
>  }

Or more simply:

void perf_guest_enter(u32 guest_lvtpc)
{
	...

	apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_VPMU_VECTOR |
			       (guest_lvtpc & APIC_LVT_MASKED));
}

and then on the KVM side:

	perf_guest_enter(kvm_lapic_get_reg(vcpu->arch.apic, APIC_LVTPC));

because an in-kernel APIC should be a hard requirement for the mediated PMU.

