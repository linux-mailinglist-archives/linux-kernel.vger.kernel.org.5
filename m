Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE93276C28B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjHBB5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjHBB5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:57:19 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB5E2116
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:57:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vot1Ora_1690941430;
Received: from 30.97.48.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vot1Ora_1690941430)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 09:57:11 +0800
Message-ID: <f77676a5-e30b-d49d-54db-b85f1ad0f65b@linux.alibaba.com>
Date:   Wed, 2 Aug 2023 09:57:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/5] mm/compaction: allow blockpfn outside of pageblock
 for high order buddy page
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230729174354.2239980-1-shikemeng@huaweicloud.com>
 <20230729174354.2239980-2-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230729174354.2239980-2-shikemeng@huaweicloud.com>
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
> Commit 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in
> free scanner") skiped compound pages to save iterations and limit blockpfn
> to reach outside of page block in case of bogus compound_order. While this
> also limit pfnblock outside page block in case a buddy page with order
> higher than page block is found. After this, isolate_freepages_range will
> fail unexpectedly as it will fail to isolate the page block which was
> isolated successfully by high order buddy page in previous page block
> and abort the free page isolation.

Not sure I uderstand the problem, why the isolate_freepages_range() will 
fail? In isolate_freepages_range(), it did not use the 'blockpfn' cursor 
to try next candidate pfn, instead using the 'isolated' to calculate 
next cursor. Or I missed something else?

> Fix this by allow blockpfn outside of pageblock in case of high order
> buddy page.
> 
> Fixes: 9fcd6d2e052ee ("mm, compaction: skip compound pages by order in free scanner")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 6841c0496223..d1d28d57e5bd 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -681,8 +681,10 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>   	/*
>   	 * There is a tiny chance that we have read bogus compound_order(),
>   	 * so be careful to not go outside of the pageblock.
> +	 * Allow blockpfn outside pageblock in normal case that we isolate
> +	 * buddy page with order more than pageblock order.
>   	 */
> -	if (unlikely(blockpfn > end_pfn))
> +	if (unlikely(blockpfn > end_pfn) && total_isolated <= pageblock_nr_pages)
>   		blockpfn = end_pfn;
>   
>   	trace_mm_compaction_isolate_freepages(*start_pfn, blockpfn,
> @@ -1418,7 +1420,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
>   	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
>   
>   	/* Skip this pageblock in the future as it's full or nearly full */
> -	if (start_pfn == end_pfn && !cc->no_set_skip_hint)
> +	if (start_pfn >= end_pfn && !cc->no_set_skip_hint)
>   		set_pageblock_skip(page);
>   }
>   
> @@ -1687,7 +1689,7 @@ static void isolate_freepages(struct compact_control *cc)
>   					block_end_pfn, freelist, stride, false);
>   
>   		/* Update the skip hint if the full pageblock was scanned */
> -		if (isolate_start_pfn == block_end_pfn)
> +		if (isolate_start_pfn >= block_end_pfn)
>   			update_pageblock_skip(cc, page, block_start_pfn);
>   
>   		/* Are enough freepages isolated? */
