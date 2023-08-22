Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10127837E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjHVCZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjHVCY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:24:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C6D180
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692671095; x=1724207095;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=UfbeD6FiU7aBNKvy5b/Ik04w1hbvhD6JT1uDE9UYhuI=;
  b=M41C6O65w/6zzToKiDtI9+7FRUdDRI1La3faNaL70ScVUT28T0DpLVuU
   1ynPqfcNBmGBmLzXo6YywlQgqOEUGyBjPwCFb5/xu0uOR04b+Qt6WsByi
   /Y6dGj2xo3zrMQFjGvOtcC8Xw0Jsi5R6MLaWzLvO3HqfPpyQuWIARTDyO
   pITXd/asl22mFB2jmt8HuilrGoJqtQaNjKg1kR6XBZ8nOKExlJFyTlMhz
   64ECJyXo9UbeXsHqTkwsH/fE6hQYAOMTgO72yWzAOGZ2LvPJhpu350F7w
   5ZpKGvRETYU0o4m7IqB9oVOGeNdG8YPcv4lh/uFkn+3SaaDF9tKk2a7ZX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="354086241"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="354086241"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 19:24:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859714072"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="859714072"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 19:24:52 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>
Subject: Re: [PATCH v2 2/8] mm: migrate: remove THP mapcount check in
 numamigrate_isolate_page()
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
        <20230821115624.158759-3-wangkefeng.wang@huawei.com>
Date:   Tue, 22 Aug 2023 10:22:46 +0800
In-Reply-To: <20230821115624.158759-3-wangkefeng.wang@huawei.com> (Kefeng
        Wang's message of "Mon, 21 Aug 2023 19:56:18 +0800")
Message-ID: <87ttsrbytl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

Kefeng Wang <wangkefeng.wang@huawei.com> writes:

> The check of THP mapped by multiple processes was introduced by commit
> 04fa5d6a6547 ("mm: migrate: check page_count of THP before migrating")
> and refactor by commit 340ef3902cf2 ("mm: numa: cleanup flow of transhuge
> page migration"), which is out of date, since migrate_misplaced_page()
> is now using the standard migrate_pages() for small pages and THPs, the
> reference count checking is in folio_migrate_mapping(), so let's remove
> the special check for THP.
>
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/migrate.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 646d8ee7f102..f2d86dfd8423 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2483,10 +2483,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  	int nr_pages = thp_nr_pages(page);
>  	int order = compound_order(page);
>  
> -	/* Do not migrate THP mapped by multiple processes */
> -	if (PageTransHuge(page) && total_mapcount(page) > 1)
> -		return 0;
> -
>  	/* Avoid migrating to a node that is nearly full */
>  	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
>  		int z;
