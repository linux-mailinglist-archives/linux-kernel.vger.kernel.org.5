Return-Path: <linux-kernel+bounces-135924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8C389CD20
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FA71C22265
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1114149C71;
	Mon,  8 Apr 2024 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5ufC6asR"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657B1494B8;
	Mon,  8 Apr 2024 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609651; cv=fail; b=toyHxNogDf6TKdR/8DcAD5Wm0FBCns6X58Ohb2DSE1dQeAfr0pu9gopB4c5qteAWiIpFKgb7TOBtBuL1tC/vzC2SKjPdNh9fMCHKqRiX7ekInDSpnzEDi/2hOXP7gcgI1es1qt6mWyZfgVp31ywTvSLbISnorONMM4PHQaBQCZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609651; c=relaxed/simple;
	bh=HP0Dv8jCe16phOvQemQteL1gyrB3FLMoFx+fww5cBBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaKiYa5NFeFhu5wmijseB/7lzNCOYNXlX00k9jwLgjgpWefvCpXMFUgzyLoRJZWSa/k44SbcleWRKJ0078jpzD+qq623eaiJ62eNa7Pkes6V8d0eE1bG6gpyo3GfQvGROjeEoQ+neaijiiaqpUdH1gLjb/mkB1UFFGaQgsv3dog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5ufC6asR; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbGSGNsHepZw1xJPcK+Lo3/xMP/Op0MFHQWIEoY6VKvV9PuldSyX/U4yiHCtmi3dWsM4x3/AEAepml8u1gmBGUNU12knAQ9qnN0mNw8X2MrPO1Kb0jQwGtRRlQlFhdWwpSC2YIa0sKeq0lhfkDQEmNHZHm0QoOiVzolWKyBUxRRN1zc/CEe8xhYpaDLzxwMizP+n5rNrK+zs+Q3L0CKxLuEbC936qPxLa8NZ6pF/n9A+TpBUrA0Tub5gZFX8ow7sbwsBTi9H12DpSzTQTrmA0OfvDnLZ8+yLujs/u6anFYH0F5XCFmTpzUmhJA5MtwLA57IFoj9YIsFzzbdt6fvabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4pk4mwSgyrVx9zjRZUeO+BPHs8ARntKlObHEWw1UlY=;
 b=OgNeFLwCZYEn1RWRJ5SKfAJRzPuWJjPO7Za3OAEkCRnrMfxE9BvW2wh9yZE66HMyolwcxNFkKSn+Qivc1i0o+2iDce1U/gerXdcl01vttHDQjjfeXYZFQfrEUFAlXglYZ3PzJQ2wQa3DRxD4HhsYZDwsACji2tdqxouJHaY0/si4O66gVY7pKIu5ukDdM708b7kA7WixrRXEbCUBgH6vaiq1ch4H9uSOUFF7ItH3ulYz8Wmss9wFyuxNkqH4z40Myd4kTkIagEmdhQZ8ZXT+xP53904aGLUDB8MyOnpYz1Mks89GUhK6y7kcMWwTzjC/fl1sJRguJeey2lhbLwJ8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4pk4mwSgyrVx9zjRZUeO+BPHs8ARntKlObHEWw1UlY=;
 b=5ufC6asRtO6viwPd9yKtifMF+onomYzvVngASnWcrE0UI793XxpEXwztG3vX8Gz2LqalTOCjwLP8dMrOwUVg20ewm5OKvrR4JqX70WmEvG/7+nBvwK6lJp+79k+FV335Z6sGs0pGOuWxL2KuGoIbP9mzu0HuNQnbV/mV7UyhSzk=
Received: from CH0PR03CA0422.namprd03.prod.outlook.com (2603:10b6:610:10e::19)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 20:54:06 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:10e:cafe::c9) by CH0PR03CA0422.outlook.office365.com
 (2603:10b6:610:10e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Mon, 8 Apr 2024 20:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7495.0 via Frontend Transport; Mon, 8 Apr 2024 20:54:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 15:54:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 15:54:03 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 8 Apr 2024 15:54:02 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 4/4] remoteproc: zynqmp: parse TCM from device tree
Date: Mon, 8 Apr 2024 13:53:14 -0700
Message-ID: <20240408205313.3552165-5-tanmay.shah@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f0f46d-426d-42eb-573b-08dc580e0674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qEmG3OaZS24XlKr7ZWLu9MBU7ekZz3Psh3zaaRJc5N2GYUiIl1UJwPmFWjWQolX3UwhwSA1tPhwKjXQVPDYc7lvSI0R+7XCztXOO1lUlPBkWTRnQBYNyfWqakTrR+jvGfOgkLkWM96v1qhVKvOYA+iB5Km1rlH5ovCsXKV7jY35zBzhiQUSh7yrsKRMhSzV0mHsp1K2Hq3ZYTM4p9YEewzkzE+0gKaWkQB9hTIUGSzbrrawZDAlgDAKsjtyVH2MYzuVzxDdRKV+0Wieytnmwg5nozRmuYjObO/isXxehIroiDp9UmHWlee401ka4ieUT1wsXBvq8T1+u3x66qVxnK9RHVZG5XOs3MWYfo2lwxe7mULFYeri3mi3f6N5rzH1wdpopLW2v1f+92FOgVy8mNl6/WpF3TkKfnVwKSLs/w6jW7mRn4KQCFXBnugS/DdE7V3Z2C10oRF+6tgZ40474J2QcOKKVGwxuIiNu5RnVUphzQRgeOi2qKu6Hbpi7J7bdOqat/97u+8JDUswCsAwe/80U2dMZcrIRxszvhw73e1O154KnLICsjGIqkqMsbghGaZvqU6RCv4hXivCMGzejQ295tnGyl6TSU+Cbz1hPMc5adsFKD/mkAv9AOdGIymli03OqhSYUT2AFs+XaoJ2XnRxJcz05OaCOCZHM/GGCHxEr8/nGYSXhW5F5Hw0Qtr/llzrDR753NYpsI7RgammdE/mxbbv+pRmcStIXqubhuS707EJ12jMIwS1QpC6Jhjjx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 20:54:03.9592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f0f46d-426d-42eb-573b-08dc580e0674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867

ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
is available in device-tree. Parse TCM information in driver
as per new bindings.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v14:
  - Add Versal platform support
  - Add Versal-NET platform support
  - Maintain backward compatibility for ZynqMP platform and use hardcode
    TCM addresses
  - Configure TCM based on xlnx,tcm-mode property for Versal
  - Avoid TCM configuration if that property isn't available in DT 

 drivers/remoteproc/xlnx_r5_remoteproc.c | 173 ++++++++++++++++++------
 1 file changed, 132 insertions(+), 41 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 0f942440b4e2..504492f930ac 100644
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
@@ -300,36 +300,6 @@ static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
 		dev_warn(dev, "failed to send message\n");
 }
 
-/*
- * zynqmp_r5_set_mode()
- *
- * set RPU cluster and TCM operation mode
- *
- * @r5_core: pointer to zynqmp_r5_core type object
- * @fw_reg_val: value expected by firmware to configure RPU cluster mode
- * @tcm_mode: value expected by fw to configure TCM mode (lockstep or split)
- *
- * Return: 0 for success and < 0 for failure
- */
-static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
-			      enum rpu_oper_mode fw_reg_val,
-			      enum rpu_tcm_comb tcm_mode)
-{
-	int ret;
-
-	ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
-	if (ret < 0) {
-		dev_err(r5_core->dev, "failed to set RPU mode\n");
-		return ret;
-	}
-
-	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
-	if (ret < 0)
-		dev_err(r5_core->dev, "failed to configure TCM\n");
-
-	return ret;
-}
-
 /*
  * zynqmp_r5_rproc_start()
  * @rproc: single R5 core's corresponding rproc instance
@@ -761,6 +731,103 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
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
@@ -839,9 +906,16 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 	struct zynqmp_r5_core *r5_core;
 	int ret, i;
 
-	ret = zynqmp_r5_get_tcm_node(cluster);
-	if (ret < 0) {
-		dev_err(dev, "can't get tcm node, err %d\n", ret);
+	r5_core = cluster->r5_cores[0];
+
+	/* Maintain backward compatibility for zynqmp by using hardcode TCM address. */
+	if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))
+		ret = zynqmp_r5_get_tcm_node(cluster);
+	else
+		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
+
+	if (ret) {
+		dev_err(dev, "can't get tcm, err %d\n", ret);
 		return ret;
 	}
 
@@ -856,12 +930,18 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 			return ret;
 		}
 
-		ret = zynqmp_r5_set_mode(r5_core, fw_reg_val, tcm_mode);
-		if (ret) {
-			dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
-				cluster->mode, ret);
+		ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
+		if (ret < 0) {
+			dev_err(r5_core->dev, "failed to set RPU mode\n");
 			return ret;
 		}
+
+		if (device_is_compatible(dev, "xlnx,zynqmp-r5fss") ||
+		    of_find_property(dev_of_node(dev), "xlnx,tcm-mode", NULL)) {
+			ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
+			if (ret < 0)
+				dev_err(r5_core->dev, "failed to configure TCM\n");
+		}
 	}
 
 	return 0;
@@ -906,16 +986,25 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
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
 
+	if (device_is_compatible(dev, "xlnx,zynqmp-r5fss")) {
+		if (cluster_mode == LOCKSTEP_MODE)
+			tcm_mode = PM_RPU_TCM_COMB;
+		else
+			tcm_mode = PM_RPU_TCM_SPLIT;
+	} else if (of_find_property(dev_node, "xlnx,tcm-mode", NULL)) {
+		ret = of_property_read_u32(dev_node, "xlnx,tcm-mode", (u32 *)&tcm_mode);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Number of cores is decided by number of child nodes of
 	 * r5f subsystem node in dts. If Split mode is used in dts
@@ -1100,6 +1189,8 @@ static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
 /* Match table for OF platform binding */
 static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
 	{ .compatible = "xlnx,zynqmp-r5fss", },
+	{ .compatible = "xlnx,versal-r5fss", },
+	{ .compatible = "xlnx,versal-net-r52fss", },
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
-- 
2.25.1


