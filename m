Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD6477CA70
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbjHOJ3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbjHOJ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:28:13 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86D1BC0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:22:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RQ5Pg2nf5z4f3mL5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 17:21:59 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgA3DcW5Q9tkeCneAg--.10131S2;
        Tue, 15 Aug 2023 17:22:02 +0800 (CST)
Subject: Re: [PATCH 3/9] mm/compaction: correctly return failure with bogus
 compound_order in strict mode
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <20230805110711.2975149-4-shikemeng@huaweicloud.com>
 <a8edac8d-8e22-89cf-2c8c-217a54608d27@linux.alibaba.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <c8797b95-052a-3db0-5a0a-e315db746a92@huaweicloud.com>
Date:   Tue, 15 Aug 2023 17:22:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <a8edac8d-8e22-89cf-2c8c-217a54608d27@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA3DcW5Q9tkeCneAg--.10131S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4xXrW8ArWkGr1fWw13twb_yoWrtF15pF
        yktFy7JryUCw1FqF17Jr1DAryUCw48t3WUJr48XFyUArn8Jr12qr1jvr1j9ryUXr4xAr1j
        qr4UtF9rZF17Xa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/15/2023 4:28 PM, Baolin Wang wrote:
> 
> 
> On 8/5/2023 7:07 PM, Kemeng Shi wrote:
>> In strict mode, we should return 0 if there is any hole in pageblock. If
>> we successfully isolated pages at beginning at pageblock and then have a
>> bogus compound_order outside pageblock in next page. We will abort search
>> loop with blockpfn > end_pfn. Although we will limit blockpfn to end_pfn,
>> we will treat it as a successful isolation in strict mode as blockpfn is
>> not < end_pfn and return partial isolated pages. Then
>> isolate_freepages_range may success unexpectly with hole in isolated
>> range.
> 
> Yes, that can be happened.
> 
>> This patch also removes unnecessary limit for blockpfn to go outside
>> by buddy page introduced in fixed commit or by stride introduced after
>> fixed commit. Caller could use returned blockpfn to check if full
>> pageblock is scanned by test if blockpfn >= end and to get next pfn to
>> scan inside isolate_freepages_block on demand.
> 
> IMO, I don't think removing the pageblock restriction is worth it, since it did not fix anything and will make people more confused, at least to me.
> 
> That is to say, it will be surprised that the blockpfn can go outside of the pageblock after calling isolate_freepages_block() to just scan only one pageblock, and I did not see in detail if this can cause other potential problems.
> 
>> Fixes: 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in free scanner")
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   mm/compaction.c | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index fa1b100b0d10..684f6e6cd8bc 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -631,6 +631,14 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>>                   page += (1UL << order) - 1;
>>                   nr_scanned += (1UL << order) - 1;
>>               }
>> +            /*
>> +             * There is a tiny chance that we have read bogus
>> +             * compound_order(), so be careful to not go outside
>> +             * of the pageblock.
>> +             */
>> +            if (unlikely(blockpfn >= end_pfn))
>> +                blockpfn = end_pfn - 1;
> 
> So we can just add this validation to ensure that the isolate_freepages_block() can return 0 if failure is happened, which can fix your problem.
> 
Thanks for feedback! Sure, I will do this in next version.
>> +
>>               goto isolate_fail;
>>           }
>>   @@ -677,17 +685,10 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>>       if (locked)
>>           spin_unlock_irqrestore(&cc->zone->lock, flags);
>>   -    /*
>> -     * There is a tiny chance that we have read bogus compound_order(),
>> -     * so be careful to not go outside of the pageblock.
>> -     */
>> -    if (unlikely(blockpfn > end_pfn))
>> -        blockpfn = end_pfn;
>> -
>>       trace_mm_compaction_isolate_freepages(*start_pfn, blockpfn,
>>                       nr_scanned, total_isolated);
>>   -    /* Record how far we have got within the block */
>> +    /* Record how far we have got */
>>       *start_pfn = blockpfn;
>>         /*
>> @@ -1443,7 +1444,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
>>       isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
>>         /* Skip this pageblock in the future as it's full or nearly full */
>> -    if (start_pfn == end_pfn && !cc->no_set_skip_hint)
>> +    if (start_pfn >= end_pfn && !cc->no_set_skip_hint)
>>           set_pageblock_skip(page);
>>   }
>>   @@ -1712,7 +1713,7 @@ static void isolate_freepages(struct compact_control *cc)
>>                       block_end_pfn, freelist, stride, false);
>>             /* Update the skip hint if the full pageblock was scanned */
>> -        if (isolate_start_pfn == block_end_pfn)
>> +        if (isolate_start_pfn >= block_end_pfn)
>>               update_pageblock_skip(cc, page, block_start_pfn -
>>                             pageblock_nr_pages);
>>   
> 

