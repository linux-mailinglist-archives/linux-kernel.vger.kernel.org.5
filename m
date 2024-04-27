Return-Path: <linux-kernel+bounces-160822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BA68B434B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3FA1F22D14
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574EF3AC25;
	Sat, 27 Apr 2024 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q3eCDp0J"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED739856
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178273; cv=none; b=eYA4vFf2Qa8LFefjCxBCZ6zzkgKvko6yj6Y1/51wNZbV12mpLHOS4poiHn9Nbfzj6fxIqJzRzg/1Q1ayh6zL89rET9t7Uvq6tYOWc+TCfVUa/CjDzlc7n0M0r0V4h2GubVrPbYLpJ2vS6JjGKywAvtcwqfqdmN0Pp/PeWmbw2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178273; c=relaxed/simple;
	bh=ODuHC/xW2Sztqrth+tMBMfYpvtgz/0RD1c7BzWd7jG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PujVj32CYsck/xiJp0/YP1YSISJnX0N5g8J2VbqXiNHOSRpU8GbO87aqHfS3CW9QE40XHNanU2bnZM6lfeDc3o7WQF4Pj8O8q/Dn0vREzAl1E6OTmVCDR2y/zPJtDHuSpsLZvRHdxhA48Kkm51/QAmkeDqBAla4Fed4wusz8abQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q3eCDp0J; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714178269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CiP6jJ3z/Zb+7HCzkE9EgNFU2GbKmyiZu4OerwR5i68=;
	b=q3eCDp0J9gOqeEqaX8tgBo8ZzkToNZNxyobMgMVMJQ9HF/mBNKsNmj1YUeUiJcf9PW3Sre
	yx9grJUbPPPWOTn07Rw0XLZzPbR+tJ83YdB8f1HVsij6xYHqrTTowobd5UzmTg2kJ+OKbX
	cChmVNaWnbQODbqk5iXRD5Oq8ndtlew=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] memcg: reduce memory for the lruvec and memcg stats
Date: Fri, 26 Apr 2024 17:37:29 -0700
Message-ID: <20240427003733.3898961-4-shakeel.butt@linux.dev>
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

At the moment, the amount of memory allocated for stats related structs
in the mem_cgroup corresponds to the size of enum node_stat_item.
However not all fields in enum node_stat_item has corresponding memcg
stats. So, let's use indirection mechanism similar to the one used for
memcg vmstats management.

For a given x86_64 config, the size of stats with and without patch is:

structs size in bytes         w/o     with

struct lruvec_stats           1128     648
struct lruvec_stats_percpu     752     432
struct memcg_vmstats          1832    1352
struct memcg_vmstats_percpu   1280     960

The memory savings is further compounded by the fact that these structs
are allocated for each cpu and for each node. To be precise, for each
memcg the memory saved would be:

Memory saved = ((21 * 3 * NR_NODES) + (21 * 2 * NR_NODS * NR_CPUS) +
	       (21 * 3) + (21 * 2 * NR_CPUS)) * sizeof(long)

Where 21 is the number of fields eliminated.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 138 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 115 insertions(+), 23 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5e337ed6c6bf..c164bc9b8ed6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -576,35 +576,105 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 	return mz;
 }
 
+/* Subset of node_stat_item for memcg stats */
+static const unsigned int memcg_node_stat_items[] = {
+	NR_INACTIVE_ANON,
+	NR_ACTIVE_ANON,
+	NR_INACTIVE_FILE,
+	NR_ACTIVE_FILE,
+	NR_UNEVICTABLE,
+	NR_SLAB_RECLAIMABLE_B,
+	NR_SLAB_UNRECLAIMABLE_B,
+	WORKINGSET_REFAULT_ANON,
+	WORKINGSET_REFAULT_FILE,
+	WORKINGSET_ACTIVATE_ANON,
+	WORKINGSET_ACTIVATE_FILE,
+	WORKINGSET_RESTORE_ANON,
+	WORKINGSET_RESTORE_FILE,
+	WORKINGSET_NODERECLAIM,
+	NR_ANON_MAPPED,
+	NR_FILE_MAPPED,
+	NR_FILE_PAGES,
+	NR_FILE_DIRTY,
+	NR_WRITEBACK,
+	NR_SHMEM,
+	NR_SHMEM_THPS,
+	NR_FILE_THPS,
+	NR_ANON_THPS,
+	NR_KERNEL_STACK_KB,
+	NR_PAGETABLE,
+	NR_SECONDARY_PAGETABLE,
+#ifdef CONFIG_SWAP
+	NR_SWAPCACHE,
+#endif
+};
+
+static const unsigned int memcg_stat_items[] = {
+	MEMCG_SWAP,
+	MEMCG_SOCK,
+	MEMCG_PERCPU_B,
+	MEMCG_VMALLOC,
+	MEMCG_KMEM,
+	MEMCG_ZSWAP_B,
+	MEMCG_ZSWAPPED,
+};
+
+#define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
+#define NR_MEMCG_STATS (NR_MEMCG_NODE_STAT_ITEMS + ARRAY_SIZE(memcg_stat_items))
+static int8_t mem_cgroup_stats_index[MEMCG_NR_STAT] __read_mostly;
+
+static void init_memcg_stats(void)
+{
+	int8_t i, j = 0;
+
+	/* Switch to short once this failure occurs. */
+	BUILD_BUG_ON(NR_MEMCG_STATS >= 127 /* INT8_MAX */);
+
+	for (i = 0; i < NR_MEMCG_NODE_STAT_ITEMS; ++i)
+		mem_cgroup_stats_index[memcg_node_stat_items[i]] = ++j;
+
+	for (i = 0; i < ARRAY_SIZE(memcg_stat_items); ++i)
+		mem_cgroup_stats_index[memcg_stat_items[i]] = ++j;
+}
+
+static inline int memcg_stats_index(int idx)
+{
+	return mem_cgroup_stats_index[idx] - 1;
+}
+
 struct lruvec_stats_percpu {
 	/* Local (CPU and cgroup) state */
-	long state[NR_VM_NODE_STAT_ITEMS];
+	long state[NR_MEMCG_NODE_STAT_ITEMS];
 
 	/* Delta calculation for lockless upward propagation */
-	long state_prev[NR_VM_NODE_STAT_ITEMS];
+	long state_prev[NR_MEMCG_NODE_STAT_ITEMS];
 };
 
 struct lruvec_stats {
 	/* Aggregated (CPU and subtree) state */
-	long state[NR_VM_NODE_STAT_ITEMS];
+	long state[NR_MEMCG_NODE_STAT_ITEMS];
 
 	/* Non-hierarchical (CPU aggregated) state */
-	long state_local[NR_VM_NODE_STAT_ITEMS];
+	long state_local[NR_MEMCG_NODE_STAT_ITEMS];
 
 	/* Pending child counts during tree propagation */
-	long state_pending[NR_VM_NODE_STAT_ITEMS];
+	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
 };
 
 unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
 {
 	struct mem_cgroup_per_node *pn;
-	long x;
+	long x = 0;
+	int i;
 
 	if (mem_cgroup_disabled())
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
-	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = READ_ONCE(pn->lruvec_stats->state[idx]);
+	i = memcg_stats_index(idx);
+	if (i >= 0) {
+		pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+		x = READ_ONCE(pn->lruvec_stats->state[i]);
+	}
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -617,12 +687,16 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 {
 	struct mem_cgroup_per_node *pn;
 	long x = 0;
+	int i;
 
 	if (mem_cgroup_disabled())
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
-	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = READ_ONCE(pn->lruvec_stats->state_local[idx]);
+	i = memcg_stats_index(idx);
+	if (i >= 0) {
+		pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+		x = READ_ONCE(pn->lruvec_stats->state_local[i]);
+	}
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -690,11 +764,11 @@ struct memcg_vmstats_percpu {
 	/* The above should fit a single cacheline for memcg_rstat_updated() */
 
 	/* Local (CPU and cgroup) page state & events */
-	long			state[MEMCG_NR_STAT];
+	long			state[NR_MEMCG_STATS];
 	unsigned long		events[NR_MEMCG_EVENTS];
 
 	/* Delta calculation for lockless upward propagation */
-	long			state_prev[MEMCG_NR_STAT];
+	long			state_prev[NR_MEMCG_STATS];
 	unsigned long		events_prev[NR_MEMCG_EVENTS];
 
 	/* Cgroup1: threshold notifications & softlimit tree updates */
@@ -704,15 +778,15 @@ struct memcg_vmstats_percpu {
 
 struct memcg_vmstats {
 	/* Aggregated (CPU and subtree) page state & events */
-	long			state[MEMCG_NR_STAT];
+	long			state[NR_MEMCG_STATS];
 	unsigned long		events[NR_MEMCG_EVENTS];
 
 	/* Non-hierarchical (CPU aggregated) page state & events */
-	long			state_local[MEMCG_NR_STAT];
+	long			state_local[NR_MEMCG_STATS];
 	unsigned long		events_local[NR_MEMCG_EVENTS];
 
 	/* Pending child counts during tree propagation */
-	long			state_pending[MEMCG_NR_STAT];
+	long			state_pending[NR_MEMCG_STATS];
 	unsigned long		events_pending[NR_MEMCG_EVENTS];
 
 	/* Stats updates since the last flush */
@@ -845,7 +919,13 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 {
-	long x = READ_ONCE(memcg->vmstats->state[idx]);
+	long x;
+	int i = memcg_stats_index(idx);
+
+	if (i < 0)
+		return 0;
+
+	x = READ_ONCE(memcg->vmstats->state[i]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -877,18 +957,25 @@ static int memcg_state_val_in_pages(int idx, int val)
  */
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 {
-	if (mem_cgroup_disabled())
+	int i = memcg_stats_index(idx);
+
+	if (mem_cgroup_disabled() || i < 0)
 		return;
 
-	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
+	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
 	memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
 }
 
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
 static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 {
-	long x = READ_ONCE(memcg->vmstats->state_local[idx]);
+	long x;
+	int i = memcg_stats_index(idx);
+
+	if (i < 0)
+		return 0;
 
+	x = READ_ONCE(memcg->vmstats->state_local[i]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -902,6 +989,10 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 {
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
+	int i = memcg_stats_index(idx);
+
+	if (i < 0)
+		return;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
@@ -931,10 +1022,10 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	}
 
 	/* Update memcg */
-	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
+	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
 
 	/* Update lruvec */
-	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
+	__this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
 
 	memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
 	memcg_stats_unlock();
@@ -5702,6 +5793,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		page_counter_init(&memcg->kmem, &parent->kmem);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
 	} else {
+		init_memcg_stats();
 		init_memcg_events();
 		page_counter_init(&memcg->memory, NULL);
 		page_counter_init(&memcg->swap, NULL);
@@ -5873,7 +5965,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 
 	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
 
-	for (i = 0; i < MEMCG_NR_STAT; i++) {
+	for (i = 0; i < NR_MEMCG_STATS; i++) {
 		/*
 		 * Collect the aggregated propagation counts of groups
 		 * below us. We're in a per-cpu loop here and this is
@@ -5937,7 +6029,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 
 		lstatc = per_cpu_ptr(pn->lruvec_stats_percpu, cpu);
 
-		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+		for (i = 0; i < NR_MEMCG_NODE_STAT_ITEMS; i++) {
 			delta = lstats->state_pending[i];
 			if (delta)
 				lstats->state_pending[i] = 0;
-- 
2.43.0


