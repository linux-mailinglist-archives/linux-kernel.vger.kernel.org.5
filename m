Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7648A7B82FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbjJDO5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbjJDO4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:56:54 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B97C1;
        Wed,  4 Oct 2023 07:56:49 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 84E2384CBD;
        Wed,  4 Oct 2023 16:56:48 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Wed, 04 Oct 2023 16:56:30 +0200
Subject: [PATCH RFC v5 6/6] input: ads7846: Move wait_for_sync() logic to
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231004-pxa-gpio-v5-6-d99ae6fceea8@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4268;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=mfGlDLCki8NV8tuIB3jWgW4BpAW+ImMtQkJ8rvZ0eFs=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlHX0ko6QF0tV1IpOHpld/KlsqWZMXejAlxwX4p
 RioSchfOkqJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZR19JAAKCRCaEZ6wQi2W
 4UDJEACL1rzW0OK+OZlq0VZP+NcIBMKUVlmXswhE+c4fqQzKRHdfqVHJ+HNX/f5un7+vbog19mN
 ghkrHhQ3na+v7tbB2lKBHQfIkfqt8Lpzo4yxZoj/xheHAaTNmC95iIzDcDejfXhn1RFqiCyg8f2
 b1/VcmMwKpw881LCL3rBkpws3D6d7E9E8p1Iv62fMYRXgHsm9SJdGxCLx649Z1XT+cw63ERxQAc
 9CO8OfRrwX0q2ip4aToA8AjddXA3MPIIfOn61sJh+k6xC/18IuQ5CMeF+R1pmMI4BBELNM0HWPt
 4C9GwnRQFfLR2q1IgIuSYYOwKP6xizY6fYWOGeI+oXLqEjpe9yAz+xo+AV3k8SHdrTJfA5wO+Fm
 2qZ50mDe3kerUqoOWAsSBf3aejym2q3i84DPemXqPkfk1Gog8R/0LyJtNh/SbP6F3zsmo58N4oo
 xdxemvjNCm64z0s5l+RJYxZTPB006qGhmS6UReKLHSR7GeV7mm78+y88WQ49BadsUCNol5i5nEH
 hEJdwUnulJII8uLcsjyGEMJMSK4j+szRDYFuxVo2eaT+cVTDsja40QF3WUhK8qBiCfQHAYeaSZl
 jqXP36EKy0W8BZkP9wqRrtlYzTa74nY/n4Xw2C4T6g6zXwQzfXyg5HxYpH0xmh2Cbr733QVkoKv
 JVBGQIlAgoCRiaw==
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
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/mach-pxa/spitz.c           | 12 ++----------
 drivers/input/touchscreen/ads7846.c | 22 +++++++++++++++-------
 include/linux/spi/ads7846.h         |  1 -
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 26ec29c9cd1b..e8bc0249b503 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -520,22 +520,12 @@ static inline void spitz_leds_init(void) {}
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
@@ -543,6 +533,8 @@ static struct gpiod_lookup_table spitz_ads7846_gpio_table = {
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


