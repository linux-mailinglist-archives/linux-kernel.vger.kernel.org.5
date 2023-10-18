Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200FD7CD4B3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjJRG5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjJRG5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:57:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179ECB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697612232; x=1729148232;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5kCfENKLdy6RK47w9C+3d3YFaUvT9YppRcN0G7AScnU=;
  b=ne61DFIdgcXKyNUwl4lC9knFXDsAXwgInxnxS5Kug6jTZuUiC8PaRRc5
   dm1JzXcpkpxVJJFYz7MVDmchFUZevIGRCMIF2KJp0MY15XzY6KeNACPFp
   T08N3+MFM6SmbCQqbYYyzkkKIHyaMF3Ch2ADKaZC0nwmss2xRlTvk8gcY
   xqn+P191yvzszzf4YBsRBWpPV4jGxUs1sbncVF61PJdHocu2WuPVcPvkL
   tGgtvLWFnBpIdGCKfy5f6dkIyLyxw+IhIK4QPgjMV+ZzyCHyTVHLGDHOp
   QLUeMu9MBvzkgI4rC1UAIFyxrP2kIUz1Ucqk26X3a9JNrTqP0l1hkHcoY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365303861"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="365303861"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 23:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="880103185"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="880103185"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 23:57:07 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/2] mm: swap: Swap-out small-sized THP without
 splitting
In-Reply-To: <20231017161302.2518826-3-ryan.roberts@arm.com> (Ryan Roberts's
        message of "Tue, 17 Oct 2023 17:13:02 +0100")
References: <20231017161302.2518826-1-ryan.roberts@arm.com>
        <20231017161302.2518826-3-ryan.roberts@arm.com>
Date:   Wed, 18 Oct 2023 14:55:06 +0800
Message-ID: <87r0ls773p.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> can allocate any power-of-2 number of contiguous entries between [4, (1
> << PMD_ORDER)] (THP cannot support order-1 folios). This is done by
> allocating a cluster for each distinct order and allocating sequentially
> from it until the cluster is full. This ensures that we don't need to
> search the map and we get no fragmentation due to alignment padding for
> different orders in the cluster. If there is no current cluster for a
> given order, we attempt to allocate a free cluster from the list. If
> there are no free clusters, we fail the allocation and the caller falls
> back to splitting the folio and allocates individual entries (as per
> existing PMD-sized THP fallback).
>
> The per-order current clusters are maintained per-cpu using the existing
> percpu_cluster infrastructure. This is done to avoid interleving pages
> from different tasks, which would prevent IO being batched. This is
> already done for the order-0 allocations so we follow the same pattern.
>
> As far as I can tell, this should not cause any extra fragmentation
> concerns, given how similar it is to the existing PMD-sized THP
> allocation mechanism. There could be up to (PMD_ORDER-2) * nr_cpus
> clusters in concurrent use though, which in a pathalogical case (cluster
> set aside for every order for every cpu and only one huge entry
> allocated from it) would tie up ~12MiB of unused swap entries for these
> high orders (assuming PMD_ORDER=9). In practice, the number of orders in
> use will be small and the amount of swap space reserved is very small
> compared to a typical swap file.
>
> Note that PMD_ORDER is not compile-time constant on powerpc, so we have
> to allocate the large_next[] array at runtime.
>
> I've run the tests on Ampere Altra (arm64), set up with a 35G block ram
> device as the swap device and from inside a memcg limited to 40G memory.
> I've then run `usemem` from vm-scalability with 70 processes (each has
> its own core), each allocating and writing 1G of memory. I've repeated
> everything 5 times and taken the mean and stdev:
>
> Mean Performance Improvement vs 4K/baseline
>
> | alloc size |            baseline |       + this series |
> |            |  v6.6-rc4+anonfolio |                     |
> |:-----------|--------------------:|--------------------:|
> | 4K Page    |                0.0% |                1.1% |
> | 64K THP    |              -44.1% |                0.9% |
> | 2M THP     |               56.0% |               56.4% |
>
> So with this change, the regression for 64K swap performance goes away.
> Both 4K and 64K benhcmarks are now bottlenecked on TLBI performance from
> try_to_unmap_flush_dirty(), on arm64 at least. When using fewer cpus in
> the test, I see upto 2x performance of 64K THP swapping compared to 4K.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/swap.h |  6 ++++
>  mm/swapfile.c        | 74 +++++++++++++++++++++++++++++++++++---------
>  mm/vmscan.c          | 10 +++---
>  3 files changed, 71 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a073366a227c..35cbbe6509a9 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -268,6 +268,12 @@ struct swap_cluster_info {
>  struct percpu_cluster {
>  	struct swap_cluster_info index; /* Current cluster index */
>  	unsigned int next; /* Likely next allocation offset */
> +	unsigned int large_next[];	/*
> +					 * next free offset within current
> +					 * allocation cluster for large folios,
> +					 * or UINT_MAX if no current cluster.
> +					 * Index is (order - 1).
> +					 */
>  };
>
>  struct swap_cluster_list {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index b83ad77e04c0..625964e53c22 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -987,35 +987,70 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  	return n_ret;
>  }
>
> -static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
> +static int swap_alloc_large(struct swap_info_struct *si, swp_entry_t *slot,
> +			    unsigned int nr_pages)

This looks hacky.  IMO, we should put the allocation logic inside
percpu_cluster framework.  If percpu_cluster framework doesn't work for
you, just refactor it firstly.

>  {
> +	int order_idx;
>  	unsigned long idx;
>  	struct swap_cluster_info *ci;
> +	struct percpu_cluster *cluster;
>  	unsigned long offset;
>
>  	/*
>  	 * Should not even be attempting cluster allocations when huge
>  	 * page swap is disabled.  Warn and fail the allocation.
>  	 */
> -	if (!IS_ENABLED(CONFIG_THP_SWAP)) {
> +	if (!IS_ENABLED(CONFIG_THP_SWAP) ||
> +	    nr_pages < 4 || nr_pages > SWAPFILE_CLUSTER ||
> +	    !is_power_of_2(nr_pages)) {
>  		VM_WARN_ON_ONCE(1);
>  		return 0;
>  	}
>
> -	if (cluster_list_empty(&si->free_clusters))
> +	/*
> +	 * Not using clusters so unable to allocate large entries.
> +	 */
> +	if (!si->cluster_info)
>  		return 0;
>
> -	idx = cluster_list_first(&si->free_clusters);
> -	offset = idx * SWAPFILE_CLUSTER;
> -	ci = lock_cluster(si, offset);
> -	alloc_cluster(si, idx);
> -	cluster_set_count(ci, SWAPFILE_CLUSTER);
> +	order_idx = ilog2(nr_pages) - 2;
> +	cluster = this_cpu_ptr(si->percpu_cluster);
> +	offset = cluster->large_next[order_idx];
> +
> +	if (offset == UINT_MAX) {
> +		if (cluster_list_empty(&si->free_clusters))
> +			return 0;
> +
> +		idx = cluster_list_first(&si->free_clusters);
> +		offset = idx * SWAPFILE_CLUSTER;
>
> -	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
> +		ci = lock_cluster(si, offset);
> +		alloc_cluster(si, idx);
> +		cluster_set_count(ci, SWAPFILE_CLUSTER);
> +
> +		/*
> +		 * If scan_swap_map_slots() can't find a free cluster, it will
> +		 * check si->swap_map directly. To make sure this standby
> +		 * cluster isn't taken by scan_swap_map_slots(), mark the swap
> +		 * entries bad (occupied). (same approach as discard).
> +		 */
> +		memset(si->swap_map + offset + nr_pages, SWAP_MAP_BAD,
> +			SWAPFILE_CLUSTER - nr_pages);

There's an issue with this solution.  If the free space of swap device
runs low, it's possible that

- some cluster are put in the percpu_cluster of some CPUs
  the swap entries there are marked as used

- no free swap entries elsewhere

- nr_swap_pages isn't 0

So, we will still scan LRU, but swap allocation fails, although there's
still free swap space.

I think that we should follow the method we used for the original
percpu_cluster.  That is, if all free swap entries are in
percpu_cluster, we will start to allocate from percpu_cluster.

> +	} else {
> +		idx = offset / SWAPFILE_CLUSTER;
> +		ci = lock_cluster(si, offset);
> +	}
> +
> +	memset(si->swap_map + offset, SWAP_HAS_CACHE, nr_pages);
>  	unlock_cluster(ci);
> -	swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
> +	swap_range_alloc(si, offset, nr_pages);
>  	*slot = swp_entry(si->type, offset);
>
> +	offset += nr_pages;
> +	if (idx != offset / SWAPFILE_CLUSTER)
> +		offset = UINT_MAX;
> +	cluster->large_next[order_idx] = offset;
> +
>  	return 1;
>  }
>

[snip]

--
Best Regards,
Huang, Ying
