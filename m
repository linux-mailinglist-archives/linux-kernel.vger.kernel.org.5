Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB80176C51E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjHBGB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjHBGBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:01:55 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC992121
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:01:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RG1Zh4JF0z4f3lVC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:01:48 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgAnuDJM8clkTZVLOg--.36803S2;
        Wed, 02 Aug 2023 14:01:49 +0800 (CST)
Subject: Re: [PATCH 1/5] mm/compaction: allow blockpfn outside of pageblock
 for high order buddy page
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230729174354.2239980-1-shikemeng@huaweicloud.com>
 <20230729174354.2239980-2-shikemeng@huaweicloud.com>
 <f77676a5-e30b-d49d-54db-b85f1ad0f65b@linux.alibaba.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <f11f5569-1d44-c7ce-fa66-2c8615a9aa4a@huaweicloud.com>
Date:   Wed, 2 Aug 2023 14:01:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <f77676a5-e30b-d49d-54db-b85f1ad0f65b@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAnuDJM8clkTZVLOg--.36803S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryDWw48ur4kGry3Zw18Zrb_yoW5ZrWkpa
        4ktFy7GryDCa9YqF17Jr4kZFyUJw4kJ3WUJr4rtFyUZF90qF12gr12vr1q9ryjqr4xAryq
        qr4qgF97uFsrZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/2/2023 9:57 AM, Baolin Wang wrote:
> 
> 
> On 7/30/2023 1:43 AM, Kemeng Shi wrote:
>> Commit 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in
>> free scanner") skiped compound pages to save iterations and limit blockpfn
>> to reach outside of page block in case of bogus compound_order. While this
>> also limit pfnblock outside page block in case a buddy page with order
>> higher than page block is found. After this, isolate_freepages_range will
>> fail unexpectedly as it will fail to isolate the page block which was
>> isolated successfully by high order buddy page in previous page block
>> and abort the free page isolation.
> 
> Not sure I uderstand the problem, why the isolate_freepages_range() will fail? In isolate_freepages_range(), it did not use the 'blockpfn' cursor to try next candidate pfn, instead using the 'isolated' to calculate next cursor. Or I missed something else?
> 
Ah, my bad. I will drop this in next version.

>> Fix this by allow blockpfn outside of pageblock in case of high order
>> buddy page.
>>
>> Fixes: 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in free scanner")
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   mm/compaction.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 6841c0496223..d1d28d57e5bd 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -681,8 +681,10 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>>       /*
>>        * There is a tiny chance that we have read bogus compound_order(),
>>        * so be careful to not go outside of the pageblock.
>> +     * Allow blockpfn outside pageblock in normal case that we isolate
>> +     * buddy page with order more than pageblock order.
>>        */
>> -    if (unlikely(blockpfn > end_pfn))
>> +    if (unlikely(blockpfn > end_pfn) && total_isolated <= pageblock_nr_pages)
>>           blockpfn = end_pfn;
>>         trace_mm_compaction_isolate_freepages(*start_pfn, blockpfn,
>> @@ -1418,7 +1420,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
>>       isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
>>         /* Skip this pageblock in the future as it's full or nearly full */
>> -    if (start_pfn == end_pfn && !cc->no_set_skip_hint)
>> +    if (start_pfn >= end_pfn && !cc->no_set_skip_hint)
>>           set_pageblock_skip(page);
>>   }
>>   @@ -1687,7 +1689,7 @@ static void isolate_freepages(struct compact_control *cc)
>>                       block_end_pfn, freelist, stride, false);
>>             /* Update the skip hint if the full pageblock was scanned */
>> -        if (isolate_start_pfn == block_end_pfn)
>> +        if (isolate_start_pfn >= block_end_pfn)
>>               update_pageblock_skip(cc, page, block_start_pfn);
>>             /* Are enough freepages isolated? */
> 

