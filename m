Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A271578BD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbjH2D2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjH2D1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:27:50 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3318110
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:27:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VqpbNto_1693279659;
Received: from 30.221.133.4(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VqpbNto_1693279659)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 11:27:40 +0800
Message-ID: <c243c9f4-51c9-797a-6ac2-b87d1689da14@linux.alibaba.com>
Date:   Tue, 29 Aug 2023 11:27:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/7] mm/compaction: correctly return failure with bogus
 compound_order in strict mode
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
 <20230826153617.4019189-4-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230826153617.4019189-4-shikemeng@huaweicloud.com>
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
> In strict mode, we should return 0 if there is any hole in pageblock. If
> we successfully isolated pages at beginning at pageblock and then have a
> bogus compound_order outside pageblock in next page. We will abort search
> loop with blockpfn > end_pfn. Although we will limit blockpfn to end_pfn,
> we will treat it as a successful isolation in strict mode as blockpfn is
> not < end_pfn and return partial isolated pages. Then
> isolate_freepages_range may success unexpectly with hole in isolated
> range.
> 
> Fixes: 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in free scanner")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index a40550a33aee..b4d03c9ffe7c 100644
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
> +
>   			goto isolate_fail;
>   		}
>   
> @@ -678,8 +686,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>   		spin_unlock_irqrestore(&cc->zone->lock, flags);
>   
>   	/*
> -	 * There is a tiny chance that we have read bogus compound_order(),
> -	 * so be careful to not go outside of the pageblock.
> +	 * Be careful to not go outside of the pageblock.
>   	 */
>   	if (unlikely(blockpfn > end_pfn))
>   		blockpfn = end_pfn;
