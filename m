Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D8A78376B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjHVBhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjHVBhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:37:14 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528E1110
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 18:37:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RVBm20ykgz4f3mK5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:37:06 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgD3Fr9EEeRkvV7UBA--.32703S2;
        Tue, 22 Aug 2023 09:37:09 +0800 (CST)
Subject: Re: [PATCH 4/9] mm/compaction: simplify pfn iteration in
 isolate_freepages_range
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <20230805110711.2975149-5-shikemeng@huaweicloud.com>
 <ecb315f9-a5cd-4fb3-bae6-eb94a08eccb3@linux.alibaba.com>
 <43b726c1-3ea6-9acc-d4e4-c7deabcf7ecd@huaweicloud.com>
 <3729c50f-6f8e-2548-8932-f39045402299@linux.alibaba.com>
 <3574ed6e-34c8-47a1-8218-9e4cf1327184@huaweicloud.com>
 <d9403099-7fa8-ba34-4260-21da36175432@linux.alibaba.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <d4b2307e-6a43-820f-1b31-41e34f153844@huaweicloud.com>
Date:   Tue, 22 Aug 2023 09:37:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <d9403099-7fa8-ba34-4260-21da36175432@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgD3Fr9EEeRkvV7UBA--.32703S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy5ZFWDJr1UGFy3GryUKFg_yoW7Jw1kpa
        4xJF1xCryDGa48XF1Utw1DZryUKw4Uta1UXr4UJF1UJFyktF9FgrnrZr1qgFyjqr4xAr4q
        vr4DtFZFv3WDZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/19/2023 7:58 PM, Baolin Wang wrote:
> 
> 
> On 8/15/2023 6:37 PM, Kemeng Shi wrote:
>>
>>
>> on 8/15/2023 6:07 PM, Baolin Wang wrote:
>>>
>>>
>>> On 8/15/2023 5:32 PM, Kemeng Shi wrote:
>>>>
>>>>
>>>> on 8/15/2023 4:38 PM, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 8/5/2023 7:07 PM, Kemeng Shi wrote:
>>>>>> We call isolate_freepages_block in strict mode, continuous pages in
>>>>>> pageblock will be isolated if isolate_freepages_block successed.
>>>>>> Then pfn + isolated will point to start of next pageblock to scan
>>>>>> no matter how many pageblocks are isolated in isolate_freepages_block.
>>>>>> Use pfn + isolated as start of next pageblock to scan to simplify the
>>>>>> iteration.
>>>>>
>>>>> IIUC, the isolate_freepages_block() can isolate high-order free pages, which means the pfn + isolated can be larger than the block_end_pfn. So in your patch, the 'block_start_pfn' and 'block_end_pfn' can be in different pageblocks, that will break pageblock_pfn_to_page().
>>>>>
>>>> In for update statement, we always update block_start_pfn to pfn and
>>>
>>> I mean, you changed to:
>>> 1) pfn += isolated;
>>> 2) block_start_pfn = pfn;
>>> 3) block_end_pfn = pfn + pageblock_nr_pages;
>>>
>>> But in 1) pfn + isolated can go outside of the currnet pageblock if isolating a high-order page, for example, located in the middle of the next pageblock. So that the block_start_pfn can point to the middle of the next pageblock, not the start position. Meanwhile after 3), the block_end_pfn can point another pageblock. Or I missed something else?
>>>
>> Ah, I miss to explain this in changelog.
>> In case we could we have buddy page with order higher than pageblock:
>> 1. page in buddy page is aligned with it's order
>> 2. order of page is higher than pageblock order
>> Then page is aligned with pageblock order. So pfn of page and isolated pages
>> count are both aligned pageblock order. So pfn + isolated is pageblock order
>> aligned.
> 
> That's not what I mean. pfn + isolated is not always pageblock-aligned, since the isolate_freepages_block() can isolated high-order free pages (for example: order-1, order-2 ...).
> 
> Suppose the pageblock size is 2M, when isolating a pageblock (suppose the pfn range is 0 - 511 to make the arithmetic easy) by isolate_freepages_block(), and suppose pfn 0 to pfn 510 are all order-0 page, but pfn 511 is order-1 page, so you will isolate 513 pages from this pageblock, which will make 'pfn + isolated' not pageblock aligned.
This is also no supposed to happen as low order buddy pages should never span
cross boundary of high order pages:
In buddy system, we always split order N pages into two order N - 1 pages as
following:
|        order N        |
|order N - 1|order N - 1|
So buddy pages with order N - 1 will never cross boudary of order N. Similar,
buddy pages with order N - 2 will never cross boudary of order N - 1 and so
on. Then any pages with order less than N will never cross boudary of order
N.

> 
>>>> update block_end_pfn to pfn + pageblock_nr_pages. So they should point
>>>> to the same pageblock. I guess you missed the change to update of
>>>> block_end_pfn. :)
>>>>>>
>>>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>>>> ---
>>>>>>     mm/compaction.c | 14 ++------------
>>>>>>     1 file changed, 2 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>>>> index 684f6e6cd8bc..8d7d38073d30 100644
>>>>>> --- a/mm/compaction.c
>>>>>> +++ b/mm/compaction.c
>>>>>> @@ -733,21 +733,11 @@ isolate_freepages_range(struct compact_control *cc,
>>>>>>         block_end_pfn = pageblock_end_pfn(pfn);
>>>>>>           for (; pfn < end_pfn; pfn += isolated,
>>>>>> -                block_start_pfn = block_end_pfn,
>>>>>> -                block_end_pfn += pageblock_nr_pages) {
>>>>>> +                block_start_pfn = pfn,
>>>>>> +                block_end_pfn = pfn + pageblock_nr_pages) {
>>>>>>             /* Protect pfn from changing by isolate_freepages_block */
>>>>>>             unsigned long isolate_start_pfn = pfn;
>>>>>>     -        /*
>>>>>> -         * pfn could pass the block_end_pfn if isolated freepage
>>>>>> -         * is more than pageblock order. In this case, we adjust
>>>>>> -         * scanning range to right one.
>>>>>> -         */
>>>>>> -        if (pfn >= block_end_pfn) {
>>>>>> -            block_start_pfn = pageblock_start_pfn(pfn);
>>>>>> -            block_end_pfn = pageblock_end_pfn(pfn);
>>>>>> -        }
>>>>>> -
>>>>>>             block_end_pfn = min(block_end_pfn, end_pfn);
>>>>>>               if (!pageblock_pfn_to_page(block_start_pfn,
>>>>>
>>>
> 
> 

