Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D99776A1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjGaUZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGaUZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:25:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB16F1723
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:25:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 673BF22081;
        Mon, 31 Jul 2023 20:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690835135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ze17HiLYmlitxQUSBxKO+kA7SK1x6NA+Ycpu61wlnOI=;
        b=NKRbwq2Xtq0Ett2CNRWDR/zGeXi2dVVh80Gu5/0280TgrP025KQs2qtUGlJThEac78tFfe
        Heo5S5GbGe/bngL6Jwd7D1lOX2CN1UuuQEnL+Gdx7W2K55QKdsM5PncTtadAiIh4Zcw15C
        YORGvzvXJAFUHq9NpM6+SuXyUw2Xqq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690835135;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ze17HiLYmlitxQUSBxKO+kA7SK1x6NA+Ycpu61wlnOI=;
        b=jHZI6MvHbgo0G3ou1hoUBBP0stk0XWVu1d1hZ+jmI4R/ZsSu0vslWTiDQH3hb2lyn0Q4EQ
        5C6k4kCJgsxMh1Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 507C61322C;
        Mon, 31 Jul 2023 20:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JkX0Er8YyGQ/dwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 31 Jul 2023 20:25:35 +0000
Message-ID: <30d2c07a-e928-64f0-361e-60f8a05db815@suse.cz>
Date:   Mon, 31 Jul 2023 22:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] mm: compaction: fix endless looping over same migrate
 block
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230731172450.1632195-1-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230731172450.1632195-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 19:24, Johannes Weiner wrote:
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

Yeah I suggested this commit for Fixes: as before the commit (or the
previous, reverted attempt) the skip would be set in
fast_find_migrateblock() so even though the issue of not handling unaligned
zones properly is older, it wouldn't cause an endless loop otherwise. Since
90ed667c03fe is rc1, we don't need stable.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index dbc9f86b1934..eacca2794e47 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -912,11 +912,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  
>  		/*
>  		 * Check if the pageblock has already been marked skipped.
> -		 * Only the aligned PFN is checked as the caller isolates
> +		 * Only the first PFN is checked as the caller isolates
>  		 * COMPACT_CLUSTER_MAX at a time so the second call must
>  		 * not falsely conclude that the block should be skipped.
>  		 */
> -		if (!valid_page && pageblock_aligned(low_pfn)) {
> +		if (!valid_page && (pageblock_aligned(low_pfn) ||
> +				    low_pfn == cc->zone->zone_start_pfn)) {
>  			if (!isolation_suitable(cc, page)) {
>  				low_pfn = end_pfn;
>  				folio = NULL;
> @@ -2002,7 +2003,8 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>  		 * before making it "skip" so other compaction instances do
>  		 * not scan the same block.
>  		 */
> -		if (pageblock_aligned(low_pfn) &&
> +		if ((pageblock_aligned(low_pfn) ||
> +		     low_pfn == cc->zone->zone_start_pfn) &&
>  		    !fast_find_block && !isolation_suitable(cc, page))
>  			continue;
>  

