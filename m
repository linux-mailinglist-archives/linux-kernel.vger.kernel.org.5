Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1527C7A72B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjITGUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjITGTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:19:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93375B9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695190785; x=1726726785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gl8Dsupvu0i/ycW4/TMF2HWHASVPpn6wN7AOIH8Z+Fc=;
  b=VxVNqNbvSOot9d5k7Kjb5vSHbRAhnoWYCocgTeM4RNrq8pV4KJzumhKo
   2VjoMKHNBfOtfx1u148N6aUsWHnPF3grRKenn540EUGjEYVaDNcVPdU45
   oZNEd0bkTBT2YRc0BUDEKplVXI1v0bpeqF6m9s2TSOBfQ1E9tWp+UEPM0
   89TLnDeZznsSUWVPsmynXJS+TQASga+547zs/eKreF5aNhtg4nXGlXSRT
   ThA1D/xt7ag0Flokfhj3qxHyGyQpfVyOviBjeL7fjBjd0wheJsBZx2YkZ
   O+4dQXgITFqnRd5Bgpj4lp+V4xx+hz+XsDWeNpaLjchIQINDthTnpnwnG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="365187621"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="365187621"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:19:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="740060540"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="740060540"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:19:41 -0700
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
Subject: [PATCH 03/10] mm, pcp: reduce lock contention for draining high-order pages
Date:   Wed, 20 Sep 2023 14:18:49 +0800
Message-Id: <20230920061856.257597-4-ying.huang@intel.com>
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
index 828dcc24b030..06aa9c5687e0 100644
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

