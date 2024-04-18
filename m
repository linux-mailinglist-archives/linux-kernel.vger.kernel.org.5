Return-Path: <linux-kernel+bounces-149349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBB18A8FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD677282643
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A13C5231;
	Thu, 18 Apr 2024 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIebJ46I"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6514A07
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399518; cv=none; b=a4Mrlm/SH5PHJrkiJJ4tEc0wTIuXQb2ert3zCFraKNeu/ib9lUceilP4kIToFr7Joc4wGQmqid4La8ikJqChoVvj1hBaFWXlll4y4nfJ+iI+zcWClQNwlleCRyV/9pziwhdQeHpq1mni2OvXhUlvWNvJKh8suLLY8a63cI/PpDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399518; c=relaxed/simple;
	bh=bkIKIH1djsPn3R+4/7YLCXNNpKr0xNO2nrEdTMRK0t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3E/9bC4pTy+MCImPHXLXBbbjYe2xA+rxBm4sFns38Bczk7rvY2hEnA//yh1bDg69eQByG+BwX0z1mnkCA6i727cSCA079KwDmvXhkykbGBkTigf90vqs1vS2qeZJSxX5YWL7tNw4m8b1k4MYojuPFUe2TXv2VElUUZl9dz8FKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIebJ46I; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so4277641fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713399515; x=1714004315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZS7fC2PWWS/IdlGtc4NUsJMdrxWdm/lrLaZ1BKKIrA=;
        b=LIebJ46IPKDoxZrOnoet5QgDx7opIgWJ70cwWLCQ7cDekP8y+CB21/IRHiZn6dxx7j
         PI51ugxowOup0S7v7s210DPCoCtK3alK5qHxHdL+g42xA1BsJKM9VyTlaurwGgbDeuDs
         a1+Cg+ixt6zxLbg4d0n0Bat0fturrsdAc3kFEGPxk+HZjCLQOj9DKGbKZg6fg083zTXs
         rCwfBtd3gd+XFGkm9HsQlzFcA7II1GNlMTObnCOYquCeZkJ3JZkNiDQhCVdeoO1fS1aO
         AYwzRz7fPBhmnz/QFlo1lB6gXqBWs12OvsNJbJAABjKrrhfXdiyRsBO8yFRsYdRWYQDc
         BSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713399515; x=1714004315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZS7fC2PWWS/IdlGtc4NUsJMdrxWdm/lrLaZ1BKKIrA=;
        b=LKljSciylpNhXqSCqN2oPPYxZ8Xpl72NqgCu9ziiSq61IP/AydFd/uforbyap15QWO
         ks07OrCsZQtp6iYNcrBA4eRc9rFmMK3m4Zqezl8V5NGO3ELnPL5pCW8j9eo05k//fb0s
         DODPxkEnftV+iC1AXH8bJrwfJtKHSmYnvGSnx83fu5aHVEU/wWbLLyBzm03equha6QNS
         h/+VMHqUqGHSwJh+TqAVSHXLxWvOyKsHuhet8vtgrhME6iazSSfKjbKy5xzBZw/adgD4
         ACHSZut6y25K5JFPiZZpevbUI40IsQ6t3Auo8GtdbMEW2prVM63NcL6MN5X6edLfU+9b
         7AuA==
X-Forwarded-Encrypted: i=1; AJvYcCVukze0G8oKmA56w4sd2K6FzIgkMXM2sfNubrzu0/0ewU/Vz4abHE+JEdZEiYlmI8b8dJRKu+98IBC6NzLlXeOMAxuAJIOtLWxFvCZb
X-Gm-Message-State: AOJu0YxuW0EWmkAZCOzS1dyfdzK5Uja/xkMIu7farMeRRmXDQCT5ByVR
	keOb5m0/n8mUo3knusZ3EqJZLxTpPD4ek/EKzjSl1MG6tTxe7QFiQifZrYOnYpMmI7ezJ3hNoBJ
	BqzKePe56n0VcL8vW6Xwg6asqZq4=
X-Google-Smtp-Source: AGHT+IEBejyDNH6C17XdFAVAdzGc8hwPSw1HZ4W04ORI/5y4zasOKPQlH0VqgPA2yPvRtatffjk1hmQUf3drP2WpGKw=
X-Received: by 2002:a2e:9f11:0:b0:2da:86c7:3b8a with SMTP id
 u17-20020a2e9f11000000b002da86c73b8amr372324ljk.43.1713399514736; Wed, 17 Apr
 2024 17:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417141436.77963-1-ioworker0@gmail.com> <20240417141436.77963-4-ioworker0@gmail.com>
 <cd659e3e-dbe4-4168-8162-64bc02f9cba7@redhat.com>
In-Reply-To: <cd659e3e-dbe4-4168-8162-64bc02f9cba7@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 18 Apr 2024 08:18:23 +0800
Message-ID: <CAK1f24=6weNdHMKf=Q9JwbcShNG0b7bFFh1wFH=q2wDTWKd4Yw@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey David,

Thanks a lot for taking time to review!

On Thu, Apr 18, 2024 at 1:05=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 17.04.24 16:14, Lance Yang wrote:
> > This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
> > (Inspired by David Hildenbrand[2]). We aim to avoid unnecessary folio
> > splitting if the large folio is fully mapped within the target range.
> >
> > If a large folio is locked or shared, or if we fail to split it, we jus=
t
> > leave it in place and advance to the next PTE in the range. But note th=
at
> > the behavior is changed; previously, any failure of this sort would cau=
se
> > the entire operation to give up. As large folios become more common,
> > sticking to the old way could result in wasted opportunities.
> >
> > On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios =
of
> > the same size results in the following runtimes for madvise(MADV_FREE) =
in
> > seconds (shorter is better):
> >
> > Folio Size |   Old    |   New    | Change
> > ------------------------------------------
> >        4KiB | 0.590251 | 0.590259 |    0%
> >       16KiB | 2.990447 | 0.185655 |  -94%
> >       32KiB | 2.547831 | 0.104870 |  -95%
> >       64KiB | 2.457796 | 0.052812 |  -97%
> >      128KiB | 2.281034 | 0.032777 |  -99%
> >      256KiB | 2.230387 | 0.017496 |  -99%
> >      512KiB | 2.189106 | 0.010781 |  -99%
> >     1024KiB | 2.183949 | 0.007753 |  -99%
> >     2048KiB | 0.002799 | 0.002804 |    0%
> >
> > [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm=
com
> > [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redh=
at.com
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
>
> Some of the changes could have been moved into separate patches to ease
> review ;)
>
> At least the folio_pte_batch() change and factoring out some stuff from
> madvise_cold_or_pageout_pte_range(). But see below on the latter.

Thanks for your suggestion! It makes sense to split some of the changes
into separate patches for easier review :)

>
> > ---
> >   mm/internal.h |  12 ++++-
> >   mm/madvise.c  | 141 ++++++++++++++++++++++++++++---------------------=
-
> >   mm/memory.c   |   4 +-
> >   3 files changed, 91 insertions(+), 66 deletions(-)
>
> [...]
>
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index f5e3699e7b54..d6f1889d6308 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -321,6 +321,39 @@ static inline bool can_do_file_pageout(struct vm_a=
rea_struct *vma)
> >              file_permission(vma->vm_file, MAY_WRITE) =3D=3D 0;
> >   }
> >
> > +static inline int madvise_folio_pte_batch(unsigned long addr, unsigned=
 long end,
> > +                                       struct folio *folio, pte_t *pte=
p,
> > +                                       pte_t pte, bool *any_young,
> > +                                       bool *any_dirty)
> > +{
> > +     int max_nr =3D (end - addr) / PAGE_SIZE;
> > +     const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRT=
Y;
>
> Reverse Christmas tree looks nicer ;)

Yep, I understand.

>
> > +
> > +     return folio_pte_batch(folio, addr, ptep, pte, max_nr, fpb_flags,=
 NULL,
> > +                            any_young, any_dirty);
> > +}
> > +
> > +static inline bool madvise_pte_split_folio(struct mm_struct *mm, pmd_t=
 *pmd,
> > +                                        unsigned long addr,
> > +                                        struct folio *folio, pte_t **p=
te,
> > +                                        spinlock_t **ptl)
> > +{
> > +     int err;
> > +
> > +     if (!folio_trylock(folio))
> > +             return false;
> > +
> > +     folio_get(folio);
> > +     pte_unmap_unlock(*pte, *ptl);
> > +     err =3D split_folio(folio);
> > +     folio_unlock(folio);
> > +     folio_put(folio);
> > +
> > +     *pte =3D pte_offset_map_lock(mm, pmd, addr, ptl);
>
> Staring at this helper again, I am really not sure if we should have it.
> Calling semantics are "special" and that pte_t **pte is just ...
> "special" as well ;)
>
> Can we just leave that part as is, in the caller? That would also mean
> less madvise_cold_or_pageout_pte_range() churn ... which i would welcome
> as part of this patch.

Yep, let's leave that part as it is in the caller :)

>
> [...]
>
> > @@ -741,19 +767,10 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
igned long addr,
> >               }
> >
> >               if (pte_young(ptent) || pte_dirty(ptent)) {
> > -                     /*
> > -                      * Some of architecture(ex, PPC) don't update TLB
> > -                      * with set_pte_at and tlb_remove_tlb_entry so fo=
r
> > -                      * the portability, remap the pte with old|clean
> > -                      * after pte clearing.
> > -                      */
> > -                     ptent =3D ptep_get_and_clear_full(mm, addr, pte,
> > -                                                     tlb->fullmm);
> > -
> > -                     ptent =3D pte_mkold(ptent);
> > -                     ptent =3D pte_mkclean(ptent);
> > -                     set_pte_at(mm, addr, pte, ptent);
> > -                     tlb_remove_tlb_entry(tlb, pte, addr);
> > +                     clear_young_dirty_ptes(vma, addr, pte, nr,
> > +                                            CYDP_CLEAR_YOUNG |
> > +                                                    CYDP_CLEAR_DIRTY);
>
> That indent looks odd. I suggest simply having a local variable
>
> const cydp_t cydp_flags =3D CYDP_CLEAR_YOUNG | CYDP_CLEAR_DIRTY;
>
> and then use cydp_flags here that will make this easier to read.

Nice. I'll use cydp_flags here in the next version.

Thanks again for the review!
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

