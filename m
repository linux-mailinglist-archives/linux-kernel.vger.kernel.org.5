Return-Path: <linux-kernel+bounces-88070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C92F86DCFD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED4F28A87B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4244469E00;
	Fri,  1 Mar 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PdpixPhM"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C267E6C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281446; cv=none; b=M1Rt+lJ8g76aKdZAyIuZcqBkyW75E91sowOJTUO4n4UNqME2MZEAnVxcO1Rspg6Lx3O1WQhYqcGoqszyIEJZFjyHIZo1BIM9cYSj/d3t5gCJ0ZJCwg4gnWNETbR99iLRZJuGxIAXEJB+Hc/JBvCRGchGZ38Q4W7jRDlRDzX4ARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281446; c=relaxed/simple;
	bh=UataCGYo3G62/ULCC+IEnJOgFpYUGdT+U0HsTd/TvSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ty4jBvZrnkWuO8/D7W/t6QN27tHg5G3ynp9AiDK00X9eJ7E9/VJoY0Vb8Tg6+p9szABKUVHQxbt5ZTgb3zcXdh+J2zmY1Pfq97hDwKIR1FuqPs14ajSkvrVVbOMGUKxfSgSaqtePe6IlTuSvOgQaXFHUmy6rWoigzDTAgrBaKmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PdpixPhM; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-690105304b4so8935016d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 00:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709281443; x=1709886243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6TShqh1i4+cFFfpKPT0xQIuYg06VEOVkdOiTtXAx9c=;
        b=PdpixPhMruAZAgHSjapjfKrqUVtgPikqaCmlnA2+G9Gh6OO2Od9R0lxRCKwC+C0dTZ
         v7ENMlrcDkQAyiQMCGZ1kP8Zn2QFq+Mzj+CGscteFPYjBRfJZ60R1NOwhzPtq/cUhv8D
         y0vwM5WFRJBx1Ghx4YnBKjLIYUbkLxp+5qz9mP1mVkU/5WtcsC691Xcbi2POhDJikAQ0
         nPrJeQuZGbkPu5+FBy0ldxzq3s65WYgg6ZEEB35dCuS1ub7VDebOdNuYtFR6wQLgAjfL
         18flJtnCsuLjVg94aSWEOpzkocmcilK2Dm7hTq9OoYuO0U8bV9chtFonp47XvEXronQA
         0rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709281443; x=1709886243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6TShqh1i4+cFFfpKPT0xQIuYg06VEOVkdOiTtXAx9c=;
        b=f6zPiB2WH+3fHIdllCfl+GJjFk8Hj/j3+7hO0AUc34+X/wMaRRmabwhaWFWICYqxxM
         OM0ZObhlNAe8dOO0piRcD55hSg/pb6dKrerxdsZY7pjm4ce8pwDtwe00HdVgqjtZtxVR
         FqNdjqTtZi6ceJ00I+6TVfy8p+EedA8G7iDGpA7yOsozMfIOtN/T3ZZJQi7qq6rBCUVa
         cJseQvtHnRxEmS/0BpMjp3jeuqW95UV4E0H0nnIMlthManZ/JHS1niOK2AWdPkSWFXxn
         wmvEmaH/Nn9BhwEEo26XWdI9stZlxVgMuxcd1IATtEyqc2/wqmIDXiMLynlruU0uzmJd
         9vsA==
X-Forwarded-Encrypted: i=1; AJvYcCXXQJ8wBB4XAKoEZ8R/1rKSIdZgSbgxGoxQWAniw9tt0vjmkbhy73RGEX9327laqaLrir3Mr/NtEkQbNglTVoqNv4PkJbT3skd9x3u0
X-Gm-Message-State: AOJu0YxAmJ/JUy1AEz6Yyyao6iBiZYClkWUSV32+Q2vYSjtWoQLSxO9c
	Yclc310BtdcaNWoOksqbhvnB8O/8fSUNiqecfwAVf8Uio4n4hLtEi4iiVjA08T4=
X-Google-Smtp-Source: AGHT+IFOE//de5gW8/t5EN6iDGtxoPupJsqmHB+gIs7CE75HdwkbfH6RIWi1eK5iB+kKO7THZmG8hQ==
X-Received: by 2002:a05:6214:42:b0:68f:280f:14cc with SMTP id c2-20020a056214004200b0068f280f14ccmr982605qvr.35.1709281443055;
        Fri, 01 Mar 2024 00:24:03 -0800 (PST)
Received: from n231-228-171.byted.org ([130.44.215.123])
        by smtp.gmail.com with ESMTPSA id y19-20020a0cd993000000b0068fc392f526sm1631907qvj.127.2024.03.01.00.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 00:24:02 -0800 (PST)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Hao Xiang" <hao.xiang@bytedance.com>,
	"Gregory Price" <gourry.memverge@gmail.com>,
	aneesh.kumar@linux.ibm.com,
	mhocko@suse.com,
	tj@kernel.org,
	john@jagalactic.com,
	"Eishan Mirakhur" <emirakhur@micron.com>,
	"Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
	"Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
	"Alistair Popple" <apopple@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huang Ying <ying.huang@intel.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v1 1/1] memory tier: acpi/hmat: create CPUless memory tiers after obtaining HMAT info
Date: Fri,  1 Mar 2024 08:22:45 +0000
Message-Id: <20240301082248.3456086-2-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240301082248.3456086-1-horenchuang@bytedance.com>
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Introduce `mt_init_with_hmat()`
We defer memory tier initialization for those CPUless NUMA nodes
until acquiring HMAT info. `mt_init_with_hmat()` is introduced to
post-create CPUless memory tiers after obtaining HMAT info.
It iterates through each CPUless memory node, creating memory tiers if
necessary. Finally, it calculates demotion tables again at the end.

* Introduce `hmat_find_alloc_memory_type()`
Find or allocate a memory type in the `hmat_memory_types` list.

* Make `set_node_memory_tier()` more generic
This function can also be used for setting other memory types for a node.
To do so, a new argument is added to specify a memory type.

* Handle cases where there is no HMAT when creating memory tiers
If no HMAT is specified, it falls back to using `default_dram_type`.

* Change adist calculation code to use another new lock, mt_perf_lock.
Iterating through CPUlist nodes requires holding the `memory_tier_lock`.
However, `mt_calc_adistance()` will end up trying to acquire the same lock,
leading to a potential deadlock. Therefore, we propose introducing a
standalone `mt_perf_lock` to protect `default_dram_perf`. This approach not
only avoids deadlock but also prevents holding a large lock simultaneously.

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 drivers/acpi/numa/hmat.c     |  3 ++
 include/linux/memory-tiers.h |  6 +++
 mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
 3 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index d6b85f0f6082..9f57338b3cb5 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -1038,6 +1038,9 @@ static __init int hmat_init(void)
 	if (!hmat_set_default_dram_perf())
 		register_mt_adistance_algorithm(&hmat_adist_nb);
 
+	/* Post-create CPUless memory tiers after getting HMAT info */
+	mt_init_with_hmat();
+
 	return 0;
 out_put:
 	hmat_free_structures();
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 69e781900082..2f845e90c033 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -48,6 +48,7 @@ int mt_calc_adistance(int node, int *adist);
 int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 			     const char *source);
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
+void mt_init_with_hmat(void);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -136,5 +137,10 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
 {
 	return -EIO;
 }
+
+static inline void mt_init_with_hmat(void)
+{
+
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0537664620e5..7a0a579b3deb 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -35,7 +35,9 @@ struct node_memory_type_map {
 };
 
 static DEFINE_MUTEX(memory_tier_lock);
+static DEFINE_MUTEX(mt_perf_lock);
 static LIST_HEAD(memory_tiers);
+static LIST_HEAD(hmat_memory_types);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 struct memory_dev_type *default_dram_type;
 
@@ -502,7 +504,7 @@ static inline void __init_node_memory_type(int node, struct memory_dev_type *mem
 	}
 }
 
-static struct memory_tier *set_node_memory_tier(int node)
+static struct memory_tier *set_node_memory_tier(int node, struct memory_dev_type *new_memtype)
 {
 	struct memory_tier *memtier;
 	struct memory_dev_type *memtype;
@@ -514,7 +516,7 @@ static struct memory_tier *set_node_memory_tier(int node)
 	if (!node_state(node, N_MEMORY))
 		return ERR_PTR(-EINVAL);
 
-	__init_node_memory_type(node, default_dram_type);
+	__init_node_memory_type(node, new_memtype);
 
 	memtype = node_memory_types[node].memtype;
 	node_set(node, memtype->nodes);
@@ -623,6 +625,56 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 }
 EXPORT_SYMBOL_GPL(clear_node_memory_type);
 
+static struct memory_dev_type *hmat_find_alloc_memory_type(int adist)
+{
+	bool found = false;
+	struct memory_dev_type *mtype;
+
+	list_for_each_entry(mtype, &hmat_memory_types, list) {
+		if (mtype->adistance == adist) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		mtype = alloc_memory_type(adist);
+		if (!IS_ERR(mtype))
+			list_add(&mtype->list, &hmat_memory_types);
+	}
+	return mtype;
+}
+
+static void mt_create_with_hmat(int node)
+{
+	struct memory_dev_type *mtype = NULL;
+	int adist = MEMTIER_ADISTANCE_DRAM;
+
+	mt_calc_adistance(node, &adist);
+	if (adist != MEMTIER_ADISTANCE_DRAM) {
+		mtype = hmat_find_alloc_memory_type(adist);
+		if (IS_ERR(mtype))
+			pr_err("%s() failed to allocate a tier\n", __func__);
+	} else {
+		mtype = default_dram_type;
+	}
+
+	set_node_memory_tier(node, mtype);
+}
+
+void mt_init_with_hmat(void)
+{
+	int nid;
+
+	mutex_lock(&memory_tier_lock);
+	for_each_node_state(nid, N_MEMORY)
+		if (!node_state(nid, N_CPU))
+			mt_create_with_hmat(nid);
+
+	establish_demotion_targets();
+	mutex_unlock(&memory_tier_lock);
+}
+EXPORT_SYMBOL_GPL(mt_init_with_hmat);
+
 static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
 {
 	pr_info(
@@ -636,7 +688,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 {
 	int rc = 0;
 
-	mutex_lock(&memory_tier_lock);
+	mutex_lock(&mt_perf_lock);
 	if (default_dram_perf_error) {
 		rc = -EIO;
 		goto out;
@@ -684,7 +736,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 	}
 
 out:
-	mutex_unlock(&memory_tier_lock);
+	mutex_unlock(&mt_perf_lock);
 	return rc;
 }
 
@@ -700,7 +752,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 	    perf->read_bandwidth + perf->write_bandwidth == 0)
 		return -EINVAL;
 
-	mutex_lock(&memory_tier_lock);
+	mutex_lock(&mt_perf_lock);
 	/*
 	 * The abstract distance of a memory node is in direct proportion to
 	 * its memory latency (read + write) and inversely proportional to its
@@ -713,7 +765,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
 		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
 		(perf->read_bandwidth + perf->write_bandwidth);
-	mutex_unlock(&memory_tier_lock);
+	mutex_unlock(&mt_perf_lock);
 
 	return 0;
 }
@@ -797,7 +849,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 		break;
 	case MEM_ONLINE:
 		mutex_lock(&memory_tier_lock);
-		memtier = set_node_memory_tier(arg->status_change_nid);
+		memtier = set_node_memory_tier(arg->status_change_nid, default_dram_type);
 		if (!IS_ERR(memtier))
 			establish_demotion_targets();
 		mutex_unlock(&memory_tier_lock);
@@ -836,7 +888,15 @@ static int __init memory_tier_init(void)
 	 * types assigned.
 	 */
 	for_each_node_state(node, N_MEMORY) {
-		memtier = set_node_memory_tier(node);
+		if (!node_state(node, N_CPU))
+			/*
+			 * Defer memory tier initialization on CPUless numa nodes.
+			 * These will be initialized when HMAT information is
+			 * available.
+			 */
+			continue;
+
+		memtier = set_node_memory_tier(node, default_dram_type);
 		if (IS_ERR(memtier))
 			/*
 			 * Continue with memtiers we are able to setup
-- 
Hao Xiang and Ho-Ren (Jack) Chuang


