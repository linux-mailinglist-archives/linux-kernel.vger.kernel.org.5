Return-Path: <linux-kernel+bounces-99341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2708E8786E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D331F22DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73B352F78;
	Mon, 11 Mar 2024 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VOz5RRMY"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239C54FBE;
	Mon, 11 Mar 2024 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710180004; cv=fail; b=bNavhhqanBCFyHQR055pv5TVNDRGWj9L9NkIJjUWJ5s0jsLD+RjEPqKLjDDsYoKo32ZnFp9fYIk4LyoEAAdYWl9DqIwHi817icRRGa/taJYAzsm46Hsk5LoCP8VH0QqyQsmLS2KI3N6vjeXyg7GDhAtKnHFu8dbo/6btauk6TIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710180004; c=relaxed/simple;
	bh=Oq56hA5WSeO+d/x8cu0Ndk5y7BaAeK4ONkSisqrTv2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GY1JI3fGEJZkHVwL6e+1Db2css1nJwHovhI3S+CZ24YZH2JA5jAON8N9unPDhakZvV9A0PCP6oC4OOQ/HMt0nulCAE0G/GuTWeYW+BZUZRG2HOpBtPRr+LwK9c8q0SpCeXJyIcCbXF4cQeyRDjeGUeCpNAEGBVG4cm9lR2fg6rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VOz5RRMY; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPZE84xIBBZFajvkewf0pXmK4+RA3XYl/3S99/ZRkm4AnS9+7ktk+3JgHs7LM9klv+QzCtKmrvdHpPusAH3D00aE8wUAQyKEOwzloJpmWJnVAlL6tUg9MbVUdq+dr+081+Iaub5TY5zrwR/jB27s91UtWbGyw2eiKrp/lGUgOXNjeZ14iTPptsT/k4Rc94pOLhqM3RVpX2cczIzQeApVC7st1+LYEUntpqBQ9HzZ9FMdpnVeyccoZHpIphgJTsgFXb/jlCP0oyYvvmfEgfkR8rqm4v+Ait7lS84CzWBx003wCvXaj1bzQ1Fu43tkCoLDlkHYQ8NMPe4rYnzB6Elc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTxqHDgRsc3kLsV1HdWdGULcI0HqOb55/uG/SqAhHjg=;
 b=iOWUysTRPHE9q8H+ZAjV6erPu0ey5sA2Jupqx/5umhOJnawoBCVsYbfRYeo3CNiQmo7Uwb55rcCZ9i5s4LE/OBWWEt7BfBQVAXuekM0OXGGmQlebwzKGaUOWKDVHEnRw99ebFhrRUAYjB61UVTk6SiXroM+Hl8nGgcSnpszK4Sk1IOTuYTFEVr8ggm1DFZMqvsOqlvmLACnNIPlNzv6rKF8oqkjAnfAodsdQuSQ6izBjFR0etHlJ+XUeJHrqmyRAdGWfgHw1+BzxJ4qeble5CXea0abhKLs0NDf4z3DmPFxDQ/1r+w7B6IvnYyq/8IokrCVtESj9cAzov5gkXkiBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTxqHDgRsc3kLsV1HdWdGULcI0HqOb55/uG/SqAhHjg=;
 b=VOz5RRMYcgxKvDmOoxU++OZA9+OoywnUPeITaDc9ehlwjGVoDZ0tUf5kt9NhtAfmlRxyBsXAfgqesEVSaSqi6pS7hJ6IoGFcyBVY1pnvGiLJ90F2xn6fdf2vT5/OQKs3Bgab3kQXM46hMUTnKv+EHDC1CMCkVPTTcUND0/ucOW0=
Received: from BN8PR15CA0009.namprd15.prod.outlook.com (2603:10b6:408:c0::22)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:59:58 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:c0:cafe::f4) by BN8PR15CA0009.outlook.office365.com
 (2603:10b6:408:c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 17:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.0 via Frontend Transport; Mon, 11 Mar 2024 17:59:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:59:56 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:59:56 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 4/4] remoteproc: zynqmp: parse TCM from device tree
Date: Mon, 11 Mar 2024 10:59:27 -0700
Message-ID: <20240311175926.1625180-5-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311175926.1625180-1-tanmay.shah@amd.com>
References: <20240311175926.1625180-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7164a0-116a-499d-51ab-08dc41f510eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yGu41Vj+WOiyBsB/zqVCCO8ftRTIJ8dtFjxKlpxehjF96Iv2NbDOoBcpTN/uaM21Gnsulj/l6Maio26LGnhtuBjH68nN661JF0MNVwj6ZsOoujbROtFfCBKRpm9UeD4Ta3mURjF+OgQiaErxZhFiGFn4FWH0FH3jiCGpAXflYchVXtVj5DI0oGwjp7AavGCq3xoXv5qu7X4nZQifihrYR/LcJp9yDds/ixGibDGiKB18U4J4jPCRkywPEt7GujHG3Auihq8hDUF04xfTh1hv3CoEIRFyM5UbcN9QMIGHp7Cw9ZpqvRZJlRKiv9pKb5Ae1CuftCyRInXp3szRz9J0NLVjfhco+9zpDb/Tjs4m/POJXjlhb6b8b6FW4EJIli10Wq3J6f48mQTGHy52fvy2Q30HM9DsIA95uJAifqBBVagBeCkrgSeFD3o4Iwom/Jc9Y/EHmHaCNU11ayvSSSjjmA3H24Hj3QcVqDO+5ksdFhXwvCAgKr/H3x5mu9LyUgMLcAmwJMkttXbYheZ1VKAKRw9CzZUIL11eVba50xPruz/FP8TKjULMIo6e7lRnugucvXJr/cF301sNMo2zVIWG6ApxmQ1swoBu+VLCX5SQGh+mtoIDArxUDR2iG9mAsQI4pchwMwWTYpdAXltP07IdVFRLlpy2hP5NVR8H1mRIgvHqNJJSt9qHSEVLmEeppO7u8+a4/ZayGPpS+E1tyt7jCjmWAv3QwAZWjHPHAmKLYsAOJp7m6Nu+2lVDfY6PtV5K
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:59:58.5949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7164a0-116a-499d-51ab-08dc41f510eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
is available in device-tree. Parse TCM information in driver
as per new bindings.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c | 112 ++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 42b0384d34f2..d4a22caebaad 100644
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
+	struct of_phandle_args out_args;
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
+			return -ENOMEM;
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


