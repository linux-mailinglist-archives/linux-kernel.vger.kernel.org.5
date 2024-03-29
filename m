Return-Path: <linux-kernel+bounces-123926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FCD890FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DA41C24D78
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9C4182A1;
	Fri, 29 Mar 2024 00:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DxBzMa05"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303EC101EC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711673304; cv=none; b=G0hPniJyGJpUQPRmLo65RPOe3Rpd6I5zt8bcHnsDUl9zLWjGLYrENdT9EdFiOsbZJcKO42IPfRB4TzAtnTrysLqL69UFU1KkZlwMxIixuPQ3Bj9BFt9xrKFFQdxSCdHGG8yRMovGe0kCuQo4pPKcatgt7xAxV3G94x27cS1UcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711673304; c=relaxed/simple;
	bh=R1aGNSWaxFJ6PQ7czaGx4Y5ImI03arpaYhlgc9KIDzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GcMSfCVJjuXCZ0pTK1+3y4MhIuoh/EbjhKocLO/JXfPXBB7fI2FUY3ukFljQgZf0PzY+XF7P2penHMIW2OqtbsZIShCuFE9/Uq4YLGAhcXMnhgr1sWfA9Veu/qSvuot+2wvuPiLgOajDytSCrl/d6oqxRhVx4ReODVJtNmKopr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DxBzMa05; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430c63d4da9so9471401cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711673301; x=1712278101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xgOS8isMxKHzHyotyIcBuD4wYWux/bS/U8DbDxoJU0=;
        b=DxBzMa05gFAMPjuOG7lmQipmBGksU9IgSEhTCVGBtPkpGeoz/SxWHXDQPqvQWnMMSa
         U5R9GMofIiSVUgS7nDl7QX6r258mWwAbA0tMhGU4rO+rf42+bX3tgQuNPJ1niASY5Sjp
         9p954VmRrtk/YFU0Y3b9Kb4hcnHL3SMlajP2enVn3PvJ+wwxxaf8B61oKeJmj9njtum9
         K2HNYgSn0yJ3zoqJG/On9opSW6N9YSKxcxyqb/4jcwVLYdH4kzWUHI26+D2ehUjFyWRZ
         TkuNM5Gfj3IS6ay9ZlToGg3uFnValmF5Jefn+zqa/gz1EMmsMDnd9FZCyXRd+ByAiybm
         duSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711673301; x=1712278101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xgOS8isMxKHzHyotyIcBuD4wYWux/bS/U8DbDxoJU0=;
        b=Yb0m4EL2Sb+UYq9kmwhg2tjqlKqUKbQGcwzCIiUP36F/z1uXUvQVPGEKS9m7796Vmi
         n+QYJzFHHzPDCIc9Tv7PNRTMyiqLF/r93ozSl0FTv/FSvp7DJO2e2UiwOtaWWqsIu2bm
         3zgyYan7D9S7phztLvTZpT/6zOhayGoPpTrmtJjOXi1E98m6kDUq8sNerdWx9O86xRnD
         0By4yM7wzYVePFXZu8p/usTD3kT0nnpd/iMG+8opJjKipQiyaeeR7tLpNnnRmT+nf1ms
         yWQI801tXsG0eLiNKGe/Qv8SlJ9FQTUoCuFh5qE6YpmaYJ7NurFJdZ3dURCIrkA7uR0J
         okrw==
X-Forwarded-Encrypted: i=1; AJvYcCXLmKIXztouT+ePdIM48yTs2x2AmKHbXgns4SYyltNEDYAX1IxVhM7vgL9urfyiuhtpoVQH4hctHWrCfAIg18RoRv6LD/YWKslX20P+
X-Gm-Message-State: AOJu0Yyi86deL26ed7M/EaB54F2fzFBNfd0nNnTf7xrAH5upshbVhG+N
	6HBLVXg5a9xLeRjNDMbKWJnuXNTvJML+gUw4xFCjuHQYyoyAleNniuC2A6HqeGs=
X-Google-Smtp-Source: AGHT+IGRQkIbG4fv+uoIg3/nxd1eFfIFzArVzfxtSMxfeYkTUQ5hMztZBEvA8x2mPlQTJlfj6KU89Q==
X-Received: by 2002:a05:622a:1492:b0:432:b84b:ac1 with SMTP id t18-20020a05622a149200b00432b84b0ac1mr1357113qtx.19.1711673301149;
        Thu, 28 Mar 2024 17:48:21 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.125])
        by smtp.gmail.com with ESMTPSA id v26-20020ac8749a000000b00430afbb6b50sm1102414qtq.51.2024.03.28.17.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 17:48:20 -0700 (PDT)
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
Subject: [PATCH v8 2/2] memory tier: create CPUless memory tiers after obtaining HMAT info
Date: Fri, 29 Mar 2024 00:48:14 +0000
Message-Id: <20240329004815.195476-3-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240329004815.195476-1-horenchuang@bytedance.com>
References: <20240329004815.195476-1-horenchuang@bytedance.com>
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
but also prevents holding a large lock simultaneously.

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

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/memory-tiers.c | 94 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 16 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 974af10cfdd8..e24fc3bebae4 100644
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
+
+	__init_node_memory_type(node, mtype);
 
-	memtype = node_memory_types[node].memtype;
-	node_set(node, memtype->nodes);
-	memtier = find_create_memory_tier(memtype);
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
@@ -668,7 +713,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 {
 	int rc = 0;
 
-	mutex_lock(&memory_tier_lock);
+	mutex_lock(&default_dram_perf_lock);
 	if (default_dram_perf_error) {
 		rc = -EIO;
 		goto out;
@@ -716,23 +761,30 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 	}
 
 out:
-	mutex_unlock(&memory_tier_lock);
+	mutex_unlock(&default_dram_perf_lock);
 	return rc;
 }
 
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 {
-	if (default_dram_perf_error)
-		return -EIO;
+	int rc = 0;
 
-	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
-		return -ENOENT;
+	mutex_lock(&default_dram_perf_lock);
+	if (default_dram_perf_error) {
+		rc = -EIO;
+		goto out;
+	}
 
 	if (perf->read_latency + perf->write_latency == 0 ||
-	    perf->read_bandwidth + perf->write_bandwidth == 0)
-		return -EINVAL;
+	    perf->read_bandwidth + perf->write_bandwidth == 0) {
+		rc = -EINVAL;
+		goto out;
+	}
 
-	mutex_lock(&memory_tier_lock);
+	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
+		rc = -ENOENT;
+		goto out;
+	}
 	/*
 	 * The abstract distance of a memory node is in direct proportion to
 	 * its memory latency (read + write) and inversely proportional to its
@@ -745,8 +797,9 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
 		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
 		(perf->read_bandwidth + perf->write_bandwidth);
-	mutex_unlock(&memory_tier_lock);
 
+out:
+	mutex_unlock(&default_dram_perf_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt_perf_to_adistance);
@@ -858,7 +911,8 @@ static int __init memory_tier_init(void)
 	 * For now we can have 4 faster memory tiers with smaller adistance
 	 * than default DRAM tier.
 	 */
-	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
+	default_dram_type = mt_find_alloc_memory_type(MEMTIER_ADISTANCE_DRAM,
+									&default_memory_types);
 	if (IS_ERR(default_dram_type))
 		panic("%s() failed to allocate default DRAM tier\n", __func__);
 
@@ -868,6 +922,14 @@ static int __init memory_tier_init(void)
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


