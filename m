Return-Path: <linux-kernel+bounces-126423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBCA8937B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D3F2B21123
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6864A1B;
	Mon,  1 Apr 2024 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXTit0Zh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA5138C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711941433; cv=none; b=XxKa8+CF4VKgIyATD3dWeV9rtsZPAZGcoYye9pL+d2+QBJx+56AZVU9buogTkOprXcx08u9mkzBEkqDQ2Hdw+JyL0dA8FzbhwKBD771lvZLmerwp/ZtRjn77XpFrYIglPsKc//y9ig84idaFHhiYh52UW5ofTlJmlFsjaB5NILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711941433; c=relaxed/simple;
	bh=RP1S+S1OAPdRtjwZ/Pt5xLAxJVR6/sgjP79MWCSOS2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ulIQTsahjf/XfyK3HB/Z1vpnj6YXSpojL2eCJ9ydB6xeDwl5hw1Krr9fvqGp1opBfRvwtYhn+wW3y3ek0h1xLpsq4q/MXVfqjY0iXPAa9ERXjucZX6WkO4iQSJc5d/ePZjHvPUmfFsPfNJKpR8E7HBUARK9UrA9K+WvtSf3Wl0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXTit0Zh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711941431; x=1743477431;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RP1S+S1OAPdRtjwZ/Pt5xLAxJVR6/sgjP79MWCSOS2s=;
  b=BXTit0ZhoNNIofQw5+MiPc0RIG4pFNiBJb/j49amkHDBLHG4bC6g+LWF
   fbnJMQLAuMe2VvxsxhhjGAFhd8Udll7Miq+egwUCWAy1RumWihH68wGo1
   +1tCRAN4MmldaIJretL8vd4dd40b2qZ9/BKHwbrrS+DDnOK2MV+1CjOs3
   YYxgEYOpNeWktZswzl3lViwAv3oQj6i/nzfLKOhNf7iCDYhpKZdvotVfr
   xN3oP7/KsXS4iczedxdXPNYrdySfq2SbmrCGxy1oMrcNzbi66nORglacH
   2yqtCGBl5ts2SBsDq8Q1zoMJPaNGbE2haK2GwTPOjKTJ7xhxV9AdaU44l
   Q==;
X-CSE-ConnectionGUID: 3PquJtA2QgOV3e100vU4xQ==
X-CSE-MsgGUID: T4CKEpP9SLKgZFrTYGXnng==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="10844269"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="10844269"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 20:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="22260426"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 20:17:06 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  Matthew Wilcox <willy@infradead.org>,  Gao Xiang
 <xiang@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Yang Shi
 <shy828301@gmail.com>,  Michal Hocko <mhocko@suse.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Barry Song <21cnbao@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  Lance Yang <ioworker0@gmail.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/6] mm: swap: Allow storage of all mTHP orders
In-Reply-To: <20240327144537.4165578-5-ryan.roberts@arm.com> (Ryan Roberts's
	message of "Wed, 27 Mar 2024 14:45:35 +0000")
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
	<20240327144537.4165578-5-ryan.roberts@arm.com>
Date: Mon, 01 Apr 2024 11:15:13 +0800
Message-ID: <87o7atkc3i.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> Multi-size THP enables performance improvements by allocating large,
> pte-mapped folios for anonymous memory. However I've observed that on an
> arm64 system running a parallel workload (e.g. kernel compilation)
> across many cores, under high memory pressure, the speed regresses. This
> is due to bottlenecking on the increased number of TLBIs added due to
> all the extra folio splitting when the large folios are swapped out.
>
> Therefore, solve this regression by adding support for swapping out mTHP
> without needing to split the folio, just like is already done for
> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
> and when the swap backing store is a non-rotating block device. These
> are the same constraints as for the existing PMD-sized THP swap-out
> support.
>
> Note that no attempt is made to swap-in (m)THP here - this is still done
> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
> prerequisite for swapping-in mTHP.
>
> The main change here is to improve the swap entry allocator so that it
> can allocate any power-of-2 number of contiguous entries between [1, (1
> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
> order and allocating sequentially from it until the cluster is full.
> This ensures that we don't need to search the map and we get no
> fragmentation due to alignment padding for different orders in the
> cluster. If there is no current cluster for a given order, we attempt to
> allocate a free cluster from the list. If there are no free clusters, we
> fail the allocation and the caller can fall back to splitting the folio
> and allocates individual entries (as per existing PMD-sized THP
> fallback).
>
> The per-order current clusters are maintained per-cpu using the existing
> infrastructure. This is done to avoid interleving pages from different
> tasks, which would prevent IO being batched. This is already done for
> the order-0 allocations so we follow the same pattern.
>
> As is done for order-0 per-cpu clusters, the scanner now can steal
> order-0 entries from any per-cpu-per-order reserved cluster. This
> ensures that when the swap file is getting full, space doesn't get tied
> up in the per-cpu reserves.
>
> This change only modifies swap to be able to accept any order mTHP. It
> doesn't change the callers to elide doing the actual split. That will be
> done in separate changes.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/swap.h |  10 ++-
>  mm/swap_slots.c      |   6 +-
>  mm/swapfile.c        | 175 ++++++++++++++++++++++++-------------------
>  3 files changed, 109 insertions(+), 82 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 5e1e4f5bf0cb..11c53692f65f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -268,13 +268,19 @@ struct swap_cluster_info {
>   */
>  #define SWAP_NEXT_INVALID	0
>  
> +#ifdef CONFIG_THP_SWAP
> +#define SWAP_NR_ORDERS		(PMD_ORDER + 1)
> +#else
> +#define SWAP_NR_ORDERS		1
> +#endif
> +
>  /*
>   * We assign a cluster to each CPU, so each CPU can allocate swap entry from
>   * its own cluster and swapout sequentially. The purpose is to optimize swapout
>   * throughput.
>   */
>  struct percpu_cluster {
> -	unsigned int next; /* Likely next allocation offset */
> +	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
>  };
>  
>  struct swap_cluster_list {
> @@ -471,7 +477,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio);
>  bool folio_free_swap(struct folio *folio);
>  void put_swap_folio(struct folio *folio, swp_entry_t entry);
>  extern swp_entry_t get_swap_page_of_type(int);
> -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
> +extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
>  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>  extern void swap_shmem_alloc(swp_entry_t);
>  extern int swap_duplicate(swp_entry_t);
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 53abeaf1371d..13ab3b771409 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -264,7 +264,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
>  	cache->cur = 0;
>  	if (swap_slot_cache_active)
>  		cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
> -					   cache->slots, 1);
> +					   cache->slots, 0);
>  
>  	return cache->nr;
>  }
> @@ -311,7 +311,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>  
>  	if (folio_test_large(folio)) {
>  		if (IS_ENABLED(CONFIG_THP_SWAP))
> -			get_swap_pages(1, &entry, folio_nr_pages(folio));
> +			get_swap_pages(1, &entry, folio_order(folio));
>  		goto out;
>  	}
>  
> @@ -343,7 +343,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>  			goto out;
>  	}
>  
> -	get_swap_pages(1, &entry, 1);
> +	get_swap_pages(1, &entry, 0);
>  out:
>  	if (mem_cgroup_try_charge_swap(folio, entry)) {
>  		put_swap_folio(folio, entry);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 1393966b77af..d56cdc547a06 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -278,15 +278,15 @@ static void discard_swap_cluster(struct swap_info_struct *si,
>  #ifdef CONFIG_THP_SWAP
>  #define SWAPFILE_CLUSTER	HPAGE_PMD_NR
>  
> -#define swap_entry_size(size)	(size)
> +#define swap_entry_order(order)	(order)
>  #else
>  #define SWAPFILE_CLUSTER	256
>  
>  /*
> - * Define swap_entry_size() as constant to let compiler to optimize
> + * Define swap_entry_order() as constant to let compiler to optimize
>   * out some code if !CONFIG_THP_SWAP
>   */
> -#define swap_entry_size(size)	1
> +#define swap_entry_order(order)	0
>  #endif
>  #define LATENCY_LIMIT		256
>  
> @@ -551,10 +551,12 @@ static void free_cluster(struct swap_info_struct *si, unsigned long idx)
>  
>  /*
>   * The cluster corresponding to page_nr will be used. The cluster will be
> - * removed from free cluster list and its usage counter will be increased.
> + * removed from free cluster list and its usage counter will be increased by
> + * count.
>   */
> -static void inc_cluster_info_page(struct swap_info_struct *p,
> -	struct swap_cluster_info *cluster_info, unsigned long page_nr)
> +static void add_cluster_info_page(struct swap_info_struct *p,
> +	struct swap_cluster_info *cluster_info, unsigned long page_nr,
> +	unsigned long count)
>  {
>  	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
>  
> @@ -563,9 +565,19 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
>  	if (cluster_is_free(&cluster_info[idx]))
>  		alloc_cluster(p, idx);
>  
> -	VM_BUG_ON(cluster_count(&cluster_info[idx]) >= SWAPFILE_CLUSTER);
> +	VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CLUSTER);
>  	cluster_set_count(&cluster_info[idx],
> -		cluster_count(&cluster_info[idx]) + 1);
> +		cluster_count(&cluster_info[idx]) + count);
> +}
> +
> +/*
> + * The cluster corresponding to page_nr will be used. The cluster will be
> + * removed from free cluster list and its usage counter will be increased by 1.
> + */
> +static void inc_cluster_info_page(struct swap_info_struct *p,
> +	struct swap_cluster_info *cluster_info, unsigned long page_nr)
> +{
> +	add_cluster_info_page(p, cluster_info, page_nr, 1);
>  }
>  
>  /*
> @@ -595,7 +607,7 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
>   */
>  static bool
>  scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
> -	unsigned long offset)
> +	unsigned long offset, int order)
>  {
>  	struct percpu_cluster *percpu_cluster;
>  	bool conflict;
> @@ -609,24 +621,39 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>  		return false;
>  
>  	percpu_cluster = this_cpu_ptr(si->percpu_cluster);
> -	percpu_cluster->next = SWAP_NEXT_INVALID;
> +	percpu_cluster->next[order] = SWAP_NEXT_INVALID;
> +	return true;
> +}
> +
> +static inline bool swap_range_empty(char *swap_map, unsigned int start,
> +				    unsigned int nr_pages)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		if (swap_map[start + i])
> +			return false;
> +	}
> +
>  	return true;
>  }
>  
>  /*
> - * Try to get a swap entry from current cpu's swap entry pool (a cluster). This
> - * might involve allocating a new cluster for current CPU too.
> + * Try to get swap entries with specified order from current cpu's swap entry
> + * pool (a cluster). This might involve allocating a new cluster for current CPU
> + * too.
>   */
>  static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
> -	unsigned long *offset, unsigned long *scan_base)
> +	unsigned long *offset, unsigned long *scan_base, int order)
>  {
> +	unsigned int nr_pages = 1 << order;

Use swap_entry_order()?

>  	struct percpu_cluster *cluster;
>  	struct swap_cluster_info *ci;
>  	unsigned int tmp, max;
>  
>  new_cluster:
>  	cluster = this_cpu_ptr(si->percpu_cluster);
> -	tmp = cluster->next;
> +	tmp = cluster->next[order];
>  	if (tmp == SWAP_NEXT_INVALID) {
>  		if (!cluster_list_empty(&si->free_clusters)) {
>  			tmp = cluster_next(&si->free_clusters.head) *
> @@ -647,26 +674,27 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>  
>  	/*
>  	 * Other CPUs can use our cluster if they can't find a free cluster,
> -	 * check if there is still free entry in the cluster
> +	 * check if there is still free entry in the cluster, maintaining
> +	 * natural alignment.
>  	 */
>  	max = min_t(unsigned long, si->max, ALIGN(tmp + 1, SWAPFILE_CLUSTER));
>  	if (tmp < max) {
>  		ci = lock_cluster(si, tmp);
>  		while (tmp < max) {
> -			if (!si->swap_map[tmp])
> +			if (swap_range_empty(si->swap_map, tmp, nr_pages))
>  				break;
> -			tmp++;
> +			tmp += nr_pages;
>  		}
>  		unlock_cluster(ci);
>  	}
>  	if (tmp >= max) {
> -		cluster->next = SWAP_NEXT_INVALID;
> +		cluster->next[order] = SWAP_NEXT_INVALID;
>  		goto new_cluster;
>  	}
>  	*offset = tmp;
>  	*scan_base = tmp;
> -	tmp += 1;
> -	cluster->next = tmp < max ? tmp : SWAP_NEXT_INVALID;
> +	tmp += nr_pages;
> +	cluster->next[order] = tmp < max ? tmp : SWAP_NEXT_INVALID;
>  	return true;
>  }
>  
> @@ -796,13 +824,14 @@ static bool swap_offset_available_and_locked(struct swap_info_struct *si,
>  
>  static int scan_swap_map_slots(struct swap_info_struct *si,
>  			       unsigned char usage, int nr,
> -			       swp_entry_t slots[])
> +			       swp_entry_t slots[], int order)
>  {
>  	struct swap_cluster_info *ci;
>  	unsigned long offset;
>  	unsigned long scan_base;
>  	unsigned long last_in_cluster = 0;
>  	int latency_ration = LATENCY_LIMIT;
> +	unsigned int nr_pages = 1 << order;

ditto.

Otherwise LGTM, feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

in the future versions.

--
Best Regards,
Huang, Ying

>  	int n_ret = 0;
>  	bool scanned_many = false;
>  
> @@ -817,6 +846,25 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  	 * And we let swap pages go all over an SSD partition.  Hugh
>  	 */
>  
> +	if (order > 0) {
> +		/*
> +		 * Should not even be attempting large allocations when huge
> +		 * page swap is disabled.  Warn and fail the allocation.
> +		 */
> +		if (!IS_ENABLED(CONFIG_THP_SWAP) ||
> +		    nr_pages > SWAPFILE_CLUSTER) {
> +			VM_WARN_ON_ONCE(1);
> +			return 0;
> +		}
> +
> +		/*
> +		 * Swapfile is not block device or not using clusters so unable
> +		 * to allocate large entries.
> +		 */
> +		if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
> +			return 0;
> +	}
> +
>  	si->flags += SWP_SCANNING;
>  	/*
>  	 * Use percpu scan base for SSD to reduce lock contention on
> @@ -831,8 +879,11 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  
>  	/* SSD algorithm */
>  	if (si->cluster_info) {
> -		if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_base))
> +		if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order)) {
> +			if (order > 0)
> +				goto no_page;
>  			goto scan;
> +		}
>  	} else if (unlikely(!si->cluster_nr--)) {
>  		if (si->pages - si->inuse_pages < SWAPFILE_CLUSTER) {
>  			si->cluster_nr = SWAPFILE_CLUSTER - 1;
> @@ -874,13 +925,16 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  
>  checks:
>  	if (si->cluster_info) {
> -		while (scan_swap_map_ssd_cluster_conflict(si, offset)) {
> +		while (scan_swap_map_ssd_cluster_conflict(si, offset, order)) {
>  		/* take a break if we already got some slots */
>  			if (n_ret)
>  				goto done;
>  			if (!scan_swap_map_try_ssd_cluster(si, &offset,
> -							&scan_base))
> +							&scan_base, order)) {
> +				if (order > 0)
> +					goto no_page;
>  				goto scan;
> +			}
>  		}
>  	}
>  	if (!(si->flags & SWP_WRITEOK))
> @@ -911,11 +965,11 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  		else
>  			goto done;
>  	}
> -	WRITE_ONCE(si->swap_map[offset], usage);
> -	inc_cluster_info_page(si, si->cluster_info, offset);
> +	memset(si->swap_map + offset, usage, nr_pages);
> +	add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
>  	unlock_cluster(ci);
>  
> -	swap_range_alloc(si, offset, 1);
> +	swap_range_alloc(si, offset, nr_pages);
>  	slots[n_ret++] = swp_entry(si->type, offset);
>  
>  	/* got enough slots or reach max slots? */
> @@ -936,8 +990,10 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  
>  	/* try to get more slots in cluster */
>  	if (si->cluster_info) {
> -		if (scan_swap_map_try_ssd_cluster(si, &offset, &scan_base))
> +		if (scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order))
>  			goto checks;
> +		if (order > 0)
> +			goto done;
>  	} else if (si->cluster_nr && !si->swap_map[++offset]) {
>  		/* non-ssd case, still more slots in cluster? */
>  		--si->cluster_nr;
> @@ -964,11 +1020,13 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  	}
>  
>  done:
> -	set_cluster_next(si, offset + 1);
> +	if (order == 0)
> +		set_cluster_next(si, offset + 1);
>  	si->flags -= SWP_SCANNING;
>  	return n_ret;
>  
>  scan:
> +	VM_WARN_ON(order > 0);
>  	spin_unlock(&si->lock);
>  	while (++offset <= READ_ONCE(si->highest_bit)) {
>  		if (unlikely(--latency_ration < 0)) {
> @@ -997,38 +1055,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  	return n_ret;
>  }
>  
> -static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
> -{
> -	unsigned long idx;
> -	struct swap_cluster_info *ci;
> -	unsigned long offset;
> -
> -	/*
> -	 * Should not even be attempting cluster allocations when huge
> -	 * page swap is disabled.  Warn and fail the allocation.
> -	 */
> -	if (!IS_ENABLED(CONFIG_THP_SWAP)) {
> -		VM_WARN_ON_ONCE(1);
> -		return 0;
> -	}
> -
> -	if (cluster_list_empty(&si->free_clusters))
> -		return 0;
> -
> -	idx = cluster_list_first(&si->free_clusters);
> -	offset = idx * SWAPFILE_CLUSTER;
> -	ci = lock_cluster(si, offset);
> -	alloc_cluster(si, idx);
> -	cluster_set_count(ci, SWAPFILE_CLUSTER);
> -
> -	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
> -	unlock_cluster(ci);
> -	swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
> -	*slot = swp_entry(si->type, offset);
> -
> -	return 1;
> -}
> -
>  static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>  {
>  	unsigned long offset = idx * SWAPFILE_CLUSTER;
> @@ -1042,17 +1068,15 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>  	swap_range_free(si, offset, SWAPFILE_CLUSTER);
>  }
>  
> -int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
> +int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
>  {
> -	unsigned long size = swap_entry_size(entry_size);
> +	int order = swap_entry_order(entry_order);
> +	unsigned long size = 1 << order;
>  	struct swap_info_struct *si, *next;
>  	long avail_pgs;
>  	int n_ret = 0;
>  	int node;
>  
> -	/* Only single cluster request supported */
> -	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
> -
>  	spin_lock(&swap_avail_lock);
>  
>  	avail_pgs = atomic_long_read(&nr_swap_pages) / size;
> @@ -1088,14 +1112,10 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  			spin_unlock(&si->lock);
>  			goto nextsi;
>  		}
> -		if (size == SWAPFILE_CLUSTER) {
> -			if (si->flags & SWP_BLKDEV)
> -				n_ret = swap_alloc_cluster(si, swp_entries);
> -		} else
> -			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
> -						    n_goal, swp_entries);
> +		n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
> +					    n_goal, swp_entries, order);
>  		spin_unlock(&si->lock);
> -		if (n_ret || size == SWAPFILE_CLUSTER)
> +		if (n_ret || size > 1)
>  			goto check_out;
>  		cond_resched();
>  
> @@ -1349,7 +1369,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
>  	unsigned char *map;
>  	unsigned int i, free_entries = 0;
>  	unsigned char val;
> -	int size = swap_entry_size(folio_nr_pages(folio));
> +	int size = 1 << swap_entry_order(folio_order(folio));
>  
>  	si = _swap_info_get(entry);
>  	if (!si)
> @@ -1647,7 +1667,7 @@ swp_entry_t get_swap_page_of_type(int type)
>  
>  	/* This is called for allocating swap entry, not cache */
>  	spin_lock(&si->lock);
> -	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry))
> +	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry, 0))
>  		atomic_long_dec(&nr_swap_pages);
>  	spin_unlock(&si->lock);
>  fail:
> @@ -3101,7 +3121,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		p->flags |= SWP_SYNCHRONOUS_IO;
>  
>  	if (p->bdev && bdev_nonrot(p->bdev)) {
> -		int cpu;
> +		int cpu, i;
>  		unsigned long ci, nr_cluster;
>  
>  		p->flags |= SWP_SOLIDSTATE;
> @@ -3139,7 +3159,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  			struct percpu_cluster *cluster;
>  
>  			cluster = per_cpu_ptr(p->percpu_cluster, cpu);
> -			cluster->next = SWAP_NEXT_INVALID;
> +			for (i = 0; i < SWAP_NR_ORDERS; i++)
> +				cluster->next[i] = SWAP_NEXT_INVALID;
>  		}
>  	} else {
>  		atomic_inc(&nr_rotate_swap);

