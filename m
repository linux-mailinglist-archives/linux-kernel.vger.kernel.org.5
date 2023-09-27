Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693327AFA50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjI0Ftr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjI0FtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:49:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5F61731
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 22:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695793476; x=1727329476;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=eVHpqGZhAIIy6UMnGBM0tF+7WZo7Dg9HmYYsMtGxPvc=;
  b=NLIGiBlK521qm6azFFYYh2FCRfqnNxQOasJh3qPeWJ5rdK8xEbUl7km5
   WPRfre4eO5Xopjzx7UHXr/uUl3FE2ST1VDssTU6IQ1yU6zU9hFQWgLyVb
   ItguKnxdW0VBRjVNzd64eIaW23j8egdY9Xx34gaGNFCwHTs1/WZWDsg0s
   QG7Cfb4Lcw6J6GAKvf7twQ0cLCt2hdsn0BfX2LFuOXSh3C1ftDexPz9Aj
   ZAMdiOUXhM+K+IhFa3A4Gfrb6Gj525GP0AVc6lGPkS0n5+HpFy91W3G9s
   Sp/blGXoZkQcKM8xn2fA5zNNY7eqkYJA6HFq0Ya9TXEMBee+n1lkup0Ag
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="380603176"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="380603176"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 22:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="892469264"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="892469264"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 22:43:26 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
References: <20230911195023.247694-1-hannes@cmpxchg.org>
        <20230911195023.247694-2-hannes@cmpxchg.org>
Date:   Wed, 27 Sep 2023 13:42:25 +0800
In-Reply-To: <20230911195023.247694-2-hannes@cmpxchg.org> (Johannes Weiner's
        message of "Mon, 11 Sep 2023 15:41:42 -0400")
Message-ID: <87y1gsrx32.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

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

I suspected the PCP allocating/freeing path may be influenced (that is,
allocating/freeing batch is less than PCP high).  So I tested
one-process will-it-scale/page_fault1 with sysctl
percpu_pagelist_high_fraction=8.  So pages will be allocated/freed
from/to PCP only.  The test results are as follows,

Before:
will-it-scale.1.processes                        618364.3      (+-  0.075%)
perf-profile.children.get_pfnblock_flags_mask         0.13     (+-  9.350%)

After:
will-it-scale.1.processes	                 616512.0      (+-  0.057%)
perf-profile.children.get_pfnblock_flags_mask	      0.41     (+-  22.44%)

The change isn't large: -0.3%.  Perf profiling shows the cycles% of
get_pfnblock_flags_mask() increases.

--
Best Regards,
Huang, Ying
