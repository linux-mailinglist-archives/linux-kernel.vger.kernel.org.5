Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8D278BD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjH2Dt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbjH2DtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:49:03 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2F5199
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:48:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vqpt4fA_1693280935;
Received: from 30.221.133.4(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vqpt4fA_1693280935)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 11:48:56 +0800
Message-ID: <940a7978-ebbb-f232-b536-7c8d16c0d1f1@linux.alibaba.com>
Date:   Tue, 29 Aug 2023 11:48:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 7/7] mm/compaction: factor out code to test if we
 should run compaction for target order
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
 <20230826153617.4019189-8-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230826153617.4019189-8-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/2023 11:36 PM, Kemeng Shi wrote:
> We always do zone_watermark_ok check and compaction_suitable check
> together to test if compaction for target order should be runned.
> Factor these code out to remove repeat code.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 63 ++++++++++++++++++++++++++++---------------------
>   1 file changed, 36 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 00b7bba6c72e..6f2b87b026b8 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2374,6 +2374,30 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>   	return false;
>   }
>   
> +/*
> + * Should we do compaction for target allocation order.
> + * Return COMPACT_SUCCESS if allocation for target order can be already
> + * satisfied
> + * Return COMPACT_SKIPPED if compaction for target order is likely to fail
> + * Return COMPACT_CONTINUE if compaction for target order should be runned
> + */
> +static inline enum compact_result

I think you should drop the 'inline' to let the compiler make the decision.

> +compaction_suit_allocation_order(struct zone *zone, unsigned int order,
> +				 int highest_zoneidx, unsigned int alloc_flags)

The changes look good to me. So please feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> +{
> +	unsigned long watermark;
> +
> +	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> +	if (zone_watermark_ok(zone, order, watermark, highest_zoneidx,
> +			      alloc_flags))
> +		return COMPACT_SUCCESS;
> +
> +	if (!compaction_suitable(zone, order, highest_zoneidx))
> +		return COMPACT_SKIPPED;
> +
> +	return COMPACT_CONTINUE;
> +}
> +
>   static enum compact_result
>   compact_zone(struct compact_control *cc, struct capture_control *capc)
>   {
> @@ -2399,19 +2423,11 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>   	cc->migratetype = gfp_migratetype(cc->gfp_mask);
>   
>   	if (!is_via_compact_memory(cc->order)) {
> -		unsigned long watermark;
> -
> -		/* Allocation can already succeed, nothing to do */
> -		watermark = wmark_pages(cc->zone,
> -					cc->alloc_flags & ALLOC_WMARK_MASK);
> -		if (zone_watermark_ok(cc->zone, cc->order, watermark,
> -				      cc->highest_zoneidx, cc->alloc_flags))
> -			return COMPACT_SUCCESS;
> -
> -		/* Compaction is likely to fail */
> -		if (!compaction_suitable(cc->zone, cc->order,
> -					 cc->highest_zoneidx))
> -			return COMPACT_SKIPPED;
> +		ret = compaction_suit_allocation_order(cc->zone, cc->order,
> +						       cc->highest_zoneidx,
> +						       cc->alloc_flags);
> +		if (ret != COMPACT_CONTINUE)
> +			return ret;
>   	}
>   
>   	/*
> @@ -2917,14 +2933,10 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
>   		if (!populated_zone(zone))
>   			continue;
>   
> -		/* Allocation can already succeed, check other zones */
> -		if (zone_watermark_ok(zone, pgdat->kcompactd_max_order,
> -				      min_wmark_pages(zone),
> -				      highest_zoneidx, 0))
> -			continue;
> -
> -		if (compaction_suitable(zone, pgdat->kcompactd_max_order,
> -					highest_zoneidx))
> +		if (compaction_suit_allocation_order(zone,
> +				pgdat->kcompactd_max_order,
> +				highest_zoneidx, ALLOC_WMARK_MIN) ==
> +				COMPACT_CONTINUE)
>   			return true;
>   	}
>   
> @@ -2961,12 +2973,9 @@ static void kcompactd_do_work(pg_data_t *pgdat)
>   		if (compaction_deferred(zone, cc.order))
>   			continue;
>   
> -		/* Allocation can already succeed, nothing to do */
> -		if (zone_watermark_ok(zone, cc.order,
> -				      min_wmark_pages(zone), zoneid, 0))
> -			continue;
> -
> -		if (!compaction_suitable(zone, cc.order, zoneid))
> +		if (compaction_suit_allocation_order(zone,
> +				cc.order, zoneid, ALLOC_WMARK_MIN) !=
> +				COMPACT_CONTINUE)
>   			continue;
>   
>   		if (kthread_should_stop())
