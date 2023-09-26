Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694037AE584
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjIZGJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjIZGJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:09:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DA5FF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695708578; x=1727244578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DeMClJs3Mthv/xHdoFt3z4ewOtGnsu4v3P02NwqV+vA=;
  b=VOBmpBkdzmmxLP1p7/AsfxqbnDSe427lVvh7D3GTe6lBuSZs+wlZ5tt1
   opVjduS2p950Kr/MPJgOj12Muy2YH+AdliJuI3zUtyFzF5xyIlQw3Tvu9
   7SVwm2sw5MF69YxZlhmoUSFt0uXZbbDFFgcXO2wFl9jfxmHt85GK6hVHt
   k/9Cx18eIAPa0SlDH/7byTozJJ0nTA4vOrPetiAMbaOozN3ihWTK4IA7C
   Nrd2qjK4i5S1Uz00vXkuVtvy1oosSOGqDMUKhR+1Bx2OVNjKpq2FyvrTb
   5aOA6fazUjo/o6dQixIZYM2j336UOzaDvY7A74Ym93gRbj6pKNjW+28BJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447991309"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="447991309"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="892075877"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="892075877"
Received: from aozhu-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.94])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:08:30 -0700
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
Subject: [PATCH -V2 03/10] mm, pcp: reduce lock contention for draining high-order pages
Date:   Tue, 26 Sep 2023 14:09:04 +0800
Message-Id: <20230926060911.266511-4-ying.huang@intel.com>
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
improve the cache-hot pages reusing between page allocating and
freeing CPUs.

On system with small per-CPU data cache, pages shouldn't be cached
before draining to guarantee cache-hot.  But on a system with large
per-CPU data cache, more pages can be cached before draining to reduce
zone lock contention.

So, in this patch, instead of draining without any caching, "batch"
pages will be cached in PCP before draining if the per-CPU data cache
size is more than "4 * batch".

On a 2-socket Intel server with 128 logical CPU, with the patch, the
network bandwidth of the UNIX (AF_UNIX) test case of lmbench test
suite with 16-pair processes increase 72.2%.  The cycles% of the
spinlock contention (mostly for zone lock) decreases from 45.8% to
21.2%.  The number of PCP draining for high order pages
freeing (free_high) decreases 89.8%.  The cache miss rate keeps 0.3%.

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
 drivers/base/cacheinfo.c |  2 ++
 include/linux/gfp.h      |  1 +
 include/linux/mmzone.h   |  1 +
 mm/page_alloc.c          | 37 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 3e8951a3fbab..a55b2f83958b 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -943,6 +943,7 @@ static int cacheinfo_cpu_online(unsigned int cpu)
 	if (rc)
 		goto err;
 	update_data_cache_size(true, cpu);
+	setup_pcp_cacheinfo();
 	return 0;
 err:
 	free_cache_attributes(cpu);
@@ -956,6 +957,7 @@ static int cacheinfo_cpu_pre_down(unsigned int cpu)
 
 	free_cache_attributes(cpu);
 	update_data_cache_size(false, cpu);
+	setup_pcp_cacheinfo();
 	return 0;
 }
 
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 665f06675c83..665edc11fb9f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -325,6 +325,7 @@ void drain_all_pages(struct zone *zone);
 void drain_local_pages(struct zone *zone);
 
 void page_alloc_init_late(void);
+void setup_pcp_cacheinfo(void);
 
 /*
  * gfp_allowed_mask is set to GFP_BOOT_MASK during early boot to restrict what
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 64d5ed2bb724..4132e7490b49 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -677,6 +677,7 @@ enum zone_watermarks {
 #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
 
 #define	PCPF_PREV_FREE_HIGH_ORDER	0x01
+#define	PCPF_FREE_HIGH_BATCH		0x02
 
 struct per_cpu_pages {
 	spinlock_t lock;	/* Protects lists field */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 295e61f0c49d..e97814985710 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -52,6 +52,7 @@
 #include <linux/psi.h>
 #include <linux/khugepaged.h>
 #include <linux/delayacct.h>
+#include <linux/cacheinfo.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -2385,7 +2386,9 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	 */
 	if (order && order <= PAGE_ALLOC_COSTLY_ORDER) {
 		free_high = (pcp->free_factor &&
-			     (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER));
+			     (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) &&
+			     (!(pcp->flags & PCPF_FREE_HIGH_BATCH) ||
+			      pcp->count >= READ_ONCE(pcp->batch)));
 		pcp->flags |= PCPF_PREV_FREE_HIGH_ORDER;
 	} else if (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) {
 		pcp->flags &= ~PCPF_PREV_FREE_HIGH_ORDER;
@@ -5418,6 +5421,38 @@ static void zone_pcp_update(struct zone *zone, int cpu_online)
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
+static void zone_pcp_update_cacheinfo(struct zone *zone)
+{
+	int cpu;
+	struct per_cpu_pages *pcp;
+	struct cpu_cacheinfo *cci;
+
+	for_each_online_cpu(cpu) {
+		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+		cci = get_cpu_cacheinfo(cpu);
+		/*
+		 * If per-CPU data cache is large enough, up to
+		 * "batch" high-order pages can be cached in PCP for
+		 * consecutive freeing.  This can reduce zone lock
+		 * contention without hurting cache-hot pages sharing.
+		 */
+		spin_lock(&pcp->lock);
+		if ((cci->size_data >> PAGE_SHIFT) > 4 * pcp->batch)
+			pcp->flags |= PCPF_FREE_HIGH_BATCH;
+		else
+			pcp->flags &= ~PCPF_FREE_HIGH_BATCH;
+		spin_unlock(&pcp->lock);
+	}
+}
+
+void setup_pcp_cacheinfo(void)
+{
+	struct zone *zone;
+
+	for_each_populated_zone(zone)
+		zone_pcp_update_cacheinfo(zone);
+}
+
 /*
  * Allocate per cpu pagesets and initialize them.
  * Before this call only boot pagesets were available.
-- 
2.39.2

