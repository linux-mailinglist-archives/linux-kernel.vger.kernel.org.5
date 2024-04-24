Return-Path: <linux-kernel+bounces-157818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF63D8B16AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046B0B26830
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B7316EBF3;
	Wed, 24 Apr 2024 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="308TfEim"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD116EBE9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999601; cv=none; b=GneY02RgAuo1kIvvBUmbw1m91ijgfyq+1WibON+JkhCHm5T463oAJETkeFvbAY0um4dVvat3C34rmm8jfdaTqEqwcwchrd9SLUau4kRzkiv/9RaouscOu1/cHdgm1gg4b+lREWSql24brbW3aDYhCi0tDvwjZlBZykT2AQ/JW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999601; c=relaxed/simple;
	bh=DqAQEHGDx6EY1b993wyDcxpyd3anFLT4vTfzBQtDgJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BcmCphKd/Cc4ocEPTisVzJFbazy+i1QjxMixWepP7zQhKaeh/13cHZhs/sWn8Ak1Pb428hiMxHNTgukufxYGwiOJ4TicYNPhyQCNseaj6PW4PzYhp8GniK62EMh1cKL1nIAPZC0Krwy92sMSE4q91EXXZlA4flePzzHcf+QaC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=308TfEim; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5f80a77b95cso400593a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713999599; x=1714604399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CPQuZuOq+EB+82vseydeL3MmBIwkyv7t/AeyvUHFOt0=;
        b=308TfEimuLnkpfRVOrYv07ACb1i4MW0YkblfTFvKsAJku8M9LW1prn2LG1ErqAORDm
         jJf6OPI6to43ypEM1jHqaFvzxXvzfpLFiwV6LKeHpmmWITo287h2/dRr7j18XuLRmsjx
         xOtI8BOS+KSXnViqeg2NI0W6dB5chgwVVOWwLh6+MPPBJh7n8fm9ZArELImF17WUTpvv
         JuLM9USYfZ6GSsMCEMd1TG1g7YQSCLaQPF0ffEN0vPlRJXsuN1jSPcqPDmP772Qrty75
         p7nlJZnwT1QewAYyNbGCvCoWzUAVrG60uAknMS3phnMEtn2LAvzjFATtF7c1XdQL7Pv7
         BTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713999599; x=1714604399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPQuZuOq+EB+82vseydeL3MmBIwkyv7t/AeyvUHFOt0=;
        b=LU0cw4zx79CORgki0dxqwJbDdqK4nDylq1dh59EBgy8dfzk5xwZCD+oKCEjzcL4r0j
         5/0R6nTlPsnV9yWI8xQHL3vrPOc6bKcMpIDkr2ZRByn0ZzebvjE6dzF8+YnDUn6bxQPc
         dwPJIHoNmqgufSeIMP8bLmwPV5SMlkvksPWA7ci1aWzhcB28UHHyBsf1lK2adkO9XGC1
         HKxDtQZYf+Bd6x1SaZmFMcCzOCIw2ZZI/Umj++AMmdum31RKXIJ2zvOBdxwc0aeIa3un
         YvwuFIorMMUyR9qyZVezWMsX3NsoEdfwE98iFASG9SfnSyTDSuI/g8P9mZi/ss6zbE75
         yVPQ==
X-Gm-Message-State: AOJu0Yx6DhhKSMuxg/5HLIa2F+ZMWjHg0s8+Mp8fRfvAU+Vbnj1LZnIg
	Yiz6kVsMqMWRa6ES0cIF2dn14t6DQB3FgpSCFhycRWLxdOal9uE90oczBIAZgWf+mrGCb/Ogllp
	I0Q==
X-Google-Smtp-Source: AGHT+IE68lJ7PRaMFcV0k+cqap59rtrBp3DhH1/zb508mWTnJNRitx52m6b+OMU/P0pJH5TF1Mtzl7DxEZM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:4c13:0:b0:5f7:d61e:50e5 with SMTP id
 z19-20020a634c13000000b005f7d61e50e5mr46918pga.6.1713999599325; Wed, 24 Apr
 2024 15:59:59 -0700 (PDT)
Date: Wed, 24 Apr 2024 15:59:57 -0700
In-Reply-To: <ZimI8j9LIUsAArdD@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240404185034.3184582-1-pbonzini@redhat.com> <20240404185034.3184582-8-pbonzini@redhat.com>
 <ZimI8j9LIUsAArdD@google.com>
Message-ID: <ZimO7V2udx8KB2Li@google.com>
Subject: Re: [PATCH 07/11] KVM: guest_memfd: extract __kvm_gmem_get_pfn()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 24, 2024, Sean Christopherson wrote:
> On Thu, Apr 04, 2024, Paolo Bonzini wrote:
> > In preparation for adding a function that walks a set of pages
> > provided by userspace and populates them in a guest_memfd,
> > add a version of kvm_gmem_get_pfn() that has a "bool prepare"
> > argument and passes it down to kvm_gmem_get_folio().
> > 
> > Populating guest memory has to call repeatedly __kvm_gmem_get_pfn()
> > on the same file, so make the new function take struct file*.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  virt/kvm/guest_memfd.c | 38 +++++++++++++++++++++++---------------
> >  1 file changed, 23 insertions(+), 15 deletions(-)
> > 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 486748e65f36..a537a7e63ab5 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -540,33 +540,29 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
> >  	fput(file);
> >  }
> >  
> > -int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> > -		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
> > +static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
> > +		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prepare)
> 
> I genuinely don't know what it means to "prepare" a guest_memfd.  I see it becomes
> 
> 	if (!prepare)
> 		fgp_flags |= FGP_CREAT_ONLY;
> 
> but I find the name "prepare" to be extremely unhelpful.

Ah, I'm blind.  Maybe "do_prepare", or "do_arch_prepare"?  To make it clear that
it's a command, not a description of the operation (which is how I first read it).

And I feel like overloading it to also mean FGP_CREAT_ONLY when _not_ preparing
the memory is odd.

	if (prepare) {
		int r =	kvm_gmem_prepare_folio(inode, index, folio);
		if (r < 0) {
			folio_unlock(folio);
			folio_put(folio);
			return ERR_PTR(r);
		}
	}

Instead of "prepare" as a command, would it make sense to describe the "populating"
case?  Because I think it's more intuitive that populating _needs_ to operate on
new, unprepared data.

