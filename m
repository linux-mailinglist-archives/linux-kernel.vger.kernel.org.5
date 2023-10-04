Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C180D7B82FF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbjJDO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243118AbjJDO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:56:51 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFB3112;
        Wed,  4 Oct 2023 07:56:46 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 8504C84CA0;
        Wed,  4 Oct 2023 16:56:44 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Wed, 04 Oct 2023 16:56:26 +0200
Subject: [PATCH RFC v5 2/6] ARM: pxa: Convert Spitz LEDs to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231004-pxa-gpio-v5-2-d99ae6fceea8@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=DE2PEskLXScJBG6OV6aN0l1pySPm6nNQ06il8QEoR7s=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlHX0kALPHlN4oJn6kZo3KSvCEzLz38DVYdz/Ba
 cdGlUtMoGCJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZR19JAAKCRCaEZ6wQi2W
 4WtUEACCiGTLN1AbQqVrfDK7Y56hTkXDQVt4zLo7s/AxU5qOIFFW9Rk9uL1rx6av9foW4enZRUC
 /AN2ZqEM2pS9l3ZIHH2CmIJD7i68hB1oW/W2C++qIoTQfreneKfudMBMH4Km9wYhTZDjIPbJ9I6
 pe/osql79J6vMKdOcReaQ3ZxMOUxtyTYNZMdRuwSmk7ZeNiJP1VssDlANf2N1LYg+caJ3NwB+cp
 NVsFa5ma1n/Z3jaFyBSxcAFXmdc0zn/QjRUxpCyYToikVRPax3QXd1aMdlJEKFtGeg82P/EqmU6
 WO+tKEqsdlLc+QsEyr1/qhkGWKmIHh63sNuSeke62Huofiier20EVS8GWa68VvqW79zJ9+xlLrn
 OAN37lpWzMIGw6C1z75RJUM82VXYe6ab/wP4i88mtebKkdlJIKungAtsUIAzXXtpU15Jd5y2VLB
 0tAt0aUgFfXEVO8a/W0XTcerFNpR32EQCFz32uT6k6gUkrYSm5FM5Dbpg2NqzOzBcKO7bUnzYA5
 og84IkURN4x910DHcL8P2gdaCYf4XEVyjYO8dVHkLCGp4elHUlMUlzB+tNUHTZZs9lGNmVGAdFz
 IamCDlLQBCwmjSizLCo77nnqiipo+DSAzwSs/TqLfhd032qT6lzX7uPandRdFfz/nGHmVmB2dqV
 O74X1KQos5QWDzw==
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


