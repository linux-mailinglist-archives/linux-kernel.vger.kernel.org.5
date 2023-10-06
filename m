Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511477BB997
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjJFNpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjJFNpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:45:15 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3697E9F;
        Fri,  6 Oct 2023 06:45:14 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 87E4082B9E;
        Fri,  6 Oct 2023 15:45:12 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 06 Oct 2023 15:44:27 +0200
Subject: [PATCH RFT v6 3/6] ARM: pxa: Convert Spitz CF power control to
 GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231006-pxa-gpio-v6-3-981b4910d599@skole.hr>
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
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=KJXbAXyTG/sVSbaLBYtwlL2iztxHfXukxnTO76EQ1Do=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlIA9dXq3IsbXcPqKQsM0k9xjtruTjk9o2uhodv
 xMeFc5SBaWJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZSAPXQAKCRCaEZ6wQi2W
 4e/aEACij3SU0X3Wg1OLQ5q3Se8lr+wN8FHuvWQrAxDoT8cxGOabqsLggZL+Dt6io84mDzME1Z/
 tjLBhJwv9L3h1Cvm6osLFEjbdLrbyRN3IzjABPnnTpcJf6oi8oREpiV7DVIdfVdlcfnr33D7eGZ
 pImzsyGszNGncC9aEHmM74+wFC6XrybGocqD7XqMlGtIOKz/FMu5wsMgk62ulQ9AUoRvj/LpdQe
 uhMQWqUVmCyo5BW1qjTlvUezX00zykRUhLFvYaamgiuiFhR2uyZauJoWnaoo0X5UhHl1z3dYPYO
 SsmHZk2xE1D+g+2zQu5yiX/sFY7avbJYHkyAnZZpkdw4TTUFYovtgh3Oomzo54KmRmuMt0Mbugi
 6A9AAkpqcuSAQ2Zw8QKQdfk1VUTikmGobUj/JVclRK1smimPpMTlS3DMFOwKl4wLEuc/ez+fSPO
 81VIVGLgQS9gDL6pJlcTX93gyY1xR3NYVN17HqA1hG4CXEX0YVKne3OWGDqKpwwfta5uJU6jvvL
 dN82vRBcdAAq2qzwCH3aVqOmQAS67cjTsF0hjQdOetNNz4mVdnUV1mNUQUjhdWkYaEs3gqwolAx
 kjrg1XFcnPdH64ixPfGkxJfB7svQ1z4vCY3jWzHQhnQfsZ2QrxldCcDDBlu1ZU5E2PLY2giGjSh
 koFNtWG4UIkqQEw==
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
index 1fb4102ea39e..8e9301cd0c93 100644
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


