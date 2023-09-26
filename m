Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A678E7AEFEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjIZPq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjIZPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:46:54 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A9110A;
        Tue, 26 Sep 2023 08:46:46 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 2DF96836CB;
        Tue, 26 Sep 2023 17:46:34 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Tue, 26 Sep 2023 17:46:23 +0200
Subject: [PATCH RFC v2 2/6] ARM: pxa: Convert Spitz LEDs to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230926-pxa-gpio-v2-2-984464d165dd@skole.hr>
References: <20230926-pxa-gpio-v2-0-984464d165dd@skole.hr>
In-Reply-To: <20230926-pxa-gpio-v2-0-984464d165dd@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=02fLXHNo6SZtYq4sldyjzMDb6JVfWPhjgCG5UTkdTdY=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlEvzW18VE2EpVyIF0E+Le+lT4YztgGaTeIG9e5
 XYpdqeQTKKJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRL81gAKCRCaEZ6wQi2W
 4eyzD/4xj3nCTSW4fc2jM0QoHwNCTTdpBf+wYw23yFkTfriAQuKwDb+yf+S/7VnH9+nPUllfkE2
 aR3bYa66FDYKIjn96yijEv76WCzw7WnOPanQmSeM/9zWQqVroR+S0+jFXVfygRmTeW9bxusuy/v
 3AWGOz8EWBP8etp2pcvDUHTseRNZNiD2lsKEcWPyRVfs8xn+UtgejBQUVNHIVdhO5do4rA+KK9b
 uZUg+SfbcvrEHqLgAUY+Jfp35wNCIP8qQIhsqVAqMpQYZt32sRvfL7uY+bf1qO7vrqFQKrp++4A
 M508QZlkki3Wp2t69uKNiXKMxdNWSt220cHv/pLKOqGbg+bcL4Hg6Ry+EODxN0Wxz6qnTxgd+jg
 QTPcymSR5N2xjJCDLLsEq9J/asHAZ0C0YQDascD+Z4Ze8qqZbG317GzNvKOhIcCL2FEm1KMpEFP
 l4NZV/skn71OwWOc7Fs9iYCwXjCS0CFl232XWzYCmQOfSRQk6npNPFaRboP0k9BF6NpLKDwBBc0
 rRemoKn9Ld/zFuR5hA/C24fYmXAjik4/nDQCXOJvFA49vza08zZs+BWr8ss3E1E5plOv5y/ZYp1
 2+hblsfHVEeLXdnopzs1F3PPhGjkgw4vFH/TXeIRpLZkkkGO4UiY3JIam0SH4rkZKHMuGyuafhH
 /WVNz3KWoyMz54w==
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

Sharp's Spitz board still uses the legacy GPIO interface for configuring
its two onboard LEDs.

Convert them to use the GPIO descriptor interface.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/spitz.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 535e2b2e997b..91c4b208973c 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -452,16 +452,25 @@ static inline void spitz_keys_init(void) {}
  * LEDs
  ******************************************************************************/
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+static struct gpiod_lookup_table spitz_led_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP("pxa-gpio", SPITZ_GPIO_LED_ORANGE, "led_orange",
+				GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("pxa-gpio", SPITZ_GPIO_LED_GREEN, "led_green",
+				GPIO_ACTIVE_HIGH),
+		{ }
+	}
+};
+
 static struct gpio_led spitz_gpio_leds[] = {
 	{
 		.name			= "spitz:amber:charge",
 		.default_trigger	= "sharpsl-charge",
-		.gpio			= SPITZ_GPIO_LED_ORANGE,
 	},
 	{
 		.name			= "spitz:green:hddactivity",
 		.default_trigger	= "disk-activity",
-		.gpio			= SPITZ_GPIO_LED_GREEN,
 	},
 };
 
@@ -480,6 +489,11 @@ static struct platform_device spitz_led_device = {
 
 static void __init spitz_leds_init(void)
 {
+	gpiod_add_lookup_table(&spitz_led_gpio_table);
+	spitz_gpio_leds[0].gpiod = gpiod_get(&spitz_led_device.dev,
+			"led_orange", GPIOD_ASIS);
+	spitz_gpio_leds[1].gpiod = gpiod_get(&spitz_led_device.dev,
+			"led_green", GPIOD_ASIS);
 	platform_device_register(&spitz_led_device);
 }
 #else

-- 
2.42.0


