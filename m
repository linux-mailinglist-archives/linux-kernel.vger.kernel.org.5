Return-Path: <linux-kernel+bounces-159528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0674F8B2FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B391F2286A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28EB13A3F3;
	Fri, 26 Apr 2024 05:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHiJhpUQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9747513A271
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110120; cv=none; b=se3Ch48SNNKOJViuVI6fMFbntpFwH/kdFAuMX0qF+NnrwuU0mgFZhyTdtbo4dJE17v87DYMscqb9YF4jNpQYTfm1NO2w4OauK8HWCHoOomR7cJKWYIwzn0x9k+8nz1lHFMXkI+zxLp/CHy0fPFNBSK77itUEyLpwSiqJmvjRcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110120; c=relaxed/simple;
	bh=/gZZY4I/cg5zoFsdRttZGXKzRfhZ+C59J72YZ3qTXWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbMLHg8U+0yMoMtRYciDmJ3mZUqfQGgQzageZV+KCaD2bLqulctE0ep3LXwjlJvFjD+BjaK9JiKxH/2iH+6keviFmM9hOv+8a615p3rOwySt9thbBqFTDQDUF+yy2429ibgxPqlvXM/NGAT6i3KPLGX7ykfsYzByvG5qEbscYy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHiJhpUQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714110117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyfGtTjL0/4BOGlGkObqvS2M4nitmPhPC2paKUGfC20=;
	b=KHiJhpUQAkEbFtkF3F2ddHLthl+2mA3a9w/KRs/43VOEaS/LesYdopdYo63TtVrX3UQysM
	5JcOqyPL6PyhHLsqkQfzJZkEbpQ9RNnr2VYftttk+9lUcqYdDIfgt8lcap+wD9f1o7dmeS
	wGh1pHw3X5jiSeoXjNf2SorBxLMhVIw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-60F_1s2pMF6GTmVY4aXR_w-1; Fri, 26 Apr 2024 01:41:54 -0400
X-MC-Unique: 60F_1s2pMF6GTmVY4aXR_w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-345c686ba9bso1100591f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714110114; x=1714714914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyfGtTjL0/4BOGlGkObqvS2M4nitmPhPC2paKUGfC20=;
        b=AmKclpX5we3jAQ4SAfc0ES2dY3CuNg9kIDg+QLm4yuVgoM/b3bSC9R+udy5AxWrL2g
         CC9P3GQgr0iYKiEHmvWNpI/ovAsolTg3uRomNvaQ6GUkudNqDybnt2oeZts8eZK2oxlk
         990TrGX29nShmDEXuKfj8i/iibPMh8KI2EcmJzSmvjeAdjk2TGJT598ubHvC+I3fH/Je
         ycIZIx17axRKZjGDomHYvj7fNgZrQeXF0k0U5txR38TCiEivnGijVlzTW5NRTPjhbQbG
         NrGJH8PTD3Nor2qKwOGB6t328SubrZFzEnt31dow/htRrNdzYEmiXSOw/Gv6JtpZmPWu
         +Gug==
X-Forwarded-Encrypted: i=1; AJvYcCVJdgsH4z3fSJYbq6ogB7lxGmTDlM9JlBX9G8okkChthUAz+njtjLEip3fT8KxcXpX4VLbYaYgsm9mXZp1LxE1KE1qBfjwclQo4B0xo
X-Gm-Message-State: AOJu0YxgwzGPJzBsreIb9rjcjgZv3MZCroAtX6pmpEw6hjn4cRhrc28E
	yWcKPaewNJ+xaRaKEtwmRNK33G6RIyOZF19AlgE5G8aadDvPb45JmdwK4+ys6crKFhtSEy4ZKML
	+5ivh32x8JmI0j+3UuINaC8LUX6rrUR6CKnWLLkx+ZjEK60YW7TC7qhwWf7RltFnMwZCsLR4cC6
	CMuNeVCYEeVz+eqZke29qpj+ByHPofyQCzDS5W
X-Received: by 2002:a5d:59a8:0:b0:343:f2e0:d507 with SMTP id p8-20020a5d59a8000000b00343f2e0d507mr1239525wrr.41.1714110113853;
        Thu, 25 Apr 2024 22:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBIXyOHDQf5t1J7hEF66tvZIMi3zbHy9WKGQ4R/jeeL+FyjVcaBJV1zMFGs9QljcxrM29xfti0U+Sza+E6tq4=
X-Received: by 2002:a5d:59a8:0:b0:343:f2e0:d507 with SMTP id
 p8-20020a5d59a8000000b00343f2e0d507mr1239519wrr.41.1714110113499; Thu, 25 Apr
 2024 22:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404185034.3184582-1-pbonzini@redhat.com> <20240404185034.3184582-10-pbonzini@redhat.com>
 <20240423235013.GO3596705@ls.amr.corp.intel.com> <ZimGulY6qyxt6ylO@google.com>
 <20240425011248.GP3596705@ls.amr.corp.intel.com> <CABgObfY2TOb6cJnFkpxWjkAmbYSRGkXGx=+-241tRx=OG-yAZQ@mail.gmail.com>
 <Zip-JsAB5TIRDJVl@google.com>
In-Reply-To: <Zip-JsAB5TIRDJVl@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Apr 2024 07:41:42 +0200
Message-ID: <CABgObfaxAd_J5ufr+rOcND=-NWrOzVsvavoaXuFw_cwDd+e9aA@mail.gmail.com>
Subject: Re: [PATCH 09/11] KVM: guest_memfd: Add interface for populating gmem
 pages with user data
To: Sean Christopherson <seanjc@google.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, michael.roth@amd.com, isaku.yamahata@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 6:00=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Apr 25, 2024, Paolo Bonzini wrote:
> > On Thu, Apr 25, 2024 at 3:12=E2=80=AFAM Isaku Yamahata <isaku.yamahata@=
intel.com> wrote:
> > > > >   get_user_pages_fast(source addr)
> > > > >   read_lock(mmu_lock)
> > > > >   kvm_tdp_mmu_get_walk_private_pfn(vcpu, gpa, &pfn);
> > > > >   if the page table doesn't map gpa, error.
> > > > >   TDH.MEM.PAGE.ADD()
> > > > >   TDH.MR.EXTEND()
> > > > >   read_unlock(mmu_lock)
> > > > >   put_page()
> > > >
> > > > Hmm, KVM doesn't _need_ to use invalidate_lock to protect against g=
uest_memfd
> > > > invalidation, but I also don't see why it would cause problems.
> >
> > The invalidate_lock is only needed to operate on the guest_memfd, but
> > it's a rwsem so there are no risks of lock inversion.
> >
> > > > I.e. why not
> > > > take mmu_lock() in TDX's post_populate() implementation?
> > >
> > > We can take the lock.  Because we have already populated the GFN of g=
uest_memfd,
> > > we need to make kvm_gmem_populate() not pass FGP_CREAT_ONLY.  Otherwi=
se we'll
> > > get -EEXIST.
> >
> > I don't understand why TDH.MEM.PAGE.ADD() cannot be called from the
> > post-populate hook. Can the code for TDH.MEM.PAGE.ADD be shared
> > between the memory initialization ioctl and the page fault hook in
> > kvm_x86_ops?
>
> Ah, because TDX is required to pre-fault the memory to establish the S-EP=
T walk,
> and pre-faulting means guest_memfd()
>
> Requiring that guest_memfd not have a page when initializing the guest im=
age
> seems wrong, i.e. I don't think we want FGP_CREAT_ONLY.  And not just bec=
ause I
> am a fan of pre-faulting, I think the semantics are bad.

Ok, fair enough. I wanted to do the once-only test in common code but
since SEV code checks for the RMP I can remove that. One less
headache.

Paolo


