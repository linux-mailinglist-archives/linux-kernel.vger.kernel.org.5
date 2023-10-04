Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E677B82E9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243003AbjJDO5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243043AbjJDO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:56:53 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7B4BF;
        Wed,  4 Oct 2023 07:56:47 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 3DC5386058;
        Wed,  4 Oct 2023 16:56:46 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Wed, 04 Oct 2023 16:56:28 +0200
Subject: [PATCH RFC v5 4/6] ARM: pxa: Convert reset driver to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231004-pxa-gpio-v5-4-d99ae6fceea8@skole.hr>
References: <20231004-pxa-gpio-v5-0-d99ae6fceea8@skole.hr>
In-Reply-To: <20231004-pxa-gpio-v5-0-d99ae6fceea8@skole.hr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3634;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=4NSf6nRqHgAPG1WiwL6ByRFscIsi1iq6bpWNwCWgJcw=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlHX0kIsnU2yb6NQa+JLbqEVhjjtHyHIfpuJ/1/
 v5rjuAT98qJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZR19JAAKCRCaEZ6wQi2W
 4fKkD/4lUF/j1aNfU/G+nduzIgzW2XaU0QH3T8Jn+YAS/8GW1LPFo0hc6CCIAZ29U/h+WJHTIeO
 hC/wabf33OODy1Bz06PDGKP2DLehHtSWZ9IRQbhzal7vp27zSp4RXG0MwJe8laVLi66w7cE1aLA
 w1ciX7zv0QhwyryD4jE0lnFiE0qWWz+M6Y15k4CEZqV3i0SDKh/Gad1yf9XFQ0IlwulBfbjezg8
 5fHnkG+S0UHGO9U89hcy0pNQxjtw77K6BHYL0L9MqpcZQeJoCRQhS141AypHEAB+dkLR3D6+LxJ
 8Jrj4V6RVGAj5LDtzzhbohULqYd5OE/LrXSUk11FD/d1nwg4NUnPTFwFlKuLcnOsyiryxa6R2D6
 rHxb/Pt4zXGfD2uOXPV/rGlIuq7Bv7FGVwGyCY2LqzCarYx+xynZh9kp+I9dfSY0tS1OkOFSRfj
 PjDDGUEXuCQmwwhZ8Y0IUKBpUqbfOVQYoM9VDWfIyvRk1H+qilvOrZ5Zq+xhqo5sLKzGYZGOOLb
 yyTKm7W3gMGISp7u+oqyl99S64Fl3k36tD5gII75Sto07s88bKCgP8re1DtqJVxGBmIEZD1D/AW
 CHrz7ODutoD/WS3HhXNsfHkFhsLO+21fKQR1inJLknDTYdkIQ0tLZNRQDNLjyQkVtuhkgY5OC5/
 vVD9oUNhdDxDklw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PXA reset driver still uses the legacy GPIO interface for
configuring and asserting the reset pin.

Convert it to use the GPIO descriptor interface.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/reset.c | 39 +++++++++++++--------------------------
 arch/arm/mach-pxa/reset.h |  3 +--
 arch/arm/mach-pxa/spitz.c |  6 +++++-
 3 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-pxa/reset.c b/arch/arm/mach-pxa/reset.c
index 27293549f8ad..08bc104b9411 100644
--- a/arch/arm/mach-pxa/reset.c
+++ b/arch/arm/mach-pxa/reset.c
@@ -2,7 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <asm/proc-fns.h>
 #include <asm/system_misc.h>
@@ -14,33 +14,20 @@
 
 static void do_hw_reset(void);
 
-static int reset_gpio = -1;
+static struct gpio_desc *reset_gpio;
 
-int init_gpio_reset(int gpio, int output, int level)
+int init_gpio_reset(int output, int level)
 {
-	int rc;
-
-	rc = gpio_request(gpio, "reset generator");
-	if (rc) {
-		printk(KERN_ERR "Can't request reset_gpio\n");
-		goto out;
+	reset_gpio = gpiod_get(NULL, "reset", GPIOD_ASIS);
+	if (IS_ERR(reset_gpio)) {
+		pr_err("Can't request reset_gpio: %pe\n", reset_gpio);
+		return PTR_ERR(reset_gpio);
 	}
 
 	if (output)
-		rc = gpio_direction_output(gpio, level);
+		return gpiod_direction_output(reset_gpio, level);
 	else
-		rc = gpio_direction_input(gpio);
-	if (rc) {
-		printk(KERN_ERR "Can't configure reset_gpio\n");
-		gpio_free(gpio);
-		goto out;
-	}
-
-out:
-	if (!rc)
-		reset_gpio = gpio;
-
-	return rc;
+		return gpiod_direction_input(reset_gpio);
 }
 
 /*
@@ -50,16 +37,16 @@ int init_gpio_reset(int gpio, int output, int level)
  */
 static void do_gpio_reset(void)
 {
-	BUG_ON(reset_gpio == -1);
+	BUG_ON(IS_ERR(reset_gpio));
 
 	/* drive it low */
-	gpio_direction_output(reset_gpio, 0);
+	gpiod_direction_output(reset_gpio, 0);
 	mdelay(2);
 	/* rising edge or drive high */
-	gpio_set_value(reset_gpio, 1);
+	gpiod_set_value(reset_gpio, 1);
 	mdelay(2);
 	/* falling edge */
-	gpio_set_value(reset_gpio, 0);
+	gpiod_set_value(reset_gpio, 0);
 
 	/* give it some time */
 	mdelay(10);
diff --git a/arch/arm/mach-pxa/reset.h b/arch/arm/mach-pxa/reset.h
index 963dd190bc13..5864f61a0e94 100644
--- a/arch/arm/mach-pxa/reset.h
+++ b/arch/arm/mach-pxa/reset.h
@@ -13,10 +13,9 @@ extern void pxa_register_wdt(unsigned int reset_status);
 
 /**
  * init_gpio_reset() - register GPIO as reset generator
- * @gpio: gpio nr
  * @output: set gpio as output instead of input during normal work
  * @level: output level
  */
-extern int init_gpio_reset(int gpio, int output, int level);
+extern int init_gpio_reset(int output, int level);
 
 #endif /* __ASM_ARCH_RESET_H */
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 965354e64c68..26ec29c9cd1b 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -1024,9 +1024,13 @@ static void spitz_restart(enum reboot_mode mode, const char *cmd)
 	spitz_poweroff();
 }
 
+GPIO_LOOKUP_SINGLE(spitz_reset_gpio_table, NULL, "pxa-gpio",
+		SPITZ_GPIO_ON_RESET, "reset", GPIO_ACTIVE_HIGH);
+
 static void __init spitz_init(void)
 {
-	init_gpio_reset(SPITZ_GPIO_ON_RESET, 1, 0);
+	gpiod_add_lookup_table(&spitz_reset_gpio_table);
+	init_gpio_reset(1, 0);
 	pm_power_off = spitz_poweroff;
 
 	PMCR = 0x00;

-- 
2.42.0


