Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3B07AEFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjIZPqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjIZPqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:46:44 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB5C11F;
        Tue, 26 Sep 2023 08:46:37 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id E0EC982367;
        Tue, 26 Sep 2023 17:46:35 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Tue, 26 Sep 2023 17:46:26 +0200
Subject: [PATCH RFC v2 5/6] ARM: pxa: Convert Spitz hsync to GPIO
 descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230926-pxa-gpio-v2-5-984464d165dd@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=iDSRsRvbtFOxQFJcaMgRFqBD4OPrnaTiwiEd2g9ViUU=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlEvzWvKOK8Jgrv8cV8mXpPyIo+QydjhrRFeCDN
 +7WkkTkiXqJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRL81gAKCRCaEZ6wQi2W
 4dpyEAChUkA0UQoq4DsrWVZ3WmVhlrOJNsEfCtKC4QnJLAgF/mpUu2DRVgIUDwTq89eEU2+m1/l
 VTF7nmWilyWNZeqaeGMRvQ9XGkoG9Iah2fCtL2JWAZbY29qdilEli4/YFWpiQOl5TN/ePfsG5dl
 WugaqopM4eIQtgaG17n9x0VC9M/M4AxD9jaMIsAbzanPKnY8RMIn9956lBz92kK13KVgdFuTX5J
 uZUbTQbgpUeP4DKJIkQ61DJkwcgN0l4RO3e/SYdzS5/dk0lZN7IYgLCCwHLo/mepyYDOKmBzUOi
 j/FtoDl0A/bephgd6M6hjovOLLuSyHZVqnuPeYz+Z61vHJ+UB3Lk5OKl5U/PTSR9ueCXwgn0TTx
 HDTp9qwvO7ivldg/O4zNqYRvBks8DB+Jr7fbVoDuIVJ2qtqlFrCN82bNeMGcfNphPkQXg/9Pe73
 /HrRyqe0+Q5/C1xK8/eSSuoZXYF13r/LkbVL1Yle33DX4C/3VtIjoEpxCZG5f89q28WXDpHHze4
 suYScWGXap094Jf0ekO8XPUUHAF1fhcYue840XzrC0hJGiSGz3n7fdWz15F+jd4cTbp9maM0EOx
 PmRpAM8+Pj/d8Pv2r6meeoA6i6LihaiAqFPPncuOAwJRnZseMNvRLKUCGM2foux/FmXeU/eVMhy
 psZq92FP0XzOeCQ==
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

Sharp's Spitz still uses the legacy GPIO interface in its
wait_for_hsync() function.

Convert it to use the GPIO descriptor interface.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/spitz.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 94bcb187713b..5c8f497b71ec 100644
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
@@ -622,6 +626,11 @@ static void __init spitz_spi_init(void)
 
 	gpiod_add_lookup_table(&spitz_ads7846_gpio_table);
 	gpiod_add_lookup_table(&spitz_spi_gpio_table);
+	hsync = gpiod_get(NULL, "hsync", GPIOD_IN);
+	if (IS_ERR(hsync)) {
+		pr_err("Failed to get hsync GPIO: %ld\n", PTR_ERR(hsync));
+		return;
+	}
 	pxa2xx_set_spi_info(2, &spitz_spi_info);
 	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
 }

-- 
2.42.0


