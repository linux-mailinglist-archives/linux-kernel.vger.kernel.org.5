Return-Path: <linux-kernel+bounces-44323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B99484203F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6521F25B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830267E68;
	Tue, 30 Jan 2024 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pskvQ+0T"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11C605C1;
	Tue, 30 Jan 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608452; cv=fail; b=DfD8+l9EMl3CGAqjF7uVSY8ejnnnY1rwflQG/JaMmeoqeoIQWrNKuGEbzJkHBErRqw/KxHrc9E6NfV25jQa4aiHucBvYurwRW3GU37PbNrRRIB3QrU91FytRZU1u2LuD1CRivu60V/BvW9AZk+HNR8oI5gGZRuLL6a2/uzoNDQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608452; c=relaxed/simple;
	bh=+PpSn9ZF5wuHmUbO/boB/GIupW+Npykoe72YsWokYAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nu6DaJcpXVfv27Fc+3IpiMwVUy2MJArsbl+qEc210+vVqmea3HGEcqeFRzPq8UFQJbUUPHfwlrqHILMVUWWkF8W6pfAarAunU4NpjjMwwzeGxvdTeTgeECdmIO59xb2yYIk7DPJb+3gq42927BdGL5NCTuD6iCAr6/JSl1JW5VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pskvQ+0T; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVuTjsRA4WINc6/kKh2ZIuVzDMUhMCkjeTrI2SxVR1YoT/Uczl8c/+fhhXy9smbLU9zwcTefSMZqVt0BUeS+pt74YNP0u76dEmZvmIWWUilVqYVwOQ9qKFWNGWBNUfCXTQhnafmFgtHTf1zNPEBwxY1grXRQVioo0jBtg3pD2JBgMtPgMmBqOMFtDzMlHka+PJMrVqqEVG0hp1Fsq7jdSPRayoqLnuSo+XVjC+TQWK9o/OyQjsOKoBofqElHvfTXAS6Z4ejdda3rzuyThstCf2TDNwobHx4JelAwZQcLbMcgCao8QKYe4e0PRO6jCYdGgFHTQXrH00ZLQlrCBMcaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gojxaqa+ZYzhBD9s5n7xbTlgBNiclJ0NWRWkKQ9OC10=;
 b=CNlJ1sTR7mMNr982RmC/hsUd/GB83hEWmI7AtsIfeStelAeWAGJAy0nnvHzPR/1VPgZYtn1OT45B1VBHwTaw7jpOupDcE2WEprb8SuHHjQ01Bgu5uIyo2bYd/EV5kF6WMoX0uhUCEhM0863uWp3kjkhX4ZNQCa74lkC+ApjCBv6NpWcKuheN+Bjjm1pcjw5Q98BhfjayZoFaQvuqVwKWg/PRt9Y5Hpde5DGZH4vTFQBjpcmxwTFE3DGYSY7GdPyAimxKiZcZA/hi0P4gO3c2jFl0PEkFyOwkr6xCnGJYoDmH8bpGdDgR2rGsKggxLp29Xr/f8RJqgNCqHIeaDYLHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gojxaqa+ZYzhBD9s5n7xbTlgBNiclJ0NWRWkKQ9OC10=;
 b=pskvQ+0TlcH82O2x6uheaIx5VQD0BQ5Oo52kRovsldrrmsHmNswxI9s0cxY8DuwxrTgo+KHPxmjQmXixB9LamG8ljEoTUq6QpPHBJc1AfQ1061U/NvBtZDfq9tGU3/j7LJhp0W4hnnXBaPNF04QzEyrhWfU8qjpZtmz/MKy2WQePMo9d93Z/CkL+lWHLk1ufyimXhIQJI6+beZkIe1NnW+bZ/eSrZKYIL3OzU5J0OjWG8BJ8Oqfrt1Jn7SJYGPdOpj98zQDHeg9st/N4dZIjYcKRK4s1MvKMp63Cd0O6/ICZ3G/rddKkHsAY24c/DFOhu0EwApu8wFs0eb33KjaDwg==
Received: from DM6PR18CA0020.namprd18.prod.outlook.com (2603:10b6:5:15b::33)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 09:54:08 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::49) by DM6PR18CA0020.outlook.office365.com
 (2603:10b6:5:15b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 09:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 09:54:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 01:53:55 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 01:53:55 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Tue, 30 Jan
 2024 01:53:54 -0800
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] platform/mellanox: mlxbf-pmc: Add support for 64-bit counters and cycle count
Date: Tue, 30 Jan 2024 04:53:47 -0500
Message-ID: <4fab3112d17a4bd2edbee66a8e77695943cbaf5a.1706607635.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1706607635.git.shravankr@nvidia.com>
References: <cover.1706607635.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: a24c976a-07f8-40c9-0152-08dc217966d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZsjJn6Mnj7w0f9CUEehVfGa3DZEq5og4W6oBmUdpq5oNx98TzvzEZ4r5lsNIDE5spKyYJLukKQ4XIouWihq8yjYFhxu4f5l8a4ehB5G8eMWD6FshKzZIUbopOvWfNYXXSWf6Xxu+HDNTy0TeBh5LgBzUe70z5t8FyxUo+tDhLLvBIxnYsUkl2kQQZCbDtYI6F/hFMTBjP38K2D2/DH3FvHOpn/31bfFurniPEmP2Dy3pafPGIVRYaDu5VWrLapYeNaN/w/Pnxn4Em1CRp1w7UzvTORcVo5Pwj51+chwzr9EhCbrE5DEjSkgMFCLSOTfh+de+Q5AQr3JndJqRv78DqnyHiYzOz3bQMvQpKIc5x1dlQ9DTBX4FbdhYakXNg7VBscnt+kUzCcpRT417PQf3VUv6gE2Y0PJrrqQ92OHj/6JuRiKqI/mehriumwGCS48qKxSBAcJG7iO/t9TzNR2qHCn4mudmnpS4BGVKpRsfDegTfN57zK9+BAywXYF0W2OVxKglFwvlqWv3llRurK1gUhO2OuKDYP+APU0HO1137OwLxsStZCUUlxjZmcMQFmeLKjQK7YO30wH7AjHE/vXqB0inXCmTnktrFcnubAZlUvyxUZ8R0i1hijdYS8WWK1bitCPhuTannevHoKbyKzhvrfm0lt4uQvuWGS/zBG5yANn9U/lKHatjvVO/PlX8iwcdN3ht3+Id6hB4NE1d3SfKccXQIPCD9dxjqwNIBIVQSsQJkpnQ8rphc+HbpSipMi8W
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(41300700001)(2616005)(7696005)(426003)(336012)(26005)(70206006)(316002)(70586007)(6636002)(4326008)(8936002)(8676002)(478600001)(6666004)(110136005)(36860700001)(82740400003)(83380400001)(54906003)(356005)(7636003)(47076005)(36756003)(40460700003)(40480700001)(5660300002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 09:54:07.8028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a24c976a-07f8-40c9-0152-08dc217966d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363

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
 drivers/platform/mellanox/mlxbf-pmc.c | 132 ++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index b1995ac268d7..906dfa96f783 100644
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
@@ -1759,6 +1765,101 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
 	return count;
 }
 
+/* Show function for "use_odd_counter" sysfs files - only for crspace */
+static ssize_t mlxbf_pmc_use_odd_counter_show(struct device *dev,
+					      struct device_attribute *attr, char *buf)
+{
+	struct mlxbf_pmc_attribute *attr_use_odd_counter = container_of(
+		attr, struct mlxbf_pmc_attribute, dev_attr);
+	int blk_num, value;
+	uint32_t reg;
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
+	return sysfs_emit(buf, "%d\n", value);
+}
+
+/* Store function for "use_odd_counter" sysfs files - only for crspace */
+static ssize_t mlxbf_pmc_use_odd_counter_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct mlxbf_pmc_attribute *attr_use_odd_counter = container_of(
+		attr, struct mlxbf_pmc_attribute, dev_attr);
+	uint32_t uoc, reg;
+	int err, blk_num;
+
+	blk_num = attr_use_odd_counter->nr;
+
+	err = kstrtoint(buf, 0, &uoc);
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
+	uint32_t reg;
+	int blk_num;
+
+	blk_num = attr_count_clock->nr;
+
+	if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
+			MLXBF_PMC_CRSPACE_PERFMON_COUNT_CLOCK(pmc->block[blk_num].counters),
+			&reg))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%d\n", reg);
+}
+
+/* Store function for "count_clock" sysfs files - only for crspace */
+static ssize_t mlxbf_pmc_count_clock_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct mlxbf_pmc_attribute *attr_count_clock = container_of(
+		attr, struct mlxbf_pmc_attribute, dev_attr);
+	int err, blk_num;
+	uint32_t reg;
+
+	blk_num = attr_count_clock->nr;
+
+	err = kstrtoint(buf, 0, &reg);
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
 static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
 {
@@ -1792,6 +1893,37 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
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


