Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D6D7DC7F7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjJaIO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjJaIO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:14:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9DBC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698740062; x=1730276062;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nn8aG/qwp31DynVdhC5f/5kYJcYQBtqnJ1gzCFyQEVc=;
  b=lFuDhkrro6OcMt1Pi0Kvt7RwpM/fX9Prws7qIayiRaOJzUXaM8oSWYff
   W/Y3mWJC7c7SIh4/ozmbkG6k3ONsKIdknDbXsmJxz+VdBy/optxOUyRQt
   HO72jMroekwpBsb3iZca3uvswxr+DlqohFFcMpPSfoZaqOaZINaZhPNyp
   JlDUlEEDo/Vspp6XHb0+Gj/TjBkJ8kETjgEfZg2baivvzS3jBECUGIaFn
   +QaDijCSTEx7w3JOn5TaXxEkW0z/XdIyy3tJPN9pI68NZhRiFA/vu5teN
   KIMOWgTUZDZGYAvImpPS/C0wSqS5P0FT1BWrsmizNxaLvMVaVjIU8mJIp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367582479"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="367582479"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 01:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="826329263"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="826329263"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 01:14:19 -0700
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
In-Reply-To: <581e3d59-1d04-4c88-8b60-74fd7513c0d9@arm.com> (Ryan Roberts's
        message of "Mon, 30 Oct 2023 13:59:51 +0000")
References: <20231025144546.577640-1-ryan.roberts@arm.com>
        <20231025144546.577640-5-ryan.roberts@arm.com>
        <87o7gga5ga.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <581e3d59-1d04-4c88-8b60-74fd7513c0d9@arm.com>
Date:   Tue, 31 Oct 2023 16:12:17 +0800
Message-ID: <87pm0v8b32.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 30/10/2023 08:18, Huang, Ying wrote:
>> Hi, Ryan,
>> 
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> The upcoming anonymous small-sized THP feature enables performance
>>> improvements by allocating large folios for anonymous memory. However
>>> I've observed that on an arm64 system running a parallel workload (e.g.
>>> kernel compilation) across many cores, under high memory pressure, the
>>> speed regresses. This is due to bottlenecking on the increased number of
>>> TLBIs added due to all the extra folio splitting.
>>>
>>> Therefore, solve this regression by adding support for swapping out
>>> small-sized THP without needing to split the folio, just like is already
>>> done for PMD-sized THP. This change only applies when CONFIG_THP_SWAP is
>>> enabled, and when the swap backing store is a non-rotating block device.
>>> These are the same constraints as for the existing PMD-sized THP
>>> swap-out support.
>>>
>>> Note that no attempt is made to swap-in THP here - this is still done
>>> page-by-page, like for PMD-sized THP.
>>>
>>> The main change here is to improve the swap entry allocator so that it
>>> can allocate any power-of-2 number of contiguous entries between [1, (1
>>> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
>>> order and allocating sequentially from it until the cluster is full.
>>> This ensures that we don't need to search the map and we get no
>>> fragmentation due to alignment padding for different orders in the
>>> cluster. If there is no current cluster for a given order, we attempt to
>>> allocate a free cluster from the list. If there are no free clusters, we
>>> fail the allocation and the caller falls back to splitting the folio and
>>> allocates individual entries (as per existing PMD-sized THP fallback).
>>>
>>> The per-order current clusters are maintained per-cpu using the existing
>>> infrastructure. This is done to avoid interleving pages from different
>>> tasks, which would prevent IO being batched. This is already done for
>>> the order-0 allocations so we follow the same pattern.
>>> __scan_swap_map_try_ssd_cluster() is introduced to deal with arbitrary
>>> orders and scan_swap_map_try_ssd_cluster() is refactored as a wrapper
>>> for order-0.
>>>
>>> As is done for order-0 per-cpu clusters, the scanner now can steal
>>> order-0 entries from any per-cpu-per-order reserved cluster. This
>>> ensures that when the swap file is getting full, space doesn't get tied
>>> up in the per-cpu reserves.
>>>
>>> I've run the tests on Ampere Altra (arm64), set up with a 35G block ram
>>> device as the swap device and from inside a memcg limited to 40G memory.
>>> I've then run `usemem` from vm-scalability with 70 processes (each has
>>> its own core), each allocating and writing 1G of memory. I've repeated
>>> everything 5 times and taken the mean:
>>>
>>> Mean Performance Improvement vs 4K/baseline
>>>
>>> | alloc size |            baseline |       + this series |
>>> |            |  v6.6-rc4+anonfolio |                     |
>>> |:-----------|--------------------:|--------------------:|
>>> | 4K Page    |                0.0% |                4.9% |
>>> | 64K THP    |              -44.1% |               10.7% |
>>> | 2M THP     |               56.0% |               65.9% |
>>>
>>> So with this change, the regression for 64K swap performance goes away
>>> and 4K and 2M swap improves slightly too.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  include/linux/swap.h |  10 +--
>>>  mm/swapfile.c        | 149 +++++++++++++++++++++++++++++++------------
>>>  mm/vmscan.c          |  10 +--
>>>  3 files changed, 119 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index 0ca8aaa098ba..ccbca5db851b 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -295,11 +295,11 @@ struct swap_info_struct {
>>>  	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
>>>  	unsigned int __percpu *cpu_next;/*
>>>  					 * Likely next allocation offset. We
>>> -					 * assign a cluster to each CPU, so each
>>> -					 * CPU can allocate swap entry from its
>>> -					 * own cluster and swapout sequentially.
>>> -					 * The purpose is to optimize swapout
>>> -					 * throughput.
>>> +					 * assign a cluster per-order to each
>>> +					 * CPU, so each CPU can allocate swap
>>> +					 * entry from its own cluster and
>>> +					 * swapout sequentially. The purpose is
>>> +					 * to optimize swapout throughput.
>>>  					 */
>> 
>> This is kind of hard to understand.  Better to define some intermediate
>> data structure to improve readability.  For example,
>> 
>> #ifdef CONFIG_THP_SWAP
>> #define NR_SWAP_ORDER   PMD_ORDER
>> #else
>> #define NR_SWAP_ORDER   1
>> #endif
>> 
>> struct percpu_clusters {
>>         unsigned int alloc_next[NR_SWAP_ORDER];
>> };
>> 
>> PMD_ORDER isn't a constant on powerpc, but THP_SWAP isn't supported on
>> powerpc too.
>
> I get your point, but this is just making it more difficult for powerpc to ever
> enable the feature in future - you're implicitly depending on !powerpc, which
> seems fragile. How about if I change the first line of the coment to be "per-cpu
> array indexed by allocation order"? Would that be enough?

Even if PMD_ORDER isn't constant on powerpc, it's not necessary for
NR_SWAP_ORDER to be variable.  At least (1 << (NR_SWAP_ORDER-1)) should
< SWAPFILE_CLUSTER.  When someone adds THP swap support on powerpc, he
can choose a reasonable constant for NR_SWAP_ORDER (for example, 10 or
7).

>> 
>>>  	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
>>>  	struct block_device *bdev;	/* swap device or bdev of swap file */
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index 94f7cc225eb9..b50bce50bed9 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -545,10 +545,12 @@ static void free_cluster(struct swap_info_struct *si, unsigned long idx)
>>>  
>>>  /*
>>>   * The cluster corresponding to page_nr will be used. The cluster will be
>>> - * removed from free cluster list and its usage counter will be increased.
>>> + * removed from free cluster list and its usage counter will be increased by
>>> + * count.
>>>   */
>>> -static void inc_cluster_info_page(struct swap_info_struct *p,
>>> -	struct swap_cluster_info *cluster_info, unsigned long page_nr)
>>> +static void add_cluster_info_page(struct swap_info_struct *p,
>>> +	struct swap_cluster_info *cluster_info, unsigned long page_nr,
>>> +	unsigned long count)
>>>  {
>>>  	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
>>>  
>>> @@ -557,9 +559,19 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
>>>  	if (cluster_is_free(&cluster_info[idx]))
>>>  		alloc_cluster(p, idx);
>>>  
>>> -	VM_BUG_ON(cluster_count(&cluster_info[idx]) >= SWAPFILE_CLUSTER);
>>> +	VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CLUSTER);
>>>  	cluster_set_count(&cluster_info[idx],
>>> -		cluster_count(&cluster_info[idx]) + 1);
>>> +		cluster_count(&cluster_info[idx]) + count);
>>> +}
>>> +
>>> +/*
>>> + * The cluster corresponding to page_nr will be used. The cluster will be
>>> + * removed from free cluster list and its usage counter will be increased.
>>> + */
>>> +static void inc_cluster_info_page(struct swap_info_struct *p,
>>> +	struct swap_cluster_info *cluster_info, unsigned long page_nr)
>>> +{
>>> +	add_cluster_info_page(p, cluster_info, page_nr, 1);
>>>  }
>>>  
>>>  /*
>>> @@ -588,8 +600,8 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
>>>   * cluster list. Avoiding such abuse to avoid list corruption.
>>>   */
>>>  static bool
>>> -scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>> -	unsigned long offset)
>>> +__scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>> +	unsigned long offset, int order)
>>>  {
>>>  	bool conflict;
>>>  
>>> @@ -601,23 +613,36 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>>  	if (!conflict)
>>>  		return false;
>>>  
>>> -	*this_cpu_ptr(si->cpu_next) = SWAP_NEXT_NULL;
>>> +	this_cpu_ptr(si->cpu_next)[order] = SWAP_NEXT_NULL;
>> 
>> This is added in the previous patch.  I don't think SWAP_NEXT_NULL is a
>> good name.  Because NEXT isn't a pointer (while cluster_next is). Better
>> to name it as SWAP_NEXT_INVALID, etc.
>
> ACK, will make change for next version.

Thanks!

>> 
>>>  	return true;
>>>  }
>>>  
>>>  /*
>>> - * Try to get a swap entry from current cpu's swap entry pool (a cluster). This
>>> - * might involve allocating a new cluster for current CPU too.
>>> + * It's possible scan_swap_map_slots() uses a free cluster in the middle of free
>>> + * cluster list. Avoiding such abuse to avoid list corruption.
>>>   */
>>> -static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>> -	unsigned long *offset, unsigned long *scan_base)
>>> +static bool
>>> +scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>> +	unsigned long offset)
>>> +{
>>> +	return __scan_swap_map_ssd_cluster_conflict(si, offset, 0);
>>> +}
>>> +
>>> +/*
>>> + * Try to get a swap entry (or size indicated by order) from current cpu's swap
>>> + * entry pool (a cluster). This might involve allocating a new cluster for
>>> + * current CPU too.
>>> + */
>>> +static bool __scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>> +	unsigned long *offset, unsigned long *scan_base, int order)
>>>  {
>>>  	struct swap_cluster_info *ci;
>>> -	unsigned int tmp, max;
>>> +	unsigned int tmp, max, i;
>>>  	unsigned int *cpu_next;
>>> +	unsigned int nr_pages = 1 << order;
>>>  
>>>  new_cluster:
>>> -	cpu_next = this_cpu_ptr(si->cpu_next);
>>> +	cpu_next = &this_cpu_ptr(si->cpu_next)[order];
>>>  	tmp = *cpu_next;
>>>  	if (tmp == SWAP_NEXT_NULL) {
>>>  		if (!cluster_list_empty(&si->free_clusters)) {
>>> @@ -643,10 +668,12 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>>  	 * reserve a new cluster.
>>>  	 */
>>>  	ci = lock_cluster(si, tmp);
>>> -	if (si->swap_map[tmp]) {
>>> -		unlock_cluster(ci);
>>> -		*cpu_next = SWAP_NEXT_NULL;
>>> -		goto new_cluster;
>>> +	for (i = 0; i < nr_pages; i++) {
>>> +		if (si->swap_map[tmp + i]) {
>>> +			unlock_cluster(ci);
>>> +			*cpu_next = SWAP_NEXT_NULL;
>>> +			goto new_cluster;
>>> +		}
>>>  	}
>>>  	unlock_cluster(ci);
>>>  
>>> @@ -654,12 +681,22 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>>  	*scan_base = tmp;
>>>  
>>>  	max = ALIGN_DOWN(tmp, SWAPFILE_CLUSTER) + SWAPFILE_CLUSTER;
>> 
>> This line is added in a previous patch.  Can we just use
>> 
>>         max = ALIGN(tmp + 1, SWAPFILE_CLUSTER);
>
> Sure. This is how I originally had it, but then decided that the other approach
> was a bit clearer. But I don't have a strong opinion, so I'll change it as you
> suggest.

Thanks!

>> 
>> Or, add ALIGN_UP() for this?
>> 
>>> -	tmp += 1;
>>> +	tmp += nr_pages;
>>>  	*cpu_next = tmp < max ? tmp : SWAP_NEXT_NULL;
>>>  
>>>  	return true;
>>>  }
>>>  
>>> +/*
>>> + * Try to get a swap entry from current cpu's swap entry pool (a cluster). This
>>> + * might involve allocating a new cluster for current CPU too.
>>> + */
>>> +static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>> +	unsigned long *offset, unsigned long *scan_base)
>>> +{
>>> +	return __scan_swap_map_try_ssd_cluster(si, offset, scan_base, 0);
>>> +}
>>> +
>>>  static void __del_from_avail_list(struct swap_info_struct *p)
>>>  {
>>>  	int nid;
>>> @@ -982,35 +1019,58 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>  	return n_ret;
>>>  }
>>>  
>>> -static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
>>> +static int swap_alloc_large(struct swap_info_struct *si, swp_entry_t *slot,
>>> +			    unsigned int nr_pages)
>> 
>> IMHO, it's better to make scan_swap_map_slots() to support order > 0
>> instead of making swap_alloc_cluster() to support order != PMD_ORDER.
>> And, we may merge swap_alloc_cluster() with scan_swap_map_slots() after
>> that.
>
> I did consider adding a 5th patch to rename swap_alloc_large() to something like
> swap_alloc_one_ssd_entry() (which would then be used for order=0 too) and
> refactor scan_swap_map_slots() to fully delegate to it for the non-scaning ssd
> allocation case. Would something like that suit?
>
> I have reservations about making scan_swap_map_slots() take an order and be the
> sole entry point:
>
>   - in the non-ssd case, we can't support order!=0

Don't need to check ssd directly, we only support order != 0 if
si->cluster_info != NULL.

>   - there is a lot of other logic to deal with falling back to scanning which we
>     would only want to do for order==0, so we would end up with a few ugly
>     conditionals against order.

We don't need to care about them in most cases.  IIUC, only the "goto
scan" after scan_swap_map_try_ssd_cluster() return false need to "goto
no_page" for order != 0.

>   - I was concerned the risk of me introducing a bug when refactoring all that
>     subtle logic was high

IMHO, readability is more important for long term maintenance.  So, we
need to refactor the existing code for that.

> What do you think? Is not making scan_swap_map_slots() support order > 0 a deal
> breaker for you?

I just think that it's better to use scan_swap_map_slots() for any order
other than PMD_ORDER.  In that way, we share as much code as possible.

--
Best Regards,
Huang, Ying
