Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8A375BBF4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 03:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjGUBp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 21:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjGUBpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:45:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA35D2733;
        Thu, 20 Jul 2023 18:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689903915; x=1721439915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Hn5VMwJGt0IXFlVjJsaiQl5L2c0xHT5vclGupSQt0Q=;
  b=Ac4YGZ/Kq+NYgS5BjFmjKY0YuO/Yh2aK3dLPLO4lb4F4mDwYWg5PS1dr
   hyJFPXFPa++55P3cOfg47A/1BYni3LobNkyLhAXJV0JrcJpg9/vXRsa5j
   RGSM5VTNWs8M1yMgRc1fPWEOu5unokPUZQOXq1U9aPUel/og4cBaGpHRM
   RSx99wALsb7OcQaBYtUTkxIXXshO0qRB4201QrnOo81Ifzk+nGciJVzdk
   KiICKdJGBcLeB6KtK/G0yJoTBFXHwGsRyyeuSsPDPHwqDb9nj6irkH2k0
   HNaCdiaTL9CW2soXKyaRaiKZ7FlK4djdX43lq/hVduQ4fkwxoWhy0FiTI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="347214161"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="347214161"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 18:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="724671020"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="724671020"
Received: from yanfeng1-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.29.24])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 18:45:09 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH RESEND 2/4] acpi, hmat: refactor hmat_register_target_initiators()
Date:   Fri, 21 Jul 2023 09:29:30 +0800
Message-Id: <20230721012932.190742-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721012932.190742-1-ying.huang@intel.com>
References: <20230721012932.190742-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Yang Shi <shy828301@gmail.com>
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

