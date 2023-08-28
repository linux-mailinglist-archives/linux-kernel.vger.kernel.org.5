Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CAB78A94C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjH1JvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjH1JvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:51:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8ECCA;
        Mon, 28 Aug 2023 02:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1FZdqxOyeuyXL6paf1Sbn0fMNmj9ZZgMrveWixM6RMUKgrgdeZNGrLNM+kO8uwVTiZDCYlNtdn87PrAw4XPc2gQxT5bU1fmGd3xr0iXWD8LBuTFFMh6HYFHdtUK+GLSGPgiF2ubx1KftuR6yOOGgELnBYSaOncPOP14qsSVK6b87QZ+G6M27PIDteKOiyxDC5mVdbfV4wMBdLj5bjLxhtG9LenF26ZJ3zWfmiZcZVPiUgknYGkzPj9PlZEoaFYi7kfzCyQh5Sg8sYdqqneMrCLVR+xIEOJXqs3U9IMyuc1qR2fOpNW4U60k8wQoP+V7meIGkV4+ulkA8X00+S1Lcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Qa8aDl4C4CNYobVGuP4IPGGAfxHG9WWBQdUHhylmTo=;
 b=PV86dSMCNIQlkoAT6NYAeNHeKFSHYaU4RX3o8X/QIrRhvz1rWSaIPcryv6WDaWGvmXQEaEZ1KPb0EDbFfmxYM8mxocGFHzwvcY2z+1VYpBzOu95NDdiTG1xs8FjE0wwWH7O52yVVStdoUDHtf5RvQXwbKT9I9SpZbh/fUkc58YWnj+T/LIhmJiqermdPHSWDWgesDj1ROsLLPLp7rXIk4Cr773ok/7pEgL/Upr2oad5w78jq20NjlTCHnbJsEaUanfMxrTXuSWU/yNf6oHkwP42KQeA+BJJSMeTezvv6Z1QBlIPr1a8aGYM+zqJs41rg2vlOOJvZiGSj0LJoK9joLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Qa8aDl4C4CNYobVGuP4IPGGAfxHG9WWBQdUHhylmTo=;
 b=i3IZc6ZU1Cx4sjry85f8q3MGYEpf08CvXuLbq8QhzKh2c/lGBCa3w2UiFJ4Bc9f5ozh/rxXwcHONfsrMrJkMHir2E83z+tgFnyfI+nXUQYvyxuP02uTJiKQqkulvPxBYZ3cnkSDj1xwFrvL3qq36kFDYemkNW3GaslfqScMX374=
Received: from MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::24)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 09:51:06 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::5d) by MW4P220CA0019.outlook.office365.com
 (2603:10b6:303:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 09:51:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Mon, 28 Aug 2023 09:51:05 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 04:50:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 02:50:23 -0700
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 28 Aug 2023 04:50:20 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <christophe.jaillet@wanadoo.fr>
CC:     <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        <neelisrinivas18@gmail.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>
Subject: [PATCH V3] watchdog: of_xilinx_wdt: Remove unnecessary clock disable call in the remove path
Date:   Mon, 28 Aug 2023 15:20:06 +0530
Message-ID: <20230828095006.3602426-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e19232-7976-4be9-230e-08dba7ac4c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: badaBdFDCPehXMSSItgEW32ZGDQ3bIJG+O9TMC5efCcCe0/TaNTR3IV6IDxqEi9GVHOYDhGEycYowhQZqs20A+FFogBMVQ+RcPb8nFc6fnV5E5g6pj7qy6FI/7c/DaD1SxBudoIOO2ATSMW2cLOrUNA/adc3Dr4V9q+aWQAgDAf5rqGi7pwWuszCTAUC4bFiF6cv4udftqTU1r9O1VIruCvremxbpVmizgFOAoXhNVkNEmm0r5Vz/SxrBzMhyX1dsrJc17vPbkfryg1OBEW9dj1NIONV9URP5YN0AypVdHadjKUoBSLUv+CNJJfKYBsE0Gi1sLzYdkwmYqcDaGk4u7ZefB2Rj5oPPM3vFO1xdJhp0xfKwW2SuGB0KKP4kioM6MjCQqXDYxfGgaQ5wRYv9tcD7bj+BLS0f744n2hhQ1hRdOcu0a+1wvllglvF4iewb3rYX8hYrNuspSCIex9IEfo2BXuBR3hILSDe2v0yJ06zKxlA+odi0rKACDZe6iOy50aCaBbKSSQGwELW9o1p7zSJuqUq91zaolYsutUtGB2jfOpBFutLhuZYPaFB8961P9A1mHlKzwalnxFoHv7sIHZ3R60aNa1fgfSiYpbMtFaJhJ98csOpWtoEeycOL4uqoeJXoUQsXX3A2262DnX9QRtwHR6/HDSbhjOPzOJdwUUvGMEXc8ouJsK1chpRLEvw6WHhsC9tGg+x8OSIwedC+UuPe5T4m5yg2/hs7Wdnub1W8BR833+Rb/NYYt4AGvMytsGadARzGDFv0ixJHNNilQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(6666004)(5660300002)(70206006)(40460700003)(36756003)(86362001)(81166007)(356005)(47076005)(40480700001)(2616005)(82740400003)(36860700001)(2906002)(1076003)(336012)(426003)(83380400001)(26005)(478600001)(8676002)(110136005)(70586007)(8936002)(54906003)(316002)(41300700001)(44832011)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 09:51:05.5472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e19232-7976-4be9-230e-08dba7ac4c29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a mismatch in axi clock enable and disable calls.
The axi clock is enabled and disabled by the probe function,
then it is again disabled in the remove path.
So observed the call trace while removing the module.
Use the clk_enable() and devm_clk_get_prepared() functions
instead of devm_clk_get_enable() to avoid an extra clock disable
call from the remove path.

 Call trace:
  clk_core_disable+0xb0/0xc0
  clk_disable+0x30/0x4c
  clk_disable_unprepare+0x18/0x30
  devm_clk_release+0x24/0x40
  devres_release_all+0xc8/0x190
  device_unbind_cleanup+0x18/0x6c
  device_release_driver_internal+0x20c/0x250
  device_release_driver+0x18/0x24
  bus_remove_device+0x124/0x130
  device_del+0x174/0x440

Fixes: 4de0224c6fbe ("watchdog: of_xilinx_wdt: Use devm_clk_get_enabled() helper")
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V3:
-> Added "clk_disable() in xwdt_selftest() error path.
Changes in V2:
-> Fixed typo in "To" list(linux@roeck-us.net).
---
 drivers/watchdog/of_xilinx_wdt.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 05657dc1d36a..352853e6fe71 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -187,7 +187,7 @@ static int xwdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
 
-	xdev->clk = devm_clk_get_enabled(dev, NULL);
+	xdev->clk = devm_clk_get_prepared(dev, NULL);
 	if (IS_ERR(xdev->clk)) {
 		if (PTR_ERR(xdev->clk) != -ENOENT)
 			return PTR_ERR(xdev->clk);
@@ -218,18 +218,25 @@ static int xwdt_probe(struct platform_device *pdev)
 	spin_lock_init(&xdev->spinlock);
 	watchdog_set_drvdata(xilinx_wdt_wdd, xdev);
 
+	rc = clk_enable(xdev->clk);
+	if (rc) {
+		dev_err(dev, "unable to enable clock\n");
+		return rc;
+	}
+
 	rc = xwdt_selftest(xdev);
 	if (rc == XWT_TIMER_FAILED) {
 		dev_err(dev, "SelfTest routine error\n");
+		clk_disable(xdev->clk);
 		return rc;
 	}
 
+	clk_disable(xdev->clk);
+
 	rc = devm_watchdog_register_device(dev, xilinx_wdt_wdd);
 	if (rc)
 		return rc;
 
-	clk_disable(xdev->clk);
-
 	dev_info(dev, "Xilinx Watchdog Timer with timeout %ds\n",
 		 xilinx_wdt_wdd->timeout);
 
-- 
2.25.1

