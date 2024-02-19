Return-Path: <linux-kernel+bounces-71771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8D785AA3B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF812284816
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DAE482E2;
	Mon, 19 Feb 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z3UvOw+C"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0160847F6E;
	Mon, 19 Feb 2024 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364788; cv=fail; b=WILbDNBTF65c10XGw1PqFDkp1ONbUQ60zUQ7qxdhujwSW9Ed8nnJmb6A96MBs1iEwKvOs7bJfncBd8dz/op8IWB0/Qxnu4w3I+lw6qZAHw8EoaXQ6UiA8j2wec9WYBMjVHQLvgXKdTNvbj2VwaZiAQLpo4ejZseum134Sqe1xzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364788; c=relaxed/simple;
	bh=5WkKrr5g217v7TIoQozlMStVoYW6tYiBnQucGNIpWEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJF66fYENwdhhGlkOXeo9cbRTNatTUOZ6Hur8WWRE9OHip6H+f6FN8kdt2q7sSyHrrUKdM8sJ8rwnSYQvM3z2ZoRzOj4ixwl9JLzfnHEzyTshotJ2yi/+6twVatBa40XRvzit3JWVCsn3ALYIc3ZJFhHVZ/7ShHzJoCF0jGkI14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z3UvOw+C; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klghvUH5rrhF6pkFXya0i1rRvfJsva3JAFwRNmAmZNzde3gOxdEVRAVGV36pUhuwoJdrbTtJHX/3WN36X0VbWugVoVJMCIsDVReXCrx4cfpM5wEn/eBB8O+JFYrjO/FKtWksyHW7JrRTUNeZHEsF/POTDbDmGbcTF7mq8havEuzUXQ2lhPv93+C4uH8slJ5hJ54Qb7yStK9WBW3GTLbHPXSbmHMBTZooW843kntnV7PnV+rD/sO7uFLRg25EmreiO8fXRD7+JpWVMhOeZg0gvuQKpWShtUFhvy7hs5TkrcwWVvv8fBMCjiypW3m/ALD0olSYGN4mNzE7YSj/4Wpp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCIlscyrZVP8ImE+qjqgUv5nqnzDxNC7BhEip53ddQ0=;
 b=haS9l6G9kwn7sUILDnmSUm/XFDbQlhKusvT9c/bpi/9loCoCA0AhRynEzDmUtHrIPRGuSh5z13I+d9OCq55yKnc0gne8hFKPSVkafinK/skmuvDtn6GQraSQDLO3YIebnYl6XigOau29ql/7Y0joDPdO/OoejUPPqXmdN7tEk+3t9HJS8Lc8FM0V6/vQbEry0zz5aRS6AyEIUulzoWylyxbwtMH/XoYCuS3vQF/tqWN5PAjTSxv7mIIIz50xgOv4ptccTb0W040FUvqXSzNGGAieSgSdpTEtyz+lASsi0a7ZwT0ufABAkFrDEEzHMfqWl1nTmI7Gqigo0WWjXxT65g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCIlscyrZVP8ImE+qjqgUv5nqnzDxNC7BhEip53ddQ0=;
 b=z3UvOw+Cu8i+JeOJHCCJdU0n3dh1G22f7fP1Vt+3bV4bI0AksBOkyaTGsS6/nB2w3pAJ5nuEYWlGNrn/+td4xXR4gMKJ7lmNuFcZbj0HEsnC2Ja5VKXxspsMtxD5bYmepzZZWI7PxwX+Mc4xdsJf4qAKeVqMoyomx+EtD7Pe3e0=
Received: from MW4PR04CA0290.namprd04.prod.outlook.com (2603:10b6:303:89::25)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Mon, 19 Feb
 2024 17:46:24 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::e4) by MW4PR04CA0290.outlook.office365.com
 (2603:10b6:303:89::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Mon, 19 Feb 2024 17:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Mon, 19 Feb 2024 17:46:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 11:46:23 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 19 Feb 2024 11:46:22 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 4/4] remoteproc: zynqmp: parse TCM from device tree
Date: Mon, 19 Feb 2024 09:44:32 -0800
Message-ID: <20240219174437.3722620-5-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240219174437.3722620-1-tanmay.shah@amd.com>
References: <20240219174437.3722620-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: f314ca01-98ab-4d4d-7504-08dc3172b0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	on3teSkK3cTmeiBzxwj7I/bLC6MJjuqlOoy3Recscfcj9ZPiyxoX+aezRiakB2AJ7q8JDwWekI7rWTXuuGRNos0MlmJ58E1X8iek8httMAM8f3zRc502OWU7Xexnsw75Lcjq6Gjp9D20I8H8wfap373t1RFxLgOFPPIsMC7YcRL5juU7ERzuFteQjOosKh1cLypVTo5Bx2DBPEhfwIXAuV1J0+hWOX/8IFTf4ePxcv+a7le3TpWHoaza4EfHav+PQJ5RBh0CQZObbhYG6GxG5Gd2sF0KZXztYHiBjs7ZGadD+D9daljEhQQBXIju8qzUsAnqvai6l5SvcOr6cPsKc0GK4/LPzxQenNhJz0dMugdYZPGPzOuCFQ34TngZwGDtC9JorRHMud3CGiMtvni635QbCMBHtq4VDiZIZ4yfHab4cy3URy1FMVCir8pdTKIn/QTdv+pA6/MLjm2eOwL3J4kMAvMEZDs/mJXFMnG6O6yfN43vG+QUOQkTJGspEbecK/7q9rfX+SyTU3+eEALiL2zFvjGY/GoKSnhj8I8RpUy54Igo9NYuArW2ZJrJyhkKyoMGtWDk10Y8qOMX6A9+JFmeIdBejYoMjvW5GZ/p72lQ8zSpkWUqm2xExGYR8yM5kNTzMuCRTqTjCw9b1sBoEVcfp9muUGA9AHTJKPx+/c8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:46:24.1017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f314ca01-98ab-4d4d-7504-08dc3172b0d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930

ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
is available in device-tree. Parse TCM information in driver
as per new bindings.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

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


