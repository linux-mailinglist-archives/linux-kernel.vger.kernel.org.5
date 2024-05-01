Return-Path: <linux-kernel+bounces-165819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FF58B91FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CF41F21060
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FEA168AEE;
	Wed,  1 May 2024 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WtOmTfIK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4D13D892
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604860; cv=none; b=rRVv5N8/8aoNKEm+SUhajD7ePLSo2J5DHnr1lnpV+0CRaofr2VD9U8NXAQV+ka5yzr+ZNSq26jukzHOtSSjkp2JFV/SK9vg2VKGmfmsKzrMxrl6ggTVODUUGt4NIOm4m27u5LENmPv9YYAFYQLSQ94A/rGDye0tYsMzoAdHFE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604860; c=relaxed/simple;
	bh=4QDGvas4u9w8udrkJBB6Q7Kg1UUo6G22Iv+BP5EKegM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L51GGWiqup58M721T5DCQr8CuS18xQ5p28oiQcPLwbH5NBNM4+87f5/F91WRVjVp8df3eD1t0FOJp7SopqnMy2zxa0mTcOxQ3G1BkWUJM5tfx5ysgNpfTXzfpDlD7C2poQKe8QlmJuLBV3jj+HBcqvzWxXfVEhCuUAMsoLyXQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WtOmTfIK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bef0accddso43210277b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 16:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714604857; x=1715209657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcfy46ofNDIF08JDPxCSwUXWD3ohxE7j32bndZidSTQ=;
        b=WtOmTfIKE+Pe3nFawO4tn+kdHDia6cl6rWovBhp4cOrEseZqY1+KJOL5UkjpAQr95c
         fGHjIITEdJc8LpdfIGKFxw2pFxDFGa0y7HFAoC3VIFDvENUwoagyS7bMciThMRNttX3c
         vlsBW5HOumKiTWvglqeAETcNzE/zLMQ5xkRKSExamVRvsaoyhc/o/mTLsv0IxruIK2Ax
         5CFSl4DwOHUONLy79liwK5HU+ZkbmUvEzGrxMTHswMx69NMiBQq/4HxNSdLRfS1UuczV
         r4zVnwHtqD4juYdPgCRHfeqVr8oOXIObs0w5DTCtydq5g+UPeqzx685jJelB/Ao6B7lA
         7Fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714604857; x=1715209657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcfy46ofNDIF08JDPxCSwUXWD3ohxE7j32bndZidSTQ=;
        b=f1WnjDzhQeDP+TOfUajKaqyQZQhyH2PIKJQhEGwyowwXhxjkzgV7YnGAWm3OXxRHIY
         UdsEQpPu0f2ZnV9/Wpw7PT4mK2jn9KI2CZttsE3uAEFO/V0iOHfCUfR091yCAxvXmmpE
         xBM6DZ8eUJFiFUvBs8syDe+oDOXU1lSxLWS+C97rWAo7s3YSGTca93U+08ye9IowLbPD
         gYLri+IryWgEhBchZN5oV0aqErdo19/aZI6LCnsXA4qLIj/qfTEsGEkxVIqVwgHGXo9u
         Bysa4tL6xoEn/H1lDFyTopIku4oeO7wmXrkxHMcAvDpUIOIR0XDOkusJj2U81AGb9oaI
         vvRw==
X-Forwarded-Encrypted: i=1; AJvYcCUY2AOctPWsznsb5ggQTcdlai5ahw9AaclVxGq5kNbeOxdb3DoJ/ixa0bVUFBNOmR0KDwbQFDDhplDXIa8B8RI6KUSm6jmHNY6vA5mX
X-Gm-Message-State: AOJu0Yw6vrI0RkJpW35XV17apZkNBamNNFsEKcFndZ5su22xfagaHFbI
	civBVOsOMFRFwEMCcTRDanv15v8XE26nahzSDao+Y8wFjh9lWkIsQbtVK+MbJxXMiJcFrGmrWRF
	uEA==
X-Google-Smtp-Source: AGHT+IEoso9E1EzUZlOXERGVZBES24HUmNdhkCjXroYBDlZzz/sTnYht/qkC0ZK79I1dSTlWsUaLZS+I51w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:e212:0:b0:61b:e2eb:f05 with SMTP id
 l18-20020a0de212000000b0061be2eb0f05mr75358ywe.2.1714604856835; Wed, 01 May
 2024 16:07:36 -0700 (PDT)
Date: Wed, 1 May 2024 16:07:35 -0700
In-Reply-To: <20240219074733.122080-23-weijiang.yang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com> <20240219074733.122080-23-weijiang.yang@intel.com>
Message-ID: <ZjLLNyvbpfemyN5g@google.com>
Subject: Re: [PATCH v10 22/27] KVM: VMX: Set up interception for CET MSRs
From: Sean Christopherson <seanjc@google.com>
To: Yang Weijiang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	chao.gao@intel.com, rick.p.edgecombe@intel.com, mlevitsk@redhat.com, 
	john.allen@amd.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Feb 18, 2024, Yang Weijiang wrote:
> @@ -7767,6 +7771,41 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
>  		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
>  }
>  
> +static void vmx_update_intercept_for_cet_msr(struct kvm_vcpu *vcpu)
> +{
> +	bool incpt;
> +
> +	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
> +		incpt = !guest_cpuid_has(vcpu, X86_FEATURE_SHSTK);
> +
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL0_SSP,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL1_SSP,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL2_SSP,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL3_SSP,
> +					  MSR_TYPE_RW, incpt);
> +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_INT_SSP_TAB,
> +					  MSR_TYPE_RW, incpt);
> +		if (!incpt)
> +			return;

Hmm, I find this is unnecessarily confusing and brittle.  E.g. in the unlikely
event more CET stuff comes along, this lurking return could cause problems.

Why not handle S_CET and U_CET in a single common path?  IMO, this is less error
prone, and more clearly captures the relationship between S/U_CET, SHSTK, and IBT.
Updating MSR intercepts is not a hot path, so the overhead of checking guest CPUID
multiple times should be a non-issue.  And eventually KVM should effectively cache
all of those lookups, i.e. the cost will be negilible.

	bool incpt;

	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
		incpt = !guest_cpuid_has(vcpu, X86_FEATURE_SHSTK);

		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL0_SSP,
					  MSR_TYPE_RW, incpt);
		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL1_SSP,
					  MSR_TYPE_RW, incpt);
		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL2_SSP,
					  MSR_TYPE_RW, incpt);
		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL3_SSP,
					  MSR_TYPE_RW, incpt);
		vmx_set_intercept_for_msr(vcpu, MSR_IA32_INT_SSP_TAB,
					  MSR_TYPE_RW, incpt);
	}

	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK) ||
	    kvm_cpu_cap_has(X86_FEATURE_IBT)) {
		incpt = !guest_cpuid_has(vcpu, X86_FEATURE_IBT) &&
			!guest_cpuid_has(vcpu, X86_FEATURE_SHSTK);

		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET,
					  MSR_TYPE_RW, incpt);
		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET,
					  MSR_TYPE_RW, incpt);
	}

