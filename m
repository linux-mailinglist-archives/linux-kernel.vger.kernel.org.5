Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A46676A702
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjHACel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjHACej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:34:39 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6765EF1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:34:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VojAOgJ_1690857274;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VojAOgJ_1690857274)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:34:35 +0800
Message-ID: <8b95b1c6-62a9-eff6-4c52-9112834e69a6@linux.alibaba.com>
Date:   Tue, 1 Aug 2023 10:35:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/8] mm/compaction: skip page block marked skip in
 isolate_migratepages_block
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-4-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230728171037.2219226-4-shikemeng@huaweicloud.com>
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
> Move migrate_pfn to page block end when block is marked skip to avoid
> unnecessary scan retry of that block from upper caller.
> For example, compact_zone may wrongly rescan skip page block with
> finish_pageblock set as following:
> 1. cc->migrate point to the start of page block
> 2. compact_zone record last_migrated_pfn to cc->migrate
> 3. compact_zone->isolate_migratepages->isolate_migratepages_block tries to
> scan the block. The low_pfn maybe moved forward to middle of block because
> of free pages at beginning of block.
> 4. we find first lru page could be isolated but block was exclusive marked
> skip.
> 5. abort isolate_migratepages_block and make cc->migrate_pfn point to
> found lru page at middle of block.
> 6. compact_zone find cc->migrate_pfn and last_migrated_pfn are in the same
> block and wrongly rescan the block with finish_pageblock set.

Good catch.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index fb250c6b2b6e..ad535f880c70 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1123,6 +1123,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   				skip_updated = true;
>   				if (test_and_set_skip(cc, valid_page) &&
>   				    !cc->finish_pageblock) {
> +					low_pfn = end_pfn;
>   					goto isolate_abort;
>   				}
>   			}
