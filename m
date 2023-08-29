Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D49478BC43
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjH2AwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjH2Avr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:51:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B652122
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693270304; x=1724806304;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=ckp+5w39kYKdx5CWCnGyq18yY6y/3olG4Ys3T3fGb0E=;
  b=kEbQWFc3EOsJvFphDVftIAxV53YcAyy/dwBMiEkKDnEiDnLqpsXz2L7s
   /FuCPIg0Gw6rvyLjzaRVE59+Yv3Z3q/rleflokab/EP33X1TDc1M2wfjp
   28TG4AH6ejTHhbnGDnaG6GVZhhdUIY6hxD3eX9AturuiPtR5A333xbFF4
   m5AKT37ft7rvoyeiP8oRn70PgvOrW0vQMY2IHaXLdSLcZWx4MU46EI+Jt
   ucqK8tx4xRuzqi4QZPG8c9MLdN/nlWCnJIRhNb3AsOtRANyrWqDUefL9k
   +a7SHyAeQm2BRJpeH5kz2Sq6KKHyizlwh0LCteEoX4u94dniyVvbMzyjE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="360248541"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="360248541"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 17:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="688308431"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="688308431"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 17:51:41 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>
Subject: Re: [PATCH v2 4/8] mm: migrate: use a folio in
 migrate_misplaced_page()
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
        <20230821115624.158759-5-wangkefeng.wang@huawei.com>
        <855536BE-766C-49B2-B358-6C0548760929@nvidia.com>
Date:   Tue, 29 Aug 2023 08:49:31 +0800
In-Reply-To: <855536BE-766C-49B2-B358-6C0548760929@nvidia.com> (Zi Yan's
        message of "Mon, 28 Aug 2023 10:10:25 -0400")
Message-ID: <875y4y65b8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 21 Aug 2023, at 7:56, Kefeng Wang wrote:
>
>> Use a folio in migrate_misplaced_page() to save compound_head() calls.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  mm/migrate.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> LGTM. And a comment below. Reveiwed-by: Zi Yan <ziy@nvidia.com>
>
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 281eafdf8e63..fc728f9a383f 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2521,17 +2521,18 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>>  			   int node)
>>  {
>>  	pg_data_t *pgdat = NODE_DATA(node);
>> +	struct folio *folio = page_folio(page);
>>  	int isolated;
>>  	int nr_remaining;
>>  	unsigned int nr_succeeded;
>>  	LIST_HEAD(migratepages);
>> -	int nr_pages = thp_nr_pages(page);
>> +	int nr_pages = folio_nr_pages(folio);
>>
>>  	/*
>>  	 * Don't migrate file pages that are mapped in multiple processes
>>  	 * with execute permissions as they are probably shared libraries.
>>  	 */
>> -	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
>> +	if (page_mapcount(page) != 1 && folio_is_file_lru(folio) &&
>
> page_mapcount() is not converted, since folio_mapcount() is not equivalent
> to page_mapcount(). It can be converted and this function can be converted
> to migrate_misplaced_folio() once we have something like folio_num_sharers().

It seems that we can use folio_estimated_sharers() here.

--
Best Regards,
Huang, Ying

>>  	    (vma->vm_flags & VM_EXEC))
>>  		goto out;
>>
>> @@ -2539,29 +2540,29 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>>  	 * Also do not migrate dirty pages as not all filesystems can move
>>  	 * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
>>  	 */
>> -	if (page_is_file_lru(page) && PageDirty(page))
>> +	if (folio_is_file_lru(folio) && folio_test_dirty(folio))
>>  		goto out;
>>
>> -	isolated = numamigrate_isolate_folio(pgdat, page_folio(page));
>> +	isolated = numamigrate_isolate_folio(pgdat, folio);
>>  	if (!isolated)
>>  		goto out;
>>
>> -	list_add(&page->lru, &migratepages);
>> +	list_add(&folio->lru, &migratepages);
>>  	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
>>  				     NULL, node, MIGRATE_ASYNC,
>>  				     MR_NUMA_MISPLACED, &nr_succeeded);
>>  	if (nr_remaining) {
>>  		if (!list_empty(&migratepages)) {
>> -			list_del(&page->lru);
>> -			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
>> -					page_is_file_lru(page), -nr_pages);
>> -			putback_lru_page(page);
>> +			list_del(&folio->lru);
>> +			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
>> +					folio_is_file_lru(folio), -nr_pages);
>> +			folio_putback_lru(folio);
>>  		}
>>  		isolated = 0;
>>  	}
>>  	if (nr_succeeded) {
>>  		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
>> -		if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
>> +		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
>>  			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
>>  					    nr_succeeded);
>>  	}
>> @@ -2569,7 +2570,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>>  	return isolated;
>>
>>  out:
>> -	put_page(page);
>> +	folio_put(folio);
>>  	return 0;
>>  }
>>  #endif /* CONFIG_NUMA_BALANCING */
>> -- 
>> 2.41.0
>
>
> --
> Best Regards,
> Yan, Zi
