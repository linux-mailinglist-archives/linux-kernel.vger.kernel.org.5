Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58E27CB9DF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjJQE6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQE6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:58:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ECCA2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 21:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697518716; x=1729054716;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dHD8WBxQWQjMRDgXMWFGWJqNZ500csN6h+LPai/u7+M=;
  b=VZCCfRFwKJOicapfHZ80G1OIamPneQV1s0kEmbBjQ/x3LgBLcNje8Y7h
   mGu2Gb7JEZDH6VPuSR7ujkkwp2c7Mzq20CsLGQz25oPafRCgvZUyWl8U1
   Klng476layvj9NO+uSsLo3Qi6nJHVYEkmQT2jFD4S+3mwpmcARj6zVGkE
   j1ZHEiw0zfqgEmdTw6XyYW5MPNLw++8cyObNb432xowW+tpLUeFVQa9tO
   xkJBD0K9iexCQXeaDKC4MNKXLG46D4rUox7b3BoCc7VqfAuHX+UH3zPAL
   cQCQGajc85VcefVxiqfSe8CpHBGCbnEAOe2oH228NcuhXhUb5fMrsdv0S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="416773784"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="416773784"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 21:58:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="821825348"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="821825348"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 21:58:33 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <zi.yan@sent.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v2] mm/migrate: correct nr_failed in migrate_pages_sync()
In-Reply-To: <20231016154156.1948815-1-zi.yan@sent.com> (Zi Yan's message of
        "Mon, 16 Oct 2023 11:41:56 -0400")
References: <20231016154156.1948815-1-zi.yan@sent.com>
Date:   Tue, 17 Oct 2023 12:56:12 +0800
Message-ID: <871qdtdez7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <zi.yan@sent.com> writes:

> From: Zi Yan <ziy@nvidia.com>
>
> nr_failed was missing the large folio splits from migrate_pages_batch()
> and can cause a mismatch between migrate_pages() return value and the
> number of not migrated pages, i.e., when the return value of
> migrate_pages() is 0, there are still pages left in the from page list.
> It will happen when a non-PMD THP large folio fails to migrate due to
> -ENOMEM and is split successfully but not all the split pages are not
> migrated, migrate_pages_batch() would return non-zero, but
> astats.nr_thp_split = 0. nr_failed would be 0 and returned to the caller
> of migrate_pages(), but the not migrated pages are left in the from page
> list without being added back to LRU lists.
>
> Fix it by adding a new nr_split counter for large folio splits and adding
> it to nr_failed in migrate_page_sync() after migrate_pages_batch() is
> done.
>
> Fixes: 2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronously firstly")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/trace/events/migrate.h | 24 ++++++++++++++----------
>  mm/migrate.c                   | 15 +++++++++++----
>  2 files changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index 061b5128f335..0190ef725b43 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -49,10 +49,11 @@ TRACE_EVENT(mm_migrate_pages,
>  
>  	TP_PROTO(unsigned long succeeded, unsigned long failed,
>  		 unsigned long thp_succeeded, unsigned long thp_failed,
> -		 unsigned long thp_split, enum migrate_mode mode, int reason),
> +		 unsigned long thp_split, unsigned long large_folio_split,
> +		 enum migrate_mode mode, int reason),
>  
>  	TP_ARGS(succeeded, failed, thp_succeeded, thp_failed,
> -		thp_split, mode, reason),
> +		thp_split, large_folio_split, mode, reason),
>  
>  	TP_STRUCT__entry(
>  		__field(	unsigned long,		succeeded)
> @@ -60,26 +61,29 @@ TRACE_EVENT(mm_migrate_pages,
>  		__field(	unsigned long,		thp_succeeded)
>  		__field(	unsigned long,		thp_failed)
>  		__field(	unsigned long,		thp_split)
> +		__field(	unsigned long,		large_folio_split)
>  		__field(	enum migrate_mode,	mode)
>  		__field(	int,			reason)
>  	),
>  
>  	TP_fast_assign(
> -		__entry->succeeded	= succeeded;
> -		__entry->failed		= failed;
> -		__entry->thp_succeeded	= thp_succeeded;
> -		__entry->thp_failed	= thp_failed;
> -		__entry->thp_split	= thp_split;
> -		__entry->mode		= mode;
> -		__entry->reason		= reason;
> +		__entry->succeeded			= succeeded;
> +		__entry->failed				= failed;
> +		__entry->thp_succeeded		= thp_succeeded;
> +		__entry->thp_failed			= thp_failed;
> +		__entry->thp_split			= thp_split;
> +		__entry->large_folio_split	= large_folio_split;
> +		__entry->mode				= mode;
> +		__entry->reason				= reason;
>  	),
>  
> -	TP_printk("nr_succeeded=%lu nr_failed=%lu nr_thp_succeeded=%lu nr_thp_failed=%lu nr_thp_split=%lu mode=%s reason=%s",
> +	TP_printk("nr_succeeded=%lu nr_failed=%lu nr_thp_succeeded=%lu nr_thp_failed=%lu nr_thp_split=%lu nr_split=%lu mode=%s reason=%s",
>  		__entry->succeeded,
>  		__entry->failed,
>  		__entry->thp_succeeded,
>  		__entry->thp_failed,
>  		__entry->thp_split,
> +		__entry->large_folio_split,
>  		__print_symbolic(__entry->mode, MIGRATE_MODE),
>  		__print_symbolic(__entry->reason, MIGRATE_REASON))
>  );

I suggest to split trace event change in another patch.  Because this
patch will be backported to previous stable kernel.  It's more
convenient for users if we keep trace event unchanged in stable kernel.
And this isn't part of fix.

> diff --git a/mm/migrate.c b/mm/migrate.c
> index c602bf6dec97..4caf405b6504 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1495,6 +1495,7 @@ struct migrate_pages_stats {
>  	int nr_thp_succeeded;	/* THP migrated successfully */
>  	int nr_thp_failed;	/* THP failed to be migrated */
>  	int nr_thp_split;	/* THP split before migrating */
> +	int nr_split;	/* Large folio (include THP) split before migrating */
>  };
>  
>  /*
> @@ -1614,6 +1615,7 @@ static int migrate_pages_batch(struct list_head *from,
>  	int nr_retry_pages = 0;
>  	int pass = 0;
>  	bool is_thp = false;
> +	bool is_large = false;
>  	struct folio *folio, *folio2, *dst = NULL, *dst2;
>  	int rc, rc_saved = 0, nr_pages;
>  	LIST_HEAD(unmap_folios);
> @@ -1629,7 +1631,8 @@ static int migrate_pages_batch(struct list_head *from,
>  		nr_retry_pages = 0;
>  
>  		list_for_each_entry_safe(folio, folio2, from, lru) {
> -			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
> +			is_large = folio_test_large(folio);
> +			is_thp = is_large && folio_test_pmd_mappable(folio);
>  			nr_pages = folio_nr_pages(folio);
>  
>  			cond_resched();
> @@ -1649,6 +1652,7 @@ static int migrate_pages_batch(struct list_head *from,
>  				stats->nr_thp_failed++;
>  				if (!try_split_folio(folio, split_folios)) {
>  					stats->nr_thp_split++;
> +					stats->nr_split++;
>  					continue;
>  				}
>  				stats->nr_failed_pages += nr_pages;
> @@ -1677,11 +1681,12 @@ static int migrate_pages_batch(struct list_head *from,
>  				nr_failed++;
>  				stats->nr_thp_failed += is_thp;
>  				/* Large folio NUMA faulting doesn't split to retry. */
> -				if (folio_test_large(folio) && !nosplit) {
> +				if (is_large && !nosplit) {

It appears that there's only one user of "is_large"?  If so, it seems
unnecessary to introduce another variable.  But this isn't a big issue.

>  					int ret = try_split_folio(folio, split_folios);
>  
>  					if (!ret) {
>  						stats->nr_thp_split += is_thp;
> +						stats->nr_split++;
>  						break;
>  					} else if (reason == MR_LONGTERM_PIN &&
>  						   ret == -EAGAIN) {
> @@ -1827,6 +1832,7 @@ static int migrate_pages_sync(struct list_head *from, new_folio_t get_new_folio,
>  	stats->nr_succeeded += astats.nr_succeeded;
>  	stats->nr_thp_succeeded += astats.nr_thp_succeeded;
>  	stats->nr_thp_split += astats.nr_thp_split;
> +	stats->nr_split += astats.nr_split;
>  	if (rc < 0) {
>  		stats->nr_failed_pages += astats.nr_failed_pages;
>  		stats->nr_thp_failed += astats.nr_thp_failed;
> @@ -1834,7 +1840,7 @@ static int migrate_pages_sync(struct list_head *from, new_folio_t get_new_folio,
>  		return rc;
>  	}
>  	stats->nr_thp_failed += astats.nr_thp_split;
> -	nr_failed += astats.nr_thp_split;
> +	nr_failed += astats.nr_split + astats.nr_thp_split;

THP splitting is counted in .nr_thp_split and .nr_split.  So we should
add .nr_split only here.

>  	/*
>  	 * Fall back to migrate all failed folios one by one synchronously. All
>  	 * failed folios except split THPs will be retried, so their failure
> @@ -1969,7 +1975,8 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
>  	count_vm_events(THP_MIGRATION_SPLIT, stats.nr_thp_split);
>  	trace_mm_migrate_pages(stats.nr_succeeded, stats.nr_failed_pages,
>  			       stats.nr_thp_succeeded, stats.nr_thp_failed,
> -			       stats.nr_thp_split, mode, reason);
> +			       stats.nr_thp_split, stats.nr_split, mode,
> +			       reason);
>  
>  	if (ret_succeeded)
>  		*ret_succeeded = stats.nr_succeeded;

--
Best Regards,
Huang, Ying
