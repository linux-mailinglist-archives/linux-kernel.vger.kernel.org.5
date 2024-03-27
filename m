Return-Path: <linux-kernel+bounces-120377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75FB88D667
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670901F2A6BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB6E20B0E;
	Wed, 27 Mar 2024 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/I/nlgT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE922089
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521162; cv=none; b=kmxKQyXTkNUrIXIhOfeNrL8Z2+sjt1TsQxjck87gPj82oj5TdpQhpqcMPKNKlslSEPzY8tAIrydaPle/zqiam/y2OOX7aiHenSVN/7q9hzoRZWwYqgrWQVm7jx1htr4AJzU3hkImcy5WI3gYh2jRpl0+kPsxuFuSfCYNGHkbfQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521162; c=relaxed/simple;
	bh=BsWibFsPr6AJVwQBOI/XULxd/ZV584eWufvBF+1J3Z0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OKhqzYzOsenRcP3liEAr7u7PSwkwMrmsq1UcSvnDgSp0YObB/+eqOW/9i3wTUgk3fMshnLgGE9ks0NvtN6zxJt2uBrruhdDLy+GEuEtIvnnW03O/jDmRQ97rUPH5KpP0hiQ/Qo9qM6OEmeZ2YOUS4sJ685QtwP1OIxO1u5hlbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/I/nlgT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711521160; x=1743057160;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=BsWibFsPr6AJVwQBOI/XULxd/ZV584eWufvBF+1J3Z0=;
  b=h/I/nlgTqjib5UfAJkHh1ouKzelDnwXKTGvmFruADs7PwuaXPFbrY2gi
   m0V7FJmqgSvKPZAWd95H01Tj2QhyOxp74oiTXl/BkNQTvr3lfPEBfBu+L
   JY9zBTB6n2qH4+THqY4wCJVO9AUFsFuR9aoYOS6T0A4d/JyDNVEs9GROg
   gf573fd5Sbg5anCWkKGBpCmu6+3TASKrDncbs7rGjVBCtTy4G/kenQqQo
   5Itml9GR9hC0siLlKvNWRnf2wxsBvkCvp5goeKIP9rCgVfMravxJVQKk9
   PN/J/ag8qn30TXsGxLnm43hgqid5xB+3rXhFU7W4d+lI8+Gj8RA1XZq6e
   w==;
X-CSE-ConnectionGUID: zmMT9tsDSqaWCBwSyN9IOw==
X-CSE-MsgGUID: DBNe650DSAKOKox1qTdksw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17333446"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="17333446"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 23:32:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16181127"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 23:32:35 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Chris Li
 <chrisl@kernel.org>,  Minchan Kim <minchan@kernel.org>,  Barry Song
 <v-songbaohua@oppo.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Yu Zhao
 <yuzhao@google.com>,  SeongJae Park <sj@kernel.org>,  David Hildenbrand
 <david@redhat.com>,  Yosry Ahmed <yosryahmed@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Matthew Wilcox <willy@infradead.org>,  Nhat Pham
 <nphamcs@gmail.com>,  Chengming Zhou <zhouchengming@bytedance.com>,
  Andrew Morton <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/10] mm/swap: remove cache bypass swapin
In-Reply-To: <20240326185032.72159-5-ryncsn@gmail.com> (Kairui Song's message
	of "Wed, 27 Mar 2024 02:50:26 +0800")
References: <20240326185032.72159-1-ryncsn@gmail.com>
	<20240326185032.72159-5-ryncsn@gmail.com>
Date: Wed, 27 Mar 2024 14:30:42 +0800
Message-ID: <87v858mbjh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> We used to have the cache bypass swapin path for better performance,
> but by removing it, more optimization can be applied and have
> an even better overall performance and less hackish.
>
> And these optimizations are not easily doable or not doable at all
> without this.
>
> This patch simply removes it, and the performance will drop heavily
> for simple swapin, things won't get this worse for real workloads
> but still observable. Following commits will fix this and archive a
> better performance.
>
> Swapout/in 30G zero pages from ZRAM (This mostly measures overhead
> of swap path itself, because zero pages are not compressed but simply
> recorded in ZRAM, and performance drops more as SWAP device is getting
> full):
>
> Test result of sequential swapin/out:
>
>                Before (us)        After (us)
> Swapout:       33619409           33624641
> Swapin:        32393771           41614858 (-28.4%)
> Swapout (THP): 7817909            7795530
> Swapin (THP) : 32452387           41708471 (-28.4%)
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     | 18 ++++-------------
>  mm/swap.h       | 10 +++++-----
>  mm/swap_state.c | 53 ++++++++++---------------------------------------
>  mm/swapfile.c   | 13 ------------
>  4 files changed, 19 insertions(+), 75 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index dfdb620a9123..357d239ee2f6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3932,7 +3932,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	struct page *page;
>  	struct swap_info_struct *si = NULL;
>  	rmap_t rmap_flags = RMAP_NONE;
> -	bool need_clear_cache = false;
>  	bool exclusive = false;
>  	swp_entry_t entry;
>  	pte_t pte;
> @@ -4000,14 +3999,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (!folio) {
>  		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>  		    __swap_count(entry) == 1) {
> -			/* skip swapcache and readahead */
>  			folio = swapin_direct(entry, GFP_HIGHUSER_MOVABLE, vmf);
> -			if (PTR_ERR(folio) == -EBUSY)
> -				goto out;
> -			need_clear_cache = true;
>  		} else {
>  			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);
> -			swapcache = folio;
>  		}
>  
>  		if (!folio) {
> @@ -4023,6 +4017,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			goto unlock;
>  		}
>  
> +		swapcache = folio;
>  		page = folio_file_page(folio, swp_offset(entry));
>  
>  		/* Had to read the page from swap area: Major fault */
> @@ -4187,7 +4182,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	vmf->orig_pte = pte;
>  
>  	/* ksm created a completely new copy */
> -	if (unlikely(folio != swapcache && swapcache)) {
> +	if (unlikely(folio != swapcache)) {
>  		folio_add_new_anon_rmap(folio, vma, vmf->address);
>  		folio_add_lru_vma(folio, vma);
>  	} else {
> @@ -4201,7 +4196,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
>  
>  	folio_unlock(folio);
> -	if (folio != swapcache && swapcache) {
> +	if (folio != swapcache) {
>  		/*
>  		 * Hold the lock to avoid the swap entry to be reused
>  		 * until we take the PT lock for the pte_same() check
> @@ -4227,9 +4222,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (vmf->pte)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out:
> -	/* Clear the swap cache pin for direct swapin after PTL unlock */
> -	if (need_clear_cache)
> -		swapcache_clear(si, entry);
>  	if (si)
>  		put_swap_device(si);
>  	return ret;
> @@ -4240,12 +4232,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	folio_unlock(folio);
>  out_release:
>  	folio_put(folio);
> -	if (folio != swapcache && swapcache) {
> +	if (folio != swapcache) {
>  		folio_unlock(swapcache);
>  		folio_put(swapcache);
>  	}
> -	if (need_clear_cache)
> -		swapcache_clear(si, entry);
>  	if (si)
>  		put_swap_device(si);
>  	return ret;
> diff --git a/mm/swap.h b/mm/swap.h
> index aee134907a70..ac9573b03432 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -41,7 +41,6 @@ void __delete_from_swap_cache(struct folio *folio,
>  void delete_from_swap_cache(struct folio *folio);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>  				  unsigned long end);
> -void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
>  struct folio *swap_cache_get_folio(swp_entry_t entry,
>  		struct vm_area_struct *vma, unsigned long addr);
>  struct folio *filemap_get_incore_folio(struct address_space *mapping,
> @@ -100,14 +99,15 @@ static inline struct folio *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
>  {
>  	return NULL;
>  }
> -
> -static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
> +static inline struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
> +			struct vm_fault *vmf);
>  {
> -	return 0;
> +	return NULL;
>  }
>  
> -static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> +static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
>  {
> +	return 0;
>  }
>  
>  static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 2a9c6bdff5ea..49ef6250f676 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -880,61 +880,28 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>  }
>  
>  /**
> - * swapin_direct - swap in folios skipping swap cache and readahead
> + * swapin_direct - swap in folios skipping readahead
>   * @entry: swap entry of this memory
>   * @gfp_mask: memory allocation flags
>   * @vmf: fault information
>   *
> - * Returns the struct folio for entry and addr after the swap entry is read
> - * in.
> + * Returns the folio for entry after it is read in.
>   */
>  struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
>  			    struct vm_fault *vmf)
>  {
> -	struct vm_area_struct *vma = vmf->vma;
> +	struct mempolicy *mpol;
>  	struct folio *folio;
> -	void *shadow = NULL;
> -
> -	/*
> -	 * Prevent parallel swapin from proceeding with
> -	 * the cache flag. Otherwise, another thread may
> -	 * finish swapin first, free the entry, and swapout
> -	 * reusing the same entry. It's undetectable as
> -	 * pte_same() returns true due to entry reuse.
> -	 */
> -	if (swapcache_prepare(entry)) {
> -		/* Relax a bit to prevent rapid repeated page faults */
> -		schedule_timeout_uninterruptible(1);
> -		return ERR_PTR(-EBUSY);
> -	}
> -
> -	/* skip swapcache */
> -	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> -				vma, vmf->address, false);
> -	if (folio) {
> -		__folio_set_locked(folio);
> -		__folio_set_swapbacked(folio);
> -
> -		if (mem_cgroup_swapin_charge_folio(folio,
> -					vma->vm_mm, GFP_KERNEL,
> -					entry)) {
> -			folio_unlock(folio);
> -			folio_put(folio);
> -			return NULL;
> -		}
> -		mem_cgroup_swapin_uncharge_swap(entry);
> -
> -		shadow = get_shadow_from_swap_cache(entry);
> -		if (shadow)
> -			workingset_refault(folio, shadow);
> +	bool page_allocated;
> +	pgoff_t ilx;
>  
> -		folio_add_lru(folio);
> +	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> +	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
> +					&page_allocated, false);
> +	mpol_cond_put(mpol);
>  
> -		/* To provide entry to swap_read_folio() */
> -		folio->swap = entry;
> +	if (page_allocated)
>  		swap_read_folio(folio, true, NULL);
> -		folio->private = NULL;
> -	}
>  
>  	return folio;
>  }

This looks similar as read_swap_cache_async().  Can we merge them?

And, we should avoid to readahead in swapin_readahead() or
swap_vma_readahead() for SWP_SYNCHRONOUS_IO anyway.  So, it appears that
we can change and use swapin_readahead() directly?

> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4dd894395a0f..ae8d3aa05df7 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3389,19 +3389,6 @@ int swapcache_prepare(swp_entry_t entry)
>  	return __swap_duplicate(entry, SWAP_HAS_CACHE);
>  }
>  
> -void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> -{
> -	struct swap_cluster_info *ci;
> -	unsigned long offset = swp_offset(entry);
> -	unsigned char usage;
> -
> -	ci = lock_cluster_or_swap_info(si, offset);
> -	usage = __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
> -	unlock_cluster_or_swap_info(si, ci);
> -	if (!usage)
> -		free_swap_slot(entry);
> -}
> -
>  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
>  {
>  	return swap_type_to_swap_info(swp_type(entry));

--
Best Regards,
Huang, Ying

