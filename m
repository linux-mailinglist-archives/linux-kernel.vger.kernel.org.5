Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CCE7BB981
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjJFNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjJFNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:45:14 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D5E95;
        Fri,  6 Oct 2023 06:45:13 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id B304383F67;
        Fri,  6 Oct 2023 15:45:11 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 06 Oct 2023 15:44:26 +0200
Subject: [PATCH RFT v6 2/6] ARM: pxa: Convert Spitz LEDs to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231006-pxa-gpio-v6-2-981b4910d599@skole.hr>
References: <20231006-pxa-gpio-v6-0-981b4910d599@skole.hr>
In-Reply-To: <20231006-pxa-gpio-v6-0-981b4910d599@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=c8SAwr7yUIDYfzBg54shArsrK1UPy+9oOW4+fo5KjpU=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlIA9dUqdcLA8NnEHUdf4WtT55qUDp3bAYkuWDY
 OJlpoomz8+JAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZSAPXQAKCRCaEZ6wQi2W
 4fuyD/91ZkszojargU21+2IAfmhklB/mbaaCM63yK7Bd6T4E0vyzsDQOj3618sH7IKQI5lcNOP5
 lVBS0BnGpVqawos5mG27ZzdBRWmalDs7HGlCnE0unzjuRiTzXJmHrUsgn0JnXqIbX8BJw4vsAJu
 yi7A5WXOabjeOmU9SxkQ5LJY4c9nwdae2X7CJ6UKK1rfx6DKYSct2Cj+rUxAM8c21Vsu9xUUg+h
 8jInzpAy0N9qTbviAJ01dQHF/U0qHsjrNHyJDK9XNslY4o5DiNXq4ZpClvf7yBqddHjarYzH3vN
 cROX55E2Qhi//b1TzPI1rmLCxMdxiem4cIE78m/vMbc2mv2wmABEZqoIYxyTTocEKG+e4MquKuk
 kTb2rhhh5rVkTAjozzsVib/46/Iw0Vll+D0Zs/ebl1q4p3+ZV7X8+adGJIOJMQMFmRPVWyiqsqs
 N9X0IW9mCLyUUnbxWBj2hjIO7Gc4MG8BEGqMz0/C03wLciP49ICXexkEYy9+LWUdOBU9ebhhRB0
 KZlbk1dQ7r13nzSCyThkJ203sLewu+ajIn/q4p7sBmipBLyyNSnqvnt4rf9x3+DEbenjigWYUIZ
 qp9lYwna9PzrfRIEHdRivj8CfQF3iUgE+EA1HI/Qec6J5/JoZmCS9atkoNNkIuRp+jpDlXb3YkW
 ypPAJO70pXTd77A==
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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/spitz.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 535e2b2e997b..1fb4102ea39e 100644
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
 
@@ -480,7 +489,14 @@ static struct platform_device spitz_led_device = {
 
 static void __init spitz_leds_init(void)
 {
+	struct gpio_descs *leds;
+
+	gpiod_add_lookup_table(&spitz_led_gpio_table);
 	platform_device_register(&spitz_led_device);
+	leds = gpiod_get_array_optional(&spitz_led_device.dev,
+			NULL, GPIOD_ASIS);
+	spitz_gpio_leds[0].gpiod = leds->desc[0];
+	spitz_gpio_leds[1].gpiod = leds->desc[1];
 }
 #else
 static inline void spitz_leds_init(void) {}

-- 
2.42.0


