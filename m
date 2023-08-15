Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62F677C95E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbjHOI3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjHOI3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:29:00 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F8127
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:28:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VprFL1k_1692088132;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VprFL1k_1692088132)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 16:28:53 +0800
Message-ID: <a8edac8d-8e22-89cf-2c8c-217a54608d27@linux.alibaba.com>
Date:   Tue, 15 Aug 2023 16:28:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/9] mm/compaction: correctly return failure with bogus
 compound_order in strict mode
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
 <20230805110711.2975149-4-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230805110711.2975149-4-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/2023 7:07 PM, Kemeng Shi wrote:
> In strict mode, we should return 0 if there is any hole in pageblock. If
> we successfully isolated pages at beginning at pageblock and then have a
> bogus compound_order outside pageblock in next page. We will abort search
> loop with blockpfn > end_pfn. Although we will limit blockpfn to end_pfn,
> we will treat it as a successful isolation in strict mode as blockpfn is
> not < end_pfn and return partial isolated pages. Then
> isolate_freepages_range may success unexpectly with hole in isolated
> range.

Yes, that can be happened.

> This patch also removes unnecessary limit for blockpfn to go outside
> by buddy page introduced in fixed commit or by stride introduced after
> fixed commit. Caller could use returned blockpfn to check if full
> pageblock is scanned by test if blockpfn >= end and to get next pfn to
> scan inside isolate_freepages_block on demand.

IMO, I don't think removing the pageblock restriction is worth it, since 
it did not fix anything and will make people more confused, at least to me.

That is to say, it will be surprised that the blockpfn can go outside of 
the pageblock after calling isolate_freepages_block() to just scan only 
one pageblock, and I did not see in detail if this can cause other 
potential problems.

> Fixes: 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in free scanner")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index fa1b100b0d10..684f6e6cd8bc 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -631,6 +631,14 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>   				page += (1UL << order) - 1;
>   				nr_scanned += (1UL << order) - 1;
>   			}
> +			/*
> +			 * There is a tiny chance that we have read bogus
> +			 * compound_order(), so be careful to not go outside
> +			 * of the pageblock.
> +			 */
> +			if (unlikely(blockpfn >= end_pfn))
> +				blockpfn = end_pfn - 1;

So we can just add this validation to ensure that the 
isolate_freepages_block() can return 0 if failure is happened, which can 
fix your problem.

> +
>   			goto isolate_fail;
>   		}
>   
> @@ -677,17 +685,10 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>   	if (locked)
>   		spin_unlock_irqrestore(&cc->zone->lock, flags);
>   
> -	/*
> -	 * There is a tiny chance that we have read bogus compound_order(),
> -	 * so be careful to not go outside of the pageblock.
> -	 */
> -	if (unlikely(blockpfn > end_pfn))
> -		blockpfn = end_pfn;
> -
>   	trace_mm_compaction_isolate_freepages(*start_pfn, blockpfn,
>   					nr_scanned, total_isolated);
>   
> -	/* Record how far we have got within the block */
> +	/* Record how far we have got */
>   	*start_pfn = blockpfn;
>   
>   	/*
> @@ -1443,7 +1444,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
>   	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
>   
>   	/* Skip this pageblock in the future as it's full or nearly full */
> -	if (start_pfn == end_pfn && !cc->no_set_skip_hint)
> +	if (start_pfn >= end_pfn && !cc->no_set_skip_hint)
>   		set_pageblock_skip(page);
>   }
>   
> @@ -1712,7 +1713,7 @@ static void isolate_freepages(struct compact_control *cc)
>   					block_end_pfn, freelist, stride, false);
>   
>   		/* Update the skip hint if the full pageblock was scanned */
> -		if (isolate_start_pfn == block_end_pfn)
> +		if (isolate_start_pfn >= block_end_pfn)
>   			update_pageblock_skip(cc, page, block_start_pfn -
>   					      pageblock_nr_pages);
>   
