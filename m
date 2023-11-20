Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0F17F0ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjKTJS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjKTJSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:18:25 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A554B137
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:18:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VwkgKKM_1700471895;
Received: from 30.97.48.46(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VwkgKKM_1700471895)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 17:18:17 +0800
Message-ID: <f2111ca6-4be7-4125-af3f-ffab47378bf1@linux.alibaba.com>
Date:   Mon, 20 Nov 2023 17:18:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] mm/compaction: enable compacting >0 order folios.
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
 <20231113170157.280181-2-zi.yan@sent.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20231113170157.280181-2-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2023 1:01 AM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> migrate_pages() supports >0 order folio migration and during compaction,
> even if compaction_alloc() cannot provide >0 order free pages,
> migrate_pages() can split the source page and try to migrate the base pages
> from the split. It can be a baseline and start point for adding support for
> compacting >0 order folios.
> 
> Suggested-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/compaction.c | 57 ++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 42 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 01ba298739dd..5217dd35b493 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -816,6 +816,21 @@ static bool too_many_isolated(struct compact_control *cc)
>   	return too_many;
>   }
>   
> +/*
> + * 1. if the page order is larger than or equal to target_order (i.e.,
> + * cc->order and when it is not -1 for global compaction), skip it since
> + * target_order already indicates no free page with larger than target_order
> + * exists and later migrating it will most likely fail;
> + *
> + * 2. compacting > pageblock_order pages does not improve memory fragmentation,
> + * skip them;
> + */
> +static bool skip_isolation_on_order(int order, int target_order)
> +{
> +	return (target_order != -1 && order >= target_order) ||
> +		order >= pageblock_order;
> +}
> +
>   /**
>    * isolate_migratepages_block() - isolate all migrate-able pages within
>    *				  a single pageblock
> @@ -1009,7 +1024,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   		/*
>   		 * Regardless of being on LRU, compound pages such as THP and
>   		 * hugetlbfs are not to be compacted unless we are attempting
> -		 * an allocation much larger than the huge page size (eg CMA).
> +		 * an allocation larger than the compound page size.
>   		 * We can potentially save a lot of iterations if we skip them
>   		 * at once. The check is racy, but we can consider only valid
>   		 * values and the only danger is skipping too much.
> @@ -1017,11 +1032,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   		if (PageCompound(page) && !cc->alloc_contig) {
>   			const unsigned int order = compound_order(page);
>   
> -			if (likely(order <= MAX_ORDER)) {
> -				low_pfn += (1UL << order) - 1;
> -				nr_scanned += (1UL << order) - 1;
> +			/*
> +			 * Skip based on page order and compaction target order
> +			 * and skip hugetlbfs pages.
> +			 */
> +			if (skip_isolation_on_order(order, cc->order) ||
> +			    PageHuge(page)) {
> +				if (order <= MAX_ORDER) {
> +					low_pfn += (1UL << order) - 1;
> +					nr_scanned += (1UL << order) - 1;
> +				}
> +				goto isolate_fail;
>   			}
> -			goto isolate_fail;
>   		}
>   
>   		/*
> @@ -1144,17 +1166,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   					goto isolate_abort;
>   				}
>   			}
> +		}
>   
> -			/*
> -			 * folio become large since the non-locked check,
> -			 * and it's on LRU.
> -			 */
> -			if (unlikely(folio_test_large(folio) && !cc->alloc_contig)) {
> -				low_pfn += folio_nr_pages(folio) - 1;
> -				nr_scanned += folio_nr_pages(folio) - 1;
> -				folio_set_lru(folio);
> -				goto isolate_fail_put;
> -			}
> +		/*
> +		 * Check LRU folio order under the lock
> +		 */
> +		if (unlikely(skip_isolation_on_order(folio_order(folio),
> +						     cc->order) &&
> +			     !cc->alloc_contig)) {
> +			low_pfn += folio_nr_pages(folio) - 1;
> +			nr_scanned += folio_nr_pages(folio) - 1;
> +			folio_set_lru(folio);
> +			goto isolate_fail_put;
>   		}

Why was this part moved out of the 'if (lruvec != locked)' block? If we 
hold the lru lock, then we do not need to check again, right?
