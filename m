Return-Path: <linux-kernel+bounces-29872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F38314AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4FA1F24CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6242D7A6;
	Thu, 18 Jan 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDkue3vR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC3D1D69F;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566180; cv=none; b=ZuM7AcozSVdrjzPoD5Z2fQbB0avvYw36YnCTsxQ7hzgwBmMyEvmvc6H4T6qz7InKq+gdDxDANfalZS+bTjbIgAPdt22lkSyPYIKWihe+eaoFxpzSJJQFtwnlKRigA/LP1USwaPlCTHCYg1J4OogsYJGXd3jHfvkPiWjgJUzkBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566180; c=relaxed/simple;
	bh=H8r+c1D4PuIPdqRUXhfvaJVpVOiIYihthdCZwohaK2M=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=n0CynFG/fxtqMDbK2tWX1XdGK7lYOffOXl8DvTHpbzgL2YyMHQWTtBDB20kEBuQno/zcsA2Pa06R502T2y5QBuMq5ahV+kXeffiNx0RZJ4BW5KLqbZbxXGAzV4ViyHCYBiSGSvHeID10k8K7ddmbMpYqU+L6WUcPzPMoRpqnTnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDkue3vR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0C87C32799;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705566179;
	bh=H8r+c1D4PuIPdqRUXhfvaJVpVOiIYihthdCZwohaK2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IDkue3vRduA5ANEgzhXyWeEPVHrwhDCMyKAXX7Iw0M5ZnlKgLNCs/q/anfudzEj0i
	 n77y+NbqdI2zJjxOmfPcZ2ou/DOO1w2fIeru9ztgXJT3WSxBVxB1ODVFjFVt+FfAwg
	 NKw0/cjijxHnbZnmnEc5fljpeasnRHAyF8BDujmA0oYdbyOkJgpXcsQpKGUZ4QnfDX
	 p5B8Z0GewC812DXbLbGAduAgWV+X7QSwqVvQP455hclbJ+0mfqqK6hZimLfhGollBr
	 XlIPfV86C4Unl73NmJUqdWdSKn8Kzd4sJ9P1pYcL2N8mAWx4AgWOfqRytdrCMqCBth
	 PYf1IQNQkJjlw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B03C47DD3;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 18 Jan 2024 11:21:07 +0300
Subject: [PATCH v7 24/39] input: keypad: ep93xx: add DT support for Cirrus
 EP93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-ep93xx-v7-24-d953846ae771@maquefel.me>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705566176; l=9171;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=gEO2z0Vy9NVI0Ft5a3kLOZwaNAzWO91e7jmQyvoBGwU=; =?utf-8?q?b=3Dm0ciMxhOy+ii?=
 =?utf-8?q?VlnmU1FJcTDdMFITHntRbR4lQfPFLUbrgZYws74rGXzZHybNUJ6/vjmG2Mkn4VJz?=
 ucNqqjpPBMFGqQPd7rRxhhYzAM7ZRePf+OXU6wEbsMRDTrfWIZ2o
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

- drop flags, they were not used anyway
- add OF ID match table
- process "autorepeat", "debounce-delay-ms", prescale from device tree
- drop platform data usage and it's header
- keymap goes from device tree now on

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/mach-ep93xx/core.c            | 46 ---------------------
 drivers/input/keyboard/ep93xx_keypad.c | 74 ++++++++++------------------------
 include/linux/soc/cirrus/ep93xx.h      |  4 --
 3 files changed, 22 insertions(+), 102 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 03bce5e9d1f1..b99c46d22c4d 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -697,52 +697,6 @@ void __init ep93xx_register_keypad(struct ep93xx_keypad_platform_data *data)
 	platform_device_register(&ep93xx_keypad_device);
 }
 
-int ep93xx_keypad_acquire_gpio(struct platform_device *pdev)
-{
-	int err;
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		err = gpio_request(EP93XX_GPIO_LINE_C(i), dev_name(&pdev->dev));
-		if (err)
-			goto fail_gpio_c;
-		err = gpio_request(EP93XX_GPIO_LINE_D(i), dev_name(&pdev->dev));
-		if (err)
-			goto fail_gpio_d;
-	}
-
-	/* Enable the keypad controller; GPIO ports C and D used for keypad */
-	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_KEYS |
-				 EP93XX_SYSCON_DEVCFG_GONK);
-
-	return 0;
-
-fail_gpio_d:
-	gpio_free(EP93XX_GPIO_LINE_C(i));
-fail_gpio_c:
-	for (--i; i >= 0; --i) {
-		gpio_free(EP93XX_GPIO_LINE_C(i));
-		gpio_free(EP93XX_GPIO_LINE_D(i));
-	}
-	return err;
-}
-EXPORT_SYMBOL(ep93xx_keypad_acquire_gpio);
-
-void ep93xx_keypad_release_gpio(struct platform_device *pdev)
-{
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		gpio_free(EP93XX_GPIO_LINE_C(i));
-		gpio_free(EP93XX_GPIO_LINE_D(i));
-	}
-
-	/* Disable the keypad controller; GPIO ports C and D used for GPIO */
-	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_KEYS |
-			       EP93XX_SYSCON_DEVCFG_GONK);
-}
-EXPORT_SYMBOL(ep93xx_keypad_release_gpio);
-
 /*************************************************************************
  * EP93xx I2S audio peripheral handling
  *************************************************************************/
diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 6b811d6bf625..8159134946b3 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -6,20 +6,13 @@
  *
  * Based on the pxa27x matrix keypad controller by Rodolfo Giometti.
  *
- * NOTE:
- *
- * The 3-key reset is triggered by pressing the 3 keys in
- * Row 0, Columns 2, 4, and 7 at the same time.  This action can
- * be disabled by setting the EP93XX_KEYPAD_DISABLE_3_KEY flag.
- *
- * Normal operation for the matrix does not autorepeat the key press.
- * This action can be enabled by setting the EP93XX_KEYPAD_AUTOREPEAT
- * flag.
  */
 
 #include <linux/bits.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -27,7 +20,6 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/slab.h>
 #include <linux/soc/cirrus/ep93xx.h>
-#include <linux/platform_data/keypad-ep93xx.h>
 #include <linux/pm_wakeirq.h>
 
 /*
@@ -61,12 +53,16 @@
 #define KEY_REG_KEY1_MASK	GENMASK(5, 0)
 #define KEY_REG_KEY1_SHIFT	0
 
+#define EP93XX_MATRIX_ROWS		(8)
+#define EP93XX_MATRIX_COLS		(8)
+
 #define EP93XX_MATRIX_SIZE	(EP93XX_MATRIX_ROWS * EP93XX_MATRIX_COLS)
 
 struct ep93xx_keypad {
-	struct ep93xx_keypad_platform_data *pdata;
 	struct input_dev *input_dev;
 	struct clk *clk;
+	unsigned int	debounce;
+	uint16_t	prescale;
 
 	void __iomem *mmio_base;
 
@@ -133,23 +129,11 @@ static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
 
 static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
 {
-	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
 	unsigned int val = 0;
 
-	clk_set_rate(keypad->clk, pdata->clk_rate);
+	val |= (keypad->debounce << KEY_INIT_DBNC_SHIFT) & KEY_INIT_DBNC_MASK;
 
-	if (pdata->flags & EP93XX_KEYPAD_DISABLE_3_KEY)
-		val |= KEY_INIT_DIS3KY;
-	if (pdata->flags & EP93XX_KEYPAD_DIAG_MODE)
-		val |= KEY_INIT_DIAG;
-	if (pdata->flags & EP93XX_KEYPAD_BACK_DRIVE)
-		val |= KEY_INIT_BACK;
-	if (pdata->flags & EP93XX_KEYPAD_TEST_MODE)
-		val |= KEY_INIT_T2;
-
-	val |= ((pdata->debounce << KEY_INIT_DBNC_SHIFT) & KEY_INIT_DBNC_MASK);
-
-	val |= ((pdata->prescale << KEY_INIT_PRSCL_SHIFT) & KEY_INIT_PRSCL_MASK);
+	val |= (keypad->prescale << KEY_INIT_PRSCL_SHIFT) & KEY_INIT_PRSCL_MASK;
 
 	__raw_writel(val, keypad->mmio_base + KEY_INIT);
 }
@@ -220,17 +204,10 @@ static int ep93xx_keypad_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(ep93xx_keypad_pm_ops,
 				ep93xx_keypad_suspend, ep93xx_keypad_resume);
 
-static void ep93xx_keypad_release_gpio_action(void *_pdev)
-{
-	struct platform_device *pdev = _pdev;
-
-	ep93xx_keypad_release_gpio(pdev);
-}
-
 static int ep93xx_keypad_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct ep93xx_keypad *keypad;
-	const struct matrix_keymap_data *keymap_data;
 	struct input_dev *input_dev;
 	int err;
 
@@ -238,14 +215,6 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	if (!keypad)
 		return -ENOMEM;
 
-	keypad->pdata = dev_get_platdata(&pdev->dev);
-	if (!keypad->pdata)
-		return -EINVAL;
-
-	keymap_data = keypad->pdata->keymap_data;
-	if (!keymap_data)
-		return -EINVAL;
-
 	keypad->irq = platform_get_irq(pdev, 0);
 	if (keypad->irq < 0)
 		return keypad->irq;
@@ -254,19 +223,13 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	if (IS_ERR(keypad->mmio_base))
 		return PTR_ERR(keypad->mmio_base);
 
-	err = ep93xx_keypad_acquire_gpio(pdev);
-	if (err)
-		return err;
-
-	err = devm_add_action_or_reset(&pdev->dev,
-				       ep93xx_keypad_release_gpio_action, pdev);
-	if (err)
-		return err;
-
 	keypad->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(keypad->clk))
 		return PTR_ERR(keypad->clk);
 
+	device_property_read_u32(dev, "debounce-delay-ms", &keypad->debounce);
+	device_property_read_u16(dev, "cirrus,prescale", &keypad->prescale);
+
 	input_dev = devm_input_allocate_device(&pdev->dev);
 	if (!input_dev)
 		return -ENOMEM;
@@ -278,13 +241,13 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	input_dev->open = ep93xx_keypad_open;
 	input_dev->close = ep93xx_keypad_close;
 
-	err = matrix_keypad_build_keymap(keymap_data, NULL,
+	err = matrix_keypad_build_keymap(NULL, NULL,
 					 EP93XX_MATRIX_ROWS, EP93XX_MATRIX_COLS,
 					 keypad->keycodes, input_dev);
 	if (err)
 		return err;
 
-	if (keypad->pdata->flags & EP93XX_KEYPAD_AUTOREPEAT)
+	if (device_property_read_bool(&pdev->dev, "autorepeat"))
 		__set_bit(EV_REP, input_dev->evbit);
 	input_set_drvdata(input_dev, keypad);
 
@@ -313,10 +276,17 @@ static void ep93xx_keypad_remove(struct platform_device *pdev)
 	dev_pm_clear_wake_irq(&pdev->dev);
 }
 
+static const struct of_device_id ep93xx_keypad_of_ids[] = {
+	{ .compatible = "cirrus,ep9307-keypad" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_keypad_of_ids);
+
 static struct platform_driver ep93xx_keypad_driver = {
 	.driver		= {
 		.name	= "ep93xx-keypad",
 		.pm	= pm_sleep_ptr(&ep93xx_keypad_pm_ops),
+		.of_match_table = ep93xx_keypad_of_ids,
 	},
 	.probe		= ep93xx_keypad_probe,
 	.remove_new	= ep93xx_keypad_remove,
diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index a27447971302..8942bfaf1545 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -41,8 +41,6 @@ int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
 void ep93xx_pwm_release_gpio(struct platform_device *pdev);
 int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
 void ep93xx_ide_release_gpio(struct platform_device *pdev);
-int ep93xx_keypad_acquire_gpio(struct platform_device *pdev);
-void ep93xx_keypad_release_gpio(struct platform_device *pdev);
 int ep93xx_i2s_acquire(void);
 void ep93xx_i2s_release(void);
 unsigned int ep93xx_chip_revision(void);
@@ -52,8 +50,6 @@ static inline int ep93xx_pwm_acquire_gpio(struct platform_device *pdev) { return
 static inline void ep93xx_pwm_release_gpio(struct platform_device *pdev) {}
 static inline int ep93xx_ide_acquire_gpio(struct platform_device *pdev) { return 0; }
 static inline void ep93xx_ide_release_gpio(struct platform_device *pdev) {}
-static inline int ep93xx_keypad_acquire_gpio(struct platform_device *pdev) { return 0; }
-static inline void ep93xx_keypad_release_gpio(struct platform_device *pdev) {}
 static inline int ep93xx_i2s_acquire(void) { return 0; }
 static inline void ep93xx_i2s_release(void) {}
 static inline unsigned int ep93xx_chip_revision(void) { return 0; }

-- 
2.41.0


