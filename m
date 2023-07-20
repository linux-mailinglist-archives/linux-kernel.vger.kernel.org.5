Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BEB75A608
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGTGJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGTGJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:09:33 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099A1985
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:09:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vnofr4u_1689833368;
Received: from 30.97.48.52(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vnofr4u_1689833368)
          by smtp.aliyun-inc.com;
          Thu, 20 Jul 2023 14:09:29 +0800
Message-ID: <9c6efec0-42ae-6b48-dd42-0ed7a0d5544d@linux.alibaba.com>
Date:   Thu, 20 Jul 2023 14:09:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] mm/compaction: avoid unneeded pageblock_end_pfn when
 no_set_skip_hint is set
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230720115351.2039431-1-shikemeng@huaweicloud.com>
 <20230720115351.2039431-4-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230720115351.2039431-4-shikemeng@huaweicloud.com>
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



On 7/20/2023 7:53 PM, Kemeng Shi wrote:
> Move pageblock_end_pfn after no_set_skip_hint check to avoid unneeded
> pageblock_end_pfn if no_set_skip_hint is set.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c0d8d08fc163..9b7a0a69e19f 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -458,12 +458,12 @@ static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
>   {
>   	struct zone *zone = cc->zone;
>   
> -	pfn = pageblock_end_pfn(pfn);
> -
>   	/* Set for isolation rather than compaction */
>   	if (cc->no_set_skip_hint)
>   		return;
>   
> +	pfn = pageblock_end_pfn(pfn);
> +
>   	if (pfn > zone->compact_cached_migrate_pfn[0])
>   		zone->compact_cached_migrate_pfn[0] = pfn;
>   	if (cc->mode != MIGRATE_ASYNC &&
