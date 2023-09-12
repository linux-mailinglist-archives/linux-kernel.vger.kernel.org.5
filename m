Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142FE79C9B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjILIVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjILIVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:21:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769B910EB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694506899; x=1726042899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3k4HDKCDGdHFd+DzNOtZ0O6HlG4Fjz1fR7N6rjdBsuw=;
  b=LcpnclVgdyn37/XYgCS6A2j6og4lcS/uh5aQS2MVNdNaDmZ/+vVgmMPa
   uo499RBnfi8LpyiCdQaNx9IdsBnD/tsQTJLrQXX+YX/BP5gRMMiIkjnp6
   vMrkPGkTqrjp1xc6ztFrWqmRCsBreQxQ5SZIUp/b7s6N7B+k5N5RRhkT2
   lDbnf92AvHneNTZCTZPDSjBSDj6Mgje59o5PwzpONAFlBywg+9qTLXDpQ
   Rg90aDY5TcX3pgjri+xlPXMvQrYcVPPBQZuaDpl9n0q8Fe56wGd+eHaw5
   p0VblGAPFS1jOqKFk7PEx1OWP2fT0goh+M/Fun0tmeKqOnE4I9gmubKHC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="442323032"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="442323032"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 01:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746787634"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="746787634"
Received: from shicha9x-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.213])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 01:21:29 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH -V3 2/4] acpi, hmat: refactor hmat_register_target_initiators()
Date:   Tue, 12 Sep 2023 16:20:59 +0800
Message-Id: <20230912082101.342002-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912082101.342002-1-ying.huang@intel.com>
References: <20230912082101.342002-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, in hmat_register_target_initiators(), the performance
attributes are calculated and the corresponding sysfs links and files
are created too.  Which is called during memory onlining.

But now, to calculate the abstract distance of a memory target before
memory onlining, we need to calculate the performance attributes for
a memory target without creating sysfs links and files.

To do that, hmat_register_target_initiators() is refactored to make it
possible to calculate performance attributes separately.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Tested-by: Alistair Popple <apopple@nvidia.com>
Tested-by: Bharata B Rao <bharata@amd.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/numa/hmat.c | 81 +++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 51 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index bba268ecd802..2dee0098f1a9 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -582,28 +582,25 @@ static int initiators_to_nodemask(unsigned long *p_nodes)
 	return 0;
 }
 
-static void hmat_register_target_initiators(struct memory_target *target)
+static void hmat_update_target_attrs(struct memory_target *target,
+				     unsigned long *p_nodes, int access)
 {
-	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
 	struct memory_initiator *initiator;
-	unsigned int mem_nid, cpu_nid;
+	unsigned int cpu_nid;
 	struct memory_locality *loc = NULL;
 	u32 best = 0;
-	bool access0done = false;
 	int i;
 
-	mem_nid = pxm_to_node(target->memory_pxm);
+	bitmap_zero(p_nodes, MAX_NUMNODES);
 	/*
-	 * If the Address Range Structure provides a local processor pxm, link
+	 * If the Address Range Structure provides a local processor pxm, set
 	 * only that one. Otherwise, find the best performance attributes and
-	 * register all initiators that match.
+	 * collect all initiators that match.
 	 */
 	if (target->processor_pxm != PXM_INVAL) {
 		cpu_nid = pxm_to_node(target->processor_pxm);
-		register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
-		access0done = true;
-		if (node_state(cpu_nid, N_CPU)) {
-			register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
+		if (access == 0 || node_state(cpu_nid, N_CPU)) {
+			set_bit(target->processor_pxm, p_nodes);
 			return;
 		}
 	}
@@ -617,47 +614,10 @@ static void hmat_register_target_initiators(struct memory_target *target)
 	 * We'll also use the sorting to prime the candidate nodes with known
 	 * initiators.
 	 */
-	bitmap_zero(p_nodes, MAX_NUMNODES);
 	list_sort(NULL, &initiators, initiator_cmp);
 	if (initiators_to_nodemask(p_nodes) < 0)
 		return;
 
-	if (!access0done) {
-		for (i = WRITE_LATENCY; i <= READ_BANDWIDTH; i++) {
-			loc = localities_types[i];
-			if (!loc)
-				continue;
-
-			best = 0;
-			list_for_each_entry(initiator, &initiators, node) {
-				u32 value;
-
-				if (!test_bit(initiator->processor_pxm, p_nodes))
-					continue;
-
-				value = hmat_initiator_perf(target, initiator,
-							    loc->hmat_loc);
-				if (hmat_update_best(loc->hmat_loc->data_type, value, &best))
-					bitmap_clear(p_nodes, 0, initiator->processor_pxm);
-				if (value != best)
-					clear_bit(initiator->processor_pxm, p_nodes);
-			}
-			if (best)
-				hmat_update_target_access(target, loc->hmat_loc->data_type,
-							  best, 0);
-		}
-
-		for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
-			cpu_nid = pxm_to_node(i);
-			register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
-		}
-	}
-
-	/* Access 1 ignores Generic Initiators */
-	bitmap_zero(p_nodes, MAX_NUMNODES);
-	if (initiators_to_nodemask(p_nodes) < 0)
-		return;
-
 	for (i = WRITE_LATENCY; i <= READ_BANDWIDTH; i++) {
 		loc = localities_types[i];
 		if (!loc)
@@ -667,7 +627,7 @@ static void hmat_register_target_initiators(struct memory_target *target)
 		list_for_each_entry(initiator, &initiators, node) {
 			u32 value;
 
-			if (!initiator->has_cpu) {
+			if (access == 1 && !initiator->has_cpu) {
 				clear_bit(initiator->processor_pxm, p_nodes);
 				continue;
 			}
@@ -681,14 +641,33 @@ static void hmat_register_target_initiators(struct memory_target *target)
 				clear_bit(initiator->processor_pxm, p_nodes);
 		}
 		if (best)
-			hmat_update_target_access(target, loc->hmat_loc->data_type, best, 1);
+			hmat_update_target_access(target, loc->hmat_loc->data_type, best, access);
 	}
+}
+
+static void __hmat_register_target_initiators(struct memory_target *target,
+					      unsigned long *p_nodes,
+					      int access)
+{
+	unsigned int mem_nid, cpu_nid;
+	int i;
+
+	mem_nid = pxm_to_node(target->memory_pxm);
+	hmat_update_target_attrs(target, p_nodes, access);
 	for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
 		cpu_nid = pxm_to_node(i);
-		register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
+		register_memory_node_under_compute_node(mem_nid, cpu_nid, access);
 	}
 }
 
+static void hmat_register_target_initiators(struct memory_target *target)
+{
+	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
+
+	__hmat_register_target_initiators(target, p_nodes, 0);
+	__hmat_register_target_initiators(target, p_nodes, 1);
+}
+
 static void hmat_register_target_cache(struct memory_target *target)
 {
 	unsigned mem_nid = pxm_to_node(target->memory_pxm);
-- 
2.39.2

