Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FCE7CEFE9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjJSGLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjJSGL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:11:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1601BE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697695882; x=1729231882;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rQtYgeSku38Ko0AKqUIbk92pm06Ktjoia6y4d/RVils=;
  b=KSppK7c5xDk/funj1TPWO6A3/OMYqaMxYZ5wvpSx2bDbkiWBdaWbYAA+
   IFm8bj9e2YCOJ+gdqt6BnSrPlf5hMRBWoh6ERaddsKeiRlKzaj5gpheCL
   Tc1bVvzLWSkS8sUCPAVN+9Qbw+IU4NmEgp7t4sBTFUhabGdO/P0aDLgFd
   R5LQ0zRVjGSB9qXZCafU0CvtnUr9Q8sIAYOgJqDJYhsWT528PAcJQLnAw
   rK/mdTDsuvqqYD3k0eSIb+gBhnU8VQ6YEuhC4bOHSG57Yo6EPaT4nhtzD
   vsnuoEBTZGbxl4QL8X9oxKmGGsXu8dsnX0WhwRWXyDbbwvQm8MmvSvBQY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="365531609"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="365531609"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 23:11:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4844576"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 23:11:22 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <hughd@google.com>, <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Fengwei Yin <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
In-Reply-To: <1F80D8DA-8BB5-4C7E-BC2F-030BF52931F7@nvidia.com> (Zi Yan's
        message of "Wed, 18 Oct 2023 10:00:52 -0400")
References: <64899ad0bb78cde88b52abed1a5a5abbc9919998.1697632761.git.baolin.wang@linux.alibaba.com>
        <1F80D8DA-8BB5-4C7E-BC2F-030BF52931F7@nvidia.com>
Date:   Thu, 19 Oct 2023 14:09:18 +0800
Message-ID: <87il73uos1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 18 Oct 2023, at 9:04, Baolin Wang wrote:
>
>> When doing compaction, I found the lru_add_drain() is an obvious hotspot
>> when migrating pages. The distribution of this hotspot is as follows:
>>    - 18.75% compact_zone
>>       - 17.39% migrate_pages
>>          - 13.79% migrate_pages_batch
>>             - 11.66% migrate_folio_move
>>                - 7.02% lru_add_drain
>>                   + 7.02% lru_add_drain_cpu
>>                + 3.00% move_to_new_folio
>>                  1.23% rmap_walk
>>             + 1.92% migrate_folio_unmap
>>          + 3.20% migrate_pages_sync
>>       + 0.90% isolate_migratepages
>>
>> The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
>> __unmap_and_move() push good newpage to LRU") to drain the newpage to LRU
>> immediately, to help to build up the correct newpage->mlock_count in
>> remove_migration_ptes() for mlocked pages. However, if there are no mlocked
>> pages are migrating, then we can avoid this lru drain operation, especailly
>> for the heavy concurrent scenarios.
>
> lru_add_drain() is also used to drain pages out of folio_batch. Pages in folio_batch
> have an additional pin to prevent migration. See folio_get(folio); in folio_add_lru().

lru_add_drain() is called after the page reference count checking in
move_to_new_folio().  So, I don't this is an issue.

>>
>> So we can record the source pages' mlocked status in migrate_folio_unmap(),
>> and only drain the lru list when the mlocked status is set in migrate_folio_move().
>> In addition, the page was already isolated from lru when migrating, so we
>> check the mlocked status is stable by folio_test_mlocked() in migrate_folio_unmap().
>>
>> After this patch, I can see the hotpot of the lru_add_drain() is gone:
>>    - 9.41% migrate_pages_batch
>>       - 6.15% migrate_folio_move
>>          - 3.64% move_to_new_folio
>>             + 1.80% migrate_folio_extra
>>             + 1.70% buffer_migrate_folio
>>          + 1.41% rmap_walk
>>          + 0.62% folio_add_lru
>>       + 3.07% migrate_folio_unmap
>>
>> Meanwhile, the compaction latency shows some improvements when running
>> thpscale:
>>                             base                   patched
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
>>  mm/migrate.c | 50 ++++++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 38 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 4caf405b6504..32c96f89710f 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1027,22 +1027,32 @@ union migration_ptr {
>>  	struct anon_vma *anon_vma;
>>  	struct address_space *mapping;
>>  };
>> +
>> +enum {
>> +	PAGE_WAS_MAPPED = 1 << 0,
>> +	PAGE_WAS_MLOCKED = 1 << 1,
>> +};
>> +
>>  static void __migrate_folio_record(struct folio *dst,
>> -				   unsigned long page_was_mapped,
>> +				   unsigned long page_flags,
>>  				   struct anon_vma *anon_vma)
>>  {
>>  	union migration_ptr ptr = { .anon_vma = anon_vma };
>>  	dst->mapping = ptr.mapping;
>> -	dst->private = (void *)page_was_mapped;
>> +	dst->private = (void *)page_flags;
>>  }
>>
>>  static void __migrate_folio_extract(struct folio *dst,
>>  				   int *page_was_mappedp,
>> +				   int *page_was_mlocked,
>>  				   struct anon_vma **anon_vmap)
>>  {
>>  	union migration_ptr ptr = { .mapping = dst->mapping };
>> +	unsigned long page_flags = (unsigned long)dst->private;
>> +
>>  	*anon_vmap = ptr.anon_vma;
>> -	*page_was_mappedp = (unsigned long)dst->private;
>> +	*page_was_mappedp = page_flags & PAGE_WAS_MAPPED ? 1 : 0;
>> +	*page_was_mlocked = page_flags & PAGE_WAS_MLOCKED ? 1 : 0;
>>  	dst->mapping = NULL;
>>  	dst->private = NULL;
>>  }
>> @@ -1103,7 +1113,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>  {
>>  	struct folio *dst;
>>  	int rc = -EAGAIN;
>> -	int page_was_mapped = 0;
>> +	int page_was_mapped = 0, page_was_mlocked = 0;
>>  	struct anon_vma *anon_vma = NULL;
>>  	bool is_lru = !__folio_test_movable(src);
>>  	bool locked = false;
>> @@ -1157,6 +1167,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>  		folio_lock(src);
>>  	}
>>  	locked = true;
>> +	page_was_mlocked = folio_test_mlocked(src);
>>
>>  	if (folio_test_writeback(src)) {
>>  		/*
>> @@ -1206,7 +1217,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>  	dst_locked = true;
>>
>>  	if (unlikely(!is_lru)) {
>> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>> +		__migrate_folio_record(dst, 0, anon_vma);
>>  		return MIGRATEPAGE_UNMAP;
>>  	}
>>
>> @@ -1236,7 +1247,13 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>  	}
>>
>>  	if (!folio_mapped(src)) {
>> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>> +		unsigned int page_flags = 0;
>> +
>> +		if (page_was_mapped)
>> +			page_flags |= PAGE_WAS_MAPPED;
>> +		if (page_was_mlocked)
>> +			page_flags |= PAGE_WAS_MLOCKED;
>> +		__migrate_folio_record(dst, page_flags, anon_vma);
>>  		return MIGRATEPAGE_UNMAP;
>>  	}
>>
>> @@ -1261,12 +1278,13 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>>  			      struct list_head *ret)
>>  {
>>  	int rc;
>> -	int page_was_mapped = 0;
>> +	int page_was_mapped = 0, page_was_mlocked = 0;
>>  	struct anon_vma *anon_vma = NULL;
>>  	bool is_lru = !__folio_test_movable(src);
>>  	struct list_head *prev;
>>
>> -	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>> +	__migrate_folio_extract(dst, &page_was_mapped,
>> +				&page_was_mlocked, &anon_vma);
>
> It is better to read out the flag, then check page_was_mapped and page_was_mlocked
> to avoid future __migrate_folio_extract() interface churns.

IHMO, in contrast, it's better to use separate flags in
__migrate_folio_record() too to avoid to pack flags in each call site.

>>  	prev = dst->lru.prev;
>>  	list_del(&dst->lru);
>>
>> @@ -1287,7 +1305,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>>  	 * isolated from the unevictable LRU: but this case is the easiest.
>>  	 */
>>  	folio_add_lru(dst);
>> -	if (page_was_mapped)
>> +	if (page_was_mlocked)
>>  		lru_add_drain();
>
> Like I said at the top, this would be if (page_was_mapped || page_was_mlocked).
>
>>
>>  	if (page_was_mapped)
>> @@ -1321,8 +1339,15 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>>  	 * right list unless we want to retry.
>>  	 */
>>  	if (rc == -EAGAIN) {
>> +		unsigned int page_flags = 0;
>> +
>> +		if (page_was_mapped)
>> +			page_flags |= PAGE_WAS_MAPPED;
>> +		if (page_was_mlocked)
>> +			page_flags |= PAGE_WAS_MLOCKED;
>> +
>>  		list_add(&dst->lru, prev);
>> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>> +		__migrate_folio_record(dst, page_flags, anon_vma);
>>  		return rc;
>>  	}
>>
>> @@ -1799,10 +1824,11 @@ static int migrate_pages_batch(struct list_head *from,
>>  	dst = list_first_entry(&dst_folios, struct folio, lru);
>>  	dst2 = list_next_entry(dst, lru);
>>  	list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
>> -		int page_was_mapped = 0;
>> +		int page_was_mapped = 0, page_was_mlocked = 0;
>>  		struct anon_vma *anon_vma = NULL;
>>
>> -		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>> +		__migrate_folio_extract(dst, &page_was_mapped,
>> +					&page_was_mlocked, &anon_vma);
>>  		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
>>  				       true, ret_folios);
>>  		list_del(&dst->lru);
>> -- 
>> 2.39.3

--
Best Regards,
Huang, Ying
