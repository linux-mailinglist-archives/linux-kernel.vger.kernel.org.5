Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932C17A1AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjIOJnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjIOJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:43:41 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A27130E0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:41:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vs6lww._1694770898;
Received: from 30.97.48.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vs6lww._1694770898)
          by smtp.aliyun-inc.com;
          Fri, 15 Sep 2023 17:41:39 +0800
Message-ID: <d9a0d268-3547-a976-d88e-4120dd36f4de@linux.alibaba.com>
Date:   Fri, 15 Sep 2023 17:41:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 4/4] mm/compaction: enable compacting >0 order folios.
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
 <20230912162815.440749-5-zi.yan@sent.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230912162815.440749-5-zi.yan@sent.com>
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
> Since compaction code can compact >0 order folios, enable it during the
> process.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/compaction.c | 25 ++++++++++---------------
>   1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 4300d877b824..f72af74094de 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1087,11 +1087,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   		if (PageCompound(page) && !cc->alloc_contig) {
>   			const unsigned int order = compound_order(page);
>   
> -			if (likely(order <= MAX_ORDER)) {
> -				low_pfn += (1UL << order) - 1;
> -				nr_scanned += (1UL << order) - 1;
> +			/*
> +			 * Compacting > pageblock_order pages does not improve
> +			 * memory fragmentation. Also skip hugetlbfs pages.
> +			 */
> +			if (likely(order >= pageblock_order) || PageHuge(page)) {

IMO, if the compound page order is larger than the requested cc->order, 
we should also fail the isolation, cause it also does not improve 
fragmentation, right?

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
> @@ -1214,17 +1220,6 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   					goto isolate_abort;
>   				}
>   			}
> -
> -			/*
> -			 * folio become large since the non-locked check,
> -			 * and it's on LRU.
> -			 */
> -			if (unlikely(folio_test_large(folio) && !cc->alloc_contig))  > -				low_pfn += folio_nr_pages(folio) - 1;
> -				nr_scanned += folio_nr_pages(folio) - 1;
> -				folio_set_lru(folio);
> -				goto isolate_fail_put;
> -			}

I do not think you can remove this validation, since previous validation 
is lockless. So under the lock, we need re-check if the compound page 
order is larger than pageblock_order or cc->order, that need fail to 
isolate.

>   		}
>   
>   		/* The folio is taken off the LRU */
