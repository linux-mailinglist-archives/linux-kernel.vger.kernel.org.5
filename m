Return-Path: <linux-kernel+bounces-144831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC918A4B62
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1E81C21D16
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9533D56D;
	Mon, 15 Apr 2024 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxMXr5I8"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082CF383B0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173053; cv=none; b=Un3fqzLOBcGHjPND3MCn0iqzgns3I9StT6080tUVm63WipYMlmhHOPEI0mmn8wqIaClgjWbfk4Md2KAKvuNzOSc1SaU4hVjyQjYCGNtyw2bL5JIjcNrTgaxYdugKWrqbJlSCRi86O5TzAyJrIPyX0Pk0dTV0ZP8G7gjcWxyTuJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173053; c=relaxed/simple;
	bh=cNbhqE8fck3r7wvi3pgtpTuaCPRJuZDLZ+zuG9/SlM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1lzt3L9biOOuosdzoFM99kgsTH677OF8LDZtBIJIdtLjRf5HSGLlxTOnmEALG07LbioyHFEPubnRWliRzr7iYLnm/DFoy5ZHyC98qc7+51By471WpHJACXNHlW0CX9594u5H1PiyOSd6c70mv984FHzoKDbo1Oc+KcUmXeLidE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxMXr5I8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5700a9caee0so2001201a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713173049; x=1713777849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjeMzniIlIp791xqAyz69U+8BqOB3aL+j7/6+3lG6Js=;
        b=jxMXr5I87yuMAIJNyspIfLhNxZN2QDRBMIxW5JzUZ5i/JaDiqlrEhmRTFStz+6LkzC
         EsUjsP5fE9NTFgM3eqz4bzfHDH6pxtM2MdpjHSyD3vn5tikDGJB8z1SEqxzxQjpBA5O3
         inLeRLoZw+cmxH8VeW52uYIw3f/7sjZMmRd/+oNK141prrwP/l5KPbp6PKS7y8Zt/cYn
         bdbbie/8KU3kCZYn4W5RcfLNGLijTzmariapOKsmWbXQShcz1pYDxbw1jUgdtp/nkFU2
         ekTjAhKhMDQxHAU62zkCO/C3BzlayzwUHlEzrnDLkyQce7YJmUO4fzPHSUP2fbuhbtwq
         E5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713173049; x=1713777849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjeMzniIlIp791xqAyz69U+8BqOB3aL+j7/6+3lG6Js=;
        b=UIAht/7HkIQvCzxzpbRH4Omnvuu1vhmdO97pHj6q89s0OANUwiWMOFoMgaRE1FDuX9
         KEuNbw+sv+RP52hOVzBZmmI/g8QXxSAaWWzn5G+LoBgT8cGZdYd/bx4Bcv98iuuDj9eM
         OIxINEVcSoEqZ2sq0p1oG23+S4wmWCI/QXGN0Qzx0vfZiH5UMg6fTQFuzf1RSRrN5jy9
         qSNsAE/v+XZrr1DYwli8jYioN3QQhmJgf+BrleyngLohNbxy6+rStOt4/yX7mViTVpyJ
         zW1AxxnzoIsGdMcjvHZsKcvfcI9u54uc11x5gJphieuaOt5g/PmzngaG8YPhFnAWUlCr
         Cbeg==
X-Forwarded-Encrypted: i=1; AJvYcCWlImaqiFW6YTlpulicZF6JrPyy48+/nsGkSUUKGUeZwx4smeMIEOZH29D5y6MBbo52JTOM5bfRwDPijRfDOZQyDdMeXy2TZ90Z6Jb+
X-Gm-Message-State: AOJu0Yx23cUFEnGkH3jEI5vYDuyDDBjlbwPVJgA/m61ZxxifLA6V9iMm
	ZCEBboVD+B6hHnKLuqykNMdEPhPURnNdkaRCigFiaOnM2VyKwZ8BYFboOwv2ELWX0uskt1tMkA+
	6hPqynYoxgSlGOk+6tBkv19LINsY=
X-Google-Smtp-Source: AGHT+IFlDOYPo9FoDXenBiQS2Jc9VuRmhmHhYhLHljXMaC3BEEF+2zatiEM0FHz4Hsarv31vRZNj2RxIr6z4bmGA0X0=
X-Received: by 2002:a50:aadc:0:b0:568:a30c:2db5 with SMTP id
 r28-20020a50aadc000000b00568a30c2db5mr5223005edc.40.1713173049076; Mon, 15
 Apr 2024 02:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413002219.71246-1-ioworker0@gmail.com> <20240413002219.71246-2-ioworker0@gmail.com>
 <2c1eb3ba-3f76-4796-b076-307a72cddc76@arm.com>
In-Reply-To: <2c1eb3ba-3f76-4796-b076-307a72cddc76@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 15 Apr 2024 17:23:57 +0800
Message-ID: <CAK1f24nUnbYNeV+4AmcWS2hWT4B2SWS1fYThOU8ZyZukDx=fqQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, 21cnbao@gmail.com, 
	shy828301@gmail.com, david@redhat.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Ryan,

Thanks a lot for taking time to review!

On Mon, Apr 15, 2024 at 4:47=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 13/04/2024 01:22, Lance Yang wrote:
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
> This is looking close IMHO. Just one bug and suggestion below.
>
>
> > ---
> >  include/linux/mm_types.h |   9 +++
> >  include/linux/pgtable.h  |  42 +++++++++++
> >  mm/internal.h            |  12 +++-
> >  mm/madvise.c             | 147 ++++++++++++++++++++++-----------------
> >  mm/memory.c              |   4 +-
> >  5 files changed, 147 insertions(+), 67 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index c432add95913..3c224e25f473 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1367,6 +1367,15 @@ enum fault_flag {
> >
> >  typedef unsigned int __bitwise zap_flags_t;
> >
> > +/* Flags for clear_young_dirty_ptes(). */
> > +typedef int __bitwise cydp_t;
> > +
> > +/* make PTEs after pte_mkold() */
> > +#define CYDP_CLEAR_YOUNG             ((__force cydp_t)BIT(0))
> > +
> > +/* make PTEs after pte_mkclean() */
> > +#define CYDP_CLEAR_DIRTY             ((__force cydp_t)BIT(1))
> > +
> >  /*
> >   * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with=
 each
> >   * other. Here is what they mean, and how to use them:
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index e2f45e22a6d1..d7958243f099 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -489,6 +489,48 @@ static inline pte_t ptep_get_and_clear(struct mm_s=
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
> > +static inline void clear_young_dirty_ptes(struct mm_struct *mm,
>
> My suggestion to introduce clear_young_dirty_ptes() was so that we could
> *remove* mkold_ptes(). So I think it would be good to split that to a sep=
arate

Sorry, I forgot to remove it :(

> preparatory patch, where you change all the callers to call the new funct=
ion and
> remove mkold_ptes().

Thanks for your suggestion!
I'll split this into a separate preparatory patch, modify all the callers
to use new function clear_young_dirty_ptes(), and then remove mkold_ptes().

>
> Additionally since many arches already override ptep_test_and_clear_young=
() (and
> that's what the default mkold_ptes() did, you might want to call that in =
the
> below loop if *only* CYDP_CLEAR_YOUNG is set to avoid the possibility of =
any
> regression. I know I only made this change for the swap-out series so wha=
t you
> have done may well be ok in practice - and certainly cleaner. It would be=
 good
> to hear others' opinions.

It makes sense to me. I'll consider calling ptep_test_and_clear_young() in
the loop only when CYDP_CLEAR_YOUNG is set to avoid any regression.

Thanks, and I'll wait to hear others' opinions.

>
> Note the existing mkold_ptes() takes a vma instead of mm (because that's =
what
> ptep_test_and_clear_young() takes). So suggest passing vma. You can get m=
m from
> vma->mm.

Got it.

>
> > +                                       unsigned long addr, pte_t *ptep=
,
> > +                                       unsigned int nr, cydp_t flags)
> > +{
> > +     pte_t pte;
> > +
> > +     for (;;) {
>
> Suggestion:
>                 if (flags =3D=3D CYDP_CLEAR_YOUNG) {
>                         ptep_test_and_clear_young(vma, addr, ptep);
>                 else {
>
> > +             pte =3D ptep_get_and_clear(mm, addr, ptep);
> > +
> > +             if (flags | CYDP_CLEAR_YOUNG)
>
> bug: this needs to be bitwise and (&). Currently it will always evaluate =
to
> true. Same for next one.

Sorry, my bad for the oversight and mistake :(
I'll fix it, thanks!

Thanks,
Lance

>
> > +                     pte =3D pte_mkold(pte);
> > +             if (flags | CYDP_CLEAR_DIRTY)
> > +                     pte =3D pte_mkclean(pte);
> > +
> > +             set_pte_at(mm, addr, ptep, pte);
>
>                 }
>
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
> > index 3c0f3e3f9d99..ab8fcdeaf6eb 100644
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
> > index d34ca6983227..b4103e2df346 100644
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
> > @@ -507,7 +529,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
> >                       continue;
> >
> >               if (!pageout && pte_young(ptent)) {
> > -                     mkold_ptes(vma, addr, pte, nr);
> > +                     clear_young_dirty_ptes(mm, addr, pte, nr,
> > +                                            CYDP_CLEAR_YOUNG);
> >                       tlb_remove_tlb_entries(tlb, pte, nr, addr);
> >               }
> >
> > @@ -687,44 +710,51 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
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
> > +             if (folio_mapcount(folio) !=3D folio_nr_pages(folio))
> > +                     continue;
> > +
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
> > @@ -740,19 +770,10 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
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
> > +                     clear_young_dirty_ptes(mm, addr, pte, nr,
> > +                                            CYDP_CLEAR_YOUNG |
> > +                                                    CYDP_CLEAR_DIRTY);
> > +                     tlb_remove_tlb_entries(tlb, pte, nr, addr);
> >               }
> >               folio_mark_lazyfree(folio);
> >       }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 76157b32faa8..b6fa5146b260 100644
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

