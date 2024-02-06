Return-Path: <linux-kernel+bounces-54158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA20B84ABA7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD421C23892
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2587AD25;
	Tue,  6 Feb 2024 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRAcILvL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17A48F6E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183343; cv=none; b=s1aO92zXV/LWw3IO47r1URU+vGMjmXnsmox7Lk075KR+VlTkjVuS0y0Pm6xHPrEMQFBt1aXP+AsCTFMBrJnCbAIw5CRm1u+SdeG5oC58eNUKnKkBAEj1xbuR+EvtUxDynVacsvzSaOkGa5e7eMLJpEcvVRn1V0H9mXQt8iKrVpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183343; c=relaxed/simple;
	bh=TdErOC3oBHrD3EqLQL/DmWpuLadgOHm4vmA2o+l7M2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EjXF/AHI/3hY4gzV3tdzT+qF2WaqykEnpIuwjcbkp4h8GkV0KhfAiPMVEqdp0B6NYDnMA1MRPmGbaP0jAA4dAsQQ99r32OCPn4P4Uqi9l8XPXfLDpaGnc7pq/goRrtSgEz3Y6zw0TxpX6X7YGQPrayXYpYezCPB2a0AVo9led5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRAcILvL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707183342; x=1738719342;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=TdErOC3oBHrD3EqLQL/DmWpuLadgOHm4vmA2o+l7M2I=;
  b=gRAcILvLvzW7Mf2swkby+vxfGzhiRXWfoR0xbTxoAgKiw5HSr39oLiHC
   4ULtAsE8bx06zpvglcLv6Zh7C3zFwSzPO+B0S77f6fghIb/H1uzwViwaR
   zGQkIv2KB/kDsZ8eLncJivzpHRaql7MPazXaIhNhsnfUdvZchHzPddUMu
   BfKzVqlX1Bhjq6FUI9J0UHjkag+foLoqnxmjnTrw4qQNPLI7W8U/edvXP
   +x5Ac8FdWWEubTlAOFVr/aC+XLvptQ8T5wgeMgyjneX6D3mu8b4dCPYzt
   oy0egGOWdRb1qkxzhKlsX2+sxT/XzjbXtTHNsfsYqKqp7g2NGUp/XnHM+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18071355"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="18071355"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 17:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="928850"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 17:35:38 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Minchan Kim
 <minchan@kernel.org>,  Hugh Dickins <hughd@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Matthew Wilcox <willy@infradead.org>,  Michal Hocko
 <mhocko@suse.com>,  Yosry Ahmed <yosryahmed@google.com>,  David
 Hildenbrand <david@redhat.com>,  Yu Zhao <yuzhao@google.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap: fix race condition in direct swapin path
In-Reply-To: <20240205110959.4021-1-ryncsn@gmail.com> (Kairui Song's message
	of "Mon, 5 Feb 2024 19:09:59 +0800")
References: <20240205110959.4021-1-ryncsn@gmail.com>
Date: Tue, 06 Feb 2024 09:33:41 +0800
Message-ID: <871q9q1imi.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> In the direct swapin path, when two or more threads swapin the same entry
> at the same time, they get different pages (A, B) because swap cache is
> skipped. Before one thread (T0) finishes the swapin and installs page (A)
> to the PTE, another thread (T1) could finish swapin of page (B),
> swap_free the entry, then modify and swap-out the page again, using the
> same entry. It break the pte_same check because PTE value is unchanged,
> causing ABA problem. Then thread (T0) will then install the stalled page
> (A) into the PTE so new data in page (B) is lost, one possible callstack
> is like this:
>
> CPU0                                CPU1
> ----                                ----
> do_swap_page()                      do_swap_page() with same entry
> <direct swapin path>                <direct swapin path>
> <alloc page A>                      <alloc page B>
> swap_readpage() <- read to page A   swap_readpage() <- read to page B
> <slow on later locks or interrupt>  <finished swapin first>
> ...                                 set_pte_at()
>                                     swap_free() <- Now the entry is freed.
>                                     <write to page B, now page A stalled>
>                                     <swap out page B using same swap entry>
> pte_same() <- Check pass, PTE seems
>               unchanged, but page A
>               is stalled!
> swap_free() <- page B content lost!
> set_pte_at() <- staled page A installed!
>
> To fix this, reuse swapcache_prepare which will pin the swap entry using
> the cache flag, and allow only one thread to pin it. Release the pin
> after PT unlocked. Racers will simply busy wait since it's a rare
> and very short event.
>
> Other methods like increasing the swap count don't seem to be a good
> idea after some tests, that will cause racers to fall back to the
> cached swapin path, two swapin path being used at the same time
> leads to a much more complex scenario.
>
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
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reported-by: "Huang, Ying" <ying.huang@intel.com>

> ---
> Huge thanks to Huang Ying and Chris Li for help finding this issue!
>
>  mm/memory.c   | 19 +++++++++++++++++++
>  mm/swap.h     |  5 +++++
>  mm/swapfile.c | 16 ++++++++++++++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e1f4849463a..fd7c55a292f1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3867,6 +3867,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (!folio) {
>  		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>  		    __swap_count(entry) == 1) {
> +			/*
> +			 * With swap count == 1, after we read the entry,
> +			 * other threads could finish swapin first, free
> +			 * the entry, then swapout the modified page using
> +			 * the same entry. Now the content we just read is
> +			 * stalled, and it's undetectable as pte_same()
> +			 * returns true due to entry reuse.
> +			 *
> +			 * So pin the swap entry using the cache flag even

"pin" doesn't sound intuitive here.  I know that the swap entry will not
be freed with this.  But now, the parallel swap in will busy waiting.
So, I suggest to say,

Prevent parallel swapin from proceeding with the cache flag.  Otherwise,
it may swapin first, free the entry, then swapout the modified page
using the same entry ...

> +			 * cache is not used.
> +			 */
> +			if (swapcache_prepare(entry))
> +				goto out;
> +
>  			/* skip swapcache */
>  			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>  						vma, vmf->address, false);
> @@ -4116,6 +4130,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  unlock:
>  	if (vmf->pte)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
> +	/* Clear the swap cache pin for direct swapin after PTL unlock */
> +	if (folio && !swapcache)
> +		swapcache_clear(si, entry);
>  out:
>  	if (si)
>  		put_swap_device(si);
> @@ -4124,6 +4141,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (vmf->pte)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out_page:
> +	if (!swapcache)
> +		swapcache_clear(si, entry);
>  	folio_unlock(folio);
>  out_release:
>  	folio_put(folio);
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
> index 556ff7347d5f..f7d4ad152a7f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3365,6 +3365,22 @@ int swapcache_prepare(swp_entry_t entry)
>  	return __swap_duplicate(entry, SWAP_HAS_CACHE);
>  }
>  
> +/*
> + * Clear the cache flag and release pinned entry.

Even if we will keep "pin" in above comments, this is hard to be
understood for reader.  Need a little more explanation like "release
pinned entry for device with SWP_SYNCHRONOUS_IO.

Or, just remove the comments.  We have comments in calling site already.

> + */
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

Otherwise it looks good for me, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

