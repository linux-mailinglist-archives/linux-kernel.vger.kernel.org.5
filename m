Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCCF811B96
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjLMRyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjLMRyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:54:01 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C9311B;
        Wed, 13 Dec 2023 09:54:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6TvSv+FqV0QBX3Nqciauioymzm57GWsgFAynImzBerdj14IflvEwNzSQ2I5+KZEDYPf7iWp9aF10MfA3MMwZGUAMCp2/fAlQkZDBBYlPcXHYH3OlSlJGkB4EUC788IPUFlyU769xBQwjFcApLQv8mjuaLUY31+YZuY0XgNpqbvfTyfDDvXCijCWNbRSbz4rBDmMhFpPf9lsstThsH96mLStHb6aFj0IkE+sxgJyzH2rAFiGIAQeO5zrFt5H0B39oLt+GjTJ3O9Xg4COk2FYw0h/7Pe3z2SO2/5kcwD/WpyABmz0UuY/ih2kWljn+ffAAatFORyw5ZpRmsM5XvjCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cr0ixxuqcPbGC2W7D030i2YyCFB31Xz9e/rZzFyCMBU=;
 b=dzhEa5d/Wk0KY5OmvGNSqWuNVAyGD8xZ/VFCH2FSKgY+fpBAOYc+EUsyVYVa8RvOXN4DiyrNy/HmhtsMlDgXZ12O3Qy2zF7Rdy9Rjlj52KYlHrilpNOga1x35hl9/roYdzf25ULj8JNnv/lUPY67FSBFe/J7ecaItUZuyV6n7Ic59MryHi8ZOC4XrUDbKIY8BZZEwXXq8yAWZgtkiPHTNAfK5XPXdZhlmOAN3gTNZEeNG8Z/sZno39QJVvqCVJtQfkMOg5Sd612NH9Fyph/Mikm2i0wMLmoigtQYJEUAk2acMIsRTM9zJV3fTJvdxGL1NWsZVlM+4Zz6OYj63wxtCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cr0ixxuqcPbGC2W7D030i2YyCFB31Xz9e/rZzFyCMBU=;
 b=fNyKFD6P8KXfeNHeCjA8A3xlJCHD3+W5S91AmnMapv2hXzSrGfO57xvinyP92iGcy84jwVDsVBeoz8kxmqTalmwggatNb46i0nuoYNZcVb1kXHbLXii5qK4OdtjMJhRMqo87NeYcY1m2dRCu56xp4r2Zc7xQRk0d82TujTwj7iN9CPEA2fh5hGl0WjspzOSVM8LfEKM9teIJ8h9LlSAA6HJxa0zc86a16zTlRihn5a1aqsRVwUEAwCkls24dGvAgeruBM9mnUDB/RJABnXfchCtUbBzb3m8RZkHlCmVqnahKVZ7NdPpIMWTA5TCbkmUjGG+ogcTdKMvMkoCFguCbmw==
Received: from BL1PR13CA0292.namprd13.prod.outlook.com (2603:10b6:208:2bc::27)
 by CO6PR08MB7769.namprd08.prod.outlook.com (2603:10b6:303:144::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 17:53:57 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::93) by BL1PR13CA0292.outlook.office365.com
 (2603:10b6:208:2bc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 17:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 17:53:57 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW36EX19B.micron.com
 (137.201.85.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Wed, 13 Dec
 2023 10:53:56 -0700
Received: from micron.com (10.3.116.19) by RestrictedRelay36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27 via Frontend
 Transport; Wed, 13 Dec 2023 10:53:49 -0700
From:   <sthanneeru.opensrc@micron.com>
To:     <sthanneeru.opensrc@micron.com>, <linux-cxl@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <sthanneeru@micron.com>, <aneesh.kumar@linux.ibm.com>,
        <dan.j.williams@intel.com>, <ying.huang@intel.com>,
        <gregory.price@memverge.com>, <mhocko@suse.com>, <tj@kernel.org>,
        <john@jagalactic.com>, <emirakhur@micron.com>,
        <vtavarespetr@micron.com>, <Ravis.OpenSrc@micron.com>,
        <Jonathan.Cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
        Ravi Jonnalagadda <ravis.opensrc@micron.com>
Subject: [PATCH 1/2] base/node: Add sysfs for memtier_override
Date:   Wed, 13 Dec 2023 23:23:28 +0530
Message-ID: <20231213175329.594-2-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CO6PR08MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b99d33b-3297-4022-6904-08dbfc047ad1
X-LD-Processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1u2y+7Zv3exMnaX4qHg8ga1fz8bJoVT/jvIDsgDqH/8VtGix6I855NG39VU1ntvA9ZbYkrA0QKA5YhP/tEr7FdNlh+KVG+zUhjcnLZqqi78+B2jeBf1ywFE8+KL1R0/nES264h1zVZOtF/0gcrPhvqc7Y8wOL9wWy2X5imF0Loeb/Li/3pO4WFnAkUTkTIlZa+EdhYVUnOuBzDOnkSuBK8VP7rI38gWEFfgDA4T3DyiPaVTowrWJN1WjpgZXiPrHBYQGu3488KEXcRRDbtU3t8s4gBMmDnfk2WiojFyLJb/etPv0WViW67SF7cPB6R2DQd1GEaHqtGnzNs91Yor3/RkdTMPOyEOyAtUHquGFhFA10PpQ1vOwtyMbDHfVw1m28m+T1JntUE1a+qGQfWIYneW7WHnFW4uhktFWtQm13HmT1+SFtU3ifOvQt7BlEqPKWPlogNVdxn6JGn19tPlEdcrCmbYM8EuoZT01RX+vuw7Z0Lzmhu0gJNgrdkaQn3MHAurEjhG/0xYnp6GGi/B4NMmcBmofOIH5VPngqKPCB1BdKCqZTf3fVEcOM2VGRUU3wypzVUwwarSMGv0E/73ZW8nVYS6IDBT3IlsSzBLYHRgGuMAk+0vszKfKDaVH4ZcfscqHPI927cCEWfY+CMmMp+WI9ev4v+UmYx1bggui2s7px3CuM3x+Pe02ktyhfu1I4PGBuZQZIjqqtw+o3SXnl0b6mtHb52Zw4ZdqSBCF7Gm+Kl+/pRD7UJYlojjMG+L0I9CPItIDF1G+UeMzXVvPhg==
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(26005)(6286002)(107886003)(2616005)(1076003)(336012)(426003)(7696005)(6666004)(47076005)(36860700001)(83380400001)(5660300002)(41300700001)(2906002)(2876002)(478600001)(110136005)(8676002)(8936002)(4326008)(70206006)(70586007)(316002)(54906003)(7636003)(82740400003)(86362001)(356005)(36756003)(55016003)(40480700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 17:53:57.2263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b99d33b-3297-4022-6904-08dbfc047ad1
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR08MB7769
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

This patch introduces a new memtier_override sysfs.

memtier_override is the current memory tier of the node.
To migrate, replace it with the id of the desired memory tier.

adistance_offset is the required offset from memtype to move
the node to the target memory tier(i.e, memtier_override).

Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
---
 Documentation/ABI/stable/sysfs-devices-node |  7 ++++
 drivers/base/node.c                         | 41 +++++++++++++++++++++
 include/linux/memory-tiers.h                |  6 +++
 include/linux/node.h                        |  6 +++
 mm/memory-tiers.c                           | 19 +++++++++-
 5 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 402af4b2b905..447a599cc536 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -70,6 +70,13 @@ Description:
 		Distance between the node and all the other nodes
 		in the system.
 
+What:		/sys/devices/system/node/nodeX/memtier_overwrite
+Date:		December 2023
+Contact:	Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
+Description:
+		The current memory tier of the node.
+		To migrate, replace it with the id of the desired memory tier.
+
 What:		/sys/devices/system/node/nodeX/vmstat
 Date:		October 2002
 Contact:	Linux Memory Management list <linux-mm@kvack.org>
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 493d533f8375..788176b3585a 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/memory.h>
+#include <linux/memory-tiers.h>
 #include <linux/vmstat.h>
 #include <linux/notifier.h>
 #include <linux/node.h>
@@ -569,11 +570,49 @@ static ssize_t node_read_distance(struct device *dev,
 }
 static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
+static ssize_t memtier_override_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int nid = dev->id;
+	int len = 0;
+
+	len += sysfs_emit(buf, "memory_tier%d\n", node_devices[nid]->memtier);
+	return len;
+}
+
+static ssize_t memtier_override_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	int nid = dev->id;
+	int ret, memtier;
+
+	ret = kstrtoint(buf, 0, &memtier);
+
+	if (ret)
+		return ret;
+	if (memtier < 0 || memtier > MAX_MEMTIERID)
+		return -EINVAL;
+	if (node_devices[nid]->memtier == memtier)
+		return size;
+	ret = get_memtier_adistance_offset(nid, memtier);
+	node_devices[nid]->adistance_offset = ret;
+
+	return size;
+}
+static DEVICE_ATTR_RW(memtier_override);
+
+void set_node_memtierid(int node, int memtierid)
+{
+	node_devices[node]->memtier = memtierid;
+}
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
+	&dev_attr_memtier_override.attr,
 	NULL
 };
 
@@ -883,6 +922,8 @@ int __register_one_node(int nid)
 
 	INIT_LIST_HEAD(&node_devices[nid]->access_list);
 	node_init_caches(nid);
+	node_devices[nid]->memtier = 0;
+	node_devices[nid]->adistance_offset = 0;
 
 	return error;
 }
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 1e39d27bee41..0dba8027e785 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -20,6 +20,11 @@
  */
 #define MEMTIER_ADISTANCE_DRAM	((4 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
 
+/*
+ * Memory tier id is derived from abstract distance(signed 32bits)
+ */
+#define MAX_MEMTIERID (0xFFFFFFFF >> (MEMTIER_CHUNK_BITS + 1))
+
 struct memory_tier;
 struct memory_dev_type {
 	/* list of memory types that are part of same tier as this type */
@@ -48,6 +53,7 @@ int mt_calc_adistance(int node, int *adist);
 int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
 			     const char *source);
 int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist);
+int get_memtier_adistance_offset(int node, int memtier);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
diff --git a/include/linux/node.h b/include/linux/node.h
index 427a5975cf40..1c4f4be39db4 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -83,6 +83,8 @@ static inline void node_set_perf_attrs(unsigned int nid,
 struct node {
 	struct device	dev;
 	struct list_head access_list;
+	int memtier;
+	int adistance_offset;
 #ifdef CONFIG_HMEM_REPORTING
 	struct list_head cache_attrs;
 	struct device *cache_dev;
@@ -138,6 +140,7 @@ extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
 extern int register_memory_node_under_compute_node(unsigned int mem_nid,
 						   unsigned int cpu_nid,
 						   unsigned access);
+extern void set_node_memtierid(int node, int memtierid);
 #else
 static inline void node_dev_init(void)
 {
@@ -165,6 +168,9 @@ static inline int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
 static inline void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
 {
 }
+static inline void set_node_memtierid(int node, int memtierid)
+{
+}
 #endif
 
 #define to_node(device) container_of(device, struct node, dev)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 8d5291add2bc..31ed3c577836 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -167,6 +167,21 @@ static const struct attribute_group *memtier_dev_groups[] = {
 	NULL
 };
 
+int get_memtier_adistance_offset(int node, int memtier)
+{
+	struct memory_dev_type *memtype;
+	int adistance_offset;
+
+	memtype = node_memory_types[node].memtype;
+	/*
+	 * Calculate the adistance offset required from memtype
+	 * to move node to target memory tier.
+	 */
+	adistance_offset = (memtier << MEMTIER_CHUNK_BITS) -
+			   memtype->adistance;
+	return adistance_offset;
+}
+
 static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
 {
 	int ret;
@@ -497,8 +512,10 @@ static struct memory_tier *set_node_memory_tier(int node)
 	memtype = node_memory_types[node].memtype;
 	node_set(node, memtype->nodes);
 	memtier = find_create_memory_tier(memtype);
-	if (!IS_ERR(memtier))
+	if (!IS_ERR(memtier)) {
 		rcu_assign_pointer(pgdat->memtier, memtier);
+		set_node_memtierid(node, memtier->dev.id);
+	}
 	return memtier;
 }
 
-- 
2.25.1

