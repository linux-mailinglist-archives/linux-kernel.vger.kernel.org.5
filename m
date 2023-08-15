Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C5577CAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjHOKIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbjHOKIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:08:02 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B09E65
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 03:08:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VprZgen_1692094076;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VprZgen_1692094076)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 18:07:57 +0800
Message-ID: <3729c50f-6f8e-2548-8932-f39045402299@linux.alibaba.com>
Date:   Tue, 15 Aug 2023 18:07:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/9] mm/compaction: simplify pfn iteration in
 isolate_freepages_range
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <20230805110711.2975149-5-shikemeng@huaweicloud.com>
 <ecb315f9-a5cd-4fb3-bae6-eb94a08eccb3@linux.alibaba.com>
 <43b726c1-3ea6-9acc-d4e4-c7deabcf7ecd@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <43b726c1-3ea6-9acc-d4e4-c7deabcf7ecd@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2023 5:32 PM, Kemeng Shi wrote:
> 
> 
> on 8/15/2023 4:38 PM, Baolin Wang wrote:
>>
>>
>> On 8/5/2023 7:07 PM, Kemeng Shi wrote:
>>> We call isolate_freepages_block in strict mode, continuous pages in
>>> pageblock will be isolated if isolate_freepages_block successed.
>>> Then pfn + isolated will point to start of next pageblock to scan
>>> no matter how many pageblocks are isolated in isolate_freepages_block.
>>> Use pfn + isolated as start of next pageblock to scan to simplify the
>>> iteration.
>>
>> IIUC, the isolate_freepages_block() can isolate high-order free pages, which means the pfn + isolated can be larger than the block_end_pfn. So in your patch, the 'block_start_pfn' and 'block_end_pfn' can be in different pageblocks, that will break pageblock_pfn_to_page().
>>
> In for update statement, we always update block_start_pfn to pfn and

I mean, you changed to:
1) pfn += isolated;
2) block_start_pfn = pfn;
3) block_end_pfn = pfn + pageblock_nr_pages;

But in 1) pfn + isolated can go outside of the currnet pageblock if 
isolating a high-order page, for example, located in the middle of the 
next pageblock. So that the block_start_pfn can point to the middle of 
the next pageblock, not the start position. Meanwhile after 3), the 
block_end_pfn can point another pageblock. Or I missed something else?

> update block_end_pfn to pfn + pageblock_nr_pages. So they should point
> to the same pageblock. I guess you missed the change to update of
> block_end_pfn. :)
>>>
>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>> ---
>>>    mm/compaction.c | 14 ++------------
>>>    1 file changed, 2 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index 684f6e6cd8bc..8d7d38073d30 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -733,21 +733,11 @@ isolate_freepages_range(struct compact_control *cc,
>>>        block_end_pfn = pageblock_end_pfn(pfn);
>>>          for (; pfn < end_pfn; pfn += isolated,
>>> -                block_start_pfn = block_end_pfn,
>>> -                block_end_pfn += pageblock_nr_pages) {
>>> +                block_start_pfn = pfn,
>>> +                block_end_pfn = pfn + pageblock_nr_pages) {
>>>            /* Protect pfn from changing by isolate_freepages_block */
>>>            unsigned long isolate_start_pfn = pfn;
>>>    -        /*
>>> -         * pfn could pass the block_end_pfn if isolated freepage
>>> -         * is more than pageblock order. In this case, we adjust
>>> -         * scanning range to right one.
>>> -         */
>>> -        if (pfn >= block_end_pfn) {
>>> -            block_start_pfn = pageblock_start_pfn(pfn);
>>> -            block_end_pfn = pageblock_end_pfn(pfn);
>>> -        }
>>> -
>>>            block_end_pfn = min(block_end_pfn, end_pfn);
>>>              if (!pageblock_pfn_to_page(block_start_pfn,
>>
