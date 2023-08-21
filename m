Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE74782159
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjHUCWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjHUCWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:22:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09539C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 19:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692584533; x=1724120533;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=RohFg+AyWwBklRGlOXwUffXNwQqkzustdxDW53emd7E=;
  b=Myk2q1KthHRRbpLphslc2wUtxmgBgfv8aaZrQjxu4M7d5e7U81uZjcq8
   7G8P4FsE7dFNrkUKXA/4qqCastM8LOo+kOAax4wCaflilIeptNb+Cr1oi
   plUL+X/7pkWCOWhIlnTrVcnPeS4TNaZh/c0LBxysdFFlen1wA96Hngo19
   itQ2q+o2hvFU1wV6caeXGzmExIe8l7w2y+FDdUt8LgxG6LD6nCkUfD1wz
   hi/q6kHLE/NY2qdeF+UUG0ZzK4Wf8/5ztikdDS6ScoQ0GYzCfHaHiRiy6
   DLY+ltKGi9zaPKF8kCi/4kMQTwAcS+h0k3So5/Zps9V112t4Ydp7wc3Nm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="358452573"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="358452573"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2023 19:22:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="729240373"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="729240373"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2023 19:22:10 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <shy828301@gmail.com>, <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] mm: migrate: move migration validation into
 numa_migrate_prep()
References: <cover.1692440586.git.baolin.wang@linux.alibaba.com>
        <a37b13dd91bd3eadcd56a08cb3c839616f8457e7.1692440586.git.baolin.wang@linux.alibaba.com>
Date:   Mon, 21 Aug 2023 10:20:01 +0800
In-Reply-To: <a37b13dd91bd3eadcd56a08cb3c839616f8457e7.1692440586.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Sat, 19 Aug 2023 18:52:34 +0800")
Message-ID: <87h6otdtm6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Now there are 3 places will validate if a page can mirate or not, and
> some validations are performed later, which will waste some CPU to call
> numa_migrate_prep().
>
> Thus we can move all the migration validation into numa_migrate_prep(),
> which is more maintainable as well as saving some CPU resources. Another
> benefit is that it can serve as a preparation for supporting batch migration
> in do_numa_page() in future.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/memory.c  | 19 +++++++++++++++++++
>  mm/migrate.c | 19 -------------------
>  2 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index d003076b218d..bee9b1e86ef0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4747,6 +4747,25 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
>  		*flags |= TNF_FAULT_LOCAL;
>  	}
>  
> +	/*
> +	 * Don't migrate file pages that are mapped in multiple processes
> +	 * with execute permissions as they are probably shared libraries.
> +	 */
> +	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
> +	    (vma->vm_flags & VM_EXEC))
> +		return NUMA_NO_NODE;
> +
> +	/*
> +	 * Also do not migrate dirty pages as not all filesystems can move
> +	 * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
> +	 */
> +	if (page_is_file_lru(page) && PageDirty(page))
> +		return NUMA_NO_NODE;
> +
> +	/* Do not migrate THP mapped by multiple processes */
> +	if (PageTransHuge(page) && total_mapcount(page) > 1)
> +		return NUMA_NO_NODE;
> +
>  	return mpol_misplaced(page, vma, addr);

In mpol_misplaced()->should_numa_migrate_memory(), accessing CPU and PID
will be recorded.  So the code change above will introduce some behavior
change.

How about move these checks into a separate function which is called
between numa_migrate_prep() and migrate_misplaced_page() after unlocking
PTL?

--
Best Regards,
Huang, Ying

>  }
>  
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e21d5a7e7447..9cc98fb1d6ec 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2485,10 +2485,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  
>  	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
>  
> -	/* Do not migrate THP mapped by multiple processes */
> -	if (PageTransHuge(page) && total_mapcount(page) > 1)
> -		return 0;
> -
>  	/* Avoid migrating to a node that is nearly full */
>  	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
>  		int z;
> @@ -2533,21 +2529,6 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>  	LIST_HEAD(migratepages);
>  	int nr_pages = thp_nr_pages(page);
>  
> -	/*
> -	 * Don't migrate file pages that are mapped in multiple processes
> -	 * with execute permissions as they are probably shared libraries.
> -	 */
> -	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
> -	    (vma->vm_flags & VM_EXEC))
> -		goto out;
> -
> -	/*
> -	 * Also do not migrate dirty pages as not all filesystems can move
> -	 * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
> -	 */
> -	if (page_is_file_lru(page) && PageDirty(page))
> -		goto out;
> -
>  	isolated = numamigrate_isolate_page(pgdat, page);
>  	if (!isolated)
>  		goto out;
