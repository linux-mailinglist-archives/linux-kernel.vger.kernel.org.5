Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1327077EF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 04:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347677AbjHQCoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 22:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347685AbjHQCno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:43:44 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F61B26AA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 19:43:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RR8T36jXTz4f3kFD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:43:35 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgB3VKdZid1k_vaUAw--.42597S2;
        Thu, 17 Aug 2023 10:43:38 +0800 (CST)
Subject: Re: [PATCH 2/2] mm/page_alloc: remove unnecessary parameter batch of
 nr_pcp_free
To:     Chris Li <chrisl@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
References: <20230809100754.3094517-1-shikemeng@huaweicloud.com>
 <20230809100754.3094517-3-shikemeng@huaweicloud.com>
 <ZNu6D+1y3agQRZgr@google.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <29681039-7a68-609e-4d3c-0bd91ca632bd@huaweicloud.com>
Date:   Thu, 17 Aug 2023 10:43:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <ZNu6D+1y3agQRZgr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3VKdZid1k_vaUAw--.42597S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy8Cr15KFW7XrWftry7Jrb_yoW8CFW3pr
        WkXan2kF18Jw1jk397Jw4DX34Utw4rtFyDG3yY934YvF13Gr9a9FWIkr90vF18GrWkWF40
        9rs8t34rAa1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
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



on 8/16/2023 1:46 AM, Chris Li wrote:
> Hi Kemeng,
> 
> Since I am discussing the other patch in this series, I might just commend on this one
> as well.
> 
> On Wed, Aug 09, 2023 at 06:07:54PM +0800, Kemeng Shi wrote:
>> We get batch from pcp and just pass it to nr_pcp_free immediately. Get
>> batch from pcp inside nr_pcp_free to remove unnecessary parameter batch.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  mm/page_alloc.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 1ddcb2707d05..bb1d14e806ad 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2376,10 +2376,10 @@ static bool free_unref_page_prepare(struct page *page, unsigned long pfn,
>>  	return true;
>>  }
>>  
>> -static int nr_pcp_free(struct per_cpu_pages *pcp, int high, int batch,
>> -		       bool free_high)
>> +static int nr_pcp_free(struct per_cpu_pages *pcp, int high, bool free_high)
>>  {
>>  	int min_nr_free, max_nr_free;
>> +	int batch = READ_ONCE(pcp->batch);
> 
> Because nr_pcp_free is static and has only one caller. This function gets inlined
> at the caller's side. I verified that on X86_64 compiled code.
> 
> So this fix in my opinion is not worthwhile to fix. It will produce the same
> machine code. One minor side effect is that it will hide the commit under it
> in "git blame".
> 
Hi Chris, thank for the reply. Except to reduce argument to pass, this patch also
tries make code look little cleaner. I think it's always better to reduce variable
scope and keep relevant code tight. In this case, we know batch is from
per_cpu_pages during reading nr_pcp_free alone rather than search caller to find it
out. And more callers of nr_pcp_free in fulture is free from pass pcp->batch. And so
on. Anyway, this patch definely gains a little without lost in my opinion.:) With it
makes sense to you.

> Chris
> 

