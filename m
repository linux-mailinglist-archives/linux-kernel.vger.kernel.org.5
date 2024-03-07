Return-Path: <linux-kernel+bounces-94777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BA687451D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11A91F25E5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6314C800;
	Thu,  7 Mar 2024 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGCNzgAp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D7137E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709771016; cv=none; b=U+9BQXjIa5EWosJBhrpGDV3ESbOZtRp8J84D+6rxcSBaV0BFgcl9oKuouUj+vOcLWSoMWLIiwTCCQammyoCUHJFwyK/Nl6/idBFtIJTckiVT+enQYHHzdLsPj3oU7f7kH5CW01bRupvz9zMO8iKHA5ZWIFa9BRLzkct/9SSklmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709771016; c=relaxed/simple;
	bh=Jy+xLG47s7rT+wQG0iu82UhoDeP2Mj1X5KLh74r33BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnXKHnPKcfCnE900+CUDvdIbAQRUKioG71Ql/486NRCXpMIU7YQuTmTWpnuEGly0GxqFmJaGxLxYOzmtGV77BOKlOZt0WfnEqZ3XQRv0gn3hGBcvFPT2RGv+lj3ZuMIxC2z6QuotzOqdAZx+aOAi00WsL7tOYF7TXPrJ5avhfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGCNzgAp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709771013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCES2kaXYWvEX1DXjcfkz3runp0pMNuB+6tHKRWiSvE=;
	b=CGCNzgApJyZ1Vudx09akenBdY+NvprT7dV4tCSHq16zBlw/guLjUqQWp2vBxIytDmMhsHW
	F2m6YGpvKTEwU/ImdV6YT/DOUrIT4v7bPzBfuRc1XBx9t8YDGkdwSgHJKOIvk1lnotlUQa
	vxFWc9BSNzz4RW93+AFjIh5MDuWS3SY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-Mp-GgcAhOSuFVKnY21RzLA-1; Wed, 06 Mar 2024 19:23:32 -0500
X-MC-Unique: Mp-GgcAhOSuFVKnY21RzLA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c683944ab0so83770a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 16:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709771011; x=1710375811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCES2kaXYWvEX1DXjcfkz3runp0pMNuB+6tHKRWiSvE=;
        b=bEi/FwJLEieBDhI5oNjiHxdHvEVAxnir0Vpk6Kok2NXubBrivWsqv38sX0vh5co34H
         i15aZGdU5SNCcJbnYdR+7sqg99mBNE/HzmvzprCwGj2AyGY+RlIf3sH5ucXCFGB8TAdL
         uJFNUMjxk94ntSjYIdPM8Ubp60F4J4qQzQN7K4GwwtfHDte3pGRrS5LMK6FkfYyjN6g4
         caOpZSAlbgNC9dl1COEn/76BL7howt8VfU4yF/5vKF6o1V5NxmhDeP46nkD3cqVQm4aK
         jIaEyi7A3Hcz2Soo18XKAS7f6w+VHLN+ZihuckoTzUXn0BxMBBwm7J+grKUfgK0RjNjP
         NzJw==
X-Forwarded-Encrypted: i=1; AJvYcCUZIyndU+vsNn7DYClWqfd6wP42DiQZD7BoDd1n5hV/f4/kl+K57p4ueupMeXXCYdRZCnLvk3XKJMBUXHzNHgoGIEah1pKlvWEhYyVT
X-Gm-Message-State: AOJu0YyjoOKQvNKv+L4xRpoaGQKZEpwXWGMJAgSWaxPrjpHJbvnOGeHd
	zd6XDNCf2q1B9Bf/J/zMwwxzxrkB7gTI4njcFuPCsbQ+t+POp2d9e5d/+L5WS6bjUMKsMoVyR99
	F+ClSs578zy7tOEeJll9kYwQnv7B9I9DS3wT79NxIu6wVjBPnkFZcwj2JdWiaHg==
X-Received: by 2002:a05:6a00:178e:b0:6e6:5574:17fe with SMTP id s14-20020a056a00178e00b006e6557417femr715257pfg.2.1709771010963;
        Wed, 06 Mar 2024 16:23:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE29oJb8+FlW3bA6qi0i5kybdj0/VJbREt+Tai6bog6Vub1H9UY05blOcWw9vPqOf2NBpHyeQ==
X-Received: by 2002:a05:6a00:178e:b0:6e6:5574:17fe with SMTP id s14-20020a056a00178e00b006e6557417femr715237pfg.2.1709771010542;
        Wed, 06 Mar 2024 16:23:30 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j1-20020a62b601000000b006e64370ace9sm3065918pff.195.2024.03.06.16.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 16:23:30 -0800 (PST)
Date: Thu, 7 Mar 2024 08:23:23 +0800
From: Peter Xu <peterx@redhat.com>
To: James Houghton <jthoughton@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Add an explicit smp_wmb() to UFFDIO_CONTINUE
Message-ID: <ZekI-xKsAje9hvS6@x1n>
References: <20240306001511.932348-1-jthoughton@google.com>
 <Zefl5mJ32IxxYtaF@x1n>
 <CADrL8HWaeEwoUov9y0weGCTNPffN4nbURDetF_+s2bF+MttKsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HWaeEwoUov9y0weGCTNPffN4nbURDetF_+s2bF+MttKsw@mail.gmail.com>

On Wed, Mar 06, 2024 at 09:57:17AM -0800, James Houghton wrote:
> On Tue, Mar 5, 2024 at 7:41 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Mar 06, 2024 at 12:15:10AM +0000, James Houghton wrote:
> > > I've tried to see if I can legitimately get a user to read stale data,
> > > and a few attempts with this test[2] have been unsuccessful.
> >
> > AFAICT that won't easily reproduce even if the problem existed, as we
> > contain so many implict memory barriers here and there.  E.g. right at the
> > entry of ioctl(), mmget_not_zero() already contains a full ordering
> > constraint:
> >
> > /**
> >  * atomic_inc_not_zero() - atomic increment unless zero with full ordering
> >  * @v: pointer to atomic_t
> 
> Oh yes, of course. Thanks for pointing this out. So we definitely
> don't need a Fixes.
> 
> >
> > I was expecting the syscall routine will guarantee an ordering already but
> > indeed I can't find any.  I also checked up Intel's spec and SYSCALL inst
> > document only has one paragraph on ordering:
> >
> >         Instruction ordering. Instructions following a SYSCALL may be
> >         fetched from memory before earlier instructions complete execution,
> >         but they will not execute (even speculatively) until all
> >         instructions prior to the SYSCALL have completed execution (the
> >         later instructions may execute before data stored by the earlier
> >         instructions have become globally visible).
> >
> > I guess it implies a hardware reordering is indeed possible in this case?
> 
> That's my understanding as well.

Let's also mention that in the commit message when repost? Just in case
it'll answer other readers when they read this patch.

> 
> >
> > >
> > > [1]: commit 153132571f02 ("userfaultfd/shmem: support UFFDIO_CONTINUE for shmem")
> > > [2]: https://gist.github.com/48ca/38d0665b0f1a6319a56507dc73a173f9
> > >
> > >  mm/hugetlb.c     | 15 +++++++++------
> > >  mm/userfaultfd.c | 18 ++++++++++++++++++
> > >  2 files changed, 27 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index bb17e5c22759..533bf6b2d94d 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -6779,12 +6779,15 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
> > >               }
> > >       }
> > >
> > > -     /*
> > > -      * The memory barrier inside __folio_mark_uptodate makes sure that
> > > -      * preceding stores to the page contents become visible before
> > > -      * the set_pte_at() write.
> > > -      */
> > > -     __folio_mark_uptodate(folio);
> > > +     if (!is_continue) {
> > > +             /*
> > > +              * The memory barrier inside __folio_mark_uptodate makes sure
> > > +              * that preceding stores to the page contents become visible
> > > +              * before the set_pte_at() write.
> > > +              */
> > > +             __folio_mark_uptodate(folio);
> >
> > Can we move the comment above the "if", explaining both conditions?
> 
> Yes, I'll do that. I think the explanation for
> WARN_ON_ONCE(!folio_test_uptodate(folio)) is:
> 
>     We only need to `__folio_mark_uptodate(folio)` if we have
> allocated a new folio, and HugeTLB pages will always be Uptodate if
> they are in the pagecache.
> 
> We could even drop the WARN_ON_ONCE.

No strong opinions, keeping it still makes sense to me.  Btw, it'll also be
important to document "how is the ordering guaranteed for CONTINUE", then
you can reference the new code you add, as readers can get confused on why
CONTINUE doesn't need such ordering.

Thanks,

-- 
Peter Xu


