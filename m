Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA14F7F43C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjKVK07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjKVK0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:26:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 124E71AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:26:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 891551595;
        Wed, 22 Nov 2023 02:27:20 -0800 (PST)
Received: from [10.57.71.201] (unknown [10.57.71.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4340D3F6C4;
        Wed, 22 Nov 2023 02:26:31 -0800 (PST)
Message-ID: <e460ab6f-3ebe-441f-8f55-ce8d50bf078f@arm.com>
Date:   Wed, 22 Nov 2023 10:26:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] mm/compaction: optimize >0 order folio compaction
 with free page split.
Content-Language: en-GB
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
 <20231113170157.280181-4-zi.yan@sent.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231113170157.280181-4-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2023 17:01, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> During migration in a memory compaction, free pages are placed in an array
> of page lists based on their order. But the desired free page order (i.e.,
> the order of a source page) might not be always present, thus leading to
> migration failures. Split a high order free pages when source migration
> page has a lower order to increase migration successful rate.
> 
> Note: merging free pages when a migration fails and a lower order free
> page is returned via compaction_free() is possible, but there is too much
> work. Since the free pages are not buddy pages, it is hard to identify
> these free pages using existing PFN-based page merging algorithm.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/compaction.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index ec6b5cc7e907..9c083e6b399a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1806,9 +1806,46 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>  	struct compact_control *cc = (struct compact_control *)data;
>  	struct folio *dst;
>  	int order = folio_order(src);
> +	bool has_isolated_pages = false;
>  
> +again:
>  	if (!cc->freepages[order].nr_pages) {
> -		isolate_freepages(cc);
> +		int i;
> +
> +		for (i = order + 1; i <= MAX_ORDER; i++) {
> +			if (cc->freepages[i].nr_pages) {
> +				struct page *freepage =
> +					list_first_entry(&cc->freepages[i].pages,
> +							 struct page, lru);
> +
> +				int start_order = i;
> +				unsigned long size = 1 << start_order;
> +
> +				list_del(&freepage->lru);
> +				cc->freepages[i].nr_pages--;
> +
> +				while (start_order > order) {
> +					start_order--;
> +					size >>= 1;
> +
> +					list_add(&freepage[size].lru,
> +						&cc->freepages[start_order].pages);
> +					cc->freepages[start_order].nr_pages++;
> +					set_page_private(&freepage[size], start_order);
> +				}
> +				post_alloc_hook(freepage, order, __GFP_MOVABLE);
> +				if (order)
> +					prep_compound_page(freepage, order);
> +				dst = page_folio(freepage);
> +				goto done;

Perhaps just do:

dst = (struct folio *)freepage;
goto done;

then move done: up a couple of statements below, so that post_alloc_hook() and
prep_compound_page() are always done below in common path? Although perhaps the
cast is frowned upon, you're already making the assumption that page and folio
are interchangable the way you call list_first_entry().

> +			}
> +		}
> +		if (!has_isolated_pages) {
> +			isolate_freepages(cc);
> +			has_isolated_pages = true;
> +			goto again;
> +		}
> +
>  		if (!cc->freepages[order].nr_pages)
>  			return NULL;
>  	}
> @@ -1819,6 +1856,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>  	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
>  	if (order)
>  		prep_compound_page(&dst->page, order);
> +done:
>  	cc->nr_freepages -= 1 << order;
>  	return page_rmappable_folio(&dst->page);
>  }

