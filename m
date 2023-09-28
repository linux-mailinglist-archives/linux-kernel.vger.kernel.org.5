Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A300E7B1C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjI1Mhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjI1Mhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:37:36 -0400
X-Greylist: delayed 283 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 05:37:34 PDT
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD60180;
        Thu, 28 Sep 2023 05:37:34 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 003B0211EF;
        Thu, 28 Sep 2023 14:37:32 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/4] power: reset: gpio-poweroff: use sys-off handler API
Date:   Thu, 28 Sep 2023 14:37:26 +0200
Message-Id: <20230928123728.21901-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928123728.21901-1-francesco@dolcini.it>
References: <20230928123204.20345-1-francesco@dolcini.it>
 <20230928123728.21901-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Use the new sys-off handler API for gpio-poweroff. This allows us to
have more than one poweroff handler and prioritise them.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/power/reset/gpio-poweroff.c | 37 ++++++++++-------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index dea550e422f3..0deb293eb2d6 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -15,6 +15,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/reboot.h>
 
 #define DEFAULT_TIMEOUT_MS 3000
 
@@ -25,15 +26,9 @@ struct gpio_poweroff {
 	u32 inactive_delay_ms;
 };
 
-/*
- * Hold configuration here, cannot be more than one instance of the driver
- * since pm_power_off itself is global.
- */
-static struct gpio_poweroff *gpio_poweroff;
-
-static void gpio_poweroff_do_poweroff(void)
+static int gpio_poweroff_do_poweroff(struct sys_off_data *data)
 {
-	BUG_ON(!gpio_poweroff);
+	struct gpio_poweroff *gpio_poweroff = data->cb_data;
 
 	/* drive it active, also inactive->active edge */
 	gpiod_direction_output(gpio_poweroff->reset_gpio, 1);
@@ -50,20 +45,16 @@ static void gpio_poweroff_do_poweroff(void)
 	mdelay(gpio_poweroff->timeout_ms);
 
 	WARN_ON(1);
+
+	return NOTIFY_DONE;
 }
 
 static int gpio_poweroff_probe(struct platform_device *pdev)
 {
+	struct gpio_poweroff *gpio_poweroff;
 	bool input = false;
 	enum gpiod_flags flags;
-
-	/* If a pm_power_off function has already been added, leave it alone */
-	if (pm_power_off != NULL) {
-		dev_err(&pdev->dev,
-			"%s: pm_power_off function already registered\n",
-		       __func__);
-		return -EBUSY;
-	}
+	int ret;
 
 	gpio_poweroff = devm_kzalloc(&pdev->dev, sizeof(*gpio_poweroff), GFP_KERNEL);
 	if (!gpio_poweroff)
@@ -89,14 +80,11 @@ static int gpio_poweroff_probe(struct platform_device *pdev)
 	if (IS_ERR(gpio_poweroff->reset_gpio))
 		return PTR_ERR(gpio_poweroff->reset_gpio);
 
-	pm_power_off = &gpio_poweroff_do_poweroff;
-	return 0;
-}
-
-static int gpio_poweroff_remove(struct platform_device *pdev)
-{
-	if (pm_power_off == &gpio_poweroff_do_poweroff)
-		pm_power_off = NULL;
+	ret = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_POWER_OFF,
+					    SYS_OFF_PRIO_DEFAULT, gpio_poweroff_do_poweroff,
+					    gpio_poweroff);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Cannot register poweroff handler\n");
 
 	return 0;
 }
@@ -109,7 +97,6 @@ MODULE_DEVICE_TABLE(of, of_gpio_poweroff_match);
 
 static struct platform_driver gpio_poweroff_driver = {
 	.probe = gpio_poweroff_probe,
-	.remove = gpio_poweroff_remove,
 	.driver = {
 		.name = "poweroff-gpio",
 		.of_match_table = of_gpio_poweroff_match,
-- 
2.25.1

