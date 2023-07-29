Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989DC767B80
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 04:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjG2CXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 22:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjG2CXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 22:23:45 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7201BC1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 19:23:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RCSwn5sLcz4f3kjG
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 10:23:37 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgC3h64reMRkx2Q4PA--.18707S2;
        Sat, 29 Jul 2023 10:23:40 +0800 (CST)
Subject: Re: [PATCH 1/8] mm/compaction: avoid missing last page block in
 section after skip offline sections
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        willy@infradead.org
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-2-shikemeng@huaweicloud.com>
 <8d3f4a1d-b624-3e2f-653c-032833646dea@redhat.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <b3b4b896-14e9-c432-602d-e9b63050aeee@huaweicloud.com>
Date:   Sat, 29 Jul 2023 10:23:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <8d3f4a1d-b624-3e2f-653c-032833646dea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3h64reMRkx2Q4PA--.18707S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4fJF15JFyxuryfKFW3KFg_yoW8KFyUpr
        48JFy7GryDX348Wa40yw1Uuryjyrs5Ja1UJr47AF18AF15Xr10gF92qr1q9r1jgrWxAFyj
        yr1vyFZruw13ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
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



on 7/28/2023 6:41 PM, David Hildenbrand wrote:
> On 28.07.23 19:10, Kemeng Shi wrote:
>> skip_offline_sections_reverse will return the last pfn in found online
>> section. Then we set block_start_pfn to start of page block which
>> contains the last pfn in section. Then we continue, move one page
>> block forward and ignore the last page block in the online section.
>> Make block_start_pfn point to first page block after online section to fix
>> this:
>> 1. make skip_offline_sections_reverse return end pfn of online section,
>> i.e. pfn of page block after online section.
>> 2. assign block_start_pfn with next_pfn.
>>
>> Fixes: f63224525309 ("mm: compaction: skip the memory hole rapidly when isolating free pages")
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   mm/compaction.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 9b7a0a69e19f..ce7841363b12 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
> 
> Can we add a short comment which kind of PFN we return (first pfn of first offline section after an online section)?
> 
Hi David, thanks for the review. Sure, I will add comment to skip_offline_sections_reverse.

-- 
Best wishes
Kemeng Shi
>> @@ -259,7 +259,7 @@ static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
>>         while (start_nr-- > 0) {
>>           if (online_section_nr(start_nr))
>> -            return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;
>> +            return section_nr_to_pfn(start_nr + 1);
>>       }
>>         return 0;
>> @@ -1670,8 +1670,7 @@ static void isolate_freepages(struct compact_control *cc)
>>                 next_pfn = skip_offline_sections_reverse(block_start_pfn);
>>               if (next_pfn)
>> -                block_start_pfn = max(pageblock_start_pfn(next_pfn),
>> -                              low_pfn);
>> +                block_start_pfn = max(next_pfn, low_pfn);
> 
> 
> So block_start_pfn() will now point at the first PFN of the offline section.
> 
> Confusing stuff, but I get the idea and I think it makes sense to me :)
> 

