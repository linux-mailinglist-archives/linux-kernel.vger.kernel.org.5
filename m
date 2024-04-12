Return-Path: <linux-kernel+bounces-143215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FE08A35D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 054C5B24306
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAFF14F9DF;
	Fri, 12 Apr 2024 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vvu+jnLo"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2591487CB;
	Fri, 12 Apr 2024 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947039; cv=fail; b=DB+LSPvAyirPbBWq1ErIv0ivy1Pb6E/hoOfSlK7MUviuNSeZnN5f3VMkrRM+wxH4uz1kU3Z15UK58vA86HCOpfbM9i9dObN/FyvDkZA4uBcSokQCNZhDdubFrtB232M2hUHSiHxYum3LbZPcPRh0C9kPlLVBZI7Bj9Ynpd+tfJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947039; c=relaxed/simple;
	bh=NB0eOtiqFlMSoEWXBvtV7QgRZOpf01bZ61XhUTCNNU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpyVwYPHdnjpoP2rZpJV/NF4e98MAbp/5pxl9eRkTcuNLZbmauBFQ7wvCXPP1KPKvveNQ+8B29Pehh/GnHMqIy9vXN08UUqQXbdqZd4ufI7NYHQRVK8V5oiW2Dc0hk4BTiTGPWp8/EDV0XAfYebuyJQu2q+K/tngnNhPjcY9H2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vvu+jnLo; arc=fail smtp.client-ip=40.107.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2M8Dy0T4ZBowr+M+R+rrFSJ13QR08oEM7HL0Fyz75oM/nmrjOfeJ03K4WT8Fy7OcrML/Sg8nk/2HQyBB3RDtGJTepgF7P5UX7G1hz+hLQxwYyWcKfzTQxEbPOOuXLKrKjJE+EM+KAr4Q6VjihTBfcq1ttDQoI7Mzfhv0eDs/N13xR1ihfDXoWc8uzpA6pD9/Pe7u+/b3jzkYguEZyOmzUkpUi0DmdfyTMqfV3jWY8+nOxgMVAJ6sKzZFSITxUap2yzEKWtj1sjSFoegiPU6szpQB0x0ElqXl8M9qkmkNqFdBw72/y1p1gi+Siogpxr7TNs7OyBZP7idY24N6G3l+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyo58WNyCKwdye/UzAMvtllU8L6elmNDMUgLwJhX3sY=;
 b=fwk9iCDAOwNB3Tg5xA5fyILesQVWzm8diAYsiIDkzy8tLidAUE9v8ku73RVAA9faMAPcvlmMbyoyluJI5OPotovi7cCmq5BgRPSUiyGZle2w6EbR/1K8Ybf8uu9oH4QpGYTXbcxst1v5DTt0nOQrNLkZNuNbVsYbkudArVcYbv3X/Jkj4SAyRqHznAKRHaE/w0Dtbti3XdU6BTdarJ3/kJQhBoLHelBCwiZtbqL5nG/zitI82wChOoc2bUjQZJKMCMmYv20GX6mXTyR2UYpVxfYMwbl3vZVyFCwNzItDDe8KH6SzBaJ7Rw8jeEDo9kkUXproQEH1zZVMCCn8143z/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyo58WNyCKwdye/UzAMvtllU8L6elmNDMUgLwJhX3sY=;
 b=Vvu+jnLozImT4VQdtnQRbxCNny9tKr4wR0u9+rubi3AtUiHdoyZAWuB63Q2+iHpN14joxnDQ5ryywpi7URKDEqHnDF6S8EBvtwAJEnRpnM9jGn9XiQjd2MFJEfhwbMxgCMbgFLChwul7faVUG8Ps8y5vRlzgZCINPApvlQ1EJOo=
Received: from MN2PR13CA0031.namprd13.prod.outlook.com (2603:10b6:208:160::44)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.28; Fri, 12 Apr
 2024 18:37:14 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::6a) by MN2PR13CA0031.outlook.office365.com
 (2603:10b6:208:160::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.13 via Frontend
 Transport; Fri, 12 Apr 2024 18:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 18:37:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 13:37:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 13:37:12 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 13:37:11 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v15 1/4] remoteproc: zynqmp: fix lockstep mode memory region
Date: Fri, 12 Apr 2024 11:37:05 -0700
Message-ID: <20240412183708.4036007-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412183708.4036007-1-tanmay.shah@amd.com>
References: <20240412183708.4036007-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 1620a0cb-972b-4620-323d-08dc5b1f930a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BbfWoEOB9P4lomTysphQ7zCWY9sljc0VMZds5Ah+32K7mYKWVQN9NrJ5hpWvQzEA4bp3V0v69lOjpgW8U5cBlFnDddJ3CTqNsxitP0xCUCCYhPb1blnmavl6hxegA7R2iPTy8A2laqbJ8XhfdrVVQdNfBGcCzQ1mZwoMk7ay+vTbD9ihjDJK6iIKftdAZCKZKshxTPRcFCUWSZXvV6KzpfJISJX68jkumqJ4SvSVC6/nPL7Vfv7OxXe+3xIC0x/6+hhCrCjMZyWsMH5+xKVuZdJCJLS/emCmsi1JWzDKzgYObljWi4Yjey4avlRmKas1E/UTLCqGDsiLqECodH0E6BEBpyCbJwRsB35+h8qWLM620XeAdhKgSUMSUM7d4eJerOap5MW/J9wcug4PhKKfEDr9mXPbCELWbYAWdoLxrR4vxHMGsMrwUcJeoJffc+ykOmbr43WxrQCD5uO69/h0n22sDaWzAx5FuaamIRY+amIDaxPJ2fCcOYcjDcX7x8YLkIwU9h3Lt/Rio/rBkP7hfikA1FaMESL9eEvtBUcl2l+DDBKwj1Zr+ZNbWI0i15L8INlbyN3ASWbLt4YP6Oatn1/1pHbqOvsD3d+Bw92FoDqlKtRJO7IGHcJ3LJ+nZtl82gmKNKuWu66sQCkN3Xxhlo28CauwnUWeajqVcdvrldeju/7uKSccbuhkr6lswety7CgngnnBUYUB9kF4d7dvXqPItYPngIJrg0tnm4ZE9x2i53O/bSFUqqmINFUmI1U/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 18:37:14.8331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1620a0cb-972b-4620-323d-08dc5b1f930a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355

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


