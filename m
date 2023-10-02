Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113F47B4C27
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbjJBHEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbjJBHEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:04:12 -0400
Received: from out-201.mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DDBA4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:04:09 -0700 (PDT)
Message-ID: <90342474-432a-9fe3-2f11-915a04f0053f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696230247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nq8NwlZ519KqON4hNH1Et3LCB/6xP0wXrfjAxri2wT8=;
        b=Rbkog8pok8p7gsjhmBMWrxgWXKDxdzi7XxbK8cncC8tZ3ZRHH1vGdozpM5r/wNSZJ9O3pZ
        LztCFdafWFJVK0lT3sPQ/f1sCe4qHm4cZt5CqxejBRGm28yLxA9MdjA83gXXfoAgDNH612
        n3DEXuNbIW2wqnP71tJkst8qjCd9Eag=
Date:   Mon, 2 Oct 2023 15:03:56 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region when
 MEMINIT_EARLY
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, willy@infradead.org, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230928083302.386202-1-yajun.deng@linux.dev>
 <20230928083302.386202-3-yajun.deng@linux.dev>
 <20230929083018.GU3303@kernel.org>
 <a6a20ff9-385c-639f-75cf-ce73a01d97cf@linux.dev>
 <20230929100252.GW3303@kernel.org>
 <15233624-f32e-172e-b2f6-7ca7bffbc96d@linux.dev>
 <20231001185934.GX3303@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20231001185934.GX3303@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/2 02:59, Mike Rapoport wrote:
> On Fri, Sep 29, 2023 at 06:27:25PM +0800, Yajun Deng wrote:
>> On 2023/9/29 18:02, Mike Rapoport wrote:
>>> On Fri, Sep 29, 2023 at 05:50:40PM +0800, Yajun Deng wrote:
>>>> On 2023/9/29 16:30, Mike Rapoport wrote:
>>>>> On Thu, Sep 28, 2023 at 04:33:02PM +0800, Yajun Deng wrote:
>>>>>> memmap_init_range() would init page count of all pages, but the free
>>>>>> pages count would be reset in __free_pages_core(). There are opposite
>>>>>> operations. It's unnecessary and time-consuming when it's MEMINIT_EARLY
>>>>>> context.
>>>>>>
>>>>>> Init page count in reserve_bootmem_region when in MEMINIT_EARLY context,
>>>>>> and check the page count before reset it.
>>>>>>
>>>>>> At the same time, the INIT_LIST_HEAD in reserve_bootmem_region isn't
>>>>>> need, as it already done in __init_single_page.
>>>>>>
>>>>>> The following data was tested on an x86 machine with 190GB of RAM.
>>>>>>
>>>>>> before:
>>>>>> free_low_memory_core_early()    341ms
>>>>>>
>>>>>> after:
>>>>>> free_low_memory_core_early()    285ms
>>>>>>
>>>>>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>>>>>> ---
>>>>>> v4: same with v2.
>>>>>> v3: same with v2.
>>>>>> v2: check page count instead of check context before reset it.
>>>>>> v1: https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/
>>>>>> ---
>>>>>>     mm/mm_init.c    | 18 +++++++++++++-----
>>>>>>     mm/page_alloc.c | 20 ++++++++++++--------
>>>>>>     2 files changed, 25 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>>>>>> index 9716c8a7ade9..3ab8861e1ef3 100644
>>>>>> --- a/mm/mm_init.c
>>>>>> +++ b/mm/mm_init.c
>>>>>> @@ -718,7 +718,7 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
>>>>>>     		if (zone_spans_pfn(zone, pfn))
>>>>>>     			break;
>>>>>>     	}
>>>>>> -	__init_single_page(pfn_to_page(pfn), pfn, zid, nid, INIT_PAGE_COUNT);
>>>>>> +	__init_single_page(pfn_to_page(pfn), pfn, zid, nid, 0);
>>>>>>     }
>>>>>>     #else
>>>>>>     static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
>>>>>> @@ -756,8 +756,8 @@ void __meminit reserve_bootmem_region(phys_addr_t start,
>>>>>>     			init_reserved_page(start_pfn, nid);
>>>>>> -			/* Avoid false-positive PageTail() */
>>>>>> -			INIT_LIST_HEAD(&page->lru);
>>>>>> +			/* Init page count for reserved region */
>>>>> Please add a comment that describes _why_ we initialize the page count here.
>>>> Okay.
>>>>>> +			init_page_count(page);
>>>>>>     			/*
>>>>>>     			 * no need for atomic set_bit because the struct
>>>>>> @@ -888,9 +888,17 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
>>>>>>     		}
>>>>>>     		page = pfn_to_page(pfn);
>>>>>> -		__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);
>>>>>> -		if (context == MEMINIT_HOTPLUG)
>>>>>> +
>>>>>> +		/* If the context is MEMINIT_EARLY, we will init page count and
>>>>>> +		 * mark page reserved in reserve_bootmem_region, the free region
>>>>>> +		 * wouldn't have page count and we will check the pages count
>>>>>> +		 * in __free_pages_core.
>>>>>> +		 */
>>>>>> +		__init_single_page(page, pfn, zone, nid, 0);
>>>>>> +		if (context == MEMINIT_HOTPLUG) {
>>>>>> +			init_page_count(page);
>>>>>>     			__SetPageReserved(page);
>>>>> Rather than calling init_page_count() and __SetPageReserved() for
>>>>> MEMINIT_HOTPLUG you can set flags to INIT_PAGE_COUNT | INIT_PAGE_RESERVED
>>>>> an call __init_single_page() after the check for MEMINIT_HOTPLUG.
>>>> No, the following code would cost more time than the current code in
>>>> memmap_init().
>>>>
>>>> if (context == MEMINIT_HOTPLUG)
>>>>
>>>> 	__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT | INIT_PAGE_RESERVED);
>>>> else
>>>> 	
>>>> 	__init_single_page(page, pfn, zone, nid, 0);
>>> Sorry if I wasn't clear. What I meant was to have something along these lines:
>>>
>>> 	enum page_init_flags flags = 0;
>>>
>>> 	if (context == MEMINIT_HOTPLUG)
>>> 		flags = INIT_PAGE_COUNT | INIT_PAGE_RESERVED;
>>> 	__init_single_page(page, pfn, zone, nid, flags);
>>>
>> Okay, I'll test the time consumed in memmap_init().
>>>>> But more generally, I wonder if we have to differentiate HOTPLUG here at all.
>>>>> @David, can you comment please?
>>>>>
>>>>>> +		}
>>>>>>     		/*
>>>>>>     		 * Usually, we want to mark the pageblock MIGRATE_MOVABLE,
>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>> index 06be8821d833..b868caabe8dc 100644
>>>>>> --- a/mm/page_alloc.c
>>>>>> +++ b/mm/page_alloc.c
>>>>>> @@ -1285,18 +1285,22 @@ void __free_pages_core(struct page *page, unsigned int order)
>>>>>>     	unsigned int loop;
>>>>>>     	/*
>>>>>> -	 * When initializing the memmap, __init_single_page() sets the refcount
>>>>>> -	 * of all pages to 1 ("allocated"/"not free"). We have to set the
>>>>>> -	 * refcount of all involved pages to 0.
>>>>>> +	 * When initializing the memmap, memmap_init_range sets the refcount
>>>>>> +	 * of all pages to 1 ("reserved" and "free") in hotplug context. We
>>>>>> +	 * have to set the refcount of all involved pages to 0. Otherwise,
>>>>>> +	 * we don't do it, as reserve_bootmem_region only set the refcount on
>>>>>> +	 * reserve region ("reserved") in early context.
>>>>>>     	 */
>>>>> Again, why hotplug and early init should be different?
>>>> I will add a comment that describes it will save boot time.
>>> But why do we need initialize struct pages differently at boot time vs
>>> memory hotplug?
>>> Is there a reason memory hotplug cannot have page count set to 0 just like
>>> for pages reserved at boot time?
>> This patch just save boot time in MEMINIT_EARLY. If someone finds out that
>> it can save time in
>>
>> MEMINIT_HOTPLUG, I think it can be done in another patch later. I just
>> keeping it in the same.
> But it's not the same. It becomes slower after your patch and the code that
> frees the pages for MEMINIT_EARLY and MEMINIT_HOTPLUG becomes non-uniform
> for no apparent reason.

__free_pages_core will also be called by others, such as:
deferred_free_range, do_collection and memblock_free_late.

We couldn't remove  'if (page_count(page))' even if we set page count to 
0 when MEMINIT_HOTPLUG.

The following data is the time consumed in online_pages_range().

start_pfn   nr_pages    before   after
0x680000    0x80000     4.315ms  4.461ms
0x700000    0x80000     4.468ms  4.440ms
0x780000    0x80000     4.295ms  3.835ms
0x800000    0x80000     3.928ms  4.377ms
0x880000    0x80000     4.321ms  4.378ms
0x900000    0x80000     4.448ms  3.964ms
0x980000    0x80000     4.000ms  4.381ms
0xa00000    0x80000     4.459ms  4.255ms
sum                     34.234ms  34.091ms

As we can see, it doesn't become slower with ' if (page_count(page))' 
when MEMINIT_HOTPLUG.

> The if (page_count(page)) is really non-obvious...
>   
>>>>>> -	prefetchw(p);
>>>>>> -	for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
>>>>>> -		prefetchw(p + 1);
>>>>>> +	if (page_count(page)) {
>>>>>> +		prefetchw(p);
>>>>>> +		for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
>>>>>> +			prefetchw(p + 1);
>>>>>> +			__ClearPageReserved(p);
>>>>>> +			set_page_count(p, 0);
>>>>>> +		}
>>>>>>     		__ClearPageReserved(p);
>>>>>>     		set_page_count(p, 0);
>>>>>>     	}
>>>>>> -	__ClearPageReserved(p);
>>>>>> -	set_page_count(p, 0);
>>>>>>     	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
>>>>>> -- 
>>>>>> 2.25.1
>>>>>>
