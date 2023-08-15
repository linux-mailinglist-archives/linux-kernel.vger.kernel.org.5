Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA277CB32
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbjHOKiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbjHOKiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:38:02 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C95BB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 03:38:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQ75J3DPmz4f41VX
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:37:56 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgC32sKDVdtkMh3iAg--.17057S2;
        Tue, 15 Aug 2023 18:37:56 +0800 (CST)
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
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <3574ed6e-34c8-47a1-8218-9e4cf1327184@huaweicloud.com>
Date:   Tue, 15 Aug 2023 18:37:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <3729c50f-6f8e-2548-8932-f39045402299@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC32sKDVdtkMh3iAg--.17057S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyDWF4kGryfuFW5WF4kZwb_yoWrJrWkpa
        4xJF1IkryDGa18XF17tw1DZryUKw4Ut3WUXr4UJF1UZFyvyF9Fgrn2vr1qgryjqr4fAr4q
        vr4DtFZrZ3WUZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/15/2023 6:07 PM, Baolin Wang wrote:
> 
> 
> On 8/15/2023 5:32 PM, Kemeng Shi wrote:
>>
>>
>> on 8/15/2023 4:38 PM, Baolin Wang wrote:
>>>
>>>
>>> On 8/5/2023 7:07 PM, Kemeng Shi wrote:
>>>> We call isolate_freepages_block in strict mode, continuous pages in
>>>> pageblock will be isolated if isolate_freepages_block successed.
>>>> Then pfn + isolated will point to start of next pageblock to scan
>>>> no matter how many pageblocks are isolated in isolate_freepages_block.
>>>> Use pfn + isolated as start of next pageblock to scan to simplify the
>>>> iteration.
>>>
>>> IIUC, the isolate_freepages_block() can isolate high-order free pages, which means the pfn + isolated can be larger than the block_end_pfn. So in your patch, the 'block_start_pfn' and 'block_end_pfn' can be in different pageblocks, that will break pageblock_pfn_to_page().
>>>
>> In for update statement, we always update block_start_pfn to pfn and
> 
> I mean, you changed to:
> 1) pfn += isolated;
> 2) block_start_pfn = pfn;
> 3) block_end_pfn = pfn + pageblock_nr_pages;
> 
> But in 1) pfn + isolated can go outside of the currnet pageblock if isolating a high-order page, for example, located in the middle of the next pageblock. So that the block_start_pfn can point to the middle of the next pageblock, not the start position. Meanwhile after 3), the block_end_pfn can point another pageblock. Or I missed something else?
> 
Ah, I miss to explain this in changelog.
In case we could we have buddy page with order higher than pageblock:
1. page in buddy page is aligned with it's order
2. order of page is higher than pageblock order
Then page is aligned with pageblock order. So pfn of page and isolated pages
count are both aligned pageblock order. So pfn + isolated is pageblock order
aligned.
>> update block_end_pfn to pfn + pageblock_nr_pages. So they should point
>> to the same pageblock. I guess you missed the change to update of
>> block_end_pfn. :)
>>>>
>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>> ---
>>>>    mm/compaction.c | 14 ++------------
>>>>    1 file changed, 2 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>> index 684f6e6cd8bc..8d7d38073d30 100644
>>>> --- a/mm/compaction.c
>>>> +++ b/mm/compaction.c
>>>> @@ -733,21 +733,11 @@ isolate_freepages_range(struct compact_control *cc,
>>>>        block_end_pfn = pageblock_end_pfn(pfn);
>>>>          for (; pfn < end_pfn; pfn += isolated,
>>>> -                block_start_pfn = block_end_pfn,
>>>> -                block_end_pfn += pageblock_nr_pages) {
>>>> +                block_start_pfn = pfn,
>>>> +                block_end_pfn = pfn + pageblock_nr_pages) {
>>>>            /* Protect pfn from changing by isolate_freepages_block */
>>>>            unsigned long isolate_start_pfn = pfn;
>>>>    -        /*
>>>> -         * pfn could pass the block_end_pfn if isolated freepage
>>>> -         * is more than pageblock order. In this case, we adjust
>>>> -         * scanning range to right one.
>>>> -         */
>>>> -        if (pfn >= block_end_pfn) {
>>>> -            block_start_pfn = pageblock_start_pfn(pfn);
>>>> -            block_end_pfn = pageblock_end_pfn(pfn);
>>>> -        }
>>>> -
>>>>            block_end_pfn = min(block_end_pfn, end_pfn);
>>>>              if (!pageblock_pfn_to_page(block_start_pfn,
>>>
> 

