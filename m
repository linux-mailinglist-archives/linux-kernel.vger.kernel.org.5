Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0634E7C9ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjJPFbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjJPFaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:30:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1AB134
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697434242; x=1728970242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DB51T+n1GD7jCWJPVbTjdF4dWPaoZxyz7GoPTpVRQSU=;
  b=lvl+XjhyJ/oIOPe556a6OwexJ55TAWy1cxw+x3ATTqk1OJ3ASdDSFIqa
   Kv8PxJkAEPmUrlkbW1pqeTMcV8Diq+nlR44fBJQlmBJIVr64rKimxiHys
   ZUGVKwUPIug1TfoKf5rev5tKGhrno+VZXIU6F1pgVp611KXvYVDl7e2uC
   /6UWQIYKRlaUB7V1R4+WJOnaoiuO1eppG/bB5W/QuS38YeR0sciNbN1WT
   Ftq/BeH4qlpPcn1RzvDN9c+6wqUMKMcFjpiOhgG1rfALfkN3S3EFuuzY/
   DinFpB8VU1b5ULW0dqluZ9d8zIY59SRZ1NIOvu3ooyKIFl0fU+uSFU92S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389308057"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389308057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:30:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899356724"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899356724"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:28:40 -0700
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
Subject: [PATCH -V3 6/9] mm: add framework for PCP high auto-tuning
Date:   Mon, 16 Oct 2023 13:29:59 +0800
Message-Id: <20231016053002.756205-7-ying.huang@intel.com>
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

The page allocation performance requirements of different workloads
are usually different.  So, we need to tune PCP (per-CPU pageset) high
to optimize the workload page allocation performance.  Now, we have a
system wide sysctl knob (percpu_pagelist_high_fraction) to tune PCP
high by hand.  But, it's hard to find out the best value by hand.  And
one global configuration may not work best for the different workloads
that run on the same system.  One solution to these issues is to tune
PCP high of each CPU automatically.

This patch adds the framework for PCP high auto-tuning.  With it,
pcp->high of each CPU will be changed automatically by tuning
algorithm at runtime.  The minimal high (pcp->high_min) is the
original PCP high value calculated based on the low watermark pages.
While the maximal high (pcp->high_max) is the PCP high value when
percpu_pagelist_high_fraction sysctl knob is set to
MIN_PERCPU_PAGELIST_HIGH_FRACTION.  That is, the maximal pcp->high
that can be set via sysctl knob by hand.

It's possible that PCP high auto-tuning doesn't work well for some
workloads.  So, when PCP high is tuned by hand via the sysctl knob,
the auto-tuning will be disabled.  The PCP high set by hand will be
used instead.

This patch only adds the framework, so pcp->high will be set to
pcp->high_min (original default) always.  We will add actual
auto-tuning algorithm in the following patches in the series.

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
 include/linux/mmzone.h |  5 ++-
 mm/page_alloc.c        | 71 +++++++++++++++++++++++++++---------------
 2 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ba548ae20686..ec3f7daedcc7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -695,6 +695,8 @@ struct per_cpu_pages {
 	spinlock_t lock;	/* Protects lists field */
 	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
+	int high_min;		/* min high watermark */
+	int high_max;		/* max high watermark */
 	int batch;		/* chunk size for buddy add/remove */
 	u8 flags;		/* protected by pcp->lock */
 	u8 alloc_factor;	/* batch scaling factor during allocate */
@@ -854,7 +856,8 @@ struct zone {
 	 * the high and batch values are copied to individual pagesets for
 	 * faster access
 	 */
-	int pageset_high;
+	int pageset_high_min;
+	int pageset_high_max;
 	int pageset_batch;
 
 #ifndef CONFIG_SPARSEMEM
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eeef0ead1c2a..1fb2c6ebde9c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2350,7 +2350,7 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int high, bool free_high)
 static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 		       bool free_high)
 {
-	int high = READ_ONCE(pcp->high);
+	int high = READ_ONCE(pcp->high_min);
 
 	if (unlikely(!high || free_high))
 		return 0;
@@ -2689,7 +2689,7 @@ static int nr_pcp_alloc(struct per_cpu_pages *pcp, int order)
 {
 	int high, batch, max_nr_alloc;
 
-	high = READ_ONCE(pcp->high);
+	high = READ_ONCE(pcp->high_min);
 	batch = READ_ONCE(pcp->batch);
 
 	/* Check for PCP disabled or boot pageset */
@@ -5296,14 +5296,15 @@ static int zone_batchsize(struct zone *zone)
 }
 
 static int percpu_pagelist_high_fraction;
-static int zone_highsize(struct zone *zone, int batch, int cpu_online)
+static int zone_highsize(struct zone *zone, int batch, int cpu_online,
+			 int high_fraction)
 {
 #ifdef CONFIG_MMU
 	int high;
 	int nr_split_cpus;
 	unsigned long total_pages;
 
-	if (!percpu_pagelist_high_fraction) {
+	if (!high_fraction) {
 		/*
 		 * By default, the high value of the pcp is based on the zone
 		 * low watermark so that if they are full then background
@@ -5316,15 +5317,15 @@ static int zone_highsize(struct zone *zone, int batch, int cpu_online)
 		 * value is based on a fraction of the managed pages in the
 		 * zone.
 		 */
-		total_pages = zone_managed_pages(zone) / percpu_pagelist_high_fraction;
+		total_pages = zone_managed_pages(zone) / high_fraction;
 	}
 
 	/*
 	 * Split the high value across all online CPUs local to the zone. Note
 	 * that early in boot that CPUs may not be online yet and that during
 	 * CPU hotplug that the cpumask is not yet updated when a CPU is being
-	 * onlined. For memory nodes that have no CPUs, split pcp->high across
-	 * all online CPUs to mitigate the risk that reclaim is triggered
+	 * onlined. For memory nodes that have no CPUs, split the high value
+	 * across all online CPUs to mitigate the risk that reclaim is triggered
 	 * prematurely due to pages stored on pcp lists.
 	 */
 	nr_split_cpus = cpumask_weight(cpumask_of_node(zone_to_nid(zone))) + cpu_online;
@@ -5352,19 +5353,21 @@ static int zone_highsize(struct zone *zone, int batch, int cpu_online)
  * However, guaranteeing these relations at all times would require e.g. write
  * barriers here but also careful usage of read barriers at the read side, and
  * thus be prone to error and bad for performance. Thus the update only prevents
- * store tearing. Any new users of pcp->batch and pcp->high should ensure they
- * can cope with those fields changing asynchronously, and fully trust only the
- * pcp->count field on the local CPU with interrupts disabled.
+ * store tearing. Any new users of pcp->batch, pcp->high_min and pcp->high_max
+ * should ensure they can cope with those fields changing asynchronously, and
+ * fully trust only the pcp->count field on the local CPU with interrupts
+ * disabled.
  *
  * mutex_is_locked(&pcp_batch_high_lock) required when calling this function
  * outside of boot time (or some other assurance that no concurrent updaters
  * exist).
  */
-static void pageset_update(struct per_cpu_pages *pcp, unsigned long high,
-		unsigned long batch)
+static void pageset_update(struct per_cpu_pages *pcp, unsigned long high_min,
+			   unsigned long high_max, unsigned long batch)
 {
 	WRITE_ONCE(pcp->batch, batch);
-	WRITE_ONCE(pcp->high, high);
+	WRITE_ONCE(pcp->high_min, high_min);
+	WRITE_ONCE(pcp->high_max, high_max);
 }
 
 static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonestat *pzstats)
@@ -5384,20 +5387,21 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	 * need to be as careful as pageset_update() as nobody can access the
 	 * pageset yet.
 	 */
-	pcp->high = BOOT_PAGESET_HIGH;
+	pcp->high_min = BOOT_PAGESET_HIGH;
+	pcp->high_max = BOOT_PAGESET_HIGH;
 	pcp->batch = BOOT_PAGESET_BATCH;
 	pcp->free_factor = 0;
 }
 
-static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
-		unsigned long batch)
+static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high_min,
+					      unsigned long high_max, unsigned long batch)
 {
 	struct per_cpu_pages *pcp;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
 		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-		pageset_update(pcp, high, batch);
+		pageset_update(pcp, high_min, high_max, batch);
 	}
 }
 
@@ -5407,19 +5411,34 @@ static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long h
  */
 static void zone_set_pageset_high_and_batch(struct zone *zone, int cpu_online)
 {
-	int new_high, new_batch;
+	int new_high_min, new_high_max, new_batch;
 
 	new_batch = max(1, zone_batchsize(zone));
-	new_high = zone_highsize(zone, new_batch, cpu_online);
+	if (percpu_pagelist_high_fraction) {
+		new_high_min = zone_highsize(zone, new_batch, cpu_online,
+					     percpu_pagelist_high_fraction);
+		/*
+		 * PCP high is tuned manually, disable auto-tuning via
+		 * setting high_min and high_max to the manual value.
+		 */
+		new_high_max = new_high_min;
+	} else {
+		new_high_min = zone_highsize(zone, new_batch, cpu_online, 0);
+		new_high_max = zone_highsize(zone, new_batch, cpu_online,
+					     MIN_PERCPU_PAGELIST_HIGH_FRACTION);
+	}
 
-	if (zone->pageset_high == new_high &&
+	if (zone->pageset_high_min == new_high_min &&
+	    zone->pageset_high_max == new_high_max &&
 	    zone->pageset_batch == new_batch)
 		return;
 
-	zone->pageset_high = new_high;
+	zone->pageset_high_min = new_high_min;
+	zone->pageset_high_max = new_high_max;
 	zone->pageset_batch = new_batch;
 
-	__zone_set_pageset_high_and_batch(zone, new_high, new_batch);
+	__zone_set_pageset_high_and_batch(zone, new_high_min, new_high_max,
+					  new_batch);
 }
 
 void __meminit setup_zone_pageset(struct zone *zone)
@@ -5528,7 +5547,8 @@ __meminit void zone_pcp_init(struct zone *zone)
 	 */
 	zone->per_cpu_pageset = &boot_pageset;
 	zone->per_cpu_zonestats = &boot_zonestats;
-	zone->pageset_high = BOOT_PAGESET_HIGH;
+	zone->pageset_high_min = BOOT_PAGESET_HIGH;
+	zone->pageset_high_max = BOOT_PAGESET_HIGH;
 	zone->pageset_batch = BOOT_PAGESET_BATCH;
 
 	if (populated_zone(zone))
@@ -6430,13 +6450,14 @@ EXPORT_SYMBOL(free_contig_range);
 void zone_pcp_disable(struct zone *zone)
 {
 	mutex_lock(&pcp_batch_high_lock);
-	__zone_set_pageset_high_and_batch(zone, 0, 1);
+	__zone_set_pageset_high_and_batch(zone, 0, 0, 1);
 	__drain_all_pages(zone, true);
 }
 
 void zone_pcp_enable(struct zone *zone)
 {
-	__zone_set_pageset_high_and_batch(zone, zone->pageset_high, zone->pageset_batch);
+	__zone_set_pageset_high_and_batch(zone, zone->pageset_high_min,
+		zone->pageset_high_max, zone->pageset_batch);
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
-- 
2.39.2

