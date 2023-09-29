Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F85A7B3345
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjI2NPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjI2NPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:15:14 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4931F1B4;
        Fri, 29 Sep 2023 06:15:10 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id D4E488475E;
        Fri, 29 Sep 2023 15:15:08 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 29 Sep 2023 15:14:02 +0200
Subject: [PATCH RFC v3 4/6] ARM: pxa: Convert reset driver to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230929-pxa-gpio-v3-4-af8d5e5d1f34@skole.hr>
References: <20230929-pxa-gpio-v3-0-af8d5e5d1f34@skole.hr>
In-Reply-To: <20230929-pxa-gpio-v3-0-af8d5e5d1f34@skole.hr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3654;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=P+Mn+7rnZeSrsHrXwwh73RzIYGjBVvhAgESHp6DzA+A=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlFs3XoAQyb355PIO8PgTe7++rLbalmrVzqHDm8
 mkrj5qE87mJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRbN1wAKCRCaEZ6wQi2W
 4aqND/9rFsjp6O60B7TMyvYW6Tf2lAPf1RU4Ns043Xeko6Ire3TxG6VnLRVZ4M+TIDLJkvZmvk/
 926OKxCZ3BLSmgvIb5tgXY8eNv8KEARMBPUW1+688Mpg6ffqBqa+P9NFcu66P2jiaaPno6hAdrp
 3SqxsXMp9WIL50+5eNx00ZglLGkPcX8sedQEV+YzInL7+SyQGTL1DfArAy1dZBfD0At9r9XBn/Q
 VJw/EKPPCYaulj49PCHy+h6uz8qBjbb2uTX8u8oioFoFGezNBsc4XiQWzI90EO7Bmnq2phjfvS0
 MpwcXb40eS6VqudVDrYWAF7DMuvQdCe5QowJDBnoi/1r4dohgCSyfgv2EjQK8YiI/WP4io4d/s7
 NfsY2Cc5E17y0G5e+57ssJjUOUbF3qtyOHNkTGV+2P/jalpxgC0kLhMBM5zYoNXcx3wg4UAkQRV
 aSrZWMj5lq5RCDrt5rJhjN5J1v+PAke1M4V7J24u5AvEZlVB00Zlh4fNnRu8jADD+9qOk/fSBmo
 Exw41SSrTaEY2ZXu6Wl6QQqM8fxKipD+rY08k8Q3rr1pNoNR++7WjzGJcXBpZo6mqQlj1rt6njn
 BmNDzJ2SJz+HZIHuRDQPYKqFPJrQlJXKE4IXoTn1t+YmbmLFoph3MCI34nOwJ473qXYAWvWdvgf
 DwIMd8Zp/VxVRNg==
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
index 27293549f8ad..2bfa66f99555 100644
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
+	reset_gpio = gpiod_get(NULL, "reset generator", GPIOD_ASIS);
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
index 59a4a439e3d2..c789eeaf3c2c 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -1024,9 +1024,13 @@ static void spitz_restart(enum reboot_mode mode, const char *cmd)
 	spitz_poweroff();
 }
 
+GPIO_LOOKUP_SINGLE(spitz_reset_gpio_table, NULL, "pxa-gpio",
+		SPITZ_GPIO_ON_RESET, "reset generator", GPIO_ACTIVE_HIGH);
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


