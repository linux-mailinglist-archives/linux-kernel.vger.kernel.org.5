Return-Path: <linux-kernel+bounces-39757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4D183D5C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE58B274F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E786720DC9;
	Fri, 26 Jan 2024 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUaDqEfF"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78489C2FE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257211; cv=none; b=uwJlzbxwWxQwiuIwfzmfXV3abek8vWjmtjn0TlGCEpYH5rnGjmjWFqqhAdRdMSK6nBqo8aWQszAgub5luXdW50uiS0vIZGW1iIQLZnMLKcBN28NG23dIyZ63850jhEBmB6F4erZJKVAgw9RnwBt7N5hh6OqU/QpPVBjY0ph1hsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257211; c=relaxed/simple;
	bh=OD0YTTntqeuNvF0BaJzpRDfSOwaABfzWUmxl74XDdto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mxKUf6Me+8W8rKmuk9ozRsDH+oOMn0VxKvkHoNRCbYyv3n+48vl0eAFGozqYuS8OBTm7zkjV3kbabkbGV6it3ti7hGOEPa2XZOAGd9cPhPR2kvSYA31jdpG6ZVaYLNGrA03dqxaJBHmbDlIIF910g3FNnRX27zPsKoMtbMaRvCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUaDqEfF; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706257209; x=1737793209;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OD0YTTntqeuNvF0BaJzpRDfSOwaABfzWUmxl74XDdto=;
  b=AUaDqEfF0aatqyjMEMMcbXEeboK89W1mmWzOc4qqR0Y9pO6LD8d6CWfl
   z//f/TW+xEeErBFZlrrX77rwe27blBVd/wXwcCWsaNCf8OxIWpQYrvZRD
   8H6oPvYOYytAELeJeB8uOaBRuHV5FHfzBB2zN+ajeXmGMnUecG6gvyT9y
   8z1A1eMm0qIHn8AzN0Z3TLfnPjOy81VPi/gccnkB90pQYv0qfYkxIbeYq
   IdREq0GA5QibIiPFwwBtLNZHAngHF1IZFY/GpWdf6pg0bHQWVd6QkwM/k
   5Im44HEy4ax5mK735/tljl7C6d2l5el9RPwFo8YDPjXYXcFS3uJZWL2Xo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="402070536"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="402070536"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 00:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2678380"
Received: from yahuili1-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.29.54])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 00:20:06 -0800
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Kyle Meyer <kyle.meyer@hpe.com>,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH] mm and cache_info: remove unnecessary CPU cache info update
Date: Fri, 26 Jan 2024 16:19:44 +0800
Message-Id: <20240126081944.414520-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For each CPU hotplug event, we will update per-CPU data slice size and
corresponding PCP configuration for every online CPU to make the
implementation simple.  But, Kyle reported that this takes tens
seconds during boot on a machine with 34 zones and 3840 CPUs.

So, in this patch, for each CPU hotplug event, we only update per-CPU
data slice size and corresponding PCP configuration for the CPUs that
share caches with the hotplugged CPU.  With the patch, the system boot
time reduces 67 seconds on the machine.

Fixes: 362d37a106dd ("mm, pcp: reduce lock contention for draining high-order pages")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Originally-by: Kyle Meyer <kyle.meyer@hpe.com>
Reported-and-tested-by: Kyle Meyer <kyle.meyer@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
---
 drivers/base/cacheinfo.c | 50 +++++++++++++++++++++++++++++++++++-----
 include/linux/gfp.h      |  2 +-
 mm/page_alloc.c          | 39 +++++++++++++++----------------
 3 files changed, 63 insertions(+), 28 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index f1e79263fe61..23b8cba4a2a3 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -898,6 +898,37 @@ static int cache_add_dev(unsigned int cpu)
 	return rc;
 }
 
+static unsigned int cpu_map_shared_cache(bool online, unsigned int cpu,
+					 cpumask_t **map)
+{
+	struct cacheinfo *llc, *sib_llc;
+	unsigned int sibling;
+
+	if (!last_level_cache_is_valid(cpu))
+		return 0;
+
+	llc = per_cpu_cacheinfo_idx(cpu, cache_leaves(cpu) - 1);
+
+	if (llc->type != CACHE_TYPE_DATA && llc->type != CACHE_TYPE_UNIFIED)
+		return 0;
+
+	if (online) {
+		*map = &llc->shared_cpu_map;
+		return cpumask_weight(*map);
+	}
+
+	/* shared_cpu_map of offlined CPU will be cleared, so use sibling map */
+	for_each_cpu(sibling, &llc->shared_cpu_map) {
+		if (sibling == cpu || !last_level_cache_is_valid(sibling))
+			continue;
+		sib_llc = per_cpu_cacheinfo_idx(sibling, cache_leaves(sibling) - 1);
+		*map = &sib_llc->shared_cpu_map;
+		return cpumask_weight(*map);
+	}
+
+	return 0;
+}
+
 /*
  * Calculate the size of the per-CPU data cache slice.  This can be
  * used to estimate the size of the data cache slice that can be used
@@ -929,28 +960,31 @@ static void update_per_cpu_data_slice_size_cpu(unsigned int cpu)
 		ci->per_cpu_data_slice_size = llc->size / nr_shared;
 }
 
-static void update_per_cpu_data_slice_size(bool cpu_online, unsigned int cpu)
+static void update_per_cpu_data_slice_size(bool cpu_online, unsigned int cpu,
+					   cpumask_t *cpu_map)
 {
 	unsigned int icpu;
 
-	for_each_online_cpu(icpu) {
+	for_each_cpu(icpu, cpu_map) {
 		if (!cpu_online && icpu == cpu)
 			continue;
 		update_per_cpu_data_slice_size_cpu(icpu);
+		setup_pcp_cacheinfo(icpu);
 	}
 }
 
 static int cacheinfo_cpu_online(unsigned int cpu)
 {
 	int rc = detect_cache_attributes(cpu);
+	cpumask_t *cpu_map;
 
 	if (rc)
 		return rc;
 	rc = cache_add_dev(cpu);
 	if (rc)
 		goto err;
-	update_per_cpu_data_slice_size(true, cpu);
-	setup_pcp_cacheinfo();
+	if (cpu_map_shared_cache(true, cpu, &cpu_map))
+		update_per_cpu_data_slice_size(true, cpu, cpu_map);
 	return 0;
 err:
 	free_cache_attributes(cpu);
@@ -959,12 +993,16 @@ static int cacheinfo_cpu_online(unsigned int cpu)
 
 static int cacheinfo_cpu_pre_down(unsigned int cpu)
 {
+	cpumask_t *cpu_map;
+	unsigned int nr_shared;
+
+	nr_shared = cpu_map_shared_cache(false, cpu, &cpu_map);
 	if (cpumask_test_and_clear_cpu(cpu, &cache_dev_map))
 		cpu_cache_sysfs_exit(cpu);
 
 	free_cache_attributes(cpu);
-	update_per_cpu_data_slice_size(false, cpu);
-	setup_pcp_cacheinfo();
+	if (nr_shared > 1)
+		update_per_cpu_data_slice_size(false, cpu, cpu_map);
 	return 0;
 }
 
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index de292a007138..09e22091f1b0 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -334,7 +334,7 @@ void drain_all_pages(struct zone *zone);
 void drain_local_pages(struct zone *zone);
 
 void page_alloc_init_late(void);
-void setup_pcp_cacheinfo(void);
+void setup_pcp_cacheinfo(unsigned int cpu);
 
 /*
  * gfp_allowed_mask is set to GFP_BOOT_MASK during early boot to restrict what
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 150d4f23b010..9faca05d124e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5572,37 +5572,34 @@ static void zone_pcp_update(struct zone *zone, int cpu_online)
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
-static void zone_pcp_update_cacheinfo(struct zone *zone)
+static void zone_pcp_update_cacheinfo(struct zone *zone, unsigned int cpu)
 {
-	int cpu;
 	struct per_cpu_pages *pcp;
 	struct cpu_cacheinfo *cci;
 
-	for_each_online_cpu(cpu) {
-		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-		cci = get_cpu_cacheinfo(cpu);
-		/*
-		 * If data cache slice of CPU is large enough, "pcp->batch"
-		 * pages can be preserved in PCP before draining PCP for
-		 * consecutive high-order pages freeing without allocation.
-		 * This can reduce zone lock contention without hurting
-		 * cache-hot pages sharing.
-		 */
-		spin_lock(&pcp->lock);
-		if ((cci->per_cpu_data_slice_size >> PAGE_SHIFT) > 3 * pcp->batch)
-			pcp->flags |= PCPF_FREE_HIGH_BATCH;
-		else
-			pcp->flags &= ~PCPF_FREE_HIGH_BATCH;
-		spin_unlock(&pcp->lock);
-	}
+	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+	cci = get_cpu_cacheinfo(cpu);
+	/*
+	 * If data cache slice of CPU is large enough, "pcp->batch"
+	 * pages can be preserved in PCP before draining PCP for
+	 * consecutive high-order pages freeing without allocation.
+	 * This can reduce zone lock contention without hurting
+	 * cache-hot pages sharing.
+	 */
+	spin_lock(&pcp->lock);
+	if ((cci->per_cpu_data_slice_size >> PAGE_SHIFT) > 3 * pcp->batch)
+		pcp->flags |= PCPF_FREE_HIGH_BATCH;
+	else
+		pcp->flags &= ~PCPF_FREE_HIGH_BATCH;
+	spin_unlock(&pcp->lock);
 }
 
-void setup_pcp_cacheinfo(void)
+void setup_pcp_cacheinfo(unsigned int cpu)
 {
 	struct zone *zone;
 
 	for_each_populated_zone(zone)
-		zone_pcp_update_cacheinfo(zone);
+		zone_pcp_update_cacheinfo(zone, cpu);
 }
 
 /*
-- 
2.39.2


