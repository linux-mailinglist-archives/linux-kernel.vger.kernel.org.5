Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6B7C5541
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346831AbjJKNYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjJKNYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:24:08 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98996A4;
        Wed, 11 Oct 2023 06:24:06 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 2658885146;
        Wed, 11 Oct 2023 15:24:05 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Wed, 11 Oct 2023 15:23:47 +0200
Subject: [PATCH RFT v8 3/6] ARM: pxa: Convert Spitz CF power control to
 GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231011-pxa-gpio-v8-3-eed08a0fcac8@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=QkQSsJ3TQ9II/e/Z5DOmYaA3FrtfclofZ2z7+nUbYbI=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlJqHoTXopvysPGlJcQLoFxSRfmSwVbMUydhtn/
 LcfAUKXhiaJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZSah6AAKCRCaEZ6wQi2W
 4aSQD/9SqnOQKvrhvxn9UtSJ9kIRdMBpf3IHXJGT7ZCC9YIJ3OFZiNdmI9O0mLfZj6ReHi7I1gq
 zpwPuh+YeV50cJrDh+/qAEumNVV3ngsDXPuxwEp5s8r3vYpCwDkzfjzxC/288zpoyaI6CaGnLlV
 bueospfCU36hguvtPCwJFjRQ4Yp3fIEwMvKCAfWA00cZbHCDtc7ovnJhaYc7iKbp1XP+bCh+dJw
 pnl8h+tfT4+a9AdkPaB9iT3W6nZ2OoZxQninyVFln6TW1IKq15wID0iqRxt+7RfD7/UcAgwNUYv
 Wp0O7eMzxrS+2gNUItvoBwFpIemnjBcs5dbUX42+pDLg4sRm/cOlqm1LM9ZgoKOGfby6v5Z7Ng4
 e91+Qz5IwnfOkxlABdiYDgeR9EW5lEAz0cdgUGVEuQmMNTZ68EcDkXHjeHe1auGf0Nm0Sjnqx2Z
 r3t2PTWM3D/AQsqBafoxWXt9RwalXb9sMT/BTfV2OvZmZvoK4sd/T2K/RmqyKrhoROXpKtYVWCg
 2xBVNXGH8vWI80TU/1vDelOiqV4rpl98Cj2XMybGiKD6HcvEuS+PnwuadchgPalWj56pMYJI8qj
 vrTzz5drFeiOoNgF9WVYPRHudrr19lD8/YKAPO1/cZYXqiqNGUjjtpSAUOWThLpp9hSQ6wnVCLZ
 RrXl2+on9ckUqJA==
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

Sharp's Spitz board still uses the legacy GPIO interface for controlling
the power supply to its CF and SD card slots.

Convert it to use the GPIO descriptor interface.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/spitz.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 9efd603c715a..b72c2916426a 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -133,6 +133,10 @@ static unsigned long spitz_pin_config[] __initdata = {
  * Scoop GPIO expander
  ******************************************************************************/
 #if defined(CONFIG_SHARP_SCOOP) || defined(CONFIG_SHARP_SCOOP_MODULE)
+GPIO_LOOKUP_SINGLE(spitz_card_pwr_ctrl_gpio_table, "pxa2xx-mci.0",
+		"sharp-scoop", SPITZ_GPIO_CF_POWER, "cf_power",
+		GPIO_ACTIVE_HIGH);
+
 /* SCOOP Device #1 */
 static struct resource spitz_scoop_1_resources[] = {
 	[0] = {
@@ -190,6 +194,7 @@ struct platform_device spitz_scoop_2_device = {
 static void __init spitz_scoop_init(void)
 {
 	platform_device_register(&spitz_scoop_1_device);
+	gpiod_add_lookup_table(&spitz_card_pwr_ctrl_gpio_table);
 
 	/* Akita doesn't have the second SCOOP chip */
 	if (!machine_is_akita())
@@ -201,9 +206,18 @@ static void __maybe_unused spitz_card_pwr_ctrl(uint8_t enable, uint8_t new_cpr)
 {
 	unsigned short cpr;
 	unsigned long flags;
+	struct gpio_desc *cf_power;
+
+	cf_power = gpiod_get(&pxa_device_mci.dev, "cf_power", GPIOD_ASIS);
+	if (IS_ERR(cf_power)) {
+		dev_err(&pxa_device_mci.dev,
+				"failed to get power control GPIO with %ld\n",
+				PTR_ERR(cf_power));
+		return;
+	}
 
 	if (new_cpr & 0x7) {
-		gpio_set_value(SPITZ_GPIO_CF_POWER, 1);
+		gpiod_direction_output(cf_power, 1);
 		mdelay(5);
 	}
 
@@ -222,8 +236,10 @@ static void __maybe_unused spitz_card_pwr_ctrl(uint8_t enable, uint8_t new_cpr)
 
 	if (!(cpr & 0x7)) {
 		mdelay(1);
-		gpio_set_value(SPITZ_GPIO_CF_POWER, 0);
+		gpiod_direction_output(cf_power, 0);
 	}
+
+	gpiod_put(cf_power);
 }
 
 #else

-- 
2.42.0


