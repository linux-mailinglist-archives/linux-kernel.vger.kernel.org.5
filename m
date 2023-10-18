Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880BA7CDE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbjJROIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344828AbjJROIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:08:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 854F095
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:07:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DF172F4;
        Wed, 18 Oct 2023 07:08:39 -0700 (PDT)
Received: from [10.1.34.143] (XHFQ2J9959.cambridge.arm.com [10.1.34.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6DF53F64C;
        Wed, 18 Oct 2023 07:07:56 -0700 (PDT)
Message-ID: <c1c5881c-f00d-4302-a305-fbd6a9998b22@arm.com>
Date:   Wed, 18 Oct 2023 15:07:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: swap: Swap-out small-sized THP without
 splitting
Content-Language: en-GB
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231017161302.2518826-1-ryan.roberts@arm.com>
 <20231017161302.2518826-3-ryan.roberts@arm.com>
 <87r0ls773p.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87r0ls773p.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2023 07:55, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> The upcoming anonymous small-sized THP feature enables performance
>> improvements by allocating large folios for anonymous memory. However
>> I've observed that on an arm64 system running a parallel workload (e.g.
>> kernel compilation) across many cores, under high memory pressure, the
>> speed regresses. This is due to bottlenecking on the increased number of
>> TLBIs added due to all the extra folio splitting.
>>
>> Therefore, solve this regression by adding support for swapping out
>> small-sized THP without needing to split the folio, just like is already
>> done for PMD-sized THP. This change only applies when CONFIG_THP_SWAP is
>> enabled, and when the swap backing store is a non-rotating block device.
>> These are the same constraints as for the existing PMD-sized THP
>> swap-out support.
>>
>> Note that no attempt is made to swap-in THP here - this is still done
>> page-by-page, like for PMD-sized THP.
>>
>> The main change here is to improve the swap entry allocator so that it
>> can allocate any power-of-2 number of contiguous entries between [4, (1
>> << PMD_ORDER)] (THP cannot support order-1 folios). This is done by
>> allocating a cluster for each distinct order and allocating sequentially
>> from it until the cluster is full. This ensures that we don't need to
>> search the map and we get no fragmentation due to alignment padding for
>> different orders in the cluster. If there is no current cluster for a
>> given order, we attempt to allocate a free cluster from the list. If
>> there are no free clusters, we fail the allocation and the caller falls
>> back to splitting the folio and allocates individual entries (as per
>> existing PMD-sized THP fallback).
>>
>> The per-order current clusters are maintained per-cpu using the existing
>> percpu_cluster infrastructure. This is done to avoid interleving pages
>> from different tasks, which would prevent IO being batched. This is
>> already done for the order-0 allocations so we follow the same pattern.
>>
>> As far as I can tell, this should not cause any extra fragmentation
>> concerns, given how similar it is to the existing PMD-sized THP
>> allocation mechanism. There could be up to (PMD_ORDER-2) * nr_cpus
>> clusters in concurrent use though, which in a pathalogical case (cluster
>> set aside for every order for every cpu and only one huge entry
>> allocated from it) would tie up ~12MiB of unused swap entries for these
>> high orders (assuming PMD_ORDER=9). In practice, the number of orders in
>> use will be small and the amount of swap space reserved is very small
>> compared to a typical swap file.
>>
>> Note that PMD_ORDER is not compile-time constant on powerpc, so we have
>> to allocate the large_next[] array at runtime.
>>
>> I've run the tests on Ampere Altra (arm64), set up with a 35G block ram
>> device as the swap device and from inside a memcg limited to 40G memory.
>> I've then run `usemem` from vm-scalability with 70 processes (each has
>> its own core), each allocating and writing 1G of memory. I've repeated
>> everything 5 times and taken the mean and stdev:
>>
>> Mean Performance Improvement vs 4K/baseline
>>
>> | alloc size |            baseline |       + this series |
>> |            |  v6.6-rc4+anonfolio |                     |
>> |:-----------|--------------------:|--------------------:|
>> | 4K Page    |                0.0% |                1.1% |
>> | 64K THP    |              -44.1% |                0.9% |
>> | 2M THP     |               56.0% |               56.4% |
>>
>> So with this change, the regression for 64K swap performance goes away.
>> Both 4K and 64K benhcmarks are now bottlenecked on TLBI performance from
>> try_to_unmap_flush_dirty(), on arm64 at least. When using fewer cpus in
>> the test, I see upto 2x performance of 64K THP swapping compared to 4K.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  include/linux/swap.h |  6 ++++
>>  mm/swapfile.c        | 74 +++++++++++++++++++++++++++++++++++---------
>>  mm/vmscan.c          | 10 +++---
>>  3 files changed, 71 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index a073366a227c..35cbbe6509a9 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -268,6 +268,12 @@ struct swap_cluster_info {
>>  struct percpu_cluster {
>>  	struct swap_cluster_info index; /* Current cluster index */
>>  	unsigned int next; /* Likely next allocation offset */
>> +	unsigned int large_next[];	/*
>> +					 * next free offset within current
>> +					 * allocation cluster for large folios,
>> +					 * or UINT_MAX if no current cluster.
>> +					 * Index is (order - 1).
>> +					 */
>>  };
>>
>>  struct swap_cluster_list {
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index b83ad77e04c0..625964e53c22 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -987,35 +987,70 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>  	return n_ret;
>>  }
>>
>> -static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
>> +static int swap_alloc_large(struct swap_info_struct *si, swp_entry_t *slot,
>> +			    unsigned int nr_pages)
> 
> This looks hacky.  IMO, we should put the allocation logic inside
> percpu_cluster framework.  If percpu_cluster framework doesn't work for
> you, just refactor it firstly.

I'm not sure I really understand what you are suggesting - could you elaborate?
What "framework"? I only see a per-cpu data structure and
scan_swap_map_try_ssd_cluster(), which is very much geared towards order-0
allocations.

Are you suggesting you want to allocate large entries (> order-0) from the same
cluster that is used for small (order-0) entries? The problem with this approach
is that there may not be enough space left in the current cluster for the large
entry that you are trying to allocate. Then you would need to take a new cluster
from the free list and presumably leave the previous cluster with unused entries
(which will now only be accessible by scanning). That unused space could be
considerable.

That's why I am currently reserving a "current cluster" per order; that way, all
allocations are the same order, they are all naturally aligned and there is no
waste.

Perhaps I could implement "stealing" between cpus so that a cpu trying to
allocate a specific order, but which doesn't have a current cluster for that
order and the free list is empty, could allocate from another cpu's current
cluster? I don't think it's a good idea to mix different orders in the same
cluster though.

I guess if really low, I could remove a current cluster from a cpu and allow it
to be scanned for order-0 allocations at least?

Any opinions gratefully received!


> 
>>  {
>> +	int order_idx;
>>  	unsigned long idx;
>>  	struct swap_cluster_info *ci;
>> +	struct percpu_cluster *cluster;
>>  	unsigned long offset;
>>
>>  	/*
>>  	 * Should not even be attempting cluster allocations when huge
>>  	 * page swap is disabled.  Warn and fail the allocation.
>>  	 */
>> -	if (!IS_ENABLED(CONFIG_THP_SWAP)) {
>> +	if (!IS_ENABLED(CONFIG_THP_SWAP) ||
>> +	    nr_pages < 4 || nr_pages > SWAPFILE_CLUSTER ||
>> +	    !is_power_of_2(nr_pages)) {
>>  		VM_WARN_ON_ONCE(1);
>>  		return 0;
>>  	}
>>
>> -	if (cluster_list_empty(&si->free_clusters))
>> +	/*
>> +	 * Not using clusters so unable to allocate large entries.
>> +	 */
>> +	if (!si->cluster_info)
>>  		return 0;
>>
>> -	idx = cluster_list_first(&si->free_clusters);
>> -	offset = idx * SWAPFILE_CLUSTER;
>> -	ci = lock_cluster(si, offset);
>> -	alloc_cluster(si, idx);
>> -	cluster_set_count(ci, SWAPFILE_CLUSTER);
>> +	order_idx = ilog2(nr_pages) - 2;
>> +	cluster = this_cpu_ptr(si->percpu_cluster);
>> +	offset = cluster->large_next[order_idx];
>> +
>> +	if (offset == UINT_MAX) {
>> +		if (cluster_list_empty(&si->free_clusters))
>> +			return 0;
>> +
>> +		idx = cluster_list_first(&si->free_clusters);
>> +		offset = idx * SWAPFILE_CLUSTER;
>>
>> -	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
>> +		ci = lock_cluster(si, offset);
>> +		alloc_cluster(si, idx);
>> +		cluster_set_count(ci, SWAPFILE_CLUSTER);
>> +
>> +		/*
>> +		 * If scan_swap_map_slots() can't find a free cluster, it will
>> +		 * check si->swap_map directly. To make sure this standby
>> +		 * cluster isn't taken by scan_swap_map_slots(), mark the swap
>> +		 * entries bad (occupied). (same approach as discard).
>> +		 */
>> +		memset(si->swap_map + offset + nr_pages, SWAP_MAP_BAD,
>> +			SWAPFILE_CLUSTER - nr_pages);
> 
> There's an issue with this solution.  If the free space of swap device
> runs low, it's possible that
> 
> - some cluster are put in the percpu_cluster of some CPUs
>   the swap entries there are marked as used
> 
> - no free swap entries elsewhere
> 
> - nr_swap_pages isn't 0
> 
> So, we will still scan LRU, but swap allocation fails, although there's
> still free swap space.

Ahh yes, good spot.

> 
> I think that we should follow the method we used for the original
> percpu_cluster.  That is, if all free swap entries are in
> percpu_cluster, we will start to allocate from percpu_cluster.

As i suggested above, I think I could do this by removing a cpu's current
cluster for a given order from the percpu_cluster and making it generally
available for scanning. Does that work for you?

> 
>> +	} else {
>> +		idx = offset / SWAPFILE_CLUSTER;
>> +		ci = lock_cluster(si, offset);
>> +	}
>> +
>> +	memset(si->swap_map + offset, SWAP_HAS_CACHE, nr_pages);
>>  	unlock_cluster(ci);
>> -	swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
>> +	swap_range_alloc(si, offset, nr_pages);
>>  	*slot = swp_entry(si->type, offset);
>>
>> +	offset += nr_pages;
>> +	if (idx != offset / SWAPFILE_CLUSTER)
>> +		offset = UINT_MAX;
>> +	cluster->large_next[order_idx] = offset;
>> +
>>  	return 1;
>>  }
>>
> 
> [snip]
> 
> --
> Best Regards,
> Huang, Ying

