Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ADB7C6A09
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjJLJxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJLJxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:53:38 -0400
Received: from out-193.mta0.migadu.com (out-193.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB9A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:53:36 -0700 (PDT)
Message-ID: <38cd0cb9-efe9-b98a-2768-ccb48da8b812@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697104414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gbrXvGOYNpk9WXAnk1FQr62A2ty+/pVMunROatruVvs=;
        b=ZHpwveGq4gOwgkcHpikKRMQ8g4KqAcJRHz7tDuhNmBdcVb/FCfejODiLssKhICnn5qC3UQ
        L0R1J6700zKG+IPUfLsqKrmjpA6ouAv0zeehd85mlu9fHsSi8F5cFp9ih11+VipQyKwHgx
        d9CE8UPmdZvobbgWGnoAaNh+Gj0H9sA=
Date:   Thu, 12 Oct 2023 17:53:22 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region when
 MEMINIT_EARLY
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230928083302.386202-1-yajun.deng@linux.dev>
 <20230928083302.386202-3-yajun.deng@linux.dev>
 <20230929083018.GU3303@kernel.org>
 <f144b910-cd9f-a571-ce9b-a0a8b509c28a@redhat.com>
 <2f8c4741-5c7f-272d-9cef-9fda9fbc7ca6@linux.dev>
 <5382bf2d-5aa0-1498-8169-3248be4b5af3@linux.dev>
 <bf7143f4-9d50-cfc4-0ef6-d312a2cc896b@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <bf7143f4-9d50-cfc4-0ef6-d312a2cc896b@redhat.com>
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


On 2023/10/12 17:23, David Hildenbrand wrote:
> On 10.10.23 04:31, Yajun Deng wrote:
>>
>> On 2023/10/8 16:57, Yajun Deng wrote:
>>>
>>> On 2023/10/2 16:30, David Hildenbrand wrote:
>>>> On 29.09.23 10:30, Mike Rapoport wrote:
>>>>> On Thu, Sep 28, 2023 at 04:33:02PM +0800, Yajun Deng wrote:
>>>>>> memmap_init_range() would init page count of all pages, but the free
>>>>>> pages count would be reset in __free_pages_core(). There are 
>>>>>> opposite
>>>>>> operations. It's unnecessary and time-consuming when it's
>>>>>> MEMINIT_EARLY
>>>>>> context.
>>>>>>
>>>>>> Init page count in reserve_bootmem_region when in MEMINIT_EARLY
>>>>>> context,
>>>>>> and check the page count before reset it.
>>>>>>
>>>>>> At the same time, the INIT_LIST_HEAD in reserve_bootmem_region isn't
>>>>>> need, as it already done in __init_single_page.
>>>>>>
>>>>>> The following data was tested on an x86 machine with 190GB of RAM.
>>>>>>
>>>>>> before:
>>>>>> free_low_memory_core_early()    341ms
>>>>>>
>>>>>> after:
>>>>>> free_low_memory_core_early()    285ms
>>>>>>
>>>>>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>>>>>> ---
>>>>>> v4: same with v2.
>>>>>> v3: same with v2.
>>>>>> v2: check page count instead of check context before reset it.
>>>>>> v1:
>>>>>> https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/ 
>>>>>>
>>>>>> ---
>>>>>>    mm/mm_init.c    | 18 +++++++++++++-----
>>>>>>    mm/page_alloc.c | 20 ++++++++++++--------
>>>>>>    2 files changed, 25 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>>>>>> index 9716c8a7ade9..3ab8861e1ef3 100644
>>>>>> --- a/mm/mm_init.c
>>>>>> +++ b/mm/mm_init.c
>>>>>> @@ -718,7 +718,7 @@ static void __meminit
>>>>>> init_reserved_page(unsigned long pfn, int nid)
>>>>>>            if (zone_spans_pfn(zone, pfn))
>>>>>>                break;
>>>>>>        }
>>>>>> -    __init_single_page(pfn_to_page(pfn), pfn, zid, nid,
>>>>>> INIT_PAGE_COUNT);
>>>>>> +    __init_single_page(pfn_to_page(pfn), pfn, zid, nid, 0);
>>>>>>    }
>>>>>>    #else
>>>>>>    static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
>>>>>> @@ -756,8 +756,8 @@ void __meminit
>>>>>> reserve_bootmem_region(phys_addr_t start,
>>>>>>                  init_reserved_page(start_pfn, nid);
>>>>>>    -            /* Avoid false-positive PageTail() */
>>>>>> -            INIT_LIST_HEAD(&page->lru);
>>>>>> +            /* Init page count for reserved region */
>>>>>
>>>>> Please add a comment that describes _why_ we initialize the page
>>>>> count here.
>>>>>
>>>>>> + init_page_count(page);
>>>>>>                  /*
>>>>>>                 * no need for atomic set_bit because the struct
>>>>>> @@ -888,9 +888,17 @@ void __meminit memmap_init_range(unsigned long
>>>>>> size, int nid, unsigned long zone
>>>>>>            }
>>>>>>              page = pfn_to_page(pfn);
>>>>>> -        __init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);
>>>>>> -        if (context == MEMINIT_HOTPLUG)
>>>>>> +
>>>>>> +        /* If the context is MEMINIT_EARLY, we will init page
>>>>>> count and
>>>>>> +         * mark page reserved in reserve_bootmem_region, the free
>>>>>> region
>>>>>> +         * wouldn't have page count and we will check the pages 
>>>>>> count
>>>>>> +         * in __free_pages_core.
>>>>>> +         */
>>>>>> +        __init_single_page(page, pfn, zone, nid, 0);
>>>>>> +        if (context == MEMINIT_HOTPLUG) {
>>>>>> +            init_page_count(page);
>>>>>>                __SetPageReserved(page);
>>>>>
>>>>> Rather than calling init_page_count() and __SetPageReserved() for
>>>>> MEMINIT_HOTPLUG you can set flags to INIT_PAGE_COUNT |
>>>>> INIT_PAGE_RESERVED
>>>>> an call __init_single_page() after the check for MEMINIT_HOTPLUG.
>>>>>
>>>>> But more generally, I wonder if we have to differentiate HOTPLUG
>>>>> here at all.
>>>>> @David, can you comment please?
>>>>
>>>> There are a lot of details to that, and I'll share some I can briefly
>>>> think of.
>>>>
>>>> 1) __SetPageReserved()
>>>>
>>>> I tried removing that a while ago, but there was a blocker (IIRC
>>>> something about
>>>> ZONE_DEVICE). I still have the patches at [1] and I could probably
>>>> take a look
>>>> if that blocker still exists (I recall that something changed at some
>>>> point, but
>>>> I never had the time to follow up).
>>>>
>>>> But once we stop setting the pages reserved, we might run into issues
>>>> with ...
>>>>
>>>>
>>>> 2) init_page_count()
>>>>
>>>> virtio-mem, XEN balloon and HV-balloon add memory blocks that can
>>>> contain holes.
>>>> set_online_page_callback() is used to intercept memory onlining and
>>>> to expose
>>>> only the pages that are not holes to the buddy: calling
>>>> generic_online_page() on !hole.
>>>>
>>>> Holes are PageReserved but with an initialized page count. Memory
>>>> offlining will fail on
>>>> PageReserved pages -- has_unmovable_pages().
>>>>
>>>>
>>>> At least virtio-mem clears the PageReserved flag of holes when
>>>> onlining memory,
>>>> and currently relies in the page count to be reasonable (so memory
>>>> offlining can work).
>>>>
>>>> static void virtio_mem_set_fake_offline(unsigned long pfn,
>>>>                      unsigned long nr_pages, bool onlined)
>>>> {
>>>>      page_offline_begin();
>>>>      for (; nr_pages--; pfn++) {
>>>>          struct page *page = pfn_to_page(pfn);
>>>>
>>>>          __SetPageOffline(page);
>>>>          if (!onlined) {
>>>>              SetPageDirty(page);
>>>>              /* FIXME: remove after cleanups */
>>>>              ClearPageReserved(page);
>>>>          }
>>>>      }
>>>>      page_offline_end();
>>>> }
>>>>
>>>>
>>>> For virtio-mem, we could initialize the page count there instead. The
>>>> other PV drivers
>>>> might require a bit more thought.
>>>>
>>>>
>>>> [1]
>>>> https://github.com/davidhildenbrand/linux/tree/online_reserved_cleanup
>>>>
>>>>>
>>>>>> +        }
>>>>>>              /*
>>>>>>             * Usually, we want to mark the pageblock 
>>>>>> MIGRATE_MOVABLE,
>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>> index 06be8821d833..b868caabe8dc 100644
>>>>>> --- a/mm/page_alloc.c
>>>>>> +++ b/mm/page_alloc.c
>>>>>> @@ -1285,18 +1285,22 @@ void __free_pages_core(struct page *page,
>>>>>> unsigned int order)
>>>>>>        unsigned int loop;
>>>>>>          /*
>>>>>> -     * When initializing the memmap, __init_single_page() sets the
>>>>>> refcount
>>>>>> -     * of all pages to 1 ("allocated"/"not free"). We have to 
>>>>>> set the
>>>>>> -     * refcount of all involved pages to 0.
>>>>>> +     * When initializing the memmap, memmap_init_range sets the
>>>>>> refcount
>>>>>> +     * of all pages to 1 ("reserved" and "free") in hotplug
>>>>>> context. We
>>>>>> +     * have to set the refcount of all involved pages to 0.
>>>>>> Otherwise,
>>>>>> +     * we don't do it, as reserve_bootmem_region only set the
>>>>>> refcount on
>>>>>> +     * reserve region ("reserved") in early context.
>>>>>>         */
>>>>>
>>>>> Again, why hotplug and early init should be different?
>>>>>
>>>>>> -    prefetchw(p);
>>>>>> -    for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
>>>>>> -        prefetchw(p + 1);
>>>>>> +    if (page_count(page)) {
>>>>>> +        prefetchw(p);
>>>>>> +        for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
>>>>>> +            prefetchw(p + 1);
>>>>>> +            __ClearPageReserved(p);
>>>>>> +            set_page_count(p, 0);
>>>>>> +        }
>>>>>>            __ClearPageReserved(p);
>>>>>>            set_page_count(p, 0);
>>>>
>>>> That looks wrong. if the page count would by pure luck be 0 already
>>>> for hotplugged memory,
>>>> you wouldn't clear the reserved flag.
>>>>
>>>> These changes make me a bit nervous.
>>>
>>>
>>> Is 'if (page_count(page) || PageReserved(page))' be safer? Or do I
>>> need to do something else?
>>>
>>
>> How about the following if statement? But it needs to add more patch
>> like v1 ([PATCH 2/4] mm: Introduce MEMINIT_LATE context).
>>
>> It'll be safer, but more complex. Please comment...
>>
>>     if (context != MEMINIT_EARLY || (page_count(page) || 
>> PageReserved(page)) {
>>
>
> Ideally we could make initialization only depend on the context, and 
> not check for count or the reserved flag.
>

This link is v1, 
https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/

If we could make initialization only depend on the context, I'll modify 
it based on v1.

@Mike,  By the way,  this code will cost more time:

                 if (context == MEMINIT_HOTPLUG)
                         flags = INIT_PAGE_COUNT | INIT_PAGE_RESERVED;
                 __init_single_page(page, pfn, zone, nid, flags);


[    0.014999] On node 0, zone DMA32: 31679 pages in unavailable ranges
[    0.311560] ACPI: PM-Timer IO Port: 0x508


This code will cost less time:

                 __init_single_page(page, pfn, zone, nid, 0);
                 if (context == MEMINIT_HOTPLUG) {
                         init_page_count(page);
                         __SetPageReserved(page);

[    0.014299] On node 0, zone DMA32: 31679 pages in unavailable ranges
[    0.250223] ACPI: PM-Timer IO Port: 0x508

