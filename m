Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A9376C32B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjHBC4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjHBCz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:55:57 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3652D26A1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:55:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vot1lRb_1690944951;
Received: from 30.97.48.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vot1lRb_1690944951)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:55:52 +0800
Message-ID: <b678358f-0834-c01a-c021-7f719faf6fc1@linux.alibaba.com>
Date:   Wed, 2 Aug 2023 10:56:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] mm/compaction: merge end_pfn boundary check in
 isolate_freepages_range
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230729174354.2239980-1-shikemeng@huaweicloud.com>
 <20230729174354.2239980-4-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230729174354.2239980-4-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2023 1:43 AM, Kemeng Shi wrote:
> From: Kemeng Shi <shikemeng@huawei.com>
> 
> Merge the end_pfn boundary check for single page block forward and multiple
> page blocks forward to avoid do twice boundary check for multiple page
> blocks forward.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 4a784872565a..65791a74c5e8 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -740,8 +740,6 @@ isolate_freepages_range(struct compact_control *cc,
>   		/* Protect pfn from changing by isolate_freepages_block */
>   		unsigned long isolate_start_pfn = pfn;
>   
> -		block_end_pfn = min(block_end_pfn, end_pfn);
> -
>   		/*
>   		 * pfn could pass the block_end_pfn if isolated freepage
>   		 * is more than pageblock order. In this case, we adjust
> @@ -750,9 +748,10 @@ isolate_freepages_range(struct compact_control *cc,
>   		if (pfn >= block_end_pfn) {
>   			block_start_pfn = pageblock_start_pfn(pfn);
>   			block_end_pfn = pageblock_end_pfn(pfn);
> -			block_end_pfn = min(block_end_pfn, end_pfn);
>   		}
>   
> +		block_end_pfn = min(block_end_pfn, end_pfn);
> +
>   		if (!pageblock_pfn_to_page(block_start_pfn,
>   					block_end_pfn, cc->zone))
>   			break;
