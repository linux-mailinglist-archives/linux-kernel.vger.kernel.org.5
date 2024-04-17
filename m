Return-Path: <linux-kernel+bounces-149251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C01C8A8DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7957A1F2181C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1A0657AF;
	Wed, 17 Apr 2024 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3I4LdPIa"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4D4597B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389073; cv=none; b=R+xetBrXDbxiegtMmIOJ0MOxSxlY+ZGWDz92ZAuPa8CA7k6iecndmt5Lqb6TcCxkMRkIbR8tMkP0SPwsFFKCeguClVmeVp7PF3AqiomrNK3SWnZQWPUOywt35+UdD+6Vil/OR03C2N9eM0kM0nJ4Qh6oJAESk7gq94CkgHGFhZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389073; c=relaxed/simple;
	bh=OqOkAxd0cQZ5gO5CqGgeuKNJjuYT+7iX8RiEjugjRKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a0yaQskB067uA/oVKhPhjqseWIMBw2TIJfgW2qDOEn4DTRAx9n1buDcrMSp+9amTVWh1ZmUNgIsEoln1LHi9VH46vgOqZvu7TgygWOiWKHMH7YsTLABWX+oikJkujKtbYvlW+L2wqi4hSt6Io/sbPZ+2w4napCBtOQnGBCoS6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3I4LdPIa; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a482a2360aso1089387a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713389071; x=1713993871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3d1pIkSQxB5FzWF6keS+07sns3KZwG0+lX38WkXeUMY=;
        b=3I4LdPIasGmclzODEkMHoBzi05IszWoEsEfiCNibjQDna5pc+jDgUbr+USwcdVtdmx
         xYdrZalEBpwNnnYWHqlHRIsXnDn3sL/brAj8nJDSePFgLxmVobIxx72DKY8ACwSOIVnr
         407Wb40GLgZ4AhlIk721hnDKuy+gLOPT8/7sS9C55CZhCf/MVmGPKFIoHHwvDLiLsnJP
         uxhyezw9jLQ/WjNvZcUs/DMDF0g+OFbKxRtVRSNFAu/bKLD6Lu+9m0GJr4gSsLJSbvE/
         sM75NamOU6ZofLUXwCfV2z9bpR9d9HD3qPLuF6ODg88qRVCY6omR+q45g9E//qQy4hRg
         YPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713389071; x=1713993871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3d1pIkSQxB5FzWF6keS+07sns3KZwG0+lX38WkXeUMY=;
        b=qZOiB4dhlhmCBRlrpd9hHtzZ2V0Q9hDLKOw4Sg7dm2sv76RdNJQcrmakDQhzgoUFNP
         qxUq3LfW5cVM9BDUum9JAGIIPYdWeFuBLhDpTjP9I/ZbhFExP4CfiiT3p1KY3ucOENnC
         8U+dsT653iXCq6h++hWGa409yybl5ggDN6hiey1P5kJ7E4tznm6CsBkBVKxDJjPGw9C+
         zI9jdOD6KWrnRzXTrNyZLAEG0+bSzu+5rxbe60sdu2J0KCeB2Z2wjW4CzURuGRidT4CK
         ySn2+UvRRo7yTfFuLVk+z9lF3zEqGFArw93rk3sDDpPNBM7Zr5J7Du2cH5C38Wn8K2xo
         UAKQ==
X-Gm-Message-State: AOJu0Yzbgw4x2bpYQo1TBEiL0KFzApxaFExSL++LW+B6N7mEKqqWyO2H
	cOhQYM4HCpFykO0bxQOXDVRL34Nk45wsTOe7piRteFgTaX1BWTPsocBEQQaplcdXauzMzKb+8UN
	RBg==
X-Google-Smtp-Source: AGHT+IHWt7fa068qPf26LgI99L+apguGazGXPv49GJ4Zmy6mXcrzhcz0eIk4qm9PCKeLcROmRPaCvsgmFxU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:3d4f:b0:2a2:bcae:83c1 with SMTP id
 o15-20020a17090a3d4f00b002a2bcae83c1mr3245pjf.3.1713389071572; Wed, 17 Apr
 2024 14:24:31 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:24:29 -0700
In-Reply-To: <20240417153450.3608097-6-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417153450.3608097-1-pbonzini@redhat.com> <20240417153450.3608097-6-pbonzini@redhat.com>
Message-ID: <ZiA-DQi52hroCSZ8@google.com>
Subject: Re: [PATCH 5/7] KVM: x86/mmu: Introduce kvm_tdp_map_page() to
 populate guest memory
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com, 
	rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 17, 2024, Paolo Bonzini wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Introduce a helper function to call the KVM fault handler.  It allows a new
> ioctl to invoke the KVM fault handler to populate without seeing RET_PF_*
> enums or other KVM MMU internal definitions because RET_PF_* are internal
> to x86 KVM MMU.  The implementation is restricted to two-dimensional paging
> for simplicity.  The shadow paging uses GVA for faulting instead of L1 GPA.
> It makes the API difficult to use.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Message-ID: <9b866a0ae7147f96571c439e75429a03dcb659b6.1712785629.git.isaku.yamahata@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu.h     |  3 +++
>  arch/x86/kvm/mmu/mmu.c | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index e8b620a85627..51ff4f67e115 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -183,6 +183,9 @@ static inline void kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
>  	__kvm_mmu_refresh_passthrough_bits(vcpu, mmu);
>  }
>  
> +int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code,
> +		     u8 *level);
> +
>  /*
>   * Check if a given access (described through the I/D, W/R and U/S bits of a
>   * page fault error code pfec) causes a permission fault with the given PTE
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 7fbcfc97edcc..fb2149d16f8d 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4646,6 +4646,38 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  	return direct_page_fault(vcpu, fault);
>  }
>  
> +int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code,
> +		     u8 *level)

If the return is an overloaded "long", then there's no need for @level, i.e. do
the level=>size conversion in this helper.

> +{
> +	int r;
> +
> +	/* Restrict to TDP page fault. */

Do we want to restrict this to the TDP MMU?  Not for any particular reason, mostly
just to keep moving towards officially deprecating/removing TDP support from the
shadow MMU.

> +	if (vcpu->arch.mmu->page_fault != kvm_tdp_page_fault)
> +		return -EOPNOTSUPP;
> +
> +	r = __kvm_mmu_do_page_fault(vcpu, gpa, error_code, true, NULL, level);
> +	if (r < 0)
> +		return r;
> +
> +	switch (r) {
> +	case RET_PF_RETRY:
> +		return -EAGAIN;
> +
> +	case RET_PF_FIXED:
> +	case RET_PF_SPURIOUS:
> +		return 0;

Going with the "long" idea, this becomes:

		end = (gpa & KVM_HPAGE_MASK(level)) + KVM_HPAGE_SIZE(level);
		return min(size, end - gpa);

though I would vote for a:

		break;

so that the happy path is nicely isolated at the end of the function.

> +
> +	case RET_PF_EMULATE:
> +		return -EINVAL;
> +
> +	case RET_PF_CONTINUE:
> +	case RET_PF_INVALID:
> +	default:
> +		WARN_ON_ONCE(r);
> +		return -EIO;
> +	}
> +}
> +
>  static void nonpaging_init_context(struct kvm_mmu *context)
>  {
>  	context->page_fault = nonpaging_page_fault;
> -- 
> 2.43.0
> 
> 

