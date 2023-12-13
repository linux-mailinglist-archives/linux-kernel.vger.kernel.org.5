Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4B9811B99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjLMRyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjLMRyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:54:07 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0A511A;
        Wed, 13 Dec 2023 09:54:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQKv6L3DcElaSzL/DbCr3zoN6SRPiFoshMSH3S4zU7cRr2jjCK+1irIO01VM/AsXi01lg45xEtYVDrGKt3NC7DQ3c8lOGJbeY12vM+cKn8zTzTV8sHufBhLyAWAMVLQ01aUvrWIgeWu+gO6H18bH0JgYpNLyRc1YaEvGEf+Q0UxH3mxttb2CNi9Pkf05oWubxbACk5aFFb+mP5ZZLEK57TMQk/P+ix2aHhYRv9CYos83mq14xyHxFYtUsaZpo0VkS/OJ/bSyFdPr1iykELMWIm25vcII4zOzE0UAfI0USiF+Vn+CXxG4VZt6ZD1KYEDHcOBJ1BqIdyZ2PyWsSTTuVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTNf944D++5RAaxuPuIOcMEvY0ECfOxgHNlMz9SZ+9w=;
 b=dPcKcSmfiknRk1HEZs6KCqGA9wy77lcyFOy7YRqSFt7Vyv8cEwjx6Sjo1yChGABvXjqDmOJoKVzMPZBw+e8lL27EuOApv5oG/5/ZWE0U3BYle9TH3pMsdtpMm72NkmaGkc4oz17FA1ZB38/VuSVoYd73t5+B2XC51Ei029nYh7Am9zsF2DSR79zCHxUfT9+cfbrKQYwvz1gZgBceVY/88bgkcOj5t9C/1MVkgwBH9l5jvDc2Gzmcjs00zKziX55wdJujwUGNPHUFodYxVTlP33txhnaGALxBhHbSVuSvQdbeNa9068Ea7Xr2q0OebERuUmuVLnHDTiVonb4IvhKUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTNf944D++5RAaxuPuIOcMEvY0ECfOxgHNlMz9SZ+9w=;
 b=gKv4X5l/Pfu7KRGEwb0Wjx/VZANowDg4sqSQhKn5xINhsdRbMi2yEsOKhyJa5icVBaqNohmfwyamw/ddqWulTrSCFzuyz62wjHxoWne+RnwfEz2NEMjkwAfEYbQnFdI90H5Rkmm+vZceSLC8EYjV77hnNC7d5AWJBCRxK45vFIM2QFYmpOo+U6xMcZDpQCjCz6JmJRs/PTbmJkFGuiLChOaJlfaVC7a965NZKTfRmpBRBStFmXEbrKC52f4QG7xUsb8wfHy4+bUOfIEXwovLAZ7hoqvluYD1nK7gERw97BeeODvemOb7xKLWkyZdQa/173L2zHuInYKrtwvjQGZILg==
Received: from CH0P221CA0046.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::19)
 by DM4PR08MB8673.namprd08.prod.outlook.com (2603:10b6:8:190::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8; Wed, 13 Dec
 2023 17:54:06 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:610:11d:cafe::d0) by CH0P221CA0046.outlook.office365.com
 (2603:10b6:610:11d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 17:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 17:54:06 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Wed, 13 Dec
 2023 10:54:02 -0700
Received: from micron.com (10.3.116.19) by RestrictedRelay36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27 via Frontend
 Transport; Wed, 13 Dec 2023 10:53:56 -0700
From:   <sthanneeru.opensrc@micron.com>
To:     <sthanneeru.opensrc@micron.com>, <linux-cxl@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <sthanneeru@micron.com>, <aneesh.kumar@linux.ibm.com>,
        <dan.j.williams@intel.com>, <ying.huang@intel.com>,
        <gregory.price@memverge.com>, <mhocko@suse.com>, <tj@kernel.org>,
        <john@jagalactic.com>, <emirakhur@micron.com>,
        <vtavarespetr@micron.com>, <Ravis.OpenSrc@micron.com>,
        <Jonathan.Cameron@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] memory tier: Support node migration between tiers
Date:   Wed, 13 Dec 2023 23:23:29 +0530
Message-ID: <20231213175329.594-3-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|DM4PR08MB8673:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0d7293-1c6c-40d2-c3af-08dbfc048046
X-LD-Processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORBEiw3+ZJXmX2+0UH0q98hwFgfOGz40DJnIjm9aBsnR5USLAUgaoMHltthNNIA8/1+zjW7dTX3iDK34rBExeJ26u40zPz/ucIzTnX5ajLROHuKtyqgWAba3jWbxhD5xkgGewJueP3RdaWsycW+DwIgVePV2Ks39PZa6gcsMATn01JHp8yEjka28dQCeHdOgQVpaR5vhh0ik4gRNKbFxmZFrRKgqpI0q4M2xoYqsg3jg5SBFEhUVBEF1SW5LDjZaPHpXasCG1INWZucOs8bv4cfdddyVm6jJrkh63aXAmuFisOorbTpj1V3O0taAFJBOVHvshmeV23ipzVEf/VPt+Id091BfoST05x0b7F6/T0dAjd9J/5Lt3XNRUmv7Rt6PjoaHUyfRZIOLAtxcmDZ7nE4UYHbS46YMZI+cCI65zLyqfs//tP7v2A/T2ueO50COC6LmGm6xq7Yxc84b9m3kQyU73Jt1yrjN0hga/mFbzweruqbjaf7VEX29LyIt1gcPt0w1QCcoRJkvNYTkBMdHDcoGO/0g2mYQ/SbZHFk5EjmC2aaPxjp0E2PGrkX4rlLijqZGjZFNBXBp84eDj5cq4l8qWVDHJ3CkASt8Jf2aABqeibfYROw/WK6fIVfQxyzG0zgngwJwIOUW+wkLoY9ZCkQiMWVANAE/GIh583pk5RYfnsZpq0eBQ4ArjTscjL7y32fNoQxsUAVPbrNZ+M8l/NyUiMiLr85FOgUeURokaHknO3IuqIQ8AlOi4kqRei0JAT20ciGtO+FaBeZKZPL+3w==
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(55016003)(40480700001)(40460700003)(70586007)(70206006)(54906003)(336012)(7636003)(82740400003)(356005)(36756003)(86362001)(36860700001)(47076005)(83380400001)(426003)(6286002)(26005)(1076003)(2616005)(2906002)(2876002)(316002)(110136005)(6666004)(478600001)(5660300002)(4326008)(8676002)(7696005)(41300700001)(8936002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 17:54:06.4309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0d7293-1c6c-40d2-c3af-08dbfc048046
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR08MB8673
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
Since nodes of the same memory-type can exist in different tiers and
can migrate from one tier to another, it is necessary to maintain
nodes per tier instead of maintaining a list of nodes grouped using
memory type(siblings) within the tier.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
---
 drivers/base/node.c          |  6 ++++
 include/linux/memory-tiers.h |  5 +++
 include/linux/node.h         |  5 +++
 mm/memory-tiers.c            | 66 +++++++++++++++++-------------------
 4 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 788176b3585a..179d9004e4f3 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -597,6 +597,7 @@ static ssize_t memtier_override_store(struct device *dev,
 		return size;
 	ret = get_memtier_adistance_offset(nid, memtier);
 	node_devices[nid]->adistance_offset = ret;
+	node_memtier_change(nid);
 
 	return size;
 }
@@ -607,6 +608,11 @@ void set_node_memtierid(int node, int memtierid)
 	node_devices[node]->memtier = memtierid;
 }
 
+int get_node_adistance_offset(int node)
+{
+	return node_devices[node]->adistance_offset;
+}
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 0dba8027e785..b323c2e2e417 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -54,6 +54,7 @@ int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
 			     const char *source);
 int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist);
 int get_memtier_adistance_offset(int node, int memtier);
+void node_memtier_change(int node);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -142,5 +143,9 @@ static inline int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist)
 {
 	return -EIO;
 }
+
+static inline void node_memtier_change(int node)
+{
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/include/linux/node.h b/include/linux/node.h
index 1c4f4be39db4..da679577a271 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -141,6 +141,7 @@ extern int register_memory_node_under_compute_node(unsigned int mem_nid,
 						   unsigned int cpu_nid,
 						   unsigned access);
 extern void set_node_memtierid(int node, int memtierid);
+extern int get_node_adistance_offset(int nid);
 #else
 static inline void node_dev_init(void)
 {
@@ -171,6 +172,10 @@ static inline void unregister_memory_block_under_nodes(struct memory_block *mem_
 static inline void set_node_memtierid(int node, int memtierid)
 {
 }
+static inline int get_node_adistance_offset(int nid)
+{
+	return 0;
+}
 #endif
 
 #define to_node(device) container_of(device, struct node, dev)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 31ed3c577836..66e1eae97e47 100644
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
@@ -182,33 +178,22 @@ int get_memtier_adistance_offset(int node, int memtier)
 	return adistance_offset;
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
@@ -238,11 +223,8 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 		put_device(&new_memtier->dev);
 		return ERR_PTR(ret);
 	}
-	memtier = new_memtier;
 
-link_memtype:
-	list_add(&memtype->tier_sibling, &memtier->memory_types);
-	return memtier;
+	return new_memtier;
 }
 
 static struct memory_tier *__node_get_memory_tier(int node)
@@ -500,7 +482,7 @@ static struct memory_tier *set_node_memory_tier(int node)
 	struct memory_tier *memtier;
 	struct memory_dev_type *memtype;
 	pg_data_t *pgdat = NODE_DATA(node);
-
+	int tier_adistance;
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
@@ -511,11 +493,15 @@ static struct memory_tier *set_node_memory_tier(int node)
 
 	memtype = node_memory_types[node].memtype;
 	node_set(node, memtype->nodes);
-	memtier = find_create_memory_tier(memtype);
+	tier_adistance = get_node_adistance_offset(node);
+	tier_adistance = memtype->adistance + tier_adistance;
+
+	memtier = find_create_memory_tier(memtype, tier_adistance);
 	if (!IS_ERR(memtier)) {
 		rcu_assign_pointer(pgdat->memtier, memtier);
 		set_node_memtierid(node, memtier->dev.id);
 	}
+	node_set(node, memtier->nodes);
 	return memtier;
 }
 
@@ -551,11 +537,9 @@ static bool clear_node_memory_tier(int node)
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
@@ -578,7 +562,6 @@ struct memory_dev_type *alloc_memory_type(int adistance)
 		return ERR_PTR(-ENOMEM);
 
 	memtype->adistance = adistance;
-	INIT_LIST_HEAD(&memtype->tier_sibling);
 	memtype->nodes  = NODE_MASK_NONE;
 	kref_init(&memtype->kref);
 	return memtype;
@@ -618,6 +601,19 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
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
 static void dump_hmem_attrs(struct node_hmem_attrs *attrs, const char *prefix)
 {
 	pr_info(
-- 
2.25.1

