Return-Path: <linux-kernel+bounces-148050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 447E48A7D12
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED03E2830BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7665974C09;
	Wed, 17 Apr 2024 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k1ezgA9f"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6537C7175E;
	Wed, 17 Apr 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339057; cv=fail; b=kefUN2NAC7tSgl8M2qdS2DsI4omvwUvUqMuJ5XwnauJC98UgCcLhNUdbAl48jGdnqUyUFPUPB8TznxSmp4kdJdCi4srSpZaUq9YdW101I2nb+l0Ww6eKmJ6HAjRi1OvnNEJAkIa8i7FP7Irde090sWYIOTD0DZ4vtk2I10+H9vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339057; c=relaxed/simple;
	bh=aYSUZfhA72SyOQKsZXyMWyiNDtSadMWs15VX4HBM4QQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mv9uxcqDlztYnByoCzWQyX9YTfmHMLj3orsaSk2xLpLl9prOov7K1/gJbvuxbEGBZ6n3xMNn918D+sOaYkktdV6NgmcIUJ2LH1bLNCq5Zg3gGQGy5NxuntyaiLeD2q6QkEHWhpc9ObdTrWw+hTSDXtvesuFp+jhw8kMCaUkrYoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k1ezgA9f; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7SaaTrAag9HCW0h3VWd+LmxhukYa7s1zfITGOkN1lZxii/CKPagy33x8pNEgYWu40fwa6yd2jxp2/+m23PQak48Yr4fVO0juki+SQqFMwAT1im+ib3bLI4JzXEPwBF7t/Jqo2xFDU5Hlgk9DIRGsCecmNd5GMAZJgHr/Od5EBdvTZyZkhgvv+D+lNd/HrKBLupSF3TEkBNGM734htjzjz2P3otRUjx8Bx7ajww2CKqvmjGdkwHY35X0Qb5qvAPayigTjCTqTOcSiVoOiql5+PMBKmyVlgZ3ffEP7Y1eXItnpyBka5KQ2p+/Gh0NbEN3UANJmMMnAtDkmhaCGS6QRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yl0n7QsT9YnrQ1Cfhcglm5itVaGQMpNsx25HsUjDrEY=;
 b=GGDm9/624Xlptmld+bT6XfHyHGFeS6EnxLMyXT1ox6KFs/FvpeWk54oWo2ACT8qmlhFtBe8mXtBR4nnkwglC6ggRtMu9q2vqE4SQ7Xi6AzxYLwqFc+LBHeNzrL5xr/HGCRRw+o1bHg93GmQFcSbaYQ+0KkGjNJlKz9TNu9cby3bZqrotmzW370iXYvRNKoYQ2L0QiAYfs3B6eVLQWuoxorzHOgsmQFR18Nwz2Zyuo9PLkw372wTwoUv/hkvWBYePEmCj19coxUKLrD7o+SqXLHRXD6u8S4EiucYHXGK53YU0wIPW5DBYU6mC/rsLoRRYOkk9F88EPWyuJwHN/2BR4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl0n7QsT9YnrQ1Cfhcglm5itVaGQMpNsx25HsUjDrEY=;
 b=k1ezgA9f/MNivGg1a4Mh3f6y1GNE6lTxi0NozrJ5xaVOIrIr2zVaXVp2m3eHWIdOz/euw+3SaDEIvssKq6OomG+xhqub9wYgLDZD3R+rNt6rkvGt4hbJgkPtEHF6LBi0/CzM/4hAP5Rztdm14lcj8P7geTvIfYeVdAszos1pavETF0UIl6HFUKYVRvbVQam06kTS0iTN2EDdHVbPAj94JkYFfs7MvFSQ5YU03nBdNxGpeti2HMd3fhVEQYimR6id1GL9C4pXBfvLiNzo43E0KmUbdqjUGyi0/kkYcXJy5wsETOS5GDuLOfQzpmoh+UC2PKD8qGZBIfUrVfI7pnNW/A==
Received: from DM6PR08CA0018.namprd08.prod.outlook.com (2603:10b6:5:80::31) by
 IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 07:30:51 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::14) by DM6PR08CA0018.outlook.office365.com
 (2603:10b6:5:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.23 via Frontend
 Transport; Wed, 17 Apr 2024 07:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 07:30:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Apr
 2024 00:30:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 17 Apr 2024 00:30:34 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 17 Apr 2024 00:30:33 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] platform/mellanox: mlxbf-pmc: Add support for 64-bit counters and cycle count
Date: Wed, 17 Apr 2024 03:30:17 -0400
Message-ID: <aec3aaa44a5738940b2511726177976336a6c72d.1713334019.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1713334019.git.shravankr@nvidia.com>
References: <cover.1713334019.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f178ef-c55c-4229-fcba-08dc5eb04efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WIDnOVb3BeIjrkrf/AJMp2ZbuR35eT9ZjHkMaGshPW8Tz+eiw8JNOr+O61ybrGhkc0Rc/GvfffTUveFx3ctOWc3yEMHSccLCUY+3kgRsvmKZhcRnDW8D6HS9TDG8REPI6E+s9zuVZ3ofa74G2i8Qcak8b+1A6c0SR0OTQopivHppWhaI/kNVGyY/3F7mV2I/RgnlmIQ27ucL2d8GXTPrIfLSl0hi8L6/iot/iIdpCX7+NdKR5LeQvIIltRAaBc6dXT19TUGVYFk67bKKHGAZCcapAPFQGhqt/MI2mNyAIwGJkfX9F/iJybgKxmO5nIxBI/cLOyYlHIQcqHUhjA0nnmEqZ60PyxyMX94XguQmhhnoCYpX38zlTbUArSvd1C8d0PHRkahtx2zNdbEUwKmlr2mMopZMdfG9lqW6FAby6v3XN+OenXJ7otNi/hRev82ooZAxMVqro0f1sJUueEZqUwMY06mujnm3rEQxDllipXCgH6FSs9paJ0O8itX9a4bgZqDtQO+f19frF43495NXYnNornAdR9hKLAKfyMEpze+aNaM7UbFhoPFsfVCVeR/+632q2IFFqcuTx4sK+I7QwI5aYryujSGWDFUN7YFL55qVlWTuvvAfKKzqk/CzEdRZwsabds7R2GCoEFgwhWn7VMRsb9fOy1Urs8mKnwfjcxRvuQsDCXPp6Z7i448bPMZsONHd5mZ7+V1chleMCWFTaoGKR+f5B1BhROrUkT87N5U/PkFWDsIKc/7w6K+08iZb
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 07:30:51.0688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f178ef-c55c-4229-fcba-08dc5eb04efa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211

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
index 4ed9c7fd2b62..635ecc3b3845 100644
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
@@ -1763,6 +1769,103 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
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
@@ -1799,6 +1902,37 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
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


