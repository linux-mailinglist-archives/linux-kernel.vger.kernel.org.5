Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31457C9EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjJPFa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJPFaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:30:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1E0A1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697434223; x=1728970223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yIFg5arfuvqezYrEgzPwE443naXU4SI+Zr6n5bfusVQ=;
  b=WL3n7xvc/cd4hOuYwHbwoj1k035a9tgQU/5K2ewvYxK+k2K6cAWctfh4
   HFOvU9JZbEj2p2VYkGZFQfu1yhpduc+BgxqDiEyf4HwUZGW9GbbBGFeBm
   3i9gMSVWOuy0btHiQwmG88W+8pvylzw83uNHx+l0A8Yw32Eq0AkinKqd7
   3zbaguTXAIS+0U1wtgFySBiRsjxyDUt0aIB286VDHtzf2pqTuxDKFgm96
   8POxpWkQRrIF8Im55ALH2ewmEQn4UoP//oXifW7T+0HE8Yn++pzlaWQ6P
   y/iwGwTkJ3CIoZHtooQPQwoAAeK+aNMj1afwp/XpU3Op4xeKfzreD6SFa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389307939"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389307939"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:30:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899356632"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899356632"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:28:22 -0700
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
Subject: [PATCH -V3 1/9] mm, pcp: avoid to drain PCP when process exit
Date:   Mon, 16 Oct 2023 13:29:54 +0800
Message-Id: <20231016053002.756205-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016053002.756205-1-ying.huang@intel.com>
References: <20231016053002.756205-1-ying.huang@intel.com>
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
  page allocation, it's highly possible that pcp->free_factor becomes >
  0.  In fact, this is expected behavior to improve process exit
  performance.

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
zone lock) decreases from 14.0% to 12.8% (with PCP size == 367).  The
number of PCP draining for high order pages freeing (free_high)
decreases 80.5%.

This helps network workload too for reduced zone lock contention.  On
a 2-socket Intel server with 128 logical CPU, with the patch, the
network bandwidth of the UNIX (AF_UNIX) test case of lmbench test
suite with 16-pair processes increase 16.8%.  The cycles% of the
spinlock contention (mostly for zone lock) decreases from 51.4% to
46.1%.  The number of PCP draining for high order pages
freeing (free_high) decreases 30.5%.  The cache miss rate keeps 0.2%.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <jweiner@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Lameter <cl@linux.com>
---
 include/linux/mmzone.h | 12 +++++++++++-
 mm/page_alloc.c        | 11 ++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4106fbc5b4b3..19c40a6f7e45 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -676,12 +676,22 @@ enum zone_watermarks {
 #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
 #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
 
+/*
+ * Flags used in pcp->flags field.
+ *
+ * PCPF_PREV_FREE_HIGH_ORDER: a high-order page is freed in the
+ * previous page freeing.  To avoid to drain PCP for an accident
+ * high-order page freeing.
+ */
+#define	PCPF_PREV_FREE_HIGH_ORDER	BIT(0)
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

