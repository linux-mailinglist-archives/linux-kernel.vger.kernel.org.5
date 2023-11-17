Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE07EF72F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346205AbjKQRnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjKQRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:42:58 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9373D7E;
        Fri, 17 Nov 2023 09:42:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6vUZfKNCeX26Sqv2WlrWUHMdC+0ES7oJ1qW7NRrK+8eZwkAY+9S9jtFOmxPNDE9cWgJ4AT3cUd3EPdeRyT2TDLt0nZjIx8keXdfKCLBNQqYt9NnhAVuGoM7wOdQKFMiueEC+iqJfXpp1RsIR3OzL2xsFryFcZDzW8B7veeOTIfQ/MRAZCYZBRDDnYU9mwFup7shW5YkjGDtlYSFQITg5ReCreXH7/xpZAuS2QbO2SuL7hCoDmFT+oevxSjqfUDFy0YW5+SsXBWecd8MNDYb3KKbacoaMYQGJ20sD23WzP3ZgFg2BNMB/o85DSznf4TpsYZAUQmpjPco+recRrqlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UDr2JdaYRDxThTk0QxeXOH7YbbTTjHNkri7s+8C5/4=;
 b=Ix7vU6y+RxWrajsZRCEdtoUQbDnrxkLNvtENy0t8EIWEg4JCeLWirz5y/hAYpE+1eaTuIP27xHkPnqC8lw+nuwf0k/4GKuYO5E/689JLo86WtPyJXWrVAjX+cgcQ/HzYQFjpPb6XDm1Xzq8lRb/DHFCYbG2C6VUcQg9V63rKFFn0fHEHP4RxYgums/oh+DXl/ipxtg8F1ECVkOSO4h/ImcboBzIl07dGKFiq42iSUF4yEk1iFgxxkHXJZk+D7Wjk+KHZdPAtlZ8HfEwK3kFAsRnvzXNvjIflP3ml71OGQ3as6oDUf88RG1+/VB3nmlNOzSk2q2qKZE0qR3ksumkwoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UDr2JdaYRDxThTk0QxeXOH7YbbTTjHNkri7s+8C5/4=;
 b=P3/c6h9Xs2MyhmBQwuF29DIRceeMlfvQ634h7nBuH7c9HUiR+NccVYvQQW/OKvZfXR2xZ9r0wMaDwdN5XCxvcwbM0h5/ha6qcEnedjHEeXocMiiPuGGQqA+tbspXCiByDp3DvFwph51sezyIJGu5yyrb7rgr81Kji229nJNW7aY=
Received: from DM6PR10CA0025.namprd10.prod.outlook.com (2603:10b6:5:60::38) by
 DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.23; Fri, 17 Nov 2023 17:42:50 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::78) by DM6PR10CA0025.outlook.office365.com
 (2603:10b6:5:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Fri, 17 Nov 2023 17:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 17:42:50 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 11:42:49 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 09:42:49 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 17 Nov 2023 11:42:48 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 4/4] remoteproc: zynqmp: parse TCM from device tree
Date:   Fri, 17 Nov 2023 09:42:38 -0800
Message-ID: <20231117174238.1876655-5-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117174238.1876655-1-tanmay.shah@amd.com>
References: <20231117174238.1876655-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da520fa-eca7-4939-e146-08dbe7949e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wvOxXHOVn5YmChPW781l2NQNU6pXCgzjkiWcCgVZLIQ5iVzcZjgyJ3ccfqBlsJq3X2inWj/iRnLtjEAZgwxpBYiFwh1Bdo/98cA/PfEptnC4gkAmrjl8ATgeGYoZYA9uyQCMIKN3Gt1hXKns2KLQB9rmWhmuHl+AT8jg3j+f7THyal+w/ImjgUxHu8kI8ZpLAPXZyyAK8pVC8ref00ky6KICIwshM9d8nuMfLCqdR0RT9srHN2xc86kPrx7Wta1SanqJ+COBGr+eo/gefdeGZfhWy5QWV+/JWjY1HvTy7zpsAyJhVkHPZwQs7J3wdj9MurSsOpbk/2hxUMPJVe8ROjtGEFya2uWtfGQGIGrIVtLqA1SEczaWiPul+9cZs131IqLSfAhnW2UpN9X0lFfKNtE9W/hluB8YKUuOTUGXLad3Gt4T9yd1ub7XZlr0WLrfXROgEzE3iyeCyaIFiCybwm9Ik0siJN0PXjh59OvCFWyQIx0FzQmZ5SLyPTFL+F1SrOVWCEcdII0wjUj7QDk+O8pRZRelZOGToTYxXYUkE2n8sjqccWLsDRps5akL/MWqh98i60oO3ZoVgDe7KIohX2LfpvqvdhHxEtmA3RkahRzwL8azkT/8rbE0PCXRpwcUvX7fKbSqcEATlZU4jSFya6CiEoFYgkoQp9G3ykvPmky7jTNevzPBF3SV4KhRwY1tTRZHUqTHIiE2AwcS/7upkQyL/IqYLF3jSuSzsYvYbnY017pRLEi+Jb4YiI9f3h41xUc6fotwBKNapm4wF0l92g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(40460700003)(66899024)(81166007)(7049001)(8676002)(4326008)(8936002)(70206006)(70586007)(110136005)(54906003)(83380400001)(316002)(2616005)(478600001)(1076003)(86362001)(6666004)(26005)(36756003)(426003)(336012)(82740400003)(2906002)(5660300002)(36860700001)(356005)(44832011)(47076005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 17:42:50.0787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da520fa-eca7-4939-e146-08dbe7949e6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

Changes in v7:
  - move checking of pm_domain_id from previous patch
  - fix mem_bank_data memory allocation

 drivers/remoteproc/xlnx_r5_remoteproc.c | 152 ++++++++++++++++++++----
 1 file changed, 128 insertions(+), 24 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 22bccc5075a0..270af73344ef 100644
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
@@ -587,12 +587,21 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 		bank_size = r5_core->tcm_banks[i]->size;
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
 
-		ret = zynqmp_pm_request_node(pm_domain_id,
-					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
-					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
-		if (ret < 0) {
-			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
-			goto release_tcm_split;
+		/*
+		 * If TCM information is available in device-tree then
+		 * in that case, pm domain framework will power on/off TCM.
+		 * In that case pm_domain_id is set to 0. If hardcode
+		 * bindings from driver is used, then only this driver will
+		 * use pm_domain_id.
+		 */
+		if (pm_domain_id) {
+			ret = zynqmp_pm_request_node(pm_domain_id,
+						     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
+						     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+			if (ret < 0) {
+				dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
+				goto release_tcm_split;
+			}
 		}
 
 		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, da=0x%x, size=0x%lx",
@@ -604,7 +613,8 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 						 bank_name);
 		if (!rproc_mem) {
 			ret = -ENOMEM;
-			zynqmp_pm_release_node(pm_domain_id);
+			if (pm_domain_id)
+				zynqmp_pm_release_node(pm_domain_id);
 			goto release_tcm_split;
 		}
 
@@ -617,7 +627,8 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
 	/* If failed, Turn off all TCM banks turned on before */
 	for (i--; i >= 0; i--) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
-		zynqmp_pm_release_node(pm_domain_id);
+		if (pm_domain_id)
+			zynqmp_pm_release_node(pm_domain_id);
 	}
 	return ret;
 }
@@ -659,13 +670,16 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
 
 		/* Turn on each TCM bank individually */
-		ret = zynqmp_pm_request_node(pm_domain_id,
-					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
-					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
-		if (ret < 0) {
-			dev_err(dev, "failed to turn on TCM 0x%x",
-				pm_domain_id);
-			goto release_tcm_lockstep;
+
+		if (pm_domain_id) {
+			ret = zynqmp_pm_request_node(pm_domain_id,
+						     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
+						     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+			if (ret < 0) {
+				dev_err(dev, "failed to turn on TCM 0x%x",
+					pm_domain_id);
+				goto release_tcm_lockstep;
+			}
 		}
 
 		bank_size = r5_core->tcm_banks[i]->size;
@@ -683,7 +697,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 						 bank_name);
 		if (!rproc_mem) {
 			ret = -ENOMEM;
-			zynqmp_pm_release_node(pm_domain_id);
+			if (pm_domain_id)
+				zynqmp_pm_release_node(pm_domain_id);
 			goto release_tcm_lockstep;
 		}
 
@@ -700,7 +715,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
 	/* If failed, Turn off all TCM banks turned on before */
 	for (i--; i >= 0; i--) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
-		zynqmp_pm_release_node(pm_domain_id);
+		if (pm_domain_id)
+			zynqmp_pm_release_node(pm_domain_id);
 	}
 	return ret;
 }
@@ -931,6 +947,8 @@ static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
 		}
 	}
 
+	return 0;
+
 fail_add_pm_domains_lockstep:
 	while (--j >= 0) {
 		device_link_del(r5_core->pm_dev_core1_link[j]);
@@ -1012,7 +1030,7 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
 
 	for (i = 0; i < r5_core->tcm_bank_count; i++) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
-		if (zynqmp_pm_release_node(pm_domain_id))
+		if (pm_domain_id && zynqmp_pm_release_node(pm_domain_id))
 			dev_warn(r5_core->dev,
 				 "can't turn off TCM bank 0x%x", pm_domain_id);
 	}
@@ -1087,6 +1105,83 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
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
+			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
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
@@ -1165,10 +1260,19 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
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

