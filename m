Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807E981125A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379047AbjLMNCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379027AbjLMNCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:02:39 -0500
Received: from outbound-smtp61.blacknight.com (outbound-smtp61.blacknight.com [46.22.136.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C5B10C8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:02:35 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id DA549FAC6E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:02:33 +0000 (GMT)
Received: (qmail 17601 invoked from network); 13 Dec 2023 13:02:33 -0000
Received: from unknown (HELO mail.blacknight.com) (mgorman@techsingularity.net@[81.17.254.22])
  by 81.17.254.26 with ESMTPA; 13 Dec 2023 13:02:33 -0000
Date:   Wed, 13 Dec 2023 13:02:31 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, david@redhat.com, hannes@cmpxchg.org,
        huzhanyuan@oppo.com, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com, v-songbaohua@oppo.com,
        willy@infradead.org
Subject: Re: [PATCH] mm: compaction: avoid fast_isolate_freepages blindly
 choose improper pageblock
Message-ID: <20231213130231.ksban2ovad4q4rxj@techsingularity.net>
References: <20231206110054.61617-1-v-songbaohua@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20231206110054.61617-1-v-songbaohua@oppo.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 12:00:54AM +1300, Barry Song wrote:
> Testing shows fast_isolate_freepages can blindly choose an unsuitable
> pageblock from time to time particularly while the min mark is used
> from XXX path:
>  if (!page) {
>          cc->fast_search_fail++;
>          if (scan_start) {
>                  /*
>                   * Use the highest PFN found above min. If one was
>                   * not found, be pessimistic for direct compaction
>                   * and use the min mark.
>                   */
>                  if (highest >= min_pfn) {
>                          page = pfn_to_page(highest);
>                          cc->free_pfn = highest;
>                  } else {
>                          if (cc->direct_compaction && pfn_valid(min_pfn)) { /* XXX */
>                                  page = pageblock_pfn_to_page(min_pfn,
>                                          min(pageblock_end_pfn(min_pfn),
>                                              zone_end_pfn(cc->zone)),
>                                          cc->zone);
>                                  cc->free_pfn = min_pfn;
>                          }
>                  }
>          }
>  }
> 
> The reason is that no code is doing any check on the min_pfn
>  min_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 1));
> 
> In contrast, slow path of isolate_freepages() is always skipping unsuitable
> pageblocks in a decent way.
> 
> This issue doesn't happen quite often. When running 25 machines with 16GiB
> memory for one night, most of them can hit this unexpected code path.
> However the frequency isn't like many times per second. It might be one
> time in a couple of hours. Thus, it is very hard to measure the visible
> performance impact in my machines though the affection of choosing the
> unsuitable migration_target should be negative in theory.
> 
> I feel it's still worth fixing this to at least make the code theoretically
> self-explanatory as it is quite odd an unsuitable migration_target can be
> still migration_target.
> 
> Reported-by: Zhanyuan Hu <huzhanyuan@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
