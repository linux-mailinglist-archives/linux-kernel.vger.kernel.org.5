Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C543B76CBA0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjHBLUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjHBLUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:20:03 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E45E2139
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:20:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VouwrhT_1690975197;
Received: from 30.97.48.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VouwrhT_1690975197)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 19:19:58 +0800
Message-ID: <026aaebd-ceb3-0659-8f54-2ec3cd81b5df@linux.alibaba.com>
Date:   Wed, 2 Aug 2023 19:20:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/8] mm/compaction: correct last_migrated_pfn update in
 compact_zone
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230802093741.2333325-1-shikemeng@huaweicloud.com>
 <20230802093741.2333325-3-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230802093741.2333325-3-shikemeng@huaweicloud.com>
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



On 8/2/2023 5:37 PM, Kemeng Shi wrote:
> We record start pfn of last isolated page block with last_migrated_pfn. And
> then:
> 1. We check if we mark the page block skip for exclusive access in
> isolate_migratepages_block by test if next migrate pfn is still in last
> isolated page block. If so, we will set finish_pageblock to do the rescan.
> 2. We check if a full cc->order block is scanned by test if last scan range
> passes the cc->order block boundary. If so, we flush the pages were freed.
> 
> We treat cc->migrate_pfn before isolate_migratepages as the start pfn of
> last isolated page range. However, we always align migrate_pfn to page block
> or move to another page block in fast_find_migrateblock or in linearly scan
> forward in isolate_migratepages before do page isolation in
> isolate_migratepages_block.
> 
> Update last_migrated_pfn with pageblock_start_pfn(cc->migrate_pfn - 1)
> after scan to correctly set start pfn of last isolated page range. To
> avoid that:
> 1. Miss a rescan with finish_pageblock set as last_migrate_pfn does not
> point to right pageblock and the migrate will not be in pageblock of
> last_migrate_pfn as it should be.
> 2. Wrongly issue flush by test cc->order block boundary with wrong
> last_migrate_pfn.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index a8cea916df9d..ec3a96b7afce 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2487,7 +2487,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>   			goto check_drain;
>   		case ISOLATE_SUCCESS:
>   			update_cached = false;
> -			last_migrated_pfn = iteration_start_pfn;
> +			last_migrated_pfn = max(cc->zone->zone_start_pfn,
> +				pageblock_start_pfn(cc->migrate_pfn - 1));
>   		}
>   
>   		err = migrate_pages(&cc->migratepages, compaction_alloc,
