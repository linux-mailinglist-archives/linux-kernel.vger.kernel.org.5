Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8656576ACBE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjHAJSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjHAJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:17:55 -0400
Received: from outbound-smtp27.blacknight.com (outbound-smtp27.blacknight.com [81.17.249.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6C235A0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:16:45 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 70D83CAD57
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:08:14 +0100 (IST)
Received: (qmail 25971 invoked from network); 1 Aug 2023 09:08:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Aug 2023 09:08:14 -0000
Date:   Tue, 1 Aug 2023 10:08:12 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: compaction: fix endless looping over same migrate
 block
Message-ID: <20230801090812.3o6utiufbwhgevom@techsingularity.net>
References: <20230731172450.1632195-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230731172450.1632195-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 01:24:50PM -0400, Johannes Weiner wrote:
> During stress testing, the following situation was observed:
> 
>      70 root      39  19       0      0      0 R 100.0   0.0 959:29.92 khugepaged
>  310936 root      20   0   84416  25620    512 R  99.7   1.5 642:37.22 hugealloc
> 
> Tracing shows isolate_migratepages_block() endlessly looping over the
> first block in the DMA zone:
> 
>        hugealloc-310936  [001] ..... 237297.415718: mm_compaction_finished: node=0 zone=DMA      order=9 ret=no_suitable_page
>        hugealloc-310936  [001] ..... 237297.415718: mm_compaction_isolate_migratepages: range=(0x1 ~ 0x400) nr_scanned=513 nr_taken=0
>        hugealloc-310936  [001] ..... 237297.415718: mm_compaction_finished: node=0 zone=DMA      order=9 ret=no_suitable_page
>        hugealloc-310936  [001] ..... 237297.415718: mm_compaction_isolate_migratepages: range=(0x1 ~ 0x400) nr_scanned=513 nr_taken=0
>        hugealloc-310936  [001] ..... 237297.415718: mm_compaction_finished: node=0 zone=DMA      order=9 ret=no_suitable_page
>        hugealloc-310936  [001] ..... 237297.415718: mm_compaction_isolate_migratepages: range=(0x1 ~ 0x400) nr_scanned=513 nr_taken=0
>        hugealloc-310936  [001] ..... 237297.415718: mm_compaction_finished: node=0 zone=DMA      order=9 ret=no_suitable_page
>        hugealloc-310936  [001] ..... 237297.415718: mm_compaction_isolate_migratepages: range=(0x1 ~ 0x400) nr_scanned=513 nr_taken=0
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

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
