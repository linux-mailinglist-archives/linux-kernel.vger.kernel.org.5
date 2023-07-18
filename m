Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FB6757402
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjGRGYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjGRGYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:24:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F81A12F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689661454; x=1721197454;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=ycN0HSOoo8giOXVll7EuuW/rgiYv30tIU6vjpIahWHY=;
  b=bV8VBT6JMBIue6xZxUXqX6VE6Q3DnRNvHkvLcLQhg7MoU9oewsLz5MsO
   XIULdDRa1benB6lEQY+YfMCyT4hF2BnjtWpoOdKZbmGIoyLLQHj4fWnv5
   sVba6v2YekZ5LwWmoFGoZoWL2Mdw6ltqmVGTdKYKwF/Fgvzumo4QnvyyG
   c+Hn5dmwOM5oQRm3vdrTdH5u6DrK0BiebS+N/sjlB1bxBAImfaZGXndpF
   XPHWyAvYakUGT2v6o2WJ0hzvH6FJr8YquZB4UesA+daZCMQFjs0jP1rkx
   ojFv0PueVnYsyB1mwayOozJAa+R0YP4GKEPcqFcgpKgWk8VZqhi5pJ4jo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="396961935"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="396961935"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 23:24:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="700777210"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="700777210"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 23:24:04 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        Zi Yan <ziy@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v1 2/3] mm: Implement folio_remove_rmap_range()
References: <20230717143110.260162-1-ryan.roberts@arm.com>
        <20230717143110.260162-3-ryan.roberts@arm.com>
Date:   Tue, 18 Jul 2023 14:22:19 +0800
In-Reply-To: <20230717143110.260162-3-ryan.roberts@arm.com> (Ryan Roberts's
        message of "Mon, 17 Jul 2023 15:31:09 +0100")
Message-ID: <874jm1d9ic.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Roberts <ryan.roberts@arm.com> writes:

> Like page_remove_rmap() but batch-removes the rmap for a range of pages
> belonging to a folio. This can provide a small speedup due to less
> manipuation of the various counters. But more crucially, if removing the
> rmap for all pages of a folio in a batch, there is no need to
> (spuriously) add it to the deferred split list, which saves significant
> cost when there is contention for the split queue lock.
>
> All contained pages are accounted using the order-0 folio (or base page)
> scheme.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/rmap.h |  2 ++
>  mm/rmap.c            | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index b87d01660412..f578975c12c0 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -200,6 +200,8 @@ void page_add_file_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
> +void folio_remove_rmap_range(struct folio *folio, struct page *page,
> +		int nr, struct vm_area_struct *vma);
>  
>  void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
>  		unsigned long address, rmap_t flags);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2baf57d65c23..1da05aca2bb1 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1359,6 +1359,71 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>  	mlock_vma_folio(folio, vma, compound);
>  }
>  
> +/*
> + * folio_remove_rmap_range - take down pte mappings from a range of pages
> + * belonging to a folio. All pages are accounted as small pages.
> + * @folio:	folio that all pages belong to
> + * @page:       first page in range to remove mapping from
> + * @nr:		number of pages in range to remove mapping from
> + * @vma:        the vm area from which the mapping is removed
> + *
> + * The caller needs to hold the pte lock.
> + */
> +void folio_remove_rmap_range(struct folio *folio, struct page *page,
> +					int nr, struct vm_area_struct *vma)
> +{
> +	atomic_t *mapped = &folio->_nr_pages_mapped;
> +	int nr_unmapped = 0;
> +	int nr_mapped;
> +	bool last;
> +	enum node_stat_item idx;
> +
> +	if (unlikely(folio_test_hugetlb(folio))) {
> +		VM_WARN_ON_FOLIO(1, folio);
> +		return;
> +	}
> +
> +	if (!folio_test_large(folio)) {
> +		/* Is this the page's last map to be removed? */
> +		last = atomic_add_negative(-1, &page->_mapcount);
> +		nr_unmapped = last;
> +	} else {
> +		for (; nr != 0; nr--, page++) {
> +			/* Is this the page's last map to be removed? */
> +			last = atomic_add_negative(-1, &page->_mapcount);
> +			if (last) {
> +				/* Page still mapped if folio mapped entirely */
> +				nr_mapped = atomic_dec_return_relaxed(mapped);
> +				if (nr_mapped < COMPOUND_MAPPED)
> +					nr_unmapped++;
> +			}
> +		}
> +	}
> +
> +	if (nr_unmapped) {
> +		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
> +		__lruvec_stat_mod_folio(folio, idx, -nr_unmapped);
> +
> +		/*
> +		 * Queue anon THP for deferred split if we have just unmapped at

Just some nitpicks.  So feel free to ignore.

s/anon THP/large folio/ ?

> +		 * least 1 page, while at least 1 page remains mapped.
> +		 */
> +		if (folio_test_large(folio) && folio_test_anon(folio))
> +			if (nr_mapped)

                if (folio_test_large(folio) && folio_test_anon(folio) && nr_mapped) ?

> +				deferred_split_folio(folio);
> +	}
> +
> +	/*
> +	 * It would be tidy to reset folio_test_anon mapping when fully
> +	 * unmapped, but that might overwrite a racing page_add_anon_rmap
> +	 * which increments mapcount after us but sets mapping before us:
> +	 * so leave the reset to free_pages_prepare, and remember that
> +	 * it's only reliable while mapped.
> +	 */
> +
> +	munlock_vma_folio(folio, vma, false);
> +}
> +
>  /**
>   * page_remove_rmap - take down pte mapping from a page
>   * @page:	page to remove mapping from

Best Regards,
Huang, Ying
