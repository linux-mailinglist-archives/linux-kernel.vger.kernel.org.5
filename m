Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112F57B1CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjI1Mho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjI1Mhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:37:38 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A31B139
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:37:37 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 933D220A04;
        Thu, 28 Sep 2023 14:37:32 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/4] power: reset: gpio-poweroff: use a struct to store the module variables
Date:   Thu, 28 Sep 2023 14:37:25 +0200
Message-Id: <20230928123728.21901-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928123204.20345-1-francesco@dolcini.it>
References: <20230928123204.20345-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Use a struct to store the module variables. This is required to later
move to notifier_blocks where we can have several instances.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/power/reset/gpio-poweroff.c | 48 +++++++++++++++++++----------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index b28f24da1b3c..dea550e422f3 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -17,32 +17,37 @@
 #include <linux/module.h>
 
 #define DEFAULT_TIMEOUT_MS 3000
+
+struct gpio_poweroff {
+	struct gpio_desc *reset_gpio;
+	u32 timeout_ms;
+	u32 active_delay_ms;
+	u32 inactive_delay_ms;
+};
+
 /*
  * Hold configuration here, cannot be more than one instance of the driver
  * since pm_power_off itself is global.
  */
-static struct gpio_desc *reset_gpio;
-static u32 timeout = DEFAULT_TIMEOUT_MS;
-static u32 active_delay = 100;
-static u32 inactive_delay = 100;
+static struct gpio_poweroff *gpio_poweroff;
 
 static void gpio_poweroff_do_poweroff(void)
 {
-	BUG_ON(!reset_gpio);
+	BUG_ON(!gpio_poweroff);
 
 	/* drive it active, also inactive->active edge */
-	gpiod_direction_output(reset_gpio, 1);
-	mdelay(active_delay);
+	gpiod_direction_output(gpio_poweroff->reset_gpio, 1);
+	mdelay(gpio_poweroff->active_delay_ms);
 
 	/* drive inactive, also active->inactive edge */
-	gpiod_set_value_cansleep(reset_gpio, 0);
-	mdelay(inactive_delay);
+	gpiod_set_value_cansleep(gpio_poweroff->reset_gpio, 0);
+	mdelay(gpio_poweroff->inactive_delay_ms);
 
 	/* drive it active, also inactive->active edge */
-	gpiod_set_value_cansleep(reset_gpio, 1);
+	gpiod_set_value_cansleep(gpio_poweroff->reset_gpio, 1);
 
 	/* give it some time */
-	mdelay(timeout);
+	mdelay(gpio_poweroff->timeout_ms);
 
 	WARN_ON(1);
 }
@@ -60,20 +65,29 @@ static int gpio_poweroff_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
+	gpio_poweroff = devm_kzalloc(&pdev->dev, sizeof(*gpio_poweroff), GFP_KERNEL);
+	if (!gpio_poweroff)
+		return -ENOMEM;
+
 	input = device_property_read_bool(&pdev->dev, "input");
 	if (input)
 		flags = GPIOD_IN;
 	else
 		flags = GPIOD_OUT_LOW;
 
-	device_property_read_u32(&pdev->dev, "active-delay-ms", &active_delay);
+
+	gpio_poweroff->active_delay_ms = 100;
+	gpio_poweroff->inactive_delay_ms = 100;
+	gpio_poweroff->timeout_ms = DEFAULT_TIMEOUT_MS;
+
+	device_property_read_u32(&pdev->dev, "active-delay-ms", &gpio_poweroff->active_delay_ms);
 	device_property_read_u32(&pdev->dev, "inactive-delay-ms",
-				 &inactive_delay);
-	device_property_read_u32(&pdev->dev, "timeout-ms", &timeout);
+				 &gpio_poweroff->inactive_delay_ms);
+	device_property_read_u32(&pdev->dev, "timeout-ms", &gpio_poweroff->timeout_ms);
 
-	reset_gpio = devm_gpiod_get(&pdev->dev, NULL, flags);
-	if (IS_ERR(reset_gpio))
-		return PTR_ERR(reset_gpio);
+	gpio_poweroff->reset_gpio = devm_gpiod_get(&pdev->dev, NULL, flags);
+	if (IS_ERR(gpio_poweroff->reset_gpio))
+		return PTR_ERR(gpio_poweroff->reset_gpio);
 
 	pm_power_off = &gpio_poweroff_do_poweroff;
 	return 0;
-- 
2.25.1

