Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86AB77C629
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjHOC5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjHOC5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:57:32 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B63E7A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:57:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VppsQQz_1692068247;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VppsQQz_1692068247)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 10:57:28 +0800
Message-ID: <bbf1e081-7732-d2f8-6490-215947eed5d3@linux.alibaba.com>
Date:   Tue, 15 Aug 2023 10:57:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] mm/compaction: remove unused parameter pgdata of
 fragmentation_score_wmark
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
References: <20230809094910.3092446-1-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230809094910.3092446-1-shikemeng@huaweicloud.com>
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



On 8/9/2023 5:49 PM, Kemeng Shi wrote:
> Parameter pgdat is not used in fragmentation_score_wmark. Just remove it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index ea61922a1619..38c8d216c6a3 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2142,7 +2142,7 @@ static unsigned int fragmentation_score_node(pg_data_t *pgdat)
>   	return score;
>   }
>   
> -static unsigned int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
> +static unsigned int fragmentation_score_wmark(bool low)
>   {
>   	unsigned int wmark_low;
>   
> @@ -2162,7 +2162,7 @@ static bool should_proactive_compact_node(pg_data_t *pgdat)
>   	if (!sysctl_compaction_proactiveness || kswapd_is_running(pgdat))
>   		return false;
>   
> -	wmark_high = fragmentation_score_wmark(pgdat, false);
> +	wmark_high = fragmentation_score_wmark(false);
>   	return fragmentation_score_node(pgdat) > wmark_high;
>   }
>   
> @@ -2201,7 +2201,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
>   			return COMPACT_PARTIAL_SKIPPED;
>   
>   		score = fragmentation_score_zone(cc->zone);
> -		wmark_low = fragmentation_score_wmark(pgdat, true);
> +		wmark_low = fragmentation_score_wmark(true);
>   
>   		if (score > wmark_low)
>   			ret = COMPACT_CONTINUE;
