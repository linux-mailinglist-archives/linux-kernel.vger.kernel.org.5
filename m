Return-Path: <linux-kernel+bounces-127864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E18951D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8430DB22EAB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D350E6996E;
	Tue,  2 Apr 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSS9gsSi"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF706341B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057429; cv=none; b=fKloXH6JPpp1QQPz84D1RH8t4ha1IK4nOF7aCWk/Bzk8GGT7HzJHhNH3N79X/PmWlq7eTzp4M3nbSSiIHnb9XXcyaKxfe64i+3GF2w17joxX/CqXxshSMxCBAzUsIPZhZzJB/x0W/3VYFvE7HgBSpeEPFawvlSIC/YCVoLGTvLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057429; c=relaxed/simple;
	bh=FyHiCae21QW9c2qk8EUOXjxYO+7PzU4htDCvkO4JqE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qexV55uCVzLBs9SQdpjRjghzKJ7HchVJXGPSLEl5PIZBCtW//f2BP2lRH+lEuhfPvLt/Gu4tJqv74ZdScWnNcuH3hcRfVsC0xT0bvm9AELJYZoUjOaShGD2lUGi1/bL4ipBKI0ubvyCVxRS5SlSBwRId5ni59IZqnSAtWRqkkNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSS9gsSi; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513e134f73aso6496814e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712057426; x=1712662226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvLJKayzGhGCWIQRgWMmiuFqAyfV+XipkMVmkcqYEZ4=;
        b=mSS9gsSiwpia2IquoaTddfO7R8wEN8TaHcxUFy6/LC5Sn+DGy/GVeBt087NcJnhA45
         5vDmXwu5DrHexUOWdU86vR1b0qEFTkSTdBxEGnvt7hTTbfTwF11ztpVILNvSbFyfYERa
         hvkuwd+wKNyvWma6QLX+0aZO42KaFV8SaL162soH86vX3/E9sCiTumiCX1/MYKZuY12l
         +sirF9sYiDYKF/8r6LuHTdS9lCTQIHqQu5rUtNUcUFH7GpnID1Q10be8osamzIslfpzi
         6lbRiaNcb6ScHlark9PKJQ+1QPvqM+40cuAZhn2szJjMHS57I76FzUeEy/UQMIFPtOx2
         Dykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712057426; x=1712662226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvLJKayzGhGCWIQRgWMmiuFqAyfV+XipkMVmkcqYEZ4=;
        b=fXTChlVFNmel7eRbW1Dww7lGAUDkSI5O0Hg5I/wLUdNH7WCCpIKLl9lwJJELLqd0Mw
         +s7wQt+xnAmml+3zI8b6HpCleHcXEL/RVpkedGSoSLn7TYlOIJ6ofSSLNtI4Stq9Rkix
         bax8a6oInIUhZ+lTcuOYI68GrXn49DpBp2W50e6xn7KdiTzl2KL44axquuT/r7fW2BZ+
         HwdShB8LynkAige3ghAhsR7tsWwPRmSgcGMPk5lH6zq8ew5RinPfz7/TyBjZtet+XNrX
         A3vvU4mX93U5rILnjeDp7olubIbWbL3nOXZ+v/gKl+CBYFz/8HaVUjHEV28TGeHvUG+W
         GFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtvhIsEy9zxcbeFL7MvpXCR8ksiJc9A9LssW06mWSnaBwNysTzHkJLc81jlSqSbpMtKxf7vybgtCz9eI/ogBph9/wtZTXuJb6+eGYf
X-Gm-Message-State: AOJu0YxHCSKqMouhahJYGv8e/v3Y0eMz9J43Lfud+Gm0ugv+w1kokWvY
	hLnAqrkIRnOgbwrBeB2zM5tBwFYvPDMFvFqsjctZ0yk/CcP/U6nwP+dR3sXTds2D2kx97Cl5fLz
	YHV+AXfHK9Jt6XGVA5gDL35IbJCw=
X-Google-Smtp-Source: AGHT+IG4CfnxLbVPc+7VK201cG0D9tzVYq3yiSkvweNt1GPtOsN270C8O0XLt57IhfAo50OYUih6KbzG7fXfKtetwys=
X-Received: by 2002:a05:6512:21ca:b0:515:8bde:56c3 with SMTP id
 d10-20020a05651221ca00b005158bde56c3mr9309404lft.26.1712057425386; Tue, 02
 Apr 2024 04:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
 <20240327144537.4165578-7-ryan.roberts@arm.com> <CAK1f24kON1tLerfYMPUO5vXN2yL9UXozOgACDtSwgGO_zFzTQQ@mail.gmail.com>
 <e0b6fb0e-0ef0-4b58-99ef-3d74fb0e4079@arm.com>
In-Reply-To: <e0b6fb0e-0ef0-4b58-99ef-3d74fb0e4079@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 2 Apr 2024 19:30:13 +0800
Message-ID: <CAK1f24mBNUQ8155+TxxR9tBkJmE=GAHW7bi-Z2cpsSw=3FDUtg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 7:20=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 01/04/2024 13:25, Lance Yang wrote:
> > On Wed, Mar 27, 2024 at 10:46=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
com> wrote:
> >>
> >> Rework madvise_cold_or_pageout_pte_range() to avoid splitting any larg=
e
> >> folio that is fully and contiguously mapped in the pageout/cold vm
> >> range. This change means that large folios will be maintained all the
> >> way to swap storage. This both improves performance during swap-out, b=
y
> >> eliding the cost of splitting the folio, and sets us up nicely for
> >> maintaining the large folio when it is swapped back in (to be covered =
in
> >> a separate series).
> >>
> >> Folios that are not fully mapped in the target range are still split,
> >> but note that behavior is changed so that if the split fails for any
> >> reason (folio locked, shared, etc) we now leave it as is and move to t=
he
> >> next pte in the range and continue work on the proceeding folios.
> >> Previously any failure of this sort would cause the entire operation t=
o
> >> give up and no folios mapped at higher addresses were paged out or mad=
e
> >> cold. Given large folios are becoming more common, this old behavior
> >> would have likely lead to wasted opportunities.
> >>
> >> While we are at it, change the code that clears young from the ptes to
> >> use ptep_test_and_clear_young(), via the new mkold_ptes() batch helper
> >> function. This is more efficent than get_and_clear/modify/set,
> >> especially for contpte mappings on arm64, where the old approach would
> >> require unfolding/refolding and the new approach can be done in place.
> >>
> >> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  include/linux/pgtable.h | 30 ++++++++++++++
> >>  mm/internal.h           | 12 +++++-
> >>  mm/madvise.c            | 88 ++++++++++++++++++++++++----------------=
-
> >>  mm/memory.c             |  4 +-
> >>  4 files changed, 93 insertions(+), 41 deletions(-)
> >>
> >> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >> index 8185939df1e8..391f56a1b188 100644
> >> --- a/include/linux/pgtable.h
> >> +++ b/include/linux/pgtable.h
> >> @@ -361,6 +361,36 @@ static inline int ptep_test_and_clear_young(struc=
t vm_area_struct *vma,
> >>  }
> >>  #endif
> >>
> >> +#ifndef mkold_ptes
> >> +/**
> >> + * mkold_ptes - Mark PTEs that map consecutive pages of the same foli=
o as old.
> >> + * @vma: VMA the pages are mapped into.
> >> + * @addr: Address the first page is mapped at.
> >> + * @ptep: Page table pointer for the first entry.
> >> + * @nr: Number of entries to mark old.
> >> + *
> >> + * May be overridden by the architecture; otherwise, implemented as a=
 simple
> >> + * loop over ptep_test_and_clear_young().
> >> + *
> >> + * Note that PTE bits in the PTE range besides the PFN can differ. Fo=
r example,
> >> + * some PTEs might be write-protected.
> >> + *
> >> + * Context: The caller holds the page table lock.  The PTEs map conse=
cutive
> >> + * pages that belong to the same folio.  The PTEs are all in the same=
 PMD.
> >> + */
> >> +static inline void mkold_ptes(struct vm_area_struct *vma, unsigned lo=
ng addr,
> >> +               pte_t *ptep, unsigned int nr)
> >> +{
> >> +       for (;;) {
> >> +               ptep_test_and_clear_young(vma, addr, ptep);
> >
> > IIUC, if the first PTE is a CONT-PTE, then calling ptep_test_and_clear_=
young()
> > will clear the young bit for the entire contig range to avoid having
> > to unfold. So,
> > the other PTEs within the range don't need to clear again.
> >
> > Maybe we should consider overriding mkold_ptes for arm64?
>
> Yes completely agree. I was saving this for a separate submission though,=
 to
> reduce the complexity of this initial series as much as possible. Let me =
know if
> you disagree and want to see that change as part of this series.

Feel free to save the change for a separate submission :)

>
> >
> > Thanks,
> > Lance
> >
> >> +               if (--nr =3D=3D 0)
> >> +                       break;
> >> +               ptep++;
> >> +               addr +=3D PAGE_SIZE;
> >> +       }
> >> +}
> >> +#endif
> >> +
> >>  #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> >>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_N=
ONLEAF_PMD_YOUNG)
> >>  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vm=
a,
> >> diff --git a/mm/internal.h b/mm/internal.h
> >> index eadb79c3a357..efee8e4cd2af 100644
> >> --- a/mm/internal.h
> >> +++ b/mm/internal.h
> >> @@ -130,6 +130,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_=
t pte, fpb_t flags)
> >>   * @flags: Flags to modify the PTE batch semantics.
> >>   * @any_writable: Optional pointer to indicate whether any entry exce=
pt the
> >>   *               first one is writable.
> >> + * @any_young: Optional pointer to indicate whether any entry except =
the
> >> + *               first one is young.
> >>   *
> >>   * Detect a PTE batch: consecutive (present) PTEs that map consecutiv=
e
> >>   * pages of the same large folio.
> >> @@ -145,16 +147,18 @@ static inline pte_t __pte_batch_clear_ignored(pt=
e_t pte, fpb_t flags)
> >>   */
> >>  static inline int folio_pte_batch(struct folio *folio, unsigned long =
addr,
> >>                 pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> >> -               bool *any_writable)
> >> +               bool *any_writable, bool *any_young)
> >>  {
> >>         unsigned long folio_end_pfn =3D folio_pfn(folio) + folio_nr_pa=
ges(folio);
> >>         const pte_t *end_ptep =3D start_ptep + max_nr;
> >>         pte_t expected_pte, *ptep;
> >> -       bool writable;
> >> +       bool writable, young;
> >>         int nr;
> >>
> >>         if (any_writable)
> >>                 *any_writable =3D false;
> >> +       if (any_young)
> >> +               *any_young =3D false;
> >>
> >>         VM_WARN_ON_FOLIO(!pte_present(pte), folio);
> >>         VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio=
);
> >> @@ -168,6 +172,8 @@ static inline int folio_pte_batch(struct folio *fo=
lio, unsigned long addr,
> >>                 pte =3D ptep_get(ptep);
> >>                 if (any_writable)
> >>                         writable =3D !!pte_write(pte);
> >> +               if (any_young)
> >> +                       young =3D !!pte_young(pte);
> >>                 pte =3D __pte_batch_clear_ignored(pte, flags);
> >>
> >>                 if (!pte_same(pte, expected_pte))
> >> @@ -183,6 +189,8 @@ static inline int folio_pte_batch(struct folio *fo=
lio, unsigned long addr,
> >>
> >>                 if (any_writable)
> >>                         *any_writable |=3D writable;
> >> +               if (any_young)
> >> +                       *any_young |=3D young;
> >>
> >>                 nr =3D pte_batch_hint(ptep, pte);
> >>                 expected_pte =3D pte_advance_pfn(expected_pte, nr);
> >> diff --git a/mm/madvise.c b/mm/madvise.c
> >> index 070bedb4996e..bd00b83e7c50 100644
> >> --- a/mm/madvise.c
> >> +++ b/mm/madvise.c
> >> @@ -336,6 +336,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t=
 *pmd,
> >>         LIST_HEAD(folio_list);
> >>         bool pageout_anon_only_filter;
> >>         unsigned int batch_count =3D 0;
> >> +       int nr;
> >>
> >>         if (fatal_signal_pending(current))
> >>                 return -EINTR;
> >> @@ -423,7 +424,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t=
 *pmd,
> >>                 return 0;
> >>         flush_tlb_batched_pending(mm);
> >>         arch_enter_lazy_mmu_mode();
> >> -       for (; addr < end; pte++, addr +=3D PAGE_SIZE) {
> >> +       for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
> >> +               nr =3D 1;
> >>                 ptent =3D ptep_get(pte);
> >>
> >>                 if (++batch_count =3D=3D SWAP_CLUSTER_MAX) {
> >> @@ -447,55 +449,67 @@ static int madvise_cold_or_pageout_pte_range(pmd=
_t *pmd,
> >>                         continue;
> >>
> >>                 /*
> >> -                * Creating a THP page is expensive so split it only i=
f we
> >> -                * are sure it's worth. Split it if we are only owner.
> >> +                * If we encounter a large folio, only split it if it =
is not
> >> +                * fully mapped within the range we are operating on. =
Otherwise
> >> +                * leave it as is so that it can be swapped out whole.=
 If we
> >> +                * fail to split a folio, leave it in place and advanc=
e to the
> >> +                * next pte in the range.
> >>                  */
> >>                 if (folio_test_large(folio)) {
> >> -                       int err;
> >> -
> >> -                       if (folio_likely_mapped_shared(folio))
> >> -                               break;
> >> -                       if (pageout_anon_only_filter && !folio_test_an=
on(folio))
> >> -                               break;
> >> -                       if (!folio_trylock(folio))
> >> -                               break;
> >> -                       folio_get(folio);
> >> -                       arch_leave_lazy_mmu_mode();
> >> -                       pte_unmap_unlock(start_pte, ptl);
> >> -                       start_pte =3D NULL;
> >> -                       err =3D split_folio(folio);
> >> -                       folio_unlock(folio);
> >> -                       folio_put(folio);
> >> -                       if (err)
> >> -                               break;
> >> -                       start_pte =3D pte =3D
> >> -                               pte_offset_map_lock(mm, pmd, addr, &pt=
l);
> >> -                       if (!start_pte)
> >> -                               break;
> >> -                       arch_enter_lazy_mmu_mode();
> >> -                       pte--;
> >> -                       addr -=3D PAGE_SIZE;
> >> -                       continue;
> >> +                       const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY |
> >> +                                               FPB_IGNORE_SOFT_DIRTY;
> >> +                       int max_nr =3D (end - addr) / PAGE_SIZE;
> >> +                       bool any_young;
> >> +
> >> +                       nr =3D folio_pte_batch(folio, addr, pte, ptent=
, max_nr,
> >> +                                            fpb_flags, NULL, &any_you=
ng);
> >> +                       if (any_young)
> >> +                               ptent =3D pte_mkyoung(ptent);
> >> +
> >> +                       if (nr < folio_nr_pages(folio)) {
> >> +                               int err;
> >> +
> >> +                               if (folio_likely_mapped_shared(folio))
> >> +                                       continue;
> >> +                               if (pageout_anon_only_filter && !folio=
_test_anon(folio))
> >> +                                       continue;
> >> +                               if (!folio_trylock(folio))
> >> +                                       continue;
> >> +                               folio_get(folio);
> >> +                               arch_leave_lazy_mmu_mode();
> >> +                               pte_unmap_unlock(start_pte, ptl);
> >> +                               start_pte =3D NULL;
> >> +                               err =3D split_folio(folio);
> >> +                               folio_unlock(folio);
> >> +                               folio_put(folio);
> >> +                               if (err)
> >> +                                       continue;
> >> +                               start_pte =3D pte =3D
> >> +                                       pte_offset_map_lock(mm, pmd, a=
ddr, &ptl);
> >> +                               if (!start_pte)
> >> +                                       break;
> >> +                               arch_enter_lazy_mmu_mode();
> >> +                               nr =3D 0;
> >> +                               continue;
> >> +                       }
> >>                 }
> >>
> >>                 /*
> >>                  * Do not interfere with other mappings of this folio =
and
> >> -                * non-LRU folio.
> >> +                * non-LRU folio. If we have a large folio at this poi=
nt, we
> >> +                * know it is fully mapped so if its mapcount is the s=
ame as its
> >> +                * number of pages, it must be exclusive.
> >>                  */
> >> -               if (!folio_test_lru(folio) || folio_mapcount(folio) !=
=3D 1)
> >> +               if (!folio_test_lru(folio) ||
> >> +                   folio_mapcount(folio) !=3D folio_nr_pages(folio))
> >>                         continue;
> >>
> >>                 if (pageout_anon_only_filter && !folio_test_anon(folio=
))
> >>                         continue;
> >>
> >> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >> -
> >>                 if (!pageout && pte_young(ptent)) {
> >> -                       ptent =3D ptep_get_and_clear_full(mm, addr, pt=
e,
> >> -                                                       tlb->fullmm);
> >> -                       ptent =3D pte_mkold(ptent);
> >> -                       set_pte_at(mm, addr, pte, ptent);
> >> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> >> +                       mkold_ptes(vma, addr, pte, nr);
> >> +                       tlb_remove_tlb_entries(tlb, pte, nr, addr);
> >>                 }
> >>
> >>                 /*
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 9d844582ba38..b5b48f4cf2af 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -989,7 +989,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, =
struct vm_area_struct *src_vma
> >>                         flags |=3D FPB_IGNORE_SOFT_DIRTY;
> >>
> >>                 nr =3D folio_pte_batch(folio, addr, src_pte, pte, max_=
nr, flags,
> >> -                                    &any_writable);
> >> +                                    &any_writable, NULL);
> >>                 folio_ref_add(folio, nr);
> >>                 if (folio_test_anon(folio)) {
> >>                         if (unlikely(folio_try_dup_anon_rmap_ptes(foli=
o, page,
> >> @@ -1553,7 +1553,7 @@ static inline int zap_present_ptes(struct mmu_ga=
ther *tlb,
> >>          */
> >>         if (unlikely(folio_test_large(folio) && max_nr !=3D 1)) {
> >>                 nr =3D folio_pte_batch(folio, addr, pte, ptent, max_nr=
, fpb_flags,
> >> -                                    NULL);
> >> +                                    NULL, NULL);
> >>
> >>                 zap_present_folio_ptes(tlb, vma, folio, page, pte, pte=
nt, nr,
> >>                                        addr, details, rss, force_flush=
,
> >> --
> >> 2.25.1
> >>
>

