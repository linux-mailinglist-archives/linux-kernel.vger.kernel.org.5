Return-Path: <linux-kernel+bounces-167043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFFB8BA3CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12218B213B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C1146B80;
	Thu,  2 May 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AOLwvAbi"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F14122C;
	Thu,  2 May 2024 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691443; cv=fail; b=q0itmIytwFE5s3A2K8wPimgD1AauQ2GiHC4/1aEYKTwPQGe3FaUtrpmeSgDqPrLws+2Z7yC1j7m1RjJoWTkmq2DjYJKlRzzZsRLNFWpwzVkcC6mftHh4heVTN+0dLcznxNkcT2n3XiN1wRdypLnJk7rkoQ3Vq5x11TrmJbP2jTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691443; c=relaxed/simple;
	bh=PoS7Dha3KGqqwoJ28J/yKk9CJP2itMHj8kNdelGIqZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWPiZxQOwYCb7kuZIH4poHKtub+m/avY2pq5mvXKechztZSjVpr0CKp4+CcoDM/69A9ZW6W3TSI2ZlB5fF2MtyH1aOA4lcp+cT2k4/Yaecarpsu8pGzaJji8xUcgU8IKIP8SlmR84d7TQLrKDSF338VtN0BwFdj33gz0sO+1yHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AOLwvAbi; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cp1cNBCWVyMXrbnvz0tWqNiO2J6zZnlEOzv8KpL5+8MdhbF0lCbcfSJ94gnw75RIdMuTSK1tDekWIbPJiL87Q5I/uwA/lm5TtAQZF8N7ZNlNBO4Dc7D8/90M1jeTZgyvahTmz1vDG6J5CuSuzd4mKjSdNvVNcEetYZII1TNUTYrwMBuqYkUs/9EUmBNj7kALfv8VaLqlKvEq5PEt70lbtb8a83h6PSbhI3DnPxIEeHIyNY8zEkC8opztn9BjSGsdCbR2wxgCLG8WLIPpRU7T9Q5FndR2/iXBIXI665KeeKei7UfHUrICu9n9ZQf/PocDCiK7HHDdsGIY1hwl/It4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXDKc6VYEK956MMSSut1fS9rPBAkslup61nuht7fmvY=;
 b=km3k847J0r9x9lG/Cws3Uj30J5YnvfE/OVU6bjJSc4dfL3aJaXLI960bs896QvDsVpqJbSI7mbMpJVK726sW0JyZp1Jtt4ZNskCX1YJyOHjhvK9jZsEIlyw+DLmVi4efjd0ghVeBbjlPIAY1Mt5WsrKPFxn68lEh1+QBFjlyj0K+hCvZ5T7Au24D4xuAO5IkJLWp8l1FirS5V1lD0FzrhUUvm4n6eTxsiDM2/Ihwy4PPTltw2JgEmkDAUcVOfe3KQ4BCy5SuT9BWeJK3zXbqnl7dcPcQ5CJZ2NR19PUaWo902LQjAgAi2Yl9lPc/GTPPQgtqKtvanfF6i9bJAGvljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXDKc6VYEK956MMSSut1fS9rPBAkslup61nuht7fmvY=;
 b=AOLwvAbivu3TWO1ez0ibI48AsyIOvy9eWtb1n3WElKZqGg9PaoZ22a2u9E553tS1OOuhrcFfl7RWAcDDCbVNSu2atL5oBLae4rwD0gecS7To3excAx+jC/ff/8Goo1n6ob0Nsz1f0xWXnaR/Hm89VV8scppF4+vBX4GA6hM+DnI=
Received: from BL1PR13CA0211.namprd13.prod.outlook.com (2603:10b6:208:2bf::6)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 23:10:39 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::b4) by BL1PR13CA0211.outlook.office365.com
 (2603:10b6:208:2bf::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 23:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 23:10:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 18:10:38 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 2 May 2024 18:10:38 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Tanmay Shah" <tanmay.shah@amd.com>
Subject: [PATCH 2/2] drivers: remoteproc: xlnx: add sram support
Date: Thu, 2 May 2024 16:10:21 -0700
Message-ID: <20240502231021.370047-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502231021.370047-1-tanmay.shah@amd.com>
References: <20240502231021.370047-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 8422600e-e1dd-4658-1ab9-08dc6afd151a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rMf1icVTJMXJkXEYW3QNaqwBMHDT3bWgj2xhSpGLtw0kbfgEFvDVUh8mRhm2?=
 =?us-ascii?Q?gh8UBP2iT+XtVFzOSc9UeIbbUh8RQ/rwEdF/xADMa8rtW8ijql0A+B1t5j5o?=
 =?us-ascii?Q?g4QOeJsSsLUm0UV1NZsS+Bo/cDupiLX14uVmxRytJFQ8eAQL4w55XayCGxGc?=
 =?us-ascii?Q?qyQcAkQxanTwmyxnAcaqyisvyxf/hjJ0F1QQGLCxnbpS3OFpk0HvjGiPhkD0?=
 =?us-ascii?Q?oID3YNk/gupsbpVPdT85DGWKk1OMbwwl5CCk6FPrf+Q652KMhOOGN9j3LLfG?=
 =?us-ascii?Q?6MAGmWT6eoTl4OW4Ht7TVRSx+vjJukU3bIy6smwnJVUR+KeLJGVIU83MH4gJ?=
 =?us-ascii?Q?m9wBysGXhs6UgqQyF8+qFBQY/K7McjuKDh0fjTsxEjGl+Z5b53uuRIhcI2ug?=
 =?us-ascii?Q?gSq4VumAqUrx8/OhrQqmtqcZHNLYzHjtZBMUpSj0ts4tAYhKCOuvxdI0+eLw?=
 =?us-ascii?Q?r9LqF0qC2WYAdSo6gLaZR3yJwJyR3ZihaKnLtlXLErdQwB3myDc/sbZjFAT4?=
 =?us-ascii?Q?q3xlRabLCkGJ1PZaSOuI2vAlyxFGzLGKgXOHwYeYvfKRE6Z57IsTier3vkan?=
 =?us-ascii?Q?o6r2AJyURJfIwrwSQCAFd9G75rbOxw+AMRsbtfGcLDo+nBA42QzUxpAobP0s?=
 =?us-ascii?Q?mVluZNTlxsfKWKhG7dxF9Lfxr2dcavQ/Lthig/Jr0gRfjeCE2nOnc83g0Dhn?=
 =?us-ascii?Q?wRxG+qT/iGTVxIsLyZD/wO/ZOgNE5/8dQkwz0Trfm61RPYtaoVodtoZHhqhB?=
 =?us-ascii?Q?YdGNgHJ/bS9Lv6oim0ca1RSDXcbq1KaA9YX8t5Yw/sL3g9cWyZ0lRmhx4N/1?=
 =?us-ascii?Q?g6AcGyHsFbolI3wpN56PtigVM/OOnI21Rbl0kbrTrEB9no1u8CG8yO+U/gll?=
 =?us-ascii?Q?Uf2H+h2o7u/yb6IxqAyRkSLMB6UOofGe8PzX1Pk1zYaao1pVfRrP6rdLnT4S?=
 =?us-ascii?Q?fmuEmCw19uU37lU9qgrU1Q2f2lrjH89Yy4335u+pt9LDIv64E6nuNvBe54Yk?=
 =?us-ascii?Q?4KHBLN5mrO4ZQlWp8cV3T5Vi7/h6pA7zZAsu5edxzCX+nQgofrxYEXWFTFae?=
 =?us-ascii?Q?lpSG7otHUGMc2ZviF4ElvGdhcog0jiM2WuivlRPudWSzLLVU/cncsEmsVnBY?=
 =?us-ascii?Q?xcrKJdpq15QQy4vpgjMLHXd5yrkM+CHBhS7EcwlRTIBwOr7qujDV7J2A5N/4?=
 =?us-ascii?Q?fXg0IWMLM42aTe2+BWNhJKZEbhlFdl/cppBwy1eTDOOvJl0GI9O/O4A963tE?=
 =?us-ascii?Q?r0Hd7+Zkp3hRrXjEPGUZMVJbkAINqefzV1p+ata4TuZZ+OPVmLzHnWC880In?=
 =?us-ascii?Q?zxV+c/kwYue2/jOiNqN9Ot/1QBH74HC1ANpIVpDQvt3Tf5TJwtH4GpnfHnGU?=
 =?us-ascii?Q?aFs71tI1wVuQVLnOB9rzXuqQedFz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 23:10:39.2445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8422600e-e1dd-4658-1ab9-08dc6afd151a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556

AMD-Xilinx zynqmp platform contains on-chip sram memory (OCM).
R5 cores can access OCM and access is faster than DDR memory but slower
than TCM memories available. Sram region can have optional multiple
power-domains.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c | 221 +++++++++++++++++++++++-
 1 file changed, 220 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index af7aff5e9098..47c08b013152 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -56,6 +56,21 @@ struct mem_bank_data {
 	char *bank_name;
 };
 
+/**
+ * struct zynqmp_sram_bank - sram bank description
+ *
+ * @sram_res: sram address region information
+ * @power_domains: Array of pm domain id
+ * @num_pd: total pm domain id count
+ * @da: device address of sram
+ */
+struct zynqmp_sram_bank {
+	struct resource sram_res;
+	int *power_domains;
+	int num_pd;
+	u32 da;
+};
+
 /**
  * struct mbox_info
  *
@@ -109,6 +124,8 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
  * struct zynqmp_r5_core
  *
  * @rsc_tbl_va: resource table virtual address
+ * @sram: Array of sram memories assigned to this core
+ * @num_sram: number of sram for this core
  * @dev: device of RPU instance
  * @np: device node of RPU instance
  * @tcm_bank_count: number TCM banks accessible to this RPU
@@ -120,6 +137,8 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
  */
 struct zynqmp_r5_core {
 	struct resource_table *rsc_tbl_va;
+	struct zynqmp_sram_bank **sram;
+	int num_sram;
 	struct device *dev;
 	struct device_node *np;
 	int tcm_bank_count;
@@ -483,6 +502,69 @@ static int add_mem_regions_carveout(struct rproc *rproc)
 	return 0;
 }
 
+static int add_sram_carveouts(struct rproc *rproc)
+{
+	struct zynqmp_r5_core *r5_core = rproc->priv;
+	struct rproc_mem_entry *rproc_mem;
+	struct zynqmp_sram_bank *sram;
+	dma_addr_t dma_addr;
+	int da, i, j, ret;
+	size_t len;
+
+	for (i = 0; i < r5_core->num_sram; i++) {
+		sram = r5_core->sram[i];
+
+		dma_addr = (dma_addr_t)sram->sram_res.start;
+		len = resource_size(&sram->sram_res);
+		da = sram->da;
+
+		for (j = 0; j < sram->num_pd; j++) {
+			ret = zynqmp_pm_request_node(sram->power_domains[j],
+						     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
+						     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+			if (ret < 0) {
+				dev_err(r5_core->dev,
+					"failed to request on SRAM pd 0x%x",
+					sram->power_domains[j]);
+				goto fail_sram;
+			} else {
+				pr_err("sram pd 0x%x request success\n",
+				       sram->power_domains[j]);
+			}
+		}
+
+		/* Register associated reserved memory regions */
+		rproc_mem = rproc_mem_entry_init(&rproc->dev, NULL,
+						 (dma_addr_t)dma_addr,
+						 len, da,
+						 zynqmp_r5_mem_region_map,
+						 zynqmp_r5_mem_region_unmap,
+						 sram->sram_res.name);
+
+		rproc_add_carveout(rproc, rproc_mem);
+		rproc_coredump_add_segment(rproc, da, len);
+
+		dev_err(&rproc->dev, "sram carveout %s addr=%llx, da=0x%x, size=0x%lx",
+			sram->sram_res.name, dma_addr, da, len);
+	}
+
+	return 0;
+
+fail_sram:
+	/* Release current sram pd. */
+	while (--j >= 0)
+		zynqmp_pm_release_node(sram->power_domains[j]);
+
+	/* Release previously requested sram pd. */
+	while (--i >= 0) {
+		sram = r5_core->sram[i];
+		for (j = 0; j < sram->num_pd; j++)
+			zynqmp_pm_release_node(sram->power_domains[j]);
+	}
+
+	return ret;
+}
+
 /*
  * tcm_mem_unmap()
  * @rproc: single R5 core's corresponding rproc instance
@@ -659,6 +741,12 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
 		return ret;
 	}
 
+	ret = add_sram_carveouts(rproc);
+	if (ret) {
+		dev_err(&rproc->dev, "failed to get sram carveout %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -673,8 +761,9 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
 static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
 {
 	struct zynqmp_r5_core *r5_core;
+	struct zynqmp_sram_bank *sram;
 	u32 pm_domain_id;
-	int i;
+	int i, j;
 
 	r5_core = rproc->priv;
 
@@ -685,6 +774,13 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
 				 "can't turn off TCM bank 0x%x", pm_domain_id);
 	}
 
+	/* Release sram power-domains. */
+	for (i = 0; i < r5_core->num_sram; i++) {
+		sram = r5_core->sram[i];
+		for (j = 0; j < sram->num_pd; j++)
+			zynqmp_pm_release_node(sram->power_domains[j]);
+	}
+
 	return 0;
 }
 
@@ -887,6 +983,123 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 	return ERR_PTR(ret);
 }
 
+static int zynqmp_r5_get_sram_pd(struct device *r5_core_dev,
+				 struct device_node *sram_np, int **power_domains,
+				 int *num_pd)
+{
+	struct of_phandle_args out_args;
+	int pd_count, i, ret;
+	int *pd_list;
+
+	if (!of_find_property(sram_np, "power-domains", NULL)) {
+		num_pd = 0;
+		return 0;
+	}
+
+	pd_count = of_count_phandle_with_args(sram_np, "power-domains",
+					      "#power-domain-cells");
+
+	pd_list = devm_kcalloc(r5_core_dev, pd_count, sizeof(int), GFP_KERNEL);
+	if (!pd_list)
+		return -ENOMEM;
+
+	for (i = 0; i < pd_count; i++) {
+		ret = of_parse_phandle_with_args(sram_np, "power-domains",
+						 "#power-domain-cells",
+						 i, &out_args);
+		if (ret) {
+			dev_err(r5_core_dev, "%s: power-domains idx %d parsing failed\n",
+				sram_np->name, i);
+			return ret;
+		}
+
+		of_node_put(out_args.np);
+		pd_list[i] = out_args.args[0];
+	}
+
+	*power_domains = pd_list;
+	*num_pd = pd_count;
+
+	return 0;
+}
+
+static int zynqmp_r5_get_sram_banks(struct zynqmp_r5_core *r5_core)
+{
+	struct zynqmp_sram_bank **sram, *sram_data;
+	struct device_node *np = r5_core->np;
+	struct device *dev = r5_core->dev;
+	struct device_node *sram_np;
+	int num_sram, i, ret;
+	u64 abs_addr, size;
+
+	num_sram = of_property_count_elems_of_size(np, "sram", sizeof(phandle));
+	if (num_sram <= 0) {
+		dev_err(dev, "Invalid sram property, ret = %d\n",
+			num_sram);
+		return -EINVAL;
+	}
+
+	sram = devm_kcalloc(dev, num_sram,
+			    sizeof(struct zynqmp_sram_bank *), GFP_KERNEL);
+	if (!sram)
+		return -ENOMEM;
+
+	for (i = 0; i < num_sram; i++) {
+		sram_data = devm_kzalloc(dev, sizeof(struct zynqmp_sram_bank),
+					 GFP_KERNEL);
+		if (!sram_data)
+			return -ENOMEM;
+
+		sram_np = of_parse_phandle(np, "sram", i);
+		if (!sram_np) {
+			dev_err(dev, "failed to get sram %d phandle\n", i);
+			return -EINVAL;
+		}
+
+		if (!of_device_is_available(sram_np)) {
+			of_node_put(sram_np);
+			dev_err(dev, "sram device not available\n");
+			return -EINVAL;
+		}
+
+		ret = of_address_to_resource(sram_np, 0, &sram_data->sram_res);
+		of_node_put(sram_np);
+		if (ret) {
+			dev_err(dev, "addr to res failed\n");
+			return ret;
+		}
+
+		/* Get SRAM device address */
+		ret = of_property_read_reg(sram_np, i, &abs_addr, &size);
+		if (ret) {
+			dev_err(dev, "failed to get reg property\n");
+			return ret;
+		}
+
+		sram_data->da = (u32)abs_addr;
+
+		ret = zynqmp_r5_get_sram_pd(r5_core->dev, sram_np,
+					    &sram_data->power_domains,
+					    &sram_data->num_pd);
+		if (ret) {
+			dev_err(dev, "failed to get power-domains for %d sram\n", i);
+			return ret;
+		}
+
+		sram[i] = sram_data;
+
+		dev_dbg(dev, "sram %d: name=%s, addr=0x%llx, da=0x%x, size=0x%llx, num_pd=%d\n",
+			i, sram[i]->sram_res.name, sram[i]->sram_res.start,
+			sram[i]->da, resource_size(&sram[i]->sram_res),
+			sram[i]->num_pd);
+	}
+
+	r5_core->sram = sram;
+	r5_core->num_sram = num_sram;
+
+	return 0;
+}
+
 static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
 {
 	int i, j, tcm_bank_count, ret, tcm_pd_idx, pd_count;
@@ -1101,6 +1314,12 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 				return ret;
 			}
 		}
+
+		if (of_find_property(r5_core->np, "sram", NULL)) {
+			ret = zynqmp_r5_get_sram_banks(r5_core);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
-- 
2.25.1


