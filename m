Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF07BB99C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjJFNpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjJFNpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:45:19 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A24A6;
        Fri,  6 Oct 2023 06:45:16 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 5F65E83F72;
        Fri,  6 Oct 2023 15:45:15 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 06 Oct 2023 15:44:30 +0200
Subject: [PATCH RFT v6 6/6] input: ads7846: Move wait_for_sync() logic to
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231006-pxa-gpio-v6-6-981b4910d599@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4335;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=WwErEB93WBzHtWVtjMPvyswbjztvxyH9/d5QcCsmPgU=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlIA9dQzEhg6l+OrzvF2JShhkoAwCrJEaY0qPfq
 gZNy0RyIi+JAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZSAPXQAKCRCaEZ6wQi2W
 4aVDEACQfgzF2JA5g5+/dfFTyPeP0PogzvS5djifnaCN3JXzeeIoGz1pU4mb/GKYWVi9mMKLTlr
 VPt6O8txKZnXT5QEoEj+U6TWF/LHHxio+PAsAxcbBMSEnS+dRQ61Dl/lbr2+9aAxgoWY7Bld509
 EKvs6Ekyw1paOlFd6m3MyghWmJUfOq7Juy4eGZJZo9vsT4kyJt9fh1uI19Fh8nlI29xzWKNu9Iy
 Sv2iQ9rbSli9QmJ0P59ZXElNrYXFbug4xAcR0AVKYGS2ChY1RTB2eVHE8vHjEaRos5Qzh6i3QQN
 +xpPKrpZgyDeIxr53qcb3NEweUl14AYck44Zcy6XfW3Kc71VGw5Y/RMvfziRHApAwuwPXVxtKul
 LZY1KOwZQjcNGx3Y9TIk+qRUQP7XvKonUnIALLmTvCas7Ra7vQt64Y1pBQxVzcxNy7sIoLFI8Op
 CltdNofYhKksbhGIOd/Fgu/NlfnIxVk0A4OY1lhCxDXGXDtiroHylTSZmi2uK+g/l3SDhxInrqB
 ky6o/tVci3yGmuEEd7EnwgAdanlUCxy4S2fOm+QLhWKSvGcsLrxb5A119ZL5BpzzPtAhRz5ARDk
 CTxQIrdQr2UseEUle2BO9EodzcpMHUooUV6tFeH0LyHjjTRXZIAbM1puEtO13WR5G8ohuudp8Xc
 oPO56adG7O8KNvQ==
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

If this code is left in the board file, the sync GPIO would have to be
separated into another lookup table during conversion to the GPIO
descriptor API (which is also done in this patch).

The only user of this code (Sharp Spitz) is also converted in this
patch.

Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/spitz.c           | 12 ++----------
 drivers/input/touchscreen/ads7846.c | 22 +++++++++++++++-------
 include/linux/spi/ads7846.h         |  1 -
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 554a4b9782c5..1df72d4d6a35 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -522,22 +522,12 @@ static inline void spitz_leds_init(void) {}
  * SSP Devices
  ******************************************************************************/
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static void spitz_ads7846_wait_for_hsync(void)
-{
-	while (gpio_get_value(SPITZ_GPIO_HSYNC))
-		cpu_relax();
-
-	while (!gpio_get_value(SPITZ_GPIO_HSYNC))
-		cpu_relax();
-}
-
 static struct ads7846_platform_data spitz_ads7846_info = {
 	.model			= 7846,
 	.vref_delay_usecs	= 100,
 	.x_plate_ohms		= 419,
 	.y_plate_ohms		= 486,
 	.pressure_max		= 1024,
-	.wait_for_sync		= spitz_ads7846_wait_for_hsync,
 };
 
 static struct gpiod_lookup_table spitz_ads7846_gpio_table = {
@@ -545,6 +535,8 @@ static struct gpiod_lookup_table spitz_ads7846_gpio_table = {
 	.table = {
 		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_TP_INT,
 			    "pendown", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_HSYNC,
+			    "sync", GPIO_ACTIVE_LOW),
 		{ }
 	},
 };
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index faea40dd66d0..139b0f3735d0 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -138,8 +138,7 @@ struct ads7846 {
 	void			*filter_data;
 	int			(*get_pendown_state)(void);
 	struct gpio_desc	*gpio_pendown;
-
-	void			(*wait_for_sync)(void);
+	struct gpio_desc	*sync;
 };
 
 enum ads7846_filter {
@@ -636,9 +635,15 @@ static const struct attribute_group ads784x_attr_group = {
 };
 
 /*--------------------------------------------------------------------------*/
-
-static void null_wait_for_sync(void)
+static void ads7846_wait_for_sync_gpio(struct ads7846 *ts)
 {
+	if (!ts->sync)
+		return;
+	while (!gpiod_get_value(ts->sync))
+		cpu_relax();
+
+	while (gpiod_get_value(ts->sync))
+		cpu_relax();
 }
 
 static int ads7846_debounce_filter(void *ads, int data_idx, int *val)
@@ -803,7 +808,7 @@ static void ads7846_read_state(struct ads7846 *ts)
 	packet->last_cmd_idx = 0;
 
 	while (true) {
-		ts->wait_for_sync();
+		ads7846_wait_for_sync_gpio(ts);
 
 		m = &ts->msg[msg_idx];
 		error = spi_sync(ts->spi, m);
@@ -1261,8 +1266,6 @@ static int ads7846_probe(struct spi_device *spi)
 		ts->penirq_recheck_delay_usecs =
 				pdata->penirq_recheck_delay_usecs;
 
-	ts->wait_for_sync = pdata->wait_for_sync ? : null_wait_for_sync;
-
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
 	snprintf(ts->name, sizeof(ts->name), "ADS%d Touchscreen", ts->model);
 
@@ -1361,6 +1364,11 @@ static int ads7846_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
+	ts->sync = devm_gpiod_get_optional(dev, "sync", GPIOD_IN);
+	if (IS_ERR(ts->sync))
+		return dev_err_probe(dev, PTR_ERR(ts->sync),
+				"Failed to get sync GPIO");
+
 	err = input_register_device(input_dev);
 	if (err)
 		return err;
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index a04c1c34c344..fa7c4f119023 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -38,7 +38,6 @@ struct ads7846_platform_data {
 	int	gpio_pendown_debounce;	/* platform specific debounce time for
 					 * the gpio_pendown */
 	int	(*get_pendown_state)(void);
-	void	(*wait_for_sync)(void);
 	bool	wakeup;
 	unsigned long irq_flags;
 };

-- 
2.42.0


