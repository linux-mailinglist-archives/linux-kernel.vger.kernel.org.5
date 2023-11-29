Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB247FD59A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjK2L1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjK2L1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:27:17 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A74B5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:27:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKD+Eb0iMGJcBx2ZgTXneM2/9acyPzmISg9pr/8B6CTMFnFJuc5cFPBxLrp4kja7YqGDxuTlM6mBC1gxQ3tSTSgqeKyw9NOiwe9O8SVA4FmgdHlKesW1A1oeHdk4W4A8oSBWGKK9xzDElK3LRyuFM1MU/oChAq3tqLUyWUKaiHD4UmpQPQqFq7UJiXY6a4L3X3juS1ZxdCgX7p0aFLthTsrbIjmcZAm3kGJ/yXl3HMcouNS6D4uymAKv8YqY15OPOBiAV0Nf45h+XGCh1Hr3GS99vMgI8KWkj4ok9Dib3zoJT3+ovg47Wcn1vourH4YV32hluDQupNNyxiLrpy5amg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNSebFxOUJfopv7pCTb3LY6J4r0xwq6xUP8EetUrtQ8=;
 b=j8vUoiXVE8EMOrfwxbogq7vqJ2S8KpDP/ai4Y9X/R0vCwLRpuU+KWiIcqEvzcuI8ADKSm8+WY1hCApWvzvnC+YQM5EWt6KpM51fDsUz2f/vjj2vGOQHng2HAairOQHqID9YexC9CoAbR0WUhSjieDfEhAbK4usSlYLinUwH/JLlx4avWC7GkvRdOVJgIzlfu6rxkyae74GxCNqS6O1mblCfIGsMlduebxfxDv/FG5m9j2hsmUwdb1uvt2XOXzuUZ+rk67Rs9kCeewXgs+RVu/ulxR9vFk3InZhq2UmFvclnLRVRZuGLkNgZRLJnRKeiVlfML/o77H15Ch8frSU0sLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNSebFxOUJfopv7pCTb3LY6J4r0xwq6xUP8EetUrtQ8=;
 b=S+kNZJ+MJ8Y5vscwxwEaDxZaJw5xdFJtW4UYGWADO73vGE9KWY78aWKkRvd8urIlzt3LvPmH4phsaxTfzX0hAFC4U1NUhdvsik2cnq6FEc6DVWy3HPR0jFTXRZ8Q1s8+jT9WdTV98Nd8RvyYoDuOpux07HdgRBscsJgLWddJ7PY=
Received: from MN2PR18CA0024.namprd18.prod.outlook.com (2603:10b6:208:23c::29)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 11:27:19 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::57) by MN2PR18CA0024.outlook.office365.com
 (2603:10b6:208:23c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 11:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 11:27:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 05:27:18 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 05:27:18 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 29 Nov 2023 05:27:17 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <nava.kishore.manne@amd.com>, <sai.krishna.potthuri@amd.com>,
        <robh@kernel.org>, <marex@denx.de>, <arnd@arndb.de>,
        <izhar.ameer.shaikh@amd.com>, <ruanjinjie@huawei.com>,
        <linus.walleij@linaro.org>, <shubhrajyoti.datta@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Saeed Nowshadi <saeed.nowshadi@amd.com>
Subject: [PATCH v5 2/5] firmware: xilinx: Expand feature check to support all PLM modules
Date:   Wed, 29 Nov 2023 03:27:10 -0800
Message-ID: <20231129112713.22718-3-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231129112713.22718-1-jay.buddhabhatti@amd.com>
References: <20231129112713.22718-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac710c5-1706-4248-0635-08dbf0ce25c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wt6YDXJztU4dHQTfTSdb/SnHzr6HjeJkIhbq4kClgCP4DJjvuxBLc4ZlpLqgDwqFqtaeWBzioglfychxl4FXZn+eYCBCVJ2lTpiCS1/eYZxobd3yl3wPT1Ns1j87h4/zRhDsVd6b69ql1LMGnEIAyNcxkPZE3Sie/5+9T0aLPn4JjCkpwdav0bsuJJLpXzgK2uYyLQRUxEtfdwhCy31bDNPqUHnHhdfrJOBG9gbskRjiXSBPs4MuLiO8eGexuNENiMgvej8n05XKnCyduNZ+WWHdgaq9nQMJG4NKP9lmmBfwE/lTwS6xGenwaw2gUv3kjrMpWDbE7Oy0LVX37z98Aubm8qZEY0P06LN4DN/KnD7VPZtTgBwBBcKdtAQcg0b7UynSmNVmd0rsbJSUFcMGORlQtu1AJt8tNyXmQhQG0wGTZ3RHDwctFTOfM3uPU4KmRJ/W9RCAswAKEftb7UoUSMovNkfKr46rl+MkrfUvL9SEC8cZrM8lbrMyKecgiAMaCDasheD+GFy8bZWWhqrrhHlnH1PaMAD7awCqOq3KwZAlcFb/M4Huoe+yb/c1QcEIeCG7D4/Jv1qhp676IA0d4PtJIEnVBZ0DPp6pSvZwZ7z9avvePyZzDC52BT63U2ldYhCWBBJwx1gHwEgfUNpiqc0NOIMJEBTdr/tdtCHKatT7z4dnbGYC2w5IS/EPYPv4ZNzCKWo2LErOjNHUT+1+P8iOPMrnRvIEHsIFwpJbhDUt5tM75q2L2ygzcjbXthRPUaKX9bi2CPDUb3CdjHz2SJ2ecKQqcSVnsyFzEK7HdI0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(40470700004)(36840700001)(46966006)(316002)(6636002)(26005)(40480700001)(1076003)(2616005)(4326008)(44832011)(8676002)(8936002)(2906002)(6666004)(478600001)(426003)(5660300002)(41300700001)(336012)(83380400001)(36860700001)(70206006)(54906003)(70586007)(110136005)(47076005)(82740400003)(356005)(81166007)(40460700003)(921008)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:27:19.0408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac710c5-1706-4248-0635-08dbf0ce25c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support feature check for all modules, append the module id of the API
that is being checked to the feature check API so it could be routed to
the target module for processing.

There is no need to check compatible string because the board information
is taken via firmware interface.

Co-developed-by: Saeed Nowshadi <saeed.nowshadi@amd.com>
Signed-off-by: Saeed Nowshadi <saeed.nowshadi@amd.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 41 ++++++++++++++++------------
 include/linux/firmware/xlnx-zynqmp.h | 11 ++++++++
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index c9ec2c75cf0a..3bd03ea0d5b9 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -199,9 +199,29 @@ static int __do_feature_check_call(const u32 api_id, u32 *ret_payload)
 {
 	int ret;
 	u64 smc_arg[2];
+	u32 module_id;
+	u32 feature_check_api_id;
 
-	smc_arg[0] = PM_SIP_SVC | PM_FEATURE_CHECK;
-	smc_arg[1] = api_id;
+	module_id = FIELD_GET(MODULE_ID_MASK, api_id);
+
+	/*
+	 * Feature check of APIs belonging to PM, XSEM, and TF-A are handled by calling
+	 * PM_FEATURE_CHECK API. For other modules, call PM_API_FEATURES API.
+	 */
+	if (module_id == PM_MODULE_ID || module_id == XSEM_MODULE_ID || module_id == TF_A_MODULE_ID)
+		feature_check_api_id = PM_FEATURE_CHECK;
+	else
+		feature_check_api_id = PM_API_FEATURES;
+
+	/*
+	 * Feature check of TF-A APIs is done in the TF-A layer and it expects for
+	 * MODULE_ID_MASK bits of SMC's arg[0] to be the same as PM_MODULE_ID.
+	 */
+	if (module_id == TF_A_MODULE_ID)
+		module_id = PM_MODULE_ID;
+
+	smc_arg[0] = PM_SIP_SVC | FIELD_PREP(MODULE_ID_MASK, module_id) | feature_check_api_id;
+	smc_arg[1] = (api_id & API_ID_MASK);
 
 	ret = do_fw_call(ret_payload, 2, smc_arg[0], smc_arg[1]);
 	if (ret)
@@ -1904,22 +1924,9 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
-	if (!np) {
-		np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
-		if (!np)
-			return 0;
-
+	ret = do_feature_check_call(PM_FEATURE_CHECK);
+	if (ret >= 0 && ((ret & FIRMWARE_VERSION_MASK) >= PM_API_VERSION_1))
 		feature_check_enabled = true;
-	}
-
-	if (!feature_check_enabled) {
-		ret = do_feature_check_call(PM_FEATURE_CHECK);
-		if (ret >= 0)
-			feature_check_enabled = true;
-	}
-
-	of_node_put(np);
 
 	devinfo = devm_kzalloc(dev, sizeof(*devinfo), GFP_KERNEL);
 	if (!devinfo)
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index a7e24f5a71b6..ef8c3e252e2c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -32,6 +32,7 @@
 #define PM_SIP_SVC			0xC2000000
 
 /* PM API versions */
+#define PM_API_VERSION_1	1
 #define PM_API_VERSION_2	2
 
 #define PM_PINCTRL_PARAM_SET_VERSION	2
@@ -47,6 +48,9 @@
 #define FAMILY_CODE_MASK	GENMASK(27, 21)
 #define SUB_FAMILY_CODE_MASK	GENMASK(20, 19)
 
+#define API_ID_MASK		GENMASK(7, 0)
+#define MODULE_ID_MASK		GENMASK(11, 8)
+
 /* ATF only commands */
 #define TF_A_PM_REGISTER_SGI		0xa04
 #define PM_GET_TRUSTZONE_VERSION	0xa03
@@ -112,6 +116,12 @@
 #define XPM_EVENT_ERROR_MASK_NOC_NCR		BIT(13)
 #define XPM_EVENT_ERROR_MASK_NOC_CR		BIT(12)
 
+enum pm_module_id {
+	PM_MODULE_ID = 0x0,
+	XSEM_MODULE_ID = 0x3,
+	TF_A_MODULE_ID = 0xa,
+};
+
 enum pm_api_cb_id {
 	PM_INIT_SUSPEND_CB = 30,
 	PM_ACKNOWLEDGE_CB = 31,
@@ -119,6 +129,7 @@ enum pm_api_cb_id {
 };
 
 enum pm_api_id {
+	PM_API_FEATURES = 0,
 	PM_GET_API_VERSION = 1,
 	PM_REGISTER_NOTIFIER = 5,
 	PM_FORCE_POWERDOWN = 8,
-- 
2.17.1

