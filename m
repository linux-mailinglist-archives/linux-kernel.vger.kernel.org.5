Return-Path: <linux-kernel+bounces-136546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796FD89D56E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED29B1F233E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513A78004F;
	Tue,  9 Apr 2024 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8FtmcG6"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C332B7F49F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654554; cv=none; b=tjd88QVEvGNs0sqdHOnTaRakTOuvRgLk36ns4UE8c3q+fiJ/PgvcJ5xM97GCJTp0QPDS3v9gN5uYeFhnqVkC7D0PtpHs+M2EsLHokwFrXe4mU6m6XbhQ1da6KTRdQ0NSiuhjD7YARfmAFCdSIFn9/Pfnsic+m8KyKCFAfROl9SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654554; c=relaxed/simple;
	bh=fsnS/YV1NWziysEQgeTQ1jNdZoYf9cXsu0mSloilZqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVKxEuJ/zkdkNjsLVziAjOfnE4XioETYfvYVQqkt9jldOClS6oe8TGOuc8f86gKRj5bI6g4k/wPnSczUxjX2AHb/QUsZG+i84iFqpZEYJ1FM4GK2BJIinencgjmq1d6oO2j8Jlnxr50Txpvx3nNpTIsiTD7bHRLJJp1YVJ7XBRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8FtmcG6; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-479ccc89792so3266433137.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712654551; x=1713259351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFje2M9/40QnlMN6BEmY41lT0dxyYIrB11kfQDhgWsc=;
        b=H8FtmcG6kxWiLEKUGm6XdxOrLURgstmQIy0FDD+9wWS0kEPY05TTkjXFge56ejB1pW
         TX9N8aKZ/qZ/4bttAqlbdi9zgaxLaIQWZUTKJYk8gVIcbqdmybMB56ReWFsPCSzQsIug
         ybwLSdmUZU8le2HWe3yQexmmwcYGpkZ1dhP8mdT/pgY3MN6tMO7bmE7WLYffuAFm9ZIm
         FVj8wHw3qq7YbFiMl381tue8LKoHivqcuBTZf/aQ0gaXlVPQ4qh/7YSescpZGh2ocnFg
         95qWsPyBoFbyVW9IgxZ0zfoyFHdyy/YcWc5oajQL08+KKE92y/5WOULxeB+mqUYxZjar
         GSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712654551; x=1713259351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFje2M9/40QnlMN6BEmY41lT0dxyYIrB11kfQDhgWsc=;
        b=TyCVtqwzlw1t1M57yu3xYU2M+AI7zAMT9Ga8cKB3fZa+/sSq/VAwiHZ6gt9/rdiKSf
         5OsMfjKIVtMypLCT0FWb8bElg1aDufDndQle69n1mh/S9WOPaWRWmrgYucuo/xHPIrwL
         4lCXJPETkG5nmrv/uhWU8XaZ2rAWNj/q686xx53qyOrx27PwTO2xgSZjMIvbZlewMlED
         r33jCEEVUojDD79imnlcYVQ7bmOeAVlIRXoRR+N6a3DTA73d6pBpRfdLkQy8OYmS8UVH
         JfYPLFjS4u4avg/rHJFYzGTBw3uep5LZbfTrvkcfEOEDLUqRZLIE/SD9doQ1S+ua4c7U
         QwfA==
X-Forwarded-Encrypted: i=1; AJvYcCW+zHlqVxmGR7QEQr+H4D/IWJt8Rn46Jd50RdVPXYEM/b0QLXfbdQhNNkEvsaev0gUE7EmfdRP5EQ13IQSgFPByrsRiprG3mq/eP8j4
X-Gm-Message-State: AOJu0YzsiUQD9u9Rz6YAoFit+7m3ibZeRVgQq4fTmB6a7RLtxQv1KfCA
	X51+TxcMK59pnIyYQdUJ/jZioMVThdr9UWvmWbuQTBHBUFaSM4q1ZIajaKpoWsgyGMAOTJbBE+y
	2C448XWD7OP0cEmrKR1fxR0kunac=
X-Google-Smtp-Source: AGHT+IFBicjJw3w+HVzH6nA33AVfGdoXgqq+/dkb6zWGdAPLodbtJFmfmAbdMIJlGlAI02JJNrlrgRrAcCCDjeDIOFk=
X-Received: by 2002:a05:6102:4716:b0:47a:150a:1fa9 with SMTP id
 ei22-20020a056102471600b0047a150a1fa9mr738879vsb.12.1712654551532; Tue, 09
 Apr 2024 02:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408183946.2991168-1-ryan.roberts@arm.com>
 <20240408183946.2991168-3-ryan.roberts@arm.com> <CAGsJ_4xMaO8AWMGc4Od-FLWBhhT-u8f7QbR11VsqD0uqH3Kp6g@mail.gmail.com>
In-Reply-To: <CAGsJ_4xMaO8AWMGc4Od-FLWBhhT-u8f7QbR11VsqD0uqH3Kp6g@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 9 Apr 2024 21:22:20 +1200
Message-ID: <CAGsJ_4wpu2Nq0y3z7LYjPLJ1ZBi+BNRNKkyUPsXKDAg1POLjLA@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] mm: swap: free_swap_and_cache_nr() as batched free_swap_and_cache()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, 
	Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 8:51=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Tue, Apr 9, 2024 at 6:40=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
> >
> > Now that we no longer have a convenient flag in the cluster to determin=
e
> > if a folio is large, free_swap_and_cache() will take a reference and
> > lock a large folio much more often, which could lead to contention and
> > (e.g.) failure to split large folios, etc.
> >
> > Let's solve that problem by batch freeing swap and cache with a new
> > function, free_swap_and_cache_nr(), to free a contiguous range of swap
> > entries together. This allows us to first drop a reference to each swap
> > slot before we try to release the cache folio. This means we only try t=
o
> > release the folio once, only taking the reference and lock once - much
> > better than the previous 512 times for the 2M THP case.
> >
> > Contiguous swap entries are gathered in zap_pte_range() and
> > madvise_free_pte_range() in a similar way to how present ptes are
> > already gathered in zap_pte_range().
> >
> > While we are at it, let's simplify by converting the return type of bot=
h
> > functions to void. The return value was used only by zap_pte_range() to
> > print a bad pte, and was ignored by everyone else, so the extra
> > reporting wasn't exactly guaranteed. We will still get the warning with
> > most of the information from get_swap_device(). With the batch version,
> > we wouldn't know which pte was bad anyway so could print the wrong one.
> >
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> >  include/linux/pgtable.h | 29 ++++++++++++
> >  include/linux/swap.h    | 12 +++--
> >  mm/internal.h           | 63 ++++++++++++++++++++++++++
> >  mm/madvise.c            | 12 +++--
> >  mm/memory.c             | 13 +++---
> >  mm/swapfile.c           | 97 +++++++++++++++++++++++++++++++++--------
> >  6 files changed, 195 insertions(+), 31 deletions(-)
> >
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index a3fc8150b047..75096025fe52 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -708,6 +708,35 @@ static inline void pte_clear_not_present_full(stru=
ct mm_struct *mm,
> >  }
> >  #endif
> >
> > +#ifndef clear_not_present_full_ptes
> > +/**
> > + * clear_not_present_full_ptes - Clear multiple not present PTEs which=
 are
> > + *                              consecutive in the pgtable.
> > + * @mm: Address space the ptes represent.
> > + * @addr: Address of the first pte.
> > + * @ptep: Page table pointer for the first entry.
> > + * @nr: Number of entries to clear.
> > + * @full: Whether we are clearing a full mm.
> > + *
> > + * May be overridden by the architecture; otherwise, implemented as a =
simple
> > + * loop over pte_clear_not_present_full().
> > + *
> > + * Context: The caller holds the page table lock.  The PTEs are all no=
t present.
> > + * The PTEs are all in the same PMD.
> > + */
> > +static inline void clear_not_present_full_ptes(struct mm_struct *mm,
> > +               unsigned long addr, pte_t *ptep, unsigned int nr, int f=
ull)
> > +{
> > +       for (;;) {
> > +               pte_clear_not_present_full(mm, addr, ptep, full);
> > +               if (--nr =3D=3D 0)
> > +                       break;
> > +               ptep++;
> > +               addr +=3D PAGE_SIZE;
> > +       }
> > +}
> > +#endif
> > +
> >  #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
> >  extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
> >                               unsigned long address,
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index f6f78198f000..5737236dc3ce 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -471,7 +471,7 @@ extern int swap_duplicate(swp_entry_t);
> >  extern int swapcache_prepare(swp_entry_t);
> >  extern void swap_free(swp_entry_t);
> >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> > -extern int free_swap_and_cache(swp_entry_t);
> > +extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> >  int swap_type_of(dev_t device, sector_t offset);
> >  int find_first_swap(dev_t *device);
> >  extern unsigned int count_swap_pages(int, int);
> > @@ -520,8 +520,9 @@ static inline void put_swap_device(struct swap_info=
_struct *si)
> >  #define free_pages_and_swap_cache(pages, nr) \
> >         release_pages((pages), (nr));
> >
> > -/* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=3D0 */
> > -#define free_swap_and_cache(e) is_pfn_swap_entry(e)
> > +static inline void free_swap_and_cache_nr(swp_entry_t entry, int nr)
> > +{
> > +}
> >
> >  static inline void free_swap_cache(struct folio *folio)
> >  {
> > @@ -589,6 +590,11 @@ static inline int add_swap_extent(struct swap_info=
_struct *sis,
> >  }
> >  #endif /* CONFIG_SWAP */
> >
> > +static inline void free_swap_and_cache(swp_entry_t entry)
> > +{
> > +       free_swap_and_cache_nr(entry, 1);
> > +}
> > +
> >  #ifdef CONFIG_MEMCG
> >  static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
> >  {
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 3bdc8693b54f..de68705624b0 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -11,6 +11,8 @@
> >  #include <linux/mm.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/rmap.h>
> > +#include <linux/swap.h>
> > +#include <linux/swapops.h>
> >  #include <linux/tracepoint-defs.h>
> >
> >  struct folio_batch;
> > @@ -189,6 +191,67 @@ static inline int folio_pte_batch(struct folio *fo=
lio, unsigned long addr,
> >
> >         return min(ptep - start_ptep, max_nr);
> >  }
> > +
> > +/**
> > + * pte_next_swp_offset - Increment the swap entry offset field of a sw=
ap pte.
> > + * @pte: The initial pte state; is_swap_pte(pte) must be true.
> > + *
> > + * Increments the swap offset, while maintaining all other fields, inc=
luding
> > + * swap type, and any swp pte bits. The resulting pte is returned.
> > + */
> > +static inline pte_t pte_next_swp_offset(pte_t pte)
> > +{
> > +       swp_entry_t entry =3D pte_to_swp_entry(pte);
> > +       pte_t new =3D __swp_entry_to_pte(__swp_entry(swp_type(entry),
> > +                                                  swp_offset(entry) + =
1));
> > +
> > +       if (pte_swp_soft_dirty(pte))
> > +               new =3D pte_swp_mksoft_dirty(new);
> > +       if (pte_swp_exclusive(pte))
> > +               new =3D pte_swp_mkexclusive(new);
> > +       if (pte_swp_uffd_wp(pte))
> > +               new =3D pte_swp_mkuffd_wp(new);
>
> I don't quite understand this. If this page table entry is exclusive,
> will its subsequent page table entry also be exclusive without
> question?
> in try_to_unmap_one, exclusive is per-subpage but not per-folio:
>
>                 anon_exclusive =3D folio_test_anon(folio) &&
>                                  PageAnonExclusive(subpage);
>
> same questions also for diry, wp etc.

Sorry for the noise. you are right. based on your new version, I think I sh=
ould
entirely drop:

[PATCH v2 3/5] mm: swap_pte_batch: add an output argument to reture if
all swap entries are exclusive

https://lore.kernel.org/linux-mm/20240409082631.187483-4-21cnbao@gmail.com/

>
> > +
> > +       return new;
> > +}
> > +
> > +/**
> > + * swap_pte_batch - detect a PTE batch for a set of contiguous swap en=
tries
> > + * @start_ptep: Page table pointer for the first entry.
> > + * @max_nr: The maximum number of table entries to consider.
> > + * @pte: Page table entry for the first entry.
> > + *
> > + * Detect a batch of contiguous swap entries: consecutive (non-present=
) PTEs
> > + * containing swap entries all with consecutive offsets and targeting =
the same
> > + * swap type, all with matching swp pte bits.
> > + *
> > + * max_nr must be at least one and must be limited by the caller so sc=
anning
> > + * cannot exceed a single page table.
> > + *
> > + * Return: the number of table entries in the batch.
> > + */
> > +static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t =
pte)
> > +{
> > +       pte_t expected_pte =3D pte_next_swp_offset(pte);
> > +       const pte_t *end_ptep =3D start_ptep + max_nr;
> > +       pte_t *ptep =3D start_ptep + 1;
> > +
> > +       VM_WARN_ON(max_nr < 1);
> > +       VM_WARN_ON(!is_swap_pte(pte));
> > +       VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));
> > +
> > +       while (ptep < end_ptep) {
> > +               pte =3D ptep_get(ptep);
> > +
> > +               if (!pte_same(pte, expected_pte))
> > +                       break;
> > +
> > +               expected_pte =3D pte_next_swp_offset(expected_pte);
> > +               ptep++;
> > +       }
> > +
> > +       return ptep - start_ptep;
> > +}
> >  #endif /* CONFIG_MMU */
> >
> >  void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 1f77a51baaac..5011ecb24344 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -628,6 +628,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsig=
ned long addr,
> >         struct folio *folio;
> >         int nr_swap =3D 0;
> >         unsigned long next;
> > +       int nr, max_nr;
> >
> >         next =3D pmd_addr_end(addr, end);
> >         if (pmd_trans_huge(*pmd))
> > @@ -640,7 +641,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsig=
ned long addr,
> >                 return 0;
> >         flush_tlb_batched_pending(mm);
> >         arch_enter_lazy_mmu_mode();
> > -       for (; addr !=3D end; pte++, addr +=3D PAGE_SIZE) {
> > +       for (; addr !=3D end; pte +=3D nr, addr +=3D PAGE_SIZE * nr) {
> > +               nr =3D 1;
> >                 ptent =3D ptep_get(pte);
> >
> >                 if (pte_none(ptent))
> > @@ -655,9 +657,11 @@ static int madvise_free_pte_range(pmd_t *pmd, unsi=
gned long addr,
> >
> >                         entry =3D pte_to_swp_entry(ptent);
> >                         if (!non_swap_entry(entry)) {
> > -                               nr_swap--;
> > -                               free_swap_and_cache(entry);
> > -                               pte_clear_not_present_full(mm, addr, pt=
e, tlb->fullmm);
> > +                               max_nr =3D (end - addr) / PAGE_SIZE;
> > +                               nr =3D swap_pte_batch(pte, max_nr, pten=
t);
> > +                               nr_swap -=3D nr;
> > +                               free_swap_and_cache_nr(entry, nr);
> > +                               clear_not_present_full_ptes(mm, addr, p=
te, nr, tlb->fullmm);
> >                         } else if (is_hwpoison_entry(entry) ||
> >                                    is_poisoned_swp_entry(entry)) {
> >                                 pte_clear_not_present_full(mm, addr, pt=
e, tlb->fullmm);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index b98e4d907a14..0db2aa066a5a 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1637,12 +1637,13 @@ static unsigned long zap_pte_range(struct mmu_g=
ather *tlb,
> >                                 folio_remove_rmap_pte(folio, page, vma)=
;
> >                         folio_put(folio);
> >                 } else if (!non_swap_entry(entry)) {
> > -                       /* Genuine swap entry, hence a private anon pag=
e */
> > +                       max_nr =3D (end - addr) / PAGE_SIZE;
> > +                       nr =3D swap_pte_batch(pte, max_nr, ptent);
> > +                       /* Genuine swap entries, hence a private anon p=
ages */
> >                         if (!should_zap_cows(details))
> >                                 continue;
> > -                       rss[MM_SWAPENTS]--;
> > -                       if (unlikely(!free_swap_and_cache(entry)))
> > -                               print_bad_pte(vma, addr, ptent, NULL);
> > +                       rss[MM_SWAPENTS] -=3D nr;
> > +                       free_swap_and_cache_nr(entry, nr);
> >                 } else if (is_migration_entry(entry)) {
> >                         folio =3D pfn_swap_entry_folio(entry);
> >                         if (!should_zap_folio(details, folio))
> > @@ -1665,8 +1666,8 @@ static unsigned long zap_pte_range(struct mmu_gat=
her *tlb,
> >                         pr_alert("unrecognized swap entry 0x%lx\n", ent=
ry.val);
> >                         WARN_ON_ONCE(1);
> >                 }
> > -               pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> > -               zap_install_uffd_wp_if_needed(vma, addr, pte, 1, detail=
s, ptent);
> > +               clear_not_present_full_ptes(mm, addr, pte, nr, tlb->ful=
lmm);
> > +               zap_install_uffd_wp_if_needed(vma, addr, pte, nr, detai=
ls, ptent);
> >         } while (pte +=3D nr, addr +=3D PAGE_SIZE * nr, addr !=3D end);
> >
> >         add_mm_rss_vec(mm, rss);
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 1ded6d1dcab4..20c45757f2b2 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -130,7 +130,11 @@ static inline unsigned char swap_count(unsigned ch=
ar ent)
> >  /* Reclaim the swap entry if swap is getting full*/
> >  #define TTRS_FULL              0x4
> >
> > -/* returns 1 if swap entry is freed */
> > +/*
> > + * returns number of pages in the folio that backs the swap entry. If =
positive,
> > + * the folio was reclaimed. If negative, the folio was not reclaimed. =
If 0, no
> > + * folio was associated with the swap entry.
> > + */
> >  static int __try_to_reclaim_swap(struct swap_info_struct *si,
> >                                  unsigned long offset, unsigned long fl=
ags)
> >  {
> > @@ -155,6 +159,7 @@ static int __try_to_reclaim_swap(struct swap_info_s=
truct *si,
> >                         ret =3D folio_free_swap(folio);
> >                 folio_unlock(folio);
> >         }
> > +       ret =3D ret ? folio_nr_pages(folio) : -folio_nr_pages(folio);
> >         folio_put(folio);
> >         return ret;
> >  }
> > @@ -895,7 +900,7 @@ static int scan_swap_map_slots(struct swap_info_str=
uct *si,
> >                 swap_was_freed =3D __try_to_reclaim_swap(si, offset, TT=
RS_ANYWAY);
> >                 spin_lock(&si->lock);
> >                 /* entry was freed successfully, try to use this again =
*/
> > -               if (swap_was_freed)
> > +               if (swap_was_freed > 0)
> >                         goto checks;
> >                 goto scan; /* check next one */
> >         }
> > @@ -1572,32 +1577,88 @@ bool folio_free_swap(struct folio *folio)
> >         return true;
> >  }
> >
> > -/*
> > - * Free the swap entry like above, but also try to
> > - * free the page cache entry if it is the last user.
> > +/**
> > + * free_swap_and_cache_nr() - Release reference on range of swap entri=
es and
> > + *                            reclaim their cache if no more reference=
s remain.
> > + * @entry: First entry of range.
> > + * @nr: Number of entries in range.
> > + *
> > + * For each swap entry in the contiguous range, release a reference. I=
f any swap
> > + * entries become free, try to reclaim their underlying folios, if pre=
sent. The
> > + * offset range is defined by [entry.offset, entry.offset + nr).
> >   */
> > -int free_swap_and_cache(swp_entry_t entry)
> > +void free_swap_and_cache_nr(swp_entry_t entry, int nr)
> >  {
> > -       struct swap_info_struct *p;
> > +       const unsigned long start_offset =3D swp_offset(entry);
> > +       const unsigned long end_offset =3D start_offset + nr;
> > +       unsigned int type =3D swp_type(entry);
> > +       struct swap_info_struct *si;
> > +       bool any_only_cache =3D false;
> > +       unsigned long offset;
> >         unsigned char count;
> >
> >         if (non_swap_entry(entry))
> > -               return 1;
> > +               return;
> >
> > -       p =3D get_swap_device(entry);
> > -       if (p) {
> > -               if (WARN_ON(data_race(!p->swap_map[swp_offset(entry)]))=
) {
> > -                       put_swap_device(p);
> > -                       return 0;
> > +       si =3D get_swap_device(entry);
> > +       if (!si)
> > +               return;
> > +
> > +       if (WARN_ON(end_offset > si->max))
> > +               goto out;
> > +
> > +       /*
> > +        * First free all entries in the range.
> > +        */
> > +       for (offset =3D start_offset; offset < end_offset; offset++) {
> > +               if (data_race(si->swap_map[offset])) {
> > +                       count =3D __swap_entry_free(si, swp_entry(type,=
 offset));
> > +                       if (count =3D=3D SWAP_HAS_CACHE)
> > +                               any_only_cache =3D true;
> > +               } else {
> > +                       WARN_ON_ONCE(1);
> >                 }
> > +       }
> > +
> > +       /*
> > +        * Short-circuit the below loop if none of the entries had thei=
r
> > +        * reference drop to zero.
> > +        */
> > +       if (!any_only_cache)
> > +               goto out;
> >
> > -               count =3D __swap_entry_free(p, entry);
> > -               if (count =3D=3D SWAP_HAS_CACHE)
> > -                       __try_to_reclaim_swap(p, swp_offset(entry),
> > +       /*
> > +        * Now go back over the range trying to reclaim the swap cache.=
 This is
> > +        * more efficient for large folios because we will only try to =
reclaim
> > +        * the swap once per folio in the common case. If we do
> > +        * __swap_entry_free() and __try_to_reclaim_swap() in the same =
loop, the
> > +        * latter will get a reference and lock the folio for every ind=
ividual
> > +        * page but will only succeed once the swap slot for every subp=
age is
> > +        * zero.
> > +        */
> > +       for (offset =3D start_offset; offset < end_offset; offset +=3D =
nr) {
> > +               nr =3D 1;
> > +               if (READ_ONCE(si->swap_map[offset]) =3D=3D SWAP_HAS_CAC=
HE) {
> > +                       /*
> > +                        * Folios are always naturally aligned in swap =
so
> > +                        * advance forward to the next boundary. Zero m=
eans no
> > +                        * folio was found for the swap entry, so advan=
ce by 1
> > +                        * in this case. Negative value means folio was=
 found
> > +                        * but could not be reclaimed. Here we can stil=
l advance
> > +                        * to the next boundary.
> > +                        */
> > +                       nr =3D __try_to_reclaim_swap(si, offset,
> >                                               TTRS_UNMAPPED | TTRS_FULL=
);
> > -               put_swap_device(p);
> > +                       if (nr =3D=3D 0)
> > +                               nr =3D 1;
> > +                       else if (nr < 0)
> > +                               nr =3D -nr;
> > +                       nr =3D ALIGN(offset + 1, nr) - offset;
> > +               }
> >         }
> > -       return p !=3D NULL;
> > +
> > +out:
> > +       put_swap_device(si);
> >  }
> >
> >  #ifdef CONFIG_HIBERNATION
> > --
> > 2.25.1
> >
>
> Thanks
> Barry

