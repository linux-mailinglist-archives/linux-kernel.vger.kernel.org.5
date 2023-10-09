Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641767BE989
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377927AbjJISej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378066AbjJISeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:34:21 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B569C;
        Mon,  9 Oct 2023 11:34:20 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 65A1684FA3;
        Mon,  9 Oct 2023 20:34:19 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Mon, 09 Oct 2023 20:34:02 +0200
Subject: [PATCH RFT v7 5/6] ARM: pxa: Convert gumstix Bluetooth to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231009-pxa-gpio-v7-5-c8f5f403e856@skole.hr>
References: <20231009-pxa-gpio-v7-0-c8f5f403e856@skole.hr>
In-Reply-To: <20231009-pxa-gpio-v7-0-c8f5f403e856@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2189;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=Dr351d93QVsgkRcO0eJVhSNl8Av1yPt3sqc414h6Tbk=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlJEebBj0U6dcvkKZYfji6sgff0OT7/oLgt/Db9
 seRjnSmcYOJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZSRHmwAKCRCaEZ6wQi2W
 4WoHD/9qzpUYFyCn3NmJahXpNgBW9xEyLZh8Lj8PO6cZO9kCTuIhy6whvaoinFhWz4/EcWxFU+I
 K4MdeBrDyxX5LLyH36oxy+7+KZp8M09WIx1E6dD+NlVoq5Nl8FLzk7RWIcR1mxKBVAQnh5UI6hD
 Ew0faz6Wr5dVPL8XNjZQ87+pSBGQ3oVqNUzIWkBm/bqvW9+picbMfALG5h36Jd+VS1V1S7ZqeCI
 4j9VSvqPbGmrvIdE15h6tUVwIu7gkPXB5zkKVCmIR+JGKTDNl4cY2GM1JyCqE/HFlxBWZBDibsW
 aJOx4e/FFN7qlKtM1XIXPdENc/w75qPo7+0G/aEL2eDgIoFz22olGjSn6qUMT7r4IJwlfyObBFG
 H5yoZQ8CerOku8YXPwM34iX79THcCL1U5h4gEoeVLpzPtAbgHQG0fDyUVpgdPl6TnxetiEhy9oo
 F21S1X+3iZjrXGIhq9VGNh/oV5yMe2c38t+zPBr0iYWV+fEzOfQWVY5AONPVHG8eKDINjWVEQAo
 rt4edis5gUZolYUcO/3WkS89rCTL2Cci7POCmb19UdJLqQokU/mJBPxI1+t4EoDRu3PmJyDBV49
 E3655N4U2IcjrckM2JTY2z8lIfLdZd2QncZOWwsiNUCbfLN905lYKf4kM7dwN6cLV7qVXUmO9LZ
 L5N8bhVA9zj6GbA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gumstix still uses the legacy GPIO interface for resetting the Bluetooth
device.

Convert it to use the GPIO descriptor interface.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/gumstix.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index c9f0f62187bd..0bca6e2c80a9 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -20,8 +20,8 @@
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
-#include <linux/gpio.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 
@@ -129,6 +129,11 @@ static void gumstix_udc_init(void)
 #endif
 
 #ifdef CONFIG_BT
+GPIO_LOOKUP_SINGLE(gumstix_bt_gpio_table, "pxa2xx-uart.1", "pxa-gpio",
+		GPIO_GUMSTIX_BTRESET, "BTRST", GPIO_ACTIVE_LOW);
+
+static struct gpio_desc *bt_reset;
+
 /* Normally, the bootloader would have enabled this 32kHz clock but many
 ** boards still have u-boot 1.1.4 so we check if it has been turned on and
 ** if not, we turn it on with a warning message. */
@@ -153,24 +158,19 @@ static void gumstix_setup_bt_clock(void)
 
 static void __init gumstix_bluetooth_init(void)
 {
-	int err;
+	gpiod_add_lookup_table(&gumstix_bt_gpio_table);
 
 	gumstix_setup_bt_clock();
 
-	err = gpio_request(GPIO_GUMSTIX_BTRESET, "BTRST");
-	if (err) {
+	bt_reset = gpiod_get(&pxa_device_btuart.dev, "BTRST", GPIOD_OUT_HIGH);
+	if (IS_ERR(bt_reset)) {
 		pr_err("gumstix: failed request gpio for bluetooth reset\n");
 		return;
 	}
 
-	err = gpio_direction_output(GPIO_GUMSTIX_BTRESET, 1);
-	if (err) {
-		pr_err("gumstix: can't reset bluetooth\n");
-		return;
-	}
-	gpio_set_value(GPIO_GUMSTIX_BTRESET, 0);
+	gpiod_set_value(bt_reset, 1);
 	udelay(100);
-	gpio_set_value(GPIO_GUMSTIX_BTRESET, 1);
+	gpiod_set_value(bt_reset, 0);
 }
 #else
 static void gumstix_bluetooth_init(void)

-- 
2.42.0


