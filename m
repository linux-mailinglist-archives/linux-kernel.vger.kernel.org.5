Return-Path: <linux-kernel+bounces-132282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C8189926E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F192884C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CB063D0;
	Fri,  5 Apr 2024 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Hs4TODHt"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7674210D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275635; cv=none; b=FVbSSeMBd9QUs3cwd7wNohdelKm6/DcqCe8nsslaZt1ICyI8IyQfPMmHD0BwrZygFz6J/heBSEYuwl9Qs2oTvss4xlz3xmNlsJfq9u/eFv3euP5C5uW3KzjrgUckE58D5vqLbBECZo6s1Jp3DbpAK1HYszuEK7OCkHcdqMEhWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275635; c=relaxed/simple;
	bh=sAMoGf8sUkm3g5lxHoJVpc49UGRBx6rQitULdlw3jOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=joqh3vtaSUjk1T0xfCU+s6bkw6qKmu3DbTzgPquixXqvLJR/Ld1WhXmQYOC0ZRNX9+ofYLTz2wjhy0uPXkAI+k6+DecsB+PHaIaxjhmoG0YPu7f8hkbZLv4wjvzc9Z4+kyjiwSxx+c+XgmNdb9SSp/reW+hEGdvYnB2KWVcJQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Hs4TODHt; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78a5580324eso90883485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712275633; x=1712880433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQdaNIkqtZaYcZaz2No7Lv3UsoB6KJKx8p/n/NpKY8s=;
        b=Hs4TODHtd0LYQUVv68Bsa4C6OvPVqZa4JwP+HwIo9QxqSi436bYd754aiRtPMZdDcX
         18c7EnrmDIR+UlobU5IJi3jvMAugJ9QLvezE4uczikVuzEsS49z9+ylExFdXYVE1679b
         m3wxrQJRnnNocyPKyMPtrxniUSFzQJOs2Ol5+c8w8rkzjciCfUgxx18tSoLL/psw5HcF
         lEF5qWOfc7tqgQFdTjcrosHoHFR8US1KtV7TCqg/TXtPbHlUl6o/Tnq422KLvUQg4sTz
         CKZgfT3GUEq/K+sa+vZlDqLnoh4thDAN63zxQq8qHt/QRpAAGnFoM2mIC3CGHJYezz/J
         wikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712275633; x=1712880433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQdaNIkqtZaYcZaz2No7Lv3UsoB6KJKx8p/n/NpKY8s=;
        b=KUaif4PuBT/itCKzzyOrbIr5CiSOL7drm8f7lAR2stjvzjrsjuLYYtJEIdL/KW6Pl5
         i0A67BOPiYTAWdk2QYHM5JxD8tl7mBaDljWGPNvq0U57xsdvzyb2xnF0kK9IhLc/kDOm
         1ip892msGOZvyPvbUI0UEjOIdDjXFc+2qgdQTEcWakQ6EKefK4Sscu4nWRvN7/dVbyG1
         dOxYrfZKVCnCOOJsq7BxwgpISVMEPz1EoGweUzQmTKAjPV/APjnSUiokCrYcKZTMBE2u
         XLDmLzDg88ljD5QWQ8Z0GNAvoL/O9Ex/vDrdLJP8JTgXaDaf68G53yOLbC+1L1TnfGLB
         eRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI7/k2v4nw8v5Qv3/GceMWpkUl5G+154iZk+nJmMw3Si+o5lnzyZyApeedlbMLZBO2spLEJm2ybc+0F0X9znDbtdUY2cVqqdZkbGR0
X-Gm-Message-State: AOJu0YxY52sqLKBPP7CRuNXSHTLqSbVB/5687kXGht5fGl9TgP8FEvMG
	n0ffexDQ/wwGcwuvZL0KyXQJ+c3c5ktN28PHu3Qaa0L994Mim9pEBynqyS6gMcc=
X-Google-Smtp-Source: AGHT+IHaVrcMfgZoSTOIj9tov+jFGpMHgFpeZLuchTMnvsxDYr39S3klFlyhMYGWZAw/tV8qmXpn0w==
X-Received: by 2002:a05:620a:c84:b0:78a:5dac:3e59 with SMTP id q4-20020a05620a0c8400b0078a5dac3e59mr3411783qki.76.1712275632825;
        Thu, 04 Apr 2024 17:07:12 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.118])
        by smtp.gmail.com with ESMTPSA id d4-20020a37c404000000b0078835bfddb8sm191433qki.84.2024.04.04.17.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:07:12 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
	"Huang, Ying" <ying.huang@intel.com>,
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
	"SeongJae Park" <sj@kernel.org>,
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
Subject: [PATCH v11 2/2] memory tier: create CPUless memory tiers after obtaining HMAT info
Date: Fri,  5 Apr 2024 00:07:06 +0000
Message-Id: <20240405000707.2670063-3-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240405000707.2670063-1-horenchuang@bytedance.com>
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
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
 mm/memory-tiers.c | 94 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 24 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 516b144fd45a..6632102bd5c9 100644
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
+	struct memory_dev_type *memtype = default_dram_type;
+	int adist = MEMTIER_ADISTANCE_DRAM;
 	pg_data_t *pgdat = NODE_DATA(node);
 
 
@@ -514,7 +522,16 @@ static struct memory_tier *set_node_memory_tier(int node)
 	if (!node_state(node, N_MEMORY))
 		return ERR_PTR(-EINVAL);
 
-	__init_node_memory_type(node, default_dram_type);
+	mt_calc_adistance(node, &adist);
+	if (!node_memory_types[node].memtype) {
+		memtype = mt_find_alloc_memory_type(adist, &default_memory_types);
+		if (IS_ERR(memtype)) {
+			memtype = default_dram_type;
+			pr_info("Failed to allocate a memory type. Fall back.\n");
+		}
+	}
+
+	__init_node_memory_type(node, memtype);
 
 	memtype = node_memory_types[node].memtype;
 	node_set(node, memtype->nodes);
@@ -652,6 +669,35 @@ void mt_put_memory_types(struct list_head *memory_types)
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
+	guard(mutex)(&memory_tier_lock);
+	for_each_node_state(nid, N_MEMORY) {
+		/*
+		 * Some device drivers may have initialized memory tiers
+		 * between `memory_tier_init()` and `memory_tier_late_init()`,
+		 * potentially bringing online memory nodes and
+		 * configuring memory tiers. Exclude them here.
+		 */
+		if (node_memory_types[nid].memtype)
+			continue;
+
+		set_node_memory_tier(nid);
+	}
+
+	establish_demotion_targets();
+
+	return 0;
+}
+late_initcall(memory_tier_late_init);
+
 static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
 {
 	pr_info(
@@ -663,25 +709,19 @@ static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
 int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 			     const char *source)
 {
-	int rc = 0;
-
-	mutex_lock(&memory_tier_lock);
-	if (default_dram_perf_error) {
-		rc = -EIO;
-		goto out;
-	}
+	guard(mutex)(&default_dram_perf_lock);
+	if (default_dram_perf_error)
+		return -EIO;
 
 	if (perf->read_latency + perf->write_latency == 0 ||
-	    perf->read_bandwidth + perf->write_bandwidth == 0) {
-		rc = -EINVAL;
-		goto out;
-	}
+	    perf->read_bandwidth + perf->write_bandwidth == 0)
+		return -EINVAL;
 
 	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
 		default_dram_perf = *perf;
 		default_dram_perf_ref_nid = nid;
 		default_dram_perf_ref_source = kstrdup(source, GFP_KERNEL);
-		goto out;
+		return 0;
 	}
 
 	/*
@@ -709,27 +749,25 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 		pr_info(
 "  disable default DRAM node performance based abstract distance algorithm.\n");
 		default_dram_perf_error = true;
-		rc = -EINVAL;
+		return -EINVAL;
 	}
 
-out:
-	mutex_unlock(&memory_tier_lock);
-	return rc;
+	return 0;
 }
 
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 {
+	guard(mutex)(&default_dram_perf_lock);
 	if (default_dram_perf_error)
 		return -EIO;
 
-	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
-		return -ENOENT;
-
 	if (perf->read_latency + perf->write_latency == 0 ||
 	    perf->read_bandwidth + perf->write_bandwidth == 0)
 		return -EINVAL;
 
-	mutex_lock(&memory_tier_lock);
+	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
+		return -ENOENT;
+
 	/*
 	 * The abstract distance of a memory node is in direct proportion to
 	 * its memory latency (read + write) and inversely proportional to its
@@ -742,7 +780,6 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
 		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
 		(perf->read_bandwidth + perf->write_bandwidth);
-	mutex_unlock(&memory_tier_lock);
 
 	return 0;
 }
@@ -855,7 +892,8 @@ static int __init memory_tier_init(void)
 	 * For now we can have 4 faster memory tiers with smaller adistance
 	 * than default DRAM tier.
 	 */
-	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
+	default_dram_type = mt_find_alloc_memory_type(MEMTIER_ADISTANCE_DRAM,
+						      &default_memory_types);
 	if (IS_ERR(default_dram_type))
 		panic("%s() failed to allocate default DRAM tier\n", __func__);
 
@@ -865,6 +903,14 @@ static int __init memory_tier_init(void)
 	 * types assigned.
 	 */
 	for_each_node_state(node, N_MEMORY) {
+		if (!node_state(node, N_CPU))
+			/*
+			 * Defer memory tier initialization on
+			 * CPUless numa nodes. These will be initialized
+			 * after firmware and devices are initialized.
+			 */
+			continue;
+
 		memtier = set_node_memory_tier(node);
 		if (IS_ERR(memtier))
 			/*
-- 
Ho-Ren (Jack) Chuang


