Return-Path: <linux-kernel+bounces-134261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE3389AFBF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43241C21103
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509AD1DDF5;
	Sun,  7 Apr 2024 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQxMipHR"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BC12E4A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712479437; cv=none; b=raX07pcZuszz9InVfl8dEB82euKz1KZJwaBoWEjF8XtW/SdmX5Oc7rL12jpFCTsXfzWO5gSe8WwoP2tqHTZmbmYOxO74KbDaNKji/Wj+d+316qjDt6L8D+sbHYaw8Ze7x9w9qrw16QpRn4GsANgwV6WDoDH7iI8wjdG3FM+eP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712479437; c=relaxed/simple;
	bh=1cfKYyrnEvztQUnFWzwlLx+l5JMLFzJIb6cZ3/a5bbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKQexpjzNJDPs+2rT51Rawg11Qd+qYOxRZXMgWUlckE72abTPxW0b+DWpzAJECTzFm8NVeX2bmtFaD2MvMrVEBOUhU992P0P1Hu1HNHvMjc+R0hTW8FG/5uZHELj8BGnhaBckMNgUELEkEJDsE1A871RXwVhr/x3pCcePhtnsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQxMipHR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e0e1d162bso3569491a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712479429; x=1713084229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHtl7o0dYPtw1SC9aB/Vlm1DlmM+4sQQVOAdOTL2aE0=;
        b=SQxMipHRUxIaoCN7oQRXgFejgabvt1SQT7wA/j7FSb9OYaLIOUET7HBz/hQpYO1tZV
         48EES1DwuCjEd8jIoaLPfjfWeBiUscv3PbjKVZlGYIBmknCPJag61jeoV84xkJNOfTar
         NhVWb8hsxDpYt4po/M08ZfTIgHlTyNHwlRNU2UpeclMYZn4b238F1dKRA9O2KaYsFJAH
         1z0su7j2BU8Q1cvIqP4f8vu+Gl0FfE6zTmyYG1Rp5xwJ106BJRrYs+M5U/lmuEnEG2Qi
         nDM2vg4e1yV9COZd6g3osbMxc8ZegodOww/Uv4yRlMlE5+rtZ0BLD+Yi3GsT/OoYwyha
         cCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712479429; x=1713084229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tHtl7o0dYPtw1SC9aB/Vlm1DlmM+4sQQVOAdOTL2aE0=;
        b=qFJKMjha52Q8H8qRaXgkzWzSMhnvbgKcvfQ2MggKbK+LmIzC8uD220c69Uc1I6CLgB
         gfmsgQDvt/OG8no/S5ilUrfa2Jwh94PZ5Gp8tUDPzlzu2Ks1cExiVk0OXVdCSktSFrVJ
         wda+as/PhA+8a9UipFBN7hli5GaxqdhUKwZ7JP5lr0UNt4Qp7V8FwJobxeGOewjzHB2Z
         9whQWpwCkLC8bm0xymCyzEOKwzsNHhjHGxvTHc18L6IMhESWtdQRRu2LDXLXEJvTEDFi
         0VxeNuEAV3RN4P/5KvJRhrF9dhE+pOVbsf4o1H9nTuK7WFnMchZgsbM4mXQ7SMTRZyJV
         FY0g==
X-Gm-Message-State: AOJu0YyZJvf/8xxwlMsxFzpH54oWli5b5u+6IlQSceHIbHaDR0LP6x74
	3bvSlu9QP5L2AwJaaFqpWCSSWJRz8KuHvzJbeG7iBol+MRxYBhlFPPyXZVP73lE=
X-Google-Smtp-Source: AGHT+IF5fprmNgfQf7xZLIPNmHEVvA85Sa+CWkB0jFI7L/4sQlUCBx2hA9BkneQcvXf8fsdXUUKLrw==
X-Received: by 2002:a17:906:81cd:b0:a51:a771:9e36 with SMTP id e13-20020a17090681cd00b00a51a7719e36mr3721932ejx.14.1712479427924;
        Sun, 07 Apr 2024 01:43:47 -0700 (PDT)
Received: from thule.. (84-236-113-28.pool.digikabel.hu. [84.236.113.28])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906c21500b00a4e28cacbddsm2891579ejz.57.2024.04.07.01.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:43:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/5] sched: Split out kernel/sched/numa_balancing.c from kernel/sched/fair.c
Date: Sun,  7 Apr 2024 10:43:17 +0200
Message-Id: <20240407084319.1462211-4-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240407084319.1462211-1-mingo@kernel.org>
References: <20240407084319.1462211-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Much of the NUMA balancing code already lives in a single #ifdef
block - move it over into its own file: kernel/sched/numa_balancing.c.

Expose a handful of methods internally to facilitate this.

This further shrinks the rather large kernel/sched/fair.c file.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/Makefile         |    1 +
 kernel/sched/fair.c           | 2307 +------------------------------------------------------------
 kernel/sched/numa_balancing.c | 2277 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h          |   40 +-
 4 files changed, 2318 insertions(+), 2307 deletions(-)

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 898f6062a2a7..45ab29e60fc7 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -32,5 +32,6 @@ obj-y += core.o
 obj-y += syscalls.o
 obj-y += fair.o
 obj-y += fair_balance.o
+obj-y += numa_balancing.o
 obj-y += build_policy.o
 obj-y += build_utility.o
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9eba1c4e2a00..0197ba78b89c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -107,7 +107,7 @@ static unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
 
 #ifdef CONFIG_NUMA_BALANCING
 /* Restrict the NUMA promotion throughput (MB/s) for each target node. */
-static unsigned int sysctl_numa_balancing_promote_rate_limit = 65536;
+unsigned int sysctl_numa_balancing_promote_rate_limit = 65536;
 #endif
 
 #ifdef CONFIG_SYSCTL
@@ -1256,2271 +1256,6 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * Scheduling class queueing methods:
  */
 
-#ifdef CONFIG_SMP
-bool is_core_idle(int cpu)
-{
-#ifdef CONFIG_SCHED_SMT
-	int sibling;
-
-	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
-		if (cpu == sibling)
-			continue;
-
-		if (!idle_cpu(sibling))
-			return false;
-	}
-#endif
-
-	return true;
-}
-#endif
-
-#ifdef CONFIG_NUMA
-#define NUMA_IMBALANCE_MIN 2
-
-long adjust_numa_imbalance(int imbalance, int dst_running, int imb_numa_nr)
-{
-	/*
-	 * Allow a NUMA imbalance if busy CPUs is less than the maximum
-	 * threshold. Above this threshold, individual tasks may be contending
-	 * for both memory bandwidth and any shared HT resources.  This is an
-	 * approximation as the number of running tasks may not be related to
-	 * the number of busy CPUs due to sched_setaffinity.
-	 */
-	if (dst_running > imb_numa_nr)
-		return imbalance;
-
-	/*
-	 * Allow a small imbalance based on a simple pair of communicating
-	 * tasks that remain local when the destination is lightly loaded.
-	 */
-	if (imbalance <= NUMA_IMBALANCE_MIN)
-		return 0;
-
-	return imbalance;
-}
-#endif /* CONFIG_NUMA */
-
-#ifdef CONFIG_NUMA_BALANCING
-/*
- * Approximate time to scan a full NUMA task in ms. The task scan period is
- * calculated based on the tasks virtual memory size and
- * numa_balancing_scan_size.
- */
-unsigned int sysctl_numa_balancing_scan_period_min = 1000;
-unsigned int sysctl_numa_balancing_scan_period_max = 60000;
-
-/* Portion of address space to scan in MB */
-unsigned int sysctl_numa_balancing_scan_size = 256;
-
-/* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
-unsigned int sysctl_numa_balancing_scan_delay = 1000;
-
-/* The page with hint page fault latency < threshold in ms is considered hot */
-unsigned int sysctl_numa_balancing_hot_threshold = MSEC_PER_SEC;
-
-struct numa_group {
-	refcount_t refcount;
-
-	spinlock_t lock; /* nr_tasks, tasks */
-	int nr_tasks;
-	pid_t gid;
-	int active_nodes;
-
-	struct rcu_head rcu;
-	unsigned long total_faults;
-	unsigned long max_faults_cpu;
-	/*
-	 * faults[] array is split into two regions: faults_mem and faults_cpu.
-	 *
-	 * Faults_cpu is used to decide whether memory should move
-	 * towards the CPU. As a consequence, these stats are weighted
-	 * more by CPU use than by memory faults.
-	 */
-	unsigned long faults[];
-};
-
-/*
- * For functions that can be called in multiple contexts that permit reading
- * ->numa_group (see struct task_struct for locking rules).
- */
-static struct numa_group *deref_task_numa_group(struct task_struct *p)
-{
-	return rcu_dereference_check(p->numa_group, p == current ||
-		(lockdep_is_held(__rq_lockp(task_rq(p))) && !READ_ONCE(p->on_cpu)));
-}
-
-static struct numa_group *deref_curr_numa_group(struct task_struct *p)
-{
-	return rcu_dereference_protected(p->numa_group, p == current);
-}
-
-static inline unsigned long group_faults_priv(struct numa_group *ng);
-static inline unsigned long group_faults_shared(struct numa_group *ng);
-
-static unsigned int task_nr_scan_windows(struct task_struct *p)
-{
-	unsigned long rss = 0;
-	unsigned long nr_scan_pages;
-
-	/*
-	 * Calculations based on RSS as non-present and empty pages are skipped
-	 * by the PTE scanner and NUMA hinting faults should be trapped based
-	 * on resident pages
-	 */
-	nr_scan_pages = sysctl_numa_balancing_scan_size << (20 - PAGE_SHIFT);
-	rss = get_mm_rss(p->mm);
-	if (!rss)
-		rss = nr_scan_pages;
-
-	rss = round_up(rss, nr_scan_pages);
-	return rss / nr_scan_pages;
-}
-
-/* For sanity's sake, never scan more PTEs than MAX_SCAN_WINDOW MB/sec. */
-#define MAX_SCAN_WINDOW 2560
-
-static unsigned int task_scan_min(struct task_struct *p)
-{
-	unsigned int scan_size = READ_ONCE(sysctl_numa_balancing_scan_size);
-	unsigned int scan, floor;
-	unsigned int windows = 1;
-
-	if (scan_size < MAX_SCAN_WINDOW)
-		windows = MAX_SCAN_WINDOW / scan_size;
-	floor = 1000 / windows;
-
-	scan = sysctl_numa_balancing_scan_period_min / task_nr_scan_windows(p);
-	return max_t(unsigned int, floor, scan);
-}
-
-static unsigned int task_scan_start(struct task_struct *p)
-{
-	unsigned long smin = task_scan_min(p);
-	unsigned long period = smin;
-	struct numa_group *ng;
-
-	/* Scale the maximum scan period with the amount of shared memory. */
-	rcu_read_lock();
-	ng = rcu_dereference(p->numa_group);
-	if (ng) {
-		unsigned long shared = group_faults_shared(ng);
-		unsigned long private = group_faults_priv(ng);
-
-		period *= refcount_read(&ng->refcount);
-		period *= shared + 1;
-		period /= private + shared + 1;
-	}
-	rcu_read_unlock();
-
-	return max(smin, period);
-}
-
-static unsigned int task_scan_max(struct task_struct *p)
-{
-	unsigned long smin = task_scan_min(p);
-	unsigned long smax;
-	struct numa_group *ng;
-
-	/* Watch for min being lower than max due to floor calculations */
-	smax = sysctl_numa_balancing_scan_period_max / task_nr_scan_windows(p);
-
-	/* Scale the maximum scan period with the amount of shared memory. */
-	ng = deref_curr_numa_group(p);
-	if (ng) {
-		unsigned long shared = group_faults_shared(ng);
-		unsigned long private = group_faults_priv(ng);
-		unsigned long period = smax;
-
-		period *= refcount_read(&ng->refcount);
-		period *= shared + 1;
-		period /= private + shared + 1;
-
-		smax = max(smax, period);
-	}
-
-	return max(smin, smax);
-}
-
-static void account_numa_enqueue(struct rq *rq, struct task_struct *p)
-{
-	rq->nr_numa_running += (p->numa_preferred_nid != NUMA_NO_NODE);
-	rq->nr_preferred_running += (p->numa_preferred_nid == task_node(p));
-}
-
-static void account_numa_dequeue(struct rq *rq, struct task_struct *p)
-{
-	rq->nr_numa_running -= (p->numa_preferred_nid != NUMA_NO_NODE);
-	rq->nr_preferred_running -= (p->numa_preferred_nid == task_node(p));
-}
-
-/* Shared or private faults. */
-#define NR_NUMA_HINT_FAULT_TYPES 2
-
-/* Memory and CPU locality */
-#define NR_NUMA_HINT_FAULT_STATS (NR_NUMA_HINT_FAULT_TYPES * 2)
-
-/* Averaged statistics, and temporary buffers. */
-#define NR_NUMA_HINT_FAULT_BUCKETS (NR_NUMA_HINT_FAULT_STATS * 2)
-
-pid_t task_numa_group_id(struct task_struct *p)
-{
-	struct numa_group *ng;
-	pid_t gid = 0;
-
-	rcu_read_lock();
-	ng = rcu_dereference(p->numa_group);
-	if (ng)
-		gid = ng->gid;
-	rcu_read_unlock();
-
-	return gid;
-}
-
-/*
- * The averaged statistics, shared & private, memory & CPU,
- * occupy the first half of the array. The second half of the
- * array is for current counters, which are averaged into the
- * first set by task_numa_placement.
- */
-static inline int task_faults_idx(enum numa_faults_stats s, int nid, int priv)
-{
-	return NR_NUMA_HINT_FAULT_TYPES * (s * nr_node_ids + nid) + priv;
-}
-
-static inline unsigned long task_faults(struct task_struct *p, int nid)
-{
-	if (!p->numa_faults)
-		return 0;
-
-	return p->numa_faults[task_faults_idx(NUMA_MEM, nid, 0)] +
-		p->numa_faults[task_faults_idx(NUMA_MEM, nid, 1)];
-}
-
-static inline unsigned long group_faults(struct task_struct *p, int nid)
-{
-	struct numa_group *ng = deref_task_numa_group(p);
-
-	if (!ng)
-		return 0;
-
-	return ng->faults[task_faults_idx(NUMA_MEM, nid, 0)] +
-		ng->faults[task_faults_idx(NUMA_MEM, nid, 1)];
-}
-
-static inline unsigned long group_faults_cpu(struct numa_group *group, int nid)
-{
-	return group->faults[task_faults_idx(NUMA_CPU, nid, 0)] +
-		group->faults[task_faults_idx(NUMA_CPU, nid, 1)];
-}
-
-static inline unsigned long group_faults_priv(struct numa_group *ng)
-{
-	unsigned long faults = 0;
-	int node;
-
-	for_each_online_node(node) {
-		faults += ng->faults[task_faults_idx(NUMA_MEM, node, 1)];
-	}
-
-	return faults;
-}
-
-static inline unsigned long group_faults_shared(struct numa_group *ng)
-{
-	unsigned long faults = 0;
-	int node;
-
-	for_each_online_node(node) {
-		faults += ng->faults[task_faults_idx(NUMA_MEM, node, 0)];
-	}
-
-	return faults;
-}
-
-/*
- * A node triggering more than 1/3 as many NUMA faults as the maximum is
- * considered part of a numa group's pseudo-interleaving set. Migrations
- * between these nodes are slowed down, to allow things to settle down.
- */
-#define ACTIVE_NODE_FRACTION 3
-
-static bool numa_is_active_node(int nid, struct numa_group *ng)
-{
-	return group_faults_cpu(ng, nid) * ACTIVE_NODE_FRACTION > ng->max_faults_cpu;
-}
-
-/* Handle placement on systems where not all nodes are directly connected. */
-static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
-					int lim_dist, bool task)
-{
-	unsigned long score = 0;
-	int node, max_dist;
-
-	/*
-	 * All nodes are directly connected, and the same distance
-	 * from each other. No need for fancy placement algorithms.
-	 */
-	if (sched_numa_topology_type == NUMA_DIRECT)
-		return 0;
-
-	/* sched_max_numa_distance may be changed in parallel. */
-	max_dist = READ_ONCE(sched_max_numa_distance);
-	/*
-	 * This code is called for each node, introducing N^2 complexity,
-	 * which should be OK given the number of nodes rarely exceeds 8.
-	 */
-	for_each_online_node(node) {
-		unsigned long faults;
-		int dist = node_distance(nid, node);
-
-		/*
-		 * The furthest away nodes in the system are not interesting
-		 * for placement; nid was already counted.
-		 */
-		if (dist >= max_dist || node == nid)
-			continue;
-
-		/*
-		 * On systems with a backplane NUMA topology, compare groups
-		 * of nodes, and move tasks towards the group with the most
-		 * memory accesses. When comparing two nodes at distance
-		 * "hoplimit", only nodes closer by than "hoplimit" are part
-		 * of each group. Skip other nodes.
-		 */
-		if (sched_numa_topology_type == NUMA_BACKPLANE && dist >= lim_dist)
-			continue;
-
-		/* Add up the faults from nearby nodes. */
-		if (task)
-			faults = task_faults(p, node);
-		else
-			faults = group_faults(p, node);
-
-		/*
-		 * On systems with a glueless mesh NUMA topology, there are
-		 * no fixed "groups of nodes". Instead, nodes that are not
-		 * directly connected bounce traffic through intermediate
-		 * nodes; a numa_group can occupy any set of nodes.
-		 * The further away a node is, the less the faults count.
-		 * This seems to result in good task placement.
-		 */
-		if (sched_numa_topology_type == NUMA_GLUELESS_MESH) {
-			faults *= (max_dist - dist);
-			faults /= (max_dist - LOCAL_DISTANCE);
-		}
-
-		score += faults;
-	}
-
-	return score;
-}
-
-/*
- * These return the fraction of accesses done by a particular task, or
- * task group, on a particular numa node.  The group weight is given a
- * larger multiplier, in order to group tasks together that are almost
- * evenly spread out between numa nodes.
- */
-unsigned long task_weight(struct task_struct *p, int nid, int dist)
-{
-	unsigned long faults, total_faults;
-
-	if (!p->numa_faults)
-		return 0;
-
-	total_faults = p->total_numa_faults;
-
-	if (!total_faults)
-		return 0;
-
-	faults = task_faults(p, nid);
-	faults += score_nearby_nodes(p, nid, dist, true);
-
-	return 1000 * faults / total_faults;
-}
-
-unsigned long group_weight(struct task_struct *p, int nid, int dist)
-{
-	struct numa_group *ng = deref_task_numa_group(p);
-	unsigned long faults, total_faults;
-
-	if (!ng)
-		return 0;
-
-	total_faults = ng->total_faults;
-
-	if (!total_faults)
-		return 0;
-
-	faults = group_faults(p, nid);
-	faults += score_nearby_nodes(p, nid, dist, false);
-
-	return 1000 * faults / total_faults;
-}
-
-/*
- * If memory tiering mode is enabled, cpupid of slow memory page is
- * used to record scan time instead of CPU and PID.  When tiering mode
- * is disabled at run time, the scan time (in cpupid) will be
- * interpreted as CPU and PID.  So CPU needs to be checked to avoid to
- * access out of array bound.
- */
-static inline bool cpupid_valid(int cpupid)
-{
-	return cpupid_to_cpu(cpupid) < nr_cpu_ids;
-}
-
-/*
- * For memory tiering mode, if there are enough free pages (more than
- * enough watermark defined here) in fast memory node, to take full
- * advantage of fast memory capacity, all recently accessed slow
- * memory pages will be migrated to fast memory node without
- * considering hot threshold.
- */
-static bool pgdat_free_space_enough(struct pglist_data *pgdat)
-{
-	int z;
-	unsigned long enough_wmark;
-
-	enough_wmark = max(1UL * 1024 * 1024 * 1024 >> PAGE_SHIFT,
-			   pgdat->node_present_pages >> 4);
-	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
-		struct zone *zone = pgdat->node_zones + z;
-
-		if (!populated_zone(zone))
-			continue;
-
-		if (zone_watermark_ok(zone, 0,
-				      wmark_pages(zone, WMARK_PROMO) + enough_wmark,
-				      ZONE_MOVABLE, 0))
-			return true;
-	}
-	return false;
-}
-
-/*
- * For memory tiering mode, when page tables are scanned, the scan
- * time will be recorded in struct page in addition to make page
- * PROT_NONE for slow memory page.  So when the page is accessed, in
- * hint page fault handler, the hint page fault latency is calculated
- * via,
- *
- *	hint page fault latency = hint page fault time - scan time
- *
- * The smaller the hint page fault latency, the higher the possibility
- * for the page to be hot.
- */
-static int numa_hint_fault_latency(struct folio *folio)
-{
-	int last_time, time;
-
-	time = jiffies_to_msecs(jiffies);
-	last_time = folio_xchg_access_time(folio, time);
-
-	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
-}
-
-/*
- * For memory tiering mode, too high promotion/demotion throughput may
- * hurt application latency.  So we provide a mechanism to rate limit
- * the number of pages that are tried to be promoted.
- */
-static bool numa_promotion_rate_limit(struct pglist_data *pgdat,
-				      unsigned long rate_limit, int nr)
-{
-	unsigned long nr_cand;
-	unsigned int now, start;
-
-	now = jiffies_to_msecs(jiffies);
-	mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE, nr);
-	nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
-	start = pgdat->nbp_rl_start;
-	if (now - start > MSEC_PER_SEC &&
-	    cmpxchg(&pgdat->nbp_rl_start, start, now) == start)
-		pgdat->nbp_rl_nr_cand = nr_cand;
-	if (nr_cand - pgdat->nbp_rl_nr_cand >= rate_limit)
-		return true;
-	return false;
-}
-
-#define NUMA_MIGRATION_ADJUST_STEPS	16
-
-static void numa_promotion_adjust_threshold(struct pglist_data *pgdat,
-					    unsigned long rate_limit,
-					    unsigned int ref_th)
-{
-	unsigned int now, start, th_period, unit_th, th;
-	unsigned long nr_cand, ref_cand, diff_cand;
-
-	now = jiffies_to_msecs(jiffies);
-	th_period = sysctl_numa_balancing_scan_period_max;
-	start = pgdat->nbp_th_start;
-	if (now - start > th_period &&
-	    cmpxchg(&pgdat->nbp_th_start, start, now) == start) {
-		ref_cand = rate_limit *
-			sysctl_numa_balancing_scan_period_max / MSEC_PER_SEC;
-		nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
-		diff_cand = nr_cand - pgdat->nbp_th_nr_cand;
-		unit_th = ref_th * 2 / NUMA_MIGRATION_ADJUST_STEPS;
-		th = pgdat->nbp_threshold ? : ref_th;
-		if (diff_cand > ref_cand * 11 / 10)
-			th = max(th - unit_th, unit_th);
-		else if (diff_cand < ref_cand * 9 / 10)
-			th = min(th + unit_th, ref_th * 2);
-		pgdat->nbp_th_nr_cand = nr_cand;
-		pgdat->nbp_threshold = th;
-	}
-}
-
-bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
-				int src_nid, int dst_cpu)
-{
-	struct numa_group *ng = deref_curr_numa_group(p);
-	int dst_nid = cpu_to_node(dst_cpu);
-	int last_cpupid, this_cpupid;
-
-	/*
-	 * Cannot migrate to memoryless nodes.
-	 */
-	if (!node_state(dst_nid, N_MEMORY))
-		return false;
-
-	/*
-	 * The pages in slow memory node should be migrated according
-	 * to hot/cold instead of private/shared.
-	 */
-	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
-	    !node_is_toptier(src_nid)) {
-		struct pglist_data *pgdat;
-		unsigned long rate_limit;
-		unsigned int latency, th, def_th;
-
-		pgdat = NODE_DATA(dst_nid);
-		if (pgdat_free_space_enough(pgdat)) {
-			/* workload changed, reset hot threshold */
-			pgdat->nbp_threshold = 0;
-			return true;
-		}
-
-		def_th = sysctl_numa_balancing_hot_threshold;
-		rate_limit = sysctl_numa_balancing_promote_rate_limit << \
-			(20 - PAGE_SHIFT);
-		numa_promotion_adjust_threshold(pgdat, rate_limit, def_th);
-
-		th = pgdat->nbp_threshold ? : def_th;
-		latency = numa_hint_fault_latency(folio);
-		if (latency >= th)
-			return false;
-
-		return !numa_promotion_rate_limit(pgdat, rate_limit,
-						  folio_nr_pages(folio));
-	}
-
-	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
-	last_cpupid = folio_xchg_last_cpupid(folio, this_cpupid);
-
-	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
-	    !node_is_toptier(src_nid) && !cpupid_valid(last_cpupid))
-		return false;
-
-	/*
-	 * Allow first faults or private faults to migrate immediately early in
-	 * the lifetime of a task. The magic number 4 is based on waiting for
-	 * two full passes of the "multi-stage node selection" test that is
-	 * executed below.
-	 */
-	if ((p->numa_preferred_nid == NUMA_NO_NODE || p->numa_scan_seq <= 4) &&
-	    (cpupid_pid_unset(last_cpupid) || cpupid_match_pid(p, last_cpupid)))
-		return true;
-
-	/*
-	 * Multi-stage node selection is used in conjunction with a periodic
-	 * migration fault to build a temporal task<->page relation. By using
-	 * a two-stage filter we remove short/unlikely relations.
-	 *
-	 * Using P(p) ~ n_p / n_t as per frequentist probability, we can equate
-	 * a task's usage of a particular page (n_p) per total usage of this
-	 * page (n_t) (in a given time-span) to a probability.
-	 *
-	 * Our periodic faults will sample this probability and getting the
-	 * same result twice in a row, given these samples are fully
-	 * independent, is then given by P(n)^2, provided our sample period
-	 * is sufficiently short compared to the usage pattern.
-	 *
-	 * This quadric squishes small probabilities, making it less likely we
-	 * act on an unlikely task<->page relation.
-	 */
-	if (!cpupid_pid_unset(last_cpupid) &&
-				cpupid_to_nid(last_cpupid) != dst_nid)
-		return false;
-
-	/* Always allow migrate on private faults */
-	if (cpupid_match_pid(p, last_cpupid))
-		return true;
-
-	/* A shared fault, but p->numa_group has not been set up yet. */
-	if (!ng)
-		return true;
-
-	/*
-	 * Destination node is much more heavily used than the source
-	 * node? Allow migration.
-	 */
-	if (group_faults_cpu(ng, dst_nid) > group_faults_cpu(ng, src_nid) *
-					ACTIVE_NODE_FRACTION)
-		return true;
-
-	/*
-	 * Distribute memory according to CPU & memory use on each node,
-	 * with 3/4 hysteresis to avoid unnecessary memory migrations:
-	 *
-	 * faults_cpu(dst)   3   faults_cpu(src)
-	 * --------------- * - > ---------------
-	 * faults_mem(dst)   4   faults_mem(src)
-	 */
-	return group_faults_cpu(ng, dst_nid) * group_faults(p, src_nid) * 3 >
-	       group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
-}
-
-/*
- * 'numa_type' describes the node at the moment of load balancing.
- */
-enum numa_type {
-	/* The node has spare capacity that can be used to run more tasks.  */
-	node_has_spare = 0,
-	/*
-	 * The node is fully used and the tasks don't compete for more CPU
-	 * cycles. Nevertheless, some tasks might wait before running.
-	 */
-	node_fully_busy,
-	/*
-	 * The node is overloaded and can't provide expected CPU cycles to all
-	 * tasks.
-	 */
-	node_overloaded
-};
-
-/* Cached statistics for all CPUs within a node */
-struct numa_stats {
-	unsigned long load;
-	unsigned long runnable;
-	unsigned long util;
-	/* Total compute capacity of CPUs on a node */
-	unsigned long compute_capacity;
-	unsigned int nr_running;
-	unsigned int weight;
-	enum numa_type node_type;
-	int idle_cpu;
-};
-
-struct task_numa_env {
-	struct task_struct *p;
-
-	int src_cpu, src_nid;
-	int dst_cpu, dst_nid;
-	int imb_numa_nr;
-
-	struct numa_stats src_stats, dst_stats;
-
-	int imbalance_pct;
-	int dist;
-
-	struct task_struct *best_task;
-	long best_imp;
-	int best_cpu;
-};
-
-static unsigned long cpu_load(struct rq *rq);
-
-static inline enum
-numa_type numa_classify(unsigned int imbalance_pct,
-			 struct numa_stats *ns)
-{
-	if ((ns->nr_running > ns->weight) &&
-	    (((ns->compute_capacity * 100) < (ns->util * imbalance_pct)) ||
-	     ((ns->compute_capacity * imbalance_pct) < (ns->runnable * 100))))
-		return node_overloaded;
-
-	if ((ns->nr_running < ns->weight) ||
-	    (((ns->compute_capacity * 100) > (ns->util * imbalance_pct)) &&
-	     ((ns->compute_capacity * imbalance_pct) > (ns->runnable * 100))))
-		return node_has_spare;
-
-	return node_fully_busy;
-}
-
-#ifdef CONFIG_SCHED_SMT
-/* Forward declarations of select_idle_sibling helpers */
-static inline bool test_idle_cores(int cpu);
-static inline int numa_idle_core(int idle_core, int cpu)
-{
-	if (!static_branch_likely(&sched_smt_present) ||
-	    idle_core >= 0 || !test_idle_cores(cpu))
-		return idle_core;
-
-	/*
-	 * Prefer cores instead of packing HT siblings
-	 * and triggering future load balancing.
-	 */
-	if (is_core_idle(cpu))
-		idle_core = cpu;
-
-	return idle_core;
-}
-#else
-static inline int numa_idle_core(int idle_core, int cpu)
-{
-	return idle_core;
-}
-#endif
-
-/*
- * Gather all necessary information to make NUMA balancing placement
- * decisions that are compatible with standard load balancer. This
- * borrows code and logic from update_sg_lb_stats but sharing a
- * common implementation is impractical.
- */
-static void update_numa_stats(struct task_numa_env *env,
-			      struct numa_stats *ns, int nid,
-			      bool find_idle)
-{
-	int cpu, idle_core = -1;
-
-	memset(ns, 0, sizeof(*ns));
-	ns->idle_cpu = -1;
-
-	rcu_read_lock();
-	for_each_cpu(cpu, cpumask_of_node(nid)) {
-		struct rq *rq = cpu_rq(cpu);
-
-		ns->load += cpu_load(rq);
-		ns->runnable += cpu_runnable(rq);
-		ns->util += cpu_util_cfs(cpu);
-		ns->nr_running += rq->cfs.h_nr_running;
-		ns->compute_capacity += capacity_of(cpu);
-
-		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
-			if (READ_ONCE(rq->numa_migrate_on) ||
-			    !cpumask_test_cpu(cpu, env->p->cpus_ptr))
-				continue;
-
-			if (ns->idle_cpu == -1)
-				ns->idle_cpu = cpu;
-
-			idle_core = numa_idle_core(idle_core, cpu);
-		}
-	}
-	rcu_read_unlock();
-
-	ns->weight = cpumask_weight(cpumask_of_node(nid));
-
-	ns->node_type = numa_classify(env->imbalance_pct, ns);
-
-	if (idle_core >= 0)
-		ns->idle_cpu = idle_core;
-}
-
-static void task_numa_assign(struct task_numa_env *env,
-			     struct task_struct *p, long imp)
-{
-	struct rq *rq = cpu_rq(env->dst_cpu);
-
-	/* Check if run-queue part of active NUMA balance. */
-	if (env->best_cpu != env->dst_cpu && xchg(&rq->numa_migrate_on, 1)) {
-		int cpu;
-		int start = env->dst_cpu;
-
-		/* Find alternative idle CPU. */
-		for_each_cpu_wrap(cpu, cpumask_of_node(env->dst_nid), start + 1) {
-			if (cpu == env->best_cpu || !idle_cpu(cpu) ||
-			    !cpumask_test_cpu(cpu, env->p->cpus_ptr)) {
-				continue;
-			}
-
-			env->dst_cpu = cpu;
-			rq = cpu_rq(env->dst_cpu);
-			if (!xchg(&rq->numa_migrate_on, 1))
-				goto assign;
-		}
-
-		/* Failed to find an alternative idle CPU */
-		return;
-	}
-
-assign:
-	/*
-	 * Clear previous best_cpu/rq numa-migrate flag, since task now
-	 * found a better CPU to move/swap.
-	 */
-	if (env->best_cpu != -1 && env->best_cpu != env->dst_cpu) {
-		rq = cpu_rq(env->best_cpu);
-		WRITE_ONCE(rq->numa_migrate_on, 0);
-	}
-
-	if (env->best_task)
-		put_task_struct(env->best_task);
-	if (p)
-		get_task_struct(p);
-
-	env->best_task = p;
-	env->best_imp = imp;
-	env->best_cpu = env->dst_cpu;
-}
-
-static bool load_too_imbalanced(long src_load, long dst_load,
-				struct task_numa_env *env)
-{
-	long imb, old_imb;
-	long orig_src_load, orig_dst_load;
-	long src_capacity, dst_capacity;
-
-	/*
-	 * The load is corrected for the CPU capacity available on each node.
-	 *
-	 * src_load        dst_load
-	 * ------------ vs ---------
-	 * src_capacity    dst_capacity
-	 */
-	src_capacity = env->src_stats.compute_capacity;
-	dst_capacity = env->dst_stats.compute_capacity;
-
-	imb = abs(dst_load * src_capacity - src_load * dst_capacity);
-
-	orig_src_load = env->src_stats.load;
-	orig_dst_load = env->dst_stats.load;
-
-	old_imb = abs(orig_dst_load * src_capacity - orig_src_load * dst_capacity);
-
-	/* Would this change make things worse? */
-	return (imb > old_imb);
-}
-
-/*
- * Maximum NUMA importance can be 1998 (2*999);
- * SMALLIMP @ 30 would be close to 1998/64.
- * Used to deter task migration.
- */
-#define SMALLIMP	30
-
-/*
- * This checks if the overall compute and NUMA accesses of the system would
- * be improved if the source tasks was migrated to the target dst_cpu taking
- * into account that it might be best if task running on the dst_cpu should
- * be exchanged with the source task
- */
-static bool task_numa_compare(struct task_numa_env *env,
-			      long taskimp, long groupimp, bool maymove)
-{
-	struct numa_group *cur_ng, *p_ng = deref_curr_numa_group(env->p);
-	struct rq *dst_rq = cpu_rq(env->dst_cpu);
-	long imp = p_ng ? groupimp : taskimp;
-	struct task_struct *cur;
-	long src_load, dst_load;
-	int dist = env->dist;
-	long moveimp = imp;
-	long load;
-	bool stopsearch = false;
-
-	if (READ_ONCE(dst_rq->numa_migrate_on))
-		return false;
-
-	rcu_read_lock();
-	cur = rcu_dereference(dst_rq->curr);
-	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
-		cur = NULL;
-
-	/*
-	 * Because we have preemption enabled we can get migrated around and
-	 * end try selecting ourselves (current == env->p) as a swap candidate.
-	 */
-	if (cur == env->p) {
-		stopsearch = true;
-		goto unlock;
-	}
-
-	if (!cur) {
-		if (maymove && moveimp >= env->best_imp)
-			goto assign;
-		else
-			goto unlock;
-	}
-
-	/* Skip this swap candidate if cannot move to the source cpu. */
-	if (!cpumask_test_cpu(env->src_cpu, cur->cpus_ptr))
-		goto unlock;
-
-	/*
-	 * Skip this swap candidate if it is not moving to its preferred
-	 * node and the best task is.
-	 */
-	if (env->best_task &&
-	    env->best_task->numa_preferred_nid == env->src_nid &&
-	    cur->numa_preferred_nid != env->src_nid) {
-		goto unlock;
-	}
-
-	/*
-	 * "imp" is the fault differential for the source task between the
-	 * source and destination node. Calculate the total differential for
-	 * the source task and potential destination task. The more negative
-	 * the value is, the more remote accesses that would be expected to
-	 * be incurred if the tasks were swapped.
-	 *
-	 * If dst and source tasks are in the same NUMA group, or not
-	 * in any group then look only at task weights.
-	 */
-	cur_ng = rcu_dereference(cur->numa_group);
-	if (cur_ng == p_ng) {
-		/*
-		 * Do not swap within a group or between tasks that have
-		 * no group if there is spare capacity. Swapping does
-		 * not address the load imbalance and helps one task at
-		 * the cost of punishing another.
-		 */
-		if (env->dst_stats.node_type == node_has_spare)
-			goto unlock;
-
-		imp = taskimp + task_weight(cur, env->src_nid, dist) -
-		      task_weight(cur, env->dst_nid, dist);
-		/*
-		 * Add some hysteresis to prevent swapping the
-		 * tasks within a group over tiny differences.
-		 */
-		if (cur_ng)
-			imp -= imp / 16;
-	} else {
-		/*
-		 * Compare the group weights. If a task is all by itself
-		 * (not part of a group), use the task weight instead.
-		 */
-		if (cur_ng && p_ng)
-			imp += group_weight(cur, env->src_nid, dist) -
-			       group_weight(cur, env->dst_nid, dist);
-		else
-			imp += task_weight(cur, env->src_nid, dist) -
-			       task_weight(cur, env->dst_nid, dist);
-	}
-
-	/* Discourage picking a task already on its preferred node */
-	if (cur->numa_preferred_nid == env->dst_nid)
-		imp -= imp / 16;
-
-	/*
-	 * Encourage picking a task that moves to its preferred node.
-	 * This potentially makes imp larger than it's maximum of
-	 * 1998 (see SMALLIMP and task_weight for why) but in this
-	 * case, it does not matter.
-	 */
-	if (cur->numa_preferred_nid == env->src_nid)
-		imp += imp / 8;
-
-	if (maymove && moveimp > imp && moveimp > env->best_imp) {
-		imp = moveimp;
-		cur = NULL;
-		goto assign;
-	}
-
-	/*
-	 * Prefer swapping with a task moving to its preferred node over a
-	 * task that is not.
-	 */
-	if (env->best_task && cur->numa_preferred_nid == env->src_nid &&
-	    env->best_task->numa_preferred_nid != env->src_nid) {
-		goto assign;
-	}
-
-	/*
-	 * If the NUMA importance is less than SMALLIMP,
-	 * task migration might only result in ping pong
-	 * of tasks and also hurt performance due to cache
-	 * misses.
-	 */
-	if (imp < SMALLIMP || imp <= env->best_imp + SMALLIMP / 2)
-		goto unlock;
-
-	/*
-	 * In the overloaded case, try and keep the load balanced.
-	 */
-	load = task_h_load(env->p) - task_h_load(cur);
-	if (!load)
-		goto assign;
-
-	dst_load = env->dst_stats.load + load;
-	src_load = env->src_stats.load - load;
-
-	if (load_too_imbalanced(src_load, dst_load, env))
-		goto unlock;
-
-assign:
-	/* Evaluate an idle CPU for a task numa move. */
-	if (!cur) {
-		int cpu = env->dst_stats.idle_cpu;
-
-		/* Nothing cached so current CPU went idle since the search. */
-		if (cpu < 0)
-			cpu = env->dst_cpu;
-
-		/*
-		 * If the CPU is no longer truly idle and the previous best CPU
-		 * is, keep using it.
-		 */
-		if (!idle_cpu(cpu) && env->best_cpu >= 0 &&
-		    idle_cpu(env->best_cpu)) {
-			cpu = env->best_cpu;
-		}
-
-		env->dst_cpu = cpu;
-	}
-
-	task_numa_assign(env, cur, imp);
-
-	/*
-	 * If a move to idle is allowed because there is capacity or load
-	 * balance improves then stop the search. While a better swap
-	 * candidate may exist, a search is not free.
-	 */
-	if (maymove && !cur && env->best_cpu >= 0 && idle_cpu(env->best_cpu))
-		stopsearch = true;
-
-	/*
-	 * If a swap candidate must be identified and the current best task
-	 * moves its preferred node then stop the search.
-	 */
-	if (!maymove && env->best_task &&
-	    env->best_task->numa_preferred_nid == env->src_nid) {
-		stopsearch = true;
-	}
-unlock:
-	rcu_read_unlock();
-
-	return stopsearch;
-}
-
-static void task_numa_find_cpu(struct task_numa_env *env,
-				long taskimp, long groupimp)
-{
-	bool maymove = false;
-	int cpu;
-
-	/*
-	 * If dst node has spare capacity, then check if there is an
-	 * imbalance that would be overruled by the load balancer.
-	 */
-	if (env->dst_stats.node_type == node_has_spare) {
-		unsigned int imbalance;
-		int src_running, dst_running;
-
-		/*
-		 * Would movement cause an imbalance? Note that if src has
-		 * more running tasks that the imbalance is ignored as the
-		 * move improves the imbalance from the perspective of the
-		 * CPU load balancer.
-		 * */
-		src_running = env->src_stats.nr_running - 1;
-		dst_running = env->dst_stats.nr_running + 1;
-		imbalance = max(0, dst_running - src_running);
-		imbalance = adjust_numa_imbalance(imbalance, dst_running,
-						  env->imb_numa_nr);
-
-		/* Use idle CPU if there is no imbalance */
-		if (!imbalance) {
-			maymove = true;
-			if (env->dst_stats.idle_cpu >= 0) {
-				env->dst_cpu = env->dst_stats.idle_cpu;
-				task_numa_assign(env, NULL, 0);
-				return;
-			}
-		}
-	} else {
-		long src_load, dst_load, load;
-		/*
-		 * If the improvement from just moving env->p direction is better
-		 * than swapping tasks around, check if a move is possible.
-		 */
-		load = task_h_load(env->p);
-		dst_load = env->dst_stats.load + load;
-		src_load = env->src_stats.load - load;
-		maymove = !load_too_imbalanced(src_load, dst_load, env);
-	}
-
-	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
-		/* Skip this CPU if the source task cannot migrate */
-		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
-			continue;
-
-		env->dst_cpu = cpu;
-		if (task_numa_compare(env, taskimp, groupimp, maymove))
-			break;
-	}
-}
-
-static int task_numa_migrate(struct task_struct *p)
-{
-	struct task_numa_env env = {
-		.p = p,
-
-		.src_cpu = task_cpu(p),
-		.src_nid = task_node(p),
-
-		.imbalance_pct = 112,
-
-		.best_task = NULL,
-		.best_imp = 0,
-		.best_cpu = -1,
-	};
-	unsigned long taskweight, groupweight;
-	struct sched_domain *sd;
-	long taskimp, groupimp;
-	struct numa_group *ng;
-	struct rq *best_rq;
-	int nid, ret, dist;
-
-	/*
-	 * Pick the lowest SD_NUMA domain, as that would have the smallest
-	 * imbalance and would be the first to start moving tasks about.
-	 *
-	 * And we want to avoid any moving of tasks about, as that would create
-	 * random movement of tasks -- counter the numa conditions we're trying
-	 * to satisfy here.
-	 */
-	rcu_read_lock();
-	sd = rcu_dereference(per_cpu(sd_numa, env.src_cpu));
-	if (sd) {
-		env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
-		env.imb_numa_nr = sd->imb_numa_nr;
-	}
-	rcu_read_unlock();
-
-	/*
-	 * Cpusets can break the scheduler domain tree into smaller
-	 * balance domains, some of which do not cross NUMA boundaries.
-	 * Tasks that are "trapped" in such domains cannot be migrated
-	 * elsewhere, so there is no point in (re)trying.
-	 */
-	if (unlikely(!sd)) {
-		sched_setnuma(p, task_node(p));
-		return -EINVAL;
-	}
-
-	env.dst_nid = p->numa_preferred_nid;
-	dist = env.dist = node_distance(env.src_nid, env.dst_nid);
-	taskweight = task_weight(p, env.src_nid, dist);
-	groupweight = group_weight(p, env.src_nid, dist);
-	update_numa_stats(&env, &env.src_stats, env.src_nid, false);
-	taskimp = task_weight(p, env.dst_nid, dist) - taskweight;
-	groupimp = group_weight(p, env.dst_nid, dist) - groupweight;
-	update_numa_stats(&env, &env.dst_stats, env.dst_nid, true);
-
-	/* Try to find a spot on the preferred nid. */
-	task_numa_find_cpu(&env, taskimp, groupimp);
-
-	/*
-	 * Look at other nodes in these cases:
-	 * - there is no space available on the preferred_nid
-	 * - the task is part of a numa_group that is interleaved across
-	 *   multiple NUMA nodes; in order to better consolidate the group,
-	 *   we need to check other locations.
-	 */
-	ng = deref_curr_numa_group(p);
-	if (env.best_cpu == -1 || (ng && ng->active_nodes > 1)) {
-		for_each_node_state(nid, N_CPU) {
-			if (nid == env.src_nid || nid == p->numa_preferred_nid)
-				continue;
-
-			dist = node_distance(env.src_nid, env.dst_nid);
-			if (sched_numa_topology_type == NUMA_BACKPLANE &&
-						dist != env.dist) {
-				taskweight = task_weight(p, env.src_nid, dist);
-				groupweight = group_weight(p, env.src_nid, dist);
-			}
-
-			/* Only consider nodes where both task and groups benefit */
-			taskimp = task_weight(p, nid, dist) - taskweight;
-			groupimp = group_weight(p, nid, dist) - groupweight;
-			if (taskimp < 0 && groupimp < 0)
-				continue;
-
-			env.dist = dist;
-			env.dst_nid = nid;
-			update_numa_stats(&env, &env.dst_stats, env.dst_nid, true);
-			task_numa_find_cpu(&env, taskimp, groupimp);
-		}
-	}
-
-	/*
-	 * If the task is part of a workload that spans multiple NUMA nodes,
-	 * and is migrating into one of the workload's active nodes, remember
-	 * this node as the task's preferred numa node, so the workload can
-	 * settle down.
-	 * A task that migrated to a second choice node will be better off
-	 * trying for a better one later. Do not set the preferred node here.
-	 */
-	if (ng) {
-		if (env.best_cpu == -1)
-			nid = env.src_nid;
-		else
-			nid = cpu_to_node(env.best_cpu);
-
-		if (nid != p->numa_preferred_nid)
-			sched_setnuma(p, nid);
-	}
-
-	/* No better CPU than the current one was found. */
-	if (env.best_cpu == -1) {
-		trace_sched_stick_numa(p, env.src_cpu, NULL, -1);
-		return -EAGAIN;
-	}
-
-	best_rq = cpu_rq(env.best_cpu);
-	if (env.best_task == NULL) {
-		ret = migrate_task_to(p, env.best_cpu);
-		WRITE_ONCE(best_rq->numa_migrate_on, 0);
-		if (ret != 0)
-			trace_sched_stick_numa(p, env.src_cpu, NULL, env.best_cpu);
-		return ret;
-	}
-
-	ret = migrate_swap(p, env.best_task, env.best_cpu, env.src_cpu);
-	WRITE_ONCE(best_rq->numa_migrate_on, 0);
-
-	if (ret != 0)
-		trace_sched_stick_numa(p, env.src_cpu, env.best_task, env.best_cpu);
-	put_task_struct(env.best_task);
-	return ret;
-}
-
-/* Attempt to migrate a task to a CPU on the preferred node. */
-static void numa_migrate_preferred(struct task_struct *p)
-{
-	unsigned long interval = HZ;
-
-	/* This task has no NUMA fault statistics yet */
-	if (unlikely(p->numa_preferred_nid == NUMA_NO_NODE || !p->numa_faults))
-		return;
-
-	/* Periodically retry migrating the task to the preferred node */
-	interval = min(interval, msecs_to_jiffies(p->numa_scan_period) / 16);
-	p->numa_migrate_retry = jiffies + interval;
-
-	/* Success if task is already running on preferred CPU */
-	if (task_node(p) == p->numa_preferred_nid)
-		return;
-
-	/* Otherwise, try migrate to a CPU on the preferred node */
-	task_numa_migrate(p);
-}
-
-/*
- * Find out how many nodes the workload is actively running on. Do this by
- * tracking the nodes from which NUMA hinting faults are triggered. This can
- * be different from the set of nodes where the workload's memory is currently
- * located.
- */
-static void numa_group_count_active_nodes(struct numa_group *numa_group)
-{
-	unsigned long faults, max_faults = 0;
-	int nid, active_nodes = 0;
-
-	for_each_node_state(nid, N_CPU) {
-		faults = group_faults_cpu(numa_group, nid);
-		if (faults > max_faults)
-			max_faults = faults;
-	}
-
-	for_each_node_state(nid, N_CPU) {
-		faults = group_faults_cpu(numa_group, nid);
-		if (faults * ACTIVE_NODE_FRACTION > max_faults)
-			active_nodes++;
-	}
-
-	numa_group->max_faults_cpu = max_faults;
-	numa_group->active_nodes = active_nodes;
-}
-
-/*
- * When adapting the scan rate, the period is divided into NUMA_PERIOD_SLOTS
- * increments. The more local the fault statistics are, the higher the scan
- * period will be for the next scan window. If local/(local+remote) ratio is
- * below NUMA_PERIOD_THRESHOLD (where range of ratio is 1..NUMA_PERIOD_SLOTS)
- * the scan period will decrease. Aim for 70% local accesses.
- */
-#define NUMA_PERIOD_SLOTS 10
-#define NUMA_PERIOD_THRESHOLD 7
-
-/*
- * Increase the scan period (slow down scanning) if the majority of
- * our memory is already on our local node, or if the majority of
- * the page accesses are shared with other processes.
- * Otherwise, decrease the scan period.
- */
-static void update_task_scan_period(struct task_struct *p,
-			unsigned long shared, unsigned long private)
-{
-	unsigned int period_slot;
-	int lr_ratio, ps_ratio;
-	int diff;
-
-	unsigned long remote = p->numa_faults_locality[0];
-	unsigned long local = p->numa_faults_locality[1];
-
-	/*
-	 * If there were no record hinting faults then either the task is
-	 * completely idle or all activity is in areas that are not of interest
-	 * to automatic numa balancing. Related to that, if there were failed
-	 * migration then it implies we are migrating too quickly or the local
-	 * node is overloaded. In either case, scan slower
-	 */
-	if (local + shared == 0 || p->numa_faults_locality[2]) {
-		p->numa_scan_period = min(p->numa_scan_period_max,
-			p->numa_scan_period << 1);
-
-		p->mm->numa_next_scan = jiffies +
-			msecs_to_jiffies(p->numa_scan_period);
-
-		return;
-	}
-
-	/*
-	 * Prepare to scale scan period relative to the current period.
-	 *	 == NUMA_PERIOD_THRESHOLD scan period stays the same
-	 *       <  NUMA_PERIOD_THRESHOLD scan period decreases (scan faster)
-	 *	 >= NUMA_PERIOD_THRESHOLD scan period increases (scan slower)
-	 */
-	period_slot = DIV_ROUND_UP(p->numa_scan_period, NUMA_PERIOD_SLOTS);
-	lr_ratio = (local * NUMA_PERIOD_SLOTS) / (local + remote);
-	ps_ratio = (private * NUMA_PERIOD_SLOTS) / (private + shared);
-
-	if (ps_ratio >= NUMA_PERIOD_THRESHOLD) {
-		/*
-		 * Most memory accesses are local. There is no need to
-		 * do fast NUMA scanning, since memory is already local.
-		 */
-		int slot = ps_ratio - NUMA_PERIOD_THRESHOLD;
-		if (!slot)
-			slot = 1;
-		diff = slot * period_slot;
-	} else if (lr_ratio >= NUMA_PERIOD_THRESHOLD) {
-		/*
-		 * Most memory accesses are shared with other tasks.
-		 * There is no point in continuing fast NUMA scanning,
-		 * since other tasks may just move the memory elsewhere.
-		 */
-		int slot = lr_ratio - NUMA_PERIOD_THRESHOLD;
-		if (!slot)
-			slot = 1;
-		diff = slot * period_slot;
-	} else {
-		/*
-		 * Private memory faults exceed (SLOTS-THRESHOLD)/SLOTS,
-		 * yet they are not on the local NUMA node. Speed up
-		 * NUMA scanning to get the memory moved over.
-		 */
-		int ratio = max(lr_ratio, ps_ratio);
-		diff = -(NUMA_PERIOD_THRESHOLD - ratio) * period_slot;
-	}
-
-	p->numa_scan_period = clamp(p->numa_scan_period + diff,
-			task_scan_min(p), task_scan_max(p));
-	memset(p->numa_faults_locality, 0, sizeof(p->numa_faults_locality));
-}
-
-/*
- * Get the fraction of time the task has been running since the last
- * NUMA placement cycle. The scheduler keeps similar statistics, but
- * decays those on a 32ms period, which is orders of magnitude off
- * from the dozens-of-seconds NUMA balancing period. Use the scheduler
- * stats only if the task is so new there are no NUMA statistics yet.
- */
-static u64 numa_get_avg_runtime(struct task_struct *p, u64 *period)
-{
-	u64 runtime, delta, now;
-	/* Use the start of this time slice to avoid calculations. */
-	now = p->se.exec_start;
-	runtime = p->se.sum_exec_runtime;
-
-	if (p->last_task_numa_placement) {
-		delta = runtime - p->last_sum_exec_runtime;
-		*period = now - p->last_task_numa_placement;
-
-		/* Avoid time going backwards, prevent potential divide error: */
-		if (unlikely((s64)*period < 0))
-			*period = 0;
-	} else {
-		delta = p->se.avg.load_sum;
-		*period = LOAD_AVG_MAX;
-	}
-
-	p->last_sum_exec_runtime = runtime;
-	p->last_task_numa_placement = now;
-
-	return delta;
-}
-
-/*
- * Determine the preferred nid for a task in a numa_group. This needs to
- * be done in a way that produces consistent results with group_weight,
- * otherwise workloads might not converge.
- */
-static int preferred_group_nid(struct task_struct *p, int nid)
-{
-	nodemask_t nodes;
-	int dist;
-
-	/* Direct connections between all NUMA nodes. */
-	if (sched_numa_topology_type == NUMA_DIRECT)
-		return nid;
-
-	/*
-	 * On a system with glueless mesh NUMA topology, group_weight
-	 * scores nodes according to the number of NUMA hinting faults on
-	 * both the node itself, and on nearby nodes.
-	 */
-	if (sched_numa_topology_type == NUMA_GLUELESS_MESH) {
-		unsigned long score, max_score = 0;
-		int node, max_node = nid;
-
-		dist = sched_max_numa_distance;
-
-		for_each_node_state(node, N_CPU) {
-			score = group_weight(p, node, dist);
-			if (score > max_score) {
-				max_score = score;
-				max_node = node;
-			}
-		}
-		return max_node;
-	}
-
-	/*
-	 * Finding the preferred nid in a system with NUMA backplane
-	 * interconnect topology is more involved. The goal is to locate
-	 * tasks from numa_groups near each other in the system, and
-	 * untangle workloads from different sides of the system. This requires
-	 * searching down the hierarchy of node groups, recursively searching
-	 * inside the highest scoring group of nodes. The nodemask tricks
-	 * keep the complexity of the search down.
-	 */
-	nodes = node_states[N_CPU];
-	for (dist = sched_max_numa_distance; dist > LOCAL_DISTANCE; dist--) {
-		unsigned long max_faults = 0;
-		nodemask_t max_group = NODE_MASK_NONE;
-		int a, b;
-
-		/* Are there nodes at this distance from each other? */
-		if (!find_numa_distance(dist))
-			continue;
-
-		for_each_node_mask(a, nodes) {
-			unsigned long faults = 0;
-			nodemask_t this_group;
-			nodes_clear(this_group);
-
-			/* Sum group's NUMA faults; includes a==b case. */
-			for_each_node_mask(b, nodes) {
-				if (node_distance(a, b) < dist) {
-					faults += group_faults(p, b);
-					node_set(b, this_group);
-					node_clear(b, nodes);
-				}
-			}
-
-			/* Remember the top group. */
-			if (faults > max_faults) {
-				max_faults = faults;
-				max_group = this_group;
-				/*
-				 * subtle: at the smallest distance there is
-				 * just one node left in each "group", the
-				 * winner is the preferred nid.
-				 */
-				nid = a;
-			}
-		}
-		/* Next round, evaluate the nodes within max_group. */
-		if (!max_faults)
-			break;
-		nodes = max_group;
-	}
-	return nid;
-}
-
-static void task_numa_placement(struct task_struct *p)
-{
-	int seq, nid, max_nid = NUMA_NO_NODE;
-	unsigned long max_faults = 0;
-	unsigned long fault_types[2] = { 0, 0 };
-	unsigned long total_faults;
-	u64 runtime, period;
-	spinlock_t *group_lock = NULL;
-	struct numa_group *ng;
-
-	/*
-	 * The p->mm->numa_scan_seq field gets updated without
-	 * exclusive access. Use READ_ONCE() here to ensure
-	 * that the field is read in a single access:
-	 */
-	seq = READ_ONCE(p->mm->numa_scan_seq);
-	if (p->numa_scan_seq == seq)
-		return;
-	p->numa_scan_seq = seq;
-	p->numa_scan_period_max = task_scan_max(p);
-
-	total_faults = p->numa_faults_locality[0] +
-		       p->numa_faults_locality[1];
-	runtime = numa_get_avg_runtime(p, &period);
-
-	/* If the task is part of a group prevent parallel updates to group stats */
-	ng = deref_curr_numa_group(p);
-	if (ng) {
-		group_lock = &ng->lock;
-		spin_lock_irq(group_lock);
-	}
-
-	/* Find the node with the highest number of faults */
-	for_each_online_node(nid) {
-		/* Keep track of the offsets in numa_faults array */
-		int mem_idx, membuf_idx, cpu_idx, cpubuf_idx;
-		unsigned long faults = 0, group_faults = 0;
-		int priv;
-
-		for (priv = 0; priv < NR_NUMA_HINT_FAULT_TYPES; priv++) {
-			long diff, f_diff, f_weight;
-
-			mem_idx = task_faults_idx(NUMA_MEM, nid, priv);
-			membuf_idx = task_faults_idx(NUMA_MEMBUF, nid, priv);
-			cpu_idx = task_faults_idx(NUMA_CPU, nid, priv);
-			cpubuf_idx = task_faults_idx(NUMA_CPUBUF, nid, priv);
-
-			/* Decay existing window, copy faults since last scan */
-			diff = p->numa_faults[membuf_idx] - p->numa_faults[mem_idx] / 2;
-			fault_types[priv] += p->numa_faults[membuf_idx];
-			p->numa_faults[membuf_idx] = 0;
-
-			/*
-			 * Normalize the faults_from, so all tasks in a group
-			 * count according to CPU use, instead of by the raw
-			 * number of faults. Tasks with little runtime have
-			 * little over-all impact on throughput, and thus their
-			 * faults are less important.
-			 */
-			f_weight = div64_u64(runtime << 16, period + 1);
-			f_weight = (f_weight * p->numa_faults[cpubuf_idx]) /
-				   (total_faults + 1);
-			f_diff = f_weight - p->numa_faults[cpu_idx] / 2;
-			p->numa_faults[cpubuf_idx] = 0;
-
-			p->numa_faults[mem_idx] += diff;
-			p->numa_faults[cpu_idx] += f_diff;
-			faults += p->numa_faults[mem_idx];
-			p->total_numa_faults += diff;
-			if (ng) {
-				/*
-				 * safe because we can only change our own group
-				 *
-				 * mem_idx represents the offset for a given
-				 * nid and priv in a specific region because it
-				 * is at the beginning of the numa_faults array.
-				 */
-				ng->faults[mem_idx] += diff;
-				ng->faults[cpu_idx] += f_diff;
-				ng->total_faults += diff;
-				group_faults += ng->faults[mem_idx];
-			}
-		}
-
-		if (!ng) {
-			if (faults > max_faults) {
-				max_faults = faults;
-				max_nid = nid;
-			}
-		} else if (group_faults > max_faults) {
-			max_faults = group_faults;
-			max_nid = nid;
-		}
-	}
-
-	/* Cannot migrate task to CPU-less node */
-	max_nid = numa_nearest_node(max_nid, N_CPU);
-
-	if (ng) {
-		numa_group_count_active_nodes(ng);
-		spin_unlock_irq(group_lock);
-		max_nid = preferred_group_nid(p, max_nid);
-	}
-
-	if (max_faults) {
-		/* Set the new preferred node */
-		if (max_nid != p->numa_preferred_nid)
-			sched_setnuma(p, max_nid);
-	}
-
-	update_task_scan_period(p, fault_types[0], fault_types[1]);
-}
-
-static inline int get_numa_group(struct numa_group *grp)
-{
-	return refcount_inc_not_zero(&grp->refcount);
-}
-
-static inline void put_numa_group(struct numa_group *grp)
-{
-	if (refcount_dec_and_test(&grp->refcount))
-		kfree_rcu(grp, rcu);
-}
-
-static void task_numa_group(struct task_struct *p, int cpupid, int flags,
-			int *priv)
-{
-	struct numa_group *grp, *my_grp;
-	struct task_struct *tsk;
-	bool join = false;
-	int cpu = cpupid_to_cpu(cpupid);
-	int i;
-
-	if (unlikely(!deref_curr_numa_group(p))) {
-		unsigned int size = sizeof(struct numa_group) +
-				    NR_NUMA_HINT_FAULT_STATS *
-				    nr_node_ids * sizeof(unsigned long);
-
-		grp = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
-		if (!grp)
-			return;
-
-		refcount_set(&grp->refcount, 1);
-		grp->active_nodes = 1;
-		grp->max_faults_cpu = 0;
-		spin_lock_init(&grp->lock);
-		grp->gid = p->pid;
-
-		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
-			grp->faults[i] = p->numa_faults[i];
-
-		grp->total_faults = p->total_numa_faults;
-
-		grp->nr_tasks++;
-		rcu_assign_pointer(p->numa_group, grp);
-	}
-
-	rcu_read_lock();
-	tsk = READ_ONCE(cpu_rq(cpu)->curr);
-
-	if (!cpupid_match_pid(tsk, cpupid))
-		goto no_join;
-
-	grp = rcu_dereference(tsk->numa_group);
-	if (!grp)
-		goto no_join;
-
-	my_grp = deref_curr_numa_group(p);
-	if (grp == my_grp)
-		goto no_join;
-
-	/*
-	 * Only join the other group if its bigger; if we're the bigger group,
-	 * the other task will join us.
-	 */
-	if (my_grp->nr_tasks > grp->nr_tasks)
-		goto no_join;
-
-	/*
-	 * Tie-break on the grp address.
-	 */
-	if (my_grp->nr_tasks == grp->nr_tasks && my_grp > grp)
-		goto no_join;
-
-	/* Always join threads in the same process. */
-	if (tsk->mm == current->mm)
-		join = true;
-
-	/* Simple filter to avoid false positives due to PID collisions */
-	if (flags & TNF_SHARED)
-		join = true;
-
-	/* Update priv based on whether false sharing was detected */
-	*priv = !join;
-
-	if (join && !get_numa_group(grp))
-		goto no_join;
-
-	rcu_read_unlock();
-
-	if (!join)
-		return;
-
-	WARN_ON_ONCE(irqs_disabled());
-	double_lock_irq(&my_grp->lock, &grp->lock);
-
-	for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++) {
-		my_grp->faults[i] -= p->numa_faults[i];
-		grp->faults[i] += p->numa_faults[i];
-	}
-	my_grp->total_faults -= p->total_numa_faults;
-	grp->total_faults += p->total_numa_faults;
-
-	my_grp->nr_tasks--;
-	grp->nr_tasks++;
-
-	spin_unlock(&my_grp->lock);
-	spin_unlock_irq(&grp->lock);
-
-	rcu_assign_pointer(p->numa_group, grp);
-
-	put_numa_group(my_grp);
-	return;
-
-no_join:
-	rcu_read_unlock();
-	return;
-}
-
-/*
- * Get rid of NUMA statistics associated with a task (either current or dead).
- * If @final is set, the task is dead and has reached refcount zero, so we can
- * safely free all relevant data structures. Otherwise, there might be
- * concurrent reads from places like load balancing and procfs, and we should
- * reset the data back to default state without freeing ->numa_faults.
- */
-void task_numa_free(struct task_struct *p, bool final)
-{
-	/* safe: p either is current or is being freed by current */
-	struct numa_group *grp = rcu_dereference_raw(p->numa_group);
-	unsigned long *numa_faults = p->numa_faults;
-	unsigned long flags;
-	int i;
-
-	if (!numa_faults)
-		return;
-
-	if (grp) {
-		spin_lock_irqsave(&grp->lock, flags);
-		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
-			grp->faults[i] -= p->numa_faults[i];
-		grp->total_faults -= p->total_numa_faults;
-
-		grp->nr_tasks--;
-		spin_unlock_irqrestore(&grp->lock, flags);
-		RCU_INIT_POINTER(p->numa_group, NULL);
-		put_numa_group(grp);
-	}
-
-	if (final) {
-		p->numa_faults = NULL;
-		kfree(numa_faults);
-	} else {
-		p->total_numa_faults = 0;
-		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
-			numa_faults[i] = 0;
-	}
-}
-
-/*
- * Got a PROT_NONE fault for a page on @node.
- */
-void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
-{
-	struct task_struct *p = current;
-	bool migrated = flags & TNF_MIGRATED;
-	int cpu_node = task_node(current);
-	int local = !!(flags & TNF_FAULT_LOCAL);
-	struct numa_group *ng;
-	int priv;
-
-	if (!static_branch_likely(&sched_numa_balancing))
-		return;
-
-	/* for example, ksmd faulting in a user's mm */
-	if (!p->mm)
-		return;
-
-	/*
-	 * NUMA faults statistics are unnecessary for the slow memory
-	 * node for memory tiering mode.
-	 */
-	if (!node_is_toptier(mem_node) &&
-	    (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING ||
-	     !cpupid_valid(last_cpupid)))
-		return;
-
-	/* Allocate buffer to track faults on a per-node basis */
-	if (unlikely(!p->numa_faults)) {
-		int size = sizeof(*p->numa_faults) *
-			   NR_NUMA_HINT_FAULT_BUCKETS * nr_node_ids;
-
-		p->numa_faults = kzalloc(size, GFP_KERNEL|__GFP_NOWARN);
-		if (!p->numa_faults)
-			return;
-
-		p->total_numa_faults = 0;
-		memset(p->numa_faults_locality, 0, sizeof(p->numa_faults_locality));
-	}
-
-	/*
-	 * First accesses are treated as private, otherwise consider accesses
-	 * to be private if the accessing pid has not changed
-	 */
-	if (unlikely(last_cpupid == (-1 & LAST_CPUPID_MASK))) {
-		priv = 1;
-	} else {
-		priv = cpupid_match_pid(p, last_cpupid);
-		if (!priv && !(flags & TNF_NO_GROUP))
-			task_numa_group(p, last_cpupid, flags, &priv);
-	}
-
-	/*
-	 * If a workload spans multiple NUMA nodes, a shared fault that
-	 * occurs wholly within the set of nodes that the workload is
-	 * actively using should be counted as local. This allows the
-	 * scan rate to slow down when a workload has settled down.
-	 */
-	ng = deref_curr_numa_group(p);
-	if (!priv && !local && ng && ng->active_nodes > 1 &&
-				numa_is_active_node(cpu_node, ng) &&
-				numa_is_active_node(mem_node, ng))
-		local = 1;
-
-	/*
-	 * Retry to migrate task to preferred node periodically, in case it
-	 * previously failed, or the scheduler moved us.
-	 */
-	if (time_after(jiffies, p->numa_migrate_retry)) {
-		task_numa_placement(p);
-		numa_migrate_preferred(p);
-	}
-
-	if (migrated)
-		p->numa_pages_migrated += pages;
-	if (flags & TNF_MIGRATE_FAIL)
-		p->numa_faults_locality[2] += pages;
-
-	p->numa_faults[task_faults_idx(NUMA_MEMBUF, mem_node, priv)] += pages;
-	p->numa_faults[task_faults_idx(NUMA_CPUBUF, cpu_node, priv)] += pages;
-	p->numa_faults_locality[local] += pages;
-}
-
-static void reset_ptenuma_scan(struct task_struct *p)
-{
-	/*
-	 * We only did a read acquisition of the mmap sem, so
-	 * p->mm->numa_scan_seq is written to without exclusive access
-	 * and the update is not guaranteed to be atomic. That's not
-	 * much of an issue though, since this is just used for
-	 * statistical sampling. Use READ_ONCE/WRITE_ONCE, which are not
-	 * expensive, to avoid any form of compiler optimizations:
-	 */
-	WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);
-	p->mm->numa_scan_offset = 0;
-}
-
-static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	unsigned long pids;
-	/*
-	 * Allow unconditional access first two times, so that all the (pages)
-	 * of VMAs get prot_none fault introduced irrespective of accesses.
-	 * This is also done to avoid any side effect of task scanning
-	 * amplifying the unfairness of disjoint set of VMAs' access.
-	 */
-	if ((READ_ONCE(current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2)
-		return true;
-
-	pids = vma->numab_state->pids_active[0] | vma->numab_state->pids_active[1];
-	if (test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids))
-		return true;
-
-	/*
-	 * Complete a scan that has already started regardless of PID access, or
-	 * some VMAs may never be scanned in multi-threaded applications:
-	 */
-	if (mm->numa_scan_offset > vma->vm_start) {
-		trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_IGNORE_PID);
-		return true;
-	}
-
-	return false;
-}
-
-#define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
-
-/*
- * The expensive part of numa migration is done from task_work context.
- * Triggered from task_tick_numa().
- */
-static void task_numa_work(struct callback_head *work)
-{
-	unsigned long migrate, next_scan, now = jiffies;
-	struct task_struct *p = current;
-	struct mm_struct *mm = p->mm;
-	u64 runtime = p->se.sum_exec_runtime;
-	struct vm_area_struct *vma;
-	unsigned long start, end;
-	unsigned long nr_pte_updates = 0;
-	long pages, virtpages;
-	struct vma_iterator vmi;
-	bool vma_pids_skipped;
-	bool vma_pids_forced = false;
-
-	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
-
-	work->next = work;
-	/*
-	 * Who cares about NUMA placement when they're dying.
-	 *
-	 * NOTE: make sure not to dereference p->mm before this check,
-	 * exit_task_work() happens _after_ exit_mm() so we could be called
-	 * without p->mm even though we still had it when we enqueued this
-	 * work.
-	 */
-	if (p->flags & PF_EXITING)
-		return;
-
-	if (!mm->numa_next_scan) {
-		mm->numa_next_scan = now +
-			msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
-	}
-
-	/*
-	 * Enforce maximal scan/migration frequency..
-	 */
-	migrate = mm->numa_next_scan;
-	if (time_before(now, migrate))
-		return;
-
-	if (p->numa_scan_period == 0) {
-		p->numa_scan_period_max = task_scan_max(p);
-		p->numa_scan_period = task_scan_start(p);
-	}
-
-	next_scan = now + msecs_to_jiffies(p->numa_scan_period);
-	if (!try_cmpxchg(&mm->numa_next_scan, &migrate, next_scan))
-		return;
-
-	/*
-	 * Delay this task enough that another task of this mm will likely win
-	 * the next time around.
-	 */
-	p->node_stamp += 2 * TICK_NSEC;
-
-	pages = sysctl_numa_balancing_scan_size;
-	pages <<= 20 - PAGE_SHIFT; /* MB in pages */
-	virtpages = pages * 8;	   /* Scan up to this much virtual space */
-	if (!pages)
-		return;
-
-
-	if (!mmap_read_trylock(mm))
-		return;
-
-	/*
-	 * VMAs are skipped if the current PID has not trapped a fault within
-	 * the VMA recently. Allow scanning to be forced if there is no
-	 * suitable VMA remaining.
-	 */
-	vma_pids_skipped = false;
-
-retry_pids:
-	start = mm->numa_scan_offset;
-	vma_iter_init(&vmi, mm, start);
-	vma = vma_next(&vmi);
-	if (!vma) {
-		reset_ptenuma_scan(p);
-		start = 0;
-		vma_iter_set(&vmi, start);
-		vma = vma_next(&vmi);
-	}
-
-	do {
-		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
-			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
-			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
-			continue;
-		}
-
-		/*
-		 * Shared library pages mapped by multiple processes are not
-		 * migrated as it is expected they are cache replicated. Avoid
-		 * hinting faults in read-only file-backed mappings or the vDSO
-		 * as migrating the pages will be of marginal benefit.
-		 */
-		if (!vma->vm_mm ||
-		    (vma->vm_file && (vma->vm_flags & (VM_READ|VM_WRITE)) == (VM_READ))) {
-			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SHARED_RO);
-			continue;
-		}
-
-		/*
-		 * Skip inaccessible VMAs to avoid any confusion between
-		 * PROT_NONE and NUMA hinting PTEs
-		 */
-		if (!vma_is_accessible(vma)) {
-			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_INACCESSIBLE);
-			continue;
-		}
-
-		/* Initialise new per-VMA NUMAB state. */
-		if (!vma->numab_state) {
-			vma->numab_state = kzalloc(sizeof(struct vma_numab_state),
-				GFP_KERNEL);
-			if (!vma->numab_state)
-				continue;
-
-			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
-
-			vma->numab_state->next_scan = now +
-				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
-
-			/* Reset happens after 4 times scan delay of scan start */
-			vma->numab_state->pids_active_reset =  vma->numab_state->next_scan +
-				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
-
-			/*
-			 * Ensure prev_scan_seq does not match numa_scan_seq,
-			 * to prevent VMAs being skipped prematurely on the
-			 * first scan:
-			 */
-			 vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;
-		}
-
-		/*
-		 * Scanning the VMAs of short lived tasks add more overhead. So
-		 * delay the scan for new VMAs.
-		 */
-		if (mm->numa_scan_seq && time_before(jiffies,
-						vma->numab_state->next_scan)) {
-			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SCAN_DELAY);
-			continue;
-		}
-
-		/* RESET access PIDs regularly for old VMAs. */
-		if (mm->numa_scan_seq &&
-				time_after(jiffies, vma->numab_state->pids_active_reset)) {
-			vma->numab_state->pids_active_reset = vma->numab_state->pids_active_reset +
-				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
-			vma->numab_state->pids_active[0] = READ_ONCE(vma->numab_state->pids_active[1]);
-			vma->numab_state->pids_active[1] = 0;
-		}
-
-		/* Do not rescan VMAs twice within the same sequence. */
-		if (vma->numab_state->prev_scan_seq == mm->numa_scan_seq) {
-			mm->numa_scan_offset = vma->vm_end;
-			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SEQ_COMPLETED);
-			continue;
-		}
-
-		/*
-		 * Do not scan the VMA if task has not accessed it, unless no other
-		 * VMA candidate exists.
-		 */
-		if (!vma_pids_forced && !vma_is_accessed(mm, vma)) {
-			vma_pids_skipped = true;
-			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
-			continue;
-		}
-
-		do {
-			start = max(start, vma->vm_start);
-			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
-			end = min(end, vma->vm_end);
-			nr_pte_updates = change_prot_numa(vma, start, end);
-
-			/*
-			 * Try to scan sysctl_numa_balancing_size worth of
-			 * hpages that have at least one present PTE that
-			 * is not already PTE-numa. If the VMA contains
-			 * areas that are unused or already full of prot_numa
-			 * PTEs, scan up to virtpages, to skip through those
-			 * areas faster.
-			 */
-			if (nr_pte_updates)
-				pages -= (end - start) >> PAGE_SHIFT;
-			virtpages -= (end - start) >> PAGE_SHIFT;
-
-			start = end;
-			if (pages <= 0 || virtpages <= 0)
-				goto out;
-
-			cond_resched();
-		} while (end != vma->vm_end);
-
-		/* VMA scan is complete, do not scan until next sequence. */
-		vma->numab_state->prev_scan_seq = mm->numa_scan_seq;
-
-		/*
-		 * Only force scan within one VMA at a time, to limit the
-		 * cost of scanning a potentially uninteresting VMA.
-		 */
-		if (vma_pids_forced)
-			break;
-	} for_each_vma(vmi, vma);
-
-	/*
-	 * If no VMAs are remaining and VMAs were skipped due to the PID
-	 * not accessing the VMA previously, then force a scan to ensure
-	 * forward progress:
-	 */
-	if (!vma && !vma_pids_forced && vma_pids_skipped) {
-		vma_pids_forced = true;
-		goto retry_pids;
-	}
-
-out:
-	/*
-	 * It is possible to reach the end of the VMA list but the last few
-	 * VMAs are not guaranteed to the vma_migratable. If they are not, we
-	 * would find the !migratable VMA on the next scan but not reset the
-	 * scanner to the start so check it now.
-	 */
-	if (vma)
-		mm->numa_scan_offset = start;
-	else
-		reset_ptenuma_scan(p);
-	mmap_read_unlock(mm);
-
-	/*
-	 * Make sure tasks use at least 32x as much time to run other code
-	 * than they used here, to limit NUMA PTE scanning overhead to 3% max.
-	 * Usually update_task_scan_period slows down scanning enough; on an
-	 * overloaded system we need to limit overhead on a per task basis.
-	 */
-	if (unlikely(p->se.sum_exec_runtime != runtime)) {
-		u64 diff = p->se.sum_exec_runtime - runtime;
-		p->node_stamp += 32 * diff;
-	}
-}
-
-void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
-{
-	int mm_users = 0;
-	struct mm_struct *mm = p->mm;
-
-	if (mm) {
-		mm_users = atomic_read(&mm->mm_users);
-		if (mm_users == 1) {
-			mm->numa_next_scan = jiffies + msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
-			mm->numa_scan_seq = 0;
-		}
-	}
-	p->node_stamp			= 0;
-	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
-	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
-	p->numa_migrate_retry		= 0;
-	/* Protect against double add, see task_tick_numa and task_numa_work */
-	p->numa_work.next		= &p->numa_work;
-	p->numa_faults			= NULL;
-	p->numa_pages_migrated		= 0;
-	p->total_numa_faults		= 0;
-	RCU_INIT_POINTER(p->numa_group, NULL);
-	p->last_task_numa_placement	= 0;
-	p->last_sum_exec_runtime	= 0;
-
-	init_task_work(&p->numa_work, task_numa_work);
-
-	/* New address space, reset the preferred nid */
-	if (!(clone_flags & CLONE_VM)) {
-		p->numa_preferred_nid = NUMA_NO_NODE;
-		return;
-	}
-
-	/*
-	 * New thread, keep existing numa_preferred_nid which should be copied
-	 * already by arch_dup_task_struct but stagger when scans start.
-	 */
-	if (mm) {
-		unsigned int delay;
-
-		delay = min_t(unsigned int, task_scan_max(current),
-			current->numa_scan_period * mm_users * NSEC_PER_MSEC);
-		delay += 2 * TICK_NSEC;
-		p->node_stamp = delay;
-	}
-}
-
-/*
- * Drive the periodic memory faults..
- */
-static void task_tick_numa(struct rq *rq, struct task_struct *curr)
-{
-	struct callback_head *work = &curr->numa_work;
-	u64 period, now;
-
-	/*
-	 * We don't care about NUMA placement if we don't have memory.
-	 */
-	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
-		return;
-
-	/*
-	 * Using runtime rather than walltime has the dual advantage that
-	 * we (mostly) drive the selection from busy threads and that the
-	 * task needs to have done some actual work before we bother with
-	 * NUMA placement.
-	 */
-	now = curr->se.sum_exec_runtime;
-	period = (u64)curr->numa_scan_period * NSEC_PER_MSEC;
-
-	if (now > curr->node_stamp + period) {
-		if (!curr->node_stamp)
-			curr->numa_scan_period = task_scan_start(curr);
-		curr->node_stamp += period;
-
-		if (!time_before(jiffies, curr->mm->numa_next_scan))
-			task_work_add(curr, work, TWA_RESUME);
-	}
-}
-
-static void update_scan_period(struct task_struct *p, int new_cpu)
-{
-	int src_nid = cpu_to_node(task_cpu(p));
-	int dst_nid = cpu_to_node(new_cpu);
-
-	if (!static_branch_likely(&sched_numa_balancing))
-		return;
-
-	if (!p->mm || !p->numa_faults || (p->flags & PF_EXITING))
-		return;
-
-	if (src_nid == dst_nid)
-		return;
-
-	/*
-	 * Allow resets if faults have been trapped before one scan
-	 * has completed. This is most likely due to a new task that
-	 * is pulled cross-node due to wakeups or load balancing.
-	 */
-	if (p->numa_scan_seq) {
-		/*
-		 * Avoid scan adjustments if moving to the preferred
-		 * node or if the task was not previously running on
-		 * the preferred node.
-		 */
-		if (dst_nid == p->numa_preferred_nid ||
-		    (p->numa_preferred_nid != NUMA_NO_NODE &&
-			src_nid != p->numa_preferred_nid))
-			return;
-	}
-
-	p->numa_scan_period = task_scan_start(p);
-}
-
-#else
-static void task_tick_numa(struct rq *rq, struct task_struct *curr)
-{
-}
-
-static inline void account_numa_enqueue(struct rq *rq, struct task_struct *p)
-{
-}
-
-static inline void account_numa_dequeue(struct rq *rq, struct task_struct *p)
-{
-}
-
-static inline void update_scan_period(struct task_struct *p, int new_cpu)
-{
-}
-
-#endif /* CONFIG_NUMA_BALANCING */
-
 static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
@@ -5865,17 +3600,6 @@ static inline void set_idle_cores(int cpu, int val)
 		WRITE_ONCE(sds->has_idle_cores, val);
 }
 
-static inline bool test_idle_cores(int cpu)
-{
-	struct sched_domain_shared *sds;
-
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds)
-		return READ_ONCE(sds->has_idle_cores);
-
-	return false;
-}
-
 /*
  * Scans the local SMT mask to see if the entire core is idle, and records this
  * information in sd_llc_shared->has_idle_cores.
@@ -5967,11 +3691,6 @@ static inline void set_idle_cores(int cpu, int val)
 {
 }
 
-static inline bool test_idle_cores(int cpu)
-{
-	return false;
-}
-
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	return __select_idle_cpu(core, p);
@@ -7982,30 +5701,6 @@ void print_cfs_stats(struct seq_file *m, int cpu)
 		print_cfs_rq(m, cpu, cfs_rq);
 	rcu_read_unlock();
 }
-
-#ifdef CONFIG_NUMA_BALANCING
-void show_numa_stats(struct task_struct *p, struct seq_file *m)
-{
-	int node;
-	unsigned long tsf = 0, tpf = 0, gsf = 0, gpf = 0;
-	struct numa_group *ng;
-
-	rcu_read_lock();
-	ng = rcu_dereference(p->numa_group);
-	for_each_online_node(node) {
-		if (p->numa_faults) {
-			tsf = p->numa_faults[task_faults_idx(NUMA_MEM, node, 0)];
-			tpf = p->numa_faults[task_faults_idx(NUMA_MEM, node, 1)];
-		}
-		if (ng) {
-			gsf = ng->faults[task_faults_idx(NUMA_MEM, node, 0)],
-			gpf = ng->faults[task_faults_idx(NUMA_MEM, node, 1)];
-		}
-		print_numa_stats(m, node, tsf, tpf, gsf, gpf);
-	}
-	rcu_read_unlock();
-}
-#endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_SCHED_DEBUG */
 
 __init void init_sched_fair_class(void)
diff --git a/kernel/sched/numa_balancing.c b/kernel/sched/numa_balancing.c
new file mode 100644
index 000000000000..2649ba6ed349
--- /dev/null
+++ b/kernel/sched/numa_balancing.c
@@ -0,0 +1,2277 @@
+#include <linux/sched.h>
+#include <linux/memory-tiers.h>
+#include <linux/mempolicy.h>
+#include <linux/task_work.h>
+
+#include "sched.h"
+#include "pelt.h"
+
+#ifdef CONFIG_SMP
+bool is_core_idle(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	int sibling;
+
+	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
+		if (cpu == sibling)
+			continue;
+
+		if (!idle_cpu(sibling))
+			return false;
+	}
+#endif
+
+	return true;
+}
+#endif
+
+#ifdef CONFIG_NUMA
+#define NUMA_IMBALANCE_MIN 2
+
+long adjust_numa_imbalance(int imbalance, int dst_running, int imb_numa_nr)
+{
+	/*
+	 * Allow a NUMA imbalance if busy CPUs is less than the maximum
+	 * threshold. Above this threshold, individual tasks may be contending
+	 * for both memory bandwidth and any shared HT resources.  This is an
+	 * approximation as the number of running tasks may not be related to
+	 * the number of busy CPUs due to sched_setaffinity.
+	 */
+	if (dst_running > imb_numa_nr)
+		return imbalance;
+
+	/*
+	 * Allow a small imbalance based on a simple pair of communicating
+	 * tasks that remain local when the destination is lightly loaded.
+	 */
+	if (imbalance <= NUMA_IMBALANCE_MIN)
+		return 0;
+
+	return imbalance;
+}
+#endif /* CONFIG_NUMA */
+
+#ifdef CONFIG_NUMA_BALANCING
+/*
+ * Approximate time to scan a full NUMA task in ms. The task scan period is
+ * calculated based on the tasks virtual memory size and
+ * numa_balancing_scan_size.
+ */
+unsigned int sysctl_numa_balancing_scan_period_min = 1000;
+unsigned int sysctl_numa_balancing_scan_period_max = 60000;
+
+/* Portion of address space to scan in MB */
+unsigned int sysctl_numa_balancing_scan_size = 256;
+
+/* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
+unsigned int sysctl_numa_balancing_scan_delay = 1000;
+
+/* The page with hint page fault latency < threshold in ms is considered hot */
+unsigned int sysctl_numa_balancing_hot_threshold = MSEC_PER_SEC;
+
+struct numa_group {
+	refcount_t refcount;
+
+	spinlock_t lock; /* nr_tasks, tasks */
+	int nr_tasks;
+	pid_t gid;
+	int active_nodes;
+
+	struct rcu_head rcu;
+	unsigned long total_faults;
+	unsigned long max_faults_cpu;
+	/*
+	 * faults[] array is split into two regions: faults_mem and faults_cpu.
+	 *
+	 * Faults_cpu is used to decide whether memory should move
+	 * towards the CPU. As a consequence, these stats are weighted
+	 * more by CPU use than by memory faults.
+	 */
+	unsigned long faults[];
+};
+
+/*
+ * For functions that can be called in multiple contexts that permit reading
+ * ->numa_group (see struct task_struct for locking rules).
+ */
+static struct numa_group *deref_task_numa_group(struct task_struct *p)
+{
+	return rcu_dereference_check(p->numa_group, p == current ||
+		(lockdep_is_held(__rq_lockp(task_rq(p))) && !READ_ONCE(p->on_cpu)));
+}
+
+static struct numa_group *deref_curr_numa_group(struct task_struct *p)
+{
+	return rcu_dereference_protected(p->numa_group, p == current);
+}
+
+static inline unsigned long group_faults_priv(struct numa_group *ng);
+static inline unsigned long group_faults_shared(struct numa_group *ng);
+
+static unsigned int task_nr_scan_windows(struct task_struct *p)
+{
+	unsigned long rss = 0;
+	unsigned long nr_scan_pages;
+
+	/*
+	 * Calculations based on RSS as non-present and empty pages are skipped
+	 * by the PTE scanner and NUMA hinting faults should be trapped based
+	 * on resident pages
+	 */
+	nr_scan_pages = sysctl_numa_balancing_scan_size << (20 - PAGE_SHIFT);
+	rss = get_mm_rss(p->mm);
+	if (!rss)
+		rss = nr_scan_pages;
+
+	rss = round_up(rss, nr_scan_pages);
+	return rss / nr_scan_pages;
+}
+
+/* For sanity's sake, never scan more PTEs than MAX_SCAN_WINDOW MB/sec. */
+#define MAX_SCAN_WINDOW 2560
+
+static unsigned int task_scan_min(struct task_struct *p)
+{
+	unsigned int scan_size = READ_ONCE(sysctl_numa_balancing_scan_size);
+	unsigned int scan, floor;
+	unsigned int windows = 1;
+
+	if (scan_size < MAX_SCAN_WINDOW)
+		windows = MAX_SCAN_WINDOW / scan_size;
+	floor = 1000 / windows;
+
+	scan = sysctl_numa_balancing_scan_period_min / task_nr_scan_windows(p);
+	return max_t(unsigned int, floor, scan);
+}
+
+static unsigned int task_scan_start(struct task_struct *p)
+{
+	unsigned long smin = task_scan_min(p);
+	unsigned long period = smin;
+	struct numa_group *ng;
+
+	/* Scale the maximum scan period with the amount of shared memory. */
+	rcu_read_lock();
+	ng = rcu_dereference(p->numa_group);
+	if (ng) {
+		unsigned long shared = group_faults_shared(ng);
+		unsigned long private = group_faults_priv(ng);
+
+		period *= refcount_read(&ng->refcount);
+		period *= shared + 1;
+		period /= private + shared + 1;
+	}
+	rcu_read_unlock();
+
+	return max(smin, period);
+}
+
+static unsigned int task_scan_max(struct task_struct *p)
+{
+	unsigned long smin = task_scan_min(p);
+	unsigned long smax;
+	struct numa_group *ng;
+
+	/* Watch for min being lower than max due to floor calculations */
+	smax = sysctl_numa_balancing_scan_period_max / task_nr_scan_windows(p);
+
+	/* Scale the maximum scan period with the amount of shared memory. */
+	ng = deref_curr_numa_group(p);
+	if (ng) {
+		unsigned long shared = group_faults_shared(ng);
+		unsigned long private = group_faults_priv(ng);
+		unsigned long period = smax;
+
+		period *= refcount_read(&ng->refcount);
+		period *= shared + 1;
+		period /= private + shared + 1;
+
+		smax = max(smax, period);
+	}
+
+	return max(smin, smax);
+}
+
+void account_numa_enqueue(struct rq *rq, struct task_struct *p)
+{
+	rq->nr_numa_running += (p->numa_preferred_nid != NUMA_NO_NODE);
+	rq->nr_preferred_running += (p->numa_preferred_nid == task_node(p));
+}
+
+void account_numa_dequeue(struct rq *rq, struct task_struct *p)
+{
+	rq->nr_numa_running -= (p->numa_preferred_nid != NUMA_NO_NODE);
+	rq->nr_preferred_running -= (p->numa_preferred_nid == task_node(p));
+}
+
+/* Shared or private faults. */
+#define NR_NUMA_HINT_FAULT_TYPES 2
+
+/* Memory and CPU locality */
+#define NR_NUMA_HINT_FAULT_STATS (NR_NUMA_HINT_FAULT_TYPES * 2)
+
+/* Averaged statistics, and temporary buffers. */
+#define NR_NUMA_HINT_FAULT_BUCKETS (NR_NUMA_HINT_FAULT_STATS * 2)
+
+pid_t task_numa_group_id(struct task_struct *p)
+{
+	struct numa_group *ng;
+	pid_t gid = 0;
+
+	rcu_read_lock();
+	ng = rcu_dereference(p->numa_group);
+	if (ng)
+		gid = ng->gid;
+	rcu_read_unlock();
+
+	return gid;
+}
+
+/*
+ * The averaged statistics, shared & private, memory & CPU,
+ * occupy the first half of the array. The second half of the
+ * array is for current counters, which are averaged into the
+ * first set by task_numa_placement.
+ */
+static inline int task_faults_idx(enum numa_faults_stats s, int nid, int priv)
+{
+	return NR_NUMA_HINT_FAULT_TYPES * (s * nr_node_ids + nid) + priv;
+}
+
+static inline unsigned long task_faults(struct task_struct *p, int nid)
+{
+	if (!p->numa_faults)
+		return 0;
+
+	return p->numa_faults[task_faults_idx(NUMA_MEM, nid, 0)] +
+		p->numa_faults[task_faults_idx(NUMA_MEM, nid, 1)];
+}
+
+static inline unsigned long group_faults(struct task_struct *p, int nid)
+{
+	struct numa_group *ng = deref_task_numa_group(p);
+
+	if (!ng)
+		return 0;
+
+	return ng->faults[task_faults_idx(NUMA_MEM, nid, 0)] +
+		ng->faults[task_faults_idx(NUMA_MEM, nid, 1)];
+}
+
+static inline unsigned long group_faults_cpu(struct numa_group *group, int nid)
+{
+	return group->faults[task_faults_idx(NUMA_CPU, nid, 0)] +
+		group->faults[task_faults_idx(NUMA_CPU, nid, 1)];
+}
+
+static inline unsigned long group_faults_priv(struct numa_group *ng)
+{
+	unsigned long faults = 0;
+	int node;
+
+	for_each_online_node(node) {
+		faults += ng->faults[task_faults_idx(NUMA_MEM, node, 1)];
+	}
+
+	return faults;
+}
+
+static inline unsigned long group_faults_shared(struct numa_group *ng)
+{
+	unsigned long faults = 0;
+	int node;
+
+	for_each_online_node(node) {
+		faults += ng->faults[task_faults_idx(NUMA_MEM, node, 0)];
+	}
+
+	return faults;
+}
+
+/*
+ * A node triggering more than 1/3 as many NUMA faults as the maximum is
+ * considered part of a numa group's pseudo-interleaving set. Migrations
+ * between these nodes are slowed down, to allow things to settle down.
+ */
+#define ACTIVE_NODE_FRACTION 3
+
+static bool numa_is_active_node(int nid, struct numa_group *ng)
+{
+	return group_faults_cpu(ng, nid) * ACTIVE_NODE_FRACTION > ng->max_faults_cpu;
+}
+
+/* Handle placement on systems where not all nodes are directly connected. */
+static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
+					int lim_dist, bool task)
+{
+	unsigned long score = 0;
+	int node, max_dist;
+
+	/*
+	 * All nodes are directly connected, and the same distance
+	 * from each other. No need for fancy placement algorithms.
+	 */
+	if (sched_numa_topology_type == NUMA_DIRECT)
+		return 0;
+
+	/* sched_max_numa_distance may be changed in parallel. */
+	max_dist = READ_ONCE(sched_max_numa_distance);
+	/*
+	 * This code is called for each node, introducing N^2 complexity,
+	 * which should be OK given the number of nodes rarely exceeds 8.
+	 */
+	for_each_online_node(node) {
+		unsigned long faults;
+		int dist = node_distance(nid, node);
+
+		/*
+		 * The furthest away nodes in the system are not interesting
+		 * for placement; nid was already counted.
+		 */
+		if (dist >= max_dist || node == nid)
+			continue;
+
+		/*
+		 * On systems with a backplane NUMA topology, compare groups
+		 * of nodes, and move tasks towards the group with the most
+		 * memory accesses. When comparing two nodes at distance
+		 * "hoplimit", only nodes closer by than "hoplimit" are part
+		 * of each group. Skip other nodes.
+		 */
+		if (sched_numa_topology_type == NUMA_BACKPLANE && dist >= lim_dist)
+			continue;
+
+		/* Add up the faults from nearby nodes. */
+		if (task)
+			faults = task_faults(p, node);
+		else
+			faults = group_faults(p, node);
+
+		/*
+		 * On systems with a glueless mesh NUMA topology, there are
+		 * no fixed "groups of nodes". Instead, nodes that are not
+		 * directly connected bounce traffic through intermediate
+		 * nodes; a numa_group can occupy any set of nodes.
+		 * The further away a node is, the less the faults count.
+		 * This seems to result in good task placement.
+		 */
+		if (sched_numa_topology_type == NUMA_GLUELESS_MESH) {
+			faults *= (max_dist - dist);
+			faults /= (max_dist - LOCAL_DISTANCE);
+		}
+
+		score += faults;
+	}
+
+	return score;
+}
+
+/*
+ * These return the fraction of accesses done by a particular task, or
+ * task group, on a particular numa node.  The group weight is given a
+ * larger multiplier, in order to group tasks together that are almost
+ * evenly spread out between numa nodes.
+ */
+unsigned long task_weight(struct task_struct *p, int nid, int dist)
+{
+	unsigned long faults, total_faults;
+
+	if (!p->numa_faults)
+		return 0;
+
+	total_faults = p->total_numa_faults;
+
+	if (!total_faults)
+		return 0;
+
+	faults = task_faults(p, nid);
+	faults += score_nearby_nodes(p, nid, dist, true);
+
+	return 1000 * faults / total_faults;
+}
+
+unsigned long group_weight(struct task_struct *p, int nid, int dist)
+{
+	struct numa_group *ng = deref_task_numa_group(p);
+	unsigned long faults, total_faults;
+
+	if (!ng)
+		return 0;
+
+	total_faults = ng->total_faults;
+
+	if (!total_faults)
+		return 0;
+
+	faults = group_faults(p, nid);
+	faults += score_nearby_nodes(p, nid, dist, false);
+
+	return 1000 * faults / total_faults;
+}
+
+/*
+ * If memory tiering mode is enabled, cpupid of slow memory page is
+ * used to record scan time instead of CPU and PID.  When tiering mode
+ * is disabled at run time, the scan time (in cpupid) will be
+ * interpreted as CPU and PID.  So CPU needs to be checked to avoid to
+ * access out of array bound.
+ */
+static inline bool cpupid_valid(int cpupid)
+{
+	return cpupid_to_cpu(cpupid) < nr_cpu_ids;
+}
+
+/*
+ * For memory tiering mode, if there are enough free pages (more than
+ * enough watermark defined here) in fast memory node, to take full
+ * advantage of fast memory capacity, all recently accessed slow
+ * memory pages will be migrated to fast memory node without
+ * considering hot threshold.
+ */
+static bool pgdat_free_space_enough(struct pglist_data *pgdat)
+{
+	int z;
+	unsigned long enough_wmark;
+
+	enough_wmark = max(1UL * 1024 * 1024 * 1024 >> PAGE_SHIFT,
+			   pgdat->node_present_pages >> 4);
+	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
+		struct zone *zone = pgdat->node_zones + z;
+
+		if (!populated_zone(zone))
+			continue;
+
+		if (zone_watermark_ok(zone, 0,
+				      wmark_pages(zone, WMARK_PROMO) + enough_wmark,
+				      ZONE_MOVABLE, 0))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * For memory tiering mode, when page tables are scanned, the scan
+ * time will be recorded in struct page in addition to make page
+ * PROT_NONE for slow memory page.  So when the page is accessed, in
+ * hint page fault handler, the hint page fault latency is calculated
+ * via,
+ *
+ *	hint page fault latency = hint page fault time - scan time
+ *
+ * The smaller the hint page fault latency, the higher the possibility
+ * for the page to be hot.
+ */
+static int numa_hint_fault_latency(struct folio *folio)
+{
+	int last_time, time;
+
+	time = jiffies_to_msecs(jiffies);
+	last_time = folio_xchg_access_time(folio, time);
+
+	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
+}
+
+/*
+ * For memory tiering mode, too high promotion/demotion throughput may
+ * hurt application latency.  So we provide a mechanism to rate limit
+ * the number of pages that are tried to be promoted.
+ */
+static bool numa_promotion_rate_limit(struct pglist_data *pgdat,
+				      unsigned long rate_limit, int nr)
+{
+	unsigned long nr_cand;
+	unsigned int now, start;
+
+	now = jiffies_to_msecs(jiffies);
+	mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE, nr);
+	nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+	start = pgdat->nbp_rl_start;
+	if (now - start > MSEC_PER_SEC &&
+	    cmpxchg(&pgdat->nbp_rl_start, start, now) == start)
+		pgdat->nbp_rl_nr_cand = nr_cand;
+	if (nr_cand - pgdat->nbp_rl_nr_cand >= rate_limit)
+		return true;
+	return false;
+}
+
+#define NUMA_MIGRATION_ADJUST_STEPS	16
+
+static void numa_promotion_adjust_threshold(struct pglist_data *pgdat,
+					    unsigned long rate_limit,
+					    unsigned int ref_th)
+{
+	unsigned int now, start, th_period, unit_th, th;
+	unsigned long nr_cand, ref_cand, diff_cand;
+
+	now = jiffies_to_msecs(jiffies);
+	th_period = sysctl_numa_balancing_scan_period_max;
+	start = pgdat->nbp_th_start;
+	if (now - start > th_period &&
+	    cmpxchg(&pgdat->nbp_th_start, start, now) == start) {
+		ref_cand = rate_limit *
+			sysctl_numa_balancing_scan_period_max / MSEC_PER_SEC;
+		nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+		diff_cand = nr_cand - pgdat->nbp_th_nr_cand;
+		unit_th = ref_th * 2 / NUMA_MIGRATION_ADJUST_STEPS;
+		th = pgdat->nbp_threshold ? : ref_th;
+		if (diff_cand > ref_cand * 11 / 10)
+			th = max(th - unit_th, unit_th);
+		else if (diff_cand < ref_cand * 9 / 10)
+			th = min(th + unit_th, ref_th * 2);
+		pgdat->nbp_th_nr_cand = nr_cand;
+		pgdat->nbp_threshold = th;
+	}
+}
+
+bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
+				int src_nid, int dst_cpu)
+{
+	struct numa_group *ng = deref_curr_numa_group(p);
+	int dst_nid = cpu_to_node(dst_cpu);
+	int last_cpupid, this_cpupid;
+
+	/*
+	 * Cannot migrate to memoryless nodes.
+	 */
+	if (!node_state(dst_nid, N_MEMORY))
+		return false;
+
+	/*
+	 * The pages in slow memory node should be migrated according
+	 * to hot/cold instead of private/shared.
+	 */
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+	    !node_is_toptier(src_nid)) {
+		struct pglist_data *pgdat;
+		unsigned long rate_limit;
+		unsigned int latency, th, def_th;
+
+		pgdat = NODE_DATA(dst_nid);
+		if (pgdat_free_space_enough(pgdat)) {
+			/* workload changed, reset hot threshold */
+			pgdat->nbp_threshold = 0;
+			return true;
+		}
+
+		def_th = sysctl_numa_balancing_hot_threshold;
+		rate_limit = sysctl_numa_balancing_promote_rate_limit << \
+			(20 - PAGE_SHIFT);
+		numa_promotion_adjust_threshold(pgdat, rate_limit, def_th);
+
+		th = pgdat->nbp_threshold ? : def_th;
+		latency = numa_hint_fault_latency(folio);
+		if (latency >= th)
+			return false;
+
+		return !numa_promotion_rate_limit(pgdat, rate_limit,
+						  folio_nr_pages(folio));
+	}
+
+	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
+	last_cpupid = folio_xchg_last_cpupid(folio, this_cpupid);
+
+	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+	    !node_is_toptier(src_nid) && !cpupid_valid(last_cpupid))
+		return false;
+
+	/*
+	 * Allow first faults or private faults to migrate immediately early in
+	 * the lifetime of a task. The magic number 4 is based on waiting for
+	 * two full passes of the "multi-stage node selection" test that is
+	 * executed below.
+	 */
+	if ((p->numa_preferred_nid == NUMA_NO_NODE || p->numa_scan_seq <= 4) &&
+	    (cpupid_pid_unset(last_cpupid) || cpupid_match_pid(p, last_cpupid)))
+		return true;
+
+	/*
+	 * Multi-stage node selection is used in conjunction with a periodic
+	 * migration fault to build a temporal task<->page relation. By using
+	 * a two-stage filter we remove short/unlikely relations.
+	 *
+	 * Using P(p) ~ n_p / n_t as per frequentist probability, we can equate
+	 * a task's usage of a particular page (n_p) per total usage of this
+	 * page (n_t) (in a given time-span) to a probability.
+	 *
+	 * Our periodic faults will sample this probability and getting the
+	 * same result twice in a row, given these samples are fully
+	 * independent, is then given by P(n)^2, provided our sample period
+	 * is sufficiently short compared to the usage pattern.
+	 *
+	 * This quadric squishes small probabilities, making it less likely we
+	 * act on an unlikely task<->page relation.
+	 */
+	if (!cpupid_pid_unset(last_cpupid) &&
+				cpupid_to_nid(last_cpupid) != dst_nid)
+		return false;
+
+	/* Always allow migrate on private faults */
+	if (cpupid_match_pid(p, last_cpupid))
+		return true;
+
+	/* A shared fault, but p->numa_group has not been set up yet. */
+	if (!ng)
+		return true;
+
+	/*
+	 * Destination node is much more heavily used than the source
+	 * node? Allow migration.
+	 */
+	if (group_faults_cpu(ng, dst_nid) > group_faults_cpu(ng, src_nid) *
+					ACTIVE_NODE_FRACTION)
+		return true;
+
+	/*
+	 * Distribute memory according to CPU & memory use on each node,
+	 * with 3/4 hysteresis to avoid unnecessary memory migrations:
+	 *
+	 * faults_cpu(dst)   3   faults_cpu(src)
+	 * --------------- * - > ---------------
+	 * faults_mem(dst)   4   faults_mem(src)
+	 */
+	return group_faults_cpu(ng, dst_nid) * group_faults(p, src_nid) * 3 >
+	       group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
+}
+
+/*
+ * 'numa_type' describes the node at the moment of load balancing.
+ */
+enum numa_type {
+	/* The node has spare capacity that can be used to run more tasks.  */
+	node_has_spare = 0,
+	/*
+	 * The node is fully used and the tasks don't compete for more CPU
+	 * cycles. Nevertheless, some tasks might wait before running.
+	 */
+	node_fully_busy,
+	/*
+	 * The node is overloaded and can't provide expected CPU cycles to all
+	 * tasks.
+	 */
+	node_overloaded
+};
+
+/* Cached statistics for all CPUs within a node */
+struct numa_stats {
+	unsigned long load;
+	unsigned long runnable;
+	unsigned long util;
+	/* Total compute capacity of CPUs on a node */
+	unsigned long compute_capacity;
+	unsigned int nr_running;
+	unsigned int weight;
+	enum numa_type node_type;
+	int idle_cpu;
+};
+
+struct task_numa_env {
+	struct task_struct *p;
+
+	int src_cpu, src_nid;
+	int dst_cpu, dst_nid;
+	int imb_numa_nr;
+
+	struct numa_stats src_stats, dst_stats;
+
+	int imbalance_pct;
+	int dist;
+
+	struct task_struct *best_task;
+	long best_imp;
+	int best_cpu;
+};
+
+static unsigned long cpu_load(struct rq *rq);
+
+static inline enum
+numa_type numa_classify(unsigned int imbalance_pct,
+			 struct numa_stats *ns)
+{
+	if ((ns->nr_running > ns->weight) &&
+	    (((ns->compute_capacity * 100) < (ns->util * imbalance_pct)) ||
+	     ((ns->compute_capacity * imbalance_pct) < (ns->runnable * 100))))
+		return node_overloaded;
+
+	if ((ns->nr_running < ns->weight) ||
+	    (((ns->compute_capacity * 100) > (ns->util * imbalance_pct)) &&
+	     ((ns->compute_capacity * imbalance_pct) > (ns->runnable * 100))))
+		return node_has_spare;
+
+	return node_fully_busy;
+}
+
+#ifdef CONFIG_SCHED_SMT
+static inline int numa_idle_core(int idle_core, int cpu)
+{
+	if (!static_branch_likely(&sched_smt_present) ||
+	    idle_core >= 0 || !test_idle_cores(cpu))
+		return idle_core;
+
+	/*
+	 * Prefer cores instead of packing HT siblings
+	 * and triggering future load balancing.
+	 */
+	if (is_core_idle(cpu))
+		idle_core = cpu;
+
+	return idle_core;
+}
+#else
+static inline int numa_idle_core(int idle_core, int cpu)
+{
+	return idle_core;
+}
+#endif
+
+/*
+ * Gather all necessary information to make NUMA balancing placement
+ * decisions that are compatible with standard load balancer. This
+ * borrows code and logic from update_sg_lb_stats but sharing a
+ * common implementation is impractical.
+ */
+static void update_numa_stats(struct task_numa_env *env,
+			      struct numa_stats *ns, int nid,
+			      bool find_idle)
+{
+	int cpu, idle_core = -1;
+
+	memset(ns, 0, sizeof(*ns));
+	ns->idle_cpu = -1;
+
+	rcu_read_lock();
+	for_each_cpu(cpu, cpumask_of_node(nid)) {
+		struct rq *rq = cpu_rq(cpu);
+
+		ns->load += cpu_load(rq);
+		ns->runnable += cpu_runnable(rq);
+		ns->util += cpu_util_cfs(cpu);
+		ns->nr_running += rq->cfs.h_nr_running;
+		ns->compute_capacity += capacity_of(cpu);
+
+		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
+			if (READ_ONCE(rq->numa_migrate_on) ||
+			    !cpumask_test_cpu(cpu, env->p->cpus_ptr))
+				continue;
+
+			if (ns->idle_cpu == -1)
+				ns->idle_cpu = cpu;
+
+			idle_core = numa_idle_core(idle_core, cpu);
+		}
+	}
+	rcu_read_unlock();
+
+	ns->weight = cpumask_weight(cpumask_of_node(nid));
+
+	ns->node_type = numa_classify(env->imbalance_pct, ns);
+
+	if (idle_core >= 0)
+		ns->idle_cpu = idle_core;
+}
+
+static void task_numa_assign(struct task_numa_env *env,
+			     struct task_struct *p, long imp)
+{
+	struct rq *rq = cpu_rq(env->dst_cpu);
+
+	/* Check if run-queue part of active NUMA balance. */
+	if (env->best_cpu != env->dst_cpu && xchg(&rq->numa_migrate_on, 1)) {
+		int cpu;
+		int start = env->dst_cpu;
+
+		/* Find alternative idle CPU. */
+		for_each_cpu_wrap(cpu, cpumask_of_node(env->dst_nid), start + 1) {
+			if (cpu == env->best_cpu || !idle_cpu(cpu) ||
+			    !cpumask_test_cpu(cpu, env->p->cpus_ptr)) {
+				continue;
+			}
+
+			env->dst_cpu = cpu;
+			rq = cpu_rq(env->dst_cpu);
+			if (!xchg(&rq->numa_migrate_on, 1))
+				goto assign;
+		}
+
+		/* Failed to find an alternative idle CPU */
+		return;
+	}
+
+assign:
+	/*
+	 * Clear previous best_cpu/rq numa-migrate flag, since task now
+	 * found a better CPU to move/swap.
+	 */
+	if (env->best_cpu != -1 && env->best_cpu != env->dst_cpu) {
+		rq = cpu_rq(env->best_cpu);
+		WRITE_ONCE(rq->numa_migrate_on, 0);
+	}
+
+	if (env->best_task)
+		put_task_struct(env->best_task);
+	if (p)
+		get_task_struct(p);
+
+	env->best_task = p;
+	env->best_imp = imp;
+	env->best_cpu = env->dst_cpu;
+}
+
+static bool load_too_imbalanced(long src_load, long dst_load,
+				struct task_numa_env *env)
+{
+	long imb, old_imb;
+	long orig_src_load, orig_dst_load;
+	long src_capacity, dst_capacity;
+
+	/*
+	 * The load is corrected for the CPU capacity available on each node.
+	 *
+	 * src_load        dst_load
+	 * ------------ vs ---------
+	 * src_capacity    dst_capacity
+	 */
+	src_capacity = env->src_stats.compute_capacity;
+	dst_capacity = env->dst_stats.compute_capacity;
+
+	imb = abs(dst_load * src_capacity - src_load * dst_capacity);
+
+	orig_src_load = env->src_stats.load;
+	orig_dst_load = env->dst_stats.load;
+
+	old_imb = abs(orig_dst_load * src_capacity - orig_src_load * dst_capacity);
+
+	/* Would this change make things worse? */
+	return (imb > old_imb);
+}
+
+/*
+ * Maximum NUMA importance can be 1998 (2*999);
+ * SMALLIMP @ 30 would be close to 1998/64.
+ * Used to deter task migration.
+ */
+#define SMALLIMP	30
+
+/*
+ * This checks if the overall compute and NUMA accesses of the system would
+ * be improved if the source tasks was migrated to the target dst_cpu taking
+ * into account that it might be best if task running on the dst_cpu should
+ * be exchanged with the source task
+ */
+static bool task_numa_compare(struct task_numa_env *env,
+			      long taskimp, long groupimp, bool maymove)
+{
+	struct numa_group *cur_ng, *p_ng = deref_curr_numa_group(env->p);
+	struct rq *dst_rq = cpu_rq(env->dst_cpu);
+	long imp = p_ng ? groupimp : taskimp;
+	struct task_struct *cur;
+	long src_load, dst_load;
+	int dist = env->dist;
+	long moveimp = imp;
+	long load;
+	bool stopsearch = false;
+
+	if (READ_ONCE(dst_rq->numa_migrate_on))
+		return false;
+
+	rcu_read_lock();
+	cur = rcu_dereference(dst_rq->curr);
+	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
+		cur = NULL;
+
+	/*
+	 * Because we have preemption enabled we can get migrated around and
+	 * end try selecting ourselves (current == env->p) as a swap candidate.
+	 */
+	if (cur == env->p) {
+		stopsearch = true;
+		goto unlock;
+	}
+
+	if (!cur) {
+		if (maymove && moveimp >= env->best_imp)
+			goto assign;
+		else
+			goto unlock;
+	}
+
+	/* Skip this swap candidate if cannot move to the source cpu. */
+	if (!cpumask_test_cpu(env->src_cpu, cur->cpus_ptr))
+		goto unlock;
+
+	/*
+	 * Skip this swap candidate if it is not moving to its preferred
+	 * node and the best task is.
+	 */
+	if (env->best_task &&
+	    env->best_task->numa_preferred_nid == env->src_nid &&
+	    cur->numa_preferred_nid != env->src_nid) {
+		goto unlock;
+	}
+
+	/*
+	 * "imp" is the fault differential for the source task between the
+	 * source and destination node. Calculate the total differential for
+	 * the source task and potential destination task. The more negative
+	 * the value is, the more remote accesses that would be expected to
+	 * be incurred if the tasks were swapped.
+	 *
+	 * If dst and source tasks are in the same NUMA group, or not
+	 * in any group then look only at task weights.
+	 */
+	cur_ng = rcu_dereference(cur->numa_group);
+	if (cur_ng == p_ng) {
+		/*
+		 * Do not swap within a group or between tasks that have
+		 * no group if there is spare capacity. Swapping does
+		 * not address the load imbalance and helps one task at
+		 * the cost of punishing another.
+		 */
+		if (env->dst_stats.node_type == node_has_spare)
+			goto unlock;
+
+		imp = taskimp + task_weight(cur, env->src_nid, dist) -
+		      task_weight(cur, env->dst_nid, dist);
+		/*
+		 * Add some hysteresis to prevent swapping the
+		 * tasks within a group over tiny differences.
+		 */
+		if (cur_ng)
+			imp -= imp / 16;
+	} else {
+		/*
+		 * Compare the group weights. If a task is all by itself
+		 * (not part of a group), use the task weight instead.
+		 */
+		if (cur_ng && p_ng)
+			imp += group_weight(cur, env->src_nid, dist) -
+			       group_weight(cur, env->dst_nid, dist);
+		else
+			imp += task_weight(cur, env->src_nid, dist) -
+			       task_weight(cur, env->dst_nid, dist);
+	}
+
+	/* Discourage picking a task already on its preferred node */
+	if (cur->numa_preferred_nid == env->dst_nid)
+		imp -= imp / 16;
+
+	/*
+	 * Encourage picking a task that moves to its preferred node.
+	 * This potentially makes imp larger than it's maximum of
+	 * 1998 (see SMALLIMP and task_weight for why) but in this
+	 * case, it does not matter.
+	 */
+	if (cur->numa_preferred_nid == env->src_nid)
+		imp += imp / 8;
+
+	if (maymove && moveimp > imp && moveimp > env->best_imp) {
+		imp = moveimp;
+		cur = NULL;
+		goto assign;
+	}
+
+	/*
+	 * Prefer swapping with a task moving to its preferred node over a
+	 * task that is not.
+	 */
+	if (env->best_task && cur->numa_preferred_nid == env->src_nid &&
+	    env->best_task->numa_preferred_nid != env->src_nid) {
+		goto assign;
+	}
+
+	/*
+	 * If the NUMA importance is less than SMALLIMP,
+	 * task migration might only result in ping pong
+	 * of tasks and also hurt performance due to cache
+	 * misses.
+	 */
+	if (imp < SMALLIMP || imp <= env->best_imp + SMALLIMP / 2)
+		goto unlock;
+
+	/*
+	 * In the overloaded case, try and keep the load balanced.
+	 */
+	load = task_h_load(env->p) - task_h_load(cur);
+	if (!load)
+		goto assign;
+
+	dst_load = env->dst_stats.load + load;
+	src_load = env->src_stats.load - load;
+
+	if (load_too_imbalanced(src_load, dst_load, env))
+		goto unlock;
+
+assign:
+	/* Evaluate an idle CPU for a task numa move. */
+	if (!cur) {
+		int cpu = env->dst_stats.idle_cpu;
+
+		/* Nothing cached so current CPU went idle since the search. */
+		if (cpu < 0)
+			cpu = env->dst_cpu;
+
+		/*
+		 * If the CPU is no longer truly idle and the previous best CPU
+		 * is, keep using it.
+		 */
+		if (!idle_cpu(cpu) && env->best_cpu >= 0 &&
+		    idle_cpu(env->best_cpu)) {
+			cpu = env->best_cpu;
+		}
+
+		env->dst_cpu = cpu;
+	}
+
+	task_numa_assign(env, cur, imp);
+
+	/*
+	 * If a move to idle is allowed because there is capacity or load
+	 * balance improves then stop the search. While a better swap
+	 * candidate may exist, a search is not free.
+	 */
+	if (maymove && !cur && env->best_cpu >= 0 && idle_cpu(env->best_cpu))
+		stopsearch = true;
+
+	/*
+	 * If a swap candidate must be identified and the current best task
+	 * moves its preferred node then stop the search.
+	 */
+	if (!maymove && env->best_task &&
+	    env->best_task->numa_preferred_nid == env->src_nid) {
+		stopsearch = true;
+	}
+unlock:
+	rcu_read_unlock();
+
+	return stopsearch;
+}
+
+static void task_numa_find_cpu(struct task_numa_env *env,
+				long taskimp, long groupimp)
+{
+	bool maymove = false;
+	int cpu;
+
+	/*
+	 * If dst node has spare capacity, then check if there is an
+	 * imbalance that would be overruled by the load balancer.
+	 */
+	if (env->dst_stats.node_type == node_has_spare) {
+		unsigned int imbalance;
+		int src_running, dst_running;
+
+		/*
+		 * Would movement cause an imbalance? Note that if src has
+		 * more running tasks that the imbalance is ignored as the
+		 * move improves the imbalance from the perspective of the
+		 * CPU load balancer.
+		 * */
+		src_running = env->src_stats.nr_running - 1;
+		dst_running = env->dst_stats.nr_running + 1;
+		imbalance = max(0, dst_running - src_running);
+		imbalance = adjust_numa_imbalance(imbalance, dst_running,
+						  env->imb_numa_nr);
+
+		/* Use idle CPU if there is no imbalance */
+		if (!imbalance) {
+			maymove = true;
+			if (env->dst_stats.idle_cpu >= 0) {
+				env->dst_cpu = env->dst_stats.idle_cpu;
+				task_numa_assign(env, NULL, 0);
+				return;
+			}
+		}
+	} else {
+		long src_load, dst_load, load;
+		/*
+		 * If the improvement from just moving env->p direction is better
+		 * than swapping tasks around, check if a move is possible.
+		 */
+		load = task_h_load(env->p);
+		dst_load = env->dst_stats.load + load;
+		src_load = env->src_stats.load - load;
+		maymove = !load_too_imbalanced(src_load, dst_load, env);
+	}
+
+	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
+		/* Skip this CPU if the source task cannot migrate */
+		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
+			continue;
+
+		env->dst_cpu = cpu;
+		if (task_numa_compare(env, taskimp, groupimp, maymove))
+			break;
+	}
+}
+
+static int task_numa_migrate(struct task_struct *p)
+{
+	struct task_numa_env env = {
+		.p = p,
+
+		.src_cpu = task_cpu(p),
+		.src_nid = task_node(p),
+
+		.imbalance_pct = 112,
+
+		.best_task = NULL,
+		.best_imp = 0,
+		.best_cpu = -1,
+	};
+	unsigned long taskweight, groupweight;
+	struct sched_domain *sd;
+	long taskimp, groupimp;
+	struct numa_group *ng;
+	struct rq *best_rq;
+	int nid, ret, dist;
+
+	/*
+	 * Pick the lowest SD_NUMA domain, as that would have the smallest
+	 * imbalance and would be the first to start moving tasks about.
+	 *
+	 * And we want to avoid any moving of tasks about, as that would create
+	 * random movement of tasks -- counter the numa conditions we're trying
+	 * to satisfy here.
+	 */
+	rcu_read_lock();
+	sd = rcu_dereference(per_cpu(sd_numa, env.src_cpu));
+	if (sd) {
+		env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
+		env.imb_numa_nr = sd->imb_numa_nr;
+	}
+	rcu_read_unlock();
+
+	/*
+	 * Cpusets can break the scheduler domain tree into smaller
+	 * balance domains, some of which do not cross NUMA boundaries.
+	 * Tasks that are "trapped" in such domains cannot be migrated
+	 * elsewhere, so there is no point in (re)trying.
+	 */
+	if (unlikely(!sd)) {
+		sched_setnuma(p, task_node(p));
+		return -EINVAL;
+	}
+
+	env.dst_nid = p->numa_preferred_nid;
+	dist = env.dist = node_distance(env.src_nid, env.dst_nid);
+	taskweight = task_weight(p, env.src_nid, dist);
+	groupweight = group_weight(p, env.src_nid, dist);
+	update_numa_stats(&env, &env.src_stats, env.src_nid, false);
+	taskimp = task_weight(p, env.dst_nid, dist) - taskweight;
+	groupimp = group_weight(p, env.dst_nid, dist) - groupweight;
+	update_numa_stats(&env, &env.dst_stats, env.dst_nid, true);
+
+	/* Try to find a spot on the preferred nid. */
+	task_numa_find_cpu(&env, taskimp, groupimp);
+
+	/*
+	 * Look at other nodes in these cases:
+	 * - there is no space available on the preferred_nid
+	 * - the task is part of a numa_group that is interleaved across
+	 *   multiple NUMA nodes; in order to better consolidate the group,
+	 *   we need to check other locations.
+	 */
+	ng = deref_curr_numa_group(p);
+	if (env.best_cpu == -1 || (ng && ng->active_nodes > 1)) {
+		for_each_node_state(nid, N_CPU) {
+			if (nid == env.src_nid || nid == p->numa_preferred_nid)
+				continue;
+
+			dist = node_distance(env.src_nid, env.dst_nid);
+			if (sched_numa_topology_type == NUMA_BACKPLANE &&
+						dist != env.dist) {
+				taskweight = task_weight(p, env.src_nid, dist);
+				groupweight = group_weight(p, env.src_nid, dist);
+			}
+
+			/* Only consider nodes where both task and groups benefit */
+			taskimp = task_weight(p, nid, dist) - taskweight;
+			groupimp = group_weight(p, nid, dist) - groupweight;
+			if (taskimp < 0 && groupimp < 0)
+				continue;
+
+			env.dist = dist;
+			env.dst_nid = nid;
+			update_numa_stats(&env, &env.dst_stats, env.dst_nid, true);
+			task_numa_find_cpu(&env, taskimp, groupimp);
+		}
+	}
+
+	/*
+	 * If the task is part of a workload that spans multiple NUMA nodes,
+	 * and is migrating into one of the workload's active nodes, remember
+	 * this node as the task's preferred numa node, so the workload can
+	 * settle down.
+	 * A task that migrated to a second choice node will be better off
+	 * trying for a better one later. Do not set the preferred node here.
+	 */
+	if (ng) {
+		if (env.best_cpu == -1)
+			nid = env.src_nid;
+		else
+			nid = cpu_to_node(env.best_cpu);
+
+		if (nid != p->numa_preferred_nid)
+			sched_setnuma(p, nid);
+	}
+
+	/* No better CPU than the current one was found. */
+	if (env.best_cpu == -1) {
+		trace_sched_stick_numa(p, env.src_cpu, NULL, -1);
+		return -EAGAIN;
+	}
+
+	best_rq = cpu_rq(env.best_cpu);
+	if (env.best_task == NULL) {
+		ret = migrate_task_to(p, env.best_cpu);
+		WRITE_ONCE(best_rq->numa_migrate_on, 0);
+		if (ret != 0)
+			trace_sched_stick_numa(p, env.src_cpu, NULL, env.best_cpu);
+		return ret;
+	}
+
+	ret = migrate_swap(p, env.best_task, env.best_cpu, env.src_cpu);
+	WRITE_ONCE(best_rq->numa_migrate_on, 0);
+
+	if (ret != 0)
+		trace_sched_stick_numa(p, env.src_cpu, env.best_task, env.best_cpu);
+	put_task_struct(env.best_task);
+	return ret;
+}
+
+/* Attempt to migrate a task to a CPU on the preferred node. */
+static void numa_migrate_preferred(struct task_struct *p)
+{
+	unsigned long interval = HZ;
+
+	/* This task has no NUMA fault statistics yet */
+	if (unlikely(p->numa_preferred_nid == NUMA_NO_NODE || !p->numa_faults))
+		return;
+
+	/* Periodically retry migrating the task to the preferred node */
+	interval = min(interval, msecs_to_jiffies(p->numa_scan_period) / 16);
+	p->numa_migrate_retry = jiffies + interval;
+
+	/* Success if task is already running on preferred CPU */
+	if (task_node(p) == p->numa_preferred_nid)
+		return;
+
+	/* Otherwise, try migrate to a CPU on the preferred node */
+	task_numa_migrate(p);
+}
+
+/*
+ * Find out how many nodes the workload is actively running on. Do this by
+ * tracking the nodes from which NUMA hinting faults are triggered. This can
+ * be different from the set of nodes where the workload's memory is currently
+ * located.
+ */
+static void numa_group_count_active_nodes(struct numa_group *numa_group)
+{
+	unsigned long faults, max_faults = 0;
+	int nid, active_nodes = 0;
+
+	for_each_node_state(nid, N_CPU) {
+		faults = group_faults_cpu(numa_group, nid);
+		if (faults > max_faults)
+			max_faults = faults;
+	}
+
+	for_each_node_state(nid, N_CPU) {
+		faults = group_faults_cpu(numa_group, nid);
+		if (faults * ACTIVE_NODE_FRACTION > max_faults)
+			active_nodes++;
+	}
+
+	numa_group->max_faults_cpu = max_faults;
+	numa_group->active_nodes = active_nodes;
+}
+
+/*
+ * When adapting the scan rate, the period is divided into NUMA_PERIOD_SLOTS
+ * increments. The more local the fault statistics are, the higher the scan
+ * period will be for the next scan window. If local/(local+remote) ratio is
+ * below NUMA_PERIOD_THRESHOLD (where range of ratio is 1..NUMA_PERIOD_SLOTS)
+ * the scan period will decrease. Aim for 70% local accesses.
+ */
+#define NUMA_PERIOD_SLOTS 10
+#define NUMA_PERIOD_THRESHOLD 7
+
+/*
+ * Increase the scan period (slow down scanning) if the majority of
+ * our memory is already on our local node, or if the majority of
+ * the page accesses are shared with other processes.
+ * Otherwise, decrease the scan period.
+ */
+static void update_task_scan_period(struct task_struct *p,
+			unsigned long shared, unsigned long private)
+{
+	unsigned int period_slot;
+	int lr_ratio, ps_ratio;
+	int diff;
+
+	unsigned long remote = p->numa_faults_locality[0];
+	unsigned long local = p->numa_faults_locality[1];
+
+	/*
+	 * If there were no record hinting faults then either the task is
+	 * completely idle or all activity is in areas that are not of interest
+	 * to automatic numa balancing. Related to that, if there were failed
+	 * migration then it implies we are migrating too quickly or the local
+	 * node is overloaded. In either case, scan slower
+	 */
+	if (local + shared == 0 || p->numa_faults_locality[2]) {
+		p->numa_scan_period = min(p->numa_scan_period_max,
+			p->numa_scan_period << 1);
+
+		p->mm->numa_next_scan = jiffies +
+			msecs_to_jiffies(p->numa_scan_period);
+
+		return;
+	}
+
+	/*
+	 * Prepare to scale scan period relative to the current period.
+	 *	 == NUMA_PERIOD_THRESHOLD scan period stays the same
+	 *       <  NUMA_PERIOD_THRESHOLD scan period decreases (scan faster)
+	 *	 >= NUMA_PERIOD_THRESHOLD scan period increases (scan slower)
+	 */
+	period_slot = DIV_ROUND_UP(p->numa_scan_period, NUMA_PERIOD_SLOTS);
+	lr_ratio = (local * NUMA_PERIOD_SLOTS) / (local + remote);
+	ps_ratio = (private * NUMA_PERIOD_SLOTS) / (private + shared);
+
+	if (ps_ratio >= NUMA_PERIOD_THRESHOLD) {
+		/*
+		 * Most memory accesses are local. There is no need to
+		 * do fast NUMA scanning, since memory is already local.
+		 */
+		int slot = ps_ratio - NUMA_PERIOD_THRESHOLD;
+		if (!slot)
+			slot = 1;
+		diff = slot * period_slot;
+	} else if (lr_ratio >= NUMA_PERIOD_THRESHOLD) {
+		/*
+		 * Most memory accesses are shared with other tasks.
+		 * There is no point in continuing fast NUMA scanning,
+		 * since other tasks may just move the memory elsewhere.
+		 */
+		int slot = lr_ratio - NUMA_PERIOD_THRESHOLD;
+		if (!slot)
+			slot = 1;
+		diff = slot * period_slot;
+	} else {
+		/*
+		 * Private memory faults exceed (SLOTS-THRESHOLD)/SLOTS,
+		 * yet they are not on the local NUMA node. Speed up
+		 * NUMA scanning to get the memory moved over.
+		 */
+		int ratio = max(lr_ratio, ps_ratio);
+		diff = -(NUMA_PERIOD_THRESHOLD - ratio) * period_slot;
+	}
+
+	p->numa_scan_period = clamp(p->numa_scan_period + diff,
+			task_scan_min(p), task_scan_max(p));
+	memset(p->numa_faults_locality, 0, sizeof(p->numa_faults_locality));
+}
+
+/*
+ * Get the fraction of time the task has been running since the last
+ * NUMA placement cycle. The scheduler keeps similar statistics, but
+ * decays those on a 32ms period, which is orders of magnitude off
+ * from the dozens-of-seconds NUMA balancing period. Use the scheduler
+ * stats only if the task is so new there are no NUMA statistics yet.
+ */
+static u64 numa_get_avg_runtime(struct task_struct *p, u64 *period)
+{
+	u64 runtime, delta, now;
+	/* Use the start of this time slice to avoid calculations. */
+	now = p->se.exec_start;
+	runtime = p->se.sum_exec_runtime;
+
+	if (p->last_task_numa_placement) {
+		delta = runtime - p->last_sum_exec_runtime;
+		*period = now - p->last_task_numa_placement;
+
+		/* Avoid time going backwards, prevent potential divide error: */
+		if (unlikely((s64)*period < 0))
+			*period = 0;
+	} else {
+		delta = p->se.avg.load_sum;
+		*period = LOAD_AVG_MAX;
+	}
+
+	p->last_sum_exec_runtime = runtime;
+	p->last_task_numa_placement = now;
+
+	return delta;
+}
+
+/*
+ * Determine the preferred nid for a task in a numa_group. This needs to
+ * be done in a way that produces consistent results with group_weight,
+ * otherwise workloads might not converge.
+ */
+static int preferred_group_nid(struct task_struct *p, int nid)
+{
+	nodemask_t nodes;
+	int dist;
+
+	/* Direct connections between all NUMA nodes. */
+	if (sched_numa_topology_type == NUMA_DIRECT)
+		return nid;
+
+	/*
+	 * On a system with glueless mesh NUMA topology, group_weight
+	 * scores nodes according to the number of NUMA hinting faults on
+	 * both the node itself, and on nearby nodes.
+	 */
+	if (sched_numa_topology_type == NUMA_GLUELESS_MESH) {
+		unsigned long score, max_score = 0;
+		int node, max_node = nid;
+
+		dist = sched_max_numa_distance;
+
+		for_each_node_state(node, N_CPU) {
+			score = group_weight(p, node, dist);
+			if (score > max_score) {
+				max_score = score;
+				max_node = node;
+			}
+		}
+		return max_node;
+	}
+
+	/*
+	 * Finding the preferred nid in a system with NUMA backplane
+	 * interconnect topology is more involved. The goal is to locate
+	 * tasks from numa_groups near each other in the system, and
+	 * untangle workloads from different sides of the system. This requires
+	 * searching down the hierarchy of node groups, recursively searching
+	 * inside the highest scoring group of nodes. The nodemask tricks
+	 * keep the complexity of the search down.
+	 */
+	nodes = node_states[N_CPU];
+	for (dist = sched_max_numa_distance; dist > LOCAL_DISTANCE; dist--) {
+		unsigned long max_faults = 0;
+		nodemask_t max_group = NODE_MASK_NONE;
+		int a, b;
+
+		/* Are there nodes at this distance from each other? */
+		if (!find_numa_distance(dist))
+			continue;
+
+		for_each_node_mask(a, nodes) {
+			unsigned long faults = 0;
+			nodemask_t this_group;
+			nodes_clear(this_group);
+
+			/* Sum group's NUMA faults; includes a==b case. */
+			for_each_node_mask(b, nodes) {
+				if (node_distance(a, b) < dist) {
+					faults += group_faults(p, b);
+					node_set(b, this_group);
+					node_clear(b, nodes);
+				}
+			}
+
+			/* Remember the top group. */
+			if (faults > max_faults) {
+				max_faults = faults;
+				max_group = this_group;
+				/*
+				 * subtle: at the smallest distance there is
+				 * just one node left in each "group", the
+				 * winner is the preferred nid.
+				 */
+				nid = a;
+			}
+		}
+		/* Next round, evaluate the nodes within max_group. */
+		if (!max_faults)
+			break;
+		nodes = max_group;
+	}
+	return nid;
+}
+
+static void task_numa_placement(struct task_struct *p)
+{
+	int seq, nid, max_nid = NUMA_NO_NODE;
+	unsigned long max_faults = 0;
+	unsigned long fault_types[2] = { 0, 0 };
+	unsigned long total_faults;
+	u64 runtime, period;
+	spinlock_t *group_lock = NULL;
+	struct numa_group *ng;
+
+	/*
+	 * The p->mm->numa_scan_seq field gets updated without
+	 * exclusive access. Use READ_ONCE() here to ensure
+	 * that the field is read in a single access:
+	 */
+	seq = READ_ONCE(p->mm->numa_scan_seq);
+	if (p->numa_scan_seq == seq)
+		return;
+	p->numa_scan_seq = seq;
+	p->numa_scan_period_max = task_scan_max(p);
+
+	total_faults = p->numa_faults_locality[0] +
+		       p->numa_faults_locality[1];
+	runtime = numa_get_avg_runtime(p, &period);
+
+	/* If the task is part of a group prevent parallel updates to group stats */
+	ng = deref_curr_numa_group(p);
+	if (ng) {
+		group_lock = &ng->lock;
+		spin_lock_irq(group_lock);
+	}
+
+	/* Find the node with the highest number of faults */
+	for_each_online_node(nid) {
+		/* Keep track of the offsets in numa_faults array */
+		int mem_idx, membuf_idx, cpu_idx, cpubuf_idx;
+		unsigned long faults = 0, group_faults = 0;
+		int priv;
+
+		for (priv = 0; priv < NR_NUMA_HINT_FAULT_TYPES; priv++) {
+			long diff, f_diff, f_weight;
+
+			mem_idx = task_faults_idx(NUMA_MEM, nid, priv);
+			membuf_idx = task_faults_idx(NUMA_MEMBUF, nid, priv);
+			cpu_idx = task_faults_idx(NUMA_CPU, nid, priv);
+			cpubuf_idx = task_faults_idx(NUMA_CPUBUF, nid, priv);
+
+			/* Decay existing window, copy faults since last scan */
+			diff = p->numa_faults[membuf_idx] - p->numa_faults[mem_idx] / 2;
+			fault_types[priv] += p->numa_faults[membuf_idx];
+			p->numa_faults[membuf_idx] = 0;
+
+			/*
+			 * Normalize the faults_from, so all tasks in a group
+			 * count according to CPU use, instead of by the raw
+			 * number of faults. Tasks with little runtime have
+			 * little over-all impact on throughput, and thus their
+			 * faults are less important.
+			 */
+			f_weight = div64_u64(runtime << 16, period + 1);
+			f_weight = (f_weight * p->numa_faults[cpubuf_idx]) /
+				   (total_faults + 1);
+			f_diff = f_weight - p->numa_faults[cpu_idx] / 2;
+			p->numa_faults[cpubuf_idx] = 0;
+
+			p->numa_faults[mem_idx] += diff;
+			p->numa_faults[cpu_idx] += f_diff;
+			faults += p->numa_faults[mem_idx];
+			p->total_numa_faults += diff;
+			if (ng) {
+				/*
+				 * safe because we can only change our own group
+				 *
+				 * mem_idx represents the offset for a given
+				 * nid and priv in a specific region because it
+				 * is at the beginning of the numa_faults array.
+				 */
+				ng->faults[mem_idx] += diff;
+				ng->faults[cpu_idx] += f_diff;
+				ng->total_faults += diff;
+				group_faults += ng->faults[mem_idx];
+			}
+		}
+
+		if (!ng) {
+			if (faults > max_faults) {
+				max_faults = faults;
+				max_nid = nid;
+			}
+		} else if (group_faults > max_faults) {
+			max_faults = group_faults;
+			max_nid = nid;
+		}
+	}
+
+	/* Cannot migrate task to CPU-less node */
+	max_nid = numa_nearest_node(max_nid, N_CPU);
+
+	if (ng) {
+		numa_group_count_active_nodes(ng);
+		spin_unlock_irq(group_lock);
+		max_nid = preferred_group_nid(p, max_nid);
+	}
+
+	if (max_faults) {
+		/* Set the new preferred node */
+		if (max_nid != p->numa_preferred_nid)
+			sched_setnuma(p, max_nid);
+	}
+
+	update_task_scan_period(p, fault_types[0], fault_types[1]);
+}
+
+static inline int get_numa_group(struct numa_group *grp)
+{
+	return refcount_inc_not_zero(&grp->refcount);
+}
+
+static inline void put_numa_group(struct numa_group *grp)
+{
+	if (refcount_dec_and_test(&grp->refcount))
+		kfree_rcu(grp, rcu);
+}
+
+static void task_numa_group(struct task_struct *p, int cpupid, int flags,
+			int *priv)
+{
+	struct numa_group *grp, *my_grp;
+	struct task_struct *tsk;
+	bool join = false;
+	int cpu = cpupid_to_cpu(cpupid);
+	int i;
+
+	if (unlikely(!deref_curr_numa_group(p))) {
+		unsigned int size = sizeof(struct numa_group) +
+				    NR_NUMA_HINT_FAULT_STATS *
+				    nr_node_ids * sizeof(unsigned long);
+
+		grp = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
+		if (!grp)
+			return;
+
+		refcount_set(&grp->refcount, 1);
+		grp->active_nodes = 1;
+		grp->max_faults_cpu = 0;
+		spin_lock_init(&grp->lock);
+		grp->gid = p->pid;
+
+		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
+			grp->faults[i] = p->numa_faults[i];
+
+		grp->total_faults = p->total_numa_faults;
+
+		grp->nr_tasks++;
+		rcu_assign_pointer(p->numa_group, grp);
+	}
+
+	rcu_read_lock();
+	tsk = READ_ONCE(cpu_rq(cpu)->curr);
+
+	if (!cpupid_match_pid(tsk, cpupid))
+		goto no_join;
+
+	grp = rcu_dereference(tsk->numa_group);
+	if (!grp)
+		goto no_join;
+
+	my_grp = deref_curr_numa_group(p);
+	if (grp == my_grp)
+		goto no_join;
+
+	/*
+	 * Only join the other group if its bigger; if we're the bigger group,
+	 * the other task will join us.
+	 */
+	if (my_grp->nr_tasks > grp->nr_tasks)
+		goto no_join;
+
+	/*
+	 * Tie-break on the grp address.
+	 */
+	if (my_grp->nr_tasks == grp->nr_tasks && my_grp > grp)
+		goto no_join;
+
+	/* Always join threads in the same process. */
+	if (tsk->mm == current->mm)
+		join = true;
+
+	/* Simple filter to avoid false positives due to PID collisions */
+	if (flags & TNF_SHARED)
+		join = true;
+
+	/* Update priv based on whether false sharing was detected */
+	*priv = !join;
+
+	if (join && !get_numa_group(grp))
+		goto no_join;
+
+	rcu_read_unlock();
+
+	if (!join)
+		return;
+
+	WARN_ON_ONCE(irqs_disabled());
+	double_lock_irq(&my_grp->lock, &grp->lock);
+
+	for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++) {
+		my_grp->faults[i] -= p->numa_faults[i];
+		grp->faults[i] += p->numa_faults[i];
+	}
+	my_grp->total_faults -= p->total_numa_faults;
+	grp->total_faults += p->total_numa_faults;
+
+	my_grp->nr_tasks--;
+	grp->nr_tasks++;
+
+	spin_unlock(&my_grp->lock);
+	spin_unlock_irq(&grp->lock);
+
+	rcu_assign_pointer(p->numa_group, grp);
+
+	put_numa_group(my_grp);
+	return;
+
+no_join:
+	rcu_read_unlock();
+	return;
+}
+
+/*
+ * Get rid of NUMA statistics associated with a task (either current or dead).
+ * If @final is set, the task is dead and has reached refcount zero, so we can
+ * safely free all relevant data structures. Otherwise, there might be
+ * concurrent reads from places like load balancing and procfs, and we should
+ * reset the data back to default state without freeing ->numa_faults.
+ */
+void task_numa_free(struct task_struct *p, bool final)
+{
+	/* safe: p either is current or is being freed by current */
+	struct numa_group *grp = rcu_dereference_raw(p->numa_group);
+	unsigned long *numa_faults = p->numa_faults;
+	unsigned long flags;
+	int i;
+
+	if (!numa_faults)
+		return;
+
+	if (grp) {
+		spin_lock_irqsave(&grp->lock, flags);
+		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
+			grp->faults[i] -= p->numa_faults[i];
+		grp->total_faults -= p->total_numa_faults;
+
+		grp->nr_tasks--;
+		spin_unlock_irqrestore(&grp->lock, flags);
+		RCU_INIT_POINTER(p->numa_group, NULL);
+		put_numa_group(grp);
+	}
+
+	if (final) {
+		p->numa_faults = NULL;
+		kfree(numa_faults);
+	} else {
+		p->total_numa_faults = 0;
+		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
+			numa_faults[i] = 0;
+	}
+}
+
+/*
+ * Got a PROT_NONE fault for a page on @node.
+ */
+void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
+{
+	struct task_struct *p = current;
+	bool migrated = flags & TNF_MIGRATED;
+	int cpu_node = task_node(current);
+	int local = !!(flags & TNF_FAULT_LOCAL);
+	struct numa_group *ng;
+	int priv;
+
+	if (!static_branch_likely(&sched_numa_balancing))
+		return;
+
+	/* for example, ksmd faulting in a user's mm */
+	if (!p->mm)
+		return;
+
+	/*
+	 * NUMA faults statistics are unnecessary for the slow memory
+	 * node for memory tiering mode.
+	 */
+	if (!node_is_toptier(mem_node) &&
+	    (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING ||
+	     !cpupid_valid(last_cpupid)))
+		return;
+
+	/* Allocate buffer to track faults on a per-node basis */
+	if (unlikely(!p->numa_faults)) {
+		int size = sizeof(*p->numa_faults) *
+			   NR_NUMA_HINT_FAULT_BUCKETS * nr_node_ids;
+
+		p->numa_faults = kzalloc(size, GFP_KERNEL|__GFP_NOWARN);
+		if (!p->numa_faults)
+			return;
+
+		p->total_numa_faults = 0;
+		memset(p->numa_faults_locality, 0, sizeof(p->numa_faults_locality));
+	}
+
+	/*
+	 * First accesses are treated as private, otherwise consider accesses
+	 * to be private if the accessing pid has not changed
+	 */
+	if (unlikely(last_cpupid == (-1 & LAST_CPUPID_MASK))) {
+		priv = 1;
+	} else {
+		priv = cpupid_match_pid(p, last_cpupid);
+		if (!priv && !(flags & TNF_NO_GROUP))
+			task_numa_group(p, last_cpupid, flags, &priv);
+	}
+
+	/*
+	 * If a workload spans multiple NUMA nodes, a shared fault that
+	 * occurs wholly within the set of nodes that the workload is
+	 * actively using should be counted as local. This allows the
+	 * scan rate to slow down when a workload has settled down.
+	 */
+	ng = deref_curr_numa_group(p);
+	if (!priv && !local && ng && ng->active_nodes > 1 &&
+				numa_is_active_node(cpu_node, ng) &&
+				numa_is_active_node(mem_node, ng))
+		local = 1;
+
+	/*
+	 * Retry to migrate task to preferred node periodically, in case it
+	 * previously failed, or the scheduler moved us.
+	 */
+	if (time_after(jiffies, p->numa_migrate_retry)) {
+		task_numa_placement(p);
+		numa_migrate_preferred(p);
+	}
+
+	if (migrated)
+		p->numa_pages_migrated += pages;
+	if (flags & TNF_MIGRATE_FAIL)
+		p->numa_faults_locality[2] += pages;
+
+	p->numa_faults[task_faults_idx(NUMA_MEMBUF, mem_node, priv)] += pages;
+	p->numa_faults[task_faults_idx(NUMA_CPUBUF, cpu_node, priv)] += pages;
+	p->numa_faults_locality[local] += pages;
+}
+
+static void reset_ptenuma_scan(struct task_struct *p)
+{
+	/*
+	 * We only did a read acquisition of the mmap sem, so
+	 * p->mm->numa_scan_seq is written to without exclusive access
+	 * and the update is not guaranteed to be atomic. That's not
+	 * much of an issue though, since this is just used for
+	 * statistical sampling. Use READ_ONCE/WRITE_ONCE, which are not
+	 * expensive, to avoid any form of compiler optimizations:
+	 */
+	WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);
+	p->mm->numa_scan_offset = 0;
+}
+
+static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	unsigned long pids;
+	/*
+	 * Allow unconditional access first two times, so that all the (pages)
+	 * of VMAs get prot_none fault introduced irrespective of accesses.
+	 * This is also done to avoid any side effect of task scanning
+	 * amplifying the unfairness of disjoint set of VMAs' access.
+	 */
+	if ((READ_ONCE(current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2)
+		return true;
+
+	pids = vma->numab_state->pids_active[0] | vma->numab_state->pids_active[1];
+	if (test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids))
+		return true;
+
+	/*
+	 * Complete a scan that has already started regardless of PID access, or
+	 * some VMAs may never be scanned in multi-threaded applications:
+	 */
+	if (mm->numa_scan_offset > vma->vm_start) {
+		trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_IGNORE_PID);
+		return true;
+	}
+
+	return false;
+}
+
+#define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
+
+/*
+ * The expensive part of numa migration is done from task_work context.
+ * Triggered from task_tick_numa().
+ */
+static void task_numa_work(struct callback_head *work)
+{
+	unsigned long migrate, next_scan, now = jiffies;
+	struct task_struct *p = current;
+	struct mm_struct *mm = p->mm;
+	u64 runtime = p->se.sum_exec_runtime;
+	struct vm_area_struct *vma;
+	unsigned long start, end;
+	unsigned long nr_pte_updates = 0;
+	long pages, virtpages;
+	struct vma_iterator vmi;
+	bool vma_pids_skipped;
+	bool vma_pids_forced = false;
+
+	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
+
+	work->next = work;
+	/*
+	 * Who cares about NUMA placement when they're dying.
+	 *
+	 * NOTE: make sure not to dereference p->mm before this check,
+	 * exit_task_work() happens _after_ exit_mm() so we could be called
+	 * without p->mm even though we still had it when we enqueued this
+	 * work.
+	 */
+	if (p->flags & PF_EXITING)
+		return;
+
+	if (!mm->numa_next_scan) {
+		mm->numa_next_scan = now +
+			msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
+	}
+
+	/*
+	 * Enforce maximal scan/migration frequency..
+	 */
+	migrate = mm->numa_next_scan;
+	if (time_before(now, migrate))
+		return;
+
+	if (p->numa_scan_period == 0) {
+		p->numa_scan_period_max = task_scan_max(p);
+		p->numa_scan_period = task_scan_start(p);
+	}
+
+	next_scan = now + msecs_to_jiffies(p->numa_scan_period);
+	if (!try_cmpxchg(&mm->numa_next_scan, &migrate, next_scan))
+		return;
+
+	/*
+	 * Delay this task enough that another task of this mm will likely win
+	 * the next time around.
+	 */
+	p->node_stamp += 2 * TICK_NSEC;
+
+	pages = sysctl_numa_balancing_scan_size;
+	pages <<= 20 - PAGE_SHIFT; /* MB in pages */
+	virtpages = pages * 8;	   /* Scan up to this much virtual space */
+	if (!pages)
+		return;
+
+
+	if (!mmap_read_trylock(mm))
+		return;
+
+	/*
+	 * VMAs are skipped if the current PID has not trapped a fault within
+	 * the VMA recently. Allow scanning to be forced if there is no
+	 * suitable VMA remaining.
+	 */
+	vma_pids_skipped = false;
+
+retry_pids:
+	start = mm->numa_scan_offset;
+	vma_iter_init(&vmi, mm, start);
+	vma = vma_next(&vmi);
+	if (!vma) {
+		reset_ptenuma_scan(p);
+		start = 0;
+		vma_iter_set(&vmi, start);
+		vma = vma_next(&vmi);
+	}
+
+	do {
+		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
+			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
+			continue;
+		}
+
+		/*
+		 * Shared library pages mapped by multiple processes are not
+		 * migrated as it is expected they are cache replicated. Avoid
+		 * hinting faults in read-only file-backed mappings or the vDSO
+		 * as migrating the pages will be of marginal benefit.
+		 */
+		if (!vma->vm_mm ||
+		    (vma->vm_file && (vma->vm_flags & (VM_READ|VM_WRITE)) == (VM_READ))) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SHARED_RO);
+			continue;
+		}
+
+		/*
+		 * Skip inaccessible VMAs to avoid any confusion between
+		 * PROT_NONE and NUMA hinting PTEs
+		 */
+		if (!vma_is_accessible(vma)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_INACCESSIBLE);
+			continue;
+		}
+
+		/* Initialise new per-VMA NUMAB state. */
+		if (!vma->numab_state) {
+			vma->numab_state = kzalloc(sizeof(struct vma_numab_state),
+				GFP_KERNEL);
+			if (!vma->numab_state)
+				continue;
+
+			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
+
+			vma->numab_state->next_scan = now +
+				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
+
+			/* Reset happens after 4 times scan delay of scan start */
+			vma->numab_state->pids_active_reset =  vma->numab_state->next_scan +
+				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
+
+			/*
+			 * Ensure prev_scan_seq does not match numa_scan_seq,
+			 * to prevent VMAs being skipped prematurely on the
+			 * first scan:
+			 */
+			 vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;
+		}
+
+		/*
+		 * Scanning the VMAs of short lived tasks add more overhead. So
+		 * delay the scan for new VMAs.
+		 */
+		if (mm->numa_scan_seq && time_before(jiffies,
+						vma->numab_state->next_scan)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SCAN_DELAY);
+			continue;
+		}
+
+		/* RESET access PIDs regularly for old VMAs. */
+		if (mm->numa_scan_seq &&
+				time_after(jiffies, vma->numab_state->pids_active_reset)) {
+			vma->numab_state->pids_active_reset = vma->numab_state->pids_active_reset +
+				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
+			vma->numab_state->pids_active[0] = READ_ONCE(vma->numab_state->pids_active[1]);
+			vma->numab_state->pids_active[1] = 0;
+		}
+
+		/* Do not rescan VMAs twice within the same sequence. */
+		if (vma->numab_state->prev_scan_seq == mm->numa_scan_seq) {
+			mm->numa_scan_offset = vma->vm_end;
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SEQ_COMPLETED);
+			continue;
+		}
+
+		/*
+		 * Do not scan the VMA if task has not accessed it, unless no other
+		 * VMA candidate exists.
+		 */
+		if (!vma_pids_forced && !vma_is_accessed(mm, vma)) {
+			vma_pids_skipped = true;
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
+			continue;
+		}
+
+		do {
+			start = max(start, vma->vm_start);
+			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
+			end = min(end, vma->vm_end);
+			nr_pte_updates = change_prot_numa(vma, start, end);
+
+			/*
+			 * Try to scan sysctl_numa_balancing_size worth of
+			 * hpages that have at least one present PTE that
+			 * is not already PTE-numa. If the VMA contains
+			 * areas that are unused or already full of prot_numa
+			 * PTEs, scan up to virtpages, to skip through those
+			 * areas faster.
+			 */
+			if (nr_pte_updates)
+				pages -= (end - start) >> PAGE_SHIFT;
+			virtpages -= (end - start) >> PAGE_SHIFT;
+
+			start = end;
+			if (pages <= 0 || virtpages <= 0)
+				goto out;
+
+			cond_resched();
+		} while (end != vma->vm_end);
+
+		/* VMA scan is complete, do not scan until next sequence. */
+		vma->numab_state->prev_scan_seq = mm->numa_scan_seq;
+
+		/*
+		 * Only force scan within one VMA at a time, to limit the
+		 * cost of scanning a potentially uninteresting VMA.
+		 */
+		if (vma_pids_forced)
+			break;
+	} for_each_vma(vmi, vma);
+
+	/*
+	 * If no VMAs are remaining and VMAs were skipped due to the PID
+	 * not accessing the VMA previously, then force a scan to ensure
+	 * forward progress:
+	 */
+	if (!vma && !vma_pids_forced && vma_pids_skipped) {
+		vma_pids_forced = true;
+		goto retry_pids;
+	}
+
+out:
+	/*
+	 * It is possible to reach the end of the VMA list but the last few
+	 * VMAs are not guaranteed to the vma_migratable. If they are not, we
+	 * would find the !migratable VMA on the next scan but not reset the
+	 * scanner to the start so check it now.
+	 */
+	if (vma)
+		mm->numa_scan_offset = start;
+	else
+		reset_ptenuma_scan(p);
+	mmap_read_unlock(mm);
+
+	/*
+	 * Make sure tasks use at least 32x as much time to run other code
+	 * than they used here, to limit NUMA PTE scanning overhead to 3% max.
+	 * Usually update_task_scan_period slows down scanning enough; on an
+	 * overloaded system we need to limit overhead on a per task basis.
+	 */
+	if (unlikely(p->se.sum_exec_runtime != runtime)) {
+		u64 diff = p->se.sum_exec_runtime - runtime;
+		p->node_stamp += 32 * diff;
+	}
+}
+
+void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
+{
+	int mm_users = 0;
+	struct mm_struct *mm = p->mm;
+
+	if (mm) {
+		mm_users = atomic_read(&mm->mm_users);
+		if (mm_users == 1) {
+			mm->numa_next_scan = jiffies + msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
+			mm->numa_scan_seq = 0;
+		}
+	}
+	p->node_stamp			= 0;
+	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
+	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
+	p->numa_migrate_retry		= 0;
+	/* Protect against double add, see task_tick_numa and task_numa_work */
+	p->numa_work.next		= &p->numa_work;
+	p->numa_faults			= NULL;
+	p->numa_pages_migrated		= 0;
+	p->total_numa_faults		= 0;
+	RCU_INIT_POINTER(p->numa_group, NULL);
+	p->last_task_numa_placement	= 0;
+	p->last_sum_exec_runtime	= 0;
+
+	init_task_work(&p->numa_work, task_numa_work);
+
+	/* New address space, reset the preferred nid */
+	if (!(clone_flags & CLONE_VM)) {
+		p->numa_preferred_nid = NUMA_NO_NODE;
+		return;
+	}
+
+	/*
+	 * New thread, keep existing numa_preferred_nid which should be copied
+	 * already by arch_dup_task_struct but stagger when scans start.
+	 */
+	if (mm) {
+		unsigned int delay;
+
+		delay = min_t(unsigned int, task_scan_max(current),
+			current->numa_scan_period * mm_users * NSEC_PER_MSEC);
+		delay += 2 * TICK_NSEC;
+		p->node_stamp = delay;
+	}
+}
+
+/*
+ * Drive the periodic memory faults..
+ */
+void task_tick_numa(struct rq *rq, struct task_struct *curr)
+{
+	struct callback_head *work = &curr->numa_work;
+	u64 period, now;
+
+	/*
+	 * We don't care about NUMA placement if we don't have memory.
+	 */
+	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
+		return;
+
+	/*
+	 * Using runtime rather than walltime has the dual advantage that
+	 * we (mostly) drive the selection from busy threads and that the
+	 * task needs to have done some actual work before we bother with
+	 * NUMA placement.
+	 */
+	now = curr->se.sum_exec_runtime;
+	period = (u64)curr->numa_scan_period * NSEC_PER_MSEC;
+
+	if (now > curr->node_stamp + period) {
+		if (!curr->node_stamp)
+			curr->numa_scan_period = task_scan_start(curr);
+		curr->node_stamp += period;
+
+		if (!time_before(jiffies, curr->mm->numa_next_scan))
+			task_work_add(curr, work, TWA_RESUME);
+	}
+}
+
+void update_scan_period(struct task_struct *p, int new_cpu)
+{
+	int src_nid = cpu_to_node(task_cpu(p));
+	int dst_nid = cpu_to_node(new_cpu);
+
+	if (!static_branch_likely(&sched_numa_balancing))
+		return;
+
+	if (!p->mm || !p->numa_faults || (p->flags & PF_EXITING))
+		return;
+
+	if (src_nid == dst_nid)
+		return;
+
+	/*
+	 * Allow resets if faults have been trapped before one scan
+	 * has completed. This is most likely due to a new task that
+	 * is pulled cross-node due to wakeups or load balancing.
+	 */
+	if (p->numa_scan_seq) {
+		/*
+		 * Avoid scan adjustments if moving to the preferred
+		 * node or if the task was not previously running on
+		 * the preferred node.
+		 */
+		if (dst_nid == p->numa_preferred_nid ||
+		    (p->numa_preferred_nid != NUMA_NO_NODE &&
+			src_nid != p->numa_preferred_nid))
+			return;
+	}
+
+	p->numa_scan_period = task_scan_start(p);
+}
+
+#ifdef CONFIG_SCHED_DEBUG
+void show_numa_stats(struct task_struct *p, struct seq_file *m)
+{
+	int node;
+	unsigned long tsf = 0, tpf = 0, gsf = 0, gpf = 0;
+	struct numa_group *ng;
+
+	rcu_read_lock();
+	ng = rcu_dereference(p->numa_group);
+	for_each_online_node(node) {
+		if (p->numa_faults) {
+			tsf = p->numa_faults[task_faults_idx(NUMA_MEM, node, 0)];
+			tpf = p->numa_faults[task_faults_idx(NUMA_MEM, node, 1)];
+		}
+		if (ng) {
+			gsf = ng->faults[task_faults_idx(NUMA_MEM, node, 0)],
+			gpf = ng->faults[task_faults_idx(NUMA_MEM, node, 1)];
+		}
+		print_numa_stats(m, node, tsf, tpf, gsf, gpf);
+	}
+	rcu_read_unlock();
+}
+#endif /* CONFIG_SCHED_DEBUG */
+
+#endif /* CONFIG_NUMA_BALANCING */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7f1d856fdc3b..d687b9a272fc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3608,7 +3608,7 @@ sched_balance_find_dst_group(struct sched_domain *sd, struct task_struct *p, int
 #ifdef CONFIG_FAIR_GROUP_SCHED
 extern unsigned long task_h_load(struct task_struct *p);
 #else
-static unsigned long task_h_load(struct task_struct *p)
+static inline unsigned long task_h_load(struct task_struct *p)
 {
 	return p->se.avg.load_avg;
 }
@@ -3850,4 +3850,42 @@ static inline void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_en
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
 #endif
 
+#ifdef CONFIG_NUMA_BALANCING
+extern void task_tick_numa(struct rq *rq, struct task_struct *curr);
+extern void account_numa_enqueue(struct rq *rq, struct task_struct *p);
+extern void account_numa_dequeue(struct rq *rq, struct task_struct *p);
+extern void update_scan_period(struct task_struct *p, int new_cpu);
+
+extern unsigned int sysctl_numa_balancing_promote_rate_limit;
+
+#else
+static inline void task_tick_numa(struct rq *rq, struct task_struct *curr) { }
+static inline void account_numa_enqueue(struct rq *rq, struct task_struct *p) { }
+static inline void account_numa_dequeue(struct rq *rq, struct task_struct *p) { }
+static inline void update_scan_period(struct task_struct *p, int new_cpu) { }
+#endif
+
+
+#ifdef CONFIG_SCHED_SMT
+
+static inline bool test_idle_cores(int cpu)
+{
+	struct sched_domain_shared *sds;
+
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds)
+		return READ_ONCE(sds->has_idle_cores);
+
+	return false;
+}
+
+#else
+
+static inline bool test_idle_cores(int cpu)
+{
+	return false;
+}
+
+#endif
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.40.1


