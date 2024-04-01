Return-Path: <linux-kernel+bounces-127088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12ED894694
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154C51F22055
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF39958133;
	Mon,  1 Apr 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEqDgWQc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66A54FB1;
	Mon,  1 Apr 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006655; cv=none; b=Q1Kn/CO1hNV6htNm/reA52oQLlutwlS4jeQQDeh/wMmfLHBMJXnQHb8c1hbSxaPpMUx2XI3vUu++QgtHA3iy4OgWxqSXHepNtvJbivmZwE4d6zSNKV5ckn5UiKCVpKhkdaQ/N6fc36zyuGiHwfoOfc37vsT6ClKunEFQouaO7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006655; c=relaxed/simple;
	bh=6mgNaymWIj3cH71XU9OfjjLH7AO/64bOHn2apMiHPmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGUCoz/x6t6nTvZTMJH2uhqfRiKUx6YxJPRyiK7p8J/8vIgioF1Hy6ayXPn3vo0Zb8VCY8axq61LA4Eimf2cqMtwkQzUipbD0NfTCMOxG6k/Urqut/ayD0rJFkU4MAv3ou3k97m43TBXN0DAJgZit7Y9qcP/zVPCvV00yvUtMpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEqDgWQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2935C433C7;
	Mon,  1 Apr 2024 21:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712006654;
	bh=6mgNaymWIj3cH71XU9OfjjLH7AO/64bOHn2apMiHPmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CEqDgWQcyierf1NuaiITc2yrzyjJnVNmoYZivgnDd9+sJZEPDSs5D8e9fey16Klma
	 KiVvXT3byvorWOkNAliER9l/ULAYI8J6wvxBoic/K5XNHtKTqGkZREygEsQbTa29Rc
	 uSmGDpjtRqZdAH/tr/HwRaRvEvMjZZBkh9AeH8YEYtnOKbwQt84RopA8K/jSvMRH7f
	 i55J5u9W8xhQqUZtxl8wQyWZRtZH1MBPlCLaQVjB90Hec/51hb3SC5uobrHZfjRyha
	 28Zz+Trfh0LhT1H4QnUoOlfLahuLruBD/tEeb2MvJEmSe6SEe510ScMApIBdhntt0J
	 iE3wAP52MhjeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B369ACD128A;
	Mon,  1 Apr 2024 21:24:14 +0000 (UTC)
From: =?utf-8?q?Andr=C3=A9_Apitzsch_via_B4_Relay?= <devnull+git.apitzsch.eu@kernel.org>
Date: Mon, 01 Apr 2024 23:23:56 +0200
Subject: [PATCH v2 2/3] leds: sy7802: Add support for Silergy SY7802 flash
 LED controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240401-sy7802-v2-2-1138190a7448@apitzsch.eu>
References: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
In-Reply-To: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712006653; l=16971;
 i=git@apitzsch.eu; s=20240325; h=from:subject:message-id;
 bh=3f0o848ZDQRRfYuiyFzPsV0wkNcr21X3ueS8dK2+aiI=;
 b=R7QjOWPlil9OCVb0J2BL2RVreOFObUgUVU0cEDUdT3zQycYulVnSsqeldCzshfbkAqWslr7dE
 c3K+FdaCz9FAoq6Mfrhb0VFX2N4Ma3YkjKxoFV80YzpXMi5dOyMXwTg
X-Developer-Key: i=git@apitzsch.eu; a=ed25519;
 pk=wxovcZRfvNYBMcTw4QFFtNEP4qv39gnBfnfyImXZxiU=
X-Endpoint-Received: by B4 Relay for git@apitzsch.eu/20240325 with
 auth_id=142
X-Original-From: =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Reply-To: git@apitzsch.eu

From: André Apitzsch <git@apitzsch.eu>

Add support for SY7802 flash LED controller. It can support up to 1.8A
flash current.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/leds/flash/Kconfig       |  11 +
 drivers/leds/flash/Makefile      |   1 +
 drivers/leds/flash/leds-sy7802.c | 532 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 544 insertions(+)

diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
index 809b6d98bb3e..f39f0bfe6eef 100644
--- a/drivers/leds/flash/Kconfig
+++ b/drivers/leds/flash/Kconfig
@@ -121,4 +121,15 @@ config LEDS_SGM3140
 	  This option enables support for the SGM3140 500mA Buck/Boost Charge
 	  Pump LED Driver.
 
+config LEDS_SY7802
+	tristate "LED support for the Silergy SY7802"
+	depends on I2C && OF
+	depends on GPIOLIB
+	select REGMAP_I2C
+	help
+	  This option enables support for the SY7802 flash LED controller.
+	  SY7802 includes torch and flash functions with programmable current.
+
+	  This driver can be built as a module, it will be called "leds-sy7802".
+
 endif # LEDS_CLASS_FLASH
diff --git a/drivers/leds/flash/Makefile b/drivers/leds/flash/Makefile
index 91d60a4b7952..48860eeced79 100644
--- a/drivers/leds/flash/Makefile
+++ b/drivers/leds/flash/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_LEDS_QCOM_FLASH)	+= leds-qcom-flash.o
 obj-$(CONFIG_LEDS_RT4505)	+= leds-rt4505.o
 obj-$(CONFIG_LEDS_RT8515)	+= leds-rt8515.o
 obj-$(CONFIG_LEDS_SGM3140)	+= leds-sgm3140.o
+obj-$(CONFIG_LEDS_SY7802)	+= leds-sy7802.o
diff --git a/drivers/leds/flash/leds-sy7802.c b/drivers/leds/flash/leds-sy7802.c
new file mode 100644
index 000000000000..c03a571b0e08
--- /dev/null
+++ b/drivers/leds/flash/leds-sy7802.c
@@ -0,0 +1,532 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Silergy SY7802 flash LED driver with I2C interface
+ *
+ * Copyright 2024 André Apitzsch <git@apitzsch.eu>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/led-class-flash.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define SY7802_MAX_LEDS 2
+#define SY7802_LED_JOINT 2
+
+#define SY7802_REG_ENABLE		0x10
+#define SY7802_REG_TORCH_BRIGHTNESS	0xa0
+#define SY7802_REG_FLASH_BRIGHTNESS	0xb0
+#define SY7802_REG_FLASH_DURATION	0xc0
+#define SY7802_REG_FLAGS		0xd0
+#define SY7802_REG_CONFIG_1		0xe0
+#define SY7802_REG_CONFIG_2		0xf0
+#define SY7802_REG_VIN_MONITOR		0x80
+#define SY7802_REG_LAST_FLASH		0x81
+#define SY7802_REG_VLED_MONITOR		0x30
+#define SY7802_REG_ADC_DELAY		0x31
+#define SY7802_REG_DEV_ID		0xff
+
+#define SY7802_MODE_OFF		0
+#define SY7802_MODE_TORCH	2
+#define SY7802_MODE_FLASH	3
+#define SY7802_MODE_MASK	GENMASK(1, 0)
+
+#define SY7802_LEDS_SHIFT	3
+#define SY7802_LEDS_MASK(_id)	(BIT(_id) << SY7802_LEDS_SHIFT)
+#define SY7802_LEDS_MASK_ALL	(SY7802_LEDS_MASK(0) | SY7802_LEDS_MASK(1))
+
+#define SY7802_TORCH_CURRENT_SHIFT	3
+#define SY7802_TORCH_CURRENT_MASK(_id) \
+	(GENMASK(2, 0) << (SY7802_TORCH_CURRENT_SHIFT * (_id)))
+#define SY7802_TORCH_CURRENT_MASK_ALL \
+	(SY7802_TORCH_CURRENT_MASK(0) | SY7802_TORCH_CURRENT_MASK(1))
+
+#define SY7802_FLASH_CURRENT_SHIFT	4
+#define SY7802_FLASH_CURRENT_MASK(_id) \
+	(GENMASK(3, 0) << (SY7802_FLASH_CURRENT_SHIFT * (_id)))
+#define SY7802_FLASH_CURRENT_MASK_ALL \
+	(SY7802_FLASH_CURRENT_MASK(0) | SY7802_FLASH_CURRENT_MASK(1))
+
+#define SY7802_TIMEOUT_DEFAULT_US	512000U
+#define SY7802_TIMEOUT_MIN_US		32000U
+#define SY7802_TIMEOUT_MAX_US		1024000U
+#define SY7802_TIMEOUT_STEPSIZE_US	32000U
+
+#define SY7802_TORCH_BRIGHTNESS_MAX 8
+
+#define SY7802_FLASH_BRIGHTNESS_DEFAULT	14
+#define SY7802_FLASH_BRIGHTNESS_MIN	0
+#define SY7802_FLASH_BRIGHTNESS_MAX	15
+#define SY7802_FLASH_BRIGHTNESS_STEP	1
+
+#define SY7802_FLAG_TIMEOUT			(1 << 0)
+#define SY7802_FLAG_THERMAL_SHUTDOWN		(1 << 1)
+#define SY7802_FLAG_LED_FAULT			(1 << 2)
+#define SY7802_FLAG_TX1_INTERRUPT		(1 << 3)
+#define SY7802_FLAG_TX2_INTERRUPT		(1 << 4)
+#define SY7802_FLAG_LED_THERMAL_FAULT		(1 << 5)
+#define SY7802_FLAG_FLASH_INPUT_VOLTAGE_LOW	(1 << 6)
+#define SY7802_FLAG_INPUT_VOLTAGE_LOW		(1 << 7)
+
+#define SY7802_CHIP_ID	0x51
+
+static const struct reg_default sy7802_regmap_defs[] = {
+	{ SY7802_REG_ENABLE, SY7802_LEDS_MASK_ALL },
+	{ SY7802_REG_TORCH_BRIGHTNESS, 0x92 },
+	{ SY7802_REG_FLASH_BRIGHTNESS, SY7802_FLASH_BRIGHTNESS_DEFAULT |
+		SY7802_FLASH_BRIGHTNESS_DEFAULT << SY7802_FLASH_CURRENT_SHIFT },
+	{ SY7802_REG_FLASH_DURATION, 0x6f },
+	{ SY7802_REG_FLAGS, 0x0 },
+	{ SY7802_REG_CONFIG_1, 0x68 },
+	{ SY7802_REG_CONFIG_2, 0xf0 },
+};
+
+struct sy7802_led {
+	struct led_classdev_flash flash;
+	struct sy7802 *chip;
+	u8 led_no;
+};
+
+struct sy7802 {
+	struct mutex mutex;
+	struct device *dev;
+	struct regmap *regmap;
+
+	struct gpio_desc *enable_gpio;
+	struct regulator *vin_regulator;
+
+	unsigned int fled_strobe_used;
+	unsigned int fled_torch_used;
+	unsigned int leds_active;
+	int num_leds;
+	struct sy7802_led leds[] __counted_by(num_leds);
+};
+
+static int sy7802_torch_brightness_set(struct led_classdev *lcdev, enum led_brightness level)
+{
+	struct sy7802_led *led = container_of(lcdev, struct sy7802_led, flash.led_cdev);
+	u32 led_enable_mask = led->led_no == SY7802_LED_JOINT ? SY7802_LEDS_MASK_ALL :
+			      SY7802_LEDS_MASK(led->led_no);
+	u32 enable_mask = SY7802_MODE_MASK | led_enable_mask;
+	u32 val = level ? led_enable_mask : SY7802_MODE_OFF;
+	struct sy7802 *chip = led->chip;
+	u32 curr;
+	u32 mask;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+
+	/*
+	 * There is only one set of flash control logic, and this flag is used to check if 'strobe'
+	 * is currently being used.
+	 */
+	if (chip->fled_strobe_used) {
+		dev_warn(chip->dev, "Please disable strobe first [%d]\n", chip->fled_strobe_used);
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (level)
+		curr = chip->fled_torch_used | BIT(led->led_no);
+	else
+		curr = chip->fled_torch_used & ~BIT(led->led_no);
+
+	if (curr)
+		val |= SY7802_MODE_TORCH;
+
+	/* Torch needs to be disabled first to apply new brightness */
+	ret = regmap_update_bits(chip->regmap, SY7802_REG_ENABLE, SY7802_MODE_MASK,
+				 SY7802_MODE_OFF);
+	if (ret)
+		goto unlock;
+
+	mask = led->led_no == SY7802_LED_JOINT ? SY7802_TORCH_CURRENT_MASK_ALL :
+	       SY7802_TORCH_CURRENT_MASK(led->led_no);
+
+	/* Register expects brightness between 0 and MAX_BRIGHTNESS - 1 */
+	if (level)
+		level -= 1;
+
+	level |= (level << SY7802_TORCH_CURRENT_SHIFT);
+
+	ret = regmap_update_bits(chip->regmap, SY7802_REG_TORCH_BRIGHTNESS, mask, level);
+	if (ret)
+		goto unlock;
+
+	ret = regmap_update_bits(chip->regmap, SY7802_REG_ENABLE, enable_mask, val);
+	if (ret)
+		goto unlock;
+
+	chip->fled_torch_used = curr;
+
+unlock:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static int sy7802_flash_brightness_set(struct led_classdev_flash *fl_cdev, u32 brightness)
+{
+	struct sy7802_led *led = container_of(fl_cdev, struct sy7802_led, flash);
+	struct led_flash_setting *s = &fl_cdev->brightness;
+	u32 val = (brightness - s->min) / s->step;
+	struct sy7802 *chip = led->chip;
+	u32 mask;
+	int ret;
+
+	val |= (val << SY7802_FLASH_CURRENT_SHIFT);
+	mask = led->led_no == SY7802_LED_JOINT ? SY7802_FLASH_CURRENT_MASK_ALL :
+	       SY7802_FLASH_CURRENT_MASK(led->led_no);
+
+	mutex_lock(&chip->mutex);
+	ret = regmap_update_bits(chip->regmap, SY7802_REG_FLASH_BRIGHTNESS, mask, val);
+	mutex_unlock(&chip->mutex);
+
+	return ret;
+}
+
+static int sy7802_strobe_set(struct led_classdev_flash *fl_cdev, bool state)
+{
+	struct sy7802_led *led = container_of(fl_cdev, struct sy7802_led, flash);
+	u32 led_enable_mask = led->led_no == SY7802_LED_JOINT ? SY7802_LEDS_MASK_ALL :
+			      SY7802_LEDS_MASK(led->led_no);
+	u32 enable_mask = SY7802_MODE_MASK | led_enable_mask;
+	u32 val = state ? led_enable_mask : SY7802_MODE_OFF;
+	struct sy7802 *chip = led->chip;
+	u32 curr;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+
+	/*
+	 * There is only one set of flash control logic, and this flag is used to check if 'torch'
+	 * is currently being used.
+	 */
+	if (chip->fled_torch_used) {
+		dev_warn(chip->dev, "Please disable torch first [0x%x]\n", chip->fled_torch_used);
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (state)
+		curr = chip->fled_strobe_used | BIT(led->led_no);
+	else
+		curr = chip->fled_strobe_used & ~BIT(led->led_no);
+
+	if (curr)
+		val |= SY7802_MODE_FLASH;
+
+	ret = regmap_update_bits(chip->regmap, SY7802_REG_ENABLE, enable_mask, val);
+
+	if (ret)
+		goto unlock;
+
+	chip->fled_strobe_used = curr;
+
+unlock:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static int sy7802_strobe_get(struct led_classdev_flash *fl_cdev, bool *state)
+{
+	struct sy7802_led *led = container_of(fl_cdev, struct sy7802_led, flash);
+	struct sy7802 *chip = led->chip;
+
+	mutex_lock(&chip->mutex);
+	*state = !!(chip->fled_strobe_used & BIT(led->led_no));
+	mutex_unlock(&chip->mutex);
+
+	return 0;
+}
+
+static int sy7802_timeout_set(struct led_classdev_flash *fl_cdev,
+			      u32 timeout)
+{
+	struct sy7802_led *led = container_of(fl_cdev, struct sy7802_led, flash);
+	struct led_flash_setting *s = &fl_cdev->timeout;
+	u32 val = (timeout - s->min) / s->step;
+	struct sy7802 *chip = led->chip;
+
+	return regmap_write(chip->regmap, SY7802_REG_FLASH_DURATION, val);
+}
+
+static int sy7802_fault_get(struct led_classdev_flash *fl_cdev, u32 *fault)
+{
+	struct sy7802_led *led = container_of(fl_cdev, struct sy7802_led, flash);
+	struct sy7802 *chip = led->chip;
+	u32 val, led_faults = 0;
+	int ret;
+
+	/* NOTE: reading register clears fault status */
+	ret = regmap_read(chip->regmap, SY7802_REG_FLAGS, &val);
+	if (ret)
+		return ret;
+
+	if (val & (SY7802_FLAG_FLASH_INPUT_VOLTAGE_LOW | SY7802_FLAG_INPUT_VOLTAGE_LOW))
+		led_faults |= LED_FAULT_INPUT_VOLTAGE;
+
+	if (val & SY7802_FLAG_THERMAL_SHUTDOWN)
+		led_faults |= LED_FAULT_OVER_TEMPERATURE;
+
+	if (val & SY7802_FLAG_TIMEOUT)
+		led_faults |= LED_FAULT_TIMEOUT;
+
+	*fault = led_faults;
+	return 0;
+}
+
+static const struct led_flash_ops sy7802_flash_ops = {
+	.flash_brightness_set = sy7802_flash_brightness_set,
+	.strobe_set = sy7802_strobe_set,
+	.strobe_get = sy7802_strobe_get,
+	.timeout_set = sy7802_timeout_set,
+	.fault_get = sy7802_fault_get,
+};
+
+static void sy7802_init_flash_brightness(struct led_classdev_flash *fl_cdev)
+{
+	struct led_flash_setting *s;
+
+	/* Init flash brightness setting */
+	s = &fl_cdev->brightness;
+	s->min = SY7802_FLASH_BRIGHTNESS_MIN;
+	s->max = SY7802_FLASH_BRIGHTNESS_MAX;
+	s->step = SY7802_FLASH_BRIGHTNESS_STEP;
+	s->val = SY7802_FLASH_BRIGHTNESS_DEFAULT;
+}
+
+static void sy7802_init_flash_timeout(struct led_classdev_flash *fl_cdev)
+{
+	struct led_flash_setting *s;
+
+	/* Init flash timeout setting */
+	s = &fl_cdev->timeout;
+	s->min = SY7802_TIMEOUT_MIN_US;
+	s->max = SY7802_TIMEOUT_MAX_US;
+	s->step = SY7802_TIMEOUT_STEPSIZE_US;
+	s->val = SY7802_TIMEOUT_DEFAULT_US;
+}
+
+static int sy7802_led_register(struct device *dev, struct sy7802_led *led,
+			       struct device_node *np)
+{
+	struct led_init_data init_data = {};
+	int ret;
+
+	init_data.fwnode = of_fwnode_handle(np);
+
+	ret = devm_led_classdev_flash_register_ext(dev, &led->flash, &init_data);
+	if (ret) {
+		dev_err(dev, "Couldn't register flash %d\n", led->led_no);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int sy7802_init_flash_properties(struct device *dev, struct sy7802_led *led,
+					struct device_node *np)
+{
+	struct led_classdev_flash *flash = &led->flash;
+	struct led_classdev *lcdev = &flash->led_cdev;
+	u32 sources[SY7802_MAX_LEDS];
+	int i, num, ret;
+
+	num = of_property_count_u32_elems(np, "led-sources");
+	if (num < 1) {
+		dev_err(dev, "Not specified or wrong number of led-sources\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32_array(np, "led-sources", sources, num);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num; i++) {
+		if (sources[i] >= SY7802_MAX_LEDS)
+			return -EINVAL;
+		if (led->chip->leds_active & BIT(sources[i]))
+			return -EINVAL;
+		led->chip->leds_active |= BIT(sources[i]);
+	}
+
+	/* If both channels are specified in 'led-sources', joint flash output mode is used */
+	led->led_no = num == 2 ? SY7802_LED_JOINT : sources[0];
+
+	lcdev->max_brightness = SY7802_TORCH_BRIGHTNESS_MAX;
+	lcdev->brightness_set_blocking = sy7802_torch_brightness_set;
+	lcdev->flags |= LED_DEV_CAP_FLASH;
+
+	flash->ops = &sy7802_flash_ops;
+
+	sy7802_init_flash_brightness(flash);
+	sy7802_init_flash_timeout(flash);
+
+	return 0;
+}
+
+static int sy7802_chip_check(struct sy7802 *chip)
+{
+	struct device *dev = chip->dev;
+	u32 chipid;
+	int ret;
+
+	ret = regmap_read(chip->regmap, SY7802_REG_DEV_ID, &chipid);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read chip ID\n");
+
+	if (chipid != SY7802_CHIP_ID)
+		return dev_err_probe(dev, -ENODEV, "Chip reported wrong ID: %x\n", chipid);
+
+	return 0;
+}
+
+static void sy7802_enable(struct sy7802 *chip)
+{
+	gpiod_set_value_cansleep(chip->enable_gpio, 1);
+	usleep_range(200, 300);
+}
+
+static void sy7802_disable(struct sy7802 *chip)
+{
+	gpiod_set_value_cansleep(chip->enable_gpio, 0);
+}
+
+static int sy7802_probe_dt(struct sy7802 *chip)
+{
+	struct device_node *np = dev_of_node(chip->dev), *child;
+	int i = 0;
+	int ret;
+
+	regmap_write(chip->regmap, SY7802_REG_ENABLE, SY7802_MODE_OFF);
+	regmap_write(chip->regmap, SY7802_REG_TORCH_BRIGHTNESS, LED_OFF);
+
+	for_each_available_child_of_node(np, child) {
+		struct sy7802_led *led = chip->leds + i;
+
+		led->chip = chip;
+		led->led_no = i;
+
+		ret = sy7802_init_flash_properties(chip->dev, led, child);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+
+		ret = sy7802_led_register(chip->dev, led, child);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+
+		i++;
+	}
+	return 0;
+}
+
+static const struct regmap_config sy7802_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xff,
+	.cache_type = REGCACHE_MAPLE,
+	.reg_defaults = sy7802_regmap_defs,
+	.num_reg_defaults = ARRAY_SIZE(sy7802_regmap_defs),
+};
+
+static int sy7802_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct sy7802 *chip;
+	size_t count;
+	int ret;
+
+	count = device_get_child_node_count(dev);
+	if (!count || count > SY7802_MAX_LEDS)
+		return dev_err_probe(dev, -EINVAL,
+		       "No child node or node count over max led number %zu\n", count);
+
+	chip = devm_kzalloc(dev, struct_size(chip, leds, count), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->num_leds = count;
+
+	chip->dev = dev;
+	i2c_set_clientdata(client, chip);
+
+	chip->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	ret = PTR_ERR_OR_ZERO(chip->enable_gpio);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request enable gpio\n");
+
+	chip->vin_regulator = devm_regulator_get(dev, "vin");
+	ret = PTR_ERR_OR_ZERO(chip->vin_regulator);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request regulator\n");
+
+	ret = regulator_enable(chip->vin_regulator);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
+
+	chip->regmap = devm_regmap_init_i2c(client, &sy7802_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		regulator_disable(chip->vin_regulator);
+		return dev_err_probe(dev, PTR_ERR(chip->regmap),
+				    "Failed to allocate register map.\n");
+	}
+
+	ret = sy7802_probe_dt(chip);
+	if (ret < 0) {
+		regulator_disable(chip->vin_regulator);
+		return ret;
+	}
+
+	sy7802_enable(chip);
+
+	ret = sy7802_chip_check(chip);
+	if (ret) {
+		sy7802_disable(chip);
+		regulator_disable(chip->vin_regulator);
+		return ret;
+	}
+
+	mutex_init(&chip->mutex);
+
+	return ret;
+}
+
+static void sy7802_remove(struct i2c_client *client)
+{
+	struct sy7802 *chip = i2c_get_clientdata(client);
+
+	sy7802_disable(chip);
+
+	mutex_destroy(&chip->mutex);
+	regulator_disable(chip->vin_regulator);
+}
+
+static const struct of_device_id __maybe_unused sy7802_leds_match[] = {
+	{ .compatible = "silergy,sy7802", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, sy7802_leds_match);
+
+static struct i2c_driver sy7802_driver = {
+	.driver = {
+		.name = "sy7802",
+		.of_match_table = of_match_ptr(sy7802_leds_match),
+	},
+	.probe = sy7802_probe,
+	.remove = sy7802_remove,
+};
+
+module_i2c_driver(sy7802_driver);
+
+MODULE_AUTHOR("André Apitzsch <git@apitzsch.eu>");
+MODULE_DESCRIPTION("Silergy SY7802 flash LED driver");
+MODULE_LICENSE("GPL");

-- 
2.44.0



