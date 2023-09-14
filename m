Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09217A0100
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbjINJ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbjINJ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:56:21 -0400
Received: from outbound-smtp16.blacknight.com (outbound-smtp16.blacknight.com [46.22.139.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1003D83
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:56:16 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 25BDD1C3EE3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:56:15 +0100 (IST)
Received: (qmail 3257 invoked from network); 14 Sep 2023 09:56:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Sep 2023 09:56:14 -0000
Date:   Thu, 14 Sep 2023 10:56:08 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
Message-ID: <20230914095608.xswhhoz2rsvbe5zu@techsingularity.net>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230911195023.247694-2-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:41:42PM -0400, Johannes Weiner wrote:
> The idea behind the cache is to save get_pageblock_migratetype()
> lookups during bulk freeing. A microbenchmark suggests this isn't
> helping, though. The pcp migratetype can get stale, which means that
> bulk freeing has an extra branch to check if the pageblock was
> isolated while on the pcp.
> 
> While the variance overlaps, the cache write and the branch seem to
> make this a net negative. The following test allocates and frees
> batches of 10,000 pages (~3x the pcp high marks to trigger flushing):
> 
> Before:
>           8,668.48 msec task-clock                       #   99.735 CPUs utilized               ( +-  2.90% )
>                 19      context-switches                 #    4.341 /sec                        ( +-  3.24% )
>                  0      cpu-migrations                   #    0.000 /sec
>             17,440      page-faults                      #    3.984 K/sec                       ( +-  2.90% )
>     41,758,692,473      cycles                           #    9.541 GHz                         ( +-  2.90% )
>    126,201,294,231      instructions                     #    5.98  insn per cycle              ( +-  2.90% )
>     25,348,098,335      branches                         #    5.791 G/sec                       ( +-  2.90% )
>         33,436,921      branch-misses                    #    0.26% of all branches             ( +-  2.90% )
> 
>          0.0869148 +- 0.0000302 seconds time elapsed  ( +-  0.03% )
> 
> After:
>           8,444.81 msec task-clock                       #   99.726 CPUs utilized               ( +-  2.90% )
>                 22      context-switches                 #    5.160 /sec                        ( +-  3.23% )
>                  0      cpu-migrations                   #    0.000 /sec
>             17,443      page-faults                      #    4.091 K/sec                       ( +-  2.90% )
>     40,616,738,355      cycles                           #    9.527 GHz                         ( +-  2.90% )
>    126,383,351,792      instructions                     #    6.16  insn per cycle              ( +-  2.90% )
>     25,224,985,153      branches                         #    5.917 G/sec                       ( +-  2.90% )
>         32,236,793      branch-misses                    #    0.25% of all branches             ( +-  2.90% )
> 
>          0.0846799 +- 0.0000412 seconds time elapsed  ( +-  0.05% )
> 
> A side effect is that this also ensures that pages whose pageblock
> gets stolen while on the pcplist end up on the right freelist and we
> don't perform potentially type-incompatible buddy merges (or skip
> merges when we shouldn't), whis is likely beneficial to long-term
> fragmentation management, although the effects would be harder to
> measure. Settle for simpler and faster code as justification here.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

I've no specific objection and other minor corrections have already been
suggested. I don't recall specifically but I think
get_pageblock_migratetype might have been called redundantly once upon a
time when there were concerns about page allocator overhead for high
speed network. Now that there is bulk allocation and the flow has
changed significantly, it's feasible to simply avoid calling
get_pageblock_migratetype unnecessarily.

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
