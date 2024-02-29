Return-Path: <linux-kernel+bounces-87657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A183986D70B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D11287A96
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628A44F618;
	Thu, 29 Feb 2024 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XLYhBkij"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CC3200A6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247151; cv=none; b=CL9JgXbsKMcwlmd+v6LWkcc5C88OwcShW6AxNJtf9Gdh56WS/FxexjvnZ0eSs1bUufZD4Sd6TXS7F5fi6rbVADnjolkD/OsNncjx7LNQ1Kem78Z43cFm0bgXA1xd9bGM5PZl8lDXfc+o9P92UaHKLyn35Z3muUnzTTvoxwaL5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247151; c=relaxed/simple;
	bh=ZrdMhzqYQdVQaVyQMzKIUyRaqQBbYvzNxQqR3wlLtso=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GwBObTQd933/J5NoUPTpwdOVNM8K1XOWjdQO93gCKHAANQ31Xicio9HeSaPmZ7q1+7BEO2KYIciw1+4rng9tIci7vn6ZaSsna4ZdeuPLSWMYiXYh4D1szjfk3lZdgCo7rfWN03GhFI2NbE5GzyE1rOS/w0LO9X+maPtIN9CPjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XLYhBkij; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607838c0800so28359147b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709247149; x=1709851949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8b8OCDD09+588UnWikIEKBHdsMfsLEpv8mfk31IU88=;
        b=XLYhBkijZqiDlJOBteNRmr5to2Rt0NtpfhR2gMTj1YP0sGenNWWr1/sR56XrqMZ+jo
         D1QFWrlAn4fLi34fzJQOifPI6PG2/+/5uqIjjeOLFF5qHVj6lpjvydw58hHsXuZGP3l8
         iOOMuMDGgPaJgepZplecwPgPvVkHyODgCdYoXapvKQNtrL0LQ6+jDqnN3aa526nyIZIw
         f2uIMqAO6jwWn7yOp5+Qr7V8f1nAz46kLte8EZne0XTKgB9EYVEbkbow90rMO6HNqW0E
         OeOMg1kjHov8hBOf4cPhUAalx/vpAWQY4UuY2QqmQ6Cho1BQ0OGJXOXPPhk/K1urV87l
         cIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709247149; x=1709851949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8b8OCDD09+588UnWikIEKBHdsMfsLEpv8mfk31IU88=;
        b=wuEq6pUYeZ0SHyEcuJq814dhxIhHXjbGk5AKHsaNCQfITL2ww/DgGEapn4Eq9wrtJK
         H3gAiXvwIu77pk68BpMU9QNuU1ztQ3imaYLk+rheBZ0rgOkZdpNK/ok0IjlEEZ0C0amr
         jJ9Xc93trQTvW7B6QqSy1WhiBDthgqRb4iP7q1cEZRqn67WJQtTTNTMYCI7JzKz8UnIv
         LghyKqEvgZd+KPsPLs2ZfBlhmzj6giz+5CJRGqJ6baRFgqi/4Uvpxo5fzjeyfBaVVH40
         q6YfhNpcoiyFuyKHM1AZMy/rn0NWl3AJHhuwQg7y4o4Bd4jeBD+LM+XOp9px3DHJ+3ui
         5HJA==
X-Forwarded-Encrypted: i=1; AJvYcCUILSFI12wk0DmO9I+iZdeTNAf2Qzrnf+JGcTe6AshhNYJVGCPEGzAkLT7vGrDxyfpu15JjeUB9p8Lv0DXVuqxVwdPrANbNmQe+V6cj
X-Gm-Message-State: AOJu0YwIGL0aw46mlMVRk7p1ITPUUT5/OaLfj6HtWIBS2cfWzLwFgRmJ
	6yIl5cXEKTrxcPYGZJoS3Iu2Qsmf7ts+kwNlkgmQd4ejvJQh7ep6p4KWHnv9p908q0gGBU+9xox
	7Jg==
X-Google-Smtp-Source: AGHT+IHBCnjWsAtWBPKYy1q+64nUvRLb3Lmabh7cpUFJSVLaB7epDdPE7K+iMz8Ell/TC4otKI1nGLa4HCA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:705:b0:dbe:d0a9:2be3 with SMTP id
 k5-20020a056902070500b00dbed0a92be3mr922888ybt.3.1709247149071; Thu, 29 Feb
 2024 14:52:29 -0800 (PST)
Date: Thu, 29 Feb 2024 14:52:27 -0800
In-Reply-To: <d0d5d6b7-218b-4769-9aa7-a393f174410e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-8-seanjc@google.com>
 <d0d5d6b7-218b-4769-9aa7-a393f174410e@intel.com>
Message-ID: <ZeEKq7L8oOqqfknb@google.com>
Subject: Re: [PATCH 07/16] KVM: x86: Move synthetic PFERR_* sanity checks to
 SVM's #NPF handler
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 01, 2024, Kai Huang wrote:
> 
> 
> On 28/02/2024 3:41 pm, Sean Christopherson wrote:
> > Move the sanity check that hardware never sets bits that collide with KVM-
> > define synthetic bits from kvm_mmu_page_fault() to npf_interception(),
> > i.e. make the sanity check #NPF specific.  The legacy #PF path already
> > WARNs if _any_ of bits 63:32 are set, and the error code that comes from
> > VMX's EPT Violatation and Misconfig is 100% synthesized (KVM morphs VMX's
> > EXIT_QUALIFICATION into error code flags).
> > 
> > Add a compile-time assert in the legacy #PF handler to make sure that KVM-
> > define flags are covered by its existing sanity check on the upper bits.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/mmu/mmu.c | 12 +++---------
> >   arch/x86/kvm/svm/svm.c |  9 +++++++++
> >   2 files changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 5d892bd59c97..bd342ebd0809 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -4561,6 +4561,9 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
> >   	if (WARN_ON_ONCE(error_code >> 32))
> >   		error_code = lower_32_bits(error_code);
> > +	/* Ensure the above sanity check also covers KVM-defined flags. */
> > +	BUILD_BUG_ON(lower_32_bits(PFERR_SYNTHETIC_MASK));
> > +
> 
> Could you explain why adding this BUILD_BUG_ON() here, but not ...
> 
> >   	vcpu->arch.l1tf_flush_l1d = true;
> >   	if (!flags) {
> >   		trace_kvm_page_fault(vcpu, fault_address, error_code);
> > @@ -5845,15 +5848,6 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
> >   	int r, emulation_type = EMULTYPE_PF;
> >   	bool direct = vcpu->arch.mmu->root_role.direct;
> > -	/*
> > -	 * WARN if hardware generates a fault with an error code that collides
> > -	 * with KVM-defined sythentic flags.  Clear the flags and continue on,
> > -	 * i.e. don't terminate the VM, as KVM can't possibly be relying on a
> > -	 * flag that KVM doesn't know about.
> > -	 */
> > -	if (WARN_ON_ONCE(error_code & PFERR_SYNTHETIC_MASK))
> > -		error_code &= ~PFERR_SYNTHETIC_MASK;
> > -
> >   	if (WARN_ON_ONCE(!VALID_PAGE(vcpu->arch.mmu->root.hpa)))
> >   		return RET_PF_RETRY;
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index e90b429c84f1..199c4dd8d214 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -2055,6 +2055,15 @@ static int npf_interception(struct kvm_vcpu *vcpu)
> >   	u64 fault_address = svm->vmcb->control.exit_info_2;
> >   	u64 error_code = svm->vmcb->control.exit_info_1;
> > +	/*
> > +	 * WARN if hardware generates a fault with an error code that collides
> > +	 * with KVM-defined sythentic flags.  Clear the flags and continue on,
> > +	 * i.e. don't terminate the VM, as KVM can't possibly be relying on a
> > +	 * flag that KVM doesn't know about.
> > +	 */
> > +	if (WARN_ON_ONCE(error_code & PFERR_SYNTHETIC_MASK))
> > +		error_code &= ~PFERR_SYNTHETIC_MASK;
> > +
> >   	trace_kvm_page_fault(vcpu, fault_address, error_code);
> >   	return kvm_mmu_page_fault(vcpu, fault_address, error_code,
> >   			static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
> 
> ...  in npf_interception() or

The intent of the BUILD_BUG_ON() is to ensure that kvm_handle_page_fault()'s
sanity check that bits 63:32 also serves as a sanity check that hardware doesn't
generate an error code that collides with any of KVM's synthetic flags.

E.g. if we were to add a KVM-defined flag in the lower 32 bits, then the #NPF
path would Just Work, because it already sanity checks all synthetic bits.  But
the #PF path would need new code, thus the BUILD_BUG_ON() to scream that new code
is needed.

> some common place like in kvm_mmu_page_fault()?

Because again, the logic being enforced is very specific to intercepted #PFs.

