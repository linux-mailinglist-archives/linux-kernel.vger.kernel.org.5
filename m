Return-Path: <linux-kernel+bounces-120294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 943A888D56E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22A8B21FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6DC2C182;
	Wed, 27 Mar 2024 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T+/+vC/R"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077A241EC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711513016; cv=none; b=cL8F+kcvehJ1Vyn/YxBx5L17nZ5pujMpvki6phD5Zv4UUfeuc6jqHes4AYidGYnlmAc6VIV3lTFpo7SXS6H06L0DJx2yHTlSy9CL/hHZ3UTupqonzMW4H/qcy7CQjDqOAyfdB+2DqQ4o4CYzQTWze5kJOAvnmHyaIQZM7+ZA518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711513016; c=relaxed/simple;
	bh=7QVbAgaawndTJX564D0oAdnA8aRIeMWkYqCYdnYgnEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1862u+xSyP2a/XTQN3xjo7PlkFPUC6IPgQRAkI6IokqnFg+slrMXF468t503UoVJ1uOxlqSH32CMKi457NXTD0BgHfiK1ZlXCe9rk2r4+6P9QYhdWt9dammIGb0wycOjHgHZl6EEmN+gCQzjPQrsk7U/pDlQWbJiEKFic7EIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T+/+vC/R; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-430bf84977dso42400021cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711513013; x=1712117813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QB9vPuIKSQgIpOAN1iO1OyFVlWoszt4mBas5cObYBt0=;
        b=T+/+vC/RaQiVu/XX9S9ILaeh2CgGW6yFdi/Ou7pOBFEvTg6Wg/K5+cPIxYq9I5kwbo
         9ACRHCzuxq+WP9XeI4iTrrmFii0cOzGdYSAE82o0M1VoKCsOmpxvHKii29iqu5ElH4ys
         Wgf3iJmStQVfnVmWJoLThbaZ0iSCugSW/jSzEkY7aOXFVzhT0Hei2/IJ5E1Z71EBHwbn
         4/TCR4GM9MsL9aLAWYUOZNFwOrxRncq9DdWplC05m8HIDvZVnDmkZ4p7v+0GqzTeccGl
         gcB/XywY9MbFdloLZAJQvYP5006lWHQ/0rrgDL51CgxQSdcD99/red8P6xt7yFkb8/sR
         35ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711513013; x=1712117813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QB9vPuIKSQgIpOAN1iO1OyFVlWoszt4mBas5cObYBt0=;
        b=fecwROdxqhizo7AvA9eCrG7oRTiiN8IKJqhWgN2gwrvO+bwp3xPPNI0aubwWimouOg
         KUcKPS3SWo1cf5EtlUMojqltUkZZFTtdVLRXK/PqUZA7HbzJ2XmyCJB+kOjZ71b4wiK+
         zbpMbEL7S/AfdzCWEfdYplT0+wq82uL8lNbUS+m+b0zVCzI5OdoTRmUte2jfy5IT/oW+
         3sFrzNXqm6W7uS3PQBHK2GBN4yyipbbL/i/eDK3DhPTGTaoBysgDQCTSvfT0bII+xnL3
         gJc6qyXW997xr7GUZv7H1rSFimLK75ZMoa0IW+Md9S2oerBLBCncsdsu3pWCv4YOp/iZ
         QajQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBjdJgvcxS+MeuR1FgXdUELx9EZKB7cb9fhk9kLZatamj2Px6voNmuMNztaTgRPdqhysjwtDIZwfLkYyVCxJMvUJZv/tJeko4q6gxx
X-Gm-Message-State: AOJu0YwfGO0tel8VNnqzNcoqITnrNhu9LlGUAfZpaznc1PsPB6D3ZA4m
	Z8KtYm71N7MbffEvkZJMBr5zFGtAg1gvkj7yGd7OWIV62tNliJ2UuOgGE3bdfgo=
X-Google-Smtp-Source: AGHT+IGro00ZV3fYTe7TE2hRIr5DsQebt1LEKkxDnTXu/2fbTJUhVHnBTE3BDQ8/xUarXeNtlbUQ4Q==
X-Received: by 2002:ac8:7fc3:0:b0:430:bd04:ad6 with SMTP id b3-20020ac87fc3000000b00430bd040ad6mr3474694qtk.34.1711513012904;
        Tue, 26 Mar 2024 21:16:52 -0700 (PDT)
Received: from n231-228-171.byted.org ([147.160.184.93])
        by smtp.gmail.com with ESMTPSA id hb11-20020a05622a2b4b00b0043123c8b6a6sm4370696qtb.4.2024.03.26.21.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:16:52 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Huang, Ying" <ying.huang@intel.com>,
	"Gregory Price" <gourry.memverge@gmail.com>,
	aneesh.kumar@linux.ibm.com,
	mhocko@suse.com,
	tj@kernel.org,
	john@jagalactic.com,
	"Eishan Mirakhur" <emirakhur@micron.com>,
	"Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
	"Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
	"Alistair Popple" <apopple@nvidia.com>,
	"Srinivasulu Thanneeru" <sthanneeru@micron.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	qemu-devel@nongnu.org,
	Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v5 2/2] memory tier: create CPUless memory tiers after obtaining HMAT info
Date: Wed, 27 Mar 2024 04:16:46 +0000
Message-Id: <20240327041646.3258110-3-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240327041646.3258110-1-horenchuang@bytedance.com>
References: <20240327041646.3258110-1-horenchuang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation treats emulated memory devices, such as
CXL1.1 type3 memory, as normal DRAM when they are emulated as normal memory
(E820_TYPE_RAM). However, these emulated devices have different
characteristics than traditional DRAM, making it important to
distinguish them. Thus, we modify the tiered memory initialization process
to introduce a delay specifically for CPUless NUMA nodes. This delay
ensures that the memory tier initialization for these nodes is deferred
until HMAT information is obtained during the boot process. Finally,
demotion tables are recalculated at the end.

* late_initcall(memory_tier_late_init);
Some device drivers may have initialized memory tiers between
`memory_tier_init()` and `memory_tier_late_init()`, potentially bringing
online memory nodes and configuring memory tiers. They should be excluded
in the late init.

* Handle cases where there is no HMAT when creating memory tiers
There is a scenario where a CPUless node does not provide HMAT information.
If no HMAT is specified, it falls back to using the default DRAM tier.

* Introduce another new lock `default_dram_perf_lock` for adist calculation
In the current implementation, iterating through CPUlist nodes requires
holding the `memory_tier_lock`. However, `mt_calc_adistance()` will end up
trying to acquire the same lock, leading to a potential deadlock.
Therefore, we propose introducing a standalone `default_dram_perf_lock` to
protect `default_dram_perf_*`. This approach not only avoids deadlock
but also prevents holding a large lock simultaneously. Besides, this patch
slightly shortens the time holding the lock by putting the lock closer to
what it protects as well.

* Upgrade `set_node_memory_tier` to support additional cases, including
  default DRAM, late CPUless, and hot-plugged initializations.
To cover hot-plugged memory nodes, `mt_calc_adistance()` and
`mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()` to
handle cases where memtype is not initialized and where HMAT information is
available.

* Introduce `default_memory_types` for those memory types that are not
  initialized by device drivers.
Because late initialized memory and default DRAM memory need to be managed,
a default memory type is created for storing all memory types that are
not initialized by device drivers and as a fallback.

* Fix a deadlock bug in `mt_perf_to_adistance`
Because an error path was not handled properly in `mt_perf_to_adistance`,
unlock before returning the error.

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 mm/memory-tiers.c | 85 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 13 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 974af10cfdd8..610db9581ba4 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -36,6 +36,11 @@ struct node_memory_type_map {
 
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
+/*
+ * The list is used to store all memory types that are not created
+ * by a device driver.
+ */
+static LIST_HEAD(default_memory_types);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 struct memory_dev_type *default_dram_type;
 
@@ -108,6 +113,8 @@ static struct demotion_nodes *node_demotion __read_mostly;
 
 static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
 
+/* The lock is used to protect `default_dram_perf*` info and nid. */
+static DEFINE_MUTEX(default_dram_perf_lock);
 static bool default_dram_perf_error;
 static struct access_coordinate default_dram_perf;
 static int default_dram_perf_ref_nid = NUMA_NO_NODE;
@@ -505,7 +512,8 @@ static inline void __init_node_memory_type(int node, struct memory_dev_type *mem
 static struct memory_tier *set_node_memory_tier(int node)
 {
 	struct memory_tier *memtier;
-	struct memory_dev_type *memtype;
+	struct memory_dev_type *mtype = default_dram_type;
+	int adist = MEMTIER_ADISTANCE_DRAM;
 	pg_data_t *pgdat = NODE_DATA(node);
 
 
@@ -514,11 +522,20 @@ static struct memory_tier *set_node_memory_tier(int node)
 	if (!node_state(node, N_MEMORY))
 		return ERR_PTR(-EINVAL);
 
-	__init_node_memory_type(node, default_dram_type);
+	mt_calc_adistance(node, &adist);
+	if (node_memory_types[node].memtype == NULL) {
+		mtype = mt_find_alloc_memory_type(adist, &default_memory_types);
+		if (IS_ERR(mtype)) {
+			mtype = default_dram_type;
+			pr_info("Failed to allocate a memory type. Fall back.\n");
+		}
+	}
 
-	memtype = node_memory_types[node].memtype;
-	node_set(node, memtype->nodes);
-	memtier = find_create_memory_tier(memtype);
+	__init_node_memory_type(node, mtype);
+
+	mtype = node_memory_types[node].memtype;
+	node_set(node, mtype->nodes);
+	memtier = find_create_memory_tier(mtype);
 	if (!IS_ERR(memtier))
 		rcu_assign_pointer(pgdat->memtier, memtier);
 	return memtier;
@@ -655,6 +672,34 @@ void mt_put_memory_types(struct list_head *memory_types)
 }
 EXPORT_SYMBOL_GPL(mt_put_memory_types);
 
+/*
+ * This is invoked via `late_initcall()` to initialize memory tiers for
+ * CPU-less memory nodes after driver initialization, which is
+ * expected to provide `adistance` algorithms.
+ */
+static int __init memory_tier_late_init(void)
+{
+	int nid;
+
+	mutex_lock(&memory_tier_lock);
+	for_each_node_state(nid, N_MEMORY)
+		if (!node_state(nid, N_CPU) &&
+			node_memory_types[nid].memtype == NULL)
+			/*
+			 * Some device drivers may have initialized memory tiers
+			 * between `memory_tier_init()` and `memory_tier_late_init()`,
+			 * potentially bringing online memory nodes and
+			 * configuring memory tiers. Exclude them here.
+			 */
+			set_node_memory_tier(nid);
+
+	establish_demotion_targets();
+	mutex_unlock(&memory_tier_lock);
+
+	return 0;
+}
+late_initcall(memory_tier_late_init);
+
 static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
 {
 	pr_info(
@@ -668,7 +713,6 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 {
 	int rc = 0;
 
-	mutex_lock(&memory_tier_lock);
 	if (default_dram_perf_error) {
 		rc = -EIO;
 		goto out;
@@ -680,6 +724,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 		goto out;
 	}
 
+	mutex_lock(&default_dram_perf_lock);
 	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
 		default_dram_perf = *perf;
 		default_dram_perf_ref_nid = nid;
@@ -716,23 +761,26 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 	}
 
 out:
-	mutex_unlock(&memory_tier_lock);
+	mutex_unlock(&default_dram_perf_lock);
 	return rc;
 }
 
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 {
+	int rc = 0;
+
 	if (default_dram_perf_error)
 		return -EIO;
 
-	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
-		return -ENOENT;
-
 	if (perf->read_latency + perf->write_latency == 0 ||
 	    perf->read_bandwidth + perf->write_bandwidth == 0)
 		return -EINVAL;
 
-	mutex_lock(&memory_tier_lock);
+	mutex_lock(&default_dram_perf_lock);
+	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
+		rc = -ENOENT;
+		goto out;
+	}
 	/*
 	 * The abstract distance of a memory node is in direct proportion to
 	 * its memory latency (read + write) and inversely proportional to its
@@ -745,8 +793,10 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
 		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
 		(perf->read_bandwidth + perf->write_bandwidth);
-	mutex_unlock(&memory_tier_lock);
+	mutex_unlock(&default_dram_perf_lock);
 
+out:
+	mutex_unlock(&default_dram_perf_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt_perf_to_adistance);
@@ -858,7 +908,8 @@ static int __init memory_tier_init(void)
 	 * For now we can have 4 faster memory tiers with smaller adistance
 	 * than default DRAM tier.
 	 */
-	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
+	default_dram_type = mt_find_alloc_memory_type(MEMTIER_ADISTANCE_DRAM,
+									&default_memory_types);
 	if (IS_ERR(default_dram_type))
 		panic("%s() failed to allocate default DRAM tier\n", __func__);
 
@@ -868,6 +919,14 @@ static int __init memory_tier_init(void)
 	 * types assigned.
 	 */
 	for_each_node_state(node, N_MEMORY) {
+		if (!node_state(node, N_CPU))
+			/*
+			 * Defer memory tier initialization on CPUless numa nodes.
+			 * These will be initialized after firmware and devices are
+			 * initialized.
+			 */
+			continue;
+
 		memtier = set_node_memory_tier(node);
 		if (IS_ERR(memtier))
 			/*
-- 
Ho-Ren (Jack) Chuang


