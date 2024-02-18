Return-Path: <linux-kernel+bounces-70291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD928595A8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38781F224E2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD41DF55;
	Sun, 18 Feb 2024 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmW/woSF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA11C2E;
	Sun, 18 Feb 2024 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708245263; cv=none; b=qG3jNSQCVVGMAl0ZL3UYQfTUP/mSnyMHYUxX0SYN+6F7leFPqYl0pGWwrqQit7TKrXVEcU9XJDvdkzok4JueOT02wX5iZ19+5SwvdSif6v1NwFRJLeLzRMao71WUciAGhR5+aj6KRgbInmUOoYPMf6ykFolfAQ7XweDTjLap4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708245263; c=relaxed/simple;
	bh=EVgsB9x0uun9RqNBetrf5j+LJUmeAGlLeOchu63WqF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pF7Qf5ZxOsSCmIofTQgR/1M/gXTVTLfbiisZLoKalzjyCYSSHT7YU1CkgS7LZhSuMngY0o0umzH0M7sBRaY1JUZsc7zfXoIlpkZGnPNCw14VPerszGsMMbmqjFqDwBLGqzvIkpGtNW6RZvfnj9lNuVMgdt/HvhmBWzNcNwtBaaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmW/woSF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708245262; x=1739781262;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=EVgsB9x0uun9RqNBetrf5j+LJUmeAGlLeOchu63WqF0=;
  b=hmW/woSFO3UXmad09r3UzubNn2nQ4Wc9tt+RbW68xbKvNpmlq53w+OJL
   E78niN0uF/6Wu6hQaUIcVhWQIJiYhu7n0ByTQzQA0evp6AEB8PiOPOtkY
   PW+YvD5oi4O19uxHpRCVA8frE/LyZIKL40kbdHGqBrv8ovIXruPPtNHv/
   5tfVOZm+9SCbst6BNmUvY9tHWHAbY0Z55Ocx0yp5XAI2KvJWRl+ycGzFV
   KnqnXKIw6N2ns8FZz2PO9v9VY6jZkzRhBODBul0h2Kz+bl1pAisAnC9JE
   KrHhPtd0qq3IVSjDaC2UNKtBRm4tGLc2E1TlUC0Lq4ZciN+yDlWXa+Dau
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="27783326"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="27783326"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 00:34:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="4583888"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 00:34:17 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Minchan Kim
 <minchan@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Barry Song
 <v-songbaohua@oppo.com>,  SeongJae Park <sj@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  stable@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
In-Reply-To: <20240216095105.14502-1-ryncsn@gmail.com> (Kairui Song's message
	of "Fri, 16 Feb 2024 17:51:05 +0800")
References: <20240216095105.14502-1-ryncsn@gmail.com>
Date: Sun, 18 Feb 2024 16:32:21 +0800
Message-ID: <87wmr2rx4a.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
> swapin the same entry at the same time, they get different pages (A, B).
> Before one thread (T0) finishes the swapin and installs page (A)
> to the PTE, another thread (T1) could finish swapin of page (B),
> swap_free the entry, then swap out the possibly modified page
> reusing the same entry. It breaks the pte_same check in (T0) because
> PTE value is unchanged, causing ABA problem. Thread (T0) will
> install a stalled page (A) into the PTE and cause data corruption.
>
> One possible callstack is like this:
>
> CPU0                                 CPU1
> ----                                 ----
> do_swap_page()                       do_swap_page() with same entry
> <direct swapin path>                 <direct swapin path>
> <alloc page A>                       <alloc page B>
> swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
> <slow on later locks or interrupt>   <finished swapin first>
> ...                                  set_pte_at()
>                                      swap_free() <- entry is free
>                                      <write to page B, now page A stalled>
>                                      <swap out page B to same swap entry>
> pte_same() <- Check pass, PTE seems
>               unchanged, but page A
>               is stalled!
> swap_free() <- page B content lost!
> set_pte_at() <- staled page A installed!
>
> And besides, for ZRAM, swap_free() allows the swap device to discard
> the entry content, so even if page (B) is not modified, if
> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> it may also cause data loss.
>
> To fix this, reuse swapcache_prepare which will pin the swap entry using
> the cache flag, and allow only one thread to pin it. Release the pin
> after PT unlocked. Racers will simply wait since it's a rare and very
> short event. A schedule() call is added to avoid wasting too much CPU
> or adding too much noise to perf statistics
>
> Other methods like increasing the swap count don't seem to be a good
> idea after some tests, that will cause racers to fall back to use the
> swap cache again. Parallel swapin using different methods leads to
> a much more complex scenario.

The swap entry may be put in swap cache by some parallel code path
anyway.  So, we always need to consider that when reasoning the code.

> Reproducer:
>
> This race issue can be triggered easily using a well constructed
> reproducer and patched brd (with a delay in read path) [1]:
>
> With latest 6.8 mainline, race caused data loss can be observed easily:
> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>   Polulating 32MB of memory region...
>   Keep swapping out...
>   Starting round 0...
>   Spawning 65536 workers...
>   32746 workers spawned, wait for done...
>   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>   Round 0 Failed, 15 data loss!
>
> This reproducer spawns multiple threads sharing the same memory region
> using a small swap device. Every two threads updates mapped pages one by
> one in opposite direction trying to create a race, with one dedicated
> thread keep swapping out the data out using madvise.
>
> The reproducer created a reproduce rate of about once every 5 minutes,
> so the race should be totally possible in production.
>
> After this patch, I ran the reproducer for over a few hundred rounds
> and no data loss observed.
>
> Performance overhead is minimal, microbenchmark swapin 10G from 32G
> zram:
>
> Before:     10934698 us
> After:      11157121 us
> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>
> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous device")
> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: stable@vger.kernel.org
>
> ---
> Update from V2:
> - Add a schedule() if raced to prevent repeated page faults wasting CPU
>   and add noise to perf statistics.
> - Use a bool to state the special case instead of reusing existing
>   variables fixing error handling [Minchan Kim].
>
> V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com/
>
> Update from V1:
> - Add some words on ZRAM case, it will discard swap content on swap_free so the race window is a bit different but cure is the same. [Barry Song]
> - Update comments make it cleaner [Huang, Ying]
> - Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]
> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO instead of "direct swapin path" [Yu Zhao]
> - Update commit message.
> - Collect Review and Acks.
>
> V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
>
>  include/linux/swap.h |  5 +++++
>  mm/memory.c          | 20 ++++++++++++++++++++
>  mm/swap.h            |  5 +++++
>  mm/swapfile.c        | 13 +++++++++++++
>  4 files changed, 43 insertions(+)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4db00ddad261..8d28f6091a32 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>  	return 0;
>  }
>  
> +static inline int swapcache_prepare(swp_entry_t swp)
> +{
> +	return 0;
> +}
> +
>  static inline void swap_free(swp_entry_t swp)
>  {
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e1f4849463a..7059230d0a54 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	struct page *page;
>  	struct swap_info_struct *si = NULL;
>  	rmap_t rmap_flags = RMAP_NONE;
> +	bool need_clear_cache = false;
>  	bool exclusive = false;
>  	swp_entry_t entry;
>  	pte_t pte;
> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (!folio) {
>  		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>  		    __swap_count(entry) == 1) {
> +			/*
> +			 * Prevent parallel swapin from proceeding with
> +			 * the cache flag. Otherwise, another thread may
> +			 * finish swapin first, free the entry, and swapout
> +			 * reusing the same entry. It's undetectable as
> +			 * pte_same() returns true due to entry reuse.
> +			 */
> +			if (swapcache_prepare(entry)) {
> +				/* Relax a bit to prevent rapid repeated page faults */
> +				schedule();

The current task may be chosen in schedule().  So, I think that we
should use cond_resched() here.

--
Best Regards,
Huang, Ying

> +				goto out;
> +			}
> +			need_clear_cache = true;
> +
>  			/* skip swapcache */
>  			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>  						vma, vmf->address, false);
> @@ -4117,6 +4132,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (vmf->pte)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out:
> +	/* Clear the swap cache pin for direct swapin after PTL unlock */
> +	if (need_clear_cache)
> +		swapcache_clear(si, entry);
>  	if (si)
>  		put_swap_device(si);
>  	return ret;
> @@ -4131,6 +4149,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		folio_unlock(swapcache);
>  		folio_put(swapcache);
>  	}
> +	if (need_clear_cache)
> +		swapcache_clear(si, entry);
>  	if (si)
>  		put_swap_device(si);
>  	return ret;
> diff --git a/mm/swap.h b/mm/swap.h
> index 758c46ca671e..fc2f6ade7f80 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -41,6 +41,7 @@ void __delete_from_swap_cache(struct folio *folio,
>  void delete_from_swap_cache(struct folio *folio);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>  				  unsigned long end);
> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
>  struct folio *swap_cache_get_folio(swp_entry_t entry,
>  		struct vm_area_struct *vma, unsigned long addr);
>  struct folio *filemap_get_incore_folio(struct address_space *mapping,
> @@ -97,6 +98,10 @@ static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
>  	return 0;
>  }
>  
> +static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> +{
> +}
> +
>  static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
>  		struct vm_area_struct *vma, unsigned long addr)
>  {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 556ff7347d5f..746aa9da5302 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3365,6 +3365,19 @@ int swapcache_prepare(swp_entry_t entry)
>  	return __swap_duplicate(entry, SWAP_HAS_CACHE);
>  }
>  
> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> +{
> +	struct swap_cluster_info *ci;
> +	unsigned long offset = swp_offset(entry);
> +	unsigned char usage;
> +
> +	ci = lock_cluster_or_swap_info(si, offset);
> +	usage = __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
> +	unlock_cluster_or_swap_info(si, ci);
> +	if (!usage)
> +		free_swap_slot(entry);
> +}
> +
>  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
>  {
>  	return swap_type_to_swap_info(swp_type(entry));

