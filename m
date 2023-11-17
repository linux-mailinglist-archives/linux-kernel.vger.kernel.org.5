Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1F7EF5E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346121AbjKQQK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjKQQKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:10:50 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49638127;
        Fri, 17 Nov 2023 08:10:47 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHGADSL119470;
        Fri, 17 Nov 2023 10:10:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700237413;
        bh=S2L3bCQjS4V5uoOpa2XWqDJtGarbiLRZq+mnrAw4iks=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TI2VIhiqa482KMcnEagSiDxLVBtUzI06ANw29jYYweKOO+OatTBmbfM7TVzKSVnkB
         2KkgFpoTrqVVYh3sKP0HBntCNtn5OjKrChqyKTlRMy8Ku8D1YlHNRbQiibJRvJhx8Q
         q54XUGTl2UTdT+FpjrCiGmVjw+7RPNo7jzYeD5S4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHGADtU001162
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Nov 2023 10:10:13 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 10:10:13 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 10:10:12 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHGA8GM004950;
        Fri, 17 Nov 2023 10:10:11 -0600
From:   Andrew Davis <afd@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Joel Stanley <joel@jms.id.au>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH RFC 3/5] power: reset: gpio-restart: Use devm_register_sys_off_handler()
Date:   Fri, 17 Nov 2023 10:10:04 -0600
Message-ID: <20231117161006.87734-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231117161006.87734-1-afd@ti.com>
References: <20231117161006.87734-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device life-cycle managed register function to simplify probe error
path and eliminate need for explicit remove function.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/gpio-restart.c | 34 ++++++++----------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpio-restart.c
index 3aa19765772dc..d1e177176fa1f 100644
--- a/drivers/power/reset/gpio-restart.c
+++ b/drivers/power/reset/gpio-restart.c
@@ -17,17 +17,14 @@
 
 struct gpio_restart {
 	struct gpio_desc *reset_gpio;
-	struct notifier_block restart_handler;
 	u32 active_delay_ms;
 	u32 inactive_delay_ms;
 	u32 wait_delay_ms;
 };
 
-static int gpio_restart_notify(struct notifier_block *this,
-				unsigned long mode, void *cmd)
+static int gpio_restart_notify(struct sys_off_data *data)
 {
-	struct gpio_restart *gpio_restart =
-		container_of(this, struct gpio_restart, restart_handler);
+	struct gpio_restart *gpio_restart = data->cb_data;
 
 	/* drive it active, also inactive->active edge */
 	gpiod_direction_output(gpio_restart->reset_gpio, 1);
@@ -52,6 +49,7 @@ static int gpio_restart_probe(struct platform_device *pdev)
 {
 	struct gpio_restart *gpio_restart;
 	bool open_source = false;
+	int priority = 129;
 	u32 property;
 	int ret;
 
@@ -71,8 +69,6 @@ static int gpio_restart_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	gpio_restart->restart_handler.notifier_call = gpio_restart_notify;
-	gpio_restart->restart_handler.priority = 129;
 	gpio_restart->active_delay_ms = 100;
 	gpio_restart->inactive_delay_ms = 100;
 	gpio_restart->wait_delay_ms = 3000;
@@ -83,7 +79,7 @@ static int gpio_restart_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Invalid priority property: %u\n",
 					property);
 		else
-			gpio_restart->restart_handler.priority = property;
+			priority = property;
 	}
 
 	of_property_read_u32(pdev->dev.of_node, "active-delay",
@@ -93,9 +89,11 @@ static int gpio_restart_probe(struct platform_device *pdev)
 	of_property_read_u32(pdev->dev.of_node, "wait-delay",
 			&gpio_restart->wait_delay_ms);
 
-	platform_set_drvdata(pdev, gpio_restart);
-
-	ret = register_restart_handler(&gpio_restart->restart_handler);
+	ret = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_RESTART,
+					    priority,
+					    gpio_restart_notify,
+					    gpio_restart);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: cannot register restart handler, %d\n",
 				__func__, ret);
@@ -105,19 +103,6 @@ static int gpio_restart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void gpio_restart_remove(struct platform_device *pdev)
-{
-	struct gpio_restart *gpio_restart = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = unregister_restart_handler(&gpio_restart->restart_handler);
-	if (ret) {
-		dev_err(&pdev->dev,
-				"%s: cannot unregister restart handler, %d\n",
-				__func__, ret);
-	}
-}
-
 static const struct of_device_id of_gpio_restart_match[] = {
 	{ .compatible = "gpio-restart", },
 	{},
@@ -125,7 +110,6 @@ static const struct of_device_id of_gpio_restart_match[] = {
 
 static struct platform_driver gpio_restart_driver = {
 	.probe = gpio_restart_probe,
-	.remove_new = gpio_restart_remove,
 	.driver = {
 		.name = "restart-gpio",
 		.of_match_table = of_gpio_restart_match,
-- 
2.39.2

