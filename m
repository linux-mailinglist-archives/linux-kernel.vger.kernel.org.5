Return-Path: <linux-kernel+bounces-160821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64428B434A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155C41C22639
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80A538F97;
	Sat, 27 Apr 2024 00:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TTzxVCz/"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500032E852
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178270; cv=none; b=myKJ8RIawiw8ZVHfb4Onk+fiSBoyMblY3Eb/y9bFkQV145q6nGAhkVuloO/vG0FGQlQ37DYJbgHRUckZkC4wUK2/34UNWzLNPLgsVsGGe0UVePE/gV0oCRsNg5sUEVmtPcm9ZndZ4vkn7l2Pe4WCPzvJ30RZC9lQ5JdOcm1ZWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178270; c=relaxed/simple;
	bh=d1x8pyehYWPfCqWd+SbnXD6NG1swtEVTqk4fMqibs8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXvup8daAUk67dSsiV8Oh2emD0QAKDI/eL45XQNudg0S4RUeqDOSnIzpPSyOK05Mg3RDuvhlxuhwd9esdhGXfrkTkW2BG0TyMyDx0xXaQSfidSARZEw6Toqxta1DANZ9/tjemmFV4Q5ke0DC+FCxN+H9Avpko6But9TSj9ILcpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TTzxVCz/; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714178266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HIEk0SwiGrn4sd8u1onunMHRY8Lr8R1eMIi9eNXAwg=;
	b=TTzxVCz/SkpxFmZQf92Tga9m8XT6tVu0QWSUn9K3qKo0E1mv96BJzNsXIz76H/EcjW0Psm
	aOZme5snQD4/yIdO02Ba+xutkIyUD+b/G5a8DIZz/9L/SuinYiiA5H2V5R0NuZ+SUXmxdq
	n/1LeeGxekFuaPZVKjK+TbCPzXMu6FA=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] memcg: dynamically allocate lruvec_stats
Date: Fri, 26 Apr 2024 17:37:28 -0700
Message-ID: <20240427003733.3898961-3-shakeel.butt@linux.dev>
In-Reply-To: <20240427003733.3898961-1-shakeel.butt@linux.dev>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To decouple the dependency of lruvec_stats on NR_VM_NODE_STAT_ITEMS, we
need to dynamically allocate lruvec_stats in the mem_cgroup_per_node
structure. Also move the definition of lruvec_stats_percpu and
lruvec_stats and related functions to the memcontrol.c to facilitate
later patches. No functional changes in the patch.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 62 +++------------------------
 mm/memcontrol.c            | 87 ++++++++++++++++++++++++++++++++------
 2 files changed, 81 insertions(+), 68 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9aba0d0462ca..ab8a6e884375 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -83,6 +83,8 @@ enum mem_cgroup_events_target {
 
 struct memcg_vmstats_percpu;
 struct memcg_vmstats;
+struct lruvec_stats_percpu;
+struct lruvec_stats;
 
 struct mem_cgroup_reclaim_iter {
 	struct mem_cgroup *position;
@@ -90,25 +92,6 @@ struct mem_cgroup_reclaim_iter {
 	unsigned int generation;
 };
 
-struct lruvec_stats_percpu {
-	/* Local (CPU and cgroup) state */
-	long state[NR_VM_NODE_STAT_ITEMS];
-
-	/* Delta calculation for lockless upward propagation */
-	long state_prev[NR_VM_NODE_STAT_ITEMS];
-};
-
-struct lruvec_stats {
-	/* Aggregated (CPU and subtree) state */
-	long state[NR_VM_NODE_STAT_ITEMS];
-
-	/* Non-hierarchical (CPU aggregated) state */
-	long state_local[NR_VM_NODE_STAT_ITEMS];
-
-	/* Pending child counts during tree propagation */
-	long state_pending[NR_VM_NODE_STAT_ITEMS];
-};
-
 /*
  * per-node information in memory controller.
  */
@@ -116,7 +99,7 @@ struct mem_cgroup_per_node {
 	struct lruvec		lruvec;
 
 	struct lruvec_stats_percpu __percpu	*lruvec_stats_percpu;
-	struct lruvec_stats			lruvec_stats;
+	struct lruvec_stats			*lruvec_stats;
 
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 
@@ -1037,42 +1020,9 @@ static inline void mod_memcg_page_state(struct page *page,
 }
 
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
-
-static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
-					      enum node_stat_item idx)
-{
-	struct mem_cgroup_per_node *pn;
-	long x;
-
-	if (mem_cgroup_disabled())
-		return node_page_state(lruvec_pgdat(lruvec), idx);
-
-	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = READ_ONCE(pn->lruvec_stats.state[idx]);
-#ifdef CONFIG_SMP
-	if (x < 0)
-		x = 0;
-#endif
-	return x;
-}
-
-static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
-						    enum node_stat_item idx)
-{
-	struct mem_cgroup_per_node *pn;
-	long x = 0;
-
-	if (mem_cgroup_disabled())
-		return node_page_state(lruvec_pgdat(lruvec), idx);
-
-	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = READ_ONCE(pn->lruvec_stats.state_local[idx]);
-#ifdef CONFIG_SMP
-	if (x < 0)
-		x = 0;
-#endif
-	return x;
-}
+unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
+unsigned long lruvec_page_state_local(struct lruvec *lruvec,
+				      enum node_stat_item idx);
 
 void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 53769d06053f..5e337ed6c6bf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -576,6 +576,60 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 	return mz;
 }
 
+struct lruvec_stats_percpu {
+	/* Local (CPU and cgroup) state */
+	long state[NR_VM_NODE_STAT_ITEMS];
+
+	/* Delta calculation for lockless upward propagation */
+	long state_prev[NR_VM_NODE_STAT_ITEMS];
+};
+
+struct lruvec_stats {
+	/* Aggregated (CPU and subtree) state */
+	long state[NR_VM_NODE_STAT_ITEMS];
+
+	/* Non-hierarchical (CPU aggregated) state */
+	long state_local[NR_VM_NODE_STAT_ITEMS];
+
+	/* Pending child counts during tree propagation */
+	long state_pending[NR_VM_NODE_STAT_ITEMS];
+};
+
+unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
+{
+	struct mem_cgroup_per_node *pn;
+	long x;
+
+	if (mem_cgroup_disabled())
+		return node_page_state(lruvec_pgdat(lruvec), idx);
+
+	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+	x = READ_ONCE(pn->lruvec_stats->state[idx]);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
+}
+
+unsigned long lruvec_page_state_local(struct lruvec *lruvec,
+				      enum node_stat_item idx)
+{
+	struct mem_cgroup_per_node *pn;
+	long x = 0;
+
+	if (mem_cgroup_disabled())
+		return node_page_state(lruvec_pgdat(lruvec), idx);
+
+	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+	x = READ_ONCE(pn->lruvec_stats->state_local[idx]);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
+}
+
 /* Subset of vm_event_item to report for memcg event stats */
 static const unsigned int memcg_vm_event_stat[] = {
 	PGPGIN,
@@ -5492,18 +5546,25 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return 1;
 
+	pn->lruvec_stats = kzalloc_node(sizeof(struct lruvec_stats), GFP_KERNEL,
+					node);
+	if (!pn->lruvec_stats)
+		goto fail;
+
 	pn->lruvec_stats_percpu = alloc_percpu_gfp(struct lruvec_stats_percpu,
 						   GFP_KERNEL_ACCOUNT);
-	if (!pn->lruvec_stats_percpu) {
-		kfree(pn);
-		return 1;
-	}
+	if (!pn->lruvec_stats_percpu)
+		goto fail;
 
 	lruvec_init(&pn->lruvec);
 	pn->memcg = memcg;
 
 	memcg->nodeinfo[node] = pn;
 	return 0;
+fail:
+	kfree(pn->lruvec_stats);
+	kfree(pn);
+	return 1;
 }
 
 static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
@@ -5514,6 +5575,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 		return;
 
 	free_percpu(pn->lruvec_stats_percpu);
+	kfree(pn->lruvec_stats);
 	kfree(pn);
 }
 
@@ -5866,18 +5928,19 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 
 	for_each_node_state(nid, N_MEMORY) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
-		struct mem_cgroup_per_node *ppn = NULL;
+		struct lruvec_stats *lstats = pn->lruvec_stats;
+		struct lruvec_stats *plstats = NULL;
 		struct lruvec_stats_percpu *lstatc;
 
 		if (parent)
-			ppn = parent->nodeinfo[nid];
+			plstats = parent->nodeinfo[nid]->lruvec_stats;
 
 		lstatc = per_cpu_ptr(pn->lruvec_stats_percpu, cpu);
 
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
-			delta = pn->lruvec_stats.state_pending[i];
+			delta = lstats->state_pending[i];
 			if (delta)
-				pn->lruvec_stats.state_pending[i] = 0;
+				lstats->state_pending[i] = 0;
 
 			delta_cpu = 0;
 			v = READ_ONCE(lstatc->state[i]);
@@ -5888,12 +5951,12 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			}
 
 			if (delta_cpu)
-				pn->lruvec_stats.state_local[i] += delta_cpu;
+				lstats->state_local[i] += delta_cpu;
 
 			if (delta) {
-				pn->lruvec_stats.state[i] += delta;
-				if (ppn)
-					ppn->lruvec_stats.state_pending[i] += delta;
+				lstats->state[i] += delta;
+				if (plstats)
+					plstats->state_pending[i] += delta;
 			}
 		}
 	}
-- 
2.43.0


