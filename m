Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB26678A8D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjH1JWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjH1JWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:22:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B770CFD;
        Mon, 28 Aug 2023 02:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5W1I1eEkbAXOpmY999rTIvPkDBscg/av5a4pYqm7LgpR8HO3ZmrYlwgFocUphXhZ32xClEJKTer1U32VV54B/jqtTklg6WMFIRv8RR90JveK1qUp2f4OWORCtPOdoJehkebLOydmPvQFpFDB9Ilw5t2GKGFe9lqR1QEH8Uvr17POt9Fx7cXpPQ9IebQc7ldCNyVvu/ggShbo2rwB3qK5sIQvQaBuvn78HjLf9z0a0JyZEyP0+Tf8hMgWRqngay/tGH8LH6wPxwnHfLj3fqx1N2+ucV5B0gK2Zk5jwafhqncX6XnJsGSoByLsgJ953MZumotLWRPtNBQ0fijX681GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0r1Q4xQEdPajeBodpkju+NYa9bWPKUjXuDuAoc6q/0=;
 b=GJad7lEW0mDEWPCT4H4ZqWYTcK1Fn5RgucM5YXch2I5s/SdN/KzV2k67SaDNmPfRxPo7+jJq30sZ8QD1XTp3Zz+BHTjr1h0L5/nvd9gtBOqNsdKnMuN3bV4BUgSWRwKD4VqiMimhXmTJlzUylHhjmTySHtU96OCu0EXPnSPKBgj+WpbJKKS5s4DwtOpen+QuBaZ95tPHyE/kMFur44eDoV4he6BeCaAkLXTXEIt3UQoKEKLgXj20+sJgsRbcZpOcMuh9ysM5owEGW7RJtgGjxC5B4M8sPcw3ew2GhFzaDVncu4oEu6B+efmnlKfCq6I3VMlxZYVSQZ5tpKoU1/U97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0r1Q4xQEdPajeBodpkju+NYa9bWPKUjXuDuAoc6q/0=;
 b=34AXYwcP6MYKzpFJeu68o1qBP8gDwATn0XNjm888xEXVuxXliuJlej0tNwSEYws64ZImxdr55UEI9IS3/oHDFB5CUGkAr7IEdqMsdM8Il2aKW1ZvrJb9ikiZLD6jXMP9seUdYzzjcYQehMtHudslzogZopUJLii4rPnRDXyuVF4=
Received: from SA0PR11CA0144.namprd11.prod.outlook.com (2603:10b6:806:131::29)
 by PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 09:21:24 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:131:cafe::ee) by SA0PR11CA0144.outlook.office365.com
 (2603:10b6:806:131::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 09:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 09:21:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 04:21:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 04:21:19 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 28 Aug 2023 04:21:16 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <wim@linux-watchdog.org>, <linux@roeck-us.ne>,
        <christophe.jaillet@wanadoo.fr>
CC:     <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        <neelisrinivas18@gmail.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>
Subject: [PATCH] watchdog: of_xilinx_wdt: Remove unnecessary clock disable call in the remove path
Date:   Mon, 28 Aug 2023 14:50:44 +0530
Message-ID: <20230828092044.3597916-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d3900b-c231-4096-3dba-08dba7a825d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CW6W3zMBA9tu/D3iHmUUmeZppZzUlKPz38FwhqzlbCNgJ1wBqrG5icMUhFfwTkBYEjttIC7U/T39ZqCYkjt91Rr6pUyFjHhP1biAmeeQFh2UKp+UhcYSmHl5jCSPpOQXunZXB/29HsiFJir84GAIlvkRjnGHQ3Fe9gMm0IFvRCs7uIWmXBcCNJHA+NBEpYp4LRnzAjltMVfpivMQcN35Aut2BWaRkw5SXTnhaWn8zXQkLVjq5Qkrv+Khd1bAUDs8UI9pq86uU+yS4gd+8dFLZldqO+qmbWo8B5IyUHQiV4FkyUiPoF16KBgKGdM1losPoUwYlPeu6hWO6IcunWO/IAk930JMjci99VQcrybakC+PK4BAjDincK+64NLyyE8qHhQU2gqAFc9KNaymjAs942SCx9MvxlAnp76hnnqr4qj3zYAOSN93Vu8ysYaAcZu7vcsVkyOCRw1oQNRjU+ce4hkNg0CF6sRmgShdO9e3sHfcEDZa6Gs1S0oVAbKDN8ig1fuI2Bp28kyoq0pZykS9Uq7XqpYHs6FRdTpCmjzBvXs1TzUynLqBaqAy5TzU2vDzGlTSZQaqQ7+NtEGdnecYl5jrKt3VwlzIHhxwBa3J91vuMF/OG8tkBtPgBuKrSFVPteX7bE0SD5vtc+jBS92j32KdRSKD4btjQyAHTcllw9cqNPRwnklI4MgN+OKXvdctCsTGZrCFPVfshx/JETOvEmnVgXAdlJQ4b1TPLbVxmVnFn6kkBV+DRglwIz1jPRcu19WbvFgBuCF+0PBeBU20Iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(186009)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(6666004)(2616005)(86362001)(36756003)(40480700001)(40460700003)(82740400003)(356005)(47076005)(81166007)(36860700001)(83380400001)(1076003)(2906002)(426003)(26005)(478600001)(70586007)(110136005)(8676002)(4326008)(44832011)(8936002)(5660300002)(316002)(70206006)(54906003)(41300700001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 09:21:23.3508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d3900b-c231-4096-3dba-08dba7a825d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796
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

