Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CF778D360
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 08:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjH3G2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 02:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbjH3G2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:28:36 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3263CE0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:28:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbDrW4SGhz4f3kpQ
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:28:27 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgDH5b2L4e5klx0+Bw--.62156S2;
        Wed, 30 Aug 2023 14:28:28 +0800 (CST)
Subject: Re: [PATCH v2 7/7] mm/compaction: factor out code to test if we
 should run compaction for target order
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
 <20230826153617.4019189-8-shikemeng@huaweicloud.com>
 <940a7978-ebbb-f232-b536-7c8d16c0d1f1@linux.alibaba.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <63028022-560d-278e-d7b5-3cdd93467c99@huaweicloud.com>
Date:   Wed, 30 Aug 2023 14:28:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <940a7978-ebbb-f232-b536-7c8d16c0d1f1@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDH5b2L4e5klx0+Bw--.62156S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WrW7WF1fJFyxCrW5Ww1ftFb_yoW7Cw1kpF
        18JryUJry8Xr1rGr1UJF1UJFy5Jr48J3WDJr10qF1UJr1ayr1qvr1qqr1q9F1UJr48Jr4U
        Jr1UXrnrZFnrArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/29/2023 11:48 AM, Baolin Wang wrote:
> 
> 
> On 8/26/2023 11:36 PM, Kemeng Shi wrote:
>> We always do zone_watermark_ok check and compaction_suitable check
>> together to test if compaction for target order should be runned.
>> Factor these code out to remove repeat code.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   mm/compaction.c | 63 ++++++++++++++++++++++++++++---------------------
>>   1 file changed, 36 insertions(+), 27 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 00b7bba6c72e..6f2b87b026b8 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -2374,6 +2374,30 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
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
> 
> I think you should drop the 'inline' to let the compiler make the decision.
> 
Sure, I will drop this in next version. Thanks for feedback.
>> +compaction_suit_allocation_order(struct zone *zone, unsigned int order,
>> +                 int highest_zoneidx, unsigned int alloc_flags)
> 
> The changes look good to me. So please feel free to add:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
>> +{
>> +    unsigned long watermark;
>> +
>> +    watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
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
>> @@ -2399,19 +2423,11 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>>       cc->migratetype = gfp_migratetype(cc->gfp_mask);
>>         if (!is_via_compact_memory(cc->order)) {
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
>> @@ -2917,14 +2933,10 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
>>           if (!populated_zone(zone))
>>               continue;
>>   -        /* Allocation can already succeed, check other zones */
>> -        if (zone_watermark_ok(zone, pgdat->kcompactd_max_order,
>> -                      min_wmark_pages(zone),
>> -                      highest_zoneidx, 0))
>> -            continue;
>> -
>> -        if (compaction_suitable(zone, pgdat->kcompactd_max_order,
>> -                    highest_zoneidx))
>> +        if (compaction_suit_allocation_order(zone,
>> +                pgdat->kcompactd_max_order,
>> +                highest_zoneidx, ALLOC_WMARK_MIN) ==
>> +                COMPACT_CONTINUE)
>>               return true;
>>       }
>>   @@ -2961,12 +2973,9 @@ static void kcompactd_do_work(pg_data_t *pgdat)
>>           if (compaction_deferred(zone, cc.order))
>>               continue;
>>   -        /* Allocation can already succeed, nothing to do */
>> -        if (zone_watermark_ok(zone, cc.order,
>> -                      min_wmark_pages(zone), zoneid, 0))
>> -            continue;
>> -
>> -        if (!compaction_suitable(zone, cc.order, zoneid))
>> +        if (compaction_suit_allocation_order(zone,
>> +                cc.order, zoneid, ALLOC_WMARK_MIN) !=
>> +                COMPACT_CONTINUE)
>>               continue;
>>             if (kthread_should_stop())
> 

