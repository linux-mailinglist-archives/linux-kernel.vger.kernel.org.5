Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D48806B15
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377292AbjLFJyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377254AbjLFJyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:54:04 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9300FA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:54:09 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vxxc1mm_1701856445;
Received: from 30.97.48.44(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vxxc1mm_1701856445)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 17:54:06 +0800
Message-ID: <079610c2-04ed-4495-8eb7-518b04f911f7@linux.alibaba.com>
Date:   Wed, 6 Dec 2023 17:54:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: compaction: avoid fast_isolate_freepages blindly
 choose improper pageblock
To:     Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     david@redhat.com, shikemeng@huaweicloud.com, willy@infradead.org,
        mgorman@techsingularity.net, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
        Zhanyuan Hu <huzhanyuan@oppo.com>
References: <20231129104530.63787-1-v-songbaohua@oppo.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20231129104530.63787-1-v-songbaohua@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/2023 6:45 PM, Barry Song wrote:
> Testing shows fast_isolate_freepages can blindly choose an unsuitable
> pageblock from time to time particularly while the min mark is used
> from XXX path:
>   if (!page) {
>           cc->fast_search_fail++;
>           if (scan_start) {
>                   /*
>                    * Use the highest PFN found above min. If one was
>                    * not found, be pessimistic for direct compaction
>                    * and use the min mark.
>                    */
>                   if (highest >= min_pfn) {
>                           page = pfn_to_page(highest);
>                           cc->free_pfn = highest;
>                   } else {
>                           if (cc->direct_compaction && pfn_valid(min_pfn)) { /* XXX */
>                                   page = pageblock_pfn_to_page(min_pfn,
>                                           min(pageblock_end_pfn(min_pfn),
>                                               zone_end_pfn(cc->zone)),
>                                           cc->zone);
>                                   cc->free_pfn = min_pfn;
>                           }
>                   }
>           }
>   }

Yes, the min_pfn can be an unsuitable migration target. But I think we 
can just add the suitable_migration_target() validation into 'min_pfn' 
case? Since other cases must be suitable target which found from 
MIGRATE_MOVABLE free list. Something like below:

diff --git a/mm/compaction.c b/mm/compaction.c
index 01ba298739dd..4e8eb4571909 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1611,6 +1611,8 @@ static void fast_isolate_freepages(struct 
compact_control *cc)
 
min(pageblock_end_pfn(min_pfn),
 
zone_end_pfn(cc->zone)),
                                                 cc->zone);
+                                       if 
(!suitable_migration_target(cc, page))
+                                               page = NULL;
                                         cc->free_pfn = min_pfn;
                                 }
                         }

By the way, I wonder if this patch can improve the efficiency of 
compaction in your test case?

> In contrast, slow path is skipping unsuitable pageblocks in a decent way.
> 
> I don't know if it is an intended design or just an oversight. But
> it seems more sensible to skip unsuitable pageblock.
> 
> Reported-by: Zhanyuan Hu <huzhanyuan@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   mm/compaction.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 01ba298739dd..98c485a25614 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1625,6 +1625,12 @@ static void fast_isolate_freepages(struct compact_control *cc)
>   	cc->total_free_scanned += nr_scanned;
>   	if (!page)
>   		return;
> +	/*
> +	 * Otherwise, we can blindly choose an improper pageblock especially
> +	 * while using the min mark
> +	 */
> +	if (!suitable_migration_target(cc, page))
> +		return;
>   
>   	low_pfn = page_to_pfn(page);
>   	fast_isolate_around(cc, low_pfn);
