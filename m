Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864647AE582
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjIZGJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjIZGJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:09:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB7DF2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695708567; x=1727244567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CSA7Jls8iydCBRBC90Y0WdsarPb+k5VXOEYoase/WoY=;
  b=Y1fgIlNahYu7lp1105Aah1I9PUaYAWMbjQBApT+FriRyolLFGhIYhy3U
   DLJ/aJkSOKtaHmznYVnFK8NTp/8t8D2Rpc4zrBUPOgWVYOKpRMG7qRI+f
   N71qAKyHAomkzd3eFyVNhDye2zfVVPE0HexKSu+OP17TVE1AG5qcSBDBh
   9wq8OQHIxgLKpG4MtgvBgAUgcZmxYE7JyhqxLBAOG+Ni9zYyfDwbaIWWf
   UdZvcg/lWuHpIWBPfTxmVmAWx4PhlIUbe+ZeIjJnW7KInDjhL34g1cvUa
   qyAoBMrRHySRF1BKnZZ/OH0f55LBvijK/sluZV5bmwBualCySrpzSILHB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447991241"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="447991241"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:09:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="892075842"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="892075842"
Received: from aozhu-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.94])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:08:19 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH -V2 00/10] mm: PCP high auto-tuning
Date:   Tue, 26 Sep 2023 14:09:01 +0800
Message-Id: <20230926060911.266511-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

The page allocation performance requirements of different workloads
are often different.  So, we need to tune the PCP (Per-CPU Pageset)
high on each CPU automatically to optimize the page allocation
performance.

The list of patches in series is as follows,

 1 mm, pcp: avoid to drain PCP when process exit
 2 cacheinfo: calculate per-CPU data cache size
 3 mm, pcp: reduce lock contention for draining high-order pages
 4 mm: restrict the pcp batch scale factor to avoid too long latency
 5 mm, page_alloc: scale the number of pages that are batch allocated
 6 mm: add framework for PCP high auto-tuning
 7 mm: tune PCP high automatically
 8 mm, pcp: decrease PCP high if free pages < high watermark
 9 mm, pcp: avoid to reduce PCP high unnecessarily
10 mm, pcp: reduce detecting time of consecutive high order page freeing

Patch 1/2/3 optimize the PCP draining for consecutive high-order pages
freeing.

Patch 4/5 optimize batch freeing and allocating.

Patch 6/7/8/9 implement and optimize a PCP high auto-tuning method.

Patch 10 optimize the PCP draining for consecutive high order page
freeing based on PCP high auto-tuning.

The test results for patches with performance impact are as follows,

kbuild
======

On a 2-socket Intel server with 224 logical CPU, we run 8 kbuild
instances in parallel (each with `make -j 28`) in 8 cgroup.  This
simulates the kbuild server that is used by 0-Day kbuild service.

	build time   lock contend%	free_high	alloc_zone
	----------	----------	---------	----------
base	     100.0	      13.5          100.0            100.0
patch1	      99.2	      10.6	     19.2	      95.6
patch3	      99.2	      11.7	      7.1	      95.6
patch5	      98.4	      10.0	      8.2	      97.1
patch7	      94.9	       0.7	      3.0	      19.0
patch9	      94.9	       0.6	      2.7	      15.0
patch10	      94.9	       0.9	      8.8	      18.6

The PCP draining optimization (patch 1/3) and PCP batch allocation
optimization (patch 5) reduces zone lock contention a little.  The PCP
high auto-tuning (patch 7/9/10) reduces build time visibly.  Where the
tuning target: the number of pages allocated from zone reduces
greatly.  So, the zone contention cycles% reduces greatly.

With PCP tuning patches (patch 7/9/10), the average used memory during
test increases up to 21.0% because more pages are cached in PCP.  But
at the end of the test, the number of the used memory decreases to the
same level as that of the base patch.  That is, the pages cached in
PCP will be released to zone after not being used actively.

netperf SCTP_STREAM_MANY
========================

On a 2-socket Intel server with 128 logical CPU, we tested
SCTP_STREAM_MANY test case of netperf test suite with 64-pair
processes.

	     score   lock contend%	free_high	alloc_zone  cache miss rate%
	     -----	----------	---------	----------  ----------------
base	     100.0	       2.0          100.0            100.0	         1.3
patch1	      99.7	       2.0	     99.7	      99.7		 1.3
patch3	     105.5	       1.2	     13.2	     105.4		 1.2
patch5	     106.9	       1.2	     13.4	     106.9		 1.3
patch7	     103.5	       1.8	      6.8	      90.8		 7.6
patch9	     103.7	       1.8	      6.6	      89.8		 7.7
patch10	     106.9	       1.2	     13.5	     106.9		 1.2

The PCP draining optimization (patch 1+3) improves performance.  The
PCP high auto-tuning (patch 7/9) reduces performance a little because
PCP draining cannot be triggered in time sometimes.  So, the cache
miss rate% increases.  The further PCP draining optimization (patch
10) based on PCP tuning restore the performance.

lmbench3 UNIX (AF_UNIX)
=======================

On a 2-socket Intel server with 128 logical CPU, we tested UNIX
(AF_UNIX socket) test case of lmbench3 test suite with 16-pair
processes.

	     score   lock contend%	free_high	alloc_zone  cache miss rate%
	     -----	----------	---------	----------  ----------------
base	     100.0	      50.0          100.0            100.0	         0.3
patch1	     117.1	      45.8           72.6	     108.9	         0.2
patch3	     201.6	      21.2            7.4	     111.5	         0.2
patch5	     201.9	      20.9            7.5	     112.7	         0.3
patch7	     194.2	      19.3            7.3	     111.5	         2.9
patch9	     193.1	      19.2            7.2	     110.4	         2.9
patch10	     196.8	      21.0            7.4	     111.2	         2.1

The PCP draining optimization (patch 1/3) improves performance much.
The PCP tuning (patch 7/9) reduces performance a little because PCP
draining cannot be triggered in time sometimes.  The further PCP
draining optimization (patch 10) based on PCP tuning restores the
performance partly.

The patchset adds several fields in struct per_cpu_pages.  The struct
layout before/after the patchset is as follows,

base
====

struct per_cpu_pages {
	spinlock_t                 lock;                 /*     0     4 */
	int                        count;                /*     4     4 */
	int                        high;                 /*     8     4 */
	int                        batch;                /*    12     4 */
	short int                  free_factor;          /*    16     2 */
	short int                  expire;               /*    18     2 */

	/* XXX 4 bytes hole, try to pack */

	struct list_head           lists[13];            /*    24   208 */

	/* size: 256, cachelines: 4, members: 7 */
	/* sum members: 228, holes: 1, sum holes: 4 */
	/* padding: 24 */
} __attribute__((__aligned__(64)));

patched
=======

struct per_cpu_pages {
	spinlock_t                 lock;                 /*     0     4 */
	int                        count;                /*     4     4 */
	int                        count_min;            /*     8     4 */
	int                        high;                 /*    12     4 */
	int                        high_min;             /*    16     4 */
	int                        high_max;             /*    20     4 */
	int                        batch;                /*    24     4 */
	u8                         flags;                /*    28     1 */
	u8                         alloc_factor;         /*    29     1 */
	u8                         expire;               /*    30     1 */

	/* XXX 1 byte hole, try to pack */

	short int                  free_count;           /*    32     2 */

	/* XXX 6 bytes hole, try to pack */

	struct list_head           lists[13];            /*    40   208 */

	/* size: 256, cachelines: 4, members: 12 */
	/* sum members: 241, holes: 2, sum holes: 7 */
	/* padding: 8 */
} __attribute__((__aligned__(64)));

The size of the struct doesn't changed with the patchset.

Changelog:

v2:

- Fix the kbuild test configuration and results.  Thanks Andrew for
  reminding on test results!

- Add document for sysctl behavior extension in [06/10] per Andrew's comments.

Best Regards,
Huang, Ying
