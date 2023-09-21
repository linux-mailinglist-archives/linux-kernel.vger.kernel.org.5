Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEAE7A90B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 03:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjIUBxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 21:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjIUBxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 21:53:13 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E6A9B7;
        Wed, 20 Sep 2023 18:53:05 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8BxNugAogtldnEqAA--.27948S3;
        Thu, 21 Sep 2023 09:53:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxndzwoQtlCvsMAA--.26254S4;
        Thu, 21 Sep 2023 09:53:02 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v6 2/2] gpio: loongson: add more gpio chip support
Date:   Thu, 21 Sep 2023 09:52:47 +0800
Message-Id: <20230921015247.23478-3-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230921015247.23478-1-zhuyinbo@loongson.cn>
References: <20230921015247.23478-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxndzwoQtlCvsMAA--.26254S4
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was to add loongson 2k0500, 2k2000 and 3a5000 gpio chip
driver support and define inten_offset attibute to enable gpio chip
interrupt.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-loongson-64bit.c | 119 ++++++++++++++++++++++++++---
 1 file changed, 110 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-loongson-64bit.c b/drivers/gpio/gpio-loongson-64bit.c
index 06213bbfabdd..6749d4dd6d64 100644
--- a/drivers/gpio/gpio-loongson-64bit.c
+++ b/drivers/gpio/gpio-loongson-64bit.c
@@ -26,6 +26,7 @@ struct loongson_gpio_chip_data {
 	unsigned int		conf_offset;
 	unsigned int		out_offset;
 	unsigned int		in_offset;
+	unsigned int		inten_offset;
 };
 
 struct loongson_gpio_chip {
@@ -117,19 +118,29 @@ static void loongson_gpio_set(struct gpio_chip *chip, unsigned int pin, int valu
 
 static int loongson_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
 {
+	unsigned int u;
 	struct platform_device *pdev = to_platform_device(chip->parent);
+	struct loongson_gpio_chip *lgpio = to_loongson_gpio_chip(chip);
+
+	if (lgpio->chip_data->mode == BIT_CTRL_MODE) {
+		/* Get the register index from offset then multiply by bytes per register */
+		u = readl(lgpio->reg_base + lgpio->chip_data->inten_offset + (offset / 32) * 4);
+		u |= BIT(offset % 32);
+		writel(u, lgpio->reg_base + lgpio->chip_data->inten_offset + (offset / 32) * 4);
+	} else {
+		writeb(1, lgpio->reg_base + lgpio->chip_data->inten_offset + offset);
+	}
 
 	return platform_get_irq(pdev, offset);
 }
 
 static int loongson_gpio_init(struct device *dev, struct loongson_gpio_chip *lgpio,
-			      struct device_node *np, void __iomem *reg_base)
+			      void __iomem *reg_base)
 {
 	int ret;
 	u32 ngpios;
 
 	lgpio->reg_base = reg_base;
-
 	if (lgpio->chip_data->mode == BIT_CTRL_MODE) {
 		ret = bgpio_init(&lgpio->chip, dev, 8,
 				lgpio->reg_base + lgpio->chip_data->in_offset,
@@ -148,15 +159,15 @@ static int loongson_gpio_init(struct device *dev, struct loongson_gpio_chip *lgp
 		lgpio->chip.direction_output = loongson_gpio_direction_output;
 		lgpio->chip.set = loongson_gpio_set;
 		lgpio->chip.parent = dev;
+		device_property_read_u32(dev, "ngpios", &ngpios);
+		lgpio->chip.ngpio = ngpios;
 		spin_lock_init(&lgpio->lock);
 	}
 
-	device_property_read_u32(dev, "ngpios", &ngpios);
-
-	lgpio->chip.can_sleep = 0;
-	lgpio->chip.ngpio = ngpios;
 	lgpio->chip.label = lgpio->chip_data->label;
-	lgpio->chip.to_irq = loongson_gpio_to_irq;
+	lgpio->chip.can_sleep = false;
+	if (lgpio->chip_data->inten_offset)
+		lgpio->chip.to_irq = loongson_gpio_to_irq;
 
 	return devm_gpiochip_add_data(dev, &lgpio->chip, lgpio);
 }
@@ -165,7 +176,6 @@ static int loongson_gpio_probe(struct platform_device *pdev)
 {
 	void __iomem *reg_base;
 	struct loongson_gpio_chip *lgpio;
-	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 
 	lgpio = devm_kzalloc(dev, sizeof(*lgpio), GFP_KERNEL);
@@ -178,7 +188,7 @@ static int loongson_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
 
-	return loongson_gpio_init(dev, lgpio, np, reg_base);
+	return loongson_gpio_init(dev, lgpio, reg_base);
 }
 
 static const struct loongson_gpio_chip_data loongson_gpio_ls2k_data = {
@@ -187,6 +197,57 @@ static const struct loongson_gpio_chip_data loongson_gpio_ls2k_data = {
 	.conf_offset = 0x0,
 	.in_offset = 0x20,
 	.out_offset = 0x10,
+	.inten_offset = 0x30,
+};
+
+static const struct loongson_gpio_chip_data loongson_gpio_ls2k0500_data0 = {
+	.label = "ls2k0500_gpio",
+	.mode = BIT_CTRL_MODE,
+	.conf_offset = 0x0,
+	.in_offset = 0x8,
+	.out_offset = 0x10,
+	.inten_offset = 0xb0,
+};
+
+static const struct loongson_gpio_chip_data loongson_gpio_ls2k0500_data1 = {
+	.label = "ls2k0500_gpio",
+	.mode = BIT_CTRL_MODE,
+	.conf_offset = 0x0,
+	.in_offset = 0x8,
+	.out_offset = 0x10,
+	.inten_offset = 0x98,
+};
+
+static const struct loongson_gpio_chip_data loongson_gpio_ls2k2000_data0 = {
+	.label = "ls2k2000_gpio",
+	.mode = BIT_CTRL_MODE,
+	.conf_offset = 0x0,
+	.in_offset = 0xc,
+	.out_offset = 0x8,
+};
+
+static const struct loongson_gpio_chip_data loongson_gpio_ls2k2000_data1 = {
+	.label = "ls2k2000_gpio",
+	.mode = BIT_CTRL_MODE,
+	.conf_offset = 0x0,
+	.in_offset = 0x20,
+	.out_offset = 0x10,
+};
+
+static const struct loongson_gpio_chip_data loongson_gpio_ls2k2000_data2 = {
+	.label = "ls2k2000_gpio",
+	.mode = BIT_CTRL_MODE,
+	.conf_offset = 0x84,
+	.in_offset = 0x88,
+	.out_offset = 0x80,
+};
+
+static const struct loongson_gpio_chip_data loongson_gpio_ls3a5000_data = {
+	.label = "ls3a5000_gpio",
+	.mode = BIT_CTRL_MODE,
+	.conf_offset = 0x0,
+	.in_offset = 0xc,
+	.out_offset = 0x8,
 };
 
 static const struct loongson_gpio_chip_data loongson_gpio_ls7a_data = {
@@ -202,6 +263,30 @@ static const struct of_device_id loongson_gpio_of_match[] = {
 		.compatible = "loongson,ls2k-gpio",
 		.data = &loongson_gpio_ls2k_data,
 	},
+	{
+		.compatible = "loongson,ls2k0500-gpio0",
+		.data = &loongson_gpio_ls2k0500_data0,
+	},
+	{
+		.compatible = "loongson,ls2k0500-gpio1",
+		.data = &loongson_gpio_ls2k0500_data1,
+	},
+	{
+		.compatible = "loongson,ls2k2000-gpio0",
+		.data = &loongson_gpio_ls2k2000_data0,
+	},
+	{
+		.compatible = "loongson,ls2k2000-gpio1",
+		.data = &loongson_gpio_ls2k2000_data1,
+	},
+	{
+		.compatible = "loongson,ls2k2000-gpio2",
+		.data = &loongson_gpio_ls2k2000_data2,
+	},
+	{
+		.compatible = "loongson,ls3a5000-gpio",
+		.data = &loongson_gpio_ls3a5000_data,
+	},
 	{
 		.compatible = "loongson,ls7a-gpio",
 		.data = &loongson_gpio_ls7a_data,
@@ -215,6 +300,22 @@ static const struct acpi_device_id loongson_gpio_acpi_match[] = {
 		.id = "LOON0002",
 		.driver_data = (kernel_ulong_t)&loongson_gpio_ls7a_data,
 	},
+	{
+		.id = "LOON0007",
+		.driver_data = (kernel_ulong_t)&loongson_gpio_ls3a5000_data,
+	},
+	{
+		.id = "LOON000A",
+		.driver_data = (kernel_ulong_t)&loongson_gpio_ls2k2000_data0,
+	},
+	{
+		.id = "LOON000B",
+		.driver_data = (kernel_ulong_t)&loongson_gpio_ls2k2000_data1,
+	},
+	{
+		.id = "LOON000C",
+		.driver_data = (kernel_ulong_t)&loongson_gpio_ls2k2000_data2,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, loongson_gpio_acpi_match);
-- 
2.20.1

