Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63CB792B5D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjIEQwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354757AbjIEOHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:07:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745E01A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693922855; x=1725458855;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eGjI4lWPLQi7BnstfSf8EXtxEieuRMGl6SSdeyTr5S8=;
  b=aWe/tfqogHuu6iGaJmTLvlr8m++qYdBrb0l4de9hDI7yEjeenaA3D7Or
   w+3vfKiVCENZRhqhZ62wu/gQv5kyY/UUwnvrubGLS6F+9s9+JkbeV29Si
   prM6vXafdAvbn61o1kIWL6DmjGPi234rSKrH+tXiflvW6vSj4bSCxY9BA
   TPbBdHBt1iLFx8acrRhzCmjETO6CVIErNVjiRhg2pQHznnKNj5D00/U8a
   pSZsVTeRJQwrOewGrMGDGEbaMCHpfGHQ3KrHnM3sw2gIJHdIcROX6pmy8
   dQ9ozEhpe82CodVlpjoiWLGzOzfCFfgo3yF72loCGsOaEhJvMbpVQZE4N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="380609577"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="380609577"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 07:06:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="811242089"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="811242089"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2023 07:06:16 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [RFC Patch 0/3] mm/slub: reduce contention for per-node list_lock for large systems 
Date:   Tue,  5 Sep 2023 22:13:45 +0800
Message-Id: <20230905141348.32946-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Please help to review the ideas and patches, thanks!

Problem
-------

0Day bot found performance regression of 'hackbench', related with
slub's per-node 'list_lock' contention [1]. The same lock contention
is also found when running will-it-scale/mmap1 benchmark on rather
big system of 2 sockets with 224 CPUs, where the lock contention can
take up to 76% of cpu cycles.

As the trend is one processor (socket) will have more and more cpu
cores, the contention can be more severe, and we need to tackle it
sooner or later. 

Possible mitigations
--------------------

There are 3 directions we can try, they don't have dependency over
each other and can be taken separately or put together:

1) increase the order of each slab (including changing the max slub
   order from 3 to 4)
2) increase number of per-cpu partial slabs
3) increase the MIN_PARTIAL and MAX_PARTIAL to let each node have
   more (64) partial slabs in maxim 

Regarding reducing the lock contention and improving peformance,
#1 is the most efficient way, #2 second it.

Please be noted that the 3 patches are just for showing the idea
separately to get review and comments first, and NOT targeting for
merge. Patch 2 even can't apply upon patch 1.

A similar regression related to 'list_lock' contention was found when
testing 'hackbench' with new 'eevdf' scheduer patchset, and a rough
combination of these patches cure the performance drop [2].


Performance data
----------------

We have showed some rough performance data in previous discussion:
https://lore.kernel.org/all/ZO2smdi83wWwZBsm@feng-clx/

Following is performance data for using 'mmap1' case of 'will-it-scale'
and 'hackbench' mentioned in [1]. For 'mmap1' case, we run  3
configurations with parallel test threads of 25%, 50% and 100% of
number of CPUs

The test HW is a 2 socket Sapphire Rapids server (112 cores / 224
threads) + 256 GB DRAM, the base kernel is vanilla kernel v6.5.

1) order increasing patch

   * will-it-scale/mmap1:
   
   		     base                      base+patch
   wis-mmap1-25%    223670           +33.3%     298205        per_process_ops
   wis-mmap1-50%    186020           +51.8%     282383        per_process_ops
   wis-mmap1-100%    89200           +65.0%     147139        per_process_ops
   
   Take the perf-profile comparasion of 50% test case, the lock contention
   is greatly reduced:
   
         43.80           -30.8       13.04       pp.self.native_queued_spin_lock_slowpath
         0.85            -0.2        0.65        pp.self.___slab_alloc
         0.41            -0.1        0.27        pp.self.__unfreeze_partials
         0.20 ±  2%      -0.1        0.12 ±  4%  pp.self.get_any_partial
   
   * hackbench: 
   
   		     base                      base+patch
   hackbench	    759951           +10.5%     839601        hackbench.throughput
   
   perf-profile diff:
        22.20 ±  3%     -15.2        7.05        pp.self.native_queued_spin_lock_slowpath
         0.82            -0.2        0.59        pp.self.___slab_alloc
         0.33            -0.2        0.13        pp.self.__unfreeze_partials
   
2) increasing per-cpu partial patch

   The patch itself only makes the per-cpu partial number 2X, and for
   better analysis, the 4X case is also profiled

   * will-it-scale/mmap1:

		  base             base + 2X patch        base + 4X patch
   wis-mmap1-25	 223670    +12.7%     251999     +34.9%     301749    per_process_ops
   wis-mmap1-50	 186020    +28.0%     238067     +55.6%     289521    per_process_ops
   wis-mmap1-100  89200    +40.7%     125478     +62.4%     144858    per_process_ops
   
   Take the perf-profile comparasion of 50% test case, the lock contention
   is greatly reduced:
   
        43.80           -11.5       32.27           -27.9       15.91   pp.self.native_queued_spin_lock_slowpath
   
   * hackbench (no obvious improvment)
                 
		 base             base + 2X patch        base + 4X patch
   hackbench	759951      +0.2%    761506      +0.5%     763972     hackbench.throughput
 
 3) increasing per-node partial patch 

    The patch effectively change the MIN_PARTIAL/MAX_PARTIAL to from
    5/10 to 64/128. 

    * will-it-scale/mmap1:

   		     base                      base+patch
    wis-mmap1-25%    223670            +0.2%     224035        per_process_ops
    wis-mmap1-50%    186020           +13.0%     210248        per_process_ops
    wis-mmap1-100%    89200           +11.3%      99308        per_process_ops

  4) combination patches


			base	            base+patch-3       base+patch-3,1        base+patch-3,1,2
     wis-mmap1-25%	223670      -0.0%     223641     +24.2%     277734    +37.7%     307991     per_process_ops
     wis-mmap1-50%	186172     +12.9%     210108     +42.4%     265028    +59.8%     297495     per_process_ops
     wis-mmap1-100%	 89289     +11.3%      99363     +47.4%     131571    +78.1%     158991     per_process_ops


Make the patch only affect large systems
----------------------------------------
      
In real world, there are different kinds of platforms which has
different useage cases, large systems with huge numbers of CPUs
usually comes with huge memory, and there are also small devices
with limited memory, whch may care more about memory footprint.

So the idea is to treat them separately, keep the current
order/partial settings for system with small number of CPUs, and
scale those settings according to CPU numbers. (there is similar
handling in slub code already). Though aggressive idea is to bump
them all together.

[1]. https://lore.kernel.org/all/202307172140.3b34825a-oliver.sang@intel.com/
[2]. ttps://lore.kernel.org/lkml/ZORaUsd+So+tnyMV@chenyu5-mobl2/

Thanks,
Feng

Feng Tang (3):
  mm/slub: increase the maximum slab order to 4 for big systems
  mm/slub: setup maxim per-node partial according to cpu numbers
  mm/slub: double per-cpu partial number for large systems

 mm/slub.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.27.0

