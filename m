Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F32E7A72B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjITGTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjITGTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:19:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5547399
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695190774; x=1726726774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=chPIaEJzVNdbE6odLGvBFsc/Z9s6eqiuK9MRZ+edZSQ=;
  b=PGuKhSryVdsx01fblxWFAjzzuKlgBKwj5oouIwlxpyoibgc1LR1eJaCh
   OzpZeaTnvfaD228qrdhuM11PCE/U+ozbzEMzfc3g15Im9dWd2HVdpbyQx
   obhmBUvwFSXnnjwehFON0R36Jzp1TEGFYXcsydTzjiZjGETULn76d7sjb
   sZTtzCsayvbQIx3+iRxMdXtk1TyLvPaat6deSp7FVhfE2roxhHDpGv+XD
   KmM9W+MDG+AyPcVzb6bbl3FB/ASWjvFkDW/EN0DYFSsuULdy2DSQBUMfT
   EMgdcAxSYFlWEei02gNOTDrC8yLP/+BgoWotNY4vfDsc7JBMEOtDkcb6J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="365187561"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="365187561"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="740060492"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="740060492"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:19:29 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH 00/10] mm: PCP high auto-tuning
Date:   Wed, 20 Sep 2023 14:18:46 +0800
Message-Id: <20230920061856.257597-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

On a 2-socket Intel server with 224 logical CPU, we tested kbuild on
one socket with `make -j 112`.

	build time	zone lock%	free_high	alloc_zone
	----------	----------	---------	----------
base	     100.0	      43.6          100.0            100.0
patch1	      96.6	      40.3	     49.2	      95.2
patch3	      96.4	      40.5	     11.3	      95.1
patch5	      96.1	      37.9	     13.3	      96.8
patch7	      86.4	       9.8	      6.2	      22.0
patch9	      85.9	       9.4	      4.8	      16.3
patch10	      87.7	      12.6	     29.0	      32.3

The PCP draining optimization (patch 1/3) improves performance a
little.  The PCP batch allocation optimization (patch 5) reduces zone
lock contention a little.  The PCP high auto-tuning (patch 7/9)
improves performance much.  Where the tuning target: the number of
pages allocated from zone reduces greatly.  So, the zone lock
contention cycles% reduces greatly.  The further PCP draining
optimization (patch 10) based on PCP tuning reduce the performance a
little.  But it will benefit network workloads as below.

With PCP tuning patches (patch 7/9/10), the maximum used memory during
test increases up to 50.6% because more pages are cached in PCP.  But
finally, the number of the used memory decreases to the same level as
that of the base patch.  That is, the pages cached in PCP will be
released to zone after not being used actively.

netperf SCTP_STREAM_MANY
========================

On a 2-socket Intel server with 128 logical CPU, we tested
SCTP_STREAM_MANY test case of netperf test suite with 64-pair
processes.

	     score	zone lock%	free_high	alloc_zone  cache miss rate%
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

	     score	zone lock%	free_high	alloc_zone  cache miss rate%
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

Best Regards,
Huang, Ying
