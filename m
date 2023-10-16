Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E7B7C9EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjJPFaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJPFaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:30:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21929DC
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697434221; x=1728970221;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xJgWFzff+uqaalunn6Rh1CxrexTGRP3XuKZ2zgaIiRI=;
  b=h7G1YlwL+yDLzLk/tmzvFpBLp0XgZvFd24Dgmo001nKJVFNiao1N1xJC
   JDatAJYsyMEvRTjF8aq5kfQ3CS4+5U0AQ1UiZLymot1mAdzDLOKOkcnK5
   jVEom/dNrX73Won4kkhSSV8PCV2HBis3wKruFhUXT3RhKTOxS3lNYAgco
   Yj3sDlwB6gVD0ZTK33VwEQJKAea7LrjrLfJ/XNDm49G81AyQbQJQ6jqy4
   aa0dXI0MdYM6b+MXL2+5gtKelVcdgzOLkHWGe9RuZa/US0xuTzmXSm8VW
   b0aAMPXvO36ZubYU9IJOHPvE2UttTwZRjpqAaHaN9QKjA7rHesPtZ+12U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389307921"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389307921"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:30:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899356623"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899356623"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:28:18 -0700
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
Subject: [PATCH -V3 0/9] mm: PCP high auto-tuning
Date:   Mon, 16 Oct 2023 13:29:53 +0800
Message-Id: <20231016053002.756205-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

[1/9] mm, pcp: avoid to drain PCP when process exit
[2/9] cacheinfo: calculate per-CPU data cache size
[3/9] mm, pcp: reduce lock contention for draining high-order pages
[4/9] mm: restrict the pcp batch scale factor to avoid too long latency
[5/9] mm, page_alloc: scale the number of pages that are batch allocated
[6/9] mm: add framework for PCP high auto-tuning
[7/9] mm: tune PCP high automatically
[8/9] mm, pcp: decrease PCP high if free pages < high watermark
[9/9] mm, pcp: reduce detecting time of consecutive high order page freeing

Patch [1/9], [2/9], [3/9] optimize the PCP draining for consecutive
high-order pages freeing.

Patch [4/9], [5/9] optimize batch freeing and allocating.

Patch [6/9], [7/9], [8/9] implement and optimize a PCP high
auto-tuning method.

Patch [9/9] optimize the PCP draining for consecutive high order page
freeing based on PCP high auto-tuning.

The test results for patches with performance impact are as follows,

kbuild
======

On a 2-socket Intel server with 224 logical CPU, we run 8 kbuild
instances in parallel (each with `make -j 28`) in 8 cgroup.  This
simulates the kbuild server that is used by 0-Day kbuild service.

	build time   lock contend%	free_high	alloc_zone
	----------	----------	---------	----------
base	     100.0	      14.0          100.0            100.0
patch1	      99.5	      12.8	     19.5	      95.6
patch3	      99.4	      12.6	      7.1	      95.6
patch5	      98.6	      11.0	      8.1	      97.1
patch7	      95.1	       0.5	      2.8	      15.6
patch9	      95.0	       1.0	      8.8	      20.0

The PCP draining optimization (patch [1/9], [3/9]) and PCP batch
allocation optimization (patch [5/9]) reduces zone lock contention a
little.  The PCP high auto-tuning (patch [7/9], [9/9]) reduces build
time visibly.  Where the tuning target: the number of pages allocated
from zone reduces greatly.  So, the zone contention cycles% reduces
greatly.

With PCP tuning patches (patch [7/9], [9/9]), the average used memory
during test increases up to 18.4% because more pages are cached in
PCP.  But at the end of the test, the number of the used memory
decreases to the same level as that of the base patch.  That is, the
pages cached in PCP will be released to zone after not being used
actively.

netperf SCTP_STREAM_MANY
========================

On a 2-socket Intel server with 128 logical CPU, we tested
SCTP_STREAM_MANY test case of netperf test suite with 64-pair
processes.

	     score   lock contend%	free_high	alloc_zone  cache miss rate%
	     -----	----------	---------	----------  ----------------
base	     100.0	       2.1          100.0            100.0	         1.3
patch1	      99.4	       2.1	     99.4	      99.4		 1.3
patch3	     106.4	       1.3	     13.3	     106.3		 1.3
patch5	     106.0	       1.2	     13.2	     105.9		 1.3
patch7	     103.4	       1.9	      6.7	      90.3		 7.6
patch9	     108.6	       1.3	     13.7	     108.6		 1.3

The PCP draining optimization (patch [1/9]+[3/9]) improves
performance.  The PCP high auto-tuning (patch [7/9]) reduces
performance a little because PCP draining cannot be triggered in time
sometimes.  So, the cache miss rate% increases.  The further PCP
draining optimization (patch [9/9]) based on PCP tuning restore the
performance.

lmbench3 UNIX (AF_UNIX)
=======================

On a 2-socket Intel server with 128 logical CPU, we tested UNIX
(AF_UNIX socket) test case of lmbench3 test suite with 16-pair
processes.

	     score   lock contend%	free_high	alloc_zone  cache miss rate%
	     -----	----------	---------	----------  ----------------
base	     100.0	      51.4          100.0            100.0	         0.2
patch1	     116.8	      46.1           69.5	     104.3	         0.2
patch3	     199.1	      21.3            7.0	     104.9	         0.2
patch5	     200.0	      20.8            7.1	     106.9	         0.3
patch7	     191.6	      19.9            6.8	     103.8	         2.8
patch9	     193.4	      21.7            7.0	     104.7	         2.1

The PCP draining optimization (patch [1/9], [3/9]) improves
performance much.  The PCP tuning (patch [7/9]) reduces performance a
little because PCP draining cannot be triggered in time sometimes.
The further PCP draining optimization (patch [9/9]) based on PCP
tuning restores the performance partly.

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
	int                        high;                 /*     8     4 */
	int                        high_min;             /*    12     4 */
	int                        high_max;             /*    16     4 */
	int                        batch;                /*    20     4 */
	u8                         flags;                /*    24     1 */
	u8                         alloc_factor;         /*    25     1 */
	u8                         expire;               /*    26     1 */

	/* XXX 1 byte hole, try to pack */

	short int                  free_count;           /*    28     2 */

	/* XXX 2 bytes hole, try to pack */

	struct list_head           lists[13];            /*    32   208 */

	/* size: 256, cachelines: 4, members: 11 */
	/* sum members: 237, holes: 2, sum holes: 3 */
	/* padding: 16 */
} __attribute__((__aligned__(64)));

The size of the struct doesn't changed with the patchset.

Changelog:

v3:

- Fix the per-CPU data cache slice size calculation in [3/9].  Thanks
  Mel for pointing this out!

- Fix a PCP->high decrement amount issue when free pages become low.

- Dropped original "[9/10] mm, pcp: avoid to reduce PCP high
  unnecessarily", because of no enough performance data to support it.

- Add some comments per Mel's comments.  Thanks!

- Add a Kconfig option for max batch scale factor in [4/9] per Mel's
  comments.  Thanks!

- Collected Acked-by.  Thanks Mel!

v2:

- Fix the kbuild test configuration and results.  Thanks Andrew for
  reminding on test results!

- Add document for sysctl behavior extension in [06/10] per Andrew's comments.

Best Regards,
Huang, Ying
