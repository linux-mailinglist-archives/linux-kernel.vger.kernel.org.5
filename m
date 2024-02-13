Return-Path: <linux-kernel+bounces-64034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2C853930
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437931C2278E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCBB612FD;
	Tue, 13 Feb 2024 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MSPFSBbe"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A899660880;
	Tue, 13 Feb 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846931; cv=fail; b=r8PBNczttkGQj9DAUA7kVznzj0zBLXmTj67WXsbcLME3MXTEM33tEaGKeQeXF1JRREzVOSeZRpyEfaODQB/J3iHQzPnrlg2GtM05tKMCDfbHxrK5CsTeTMmuGo22bKeGKqI/SDDMwrQyN1FrqgKwvU9w3fdjoR8fobuDi+LXWAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846931; c=relaxed/simple;
	bh=6OLGle9uc0UD31kADal+a1zb1ZaRR/c6cmwNOmESWZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpY+1/U5OOBcpUMPjbdynNNh9NzG6otnE+Y9AgywwxMl8qL7yxYua5ATX7bnwnu76h4xQzyCaWYg7fJB2pNhleaixPvynJrSOJyK7LqJQhDQbcNqPVICogJUCVUi0LU44tFBV0DR6WSwh3GWZN1PAW7XS4svzvGNJegdCe3uAjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MSPFSBbe; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrRljppLsCtPl97yTRZI+WW8oDZPsVCaU66qH5eHI/FWti8/Mo4jm4CWn1BRKTUvh0ffcmRK5nisyIeOK0e0XgyxqsNgQxBAxcYNnmvFsYp3NwrVzTRzG7g3sNYLc2IEXASd4+vZtZg/cQIhfClchSdqfFERb31vZMlAW0USvrSEAzQP2PG2bTYzz78MBHJZiof5gkjlD5vpDQ4tuVw5UTfwsp7oH9Mun/8mDG+xUjugtPIyC4Ge9m4DtJlOv/+xl49fOObX9XfcjxsScCQvWmxJDBAhg4Jiov4uQDSgS/VyIAlHFvJ89r3qCi3Ome6a8aww00fupu+YGnwV97IvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdI3EnF53gmpT8AOm+ghTP9I0eBaFUqGBB/XRjLCQ2o=;
 b=CoA5I5gGJXGXrjJo9ta4cNrCGU+31J9z5cJ25G1WJKujvqWPREI3EsgOVLZ0ZMSY4/yaUYBqAxRcz8tYw0GN/FToAm5/cAXGyuMbbbNnOcogmp2kpfry0Ss2jUCs2PBdvXW71qgQWmvErJXHWpRXn+KeMC/Hgu3aWetmT510Iz5dAPe9fghTVMs0YTCcUKauu8CFfR5qM/b5eLizq9OWuZ5mY1YuwPONbe3w0L5Fjwwf2iINkw5LJ2C7i0I0HKXZjB+vjzCREBig6aLGZVG98s3+hWJXFvoFp1W5y2PYvy5MQ4SULpPAQ8bYVzQK97a1gLxAt4c0LnGI9GwGuL57sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdI3EnF53gmpT8AOm+ghTP9I0eBaFUqGBB/XRjLCQ2o=;
 b=MSPFSBbeMJfkGNtO6tcHF28L6fson6CS4QQ/iw01AS70OTvLIRCESBMrWkUiCjMVI0aWjri87qJ6W3MJ3ghtwwRCn2ODlhpXWF6deLpZ9/IZmjcPCCSuYlB0jC1W3hyLRWJyu7yMyKJQhmfbfaUmc+Lr+q27c7c6keZcOWA19mU=
Received: from BN9PR03CA0584.namprd03.prod.outlook.com (2603:10b6:408:10d::19)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 17:55:26 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::66) by BN9PR03CA0584.outlook.office365.com
 (2603:10b6:408:10d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Tue, 13 Feb 2024 17:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 17:55:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 11:55:26 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 13 Feb 2024 11:55:25 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 4/4] remoteproc: zynqmp: parse TCM from device tree
Date: Tue, 13 Feb 2024 09:54:50 -0800
Message-ID: <20240213175450.3097308-5-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240213175450.3097308-1-tanmay.shah@amd.com>
References: <20240213175450.3097308-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdc7416-6009-4d9c-fa1c-08dc2cbcf5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PRLiwO54M9rH8TFrDlG4IKaPJohEHdsZL9G/e6OBeZEcoeDhUhWHjeZ/zzkOC2WIZ74HSOvmCj7E4P6TH08Pj+K62MmltdkHCSaPu26zjJ11hb7eEcQoFiAscpnTg8GVnb6S1OIGsH82QbXudqjNrMq0qyWPwVHcIELx+mmS4DmwMmaVQ8zvYbaF0ph5TOt5XrAk452Pp9MCUCXOpeqrP8BOpm3IuBS6YYFim99X5RqSXt7yLotuv+8U6UksxrXDsVB0v0CYRpzKa9t2HPBmyftVlfpPjAyuivBPMfa0jKOyD89D4/8H/tghMohrfFtVwkLnmPwhohV+SV8cqVgf6YJ4fy3plnOP19UcXnKLM2FaH5LwywhZLch9P0ysThqUrBhQas2Fjojz3lu39eOETJ4xF88+coeDN1+tf5iysx7gSWmfxloPk8RblDt2BeSPJtfiiHcSYLhWLHnoo+dy/jOgQlgL+vxWTY2qGrWqzCyNJGuaUzVQ8fI18My/0uo29Vhuu+mnfpB7Q90mLzEj5xMBMLtjT74ORGJEF1sbOyYQfRcJGckdAMCbok6YwPhf8viR+hNUPbXaYQQmsovlm/yVjdYiUP5aBcHGpeJwG/E=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(82740400003)(44832011)(66899024)(5660300002)(1076003)(86362001)(356005)(81166007)(2616005)(6666004)(83380400001)(70206006)(26005)(426003)(54906003)(316002)(36756003)(336012)(70586007)(110136005)(8676002)(8936002)(478600001)(4326008)(7049001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 17:55:26.7928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdc7416-6009-4d9c-fa1c-08dc2cbcf5bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
is available in device-tree. Parse TCM information in driver
as per new bindings.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v10:
  - Remove redundant changes to handle TCM in lockstep mode

Changes in v9:
  - Introduce new API to request and release core1 TCM power-domains in
    lockstep mode. This will be used during prepare -> add_tcm_banks
    callback to enable TCM in lockstep mode.
  - Parse TCM from device-tree in lockstep mode and split mode in
    uniform way.
  - Fix TCM representation in device-tree in lockstep mode.

Changes in v8:
  - Remove pm_domains framework
  - Remove checking of pm_domain_id validation to power on/off tcm
  - Remove spurious change
  - parse power-domains property from device-tree and use EEMI calls
    to power on/off TCM instead of using pm domains framework

Changes in v7:
  - move checking of pm_domain_id from previous patch
  - fix mem_bank_data memory allocation

 drivers/remoteproc/xlnx_r5_remoteproc.c | 112 ++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 42b0384d34f2..49e8eaf83fce 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -74,8 +74,8 @@ struct mbox_info {
 };
 
 /*
- * Hardcoded TCM bank values. This will be removed once TCM bindings are
- * accepted for system-dt specifications and upstreamed in linux kernel
+ * Hardcoded TCM bank values. This will stay in driver to maintain backward
+ * compatibility with device-tree that does not have TCM information.
  */
 static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
 	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
@@ -757,6 +757,103 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 	return ERR_PTR(ret);
 }
 
+static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
+{
+	int i, j, tcm_bank_count, ret, tcm_pd_idx, pd_count;
+	struct of_phandle_args out_args = {0};
+	struct zynqmp_r5_core *r5_core;
+	struct platform_device *cpdev;
+	struct mem_bank_data *tcm;
+	struct device_node *np;
+	struct resource *res;
+	u64 abs_addr, size;
+	struct device *dev;
+
+	for (i = 0; i < cluster->core_count; i++) {
+		r5_core = cluster->r5_cores[i];
+		dev = r5_core->dev;
+		np = r5_core->np;
+
+		pd_count = of_count_phandle_with_args(np, "power-domains",
+						      "#power-domain-cells");
+
+		if (pd_count <= 0) {
+			dev_err(dev, "invalid power-domains property, %d\n", pd_count);
+			return -EINVAL;
+		}
+
+		/* First entry in power-domains list is for r5 core, rest for TCM. */
+		tcm_bank_count = pd_count - 1;
+
+		if (tcm_bank_count <= 0) {
+			dev_err(dev, "invalid TCM count %d\n", tcm_bank_count);
+			return -EINVAL;
+		}
+
+		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
+						  sizeof(struct mem_bank_data *),
+						  GFP_KERNEL);
+		if (!r5_core->tcm_banks)
+			ret = -ENOMEM;
+
+		r5_core->tcm_bank_count = tcm_bank_count;
+		for (j = 0, tcm_pd_idx = 1; j < tcm_bank_count; j++, tcm_pd_idx++) {
+			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
+					   GFP_KERNEL);
+			if (!tcm)
+				return -ENOMEM;
+
+			r5_core->tcm_banks[j] = tcm;
+
+			/* Get power-domains id of TCM. */
+			ret = of_parse_phandle_with_args(np, "power-domains",
+							 "#power-domain-cells",
+							 tcm_pd_idx, &out_args);
+			if (ret) {
+				dev_err(r5_core->dev,
+					"failed to get tcm %d pm domain, ret %d\n",
+					tcm_pd_idx, ret);
+				return ret;
+			}
+			tcm->pm_domain_id = out_args.args[0];
+			of_node_put(out_args.np);
+
+			/* Get TCM address without translation. */
+			ret = of_property_read_reg(np, j, &abs_addr, &size);
+			if (ret) {
+				dev_err(dev, "failed to get reg property\n");
+				return ret;
+			}
+
+			/*
+			 * Remote processor can address only 32 bits
+			 * so convert 64-bits into 32-bits. This will discard
+			 * any unwanted upper 32-bits.
+			 */
+			tcm->da = (u32)abs_addr;
+			tcm->size = (u32)size;
+
+			cpdev = to_platform_device(dev);
+			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
+			if (!res) {
+				dev_err(dev, "failed to get tcm resource\n");
+				return -EINVAL;
+			}
+
+			tcm->addr = (u32)res->start;
+			tcm->bank_name = (char *)res->name;
+			res = devm_request_mem_region(dev, tcm->addr, tcm->size,
+						      tcm->bank_name);
+			if (!res) {
+				dev_err(dev, "failed to request tcm resource\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
 /**
  * zynqmp_r5_get_tcm_node()
  * Ideally this function should parse tcm node and store information
@@ -835,9 +932,14 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 	struct zynqmp_r5_core *r5_core;
 	int ret, i;
 
-	ret = zynqmp_r5_get_tcm_node(cluster);
-	if (ret < 0) {
-		dev_err(dev, "can't get tcm node, err %d\n", ret);
+	r5_core = cluster->r5_cores[0];
+	if (of_find_property(r5_core->np, "reg", NULL))
+		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
+	else
+		ret = zynqmp_r5_get_tcm_node(cluster);
+
+	if (ret) {
+		dev_err(dev, "can't get tcm, err %d\n", ret);
 		return ret;
 	}
 
-- 
2.25.1


