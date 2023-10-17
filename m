Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2DE7CC006
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbjJQJ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjJQJ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:58:41 -0400
Received: from out-198.mta1.migadu.com (out-198.mta1.migadu.com [IPv6:2001:41d0:203:375::c6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D635298
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:58:38 -0700 (PDT)
Message-ID: <8a18b38a-9b49-b583-3a54-54fcd843fb9d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697536716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AnajFnpSm9h3WHytb+us6ByAc92RA8ylloa0bDcwnk=;
        b=Tdmv2TK9bxyJocAygdHBWmXesOjPNuQj06JMRWgz6SgVUkLL+gNa3I7cK8vSyMT/Pmatb4
        hhgdwwufGr22yUd1jhKw8Lh40uUfpKJKK+se9FgEj7/+t0uh9DNe6oeb/eKvjRkgAhfIlg
        zb25Fv3ayWDxAObAxZyi19E8lr8rLR8=
Date:   Tue, 17 Oct 2023 17:58:24 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region when
 MEMINIT_EARLY
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
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
 <38cd0cb9-efe9-b98a-2768-ccb48da8b812@linux.dev>
 <20231013084827.GT3303@kernel.org>
 <1c91dd62-886d-bb05-8aee-22191a8a2d8e@linux.dev>
 <20231016063357.GU3303@kernel.org>
 <a67fc1bf-64e8-ce6c-f68a-52fe8b942860@linux.dev>
 <abace691-e11f-ec08-a725-9e3b17935d8c@redhat.com>
 <0d890048-be58-5050-02fa-21768059aa0d@linux.dev>
 <23302f67-eb69-265a-ab2d-9c55715e2843@redhat.com>
 <121772bf-4c1d-3d23-f266-60ce2e879193@linux.dev>
In-Reply-To: <121772bf-4c1d-3d23-f266-60ce2e879193@linux.dev>
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


On 2023/10/16 18:17, Yajun Deng wrote:
>
> On 2023/10/16 16:36, David Hildenbrand wrote:
>> On 16.10.23 10:32, Yajun Deng wrote:
>>>
>>> On 2023/10/16 16:16, David Hildenbrand wrote:
>>>> On 16.10.23 10:10, Yajun Deng wrote:
>>>>>
>>>>> On 2023/10/16 14:33, Mike Rapoport wrote:
>>>>>> On Fri, Oct 13, 2023 at 05:29:19PM +0800, Yajun Deng wrote:
>>>>>>> On 2023/10/13 16:48, Mike Rapoport wrote:
>>>>>>>> On Thu, Oct 12, 2023 at 05:53:22PM +0800, Yajun Deng wrote:
>>>>>>>>> On 2023/10/12 17:23, David Hildenbrand wrote:
>>>>>>>>>> On 10.10.23 04:31, Yajun Deng wrote:
>>>>>>>>>>> On 2023/10/8 16:57, Yajun Deng wrote:
>>>>>>>>>>>>> That looks wrong. if the page count would by pure luck be 0
>>>>>>>>>>>>> already for hotplugged memory, you wouldn't clear the 
>>>>>>>>>>>>> reserved
>>>>>>>>>>>>> flag.
>>>>>>>>>>>>>
>>>>>>>>>>>>> These changes make me a bit nervous.
>>>>>>>>>>>> Is 'if (page_count(page) || PageReserved(page))' be safer? Or
>>>>>>>>>>>> do I
>>>>>>>>>>>> need to do something else?
>>>>>>>>>>>>
>>>>>>>>>>> How about the following if statement? But it needs to add more
>>>>>>>>>>> patch
>>>>>>>>>>> like v1 ([PATCH 2/4] mm: Introduce MEMINIT_LATE context).
>>>>>>>>>>>
>>>>>>>>>>> It'll be safer, but more complex. Please comment...
>>>>>>>>>>>
>>>>>>>>>>>         if (context != MEMINIT_EARLY || (page_count(page) ||
>>>>>>>>>>> PageReserved(page)) {
>>>>>>>>>>>
>>>>>>>>>> Ideally we could make initialization only depend on the context,
>>>>>>>>>> and not
>>>>>>>>>> check for count or the reserved flag.
>>>>>>>>>>
>>>>>>>>> This link is v1,
>>>>>>>>> https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/ 
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> If we could make initialization only depend on the context, I'll
>>>>>>>>> modify it
>>>>>>>>> based on v1.
>>>>>>>> Although ~20% improvement looks impressive, this is only
>>>>>>>> optimization of a
>>>>>>>> fraction of the boot time, and realistically, how much 56 msec
>>>>>>>> saves from
>>>>>>>> the total boot time when you boot a machine with 190G of RAM?
>>>>>>> There are a lot of factors that can affect the total boot time. 56
>>>>>>> msec
>>>>>>> saves may be insignificant.
>>>>>>>
>>>>>>> But if we look at the boot log, we'll see there's a significant
>>>>>>> time jump.
>>>>>>>
>>>>>>> before:
>>>>>>>
>>>>>>> [    0.250334] ACPI: PM-Timer IO Port: 0x508
>>>>>>> [    0.618994] Memory: 173413056K/199884452K available (18440K
>>>>>>> kernel code,
>>>>>>>
>>>>>>> after:
>>>>>>>
>>>>>>> [    0.260229] software IO TLB: area num 32.
>>>>>>> [    0.563497] Memory: 173413056K/199884452K available (18440K
>>>>>>> kernel code,
>>>>>>> Memory:
>>>>>>> Memory initialization is time consuming in the boot log.
>>>>>> You just confirmed that 56 msec is insignificant and then you send
>>>>>> again
>>>>>> the improvement of ~60 msec in memory initialization.
>>>>>>
>>>>>> What does this improvement gain in percentage of total boot time?
>>>>>
>>>>>
>>>>> before:
>>>>>
>>>>> [   10.692708] Run /init as init process
>>>>>
>>>>>
>>>>> after:
>>>>>
>>>>> [   10.666290] Run /init as init process
>>>>>
>>>>>
>>>>> About 0.25%. The total boot time is variable, depending on how many
>>>>> drivers need to be initialized.
>>>>>
>>>>>
>>>>>>>> I still think the improvement does not justify the churn, added
>>>>>>>> complexity
>>>>>>>> and special casing of different code paths of initialization of
>>>>>>>> struct pages.
>>>>>>>
>>>>>>> Because there is a loop, if the order is MAX_ORDER, the loop will
>>>>>>> run 1024
>>>>>>> times. The following 'if' would be safer:
>>>>>>>
>>>>>>> 'if (context != MEMINIT_EARLY || (page_count(page) || >>
>>>>>>> PageReserved(page))
>>>>>>> {'
>>>>>> No, it will not.
>>>>>>
>>>>>> As the matter of fact any condition here won't be 'safer' because it
>>>>>> makes
>>>>>> the code more complex and less maintainable.
>>>>>> Any future change in __free_pages_core() or one of it's callers will
>>>>>> have
>>>>>> to reason what will happen with that condition after the change.
>>>>>
>>>>>
>>>>> To avoid introducing MEMINIT_LATE context and make code simpler. This
>>>>> might be a better option.
>>>>>
>>>>> if (page_count(page) || PageReserved(page))
>>>>
>>>> I'll have to side with Mike here; this change might not be worth it.
>>>>
>>>
>>> Okay, I got it. Thanks!
>>
>> IMHO instead of adding more checks to that code we should try to 
>> unify that handling such that we can just remove it. As expressed, at 
>> least from the memory hotplug perspective there are still reasons why 
>> we need that; I can provide some guidance on how to eventually 
>> achieve that, but it might end up in a bit of work ...
>
>
> Yes, we can't remove it right now. If we want to do that, we have to 
> clean up rely on page count and PageReserved first.


How about making __free_pages_core separate, like:

void __init __free_pages_core_early(struct page *page, unsigned int order)
{
         unsigned int nr_pages = 1 << order;

         atomic_long_add(nr_pages, &page_zone(page)->managed_pages);

         if (page_contains_unaccepted(page, order)) {
                 if (order == MAX_ORDER && __free_unaccepted(page))
                         return;

                 accept_page(page, order);
         }

         /*
          * Bypass PCP and place fresh pages right to the tail, primarily
          * relevant for memory onlining.
          */
         __free_pages_ok(page, order, FPI_TO_TAIL);
}

void __free_pages_core(struct page *page, unsigned int order)
{
         unsigned int nr_pages = 1 << order;
         struct page *p = page;
         unsigned int loop;

         /*
          * When initializing the memmap, __init_single_page() sets the 
refcount
          * of all pages to 1 ("allocated"/"not free"). We have to set the
          * refcount of all involved pages to 0.
          */
         prefetchw(p);
         for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
                 prefetchw(p + 1);
                 __ClearPageReserved(p);
                 set_page_count(p, 0);
         }
         __ClearPageReserved(p);
         set_page_count(p, 0);

         __free_pages_core_early(page, order);
}

We only change the caller we need to __free_pages_core_early, it doesn't 
affect other callers.

>
>>
>> Anyhow, thanks for bringing up that topic; it reminded me that I 
>> still have pending cleanups to not rely on PageReserved on the memory 
>> hotplug path.
>>
