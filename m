Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E0376A771
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 05:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjHADYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 23:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjHADYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 23:24:11 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C2F19BE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:24:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RFL7746Hdz4f3yys
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:24:03 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgCHGDPSeshk47P3OQ--.13461S2;
        Tue, 01 Aug 2023 11:24:03 +0800 (CST)
Subject: Re: [PATCH 4/8] mm/compaction: remove stale fast_find_block flag in
 isolate_migratepages
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, david@redhat.com
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-5-shikemeng@huaweicloud.com>
 <d58cca96-4b98-8b27-1ad9-884e4db926af@linux.alibaba.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <dd8ab22f-d6e4-b609-38f4-3645cde5e0e3@huaweicloud.com>
Date:   Tue, 1 Aug 2023 11:24:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <d58cca96-4b98-8b27-1ad9-884e4db926af@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCHGDPSeshk47P3OQ--.13461S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF43Aw18tFyUuw4fuw1rJFb_yoW5Kw18pw
        18J34xGFyDC3WrXF1UJFyDX34UJw1xJ3ZrJr4Ut3W8Ars8JFnFqw1jqrnYgryYqr4fAryD
        Zr4UtasrZF47XrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
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



on 8/1/2023 10:42 AM, Baolin Wang wrote:
> 
> 
> On 7/29/2023 1:10 AM, Kemeng Shi wrote:
>> In old code, we set skip to found page block in fast_find_migrateblock. So
>> we use fast_find_block to avoid skip found page block from
>> fast_find_migrateblock.
>> In 90ed667c03fe5 ("Revert "Revert "mm/compaction: fix set skip in
>> fast_find_migrateblock"""), we remove skip set in fast_find_migrateblock,
>> then fast_find_block is useless.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   mm/compaction.c | 12 +-----------
>>   1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index ad535f880c70..09c36251c613 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1949,7 +1949,6 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>>       const isolate_mode_t isolate_mode =
>>           (sysctl_compact_unevictable_allowed ? ISOLATE_UNEVICTABLE : 0) |
>>           (cc->mode != MIGRATE_SYNC ? ISOLATE_ASYNC_MIGRATE : 0);
>> -    bool fast_find_block;
>>         /*
>>        * Start at where we last stopped, or beginning of the zone as
>> @@ -1961,13 +1960,6 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>>       if (block_start_pfn < cc->zone->zone_start_pfn)
>>           block_start_pfn = cc->zone->zone_start_pfn;
>>   -    /*
>> -     * fast_find_migrateblock marks a pageblock skipped so to avoid
>> -     * the isolation_suitable check below, check whether the fast
>> -     * search was successful.
>> -     */
>> -    fast_find_block = low_pfn != cc->migrate_pfn && !cc->fast_search_fail;
>> -
>>       /* Only scan within a pageblock boundary */
>>       block_end_pfn = pageblock_end_pfn(low_pfn);
>>   @@ -1976,7 +1968,6 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>>        * Do not cross the free scanner.
>>        */
>>       for (; block_end_pfn <= cc->free_pfn;
>> -            fast_find_block = false,
>>               cc->migrate_pfn = low_pfn = block_end_pfn,
>>               block_start_pfn = block_end_pfn,
>>               block_end_pfn += pageblock_nr_pages) {
>> @@ -2007,8 +1998,7 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>>            * before making it "skip" so other compaction instances do
>>            * not scan the same block.
>>            */
>> -        if (pageblock_aligned(low_pfn) &&
>> -            !fast_find_block && !isolation_suitable(cc, page))
>> +        if (pageblock_aligned(low_pfn) && !isolation_suitable(cc, page))
> 
> I do not think so. If the pageblock is found by fast_find_migrateblock(), that means it definitely has not been set the skip flag, so there is not need to call isolation_suitable() if fast_find_block is true, right?
> 
> 
Actually, found pageblock could be set skip as:
1. other compactor could mark this pageblock as skip after zone lock is realeased
in fast_find_migrateblock.
2. fast_find_migrateblock may uses pfn from reinit_migrate_pfn which is previously found
and sacnned. It could be fully sacnned and marked skip after it's first return from
fast_find_migrateblock and it should be skipped.
Thanks!
-- 
Best wishes
Kemeng Shi

