Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2867E7FFE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377124AbjK3WE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377117AbjK3WEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:04:53 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B31712;
        Thu, 30 Nov 2023 14:04:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5/MHUZndkKKy/wMTpGNxP4CwB9gp4fk81t8/4nRgX5fgSJ6HwxffXGQakIZJ1Hxp9MgZk2xMZLzZgC+AnnVBJZ+OpMB/7CtF6o+QindtEt0HGN5WNdxSZssMG4JpvPVsRVyPOssI0IzN+1aqrd8uJL2pIYRpXursBC2j3M+kZu3MnCy3PunbsbAzBcbs2gj9AemzwStruLuuwxeOIaIG6/gmar4TZAlUA0BlhzpNEIVWoP+4a0mcfcVFkjk/fcfHz8y9IgyGEm+ElpLxZZqQ1PvQyvqb0QamJgOuaVDoCWvIZjyuV8P/jacRky/u8H2to+D9yaKsh5NyFXcuwuY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o52l5LIU7CxjEEjkP4vOMXqkkPzqcXZT78iTMDIBX8k=;
 b=Nn61Y/hMg/QrdvU8327z3ijwhpbbGF8D0N7aJBqK9/uH5L1NXrrV2kvLEP6KPwN1PuIdbJtL04ypbL5VdlpR2QmTBoYMnVGDiW/4mUdtarxZHtLNB6iWxwAtQj4CFbquDvc3tbuNkjM7xfxrXoSg6RH1T2P4xmhHXIDRNlINHBqiTWV9rcT8OSH/33VrnXm5fKKPy4Av21AAS9bazbEQVexTgoM+TQjKpcs0BLqN93wtXXz3wXfHqpeaDtFrF3fuZsvCKNtL6+dxpvD2obNOeCIPNrCJX6qKjYDit4tJw3sA+89YAxKScqy2Db2fTglC7VowT1MJ4aNRJurkZUShZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o52l5LIU7CxjEEjkP4vOMXqkkPzqcXZT78iTMDIBX8k=;
 b=OC0sbkevzytx7VJ2def5zr6kxiRZ+xq3UAXPOq7fpzZPbO9L8mobZFmx0euVk4elNMj6JgsAOIa8d+c8IXULycJm4ei0yDz5FmcLhwmhbEAR5FuHTrH8eqDGKu7Es0dU642liUpUJDaTh6FojGF1NDEsPx0zenb1XnPXwzX0r6X54/jTw3RLzlSOjaVOfc+T44+QqaSx+7sNQQbl09FpDgo/VKh6oWNfHt83auZyBeB09klQO16O5NQ4n/rTNbKShMTPN4QEhF/scLMCdY9jD5x8HXQgG+/Ri5sCt+AndOMAVkxTu4wM/Qhkhjuhz6JJ1B/v4m+NjtApXFe7IPv5qw==
Received: from BYAPR08CA0063.namprd08.prod.outlook.com (2603:10b6:a03:117::40)
 by DM4PR08MB8723.namprd08.prod.outlook.com (2603:10b6:8:18e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 22:04:54 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::80) by BYAPR08CA0063.outlook.office365.com
 (2603:10b6:a03:117::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 22:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 22:04:54 +0000
Received: from BOW36EX19B.micron.com (137.201.85.154) by BOW17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Thu, 30 Nov
 2023 15:04:53 -0700
Received: from micron.com (10.3.67.194) by
 RestrictedRelayBOW36EX19B.micron.com (137.201.85.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Thu, 30 Nov 2023 15:04:46 -0700
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
        <linux-api@vger.kernel.org>,
        Ravi Jonnalagadda <ravis.opensrc@micron.com>
Subject: [RFC PATCH 1/2] base/node: Add sysfs for adistance_offset
Date:   Fri, 1 Dec 2023 03:34:21 +0530
Message-ID: <20231130220422.2033-2-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
References: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DM4PR08MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: bfaaae28-bc5a-4169-8721-08dbf1f061f8
X-LD-Processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2VBLTR1tz4GORoXEczCGqoXuiPkeA6sMBLpOq7fwb3ENEZAIXoHLCKVhZnsMv63KJSAxD9ilwVEsaa+gefmedO0kx737yE4e3t5lTktjzL6/9QlbjOewHr1WqjK42bH1B2NSfUkBQMz7byUR7rd4C0pyky6RP2X/b/WfCgQD/Mjjz/1oyAMPCRWFPuWuQmgzCBhxMqne0TN4pJakdqCpHn7pUxl5U+9629UM56WLIgVTPdeT5aIEDCjWX+YYBH+CcT40HA3kWz7QWsftfkpINN2dh40mqmxA+/gF5++rPVwdDmD4+zoBWRW9vPP2jIES2n/B4OOCZQXTYpArX3elbd+PkuwkHOBtCgFWVmxuYPw3rvhsF5EpdFf3FTmVdlEFQeYAl/6mRgoq3Lrbht041PzHRQAC+w1H0oVDnoR86AyY7EAw075bkVAfdWAfSSqlp2C2+mzv1JavWRmY0hhx4ZSQVOp5QfvCRV77+8Z26p2g6VoSSMykbhzwt2+7wrkCwCtvyY5DmKMy36S53A7jApupvtEJrverYRTPZHBr030ZncSOqiKtOKRAhzXjMyqDcp3aZRkIo5uKGeF4E1L/m41p8beirxzmlNl2zwrk0G8tMWLJJGYZiWLMA0LbsEf/USGjH0AWyQsk/ADvCg1B6SuVhL8SrTx9Y1uexIG8kOKl0jCS/97flWMsejsCjkssu0QQvceTvUKuk4R84wcmO+Bwvj+EpM5n2zZCCOvl0prET3+41iNKlns8caEK6YJoWNPH+zda5ioC7/ero1SLA==
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(55016003)(40480700001)(7049001)(86362001)(40460700003)(70586007)(70206006)(54906003)(7636003)(356005)(82740400003)(36756003)(47076005)(426003)(36860700001)(1076003)(6286002)(26005)(83380400001)(2616005)(107886003)(6666004)(7696005)(110136005)(2906002)(2876002)(316002)(4326008)(8676002)(5660300002)(478600001)(7416002)(8936002)(336012)(41300700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:04:54.0242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfaaae28-bc5a-4169-8721-08dbf1f061f8
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR08MB8723
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

