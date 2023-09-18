Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB487A42E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbjIRHhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbjIRHhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:37:36 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6E310F7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:34:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VsIAQZk_1695022459;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VsIAQZk_1695022459)
          by smtp.aliyun-inc.com;
          Mon, 18 Sep 2023 15:34:21 +0800
Message-ID: <28f76c7c-4b84-5e08-2f27-07592d8078a2@linux.alibaba.com>
Date:   Mon, 18 Sep 2023 15:34:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 2/4] mm/compaction: optimize >0 order folio compaction
 with free page split.
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <20230912162815.440749-3-zi.yan@sent.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230912162815.440749-3-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/2023 12:28 AM, Zi Yan wrote:
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
>   mm/compaction.c | 40 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 868e92e55d27..45747ab5f380 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1801,9 +1801,46 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>   	struct compact_control *cc = (struct compact_control *)data;
>   	struct folio *dst;
>   	int order = folio_order(src);
> +	bool has_isolated_pages = false;
>   
> +again:
>   	if (!cc->freepages[order].nr_free) {
> -		isolate_freepages(cc);
> +		int i;
> +
> +		for (i = order + 1; i <= MAX_ORDER; i++) {
> +			if (cc->freepages[i].nr_free) {
> +				struct page *freepage =
> +					list_first_entry(&cc->freepages[i].pages,
> +							 struct page, lru);
> +
> +				int start_order = i;
> +				unsigned long size = 1 << start_order;
> +
> +				list_del(&freepage->lru);
> +				cc->freepages[i].nr_free--;
> +
> +				while (start_order > order) {
> +					start_order--;
> +					size >>= 1;
> +
> +					list_add(&freepage[size].lru,
> +						&cc->freepages[start_order].pages);
> +					cc->freepages[start_order].nr_free++;
> +					set_page_private(&freepage[size], start_order);

IIUC, these split pages should also call functions to initialize? e.g. 
prep_compound_page()?

> +				}
> +				post_alloc_hook(freepage, order, __GFP_MOVABLE);
> +				if (order)
> +					prep_compound_page(freepage, order);
> +				dst = page_folio(freepage);
> +				goto done;
> +			}
> +		}
> +		if (!has_isolated_pages) {
> +			isolate_freepages(cc);
> +			has_isolated_pages = true;
> +			goto again;
> +		}
> +
>   		if (!cc->freepages[order].nr_free)
>   			return NULL;
>   	}
> @@ -1814,6 +1851,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>   	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
>   	if (order)
>   		prep_compound_page(&dst->page, order);
> +done:
>   	cc->nr_freepages -= 1 << order;
>   	return dst;
>   }
