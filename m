Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FD67DDB4B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376754AbjKAC6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346237AbjKAC6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:58:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DF0F3;
        Tue, 31 Oct 2023 19:58:38 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A12wOnkD944736, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A12wOnkD944736
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 10:58:24 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 1 Nov 2023 10:58:25 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Nov 2023 10:58:22 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 1 Nov 2023 10:58:22 +0800
From:   Tzuyi Chang <tychang@realtek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, TY Chang <tychang@realtek.com>
Subject: [PATCH 1/2] gpio: realtek: Add GPIO support for RTD SoC variants
Date:   Wed, 1 Nov 2023 10:58:01 +0800
Message-ID: <20231101025802.3744-2-tychang@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101025802.3744-1-tychang@realtek.com>
References: <20231101025802.3744-1-tychang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS06.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: license violation
X-KSE-Antivirus-Attachment-Filter-Interceptor-Info: license violation
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds GPIO support for Realtek DHC RTD SoCs.

This driver enables configuration of GPIO direction, GPIO values, GPIO
debounce settings and handles GPIO interrupts.

Signed-off-by: Tzuyi Chang <tychang@realtek.com>
---
 drivers/gpio/Kconfig    |   8 +
 drivers/gpio/Makefile   |   1 +
 drivers/gpio/gpio-rtd.c | 702 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 711 insertions(+)
 create mode 100644 drivers/gpio/gpio-rtd.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 673bafb8be58..8d55c1ce8f3b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -553,6 +553,14 @@ config GPIO_ROCKCHIP
 	help
 	  Say yes here to support GPIO on Rockchip SoCs.
 
+config GPIO_RTD
+	tristate "Realtek DHC GPIO support"
+	depends on ARCH_REALTEK
+	default y
+	select GPIOLIB_IRQCHIP
+	help
+	  Say yes here to support GPIO on Realtek DHC SoCs.
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
index 000000000000..5fec261b602f
--- /dev/null
+++ b/drivers/gpio/gpio-rtd.c
@@ -0,0 +1,702 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Realtek DHC gpio driver
+ *
+ * Copyright (c) 2023 Realtek Semiconductor Corp.
+ */
+
+#include <linux/bitops.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
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
+ * @num_gpios: Number of GPIOs
+ * @dir_offset: Offset for GPIO direction registers
+ * @dato_offset: Offset for GPIO data output registers
+ * @dati_offset: Offset for GPIO data input registers
+ * @ie_offset: Offset for GPIO interrupt enable registers
+ * @dp_offset: Offset for GPIO detection polarity registers
+ * @gpa_offset: Offset for GPIO assert interrupt status registers
+ * @gpda_offset: Offset for GPIO deassert interrupt status registers
+ * @deb_offset: Offset for GPIO debounce registers
+ */
+struct rtd_gpio_info {
+	const char *name;
+	enum rtd_gpio_type type;
+	unsigned int gpio_base;
+	unsigned int num_gpios;
+	unsigned int *dir_offset;
+	unsigned int *dato_offset;
+	unsigned int *dati_offset;
+	unsigned int *ie_offset;
+	unsigned int *dp_offset;
+	unsigned int *gpa_offset;
+	unsigned int *gpda_offset;
+	unsigned int *deb_offset;
+};
+
+struct rtd_gpio {
+	struct platform_device *pdev;
+	const struct rtd_gpio_info *info;
+	void __iomem *base;
+	void __iomem *irq_base;
+	struct gpio_chip gpio_chip;
+	struct irq_chip	irq_chip;
+	int assert_irq;
+	int deassert_irq;
+	struct irq_domain *domain;
+	spinlock_t lock;
+};
+
+
+static const struct rtd_gpio_info rtd_iso_gpio_info = {
+	.name = "rtd_iso_gpio",
+	.type = RTD_ISO_GPIO,
+	.gpio_base = 0,
+	.num_gpios = 82,
+	.dir_offset  = (unsigned int []){ 0x0, 0x18, 0x2c },
+	.dato_offset = (unsigned int []){ 0x4, 0x1c, 0x30 },
+	.dati_offset = (unsigned int []){ 0x8, 0x20, 0x34 },
+	.ie_offset = (unsigned int []){ 0xc, 0x24, 0x38 },
+	.dp_offset = (unsigned int []){ 0x10, 0x28, 0x3c },
+	.gpa_offset = (unsigned int []){ 0x8, 0xe0, 0x90 },
+	.gpda_offset = (unsigned int []){ 0xc, 0xe4, 0x94 },
+	.deb_offset = (unsigned int []){ 0x44, 0x48, 0x4c, 0x50, 0x54, 0x58, 0x5c,
+					 0x60, 0x64, 0x68, 0x6c },
+};
+
+static const struct rtd_gpio_info rtd1619_iso_gpio_info = {
+	.name = "rtd1619_iso_gpio",
+	.type = RTD1619_ISO_GPIO,
+	.gpio_base = 0,
+	.num_gpios = 86,
+	.dir_offset  = (unsigned int []){ 0x0, 0x18, 0x2c },
+	.dato_offset = (unsigned int []){ 0x4, 0x1c, 0x30 },
+	.dati_offset = (unsigned int []){ 0x8, 0x20, 0x34 },
+	.ie_offset = (unsigned int []){ 0xc, 0x24, 0x38 },
+	.dp_offset = (unsigned int []){ 0x10, 0x28, 0x3c },
+	.gpa_offset = (unsigned int []){ 0x8, 0xe0, 0x90 },
+	.gpda_offset = (unsigned int []){ 0xc, 0xe4, 0x94 },
+	.deb_offset = (unsigned int []){ 0x44, 0x48, 0x4c, 0x50, 0x54, 0x58, 0x5c,
+					 0x60, 0x64, 0x68, 0x6c },
+};
+
+static const struct rtd_gpio_info rtd1395_iso_gpio_info = {
+	.name = "rtd1395_iso_gpio",
+	.type = RTD1395_ISO_GPIO,
+	.gpio_base = 0,
+	.num_gpios = 57,
+	.dir_offset  = (unsigned int []){ 0x0, 0x18 },
+	.dato_offset = (unsigned int []){ 0x4, 0x1c },
+	.dati_offset = (unsigned int []){ 0x8, 0x20 },
+	.ie_offset = (unsigned int []){ 0xc, 0x24 },
+	.dp_offset = (unsigned int []){ 0x10, 0x28 },
+	.gpa_offset = (unsigned int []){ 0x8, 0xe0 },
+	.gpda_offset = (unsigned int []){ 0xc, 0xe4 },
+	.deb_offset = (unsigned int []){ 0x30, 0x34, 0x38, 0x3c, 0x40, 0x44, 0x48, 0x4c },
+};
+
+static const struct rtd_gpio_info rtd1295_misc_gpio_info = {
+	.name = "rtd1295_misc_gpio",
+	.type = RTD1295_ISO_GPIO,
+	.gpio_base = 0,
+	.num_gpios = 101,
+	.dir_offset  = (unsigned int []){ 0x0, 0x4, 0x8, 0xc },
+	.dato_offset = (unsigned int []){ 0x10, 0x14, 0x18, 0x1c },
+	.dati_offset = (unsigned int []){ 0x20, 0x24, 0x28, 0x2c },
+	.ie_offset = (unsigned int []){ 0x30, 0x34, 0x38, 0x3c },
+	.dp_offset = (unsigned int []){ 0x40, 0x44, 0x48, 0x4c },
+	.gpa_offset = (unsigned int []){ 0x40, 0x44, 0xa4, 0xb8 },
+	.gpda_offset = (unsigned int []){ 0x54, 0x58, 0xa8, 0xbc},
+	.deb_offset = (unsigned int []){ 0x50 },
+};
+
+static const struct rtd_gpio_info rtd1295_iso_gpio_info = {
+	.name = "rtd1295_iso_gpio",
+	.type = RTD1295_ISO_GPIO,
+	.gpio_base = 101,
+	.num_gpios = 35,
+	.dir_offset  = (unsigned int []){ 0x0, 0x18 },
+	.dato_offset = (unsigned int []){ 0x4, 0x1c },
+	.dati_offset = (unsigned int []){ 0x8, 0x20 },
+	.ie_offset = (unsigned int []){ 0xc, 0x24 },
+	.dp_offset = (unsigned int []){ 0x10, 0x28 },
+	.gpa_offset = (unsigned int []){ 0x8, 0xe0 },
+	.gpda_offset = (unsigned int []){ 0xc, 0xe4 },
+	.deb_offset = (unsigned int []){ 0x14 },
+};
+
+static unsigned int rtd_gpio_dir_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	return data->info->dir_offset[offset / 32];
+}
+
+static unsigned int rtd_gpio_dato_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	return data->info->dato_offset[offset / 32];
+}
+
+static unsigned int rtd_gpio_dati_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	return data->info->dati_offset[offset / 32];
+}
+
+static unsigned int rtd_gpio_ie_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	return data->info->ie_offset[offset / 32];
+}
+
+static unsigned int rtd_gpio_dp_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	return data->info->dp_offset[offset / 32];
+}
+
+static unsigned int rtd_gpio_gpa_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	return data->info->gpa_offset[offset / 31];
+}
+
+static unsigned int rtd_gpio_gpda_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	return data->info->gpda_offset[offset / 31];
+}
+
+static unsigned int rtd_gpio_deb_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	return data->info->deb_offset[offset / 8];
+}
+
+static unsigned int rtd1295_gpio_deb_offset(struct rtd_gpio *data, unsigned int offset)
+{
+	return data->info->deb_offset[0];
+}
+
+static int rtd_gpio_set_debounce(struct gpio_chip *chip, unsigned int offset,
+				   unsigned int debounce)
+{
+	struct rtd_gpio *data = gpiochip_get_data(chip);
+	unsigned long flags;
+	unsigned int reg_offset;
+	unsigned int shift;
+	unsigned int write_en;
+	u32 val;
+	u32 deb_val;
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
+		shift = 0;
+		deb_val += 1;
+		write_en = BIT(shift + 3);
+		reg_offset = rtd1295_gpio_deb_offset(data, offset);
+	} else if (data->info->type == RTD1295_MISC_GPIO) {
+		shift = (offset >> 4) * 4;
+		deb_val += 1;
+		write_en = BIT(shift + 3);
+		reg_offset = rtd1295_gpio_deb_offset(data, offset);
+	} else {
+		shift = (offset % 8) * 4;
+		write_en = BIT(shift + 3);
+		reg_offset = rtd_gpio_deb_offset(data, offset);
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
+		return pinctrl_gpio_set_config(chip->base + offset, config);
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		debounce = pinconf_to_config_argument(config);
+		return rtd_gpio_set_debounce(chip, offset, debounce);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int rtd_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	return pinctrl_gpio_request(chip->base + offset);
+}
+
+static void rtd_gpio_free(struct gpio_chip *chip, unsigned int offset)
+{
+	pinctrl_gpio_free(chip->base + offset);
+}
+
+static int rtd_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rtd_gpio *data = gpiochip_get_data(chip);
+	unsigned long flags;
+	unsigned int reg_offset;
+	u32 val;
+
+	reg_offset = rtd_gpio_dir_offset(data, offset);
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
+	unsigned long flags;
+	unsigned int reg_offset;
+	u32 mask = BIT(offset % 32);
+	u32 val;
+
+	reg_offset = rtd_gpio_dir_offset(data, offset);
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
+	unsigned long flags;
+	unsigned int dato_reg_offset;
+	u32 mask = BIT(offset % 32);
+	u32 val;
+
+	dato_reg_offset = rtd_gpio_dato_offset(data, offset);
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
+	unsigned long flags;
+	unsigned int dir_reg_offset, dat_reg_offset;
+	u32 val;
+
+	dir_reg_offset = rtd_gpio_dir_offset(data, offset);
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	val = readl_relaxed(data->base + dir_reg_offset);
+	val &= BIT(offset % 32);
+	dat_reg_offset = (val) ? rtd_gpio_dato_offset(data, offset) : rtd_gpio_dati_offset(data, offset);
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
+
+static int rtd_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rtd_gpio *data = gpiochip_get_data(chip);
+	u32 irq = 0;
+
+	irq = irq_find_mapping(data->domain, offset);
+	if (!irq) {
+		dev_err(&data->pdev->dev, "%s: can not find irq number for hwirq= %d\n",
+			__func__, offset);
+		return -EINVAL;
+	}
+	return irq;
+}
+
+static bool rtd_gpio_check_ie(struct rtd_gpio *data, int irq)
+{
+	unsigned int ie_reg_offset;
+	u32 enable;
+	int mask = BIT(irq % 32);
+
+	ie_reg_offset = rtd_gpio_ie_offset(data, irq);
+	enable = readl_relaxed(data->base + ie_reg_offset);
+
+	return enable & mask;
+}
+
+static void rtd_gpio_assert_irq_handle(struct irq_desc *desc)
+{
+	struct rtd_gpio *data = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int gpa_reg_offset;
+	u32 status;
+	int hwirq;
+	int i;
+	int j;
+
+	chained_irq_enter(chip, desc);
+
+	for (i = 0; i < data->info->num_gpios; i = i + 31) {
+		gpa_reg_offset = rtd_gpio_gpa_offset(data, i);
+		status = readl_relaxed(data->irq_base + gpa_reg_offset) >> 1;
+		writel_relaxed(status << 1, data->irq_base + gpa_reg_offset);
+
+		while (status) {
+			j = __ffs(status);
+			status &= ~BIT(j);
+			hwirq = i + j;
+			if (rtd_gpio_check_ie(data, hwirq)) {
+				int irq = irq_find_mapping(data->domain, hwirq);
+
+				generic_handle_irq(irq);
+			}
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void rtd_gpio_deassert_irq_handle(struct irq_desc *desc)
+{
+	struct rtd_gpio *data = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int gpda_reg_offset;
+	u32 status;
+	int hwirq;
+	int i;
+	int j;
+
+	chained_irq_enter(chip, desc);
+
+	for (i = 0; i < data->info->num_gpios; i = i + 31) {
+		gpda_reg_offset = rtd_gpio_gpda_offset(data, i);
+		status = readl_relaxed(data->irq_base + gpda_reg_offset) >> 1;
+		writel_relaxed(status << 1, data->irq_base + gpda_reg_offset);
+
+		while (status) {
+			j = __ffs(status);
+			status &= ~BIT(j);
+			hwirq = i + j;
+			if (rtd_gpio_check_ie(data, hwirq)) {
+				int irq = irq_find_mapping(data->domain, hwirq);
+				u32 irq_type = irq_get_trigger_type(irq);
+
+				if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
+					generic_handle_irq(irq);
+			}
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void rtd_gpio_enable_irq(struct irq_data *d)
+{
+	struct rtd_gpio *data = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	unsigned int ie_reg_offset;
+	unsigned int gpa_reg_offset;
+	unsigned int gpda_reg_offset;
+	u32 ie_mask = BIT(d->hwirq % 32);
+	u32 clr_mask = BIT(d->hwirq % 31) << 1;
+	u32 val;
+
+	ie_reg_offset = rtd_gpio_ie_offset(data, d->hwirq);
+	gpa_reg_offset = rtd_gpio_gpa_offset(data, d->hwirq);
+	gpda_reg_offset = rtd_gpio_gpda_offset(data, d->hwirq);
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
+	struct rtd_gpio *data = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	unsigned int ie_reg_offset;
+	u32 ie_mask = BIT(d->hwirq % 32);
+	u32 val;
+
+	ie_reg_offset = rtd_gpio_ie_offset(data, d->hwirq);
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
+
+static int rtd_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct rtd_gpio *data = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	unsigned int dp_reg_offset;
+	u32 mask = BIT(d->hwirq % 32);
+	u32 val;
+	bool polarity;
+
+	dp_reg_offset = rtd_gpio_dp_offset(data, d->hwirq);
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
+
+static const struct irq_chip rtd_gpio_irq_chip = {
+	.irq_enable = rtd_gpio_enable_irq,
+	.irq_disable = rtd_gpio_disable_irq,
+	.irq_set_type = rtd_gpio_irq_set_type,
+};
+
+static const struct of_device_id rtd_gpio_of_matches[] = {
+	{ .compatible = "realtek,rtd-gpio", .data = &rtd_iso_gpio_info },
+	{ .compatible = "realtek,rtd1295-misc-gpio", .data = &rtd1295_misc_gpio_info },
+	{ .compatible = "realtek,rtd1295-iso-gpio", .data = &rtd1295_iso_gpio_info },
+	{ .compatible = "realtek,rtd1395-iso-gpio", .data = &rtd1395_iso_gpio_info },
+	{ .compatible = "realtek,rtd1619-iso-gpio", .data = &rtd1619_iso_gpio_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rtd_gpio_of_matches);
+
+static int rtd_gpio_probe(struct platform_device *pdev)
+{
+	struct rtd_gpio *data;
+	const struct of_device_id *match;
+	struct device_node *node;
+	int ret;
+	int i;
+
+	node = pdev->dev.of_node;
+	match = of_match_node(rtd_gpio_of_matches, pdev->dev.of_node);
+	if (!match || !match->data)
+		return -EINVAL;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->assert_irq = irq_of_parse_and_map(node, 0);
+	if (!data->assert_irq)
+		goto deferred;
+
+	data->deassert_irq = irq_of_parse_and_map(node, 1);
+	if (!data->deassert_irq)
+		goto deferred;
+
+	data->info = match->data;
+	spin_lock_init(&data->lock);
+
+	data->base = of_iomap(node, 0);
+	if (!data->base)
+		return -ENXIO;
+
+	data->irq_base = of_iomap(node, 1);
+	if (!data->irq_base)
+		return -ENXIO;
+
+	data->gpio_chip.parent = &pdev->dev;
+	data->gpio_chip.label = dev_name(&pdev->dev);
+	data->gpio_chip.of_gpio_n_cells = 2;
+	data->gpio_chip.base = data->info->gpio_base;
+	data->gpio_chip.ngpio = data->info->num_gpios;
+	data->gpio_chip.request = rtd_gpio_request;
+	data->gpio_chip.free = rtd_gpio_free;
+	data->gpio_chip.get_direction = rtd_gpio_get_direction;
+	data->gpio_chip.direction_input = rtd_gpio_direction_input;
+	data->gpio_chip.direction_output = rtd_gpio_direction_output;
+	data->gpio_chip.set = rtd_gpio_set;
+	data->gpio_chip.get = rtd_gpio_get;
+	data->gpio_chip.set_config = rtd_gpio_set_config;
+	data->gpio_chip.to_irq = rtd_gpio_to_irq;
+	data->irq_chip = rtd_gpio_irq_chip;
+	data->irq_chip.name = data->info->name;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &data->gpio_chip, data);
+	if (ret) {
+		dev_err(&pdev->dev, "Adding GPIO chip failed (%d)\n", ret);
+		return ret;
+	}
+
+	data->domain = irq_domain_add_linear(node, data->gpio_chip.ngpio,
+				&irq_domain_simple_ops, data);
+	if (!data->domain) {
+		devm_kfree(&pdev->dev, data);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < data->gpio_chip.ngpio; i++) {
+		int irq = irq_create_mapping(data->domain, i);
+
+		irq_set_chip_data(irq, data);
+		irq_set_chip_and_handler(irq, &data->irq_chip, handle_simple_irq);
+	}
+
+	irq_set_chained_handler_and_data(data->assert_irq, rtd_gpio_assert_irq_handle, data);
+	irq_set_chained_handler_and_data(data->deassert_irq, rtd_gpio_deassert_irq_handle, data);
+
+	dev_dbg(&pdev->dev, "probed\n");
+
+	return 0;
+
+deferred:
+	devm_kfree(&pdev->dev, data);
+	return -EPROBE_DEFER;
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
2.42.0

