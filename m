Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB7B7AE57A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjIZGHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjIZGHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:07:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59778F2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695708421; x=1727244421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/tnrd8Wcw8r5aEvovh7DYTLJfhjcN/4NzFCxtBHH1c=;
  b=ULrJNi8LBh+KWJBIBe+f+C/Vu66ZY65rznsBTXA9X9a/kly6Gyx4wBjM
   0pPuAnD66FIkZkyfMPsXD8/Z9OLky1DzOS//oYMjsAkkY/QLyrfCFTdAw
   SxOTn06kwGO5Xf6IH0EcIuo0pYR8Dxaogl6vXM2a+YXyfvjk2Ir1VT2bv
   cknJKRS84ZwpB1gcO1znhGM2Pzy+COn3ZlxVisIJMkl8KnOSmV6IFwaO6
   Aw62+ExroxbNJMtkos52tKFWaC7TD05ueoQhxM8o/myHeBXm6wrcsUuA9
   WuHPlwz3mknomf4Nz63hLAJVUufiHhhAl/2gzOeqX+nRKUD12rzVdfO/8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447990855"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="447990855"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="892074793"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="892074793"
Received: from aozhu-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.94])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:05:50 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
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
Subject: [PATCH -V4 3/4] acpi, hmat: calculate abstract distance with HMAT
Date:   Tue, 26 Sep 2023 14:06:27 +0800
Message-Id: <20230926060628.265989-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926060628.265989-1-ying.huang@intel.com>
References: <20230926060628.265989-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory tiering abstract distance calculation algorithm based on ACPI
HMAT is implemented.  The basic idea is as follows.

The performance attributes of system default DRAM nodes are recorded
as the base line.  Whose abstract distance is MEMTIER_ADISTANCE_DRAM.
Then, the ratio of the abstract distance of a memory node (target) to
MEMTIER_ADISTANCE_DRAM is scaled based on the ratio of the performance
attributes of the node to that of the default DRAM nodes.

The functions to record the read/write latency/bandwidth of the
default DRAM nodes and calculate abstract distance according to
read/write latency/bandwidth ratio will be used by CXL CDAT (Coherent
Device Attribute Table) and other memory device drivers.  So, they are
put in memory-tiers.c.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Tested-by: Bharata B Rao <bharata@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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
 drivers/acpi/numa/hmat.c     |  65 +++++++++++++++++++++-
 include/linux/memory-tiers.h |  18 ++++++
 mm/memory-tiers.c            | 103 ++++++++++++++++++++++++++++++++++-
 3 files changed, 183 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2dee0098f1a9..9ef5f1bdcfdb 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -24,6 +24,7 @@
 #include <linux/node.h>
 #include <linux/sysfs.h>
 #include <linux/dax.h>
+#include <linux/memory-tiers.h>
 
 static u8 hmat_revision;
 static int hmat_disable __initdata;
@@ -759,6 +760,61 @@ static int hmat_callback(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
+static int hmat_set_default_dram_perf(void)
+{
+	int rc;
+	int nid, pxm;
+	struct memory_target *target;
+	struct node_hmem_attrs *attrs;
+
+	if (!default_dram_type)
+		return -EIO;
+
+	for_each_node_mask(nid, default_dram_type->nodes) {
+		pxm = node_to_pxm(nid);
+		target = find_mem_target(pxm);
+		if (!target)
+			continue;
+		attrs = &target->hmem_attrs[1];
+		rc = mt_set_default_dram_perf(nid, attrs, "ACPI HMAT");
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int hmat_calculate_adistance(struct notifier_block *self,
+				    unsigned long nid, void *data)
+{
+	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
+	struct memory_target *target;
+	struct node_hmem_attrs *perf;
+	int *adist = data;
+	int pxm;
+
+	pxm = node_to_pxm(nid);
+	target = find_mem_target(pxm);
+	if (!target)
+		return NOTIFY_OK;
+
+	mutex_lock(&target_lock);
+	hmat_update_target_attrs(target, p_nodes, 1);
+	mutex_unlock(&target_lock);
+
+	perf = &target->hmem_attrs[1];
+
+	if (mt_perf_to_adistance(perf, adist))
+		return NOTIFY_OK;
+
+	return NOTIFY_STOP;
+}
+
+static struct notifier_block hmat_adist_nb __meminitdata = {
+	.notifier_call = hmat_calculate_adistance,
+	.priority = 100,
+};
+
 static __init void hmat_free_structures(void)
 {
 	struct memory_target *target, *tnext;
@@ -841,8 +897,13 @@ static __init int hmat_init(void)
 	hmat_register_targets();
 
 	/* Keep the table and structures if the notifier may use them */
-	if (!hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
-		return 0;
+	if (hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
+		goto out_put;
+
+	if (!hmat_set_default_dram_perf())
+		register_mt_adistance_algorithm(&hmat_adist_nb);
+
+	return 0;
 out_put:
 	hmat_free_structures();
 	acpi_put_table(tbl);
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index c8382220cced..9d27ca3b143e 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -31,8 +31,11 @@ struct memory_dev_type {
 	struct kref kref;
 };
 
+struct node_hmem_attrs;
+
 #ifdef CONFIG_NUMA
 extern bool numa_demotion_enabled;
+extern struct memory_dev_type *default_dram_type;
 struct memory_dev_type *alloc_memory_type(int adistance);
 void put_memory_type(struct memory_dev_type *memtype);
 void init_node_memory_type(int node, struct memory_dev_type *default_type);
@@ -40,6 +43,9 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype);
 int register_mt_adistance_algorithm(struct notifier_block *nb);
 int unregister_mt_adistance_algorithm(struct notifier_block *nb);
 int mt_calc_adistance(int node, int *adist);
+int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
+			     const char *source);
+int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -64,6 +70,7 @@ static inline bool node_is_toptier(int node)
 #else
 
 #define numa_demotion_enabled	false
+#define default_dram_type	NULL
 /*
  * CONFIG_NUMA implementation returns non NULL error.
  */
@@ -116,5 +123,16 @@ static inline int mt_calc_adistance(int node, int *adist)
 {
 	return NOTIFY_DONE;
 }
+
+static inline int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
+					   const char *source)
+{
+	return -EIO;
+}
+
+static inline int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist)
+{
+	return -EIO;
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 76c0ad47a5ad..fa1a8b418f9a 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -37,7 +37,7 @@ struct node_memory_type_map {
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
-static struct memory_dev_type *default_dram_type;
+struct memory_dev_type *default_dram_type;
 
 static struct bus_type memory_tier_subsys = {
 	.name = "memory_tiering",
@@ -108,6 +108,11 @@ static struct demotion_nodes *node_demotion __read_mostly;
 
 static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
 
+static bool default_dram_perf_error;
+static struct node_hmem_attrs default_dram_perf;
+static int default_dram_perf_ref_nid = NUMA_NO_NODE;
+static const char *default_dram_perf_ref_source;
+
 static inline struct memory_tier *to_memory_tier(struct device *device)
 {
 	return container_of(device, struct memory_tier, dev);
@@ -595,6 +600,102 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 }
 EXPORT_SYMBOL_GPL(clear_node_memory_type);
 
+static void dump_hmem_attrs(struct node_hmem_attrs *attrs, const char *prefix)
+{
+	pr_info(
+"%sread_latency: %u, write_latency: %u, read_bandwidth: %u, write_bandwidth: %u\n",
+		prefix, attrs->read_latency, attrs->write_latency,
+		attrs->read_bandwidth, attrs->write_bandwidth);
+}
+
+int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
+			     const char *source)
+{
+	int rc = 0;
+
+	mutex_lock(&memory_tier_lock);
+	if (default_dram_perf_error) {
+		rc = -EIO;
+		goto out;
+	}
+
+	if (perf->read_latency + perf->write_latency == 0 ||
+	    perf->read_bandwidth + perf->write_bandwidth == 0) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
+		default_dram_perf = *perf;
+		default_dram_perf_ref_nid = nid;
+		default_dram_perf_ref_source = kstrdup(source, GFP_KERNEL);
+		goto out;
+	}
+
+	/*
+	 * The performance of all default DRAM nodes is expected to be
+	 * same (that is, the variation is less than 10%).  And it
+	 * will be used as base to calculate the abstract distance of
+	 * other memory nodes.
+	 */
+	if (abs(perf->read_latency - default_dram_perf.read_latency) * 10 >
+	    default_dram_perf.read_latency ||
+	    abs(perf->write_latency - default_dram_perf.write_latency) * 10 >
+	    default_dram_perf.write_latency ||
+	    abs(perf->read_bandwidth - default_dram_perf.read_bandwidth) * 10 >
+	    default_dram_perf.read_bandwidth ||
+	    abs(perf->write_bandwidth - default_dram_perf.write_bandwidth) * 10 >
+	    default_dram_perf.write_bandwidth) {
+		pr_info(
+"memory-tiers: the performance of DRAM node %d mismatches that of the reference\n"
+"DRAM node %d.\n", nid, default_dram_perf_ref_nid);
+		pr_info("  performance of reference DRAM node %d:\n",
+			default_dram_perf_ref_nid);
+		dump_hmem_attrs(&default_dram_perf, "    ");
+		pr_info("  performance of DRAM node %d:\n", nid);
+		dump_hmem_attrs(perf, "    ");
+		pr_info(
+"  disable default DRAM node performance based abstract distance algorithm.\n");
+		default_dram_perf_error = true;
+		rc = -EINVAL;
+	}
+
+out:
+	mutex_unlock(&memory_tier_lock);
+	return rc;
+}
+
+int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist)
+{
+	if (default_dram_perf_error)
+		return -EIO;
+
+	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
+		return -ENOENT;
+
+	if (perf->read_latency + perf->write_latency == 0 ||
+	    perf->read_bandwidth + perf->write_bandwidth == 0)
+		return -EINVAL;
+
+	mutex_lock(&memory_tier_lock);
+	/*
+	 * The abstract distance of a memory node is in direct proportion to
+	 * its memory latency (read + write) and inversely proportional to its
+	 * memory bandwidth (read + write).  The abstract distance, memory
+	 * latency, and memory bandwidth of the default DRAM nodes are used as
+	 * the base.
+	 */
+	*adist = MEMTIER_ADISTANCE_DRAM *
+		(perf->read_latency + perf->write_latency) /
+		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
+		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
+		(perf->read_bandwidth + perf->write_bandwidth);
+	mutex_unlock(&memory_tier_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt_perf_to_adistance);
+
 /**
  * register_mt_adistance_algorithm() - Register memory tiering abstract distance algorithm
  * @nb: The notifier block which describe the algorithm
-- 
2.39.2

