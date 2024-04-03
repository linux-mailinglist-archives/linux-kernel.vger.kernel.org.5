Return-Path: <linux-kernel+bounces-129217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3A689671F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9CEB28FBA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F0760267;
	Wed,  3 Apr 2024 07:48:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935C8286A6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130527; cv=none; b=sKSzRcaW1l/Ef9RMw/qcPCGrFKgEsk+5hRa2VTp7gbqG4t4FwVI+Pf8OHM8jiavmcglU7LPjfY9idM6C42LZRZjO2/wWJDeBAadgjFCOIpY/Sfm3mEsKuj+ks6Y/ZPj27wajNp+pKU/LL0Iq6VxiWLMZZj0wdBW7HqjacPoKw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130527; c=relaxed/simple;
	bh=y9VvcHmgUjjoeI5lKnDhfqtAa09LFx3qDFmUcrGnXAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqMT9oJILj1moxLW4IjsxTYslRXkdZYy3DBPJD9Oph5nkzTXwa+WkKw40VwqcLs1Pd8bxQDINbb1ScgwiqExzwoKfv5odon6a1zrkxEZSpfXW9d4kK6BdS3wgX5sHTD19zsx9hgiyrvVrt9TQAQSiMKCnpK+fiC48bf2EBfjk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 090CC1007;
	Wed,  3 Apr 2024 00:49:15 -0700 (PDT)
Received: from [10.57.72.245] (unknown [10.57.72.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CC0A3F7B4;
	Wed,  3 Apr 2024 00:48:41 -0700 (PDT)
Message-ID: <e5911bd7-7b33-4e6f-a844-fbac0db31af5@arm.com>
Date: Wed, 3 Apr 2024 08:48:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: swap: Allow storage of all mTHP orders
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
 <20240327144537.4165578-5-ryan.roberts@arm.com>
 <87o7atkc3i.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <017632d3-7de8-407a-aaa4-caaa5ebab057@arm.com>
 <8734s3f8jt.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8734s3f8jt.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 04:07, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> On 01/04/2024 04:15, Huang, Ying wrote:
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> Multi-size THP enables performance improvements by allocating large,
>>>> pte-mapped folios for anonymous memory. However I've observed that on an
>>>> arm64 system running a parallel workload (e.g. kernel compilation)
>>>> across many cores, under high memory pressure, the speed regresses. This
>>>> is due to bottlenecking on the increased number of TLBIs added due to
>>>> all the extra folio splitting when the large folios are swapped out.
>>>>
>>>> Therefore, solve this regression by adding support for swapping out mTHP
>>>> without needing to split the folio, just like is already done for
>>>> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
>>>> and when the swap backing store is a non-rotating block device. These
>>>> are the same constraints as for the existing PMD-sized THP swap-out
>>>> support.
>>>>
>>>> Note that no attempt is made to swap-in (m)THP here - this is still done
>>>> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
>>>> prerequisite for swapping-in mTHP.
>>>>
>>>> The main change here is to improve the swap entry allocator so that it
>>>> can allocate any power-of-2 number of contiguous entries between [1, (1
>>>> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
>>>> order and allocating sequentially from it until the cluster is full.
>>>> This ensures that we don't need to search the map and we get no
>>>> fragmentation due to alignment padding for different orders in the
>>>> cluster. If there is no current cluster for a given order, we attempt to
>>>> allocate a free cluster from the list. If there are no free clusters, we
>>>> fail the allocation and the caller can fall back to splitting the folio
>>>> and allocates individual entries (as per existing PMD-sized THP
>>>> fallback).
>>>>
>>>> The per-order current clusters are maintained per-cpu using the existing
>>>> infrastructure. This is done to avoid interleving pages from different
>>>> tasks, which would prevent IO being batched. This is already done for
>>>> the order-0 allocations so we follow the same pattern.
>>>>
>>>> As is done for order-0 per-cpu clusters, the scanner now can steal
>>>> order-0 entries from any per-cpu-per-order reserved cluster. This
>>>> ensures that when the swap file is getting full, space doesn't get tied
>>>> up in the per-cpu reserves.
>>>>
>>>> This change only modifies swap to be able to accept any order mTHP. It
>>>> doesn't change the callers to elide doing the actual split. That will be
>>>> done in separate changes.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  include/linux/swap.h |  10 ++-
>>>>  mm/swap_slots.c      |   6 +-
>>>>  mm/swapfile.c        | 175 ++++++++++++++++++++++++-------------------
>>>>  3 files changed, 109 insertions(+), 82 deletions(-)
>>>>
>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>> index 5e1e4f5bf0cb..11c53692f65f 100644
>>>> --- a/include/linux/swap.h
>>>> +++ b/include/linux/swap.h
>>>> @@ -268,13 +268,19 @@ struct swap_cluster_info {
>>>>   */
>>>>  #define SWAP_NEXT_INVALID	0
>>>>  
>>>> +#ifdef CONFIG_THP_SWAP
>>>> +#define SWAP_NR_ORDERS		(PMD_ORDER + 1)
>>>> +#else
>>>> +#define SWAP_NR_ORDERS		1
>>>> +#endif
>>>> +
>>>>  /*
>>>>   * We assign a cluster to each CPU, so each CPU can allocate swap entry from
>>>>   * its own cluster and swapout sequentially. The purpose is to optimize swapout
>>>>   * throughput.
>>>>   */
>>>>  struct percpu_cluster {
>>>> -	unsigned int next; /* Likely next allocation offset */
>>>> +	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
>>>>  };
>>>>  
>>>>  struct swap_cluster_list {
>>>> @@ -471,7 +477,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio);
>>>>  bool folio_free_swap(struct folio *folio);
>>>>  void put_swap_folio(struct folio *folio, swp_entry_t entry);
>>>>  extern swp_entry_t get_swap_page_of_type(int);
>>>> -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
>>>> +extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
>>>>  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>>>>  extern void swap_shmem_alloc(swp_entry_t);
>>>>  extern int swap_duplicate(swp_entry_t);
>>>> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
>>>> index 53abeaf1371d..13ab3b771409 100644
>>>> --- a/mm/swap_slots.c
>>>> +++ b/mm/swap_slots.c
>>>> @@ -264,7 +264,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
>>>>  	cache->cur = 0;
>>>>  	if (swap_slot_cache_active)
>>>>  		cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
>>>> -					   cache->slots, 1);
>>>> +					   cache->slots, 0);
>>>>  
>>>>  	return cache->nr;
>>>>  }
>>>> @@ -311,7 +311,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>>>>  
>>>>  	if (folio_test_large(folio)) {
>>>>  		if (IS_ENABLED(CONFIG_THP_SWAP))
>>>> -			get_swap_pages(1, &entry, folio_nr_pages(folio));
>>>> +			get_swap_pages(1, &entry, folio_order(folio));
>>>>  		goto out;
>>>>  	}
>>>>  
>>>> @@ -343,7 +343,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>>>>  			goto out;
>>>>  	}
>>>>  
>>>> -	get_swap_pages(1, &entry, 1);
>>>> +	get_swap_pages(1, &entry, 0);
>>>>  out:
>>>>  	if (mem_cgroup_try_charge_swap(folio, entry)) {
>>>>  		put_swap_folio(folio, entry);
>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>> index 1393966b77af..d56cdc547a06 100644
>>>> --- a/mm/swapfile.c
>>>> +++ b/mm/swapfile.c
>>>> @@ -278,15 +278,15 @@ static void discard_swap_cluster(struct swap_info_struct *si,
>>>>  #ifdef CONFIG_THP_SWAP
>>>>  #define SWAPFILE_CLUSTER	HPAGE_PMD_NR
>>>>  
>>>> -#define swap_entry_size(size)	(size)
>>>> +#define swap_entry_order(order)	(order)
>>>>  #else
>>>>  #define SWAPFILE_CLUSTER	256
>>>>  
>>>>  /*
>>>> - * Define swap_entry_size() as constant to let compiler to optimize
>>>> + * Define swap_entry_order() as constant to let compiler to optimize
>>>>   * out some code if !CONFIG_THP_SWAP
>>>>   */
>>>> -#define swap_entry_size(size)	1
>>>> +#define swap_entry_order(order)	0
>>>>  #endif
>>>>  #define LATENCY_LIMIT		256
>>>>  
>>>> @@ -551,10 +551,12 @@ static void free_cluster(struct swap_info_struct *si, unsigned long idx)
>>>>  
>>>>  /*
>>>>   * The cluster corresponding to page_nr will be used. The cluster will be
>>>> - * removed from free cluster list and its usage counter will be increased.
>>>> + * removed from free cluster list and its usage counter will be increased by
>>>> + * count.
>>>>   */
>>>> -static void inc_cluster_info_page(struct swap_info_struct *p,
>>>> -	struct swap_cluster_info *cluster_info, unsigned long page_nr)
>>>> +static void add_cluster_info_page(struct swap_info_struct *p,
>>>> +	struct swap_cluster_info *cluster_info, unsigned long page_nr,
>>>> +	unsigned long count)
>>>>  {
>>>>  	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
>>>>  
>>>> @@ -563,9 +565,19 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
>>>>  	if (cluster_is_free(&cluster_info[idx]))
>>>>  		alloc_cluster(p, idx);
>>>>  
>>>> -	VM_BUG_ON(cluster_count(&cluster_info[idx]) >= SWAPFILE_CLUSTER);
>>>> +	VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CLUSTER);
>>>>  	cluster_set_count(&cluster_info[idx],
>>>> -		cluster_count(&cluster_info[idx]) + 1);
>>>> +		cluster_count(&cluster_info[idx]) + count);
>>>> +}
>>>> +
>>>> +/*
>>>> + * The cluster corresponding to page_nr will be used. The cluster will be
>>>> + * removed from free cluster list and its usage counter will be increased by 1.
>>>> + */
>>>> +static void inc_cluster_info_page(struct swap_info_struct *p,
>>>> +	struct swap_cluster_info *cluster_info, unsigned long page_nr)
>>>> +{
>>>> +	add_cluster_info_page(p, cluster_info, page_nr, 1);
>>>>  }
>>>>  
>>>>  /*
>>>> @@ -595,7 +607,7 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
>>>>   */
>>>>  static bool
>>>>  scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>>> -	unsigned long offset)
>>>> +	unsigned long offset, int order)
>>>>  {
>>>>  	struct percpu_cluster *percpu_cluster;
>>>>  	bool conflict;
>>>> @@ -609,24 +621,39 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>>>  		return false;
>>>>  
>>>>  	percpu_cluster = this_cpu_ptr(si->percpu_cluster);
>>>> -	percpu_cluster->next = SWAP_NEXT_INVALID;
>>>> +	percpu_cluster->next[order] = SWAP_NEXT_INVALID;
>>>> +	return true;
>>>> +}
>>>> +
>>>> +static inline bool swap_range_empty(char *swap_map, unsigned int start,
>>>> +				    unsigned int nr_pages)
>>>> +{
>>>> +	unsigned int i;
>>>> +
>>>> +	for (i = 0; i < nr_pages; i++) {
>>>> +		if (swap_map[start + i])
>>>> +			return false;
>>>> +	}
>>>> +
>>>>  	return true;
>>>>  }
>>>>  
>>>>  /*
>>>> - * Try to get a swap entry from current cpu's swap entry pool (a cluster). This
>>>> - * might involve allocating a new cluster for current CPU too.
>>>> + * Try to get swap entries with specified order from current cpu's swap entry
>>>> + * pool (a cluster). This might involve allocating a new cluster for current CPU
>>>> + * too.
>>>>   */
>>>>  static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>>> -	unsigned long *offset, unsigned long *scan_base)
>>>> +	unsigned long *offset, unsigned long *scan_base, int order)
>>>>  {
>>>> +	unsigned int nr_pages = 1 << order;
>>>
>>> Use swap_entry_order()?
>>
>> I had previously convinced myself that the compiler should be smart enough to
>> propagate the constant from
>>
>> get_swap_pages -> scan_swap_map_slots -> scan_swap_map_try_ssd_cluster
> 
> Do some experiments via calling function with constants and check the
> compiled code.  It seems that "interprocedural constant propagation" in
> compiler can optimize the code at least if the callee is "static".

Yes; I just confirmed this by compiling swapfile.c to assembly. For the
!CONFIG_THP_SWAP case, as long as get_swap_pages() is using swap_entry_order(),
the constant order=0 is propagated to scan_swap_map_slots() and
scan_swap_map_try_ssd_cluster() implicitly and those functions' assembly is
hardcoded for order=0.

So at least for arm64 with this specific toolchain, it all works as I assumed
and swap_entry_order() is not required in the static functions.

aarch64-none-linux-gnu-gcc (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7)) 13.2.1
20231009

> 
>> But I'll add the explicit macro for the next version, as you suggest.
> 
> So, I will leave it to you to decide whether to do that.

On this basis, I'd rather leave the compiler to do the optimizations itself and
reduce swap_entry_order() usage to a minimum (i.e. only at the non-static entry
points).

Thanks,
Ryan

> 
> --
> Best Regards,
> Huang, Ying
> 
> [snip]


