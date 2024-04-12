Return-Path: <linux-kernel+bounces-143217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F828A35DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58426285935
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ACD14F12B;
	Fri, 12 Apr 2024 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w68pVKTb"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9814E2F5;
	Fri, 12 Apr 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947049; cv=fail; b=XIycnqRTV7WuFAKK/KXmAyIewt4gj2DuPeyuNGirVhoQwH1qngjr9C5lU+4xLAJacSQu6azV87+CpeWoDH69g1vy1XLvoM0AcZKenY/8xTPqeGt1KdYsB6N6bm+r+whfcKXj4ONm8l4TXrTMukV4xATsxgd6+lRAoKfJMBwo0Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947049; c=relaxed/simple;
	bh=1jqVYZX4vQGrBbd0HuSd1tDIPzc5V6NFtG7wOkGdjo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xh7tvTFCdZgu/rM0hPjCVQ8CElSZVq9bbOUmpatAKVeEDy3Ttwu1E49GprHFzb8Cyw4hK6GC3qYHDqmmnJ5kUCOxn5D9s0vLykba3B44FsjU53QxfkX+SsM4tkmPnMtiu+Z9xdXrtvQzkEpMss2qFeLOqQTxXAaYE6S2bFVfv7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w68pVKTb; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhGzHPPP+jv+GV92ZzMXzbTOBPEnCbOFoMA7+sn/SzmL0HYAa6Nf8RFh/0ckDa1RgzKrSVMxyF5yoBBF+aZE6bZ7W+mZILsFpArT83x2elN5HBxig9JRBEIb4pCLuMZuFnHUZLgH3qTHBq/2v7HZoZn/sE7lLQxR+itlFHjPxt2hLhy1GOmah4cbBdPdcs7YFgdPRtZv3yRaGUvMqU9yu3OiUwoTAzfjBjcm9F1Ma6xC+4yt6JuHrP4UBR09OvjlZ/jyi7Dnc61ra05FkUGbTVLLK+oss4CWpMRpTcYLAmt3xnHGdfDdM19Aob55TuHqTExi7DIceE/tP2lMKnePkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvoXtu7/OGfkuNx9I+gKcIWKbW2uVASV3rsKoQcoeOw=;
 b=ApLac3j0EkO3uSll6AjeRuXUsGG+0GyL/74+Y24sxFZnRQ5+EVlUWDUmyGhlxxEkBB7ATiMS9pVQVWj6sKzZ+Z7NAB2pIgUqcKtq9iTqoDn02rbUqdyaRkPnqyPZbzf1EY3ZxuMLN5bZSbxrRlQRwcgfAcJCPo9wUq0j/CeGdci5m5lUyjIGVUnu0E9YXa8v8IIKX3Ba3mXux6Ae4WGVNpllRCfbQk+7LuL+jUpYjZlImeCEz6Bz5acOOj15zuqwCQ5YmJJvO4YI+h5vowYkeUYwK2j0RjTOlwUa8UrES9Ki4DnSc2Qpz9UzqyPuLGwKd7Xs5lktEN7mKblD+v5NRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvoXtu7/OGfkuNx9I+gKcIWKbW2uVASV3rsKoQcoeOw=;
 b=w68pVKTbkD+XOf+LFNCcfm2h+C3hAXUp7t7HtQz6UkriqUqa5jbyh4FCKku/WjHpc7xK560LBVU55VxWsjsM058IwbKWCP7CXoCTVHawkcO1v/k/zx54VGxPCzrvsw6pG+GtmqvHljk/vR3DxDAa3/t+MPo7DzSazSy/vv1KZnc=
Received: from CH2PR03CA0021.namprd03.prod.outlook.com (2603:10b6:610:59::31)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 18:37:20 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::65) by CH2PR03CA0021.outlook.office365.com
 (2603:10b6:610:59::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Fri, 12 Apr 2024 18:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 18:37:16 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 13:37:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 11:37:15 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 13:37:14 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v15 4/4] remoteproc: zynqmp: parse TCM from device tree
Date: Fri, 12 Apr 2024 11:37:08 -0700
Message-ID: <20240412183708.4036007-5-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: a86d4f46-9f31-4fa8-424f-08dc5b1f93ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ndr6ET2E0Y49RPvDRc1FoUx2J4uhOF9vOOLylMM3Z5XBPhpSRW/6X7LJgnmxGbX8OY3mBGjUog8Z6y0N0vEWNZI81WrnaGy3w7lPceEGoz7ONZc2UqpKvh0jmwAelkw1M3Pbn4gPRmPZ24wTbTdXHjENZBZGIR1KOZLacPue53LcefpNXZWZmWoLyOm/1/7smbVWE04neMXud3C5Axeoi2XdW4ziCZQZatnkK1K8JVrnzu0diWUuF90j1oLA5BzGU5cb9Andm2VGj9ZhCWeZTwM5iK0/yDH8CLZeoDwUCSKca8F3P5A9mgfG7D+XpkStfplwxcbN77nMv2cAowL2PsmOMFP8y8nU2wDphye1Dn5/qMmYbRaXRtEtLccuQS6MtuXEIZo6jvMzyMaSRuGobLDE/ysP28sN8iMw4cbj4q+aHShNnfBYZU813tkV1giRlXlLRsxI7NxUobI+JCDf64oDChGqBSyOhwLVEUPqaE0HNtIDJEh1jBhMGkVrxTTC1cBGwDsIs4ZstpK9aPamxQWxDpCUmPJgzBAjdT3k35wHETf1kVk9zLMY27XetCf2+WOXNQTPyEcgAmhLVKYLxpaY/k7pT8EXKokIUiqN4A08mBmWFaC/YEXpi+/88+q0LkKUwNRA0viFVxGR2QKyc7MaUE4Nl7gemLmiYdbe/mAmju/Aw8vDn+xrqhmpDMd/w9aPjNHwtEWUpSKt5twPvNxT2h535Hix+XhE/+edHFQ6dFj8JEa22dj5wZzpsmjR
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 18:37:16.2834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a86d4f46-9f31-4fa8-424f-08dc5b1f93ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712

ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
is available in device-tree. Parse TCM information in driver
as per new bindings.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v15:
  - Use hardcode TCM addresses as fallback method if "reg" unavailable
  - Remove Versal and Versal-net support

Changes in v14:
  - Add Versal platform support
  - Add Versal-NET platform support
  - Maintain backward compatibility for ZynqMP platform and use hardcode
    TCM addresses
  - Configure TCM based on xlnx,tcm-mode property for Versal
  - Avoid TCM configuration if that property isn't available in dt

 drivers/remoteproc/xlnx_r5_remoteproc.c | 127 ++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 0f942440b4e2..7b1c12108bff 100644
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
@@ -761,6 +761,103 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
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
@@ -839,9 +936,16 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 	struct zynqmp_r5_core *r5_core;
 	int ret, i;
 
-	ret = zynqmp_r5_get_tcm_node(cluster);
-	if (ret < 0) {
-		dev_err(dev, "can't get tcm node, err %d\n", ret);
+	r5_core = cluster->r5_cores[0];
+
+	/* Maintain backward compatibility for zynqmp by using hardcode TCM address. */
+	if (of_find_property(r5_core->np, "reg", NULL))
+		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
+	else
+		ret = zynqmp_r5_get_tcm_node(cluster);
+
+	if (ret) {
+		dev_err(dev, "can't get tcm, err %d\n", ret);
 		return ret;
 	}
 
@@ -906,16 +1010,25 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 	 * fail driver probe if either of that is not set in dts.
 	 */
 	if (cluster_mode == LOCKSTEP_MODE) {
-		tcm_mode = PM_RPU_TCM_COMB;
 		fw_reg_val = PM_RPU_MODE_LOCKSTEP;
 	} else if (cluster_mode == SPLIT_MODE) {
-		tcm_mode = PM_RPU_TCM_SPLIT;
 		fw_reg_val = PM_RPU_MODE_SPLIT;
 	} else {
 		dev_err(dev, "driver does not support cluster mode %d\n", cluster_mode);
 		return -EINVAL;
 	}
 
+	if (of_find_property(dev_node, "xlnx,tcm-mode", NULL)) {
+		ret = of_property_read_u32(dev_node, "xlnx,tcm-mode", (u32 *)&tcm_mode);
+		if (ret)
+			return ret;
+	} else {
+		if (cluster_mode == LOCKSTEP_MODE)
+			tcm_mode = PM_RPU_TCM_COMB;
+		else
+			tcm_mode = PM_RPU_TCM_SPLIT;
+	}
+
 	/*
 	 * Number of cores is decided by number of child nodes of
 	 * r5f subsystem node in dts. If Split mode is used in dts
-- 
2.25.1


