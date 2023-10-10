Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700587BF1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442054AbjJJDit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441973AbjJJDis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:38:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4C992
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696909127; x=1728445127;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=rBNxEXKO+pOeAvL44CpshEm8bQZYocM51QCHssvFplE=;
  b=BH6Qg4UjAxzHvbx+K8/rlGtBjNfJS6Mvvtc/mUyeXpQO7vaPjeYqpY6I
   nqsgdAhCM/tvo2xbiClDoI1Fr+5ShUBj6nIt7sVljnBoahi15xhSEFHQl
   mEIJ6UACsY/51kM0TsxgJxFy80H6Kizec5kldTzl3RRvaqEG2OxqZGNcK
   vD7nwrpWK83UbsFR22FanOslwj3UexBV3m3Tg4IxZqZeBSNo5fBAfTpoG
   3IHEHSN15rmQlPOOPsdDVESgShDwxHdKQrpJaE4RwJF75ZHSFtQB4FPLz
   /rwNzpew8bD/rOGGErrKy+CR+jlOwzGZAjxfDXm5CXN/XZsnB9GiwBP3b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="450796925"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="450796925"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 20:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="746921928"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="746921928"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 20:38:44 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <zi.yan@sent.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 1/1] mm/migrate: correct nr_failed in migrate_pages_sync()
References: <20231009203231.1715845-1-zi.yan@sent.com>
        <20231009203231.1715845-2-zi.yan@sent.com>
Date:   Tue, 10 Oct 2023 11:36:34 +0800
In-Reply-To: <20231009203231.1715845-2-zi.yan@sent.com> (Zi Yan's message of
        "Mon, 9 Oct 2023 16:32:31 -0400")
Message-ID: <87wmvvi1x9.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Zi Yan <zi.yan@sent.com> writes:

> From: Zi Yan <ziy@nvidia.com>
>
> nr_failed was missing the rc value from migrate_pages_batch() and can
> cause a mismatch between migrate_pages() return value and the number of
> not migrated pages, i.e., when the return value of migrate_pages() is 0,
> there are still pages left in the from page list. It will happen when a
> non-PMD THP large folio fails to migrate due to -ENOMEM and is split
> successfully but not all the split pages are not migrated,
> migrate_pages_batch() would return non-zero, but astats.nr_thp_split = 0.
> nr_failed would be 0 and returned to the caller of migrate_pages(), but
> the not migrated pages are left in the from page list without being added
> back to LRU lists.
>
> Fixes: 2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronously firstly")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c602bf6dec97..5348827bd958 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1834,7 +1834,7 @@ static int migrate_pages_sync(struct list_head *from, new_folio_t get_new_folio,
>  		return rc;
>  	}
>  	stats->nr_thp_failed += astats.nr_thp_split;
> -	nr_failed += astats.nr_thp_split;
> +	nr_failed += rc + astats.nr_thp_split;
>  	/*
>  	 * Fall back to migrate all failed folios one by one synchronously. All
>  	 * failed folios except split THPs will be retried, so their failure

I don't think this is a correct fix.  The failed folios will be retried
in the following synchronous migration below.

To fix the issue, we should track nr_split for all large folios (not
only THP), then use

        nr_failed += astats.nr_split;

--
Best Regards,
Huang, Ying
