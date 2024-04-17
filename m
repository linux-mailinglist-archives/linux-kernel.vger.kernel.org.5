Return-Path: <linux-kernel+bounces-147917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F92E8A7B43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF21B21781
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A732041C78;
	Wed, 17 Apr 2024 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd/cRcby"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C462B9D3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713327232; cv=none; b=hD0pI2DdFuC2vglK25ekzciCXs8E8ZMKy4uxSP05PIs+QbQfxUiw7KTf0xckPsRgFtzE+XolLnp97U6kPYb4jNzm//fFMiwGW+50yj+hDyJsOv9bWqMbZ4w0NvrdgpPvgmg9lfPydK1is/jjqvlYdV9QxzsAd6EbIdTbrBBEzYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713327232; c=relaxed/simple;
	bh=+uz6IdhV2CEK8YkVp8cqx35Tu53jRsaPN/mqFjAWO8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdKFMxokP4hwEE3Pt+PtB1vz+bAmFAetGZzdBuwM3mrMFtF0iOO/1kwvaTzaXReQyGYox4ugmexSD8zjlDD3P8d85Qwe7WiL1FzNLSAiCrdJhvqw0I11A7AHWljAS+1gkU4qt6pkvej/KrqNI5mT3XUBfu5PSTMwMhloqq2wORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd/cRcby; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5194a2cf7c2so184931e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713327229; x=1713932029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEqfKge7MQ1Mw6PledvI7/9N3sbTbHGNwBYkcQt5fec=;
        b=jd/cRcbycUUd3OIGGgcWrunEefmfpON5fPxilhxfucaHN3SP7GEuIb6sAQGmiyPj3W
         wzSHFfTgEN4xaDdP51/E+UVoqJx8icJ3O86quhwAM4QL/qlhqBS7PKKA3doTbVp0sv3Z
         pLpx6FbBN5TBu0z/aJt+5ga1p+ja4vBx9lB2nk5yVvYDTQdef6o3gRcXHheOL8UQBc0u
         Z5URMZy91p2feElgiSgjU1PEvNjSt+hjiMH9OXmSwTnqYtDfkO3Chbc0D646cDnhrIDf
         D72lKG0XZbXfg6LyfFkaSC45q5D4vzeMQcW3nrkAYpSNByueBlji/qJZSAndg3arF140
         om4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713327229; x=1713932029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEqfKge7MQ1Mw6PledvI7/9N3sbTbHGNwBYkcQt5fec=;
        b=lxo3Uhdo09E00eJLvvky38CKzb7jecSjg3zro9f5+XXjqHHH210Wo2hjVAOq87KzrQ
         BQ0oQzyFogGQT0aBBJp+/x2GG+N5yq7lHPkV5BqhwEkgAy91/inJRAYT7A9w7IIIUGoV
         K1Vl2/gZZR8DjmZ2/rxp9tzqKglaRGO2JQEluttpiEQbF/9f82QIq6DzY78LeEpWaIDI
         fQP2hnGDx245VJSdywctMtiLkOYmDPMipvnu9o4IlJU4F6JS/+LE8Ri1z+AY9WpYex68
         YIV5nvwi4wmJaH3ejWJuA9Tp4Awli+bka/z2YEVh/26NGNeCDmT3r9w1sg6C10sWSHX0
         OQiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4a/6KmSuX0IgYcF558qmKwdzMyJNHe5vVkBOyIYOh23dQOZU8QOMNqEhXrnQIrmgBTcT3Ci+PcTlroVlTbC9h3nr0E35nvb2ngG7W
X-Gm-Message-State: AOJu0YyQM3ThZ0PAhTqCnxNfMF0jImYr02d+sZQ2tb2CjOMQn0WXTMge
	k7G3RMe2tw7cIFEFpf3tsH+YjJtm8MknuJuL5Qd5IUt4Uei8m3CpXzNOOwvbWLZnJiAtNR2W/FA
	B9bs2T2Bl7rRx5xBJJLPRaI2031Q=
X-Google-Smtp-Source: AGHT+IFA0QAC0jQwNYVUYeAL9ghcZWctuTIiC8wIocajR135msiyIBXAIbpojWrWryNqi6Z5hHTJ265EnUGHLcyIegk=
X-Received: by 2002:ac2:4c86:0:b0:518:6ea2:a2a3 with SMTP id
 d6-20020ac24c86000000b005186ea2a2a3mr9198678lfl.54.1713327229200; Tue, 16 Apr
 2024 21:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416033457.32154-1-ioworker0@gmail.com> <20240416033457.32154-2-ioworker0@gmail.com>
 <3c4b1711-5a84-4e7a-b54a-d4955d62ec59@arm.com>
In-Reply-To: <3c4b1711-5a84-4e7a-b54a-d4955d62ec59@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 17 Apr 2024 12:13:37 +0800
Message-ID: <CAK1f24n-tZm=fmkmxU3j8FqBsgUfH9ZfzEwVW6xaEjFQ5_mqyw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] mm/madvise: introduce clear_young_dirty_ptes()
 batch helper
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 12:25=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 16/04/2024 04:34, Lance Yang wrote:
> > This commit introduces clear_young_dirty_ptes() to replace mkold_ptes()=
.
> > By doing so, we can use the same function for both use cases
> > (madvise_pageout and madvise_free), and it also provides the flexibilit=
y
> > to only clear the dirty flag in the future if needed.
> >
> > Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Hey Ryan,

Thanks for taking time to review!

Best,
Lance

>
> > ---
> >  include/linux/mm_types.h |  9 +++++
> >  include/linux/pgtable.h  | 74 ++++++++++++++++++++++++----------------
> >  mm/madvise.c             |  3 +-
> >  3 files changed, 55 insertions(+), 31 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index c432add95913..28822cd65d2a 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1367,6 +1367,15 @@ enum fault_flag {
> >
> >  typedef unsigned int __bitwise zap_flags_t;
> >
> > +/* Flags for clear_young_dirty_ptes(). */
> > +typedef int __bitwise cydp_t;
> > +
> > +/* Clear the access bit */
> > +#define CYDP_CLEAR_YOUNG             ((__force cydp_t)BIT(0))
> > +
> > +/* Clear the dirty bit */
> > +#define CYDP_CLEAR_DIRTY             ((__force cydp_t)BIT(1))
> > +
> >  /*
> >   * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with=
 each
> >   * other. Here is what they mean, and how to use them:
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index e2f45e22a6d1..18019f037bae 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -361,36 +361,6 @@ static inline int ptep_test_and_clear_young(struct=
 vm_area_struct *vma,
> >  }
> >  #endif
> >
> > -#ifndef mkold_ptes
> > -/**
> > - * mkold_ptes - Mark PTEs that map consecutive pages of the same folio=
 as old.
> > - * @vma: VMA the pages are mapped into.
> > - * @addr: Address the first page is mapped at.
> > - * @ptep: Page table pointer for the first entry.
> > - * @nr: Number of entries to mark old.
> > - *
> > - * May be overridden by the architecture; otherwise, implemented as a =
simple
> > - * loop over ptep_test_and_clear_young().
> > - *
> > - * Note that PTE bits in the PTE range besides the PFN can differ. For=
 example,
> > - * some PTEs might be write-protected.
> > - *
> > - * Context: The caller holds the page table lock.  The PTEs map consec=
utive
> > - * pages that belong to the same folio.  The PTEs are all in the same =
PMD.
> > - */
> > -static inline void mkold_ptes(struct vm_area_struct *vma, unsigned lon=
g addr,
> > -             pte_t *ptep, unsigned int nr)
> > -{
> > -     for (;;) {
> > -             ptep_test_and_clear_young(vma, addr, ptep);
> > -             if (--nr =3D=3D 0)
> > -                     break;
> > -             ptep++;
> > -             addr +=3D PAGE_SIZE;
> > -     }
> > -}
> > -#endif
> > -
> >  #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NO=
NLEAF_PMD_YOUNG)
> >  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma=
,
> > @@ -489,6 +459,50 @@ static inline pte_t ptep_get_and_clear(struct mm_s=
truct *mm,
> >  }
> >  #endif
> >
> > +#ifndef clear_young_dirty_ptes
> > +/**
> > + * clear_young_dirty_ptes - Mark PTEs that map consecutive pages of th=
e
> > + *           same folio as old/clean.
> > + * @mm: Address space the pages are mapped into.
> > + * @addr: Address the first page is mapped at.
> > + * @ptep: Page table pointer for the first entry.
> > + * @nr: Number of entries to mark old/clean.
> > + * @flags: Flags to modify the PTE batch semantics.
> > + *
> > + * May be overridden by the architecture; otherwise, implemented by
> > + * get_and_clear/modify/set for each pte in the range.
> > + *
> > + * Note that PTE bits in the PTE range besides the PFN can differ. For=
 example,
> > + * some PTEs might be write-protected.
> > + *
> > + * Context: The caller holds the page table lock.  The PTEs map consec=
utive
> > + * pages that belong to the same folio.  The PTEs are all in the same =
PMD.
> > + */
> > +static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
> > +                                       unsigned long addr, pte_t *ptep=
,
> > +                                       unsigned int nr, cydp_t flags)
> > +{
> > +     pte_t pte;
> > +
> > +     for (;;) {
> > +             if (flags =3D=3D CYDP_CLEAR_YOUNG)
> > +                     ptep_test_and_clear_young(vma, addr, ptep);
> > +             else {
> > +                     pte =3D ptep_get_and_clear(vma->vm_mm, addr, ptep=
);
> > +                     if (flags & CYDP_CLEAR_YOUNG)
> > +                             pte =3D pte_mkold(pte);
> > +                     if (flags & CYDP_CLEAR_DIRTY)
> > +                             pte =3D pte_mkclean(pte);
> > +                     set_pte_at(vma->vm_mm, addr, ptep, pte);
> > +             }
> > +             if (--nr =3D=3D 0)
> > +                     break;
> > +             ptep++;
> > +             addr +=3D PAGE_SIZE;
> > +     }
> > +}
> > +#endif
> > +
> >  static inline void ptep_clear(struct mm_struct *mm, unsigned long addr=
,
> >                             pte_t *ptep)
> >  {
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index f59169888b8e..edb592adb749 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -507,7 +507,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
> >                       continue;
> >
> >               if (!pageout && pte_young(ptent)) {
> > -                     mkold_ptes(vma, addr, pte, nr);
> > +                     clear_young_dirty_ptes(vma, addr, pte, nr,
> > +                                            CYDP_CLEAR_YOUNG);
> >                       tlb_remove_tlb_entries(tlb, pte, nr, addr);
> >               }
> >
>

