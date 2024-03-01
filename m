Return-Path: <linux-kernel+bounces-88891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6E586E80E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDD01C2206B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B101028383;
	Fri,  1 Mar 2024 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IhcizhTi"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA58825;
	Fri,  1 Mar 2024 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317033; cv=fail; b=UlCAmmSQ+6wONAaMomm/rV4shOEJxtdynjUA/59bRXldxYT4sNB47swROL5WCvgmNnX/tqnSd9HkU+bsV2XqGj3MRg7898+aJUgTZ74qNHx/PdASgr6HfAqsg60Pv/0Pee5qIAnlGbI/NXtCpwYvduuAnQBD0waW2IHqTdRvYog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317033; c=relaxed/simple;
	bh=qDErJv3mMHu7GxRPmcX9r96ekS2YDAPnGo0SzEayMbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbtkcCK2qc5bNfpAwwfDTA3S9nEoxMxv66mE2Nu+cpPc1u62URuULL9xegcDdFrq5HjMdEW8wGGaq+uLk95VxKhQRu0nN2R51LjTQpvhZu8a/pB4D6CVCS0tp/94B9qxU3J6wQVApC6CNe1s/XZletJZ8udYA3+UtpzC4QiPKjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IhcizhTi; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WD5XObqMrQC3poeuL4tNEbnkdA8+uQ1bkwJqLV3ajwWOxyouhRyQAPhxyMqSkJFm/k5rMaotG5TdQgrrNV39/HqX9v/Mz5tChgC8Rm3idsYJ4yGxcljot8uVHOG4FU1zg+kdsTAACnETu4Obh4KP4ko8v5DRMw8MJbjc3IgxIhCOUdqGqqD4yTMl97zzOfXo5cNCYZIO0SW0S5VpVoE82LZW4CJ/420YlDpoUOYODnYlauQcsk1CN4GKNBo/Ny1ScP3SK2r0P2psFmKP6tcZIq6wrm2C1aeUXfMINmWwS5F18K1FpA9Z9aGh+KMbLK1f772oLdG+6c2SoWe7FVyZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lM9DTxTghBBdcVUVEjO5JQZu4wlEdGOqat/qzIryIUE=;
 b=M/MTJ4bIPWnLJCIne5pdDRQBZ9YFKS+6I4GxVDh+5C9SjeZW1e1179gZtyw/3VJVM06NF2CvtnIKEfbdxP2IKke5kU8hd+taI5akkJOa6TBSDYhyN+A2LlPPXrV7QrEtUa+Vnp9wXcvaaE3pqgAsuq5DqbopwAsak9Jh+WjoSn5y2oUiZbx28G8sdTiOOwz4jNaXwx0EScOAl5vGyy2VbB8SUwS+zkmRZF3wGZi1fj1NcH69UeMHbYmEb95mLB/3CB9IPPwXBpSJnEvl0HOITjxGxrxRd9rxjEIGEJYmepETNkhoQX8oQ53G3r2YhKRbEPHqIq6UYsL/MqMLjnoWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM9DTxTghBBdcVUVEjO5JQZu4wlEdGOqat/qzIryIUE=;
 b=IhcizhTiC8wqlMqADJuqpsOJjXCy8OD3GEQYiz17KnmsyyI3qE8751FdKorcdrVlEZj1V27Db9VY67bXp5HWJKWgtlhRy/pe05UG6WrSFciVJAHXNUrgrX6nCD/IUxhSLbG2XT7PyVCDQTvsZ55uRMAhJj9050/6LpmOcQvogvw=
Received: from BN9PR03CA0672.namprd03.prod.outlook.com (2603:10b6:408:10e::17)
 by PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.47; Fri, 1 Mar
 2024 18:17:08 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:10e:cafe::28) by BN9PR03CA0672.outlook.office365.com
 (2603:10b6:408:10e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.33 via Frontend
 Transport; Fri, 1 Mar 2024 18:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.0 via Frontend Transport; Fri, 1 Mar 2024 18:17:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 12:17:07 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Mar 2024 12:17:06 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 1/4] remoteproc: zynqmp: fix lockstep mode memory region
Date: Fri, 1 Mar 2024 10:16:35 -0800
Message-ID: <20240301181638.814215-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301181638.814215-1-tanmay.shah@amd.com>
References: <20240301181638.814215-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e591d18-3236-4dcb-6ec6-08dc3a1bce69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ln7N5IgKf9DYCbOOxLX3f7XhVqLmPYLS66X8237OLb1FTHj+rvtichwn4cgg/JgHf5rmqA5HTEah9lOyjmM5EWxKsNIOW75FriLdxf77cr4wIy6TMugQJXWu//8NeMQPZovIXBNgvNnlM1Gfvm5+I7Q2c7zymBeynz81Y03tZk8svkYBhu3ilajYG+51ZnZ7g04xWDaGa/xgYuCd3hb90s3n82kPLG8J9ydJSsRn1Qpw8q3FMdyUiOhq7WTxB8N3e8wzwdhDSXb7L83v6ldphoPM64sOnYVlCwxbeKkk6CtmT1Wzp2zVio4zYvCV0o4102VRNqhdIvhWs0pCiuqdbBhH50MMgtQe5cBQkwpoGzA9LJGSjTbd+qpJDOPGKATaJIfIm3S37GsPo9TSzLCPLz8sVSA/Lxa4T3rfGKqXlncYYe/AXVKxWKZZeM9ujucBee+cGBiOqve4/JNvJWClQDCvkxgy9zPAPreZCaa8BKQO6khZboS7AHFBwE9qxFJngA3h3votv6YhHB/UUZg/dn9WSMl7Rzm0VvuIsD09qeBnrbx1UDe/9mdptMZA9kcErl1z3UK/H2BEOQhGSUXZZTtd+Z593Hb/wiOlp9c54f76X5PrsZ+J5M0GbUnO3iWdBthuU2I6DwgZzQ5vKzfz64K2T7skS0AdtHKbxxX0i4qXUvnithwo5gEXUmK+16OBOKkJI564i1EG7+xbUP/nDPWH/SyMpI0MijeuRhiJw51Im4anQMS/AFjL4ECBodzc
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 18:17:07.9905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e591d18-3236-4dcb-6ec6-08dc3a1bce69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973

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

Changes in v12:
  - None

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
-- 
2.25.1


