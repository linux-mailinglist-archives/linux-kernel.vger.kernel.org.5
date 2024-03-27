Return-Path: <linux-kernel+bounces-120433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1B188D748
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004051C2362B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA962262B;
	Wed, 27 Mar 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFUxrOZT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E31849
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711524681; cv=none; b=LD04UEwxx5Tct9EFzN5jRVgJ+8ykBM7u3muaS8QcCR68/kDEHfbTatgm5nJtZ16aVNgFIIxFfrffiMMVafqz4umC0axzb2nQuyGaWv+SRzXaer5w2vtCJxpg4uysexkV9RPR8cao8VWVNcdu8941oWT2WoBU8Kw92NM4yZfUF4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711524681; c=relaxed/simple;
	bh=jA/U0eowmhkvePD2PDKZbHPIlUMQ8vsrUVqd0Nrq2g0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B78juySDndU1LMqCDbJF53IOaqMcEuymArNFpXBwnJkZsIEtiN3QRTW0bhc8hgrhQY/jMIgie+JZju96/Lx8jXs3TNUBTFCHYo5U0bFG9iDeiywcO5u9bkdN+qyUdf11a43Vh23Ss8UaByL0udOzqKx3Z2mF+zEr3l2cTVeso54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFUxrOZT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711524679; x=1743060679;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=jA/U0eowmhkvePD2PDKZbHPIlUMQ8vsrUVqd0Nrq2g0=;
  b=HFUxrOZTsf1CzpIPIw+1JniSfqclncfkvGjYpcXnIPN5aaAR+y19pA1H
   tB+IoDGuE41/8d83jibKkq1vtmtf/eBRFxIow0Mr/XLAV5oMdC32vzyzd
   log03hmXI1ZbmFj7hhNX9pkwZV6C6s+qP5asnhWeqZrzmRj18L3Vvpp2f
   j0ZYd05OFQ51o9m44kEmM3FJ99eSUGCS3dd/SL4+LW6LGtO+sUWS7oUIk
   aVszonDOHdB/F0ry8S6AiFrIacFAZcbaspPnI5Ls0qrbROC1LdnfNHkxw
   GPz9zdAbmwxNwvz6zXTosMtOlpmshgRojdCaus7VeWexTzXAHdKrReAhz
   w==;
X-CSE-ConnectionGUID: bsGT5ve5TpaNl7qfJk5owQ==
X-CSE-MsgGUID: Zb0eW/loTaOUbUcCPB5luA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6739526"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6739526"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 00:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16305356"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 00:31:15 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Chris Li <chrisl@kernel.org>,  Minchan Kim
 <minchan@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Yu Zhao <yuzhao@google.com>,  SeongJae Park
 <sj@kernel.org>,  David Hildenbrand <david@redhat.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew
 Wilcox <willy@infradead.org>,  Nhat Pham <nphamcs@gmail.com>,  Chengming
 Zhou <zhouchengming@bytedance.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/10] mm/swap: remove cache bypass swapin
In-Reply-To: <CAMgjq7B0rDp_u37XG0JWyFci6s9NmGd3gdasOwU0RRZBYTqquw@mail.gmail.com>
	(Kairui Song's message of "Wed, 27 Mar 2024 14:55:53 +0800")
References: <20240326185032.72159-1-ryncsn@gmail.com>
	<20240326185032.72159-5-ryncsn@gmail.com>
	<87v858mbjh.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7B0rDp_u37XG0JWyFci6s9NmGd3gdasOwU0RRZBYTqquw@mail.gmail.com>
Date: Wed, 27 Mar 2024 15:29:21 +0800
Message-ID: <87msqkm8tq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> On Wed, Mar 27, 2024 at 2:32=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Kairui Song <ryncsn@gmail.com> writes:
>>
>> > From: Kairui Song <kasong@tencent.com>
>> >
>> > We used to have the cache bypass swapin path for better performance,
>> > but by removing it, more optimization can be applied and have
>> > an even better overall performance and less hackish.
>> >
>> > And these optimizations are not easily doable or not doable at all
>> > without this.
>> >
>> > This patch simply removes it, and the performance will drop heavily
>> > for simple swapin, things won't get this worse for real workloads
>> > but still observable. Following commits will fix this and archive a
>> > better performance.
>> >
>> > Swapout/in 30G zero pages from ZRAM (This mostly measures overhead
>> > of swap path itself, because zero pages are not compressed but simply
>> > recorded in ZRAM, and performance drops more as SWAP device is getting
>> > full):
>> >
>> > Test result of sequential swapin/out:
>> >
>> >                Before (us)        After (us)
>> > Swapout:       33619409           33624641
>> > Swapin:        32393771           41614858 (-28.4%)
>> > Swapout (THP): 7817909            7795530
>> > Swapin (THP) : 32452387           41708471 (-28.4%)
>> >
>> > Signed-off-by: Kairui Song <kasong@tencent.com>
>> > ---
>> >  mm/memory.c     | 18 ++++-------------
>> >  mm/swap.h       | 10 +++++-----
>> >  mm/swap_state.c | 53 ++++++++++---------------------------------------
>> >  mm/swapfile.c   | 13 ------------
>> >  4 files changed, 19 insertions(+), 75 deletions(-)
>> >
>> > diff --git a/mm/memory.c b/mm/memory.c
>> > index dfdb620a9123..357d239ee2f6 100644
>> > --- a/mm/memory.c
>> > +++ b/mm/memory.c
>> > @@ -3932,7 +3932,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >       struct page *page;
>> >       struct swap_info_struct *si =3D NULL;
>> >       rmap_t rmap_flags =3D RMAP_NONE;
>> > -     bool need_clear_cache =3D false;
>> >       bool exclusive =3D false;
>> >       swp_entry_t entry;
>> >       pte_t pte;
>> > @@ -4000,14 +3999,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >       if (!folio) {
>> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>> >                   __swap_count(entry) =3D=3D 1) {
>> > -                     /* skip swapcache and readahead */
>> >                       folio =3D swapin_direct(entry, GFP_HIGHUSER_MOVA=
BLE, vmf);
>> > -                     if (PTR_ERR(folio) =3D=3D -EBUSY)
>> > -                             goto out;
>> > -                     need_clear_cache =3D true;
>> >               } else {
>> >                       folio =3D swapin_readahead(entry, GFP_HIGHUSER_M=
OVABLE, vmf);
>> > -                     swapcache =3D folio;
>> >               }
>> >
>> >               if (!folio) {
>> > @@ -4023,6 +4017,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >                       goto unlock;
>> >               }
>> >
>> > +             swapcache =3D folio;
>> >               page =3D folio_file_page(folio, swp_offset(entry));
>> >
>> >               /* Had to read the page from swap area: Major fault */
>> > @@ -4187,7 +4182,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >       vmf->orig_pte =3D pte;
>> >
>> >       /* ksm created a completely new copy */
>> > -     if (unlikely(folio !=3D swapcache && swapcache)) {
>> > +     if (unlikely(folio !=3D swapcache)) {
>> >               folio_add_new_anon_rmap(folio, vma, vmf->address);
>> >               folio_add_lru_vma(folio, vma);
>> >       } else {
>> > @@ -4201,7 +4196,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >       arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_=
pte);
>> >
>> >       folio_unlock(folio);
>> > -     if (folio !=3D swapcache && swapcache) {
>> > +     if (folio !=3D swapcache) {
>> >               /*
>> >                * Hold the lock to avoid the swap entry to be reused
>> >                * until we take the PT lock for the pte_same() check
>> > @@ -4227,9 +4222,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >       if (vmf->pte)
>> >               pte_unmap_unlock(vmf->pte, vmf->ptl);
>> >  out:
>> > -     /* Clear the swap cache pin for direct swapin after PTL unlock */
>> > -     if (need_clear_cache)
>> > -             swapcache_clear(si, entry);
>> >       if (si)
>> >               put_swap_device(si);
>> >       return ret;
>> > @@ -4240,12 +4232,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >       folio_unlock(folio);
>> >  out_release:
>> >       folio_put(folio);
>> > -     if (folio !=3D swapcache && swapcache) {
>> > +     if (folio !=3D swapcache) {
>> >               folio_unlock(swapcache);
>> >               folio_put(swapcache);
>> >       }
>> > -     if (need_clear_cache)
>> > -             swapcache_clear(si, entry);
>> >       if (si)
>> >               put_swap_device(si);
>> >       return ret;
>> > diff --git a/mm/swap.h b/mm/swap.h
>> > index aee134907a70..ac9573b03432 100644
>> > --- a/mm/swap.h
>> > +++ b/mm/swap.h
>> > @@ -41,7 +41,6 @@ void __delete_from_swap_cache(struct folio *folio,
>> >  void delete_from_swap_cache(struct folio *folio);
>> >  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>> >                                 unsigned long end);
>> > -void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
>> >  struct folio *swap_cache_get_folio(swp_entry_t entry,
>> >               struct vm_area_struct *vma, unsigned long addr);
>> >  struct folio *filemap_get_incore_folio(struct address_space *mapping,
>> > @@ -100,14 +99,15 @@ static inline struct folio *swapin_readahead(swp_=
entry_t swp, gfp_t gfp_mask,
>> >  {
>> >       return NULL;
>> >  }
>> > -
>> > -static inline int swap_writepage(struct page *p, struct writeback_con=
trol *wbc)
>> > +static inline struct folio *swapin_direct(swp_entry_t entry, gfp_t fl=
ag,
>> > +                     struct vm_fault *vmf);
>> >  {
>> > -     return 0;
>> > +     return NULL;
>> >  }
>> >
>> > -static inline void swapcache_clear(struct swap_info_struct *si, swp_e=
ntry_t entry)
>> > +static inline int swap_writepage(struct page *p, struct writeback_con=
trol *wbc)
>> >  {
>> > +     return 0;
>> >  }
>> >
>> >  static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
>> > diff --git a/mm/swap_state.c b/mm/swap_state.c
>> > index 2a9c6bdff5ea..49ef6250f676 100644
>> > --- a/mm/swap_state.c
>> > +++ b/mm/swap_state.c
>> > @@ -880,61 +880,28 @@ static struct folio *swap_vma_readahead(swp_entr=
y_t targ_entry, gfp_t gfp_mask,
>> >  }
>> >
>> >  /**
>> > - * swapin_direct - swap in folios skipping swap cache and readahead
>> > + * swapin_direct - swap in folios skipping readahead
>> >   * @entry: swap entry of this memory
>> >   * @gfp_mask: memory allocation flags
>> >   * @vmf: fault information
>> >   *
>> > - * Returns the struct folio for entry and addr after the swap entry i=
s read
>> > - * in.
>> > + * Returns the folio for entry after it is read in.
>> >   */
>> >  struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
>> >                           struct vm_fault *vmf)
>> >  {
>> > -     struct vm_area_struct *vma =3D vmf->vma;
>> > +     struct mempolicy *mpol;
>> >       struct folio *folio;
>> > -     void *shadow =3D NULL;
>> > -
>> > -     /*
>> > -      * Prevent parallel swapin from proceeding with
>> > -      * the cache flag. Otherwise, another thread may
>> > -      * finish swapin first, free the entry, and swapout
>> > -      * reusing the same entry. It's undetectable as
>> > -      * pte_same() returns true due to entry reuse.
>> > -      */
>> > -     if (swapcache_prepare(entry)) {
>> > -             /* Relax a bit to prevent rapid repeated page faults */
>> > -             schedule_timeout_uninterruptible(1);
>> > -             return ERR_PTR(-EBUSY);
>> > -     }
>> > -
>> > -     /* skip swapcache */
>> > -     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>> > -                             vma, vmf->address, false);
>> > -     if (folio) {
>> > -             __folio_set_locked(folio);
>> > -             __folio_set_swapbacked(folio);
>> > -
>> > -             if (mem_cgroup_swapin_charge_folio(folio,
>> > -                                     vma->vm_mm, GFP_KERNEL,
>> > -                                     entry)) {
>> > -                     folio_unlock(folio);
>> > -                     folio_put(folio);
>> > -                     return NULL;
>> > -             }
>> > -             mem_cgroup_swapin_uncharge_swap(entry);
>> > -
>> > -             shadow =3D get_shadow_from_swap_cache(entry);
>> > -             if (shadow)
>> > -                     workingset_refault(folio, shadow);
>> > +     bool page_allocated;
>> > +     pgoff_t ilx;
>> >
>> > -             folio_add_lru(folio);
>> > +     mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
>> > +     folio =3D __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
>> > +                                     &page_allocated, false);
>> > +     mpol_cond_put(mpol);
>> >
>> > -             /* To provide entry to swap_read_folio() */
>> > -             folio->swap =3D entry;
>> > +     if (page_allocated)
>> >               swap_read_folio(folio, true, NULL);
>> > -             folio->private =3D NULL;
>> > -     }
>> >
>> >       return folio;
>> >  }
>>
>> This looks similar as read_swap_cache_async().  Can we merge them?
>
> Yes, that's doable. But I may have to split it out again for later
> optimizations though.
>
>>
>> And, we should avoid to readahead in swapin_readahead() or
>> swap_vma_readahead() for SWP_SYNCHRONOUS_IO anyway.  So, it appears that
>> we can change and use swapin_readahead() directly?
>
> Good point, SWP_SYNCHRONOUS_IO check can be extended more after this
> series, but readahead optimization could be another series (like the
> previous one which tried to unify readahead for shmem/anon), so I
> thought it's better to keep it untouched for now.

Just want to check whether we can reduce the special processing for
SWP_SYNCHRONOUS_IO as much as possible.

--
Best Regards,
Huang, Ying

