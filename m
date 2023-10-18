Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16E47CD1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344280AbjJRB3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJRB3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:29:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8659890
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697592585; x=1729128585;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=JeZ5du+/IDSiEG8X9Aw/xnmtEi44zSfNXT00j2yIjG0=;
  b=iHF/bDjPEMr+RuusI87PihaUpHuA3cGLJKbFlhCYvSK1yWHzMWvWM7ZB
   /THuOmYurJJKMiQKoyIR4mXYd1zwfwG9ccyErkYNwBWsAdZ0YgLDhEI76
   5PNQfwcGy+GdE8Fafzg7OKCP4ajhcsKIy8vlH3VIVgDtJzXQMkef72mJH
   ScKIRorCtIMbVMuqS6DRa07qYC1Za8ixPfuAbEkMSbgG5wGk0RWJ8KtrO
   8ateiCvuUWniRhTy1FJ8HqGaDmjbvembIMHQEQLLAIzvwD5T+DYSZRz/A
   cvV8vcnSKxbQKtE5+yMfl6gansXVTpuffngMh2Jmxfp7HlLDXS6NTXRU1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="383136881"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="383136881"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 18:29:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1003568528"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="1003568528"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 18:29:42 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <zi.yan@sent.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v3 1/2] mm/migrate: correct nr_failed in
 migrate_pages_sync()
In-Reply-To: <20231017163129.2025214-1-zi.yan@sent.com> (Zi Yan's message of
        "Tue, 17 Oct 2023 12:31:28 -0400")
References: <20231017163129.2025214-1-zi.yan@sent.com>
Date:   Wed, 18 Oct 2023 09:27:41 +0800
Message-ID: <878r8090tu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>

LGTM except a trivial issue below, not a big deal.  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/migrate.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c602bf6dec97..fc2e70b17704 100644
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
>  					int ret = try_split_folio(folio, split_folios);
>  
>  					if (!ret) {
>  						stats->nr_thp_split += is_thp;
> +						stats->nr_split += is_large;

We have tested is_large above, so, "++" is enough here.  Not a big deal,
only change it if you think it's necessary.

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
> @@ -1834,7 +1840,11 @@ static int migrate_pages_sync(struct list_head *from, new_folio_t get_new_folio,
>  		return rc;
>  	}
>  	stats->nr_thp_failed += astats.nr_thp_split;
> -	nr_failed += astats.nr_thp_split;
> +	/*
> +	 * Do not count rc, as pages will be retried below.
> +	 * Count nr_split only, since it includes nr_thp_split.
> +	 */
> +	nr_failed += astats.nr_split;
>  	/*
>  	 * Fall back to migrate all failed folios one by one synchronously. All
>  	 * failed folios except split THPs will be retried, so their failure

--
Best Regards,
Huang, Ying
