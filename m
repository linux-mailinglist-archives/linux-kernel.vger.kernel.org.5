Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A55278FADB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348549AbjIAJdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjIAJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:33:01 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3410C0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:32:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RcXrK67Ykz4f4XXP
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 17:32:49 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgAHJLzBr_FkCZfiBw--.14106S2;
        Fri, 01 Sep 2023 17:32:51 +0800 (CST)
Subject: Re: [PATCH v3 3/6] mm/compaction: correctly return failure with bogus
 compound_order in strict mode
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230901155141.249860-1-shikemeng@huaweicloud.com>
 <20230901155141.249860-4-shikemeng@huaweicloud.com>
 <20230901091711.rpykbvfsnrcuwqhn@techsingularity.net>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <74851ecc-93ff-1ec3-1589-f13d66d4336d@huaweicloud.com>
Date:   Fri, 1 Sep 2023 17:32:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230901091711.rpykbvfsnrcuwqhn@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgAHJLzBr_FkCZfiBw--.14106S2
X-Coremail-Antispam: 1UD129KBjvJXoW7try5JFWfurW5uF4DCw1kAFb_yoW8tF17pa
        yDK3WxCF1v934YgFy7AFWDZw12gwsakF47A398K3W8AF9aya4Syry2yr18uFyjqrnrAFW0
        vrsrWFWSkayqqa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 9/1/2023 5:17 PM, Mel Gorman wrote:
> On Fri, Sep 01, 2023 at 11:51:38PM +0800, Kemeng Shi wrote:
>> In strict mode, we should return 0 if there is any hole in pageblock. If
>> we successfully isolated pages at beginning at pageblock and then have a
>> bogus compound_order outside pageblock in next page. We will abort search
>> loop with blockpfn > end_pfn. Although we will limit blockpfn to end_pfn,
>> we will treat it as a successful isolation in strict mode as blockpfn is
>> not < end_pfn and return partial isolated pages. Then
>> isolate_freepages_range may success unexpectly with hole in isolated
>> range.
>>
>> Fixes: 9fcd6d2e052e ("mm, compaction: skip compound pages by order in free scanner")
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>  mm/compaction.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index a40550a33aee..9ecbfbc695e5 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -626,11 +626,12 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>>  		if (PageCompound(page)) {
>>  			const unsigned int order = compound_order(page);
>>  
>> -			if (likely(order <= MAX_ORDER)) {
>> +			if (blockpfn + (1UL << order) <= end_pfn) {
>>  				blockpfn += (1UL << order) - 1;
>>  				page += (1UL << order) - 1;
>>  				nr_scanned += (1UL << order) - 1;
>>  			}
>> +
>>  			goto isolate_fail;
>>  		}
>>  
>> @@ -678,8 +679,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>>  		spin_unlock_irqrestore(&cc->zone->lock, flags);
>>  
>>  	/*
>> -	 * There is a tiny chance that we have read bogus compound_order(),
>> -	 * so be careful to not go outside of the pageblock.
>> +	 * Be careful to not go outside of the pageblock.
>>  	 */
>>  	if (unlikely(blockpfn > end_pfn))
>>  		blockpfn = end_pfn;
> 
> Is this check still necessary after the first hunk?
> 
Actually, I removed this check in the first version, but Baolin thought remove this check is not
cheap and not worth it. More discussion can be found in [1]. Thanks!

[1] https://lore.kernel.org/all/a8edac8d-8e22-89cf-2c8c-217a54608d27@linux.alibaba.com/

