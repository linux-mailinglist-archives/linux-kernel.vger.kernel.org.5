Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D29A7D1AA2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 05:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjJUDbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 23:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUDbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 23:31:12 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174AD76
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 20:31:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VuYXo-8_1697859064;
Received: from 192.168.43.40(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VuYXo-8_1697859064)
          by smtp.aliyun-inc.com;
          Sat, 21 Oct 2023 11:31:06 +0800
Message-ID: <5f6fc244-4e48-2118-4e8c-fcd00a0943ec@linux.alibaba.com>
Date:   Sat, 21 Oct 2023 11:31:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, ying.huang@intel.com, ziy@nvidia.com,
        fengwei.yin@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <c960df0db27ae55b9e9babdcfe842e75fb44ccbc.1697703785.git.baolin.wang@linux.alibaba.com>
 <163ce2c0-9c8a-3db3-26a7-4d115fb95802@google.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <163ce2c0-9c8a-3db3-26a7-4d115fb95802@google.com>
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



On 10/20/2023 12:48 PM, Hugh Dickins wrote:
> On Fri, 20 Oct 2023, Baolin Wang wrote:
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
> 
> Seems a sensible change with good results (I'll conceal how little of
> the stats I understand, I expect everyone else understands them: in my
> naivety, I'm mainly curious why rmap_walk's 1.23% didn't get a + on it).

TBH, I also don't know why the rmap_walk didn't get a + on it, let me 
check it again.

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
>> +	PAGE_WAS_MLOCKED = 1 << 1,
>> +};
>> +
> 
> I was whispering to myself "I bet someone will suggest BIT()";
> and indeed that someone has turned out to be Huang, Ying.

Sure.

> 
>>   static void __migrate_folio_record(struct folio *dst,
>> -				   unsigned long page_was_mapped,
>> +				   unsigned int page_was_mapped,
>> +				   unsigned int page_was_mlocked,
>>   				   struct anon_vma *anon_vma)
>>   {
>>   	union migration_ptr ptr = { .anon_vma = anon_vma };
>> +	unsigned long page_flags = 0;
> 
> Huang, Ying preferred a different name, me too: old_page_state?

OK, sounds better to me.

> 
>> +
>> +	if (page_was_mapped)
>> +		page_flags |= PAGE_WAS_MAPPED;
>> +	if (page_was_mlocked)
>> +		page_flags |= PAGE_WAS_MLOCKED;
> 
> What's annoying me about the patch is all this mix of page_was_mapped and
> page_was_mlocked variables, then the old_page_state bits.  Can't it be
> done with PAGE_WAS_ bits in old_page_state throughout, without any
> page_was_mapped and page_was_mlocked variables?

Yes, good point. Let me try it. Thanks for your comments.
