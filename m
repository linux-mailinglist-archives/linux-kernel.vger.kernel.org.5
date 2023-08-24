Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD2A7865A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 05:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbjHXDAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 23:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbjHXC7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:59:47 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B129C124
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:59:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWSVM3GSrz4f3n5d
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 10:59:39 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgC3j6Kbx+ZkBYrGBQ--.40864S2;
        Thu, 24 Aug 2023 10:59:40 +0800 (CST)
Subject: Re: [PATCH 7/9] mm/compaction: factor out code to test if we should
 run compaction for target order
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <20230805110711.2975149-8-shikemeng@huaweicloud.com>
 <7b337eca-1c45-c802-0aea-50d8d149efb4@linux.alibaba.com>
 <631d62de-c9b5-3c5f-e0b3-df0109627a27@huaweicloud.com>
 <3aefc27b-f7b8-6832-964d-77a55ea304fc@linux.alibaba.com>
 <ba737e36-ef83-8254-aff1-1a46a9029fff@huaweicloud.com>
 <7a309d46-4fbc-f86e-5f21-b77660e84ff5@linux.alibaba.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <0e907eb6-db69-503c-1d17-a26fc53c8384@huaweicloud.com>
Date:   Thu, 24 Aug 2023 10:59:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <7a309d46-4fbc-f86e-5f21-b77660e84ff5@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3j6Kbx+ZkBYrGBQ--.40864S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1fAFWDKr4kXFy8Cry8Krg_yoW7Gr43pr
        18JFyUJ3yrXr18Gr17tw1UJFy3tw48J3WDXrnFqF1UJrsIyr1qqr1qqryq9r1UXr48Jr1U
        XF1UJFy7ZF15A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/24/2023 10:25 AM, Baolin Wang wrote:
> 
> 
> On 8/22/2023 9:57 AM, Kemeng Shi wrote:
>>
>>
>> on 8/19/2023 8:27 PM, Baolin Wang wrote:
>>>
>>>
>>> On 8/15/2023 8:10 PM, Kemeng Shi wrote:
>>>>
>>>>
>>>> on 8/15/2023 4:53 PM, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 8/5/2023 7:07 PM, Kemeng Shi wrote:
>>>>>> We always do zone_watermark_ok check and compaction_suitable check
>>>>>> together to test if compaction for target order should be runned.
>>>>>> Factor these code out for preparation to remove repeat code.
>>>>>>
>>>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>>>> ---
>>>>>>     mm/compaction.c | 42 +++++++++++++++++++++++++++++-------------
>>>>>>     1 file changed, 29 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>>>> index b5a699ed526b..26787ebb0297 100644
>>>>>> --- a/mm/compaction.c
>>>>>> +++ b/mm/compaction.c
>>>>>> @@ -2365,6 +2365,30 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>>>>>>         return false;
>>>>>>     }
>>>>>>     +/*
>>>>>> + * Should we do compaction for target allocation order.
>>>>>> + * Return COMPACT_SUCCESS if allocation for target order can be already
>>>>>> + * satisfied
>>>>>> + * Return COMPACT_SKIPPED if compaction for target order is likely to fail
>>>>>> + * Return COMPACT_CONTINUE if compaction for target order should be runned
>>>>>> + */
>>>>>> +static inline enum compact_result
>>>>>> +compaction_suit_allocation_order(struct zone *zone, unsigned int order,
>>>>>> +                 int highest_zoneidx, unsigned int alloc_flags)
>>>>>> +{
>>>>>> +    unsigned long watermark;
>>>>>> +
>>>>>> +    watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
>>>>>
>>>>> IIUC, the watermark used in patch 8 and patch 9 is different, right? Have you measured the impact of modifying this watermark?
>>>>>
>>>> Actually, there is no functional change intended. Consider wmark_pages with
>>>> alloc_flags = 0 is equivalent to min_wmark_pages, patch 8 and patch 9 still
>>>> use original watermark.
>>>
>>> Can you use ALLOC_WMARK_MIN macro to make it more clear?
>> Sorry, I can't quite follow this. The watermark should differ with different
>> alloc_flags instead of WMARK_MIN hard-coded.
>> Patch 8 and patch 9 use watermark with WMARK_MIN as they get alloc_flags = 0.
> 
> I mean you can pass 'alloc_flags=ALLOC_WMARK_MIN' instead of a magic number 0 when calling compaction_suit_allocation_order() in patch 8 and patch 9.
> 
Thanks for explain and this do make it better. I will do this in next version.
>>> And I think patch 8 and patch 9 should be squashed into patch 7 to convert all at once.
>> Sure, i could do this in next version.
>>>
>>>>>> +    if (zone_watermark_ok(zone, order, watermark, highest_zoneidx,
>>>>>> +                  alloc_flags))
>>>>>> +        return COMPACT_SUCCESS;
>>>>>> +
>>>>>> +    if (!compaction_suitable(zone, order, highest_zoneidx))
>>>>>> +        return COMPACT_SKIPPED;
>>>>>> +
>>>>>> +    return COMPACT_CONTINUE;
>>>>>> +}
>>>>>> +
>>>>>>     static enum compact_result
>>>>>>     compact_zone(struct compact_control *cc, struct capture_control *capc)
>>>>>>     {
>>>>>> @@ -2390,19 +2414,11 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>>>>>>         cc->migratetype = gfp_migratetype(cc->gfp_mask);
>>>>>>           if (compaction_with_allocation_order(cc->order)) {
>>>>>> -        unsigned long watermark;
>>>>>> -
>>>>>> -        /* Allocation can already succeed, nothing to do */
>>>>>> -        watermark = wmark_pages(cc->zone,
>>>>>> -                    cc->alloc_flags & ALLOC_WMARK_MASK);
>>>>>> -        if (zone_watermark_ok(cc->zone, cc->order, watermark,
>>>>>> -                      cc->highest_zoneidx, cc->alloc_flags))
>>>>>> -            return COMPACT_SUCCESS;
>>>>>> -
>>>>>> -        /* Compaction is likely to fail */
>>>>>> -        if (!compaction_suitable(cc->zone, cc->order,
>>>>>> -                     cc->highest_zoneidx))
>>>>>> -            return COMPACT_SKIPPED;
>>>>>> +        ret = compaction_suit_allocation_order(cc->zone, cc->order,
>>>>>> +                               cc->highest_zoneidx,
>>>>>> +                               cc->alloc_flags);
>>>>>> +        if (ret != COMPACT_CONTINUE)
>>>>>> +            return ret;
>>>>>>         }
>>>>>>           /*
>>>>>
>>>>>
>>>
>>>
> 

