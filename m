Return-Path: <linux-kernel+bounces-167071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762DE8BA414
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C701C220E5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475A23F9D9;
	Thu,  2 May 2024 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="1VeE8fRn"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3D24A08
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692965; cv=none; b=mWWPAueYPlLVOXb54EaXgIk7L6dGsZlZptt8ZKFQ5wkC8YJfT7qd9JnjMCykDiJ+Pf7dO9hUBzTMEpIPMK9emc3leyMyt/aHQl5ugnt8onIp1Nbg7ijn/MDpvR6rpMbJzZ4SfhbueUeKMDL6iWEzMG94MWgdPnoFeKDD2lKvEVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692965; c=relaxed/simple;
	bh=0dwj6bRBqsUtQYoDeVUdjqbm8P3ym0YXikVZmUYSRdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iSo72ETV7yYWR5l3nD4Mbjh5b9ZZQNvVV3SHyDX2ikkkLomUroD0X2iJyEMFgKaqLQmfXN3lQutjs+ecTlJBX5GkPYi0BHMoeVwedSGp9cbCfxpBBNt55F8FIcT/CQ/O4sEANBYTdSvvwnnJMBxiamSeG4nOTNdfLHC/1XPO4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1VeE8fRn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so13290640276.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714692963; x=1715297763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ecRZPEHvExqS79AgCnGYCH1KXuiTZnddDvYfe16C7IA=;
        b=1VeE8fRnBIorSrPVUWyvqzfvH/wKv8lACmUTx1LfWg2LEOLY2gwKRNWZnnP+ZJtD1N
         qHfa3VVxF8WALXvnpAWgI/gNPjW+mNQXsjuLdBTOu30zFlNS1p36PXaaX3f426J3Wx8s
         FIZxMRshRSK/H6HzLMwGUeurX1isfVKkyTsdqqjKAThi48EwLkn6MLnz6Pbl3scetCQU
         s/U9TXvJk77iS7clxRsR4OHF3Iz+oD9G+dWsDMvzwPB4i/34MYoVPheuMTi7iW3dCkH4
         CkOiYRet/MnCoBqQ3RE+ineycnQ1q15ZH5gbNwAV4TWBtEFC+1g1hRk0gElNZHOJqy6o
         4YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692963; x=1715297763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecRZPEHvExqS79AgCnGYCH1KXuiTZnddDvYfe16C7IA=;
        b=LOC6xAfqTah/f68kfE8ZhSXZbgvxmNw+4CsIHzKEacL/IBF0NEL5/81amG3Vmc0F5e
         +3yPpOHONupnEixdeCXuRX1kaVPGl+QMK++i4m1GC02wJFyiShuXjMY99O8f74YV38es
         uHHWcsvtSypMgkLQysMj2r4KbJ2XTUovpFfNpqtwwLwckzJQrbnfxDBUD4L7GtFBqenG
         5PdzYIAIHWMkmwEB6BrSCqoRQ1mR/QrgekpG79GwYZvUCjTbVo2tGElzC3fxp2+XP7PN
         iembymNbR10U0CnojW4BY87HU7H86/Bx6Sx87iz8QXpeykczIk+I2Pm2iwXoNq6iS/ho
         FVpA==
X-Forwarded-Encrypted: i=1; AJvYcCWO/5UJRrzVcPvbRD6dNi//KGlumCNa1NBtX5oX0rsV0rC4Ec9mWZywN1yGbp1yP9nBdmWrK1pYxzHGzcBoPSKoEQXIQqvjah0tUF4y
X-Gm-Message-State: AOJu0Yx7eKAOos3BLNAAzDZ1cZOp+ygB6VaGe818EFm7FptUsPI/Ma/y
	EL/3Ab2sesXTQfWkznnIna0mOCm0znTsE/s7H0twHTV281F7wdBVGuoiTrJtEeY6+w2f/+cQp6c
	62g==
X-Google-Smtp-Source: AGHT+IH8smrXS8uR5PTJLZQ+0LYn4C/hOdclLpqwTA1bf34fQgFNnBWZMMKNl0IRxZ/fICwotoG+8uya7h8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1788:b0:de5:bc2f:72bb with SMTP id
 ca8-20020a056902178800b00de5bc2f72bbmr179258ybb.12.1714692963300; Thu, 02 May
 2024 16:36:03 -0700 (PDT)
Date: Thu, 2 May 2024 16:36:02 -0700
In-Reply-To: <20240425125252.48963-4-wei.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425125252.48963-1-wei.w.wang@intel.com> <20240425125252.48963-4-wei.w.wang@intel.com>
Message-ID: <ZjQjYiwBg1jGmdUq@google.com>
Subject: Re: [PATCH v3 3/3] KVM: x86/pmu: Add KVM_PMU_CALL() to simplify
 static calls of kvm_pmu_ops
From: Sean Christopherson <seanjc@google.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 25, 2024, Wei Wang wrote:
>  #define KVM_X86_CALL(func) static_call(kvm_x86_##func)
> +#define KVM_PMU_CALL(func) static_call(kvm_x86_pmu_##func)

..

> @@ -796,7 +796,7 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu)
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  
>  	memset(pmu, 0, sizeof(*pmu));
> -	static_call(kvm_x86_pmu_init)(vcpu);
> +	KVM_PMU_CALL(init)(vcpu);
>  	kvm_pmu_refresh(vcpu);

I usually like macros to use CAPS so that they're clearly macros, but in this
case I find the code a bit jarring.  Essentially, I *want* my to be fooled into
thinking it's a function call, because that's really what it is.

So rather than all caps, what if we follow function naming style?  E.g.

	memset(pmu, 0, sizeof(*pmu));
	kvm_pmu_call(init)(vcpu);
	kvm_pmu_refresh(vcpu);

and

	if (lapic_in_kernel(vcpu)) {
		kvm_pmu_call(deliver_pmi)(vcpu);
		kvm_apic_local_deliver(vcpu->arch.apic, APIC_LVTPC);
	}

and

	switch (msr) {
	case MSR_CORE_PERF_GLOBAL_STATUS:
	case MSR_CORE_PERF_GLOBAL_CTRL:
	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
		return kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
	default:
		break;
	}
	return kvm_pmu_call(msr_idx_to_pmc)(vcpu, msr) ||
	       kvm_pmu_call(is_valid_msr)(vcpu, msr);

all are easier for my brain to parse.

