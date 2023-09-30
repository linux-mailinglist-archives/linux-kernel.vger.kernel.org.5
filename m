Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A947B3E02
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 06:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjI3E2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 00:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjI3E2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 00:28:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8575EB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 21:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696048093; x=1727584093;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=rVpj1lqLtJb8TCKjOHawgxXj1vC2ae/09G5U9A5u7Xo=;
  b=BwS9mARgoSYcIUSV8PwrOu8VRf7PkYXDeJUgG28irIP4tTAUBIE0PNga
   HDvm+hXovr/uAeK869basIxMYwcMSRgJKbL25kpLmHw6PJGQwy57KnnSM
   3SKq9lQkt/uz4/5bolbzNce6fxLuuFB1q92RO8vgKyl9NkPiNv4Fr6rEr
   hdisEq110YFqdp38wzxcGRqkMSFdiT4PepeBG9i/SbAaRA89lflfBKi8b
   zRtyovWcjEg2WORWNqT7wE1TLyXY5zKVlq2Fva/Q3PoOr9vtsgPVy0N2l
   800he6RRHhWPGq7Nxy1G5QoO1UD12cpW8a8DQl5PipYXQzP1n1QoxEEkO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="381301879"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="381301879"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 21:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="750110687"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="750110687"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 21:28:10 -0700
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
        <87y1gsrx32.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230927145115.GA365513@cmpxchg.org>
Date:   Sat, 30 Sep 2023 12:26:01 +0800
In-Reply-To: <20230927145115.GA365513@cmpxchg.org> (Johannes Weiner's message
        of "Wed, 27 Sep 2023 10:51:15 -0400")
Message-ID: <87pm20p9ra.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Wed, Sep 27, 2023 at 01:42:25PM +0800, Huang, Ying wrote:
>> Johannes Weiner <hannes@cmpxchg.org> writes:
>> 
>> > The idea behind the cache is to save get_pageblock_migratetype()
>> > lookups during bulk freeing. A microbenchmark suggests this isn't
>> > helping, though. The pcp migratetype can get stale, which means that
>> > bulk freeing has an extra branch to check if the pageblock was
>> > isolated while on the pcp.
>> >
>> > While the variance overlaps, the cache write and the branch seem to
>> > make this a net negative. The following test allocates and frees
>> > batches of 10,000 pages (~3x the pcp high marks to trigger flushing):
>> >
>> > Before:
>> >           8,668.48 msec task-clock                       #   99.735 CPUs utilized               ( +-  2.90% )
>> >                 19      context-switches                 #    4.341 /sec                        ( +-  3.24% )
>> >                  0      cpu-migrations                   #    0.000 /sec
>> >             17,440      page-faults                      #    3.984 K/sec                       ( +-  2.90% )
>> >     41,758,692,473      cycles                           #    9.541 GHz                         ( +-  2.90% )
>> >    126,201,294,231      instructions                     #    5.98  insn per cycle              ( +-  2.90% )
>> >     25,348,098,335      branches                         #    5.791 G/sec                       ( +-  2.90% )
>> >         33,436,921      branch-misses                    #    0.26% of all branches             ( +-  2.90% )
>> >
>> >          0.0869148 +- 0.0000302 seconds time elapsed  ( +-  0.03% )
>> >
>> > After:
>> >           8,444.81 msec task-clock                       #   99.726 CPUs utilized               ( +-  2.90% )
>> >                 22      context-switches                 #    5.160 /sec                        ( +-  3.23% )
>> >                  0      cpu-migrations                   #    0.000 /sec
>> >             17,443      page-faults                      #    4.091 K/sec                       ( +-  2.90% )
>> >     40,616,738,355      cycles                           #    9.527 GHz                         ( +-  2.90% )
>> >    126,383,351,792      instructions                     #    6.16  insn per cycle              ( +-  2.90% )
>> >     25,224,985,153      branches                         #    5.917 G/sec                       ( +-  2.90% )
>> >         32,236,793      branch-misses                    #    0.25% of all branches             ( +-  2.90% )
>> >
>> >          0.0846799 +- 0.0000412 seconds time elapsed  ( +-  0.05% )
>> >
>> > A side effect is that this also ensures that pages whose pageblock
>> > gets stolen while on the pcplist end up on the right freelist and we
>> > don't perform potentially type-incompatible buddy merges (or skip
>> > merges when we shouldn't), whis is likely beneficial to long-term
>> > fragmentation management, although the effects would be harder to
>> > measure. Settle for simpler and faster code as justification here.
>> 
>> I suspected the PCP allocating/freeing path may be influenced (that is,
>> allocating/freeing batch is less than PCP high).  So I tested
>> one-process will-it-scale/page_fault1 with sysctl
>> percpu_pagelist_high_fraction=8.  So pages will be allocated/freed
>> from/to PCP only.  The test results are as follows,
>> 
>> Before:
>> will-it-scale.1.processes                        618364.3      (+-  0.075%)
>> perf-profile.children.get_pfnblock_flags_mask         0.13     (+-  9.350%)
>> 
>> After:
>> will-it-scale.1.processes	                 616512.0      (+-  0.057%)
>> perf-profile.children.get_pfnblock_flags_mask	      0.41     (+-  22.44%)
>> 
>> The change isn't large: -0.3%.  Perf profiling shows the cycles% of
>> get_pfnblock_flags_mask() increases.
>
> Ah, this is going through the free_unref_page_list() path that
> Vlastimil had pointed out as well. I made another change on top that
> eliminates the second lookup. After that, both pcp fast paths have the
> same number of lookups as before: 1. This fixes the regression for me.
>
> Would you mind confirming this as well?

I have done more test for the series and addon patches.  The test
results are as follows,

base
perf-profile.children.get_pfnblock_flags_mask	     0.15	(+- 32.62%)
will-it-scale.1.processes			618621.7	(+-  0.18%)

mm: page_alloc: remove pcppage migratetype caching
perf-profile.children.get_pfnblock_flags_mask	     0.40	(+- 21.55%)
will-it-scale.1.processes			616350.3	(+-  0.27%)

mm: page_alloc: fix up block types when merging compatible blocks
perf-profile.children.get_pfnblock_flags_mask	     0.36	(+-  8.36%)
will-it-scale.1.processes			617121.0	(+-  0.17%)

mm: page_alloc: move free pages when converting block during isolation
perf-profile.children.get_pfnblock_flags_mask	     0.36	(+- 15.10%)
will-it-scale.1.processes			615578.0	(+-  0.18%)

mm: page_alloc: fix move_freepages_block() range error
perf-profile.children.get_pfnblock_flags_mask	     0.36	(+- 12.78%)
will-it-scale.1.processes			615364.7	(+-  0.27%)

mm: page_alloc: fix freelist movement during block conversion
perf-profile.children.get_pfnblock_flags_mask	     0.36	(+- 10.52%)
will-it-scale.1.processes			617834.8	(+-  0.52%)

mm: page_alloc: consolidate free page accounting
perf-profile.children.get_pfnblock_flags_mask	     0.39	(+-  8.27%)
will-it-scale.1.processes			621000.0	(+-  0.13%)

mm: page_alloc: close migratetype race between freeing and stealing
perf-profile.children.get_pfnblock_flags_mask	     0.37	(+-  5.87%)
will-it-scale.1.processes			618378.8	(+-  0.17%)

mm: page_alloc: optimize free_unref_page_list()
perf-profile.children.get_pfnblock_flags_mask	     0.20	(+- 14.96%)
will-it-scale.1.processes			618136.3	(+-  0.16%)

It seems that the will-it-scale score is influenced by some other
factors too.  But anyway, the series + addon patches restores the score
of will-it-scale.  And the cycles% of get_pfnblock_flags_mask() is
almost restored by the final patch (mm: page_alloc: optimize
free_unref_page_list()).

Feel free to add my "Tested-by" for these patches.

--
Best Regards,
Huang, Ying
