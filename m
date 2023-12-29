Return-Path: <linux-kernel+bounces-12974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E6A81FDDA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4AF1F23C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06207497;
	Fri, 29 Dec 2023 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKeEkY5v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA5BA26;
	Fri, 29 Dec 2023 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35fff16827fso17248485ab.0;
        Thu, 28 Dec 2023 23:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703835940; x=1704440740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMIfoUSkLSoDGZ5tRbb3bXVs4hbdVpL1OH6EPKJqVS4=;
        b=fKeEkY5vqPrP3MkK6zggTDUEF3sRWQzUFxk3aEpPmf/sTfLEq/o/KN75tqAt/BOwsi
         2rNiwnFJCQPbnUf1Sj/MhxVwdNCIMxAvn9vazRWN11mAZ2EPp57FyK30H5nsNuQn0cJ/
         EprG1Bu3q0V0v35GEffBLsLRBtGpwPeer623ePnAYF5RgbLE1koKJ4vl3HCsGI17GYD/
         gceWaTXicxfT1PjbXZSyCXbZjmcLPCC0YgUuxsmFXibsk7vPhe6sazAm4FO+IjW1vji3
         15vHYqeufBdyf29XBHpnzHZUyE3sd7SeUp9yGhAlCKAMw83B07xXUeA5qBhJurR8YRHo
         lCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703835940; x=1704440740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMIfoUSkLSoDGZ5tRbb3bXVs4hbdVpL1OH6EPKJqVS4=;
        b=bkyYIeAmlQiS+pMGZcuGoEbTRiyI586SPuN/DRxG50qv3rmcltNlrbqY1TLr7ER184
         jQLOg2VhI4x+jMC68dSaDlt8J59Ca2Dh+UVxRBs+IxnmXs921QcqIvBbvIzyB58GoG2+
         chi1Go4Ljnk2BJiphQnecEizWh4JvqD+s8p6YzZPyCf6N7Ul7Pg8M/KVSehSVMyMhNk/
         Fm9dF1uiazydD8VkZrE0XUhiGcb4QIpIQyG7KaA7oqBIKAW9Eig2ss2XEvRkhbRdS8YW
         tPlMv+pfP6IrDL3cQKshc2QA6OO7Uf5TG/FdDXjSxUG+HnlfLsKQov1bW8n5DZkXVDdY
         QY/Q==
X-Gm-Message-State: AOJu0YycYa7QY/phoDUslOKVGJ3+dfiATppMBXiqRlTcs29zb/K1uok1
	NbQ8vIgjvKAtt4qsd3IsI+Y=
X-Google-Smtp-Source: AGHT+IFOWQbvYCSYGznrRgGPUgj4LOiR0e9OWuMLARRpr5JAWfNEpz3eoJ/g1+Y2tv6KiAFp/xarzQ==
X-Received: by 2002:a05:6e02:1c89:b0:35f:f67b:b004 with SMTP id w9-20020a056e021c8900b0035ff67bb004mr7762429ill.15.1703835940334;
        Thu, 28 Dec 2023 23:45:40 -0800 (PST)
Received: from localhost.localdomain ([1.200.140.173])
        by smtp.gmail.com with ESMTPSA id s188-20020a6377c5000000b005c683937cc5sm10305186pgc.44.2023.12.28.23.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 23:45:39 -0800 (PST)
From: jim.t90615@gmail.com
X-Google-Original-From: JJLIU0@nuvoton.com
To: JJLIU0@nuvoton.com,
	KWLIU@nuvoton.com,
	jim.t90615@gmail.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: [PATCH v10 3/3] gpio: nuvoton: Add Nuvoton NPCM sgpio driver
Date: Fri, 29 Dec 2023 15:45:08 +0800
Message-Id: <20231229074508.2709093-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231229074508.2709093-1-JJLIU0@nuvoton.com>
References: <20231229074508.2709093-1-JJLIU0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Liu <JJLIU0@nuvoton.com>

Add Nuvoton BMC NPCM7xx/NPCM8xx sgpio driver support.
Nuvoton NPCM SGPIO module is combine serial to parallel IC (HC595)
and parallel to serial IC (HC165), and use APB3 clock to control it.
This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
BMC can use this driver to increase 64 GPI pins and 64 GPO pins to use.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v10:
   - use HZ_PER_MHZ
   - check blank line and spaces wrongs
   - use dev_err_probe
   - Instead of conditionals use arithmetics
Changes for v9:
   - fix kernel rebot test warning
Changes for v8:
   - Remove OF_GPIO/GPIO_GENERIC and redundant assignments
   - Use GENMASK() and BIT()
   - Use dev_WARN and dev_err_probe
   - Check indentation issue
   - Use raw_spinlock_t
---
 drivers/gpio/Kconfig           |   7 +
 drivers/gpio/Makefile          |   1 +
 drivers/gpio/gpio-npcm-sgpio.c | 612 +++++++++++++++++++++++++++++++++
 3 files changed, 620 insertions(+)
 create mode 100644 drivers/gpio/gpio-npcm-sgpio.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b3a133ed31ee..efbdc93819d4 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -478,6 +478,13 @@ config GPIO_MXS
 	select GPIO_GENERIC
 	select GENERIC_IRQ_CHIP
 
+config GPIO_NPCM_SGPIO
+	bool "Nuvoton SGPIO support"
+	depends on ARCH_NPCM || COMPILE_TEST
+	select GPIOLIB_IRQCHIP
+	help
+	  Say Y here to support Nuvoton NPCM7XX/NPCM8XX SGPIO functionality.
+
 config GPIO_OCTEON
 	tristate "Cavium OCTEON GPIO"
 	depends on CAVIUM_OCTEON_SOC
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index eb73b5d633eb..373aa2943de5 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -116,6 +116,7 @@ obj-$(CONFIG_GPIO_MT7621)		+= gpio-mt7621.o
 obj-$(CONFIG_GPIO_MVEBU)		+= gpio-mvebu.o
 obj-$(CONFIG_GPIO_MXC)			+= gpio-mxc.o
 obj-$(CONFIG_GPIO_MXS)			+= gpio-mxs.o
+obj-$(CONFIG_GPIO_NPCM_SGPIO)		+= gpio-npcm-sgpio.o
 obj-$(CONFIG_GPIO_OCTEON)		+= gpio-octeon.o
 obj-$(CONFIG_GPIO_OMAP)			+= gpio-omap.o
 obj-$(CONFIG_GPIO_PALMAS)		+= gpio-palmas.o
diff --git a/drivers/gpio/gpio-npcm-sgpio.c b/drivers/gpio/gpio-npcm-sgpio.c
new file mode 100644
index 000000000000..e9057c4a658d
--- /dev/null
+++ b/drivers/gpio/gpio-npcm-sgpio.c
@@ -0,0 +1,612 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Nuvoton NPCM Serial GPIO Driver
+ *
+ * Copyright (C) 2021 Nuvoton Technologies
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/gpio/driver.h>
+#include <linux/hashtable.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/units.h>
+
+#define MAX_NR_HW_SGPIO		64
+
+#define  NPCM_IOXCFG1		0x2A
+#define  NPCM_IOXCFG1_SFT_CLK	GENMASK(3, 0)
+#define  NPCM_IOXCFG1_SCLK_POL	BIT(4)
+#define  NPCM_IOXCFG1_LDSH_POL	BIT(5)
+
+#define  NPCM_IOXCTS			0x28
+#define  NPCM_IOXCTS_IOXIF_EN		BIT(7)
+#define  NPCM_IOXCTS_RD_MODE		GENMASK(2, 1)
+#define  NPCM_IOXCTS_RD_MODE_PERIODIC	BIT(2)
+
+#define  NPCM_IOXCFG2		0x2B
+#define  NPCM_IOXCFG2_PORT	GENMASK(3, 0)
+
+#define  NPCM_IXOEVCFG_MASK	GENMASK(1, 0)
+#define  NPCM_IXOEVCFG_FALLING	BIT(1)
+#define  NPCM_IXOEVCFG_RISING	BIT(0)
+#define  NPCM_IXOEVCFG_BOTH	(NPCM_IXOEVCFG_FALLING | NPCM_IXOEVCFG_RISING)
+
+#define NPCM_CLK_MHZ	(8 * HZ_PER_MHZ)
+#define NPCM_750_OPT	6
+#define NPCM_845_OPT	5
+
+#define GPIO_BANK(x)    ((x) / 8)
+#define GPIO_BIT(x)     ((x) % 8)
+
+/*
+ * Select the frequency of shift clock.
+ * The shift clock is a division of the APB clock.
+ */
+struct npcm_clk_cfg {
+	unsigned int	*sft_clk;
+	unsigned int	*clk_sel;
+	unsigned int	cfg_opt;
+};
+
+struct npcm_sgpio {
+	struct gpio_chip chip;
+	struct clk *pclk;
+	struct irq_chip intc;
+	raw_spinlock_t lock;
+
+	void __iomem *base;
+	int irq;
+	u8 nin_sgpio;
+	u8 nout_sgpio;
+	u8 in_port;
+	u8 out_port;
+	u8 int_type[MAX_NR_HW_SGPIO];
+};
+
+struct npcm_sgpio_bank {
+	u8 rdata_reg;
+	u8 wdata_reg;
+	u8 event_config;
+	u8 event_status;
+};
+
+enum npcm_sgpio_reg {
+	READ_DATA,
+	WRITE_DATA,
+	EVENT_CFG,
+	EVENT_STS,
+};
+
+static const struct npcm_sgpio_bank npcm_sgpio_banks[] = {
+	{
+		.wdata_reg = 0x00,
+		.rdata_reg = 0x08,
+		.event_config = 0x10,
+		.event_status = 0x20,
+	},
+	{
+		.wdata_reg = 0x01,
+		.rdata_reg = 0x09,
+		.event_config = 0x12,
+		.event_status = 0x21,
+	},
+	{
+		.wdata_reg = 0x02,
+		.rdata_reg = 0x0a,
+		.event_config = 0x14,
+		.event_status = 0x22,
+	},
+	{
+		.wdata_reg = 0x03,
+		.rdata_reg = 0x0b,
+		.event_config = 0x16,
+		.event_status = 0x23,
+	},
+	{
+		.wdata_reg = 0x04,
+		.rdata_reg = 0x0c,
+		.event_config = 0x18,
+		.event_status = 0x24,
+	},
+	{
+		.wdata_reg = 0x05,
+		.rdata_reg = 0x0d,
+		.event_config = 0x1a,
+		.event_status = 0x25,
+	},
+	{
+		.wdata_reg = 0x06,
+		.rdata_reg = 0x0e,
+		.event_config = 0x1c,
+		.event_status = 0x26,
+	},
+	{
+		.wdata_reg = 0x07,
+		.rdata_reg = 0x0f,
+		.event_config = 0x1e,
+		.event_status = 0x27,
+	},
+};
+
+static void __iomem *bank_reg(struct npcm_sgpio *gpio,
+			      const struct npcm_sgpio_bank *bank,
+			      const enum npcm_sgpio_reg reg)
+{
+	switch (reg) {
+	case READ_DATA:
+		return gpio->base + bank->rdata_reg;
+	case WRITE_DATA:
+		return gpio->base + bank->wdata_reg;
+	case EVENT_CFG:
+		return gpio->base + bank->event_config;
+	case EVENT_STS:
+		return gpio->base + bank->event_status;
+	default:
+		/* actually if code runs to here, it's an error case */
+		dev_WARN(gpio->chip.parent, "Getting here is an error condition");
+		return NULL;
+	}
+}
+
+static const struct npcm_sgpio_bank *offset_to_bank(unsigned int offset)
+{
+	unsigned int bank = GPIO_BANK(offset);
+
+	return &npcm_sgpio_banks[bank];
+}
+
+static void npcm_sgpio_irqd_to_data(struct irq_data *d,
+				    struct npcm_sgpio **gpio,
+				    const struct npcm_sgpio_bank **bank,
+				    u8 *bit, unsigned int *offset)
+{
+	struct npcm_sgpio *internal;
+
+	*offset = irqd_to_hwirq(d);
+	internal = irq_data_get_irq_chip_data(d);
+
+	*gpio = internal;
+	*offset -= internal->nout_sgpio;
+	*bank = offset_to_bank(*offset);
+	*bit = GPIO_BIT(*offset);
+}
+
+static int npcm_sgpio_init_port(struct npcm_sgpio *gpio)
+{
+	u8 in_port, out_port, set_port, reg;
+
+	in_port = GPIO_BANK(gpio->nin_sgpio);
+	if (GPIO_BIT(gpio->nin_sgpio) > 0)
+		in_port += 1;
+
+	out_port = GPIO_BANK(gpio->nout_sgpio);
+	if (GPIO_BIT(gpio->nout_sgpio) > 0)
+		out_port += 1;
+
+	gpio->in_port = in_port;
+	gpio->out_port = out_port;
+	set_port = (out_port & NPCM_IOXCFG2_PORT) << 4 | (in_port & NPCM_IOXCFG2_PORT);
+	iowrite8(set_port, gpio->base + NPCM_IOXCFG2);
+
+	reg = ioread8(gpio->base + NPCM_IOXCFG2);
+
+	return reg == set_port ? 0 : -EINVAL;
+
+}
+
+static int npcm_sgpio_dir_in(struct gpio_chip *gc, unsigned int offset)
+{
+	struct npcm_sgpio *gpio = gpiochip_get_data(gc);
+
+	return offset <	gpio->nout_sgpio ? -EINVAL : 0;
+
+}
+
+static int npcm_sgpio_dir_out(struct gpio_chip *gc, unsigned int offset, int val)
+{
+	gc->set(gc, offset, val);
+
+	return 0;
+}
+
+static int npcm_sgpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct npcm_sgpio *gpio = gpiochip_get_data(gc);
+
+	if (offset < gpio->nout_sgpio)
+		return GPIO_LINE_DIRECTION_OUT;
+
+	return GPIO_LINE_DIRECTION_IN;
+}
+
+static void npcm_sgpio_set(struct gpio_chip *gc, unsigned int offset, int val)
+{
+	struct npcm_sgpio *gpio = gpiochip_get_data(gc);
+	const struct  npcm_sgpio_bank *bank = offset_to_bank(offset);
+	void __iomem *addr;
+	u8 reg = 0;
+
+	addr = bank_reg(gpio, bank, WRITE_DATA);
+	reg = ioread8(addr);
+
+	if (val)
+		reg |= BIT(GPIO_BIT(offset));
+	else
+		reg &= ~BIT(GPIO_BIT(offset));
+
+	iowrite8(reg, addr);
+}
+
+static int npcm_sgpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct npcm_sgpio *gpio = gpiochip_get_data(gc);
+	const struct  npcm_sgpio_bank *bank;
+	void __iomem *addr;
+	u8 reg;
+
+	if (offset < gpio->nout_sgpio) {
+		bank = offset_to_bank(offset);
+		addr = bank_reg(gpio, bank, WRITE_DATA);
+	} else {
+		offset -= gpio->nout_sgpio;
+		bank = offset_to_bank(offset);
+		addr = bank_reg(gpio, bank, READ_DATA);
+	}
+
+	reg = ioread8(addr);
+
+	return !!(reg & BIT(GPIO_BIT(offset)));
+}
+
+static void npcm_sgpio_setup_enable(struct npcm_sgpio *gpio, bool enable)
+{
+	u8 reg;
+
+	reg = ioread8(gpio->base + NPCM_IOXCTS);
+	reg = (reg & ~NPCM_IOXCTS_RD_MODE) | NPCM_IOXCTS_RD_MODE_PERIODIC;
+
+	if (enable)
+		reg |= NPCM_IOXCTS_IOXIF_EN;
+	else
+		reg &= ~NPCM_IOXCTS_IOXIF_EN;
+
+	iowrite8(reg, gpio->base + NPCM_IOXCTS);
+}
+
+static int npcm_sgpio_setup_clk(struct npcm_sgpio *gpio,
+				const struct npcm_clk_cfg *clk_cfg)
+{
+	unsigned long apb_freq;
+	u32 val;
+	u8 tmp;
+	int i;
+
+	apb_freq = clk_get_rate(gpio->pclk);
+	tmp = ioread8(gpio->base + NPCM_IOXCFG1) & ~NPCM_IOXCFG1_SFT_CLK;
+
+	for (i = clk_cfg->cfg_opt-1; i > 0; i--) {
+		val = apb_freq / clk_cfg->sft_clk[i];
+		if (NPCM_CLK_MHZ > val) {
+			iowrite8(clk_cfg->clk_sel[i] | tmp, gpio->base + NPCM_IOXCFG1);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static void npcm_sgpio_irq_init_valid_mask(struct gpio_chip *gc,
+					   unsigned long *valid_mask, unsigned int ngpios)
+{
+	struct npcm_sgpio *gpio = gpiochip_get_data(gc);
+
+	/* input GPIOs in the high range */
+	bitmap_set(valid_mask, gpio->nout_sgpio, gpio->nin_sgpio);
+	bitmap_clear(valid_mask, 0, gpio->nout_sgpio);
+}
+
+static void npcm_sgpio_irq_set_mask(struct irq_data *d, bool set)
+{
+	const struct npcm_sgpio_bank *bank;
+	struct npcm_sgpio *gpio;
+	unsigned long flags;
+	void __iomem *addr;
+	unsigned int offset;
+	u16 reg, type;
+	u8 bit;
+
+	npcm_sgpio_irqd_to_data(d, &gpio, &bank, &bit, &offset);
+	addr = bank_reg(gpio, bank, EVENT_CFG);
+
+	reg = ioread16(addr);
+	if (set) {
+		reg &= ~(NPCM_IXOEVCFG_MASK << (bit * 2));
+	} else {
+		type = gpio->int_type[offset];
+		reg |= (type << (bit * 2));
+	}
+
+	raw_spin_lock_irqsave(&gpio->lock, flags);
+
+	npcm_sgpio_setup_enable(gpio, false);
+
+	iowrite16(reg, addr);
+
+	npcm_sgpio_setup_enable(gpio, true);
+
+	addr = bank_reg(gpio, bank, EVENT_STS);
+	reg = ioread8(addr);
+	reg |= BIT(bit);
+	iowrite8(reg, addr);
+
+	raw_spin_unlock_irqrestore(&gpio->lock, flags);
+}
+
+static void npcm_sgpio_irq_ack(struct irq_data *d)
+{
+	const struct npcm_sgpio_bank *bank;
+	struct npcm_sgpio *gpio;
+	unsigned long flags;
+	void __iomem *status_addr;
+	unsigned int offset;
+	u8 bit;
+
+	npcm_sgpio_irqd_to_data(d, &gpio, &bank, &bit, &offset);
+	status_addr = bank_reg(gpio, bank, EVENT_STS);
+	raw_spin_lock_irqsave(&gpio->lock, flags);
+	iowrite8(BIT(bit), status_addr);
+	raw_spin_unlock_irqrestore(&gpio->lock, flags);
+}
+
+static void npcm_sgpio_irq_mask(struct irq_data *d)
+{
+	npcm_sgpio_irq_set_mask(d, true);
+}
+
+static void npcm_sgpio_irq_unmask(struct irq_data *d)
+{
+	npcm_sgpio_irq_set_mask(d, false);
+}
+
+static int npcm_sgpio_set_type(struct irq_data *d, unsigned int type)
+{
+	const struct npcm_sgpio_bank *bank;
+	irq_flow_handler_t handler;
+	struct npcm_sgpio *gpio;
+	unsigned long flags;
+	void __iomem *addr;
+	unsigned int offset;
+	u16 reg, val;
+	u8 bit;
+
+	npcm_sgpio_irqd_to_data(d, &gpio, &bank, &bit, &offset);
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_BOTH:
+		val = NPCM_IXOEVCFG_BOTH;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		val = NPCM_IXOEVCFG_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_LEVEL_LOW:
+		val = NPCM_IXOEVCFG_FALLING;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		handler = handle_level_irq;
+	else
+		handler = handle_edge_irq;
+
+	gpio->int_type[offset] = val;
+
+	raw_spin_lock_irqsave(&gpio->lock, flags);
+	npcm_sgpio_setup_enable(gpio, false);
+	addr = bank_reg(gpio, bank, EVENT_CFG);
+	reg = ioread16(addr);
+
+	reg |= (val << (bit * 2));
+
+	iowrite16(reg, addr);
+	npcm_sgpio_setup_enable(gpio, true);
+	raw_spin_unlock_irqrestore(&gpio->lock, flags);
+
+	irq_set_handler_locked(d, handler);
+
+	return 0;
+}
+
+static void npcm_sgpio_irq_handler(struct irq_desc *desc)
+{
+	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
+	struct irq_chip *ic = irq_desc_get_chip(desc);
+	struct npcm_sgpio *gpio = gpiochip_get_data(gc);
+	unsigned int i, j, girq;
+	unsigned long reg;
+
+	chained_irq_enter(ic, desc);
+
+	for (i = 0; i < ARRAY_SIZE(npcm_sgpio_banks); i++) {
+		const struct npcm_sgpio_bank *bank = &npcm_sgpio_banks[i];
+
+		reg = ioread8(bank_reg(gpio, bank, EVENT_STS));
+		for_each_set_bit(j, &reg, 8) {
+			girq = irq_find_mapping(gc->irq.domain, i * 8 + gpio->nout_sgpio + j);
+			generic_handle_domain_irq(gc->irq.domain, girq);
+		}
+	}
+
+	chained_irq_exit(ic, desc);
+}
+
+static const struct irq_chip sgpio_irq_chip = {
+	.name = "sgpio-irq",
+	.irq_ack = npcm_sgpio_irq_ack,
+	.irq_mask = npcm_sgpio_irq_mask,
+	.irq_unmask = npcm_sgpio_irq_unmask,
+	.irq_set_type = npcm_sgpio_set_type,
+	.flags	= IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static int npcm_sgpio_setup_irqs(struct npcm_sgpio *gpio,
+				 struct platform_device *pdev)
+{
+	int rc, i;
+	struct gpio_irq_chip *irq;
+
+	rc = platform_get_irq(pdev, 0);
+	if (rc < 0)
+		return rc;
+
+	gpio->irq = rc;
+
+	npcm_sgpio_setup_enable(gpio, false);
+
+	/* Disable IRQ and clear Interrupt status registers for all SGPIO Pins. */
+	for (i = 0; i < ARRAY_SIZE(npcm_sgpio_banks); i++) {
+		const struct npcm_sgpio_bank *bank = &npcm_sgpio_banks[i];
+
+		iowrite16(0, bank_reg(gpio, bank, EVENT_CFG));
+		iowrite8(0xff, bank_reg(gpio, bank, EVENT_STS));
+	}
+
+	irq = &gpio->chip.irq;
+	gpio_irq_chip_set_chip(irq, &sgpio_irq_chip);
+	irq->init_valid_mask = npcm_sgpio_irq_init_valid_mask;
+	irq->handler = handle_bad_irq;
+	irq->default_type = IRQ_TYPE_NONE;
+	irq->parent_handler = npcm_sgpio_irq_handler;
+	irq->parent_handler_data = gpio;
+	irq->parents = &gpio->irq;
+	irq->num_parents = 1;
+
+	return 0;
+}
+
+static int npcm_sgpio_probe(struct platform_device *pdev)
+{
+	struct npcm_sgpio *gpio;
+	const struct npcm_clk_cfg *clk_cfg;
+	int rc;
+	u32 nin_gpios, nout_gpios;
+
+	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+
+	gpio->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(gpio->base))
+		return PTR_ERR(gpio->base);
+
+	clk_cfg = device_get_match_data(&pdev->dev);
+	if (!clk_cfg)
+		return -EINVAL;
+
+	rc = device_property_read_u32(&pdev->dev, "nuvoton,input-ngpios", &nin_gpios);
+	if (rc < 0)
+		return dev_err_probe(&pdev->dev, rc, "Could not read ngpios property\n");
+
+	rc = device_property_read_u32(&pdev->dev, "nuvoton,output-ngpios", &nout_gpios);
+	if (rc < 0)
+		return dev_err_probe(&pdev->dev, rc, "Could not read ngpios property\n");
+
+	gpio->nin_sgpio = nin_gpios;
+	gpio->nout_sgpio = nout_gpios;
+	if (gpio->nin_sgpio > MAX_NR_HW_SGPIO || gpio->nout_sgpio > MAX_NR_HW_SGPIO)
+		return dev_err_probe(&pdev->dev, -EINVAL, "Number of GPIOs exceeds the maximum of %d: input: %d output: %d\n", MAX_NR_HW_SGPIO, nin_gpios, nout_gpios);
+
+	gpio->pclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(gpio->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(gpio->pclk), "Could not get pclk\n");
+
+	rc = npcm_sgpio_setup_clk(gpio, clk_cfg);
+	if (rc < 0)
+		return dev_err_probe(&pdev->dev, rc, "Failed to setup clock\n");
+
+	raw_spin_lock_init(&gpio->lock);
+	gpio->chip.parent = &pdev->dev;
+	gpio->chip.ngpio = gpio->nin_sgpio + gpio->nout_sgpio;
+	gpio->chip.direction_input = npcm_sgpio_dir_in;
+	gpio->chip.direction_output = npcm_sgpio_dir_out;
+	gpio->chip.get_direction = npcm_sgpio_get_direction;
+	gpio->chip.get = npcm_sgpio_get;
+	gpio->chip.set = npcm_sgpio_set;
+	gpio->chip.label = dev_name(&pdev->dev);
+	gpio->chip.base = -1;
+
+	rc = npcm_sgpio_init_port(gpio);
+	if (rc < 0)
+		return rc;
+
+	rc = npcm_sgpio_setup_irqs(gpio, pdev);
+	if (rc < 0)
+		return rc;
+
+	rc = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
+	if (rc)
+		return dev_err_probe(&pdev->dev, rc, "GPIO registering failed\n");
+
+	npcm_sgpio_setup_enable(gpio, true);
+
+	return 0;
+}
+
+static unsigned int npcm750_SFT_CLK[NPCM_750_OPT] = {
+	1024, 32, 8, 4, 3, 2,
+};
+
+static unsigned int npcm750_CLK_SEL[NPCM_750_OPT] = {
+	0x00, 0x05, 0x07, 0x0C, 0x0D, 0x0E,
+};
+
+static unsigned int npcm845_SFT_CLK[NPCM_845_OPT] = {
+	1024, 32, 16, 8, 4,
+};
+
+static unsigned int npcm845_CLK_SEL[NPCM_845_OPT] = {
+	0x00, 0x05, 0x06, 0x07, 0x0C,
+};
+
+static struct npcm_clk_cfg npcm750_sgpio_pdata = {
+	.sft_clk = npcm750_SFT_CLK,
+	.clk_sel = npcm750_CLK_SEL,
+	.cfg_opt = NPCM_750_OPT,
+};
+
+static const struct npcm_clk_cfg npcm845_sgpio_pdata = {
+	.sft_clk = npcm845_SFT_CLK,
+	.clk_sel = npcm845_CLK_SEL,
+	.cfg_opt = NPCM_845_OPT,
+};
+
+static const struct of_device_id npcm_sgpio_of_table[] = {
+	{ .compatible = "nuvoton,npcm750-sgpio", .data = &npcm750_sgpio_pdata, },
+	{ .compatible = "nuvoton,npcm845-sgpio", .data = &npcm845_sgpio_pdata, },
+	{}
+};
+MODULE_DEVICE_TABLE(of, npcm_sgpio_of_table);
+
+static struct platform_driver npcm_sgpio_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = npcm_sgpio_of_table,
+	},
+	.probe	= npcm_sgpio_probe,
+};
+module_platform_driver(npcm_sgpio_driver);
+
+MODULE_AUTHOR("Jim Liu <jjliu0@nuvoton.com>");
+MODULE_AUTHOR("Joseph Liu <kwliu@nuvoton.com>");
+MODULE_DESCRIPTION("Nuvoton NPCM Serial GPIO Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1


