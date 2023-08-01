Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ED976A744
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 05:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjHADC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 23:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjHADCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 23:02:23 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1CB1981
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:02:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VojZ4od_1690858938;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VojZ4od_1690858938)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 11:02:19 +0800
Message-ID: <8c265e65-10b0-1a81-fe9c-ae334162346e@linux.alibaba.com>
Date:   Tue, 1 Aug 2023 11:02:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 8/8] mm/compaction: only set skip flag if
 cc->no_set_skip_hint is false
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-9-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230728171037.2219226-9-shikemeng@huaweicloud.com>
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



On 7/29/2023 1:10 AM, Kemeng Shi wrote:
> Keep the same logic as update_pageblock_skip, only set skip if
> no_set_skip_hint is false which is more reasonable.

Um, the fast_find_migrateblock() and fast_isolate_freepages() will rely 
on the skip flag and ignore the cc->no_set_skip_hint. So not sure it is 
helpful. Let's see if Mel has some input.

> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 188d610eb3b6..6841c0496223 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1418,7 +1418,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
>   	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
>   
>   	/* Skip this pageblock in the future as it's full or nearly full */
> -	if (start_pfn == end_pfn)
> +	if (start_pfn == end_pfn && !cc->no_set_skip_hint)
>   		set_pageblock_skip(page);
>   }
>   
