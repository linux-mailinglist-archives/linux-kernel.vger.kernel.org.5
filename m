Return-Path: <linux-kernel+bounces-135159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AF689BBDB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D381C21FBF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59114482C2;
	Mon,  8 Apr 2024 09:35:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D3E6FBF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568954; cv=none; b=S8h3kqC2DhlasyKowQdc32YHPqMhbcXSUKVtetacacviEOP3XGhkTgG6VK+S8Ze17Eg5pMeXftQOCw01s2vB0u94RFZz/FnxpWuMkMII84CDX5W68QxaUktVUWv8JgTZPeurcQDQy093aNsyxBrlRzYLSq6iSXlDS5zK+M3ZMy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568954; c=relaxed/simple;
	bh=7hCh8G86/2fsEPidW5F9QFigVKQy/nULke71HqInQow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxV4XApm0D3CqPUjimwr/NeMDETnFw7qne/UD3Gx0MMJ3FjCHXpKgwt6C9jBZECiTiU1JIwnj+M2dvhsNtqGyBkVxVQsg98Fh243NJkp6FkZZfcjkwzBtI75IFUHjgTI/uu4jYaMuieoL/SX6KxwKCKJuGB1O3osFU/GvA1DkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC0C41007;
	Mon,  8 Apr 2024 02:36:22 -0700 (PDT)
Received: from [10.57.73.169] (unknown [10.57.73.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAE133F766;
	Mon,  8 Apr 2024 02:35:49 -0700 (PDT)
Message-ID: <521b8246-e327-400b-ae04-8ed97f98703c@arm.com>
Date: Mon, 8 Apr 2024 10:35:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] mm: swap: Allow storage of all mTHP orders
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-5-ryan.roberts@arm.com>
 <c7748c77-b2a3-4b06-aaeb-02793a160aaf@redhat.com>
 <87edbhaexj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ba63464e-afc3-4bbb-b13f-704eaf9ed4af@arm.com>
 <10f8227a-c8e1-4873-aff3-6260cbe4378c@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <10f8227a-c8e1-4873-aff3-6260cbe4378c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/04/2024 10:33, David Hildenbrand wrote:
> On 08.04.24 11:24, Ryan Roberts wrote:
>> On 07/04/2024 07:02, Huang, Ying wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 03.04.24 13:40, Ryan Roberts wrote:
>>>>> Multi-size THP enables performance improvements by allocating large,
>>>>> pte-mapped folios for anonymous memory. However I've observed that on an
>>>>> arm64 system running a parallel workload (e.g. kernel compilation)
>>>>> across many cores, under high memory pressure, the speed regresses. This
>>>>> is due to bottlenecking on the increased number of TLBIs added due to
>>>>> all the extra folio splitting when the large folios are swapped out.
>>>>> Therefore, solve this regression by adding support for swapping out
>>>>> mTHP
>>>>> without needing to split the folio, just like is already done for
>>>>> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
>>>>> and when the swap backing store is a non-rotating block device. These
>>>>> are the same constraints as for the existing PMD-sized THP swap-out
>>>>> support.
>>>>> Note that no attempt is made to swap-in (m)THP here - this is still
>>>>> done
>>>>> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
>>>>> prerequisite for swapping-in mTHP.
>>>>> The main change here is to improve the swap entry allocator so that
>>>>> it
>>>>> can allocate any power-of-2 number of contiguous entries between [1, (1
>>>>> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
>>>>> order and allocating sequentially from it until the cluster is full.
>>>>> This ensures that we don't need to search the map and we get no
>>>>> fragmentation due to alignment padding for different orders in the
>>>>> cluster. If there is no current cluster for a given order, we attempt to
>>>>> allocate a free cluster from the list. If there are no free clusters, we
>>>>> fail the allocation and the caller can fall back to splitting the folio
>>>>> and allocates individual entries (as per existing PMD-sized THP
>>>>> fallback).
>>>>> The per-order current clusters are maintained per-cpu using the
>>>>> existing
>>>>> infrastructure. This is done to avoid interleving pages from different
>>>>> tasks, which would prevent IO being batched. This is already done for
>>>>> the order-0 allocations so we follow the same pattern.
>>>>> As is done for order-0 per-cpu clusters, the scanner now can steal
>>>>> order-0 entries from any per-cpu-per-order reserved cluster. This
>>>>> ensures that when the swap file is getting full, space doesn't get tied
>>>>> up in the per-cpu reserves.
>>>>> This change only modifies swap to be able to accept any order
>>>>> mTHP. It
>>>>> doesn't change the callers to elide doing the actual split. That will be
>>>>> done in separate changes.
>>>>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>>    include/linux/swap.h |  10 ++-
>>>>>    mm/swap_slots.c      |   6 +-
>>>>>    mm/swapfile.c        | 175 ++++++++++++++++++++++++-------------------
>>>>>    3 files changed, 109 insertions(+), 82 deletions(-)
>>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>>> index 5e1e4f5bf0cb..11c53692f65f 100644
>>>>> --- a/include/linux/swap.h
>>>>> +++ b/include/linux/swap.h
>>>>> @@ -268,13 +268,19 @@ struct swap_cluster_info {
>>>>>     */
>>>>>    #define SWAP_NEXT_INVALID    0
>>>>>    +#ifdef CONFIG_THP_SWAP
>>>>> +#define SWAP_NR_ORDERS        (PMD_ORDER + 1)
>>>>> +#else
>>>>> +#define SWAP_NR_ORDERS        1
>>>>> +#endif
>>>>> +
>>>>>    /*
>>>>>     * We assign a cluster to each CPU, so each CPU can allocate swap entry
>>>>> from
>>>>>     * its own cluster and swapout sequentially. The purpose is to optimize
>>>>> swapout
>>>>>     * throughput.
>>>>>     */
>>>>>    struct percpu_cluster {
>>>>> -    unsigned int next; /* Likely next allocation offset */
>>>>> +    unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
>>>>>    };
>>>>>      struct swap_cluster_list {
>>>>> @@ -471,7 +477,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio);
>>>>>    bool folio_free_swap(struct folio *folio);
>>>>>    void put_swap_folio(struct folio *folio, swp_entry_t entry);
>>>>>    extern swp_entry_t get_swap_page_of_type(int);
>>>>> -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
>>>>> +extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
>>>>>    extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>>>>>    extern void swap_shmem_alloc(swp_entry_t);
>>>>>    extern int swap_duplicate(swp_entry_t);
>>>>> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
>>>>> index 53abeaf1371d..13ab3b771409 100644
>>>>> --- a/mm/swap_slots.c
>>>>> +++ b/mm/swap_slots.c
>>>>> @@ -264,7 +264,7 @@ static int refill_swap_slots_cache(struct
>>>>> swap_slots_cache *cache)
>>>>>        cache->cur = 0;
>>>>>        if (swap_slot_cache_active)
>>>>>            cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
>>>>> -                       cache->slots, 1);
>>>>> +                       cache->slots, 0);
>>>>>          return cache->nr;
>>>>>    }
>>>>> @@ -311,7 +311,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>>>>>          if (folio_test_large(folio)) {
>>>>>            if (IS_ENABLED(CONFIG_THP_SWAP))
>>>>> -            get_swap_pages(1, &entry, folio_nr_pages(folio));
>>>>> +            get_swap_pages(1, &entry, folio_order(folio));
>>>>
>>>> The only comment I have is that this nr_pages -> order conversion adds
>>>> a bit of noise to this patch.
>>>>
>>>> AFAIKS, it's primarily only required for "cluster->next[order]",
>>>> everything else doesn't really require the order.
>>>>
>>>> I'd just have split that out into a separate patch, or simply
>>>> converted nr_pages -> order where required.
>>>>
>>>> Nothing jumped at me, but I'm not an expert on that code, so I'm
>>>> mostly trusting the others ;)
>>>
>>> The nr_pages -> order conversion replaces ilog2(nr_pages) with
>>> (1<<order).  IIUC, "<<" is a little faster than "ilog2()".  And, we
>>> don't need to worry about whether nr_pages is a power of 2.  Do you
>>> think that this makes sense?
>>
>> I think that David's point was that I should just split out that change to its
>> own patch to aid readability? I'm happy to do that if no one objects.
> 
> Yes. Or avoiding it and not caring about a ilog vs. 1<<order micro-optimization ;)

My motivation wasn't really the ilog vs shift, but rather improving the
self-documenting nature of the API; if it takes an order its clear that
power-of-2 is required.

I'll split out the patch.


> 


