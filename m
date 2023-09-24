Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A987ACADF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjIXRLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjIXRLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:11:39 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D267C6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 10:11:33 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 314D38207C;
        Sun, 24 Sep 2023 19:11:32 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Sun, 24 Sep 2023 18:42:58 +0200
Subject: [PATCH RFC 5/6] ARM: pxa: Convert Spitz hsync to GPIO descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230924-pxa-gpio-v1-5-2805b87d8894@skole.hr>
References: <20230924-pxa-gpio-v1-0-2805b87d8894@skole.hr>
In-Reply-To: <20230924-pxa-gpio-v1-0-2805b87d8894@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=5895JvGZEWJwM5WNxnvl7MrpXNHBGrr2xGh6alIOeRs=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlEG28CnZS8E5xwAgzJ6CVN1PApJKF1p75dl+ro
 yYoGLjMX3SJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRBtvAAKCRCaEZ6wQi2W
 4YQfD/9LYjsoRnldDP9MME1UjvcTXrPKebJ1AlZZnkgjiTUqxRtFVja207shgBymZoSNfnYFQXK
 sts9x+WgMnlEaHH5XL6nRVrsBZ+v/TahgGgaEXvoq5MvERbUo9ndtbNsSZmTFAppefrqk6UK3eY
 tTnpgwRWJrhyybcGSqKy2RlbvnCxlBJtaKNmjbwY5OfXfgu0yu/Nzbf99f2+B9Sjfzhs7GhKINK
 tqhH3qpCvqMbEASiph4uIj5NoZeK3BpdSycgBAy0S5C7nP1LxhRzB57gLSBGPAu0zjKfq3cWIqY
 v4BXqg/OwTG/Q1IL8MxuROJoLhV+ehUFN/s6qb8crXQkTmcxWfikfIWCM7i/B/4SsFhW3G/doPY
 sPg7vCpWiX+ScuB7opkcFPlszjXy7Z+EkwTc0Nzq2N6saG4cbUI0OoV5rk91o0/pHZ1haAQ6FJG
 BMwJLJXjlIyPFAyEe/cq6oNb3AM0Z8sX74+uO3cWijv3Lt2qmzFybQrF1w3zAypi7g8mNJ9DZ+O
 0MipG2lbd/oIHZ8dyfljXYMTKrWieYgZAh4FKFajPGAVwgp8rwsE63vB+EMg6119jorXG/Xp86b
 jBm20jjKfDGUnMG9lUoctJfg/2keNdlpp3sULGvQi0FeNWLjSQnOFKd+Kpydu/Y3nhaIsDVXF7G
 iRxo4ltWhHjGHUA==
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

Sharp's Spitz still uses the legacy GPIO interface in its wait_for_hsync
function.

Convert it to use the GPIO descriptor interface.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/spitz.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 94bcb187713b..1e38069e75f7 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -520,12 +520,14 @@ static inline void spitz_leds_init(void) {}
  * SSP Devices
  ******************************************************************************/
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
+static struct gpio_desc *hsync = NULL;
+
 static void spitz_ads7846_wait_for_hsync(void)
 {
-	while (gpio_get_value(SPITZ_GPIO_HSYNC))
+	while (gpiod_get_value(hsync))
 		cpu_relax();
 
-	while (!gpio_get_value(SPITZ_GPIO_HSYNC))
+	while (!gpiod_get_value(hsync))
 		cpu_relax();
 }
 
@@ -543,6 +545,8 @@ static struct gpiod_lookup_table spitz_ads7846_gpio_table = {
 	.table = {
 		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_TP_INT,
 			    "pendown", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_HSYNC,
+			    "hsync", GPIO_ACTIVE_LOW),
 		{ }
 	},
 };
@@ -622,6 +626,9 @@ static void __init spitz_spi_init(void)
 
 	gpiod_add_lookup_table(&spitz_ads7846_gpio_table);
 	gpiod_add_lookup_table(&spitz_spi_gpio_table);
+	hsync = gpiod_get(NULL, "hsync", GPIOD_IN);
+	if (IS_ERR(hsync))
+		pr_err("Failed to get hsync GPIO: %ld\n", PTR_ERR(hsync));
 	pxa2xx_set_spi_info(2, &spitz_spi_info);
 	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
 }

-- 
2.42.0


