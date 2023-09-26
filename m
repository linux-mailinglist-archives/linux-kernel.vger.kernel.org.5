Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673187AE587
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjIZGJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbjIZGJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:09:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E90F0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695708571; x=1727244571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kkrugMJHHzL4iBIjWV0YJcdllhvq6CWQwVNpR1GjvwQ=;
  b=UQFp8K2cLTI+CrWy3bpWxIrGTNWTQhIqU72TogVb/U49x5IYBKGO4s2H
   kBCjXxJG108gMM9gcbh+/KUhvMR75l/LBjdOdYQsne55RLaXdrBgnb0M2
   xXaFgoHtf5FmuOR6S0v/lED9HqNTBio5y49ZURkr0Ugi7ROaqWkqNDKfu
   l7dPAQUsM0D2GYRvvCyHeG1JtuFFNEHBYMMPux5Tbz9NdBg0O8yr3jcxD
   /vMjed6jLOwy2sKPQyBCYA+XZxnDFTkUj9Z7tJAp2Yo4CbEJzs6bcFkrF
   yorZTQvaY6aHaCj3KeNXRayGcJjBh759k5yTcSkZJwTMhmBxvv2srXCi4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447991263"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="447991263"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:09:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="892075849"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="892075849"
Received: from aozhu-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.94])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:08:22 -0700
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
Subject: [PATCH -V2 01/10] mm, pcp: avoid to drain PCP when process exit
Date:   Tue, 26 Sep 2023 14:09:02 +0800
Message-Id: <20230926060911.266511-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926060911.266511-1-ying.huang@intel.com>
References: <20230926060911.266511-1-ying.huang@intel.com>
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

On a 2-socket Intel server with 224 logical CPU, we run 8 kbuild
instances in parallel (each with `make -j 28`) in 8 cgroup.  This
simulates the kbuild server that is used by 0-Day kbuild service.
With the patch, the cycles% of the spinlock contention (mostly for
zone lock) decreases from 13.5% to 10.6% (with PCP size == 361).  The
number of PCP draining for high order pages freeing (free_high)
decreases 80.8%.

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
index 95546f376302..295e61f0c49d 100644
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

