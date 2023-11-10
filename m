Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71A67E7FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbjKJR6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjKJR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:56:15 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B36327048;
        Fri, 10 Nov 2023 02:07:53 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AAA7bnJ112103;
        Fri, 10 Nov 2023 04:07:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699610857;
        bh=mxg1FHFd1rRvOC36n+OHwsPn0OmqfcxRKRDGDy9uAcI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DT+hVshrjO7vdhNxIT15tWkNSdAqW0Duo9P8wf7DC4oVXlFVeWvxcg8bGpUOZEbTG
         Zjb+W7zqtG5NM5WAKE4iqXMkjL1jFW9y1buOnsrufpsoAd28YDouVEfTyZNRcnczXZ
         njvC/676o5TyQUiT7WVWDcqXMVL50ybbZvjty4BI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AAA7bKu003760
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Nov 2023 04:07:37 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 04:07:37 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 04:07:37 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AAA7S4r051776;
        Fri, 10 Nov 2023 04:07:35 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Tero Kristo <t-kristo@kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH 2/2] watchdog: rti_wdt: Drop RPM watchdog when unused
Date:   Fri, 10 Nov 2023 15:37:26 +0530
Message-ID: <20231110100726.2930218-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231110100726.2930218-1-vigneshr@ti.com>
References: <20231110100726.2930218-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do a RPM put if watchdog is not already started during probe and re
enable it in watchdog start.

On K3 SoCs, watchdogs and their corresponding CPUs are under same PD, so
if the reference count of unused watchdogs aren't dropped, it will lead
to CPU hotplug failures as Device Management firmware won't allow to
turn off the PD due to dangling reference count.

Fixes: 2d63908bdbfb ("watchdog: Add K3 RTI watchdog support")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/watchdog/rti_wdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 163bdeb6929a..87f2c333a41d 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -78,6 +78,9 @@ static int rti_wdt_start(struct watchdog_device *wdd)
 	u32 timer_margin;
 	struct rti_wdt_device *wdt = watchdog_get_drvdata(wdd);
 
+	if (pm_runtime_suspended(wdd->parent))
+		pm_runtime_get_sync(wdd->parent);
+
 	/* set timeout period */
 	timer_margin = (u64)wdd->timeout * wdt->freq;
 	timer_margin >>= WDT_PRELOAD_SHIFT;
@@ -337,6 +340,9 @@ static int rti_wdt_probe(struct platform_device *pdev)
 	if (last_ping)
 		watchdog_set_last_hw_keepalive(wdd, last_ping);
 
+	if (!watchdog_hw_running(wdd))
+		pm_runtime_put_sync(&pdev->dev);
+
 	return 0;
 }
 
@@ -345,6 +351,9 @@ static void rti_wdt_remove(struct platform_device *pdev)
 	struct rti_wdt_device *wdt = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&wdt->wdd);
+
+	if (!pm_runtime_suspended(&pdev->dev))
+		pm_runtime_put_sync(&pdev->dev);
 }
 
 static const struct of_device_id rti_wdt_of_match[] = {
-- 
2.42.0

