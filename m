Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E5476A6E2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjHACTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHACTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:19:45 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAA3125
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:19:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFJhk126sz4f3lx0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:19:34 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgDXg6e4a8hkX5skPQ--.17531S2;
        Tue, 01 Aug 2023 10:19:36 +0800 (CST)
Subject: Re: [PATCH 2/8] mm/compaction: correct last_migrated_pfn update in
 compact_zone
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, david@redhat.com
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-3-shikemeng@huaweicloud.com>
 <fd381e0b-3d83-5a4d-cae1-b9957009e578@linux.alibaba.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <a7d2ba07-8f3c-55db-06c1-b467cb2217e9@huaweicloud.com>
Date:   Tue, 1 Aug 2023 10:19:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <fd381e0b-3d83-5a4d-cae1-b9957009e578@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXg6e4a8hkX5skPQ--.17531S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWxZr45Zw13Zr4UZr4Dtwb_yoW8tw48p3
        48G3WxKrWDW3y8CF17tF1kZFyrAw47t3W3JrZ8JFy8Ars5J3Wjq342qr1j9ryUXrsayr90
        vF4qqa9rZanrZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/1/2023 10:09 AM, Baolin Wang wrote:
> 
> 
> On 7/29/2023 1:10 AM, Kemeng Shi wrote:
>> We record start pfn of last isolated page block with last_migrated_pfn. And
>> then:
>> 1. We check if we mark the page block skip for exclusive access in
>> isolate_migratepages_block by test if next migrate pfn is still in last
>> isolated page block. If so, we will set finish_pageblock to do the rescan.
>> 2. We check if a full cc->order block is scanned by test if last scan range
>> passes the cc->order block boundary. If so, we flush the pages were freed.
>>
>> We treat cc->migrate_pfn before isolate_migratepages as the start pfn of
>> last isolated page range. However, we always align migrate_pfn to page block
>> or move to another page block in fast_find_migrateblock or in linearly scan
>> forward in isolate_migratepages before do page isolation in
>> isolate_migratepages_block.
> 
> Right. But can you describe the impact in detail if the last_migrated_pfn is not set correctly? For example, this will result in rescan not being set correctly to miss a pageblock's rescanning.
> 
> Otherwise looks good to me.
> 
Sure, the impact will be added in next version. Thanks!
>> Update last_migrated_pfn with pageblock_start_pfn(cc->migrate_pfn - 1)
>> after scan to correctly set start pfn of last isolated page range. > Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   mm/compaction.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index ce7841363b12..fb250c6b2b6e 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -2482,7 +2482,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>>               goto check_drain;
>>           case ISOLATE_SUCCESS:
>>               update_cached = false;
>> -            last_migrated_pfn = iteration_start_pfn;
>> +            last_migrated_pfn = max(cc->zone->zone_start_pfn,
>> +                pageblock_start_pfn(cc->migrate_pfn - 1));
>>           }
>>             err = migrate_pages(&cc->migratepages, compaction_alloc,
> 

-- 
Best wishes
Kemeng Shi

