Return-Path: <linux-kernel+bounces-94354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8542E873DD9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D151C217B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D6213BAFF;
	Wed,  6 Mar 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+iQYWAB"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BEB5D48F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747877; cv=none; b=Q6r/XvT/f1RRCbbOsEsK28TsUjyAh312voQqKvKeEfI0/VHgSdTQC4WOEnXDQDF7qymXyayfyYbjUScqedQOeyTC6tzp/Q1qjOuIaOZmpZo/EdZ7nfbVAFb/QJv75X8WjR/Qlu5W0MODRYaqOZib8KRXR2OSUjfd9HRjvtVsbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747877; c=relaxed/simple;
	bh=A+RJIboiAiSHzFwIGTG+pLAmV34D1JkjLrbUzmX+ydA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf8PQ7d8bCkyg6OWd2yGeMaFtt+akE3oTEJquMeTDQ46iOBiLhvcb56VE5Ok+oQdaIMC45PSIFPkjIFa/IQ91jl90m3tv7ADcoJqTcFLoTBN7oo1SlVEbDFKF86KRTvlYl9SfJfJl9MzNVUlgx3N0dd2yzLMFNFR9sp0yIqGP04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M+iQYWAB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dcd07252d9so2475ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709747875; x=1710352675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iz/q/61+6k4jv/ntFkhv95Db7Kj6nibuvxIyJnMWHgM=;
        b=M+iQYWABYQxx3v3T4nyuWtRBt8h5ex+I+7LmWfENZcYnLzvEiKzN/AYZqCwYL92SoL
         V4UdPwZTvy6wxx5KH3F2G45RIq14Owcm6swpET7DC7wlpJyHBoSscM23dK04wrJhOx4e
         XxQ6fd7sXJ+g8X9wtQou/V0cEQTfkj0n14bCzThyHFATeiO37HeqeVdBWyHOHRrkyjQc
         iy3ruVkt3GhmLYRKw7fC0i/FMUpvOPvLBI8p7unkdW/Aa6paBj7n+Tfoo4pwSVEsl8qR
         voROmOfcPheFUWKqz6xnWE95AZ0AL9NoYTE1PYx3ZrTdcN1BIbJ9FNnNnoZ+F/Vj+2XO
         13dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709747875; x=1710352675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iz/q/61+6k4jv/ntFkhv95Db7Kj6nibuvxIyJnMWHgM=;
        b=SXhHvpDiISS0IV1SVjiob2rd/MDSsk1s4aBp+j7l3N8d8+6Rx6Dvd7Gk9iHVB2VR2e
         hwULSLYbGDJQQEMcU1ICbsxqWK6pgGC8BLU4E3HJzjD4QbkytOiNM0C6xSJ0p4lmQGbf
         puK8/2cQik8x3o4iNlw+r2rHqU3nvHn4+exyQC/TVajFWnv+2dmSsHKbsyds2UTZM/3D
         IA3BSyA/AE8Mk2W/L+kHNM4X5ipeB0Hpp0SSMEV3zefBcXNO6iK7AzbWmopN5ZRpKwqa
         +cLWZ9GLjzo1hoV3xyhLNVUwl1+2RgZzLDOOCYgMXxabClGmNbCzfqEgqmvof/7h1x4p
         BWoA==
X-Forwarded-Encrypted: i=1; AJvYcCUyr0cZmXcicTXMNEzTTDalRsZVHOi6u/bhre7FEEhb/ljMyQRup4N5w7tqIcVEJAsJvHjDCKrbHpflZOtPLm5PSOJdPqaJ5dRXkC7k
X-Gm-Message-State: AOJu0YyI1OQl+xAMa/S3qS2BM/iL7sdcQHnP8HjUCBREwpX2Ns/M8o52
	8pwtbhWXyqf0aHEWVBFIBUTE/DBsaibKa2NZVHXg3QQh9bfNhQVMDVcsfdUpcq5U2O9j5kstAD1
	uQT+aO7N3K12AEj9RVEKdZDWMIqyTcMffW9DT
X-Google-Smtp-Source: AGHT+IGONinR76McGlcNk+1yKf1YpKero3GD9FraFlLoMGj1RcyafvVPOHQGAkTJt08dI8zLZzKp+OmVcM7sg9VFamY=
X-Received: by 2002:a17:902:684a:b0:1dc:89f6:8b8d with SMTP id
 f10-20020a170902684a00b001dc89f68b8dmr29328pln.5.1709747874585; Wed, 06 Mar
 2024 09:57:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306001511.932348-1-jthoughton@google.com> <Zefl5mJ32IxxYtaF@x1n>
In-Reply-To: <Zefl5mJ32IxxYtaF@x1n>
From: James Houghton <jthoughton@google.com>
Date: Wed, 6 Mar 2024 09:57:17 -0800
Message-ID: <CADrL8HWaeEwoUov9y0weGCTNPffN4nbURDetF_+s2bF+MttKsw@mail.gmail.com>
Subject: Re: [PATCH] mm: Add an explicit smp_wmb() to UFFDIO_CONTINUE
To: Peter Xu <peterx@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 7:41=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Mar 06, 2024 at 12:15:10AM +0000, James Houghton wrote:
> > I've tried to see if I can legitimately get a user to read stale data,
> > and a few attempts with this test[2] have been unsuccessful.
>
> AFAICT that won't easily reproduce even if the problem existed, as we
> contain so many implict memory barriers here and there.  E.g. right at th=
e
> entry of ioctl(), mmget_not_zero() already contains a full ordering
> constraint:
>
> /**
>  * atomic_inc_not_zero() - atomic increment unless zero with full orderin=
g
>  * @v: pointer to atomic_t

Oh yes, of course. Thanks for pointing this out. So we definitely
don't need a Fixes.

>
> I was expecting the syscall routine will guarantee an ordering already bu=
t
> indeed I can't find any.  I also checked up Intel's spec and SYSCALL inst
> document only has one paragraph on ordering:
>
>         Instruction ordering. Instructions following a SYSCALL may be
>         fetched from memory before earlier instructions complete executio=
n,
>         but they will not execute (even speculatively) until all
>         instructions prior to the SYSCALL have completed execution (the
>         later instructions may execute before data stored by the earlier
>         instructions have become globally visible).
>
> I guess it implies a hardware reordering is indeed possible in this case?

That's my understanding as well.

>
> >
> > [1]: commit 153132571f02 ("userfaultfd/shmem: support UFFDIO_CONTINUE f=
or shmem")
> > [2]: https://gist.github.com/48ca/38d0665b0f1a6319a56507dc73a173f9
> >
> >  mm/hugetlb.c     | 15 +++++++++------
> >  mm/userfaultfd.c | 18 ++++++++++++++++++
> >  2 files changed, 27 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index bb17e5c22759..533bf6b2d94d 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6779,12 +6779,15 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
> >               }
> >       }
> >
> > -     /*
> > -      * The memory barrier inside __folio_mark_uptodate makes sure tha=
t
> > -      * preceding stores to the page contents become visible before
> > -      * the set_pte_at() write.
> > -      */
> > -     __folio_mark_uptodate(folio);
> > +     if (!is_continue) {
> > +             /*
> > +              * The memory barrier inside __folio_mark_uptodate makes =
sure
> > +              * that preceding stores to the page contents become visi=
ble
> > +              * before the set_pte_at() write.
> > +              */
> > +             __folio_mark_uptodate(folio);
>
> Can we move the comment above the "if", explaining both conditions?

Yes, I'll do that. I think the explanation for
WARN_ON_ONCE(!folio_test_uptodate(folio)) is:

    We only need to `__folio_mark_uptodate(folio)` if we have
allocated a new folio, and HugeTLB pages will always be Uptodate if
they are in the pagecache.

We could even drop the WARN_ON_ONCE.

>
> > +     } else
> > +             WARN_ON_ONCE(!folio_test_uptodate(folio));
> >
> >       /* Add shared, newly allocated pages to the page cache. */
> >       if (vm_shared && !is_continue) {
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 503ea77c81aa..d515b640ca48 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -531,6 +531,10 @@ static __always_inline ssize_t mfill_atomic_hugetl=
b(
> >                       goto out_unlock;
> >       }
> >
> > +     if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> > +             /* See the comment in mfill_atomic. */
> > +             smp_wmb();
> > +
> >       while (src_addr < src_start + len) {
> >               BUG_ON(dst_addr >=3D dst_start + len);
> >
> > @@ -743,6 +747,20 @@ static __always_inline ssize_t mfill_atomic(struct=
 userfaultfd_ctx *ctx,
> >           uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> >               goto out_unlock;
> >
> > +     if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> > +             /*
> > +              * A caller might reasonably assume that UFFDIO_CONTINUE
> > +              * contains a wmb() to ensure that any writes to the
> > +              * about-to-be-mapped page by the thread doing the
> > +              * UFFDIO_CONTINUE are guaranteed to be visible to subseq=
uent
> > +              * reads of the page through the newly mapped address.
> > +              *
> > +              * For MFILL_ATOMIC_COPY, the wmb() is done for each COPY=
ed
> > +              * page. We can do the wmb() now for CONTINUE as the user=
 has
> > +              * already prepared the page contents.
> > +              */
> > +             smp_wmb();
> > +
>
> Why you did it twice separately?  Can we still share the code?
>
> I'm wildly guessing: I don't worry on an extra wmb() in failure paths, as
> that's never a performance concern to make failure slightly slower, IMHO.

You're right, I shouldn't care so much about making the slow paths a
little bit slower. I'll move the wmb earlier so that we only need it
in one place.

>
> Thanks,

Thanks Peter!

