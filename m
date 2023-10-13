Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B27C7C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 06:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjJMEYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 00:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjJMEXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 00:23:46 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC979C9;
        Thu, 12 Oct 2023 21:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duXgJtGLuxLlNY7YPC9+OJTFy+UD8AnFy3cjxq//0hKvE85zumbKQR+hyC0+5e3rbj/ALOpwstF0CEHeAHI9VrgMlvs6LLry4RVToWpbihb0r3ansbXCuO2CsolWG9HZOj7LAV4MytK3aVbfncaeN3tSFU1loy8Tfxie0ADGVS3PqntyluyBSLY3tmmAato5DzZoA1a9zuwGoSfAZHm+GzR+ywFSIj1Vgytuwnz38vGAfPtMmSP5gGKZgDAOHKA1GhdUWOl5XCz5TlgytL3W2Iqu4Ihc/bZ1rrucWWHSTVLm2AK9ZL1ZBAbhQmliq5vkIHPSxqs5ZKp/PiK96MaS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dBzDIOayrQB/L6Op8Ns7ByE7/nkLBipyWaEDCr81qY=;
 b=mrUVBupicVZL7HDnBR98pX4o/bn906lfM8/aDPvIc+FdthNqxiuPiCWgxOAFSC/sCClg/7gQXYMc6MK4yZ754/09/d6ATmfIKOFp46vEL80GdeEVxawVNRngFHwkh+9sNDx350B/RojgqXp+kY6/zSsMqEY1FyX3gFgUvnkqLlvkLZ4oXhdv/M5gEJLosHzHLHsdeRtuOzGXwbHPKdy719NDBkKWQeE2LFLeSUtS4EuGAxJ/If2+l1008aqitIPTLFT1136gWM0jxOqd8uwJ+LvILQ58KPJeYhRbiMaUQ11aHS0JHik3c7s7OIWnHvdhYrBcvMkgSlg175DLO+rYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dBzDIOayrQB/L6Op8Ns7ByE7/nkLBipyWaEDCr81qY=;
 b=PxmLbYILFK0l/p1IE51l/WTGTxvzV89HSBC4eLq0MoLOeKMSbgdAM0EZdkd/NWBMJpRH76AccBpYit3mxBW8fXdaZEvq9w4XailLT4MbKF/UxORLZ5J5Q1rXzDu0rL1JIZcAnKUUyqtIv0mCaS4mIRH5uVz5vbjOxXQ5xjbgPqk=
Received: from CY5PR15CA0131.namprd15.prod.outlook.com (2603:10b6:930:68::22)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 04:23:40 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::81) by CY5PR15CA0131.outlook.office365.com
 (2603:10b6:930:68::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 04:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 04:23:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 23:23:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 23:23:39 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 12 Oct 2023 23:23:38 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/4] remoteproc: zynqmp: parse TCM from device tree
Date:   Thu, 12 Oct 2023 21:22:29 -0700
Message-ID: <20231013042229.3954527-5-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013042229.3954527-1-tanmay.shah@amd.com>
References: <20231013042229.3954527-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: fa903dc4-07ea-4047-8ae2-08dbcba42dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdfPLn93pr0LFJAs7GCwNmNM8u9sc5FuAbvwGl8vuF0/+HG4wbQGBc++ZgnAiXbB+OWAkRQtWpQcG4e8Ob4b7s+4nMt9kOfHYd0Yi++UreKK1HA4LmPN9Kc/1GCN9jMGrz3xwFWQauGIYpUrDEtbj76jqqgRQHnAzR6h2R36xgzPAPi4mu1iw0ONnUvWs7XBWOZp35zpMTVv4lwT8yMZbJj2VA3ctbXj7/Aivy7MF1pwdQ6I5xzMHAog3js65juYB73z/nyNXCha83ml+0NvBr/DxwLSgAa8jxmWR60teSgcQOp923UnaH50UjAZF2vsQMODfQWhNo5qhfl0WfRAe+aBal9iT5tOl2mbcl4atkRVKtu6cCsB+7kdZrnUffL/7p3AAYN4IuLmKJtNnEn80v7A+h1oJAIDTKDnM0N4rDavW0xJUN8f/90Bc+5OvwaI5rBuVsn/cXA2NXT4GqYnhHLNI4FXTyac1P2D6juuo6VCz+JE3UuT6eVVg69gMLJaAu9DWEyVSvglh8sfb6OpJ2BaqF1HYQbT2qjdnGQ2FYzjZcOx/fS+WTivUyxrvq603aZJH9OkUhBBEU6BTii7nKw8729qhajjllg6JeGPEEbAqHV2DLJ+C2mqQJ/pZFGGq+Cv7bpAFhwA8VpAXvnd41PF0UXDDtg3fCOJX0AohGJfvWN4USkYl0bvjK14LK5izOHtcwNEBr55t0RQI353pehwVO0+y90Rctwvwqlf/ji5xAoSaUP6mE5YNydXl83trncKiVQSXt660uzi1Jo33Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(6666004)(2906002)(40460700003)(478600001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(66899024)(40480700001)(44832011)(70586007)(54906003)(70206006)(110136005)(316002)(36756003)(83380400001)(47076005)(26005)(82740400003)(336012)(426003)(36860700001)(2616005)(81166007)(7049001)(356005)(1076003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 04:23:40.5549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa903dc4-07ea-4047-8ae2-08dbcba42dce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP TCM information is fixed in driver. Now ZynqMP TCM information
is available in device-tree. Parse TCM information in driver
as per new bindings.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v6:
  - Missing . at the end of the commit message
  - remove redundant initialization of variables
  - remove fail_tcm label and relevant code to free memory
    acquired using devm_* API. As this will be freed when device free it
  - add extra check to see if "reg" property is supported or not

 drivers/remoteproc/xlnx_r5_remoteproc.c | 106 ++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 04e95d880184..8c3575970c1d 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -75,8 +75,8 @@ struct mbox_info {
 };
 
 /*
- * Hardcoded TCM bank values. This will be removed once TCM bindings are
- * accepted for system-dt specifications and upstreamed in linux kernel
+ * Hardcoded TCM bank values. This will stay in driver to maintain backward
+ * compatibility with device-tree that does not have TCM information.
  */
 static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
 	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
@@ -613,7 +613,8 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 						 bank_name);
 		if (!rproc_mem) {
 			ret = -ENOMEM;
-			zynqmp_pm_release_node(pm_domain_id);
+			if (pm_domain_id)
+				zynqmp_pm_release_node(pm_domain_id);
 			goto release_tcm_split;
 		}
 
@@ -626,7 +627,8 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 	/* If failed, Turn off all TCM banks turned on before */
 	for (i--; i >= 0; i--) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
-		zynqmp_pm_release_node(pm_domain_id);
+		if (pm_domain_id)
+			zynqmp_pm_release_node(pm_domain_id);
 	}
 	return ret;
 }
@@ -940,6 +942,8 @@ static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
 		}
 	}
 
+	return 0;
+
 fail_add_pm_domains_lockstep:
 	while (j >= 1) {
 		if (r5_core->pm_dev_link2 && !IS_ERR_OR_NULL(r5_core->pm_dev_link2[j]))
@@ -1102,6 +1106,83 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 	return ERR_PTR(ret);
 }
 
+static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
+{
+	struct zynqmp_r5_core *r5_core;
+	int i, j, tcm_bank_count, ret;
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
+		np = dev_of_node(dev);
+
+		/* we have address cell 2 and size cell as 2 */
+		ret = of_property_count_elems_of_size(np, "reg",
+						      4 * sizeof(u32));
+		if (ret <= 0) {
+			dev_err(dev, "can't get reg property err %d\n", ret);
+			return -EINVAL;
+		}
+
+		tcm_bank_count = ret;
+
+		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
+						  sizeof(struct mem_bank_data *),
+						  GFP_KERNEL);
+		if (!r5_core->tcm_banks)
+			ret = -ENOMEM;
+
+		r5_core->tcm_bank_count = tcm_bank_count;
+		for (j = 0; j < tcm_bank_count; j++) {
+			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data *),
+					   GFP_KERNEL);
+			if (!tcm)
+				return -ENOMEM;
+
+			r5_core->tcm_banks[j] = tcm;
+
+			/* get tcm address without translation */
+			ret = of_property_read_reg(np, j, &abs_addr, &size);
+			if (ret) {
+				dev_err(dev, "failed to get reg property\n");
+				return ret;
+			}
+
+			/*
+			 * remote processor can address only 32 bits
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
@@ -1180,10 +1261,19 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 	struct zynqmp_r5_core *r5_core;
 	int ret, i;
 
-	ret = zynqmp_r5_get_tcm_node(cluster);
-	if (ret < 0) {
-		dev_err(dev, "can't get tcm node, err %d\n", ret);
-		return ret;
+	r5_core = cluster->r5_cores[0];
+	if (of_find_property(r5_core->np, "reg", NULL)) {
+		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
+		if (ret) {
+			dev_err(dev, "can't get tcm node from dt, err %d\n", ret);
+			return ret;
+		}
+	} else {
+		ret = zynqmp_r5_get_tcm_node(cluster);
+		if (ret < 0) {
+			dev_err(dev, "can't get tcm node, err %d\n", ret);
+			return ret;
+		}
 	}
 
 	for (i = 0; i < cluster->core_count; i++) {
-- 
2.25.1

