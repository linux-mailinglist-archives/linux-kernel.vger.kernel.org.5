Return-Path: <linux-kernel+bounces-149346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B658A8FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E47FEB21B61
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF810E6;
	Thu, 18 Apr 2024 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqlWxRCi"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D8376
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399004; cv=none; b=rie3vPq6KGALoPekZtjijtNPFzEIEVLwKdYq9gxfL4jt4uJuoB9LKDrwyQz80bv4IroL0JTdUFX/YC8cJFOfcON24OlSfq8fM1T0Yimt4CIrgnMUb5afXkH83wWmw4amVmLHYwRSfyyIaC+XG8ZZELH25AYy+xus1LPPBG5DyAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399004; c=relaxed/simple;
	bh=QDEoUifSlFc04Ze3+z61PgZvGIo9OM11sGEITXyIkc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQZb/pJ/0N0YBV7W66Zkd4G0ZRCUcH/TJurAfyd/sN8x38AVDAwbgJCa8n++JoBRHyN70+4KlzDOc15D8WDW2MiB2VVkpbs8QlJp2Jq3qW6pNIuxqV7ZoAFPVZun6ZmV0FJgH90PWAYsqJvUcRB9jMDCKOGkDAQZvvfUjbwc4Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqlWxRCi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so2487867a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713399000; x=1714003800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWNnfVzIIfJeshD3FIeRNRSQAI7PxLGbs+JyRQWqQZE=;
        b=PqlWxRCi4gYFSPvSpVO6NDIxjF1DlTRDHQDtdHVNooHPaqiTJcaZfzSMHCbM0Cwju7
         GG23Sajg4d86DvvrHseCn2BQeumG+wYVBMEPzWKJHjL47sSXWRgPyMSh69aXeW5HkpwL
         zyoVgRivxUg2GFWrJhMhSD2BQiRWbXavZ2luHd/QsHHeLBOxsoay1L2kenIRU7TJYLuP
         wRAyLb8/f3ksTx3OguCPX9nsEEKZtatytupMNCVB8iSIHrGNQA7i2kCnGsADvQ2/Ylem
         xHKwXz4+PPxs67a7sRJm7/i5fiRJD2zgZZWpuFwnc/6EH9X0iHZrAl25xJtTxmuSWU5B
         AXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713399000; x=1714003800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWNnfVzIIfJeshD3FIeRNRSQAI7PxLGbs+JyRQWqQZE=;
        b=DRqeaSAFOOtbfQvX4UekiJyMMZ5UFsWyr4ft/D/0NRvsFEd7odhZQ9mdUubvD/YUqr
         Z/7sNAl4y2LepL4fgiL7rvkIKljhgMMF9VtAW9+FN3Q+tRPFH58jsYp8w9LKhDH2foBE
         KvGdr2xT3zRGjP3nP34SDkvT1XmqUpC7PVULF9cAWUambhL7XFpjtQ3X7n6puzvBXclY
         uyoEsJChhOLjJRJRPkideL5iaQTILw38Yub9YSeV6g/US+0sYZyK87ZLuPROV1yZtlc0
         u+Wjp16C8ErVXIl1dg7LYuqcKwO0jAyr/p4Y6jY9fVPsOBAvbXOrGBTbSWXKVXwSNiRR
         ZdnA==
X-Forwarded-Encrypted: i=1; AJvYcCV2FzegEblfxlEN6rGxZd8k2xcrQQk80jGS+7u3eRPIrFEOEi3epvNGeKx2/X/TDjy+d6dKMGgc0l3cQeX1H4p92Iq+Dlmn3JII7B8Z
X-Gm-Message-State: AOJu0Yy4T088lal77DPQtf7redWq4/KRjcd/I3ZpNbrddjt1KMSRB0W6
	a7rcyQ1/GyJDmmtCNepQbsKyLaDpCeOrFBQcDMXf+5bKlrxijvFMxXJoZXvzfklkcEWg5MmrHGZ
	0xZFZuESn6EpqnqWED/OFWoAy6Cc=
X-Google-Smtp-Source: AGHT+IFxvgg4TrqYmmtEv3dEcoyPdMa0XHro7sMEdAno+N/fY4YFecJxK/aGYpZbM3pLOqFHQRWMDWh+B1xEX3DZMrw=
X-Received: by 2002:a50:9343:0:b0:570:392:aa1a with SMTP id
 n3-20020a509343000000b005700392aa1amr458921eda.7.1713398999904; Wed, 17 Apr
 2024 17:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417141436.77963-1-ioworker0@gmail.com> <20240417141436.77963-4-ioworker0@gmail.com>
 <10c33581-b016-453f-ab7d-84832393466e@arm.com>
In-Reply-To: <10c33581-b016-453f-ab7d-84832393466e@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 18 Apr 2024 08:09:48 +0800
Message-ID: <CAK1f24nrq-Z473e1zf9wOZkqxrJXWYK=FGoJRzedCpy797wF7Q@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:25=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 17/04/2024 15:14, Lance Yang wrote:
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
>
> LGTM!
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Hey Ryan,

Thanks a lot for taking time to review!
Lance

>
> > ---
> >  mm/internal.h |  12 ++++-
> >  mm/madvise.c  | 141 ++++++++++++++++++++++++++++----------------------
> >  mm/memory.c   |   4 +-
> >  3 files changed, 91 insertions(+), 66 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index c6483f73ec13..daa59cef85d7 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -134,6 +134,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_t=
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
> > @@ -149,18 +151,20 @@ static inline pte_t __pte_batch_clear_ignored(pte=
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
> > @@ -176,6 +180,8 @@ static inline int folio_pte_batch(struct folio *fol=
io, unsigned long addr,
> >                       writable =3D !!pte_write(pte);
> >               if (any_young)
> >                       young =3D !!pte_young(pte);
> > +             if (any_dirty)
> > +                     dirty =3D !!pte_dirty(pte);
> >               pte =3D __pte_batch_clear_ignored(pte, flags);
> >
> >               if (!pte_same(pte, expected_pte))
> > @@ -193,6 +199,8 @@ static inline int folio_pte_batch(struct folio *fol=
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
> > index f5e3699e7b54..d6f1889d6308 100644
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
> > @@ -456,41 +489,30 @@ static int madvise_cold_or_pageout_pte_range(pmd_=
t *pmd,
> >                * next pte in the range.
> >                */
> >               if (folio_test_large(folio)) {
> > -                     const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY |
> > -                                             FPB_IGNORE_SOFT_DIRTY;
> > -                     int max_nr =3D (end - addr) / PAGE_SIZE;
> >                       bool any_young;
> >
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
> > @@ -688,44 +710,48 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
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
> > -                     folio_unlock(folio);
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
> > -                     continue;
> > +                     nr =3D madvise_folio_pte_batch(addr, end, folio, =
pte,
> > +                                                  ptent, &any_young, &=
any_dirty);
> > +
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
> >               }
> >
> >               if (folio_test_swapcache(folio) || folio_test_dirty(folio=
)) {
> >                       if (!folio_trylock(folio))
> >                               continue;
> >                       /*
> > -                      * If folio is shared with others, we mustn't cle=
ar
> > -                      * the folio's dirty flag.
> > +                      * If we have a large folio at this point, we kno=
w it is
> > +                      * fully mapped so if its mapcount is the same as=
 its
> > +                      * number of pages, it must be exclusive.
> >                        */
> > -                     if (folio_mapcount(folio) !=3D 1) {
> > +                     if (folio_mapcount(folio) !=3D folio_nr_pages(fol=
io)) {
> >                               folio_unlock(folio);
> >                               continue;
> >                       }
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
> > +                     tlb_remove_tlb_entries(tlb, pte, nr, addr);
> >               }
> >               folio_mark_lazyfree(folio);
> >       }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 33d87b64d15d..9e07d1b9020c 100644
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
> > @@ -1558,7 +1558,7 @@ static inline int zap_present_ptes(struct mmu_gat=
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

