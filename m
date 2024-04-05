Return-Path: <linux-kernel+bounces-133033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D4E899DC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C542F1C22ECB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8A416D4CB;
	Fri,  5 Apr 2024 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaRgCfKa"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532A16D4C1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321902; cv=none; b=YH0D6p5dgq3Zss+ivCX1MZupG2F9hSduev0FtvbwL378oZHT0nAKj/gLA9CNSneYfYrpoJQItBZXzZG1qeMS/jjZ32ocqOAJhc09Yv6aOBtaWjL7dbH4y6jrqSJhWLYnPMg88JHuCAzrE+PmfXkHggg/lFuJCTiBcXgeNRbDBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321902; c=relaxed/simple;
	bh=yuLrKKyelhMsduMKUa8svTL+unTFn/ir9dPizyugFEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQRB/czJ+oofFalVpSqxpcjtqEWQEUSWAV2wcUI1XP0FavIGu0XBlL1AQ/WbO7MN81lcDk7kIsRga85Sc5Y/omK60en1hYvWmJKlUiSvTOgk5W01/WOP8TWRFP+HRfbDXc9vEkwTe+K4xMSeaBinq1Bgp6ZDR1/r6qsJToaxPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaRgCfKa; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d3776334so1041853e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712321898; x=1712926698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvG8ftiblG7YqudDTfPBSWyIzjLPS3+rvJ5EDGpa490=;
        b=AaRgCfKaoNrb9yaREHCPrPL7ekE5wVjoUY5b1UU4n4DmcaVeLJpvATP0KnHw8hbOPL
         SxNiKlXkhqYOcyNV+Bv8Dcz8GzCC4QV2UMWWhPSB+IeuBD6uD8Xafaiqftg/HGf5A7er
         wVjUVKjQdRCLBdTvyYg5OhijMbsNlZQPoYR8l+6gC3HoT10/v9VYN0N/IB6xromycWba
         QgvEneeNeeEHBN0CBU3ip/THF1mV3Ak8MNIQPr3tcRnc233TUgiJ7RPCEVMmDZNLXERF
         LvfTSPiDUODFkqOUXLz2Wd+igA9i0ds/Cl/6jd6iCGaRw3oHCVf1GUu2iLWTn7aG0RdW
         /J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321898; x=1712926698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvG8ftiblG7YqudDTfPBSWyIzjLPS3+rvJ5EDGpa490=;
        b=qfCK7R3Sa1DFjvprH84VQ2py8bMqGe2NSLr0jgoen7BMJKfTZkvgaU6pCI5KDK8Zs3
         0zrINyfmuSwrUJYaRxAVZGNVoGH6Ovck8HqBEAOGM6U2Vfzk1rXvWUxfalY6+E4ox0D1
         nq8Wj08m0fylLkUKO2BP0VZSceHagZRI96daMHCeoy7JvWKdrd7dAw4+fyIV6DlZSBIp
         7weREuBEwfpeo7x0ek+JKE6ZsS3R5fdU1nyvZ534bak1G8Ff9utSVGtdBaP4LGkwT4MX
         RBHdfjmvQnE0wSW6dUsHaKHiN6a9odWnV8tVp6RbbTTdC3fESq2/ZarvWULk1n8tAX1H
         dylA==
X-Forwarded-Encrypted: i=1; AJvYcCWb0teY6VZNjPh3+bzmPBD77W8lygZdUnZXtd5agMYUk5ki9Yfpsagj/5AqUdxMuLqad4DjEBV/80rvLq0PNl0WBcH4XcCexkkrEEJU
X-Gm-Message-State: AOJu0YxijnbOwGxjCayNjbw7o9kQg9p8hZs7psQR5ZLoZzjvKibYuY5w
	csuqdX6Z3/jldXRVmaflZk0igFCEmEp7vQMWNF5LM2PGWvJE/4Gmpw+Qzly6maDX5Jk/s68beZu
	zfo1pFDOJomymLiReE6tu0Y0vrxs=
X-Google-Smtp-Source: AGHT+IGwkGQiDhcs8HfYt/EMSmyeQZ1iWrzZlzK7RNy+fRBAKTtk/TMr4YMlk/B16yMIcMnvmBUVsz4EDZz/qeNrd7Q=
X-Received: by 2002:ac2:592c:0:b0:515:c8da:c96d with SMTP id
 v12-20020ac2592c000000b00515c8dac96dmr1107487lfi.19.1712321897384; Fri, 05
 Apr 2024 05:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402124029.47846-1-ioworker0@gmail.com> <20240402124029.47846-3-ioworker0@gmail.com>
 <99c745a1-fe87-4f63-9475-a0a598c92c8c@arm.com>
In-Reply-To: <99c745a1-fe87-4f63-9475-a0a598c92c8c@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 5 Apr 2024 20:58:05 +0800
Message-ID: <CAK1f24nB3BuUVQqfY8u_1eks29q_8f-zQ-U1bwFRJkNueBKnvA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, 21cnbao@gmail.com, 
	shy828301@gmail.com, david@redhat.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Ryan,

Thanks for taking time to review!

On Thu, Apr 4, 2024 at 1:35=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 02/04/2024 13:40, Lance Yang wrote:
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
>
> I'm guessing the reason that 2M is not showing any change is because its
> PMD-mapped and splitting is already elided? If you were to force it to be

Your guess is correct. The lack of change in 2M is because it's PMD-mapped.

> PTE-mapped then you'll see the very impressive speed-up there too. Don't =
worry
> about doing that on my account though; these results are already sufficie=
nt IMHO.
>
> >
> > [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm=
com
> > [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redh=
at.com
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  mm/internal.h |  12 ++++-
> >  mm/madvise.c  | 147 ++++++++++++++++++++++++++------------------------
> >  mm/memory.c   |   4 +-
> >  3 files changed, 88 insertions(+), 75 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 3df06a152ff0..cdc6e2162b30 100644
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
> > index bd00b83e7c50..8197effd9f14 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -321,6 +321,38 @@ static inline bool can_do_file_pageout(struct vm_a=
rea_struct *vma)
> >              file_permission(vma->vm_file, MAY_WRITE) =3D=3D 0;
> >  }
> >
> > +static inline int madvise_folio_pte_batch(unsigned long addr, unsigned=
 long end,
> > +                                       struct folio *folio, pte_t *pte=
,
> > +                                       bool *any_writable, bool *any_y=
oung, bool *any_dirty)
>
> any_writable is always NULL. Do you need it?

Thanks for pointing that out.
It seems that the any_writable parameter is redundant here, so I'll drop it=
.

>
> > +{
> > +     int max_nr =3D (end - addr) / PAGE_SIZE;
> > +     const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRT=
Y;
> > +
> > +     return folio_pte_batch(folio, addr, pte, ptep_get(pte), max_nr,
>
> ptep_get() was problematic for performance of the order-0 folio case when=
 we
> batched fork(). So we are deliberately passing around the value we alread=
y read
> in the main loop. Granted this case is not so performance critical becaus=
e we
> only end up here for large folios. But I would still prefer to just pass =
the
> data we have already read into this function rather than reading it again=
.

Thanks for the explanation! I completely agree.
I=E2=80=98ll pass the data we=E2=80=99ve already read into this function.

>
> > +                            fpb_flags, any_writable, any_young, any_di=
rty);
> > +}
> > +
> > +static inline bool madvise_pte_split_folio(struct mm_struct *mm, pmd_t=
 *pmd,
> > +                                        unsigned long addr, struct fol=
io *folio, pte_t **pte,
>
> nit: I know 80 chars is a soft limit now (and I think 100 is a hard limit=
), but
> try to be consistent. You could move the addr param to the previous line =
and be
> within the 100 char limit. Personally I would just make the prototype fit=
 in 80
> chars (same goes for madvise_folio_pte_batch).

Got it. Thanks.

>
> > +                                        spinlock_t **ptl)
> > +{
> > +     int err;
> > +
> > +     if (!folio_trylock(folio))
> > +             return false;
> > +
> > +     folio_get(folio);
> > +     pte_unmap_unlock(*pte, *ptl);
> > +     *pte =3D NULL;
>
> nit: you don't need this since you are later unconditionally setting it a=
gain.

Nice. I'll remove it.

>
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
> > @@ -456,40 +488,26 @@ static int madvise_cold_or_pageout_pte_range(pmd_=
t *pmd,
> >                * next pte in the range.
> >                */
> >               if (folio_test_large(folio)) {
> > -                     const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY |
> > -                                             FPB_IGNORE_SOFT_DIRTY;
> > -                     int max_nr =3D (end - addr) / PAGE_SIZE;
> >                       bool any_young;
> > -
> > -                     nr =3D folio_pte_batch(folio, addr, pte, ptent, m=
ax_nr,
> > -                                          fpb_flags, NULL, &any_young)=
;
> > +                     nr =3D madvise_folio_pte_batch(addr, end, folio, =
pte,
> > +                                                  NULL, &any_young, NU=
LL);
> >                       if (any_young)
> >                               ptent =3D pte_mkyoung(ptent);
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
> > -                             if (err)
> > -                                     continue;
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
> > -                             nr =3D 0;
> >                               continue;
>
> This change fixes a bug I've introduced in my swap-out series. Nice. I tr=
ied to
> fix in v6, but looking at this, I've realised its still broken. I've repl=
ied
> against that series with the fix.
>
>
> >                       }
> >               }
> > @@ -688,72 +706,59 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
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
> > +                                                  NULL, &any_young, &a=
ny_dirty);
> > +                     if (any_young || any_dirty)
> > +                             ptent =3D pte_mkdirty(pte_mkyoung(ptent))=
;
>
> I don't think it makes any difference to how ptent is consumed below, but=
 its
> probably more intuitive to separate these two operations:
>
>                         if (any_young)
>                                 ptent =3D pte_mkyoung(ptent);
>                         if (any_dirty)
>                                 ptent =3D pte_mkdirty(ptent);

I agree that it's more intuitive to separate these two operations. Thanks.

>
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
> > -             }
> > +                     if (nr < folio_nr_pages(folio)) {
> > +                             if (folio_likely_mapped_shared(folio))
> > +                                     continue;
> >
> > -             if (folio_test_swapcache(folio) || folio_test_dirty(folio=
)) {
> > -                     if (!folio_trylock(folio))
> > -                             continue;
> > -                     /*
> > -                      * If folio is shared with others, we mustn't cle=
ar
> > -                      * the folio's dirty flag.
> > -                      */
> > -                     if (folio_mapcount(folio) !=3D 1) {
> > -                             folio_unlock(folio);
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
> >                               continue;
> >                       }
> > +             }
> >
> > +             if (!folio_trylock(folio))
> > +                     continue;
> > +             /*
> > +              * If we have a large folio at this point, we know it is =
fully mapped
> > +              * so if its mapcount is the same as its number of pages,=
 it must be
> > +              * exclusive.
> > +              */
> > +             if (folio_mapcount(folio) !=3D folio_nr_pages(folio)) {
> > +                     folio_unlock(folio);
> > +                     continue;
> > +             }
> > +             if (folio_test_swapcache(folio) || folio_test_dirty(folio=
)) {
>
> I don't understand the rationale for reducing the scope of this condition=
al?
> Previously it was used to avoid having to lock the folio if it wasn't in =
the
> swapcache or if it wasn't dirty. So now you will be locking much more oft=
en.

You're right. I should keep the previous behavior of avoiding locking
the folio if
wasn't in the swapcache or if it wasn't dirty.

Thanks again for your time!
Lance

>
> Thanks,
> Ryan
>
> >                       if (folio_test_swapcache(folio) &&
> >                           !folio_free_swap(folio)) {
> >                               folio_unlock(folio);
> >                               continue;
> >                       }
> > -
> >                       folio_clear_dirty(folio);
> > -                     folio_unlock(folio);
> >               }
> > +             folio_unlock(folio);
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
> > +                     mkold_clean_ptes(vma, addr, pte, nr, tlb->fullmm)=
;
> > +                     tlb_remove_tlb_entries(tlb, pte, nr, addr);
> >               }
> >               folio_mark_lazyfree(folio);
> >       }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 912cd738ec03..24769ecb59e5 100644
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

