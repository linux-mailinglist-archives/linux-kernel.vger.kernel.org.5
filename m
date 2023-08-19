Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CF8781983
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjHSM3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjHSM3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 08:29:08 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CF9469E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 05:27:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vq5KVnt_1692448074;
Received: from 30.97.48.38(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vq5KVnt_1692448074)
          by smtp.aliyun-inc.com;
          Sat, 19 Aug 2023 20:27:55 +0800
Message-ID: <3aefc27b-f7b8-6832-964d-77a55ea304fc@linux.alibaba.com>
Date:   Sat, 19 Aug 2023 20:27:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 7/9] mm/compaction: factor out code to test if we should
 run compaction for target order
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <20230805110711.2975149-8-shikemeng@huaweicloud.com>
 <7b337eca-1c45-c802-0aea-50d8d149efb4@linux.alibaba.com>
 <631d62de-c9b5-3c5f-e0b3-df0109627a27@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <631d62de-c9b5-3c5f-e0b3-df0109627a27@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2023 8:10 PM, Kemeng Shi wrote:
> 
> 
> on 8/15/2023 4:53 PM, Baolin Wang wrote:
>>
>>
>> On 8/5/2023 7:07 PM, Kemeng Shi wrote:
>>> We always do zone_watermark_ok check and compaction_suitable check
>>> together to test if compaction for target order should be runned.
>>> Factor these code out for preparation to remove repeat code.
>>>
>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>> ---
>>>    mm/compaction.c | 42 +++++++++++++++++++++++++++++-------------
>>>    1 file changed, 29 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index b5a699ed526b..26787ebb0297 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -2365,6 +2365,30 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>>>        return false;
>>>    }
>>>    +/*
>>> + * Should we do compaction for target allocation order.
>>> + * Return COMPACT_SUCCESS if allocation for target order can be already
>>> + * satisfied
>>> + * Return COMPACT_SKIPPED if compaction for target order is likely to fail
>>> + * Return COMPACT_CONTINUE if compaction for target order should be runned
>>> + */
>>> +static inline enum compact_result
>>> +compaction_suit_allocation_order(struct zone *zone, unsigned int order,
>>> +                 int highest_zoneidx, unsigned int alloc_flags)
>>> +{
>>> +    unsigned long watermark;
>>> +
>>> +    watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
>>
>> IIUC, the watermark used in patch 8 and patch 9 is different, right? Have you measured the impact of modifying this watermark?
>>
> Actually, there is no functional change intended. Consider wmark_pages with
> alloc_flags = 0 is equivalent to min_wmark_pages, patch 8 and patch 9 still
> use original watermark.

Can you use ALLOC_WMARK_MIN macro to make it more clear?

And I think patch 8 and patch 9 should be squashed into patch 7 to 
convert all at once.

>>> +    if (zone_watermark_ok(zone, order, watermark, highest_zoneidx,
>>> +                  alloc_flags))
>>> +        return COMPACT_SUCCESS;
>>> +
>>> +    if (!compaction_suitable(zone, order, highest_zoneidx))
>>> +        return COMPACT_SKIPPED;
>>> +
>>> +    return COMPACT_CONTINUE;
>>> +}
>>> +
>>>    static enum compact_result
>>>    compact_zone(struct compact_control *cc, struct capture_control *capc)
>>>    {
>>> @@ -2390,19 +2414,11 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>>>        cc->migratetype = gfp_migratetype(cc->gfp_mask);
>>>          if (compaction_with_allocation_order(cc->order)) {
>>> -        unsigned long watermark;
>>> -
>>> -        /* Allocation can already succeed, nothing to do */
>>> -        watermark = wmark_pages(cc->zone,
>>> -                    cc->alloc_flags & ALLOC_WMARK_MASK);
>>> -        if (zone_watermark_ok(cc->zone, cc->order, watermark,
>>> -                      cc->highest_zoneidx, cc->alloc_flags))
>>> -            return COMPACT_SUCCESS;
>>> -
>>> -        /* Compaction is likely to fail */
>>> -        if (!compaction_suitable(cc->zone, cc->order,
>>> -                     cc->highest_zoneidx))
>>> -            return COMPACT_SKIPPED;
>>> +        ret = compaction_suit_allocation_order(cc->zone, cc->order,
>>> +                               cc->highest_zoneidx,
>>> +                               cc->alloc_flags);
>>> +        if (ret != COMPACT_CONTINUE)
>>> +            return ret;
>>>        }
>>>          /*
>>
>>
