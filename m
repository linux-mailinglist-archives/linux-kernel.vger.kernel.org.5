Return-Path: <linux-kernel+bounces-37552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C719983B17F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B362881AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3764813175F;
	Wed, 24 Jan 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7+oXeBU"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3F81292FC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122336; cv=none; b=P8NGOWST9RF5eHYobFpWyW21bfIjSWHEWLaFiu7FBEq6H1xgDvdDOma6XELGQlZADEJOY+Pj+2xH9x8G1w4QXY1z+wWuSovLClbDYueGjrPMF9vM5nUS69vh6koVAOmWnt93slff/Dt1D2X2xtfo6L50SOw7+UtoNeRpqJEe/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122336; c=relaxed/simple;
	bh=6TdjO5UfgWZZjNe38ds4eqkhex4saa37TCe+orCZRj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u+NtTOOPkp7VUILU4LUEhF/hfOcBl6ZadtBdRBVYUTazZUC4+WbYY977CXqibSg9MFAf2U2T0vt1b+dwVYIVTdRKR9Tw/LCfdVu1DpGrxAtdkpEsCNiIXRAJl4gpp++Topmlqja9mEOIpPbyd649+zuXbnYjt9qvfRPNYGgwlnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7+oXeBU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc3645c083aso5221129276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706122334; x=1706727134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DeJXI63JE4NpBTBWR+qtr9gFEncQ6Y/JV8zIyVI58iM=;
        b=q7+oXeBU8qQTEM5vlvc6PjXdjLVmJC1sF0xIsI2Zy1xH4bF+FFku/H0v9MHpsFeDUp
         LDsY6zKZOZR13YPdgHskId2eewbODH3SN7k1XAmg4T5YhUR57+Z633fion4BD3bR/ng/
         E4SGJ8JRZV1RqyVhOe26wDC6GWKBtpletTZl/BhwkeataDFlzSWm6+rd9jFGYDuf7Dz+
         n/JP4yTE8pMWEgmVBrXFCtGviPhS/f5MNs+/oH20uSZfNjcADbWIFD8trjx4lLYaZS9k
         4nqMTlSjZc7O10nTo/wuxuOAJoy8oLcK4eLtJ03SjVnChgH99HLTXvHXL9Ll5EukVRAY
         xikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122334; x=1706727134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DeJXI63JE4NpBTBWR+qtr9gFEncQ6Y/JV8zIyVI58iM=;
        b=TL88IStQqV+6p1XBMxLVljVh/hAj70MZzfTuamNsP8xPMrs2Njvh59sEQEkbuV8ATR
         c6MmEtrzwZzAU4aUS41bAvsT5EGMZoFeEmB88aQAEX01UD1e57FKz1059da2sPGEls90
         3axJH7ql+EGZLsLFGTLF6xkxeZhNu5qkLmISjUl56728gHfJKUuOJd6fT1bbnUE0QgVj
         w/bgCK5M7FBgfwg63xJ8c1U7PSwjHZMEvLmsflLONf488lwyexNzAMF65/Gb8z4q4d/p
         VZSCsf7w7gLjMzsLa4rcuh/FVf/E3/jCZTo08mzsyFSXk6P1wqQEO5REhTBUzIHAWZu/
         i6yg==
X-Gm-Message-State: AOJu0YzK4tlDztwazpeDZ3OjwBp6ZIDUVn2ejy2iXFPQnPsM+Z7iyOHw
	3X3ujz7GcbZW1XN53vZvYOaNWwA+6ENlnMfQhW0fHpba+jm4f+l7lXHJIHkypeKhYFErzRcvEeu
	i+Q==
X-Google-Smtp-Source: AGHT+IEAV+1+iqSEN/dEkDSeXdzloc8d7SaECvFvbanSnYtiz5oBCgilhNs0kNWqA3W+IGo3T6P9dYzHyV0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:e10:b0:dc2:45ad:de34 with SMTP id
 df16-20020a0569020e1000b00dc245adde34mr573846ybb.11.1706122333987; Wed, 24
 Jan 2024 10:52:13 -0800 (PST)
Date: Wed, 24 Jan 2024 10:52:12 -0800
In-Reply-To: <Zavj4U2LYeOsnXOh@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240110011533.503302-1-seanjc@google.com> <20240110011533.503302-4-seanjc@google.com>
 <Zavj4U2LYeOsnXOh@yilunxu-OptiPlex-7050>
Message-ID: <ZbFcXB5ctGOMEr22@google.com>
Subject: Re: [PATCH 3/4] KVM: Get reference to VM's address space in the async
 #PF worker
From: Sean Christopherson <seanjc@google.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Jan 20, 2024, Xu Yilun wrote:
> On Tue, Jan 09, 2024 at 05:15:32PM -0800, Sean Christopherson wrote:
> > Get a reference to the target VM's address space in async_pf_execute()
> > instead of gifting a reference from kvm_setup_async_pf().  Keeping the
> > address space alive just to service an async #PF is counter-productive,
> > i.e. if the process is exiting and all vCPUs are dead, then NOT doing
> > get_user_pages_remote() and freeing the address space asap is desirable.
> > 
> > Handling the mm reference entirely within async_pf_execute() also
> > simplifies the async #PF flows as a whole, e.g. it's not immediately
> > obvious when the worker task vs. the vCPU task is responsible for putting
> > the gifted mm reference.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  include/linux/kvm_host.h |  1 -
> >  virt/kvm/async_pf.c      | 32 ++++++++++++++++++--------------
> >  2 files changed, 18 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 7e7fd25b09b3..bbfefd7e612f 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -238,7 +238,6 @@ struct kvm_async_pf {
> >  	struct list_head link;
> >  	struct list_head queue;
> >  	struct kvm_vcpu *vcpu;
> > -	struct mm_struct *mm;
> >  	gpa_t cr2_or_gpa;
> >  	unsigned long addr;
> >  	struct kvm_arch_async_pf arch;
> > diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
> > index d5dc50318aa6..c3f4f351a2ae 100644
> > --- a/virt/kvm/async_pf.c
> > +++ b/virt/kvm/async_pf.c
> > @@ -46,8 +46,8 @@ static void async_pf_execute(struct work_struct *work)
> >  {
> >  	struct kvm_async_pf *apf =
> >  		container_of(work, struct kvm_async_pf, work);
> > -	struct mm_struct *mm = apf->mm;
> >  	struct kvm_vcpu *vcpu = apf->vcpu;
> > +	struct mm_struct *mm = vcpu->kvm->mm;
> >  	unsigned long addr = apf->addr;
> >  	gpa_t cr2_or_gpa = apf->cr2_or_gpa;
> >  	int locked = 1;
> > @@ -56,16 +56,24 @@ static void async_pf_execute(struct work_struct *work)
> >  	might_sleep();
> >  
> >  	/*
> > -	 * This work is run asynchronously to the task which owns
> > -	 * mm and might be done in another context, so we must
> > -	 * access remotely.
> > +	 * Attempt to pin the VM's host address space, and simply skip gup() if
> > +	 * acquiring a pin fail, i.e. if the process is exiting.  Note, KVM
> > +	 * holds a reference to its associated mm_struct until the very end of
> > +	 * kvm_destroy_vm(), i.e. the struct itself won't be freed before this
> > +	 * work item is fully processed.
> >  	 */
> > -	mmap_read_lock(mm);
> > -	get_user_pages_remote(mm, addr, 1, FOLL_WRITE, NULL, &locked);
> > -	if (locked)
> > -		mmap_read_unlock(mm);
> > -	mmput(mm);
> > +	if (mmget_not_zero(mm)) {
> > +		mmap_read_lock(mm);
> > +		get_user_pages_remote(mm, addr, 1, FOLL_WRITE, NULL, &locked);
> > +		if (locked)
> > +			mmap_read_unlock(mm);
> > +		mmput(mm);
> > +	}
> >  
> > +	/*
> > +	 * Notify and kick the vCPU even if faulting in the page failed, e.g.
> 
> How about when the process is exiting? Could we just skip the following?

Maybe?  I'm not opposed to trimming this down even more, but I doubt it will make
much of a difference.  The vCPU can't be running so async_pf.lock shouldn't be
contended, no IPIs will be issued for kicks, etc.  So for this patch at least,
I want to take the most conservative approach while still cleaning up the mm_struct
usage.

> > +	 * so that the vCPU can retry the fault synchronously.
> > +	 */
> >  	if (IS_ENABLED(CONFIG_KVM_ASYNC_PF_SYNC))
> >  		kvm_arch_async_page_present(vcpu, apf);
> >  
> > @@ -129,10 +137,8 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
> >  #ifdef CONFIG_KVM_ASYNC_PF_SYNC
> >  		flush_work(&work->work);
> >  #else
> > -		if (cancel_work_sync(&work->work)) {
> > -			mmput(work->mm);
> > +		if (cancel_work_sync(&work->work))
> >  			kmem_cache_free(async_pf_cache, work);
> > -		}
> >  #endif
> >  		spin_lock(&vcpu->async_pf.lock);
> >  	}
> > @@ -211,8 +217,6 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> >  	work->cr2_or_gpa = cr2_or_gpa;
> >  	work->addr = hva;
> >  	work->arch = *arch;
> > -	work->mm = current->mm;
> > -	mmget(work->mm);
> >  
> >  	INIT_WORK(&work->work, async_pf_execute);
> >  
> > -- 
> > 2.43.0.472.g3155946c3a-goog
> > 

