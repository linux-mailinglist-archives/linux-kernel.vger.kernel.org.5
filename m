Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EEC7A72B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjITGTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjITGTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:19:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDF69D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695190777; x=1726726777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y5KqaVwntn1O5nTc80IjgYebQMrM7BtNCmGfR5qYkwg=;
  b=JscwNsJ7pqDILWogYR/nvN0sLD+OCVPadr9V0lRIcJP5vJrgX4zEShqS
   teJ4pVWjU/AmN1Z5uMKIjRtkXitW2QdP0iwXPyO9OdPGvVvfz2/rRz8fz
   w8j0JJSVZ51bdSTiSkb/LmI2P7/ZOB/7vPz7YNX5BVM3S5SQ7UUWpuuDQ
   iRVx+Do1eniOy7v/KREL5E+pYa7sRODKw8GkKAGgi7s2A26Tz4Mm1OBaA
   G5+QV7OqWMSN+512nZdWijau83Okth2Arz5taU88FlomqgpjTVfJBPOmB
   Yddkrr6j0MUXfUgqglSjWBDhRHkKSbTs9hqhoC3mvTWnefZ+b1XgaWPvM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="365187579"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="365187579"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:19:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="740060503"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="740060503"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:19:33 -0700
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
Subject: [PATCH 01/10] mm, pcp: avoid to drain PCP when process exit
Date:   Wed, 20 Sep 2023 14:18:47 +0800
Message-Id: <20230920061856.257597-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230920061856.257597-1-ying.huang@intel.com>
References: <20230920061856.257597-1-ying.huang@intel.com>
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

In commit f26b3fa04611 ("mm/page_alloc: limit number of high-order
pages on PCP during bulk free"), the PCP (Per-CPU Pageset) will be
drained when PCP is mostly used for high-order pages freeing to
improve the cache-hot pages reusing between page allocation and
freeing CPUs.

But, the PCP draining mechanism may be triggered unexpectedly when
process exits.  With some customized trace point, it was found that
PCP draining (free_high == true) was triggered with the order-1 page
freeing with the following call stack,

 => free_unref_page_commit
 => free_unref_page
 => __mmdrop
 => exit_mm
 => do_exit
 => do_group_exit
 => __x64_sys_exit_group
 => do_syscall_64

Checking the source code, this is the page table PGD
freeing (mm_free_pgd()).  It's a order-1 page freeing if
CONFIG_PAGE_TABLE_ISOLATION=y.  Which is a common configuration for
security.

Just before that, page freeing with the following call stack was
found,

 => free_unref_page_commit
 => free_unref_page_list
 => release_pages
 => tlb_batch_pages_flush
 => tlb_finish_mmu
 => exit_mmap
 => __mmput
 => exit_mm
 => do_exit
 => do_group_exit
 => __x64_sys_exit_group
 => do_syscall_64

So, when a process exits,

- a large number of user pages of the process will be freed without
  page allocation, it's highly possible that pcp->free_factor becomes
  > 0.

- after freeing all user pages, the PGD will be freed, which is a
  order-1 page freeing, PCP will be drained.

All in all, when a process exits, it's high possible that the PCP will
be drained.  This is an unexpected behavior.

To avoid this, in the patch, the PCP draining will only be triggered
for 2 consecutive high-order page freeing.

On a 2-socket Intel server with 224 logical CPU, we tested kbuild on
one socket with `make -j 112`.  With the patch, the build time
decreases 3.4% (from 206s to 199s).  The cycles% of the spinlock
contention (mostly for zone lock) decreases from 43.6% to 40.3% (with
PCP size == 361).  The number of PCP draining for high order pages
freeing (free_high) decreases 50.8%.

This helps network workload too for reduced zone lock contention.  On
a 2-socket Intel server with 128 logical CPU, with the patch, the
network bandwidth of the UNIX (AF_UNIX) test case of lmbench test
suite with 16-pair processes increase 17.1%.  The cycles% of the
spinlock contention (mostly for zone lock) decreases from 50.0% to
45.8%.  The number of PCP draining for high order pages
freeing (free_high) decreases 27.4%.  The cache miss rate keeps 0.3%.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <jweiner@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Lameter <cl@linux.com>
---
 include/linux/mmzone.h |  5 ++++-
 mm/page_alloc.c        | 11 ++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4106fbc5b4b3..64d5ed2bb724 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -676,12 +676,15 @@ enum zone_watermarks {
 #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
 #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
 
+#define	PCPF_PREV_FREE_HIGH_ORDER	0x01
+
 struct per_cpu_pages {
 	spinlock_t lock;	/* Protects lists field */
 	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
-	short free_factor;	/* batch scaling factor during free */
+	u8 flags;		/* protected by pcp->lock */
+	u8 free_factor;		/* batch scaling factor during free */
 #ifdef CONFIG_NUMA
 	short expire;		/* When 0, remote pagesets are drained */
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0c5be12f9336..828dcc24b030 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2370,7 +2370,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 {
 	int high;
 	int pindex;
-	bool free_high;
+	bool free_high = false;
 
 	__count_vm_events(PGFREE, 1 << order);
 	pindex = order_to_pindex(migratetype, order);
@@ -2383,8 +2383,13 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	 * freeing without allocation. The remainder after bulk freeing
 	 * stops will be drained from vmstat refresh context.
 	 */
-	free_high = (pcp->free_factor && order && order <= PAGE_ALLOC_COSTLY_ORDER);
-
+	if (order && order <= PAGE_ALLOC_COSTLY_ORDER) {
+		free_high = (pcp->free_factor &&
+			     (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER));
+		pcp->flags |= PCPF_PREV_FREE_HIGH_ORDER;
+	} else if (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) {
+		pcp->flags &= ~PCPF_PREV_FREE_HIGH_ORDER;
+	}
 	high = nr_pcp_high(pcp, zone, free_high);
 	if (pcp->count >= high) {
 		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, free_high), pcp, pindex);
-- 
2.39.2

