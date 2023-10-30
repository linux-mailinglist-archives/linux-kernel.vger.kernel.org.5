Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26EF7DB502
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjJ3IU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjJ3IU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:20:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70E1AF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698654053; x=1730190053;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=V5HYsWuYdqN38YgU1fLYuAoGWmOa5aA3SfyUzU7Av0Y=;
  b=Fc2nu9NBy7fZIaN3G7GoTVQGDb5G1RqD1+tyg/ciN1LUNXPI+OJ8IDre
   iYGMecIhZ7iKEDzeFvpNOQVWxNoAO0pIZ02vuLgADvNaLFWuJ/d1qE3DC
   RqoxArD00sJRDCHs8cinYq9Y5UGichRwuS42N7glGPrWn6ToHvRuhtSDR
   cPROTNikZ9ysiMAjZ3aHAyku8ynWHMXLyq1ceWgoiaD44DKsT84lKXXlQ
   0DSS9cyj/m2yaImmkskpzPbtQqSUVIFjHTmZNCUnEzhMwFs6vsrF4vxyf
   Q5ZnRrn3OVFO/517b4AzCdAyavvjvoruJp1OKAr3q8vmTJ32b8LMpp/PM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="452290014"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="452290014"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="8266075"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:20:48 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@googleN.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without
 splitting
In-Reply-To: <20231025144546.577640-5-ryan.roberts@arm.com> (Ryan Roberts's
        message of "Wed, 25 Oct 2023 15:45:46 +0100")
References: <20231025144546.577640-1-ryan.roberts@arm.com>
        <20231025144546.577640-5-ryan.roberts@arm.com>
Date:   Mon, 30 Oct 2023 16:18:45 +0800
Message-ID: <87o7gga5ga.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ryan,

Ryan Roberts <ryan.roberts@arm.com> writes:

> The upcoming anonymous small-sized THP feature enables performance
> improvements by allocating large folios for anonymous memory. However
> I've observed that on an arm64 system running a parallel workload (e.g.
> kernel compilation) across many cores, under high memory pressure, the
> speed regresses. This is due to bottlenecking on the increased number of
> TLBIs added due to all the extra folio splitting.
>
> Therefore, solve this regression by adding support for swapping out
> small-sized THP without needing to split the folio, just like is already
> done for PMD-sized THP. This change only applies when CONFIG_THP_SWAP is
> enabled, and when the swap backing store is a non-rotating block device.
> These are the same constraints as for the existing PMD-sized THP
> swap-out support.
>
> Note that no attempt is made to swap-in THP here - this is still done
> page-by-page, like for PMD-sized THP.
>
> The main change here is to improve the swap entry allocator so that it
> can allocate any power-of-2 number of contiguous entries between [1, (1
> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
> order and allocating sequentially from it until the cluster is full.
> This ensures that we don't need to search the map and we get no
> fragmentation due to alignment padding for different orders in the
> cluster. If there is no current cluster for a given order, we attempt to
> allocate a free cluster from the list. If there are no free clusters, we
> fail the allocation and the caller falls back to splitting the folio and
> allocates individual entries (as per existing PMD-sized THP fallback).
>
> The per-order current clusters are maintained per-cpu using the existing
> infrastructure. This is done to avoid interleving pages from different
> tasks, which would prevent IO being batched. This is already done for
> the order-0 allocations so we follow the same pattern.
> __scan_swap_map_try_ssd_cluster() is introduced to deal with arbitrary
> orders and scan_swap_map_try_ssd_cluster() is refactored as a wrapper
> for order-0.
>
> As is done for order-0 per-cpu clusters, the scanner now can steal
> order-0 entries from any per-cpu-per-order reserved cluster. This
> ensures that when the swap file is getting full, space doesn't get tied
> up in the per-cpu reserves.
>
> I've run the tests on Ampere Altra (arm64), set up with a 35G block ram
> device as the swap device and from inside a memcg limited to 40G memory.
> I've then run `usemem` from vm-scalability with 70 processes (each has
> its own core), each allocating and writing 1G of memory. I've repeated
> everything 5 times and taken the mean:
>
> Mean Performance Improvement vs 4K/baseline
>
> | alloc size |            baseline |       + this series |
> |            |  v6.6-rc4+anonfolio |                     |
> |:-----------|--------------------:|--------------------:|
> | 4K Page    |                0.0% |                4.9% |
> | 64K THP    |              -44.1% |               10.7% |
> | 2M THP     |               56.0% |               65.9% |
>
> So with this change, the regression for 64K swap performance goes away
> and 4K and 2M swap improves slightly too.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/swap.h |  10 +--
>  mm/swapfile.c        | 149 +++++++++++++++++++++++++++++++------------
>  mm/vmscan.c          |  10 +--
>  3 files changed, 119 insertions(+), 50 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 0ca8aaa098ba..ccbca5db851b 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -295,11 +295,11 @@ struct swap_info_struct {
>  	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
>  	unsigned int __percpu *cpu_next;/*
>  					 * Likely next allocation offset. We
> -					 * assign a cluster to each CPU, so each
> -					 * CPU can allocate swap entry from its
> -					 * own cluster and swapout sequentially.
> -					 * The purpose is to optimize swapout
> -					 * throughput.
> +					 * assign a cluster per-order to each
> +					 * CPU, so each CPU can allocate swap
> +					 * entry from its own cluster and
> +					 * swapout sequentially. The purpose is
> +					 * to optimize swapout throughput.
>  					 */

This is kind of hard to understand.  Better to define some intermediate
data structure to improve readability.  For example,

#ifdef CONFIG_THP_SWAP
#define NR_SWAP_ORDER   PMD_ORDER
#else
#define NR_SWAP_ORDER   1
#endif

struct percpu_clusters {
        unsigned int alloc_next[NR_SWAP_ORDER];
};

PMD_ORDER isn't a constant on powerpc, but THP_SWAP isn't supported on
powerpc too.

>  	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
>  	struct block_device *bdev;	/* swap device or bdev of swap file */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 94f7cc225eb9..b50bce50bed9 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -545,10 +545,12 @@ static void free_cluster(struct swap_info_struct *si, unsigned long idx)
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
> @@ -557,9 +559,19 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
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
> + * removed from free cluster list and its usage counter will be increased.
> + */
> +static void inc_cluster_info_page(struct swap_info_struct *p,
> +	struct swap_cluster_info *cluster_info, unsigned long page_nr)
> +{
> +	add_cluster_info_page(p, cluster_info, page_nr, 1);
>  }
>  
>  /*
> @@ -588,8 +600,8 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
>   * cluster list. Avoiding such abuse to avoid list corruption.
>   */
>  static bool
> -scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
> -	unsigned long offset)
> +__scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
> +	unsigned long offset, int order)
>  {
>  	bool conflict;
>  
> @@ -601,23 +613,36 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>  	if (!conflict)
>  		return false;
>  
> -	*this_cpu_ptr(si->cpu_next) = SWAP_NEXT_NULL;
> +	this_cpu_ptr(si->cpu_next)[order] = SWAP_NEXT_NULL;

This is added in the previous patch.  I don't think SWAP_NEXT_NULL is a
good name.  Because NEXT isn't a pointer (while cluster_next is). Better
to name it as SWAP_NEXT_INVALID, etc.

>  	return true;
>  }
>  
>  /*
> - * Try to get a swap entry from current cpu's swap entry pool (a cluster). This
> - * might involve allocating a new cluster for current CPU too.
> + * It's possible scan_swap_map_slots() uses a free cluster in the middle of free
> + * cluster list. Avoiding such abuse to avoid list corruption.
>   */
> -static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
> -	unsigned long *offset, unsigned long *scan_base)
> +static bool
> +scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
> +	unsigned long offset)
> +{
> +	return __scan_swap_map_ssd_cluster_conflict(si, offset, 0);
> +}
> +
> +/*
> + * Try to get a swap entry (or size indicated by order) from current cpu's swap
> + * entry pool (a cluster). This might involve allocating a new cluster for
> + * current CPU too.
> + */
> +static bool __scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
> +	unsigned long *offset, unsigned long *scan_base, int order)
>  {
>  	struct swap_cluster_info *ci;
> -	unsigned int tmp, max;
> +	unsigned int tmp, max, i;
>  	unsigned int *cpu_next;
> +	unsigned int nr_pages = 1 << order;
>  
>  new_cluster:
> -	cpu_next = this_cpu_ptr(si->cpu_next);
> +	cpu_next = &this_cpu_ptr(si->cpu_next)[order];
>  	tmp = *cpu_next;
>  	if (tmp == SWAP_NEXT_NULL) {
>  		if (!cluster_list_empty(&si->free_clusters)) {
> @@ -643,10 +668,12 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>  	 * reserve a new cluster.
>  	 */
>  	ci = lock_cluster(si, tmp);
> -	if (si->swap_map[tmp]) {
> -		unlock_cluster(ci);
> -		*cpu_next = SWAP_NEXT_NULL;
> -		goto new_cluster;
> +	for (i = 0; i < nr_pages; i++) {
> +		if (si->swap_map[tmp + i]) {
> +			unlock_cluster(ci);
> +			*cpu_next = SWAP_NEXT_NULL;
> +			goto new_cluster;
> +		}
>  	}
>  	unlock_cluster(ci);
>  
> @@ -654,12 +681,22 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>  	*scan_base = tmp;
>  
>  	max = ALIGN_DOWN(tmp, SWAPFILE_CLUSTER) + SWAPFILE_CLUSTER;

This line is added in a previous patch.  Can we just use

        max = ALIGN(tmp + 1, SWAPFILE_CLUSTER);

Or, add ALIGN_UP() for this?

> -	tmp += 1;
> +	tmp += nr_pages;
>  	*cpu_next = tmp < max ? tmp : SWAP_NEXT_NULL;
>  
>  	return true;
>  }
>  
> +/*
> + * Try to get a swap entry from current cpu's swap entry pool (a cluster). This
> + * might involve allocating a new cluster for current CPU too.
> + */
> +static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
> +	unsigned long *offset, unsigned long *scan_base)
> +{
> +	return __scan_swap_map_try_ssd_cluster(si, offset, scan_base, 0);
> +}
> +
>  static void __del_from_avail_list(struct swap_info_struct *p)
>  {
>  	int nid;
> @@ -982,35 +1019,58 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  	return n_ret;
>  }
>  
> -static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
> +static int swap_alloc_large(struct swap_info_struct *si, swp_entry_t *slot,
> +			    unsigned int nr_pages)

IMHO, it's better to make scan_swap_map_slots() to support order > 0
instead of making swap_alloc_cluster() to support order != PMD_ORDER.
And, we may merge swap_alloc_cluster() with scan_swap_map_slots() after
that.

>  {
> -	unsigned long idx;
>  	struct swap_cluster_info *ci;
> -	unsigned long offset;
> +	unsigned long offset, scan_base;
> +	int order = ilog2(nr_pages);
> +	bool ret;
>  
>  	/*
> -	 * Should not even be attempting cluster allocations when huge
> +	 * Should not even be attempting large allocations when huge
>  	 * page swap is disabled.  Warn and fail the allocation.
>  	 */
> -	if (!IS_ENABLED(CONFIG_THP_SWAP)) {
> +	if (!IS_ENABLED(CONFIG_THP_SWAP) ||
> +	    nr_pages < 2 || nr_pages > SWAPFILE_CLUSTER ||
> +	    !is_power_of_2(nr_pages)) {
>  		VM_WARN_ON_ONCE(1);
>  		return 0;
>  	}
>  
> -	if (cluster_list_empty(&si->free_clusters))
> +	/*
> +	 * Swapfile is not block device or not using clusters so unable to
> +	 * allocate large entries.
> +	 */
> +	if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
>  		return 0;
>  
> -	idx = cluster_list_first(&si->free_clusters);
> -	offset = idx * SWAPFILE_CLUSTER;
> -	ci = lock_cluster(si, offset);
> -	alloc_cluster(si, idx);
> -	cluster_set_count(ci, SWAPFILE_CLUSTER);
> +again:
> +	/*
> +	 * __scan_swap_map_try_ssd_cluster() may drop si->lock during discard,
> +	 * so indicate that we are scanning to synchronise with swapoff.
> +	 */
> +	si->flags += SWP_SCANNING;
> +	ret = __scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order);
> +	si->flags -= SWP_SCANNING;
> +
> +	/*
> +	 * If we failed to allocate or if swapoff is waiting for us (due to lock
> +	 * being dropped for discard above), return immediately.
> +	 */
> +	if (!ret || !(si->flags & SWP_WRITEOK))
> +		return 0;
>  
> -	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
> +	if (__scan_swap_map_ssd_cluster_conflict(si, offset, order))
> +		goto again;
> +
> +	ci = lock_cluster(si, offset);
> +	memset(si->swap_map + offset, SWAP_HAS_CACHE, nr_pages);
> +	add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
>  	unlock_cluster(ci);
> -	swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
> -	*slot = swp_entry(si->type, offset);
>  
> +	swap_range_alloc(si, offset, nr_pages);
> +	*slot = swp_entry(si->type, offset);
>  	return 1;
>  }
>  
> @@ -1036,7 +1096,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  	int node;
>  
>  	/* Only single cluster request supported */
> -	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
> +	WARN_ON_ONCE(n_goal > 1 && size > 1);
>  
>  	spin_lock(&swap_avail_lock);
>  
> @@ -1073,14 +1133,13 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  			spin_unlock(&si->lock);
>  			goto nextsi;
>  		}
> -		if (size == SWAPFILE_CLUSTER) {
> -			if (si->flags & SWP_BLKDEV)
> -				n_ret = swap_alloc_cluster(si, swp_entries);
> +		if (size > 1) {
> +			n_ret = swap_alloc_large(si, swp_entries, size);
>  		} else
>  			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
>  						    n_goal, swp_entries);
>  		spin_unlock(&si->lock);
> -		if (n_ret || size == SWAPFILE_CLUSTER)
> +		if (n_ret || size > 1)
>  			goto check_out;
>  		cond_resched();
>  
> @@ -3041,6 +3100,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	if (p->bdev && bdev_nonrot(p->bdev)) {
>  		int cpu;
>  		unsigned long ci, nr_cluster;
> +		int nr_order;
> +		int i;
>  
>  		p->flags |= SWP_SOLIDSTATE;
>  		p->cluster_next_cpu = alloc_percpu(unsigned int);
> @@ -3068,13 +3129,19 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		for (ci = 0; ci < nr_cluster; ci++)
>  			spin_lock_init(&((cluster_info + ci)->lock));
>  
> -		p->cpu_next = alloc_percpu(unsigned int);
> +		nr_order = IS_ENABLED(CONFIG_THP_SWAP) ? PMD_ORDER + 1 : 1;
> +		p->cpu_next = __alloc_percpu(sizeof(unsigned int) * nr_order,
> +					     __alignof__(unsigned int));
>  		if (!p->cpu_next) {
>  			error = -ENOMEM;
>  			goto bad_swap_unlock_inode;
>  		}
> -		for_each_possible_cpu(cpu)
> -			per_cpu(*p->cpu_next, cpu) = SWAP_NEXT_NULL;
> +		for_each_possible_cpu(cpu) {
> +			unsigned int *cpu_next = per_cpu_ptr(p->cpu_next, cpu);
> +
> +			for (i = 0; i < nr_order; i++)
> +				cpu_next[i] = SWAP_NEXT_NULL;
> +		}
>  	} else {
>  		atomic_inc(&nr_rotate_swap);
>  		inced_nr_rotate_swap = true;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2cc0cb41fb32..ea19710aa4cd 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1212,11 +1212,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  					if (!can_split_folio(folio, NULL))
>  						goto activate_locked;
>  					/*
> -					 * Split folios without a PMD map right
> -					 * away. Chances are some or all of the
> -					 * tail pages can be freed without IO.
> +					 * Split PMD-mappable folios without a
> +					 * PMD map right away. Chances are some
> +					 * or all of the tail pages can be freed
> +					 * without IO.
>  					 */
> -					if (!folio_entire_mapcount(folio) &&
> +					if (folio_test_pmd_mappable(folio) &&
> +					    !folio_entire_mapcount(folio) &&
>  					    split_folio_to_list(folio,
>  								folio_list))
>  						goto activate_locked;

--
Best Regards,
Huang, Ying
