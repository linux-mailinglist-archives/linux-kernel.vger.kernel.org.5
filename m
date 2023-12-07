Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62ED8085F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379102AbjLGKIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378851AbjLGKIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:08:00 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ED1A8;
        Thu,  7 Dec 2023 02:08:04 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B7A7nB62077970, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B7A7nB62077970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Dec 2023 18:07:49 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 7 Dec 2023 18:07:49 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 7 Dec 2023 18:07:48 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Thu, 7 Dec 2023 18:07:48 +0800
From:   TY Chang <tychang@realtek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, TY Chang <tychang@realtek.com>
Subject: [PATCH v3 2/2] Add GPIO support for Realtek DHC(Digital Home Center) RTD SoCs.
Date:   Thu, 7 Dec 2023 18:07:23 +0800
Message-ID: <20231207100723.15015-3-tychang@realtek.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207100723.15015-1-tychang@realtek.com>
References: <20231207100723.15015-1-tychang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzuyi Chang <tychang@realtek.com>

This driver enables configuration of GPIO direction, GPIO values, GPIO
debounce settings and handles GPIO interrupts.

Signed-off-by: Tzuyi Chang <tychang@realtek.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v2 to v3 change:
    1. Remove generic compatible and use SoC-specific compatible instead.
    2. Add the missing descriptions for the rtd_gpio_info structure members.
    3. Assign gpio_chip fwnode.
v1 to v2 change:
    1. Remove legacy headers.
    2. Transitioned from OF API to platform_device API.
    3. Use u8 for the offset member within the rtd_gpio_info structure.
    4. Record the size of each array within the rtd_gpio_info structure and
       implement checks to prevent out-of-bounds access.
    5. Use GPIOLIB_IRQCHIP helpers to register interrupts.
    6. Use dynamic allocation for GPIO base.
---
 drivers/gpio/Kconfig    |   9 +
 drivers/gpio/Makefile   |   1 +
 drivers/gpio/gpio-rtd.c | 748 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 758 insertions(+)
 create mode 100644 drivers/gpio/gpio-rtd.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b3a133ed31ee..f0bdf9dbdefc 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -553,6 +553,15 @@ config GPIO_ROCKCHIP
 	help
 	  Say yes here to support GPIO on Rockchip SoCs.
 
+config GPIO_RTD
+	tristate "Realtek DHC GPIO support"
+	depends on ARCH_REALTEK
+	default y
+	select GPIOLIB_IRQCHIP
+	help
+	  Say yes here to support GPIO on Realtek DHC(Digital Home Center)
+	  SoCs.
+
 config GPIO_SAMA5D2_PIOBU
 	tristate "SAMA5D2 PIOBU GPIO support"
 	depends on MFD_SYSCON
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index eb73b5d633eb..16bb40717e87 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -137,6 +137,7 @@ obj-$(CONFIG_GPIO_RDC321X)		+= gpio-rdc321x.o
 obj-$(CONFIG_GPIO_REALTEK_OTTO)		+= gpio-realtek-otto.o
 obj-$(CONFIG_GPIO_REG)			+= gpio-reg.o
 obj-$(CONFIG_GPIO_ROCKCHIP)	+= gpio-rockchip.o
+obj-$(CONFIG_GPIO_RTD)			+= gpio-rtd.o
 obj-$(CONFIG_ARCH_SA1100)		+= gpio-sa1100.o
 obj-$(CONFIG_GPIO_SAMA5D2_PIOBU)	+= gpio-sama5d2-piobu.o
 obj-$(CONFIG_GPIO_SCH311X)		+= gpio-sch311x.o
diff --git a/drivers/gpio/gpio-rtd.c b/drivers/gpio/gpio-rtd.c
new file mode 100644
index 000000000000..f3489b636bc7
--- /dev/null
+++ b/drivers/gpio/gpio-rtd.c
@@ -0,0 +1,748 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Realtek DHC gpio driver
+ *
+ * Copyright (c) 2023 Realtek Semiconductor Corp.
+ */
+
+#include <linux/bitops.h>
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/spinlock.h>
+
+#define RTD_GPIO_DEBOUNCE_1US 0
+#define RTD_GPIO_DEBOUNCE_10US 1
+#define RTD_GPIO_DEBOUNCE_100US 2
+#define RTD_GPIO_DEBOUNCE_1MS 3
+#define RTD_GPIO_DEBOUNCE_10MS 4
+#define RTD_GPIO_DEBOUNCE_20MS 5
+#define RTD_GPIO_DEBOUNCE_30MS 6
+
+enum rtd_gpio_type {
+	RTD_ISO_GPIO = 0,
+	RTD1295_ISO_GPIO,
+	RTD1295_MISC_GPIO,
+	RTD1395_ISO_GPIO,
+	RTD1619_ISO_GPIO,
+};
+
+/**
+ * struct rtd_gpio_info - Specific GPIO register information
+ * @name: GPIO device name
+ * @type: RTD GPIO ID
+ * @gpio_base: GPIO base number
+ * @num_gpios: The number of GPIOs
+ * @dir_offset: Offset for GPIO direction registers
+ * @num_dir: The number of GPIO direction registers
+ * @dato_offset: Offset for GPIO data output registers
+ * @num_dato: The number of GPIO data output registers
+ * @dati_offset: Offset for GPIO data input registers
+ * @num_dati: The number of GPIO data input registers
+ * @ie_offset: Offset for GPIO interrupt enable registers
+ * @num_ie: The number of GPIO interrupt enable registers
+ * @dp_offset: Offset for GPIO detection polarity registers
+ * @num_dp: The number of GPIO detection polarity registers
+ * @gpa_offset: Offset for GPIO assert interrupt status registers
+ * @num_gpa: The number of GPIO assert interrupt status registers
+ * @gpda_offset: Offset for GPIO deassert interrupt status registers
+ * @num_gpda: The number of GPIO deassert interrupt status registers
+ * @deb_offset: Offset for GPIO debounce registers
+ * @num_deb: The number of GPIO debounce registers
+ */
+struct rtd_gpio_info {
+	const char		*name;
+	enum rtd_gpio_type	type;
+	unsigned int		gpio_base;
+	unsigned int		num_gpios;
+	u8			*dir_offset;
+	u8			num_dir;
+	u8			*dato_offset;
+	u8			num_dato;
+	u8			*dati_offset;
+	u8			num_dati;
+	u8			*ie_offset;
+	u8			num_ie;
+	u8			*dp_offset;
+	u8			num_dp;
+	u8			*gpa_offset;
+	u8			num_gpa;
+	u8			*gpda_offset;
+	u8			num_gpda;
+	u8			*deb_offset;
+	u8			num_deb;
+};
+
+struct rtd_gpio {
+	struct platform_device		*pdev;
+	const struct rtd_gpio_info	*info;
+	void __iomem			*base;
+	void __iomem			*irq_base;
+	struct gpio_chip		gpio_chip;
+	unsigned int			irqs[2];
+	spinlock_t			lock;
+};
+
+
+static const struct rtd_gpio_info rtd_iso_gpio_info = {
+	.name		= "rtd_iso_gpio",
+	.type		= RTD_ISO_GPIO,
+	.gpio_base	= 0,
+	.num_gpios	= 82,
+	.dir_offset	= (u8 []){ 0x0, 0x18, 0x2c },
+	.num_dir	= 3,
+	.dato_offset	= (u8 []){ 0x4, 0x1c, 0x30 },
+	.num_dato	= 3,
+	.dati_offset	= (u8 []){ 0x8, 0x20, 0x34 },
+	.num_dati	= 3,
+	.ie_offset	= (u8 []){ 0xc, 0x24, 0x38 },
+	.num_ie		= 3,
+	.dp_offset	= (u8 []){ 0x10, 0x28, 0x3c },
+	.num_dp		= 3,
+	.gpa_offset	= (u8 []){ 0x8, 0xe0, 0x90 },
+	.num_gpa	= 3,
+	.gpda_offset	= (u8 []){ 0xc, 0xe4, 0x94 },
+	.num_gpda	= 3,
+	.deb_offset	= (u8 []){ 0x44, 0x48, 0x4c, 0x50, 0x54, 0x58, 0x5c,
+				   0x60, 0x64, 0x68, 0x6c },
+	.num_deb	= 11,
+};
+
+static const struct rtd_gpio_info rtd1619_iso_gpio_info = {
+	.name		= "rtd1619_iso_gpio",
+	.type		= RTD1619_ISO_GPIO,
+	.gpio_base	= 0,
+	.num_gpios	= 86,
+	.dir_offset	= (u8 []){ 0x0, 0x18, 0x2c },
+	.num_dir	= 3,
+	.dato_offset	= (u8 []){ 0x4, 0x1c, 0x30 },
+	.num_dato	= 3,
+	.dati_offset	= (u8 []){ 0x8, 0x20, 0x34 },
+	.num_dati	= 3,
+	.ie_offset	= (u8 []){ 0xc, 0x24, 0x38 },
+	.num_ie		= 3,
+	.dp_offset	= (u8 []){ 0x10, 0x28, 0x3c },
+	.num_dp		= 3,
+	.gpa_offset	= (u8 []){ 0x8, 0xe0, 0x90 },
+	.num_gpa	= 3,
+	.gpda_offset	= (u8 []){ 0xc, 0xe4, 0x94 },
+	.num_gpda	= 3,
+	.deb_offset	= (u8 []){ 0x44, 0x48, 0x4c, 0x50, 0x54, 0x58, 0x5c,
+				   0x60, 0x64, 0x68, 0x6c },
+	.num_deb	= 11,
+};
+
+static const struct rtd_gpio_info rtd1395_iso_gpio_info = {
+	.name		= "rtd1395_iso_gpio",
+	.type		= RTD1395_ISO_GPIO,
+	.gpio_base	= 0,
+	.num_gpios	= 57,
+	.dir_offset	= (u8 []){ 0x0, 0x18 },
+	.num_dir	= 2,
+	.dato_offset	= (u8 []){ 0x4, 0x1c },
+	.num_dato	= 2,
+	.dati_offset	= (u8 []){ 0x8, 0x20 },
+	.num_dati	= 2,
+	.ie_offset	= (u8 []){ 0xc, 0x24 },
+	.num_ie		= 2,
+	.dp_offset	= (u8 []){ 0x10, 0x28 },
+	.num_dp		= 2,
+	.gpa_offset	= (u8 []){ 0x8, 0xe0 },
+	.num_gpa	= 2,
+	.gpda_offset	= (u8 []){ 0xc, 0xe4 },
+	.num_gpda	= 2,
+	.deb_offset	= (u8 []){ 0x30, 0x34, 0x38, 0x3c, 0x40, 0x44, 0x48, 0x4c },
+	.num_deb	= 8,
+};
+
+static const struct rtd_gpio_info rtd1295_misc_gpio_info = {
+	.name		= "rtd1295_misc_gpio",
+	.type		= RTD1295_ISO_GPIO,
+	.gpio_base	= 0,
+	.num_gpios	= 101,
+	.dir_offset	= (u8 []){ 0x0, 0x4, 0x8, 0xc },
+	.num_dir	= 4,
+	.dato_offset	= (u8 []){ 0x10, 0x14, 0x18, 0x1c },
+	.num_dato	= 4,
+	.dati_offset	= (u8 []){ 0x20, 0x24, 0x28, 0x2c },
+	.num_dati	= 4,
+	.ie_offset	= (u8 []){ 0x30, 0x34, 0x38, 0x3c },
+	.num_ie		= 4,
+	.dp_offset	= (u8 []){ 0x40, 0x44, 0x48, 0x4c },
+	.num_dp		= 4,
+	.gpa_offset	= (u8 []){ 0x40, 0x44, 0xa4, 0xb8 },
+	.num_gpa	= 4,
+	.gpda_offset	= (u8 []){ 0x54, 0x58, 0xa8, 0xbc},
+	.num_gpda	= 4,
+	.deb_offset	= (u8 []){ 0x50 },
+	.num_deb	= 1,
+};
+
+static const struct rtd_gpio_info rtd1295_iso_gpio_info = {
+	.name		= "rtd1295_iso_gpio",
+	.type		= RTD1295_ISO_GPIO,
+	.gpio_base	= 101,
+	.num_gpios	= 35,
+	.dir_offset	= (u8 []){ 0x0, 0x18 },
+	.num_dir	= 2,
+	.dato_offset	= (u8 []){ 0x4, 0x1c },
+	.num_dato	= 2,
+	.dati_offset	= (u8 []){ 0x8, 0x20 },
+	.num_dati	= 2,
+	.ie_offset	= (u8 []){ 0xc, 0x24 },
+	.num_ie		= 2,
+	.dp_offset	= (u8 []){ 0x10, 0x28 },
+	.num_dp		= 2,
+	.gpa_offset	= (u8 []){ 0x8, 0xe0 },
+	.num_gpa	= 2,
+	.gpda_offset	= (u8 []){ 0xc, 0xe4 },
+	.num_gpda	= 2,
+	.deb_offset	= (u8 []){ 0x14 },
+	.num_deb	= 1,
+};
+
+static int rtd_gpio_dir_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	int index = offset / 32;
+
+	if (index > data->info->num_dir)
+		return -EINVAL;
+
+	return data->info->dir_offset[index];
+}
+
+static int rtd_gpio_dato_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	int index = offset / 32;
+
+	if (index > data->info->num_dato)
+		return -EINVAL;
+
+	return data->info->dato_offset[index];
+}
+
+static int rtd_gpio_dati_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	int index = offset / 32;
+
+	if (index > data->info->num_dati)
+		return -EINVAL;
+
+	return data->info->dati_offset[index];
+}
+
+static int rtd_gpio_ie_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	int index = offset / 32;
+
+	if (index > data->info->num_ie)
+		return -EINVAL;
+
+	return data->info->ie_offset[index];
+}
+
+static int rtd_gpio_dp_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	int index = offset / 32;
+
+	if (index > data->info->num_dp)
+		return -EINVAL;
+
+	return data->info->dp_offset[index];
+}
+
+static int rtd_gpio_gpa_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	int index = offset / 31;
+
+	if (index > data->info->num_gpa)
+		return -EINVAL;
+
+	return data->info->gpa_offset[index];
+}
+
+static int rtd_gpio_gpda_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	int index = offset / 31;
+
+	if (index > data->info->num_gpda)
+		return -EINVAL;
+
+	return data->info->gpda_offset[index];
+}
+
+static int rtd_gpio_deb_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	int index = offset / 8;
+
+	if (index > data->info->num_deb)
+		return -EINVAL;
+
+	return data->info->deb_offset[index];
+}
+
+static int rtd_gpio_set_debounce(struct gpio_chip *chip, unsigned int offset,
+				   unsigned int debounce)
+{
+	struct rtd_gpio *data = gpiochip_get_data(chip);
+	unsigned int write_en;
+	unsigned long flags;
+	unsigned int shift;
+	int reg_offset;
+	u32 deb_val;
+	u32 val;
+
+	switch (debounce) {
+	case 1:
+		deb_val = RTD_GPIO_DEBOUNCE_1US;
+		break;
+	case 10:
+		deb_val = RTD_GPIO_DEBOUNCE_10US;
+		break;
+	case 100:
+		deb_val = RTD_GPIO_DEBOUNCE_100US;
+		break;
+	case 1000:
+		deb_val = RTD_GPIO_DEBOUNCE_1MS;
+		break;
+	case 10000:
+		deb_val = RTD_GPIO_DEBOUNCE_10MS;
+		break;
+	case 20000:
+		deb_val = RTD_GPIO_DEBOUNCE_20MS;
+		break;
+	case 30000:
+		deb_val = RTD_GPIO_DEBOUNCE_30MS;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	if (data->info->type == RTD1295_ISO_GPIO) {
+		reg_offset = rtd_gpio_deb_offset(data, 0);
+		if (reg_offset < 0)
+			return reg_offset;
+		shift = 0;
+		deb_val += 1;
+		write_en = BIT(shift + 3);
+	} else if (data->info->type == RTD1295_MISC_GPIO) {
+		reg_offset = rtd_gpio_deb_offset(data, 0);
+		if (reg_offset < 0)
+			return reg_offset;
+		shift = (offset >> 4) * 4;
+		deb_val += 1;
+		write_en = BIT(shift + 3);
+	} else {
+		reg_offset = rtd_gpio_deb_offset(data, offset);
+		if (reg_offset < 0)
+			return reg_offset;
+		shift = (offset % 8) * 4;
+		write_en = BIT(shift + 3);
+	}
+	val = (deb_val << shift) | write_en;
+
+	spin_lock_irqsave(&data->lock, flags);
+	writel_relaxed(val, data->base + reg_offset);
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static int rtd_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
+				 unsigned long config)
+{
+	int debounce;
+
+	switch (pinconf_to_config_param(config)) {
+	case PIN_CONFIG_BIAS_DISABLE:
+	case PIN_CONFIG_BIAS_PULL_UP:
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		return gpiochip_generic_config(chip, offset, config);
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		debounce = pinconf_to_config_argument(config);
+		return rtd_gpio_set_debounce(chip, offset, debounce);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int rtd_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rtd_gpio *data = gpiochip_get_data(chip);
+	unsigned long flags;
+	int reg_offset;
+	u32 val;
+
+	reg_offset = rtd_gpio_dir_offset(data, offset);
+	if (reg_offset < 0)
+		return reg_offset;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	val = readl_relaxed(data->base + reg_offset);
+	val &= BIT(offset % 32);
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return val ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
+static int rtd_gpio_set_direction(struct gpio_chip *chip, unsigned int offset, bool out)
+{
+	struct rtd_gpio *data = gpiochip_get_data(chip);
+	u32 mask = BIT(offset % 32);
+	unsigned long flags;
+	int reg_offset;
+	u32 val;
+
+	reg_offset = rtd_gpio_dir_offset(data, offset);
+	if (reg_offset < 0)
+		return reg_offset;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	val = readl_relaxed(data->base + reg_offset);
+	if (out)
+		val |= mask;
+	else
+		val &= ~mask;
+	writel_relaxed(val, data->base + reg_offset);
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static int rtd_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	return rtd_gpio_set_direction(chip, offset, false);
+}
+
+static int rtd_gpio_direction_output(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	chip->set(chip, offset, value);
+
+	return rtd_gpio_set_direction(chip, offset, true);
+}
+
+static void rtd_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct rtd_gpio *data = gpiochip_get_data(chip);
+	u32 mask = BIT(offset % 32);
+	unsigned long flags;
+	int dato_reg_offset;
+	u32 val;
+
+	dato_reg_offset = rtd_gpio_dato_offset(data, offset);
+	if (dato_reg_offset < 0)
+		return;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	val = readl_relaxed(data->base + dato_reg_offset);
+	if (value)
+		val |= mask;
+	else
+		val &= ~mask;
+	writel_relaxed(val, data->base + dato_reg_offset);
+
+	spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static int rtd_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rtd_gpio *data = gpiochip_get_data(chip);
+	int dir_reg_offset, dat_reg_offset;
+	unsigned long flags;
+	u32 val;
+
+	dir_reg_offset = rtd_gpio_dir_offset(data, offset);
+	if (dir_reg_offset < 0)
+		return dir_reg_offset;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	val = readl_relaxed(data->base + dir_reg_offset);
+	val &= BIT(offset % 32);
+	dat_reg_offset = val ?
+			 rtd_gpio_dato_offset(data, offset) : rtd_gpio_dati_offset(data, offset);
+
+	val = readl_relaxed(data->base + dat_reg_offset);
+	val >>= offset % 32;
+	val &= 0x1;
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return val;
+}
+
+static bool rtd_gpio_check_ie(struct rtd_gpio *data, int irq)
+{
+	int mask = BIT(irq % 32);
+	int ie_reg_offset;
+	u32 enable;
+
+	ie_reg_offset = rtd_gpio_ie_offset(data, irq);
+	if (ie_reg_offset < 0)
+		return ie_reg_offset;
+	enable = readl_relaxed(data->base + ie_reg_offset);
+
+	return enable & mask;
+}
+
+static void rtd_gpio_irq_handle(struct irq_desc *desc)
+{
+	int (*get_reg_offset)(struct rtd_gpio *gpio, unsigned int offset);
+	struct rtd_gpio *data = irq_desc_get_handler_data(desc);
+	struct irq_domain *domain = data->gpio_chip.irq.domain;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int irq = irq_desc_get_irq(desc);
+	int reg_offset;
+	u32 status;
+	int hwirq;
+	int i;
+	int j;
+
+	chained_irq_enter(chip, desc);
+
+	if (irq == data->irqs[0])
+		get_reg_offset = &rtd_gpio_gpa_offset;
+	else if (irq == data->irqs[1])
+		get_reg_offset = &rtd_gpio_gpda_offset;
+
+	for (i = 0; i < data->info->num_gpios; i = i + 31) {
+		reg_offset = get_reg_offset(data, i);
+		if (reg_offset < 0)
+			return;
+
+		status = readl_relaxed(data->irq_base + reg_offset) >> 1;
+		writel_relaxed(status << 1, data->irq_base + reg_offset);
+
+		while (status) {
+			j = __ffs(status);
+			status &= ~BIT(j);
+			hwirq = i + j;
+			if (rtd_gpio_check_ie(data, hwirq)) {
+				int girq = irq_find_mapping(domain, hwirq);
+				u32 irq_type = irq_get_trigger_type(girq);
+
+				if ((irq == data->irqs[1]) && ((irq_type & IRQ_TYPE_SENSE_MASK) !=
+					IRQ_TYPE_EDGE_BOTH))
+					break;
+				generic_handle_irq(girq);
+			}
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void rtd_gpio_enable_irq(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct rtd_gpio *data = gpiochip_get_data(gc);
+	u32 clr_mask = BIT(d->hwirq % 31) << 1;
+	u32 ie_mask = BIT(d->hwirq % 32);
+	unsigned long flags;
+	int gpda_reg_offset;
+	int gpa_reg_offset;
+	int ie_reg_offset;
+	u32 val;
+
+	ie_reg_offset = rtd_gpio_ie_offset(data, d->hwirq);
+	if (ie_reg_offset < 0)
+		return;
+	gpa_reg_offset = rtd_gpio_gpa_offset(data, d->hwirq);
+	if (gpa_reg_offset < 0)
+		return;
+	gpda_reg_offset = rtd_gpio_gpda_offset(data, d->hwirq);
+	if (gpda_reg_offset < 0)
+		return;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	writel_relaxed(clr_mask, data->irq_base + gpa_reg_offset);
+	writel_relaxed(clr_mask, data->irq_base + gpda_reg_offset);
+
+	val = readl_relaxed(data->base + ie_reg_offset);
+	val |= ie_mask;
+	writel_relaxed(val, data->base + ie_reg_offset);
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+}
+
+static void rtd_gpio_disable_irq(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct rtd_gpio *data = gpiochip_get_data(gc);
+	u32 ie_mask = BIT(d->hwirq % 32);
+	unsigned long flags;
+	int ie_reg_offset;
+	u32 val;
+
+	ie_reg_offset = rtd_gpio_ie_offset(data, d->hwirq);
+	if (ie_reg_offset < 0)
+		return;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	val = readl_relaxed(data->base + ie_reg_offset);
+	val &= ~ie_mask;
+	writel_relaxed(val, data->base + ie_reg_offset);
+
+	spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static int rtd_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct rtd_gpio *data = gpiochip_get_data(gc);
+	u32 mask = BIT(d->hwirq % 32);
+	unsigned long flags;
+	int dp_reg_offset;
+	bool polarity;
+	u32 val;
+
+	dp_reg_offset = rtd_gpio_dp_offset(data, d->hwirq);
+	if (dp_reg_offset < 0)
+		return dp_reg_offset;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_RISING:
+		polarity = 1;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		polarity = 0;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		polarity = 1;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	val = readl_relaxed(data->base + dp_reg_offset);
+	if (polarity)
+		val |= mask;
+	else
+		val &= ~mask;
+	writel_relaxed(val, data->base + dp_reg_offset);
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static const struct irq_chip rtd_gpio_irq_chip = {
+	.name = "rtd-gpio",
+	.irq_enable = rtd_gpio_enable_irq,
+	.irq_disable = rtd_gpio_disable_irq,
+	.irq_set_type = rtd_gpio_irq_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+};
+
+static const struct of_device_id rtd_gpio_of_matches[] = {
+	{ .compatible = "realtek,rtd1295-misc-gpio", .data = &rtd1295_misc_gpio_info },
+	{ .compatible = "realtek,rtd1295-iso-gpio", .data = &rtd1295_iso_gpio_info },
+	{ .compatible = "realtek,rtd1395-iso-gpio", .data = &rtd1395_iso_gpio_info },
+	{ .compatible = "realtek,rtd1619-iso-gpio", .data = &rtd1619_iso_gpio_info },
+	{ .compatible = "realtek,rtd1319-iso-gpio", .data = &rtd_iso_gpio_info },
+	{ .compatible = "realtek,rtd1619b-iso-gpio", .data = &rtd_iso_gpio_info },
+	{ .compatible = "realtek,rtd1319d-iso-gpio", .data = &rtd_iso_gpio_info },
+	{ .compatible = "realtek,rtd1315e-iso-gpio", .data = &rtd_iso_gpio_info },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rtd_gpio_of_matches);
+
+static int rtd_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct gpio_irq_chip *irq_chip;
+	struct rtd_gpio *data;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->irqs[0] = platform_get_irq(pdev, 0);
+	if (data->irqs[0] < 0)
+		return data->irqs[0];
+
+	data->irqs[1] = platform_get_irq(pdev, 1);
+	if (data->irqs[1] < 0)
+		return data->irqs[1];
+
+	data->info = device_get_match_data(dev);
+	if (!data->info)
+		return -EINVAL;
+
+	spin_lock_init(&data->lock);
+
+	data->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->base))
+		return PTR_ERR(data->base);
+
+	data->irq_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(data->irq_base))
+		return PTR_ERR(data->irq_base);
+
+	data->gpio_chip.label = dev_name(&pdev->dev);
+	data->gpio_chip.base = -1;
+	data->gpio_chip.ngpio = data->info->num_gpios;
+	data->gpio_chip.request = gpiochip_generic_request;
+	data->gpio_chip.free = gpiochip_generic_free;
+	data->gpio_chip.get_direction = rtd_gpio_get_direction;
+	data->gpio_chip.direction_input = rtd_gpio_direction_input;
+	data->gpio_chip.direction_output = rtd_gpio_direction_output;
+	data->gpio_chip.set = rtd_gpio_set;
+	data->gpio_chip.get = rtd_gpio_get;
+	data->gpio_chip.set_config = rtd_gpio_set_config;
+	data->gpio_chip.fwnode = dev_fwnode(&pdev->dev);
+
+	irq_chip = &data->gpio_chip.irq;
+	irq_chip->handler = handle_simple_irq;
+	irq_chip->default_type = IRQ_TYPE_NONE;
+	irq_chip->parent_handler = rtd_gpio_irq_handle;
+	irq_chip->parent_handler_data = data;
+	irq_chip->num_parents = 2;
+	irq_chip->parents = data->irqs;
+
+	gpio_irq_chip_set_chip(irq_chip, &rtd_gpio_irq_chip);
+
+	return devm_gpiochip_add_data(&pdev->dev, &data->gpio_chip, data);
+}
+
+static struct platform_driver rtd_gpio_platform_driver = {
+	.driver = {
+		.name = "gpio-rtd",
+		.of_match_table = rtd_gpio_of_matches,
+	},
+	.probe = rtd_gpio_probe,
+};
+
+static int rtd_gpio_init(void)
+{
+	return platform_driver_register(&rtd_gpio_platform_driver);
+}
+
+subsys_initcall(rtd_gpio_init);
+
+static void __exit rtd_gpio_exit(void)
+{
+	platform_driver_unregister(&rtd_gpio_platform_driver);
+}
+module_exit(rtd_gpio_exit);
+
+MODULE_DESCRIPTION("Realtek DHC SoC gpio driver");
+MODULE_LICENSE("GPL v2");
-- 
2.43.0

