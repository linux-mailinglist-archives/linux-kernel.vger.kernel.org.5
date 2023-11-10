Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4B17E80EA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345809AbjKJSTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjKJSRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:15 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7FF2704A;
        Fri, 10 Nov 2023 02:07:53 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AAA7Y5d015876;
        Fri, 10 Nov 2023 04:07:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699610854;
        bh=TBhNcMdYIYfOE3nmWstbO+Hog8z7g7tkR/0hU9Urw7A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=K4l61i8VdLOOk330swBJx8cC4Q5o++pyUe2BlospnkYgintcGzttYR8g6d3bnhe91
         o5fiYberLk/9Iu+2Cb1C98oFbtKasXbwkZC2DD171dU0GgINueyIPbR+DKDuYrMvtx
         uAO34wvUIpA6hIcnxTGCdVD6yZJqMrk8SeFcrtQo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AAA7Yqj095147
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Nov 2023 04:07:34 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 04:07:34 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 04:07:34 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AAA7S4q051776;
        Fri, 10 Nov 2023 04:07:32 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Tero Kristo <t-kristo@kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH 1/2] watchdog: rti_wdt: Use managed APIs to handle runtime PM
Date:   Fri, 10 Nov 2023 15:37:25 +0530
Message-ID: <20231110100726.2930218-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231110100726.2930218-1-vigneshr@ti.com>
References: <20231110100726.2930218-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to devm_pm_runtime_enable() to simplify error handling in driver
probe.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/watchdog/rti_wdt.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 8e1be7ba0103..163bdeb6929a 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -236,12 +236,8 @@ static int rti_wdt_probe(struct platform_device *pdev)
 	if (wdt->freq < 32768)
 		wdt->freq = wdt->freq * 9 / 10;
 
-	pm_runtime_enable(dev);
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0) {
-		pm_runtime_disable(&pdev->dev);
-		return dev_err_probe(dev, ret, "runtime pm failed\n");
-	}
+	devm_pm_runtime_enable(dev);
+	pm_runtime_get_noresume(dev);
 
 	platform_set_drvdata(pdev, wdt);
 
@@ -260,7 +256,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
 	wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->base)) {
 		ret = PTR_ERR(wdt->base);
-		goto err_iomap;
+		return ret;
 	}
 
 	if (readl(wdt->base + RTIDWDCTRL) == WDENABLE_KEY) {
@@ -286,7 +282,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
 		ret = rti_wdt_setup_hw_hb(wdd, wsize);
 		if (ret) {
 			dev_err(dev, "bad window size.\n");
-			goto err_iomap;
+			return ret;
 		}
 
 		last_ping = heartbeat_ms - time_left_ms;
@@ -301,7 +297,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
 		ret = of_address_to_resource(node, 0, &res);
 		if (ret) {
 			dev_err(dev, "No memory address assigned to the region.\n");
-			goto err_iomap;
+			return ret;
 		}
 
 		/*
@@ -312,15 +308,13 @@ static int rti_wdt_probe(struct platform_device *pdev)
 		reserved_mem_size = resource_size(&res);
 		if (reserved_mem_size < RESERVED_MEM_MIN_SIZE) {
 			dev_err(dev, "The size of reserved memory is too small.\n");
-			ret = -EINVAL;
-			goto err_iomap;
+			return -EINVAL;
 		}
 
 		vaddr = memremap(paddr, reserved_mem_size, MEMREMAP_WB);
 		if (!vaddr) {
 			dev_err(dev, "Failed to map memory-region.\n");
-			ret = -ENOMEM;
-			goto err_iomap;
+			return -ENOMEM;
 		}
 
 		if (vaddr[0] == PON_REASON_SOF_NUM &&
@@ -337,19 +331,13 @@ static int rti_wdt_probe(struct platform_device *pdev)
 	ret = watchdog_register_device(wdd);
 	if (ret) {
 		dev_err(dev, "cannot register watchdog device\n");
-		goto err_iomap;
+		return ret;
 	}
 
 	if (last_ping)
 		watchdog_set_last_hw_keepalive(wdd, last_ping);
 
 	return 0;
-
-err_iomap:
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-
-	return ret;
 }
 
 static void rti_wdt_remove(struct platform_device *pdev)
@@ -357,8 +345,6 @@ static void rti_wdt_remove(struct platform_device *pdev)
 	struct rti_wdt_device *wdt = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&wdt->wdd);
-	pm_runtime_put(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 }
 
 static const struct of_device_id rti_wdt_of_match[] = {
-- 
2.42.0

