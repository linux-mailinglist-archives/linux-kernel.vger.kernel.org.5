Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDED27B6BD9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbjJCOiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbjJCOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:38:24 -0400
Received: from out-209.mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A655A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:38:21 -0700 (PDT)
Message-ID: <8c9ee3bd-6d71-4111-8f4e-91bc52b42ed4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696343898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NtOgS8kdqdev2oPEOGg7PvbjyZjOnfyVKUNFOralQmQ=;
        b=ci+JFf9BqXsUYWMEsTqZOYEE80uqO9eDp4Uhvo68rnHJZPASLc2gn+1e953ZBMTII5+HkH
        9DO1bccuQdRD07co0hGqNjqCfQJca9+yEuje63CG5tCN9L8Wn3/5V61aSbY8fb3/TGU6rh
        urWiPBsB8/7TKLCXcM6CPLqigyQK7WU=
Date:   Tue, 3 Oct 2023 22:38:09 +0800
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
 <a6a20ff9-385c-639f-75cf-ce73a01d97cf@linux.dev>
 <20230929100252.GW3303@kernel.org>
 <15233624-f32e-172e-b2f6-7ca7bffbc96d@linux.dev>
 <20231001185934.GX3303@kernel.org>
 <90342474-432a-9fe3-2f11-915a04f0053f@linux.dev>
 <20231002084708.GZ3303@kernel.org>
 <f7e6f67a-4cac-73bd-1d5e-5020c6c8423d@redhat.com>
 <20231002111051.GA3303@kernel.org>
 <3057dab3-19f2-99ca-f125-e91a094975ed@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <3057dab3-19f2-99ca-f125-e91a094975ed@redhat.com>
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


On 2023/10/2 19:25, David Hildenbrand wrote:
> On 02.10.23 13:10, Mike Rapoport wrote:
>> On Mon, Oct 02, 2023 at 10:56:51AM +0200, David Hildenbrand wrote:
>>> On 02.10.23 10:47, Mike Rapoport wrote:
>>>> On Mon, Oct 02, 2023 at 03:03:56PM +0800, Yajun Deng wrote:
>>>>>
>>>>> On 2023/10/2 02:59, Mike Rapoport wrote:
>>>>>> On Fri, Sep 29, 2023 at 06:27:25PM +0800, Yajun Deng wrote:
>>>>>>> On 2023/9/29 18:02, Mike Rapoport wrote:
>>>>>>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>>>>>>> index 06be8821d833..b868caabe8dc 100644
>>>>>>>>>>> --- a/mm/page_alloc.c
>>>>>>>>>>> +++ b/mm/page_alloc.c
>>>>>>>>>>> @@ -1285,18 +1285,22 @@ void __free_pages_core(struct page 
>>>>>>>>>>> *page, unsigned int order)
>>>>>>>>>>>           unsigned int loop;
>>>>>>>>>>>           /*
>>>>>>>>>>> -     * When initializing the memmap, __init_single_page() 
>>>>>>>>>>> sets the refcount
>>>>>>>>>>> -     * of all pages to 1 ("allocated"/"not free"). We have 
>>>>>>>>>>> to set the
>>>>>>>>>>> -     * refcount of all involved pages to 0.
>>>>>>>>>>> +     * When initializing the memmap, memmap_init_range sets 
>>>>>>>>>>> the refcount
>>>>>>>>>>> +     * of all pages to 1 ("reserved" and "free") in hotplug 
>>>>>>>>>>> context. We
>>>>>>>>>>> +     * have to set the refcount of all involved pages to 0. 
>>>>>>>>>>> Otherwise,
>>>>>>>>>>> +     * we don't do it, as reserve_bootmem_region only set 
>>>>>>>>>>> the refcount on
>>>>>>>>>>> +     * reserve region ("reserved") in early context.
>>>>>>>>>>>            */
>>>>>>>>>> Again, why hotplug and early init should be different?
>>>>>>>>> I will add a comment that describes it will save boot time.
>>>>>>>> But why do we need initialize struct pages differently at boot 
>>>>>>>> time vs
>>>>>>>> memory hotplug?
>>>>>>>> Is there a reason memory hotplug cannot have page count set to 
>>>>>>>> 0 just like
>>>>>>>> for pages reserved at boot time?
>>>>>>> This patch just save boot time in MEMINIT_EARLY. If someone 
>>>>>>> finds out that
>>>>>>> it can save time in
>>>>>>>
>>>>>>> MEMINIT_HOTPLUG, I think it can be done in another patch later. 
>>>>>>> I just
>>>>>>> keeping it in the same.
>>>>>> But it's not the same. It becomes slower after your patch and the 
>>>>>> code that
>>>>>> frees the pages for MEMINIT_EARLY and MEMINIT_HOTPLUG becomes 
>>>>>> non-uniform
>>>>>> for no apparent reason.
>>>>>
>>>>> __free_pages_core will also be called by others, such as:
>>>>> deferred_free_range, do_collection and memblock_free_late.
>>>>>
>>>>> We couldn't remove  'if (page_count(page))' even if we set page 
>>>>> count to 0
>>>>> when MEMINIT_HOTPLUG.
>>>>
>>>> That 'if' breaks the invariant that __free_pages_core is always 
>>>> called for
>>>> pages with initialized page count. Adding it may lead to subtle 
>>>> bugs and
>>>> random memory corruption so we don't want to add it at the first 
>>>> place.
>>>
>>> As long as we have to special-case memory hotplug, we know that we are
>>> always coming via generic_online_page() in that case. We could 
>>> either move
>>> some logic over there, or let __free_pages_core() know what it 
>>> should do.
>>
>> Looks like the patch rather special cases MEMINIT_EARLY, although I 
>> didn't
>> check throughfully other code paths.
>> Anyway, relying on page_count() to be correct in different ways for
>> different callers of __free_pages_core() does not sound right to me.
>
> Absolutely agreed.
>
I already sent v5  a few days ago. Comments, please...


