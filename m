Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71EE7FFDDF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376997AbjK3Vt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjK3VtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:49:25 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8E510FC;
        Thu, 30 Nov 2023 13:49:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atkN91w4WzTi870IxiaTvm02DxXwv25JMh/szwASkYYN7AlNmkjx0f9S95nboMeuvcCf86H606UA/80Xt8vxNZBu7I1Qv8UjgKO/Nnjr22jRIac7xjSFCoOtWbMWSwKMsxmhZres7UnmIOiPLCDVhr5cSvoyntfi50BhhxYT4b0EtewqRBVe9LMK34TV2x4GpJ0NxwS6pC4n5mJPsNVqMex4qXKg0i6/YfM1Zmj89CmE/xLJnODUnwJzulabrbpDQOUyTQ7HmD3nHNdBMvD3JzhJEXpoLN+tunj7qgumlBv5G8yhZgxOZXQZ0WlpvlpjfOJVTBR+mcyeNrjXWLqZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o52l5LIU7CxjEEjkP4vOMXqkkPzqcXZT78iTMDIBX8k=;
 b=DLDpU60JqNiF8MY4mMGxGyyjCsC10I1/d+9kui1coP3bfKTKc8TyXo75rgDUB8x2htPMtmyHSwj7HUehUY2e2hDgE5UCI5DLN4lW5mLUM7564S6Ox3T6nDUwV+JPhl4HQfjMGLebFbSV1kuNsdfaPhOmTUeKK6dUKLbYkOFZwreSFM2Q1fGw0slFzjZ5jKzk98RFThIbH1GmOR8HCcheTkcOgmOQl/B6fPeBjfgHOfgVO/Uubywsx0iSUk6Lrd47kq9vgqEzjpx+PiC/j1bAzKXrzxfVh/X/noODPJRTl1rMrdo5vvInmgR3W8XNGVH/jZ3RFAqOtj8Jh/brMYyRag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=cmpxchg.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o52l5LIU7CxjEEjkP4vOMXqkkPzqcXZT78iTMDIBX8k=;
 b=gXRXCtx9ozewQwq/Xz2VRwALMP8xolVrxWEyCfxGYCyNMsDr+RKVU5C7ty62kNT1hXNrY7qIcD14XM3RbuIrrPv87Jxh1JbXRpDAi1PGDvuxEhFm/4tsSRwSC63Tcq5BOFXris0g3KyGLMPkzPjtLfKl2LHb4PuwFb++KtV0JahStO5hBwPp+sjo7xuDKzkgGaL1C5X1yCEFAqhPUV5GJxwH5DO7gs+Qh/XCDs8kHuD0daEGpvBnDE5C8j9EiSle2vLKlPK7PTnJqKJjAOMYTFAHxAOU3hS4YdacFtg9X3LegIKLyBwYrZKXSOyGTG+g3FywF/C0ln5t9uPxeqmC8Q==
Received: from BL1PR13CA0277.namprd13.prod.outlook.com (2603:10b6:208:2bc::12)
 by SA2PR08MB6523.namprd08.prod.outlook.com (2603:10b6:806:110::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Thu, 30 Nov
 2023 21:49:20 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::8e) by BL1PR13CA0277.outlook.office365.com
 (2603:10b6:208:2bc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Thu, 30 Nov 2023 21:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 21:49:19 +0000
Received: from BOW17EX19A.micron.com (137.201.21.218) by BOW36EX19B.micron.com
 (137.201.85.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Thu, 30 Nov
 2023 14:49:17 -0700
Received: from micron.com (10.3.67.194) by RestrictedRelay17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27 via Frontend
 Transport; Thu, 30 Nov 2023 14:49:11 -0700
From:   <sthanneeru.opensrc@micron.com>
To:     <aneesh.kumar@linux.ibm.com>, <hannes@cmpxchg.org>,
        <hasanalmaruf@fb.com>, <haowang3@fb.com>, <ying.huang@intel.com>,
        <gregory.price@memverge.com>, <dan.j.williams@intel.com>,
        <mhocko@suse.com>, <tj@kernel.org>, <hezhongkun.hzk@bytedance.com>,
        <fvdl@google.com>, <john@jagalactic.com>, <mirakhur@micron.com>,
        <vtavarespetr@micron.com>, <Ravis.OpenSrc@micron.com>,
        <Jonathan.Cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>
CC:     Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>,
        Ravi Jonnalagadda <ravis.opensrc@micron.com>
Subject: [RFC PATCH 1/2] base/node: Add sysfs for adistance_offset
Date:   Fri, 1 Dec 2023 03:18:57 +0530
Message-ID: <20231130214858.1887-2-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231130214858.1887-1-sthanneeru.opensrc@micron.com>
References: <20231130214858.1887-1-sthanneeru.opensrc@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SA2PR08MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c3c0dd-af63-4856-bc6c-08dbf1ee34e8
X-LD-Processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWu3tn/s3fXeKw6pyjFKRw4HQLGCZFXGzuSjnJsNWmMknpS11ionnvV6DlDXVWQvRsfYG5v+VMsyqSbX+1NgWw0VoWSHjGji+10v3OocjjC84/HIbzgMhFsGfmuGsDCW/IyO5Y2Pc6lCQ2X0n3BGl9pTBiubWtcVs09BHJYQcSSUPfbegWu6FV2BetN7mMte0yjkSuoPDdfy45iR/W//+eoe1xYiWgW0sNHZjO+5p+Xt8pBVNEToHWymGMdig2oh7XPB53Bx0NhpDvohpJ7lh/ECTsuo4i++je4D3Q5ZOSDG6sRUVRVZ0fxAGLOUJ63rFeocy139upQ6RhgSoM3iRZq73YoKC1MW3MEGmwLttFTp6Pk8c/pxIxbrnU/PyiC4V52y0/RtCKZyXyMafVXQzh4NQLJ0hpzHv9t3tJBVkEvfK8+GTSyalSzS1w3C6P/5G3P+eGD11mmMzs+1qgRtmcN7DfNijFpZrXAqmACABK4ZjbFk7sdoiAd4eREpyLOOeS1dZDwBFGnMY5l8T8MDAR2gjhXJvrCOtcWuUfpFKRTt39WhkNOhXuH49AKuZLPxkLe2b5a8OfjXbLGgt0AtkADh5x4KT7Ii7RueWOF++1OUojSoZCKWWrhVoMkfJwxMuANtHa65kpw1hXzG6qK3m5uhcW3olJSsmSC1wnUb1jihhPtXeikfgAHE7Z41m19Y6tofDFd7Wl4E2mdLHlTzRuB6DxCHZ+zXDKKG/o8XFmlsvHIv1R6LxWPMOSuWLPEa2Ec9vR0GG7v4LO+1VcXF7F/SRy8zGWtD0SOwM8nqVP/tn7jPpqoRI9EtiohVkNkv
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(36840700001)(40470700004)(46966006)(40480700001)(7416002)(6286002)(478600001)(6666004)(55016003)(70206006)(36860700001)(86362001)(2616005)(316002)(107886003)(2906002)(336012)(426003)(1076003)(110136005)(26005)(5660300002)(4326008)(70586007)(8936002)(8676002)(83380400001)(41300700001)(54906003)(2876002)(82740400003)(40460700003)(47076005)(7636003)(7696005)(36756003)(356005)(921008)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 21:49:19.3672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c3c0dd-af63-4856-bc6c-08dbf1ee34e8
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6523
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

This patch introduces a new attribute called adistance_offset to the
node_devices structure.
Using adistance_offset, a node can be migrated to a targeted tier.
Target tier's adjacent distance(adistance) is calculated by taking the
adistance offset into account.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
---
 drivers/base/node.c          | 45 ++++++++++++++++++++++++++++++++++++
 include/linux/memory-tiers.h |  6 +++++
 include/linux/node.h         |  1 +
 mm/memory-tiers.c            | 14 +++++++++++
 4 files changed, 66 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 493d533f8375..1e63c692977b 100644
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
@@ -569,11 +570,54 @@ static ssize_t node_read_distance(struct device *dev,
 }
 static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
+static ssize_t adistance_offset_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int nid = dev->id;
+	int len = 0;
+
+	/*
+	 * buf is currently PAGE_SIZE in length and each node needs 4 chars
+	 * at the most (distance + space or newline).
+	 */
+	BUILD_BUG_ON(MAX_NUMNODES * 4 > PAGE_SIZE);
+
+	len += sysfs_emit(buf, "%d\n", node_devices[nid]->adistance_offset);
+	return len;
+}
+
+static ssize_t adistance_offset_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	int nid = dev->id;
+	int value, ret;
+
+	ret = kstrtoint(buf, 0, &value);
+
+	if (ret)
+		return ret;
+	if (node_devices[nid]->adistance_offset == value)
+		return size;
+	/*
+	 * Request from a node to migrate to a memtier with negative
+	 * adistance is not valid.
+	 */
+	ret = get_target_memtier_adistance(nid, value);
+	if (ret < 0)
+		return -EINVAL;
+
+	node_devices[nid]->adistance_offset = value;
+	return size;
+}
+static DEVICE_ATTR_RW(adistance_offset);
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
+	&dev_attr_adistance_offset.attr,
 	NULL
 };
 
@@ -883,6 +927,7 @@ int __register_one_node(int nid)
 
 	INIT_LIST_HEAD(&node_devices[nid]->access_list);
 	node_init_caches(nid);
+	node_devices[nid]->adistance_offset = 0;
 
 	return error;
 }
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 1e39d27bee41..ff4e7136ab40 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -48,6 +48,7 @@ int mt_calc_adistance(int node, int *adist);
 int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
 			     const char *source);
 int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist);
+int get_target_memtier_adistance(int node, int adistance_offset);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -136,5 +137,10 @@ static inline int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist)
 {
 	return -EIO;
 }
+
+static int get_target_memtier_adistance(int node, int adistance_offset)
+{
+	return 0;
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/include/linux/node.h b/include/linux/node.h
index 427a5975cf40..fd0f4f3177f8 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -83,6 +83,7 @@ static inline void node_set_perf_attrs(unsigned int nid,
 struct node {
 	struct device	dev;
 	struct list_head access_list;
+	int adistance_offset;
 #ifdef CONFIG_HMEM_REPORTING
 	struct list_head cache_attrs;
 	struct device *cache_dev;
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 8d5291add2bc..a40d4d4383d7 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -167,6 +167,20 @@ static const struct attribute_group *memtier_dev_groups[] = {
 	NULL
 };
 
+int get_target_memtier_adistance(int node, int adistance_offset)
+{
+	struct memory_dev_type *memtype;
+	int node_adistance;
+
+	memtype = node_memory_types[node].memtype;
+	/*
+	 * Calculate the targeted memtier abstract distance from
+	 * memtype adistance and node adistance offset.
+	 */
+	node_adistance = memtype->adistance + adistance_offset;
+	return node_adistance;
+}
+
 static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
 {
 	int ret;
-- 
2.25.1

