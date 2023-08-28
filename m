Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A3B78A90B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjH1Ji4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjH1Jii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:38:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A2D103;
        Mon, 28 Aug 2023 02:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFQOVHm3/5H61qe6P94UUye9u0FrT3P2blt1Ql19NwcnN8sVoS5Q03y+KU/iSxEJ48UrN2oSHIOSiulDNGmSMyxlM0dJXaNObmSHtCexfCEZOPGs47sCMi+2YeimG1DyZH8NO8wVpJSdouyLSMMApbwc5QqavL/bw+fOGJRPAhvuT0UMfMYavfQpa/bct9JokdI7fV63Oyc7+gMhQU0V3dc5l1GbQvmk+YfIQukv6q4yVWNR5pSa8QO7+qpErASj6WqysgjPtPBPTheNEmk63tk5SMbeYA/GcQu6NCYs92u3M1qIW3URm0ldhRncBH+vWu0j434X6iLDx7AAe/nykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxkdEyLWlvyPGms8TOiz/tZ/WWBruXVMFWGRKE04ZaI=;
 b=lpI6q7GeCF6/8J8nPlTkStBanWtglyrpV4f04RNk1AsQcJKwioksv/MVj+IQkpT/4aL215C2IIen0/vH3hIY8xT2Hy4iq0QfRdgtAflSqzoYrJexWK3KmCnLVsEx6KSDZ/+EKrpoqCO/OcF4LiQot1b02vFomDp4/w+wz7A7nwW0LPTmAufazNH7cB+Fqn1y8GvS6CdYdWrppQO6KBqVOm4NangQfzWqr6UzaAD2NIZSJXOMKlMNp3rCXGNDi+bWyzEEw+XtbjgUJuhVKC1Jy86UUWDFloLjkpOkPgh0aKXbd+OCxYxuk0+9yerQGsIqPKzDdyuP65KpiQX9hvvA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxkdEyLWlvyPGms8TOiz/tZ/WWBruXVMFWGRKE04ZaI=;
 b=iSwK3v72r2ljutMKC7HZd5Iu1ohuh8iMRRQ8CB3+xoZzMu6/cr0LbEzhO1CvnJe8nbl5uwS8oWtwilOUTWDg4Vr3MF+FtsuTOaficzM9SsNRC7fcEd0ae/G8bVp7mrarzHSVpok8qYNR82gde3hO9737UQGGdzgKwgwBBlkiwac=
Received: from SA9PR03CA0020.namprd03.prod.outlook.com (2603:10b6:806:20::25)
 by CH2PR12MB4971.namprd12.prod.outlook.com (2603:10b6:610:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 09:38:33 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::85) by SA9PR03CA0020.outlook.office365.com
 (2603:10b6:806:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 09:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 09:38:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 04:38:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 02:38:31 -0700
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 28 Aug 2023 04:38:28 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <christophe.jaillet@wanadoo.fr>
CC:     <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        <neelisrinivas18@gmail.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>
Subject: [PATCH V2] watchdog: of_xilinx_wdt: Remove unnecessary clock disable call in the remove path
Date:   Mon, 28 Aug 2023 15:07:56 +0530
Message-ID: <20230828093756.3598755-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CH2PR12MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b78dc01-1288-4591-af09-08dba7aa8b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hzm52OV3SSwWXvAd9jZYmBufCheO6SbxRyvg5CAwrbT2IvWF7T51mWjKRzViEMUH7MlT9RwiEEwVoidhLEgboFq7ByduhnaxMUAekmmnEvxdbnYbcGJG/cm3XYBUN8wB+iWy1uqN58UqwTKYC3vKlbTUQ48fjfcirClhps3n4+kb83mvlr6V8CUypQCP86PYWj/CBhR1Vuglw59h/XXYXr+FcrV7WYrsJwiWI+mWIxtg9alu080tHZqFoXof99luTA/N9zw1IE8Ne17Jc8CeT8SMrKYMX9X1DGofAwHib0Ianlh+GifAL4DbLBQOqSti+YBf7+S52nFEj+lvTrDw3ziI5mHfd17+8uXAJoFfLia3mByzNfrBMFCHOhf+kJIAkcproRLtxMO7wMaxdpVD9m2CE8TwrdiMDoFoIQQykkkHReZtgFNf4B11T9UFnkZr4171F5Z60pksCUovp5UK5JOoNsVC4he+7d0zexTlW65kqFSgTOJpd7aR9UBfb/LZsB/172xIjvniGmaHgNlm8W4bB8W2rmSxRDxpv7u4hiCcpWAK92drYjOlC+pE6BwWSGPL6an3oDp8oldYIlSEPoCLXsqVg0mB+2haaAxi0BkCJ0sBzp5Qufu4nrsjA2y+bXC2y6J+G4HHsxlGbNySBcJBkvw2BuwmYYOqFM59qRKDAwSyAKZPEVtdO4R4+iYadJIz5Nwa6hfPiRedmdC++D5hJebn8q6nIsyoMFrLiojPniseysmRawkcVpwlS2h18TFDMJDdwRHkMRSPDY3yGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(6666004)(40480700001)(82740400003)(86362001)(40460700003)(26005)(1076003)(36756003)(2616005)(336012)(426003)(83380400001)(316002)(36860700001)(5660300002)(110136005)(70206006)(70586007)(54906003)(41300700001)(44832011)(47076005)(81166007)(2906002)(478600001)(356005)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 09:38:32.2099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b78dc01-1288-4591-af09-08dba7aa8b14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4971
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
Changes in V2:
-> Fixed typo in "To" list(linux@roeck-us.net).
---
 drivers/watchdog/of_xilinx_wdt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 05657dc1d36a..777272f7d326 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -187,7 +187,7 @@ static int xwdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
 
-	xdev->clk = devm_clk_get_enabled(dev, NULL);
+	xdev->clk = devm_clk_get_prepared(dev, NULL);
 	if (IS_ERR(xdev->clk)) {
 		if (PTR_ERR(xdev->clk) != -ENOENT)
 			return PTR_ERR(xdev->clk);
@@ -218,18 +218,24 @@ static int xwdt_probe(struct platform_device *pdev)
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

