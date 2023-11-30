Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1793C7FFE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377104AbjK3WFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377132AbjK3WFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:05:01 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C90170D;
        Thu, 30 Nov 2023 14:05:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQffWLdkFqcIdCdNfx8Iv7YeMvAG7Qi8NryWn2LFj0MRIAuCjUCaadshegpITL1ZovvMeo80QcVtzXqg1VRoy0OZilG1/xnwMeZvrustsVjLT3QuNT/qaTLgAeNyPMHp2PZYwVKMDXyxKvexlfXF/yunuRWk0AVEVCPnATjQKcZ4wVYUF35Qg/wBc08JrPCT6IyjTUm0qTfS0+MzOktPE9t7g/XmkCPpYvupjmlUWmR6f7f6tvcWkkkpeqAqADLeVF0etiALZIUTl6sV5Fv2j3A7oaq6z/Y1x610AYLbvrAkGlm0TUTbnG2SVnwpEHhkNMrC/wlhV1UyCypVG3bRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwCsJjNu6nQC1LUWcY1s4jJwPpNdTPIRqZ+x26Tt4/I=;
 b=dLi+/dX/oiInLK2iaT9cmUkfgZs1Xwylxrq0lR325bKZc3o+R7cNB5aOyWMwM4Przl/qME5XTVY6fDTiCNSc6G/IBcJtce6O5CNVrnWWpSD9tgescGTv3LsDwuTPDIdX6ZJD6COLWkB6poNDHJsv9JHuBz+PamW68XLyE0mXMV8akxGzksLXo9nnMW8lXfeWdfbcu8OuXXUGPQypS2bhr88sknZpQyDdDnv+uNGSOWNGtJd+XFWwhUHGp02l5TsnGkOM9BUbnxDt02SCX9hRd6vnh56MHjigkwmRRguKd0ZO26uhubSZoLSKmdeZOK5y5/VhfpIH/Bu18feHAnHPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwCsJjNu6nQC1LUWcY1s4jJwPpNdTPIRqZ+x26Tt4/I=;
 b=P73mE6GMXIbzg4FzeWQBUfpAKR2tkwmaRj2bKtl3ICSSFYXmXkboClQ6DgXiZwYt4cUHLjDrkk1cRUKdyn9WHdoA1pXBVD47KCklMn6uCb1uSO/R0Cr5lNCUcpS2A9d7XsTXRY1Bq+hydmV0fmGwl9NLG6i52qgek9uzpW/q8nvkRW8esDuCgfDN3ontdTNU08eACuoRr7josvmY+LiKd8ca39Cqkm+HQwSa00lddmcS08fy1hAdce+z4zet1JXfPFGxkAJPuIMAVfFxAfr5A3f1md29j0TSsQhpcvg/Fo99exzlBzmpYR8j0O71X4+U3/62uKV0DvFl6pLj/Gu7oQ==
Received: from MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::17)
 by SA2PR08MB6763.namprd08.prod.outlook.com (2603:10b6:806:11e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 22:05:01 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::7) by MW4P223CA0012.outlook.office365.com
 (2603:10b6:303:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Thu, 30 Nov 2023 22:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 22:05:01 +0000
Received: from BOW36EX19B.micron.com (137.201.85.154) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Thu, 30 Nov
 2023 15:05:00 -0700
Received: from micron.com (10.3.67.194) by
 RestrictedRelayBOW36EX19B.micron.com (137.201.85.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Thu, 30 Nov 2023 15:04:53 -0700
From:   <sthanneeru.opensrc@micron.com>
To:     <aneesh.kumar@linux.ibm.com>, <linux-cxl@vger.kernel.org>,
        <linux-mm@kvack.org>, <sthanneeru.opensrc@micron.com>
CC:     <dan.j.williams@intel.com>, <hannes@cmpxchg.org>,
        <hasanalmaruf@fb.com>, <haowang3@fb.com>, <ying.huang@intel.com>,
        <gregory.price@memverge.com>, <mhocko@suse.com>, <tj@kernel.org>,
        <hezhongkun.hzk@bytedance.com>, <fvdl@google.com>,
        <john@jagalactic.com>, <emirakhur@micron.com>,
        <vtavarespetr@micron.com>, <Ravis.OpenSrc@micron.com>,
        <Jonathan.Cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>
Subject: [RFC PATCH 2/2] memory tier: Support node migration between tiers
Date:   Fri, 1 Dec 2023 03:34:22 +0530
Message-ID: <20231130220422.2033-3-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
References: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SA2PR08MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 25aecafa-2291-4cf9-e033-08dbf1f06640
X-LD-Processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vF4iKpy4IR8YBIhL6EyZvGR2PgHb/cJynJCYKGTnmD+UkqBP9Xeo1/wu5zB0/sOfb4T0pGX5+m/LBdOVXxfng/4nN81hMudEYxywOjeDPA07n2fU59+EPalrU2PdysgJWXyFbHZH4zj7flKfHGp3a4TRuYwzacoK+Yj6P20rVuCyDPe9FE8XV6P/tAwyMBeSUEREkiVA1g+XTMjlNWZl0SZGx6Qj5OKt27QDy80ERYqKY48E0RNusJje9UCBTcNHuDtEoXmNlzQ2I66Q5UqaNyv7UQFVRnmjM5OxMUIAUJ+G70rEvDQ9F8nerFHFwRtlXflgv8alqX6UtmVlHW7UyEJOXPBAx2yFYqlpYZtX+MXprpux+OV0hLcmPXrFtqPHe3okUxHZ61y9w+YSYmLlvFqqCX3JxOV7H3qwbqNLn6YYlaYMadIMj9kCsRKq1+W39fJkQsATIX825BF1IGcW4RP5/WFnlap006tnqnEe/nf9SiccFO88ku/2MBjBe9JGEaItsiB70cdRvb3QntM8CJQoUFTkuBKYqOzA7JDqVT+OEGWG7/4QhgYGrnDNUkiUj10iBEe05lQE1pIktkVfH4v9qWO/dH1Ro/yhcbCEEtlo67GcIwdryz04iOlAfN/EkTyK3rCVqTKgSsCQzDnS02l5N4YnOosv3bA2v00Wr8NoF/SzsxHA1C3ppa9xV2016E+XSQmG3XkgEQM22hlswwx9z/C1WMaQgw2uOSvPeha5Du1Km+O9u+wVZNOZIM/iw1tpvig3AP1z3cyr8tvpFg==
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(36840700001)(40470700004)(46966006)(1076003)(55016003)(47076005)(40480700001)(7636003)(356005)(82740400003)(83380400001)(26005)(6286002)(41300700001)(36756003)(36860700001)(7049001)(426003)(336012)(7696005)(2616005)(6666004)(40460700003)(2876002)(2906002)(5660300002)(7416002)(54906003)(316002)(70586007)(110136005)(70206006)(478600001)(8676002)(8936002)(86362001)(4326008)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:05:01.2092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25aecafa-2291-4cf9-e033-08dbf1f06640
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6763
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

Node migration enables the grouping or migration of nodes
between tiers based on nodes' latencies and bandwidth characteristics.
Since nodes of the same memory-type can exist in different tiers and can
migrate from one tier to another, it is necessary to maintain nodes
per tier instead of maintaining a list of nodes grouped using
memory type(siblings) within the tier.

To migrate a node from one tier to another, remove the node from the
current tier and insert it into the target tier. If the target tier does
not exist, create a new one.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
---
 drivers/base/node.c          |  6 ++++
 include/linux/memory-tiers.h |  5 +++
 include/linux/node.h         |  5 +++
 mm/memory-tiers.c            | 65 +++++++++++++++++-------------------
 4 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 1e63c692977b..8290ea96b439 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -608,10 +608,16 @@ static ssize_t adistance_offset_store(struct device *dev,
 		return -EINVAL;
 
 	node_devices[nid]->adistance_offset = value;
+	node_memtier_change(nid);
 	return size;
 }
 static DEVICE_ATTR_RW(adistance_offset);
 
+int get_node_adistance_offset(int nid)
+{
+	return node_devices[nid]->adistance_offset;
+}
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index ff4e7136ab40..e86c23873334 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -49,6 +49,7 @@ int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
 			     const char *source);
 int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist);
 int get_target_memtier_adistance(int node, int adistance_offset);
+void node_memtier_change(int node);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -142,5 +143,9 @@ static int get_target_memtier_adistance(int node, int adistance_offset)
 {
 	return 0;
 }
+
+static inline void node_memtier_change(int node)
+{
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/include/linux/node.h b/include/linux/node.h
index fd0f4f3177f8..5150215b4922 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -139,6 +139,7 @@ extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
 extern int register_memory_node_under_compute_node(unsigned int mem_nid,
 						   unsigned int cpu_nid,
 						   unsigned access);
+extern int get_node_adistance_offset(int nid);
 #else
 static inline void node_dev_init(void)
 {
@@ -166,6 +167,10 @@ static inline int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
 static inline void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
 {
 }
+static inline int get_node_adistance_offset(int nid)
+{
+	return 0;
+}
 #endif
 
 #define to_node(device) container_of(device, struct node, dev)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index a40d4d4383d7..b6cd86977731 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -23,6 +23,8 @@ struct memory_tier {
 	struct device dev;
 	/* All the nodes that are part of all the lower memory tiers. */
 	nodemask_t lower_tier_mask;
+	/* Nodes linked to this tier*/
+	nodemask_t nodes;
 };
 
 struct demotion_nodes {
@@ -120,13 +122,7 @@ static inline struct memory_tier *to_memory_tier(struct device *device)
 
 static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
 {
-	nodemask_t nodes = NODE_MASK_NONE;
-	struct memory_dev_type *memtype;
-
-	list_for_each_entry(memtype, &memtier->memory_types, tier_sibling)
-		nodes_or(nodes, nodes, memtype->nodes);
-
-	return nodes;
+	return memtier->nodes;
 }
 
 static void memory_tier_device_release(struct device *dev)
@@ -181,33 +177,22 @@ int get_target_memtier_adistance(int node, int adistance_offset)
 	return node_adistance;
 }
 
-static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
+static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype,
+						   int tier_adistance)
 {
 	int ret;
 	bool found_slot = false;
 	struct memory_tier *memtier, *new_memtier;
-	int adistance = memtype->adistance;
+	int adistance;
 	unsigned int memtier_adistance_chunk_size = MEMTIER_CHUNK_SIZE;
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
-	adistance = round_down(adistance, memtier_adistance_chunk_size);
-	/*
-	 * If the memtype is already part of a memory tier,
-	 * just return that.
-	 */
-	if (!list_empty(&memtype->tier_sibling)) {
-		list_for_each_entry(memtier, &memory_tiers, list) {
-			if (adistance == memtier->adistance_start)
-				return memtier;
-		}
-		WARN_ON(1);
-		return ERR_PTR(-EINVAL);
-	}
+	adistance = round_down(tier_adistance, memtier_adistance_chunk_size);
 
 	list_for_each_entry(memtier, &memory_tiers, list) {
 		if (adistance == memtier->adistance_start) {
-			goto link_memtype;
+			return memtier;
 		} else if (adistance < memtier->adistance_start) {
 			found_slot = true;
 			break;
@@ -238,9 +223,6 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 		return ERR_PTR(ret);
 	}
 	memtier = new_memtier;
-
-link_memtype:
-	list_add(&memtype->tier_sibling, &memtier->memory_types);
 	return memtier;
 }
 
@@ -499,7 +481,7 @@ static struct memory_tier *set_node_memory_tier(int node)
 	struct memory_tier *memtier;
 	struct memory_dev_type *memtype;
 	pg_data_t *pgdat = NODE_DATA(node);
-
+	int tier_adistance;
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
@@ -510,9 +492,13 @@ static struct memory_tier *set_node_memory_tier(int node)
 
 	memtype = node_memory_types[node].memtype;
 	node_set(node, memtype->nodes);
-	memtier = find_create_memory_tier(memtype);
+	tier_adistance = get_node_adistance_offset(node);
+	tier_adistance = memtype->adistance + tier_adistance;
+
+	memtier = find_create_memory_tier(memtype, tier_adistance);
 	if (!IS_ERR(memtier))
 		rcu_assign_pointer(pgdat->memtier, memtier);
+	node_set(node, memtier->nodes);
 	return memtier;
 }
 
@@ -548,11 +534,9 @@ static bool clear_node_memory_tier(int node)
 		synchronize_rcu();
 		memtype = node_memory_types[node].memtype;
 		node_clear(node, memtype->nodes);
-		if (nodes_empty(memtype->nodes)) {
-			list_del_init(&memtype->tier_sibling);
-			if (list_empty(&memtier->memory_types))
-				destroy_memory_tier(memtier);
-		}
+		node_clear(node, memtier->nodes);
+		if (nodes_empty(memtier->nodes))
+			destroy_memory_tier(memtier);
 		cleared = true;
 	}
 	return cleared;
@@ -575,7 +559,6 @@ struct memory_dev_type *alloc_memory_type(int adistance)
 		return ERR_PTR(-ENOMEM);
 
 	memtype->adistance = adistance;
-	INIT_LIST_HEAD(&memtype->tier_sibling);
 	memtype->nodes  = NODE_MASK_NONE;
 	kref_init(&memtype->kref);
 	return memtype;
@@ -615,6 +598,20 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 }
 EXPORT_SYMBOL_GPL(clear_node_memory_type);
 
+void node_memtier_change(int node)
+{
+	struct memory_tier *memtier;
+
+	mutex_lock(&memory_tier_lock);
+	if (clear_node_memory_tier(node))
+		establish_demotion_targets();
+	memtier = set_node_memory_tier(node);
+	if (!IS_ERR(memtier))
+		establish_demotion_targets();
+	mutex_unlock(&memory_tier_lock);
+}
+
+
 static void dump_hmem_attrs(struct node_hmem_attrs *attrs, const char *prefix)
 {
 	pr_info(
-- 
2.25.1

