Return-Path: <linux-kernel+bounces-154522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED388ADD15
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C602818EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB120B3E;
	Tue, 23 Apr 2024 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rs11xhPn"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6C225A2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713849551; cv=none; b=UQr8UnyRasN37wMk52LTyE/2iU39tuqQxGRjh+wxsv78a233qIJtq5RYaNRwTvxvGryjqwwMquViTyCzpEIuTx9Lv4Wv/JQuuEjnhmafW9gbIqrBbPAElguyeFFmSTaGWQsLvsUxOV+H4VXIjiNMNGiOhNkLHnLeSDEQ+h3XfTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713849551; c=relaxed/simple;
	bh=Wmvq48LEHKtnsh9tlioUOV+HIKXT4mpP0GExGJRNVys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNqgdC3PyNDBdKlbg+29NMwF32Jco7MKLtsSPVHsD0N+zN4YVIWxubSrp14yvMMfrB/JbO1fQDFpUxBgURlB2DXDy+SCDaqG3sew4Fg6RuaeHHEblvuUGLNqaZ/wohR2kPWu9lc4TItc3/m6CW/AgVX7Vr2oTWcMR75l+1Iqehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rs11xhPn; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713849547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPVb/7bJYg0jCXHlUHlEkoC8VRMDznvlUA6F/qpq0LU=;
	b=rs11xhPnd+9ujJmxyiwAvIbaHbCvJYdPVIddaFlw5SnCPmRJf2G7uYXy12IKeEAF5st3Lj
	b59FvyJ5wKuhH/XVQ6PnB0vVo8qJTGEnv4SY4rfkSAgFn0xbURo2o9NiV0/PjYCL0/JEeB
	Uv0DlU5Nl1YornvPTybWThJ/C1flxus=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] memcg: reduce memory for the lruvec and memcg stats
Date: Mon, 22 Apr 2024 22:18:24 -0700
Message-ID: <20240423051826.791934-3-shakeel.butt@linux.dev>
In-Reply-To: <20240423051826.791934-1-shakeel.butt@linux.dev>
References: <20240423051826.791934-1-shakeel.butt@linux.dev>
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
stats. The fields of enum node_stat_item is sorted in such a way that
all the fields with corresponding memcg stats are at the start of the
enum node_stat_item. So, let's just make an explicit  boundary within
enum node_stat_item and use that boundary to allocate memory for stats
related structs of memcgs.

For a given x86_64 config, the size of stats with and without patch is:

structs size in bytes         w/o     with

struct lruvec_stats           1128     648
struct lruvec_stats_percpu     752     432
struct memcg_vmstats          1832    1352
struct memcg_vmstats_percpu   1280     960

The memory savings is further compounded by the fact that these structs
are allocated for each cpu and for node. To be precise, for each memcg,
the memory saved would be:

Memory saved = ((21 * 3 * NR_NODES) + (21 * 2 * NR_NODS * NR_CPUS) +
               (21 * 3) + (21 * 2 * NR_CPUS)) * sizeof(long)

Where 21 is the number of fields eliminated.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 12 ++++++------
 include/linux/mmzone.h     |  8 ++++++--
 mm/memcontrol.c            |  5 ++++-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9aba0d0462ca..d68db7a0e829 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -32,7 +32,7 @@ struct kmem_cache;
 
 /* Cgroup-specific page state, on top of universal node page state */
 enum memcg_stat_item {
-	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
+	MEMCG_SWAP = NR_VM_NODE_MEMCG_STAT_ITEMS,
 	MEMCG_SOCK,
 	MEMCG_PERCPU_B,
 	MEMCG_VMALLOC,
@@ -92,21 +92,21 @@ struct mem_cgroup_reclaim_iter {
 
 struct lruvec_stats_percpu {
 	/* Local (CPU and cgroup) state */
-	long state[NR_VM_NODE_STAT_ITEMS];
+	long state[NR_VM_NODE_MEMCG_STAT_ITEMS];
 
 	/* Delta calculation for lockless upward propagation */
-	long state_prev[NR_VM_NODE_STAT_ITEMS];
+	long state_prev[NR_VM_NODE_MEMCG_STAT_ITEMS];
 };
 
 struct lruvec_stats {
 	/* Aggregated (CPU and subtree) state */
-	long state[NR_VM_NODE_STAT_ITEMS];
+	long state[NR_VM_NODE_MEMCG_STAT_ITEMS];
 
 	/* Non-hierarchical (CPU aggregated) state */
-	long state_local[NR_VM_NODE_STAT_ITEMS];
+	long state_local[NR_VM_NODE_MEMCG_STAT_ITEMS];
 
 	/* Pending child counts during tree propagation */
-	long state_pending[NR_VM_NODE_STAT_ITEMS];
+	long state_pending[NR_VM_NODE_MEMCG_STAT_ITEMS];
 };
 
 /*
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 989ca97402c6..59592f3c7d9b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -192,8 +192,12 @@ enum node_stat_item {
 	NR_SHMEM_THPS,
 	NR_FILE_THPS,
 	NR_ANON_THPS,
-	/* No memcg stats for the following fields. */
-	NR_SHMEM_PMDMAPPED,
+	/*
+	 * No memcg stats for the following fields. Please add stats which have
+	 * memcg counterpart above NR_VM_NODE_MEMCG_STAT_ITEMS.
+	 */
+	NR_VM_NODE_MEMCG_STAT_ITEMS,
+	NR_SHMEM_PMDMAPPED = NR_VM_NODE_MEMCG_STAT_ITEMS,
 	NR_FILE_PMDMAPPED,
 	NR_WRITEBACK_TEMP,	/* Writeback using temporary buffers */
 	NR_VMSCAN_WRITE,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 833d09c1d523..bb1bbf417a46 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1648,6 +1648,9 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
 	int i;
 
+	/* Reduce by 1 for MEMCG_SWAP as that is not exposed in v2. */
+	BUILD_BUG_ON(ARRAY_SIZE(memory_stats) != MEMCG_NR_STAT - 1);
+
 	/*
 	 * Provide statistics on the state of the memory subsystem as
 	 * well as cumulative event counters that show past behavior.
@@ -5869,7 +5872,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 
 		lstatc = per_cpu_ptr(pn->lruvec_stats_percpu, cpu);
 
-		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+		for (i = 0; i < NR_VM_NODE_MEMCG_STAT_ITEMS; i++) {
 			delta = pn->lruvec_stats.state_pending[i];
 			if (delta)
 				pn->lruvec_stats.state_pending[i] = 0;
-- 
2.43.0


