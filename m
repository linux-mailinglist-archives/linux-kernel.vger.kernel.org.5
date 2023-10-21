Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3357D1A9E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 05:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjJUDZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 23:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUDZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 23:25:54 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D575D76
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 20:25:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VuYY98S_1697858742;
Received: from 192.168.43.40(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VuYY98S_1697858742)
          by smtp.aliyun-inc.com;
          Sat, 21 Oct 2023 11:25:43 +0800
Message-ID: <ff4224eb-262e-3eea-ec39-e5717929b038@linux.alibaba.com>
Date:   Sat, 21 Oct 2023 11:25:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        hughd@google.com, vbabka@suse.cz, ziy@nvidia.com,
        fengwei.yin@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <c960df0db27ae55b9e9babdcfe842e75fb44ccbc.1697703785.git.baolin.wang@linux.alibaba.com>
 <87jzriez8h.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87jzriez8h.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 11:42 AM, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> When doing compaction, I found the lru_add_drain() is an obvious hotspot
>> when migrating pages. The distribution of this hotspot is as follows:
>>     - 18.75% compact_zone
>>        - 17.39% migrate_pages
>>           - 13.79% migrate_pages_batch
>>              - 11.66% migrate_folio_move
>>                 - 7.02% lru_add_drain
>>                    + 7.02% lru_add_drain_cpu
>>                 + 3.00% move_to_new_folio
>>                   1.23% rmap_walk
>>              + 1.92% migrate_folio_unmap
>>           + 3.20% migrate_pages_sync
>>        + 0.90% isolate_migratepages
>>
>> The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
>> __unmap_and_move() push good newpage to LRU") to drain the newpage to LRU
>> immediately, to help to build up the correct newpage->mlock_count in
>> remove_migration_ptes() for mlocked pages. However, if there are no mlocked
>> pages are migrating, then we can avoid this lru drain operation, especailly
>> for the heavy concurrent scenarios.
>>
>> So we can record the source pages' mlocked status in migrate_folio_unmap(),
>> and only drain the lru list when the mlocked status is set in migrate_folio_move().
>> In addition, the page was already isolated from lru when migrating, so checking
>> the mlocked status is stable by folio_test_mlocked() in migrate_folio_unmap().
>>
>> After this patch, I can see the hotpot of the lru_add_drain() is gone:
>>     - 9.41% migrate_pages_batch
>>        - 6.15% migrate_folio_move
>>           - 3.64% move_to_new_folio
>>              + 1.80% migrate_folio_extra
>>              + 1.70% buffer_migrate_folio
>>           + 1.41% rmap_walk
>>           + 0.62% folio_add_lru
>>        + 3.07% migrate_folio_unmap
>>
>> Meanwhile, the compaction latency shows some improvements when running
>> thpscale:
>>                              base                   patched
>> Amean     fault-both-1      1131.22 (   0.00%)     1112.55 *   1.65%*
>> Amean     fault-both-3      2489.75 (   0.00%)     2324.15 *   6.65%*
>> Amean     fault-both-5      3257.37 (   0.00%)     3183.18 *   2.28%*
>> Amean     fault-both-7      4257.99 (   0.00%)     4079.04 *   4.20%*
>> Amean     fault-both-12     6614.02 (   0.00%)     6075.60 *   8.14%*
>> Amean     fault-both-18    10607.78 (   0.00%)     8978.86 *  15.36%*
>> Amean     fault-both-24    14911.65 (   0.00%)    11619.55 *  22.08%*
>> Amean     fault-both-30    14954.67 (   0.00%)    14925.66 *   0.19%*
>> Amean     fault-both-32    16654.87 (   0.00%)    15580.31 *   6.45%*
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>> Chages from v1:
>>   - Use separate flags in __migrate_folio_record() to avoid to pack flags
>> in each call site per Ying.
>> ---
>>   mm/migrate.c | 47 +++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 35 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 125194f5af0f..fac96139dbba 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1027,22 +1027,39 @@ union migration_ptr {
>>   	struct anon_vma *anon_vma;
>>   	struct address_space *mapping;
>>   };
>> +
>> +enum {
>> +	PAGE_WAS_MAPPED = 1 << 0,
> 
> PAGE_WAS_MAPPED = BIT(0) ?

Sure, will do.

> 
>> +	PAGE_WAS_MLOCKED = 1 << 1,
>> +};
>> +
>>   static void __migrate_folio_record(struct folio *dst,
>> -				   unsigned long page_was_mapped,
>> +				   unsigned int page_was_mapped,
>> +				   unsigned int page_was_mlocked,
>>   				   struct anon_vma *anon_vma)
>>   {
>>   	union migration_ptr ptr = { .anon_vma = anon_vma };
>> +	unsigned long page_flags = 0;
> 
> page_flags wasn't a good name, it can be confused with page->flags.

Agree.

> May be something like "page_attrs"?

OK, I prefer to the 'old_page_state' suggested by Hugh :)

>> +
>> +	if (page_was_mapped)
>> +		page_flags |= PAGE_WAS_MAPPED;
>> +	if (page_was_mlocked)
>> +		page_flags |= PAGE_WAS_MLOCKED;
>>   	dst->mapping = ptr.mapping;
>> -	dst->private = (void *)page_was_mapped;
>> +	dst->private = (void *)page_flags;
>>   }
>>   
>>   static void __migrate_folio_extract(struct folio *dst,
>>   				   int *page_was_mappedp,
>> +				   int *page_was_mlocked,
> 
> Better to use the same naming convention.  Either both have "p" suffix,
> or both not.

OK.

> 
> Otherwise looks good to me.

Thanks for reviewing.
