Return-Path: <linux-kernel+bounces-63413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A63C852EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4A31C2296C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E83E3D3A4;
	Tue, 13 Feb 2024 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZJcHPtjW"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA7137715;
	Tue, 13 Feb 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822967; cv=fail; b=d0LiiA59hGpjW1nAjqjZpC+kF8XkOI2IRy536fJO21eXFSf8JGYO/Dn68PVY6XWBGhW/Nmy/siih0xRx0/ysZgI5N+wlV6SfsXY2Nsc3CI7DWzG9HEr6K+2wx0MUbc+QQOWaZAkCrdQGTtE/4ri5va4rx6QlORe1Q08mgnG/Tzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822967; c=relaxed/simple;
	bh=Apl11HVjbUMRZbtvERcmPJSZcq7c341hvsj4EOgI6lw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fl7mUYgKS5t1ecU3JxBdtuVfg5y+//0HtoVc9/dAWsJqtrEG5I6AbN+GG7RENvRAY1n402wVIjkeNN2GFXObGB940nt5xHCLBHtyd6fuK9b7zU0fbV7ALfzsaqlLWST8kwZWhyyKtiFvzUiXMBStdz4cgRQU2mpj45D3/pRp3Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZJcHPtjW; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWZ77015bRil6X5Xr67cIr1A9juSXF7KKhJjZL3CG1vQVtFPl0fOrWjX5gu8e71/RiV5wmA0TWFlLDhHxfJajwS9BUgeZGyxEe15t0tvPjxDMmbwLVn1ix73EpefPhfMMzfH92Yzqu2dVxf+PFbVUzaSodq/ifAJuNsKcAy7jk1pQUDPPjaTKV/75zK4KF4XLMOHKxHecII0TI7X4FiirqGrmGvmBAxPdYpYK0onhPvvq+Cu3kA+9ub4BpnLqGsnbUhTI5SYYK4jf1gdzX+tQo7RjJM1Lg2ifk1JY94L0RtvwdwMXMwmIbDOc5oe/ODa77IBvWk5UPF1URclRgEKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRR1k1bcbQ7EzfF9+NsdS62xy4Q/64ebL5m5XlOcf3w=;
 b=OSgHiEQcgyjwB9GRAXTSzMS9uCEVA5NuLTiukgZ62MTSt/VEsXtBqaj1AGqykaPXpXO0OWR+J/KgV0MjR83GDu4/r1S5gsKOJgvnij3L2wdLAMYSn9ASVhFSbT8/2VSFN7Ol4drJwAHRpACkvjsi0LTNxwu5kLONgNsDtQrC1vvog3IQ7vOQvGwYh7LjW7/EWnhpp8QpleVnhK0uDfbk28NHDQzvPqW5GOC2KuJh4c5fG0nW+IuuFxvFniZwz8BKHlAPTR/ZOrNUSjY3lnnDaztQdKxJiGEwVQA3Gm3JfGKGPmr2ccfht9PlQ4aNinGO84WpcZZ7bst0qo0IG4N05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRR1k1bcbQ7EzfF9+NsdS62xy4Q/64ebL5m5XlOcf3w=;
 b=ZJcHPtjWxsD8F9HnMan1HyaBtuvSQFnLKI7yz5bWNKR2aHmSM/s1bTCu5b+jH8cYPbLZsut+3lvfJi0ShJFlP94+usKq0CmYrUQrM6TkB7PLEviTWJy88bIfeQ0gP1TPI602+Bg5QFNiwBH4SukHYT/iR043lRqHtMXrgQAqCJI+VB/WZ5R4N5B+A2E799aVYuK4N9IjZOQ/LbIbxM6jXNXqmnmECBeElVYJsG9vgQZp+oqGK4QiGNrQkcvgvzA0d35PKlUm3YevRy/EuODHugo+wgcwEPMaVySOx0VqCsoVH9VwfZqKHSAdi0ztiKEk1Ue6A+4XPknkdH6iIFlokg==
Received: from SJ0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:a03:33e::21)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 11:15:58 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ee) by SJ0PR03CA0046.outlook.office365.com
 (2603:10b6:a03:33e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Tue, 13 Feb 2024 11:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 11:15:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 13 Feb
 2024 03:15:42 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 03:15:42 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 13
 Feb 2024 03:15:41 -0800
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/4] platform/mellanox: mlxbf-pmc: Add support for 64-bit counters and cycle count
Date: Tue, 13 Feb 2024 06:15:27 -0500
Message-ID: <ce1140840b09df3fe2b85e3f87089f2e0d0877d0.1707808180.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1707808180.git.shravankr@nvidia.com>
References: <cover.1707808180.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf02be4-92ce-49d8-60b0-08dc2c852705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GptkxDxOWr6vGiwJeySZJy+G6mqFdiMM/54tE2g9sqfv8BnqoiLYeYIKffHSnrolnu6yZXD4trB5GGnqH6q1pI1nrNh1Fm++N8tz8m6TwBKQY2T5Bzq2acCjPngV2v1M40XA5ej5k0lxhvuZ1cn1LMeTOHU/VkuDBRWb8t6qG2zioCvavmxlYSfEmPjBmyk7yshF8XwXaT30sTnuzqJ09O0C5l4S56zQn+7+YWBk1GJ91insXvOvi4tnX5aAppWiGs+89xLjx8THSok7RztCaj8A5nbEFT1hmxCTT+6lMt1SwRVUvxhTJzDe6gcQ/RqgZy3Tnb6gkkvH1BMwLoa9UvD0Vm5+yDCUrFStGjVHr/tCZcS3mW0bLKDGVYL06AwkeAtXqr2ZDdYzYIvEzavRR9dckIie3ZHhzZhK8itQv7bSFmB0uSg689t1ea0s0LuXaqSXYRzK0QaI5wi3HU3pSBfhqtyJ1n1Oxv+It/nwZaTLfOkP2lEr/XvFCx+ueKAtzo1YcYbS6NmFBEuiywFIbjEDZ8DryVYARqSuAk6dAcGnfV5L7OjbLl38VPgqY7sCqbx8NOwvAQBArOEGrOmvJji+ZCtOkKv4YCV2nmIW4IA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(46966006)(36840700001)(40470700004)(41300700001)(2906002)(4326008)(6666004)(36756003)(2616005)(7696005)(478600001)(356005)(86362001)(7636003)(83380400001)(26005)(426003)(336012)(82740400003)(8676002)(8936002)(5660300002)(110136005)(70206006)(70586007)(6636002)(316002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 11:15:57.6391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf02be4-92ce-49d8-60b0-08dc2c852705
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247

Add support for programming any counter to monitor the cycle count.
Since counting of cycles using 32-bit ocunters would result in frequent
wraparounds, add the ability to combine 2 adjacent 32-bit counters to
form 1 64-bit counter.
Both these features are supported by BlueField-3 PMC hardware, hence
the required bit-fields are exposed by the driver via sysfs to allow
the user to configure as needed.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 134 ++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 250405bb59a7..e2f11c0c63e9 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -88,6 +88,8 @@
 #define MLXBF_PMC_CRSPACE_PERFMON_CTL(n) (n * MLXBF_PMC_CRSPACE_PERFMON_REG0_SZ)
 #define MLXBF_PMC_CRSPACE_PERFMON_EN BIT(30)
 #define MLXBF_PMC_CRSPACE_PERFMON_CLR BIT(28)
+#define MLXBF_PMC_CRSPACE_PERFMON_UOC GENMASK(15, 0)
+#define MLXBF_PMC_CRSPACE_PERFMON_COUNT_CLOCK(n) (MLXBF_PMC_CRSPACE_PERFMON_CTL(n) + 0x4)
 #define MLXBF_PMC_CRSPACE_PERFMON_VAL0(n) (MLXBF_PMC_CRSPACE_PERFMON_CTL(n) + 0xc)
 
 /**
@@ -114,6 +116,8 @@ struct mlxbf_pmc_attribute {
  * @attr_event: Attributes for "event" sysfs files
  * @attr_event_list: Attributes for "event_list" sysfs files
  * @attr_enable: Attributes for "enable" sysfs files
+ * @attr_use_odd_counter: Attributes for "use_odd_counter" sysfs files
+ * @attr_count_clock: Attributes for "count_clock" sysfs files
  * @block_attr: All attributes needed for the block
  * @block_attr_grp: Attribute group for the block
  */
@@ -126,6 +130,8 @@ struct mlxbf_pmc_block_info {
 	struct mlxbf_pmc_attribute *attr_event;
 	struct mlxbf_pmc_attribute attr_event_list;
 	struct mlxbf_pmc_attribute attr_enable;
+	struct mlxbf_pmc_attribute attr_use_odd_counter;
+	struct mlxbf_pmc_attribute attr_count_clock;
 	struct attribute *block_attr[MLXBF_PMC_MAX_ATTRS];
 	struct attribute_group block_attr_grp;
 };
@@ -1751,6 +1757,103 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
 	return count;
 }
 
+/* Show function for "use_odd_counter" sysfs files - only for crspace */
+static ssize_t mlxbf_pmc_use_odd_counter_show(struct device *dev,
+					      struct device_attribute *attr, char *buf)
+{
+	struct mlxbf_pmc_attribute *attr_use_odd_counter = container_of(
+		attr, struct mlxbf_pmc_attribute, dev_attr);
+	unsigned int blk_num;
+	u32 value, reg;
+
+	blk_num = attr_use_odd_counter->nr;
+
+	if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
+			MLXBF_PMC_CRSPACE_PERFMON_CTL(pmc->block[blk_num].counters),
+			&reg))
+		return -EINVAL;
+
+	value = FIELD_GET(MLXBF_PMC_CRSPACE_PERFMON_UOC, reg);
+
+	return sysfs_emit(buf, "%u\n", value);
+}
+
+/* Store function for "use_odd_counter" sysfs files - only for crspace */
+static ssize_t mlxbf_pmc_use_odd_counter_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct mlxbf_pmc_attribute *attr_use_odd_counter = container_of(
+		attr, struct mlxbf_pmc_attribute, dev_attr);
+	unsigned int blk_num;
+	u32 uoc, reg;
+	int err;
+
+	blk_num = attr_use_odd_counter->nr;
+
+	err = kstrtouint(buf, 0, &uoc);
+	if (err < 0)
+		return err;
+
+	err = mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
+		MLXBF_PMC_CRSPACE_PERFMON_CTL(pmc->block[blk_num].counters),
+		&reg);
+	if (err)
+		return -EINVAL;
+
+	reg &= ~MLXBF_PMC_CRSPACE_PERFMON_UOC;
+	reg |= FIELD_PREP(MLXBF_PMC_CRSPACE_PERFMON_UOC, uoc);
+
+	mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
+		MLXBF_PMC_CRSPACE_PERFMON_CTL(pmc->block[blk_num].counters),
+		MLXBF_PMC_WRITE_REG_32, reg);
+
+	return count;
+}
+
+/* Show function for "count_clock" sysfs files - only for crspace */
+static ssize_t mlxbf_pmc_count_clock_show(struct device *dev,
+					  struct device_attribute *attr, char *buf)
+{
+	struct mlxbf_pmc_attribute *attr_count_clock = container_of(
+		attr, struct mlxbf_pmc_attribute, dev_attr);
+	unsigned int blk_num;
+	u32 reg;
+
+	blk_num = attr_count_clock->nr;
+
+	if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
+			MLXBF_PMC_CRSPACE_PERFMON_COUNT_CLOCK(pmc->block[blk_num].counters),
+			&reg))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%u\n", reg);
+}
+
+/* Store function for "count_clock" sysfs files - only for crspace */
+static ssize_t mlxbf_pmc_count_clock_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct mlxbf_pmc_attribute *attr_count_clock = container_of(
+		attr, struct mlxbf_pmc_attribute, dev_attr);
+	unsigned int blk_num;
+	u32 reg;
+	int err;
+
+	blk_num = attr_count_clock->nr;
+
+	err = kstrtouint(buf, 0, &reg);
+	if (err < 0)
+		return err;
+
+	mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
+		MLXBF_PMC_CRSPACE_PERFMON_COUNT_CLOCK(pmc->block[blk_num].counters),
+		MLXBF_PMC_WRITE_REG_32, reg);
+
+	return count;
+}
+
 /* Populate attributes for blocks with counters to monitor performance */
 static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_num)
 {
@@ -1784,6 +1887,37 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
 		attr = NULL;
 	}
 
+	if (pmc->block[blk_num].type == MLXBF_PMC_TYPE_CRSPACE) {
+		/*
+		 * Couple adjacent odd and even 32-bit counters to form 64-bit counters
+		 * using "use_odd_counter" sysfs which has one bit per even counter.
+		 */
+		attr = &pmc->block[blk_num].attr_use_odd_counter;
+		attr->dev_attr.attr.mode = 0644;
+		attr->dev_attr.show = mlxbf_pmc_use_odd_counter_show;
+		attr->dev_attr.store = mlxbf_pmc_use_odd_counter_store;
+		attr->nr = blk_num;
+		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
+							  "use_odd_counter");
+		if (!attr->dev_attr.attr.name)
+			return -ENOMEM;
+		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
+		attr = NULL;
+
+		/* Program crspace counters to count clock cycles using "count_clock" sysfs */
+		attr = &pmc->block[blk_num].attr_count_clock;
+		attr->dev_attr.attr.mode = 0644;
+		attr->dev_attr.show = mlxbf_pmc_count_clock_show;
+		attr->dev_attr.store = mlxbf_pmc_count_clock_store;
+		attr->nr = blk_num;
+		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
+							  "count_clock");
+		if (!attr->dev_attr.attr.name)
+			return -ENOMEM;
+		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
+		attr = NULL;
+	}
+
 	pmc->block[blk_num].attr_counter = devm_kcalloc(
 		dev, pmc->block[blk_num].counters,
 		sizeof(struct mlxbf_pmc_attribute), GFP_KERNEL);
-- 
2.30.1


