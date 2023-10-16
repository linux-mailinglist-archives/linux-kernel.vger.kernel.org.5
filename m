Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B297C9EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjJPFal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjJPFag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:30:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CE1EB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697434231; x=1728970231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UjGG03uSU9scSCPZWKrCozXwLS8Efdo9vVeSGMTDY0g=;
  b=Sr1B9FfN37v+qc3sXW4PrN6sHmE1Z1dLeXeYAow4gjmjWz9h9ScCJ4PO
   aRgdzGO1/CEyk9wsN3PAzFr4Shz8c3fbzUsq70+3Fh5psfvLmiX7apkJZ
   eYwgzgBiiUi6HNdUxnqQXQtFxBdq0g+b2VyMG5hBxkzowZvV4j04C8xeR
   fTMzWOWaJHcKqAxX7P+nMGTfxGB726v9aG2nKV1F6YhJt6j/Mpbb3qiDW
   69d3aYEsIgYutMG2vU4Zaur0+T1v3mkKNVtrB2CfBqiacAaZTu01VrP6m
   6/ZVBDImc+tls0l+r1jr4fFGRS7lL1SBdN95IG721RGCl7k/hFM0KocFa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389307992"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389307992"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899356680"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899356680"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:28:29 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH -V3 3/9] mm, pcp: reduce lock contention for draining high-order pages
Date:   Mon, 16 Oct 2023 13:29:56 +0800
Message-Id: <20231016053002.756205-4-ying.huang@intel.com>
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
improve the cache-hot pages reusing between page allocating and
freeing CPUs.

On system with small per-CPU data cache slice, pages shouldn't be
cached before draining to guarantee cache-hot.  But on a system with
large per-CPU data cache slice, some pages can be cached before
draining to reduce zone lock contention.

So, in this patch, instead of draining without any caching,
"pcp->batch" pages will be cached in PCP before draining if the
size of the per-CPU data cache slice is more than "3 * batch".

In theory, if the size of per-CPU data cache slice is more than "2 *
batch", we can reuse cache-hot pages between CPUs.  But considering
the other usage of cache (code, other data accessing, etc.), "3 *
batch" is used.

Note: "3 * batch" is chosen to make sure the optimization works on
recent x86_64 server CPUs.  If you want to increase it, please check
whether it breaks the optimization.

On a 2-socket Intel server with 128 logical CPU, with the patch, the
network bandwidth of the UNIX (AF_UNIX) test case of lmbench test
suite with 16-pair processes increase 70.5%.  The cycles% of the
spinlock contention (mostly for zone lock) decreases from 46.1% to
21.3%.  The number of PCP draining for high order pages
freeing (free_high) decreases 89.9%.  The cache miss rate keeps 0.2%.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
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
 include/linux/mmzone.h   |  6 ++++++
 mm/page_alloc.c          | 38 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 585c66fce9d9..f1e79263fe61 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -950,6 +950,7 @@ static int cacheinfo_cpu_online(unsigned int cpu)
 	if (rc)
 		goto err;
 	update_per_cpu_data_slice_size(true, cpu);
+	setup_pcp_cacheinfo();
 	return 0;
 err:
 	free_cache_attributes(cpu);
@@ -963,6 +964,7 @@ static int cacheinfo_cpu_pre_down(unsigned int cpu)
 
 	free_cache_attributes(cpu);
 	update_per_cpu_data_slice_size(false, cpu);
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
index 19c40a6f7e45..cdff247e8c6f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -682,8 +682,14 @@ enum zone_watermarks {
  * PCPF_PREV_FREE_HIGH_ORDER: a high-order page is freed in the
  * previous page freeing.  To avoid to drain PCP for an accident
  * high-order page freeing.
+ *
+ * PCPF_FREE_HIGH_BATCH: preserve "pcp->batch" pages in PCP before
+ * draining PCP for consecutive high-order pages freeing without
+ * allocation if data cache slice of CPU is large enough.  To reduce
+ * zone lock contention and keep cache-hot pages reusing.
  */
 #define	PCPF_PREV_FREE_HIGH_ORDER	BIT(0)
+#define	PCPF_FREE_HIGH_BATCH		BIT(1)
 
 struct per_cpu_pages {
 	spinlock_t lock;	/* Protects lists field */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 295e61f0c49d..ba2d8f06523e 100644
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
@@ -5418,6 +5421,39 @@ static void zone_pcp_update(struct zone *zone, int cpu_online)
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
+		 * If data cache slice of CPU is large enough, "pcp->batch"
+		 * pages can be preserved in PCP before draining PCP for
+		 * consecutive high-order pages freeing without allocation.
+		 * This can reduce zone lock contention without hurting
+		 * cache-hot pages sharing.
+		 */
+		spin_lock(&pcp->lock);
+		if ((cci->per_cpu_data_slice_size >> PAGE_SHIFT) > 3 * pcp->batch)
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

