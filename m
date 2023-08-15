Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11AD77CA86
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbjHOJeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbjHOJcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:32:55 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BB6212D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:32:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQ5f62cwDz4f3mVy
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 17:32:46 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgB3Bqk9Rttk9ywMAw--.11509S2;
        Tue, 15 Aug 2023 17:32:46 +0800 (CST)
Subject: Re: [PATCH 4/9] mm/compaction: simplify pfn iteration in
 isolate_freepages_range
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <20230805110711.2975149-5-shikemeng@huaweicloud.com>
 <ecb315f9-a5cd-4fb3-bae6-eb94a08eccb3@linux.alibaba.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <43b726c1-3ea6-9acc-d4e4-c7deabcf7ecd@huaweicloud.com>
Date:   Tue, 15 Aug 2023 17:32:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <ecb315f9-a5cd-4fb3-bae6-eb94a08eccb3@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3Bqk9Rttk9ywMAw--.11509S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1xZF1kKw1kJry3Gw4kJFb_yoW5GF48pa
        48JF1xGryUG3W0gF17J34DZryUGw4UG3WUJr4UJF1UZFyFyF9Fgr1qqr1qgFyjqr4xArWq
        vr1DtF9rZ3WUZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/15/2023 4:38 PM, Baolin Wang wrote:
> 
> 
> On 8/5/2023 7:07 PM, Kemeng Shi wrote:
>> We call isolate_freepages_block in strict mode, continuous pages in
>> pageblock will be isolated if isolate_freepages_block successed.
>> Then pfn + isolated will point to start of next pageblock to scan
>> no matter how many pageblocks are isolated in isolate_freepages_block.
>> Use pfn + isolated as start of next pageblock to scan to simplify the
>> iteration.
> 
> IIUC, the isolate_freepages_block() can isolate high-order free pages, which means the pfn + isolated can be larger than the block_end_pfn. So in your patch, the 'block_start_pfn' and 'block_end_pfn' can be in different pageblocks, that will break pageblock_pfn_to_page().
> 
In for update statement, we always update block_start_pfn to pfn and
update block_end_pfn to pfn + pageblock_nr_pages. So they should point
to the same pageblock. I guess you missed the change to update of
block_end_pfn. :)
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   mm/compaction.c | 14 ++------------
>>   1 file changed, 2 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 684f6e6cd8bc..8d7d38073d30 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -733,21 +733,11 @@ isolate_freepages_range(struct compact_control *cc,
>>       block_end_pfn = pageblock_end_pfn(pfn);
>>         for (; pfn < end_pfn; pfn += isolated,
>> -                block_start_pfn = block_end_pfn,
>> -                block_end_pfn += pageblock_nr_pages) {
>> +                block_start_pfn = pfn,
>> +                block_end_pfn = pfn + pageblock_nr_pages) {
>>           /* Protect pfn from changing by isolate_freepages_block */
>>           unsigned long isolate_start_pfn = pfn;
>>   -        /*
>> -         * pfn could pass the block_end_pfn if isolated freepage
>> -         * is more than pageblock order. In this case, we adjust
>> -         * scanning range to right one.
>> -         */
>> -        if (pfn >= block_end_pfn) {
>> -            block_start_pfn = pageblock_start_pfn(pfn);
>> -            block_end_pfn = pageblock_end_pfn(pfn);
>> -        }
>> -
>>           block_end_pfn = min(block_end_pfn, end_pfn);
>>             if (!pageblock_pfn_to_page(block_start_pfn,
> 

