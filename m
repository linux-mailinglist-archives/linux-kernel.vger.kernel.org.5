Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9536E7C5552
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346790AbjJKNYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjJKNYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:24:09 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2263490;
        Wed, 11 Oct 2023 06:24:08 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id BB0B683D95;
        Wed, 11 Oct 2023 15:24:06 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Wed, 11 Oct 2023 15:23:48 +0200
Subject: [PATCH RFT v8 4/6] ARM: pxa: Convert reset driver to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231011-pxa-gpio-v8-4-eed08a0fcac8@skole.hr>
References: <20231011-pxa-gpio-v8-0-eed08a0fcac8@skole.hr>
In-Reply-To: <20231011-pxa-gpio-v8-0-eed08a0fcac8@skole.hr>
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
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3701;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=fiTAkhx/392g7RKt0TzxS8LYK9aSUcvD4v5HvOhokVU=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlJqHo5nattoNOlB3XygeTijL6yvVuXLvMIDa/N
 d0laJ14PBmJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZSah6AAKCRCaEZ6wQi2W
 4RAVD/9/YTdtpNkyV48JiHRA1s3T8GEl85ehHNU+1KfUTmt0+fP38r/WTocoVPjJWIQ7cjyz9c5
 WRagQSF/zGyTL8NfDUdiLAltJCFjYSlqb/yWCw6z/dICXYWS/8DxBs6MnOyzSEvFP+1BTClEXq2
 5SfVGEdiJO+SIhG2eQfQF6NCmWQ3Y38KE6WxnwEqHrP8R+mBiSz/T8H9fy6e11wR1UgzVLXXSFe
 ELv9hgwo29yzgeNYSyfX32KaytGdmrCr2y99/3a0xS4dVSIVtePcCV64EKKQsz8RH+J6d8u+lxy
 QZC1iyU6jgH8h9gg2HqGr5h7olOGLC61VSAnzXSXTEIQdDvmFLwbMsFhlbbYCDe0CjVtx6Y23KQ
 edFl/syYKw7Fn68xPuKfZQxv3oH3WKcNRqKcKvskB2S7/U6LP3w4iFlQ+gOa1ouUnOWrjcOpNp8
 rGLmgvgVMuerqfU98cB+QjP5/QCct8zeis6MhbMx/QimYx3yO8Alvf96R+C+V/BSM5aKkXTf/S9
 ZIvcJiQ8SAu27lY3AqGy6hF6se5gIJyzE+ohAYwlYI/4sdjbKsNegTbQfnWvroS7ek59K+SLA/C
 5zhVt358n4UAj5ON6OOFdOAKAu8OMO33MFQgvgGKJxMKNf6CglbjArkekZoo6Cov/XoFVpjz8RO
 yK6/mNCHyafi+Rw==
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
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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
index b72c2916426a..acb2b5495dbe 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -1020,9 +1020,13 @@ static void spitz_restart(enum reboot_mode mode, const char *cmd)
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


