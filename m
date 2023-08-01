Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCEB76AAA5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjHAIPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjHAIPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:15:19 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECC31FD2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:15:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VopS8qt_1690877699;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VopS8qt_1690877699)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 16:15:00 +0800
Message-ID: <266af290-fede-88a8-5cb2-0d03f551bee4@linux.alibaba.com>
Date:   Tue, 1 Aug 2023 16:15:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/8] mm/compaction: remove stale fast_find_block flag in
 isolate_migratepages
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-5-shikemeng@huaweicloud.com>
 <d58cca96-4b98-8b27-1ad9-884e4db926af@linux.alibaba.com>
 <dd8ab22f-d6e4-b609-38f4-3645cde5e0e3@huaweicloud.com>
 <ab91a0e6-8a19-148c-1e93-ca7a51f5c459@linux.alibaba.com>
 <cbd52207-31a2-46d3-8910-68b056885bcb@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <cbd52207-31a2-46d3-8910-68b056885bcb@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/2023 11:48 AM, Kemeng Shi wrote:
> 
> 
> on 8/1/2023 11:34 AM, Baolin Wang wrote:
>>
>>
>> On 8/1/2023 11:24 AM, Kemeng Shi wrote:
>>>
>>>
>>> on 8/1/2023 10:42 AM, Baolin Wang wrote:
>>>>
>>>>
>>>> On 7/29/2023 1:10 AM, Kemeng Shi wrote:
>>>>> In old code, we set skip to found page block in fast_find_migrateblock. So
>>>>> we use fast_find_block to avoid skip found page block from
>>>>> fast_find_migrateblock.
>>>>> In 90ed667c03fe5 ("Revert "Revert "mm/compaction: fix set skip in
>>>>> fast_find_migrateblock"""), we remove skip set in fast_find_migrateblock,
>>>>> then fast_find_block is useless.
>>>>>
>>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>>> ---
>>>>>     mm/compaction.c | 12 +-----------
>>>>>     1 file changed, 1 insertion(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>>> index ad535f880c70..09c36251c613 100644
>>>>> --- a/mm/compaction.c
>>>>> +++ b/mm/compaction.c
>>>>> @@ -1949,7 +1949,6 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>>>>>         const isolate_mode_t isolate_mode =
>>>>>             (sysctl_compact_unevictable_allowed ? ISOLATE_UNEVICTABLE : 0) |
>>>>>             (cc->mode != MIGRATE_SYNC ? ISOLATE_ASYNC_MIGRATE : 0);
>>>>> -    bool fast_find_block;
>>>>>           /*
>>>>>          * Start at where we last stopped, or beginning of the zone as
>>>>> @@ -1961,13 +1960,6 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>>>>>         if (block_start_pfn < cc->zone->zone_start_pfn)
>>>>>             block_start_pfn = cc->zone->zone_start_pfn;
>>>>>     -    /*
>>>>> -     * fast_find_migrateblock marks a pageblock skipped so to avoid
>>>>> -     * the isolation_suitable check below, check whether the fast
>>>>> -     * search was successful.
>>>>> -     */
>>>>> -    fast_find_block = low_pfn != cc->migrate_pfn && !cc->fast_search_fail;
>>>>> -
>>>>>         /* Only scan within a pageblock boundary */
>>>>>         block_end_pfn = pageblock_end_pfn(low_pfn);
>>>>>     @@ -1976,7 +1968,6 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>>>>>          * Do not cross the free scanner.
>>>>>          */
>>>>>         for (; block_end_pfn <= cc->free_pfn;
>>>>> -            fast_find_block = false,
>>>>>                 cc->migrate_pfn = low_pfn = block_end_pfn,
>>>>>                 block_start_pfn = block_end_pfn,
>>>>>                 block_end_pfn += pageblock_nr_pages) {
>>>>> @@ -2007,8 +1998,7 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>>>>>              * before making it "skip" so other compaction instances do
>>>>>              * not scan the same block.
>>>>>              */
>>>>> -        if (pageblock_aligned(low_pfn) &&
>>>>> -            !fast_find_block && !isolation_suitable(cc, page))
>>>>> +        if (pageblock_aligned(low_pfn) && !isolation_suitable(cc, page))
>>>>
>>>> I do not think so. If the pageblock is found by fast_find_migrateblock(), that means it definitely has not been set the skip flag, so there is not need to call isolation_suitable() if fast_find_block is true, right?
>>>>
>>>>
>>> Actually, found pageblock could be set skip as:
>>> 1. other compactor could mark this pageblock as skip after zone lock is realeased
>>> in fast_find_migrateblock.
>>
>> Yes, but your patch also can not close this race window, that means it can also be set skip flag after the isolation_suitable() validation by other compactors.
>>
> Yes, I think it's still worth to remove a lot of fast_find_block relevant check and reduce
> code complexity with one redundant isolation_suitable which may skip some block with luck.
>>> 2. fast_find_migrateblock may uses pfn from reinit_migrate_pfn which is previously found
>>> and sacnned. It could be fully sacnned and marked skip after it's first return from
>>
>> Right, but now the 'fast_find_block' is false, and we will call isolation_suitable() to validate the skip flag.
>>
> Right, sorry for missing that.
> 
> But it's ok to keep the fast_find_block if you insist and I will just correct the stale

Yes, I still prefer to keep the fast_find_block, since I did not see 
this patch can fix any real issue and might have a side effect for 
fast-find-pageblock(?).

> comment that "fast_find_migrateblock marks a pageblock skipped ..." in next version.

Sure, please do it.
