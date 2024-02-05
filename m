Return-Path: <linux-kernel+bounces-53236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F084A26F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68C81F25C8E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1E048CFD;
	Mon,  5 Feb 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WK8+KSXi"
Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B714878B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157997; cv=none; b=G7sgLZtJMhSSE5WsNlBJfwWtjzXuo7Vy/sbYyhTI1hoEgFPVo7/YXOlvM6PS73bCtZk9UhbaGPZekT6+6lSEZ7cD2w94PoTFT9LH9BcGnTdm/2wkJop8ygTXC5QL3z7lVdOTrOB+sFqfIBR2Fw1jRjserXQnHEdPI/MX01+V7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157997; c=relaxed/simple;
	bh=hTxsNRIaGRjBwJpqKwaNDMab2a4fYA69wIIdAR8tCCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F67zPkS7qYLZj3Y7c2OY+qek4NpcBpODIUx38XYrmQTJ7M8rNr4BZYTJqOpGEzVTL8qmUw0V+ntbS1SUgiynzeLZDkpU9DNPxTZBVUIGzylOLQavsXJj64e6uL7tn1am/8Wcjp/cg8AbgydGnzE5Oxo+OpgeG296su+ilupgEkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WK8+KSXi; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-3bfb92805fbso2893032b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707157994; x=1707762794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6ZPCrlgHUcHY17Dx/9azP9InbsH3BOK0AE11r+Q4/4=;
        b=WK8+KSXimL1AuvCVX0nYehCiSbDp7qRXxCdHBKJtUNXe/hhTR/03gTnuZK/qyqp9vl
         VrB8Edx2Z5fGkxo7zMSeX4bzCNKGdrJkyOcesMRi1dIsZpZwpTEjmu/ly3NOZV6cLfuw
         KTeUGPQU6rME9WeVswHF5ib8jMjZODu5HkC5pLpDdygmFt592+GKkGldCWZhprB4f946
         3oCt/ec7yuzK3NQ0QPsGIymXMMgn7X6bZ8q4YdWoDTtpjuSCMMZP6j4L6A1HC5sCjh3r
         f/YSymFJWnga8UMUnGn/LJeDUdT3HFDflHRyc7O8P6wncxYaPAlymvS3fW4nI/lwAQAA
         HHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157994; x=1707762794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6ZPCrlgHUcHY17Dx/9azP9InbsH3BOK0AE11r+Q4/4=;
        b=hstTyZFtulUpFkUC2o1NYJylgMUKYz+km6lUQgEBhyJ5S6HVejvKkl43x4a+pmAcwR
         2U52rC7Z1lzpY9Po8Y9bhmTYKgyxBiL1GDn5a0HghFfpvapQS8CBlqysqMBT9VfTBWR9
         eYFrkaMKDwUi/kBEX/Hw+XGgUGkBJPGSJsSuWIXU+L4vNI1rrPoE0kqqCNqp3l45wUnW
         YKbTtgY0lPykaF/YehpiWvRQM8/gUbjVbuLarfx+8Soaq5D3HL8abNtIta4+8u73DLku
         uxvJF19VxvV3RHklXDI/TT3jtHq5J6rnb3Rd2OzAvGoHG+gOqs2tbSl6plZtYopl1+xt
         4Dpg==
X-Gm-Message-State: AOJu0YzZ91O3Dk8rE3s16cMVRqSTBogIaOIXucsKKQyXWntVp4ZWCczY
	OG4l+ZaHxAUCaPLebkuJz9Nzk0TPA0v2Z8aHNqxLDyBiv7rwaPArIZpgMNwXY3F3kqE5VjO9Dyb
	lWA==
X-Google-Smtp-Source: AGHT+IFtnmfBtSmrd4IucuU5NkyRfvur5Auy6ZOBw6FDjoMVMNgtnq9HbpzBqE1HYDOpuwt7aoDovxA7+hk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1081:b0:dc6:b7c2:176e with SMTP id
 v1-20020a056902108100b00dc6b7c2176emr1704153ybu.4.1707157653888; Mon, 05 Feb
 2024 10:27:33 -0800 (PST)
Date: Mon, 5 Feb 2024 10:27:32 -0800
In-Reply-To: <ZcAoZ/uZqJHFNfLC@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240203003518.387220-1-seanjc@google.com> <ZcAoZ/uZqJHFNfLC@yzhao56-desk.sh.intel.com>
Message-ID: <ZcEolLQYSlLEVslN@google.com>
Subject: Re: [PATCH v3] KVM: x86/mmu: Retry fault before acquiring mmu_lock if
 mapping is changing
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 05, 2024, Yan Zhao wrote:
> On Fri, Feb 02, 2024 at 04:35:18PM -0800, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 3c193b096b45..8ce9898914f1 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -4415,6 +4415,25 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
> >  	if (unlikely(!fault->slot))
> >  		return kvm_handle_noslot_fault(vcpu, fault, access);
> >  
> > +	/*
> > +	 * Pre-check for a relevant mmu_notifier invalidation event prior to
> > +	 * acquiring mmu_lock.  If there is an in-progress invalidation and the
> > +	 * kernel allows preemption, the invalidation task may drop mmu_lock
> > +	 * and yield in response to mmu_lock being contended, which is *very*
> > +	 * counter-productive as this vCPU can't actually make forward progress
> > +	 * until the invalidation completes.  This "unsafe" check can get false
> > +	 * negatives, i.e. KVM needs to re-check after acquiring mmu_lock.
> > +	 *
> > +	 * Do the pre-check even for non-preemtible kernels, i.e. even if KVM
> > +	 * will never yield mmu_lock in response to contention, as this vCPU is
> > +	 * *guaranteed* to need to retry, i.e. waiting until mmu_lock is held
> > +	 * to detect retry guarantees the worst case latency for the vCPU.
> > +	 */
> > +	if (mmu_invalidate_retry_gfn_unsafe(vcpu->kvm, fault->mmu_seq, fault->gfn)) {
> > +		kvm_release_pfn_clean(fault->pfn);
> > +		return RET_PF_RETRY;
> > +	}
> > +
> Could we also add this pre-check before fault in the pfn? like
> @@ -4404,6 +4404,8 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
> 
>         fault->mmu_seq = vcpu->kvm->mmu_invalidate_seq;
>         smp_rmb();
> +       if (mmu_invalidate_retry_gfn_unsafe(vcpu->kvm, fault->mmu_seq, fault->gfn))
> +               return RET_PF_CONTINUE;
> 
>         ret = __kvm_faultin_pfn(vcpu, fault);
>         if (ret != RET_PF_CONTINUE)
> 
> Though the mmu_seq would be always equal in the check, it can avoid repeated faulting
> and release pfn for vain during a long zap cycle.

Just to be super claer, by "repeated faulting", you mean repeated faulting in the
primary MMU, correct?

Yeah, I agree, that makes sense.  The only question is whether to check before
and after, or only before.  When abusing KSM, I see ~99.5% of all invalidations
being detected before (21.5M out of just over 21.6M).

I think it makes sense to also check after getting the pfn?  The check is super
cheap, especially when there isn't an invalidation event as the checks should all
be quite predictable and cache hot.

> > +/*
> > + * This lockless version of the range-based retry check *must* be paired with a
> > + * call to the locked version after acquiring mmu_lock, i.e. this is safe to
> > + * use only as a pre-check to avoid contending mmu_lock.  This version *will*
> > + * get false negatives and false positives.
> > + */
> > +static inline bool mmu_invalidate_retry_gfn_unsafe(struct kvm *kvm,
> > +						   unsigned long mmu_seq,
> > +						   gfn_t gfn)
> > +{
> > +	/*
> > +	 * Use READ_ONCE() to ensure the in-progress flag and sequence counter
> > +	 * are always read from memory, e.g. so that checking for retry in a
> > +	 * loop won't result in an infinite retry loop.  Don't force loads for
> > +	 * start+end, as the key to avoiding infinite retry loops is observing
> > +	 * the 1=>0 transition of in-progress, i.e. getting false negatives
> > +	 * due to stale start+end values is acceptable.
> > +	 */
> > +	if (unlikely(READ_ONCE(kvm->mmu_invalidate_in_progress)) &&
> > +	    gfn >= kvm->mmu_invalidate_range_start &&
> > +	    gfn < kvm->mmu_invalidate_range_end)
> > +		return true;
> > +
> Is a smp_rmb() before below check better, given this retry is defined in a header
> for all platforms?

No, because the unsafe check very deliberately doesn't provide any ordering
guarantees.  The READ_ONCE() is purely to ensure forward progress.  And trying to
provide ordering for mmu_invalidate_in_progress is rather nonsensical.  The smp_rmb()
in mmu_invalidate_retry() ensures the caller will see a different mmu_invalidate_seq
or an elevated mmu_invalidate_in_progress.

For this code, the order in which mmu_invalidate_seq and mmu_invalidate_in_progress
are checked truly doesn't matter as the range-based checks are will get false
negatives when performed outside of mmu_lock.   And from a correctness perspective,
there are zero constraints on when the checks are performed (beyond the existing
constraints from the earlier smp_rmb() and acquiring mmu_lock).

If an arch wants ordering guarantees, it can simply use mmu_invalidate_retry()
without a gfn, which has the advantage of being safe outside of mmu_lock (the
obvious disadvantage is that it's very imprecise).

