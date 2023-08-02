Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DAB76C2EC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjHBCcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHBCcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:32:22 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BFE268C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:32:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vot7YLG_1690943537;
Received: from 30.97.48.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vot7YLG_1690943537)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:32:18 +0800
Message-ID: <062e3adc-6d01-aa9a-8480-a4d845d4d4fe@linux.alibaba.com>
Date:   Wed, 2 Aug 2023 10:32:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/5] mm/compaction: set compact_cached_free_pfn correctly
 in update_pageblock_skip
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230729174354.2239980-1-shikemeng@huaweicloud.com>
 <20230729174354.2239980-3-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230729174354.2239980-3-shikemeng@huaweicloud.com>
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
> We will set skip to page block of block_start_pfn, it's more reasonable
> to set compact_cached_free_pfn to page block before the block_start_pfn.

Looks reasonable to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index d1d28d57e5bd..4a784872565a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1690,7 +1690,8 @@ static void isolate_freepages(struct compact_control *cc)
>   
>   		/* Update the skip hint if the full pageblock was scanned */
>   		if (isolate_start_pfn >= block_end_pfn)
> -			update_pageblock_skip(cc, page, block_start_pfn);
> +			update_pageblock_skip(cc, page, block_start_pfn -
> +					      pageblock_nr_pages);
>   
>   		/* Are enough freepages isolated? */
>   		if (cc->nr_freepages >= cc->nr_migratepages) {
