Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD09D7E024E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346169AbjKCLme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCLmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:42:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C33A134
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:42:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E66DFC15;
        Fri,  3 Nov 2023 04:43:11 -0700 (PDT)
Received: from [10.57.71.183] (unknown [10.57.71.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 954923F703;
        Fri,  3 Nov 2023 04:42:27 -0700 (PDT)
Message-ID: <1bec0057-8d8c-433f-aee6-e6b2f781aa54@arm.com>
Date:   Fri, 3 Nov 2023 11:42:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without
 splitting
Content-Language: en-GB
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@googleN.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231025144546.577640-5-ryan.roberts@arm.com>
 <87o7gga5ga.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <581e3d59-1d04-4c88-8b60-74fd7513c0d9@arm.com>
 <87pm0v8b32.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87pm0v8b32.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 08:12, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> On 30/10/2023 08:18, Huang, Ying wrote:
>>> Hi, Ryan,
>>>
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> The upcoming anonymous small-sized THP feature enables performance
>>>> improvements by allocating large folios for anonymous memory. However
>>>> I've observed that on an arm64 system running a parallel workload (e.g.
>>>> kernel compilation) across many cores, under high memory pressure, the
>>>> speed regresses. This is due to bottlenecking on the increased number of
>>>> TLBIs added due to all the extra folio splitting.
>>>>
>>>> Therefore, solve this regression by adding support for swapping out
>>>> small-sized THP without needing to split the folio, just like is already
>>>> done for PMD-sized THP. This change only applies when CONFIG_THP_SWAP is
>>>> enabled, and when the swap backing store is a non-rotating block device.
>>>> These are the same constraints as for the existing PMD-sized THP
>>>> swap-out support.
>>>>
>>>> Note that no attempt is made to swap-in THP here - this is still done
>>>> page-by-page, like for PMD-sized THP.
>>>>
>>>> The main change here is to improve the swap entry allocator so that it
>>>> can allocate any power-of-2 number of contiguous entries between [1, (1
>>>> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
>>>> order and allocating sequentially from it until the cluster is full.
>>>> This ensures that we don't need to search the map and we get no
>>>> fragmentation due to alignment padding for different orders in the
>>>> cluster. If there is no current cluster for a given order, we attempt to
>>>> allocate a free cluster from the list. If there are no free clusters, we
>>>> fail the allocation and the caller falls back to splitting the folio and
>>>> allocates individual entries (as per existing PMD-sized THP fallback).
>>>>
>>>> The per-order current clusters are maintained per-cpu using the existing
>>>> infrastructure. This is done to avoid interleving pages from different
>>>> tasks, which would prevent IO being batched. This is already done for
>>>> the order-0 allocations so we follow the same pattern.
>>>> __scan_swap_map_try_ssd_cluster() is introduced to deal with arbitrary
>>>> orders and scan_swap_map_try_ssd_cluster() is refactored as a wrapper
>>>> for order-0.
>>>>
>>>> As is done for order-0 per-cpu clusters, the scanner now can steal
>>>> order-0 entries from any per-cpu-per-order reserved cluster. This
>>>> ensures that when the swap file is getting full, space doesn't get tied
>>>> up in the per-cpu reserves.
>>>>
>>>> I've run the tests on Ampere Altra (arm64), set up with a 35G block ram
>>>> device as the swap device and from inside a memcg limited to 40G memory.
>>>> I've then run `usemem` from vm-scalability with 70 processes (each has
>>>> its own core), each allocating and writing 1G of memory. I've repeated
>>>> everything 5 times and taken the mean:
>>>>
>>>> Mean Performance Improvement vs 4K/baseline
>>>>
>>>> | alloc size |            baseline |       + this series |
>>>> |            |  v6.6-rc4+anonfolio |                     |
>>>> |:-----------|--------------------:|--------------------:|
>>>> | 4K Page    |                0.0% |                4.9% |
>>>> | 64K THP    |              -44.1% |               10.7% |
>>>> | 2M THP     |               56.0% |               65.9% |
>>>>
>>>> So with this change, the regression for 64K swap performance goes away
>>>> and 4K and 2M swap improves slightly too.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  include/linux/swap.h |  10 +--
>>>>  mm/swapfile.c        | 149 +++++++++++++++++++++++++++++++------------
>>>>  mm/vmscan.c          |  10 +--
>>>>  3 files changed, 119 insertions(+), 50 deletions(-)
>>>>
>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>> index 0ca8aaa098ba..ccbca5db851b 100644
>>>> --- a/include/linux/swap.h
>>>> +++ b/include/linux/swap.h
>>>> @@ -295,11 +295,11 @@ struct swap_info_struct {
>>>>  	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
>>>>  	unsigned int __percpu *cpu_next;/*
>>>>  					 * Likely next allocation offset. We
>>>> -					 * assign a cluster to each CPU, so each
>>>> -					 * CPU can allocate swap entry from its
>>>> -					 * own cluster and swapout sequentially.
>>>> -					 * The purpose is to optimize swapout
>>>> -					 * throughput.
>>>> +					 * assign a cluster per-order to each
>>>> +					 * CPU, so each CPU can allocate swap
>>>> +					 * entry from its own cluster and
>>>> +					 * swapout sequentially. The purpose is
>>>> +					 * to optimize swapout throughput.
>>>>  					 */
>>>
>>> This is kind of hard to understand.  Better to define some intermediate
>>> data structure to improve readability.  For example,
>>>
>>> #ifdef CONFIG_THP_SWAP
>>> #define NR_SWAP_ORDER   PMD_ORDER
>>> #else
>>> #define NR_SWAP_ORDER   1
>>> #endif
>>>
>>> struct percpu_clusters {
>>>         unsigned int alloc_next[NR_SWAP_ORDER];
>>> };
>>>
>>> PMD_ORDER isn't a constant on powerpc, but THP_SWAP isn't supported on
>>> powerpc too.
>>
>> I get your point, but this is just making it more difficult for powerpc to ever
>> enable the feature in future - you're implicitly depending on !powerpc, which
>> seems fragile. How about if I change the first line of the coment to be "per-cpu
>> array indexed by allocation order"? Would that be enough?
> 
> Even if PMD_ORDER isn't constant on powerpc, it's not necessary for
> NR_SWAP_ORDER to be variable.  At least (1 << (NR_SWAP_ORDER-1)) should
> < SWAPFILE_CLUSTER.  When someone adds THP swap support on powerpc, he
> can choose a reasonable constant for NR_SWAP_ORDER (for example, 10 or
> 7).
> 
>>>
>>>>  	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
>>>>  	struct block_device *bdev;	/* swap device or bdev of swap file */
>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>> index 94f7cc225eb9..b50bce50bed9 100644
>>>> --- a/mm/swapfile.c
>>>> +++ b/mm/swapfile.c
>>>> @@ -545,10 +545,12 @@ static void free_cluster(struct swap_info_struct *si, unsigned long idx)
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
>>>> @@ -557,9 +559,19 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
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
>>>> + * removed from free cluster list and its usage counter will be increased.
>>>> + */
>>>> +static void inc_cluster_info_page(struct swap_info_struct *p,
>>>> +	struct swap_cluster_info *cluster_info, unsigned long page_nr)
>>>> +{
>>>> +	add_cluster_info_page(p, cluster_info, page_nr, 1);
>>>>  }
>>>>  
>>>>  /*
>>>> @@ -588,8 +600,8 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
>>>>   * cluster list. Avoiding such abuse to avoid list corruption.
>>>>   */
>>>>  static bool
>>>> -scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>>> -	unsigned long offset)
>>>> +__scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>>> +	unsigned long offset, int order)
>>>>  {
>>>>  	bool conflict;
>>>>  
>>>> @@ -601,23 +613,36 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>>>  	if (!conflict)
>>>>  		return false;
>>>>  
>>>> -	*this_cpu_ptr(si->cpu_next) = SWAP_NEXT_NULL;
>>>> +	this_cpu_ptr(si->cpu_next)[order] = SWAP_NEXT_NULL;
>>>
>>> This is added in the previous patch.  I don't think SWAP_NEXT_NULL is a
>>> good name.  Because NEXT isn't a pointer (while cluster_next is). Better
>>> to name it as SWAP_NEXT_INVALID, etc.
>>
>> ACK, will make change for next version.
> 
> Thanks!
> 
>>>
>>>>  	return true;
>>>>  }
>>>>  
>>>>  /*
>>>> - * Try to get a swap entry from current cpu's swap entry pool (a cluster). This
>>>> - * might involve allocating a new cluster for current CPU too.
>>>> + * It's possible scan_swap_map_slots() uses a free cluster in the middle of free
>>>> + * cluster list. Avoiding such abuse to avoid list corruption.
>>>>   */
>>>> -static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>>> -	unsigned long *offset, unsigned long *scan_base)
>>>> +static bool
>>>> +scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>>> +	unsigned long offset)
>>>> +{
>>>> +	return __scan_swap_map_ssd_cluster_conflict(si, offset, 0);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Try to get a swap entry (or size indicated by order) from current cpu's swap
>>>> + * entry pool (a cluster). This might involve allocating a new cluster for
>>>> + * current CPU too.
>>>> + */
>>>> +static bool __scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>>> +	unsigned long *offset, unsigned long *scan_base, int order)
>>>>  {
>>>>  	struct swap_cluster_info *ci;
>>>> -	unsigned int tmp, max;
>>>> +	unsigned int tmp, max, i;
>>>>  	unsigned int *cpu_next;
>>>> +	unsigned int nr_pages = 1 << order;
>>>>  
>>>>  new_cluster:
>>>> -	cpu_next = this_cpu_ptr(si->cpu_next);
>>>> +	cpu_next = &this_cpu_ptr(si->cpu_next)[order];
>>>>  	tmp = *cpu_next;
>>>>  	if (tmp == SWAP_NEXT_NULL) {
>>>>  		if (!cluster_list_empty(&si->free_clusters)) {
>>>> @@ -643,10 +668,12 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>>>  	 * reserve a new cluster.
>>>>  	 */
>>>>  	ci = lock_cluster(si, tmp);
>>>> -	if (si->swap_map[tmp]) {
>>>> -		unlock_cluster(ci);
>>>> -		*cpu_next = SWAP_NEXT_NULL;
>>>> -		goto new_cluster;
>>>> +	for (i = 0; i < nr_pages; i++) {
>>>> +		if (si->swap_map[tmp + i]) {
>>>> +			unlock_cluster(ci);
>>>> +			*cpu_next = SWAP_NEXT_NULL;
>>>> +			goto new_cluster;
>>>> +		}
>>>>  	}
>>>>  	unlock_cluster(ci);
>>>>  
>>>> @@ -654,12 +681,22 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>>>  	*scan_base = tmp;
>>>>  
>>>>  	max = ALIGN_DOWN(tmp, SWAPFILE_CLUSTER) + SWAPFILE_CLUSTER;
>>>
>>> This line is added in a previous patch.  Can we just use
>>>
>>>         max = ALIGN(tmp + 1, SWAPFILE_CLUSTER);
>>
>> Sure. This is how I originally had it, but then decided that the other approach
>> was a bit clearer. But I don't have a strong opinion, so I'll change it as you
>> suggest.
> 
> Thanks!
> 
>>>
>>> Or, add ALIGN_UP() for this?
>>>
>>>> -	tmp += 1;
>>>> +	tmp += nr_pages;
>>>>  	*cpu_next = tmp < max ? tmp : SWAP_NEXT_NULL;
>>>>  
>>>>  	return true;
>>>>  }
>>>>  
>>>> +/*
>>>> + * Try to get a swap entry from current cpu's swap entry pool (a cluster). This
>>>> + * might involve allocating a new cluster for current CPU too.
>>>> + */
>>>> +static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>>> +	unsigned long *offset, unsigned long *scan_base)
>>>> +{
>>>> +	return __scan_swap_map_try_ssd_cluster(si, offset, scan_base, 0);
>>>> +}
>>>> +
>>>>  static void __del_from_avail_list(struct swap_info_struct *p)
>>>>  {
>>>>  	int nid;
>>>> @@ -982,35 +1019,58 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>>  	return n_ret;
>>>>  }
>>>>  
>>>> -static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
>>>> +static int swap_alloc_large(struct swap_info_struct *si, swp_entry_t *slot,
>>>> +			    unsigned int nr_pages)
>>>
>>> IMHO, it's better to make scan_swap_map_slots() to support order > 0
>>> instead of making swap_alloc_cluster() to support order != PMD_ORDER.
>>> And, we may merge swap_alloc_cluster() with scan_swap_map_slots() after
>>> that.
>>
>> I did consider adding a 5th patch to rename swap_alloc_large() to something like
>> swap_alloc_one_ssd_entry() (which would then be used for order=0 too) and
>> refactor scan_swap_map_slots() to fully delegate to it for the non-scaning ssd
>> allocation case. Would something like that suit?
>>
>> I have reservations about making scan_swap_map_slots() take an order and be the
>> sole entry point:
>>
>>   - in the non-ssd case, we can't support order!=0
> 
> Don't need to check ssd directly, we only support order != 0 if
> si->cluster_info != NULL.
> 
>>   - there is a lot of other logic to deal with falling back to scanning which we
>>     would only want to do for order==0, so we would end up with a few ugly
>>     conditionals against order.
> 
> We don't need to care about them in most cases.  IIUC, only the "goto
> scan" after scan_swap_map_try_ssd_cluster() return false need to "goto
> no_page" for order != 0.
> 
>>   - I was concerned the risk of me introducing a bug when refactoring all that
>>     subtle logic was high
> 
> IMHO, readability is more important for long term maintenance.  So, we
> need to refactor the existing code for that.
> 
>> What do you think? Is not making scan_swap_map_slots() support order > 0 a deal
>> breaker for you?
> 
> I just think that it's better to use scan_swap_map_slots() for any order
> other than PMD_ORDER.  In that way, we share as much code as possible.

OK, I'll take a look at implementing it as you propose, although I likely won't
have bandwidth until start of December. Will repost once I have something.

Thanks,
Ryan

> 
> --
> Best Regards,
> Huang, Ying

