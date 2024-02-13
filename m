Return-Path: <linux-kernel+bounces-64032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81242853929
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E587D1F22755
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7F860881;
	Tue, 13 Feb 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NvR2dO9j"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9DB6086C;
	Tue, 13 Feb 2024 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846928; cv=fail; b=dN3hUd7/ebCPKgT5ALoD7nnCDf9r4gidqhLwyNas87uiLZCZa1t4/HEZM62iszVaIVlwnXLUzgC5aloAkEHRZi1CRxlFzgkOqcKkBJU3h8iVMgKIfCttQjzWr1D0w2QVCPz3j2vFLXpE53Xt/R/ydOa7+lQCxOC5sR3xiM0jTp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846928; c=relaxed/simple;
	bh=5AUhupikPmam0i2r5aCWBMICflaD0hJ0xeBKZsYi4T4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnmRa82SyZAF5H6hFNprQNxOB5NjKejkpeYq7lGGaZptkj6dQmF3QwCxddxhENV1Y7UxwT1NAi4K+mE+M877mtrh6ZhEbUWTvGYcSGHYRzMHI0Bn55PWEVP24vIpAO306VnoK7fM6aT6LoJQ9IwSsL89AMiqjSyCDlcFae0ifKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NvR2dO9j; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1bIOjgctGDZCDVpOYQvnMswlzfJHQCUBX8Az0ERb1Tdwcrf5uNgQqqw0OeRsMF39UWceqCNMNTLnNFNtsAqKrAWOUg4ZJJd1RHVJswz1L6JakSQ4UTDA9bWsCHnAZMko3MOZvaxEypHv7Fb/foz6EvzqYO5JVtGUIFzaB8oIG2bkjfHcNc66ebs6rV2ZWgT+Axl4bck4LuhJX35MeaZbGKi8XshRxkj6Va3wChDsTP2VLIEMLOktSYiUPOnn5siGctRr1mCnblYMnSa+vSDwHBF39+1jryhV3+gulrKGIqbDfKSu4Oa1mijJulRqFEIrY8jNMP8TuSOLnhfNgg1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KBJSiTUh5H8gAZwNJ5byG2b3A6H7udoV2uMSD+MKLY=;
 b=W0BRkfqouANKaVucCDzfVCEz0CALrBfCNNQYqhSrq6Zca9MY9b/38QcoCHkRdasBEimIx8PjdequX254BNLT6mJwWFVGflxUQUCAND1sm6aca9skE+9hxPBUqGVQh3Mdkv6yLM/zfQ2DFU6/OsgZJqtLUt95TvGaSYomfJoG2bQ/6YQFqQC5hXk+v3VAQAMACYkw8j2RTEHVcKTZ48A52ebZ7yMlAq0J09L9ttefbd5t4LCi9zaRgMm95VP5tLOrQXGEJhvCFezsF0F3gJWIkUjUV2EyeQE2m/12cLgByadp8wH9f8LeLG2ZB9l/LoAR5ZyGzdGpUCoatSTSCwIy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KBJSiTUh5H8gAZwNJ5byG2b3A6H7udoV2uMSD+MKLY=;
 b=NvR2dO9jbX6EVzis99etcHhXkbqYWbeqPOpoQtr/36z/S/TYFYf3GPcM7Sp9XgtI2iriNFkH7ZwW9uv8YkuIPy5Did970qkI2dWLVfzw5LzdnzMAnoeNi+0oDekxO8Co8Wuc7/IRfl7OWr8Dz124qeNWJepbG5FcU//7v7vYYPo=
Received: from LV3P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::20)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 17:55:23 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::10) by LV3P220CA0024.outlook.office365.com
 (2603:10b6:408:234::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Tue, 13 Feb 2024 17:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 17:55:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 11:55:23 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 13 Feb 2024 11:55:22 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 1/4] remoteproc: zynqmp: fix lockstep mode memory region
Date: Tue, 13 Feb 2024 09:54:47 -0800
Message-ID: <20240213175450.3097308-2-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 909b8cbc-a7a0-45b7-8f89-08dc2cbcf3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+hJ78dbzxqwbwjM0mwwrryMrMiIVvOjyChlsfCpz6VQ0eUHBJ1W3TADoQmP95J7n+WhSxLr4A3mrbhHJJ80Y3RuG8zYhTyp2AVOJNOF0dyU1TMfXqOBjS00IbBmYyu67dbzoQo4QrWQoh6varMv4TJEnJRKw0SJOj4DR/io4BHWFReG+e7m6z8PcqxDcvtOdP06Ft/ePk3VACxJTyqfs0JPJu1qoD40h89+lUf/IqwGzhT1VmAazurv2HS5KeQWyMlFqAzcvEYo22755DQlm6PsES27tYLmR4yUXzk2K22OuO0lqxDnNKPAGkkrIA8Vv0pCrUHN8hcgDEgIXdrDXIjr1BBvBslfMg1J29qlB3vjPMOB5vGIoLm9I0JqGqoey7cDT0MP1+THWAezmqekDqftbFTzqY7ArhPjJcUOTGdi93FHMErmqF1KIgxxQNn08vbKc+q36L6R+Tz5+RGRPw6l23Cxys5452gZmWE2QH6cVKbNPIDENMdN4HL1qoUaiiqL5u71QUgeY0IUn0W5u7rwQlTqcvwy3/eQ1V2ltjvHO15odj1oNlkL6vuuB5j5cgO/FynfzDUBoWCXWj0Y0wMmGTwJgJ971+wuKsp2etJI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(70586007)(8676002)(336012)(1076003)(426003)(26005)(2616005)(41300700001)(83380400001)(70206006)(8936002)(4326008)(81166007)(316002)(478600001)(54906003)(110136005)(6666004)(36756003)(82740400003)(86362001)(356005)(2906002)(44832011)(7049001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 17:55:23.5788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 909b8cbc-a7a0-45b7-8f89-08dc2cbcf3d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062

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


