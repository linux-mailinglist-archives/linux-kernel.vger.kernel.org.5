Return-Path: <linux-kernel+bounces-140467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFBF8A1502
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7719E1F235CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541E014C5A0;
	Thu, 11 Apr 2024 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4c+X6Gb"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6413D638
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839619; cv=none; b=l0GjLlD/hi7gT3LBN7SjGbH9ytwIVa6zZMbbsWkGu/Hc6K+flj7MlnSY9MzRSsWspvmAl/wWd8CHtiMUIDEuWewhfNfSkkeFNpFzXwtpcIeQFJa/wpWymtSd/nq8vyWsP4fqt7s6gr43dmZNFtlnpz6JjCosdUZGyffOjFl5IKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839619; c=relaxed/simple;
	bh=jua1rZA252piZ/1zPi5Hx2RBad6Q64W9kOTXEMMRmyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kY9VqbIBh3wlnAskjHS0AmV3SJ7UIGCBHKOa3FSc7x792/FRBTIqyIThA3m77AUJ5pki1u6pacu47+pWXzWd+sOoYcS1cQ0eHga6lmkJq0ZFmbk02tbRQo5RH0DBr7njWPryCpi7WcjmNU7geEVhjVi23nfVVXGEVt9rxEPpDgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4c+X6Gb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a522c00ce55so24027966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712839615; x=1713444415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpIN/oe251dQdk+11Tq2j0spT/wKyDbFMGp96y9QdMY=;
        b=W4c+X6Gbr7b8xL5Tn6fOX5EsKPqKzW5t2uG/XCthofS29A/PyMzhsp7m6iAKj2iquD
         qI/VYelTlJbp4WcEcS59fipln2sZOE8Su1Q7eXW4LcHxxqRIPF7aKxeKEldFjsX+BuqV
         bQuaKEcFUQQbsZd/n1kS+UNpaKqYRqrAIaWfqrkFP8xDJ/OQHGh6rH+mRLtCg3UJ4ow0
         3uzHt4FX93nK/O1bbsJ3znUgQKWS1MeHZeynUy9HIAM4IndjBk7Zl8EkGwNkVBHPXzVA
         9XMGtzslYoKv+mk08z/1v7NMpLINqWQreCgvFSYWKOilLU6+pYdRsYPrKJHYQJjyEiIy
         h0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712839615; x=1713444415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpIN/oe251dQdk+11Tq2j0spT/wKyDbFMGp96y9QdMY=;
        b=n0CmXErZPlesIXgGDmgRb0SVvJb7SjtR1iisFuHDSNCAE/PB8slGFAq3lgsW49FZhC
         ilQjH/JB9CldBe9Yxe3+RP4RRXVvBD4yfguzj42LmEIQ1Cjx1TwgXJmjyRLyqT+i1bMc
         2opfw7tsYGzP5eOIlWIhFyORKDXTuNKlS/oAhC4uDTdGiKlqWURmC7I3mRdOIqpbHGGz
         r9t3andjh8iZLiuY9shI8fqSuHU6yzFdpJ23qHg3q30ICEca7I65pnYCiK+Fp2NxC0Oh
         NnfgSV6d3sE64ki8WXkM3FtvF6hRgHr0LLfgl+ymsfIiHo4PY0QZmxTzh/Od8nfV8ytq
         GOmg==
X-Forwarded-Encrypted: i=1; AJvYcCXrfpRRpRUbBhpPw87ltrQ03eVK8V+jGS2AnCz8T1zxMWjzqFLxEyPXxPB+4kAS96UQZMaXNycS6+ICbPr3ktKIyLc5EQRdygc3k933
X-Gm-Message-State: AOJu0YzmnVwgnOyVMMz8aJPvOGkoL4RffXXo8OLbx3Iz65vlycRgGNYH
	yXrn2SO1o0ZmY1K4uU8+zK93P3GeVWUfcXMyUXkAR/TFKwWtM2dfrnV6w+QlYWHY3UkP97W9Q8s
	9qPyn3JJmNxz3EQlIHGNyopL5O1Q=
X-Google-Smtp-Source: AGHT+IGIibNsbnvHb0rYMKt6CKnZKVPtOGxuVkTGaVO+y3GaOYPdTS+PaL8kEXS9LHaeOWe/gaHDBLc769ysgZO5DV8=
X-Received: by 2002:a17:907:d2a:b0:a52:1a82:7d3b with SMTP id
 gn42-20020a1709070d2a00b00a521a827d3bmr2353932ejc.0.1712839615480; Thu, 11
 Apr 2024 05:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408042437.10951-1-ioworker0@gmail.com> <20240408042437.10951-2-ioworker0@gmail.com>
 <38c4add8-53a2-49ca-9f1b-f62c2ee3e764@arm.com>
In-Reply-To: <38c4add8-53a2-49ca-9f1b-f62c2ee3e764@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 11 Apr 2024 20:46:43 +0800
Message-ID: <CAK1f24kh-vN3_6ZLUZWXu_g1UOPBuoVXq2jsnx_GBbGFXyXRFQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 7:11=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 08/04/2024 05:24, Lance Yang wrote:
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
> >       4KiB | 0.590251 | 0.590259 |    0%
> >      16KiB | 2.990447 | 0.185655 |  -94%
> >      32KiB | 2.547831 | 0.104870 |  -95%
> >      64KiB | 2.457796 | 0.052812 |  -97%
> >     128KiB | 2.281034 | 0.032777 |  -99%
> >     256KiB | 2.230387 | 0.017496 |  -99%
> >     512KiB | 2.189106 | 0.010781 |  -99%
> >    1024KiB | 2.183949 | 0.007753 |  -99%
> >    2048KiB | 0.002799 | 0.002804 |    0%
> >
> > [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm=
com
> > [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redh=
at.com
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  include/linux/pgtable.h |  34 +++++++++
> >  mm/internal.h           |  12 +++-
> >  mm/madvise.c            | 149 ++++++++++++++++++++++------------------
> >  mm/memory.c             |   4 +-
> >  4 files changed, 129 insertions(+), 70 deletions(-)
> >
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 0f4b2faa1d71..4dd442787420 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -489,6 +489,40 @@ static inline pte_t ptep_get_and_clear(struct mm_s=
truct *mm,
> >  }
> >  #endif
> >
> > +#ifndef mkold_clean_ptes
> > +/**
> > + * mkold_clean_ptes - Mark PTEs that map consecutive pages of the same=
 folio
> > + *           as old and clean.
> > + * @mm: Address space the pages are mapped into.
> > + * @addr: Address the first page is mapped at.
> > + * @ptep: Page table pointer for the first entry.
> > + * @nr: Number of entries to mark old and clean.
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
> > +static inline void mkold_clean_ptes(struct mm_struct *mm, unsigned lon=
g addr,
> > +                                 pte_t *ptep, unsigned int nr)
>
> Just thinking out loud, I wonder if it would be cleaner to convert mkold_=
ptes()
> (which I added as part of swap-out) to something like:
>
> clear_young_dirty_ptes(struct mm_struct *mm, unsigned long addr,
>                        pte_t *ptep, unsigned int nr,
>                        bool clear_young, bool clear_dirty);
>
> Then we can use the same function for both use cases and also have the ab=
ility
> to only clear dirty in future if we ever need it. The other advantage is =
that we
> only need to plumb a single function down the arm64 arch code. As it curr=
ently
> stands, those 2 functions would be duplicating most of their code.
>
> Generated code would still be the same since I'd expect the callsites to =
be
> passing in constants for clear_young and clear_dirty.
>
> > +{
> > +     pte_t pte;
> > +
> > +     for (;;) {
> > +             pte =3D ptep_get_and_clear(mm, addr, ptep);
> > +             set_pte_at(mm, addr, ptep, pte_mkclean(pte_mkold(pte)));
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
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 57c1055d5568..792a9baf0d14 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -132,6 +132,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_t=
 pte, fpb_t flags)
> >   *             first one is writable.
> >   * @any_young: Optional pointer to indicate whether any entry except t=
he
> >   *             first one is young.
> > + * @any_dirty: Optional pointer to indicate whether any entry except t=
he
> > + *             first one is dirty.
> >   *
> >   * Detect a PTE batch: consecutive (present) PTEs that map consecutive
> >   * pages of the same large folio.
> > @@ -147,18 +149,20 @@ static inline pte_t __pte_batch_clear_ignored(pte=
_t pte, fpb_t flags)
> >   */
> >  static inline int folio_pte_batch(struct folio *folio, unsigned long a=
ddr,
> >               pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> > -             bool *any_writable, bool *any_young)
> > +             bool *any_writable, bool *any_young, bool *any_dirty)
> >  {
> >       unsigned long folio_end_pfn =3D folio_pfn(folio) + folio_nr_pages=
(folio);
> >       const pte_t *end_ptep =3D start_ptep + max_nr;
> >       pte_t expected_pte, *ptep;
> > -     bool writable, young;
> > +     bool writable, young, dirty;
> >       int nr;
> >
> >       if (any_writable)
> >               *any_writable =3D false;
> >       if (any_young)
> >               *any_young =3D false;
> > +     if (any_dirty)
> > +             *any_dirty =3D false;
> >
> >       VM_WARN_ON_FOLIO(!pte_present(pte), folio);
> >       VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
> > @@ -174,6 +178,8 @@ static inline int folio_pte_batch(struct folio *fol=
io, unsigned long addr,
> >                       writable =3D !!pte_write(pte);
> >               if (any_young)
> >                       young =3D !!pte_young(pte);
> > +             if (any_dirty)
> > +                     dirty =3D !!pte_dirty(pte);
> >               pte =3D __pte_batch_clear_ignored(pte, flags);
> >
> >               if (!pte_same(pte, expected_pte))
> > @@ -191,6 +197,8 @@ static inline int folio_pte_batch(struct folio *fol=
io, unsigned long addr,
> >                       *any_writable |=3D writable;
> >               if (any_young)
> >                       *any_young |=3D young;
> > +             if (any_dirty)
> > +                     *any_dirty |=3D dirty;
> >
> >               nr =3D pte_batch_hint(ptep, pte);
> >               expected_pte =3D pte_advance_pfn(expected_pte, nr);
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index bf26cf2b7715..0777df2e3691 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -321,6 +321,39 @@ static inline bool can_do_file_pageout(struct vm_a=
rea_struct *vma)
> >              file_permission(vma->vm_file, MAY_WRITE) =3D=3D 0;
> >  }
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
> > +
> > +     return err =3D=3D 0;
> > +}
> > +
> >  static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >                               unsigned long addr, unsigned long end,
> >                               struct mm_walk *walk)
> > @@ -456,41 +489,29 @@ static int madvise_cold_or_pageout_pte_range(pmd_=
t *pmd,
> >                * next pte in the range.
> >                */
> >               if (folio_test_large(folio)) {
> > -                     const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY |
> > -                                             FPB_IGNORE_SOFT_DIRTY;
> > -                     int max_nr =3D (end - addr) / PAGE_SIZE;
> >                       bool any_young;
> > -
>
> nit: there should be a blank line between variable declarations and follo=
wing
> code. You have removed it here (and similar in free function). Did you ru=
n
> checkpatch.pl? It would have caught these things.

Sorry for that. I did see this warning msg, but I didn't take it seriously =
:(

>
> > -                     nr =3D folio_pte_batch(folio, addr, pte, ptent, m=
ax_nr,
> > -                                          fpb_flags, NULL, &any_young)=
;
> > -                     if (any_young)
> > -                             ptent =3D pte_mkyoung(ptent);
> > +                     nr =3D madvise_folio_pte_batch(addr, end, folio, =
pte,
> > +                                                  ptent, &any_young, N=
ULL);
> >
> >                       if (nr < folio_nr_pages(folio)) {
> > -                             int err;
> > -
> >                               if (folio_likely_mapped_shared(folio))
> >                                       continue;
> >                               if (pageout_anon_only_filter && !folio_te=
st_anon(folio))
> >                                       continue;
> > -                             if (!folio_trylock(folio))
> > -                                     continue;
> > -                             folio_get(folio);
> > +
> >                               arch_leave_lazy_mmu_mode();
> > -                             pte_unmap_unlock(start_pte, ptl);
> > -                             start_pte =3D NULL;
> > -                             err =3D split_folio(folio);
> > -                             folio_unlock(folio);
> > -                             folio_put(folio);
> > -                             start_pte =3D pte =3D
> > -                                     pte_offset_map_lock(mm, pmd, addr=
, &ptl);
> > +                             if (madvise_pte_split_folio(mm, pmd, addr=
,
> > +                                                         folio, &start=
_pte, &ptl))
> > +                                     nr =3D 0;
> >                               if (!start_pte)
> >                                       break;
> > +                             pte =3D start_pte;
> >                               arch_enter_lazy_mmu_mode();
> > -                             if (!err)
> > -                                     nr =3D 0;
> >                               continue;
> >                       }
> > +
> > +                     if (any_young)
> > +                             ptent =3D pte_mkyoung(ptent);
> >               }
> >
> >               /*
> > @@ -687,47 +708,54 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
igned long addr,
> >                       continue;
> >
> >               /*
> > -              * If pmd isn't transhuge but the folio is large and
> > -              * is owned by only this process, split it and
> > -              * deactivate all pages.
> > +              * If we encounter a large folio, only split it if it is =
not
> > +              * fully mapped within the range we are operating on. Oth=
erwise
> > +              * leave it as is so that it can be marked as lazyfree. I=
f we
> > +              * fail to split a folio, leave it in place and advance t=
o the
> > +              * next pte in the range.
> >                */
> >               if (folio_test_large(folio)) {
> > -                     int err;
> > +                     bool any_young, any_dirty;
> > +                     nr =3D madvise_folio_pte_batch(addr, end, folio, =
pte,
> > +                                                  ptent, &any_young, &=
any_dirty);
> >
> > -                     if (folio_likely_mapped_shared(folio))
> > -                             break;
> > -                     if (!folio_trylock(folio))
> > -                             break;
> > -                     folio_get(folio);
> > -                     arch_leave_lazy_mmu_mode();
> > -                     pte_unmap_unlock(start_pte, ptl);
> > -                     start_pte =3D NULL;
> > -                     err =3D split_folio(folio);
> > +                     if (nr < folio_nr_pages(folio)) {
> > +                             if (folio_likely_mapped_shared(folio))
> > +                                     continue;
> > +
> > +                             arch_leave_lazy_mmu_mode();
> > +                             if (madvise_pte_split_folio(mm, pmd, addr=
,
> > +                                                         folio, &start=
_pte, &ptl))
> > +                                     nr =3D 0;
> > +                             if (!start_pte)
> > +                                     break;
> > +                             pte =3D start_pte;
> > +                             arch_enter_lazy_mmu_mode();
> > +                             continue;
> > +                     }
> > +
> > +                     if (any_young)
> > +                             ptent =3D pte_mkyoung(ptent);
> > +                     if (any_dirty)
> > +                             ptent =3D pte_mkdirty(ptent);
> > +             }
> > +
> > +             if (!folio_trylock(folio))
> > +                     continue;
>
> This is still wrong. This should all be protected by the "if
> (folio_test_swapcache(folio) || folio_test_dirty(folio))" as it was previ=
ously
> so that you only call folio_trylock() if that condition is true. You are
> unconditionally locking here, then unlocking, then relocking below if the
> condition is met. Just put everything inside the condition and lock once.

I'm not sure if it's safe to call folio_mapcount() without holding the
folio lock.

As mentioned earlier by David in the v2[1]
> What could work for large folios is making sure that #ptes that map the
> folio here correspond to the folio_mapcount(). And folio_mapcount()
> should be called under folio lock, to avoid racing with swapout/migration=
.

[1] https://lore.kernel.org/all/5cc05529-eb80-410e-bc26-233b0ba0b21f@redhat=
com/

Thanks,
Lance
>
> Thanks,
> Ryan
>
> > +             /*
> > +              * If we have a large folio at this point, we know it is =
fully mapped
> > +              * so if its mapcount is the same as its number of pages,=
 it must be
> > +              * exclusive.
> > +              */
> > +             if (folio_mapcount(folio) !=3D folio_nr_pages(folio)) {
> >                       folio_unlock(folio);
> > -                     folio_put(folio);
> > -                     if (err)
> > -                             break;
> > -                     start_pte =3D pte =3D
> > -                             pte_offset_map_lock(mm, pmd, addr, &ptl);
> > -                     if (!start_pte)
> > -                             break;
> > -                     arch_enter_lazy_mmu_mode();
> > -                     pte--;
> > -                     addr -=3D PAGE_SIZE;
> >                       continue;
> >               }
> > +             folio_unlock(folio);
> >
> >               if (folio_test_swapcache(folio) || folio_test_dirty(folio=
)) {
> >                       if (!folio_trylock(folio))
> >                               continue;
> > -                     /*
> > -                      * If folio is shared with others, we mustn't cle=
ar
> > -                      * the folio's dirty flag.
> > -                      */
> > -                     if (folio_mapcount(folio) !=3D 1) {
> > -                             folio_unlock(folio);
> > -                             continue;
> > -                     }
> >
> >                       if (folio_test_swapcache(folio) &&
> >                           !folio_free_swap(folio)) {
> > @@ -740,19 +768,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsi=
gned long addr,
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
> > +                     mkold_clean_ptes(mm, addr, pte, nr);
> > +                     tlb_remove_tlb_entries(tlb, pte, nr, addr);
> >               }
> >               folio_mark_lazyfree(folio);
> >       }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 1723c8ddf9cb..fe9d4d64c627 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -989,7 +989,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, s=
truct vm_area_struct *src_vma
> >                       flags |=3D FPB_IGNORE_SOFT_DIRTY;
> >
> >               nr =3D folio_pte_batch(folio, addr, src_pte, pte, max_nr,=
 flags,
> > -                                  &any_writable, NULL);
> > +                                  &any_writable, NULL, NULL);
> >               folio_ref_add(folio, nr);
> >               if (folio_test_anon(folio)) {
> >                       if (unlikely(folio_try_dup_anon_rmap_ptes(folio, =
page,
> > @@ -1559,7 +1559,7 @@ static inline int zap_present_ptes(struct mmu_gat=
her *tlb,
> >        */
> >       if (unlikely(folio_test_large(folio) && max_nr !=3D 1)) {
> >               nr =3D folio_pte_batch(folio, addr, pte, ptent, max_nr, f=
pb_flags,
> > -                                  NULL, NULL);
> > +                                  NULL, NULL, NULL);
> >
> >               zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent,=
 nr,
> >                                      addr, details, rss, force_flush,
>

