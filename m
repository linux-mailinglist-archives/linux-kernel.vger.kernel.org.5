Return-Path: <linux-kernel+bounces-73676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD9285C5BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11CE1C22BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F2214C5A9;
	Tue, 20 Feb 2024 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCW97FD4"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BA914AD30
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460739; cv=none; b=dPcGHHa3PfY4mGjKQ8rhSTDpP6P288C/zGazArq3h4lK6He9UBrW+8I5R6jnEd5sRfYIU0kMK4pkKVdGlCo7LyVHKC3sdOKcg9z0eag1ZxKSxJkLCrhOj2jlaQzIE03kxNYH5yb1xpbeOJHjvJ9Rxklfsb9GxUvoIfIxd6uMTG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460739; c=relaxed/simple;
	bh=xXscJzLuofLsErQ12WqLPIQ0oQ+LmPxgWF+KcXzMm+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sOMilL8z2bd9Bi9iv0sZx40r/VAdk9+MXmK3PK8MGxPqXlvqnINx6KhgHUyP+KWh53DmbHP2yP4rxkN3VtLPvTKlMeRIok1o430Hsbyx8LkH+TIzja9ZSYZaczK12+Bs6tIIwTouK8X5VGo2eSJqOCx8SkzEa/hRnAoCfV+tE0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCW97FD4; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1dc1ff697f9so6516555ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708460737; x=1709065537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBnklkS7WMFU168TcI+v2P140FGO/f8vdLXL7Ok+vL4=;
        b=fCW97FD4yu0udtb5AbnrJN47SKClRpOVbgYTqOeIGEVoL5HrOHyt4D+EwLtpRw3MiN
         LCEI33+xfJGoNq+0pTEzuuZJxDY70W4sH/wwq/YOvj8NVJfrjmKrvYGM95Uaa4A+2kBT
         uu5jU1E2pboHXl51UsEXZ4WDshDnYHaluGVAN4pIbIL7UDcuT1o3K1rWQPp1GOSH7mPJ
         5kmX9mzHhxTedLDKN6dFihK2zc3vSsiNMXYdf+c/kYC2D9D4kVs+yNpIzhWTqcYAx1Tl
         gxtG4Y9zZyn05dGLpOcZMp5iydqu3j/pYzm7m7JLFhKUptNegd/v8ROgVGcnYYXVmRqp
         5UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460737; x=1709065537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBnklkS7WMFU168TcI+v2P140FGO/f8vdLXL7Ok+vL4=;
        b=Lxtq2NLtW93qliOwazEdJwPgqWemhGrWA7athqNzRVZBBL6MWQGDCoQFhbxhY89yJd
         WMn2PrzIUKqOi4k1W4tjMN3rQkhHCC2gyK6wUGqglgoIxapbmJNz3gtgwaTIDZ9hasBZ
         0pk5OCMXX882fGtCO+N5xQrwBZ5YZnWzC239SbpF+OvkzkcQNidrCnYl03yYqeLIIDF4
         bwk9PZNlTddX0AqMhX3s56jYYEZBd6iyrXIWpQmaExel6upRt8I/AuQL3WYn7TeGPAWY
         Y2l2uQSF10IExJ/6T7XS8KYDnHI2HHOtJT6AmkPRKz9Yf+NrHEM0Ho15tjn5U7LhrFHT
         pLbw==
X-Gm-Message-State: AOJu0YzVh3Ddh34s6GvTImRMC7DVVephpTmhE3urbvKxw598Aq9dc2Pj
	Nh+WamO26BfO51sfh1bOE/XgcaReancxM+L5EE8nFLT+eLOL0QLVxh8rEfYiXOWr
X-Google-Smtp-Source: AGHT+IHkA4V6qwKf4cOC/uOz/uS+q2KycSuLitxGvr0jW9ZC5rlBdfn8y7exgV7lyAyk5hf55NW/PA==
X-Received: by 2002:a17:902:eb8c:b0:1db:e245:8c35 with SMTP id q12-20020a170902eb8c00b001dbe2458c35mr6191582plg.30.1708460736845;
        Tue, 20 Feb 2024 12:25:36 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id je13-20020a170903264d00b001db40c0ed33sm6696678plb.61.2024.02.20.12.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 12:25:36 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	ying.huang@intel.com,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC 1/1] mm/mempolicy: introduce system default interleave weights
Date: Tue, 20 Feb 2024 15:25:29 -0500
Message-Id: <20240220202529.2365-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240220202529.2365-1-gregory.price@memverge.com>
References: <20240220202529.2365-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Startup and hotplug code may register HMAT data for memory
devices. Utilize this data to generate reasonable default
weighted interleave values.

Introduce `mempolicy_set_node_perf()`. A function which can
be invoked from node and CXL code to have mempolicy rebalance
the system default interleave weights.

mempolicy_set_node_perf() cache's each node's bandwidth (in
this patch: min(read_bw, write_bw)), and recalculates the weight
associated with each node.  After weights are calculated, we use
gcd() to reduce these weights to the smallest amount possible in
and effort to more aggressively interleave on smaller intervals.

For example, a 1-socket system with a CXL memory expander which
exposes 224GB/s and 64GB/s of bandwidth respectively will end
up with a weight array of [7,2].

The downside of this approach is that some distributes may
experience large default values if they happen to a bandwidth
distribution that includes an unfortunate prime number, or if
any two values are co-prime.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 drivers/acpi/numa/hmat.c  |   1 +
 drivers/base/node.c       |   7 +++
 include/linux/mempolicy.h |   4 ++
 mm/mempolicy.c            | 129 ++++++++++++++++++++++++++++++--------
 4 files changed, 116 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index d6b85f0f6082..7935d387e001 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -20,6 +20,7 @@
 #include <linux/list_sort.h>
 #include <linux/memregion.h>
 #include <linux/memory.h>
+#include <linux/mempolicy.h>
 #include <linux/mutex.h>
 #include <linux/node.h>
 #include <linux/sysfs.h>
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 1c05640461dd..30458df504b4 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/memory.h>
+#include <linux/mempolicy.h>
 #include <linux/vmstat.h>
 #include <linux/notifier.h>
 #include <linux/node.h>
@@ -214,6 +215,12 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
 			break;
 		}
 	}
+
+	/* When setting CPU access coordinates, update mempolicy */
+	if (access == ACCESS_COORDINATE_CPU) {
+		if (mempolicy_set_node_perf(nid, coord))
+			pr_info("failed to set node%d mempolicy attrs\n", nid);
+	}
 }
 
 /**
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 931b118336f4..d564e9e893ea 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
+#include <linux/node.h>
 #include <linux/nodemask.h>
 #include <linux/pagemap.h>
 #include <uapi/linux/mempolicy.h>
@@ -177,6 +178,9 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 
 extern bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone);
 
+extern int mempolicy_set_node_perf(unsigned int node,
+				   struct access_coordinate *coords);
+
 #else
 
 struct mempolicy {};
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ba0b2b81bd08..0a82aa51e497 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -109,6 +109,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
 #include <linux/swapops.h>
+#include <linux/gcd.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
@@ -139,31 +140,114 @@ static struct mempolicy default_policy = {
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
 /*
- * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
- * system-default value should be used. A NULL iw_table also denotes that
- * system-default values should be used. Until the system-default table
- * is implemented, the system-default is always 1.
+ * The interleave weight tables denote what weights should be used with
+ * the weighted interleave policy.  There are two tables:
+ *    - iw_table : the sysfs-set interleave weight table
+ *    - default_iw_table : the system default interleave weight table.
  *
- * iw_table is RCU protected
+ * If the iw_table is NULL, default_iw_table values are used.
+ * If both tables are NULL, a minimum weight of 1 is always used.
+ * A value of 0 in the iw_table means the system default value will be used.
+ *
+ * iw_table, and default_iw_table are RCU protected
+ * node_bw_table is protected by default_iwt_lock
+ *
+ * system startup and hotplug code may register node performance information
+ * via mempolicy_set_node_attributes()
  */
+static unsigned long *node_bw_table;
+static u8 __rcu *default_iw_table;
+static DEFINE_MUTEX(default_iwt_lock);
+
 static u8 __rcu *iw_table;
 static DEFINE_MUTEX(iw_table_lock);
 
 static u8 get_il_weight(int node)
 {
-	u8 *table;
+	u8 *table, *default_table;
 	u8 weight;
 
 	rcu_read_lock();
 	table = rcu_dereference(iw_table);
-	/* if no iw_table, use system default */
-	weight = table ? table[node] : 1;
-	/* if value in iw_table is 0, use system default */
-	weight = weight ? weight : 1;
+	default_table = rcu_dereference(default_iw_table);
+	/* if no table pointers or value is 0, use system default or 1 */
+	weight = table ? table[node] : 0;
+	weight = weight ? weight : (default_table ? default_table[node] : 1);
 	rcu_read_unlock();
 	return weight;
 }
 
+int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
+{
+	unsigned long *old_bw, *new_bw;
+	unsigned long gcd_val;
+	u8 *old_iw, *new_iw;
+	uint64_t ttl_bw = 0;
+	int i;
+
+	new_bw = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
+	if (!new_bw)
+		return -ENOMEM;
+
+	new_iw = kzalloc(nr_node_ids, GFP_KERNEL);
+	if (!new_iw) {
+		kfree(new_bw);
+		return -ENOMEM;
+	}
+
+	mutex_lock(&default_iwt_lock);
+	old_bw = node_bw_table;
+	old_iw = rcu_dereference_protected(default_iw_table,
+					   lockdep_is_held(&default_iwt_lock));
+
+	if (old_bw)
+		memcpy(new_bw, old_bw, nr_node_ids*sizeof(unsigned long));
+	new_bw[node] = min(coords->read_bandwidth, coords->write_bandwidth);
+
+	/* New recalculate the bandwidth distribution given the new info */
+	for (i = 0; i < nr_node_ids; i++)
+		ttl_bw += new_bw[i];
+
+	/* If node is not set or has < 1% of total bw, use minimum value of 1 */
+	for (i = 0; i < nr_node_ids; i++) {
+		if (new_bw[i])
+			new_iw[i] = max((100 * new_bw[i] / ttl_bw), 1);
+		else
+			new_iw[i] = 1;
+	}
+	/*
+	 * Now attempt to aggressively reduce the interleave weights by GCD
+	 * We want smaller interleave intervals to have a better distribution
+	 * of memory, even on smaller memory regions. If weights are divisible
+	 * by each other, we can do some quick math to aggresively squash them.
+	 */
+reduce:
+	gcd_val = new_iw[i];
+	for (i = 0; i < nr_node_ids; i++) {
+		/* Skip nodes that haven't been set */
+		if (!new_bw[i])
+			continue;
+		gcd_val = gcd(gcd_val, new_iw[i]);
+		if (gcd_val == 1)
+			goto leave;
+	}
+	for (i = 0; i < nr_node_ids; i++) {
+		if (!new_bw[i])
+			continue;
+		new_iw[i] /= gcd_val;
+	}
+	/* repeat until we get a gcd of 1 */
+	goto reduce;
+leave:
+	node_bw_table = new_bw;
+	rcu_assign_pointer(default_iw_table, new_iw);
+	mutex_unlock(&default_iwt_lock);
+	synchronize_rcu();
+	kfree(old_bw);
+	kfree(old_iw);
+	return 0;
+}
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -1983,7 +2067,7 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 {
 	nodemask_t nodemask;
 	unsigned int target, nr_nodes;
-	u8 *table;
+	u8 *table, *default_table;
 	unsigned int weight_total = 0;
 	u8 weight;
 	int nid;
@@ -1994,11 +2078,13 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 
 	rcu_read_lock();
 	table = rcu_dereference(iw_table);
+	default_table = rcu_dereference(default_iw_table);
 	/* calculate the total weight */
 	for_each_node_mask(nid, nodemask) {
 		/* detect system default usage */
-		weight = table ? table[nid] : 1;
-		weight = weight ? weight : 1;
+		weight = table ? table[nid] : 0;
+		weight = weight ? weight :
+				  (default_table ? default_table[nid] : 1);
 		weight_total += weight;
 	}
 
@@ -2007,8 +2093,9 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 	nid = first_node(nodemask);
 	while (target) {
 		/* detect system default usage */
-		weight = table ? table[nid] : 1;
-		weight = weight ? weight : 1;
+		weight = table ? table[nid] : 0;
+		weight = weight ? weight :
+				  (default_table ? default_table[nid] : 1);
 		if (target < weight)
 			break;
 		target -= weight;
@@ -2391,7 +2478,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	unsigned long nr_allocated = 0;
 	unsigned long rounds;
 	unsigned long node_pages, delta;
-	u8 *table, *weights, weight;
+	u8 *weights, weight;
 	unsigned int weight_total = 0;
 	unsigned long rem_pages = nr_pages;
 	nodemask_t nodes;
@@ -2440,16 +2527,8 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	if (!weights)
 		return total_allocated;
 
-	rcu_read_lock();
-	table = rcu_dereference(iw_table);
-	if (table)
-		memcpy(weights, table, nr_node_ids);
-	rcu_read_unlock();
-
-	/* calculate total, detect system default usage */
 	for_each_node_mask(node, nodes) {
-		if (!weights[node])
-			weights[node] = 1;
+		weights[node] = get_il_weight(node);
 		weight_total += weights[node];
 	}
 
-- 
2.39.1


