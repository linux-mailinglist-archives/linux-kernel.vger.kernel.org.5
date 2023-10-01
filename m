Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1997B47D7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 16:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbjJAONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjJAONG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:13:06 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44AFAB;
        Sun,  1 Oct 2023 07:13:03 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 5D829820F6;
        Sun,  1 Oct 2023 16:13:02 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Sun, 01 Oct 2023 16:12:53 +0200
Subject: [PATCH RFC v4 2/6] ARM: pxa: Convert Spitz LEDs to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231001-pxa-gpio-v4-2-0f3b975e6ed5@skole.hr>
References: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr>
In-Reply-To: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=Kq4sitRUky6xb8wL9sBaMZGXvKR+7tYT75wjzOs1EKA=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlGX5oiTaZUpJDP7w5L7beBppkIPioNnA8+i8f/
 4vGwGpa92SJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRl+aAAKCRCaEZ6wQi2W
 4a3ID/9kD0IUxsNMJ0Kgzqs2+ecS+vsRfinQKLHtN09655zhXWVN9oGjz+yP46mVg5jX91D+uKN
 QkkD/scdTUAaVgsCKI01u6iKCfaZnzSUSJXcNkk0pSwwfwrtRP0LQxtdhJIoRDrXHL9Gn1NY3Dj
 Li2/9Hzonh+jdTrjFmoX/UmUIiEegu5ll7jDF60T1CwnQ8bDZn4Ulh1MptAymAhrbFD2wV0qsiu
 kcFP0SsgmqqxJ4Lde6pK32w5mjMgpgiLz/ayGUl0RBhhz3W1Pfeqif0tyLJsP0LTJMPKsEpPMUr
 L9lTRfHlL1t9krEVMB9YG9XWO3ZK+qAaVxMzFcdUqjgr0ihj5Nm10bg5vua/M+Ipvwf3x2t14qG
 rUOdQmp3Yc2TwCS2cTmrxsSY/EmScxUNKdlv62VSyids0AeWnYNyyXtuLX70TA1sRf7olJy8ZQz
 9PG6hTSvqi4dnHIRnFhrUnGP1xcRuzzVvZ2xyWqskxy8Gpp5RXDOgULDTwZw69GOt3zXmiVqWQB
 qXC4h1XjT7fRatDR3J6UGAe4O1N4YD+usOx6TdFroler7JY0Lkp7RzzoyPttwmHc/Me+oVqKVHy
 KW1Azyyv0tUWmKkqxAwEN8O+HF4FCJQKj4JS5EXwwbAIygnsBJEY4KfrUK13FcEyciYOsskWcPU
 F+X4YO720TTYgDg==
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
index 535e2b2e997b..b6a4085e9fb0 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -452,16 +452,25 @@ static inline void spitz_keys_init(void) {}
  * LEDs
  ******************************************************************************/
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+static struct gpiod_lookup_table spitz_led_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("pxa-gpio", SPITZ_GPIO_LED_ORANGE, NULL, 0,
+				GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("pxa-gpio", SPITZ_GPIO_LED_GREEN, NULL, 1,
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
 
@@ -480,7 +489,12 @@ static struct platform_device spitz_led_device = {
 
 static void __init spitz_leds_init(void)
 {
+	gpiod_add_lookup_table(&spitz_led_gpio_table);
 	platform_device_register(&spitz_led_device);
+	spitz_gpio_leds[0].gpiod = gpiod_get_index(&spitz_led_device.dev,
+			NULL, 0, GPIOD_ASIS);
+	spitz_gpio_leds[1].gpiod = gpiod_get_index(&spitz_led_device.dev,
+			NULL, 1, GPIOD_ASIS);
 }
 #else
 static inline void spitz_leds_init(void) {}

-- 
2.42.0


