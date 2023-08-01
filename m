Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570D676A6C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjHACI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjHACIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:08:55 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427C3B8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:08:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Voip3YX_1690855729;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Voip3YX_1690855729)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:08:50 +0800
Message-ID: <fd381e0b-3d83-5a4d-cae1-b9957009e578@linux.alibaba.com>
Date:   Tue, 1 Aug 2023 10:09:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/8] mm/compaction: correct last_migrated_pfn update in
 compact_zone
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-3-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230728171037.2219226-3-shikemeng@huaweicloud.com>
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

Right. But can you describe the impact in detail if the 
last_migrated_pfn is not set correctly? For example, this will result in 
rescan not being set correctly to miss a pageblock's rescanning.

Otherwise looks good to me.

> Update last_migrated_pfn with pageblock_start_pfn(cc->migrate_pfn - 1)
> after scan to correctly set start pfn of last isolated page range. > Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index ce7841363b12..fb250c6b2b6e 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2482,7 +2482,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>   			goto check_drain;
>   		case ISOLATE_SUCCESS:
>   			update_cached = false;
> -			last_migrated_pfn = iteration_start_pfn;
> +			last_migrated_pfn = max(cc->zone->zone_start_pfn,
> +				pageblock_start_pfn(cc->migrate_pfn - 1));
>   		}
>   
>   		err = migrate_pages(&cc->migratepages, compaction_alloc,
