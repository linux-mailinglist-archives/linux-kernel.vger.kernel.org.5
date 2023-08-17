Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B9677EF02
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 04:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347631AbjHQCWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 22:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347620AbjHQCWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:22:12 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D4269F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 19:22:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RR80F0xWvz4f3mJ4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:22:05 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgBnRKdMhN1ks72TAw--.40305S2;
        Thu, 17 Aug 2023 10:22:06 +0800 (CST)
Subject: Re: [PATCH 1/2] mm/page_alloc: remove track of active PCP lists range
 in bulk free
To:     Chris Li <chrisl@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
References: <20230809100754.3094517-1-shikemeng@huaweicloud.com>
 <20230809100754.3094517-2-shikemeng@huaweicloud.com>
 <ZNu5uHhYI4QxR4au@google.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <53956bbf-844c-97da-2057-a8805360b35f@huaweicloud.com>
Date:   Thu, 17 Aug 2023 10:22:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <ZNu5uHhYI4QxR4au@google.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBnRKdMhN1ks72TAw--.40305S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4rZrWDKrW8Zw1UXFW3Awb_yoW5XFWrpr
        WFyFnayFWkJrW0kw47ZanrW3429w4YyFWDWrW5Ja4rZwnxurySkFs7K3y0grWrArWxAFWI
        vF42qF1SvFyUZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/16/2023 1:45 AM, Chris Li wrote:
> Hi Kemeng,
> 
> Can you confirm this patch has no intended functional change?
> 
Hi Chris, there is no functional change intended in this patch. As
I menthioned in changelog, there is no wrap for list iteration, so
that the active PCP lists range will never be used.
> I have a patch sitting in my tree for a while related to this
> count vs pcp->count.  The BPF function hook can potentially change
> pcp->count and make count out of sync with pcp->count which causes
> a dead loop.
> 
I guess pcp->count is set to bigger than it should be. In this case,
we will keep trying get pages while all pages in pcp list were taken
off already and dead lock will happen. In this case, dead looo will
happen with or without this patch as the root cause is that we try
to get pages more than pcp list owns.> Maybe I can send my out alone side with yours for discussion?
> I don't mind my patch combined with yours.
>
Either way is acceptable to me, just feel free to choose one you like
and I'd like to see if more we could do to this.

> Your change looks fine to me. There is more can be done
> on the clean up.
>
Thanks for feedback, and more clean up is welcome.
> Chris
> 
> On Wed, Aug 09, 2023 at 06:07:53PM +0800, Kemeng Shi wrote:
>> After commit fd56eef258a17 ("mm/page_alloc: simplify how many pages are
>> selected per pcp list during bulk free"), we will drain all pages in
>> selected pcp list. And we ensured passed count is < pcp->count. Then,
>> the search will finish before wrap-around and track of active PCP lists
>> range intended for wrap-around case is no longer needed.
> 
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  mm/page_alloc.c | 15 +++------------
>>  1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 96b7c1a7d1f2..1ddcb2707d05 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1207,8 +1207,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>>  					int pindex)
>>  {
>>  	unsigned long flags;
>> -	int min_pindex = 0;
>> -	int max_pindex = NR_PCP_LISTS - 1;
>>  	unsigned int order;
>>  	bool isolated_pageblocks;
>>  	struct page *page;
>> @@ -1231,17 +1229,10 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>>  
>>  		/* Remove pages from lists in a round-robin fashion. */
>>  		do {
>> -			if (++pindex > max_pindex)
>> -				pindex = min_pindex;
>> +			if (++pindex > NR_PCP_LISTS - 1)
>> +				pindex = 0;
>>  			list = &pcp->lists[pindex];
>> -			if (!list_empty(list))
>> -				break;
>> -
>> -			if (pindex == max_pindex)
>> -				max_pindex--;
>> -			if (pindex == min_pindex)
>> -				min_pindex++;
>> -		} while (1);
>> +		} while (list_empty(list));
>>  
>>  		order = pindex_to_order(pindex);
>>  		nr_pages = 1 << order;
>> -- 
>> 2.30.0
>>
> 

