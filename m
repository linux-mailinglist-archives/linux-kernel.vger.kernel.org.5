Return-Path: <linux-kernel+bounces-151147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A21E8AA9C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36F6282633
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B644F214;
	Fri, 19 Apr 2024 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Grj7QlqN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150947F6C;
	Fri, 19 Apr 2024 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514025; cv=none; b=IuZs0OMM9pkSypAFTar6seoz29EkbyIuwT2qwj1ZxyL9j7kozP2N+DvukF92Jjfxoobp23mv1ZUbZpz+vC6DiwhqR3xrpDUIRbx6yZs3Br1em6B+h4y6Q0wbyjeHJvS4rEYR0lYOD8361u7kB5zcHzCsLbrgIckKTQdYFr8utQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514025; c=relaxed/simple;
	bh=aSuBEZZSH8hrgCN+8fbEtoJw/zuPGaLEQ0sC4w8cSqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VeNyqC9dKIQJRIxYQbXheiTS2cWnVRIagGyalWJlI3iBe+aWmsb7Gi/I3Ae1aYxTABg7UEj15jiRpxjVb15xkdAAL8gbiicI/wnrE8x3C/o9+7zXWVp4sjFtCMCGHru8ELJQM95cPRkf7ASWJDAHN5LA5l9ekPY9XZUzzJi2yic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Grj7QlqN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713514023; x=1745050023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aSuBEZZSH8hrgCN+8fbEtoJw/zuPGaLEQ0sC4w8cSqk=;
  b=Grj7QlqNuhSc98sd699q9fDfn2A/Vm4hNXehM3PiS9GVF/MI9fLP4i/k
   EI2h95xl652szfq1C09xSBwHUklCy77G4RMDbe+Vbm3Sszktupi0RUFV5
   ZijrfQFpCdky0ySA1zps9m1DnKPyNP1ZyOkzqvB0ZyzfsLpb2Hl3B3CH/
   +xesOfp4xvS5HojvzNFukr7czSuQNoa9lKHQnTYGC3D1q7BOBjmOcsZv+
   spi/X8QYN8VbVV8sE07iNyFsCoTJE0TVvU5KqniO/mu7Rmc3FGHwEdOzS
   b3Zr0T3ereCNqkQDUjKIbIPKQUBUpmXLtjXxgZ4KRDdaKeWRSvP9IpXkb
   g==;
X-CSE-ConnectionGUID: fRKhoN+WRC+pBw3JigdbnA==
X-CSE-MsgGUID: wkwqx4jQSxWOsk0J3T0WQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="31587165"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="31587165"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 01:07:03 -0700
X-CSE-ConnectionGUID: 99iYCZYKRLu/bYUeuw0Vew==
X-CSE-MsgGUID: j/3AnJ7TRJq2Aq3OAqgORw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23319631"
Received: from mpkangas-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.63.92])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 01:07:00 -0700
From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Aapo Vienamo <aapo.vienamo@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
Date: Fri, 19 Apr 2024 11:05:55 +0300
Message-ID: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver provides a basic GPIO driver for the Intel Granite Rapids-D
virtual GPIOs. On SoCs with limited physical pins on the package, the
physical pins controlled by this driver would be exposed on an external
device such as a BMC or CPLD.

Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                       |   1 +
 drivers/gpio/Kconfig              |  16 ++
 drivers/gpio/Makefile             |   1 +
 drivers/gpio/gpio-graniterapids.c | 382 ++++++++++++++++++++++++++++++
 4 files changed, 400 insertions(+)
 create mode 100644 drivers/gpio/gpio-graniterapids.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c5760f4484f..cd97f6fcc3c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10995,6 +10995,7 @@ L:	linux-gpio@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git
 F:	drivers/gpio/gpio-elkhartlake.c
+F:	drivers/gpio/gpio-graniterapids.c
 F:	drivers/gpio/gpio-ich.c
 F:	drivers/gpio/gpio-merrifield.c
 F:	drivers/gpio/gpio-ml-ioh.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 00b5c007a2bb..1796eaed34ee 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -321,6 +321,22 @@ config GPIO_GENERIC_PLATFORM
 	help
 	  Say yes here to support basic platform_device memory-mapped GPIO controllers.
 
+config GPIO_GRANITERAPIDS
+	tristate "Intel Granite Rapids-D vGPIO support"
+	depends on X86 || COMPILE_TEST
+	select GPIOLIB_IRQCHIP
+	help
+	  Select this to enable GPIO support on platforms with the following
+	  SoCs:
+
+	  - Intel Granite Rapids-D
+
+	  The driver enables basic GPIO functionality and implements interrupt
+	  support.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gpio-graniterapids.
+
 config GPIO_GRGPIO
 	tristate "Aeroflex Gaisler GRGPIO support"
 	depends on OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index fdd28c58d890..e2a53013780e 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_GPIO_FTGPIO010)		+= gpio-ftgpio010.o
 obj-$(CONFIG_GPIO_FXL6408)		+= gpio-fxl6408.o
 obj-$(CONFIG_GPIO_GE_FPGA)		+= gpio-ge.o
 obj-$(CONFIG_GPIO_GPIO_MM)		+= gpio-gpio-mm.o
+obj-$(CONFIG_GPIO_GRANITERAPIDS)	+= gpio-graniterapids.o
 obj-$(CONFIG_GPIO_GRGPIO)		+= gpio-grgpio.o
 obj-$(CONFIG_GPIO_GW_PLD)		+= gpio-gw-pld.o
 obj-$(CONFIG_GPIO_HISI)                 += gpio-hisi.o
diff --git a/drivers/gpio/gpio-graniterapids.c b/drivers/gpio/gpio-graniterapids.c
new file mode 100644
index 000000000000..61bcafe1985e
--- /dev/null
+++ b/drivers/gpio/gpio-graniterapids.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Granite Rapids-D vGPIO driver
+ *
+ * Copyright (c) 2024, Intel Corporation.
+ *
+ * Author: Aapo Vienamo <aapo.vienamo@linux.intel.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitmap.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gfp_types.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <linux/gpio/driver.h>
+
+#define GNR_NUM_PINS 128
+#define GNR_PINS_PER_REG 32
+#define GNR_NUM_REGS DIV_ROUND_UP(GNR_NUM_PINS, GNR_PINS_PER_REG)
+
+#define GNR_CFG_BAR		0x00
+#define GNR_CFG_LOCK_OFFSET	0x04
+#define GNR_GPI_STATUS_OFFSET	0x20
+#define GNR_GPI_ENABLE_OFFSET	0x24
+
+#define GNR_CFG_DW_RX_MASK	(3 << 22)
+#define GNR_CFG_DW_RX_DISABLE	(2 << 22)
+#define GNR_CFG_DW_RX_EDGE	(1 << 22)
+#define GNR_CFG_DW_RX_LEVEL	(0 << 22)
+#define GNR_CFG_DW_RXDIS	BIT(4)
+#define GNR_CFG_DW_TXDIS	BIT(3)
+#define GNR_CFG_DW_RXSTATE	BIT(1)
+#define GNR_CFG_DW_TXSTATE	BIT(0)
+
+/**
+ * struct gnr_gpio - Intel Granite Rapids-D vGPIO driver state
+ * @gc: GPIO controller interface
+ * @reg_base: base address of the GPIO registers
+ * @ro_bitmap: bitmap of read-only pins
+ * @lock: guard the registers
+ * @pad_backup: backup of the register state for suspend
+ */
+struct gnr_gpio {
+	struct gpio_chip gc;
+	void __iomem *reg_base;
+	DECLARE_BITMAP(ro_bitmap, GNR_NUM_PINS);
+	raw_spinlock_t lock;
+	u32 pad_backup[];
+};
+
+static void __iomem *gnr_gpio_get_padcfg_addr(const struct gnr_gpio *priv,
+					      unsigned int gpio)
+{
+	return priv->reg_base + gpio * sizeof(u32);
+}
+
+static int gnr_gpio_configure_pad(struct gpio_chip *gc, unsigned int gpio,
+				  u32 clear_mask, u32 set_mask)
+{
+	struct gnr_gpio *priv = gpiochip_get_data(gc);
+	void __iomem *addr = gnr_gpio_get_padcfg_addr(priv, gpio);
+	u32 dw;
+
+	if (test_bit(gpio, priv->ro_bitmap))
+		return -EACCES;
+
+	guard(raw_spinlock_irqsave)(&priv->lock);
+
+	dw = readl(addr);
+	dw &= ~clear_mask;
+	dw |= set_mask;
+	writel(dw, addr);
+
+	return 0;
+}
+
+static int gnr_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	const struct gnr_gpio *priv = gpiochip_get_data(gc);
+	u32 dw;
+
+	dw = readl(gnr_gpio_get_padcfg_addr(priv, gpio));
+
+	return !!(dw & GNR_CFG_DW_RXSTATE);
+}
+
+static void gnr_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	u32 clear = 0;
+	u32 set = 0;
+
+	if (value)
+		set = GNR_CFG_DW_TXSTATE;
+	else
+		clear = GNR_CFG_DW_TXSTATE;
+
+	gnr_gpio_configure_pad(gc, gpio, clear, set);
+}
+
+static int gnr_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct gnr_gpio *priv = gpiochip_get_data(gc);
+	u32 dw;
+
+	dw = readl(gnr_gpio_get_padcfg_addr(priv, gpio));
+
+	if (dw & GNR_CFG_DW_TXDIS)
+		return GPIO_LINE_DIRECTION_IN;
+
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int gnr_gpio_direction_input(struct gpio_chip *gc, unsigned int gpio)
+{
+	return gnr_gpio_configure_pad(gc, gpio, GNR_CFG_DW_RXDIS, 0);
+}
+
+static int gnr_gpio_direction_output(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	u32 clear = GNR_CFG_DW_TXDIS;
+	u32 set = value ? GNR_CFG_DW_TXSTATE : 0;
+
+	return gnr_gpio_configure_pad(gc, gpio, clear, set);
+}
+
+static const struct gpio_chip gnr_gpio_chip = {
+	.owner		  = THIS_MODULE,
+	.get		  = gnr_gpio_get,
+	.set		  = gnr_gpio_set,
+	.get_direction    = gnr_gpio_get_direction,
+	.direction_input  = gnr_gpio_direction_input,
+	.direction_output = gnr_gpio_direction_output,
+};
+
+static void __iomem *gnr_gpio_get_reg_addr(const struct gnr_gpio *priv,
+					   unsigned int base,
+					   unsigned int gpio)
+{
+	return priv->reg_base + base + gpio * sizeof(u32);
+}
+
+static void gnr_gpio_irq_ack(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gnr_gpio *priv = gpiochip_get_data(gc);
+	irq_hw_number_t gpio = irqd_to_hwirq(d);
+	unsigned int reg_idx = gpio / GNR_PINS_PER_REG;
+	unsigned int bit_idx = gpio % GNR_PINS_PER_REG;
+	void __iomem *addr = gnr_gpio_get_reg_addr(priv, GNR_GPI_STATUS_OFFSET, reg_idx);
+	u32 reg;
+
+	guard(raw_spinlock_irqsave)(&priv->lock);
+
+	reg = readl(addr);
+	reg &= ~BIT(bit_idx);
+	writel(reg, addr);
+}
+
+static void gnr_gpio_irq_mask_unmask(struct gpio_chip *gc, unsigned long gpio, bool mask)
+{
+	struct gnr_gpio *priv = gpiochip_get_data(gc);
+	unsigned int reg_idx = gpio / GNR_PINS_PER_REG;
+	unsigned int bit_idx = gpio % GNR_PINS_PER_REG;
+	void __iomem *addr = gnr_gpio_get_reg_addr(priv, GNR_GPI_ENABLE_OFFSET, reg_idx);
+	u32 reg;
+
+	guard(raw_spinlock_irqsave)(&priv->lock);
+
+	reg = readl(addr);
+	if (mask)
+		reg &= ~BIT(bit_idx);
+	else
+		reg |= BIT(bit_idx);
+	writel(reg, addr);
+}
+
+static void gnr_gpio_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+
+	gnr_gpio_irq_mask_unmask(gc, hwirq, true);
+	gpiochip_disable_irq(gc, hwirq);
+}
+
+static void gnr_gpio_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+
+	gpiochip_enable_irq(gc, hwirq);
+	gnr_gpio_irq_mask_unmask(gc, hwirq, false);
+}
+
+static int gnr_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t pin = irqd_to_hwirq(d);
+	u32 mask = GNR_CFG_DW_RX_MASK;
+	u32 set;
+
+	/* Falling edge and level low triggers not supported by the GPIO controller */
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		set = GNR_CFG_DW_RX_DISABLE;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		set = GNR_CFG_DW_RX_EDGE;
+		irq_set_handler_locked(d, handle_edge_irq);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		set = GNR_CFG_DW_RX_LEVEL;
+		irq_set_handler_locked(d, handle_level_irq);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return gnr_gpio_configure_pad(gc, pin, mask, set);
+}
+
+static const struct irq_chip gnr_gpio_irq_chip = {
+	.irq_ack	= gnr_gpio_irq_ack,
+	.irq_mask	= gnr_gpio_irq_mask,
+	.irq_unmask	= gnr_gpio_irq_unmask,
+	.irq_set_type	= gnr_gpio_irq_set_type,
+	.flags		= IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static void gnr_gpio_init_pin_ro_bits(struct device *dev,
+				      const void __iomem *cfg_lock_base,
+				      unsigned long *ro_bitmap)
+{
+	u32 tmp[GNR_NUM_REGS];
+
+	memcpy_fromio(tmp, cfg_lock_base, sizeof(tmp));
+	bitmap_from_arr32(ro_bitmap, tmp, GNR_NUM_PINS);
+}
+
+static irqreturn_t gnr_gpio_irq(int irq, void *data)
+{
+	struct gnr_gpio *priv = data;
+	unsigned int handled = 0;
+
+	for (unsigned int i = 0; i < GNR_NUM_REGS; i++) {
+		const void __iomem *reg = priv->reg_base + i * sizeof(u32);
+		unsigned long pending;
+		unsigned long enabled;
+		unsigned int bit_idx;
+
+		scoped_guard(raw_spinlock, &priv->lock) {
+			pending = readl(reg + GNR_GPI_STATUS_OFFSET);
+			enabled = readl(reg + GNR_GPI_ENABLE_OFFSET);
+		}
+
+		/* Only enabled interrupts */
+		pending &= enabled;
+
+		for_each_set_bit(bit_idx, &pending, GNR_PINS_PER_REG) {
+			unsigned int hwirq = i * GNR_PINS_PER_REG + bit_idx;
+
+			generic_handle_domain_irq(priv->gc.irq.domain, hwirq);
+		}
+
+		handled += pending ? 1 : 0;
+
+	}
+	return IRQ_RETVAL(handled);
+}
+
+static int gnr_gpio_probe(struct platform_device *pdev)
+{
+	size_t num_backup_pins = IS_ENABLED(CONFIG_PM_SLEEP) ? GNR_NUM_PINS : 0;
+	struct device *dev = &pdev->dev;
+	struct gpio_irq_chip *girq;
+	struct gnr_gpio *priv;
+	void __iomem *regs;
+	int irq, ret;
+
+	priv = devm_kzalloc(dev, struct_size(priv, pad_backup, num_backup_pins), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, gnr_gpio_irq, IRQF_SHARED | IRQF_NO_THREAD,
+			       dev_name(dev), priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request interrupt\n");
+
+	priv->reg_base = regs + readl(regs + GNR_CFG_BAR);
+
+	gnr_gpio_init_pin_ro_bits(dev, priv->reg_base + GNR_CFG_LOCK_OFFSET,
+				  priv->ro_bitmap);
+
+	priv->gc	= gnr_gpio_chip;
+	priv->gc.label	= dev_name(dev);
+	priv->gc.parent	= dev;
+	priv->gc.ngpio	= GNR_NUM_PINS;
+	priv->gc.base	= -1;
+
+	girq = &priv->gc.irq;
+	gpio_irq_chip_set_chip(girq, &gnr_gpio_irq_chip);
+	girq->chip->name	= dev_name(dev);
+	girq->parent_handler	= NULL;
+	girq->num_parents	= 0;
+	girq->parents		= NULL;
+	girq->default_type	= IRQ_TYPE_NONE;
+	girq->handler		= handle_bad_irq;
+
+	platform_set_drvdata(pdev, priv);
+
+	return devm_gpiochip_add_data(dev, &priv->gc, priv);
+}
+
+static int gnr_gpio_suspend(struct device *dev)
+{
+	struct gnr_gpio *priv = dev_get_drvdata(dev);
+	unsigned int i;
+
+	guard(raw_spinlock_irqsave)(&priv->lock);
+
+	for_each_clear_bit(i, priv->ro_bitmap, priv->gc.ngpio)
+		priv->pad_backup[i] = readl(gnr_gpio_get_padcfg_addr(priv, i));
+
+	return 0;
+}
+
+static int gnr_gpio_resume(struct device *dev)
+{
+	struct gnr_gpio *priv = dev_get_drvdata(dev);
+	unsigned int i;
+
+	guard(raw_spinlock_irqsave)(&priv->lock);
+
+	for_each_clear_bit(i, priv->ro_bitmap, priv->gc.ngpio)
+		writel(priv->pad_backup[i], gnr_gpio_get_padcfg_addr(priv, i));
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(gnr_gpio_pm_ops, gnr_gpio_suspend, gnr_gpio_resume);
+
+static const struct acpi_device_id gnr_gpio_acpi_match[] = {
+	{ "INTC1109" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, gnr_gpio_acpi_match);
+
+static struct platform_driver gnr_gpio_driver = {
+	.driver = {
+		.name		  = "gpio-graniterapids",
+		.pm		  = pm_sleep_ptr(&gnr_gpio_pm_ops),
+		.acpi_match_table = gnr_gpio_acpi_match,
+	},
+	.probe = gnr_gpio_probe,
+};
+module_platform_driver(gnr_gpio_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Aapo Vienamo <aapo.vienamo@linux.intel.com>");
+MODULE_DESCRIPTION("Intel Granite Rapids-D vGPIO driver");
-- 
2.44.0


