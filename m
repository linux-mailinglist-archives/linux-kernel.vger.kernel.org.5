Return-Path: <linux-kernel+bounces-135920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B82B89CD16
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B708D1F2246F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB71487C0;
	Mon,  8 Apr 2024 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EHuHNHUt"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A35A1465AB;
	Mon,  8 Apr 2024 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609644; cv=fail; b=KabBKhu8uixKafe2J0tCecIXD+gejo42dHceh+Lj+S1yxETDzGuc72oSGFFZV+QOjLtMh0hme3R/j5EhJU+tEfl97qDYT2MZ5kVQS4U24e9GHrJfyPuERoHCFiGYHrZOlLt4wRxF9tcjVqmuDW/36KuOV39601HnfGXQsZObEKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609644; c=relaxed/simple;
	bh=NB0eOtiqFlMSoEWXBvtV7QgRZOpf01bZ61XhUTCNNU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oljpw5hVKrfoCAYXszcRED5Ixk47yO6H5Aqb7u6sC2hROr9uNt5d+cXCLKiiWf4Chmm9sHrjYkSYjwqkt2uimaDTvmQjJ3CKO65FRLCHOmeZVHAB7EzFYcGkT9IZqS5ijoYglUHK/LXXn39SjJldAXQwZx/PR3HScxA1Yym5uro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EHuHNHUt; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqp8bkYpd7X7GUOcgEZ0LkTSy8jSkxVwV2itAAEzrFtxluPITbkZ/ea9QKOrvjRFkXCtsyencDPZzyGKpQpvsJfZEzJ1QfqjHrx5jCbUciusfY7jsQNVGoZmdVSRskZ/4wRj+Ge22MN2mm3McgeLoHGdlZaVyoojOPIkk4ZSzc/2cpa8DMQtyWGn4c6yV3TwipO96EOy94Gg3K9DHCrfLh91Mpg6qVRn2wG6DoXyY2SU1Tpq2chHa0zB5Knp/NyyLSdBFaTx3uhCLplvj/kPnGIIEM+yqF3D5e9SB4eK1gYOjGW8q2NgLlzkpFpf7kV/ezKm0m7kx5JSss/5n4zC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyo58WNyCKwdye/UzAMvtllU8L6elmNDMUgLwJhX3sY=;
 b=cqYjqpLtW6/fJKUHXX1fWaSMfGuO/i9INCwYomH5/C+ET1NHYi4Nbsj+Iydu8bmvg3q5TTORtHbpYZIs4VH1xEAdkRgOwJ04Jw7DG9dzH2na0RRQFAsoK6Hi/yrPEPnD49U/LFSrPbWpGAQ+SrdLG5Ob/HFDTnPH/Eqz5JqWPyIZQQEMiN5QRiYkqvbqQ1rZiRmMugd1MwezKNcuyPyLyX4w+ehrSF6CMnKVPSWTtbjZBXnUJ3q1jHYkTwxlkhVRJ3r/it+rciV71NNlBW4QRTlpiSP//pw0ByYAO3muvsLSS/lk8pHTjLqI5hG4nQTfQ8beU2XLiXc0EkJTadstQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyo58WNyCKwdye/UzAMvtllU8L6elmNDMUgLwJhX3sY=;
 b=EHuHNHUt83X1WQcSW1+/6B4W4xvYYkFsgLJDmuo3L9xJbKozw8UwXTKW71J3mFMQEhXEzMmwlqORoXDCY6qUFMSTuaU/DOoJPhHKbyzfthbl5ATbfz+7uXGxHXhFMOGm4qosbQ1hWa7iyfLE9jumuU9PUi6rVgpNo9ApetlRKcE=
Received: from MN2PR20CA0056.namprd20.prod.outlook.com (2603:10b6:208:235::25)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 20:54:00 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::23) by MN2PR20CA0056.outlook.office365.com
 (2603:10b6:208:235::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 8 Apr 2024 20:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 20:54:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 15:53:59 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 8 Apr 2024 15:53:58 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 1/4] remoteproc: zynqmp: fix lockstep mode memory region
Date: Mon, 8 Apr 2024 13:53:11 -0700
Message-ID: <20240408205313.3552165-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408205313.3552165-1-tanmay.shah@amd.com>
References: <20240408205313.3552165-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: fe03c925-4252-4bdf-6379-08dc580e0423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/uunMSXISOLiX0iwUAM9nqpRF2QW4CozAKk5YvgFul0GBjsGewE3WtztGjSZhVTRwGTcZ118Qv6sYIK/VmX8REx7Ed2Rpd6rO+GXx8Z7ETgI6GKJ9KDdtQUXeEVD3UDtz/Ov0XUONXBf2H39G99btv++3Bk6zX6PXDI7HHdJSJFRBFoLA0XwvV77q6OgwglSLqqE0P7U0B6X9EuFALn4DNlEl+9JjsCCEormMDhgCU5W73kVcBaLN/1NauwPiCPbGBTEPzCFz7hs4GZeyVBR+8UYGEy7b1UbqAcWSRj6lR19fdjNSSpC0WPaOwoNah3LY6bgGjboyZVxlLP94Ezv6N0a3X1RQJP6yoKMkytKGfZFfWm9zLGLEUCP0wSLnaxDIP7OXVfSHQ4giNjD+OltERGFJf9LXdMumVwpG7r+p+9ZKHbZdU8WAjDmPeWuHJSSHOxEVA/AKsmJlRW5u8hIDbfRc2kYedlAzL7vdd2t7MjViO/2u2V32wjiStBg341uv/31G9uyR3VkU183LboXGfhLnFhnl1/R7daX974SgCtR9PSBOq8caITBCFvzcaX/kxf4eDcPwD04zdAo4kQE4dphChkDZH4I+IxljMkHa9+i4OmY5E9kiEFNB1RM+D3wgj4h7Q36A+e2HHo4X/VNNRIg4AOcJ+PsBHWoBCzd4y2Ili32KK90ssWkx+6AladB3zM8PiTvRzETcrFMoHUxWT0PHpBBY8nilMGlIOZ5wHwshGQC1GukRD62Hn4TZ3wm
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 20:54:00.0888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe03c925-4252-4bdf-6379-08dc580e0423
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742

In lockstep mode, r5 core0 uses TCM of R5 core1. Following is lockstep
mode memory region as per hardware reference manual.

    |      *TCM*         |   *R5 View* | *Linux view* |
    | R5_0 ATCM (128 KB) | 0x0000_0000 | 0xFFE0_0000  |
    | R5_0 BTCM (128 KB) | 0x0002_0000 | 0xFFE2_0000  |

However, driver shouldn't model it as above because R5 core0 TCM and core1
TCM has different power-domains mapped to it.
Hence, TCM address space in lockstep mode should be modeled as 64KB
regions only where each region has its own power-domain as following:

    |      *TCM*         |   *R5 View* | *Linux view* |
    | R5_0 ATCM0 (64 KB) | 0x0000_0000 | 0xFFE0_0000  |
    | R5_0 BTCM0 (64 KB) | 0x0002_0000 | 0xFFE2_0000  |
    | R5_0 ATCM1 (64 KB) | 0x0001_0000 | 0xFFE1_0000  |
    | R5_0 BTCM1 (64 KB) | 0x0003_0000 | 0xFFE3_0000  |

This makes driver maintanance easy and makes design robust for future
platorms as well.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c | 146 ++----------------------
 1 file changed, 12 insertions(+), 134 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index cfbd97b89c26..0f942440b4e2 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -84,12 +84,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
 	{0xffeb0000UL, 0x20000, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
 };
 
-/* In lockstep mode cluster combines each 64KB TCM and makes 128KB TCM */
+/* In lockstep mode cluster uses each 64KB TCM from second core as well */
 static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
-	{0xffe00000UL, 0x0, 0x20000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 128KB each */
-	{0xffe20000UL, 0x20000, 0x20000UL, PD_R5_0_BTCM, "btcm0"},
-	{0, 0, 0, PD_R5_1_ATCM, ""},
-	{0, 0, 0, PD_R5_1_BTCM, ""},
+	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
+	{0xffe20000UL, 0x20000, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
+	{0xffe10000UL, 0x10000, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
+	{0xffe30000UL, 0x30000, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
 };
 
 /**
@@ -541,14 +541,14 @@ static int tcm_mem_map(struct rproc *rproc,
 }
 
 /*
- * add_tcm_carveout_split_mode()
+ * add_tcm_banks()
  * @rproc: single R5 core's corresponding rproc instance
  *
- * allocate and add remoteproc carveout for TCM memory in split mode
+ * allocate and add remoteproc carveout for TCM memory
  *
  * return 0 on success, otherwise non-zero value on failure
  */
-static int add_tcm_carveout_split_mode(struct rproc *rproc)
+static int add_tcm_banks(struct rproc *rproc)
 {
 	struct rproc_mem_entry *rproc_mem;
 	struct zynqmp_r5_core *r5_core;
@@ -581,10 +581,10 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
 		if (ret < 0) {
 			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
-			goto release_tcm_split;
+			goto release_tcm;
 		}
 
-		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, da=0x%x, size=0x%lx",
+		dev_dbg(dev, "TCM carveout %s addr=%llx, da=0x%x, size=0x%lx",
 			bank_name, bank_addr, da, bank_size);
 
 		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
@@ -594,99 +594,16 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 		if (!rproc_mem) {
 			ret = -ENOMEM;
 			zynqmp_pm_release_node(pm_domain_id);
-			goto release_tcm_split;
-		}
-
-		rproc_add_carveout(rproc, rproc_mem);
-		rproc_coredump_add_segment(rproc, da, bank_size);
-	}
-
-	return 0;
-
-release_tcm_split:
-	/* If failed, Turn off all TCM banks turned on before */
-	for (i--; i >= 0; i--) {
-		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
-		zynqmp_pm_release_node(pm_domain_id);
-	}
-	return ret;
-}
-
-/*
- * add_tcm_carveout_lockstep_mode()
- * @rproc: single R5 core's corresponding rproc instance
- *
- * allocate and add remoteproc carveout for TCM memory in lockstep mode
- *
- * return 0 on success, otherwise non-zero value on failure
- */
-static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
-{
-	struct rproc_mem_entry *rproc_mem;
-	struct zynqmp_r5_core *r5_core;
-	int i, num_banks, ret;
-	phys_addr_t bank_addr;
-	size_t bank_size = 0;
-	struct device *dev;
-	u32 pm_domain_id;
-	char *bank_name;
-	u32 da;
-
-	r5_core = rproc->priv;
-	dev = r5_core->dev;
-
-	/* Go through zynqmp banks for r5 node */
-	num_banks = r5_core->tcm_bank_count;
-
-	/*
-	 * In lockstep mode, TCM is contiguous memory block
-	 * However, each TCM block still needs to be enabled individually.
-	 * So, Enable each TCM block individually.
-	 * Although ATCM and BTCM is contiguous memory block, add two separate
-	 * carveouts for both.
-	 */
-	for (i = 0; i < num_banks; i++) {
-		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
-
-		/* Turn on each TCM bank individually */
-		ret = zynqmp_pm_request_node(pm_domain_id,
-					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
-					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
-		if (ret < 0) {
-			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
-			goto release_tcm_lockstep;
-		}
-
-		bank_size = r5_core->tcm_banks[i]->size;
-		if (bank_size == 0)
-			continue;
-
-		bank_addr = r5_core->tcm_banks[i]->addr;
-		da = r5_core->tcm_banks[i]->da;
-		bank_name = r5_core->tcm_banks[i]->bank_name;
-
-		/* Register TCM address range, TCM map and unmap functions */
-		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
-						 bank_size, da,
-						 tcm_mem_map, tcm_mem_unmap,
-						 bank_name);
-		if (!rproc_mem) {
-			ret = -ENOMEM;
-			zynqmp_pm_release_node(pm_domain_id);
-			goto release_tcm_lockstep;
+			goto release_tcm;
 		}
 
-		/* If registration is success, add carveouts */
 		rproc_add_carveout(rproc, rproc_mem);
 		rproc_coredump_add_segment(rproc, da, bank_size);
-
-		dev_dbg(dev, "TCM carveout lockstep mode %s addr=0x%llx, da=0x%x, size=0x%lx",
-			bank_name, bank_addr, da, bank_size);
 	}
 
 	return 0;
 
-release_tcm_lockstep:
+release_tcm:
 	/* If failed, Turn off all TCM banks turned on before */
 	for (i--; i >= 0; i--) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
@@ -695,45 +612,6 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 	return ret;
 }
 
-/*
- * add_tcm_banks()
- * @rproc: single R5 core's corresponding rproc instance
- *
- * allocate and add remoteproc carveouts for TCM memory based on cluster mode
- *
- * return 0 on success, otherwise non-zero value on failure
- */
-static int add_tcm_banks(struct rproc *rproc)
-{
-	struct zynqmp_r5_cluster *cluster;
-	struct zynqmp_r5_core *r5_core;
-	struct device *dev;
-
-	r5_core = rproc->priv;
-	if (!r5_core)
-		return -EINVAL;
-
-	dev = r5_core->dev;
-
-	cluster = dev_get_drvdata(dev->parent);
-	if (!cluster) {
-		dev_err(dev->parent, "Invalid driver data\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * In lockstep mode TCM banks are one contiguous memory region of 256Kb
-	 * In split mode, each TCM bank is 64Kb and not contiguous.
-	 * We add memory carveouts accordingly.
-	 */
-	if (cluster->mode == SPLIT_MODE)
-		return add_tcm_carveout_split_mode(rproc);
-	else if (cluster->mode == LOCKSTEP_MODE)
-		return add_tcm_carveout_lockstep_mode(rproc);
-
-	return -EINVAL;
-}
-
 /*
  * zynqmp_r5_parse_fw()
  * @rproc: single R5 core's corresponding rproc instance
-- 
2.25.1


