Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF64176B2BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjHALJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjHALJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:09:20 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C2949F6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:03:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vor2y66_1690887804;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vor2y66_1690887804)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 19:03:25 +0800
Message-ID: <8e445d60-e8b1-7172-4577-20e7f28d1e9d@linux.alibaba.com>
Date:   Tue, 1 Aug 2023 19:03:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm: compaction: fix endless looping over same migrate
 block
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230731172450.1632195-1-hannes@cmpxchg.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230731172450.1632195-1-hannes@cmpxchg.org>
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



On 8/1/2023 1:24 AM, Johannes Weiner wrote:
> During stress testing, the following situation was observed:
> 
>       70 root      39  19       0      0      0 R 100.0   0.0 959:29.92 khugepaged
>   310936 root      20   0   84416  25620    512 R  99.7   1.5 642:37.22 hugealloc
> 
> Tracing shows isolate_migratepages_block() endlessly looping over the
> first block in the DMA zone:
> 
>         hugealloc-310936  [001] ..... 237297.415718: mm_compaction_finished: node=0 zone=DMA      order=9 ret=no_suitable_page
>         hugealloc-310936  [001] ..... 237297.415718: mm_compaction_isolate_migratepages: range=(0x1 ~ 0x400) nr_scanned=513 nr_taken=0
>         hugealloc-310936  [001] ..... 237297.415718: mm_compaction_finished: node=0 zone=DMA      order=9 ret=no_suitable_page
>         hugealloc-310936  [001] ..... 237297.415718: mm_compaction_isolate_migratepages: range=(0x1 ~ 0x400) nr_scanned=513 nr_taken=0
>         hugealloc-310936  [001] ..... 237297.415718: mm_compaction_finished: node=0 zone=DMA      order=9 ret=no_suitable_page
>         hugealloc-310936  [001] ..... 237297.415718: mm_compaction_isolate_migratepages: range=(0x1 ~ 0x400) nr_scanned=513 nr_taken=0
>         hugealloc-310936  [001] ..... 237297.415718: mm_compaction_finished: node=0 zone=DMA      order=9 ret=no_suitable_page
>         hugealloc-310936  [001] ..... 237297.415718: mm_compaction_isolate_migratepages: range=(0x1 ~ 0x400) nr_scanned=513 nr_taken=0
> 
> The problem is that the functions tries to test and set the skip bit
> once on the block, to avoid skipping on its own skip-set, using
> pageblock_aligned() on the pfn as a test. But because this is the DMA
> zone which starts at pfn 1, this is never true for the first block,
> and the skip bit isn't set or tested at all. As a result,
> fast_find_migrateblock() returns the same pageblock over and over.
> 
> If the pfn isn't pageblock-aligned, also check if it's the start of
> the zone to ensure test-and-set-exactly-once on unaligned ranges.
> 
> Thanks to Vlastimil Babka for the help in debugging this.
> 
> Fixes: 90ed667c03fe ("Revert "Revert "mm/compaction: fix set skip in fast_find_migrateblock""")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index dbc9f86b1934..eacca2794e47 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -912,11 +912,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   
>   		/*
>   		 * Check if the pageblock has already been marked skipped.
> -		 * Only the aligned PFN is checked as the caller isolates
> +		 * Only the first PFN is checked as the caller isolates
>   		 * COMPACT_CLUSTER_MAX at a time so the second call must
>   		 * not falsely conclude that the block should be skipped.
>   		 */
> -		if (!valid_page && pageblock_aligned(low_pfn)) {
> +		if (!valid_page && (pageblock_aligned(low_pfn) ||
> +				    low_pfn == cc->zone->zone_start_pfn)) {
>   			if (!isolation_suitable(cc, page)) {
>   				low_pfn = end_pfn;
>   				folio = NULL;
> @@ -2002,7 +2003,8 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>   		 * before making it "skip" so other compaction instances do
>   		 * not scan the same block.
>   		 */
> -		if (pageblock_aligned(low_pfn) &&
> +		if ((pageblock_aligned(low_pfn) ||
> +		     low_pfn == cc->zone->zone_start_pfn) &&
>   		    !fast_find_block && !isolation_suitable(cc, page))
>   			continue;
>   
