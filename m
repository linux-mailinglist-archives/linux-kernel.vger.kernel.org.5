Return-Path: <linux-kernel+bounces-88892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9588E86E814
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442C528ADF9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B528138FBA;
	Fri,  1 Mar 2024 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JtuvDovX"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98AE27471;
	Fri,  1 Mar 2024 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317035; cv=fail; b=YTjcQf/+KnL53lfPcSx0zhAqPy4UEzR4hftmtozXCVwx1YCm2MQ7zqooEIpS5rY9NT9kTpm1hiRTzvHAM8ioSU0fqZie+UtqqjllTY2z3oGjwvQRoJUXmdP1OJSXZ41ldWGOqRSy/3Hj/BSmXh4xoqWI9p4WQQK0EWki98wGybQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317035; c=relaxed/simple;
	bh=oV20fcskrY3IV8D7QtZzvN067JMXZn2h0UEDk1QC1yY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEZgcevpTpgCHUbDngYX0uITh87/aGjaVLi8BhGZH7WdTHS8fs2hom5zG27c7JxvinyfzFw48CPW4KFNs7nD2J0KJyRMTAPgvsmPt+nHC504rvw4rsmpCeSOOtElxBvMF9u4wUZySqakAD/NKjf2kqZZpdjV0au1nqQXyiUs9n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JtuvDovX; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bk0WEZ4KNMvESB6OKd8KJb16qlSK+ZaPuo6lg7GrxWWFQhFfKvaUSC31BpNoUPP7msBtsavNABaRh3XNIbW+p8xSHpVAXcu/9cOPsnqp3i+Xw8o5PA0iL34n9M1nSW+aYF9IdDLRRcfhRquBG1MKuCF2IwIoKwrtyqjxipmiZhHaca9NZIvE9Tnvk3D3rVz2SksPfTvAUmVGEa++HiFUlnLtXnTOSj7Gyx3VhJ/56ttPFiSqrDAW8WY2uyiMsbNqundarKDwyoxOtdK5d3GwmMW0+X4sqFQBQtmtDIbUvfF5jA/K34ibpAQ4AB1WgTsGGsVQyvsCGMzuxEey4yA3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j95CTk4QRkepmbOZdlmxZEceZxMUEf1UvyiXuoLtd8A=;
 b=egdbWxilBNJwyceoM+ObxNj35o8+IywzYcl1+Pn73n+zubBM/8zMZX6909QwFQ9pTJka+rC6fM+HrgbEu8ZTruyGaV+CQvyJgxy59JFU1akwczWjUlQskDYSBpszr150cNqmbXbziK/F0RsOEkr6TH0LzjbuYH6VJFwecIv7jcWB7lK5RRRGIb3mX6VpWCN/dO4aTKvPWnGoKzeuKyEnM5XbdQBQipxCVBuyI7DzapxXOo2MTEarx2q+z/yy9mzh2us8wXvBJApRp+zGhMA93bvCab5dm5nGh9f4uI7h/beO9w3vPfzd8kxAD6KeYcBcWNFBPGHZG+X80b2N2IHJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j95CTk4QRkepmbOZdlmxZEceZxMUEf1UvyiXuoLtd8A=;
 b=JtuvDovXadinWITK0Dvua/5ZGPzPe5l0lz7s9FROvfEBAREJZXLq8N4IT6zCB9mZeUtiLAviCElfrYywBdEOPDxEY8DfnpG/D619TJMqguBheN/4Asvo2wLi2TDBKAFa5eHrWMOA887W3VkFVhAAjFiLYj5QF/5+B/znKtwrymY=
Received: from BN9PR03CA0687.namprd03.prod.outlook.com (2603:10b6:408:10e::32)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Fri, 1 Mar
 2024 18:17:11 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:10e:cafe::f4) by BN9PR03CA0687.outlook.office365.com
 (2603:10b6:408:10e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Fri, 1 Mar 2024 18:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.0 via Frontend Transport; Fri, 1 Mar 2024 18:17:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 12:17:10 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Mar 2024 12:17:09 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 4/4] remoteproc: zynqmp: parse TCM from device tree
Date: Fri, 1 Mar 2024 10:16:38 -0800
Message-ID: <20240301181638.814215-5-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 7692ecae-cc19-4bce-19f8-08dc3a1bd09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q9/dvel67m2vLHPftbsClamrR2Ju27MBUUc29fW1myQINp8wompE3FrC7G3YVBd/RydOscfzs0/C6ZcIZfHiwTy9EZ8LfMEk3gWW7G41RAfqMjchTMFSLzlcdSgKPjUEoS1dEhEc8TOIsnDq5GUHk0kH6xPE9zCvKIKCG223evw5tCsODGPAx2+hftQRLDubktdD8TJGudb42mOwwVQFduJA3CbFypXsORmIWxwOd9Y64S5BC62FJQVgctk6yiSjpd14nRMfX9w22NRWNMHzb98VIKBp3xcJGd9rzSBNTzNDjH72jk+CqNh+qYbWhYKZTgAq4CzAbMh7CG+3p6iIi6COLGMxfsJji3fcgdLlR+N3yI1Di3oTky+phA1hMCYJ06AmLD+eWyDogl0VQ0b6BMEILQrhxcfYdomyN2hF5pz7M1/phK20NGDCDl6UE9ud3M9UokJCI3dSo7F/0drxQYrOi6zv/7x6FpdHifBPMRduYaUqZ0oP6+BKF+Py7MfDIheQyPFX32/48uOctS0xBtrm43gw0bgBJELxW9g0UCi3oPu1Gowv1EoyAiaoEvCVXzH6xxBzQmg/4E5AAOl6G6UfxaNFl2mgQtT11jmsVJJXU2J/AGAlzsj/WrU5HvFz+KF4MJxygduMhU9jhwcr36MW3gZWh8sEmfL0tscgDq5BJqd1vnSOJ7rSAuZFZGq5AxMy/gAr9OgAW7+ccsxKTbPPiJfbUGGnpJ81DT89JW8EKtfzU2Y/w2uvRnVlCGb8
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 18:17:11.6780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7692ecae-cc19-4bce-19f8-08dc3a1bd09c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206

ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
is available in device-tree. Parse TCM information in driver
as per new bindings.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v12:
  - None

Changes in v11:
  - Remove redundant initialization of the variable
  - return correct error code if memory allocation failed

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


