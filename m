Return-Path: <linux-kernel+bounces-47453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D110C844E28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F79B2235E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A7D210D;
	Thu,  1 Feb 2024 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z5l/6KCY"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088B20F1;
	Thu,  1 Feb 2024 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748517; cv=fail; b=eH5lJJwVCqK08sC1uQYf2q42TLQPIl1sinXQYcBa2gUKOeqJK5y1BczvR7IWD04vtmOfCZol9IC+0X4b9HdLdu4nsK+NfGbgEKChs5idPDyud+tfe90M4new/I/ujyFd4MKuKqj/DXXbzHrHojQctsIBFvTjO5QWb+EnuWQw7+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748517; c=relaxed/simple;
	bh=N1tvb4KErtYz4HxDm8my6zlEZwCR98ykKUygL87kqAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m/Y8uhC95I9SnR4P0MXPpcyGUQT3Htg2v+suh0NVYU5eBoIQGSt5SO5/wcG2PhklyAlLAFEDcIwGDqJK7VVtEN+cJ9ee88AJO1LHygiYsSM4muRFe+TTSYqGbl0mi+18bAGzq8d910H5uovkmnB6QpTmQiB7Dzowe6VemQc3CAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z5l/6KCY; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvITHOOnRXIIVlKUCYDZ3DPRqk807m/wVeFotsgMoVAcAf8Z0oOb7FFRCrcJIW55Tn7FOBuAXGFikWRKaOME07aKCsSWPwZayiPsYpj5gWaBOvsI115lYL5OOTA1X4Mh8h/7MWpA/4jArNE35p0vjrfdQ4PdGk+W2VHEXlhlGJ5leu/FPYaxkC6OKP/Pw83G44rjVBXnCWlBYOkzUfv0rktv+bFc3D4603sG/+L+Y8Lyii8tJTf4GTg+k1w7cPU25XM9QNSVgNnby1+k67Lv8XN09VPVuWdvkYOJh71CRjxeAapuNaj0LQkV1IEecv6mGHWjstSy2Dgx+eqwkMgRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMj6XdtbWWJzvSUNeX5KwoSyEIUdhVPCQdUTesGhcRc=;
 b=WbGGc2Ieqq3BjSnX/wQuFKJQrP0M8sBUokS9tfXKS3iTgZgqQKTh/jU2r6/+uvnYO5Ym7KIVz9NxCVqQvax1jywsEwAr3P6laOW3nB9bhPeFr+wgDNYSOPd2yA6ITy/sTuLaIM0l5Mf9uIm9kQJ0zSKORnUd/A5Y4OdUAxYHudAblmBXzF8g7vg8Kcg60OdJDcTmDJlhttNoj1vgkosZdDlD0El+STZKQyAUOLVrLtk0WlHOTsltgCLJAzeP5n7n1QRXJqa9Lgvo8NFwKUPxeHo/wEYOfMXIJrcZBbSu73OkmSNBWuODiZ1d9/TAcwWxEt9mJgcNoPoLTrQ/YJKwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMj6XdtbWWJzvSUNeX5KwoSyEIUdhVPCQdUTesGhcRc=;
 b=z5l/6KCYTnoqqMOv/DZl2yoq9RvxeYudoW7KgeA1lGLtrFenLHC1jJI5AyOS9IbsO7dQmGaw5gx8+7kRH5TvBEdBABd5w5FW3JvErwIRsaxMZ/Xdm0GhoJZRDHaYUMSmM3YMywh/JP2v2PYdWkSeedTTrhWx0uQCKfKgIEAqKYM=
Received: from CY8PR19CA0044.namprd19.prod.outlook.com (2603:10b6:930:6::13)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Thu, 1 Feb
 2024 00:48:32 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::e8) by CY8PR19CA0044.outlook.office365.com
 (2603:10b6:930:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 00:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 1 Feb 2024 00:48:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 18:48:31 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 18:48:31 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 31 Jan 2024 18:48:31 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] remoteproc: zynqmp: fix lockstep mode memory region
Date: Wed, 31 Jan 2024 16:48:12 -0800
Message-ID: <20240201004812.1471407-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 89737e39-13e7-4486-2715-08dc22bf83d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zfV67D8OlgjihpdK6OESDj2D0opHkNjtF5WQFju/F0LMOxHr9mXqwkiiwMu+QXauzbEA2eR4mIjiiayOdOpKNty9wp0kG3UUF6o431+JUZuXLeg+DfFHnJ8dJbdOxTEYnUTh2re/ZRVnU5Jdtr7ru7JrAJFXUc+evkxL+FmAOBbQwqUxJ+7g4fWbmStTsshuD7+5HL5CSR5T2yUIeNTR5PIplO975SdBRCRq7WdHzi584W6YYvapVT0eN3OyRgSbtk6KYgi6OVAWCnimSMmsSApUfVek/rLxtE9UyUJMwuruAS1cN8rIw/4SQv/TMpkCAz5BqjVmV5z2bqhs7aKwiQ7HOnRlfzNr5jhKXhEeVXNVactub1+uL1nTixjWWMHGITcInwPaFWqhgagVUDnbM6d/Vo3z3xuRMGR/AXj9rVWEyiNSTIFqIvU28wCQLsCeAzlIMbbyIMdrYgkW7c32rVYTHbQklSQi4Bg9BsQVR5yV0kPxarWQD7BOn6sYztjmP6wbmu1Z7hl0GIrOS9FnKpDSTYvouObrZ0W/RLU5OKwvsli5iftKr6ub2pAesPQ4SgmMlZT945F9jgEXuERDsdc1j0J4HBzTlqO3dVGfSbUeTlvCQb0v719l9On2Hl74gfqM8DrMCJQNuiH1aTK3FhUUUiZmaHC6kD43htOLMeXgJXd4UnVQkRVTpDPLWuoyWnx/rgykj02k2pu6crZDdGrn6ai1JQQTteXM4d2o+N7vGz+vNB7n8+9ZlPb1kZhI1DY+FndL+EsAw+/qJxk3SQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(40470700004)(46966006)(2906002)(54906003)(4326008)(8676002)(8936002)(5660300002)(44832011)(316002)(70586007)(86362001)(70206006)(36756003)(36860700001)(47076005)(478600001)(81166007)(356005)(82740400003)(6666004)(2616005)(26005)(83380400001)(110136005)(336012)(426003)(1076003)(41300700001)(7049001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 00:48:32.4465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89737e39-13e7-4486-2715-08dc22bf83d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687

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

This fix makes driver maintanance easy and makes design robust for future
platorms as well.

Fixes: 9af45bbdcbbb ("remoteproc: zynqmp: fix TCM carveouts in lockstep mode")
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c | 145 ++----------------------
 1 file changed, 12 insertions(+), 133 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 4395edea9a64..42b0384d34f2 100644
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
@@ -540,14 +540,14 @@ static int tcm_mem_map(struct rproc *rproc,
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
@@ -580,10 +580,10 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
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
@@ -593,7 +593,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 		if (!rproc_mem) {
 			ret = -ENOMEM;
 			zynqmp_pm_release_node(pm_domain_id);
-			goto release_tcm_split;
+			goto release_tcm;
 		}
 
 		rproc_add_carveout(rproc, rproc_mem);
@@ -601,7 +601,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 
 	return 0;
 
-release_tcm_split:
+release_tcm:
 	/* If failed, Turn off all TCM banks turned on before */
 	for (i--; i >= 0; i--) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
@@ -610,127 +610,6 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 	return ret;
 }
 
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
-		}
-
-		/* If registration is success, add carveouts */
-		rproc_add_carveout(rproc, rproc_mem);
-
-		dev_dbg(dev, "TCM carveout lockstep mode %s addr=0x%llx, da=0x%x, size=0x%lx",
-			bank_name, bank_addr, da, bank_size);
-	}
-
-	return 0;
-
-release_tcm_lockstep:
-	/* If failed, Turn off all TCM banks turned on before */
-	for (i--; i >= 0; i--) {
-		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
-		zynqmp_pm_release_node(pm_domain_id);
-	}
-	return ret;
-}
-
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

base-commit: 99f59b148871dadb9104366e3d25b120a97f897b
-- 
2.25.1


