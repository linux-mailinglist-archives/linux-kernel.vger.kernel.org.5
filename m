Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399C476C338
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjHBC7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjHBC7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:59:10 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E9EC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:59:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VotEpv._1690945144;
Received: from 30.97.48.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VotEpv._1690945144)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:59:05 +0800
Message-ID: <b51e710a-ab9a-78b5-59fc-6ed9bcd27269@linux.alibaba.com>
Date:   Wed, 2 Aug 2023 10:59:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/5] mm/compaction: remove unnecessary cursor page in
 isolate_freepages_block
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230729174354.2239980-1-shikemeng@huaweicloud.com>
 <20230729174354.2239980-5-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230729174354.2239980-5-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2023 1:43 AM, Kemeng Shi wrote:
> The cursor is only used for page forward currently. We can simply move page
> forward directly to remove unnecessary cursor.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 65791a74c5e8..cfb661f4ce23 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -589,7 +589,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>   				bool strict)
>   {
>   	int nr_scanned = 0, total_isolated = 0;
> -	struct page *cursor;
> +	struct page *page;
>   	unsigned long flags = 0;
>   	spinlock_t *locked = NULL;
>   	unsigned long blockpfn = *start_pfn;
> @@ -599,12 +599,11 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>   	if (strict)
>   		stride = 1;
>   
> -	cursor = pfn_to_page(blockpfn);
> +	page = pfn_to_page(blockpfn);
>   
>   	/* Isolate free pages. */
> -	for (; blockpfn < end_pfn; blockpfn += stride, cursor += stride) {
> +	for (; blockpfn < end_pfn; blockpfn += stride, page += stride) {
>   		int isolated;
> -		struct page *page = cursor;
>   
>   		/*
>   		 * Periodically drop the lock (if held) regardless of its
> @@ -628,7 +627,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>   
>   			if (likely(order <= MAX_ORDER)) {
>   				blockpfn += (1UL << order) - 1;
> -				cursor += (1UL << order) - 1;
> +				page += (1UL << order) - 1;
>   				nr_scanned += (1UL << order) - 1;
>   			}
>   			goto isolate_fail;
> @@ -665,7 +664,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>   		}
>   		/* Advance to the end of split page */
>   		blockpfn += isolated - 1;
> -		cursor += isolated - 1;
> +		page += isolated - 1;
>   		continue;
>   
>   isolate_fail:
