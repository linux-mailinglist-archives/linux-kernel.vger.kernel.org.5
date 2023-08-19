Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BF478197B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 14:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjHSMQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 08:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjHSMQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 08:16:23 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01884255F5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 05:15:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vq5IL7U_1692447296;
Received: from 30.97.48.38(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vq5IL7U_1692447296)
          by smtp.aliyun-inc.com;
          Sat, 19 Aug 2023 20:14:57 +0800
Message-ID: <bf23350e-45cc-17ef-ac2c-9efff4a70172@linux.alibaba.com>
Date:   Sat, 19 Aug 2023 20:14:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 6/9] mm/compaction: rename is_via_compact_memory to
 compaction_with_allocation_order
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <20230805110711.2975149-7-shikemeng@huaweicloud.com>
 <111c3142-e20b-3e3c-f107-cbb64a16c2b0@linux.alibaba.com>
 <d28fc70d-ea1e-4c27-a206-6c276e6e020e@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <d28fc70d-ea1e-4c27-a206-6c276e6e020e@huaweicloud.com>
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



On 8/15/2023 8:04 PM, Kemeng Shi wrote:
> 
> 
> on 8/15/2023 4:58 PM, Baolin Wang wrote:
>>
>>
>> On 8/5/2023 7:07 PM, Kemeng Shi wrote:
>>> We have order = -1 via proactive compaction, the is_via_compact_memory is
>>> not proper name anymore.
>>> As cc->order informs the compaction to satisfy a allocation with that
>>> order, so rename it to compaction_with_allocation_order.
>>>
>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>> ---
>>>    mm/compaction.c | 11 +++++------
>>>    1 file changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index d8416d3dd445..b5a699ed526b 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -2055,12 +2055,11 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>>>    }
>>>      /*
>>> - * order == -1 is expected when compacting via
>>> - * /proc/sys/vm/compact_memory
>>> + * compact to satisfy allocation with target order
>>>     */
>>> -static inline bool is_via_compact_memory(int order)
>>> +static inline bool compaction_with_allocation_order(int order)
>>
>> I know naming is hard, but this name is not good enough that can show the compaction mode. But the original one could.
>>
> Yes, I agree with this, but name and comment of is_via_compact_memory may
> mislead reader that order == -1 is equivalent to compaction from
> /proc/sys/vm/compact_memory.
> Actually, we have several approaches to trigger compaction with order == -1:
> 1. via /proc/sys/vm/compact_memory
> 2. via /sys/devices/system/node/nodex/compact
> 3. via proactive compact

They can all be called proactive compaction.

> 
> Instead of indicate compaction is tirggerred by compact_memocy or anything,
> order == -1 implies if compaction is triggerrred to meet allocation with high
> order and we will stop compaction if allocation with target order will success.

IMO, the is_via_compact_memory() function helps people better 
distinguish the compaction logic we have under direct compaction or 
kcompactd compaction, while proactive compaction does not concern itself 
with these details. But compaction_with_allocation_order() will make me 
just wonder why we should compare with -1. So I don't think this patch 
is worth it, but as you said above, we can add more comments to make it 
more clear.

>>>    {
>>> -    return order == -1;
>>> +    return order != -1;
>>>    }
>>>      /*
>>> @@ -2200,7 +2199,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
>>>            goto out;
>>>        }
>>>    -    if (is_via_compact_memory(cc->order))
>>> +    if (!compaction_with_allocation_order(cc->order))
>>>            return COMPACT_CONTINUE;
>>>          /*
>>> @@ -2390,7 +2389,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>>>          cc->migratetype = gfp_migratetype(cc->gfp_mask);
>>>    -    if (!is_via_compact_memory(cc->order)) {
>>> +    if (compaction_with_allocation_order(cc->order)) {
>>>            unsigned long watermark;
>>>              /* Allocation can already succeed, nothing to do */
>>
