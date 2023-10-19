Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527137CF12A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjJSHZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSHZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:25:35 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890C6124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:25:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VuT9hAc_1697700327;
Received: from 30.97.48.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VuT9hAc_1697700327)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 15:25:28 +0800
Message-ID: <2ad721be-b81e-d279-0055-f995a8cfe180@linux.alibaba.com>
Date:   Thu, 19 Oct 2023 15:25:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
To:     "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        hughd@google.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Fengwei Yin <fengwei.yin@intel.com>
References: <64899ad0bb78cde88b52abed1a5a5abbc9919998.1697632761.git.baolin.wang@linux.alibaba.com>
 <1F80D8DA-8BB5-4C7E-BC2F-030BF52931F7@nvidia.com>
 <87il73uos1.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87il73uos1.fsf@yhuang6-desk2.ccr.corp.intel.com>
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



On 10/19/2023 2:09 PM, Huang, Ying wrote:
> Zi Yan <ziy@nvidia.com> writes:
> 
>> On 18 Oct 2023, at 9:04, Baolin Wang wrote:
>>
>>> When doing compaction, I found the lru_add_drain() is an obvious hotspot
>>> when migrating pages. The distribution of this hotspot is as follows:
>>>     - 18.75% compact_zone
>>>        - 17.39% migrate_pages
>>>           - 13.79% migrate_pages_batch
>>>              - 11.66% migrate_folio_move
>>>                 - 7.02% lru_add_drain
>>>                    + 7.02% lru_add_drain_cpu
>>>                 + 3.00% move_to_new_folio
>>>                   1.23% rmap_walk
>>>              + 1.92% migrate_folio_unmap
>>>           + 3.20% migrate_pages_sync
>>>        + 0.90% isolate_migratepages
>>>
>>> The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
>>> __unmap_and_move() push good newpage to LRU") to drain the newpage to LRU
>>> immediately, to help to build up the correct newpage->mlock_count in
>>> remove_migration_ptes() for mlocked pages. However, if there are no mlocked
>>> pages are migrating, then we can avoid this lru drain operation, especailly
>>> for the heavy concurrent scenarios.
>>
>> lru_add_drain() is also used to drain pages out of folio_batch. Pages in folio_batch
>> have an additional pin to prevent migration. See folio_get(folio); in folio_add_lru().
> 
> lru_add_drain() is called after the page reference count checking in
> move_to_new_folio().  So, I don't this is an issue.

Agree. The purpose of adding lru_add_drain() is to address the 
'mlock_count' issue for mlocked pages. Please see commit c3096e6782b7 
and related comments. Moreover I haven't seen an increase in the number 
of page migration failures due to page reference count checking after 
this patch.

>>> So we can record the source pages' mlocked status in migrate_folio_unmap(),
>>> and only drain the lru list when the mlocked status is set in migrate_folio_move().
>>> In addition, the page was already isolated from lru when migrating, so we
>>> check the mlocked status is stable by folio_test_mlocked() in migrate_folio_unmap().
>>>
>>> After this patch, I can see the hotpot of the lru_add_drain() is gone:
>>>     - 9.41% migrate_pages_batch
>>>        - 6.15% migrate_folio_move
>>>           - 3.64% move_to_new_folio
>>>              + 1.80% migrate_folio_extra
>>>              + 1.70% buffer_migrate_folio
>>>           + 1.41% rmap_walk
>>>           + 0.62% folio_add_lru
>>>        + 3.07% migrate_folio_unmap
>>>
>>> Meanwhile, the compaction latency shows some improvements when running
>>> thpscale:
>>>                              base                   patched
>>> Amean     fault-both-1      1131.22 (   0.00%)     1112.55 *   1.65%*
>>> Amean     fault-both-3      2489.75 (   0.00%)     2324.15 *   6.65%*
>>> Amean     fault-both-5      3257.37 (   0.00%)     3183.18 *   2.28%*
>>> Amean     fault-both-7      4257.99 (   0.00%)     4079.04 *   4.20%*
>>> Amean     fault-both-12     6614.02 (   0.00%)     6075.60 *   8.14%*
>>> Amean     fault-both-18    10607.78 (   0.00%)     8978.86 *  15.36%*
>>> Amean     fault-both-24    14911.65 (   0.00%)    11619.55 *  22.08%*
>>> Amean     fault-both-30    14954.67 (   0.00%)    14925.66 *   0.19%*
>>> Amean     fault-both-32    16654.87 (   0.00%)    15580.31 *   6.45%*
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>   mm/migrate.c | 50 ++++++++++++++++++++++++++++++++++++++------------
>>>   1 file changed, 38 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 4caf405b6504..32c96f89710f 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1027,22 +1027,32 @@ union migration_ptr {
>>>   	struct anon_vma *anon_vma;
>>>   	struct address_space *mapping;
>>>   };
>>> +
>>> +enum {
>>> +	PAGE_WAS_MAPPED = 1 << 0,
>>> +	PAGE_WAS_MLOCKED = 1 << 1,
>>> +};
>>> +
>>>   static void __migrate_folio_record(struct folio *dst,
>>> -				   unsigned long page_was_mapped,
>>> +				   unsigned long page_flags,
>>>   				   struct anon_vma *anon_vma)
>>>   {
>>>   	union migration_ptr ptr = { .anon_vma = anon_vma };
>>>   	dst->mapping = ptr.mapping;
>>> -	dst->private = (void *)page_was_mapped;
>>> +	dst->private = (void *)page_flags;
>>>   }
>>>
>>>   static void __migrate_folio_extract(struct folio *dst,
>>>   				   int *page_was_mappedp,
>>> +				   int *page_was_mlocked,
>>>   				   struct anon_vma **anon_vmap)
>>>   {
>>>   	union migration_ptr ptr = { .mapping = dst->mapping };
>>> +	unsigned long page_flags = (unsigned long)dst->private;
>>> +
>>>   	*anon_vmap = ptr.anon_vma;
>>> -	*page_was_mappedp = (unsigned long)dst->private;
>>> +	*page_was_mappedp = page_flags & PAGE_WAS_MAPPED ? 1 : 0;
>>> +	*page_was_mlocked = page_flags & PAGE_WAS_MLOCKED ? 1 : 0;
>>>   	dst->mapping = NULL;
>>>   	dst->private = NULL;
>>>   }
>>> @@ -1103,7 +1113,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>   {
>>>   	struct folio *dst;
>>>   	int rc = -EAGAIN;
>>> -	int page_was_mapped = 0;
>>> +	int page_was_mapped = 0, page_was_mlocked = 0;
>>>   	struct anon_vma *anon_vma = NULL;
>>>   	bool is_lru = !__folio_test_movable(src);
>>>   	bool locked = false;
>>> @@ -1157,6 +1167,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>   		folio_lock(src);
>>>   	}
>>>   	locked = true;
>>> +	page_was_mlocked = folio_test_mlocked(src);
>>>
>>>   	if (folio_test_writeback(src)) {
>>>   		/*
>>> @@ -1206,7 +1217,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>   	dst_locked = true;
>>>
>>>   	if (unlikely(!is_lru)) {
>>> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>>> +		__migrate_folio_record(dst, 0, anon_vma);
>>>   		return MIGRATEPAGE_UNMAP;
>>>   	}
>>>
>>> @@ -1236,7 +1247,13 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>   	}
>>>
>>>   	if (!folio_mapped(src)) {
>>> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>>> +		unsigned int page_flags = 0;
>>> +
>>> +		if (page_was_mapped)
>>> +			page_flags |= PAGE_WAS_MAPPED;
>>> +		if (page_was_mlocked)
>>> +			page_flags |= PAGE_WAS_MLOCKED;
>>> +		__migrate_folio_record(dst, page_flags, anon_vma);
>>>   		return MIGRATEPAGE_UNMAP;
>>>   	}
>>>
>>> @@ -1261,12 +1278,13 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>>>   			      struct list_head *ret)
>>>   {
>>>   	int rc;
>>> -	int page_was_mapped = 0;
>>> +	int page_was_mapped = 0, page_was_mlocked = 0;
>>>   	struct anon_vma *anon_vma = NULL;
>>>   	bool is_lru = !__folio_test_movable(src);
>>>   	struct list_head *prev;
>>>
>>> -	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>>> +	__migrate_folio_extract(dst, &page_was_mapped,
>>> +				&page_was_mlocked, &anon_vma);
>>
>> It is better to read out the flag, then check page_was_mapped and page_was_mlocked
>> to avoid future __migrate_folio_extract() interface churns.
> 
> IHMO, in contrast, it's better to use separate flags in
> __migrate_folio_record() too to avoid to pack flags in each call site.

Either way is okay for me. And avoiding to pack flags in each call site 
seems more reasonable to me.

> 
>>>   	prev = dst->lru.prev;
>>>   	list_del(&dst->lru);
>>>
>>> @@ -1287,7 +1305,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>>>   	 * isolated from the unevictable LRU: but this case is the easiest.
>>>   	 */
>>>   	folio_add_lru(dst);
>>> -	if (page_was_mapped)
>>> +	if (page_was_mlocked)
>>>   		lru_add_drain();
>>
>> Like I said at the top, this would be if (page_was_mapped || page_was_mlocked).

I don't think so. Like I said above, we can drain lru list only if page 
was mlocked.

>>>   	if (page_was_mapped)
>>> @@ -1321,8 +1339,15 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>>>   	 * right list unless we want to retry.
>>>   	 */
>>>   	if (rc == -EAGAIN) {
>>> +		unsigned int page_flags = 0;
>>> +
>>> +		if (page_was_mapped)
>>> +			page_flags |= PAGE_WAS_MAPPED;
>>> +		if (page_was_mlocked)
>>> +			page_flags |= PAGE_WAS_MLOCKED;
>>> +
>>>   		list_add(&dst->lru, prev);
>>> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>>> +		__migrate_folio_record(dst, page_flags, anon_vma);
>>>   		return rc;
>>>   	}
>>>
>>> @@ -1799,10 +1824,11 @@ static int migrate_pages_batch(struct list_head *from,
>>>   	dst = list_first_entry(&dst_folios, struct folio, lru);
>>>   	dst2 = list_next_entry(dst, lru);
>>>   	list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
>>> -		int page_was_mapped = 0;
>>> +		int page_was_mapped = 0, page_was_mlocked = 0;
>>>   		struct anon_vma *anon_vma = NULL;
>>>
>>> -		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>>> +		__migrate_folio_extract(dst, &page_was_mapped,
>>> +					&page_was_mlocked, &anon_vma);
>>>   		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
>>>   				       true, ret_folios);
>>>   		list_del(&dst->lru);
>>> -- 
>>> 2.39.3
> 
> --
> Best Regards,
> Huang, Ying
