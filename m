Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6107B3340
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjI2NPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjI2NPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:15:14 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB58E7;
        Fri, 29 Sep 2023 06:15:09 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 492B1826A9;
        Fri, 29 Sep 2023 15:15:08 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 29 Sep 2023 15:14:01 +0200
Subject: [PATCH RFC v3 3/6] ARM: pxa: Convert Spitz CF power control to
 GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230929-pxa-gpio-v3-3-af8d5e5d1f34@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2214;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=Rp/bq67hwkJJrBFGSoz+RTRGHfxFwf+Ynos1++JoSzg=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlFs3XkJZo5x8yVshrw8dgNQ73fJfXKc5u2vtEQ
 b9DqcIs3TqJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRbN1wAKCRCaEZ6wQi2W
 4SHMD/9SnS+b2n0HYmaURspdYBfZY0j5eU5q7O8YCa5odWKNnYkAhJnUOU9fEHGepGyxeFJodV9
 6k1wC23nZqV74NSLMaBU2dSfKz7dSMQxeN29EKCulYyvAIeXwiNNBshzbcbonFCXuYDvwrZHnxt
 MIkn/C4uvAow2GPLhFvkJO81vgfJ1iuXKLz7Vr5QisLmyV+Ru3jyal98sttQe2Cadho6ESF+0Ta
 jFnPLa/5iFVUnU28pcPzmwRrOmI4bh8M90YGIpVC2jgCzbJBL5Rh0BtgHv0m3I3pH0xi5p1PqJs
 o3TsIhXrAmeRY1qkEVBJ4JcXq9yFI2nVdZE22bIMXySmvCdK5iVy+wM5Zaf0Qmr9Frb4N0XEt5b
 /w0mOHsvokEnDKYQc6rHvDiCBbrgLnsCpJJWnZurPCuQadwuAEXrWz4iyHekOa7bHYnWH1WXfwy
 Zeb5qmHuoOqYdfS4FpHTwgfh5sdU0GMwx31v6wOJY8SfofwHrGtWd8S2ygAcxtR5l9V02Pc7I39
 Wt9rmhPLKbyqEJ18+MGtyfIvNstZI/Fe2+N/nlBrvT7ljCp5cEYU2kfkCllmdj4BLEWciwN64AM
 jrlxb8ZtJ9KfHOzDeuR4nhdexEfeii1tf1slQ9jiYfXnCmbd0trF1iH/d6AJCy3cifB4j0H/EtE
 iCcsrH6q+rrMUHQ==
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
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/spitz.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 6aa4a3a9f7aa..59a4a439e3d2 100644
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


