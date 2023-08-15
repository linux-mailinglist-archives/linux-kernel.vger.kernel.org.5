Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D044C77CC63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbjHOMKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbjHOMKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:10:12 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ACAE51
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:10:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RQ97b6pXGz4f3lKd
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:10:03 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgA3ZjIea9tkq+3oAg--.25318S2;
        Tue, 15 Aug 2023 20:10:06 +0800 (CST)
Subject: Re: [PATCH 7/9] mm/compaction: factor out code to test if we should
 run compaction for target order
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <20230805110711.2975149-8-shikemeng@huaweicloud.com>
 <7b337eca-1c45-c802-0aea-50d8d149efb4@linux.alibaba.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <631d62de-c9b5-3c5f-e0b3-df0109627a27@huaweicloud.com>
Date:   Tue, 15 Aug 2023 20:10:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <7b337eca-1c45-c802-0aea-50d8d149efb4@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgA3ZjIea9tkq+3oAg--.25318S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyrXryfGFy5XFyrWF4fAFb_yoWrJF4DpF
        18JrWUG3y8XF1fGr1xtF1UJFy5Xr48J3WDJrn2qF17Jw1ayr1jvr1qqryq9F1UXr4xJr4U
        JF4UXF9rZF15AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
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



on 8/15/2023 4:53 PM, Baolin Wang wrote:
> 
> 
> On 8/5/2023 7:07 PM, Kemeng Shi wrote:
>> We always do zone_watermark_ok check and compaction_suitable check
>> together to test if compaction for target order should be runned.
>> Factor these code out for preparation to remove repeat code.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   mm/compaction.c | 42 +++++++++++++++++++++++++++++-------------
>>   1 file changed, 29 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index b5a699ed526b..26787ebb0297 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -2365,6 +2365,30 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>>       return false;
>>   }
>>   +/*
>> + * Should we do compaction for target allocation order.
>> + * Return COMPACT_SUCCESS if allocation for target order can be already
>> + * satisfied
>> + * Return COMPACT_SKIPPED if compaction for target order is likely to fail
>> + * Return COMPACT_CONTINUE if compaction for target order should be runned
>> + */
>> +static inline enum compact_result
>> +compaction_suit_allocation_order(struct zone *zone, unsigned int order,
>> +                 int highest_zoneidx, unsigned int alloc_flags)
>> +{
>> +    unsigned long watermark;
>> +
>> +    watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> 
> IIUC, the watermark used in patch 8 and patch 9 is different, right? Have you measured the impact of modifying this watermark?
> 
Actually, there is no functional change intended. Consider wmark_pages with
alloc_flags = 0 is equivalent to min_wmark_pages, patch 8 and patch 9 still
use original watermark.

>> +    if (zone_watermark_ok(zone, order, watermark, highest_zoneidx,
>> +                  alloc_flags))
>> +        return COMPACT_SUCCESS;
>> +
>> +    if (!compaction_suitable(zone, order, highest_zoneidx))
>> +        return COMPACT_SKIPPED;
>> +
>> +    return COMPACT_CONTINUE;
>> +}
>> +
>>   static enum compact_result
>>   compact_zone(struct compact_control *cc, struct capture_control *capc)
>>   {
>> @@ -2390,19 +2414,11 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>>       cc->migratetype = gfp_migratetype(cc->gfp_mask);
>>         if (compaction_with_allocation_order(cc->order)) {
>> -        unsigned long watermark;
>> -
>> -        /* Allocation can already succeed, nothing to do */
>> -        watermark = wmark_pages(cc->zone,
>> -                    cc->alloc_flags & ALLOC_WMARK_MASK);
>> -        if (zone_watermark_ok(cc->zone, cc->order, watermark,
>> -                      cc->highest_zoneidx, cc->alloc_flags))
>> -            return COMPACT_SUCCESS;
>> -
>> -        /* Compaction is likely to fail */
>> -        if (!compaction_suitable(cc->zone, cc->order,
>> -                     cc->highest_zoneidx))
>> -            return COMPACT_SKIPPED;
>> +        ret = compaction_suit_allocation_order(cc->zone, cc->order,
>> +                               cc->highest_zoneidx,
>> +                               cc->alloc_flags);
>> +        if (ret != COMPACT_CONTINUE)
>> +            return ret;
>>       }
>>         /*
> 
> 

