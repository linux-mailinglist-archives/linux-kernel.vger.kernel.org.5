Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F42E778363
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjHJWBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjHJWBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:01:07 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F150F2D55
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:01:04 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-48719e50231so903283e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691704864; x=1692309664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5S8Ti8tnbk9YmYY2W4cp76CDGKdAKwsKKE/wVi7jP8k=;
        b=YN1RDXCPR8P1Nk4TnclLcfgYBY+uofifUYED0LO/SfhH6kkvspGUZDF722oDT42S0w
         opAxMMjzPBChwdMGpACr+ubWm1dO5m2jRWdyOSJbD2DxrPUECfSF2VNFrlZPzP18Y+gc
         WxzCeUjLS5YjKwCPcvx79GeuJCbTkAyS9ZkM6xqdA/FArfM+lYCsEMnyDSw1kpLMVJnn
         sGpyorYJ88fIsLyeIqq1m8rX7j3vwg5VpBmxIS9liBKU0s0H6FhfKIPXG0RjDiEitI7i
         QqvK39dh+bqiFEAMt7pdSnNkK6AEIgRKUfsyr06coWR974V3nO2v+ltq3K31AdLoM97B
         OfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704864; x=1692309664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5S8Ti8tnbk9YmYY2W4cp76CDGKdAKwsKKE/wVi7jP8k=;
        b=UjdrcNyOCRe66dcMk1w/QTbMAU7ar1c5+3UUwMqthce5f3mN2w59L/rV6NvGRy5WBp
         Xm5bxnx9yIujqpJFjHm64t4eEzAT5ngXqrWdilCPVUTOSn8qjEDCzmtqN6FTx4uqVJYa
         N1qW2nbjcW1HE7CeBa4MJK3qJ19yAgAYgQoX5UKmofyl6l1HvOxaoo3MnVNeQu17R+Wh
         Y9eOZkoAQELn5fGvWJuZuxxYyUBk+pQTY5so7crCN6I/xusWh+YURSgkkt0KPDWPH2hP
         lA0MuHlW9GkTSCUoV/gxh2JUmQTuhXDepoa8Kq1V3d0W3W3IKJpTRZsYRkNsj0D3F19q
         x+iQ==
X-Gm-Message-State: AOJu0Ywdnn3oEolFJVfDjBL135aXmJ+RT3gqqfNq+eyu4Gbvq5OlZFFo
        nIyjHtYSNaJUpzwvVGsKF+FGDg==
X-Google-Smtp-Source: AGHT+IGMXlTm5hPZp9avZCeV/iTdLZkev9Y3i+ezcwq2oSa84otCQ5dyqr0C9DGvsSPYSkzJOSyAgQ==
X-Received: by 2002:a05:6122:421c:b0:486:7b72:68ca with SMTP id cm28-20020a056122421c00b004867b7268camr1935379vkb.5.1691704863941;
        Thu, 10 Aug 2023 15:01:03 -0700 (PDT)
Received: from fedora.. (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id r17-20020a056122009100b004872b997d3bsm387105vka.1.2023.08.10.15.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 15:01:03 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [RESEND PATCH 5/7] gpio: pcie-idio-24: Migrate to the regmap API
Date:   Thu, 10 Aug 2023 18:00:42 -0400
Message-ID: <b5c4fa61bb9c64ebd12af38c67b5d2d91fe0fd96.1691703928.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691703927.git.william.gray@linaro.org>
References: <cover.1691703927.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

For the PCIe-IDIO-24 series of devices, the following BARs are
available:

    BAR[0]: memory mapped PEX8311
    BAR[1]: I/O mapped PEX8311
    BAR[2]: I/O mapped card registers

There are 24 FET Output lines, 24 Isolated Input lines, and 8 TTL/CMOS
lines (which may be configured for either output or input). The GPIO
lines are exposed by the following card registers:

    Base +0x0-0x2 (Read/Write): FET Outputs
    Base +0xB (Read/Write): TTL/CMOS
    Base +0x4-0x6 (Read): Isolated Inputs
    Base +0x7 (Read): TTL/CMOS

In order for the device to support interrupts, the PLX PEX8311 internal
PCI wire interrupt and local interrupt input must first be enabled.

The following card registers for Change-Of-State may be used:

    Base +0x8-0xA (Read): COS Status Inputs
    Base +0x8-0xA (Write): COS Clear Inputs
    Base +0xB (Read): COS Status TTL/CMOS
    Base +0xB (Write): COS Clear TTL/CMOS
    Base +0xE (Read/Write): COS Enable

The COS Enable register is used to enable/disable interrupts and
configure the interrupt levels; each bit maps to a group of eight inputs
as described below:

    Bit 0: IRQ EN Rising Edge IN0-7
    Bit 1: IRQ EN Rising Edge IN8-15
    Bit 2: IRQ EN Rising Edge IN16-23
    Bit 3: IRQ EN Rising Edge TTL0-7
    Bit 4: IRQ EN Falling Edge IN0-7
    Bit 5: IRQ EN Falling Edge IN8-15
    Bit 6: IRQ EN Falling Edge IN16-23
    Bit 7: IRQ EN Falling Edge TTL0-7

An interrupt is asserted when a change-of-state matching the interrupt
level configuration respective for a particular group of eight inputs
with enabled COS is detected.

The COS Status registers may be read to determine which inputs have
changed; if interrupts were enabled, an IRQ will be generated for the
set bits in these registers. Writing the value read from the COS Status
register back to the respective COS Clear register will clear just those
interrupts.

Reviewed-by: Michael Walle <michael@walle.cc>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/3091e387b1d2eac011a1d84e493663aa2acf982e.1680708357.git.william.gray@linaro.org/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig             |   3 +
 drivers/gpio/gpio-pcie-idio-24.c | 677 +++++++++++--------------------
 2 files changed, 250 insertions(+), 430 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 864b221252b2..3cccc6cc315f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1665,7 +1665,10 @@ config GPIO_PCI_IDIO_16
 
 config GPIO_PCIE_IDIO_24
 	tristate "ACCES PCIe-IDIO-24 GPIO support"
+	select REGMAP_IRQ
+	select REGMAP_MMIO
 	select GPIOLIB_IRQCHIP
+	select GPIO_REGMAP
 	help
 	  Enables GPIO support for the ACCES PCIe-IDIO-24 family (PCIe-IDIO-24,
 	  PCIe-IDI-24, PCIe-IDO-24, PCIe-IDIO-12). An interrupt is generated
diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 463c0613abb9..2efd1b1a0805 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -6,16 +6,15 @@
  * This driver supports the following ACCES devices: PCIe-IDIO-24,
  * PCIe-IDI-24, PCIe-IDO-24, and PCIe-IDIO-12.
  */
-#include <linux/bitmap.h>
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/gpio/driver.h>
-#include <linux/interrupt.h>
-#include <linux/irqdesc.h>
+#include <linux/err.h>
+#include <linux/gpio/regmap.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -59,422 +58,224 @@
 #define PLX_PEX8311_PCI_LCS_INTCSR  0x68
 #define INTCSR_INTERNAL_PCI_WIRE    BIT(8)
 #define INTCSR_LOCAL_INPUT          BIT(11)
+#define IDIO_24_ENABLE_IRQ          (INTCSR_INTERNAL_PCI_WIRE | INTCSR_LOCAL_INPUT)
+
+#define IDIO_24_OUT_BASE 0x0
+#define IDIO_24_TTLCMOS_OUT_REG 0x3
+#define IDIO_24_IN_BASE 0x4
+#define IDIO_24_TTLCMOS_IN_REG 0x7
+#define IDIO_24_COS_STATUS_BASE 0x8
+#define IDIO_24_CONTROL_REG 0xC
+#define IDIO_24_COS_ENABLE 0xE
+#define IDIO_24_SOFT_RESET 0xF
+
+#define CONTROL_REG_OUT_MODE BIT(1)
+
+#define COS_ENABLE_RISING BIT(1)
+#define COS_ENABLE_FALLING BIT(4)
+#define COS_ENABLE_BOTH (COS_ENABLE_RISING | COS_ENABLE_FALLING)
+
+static const struct regmap_config pex8311_intcsr_regmap_config = {
+	.name = "pex8311_intcsr",
+	.reg_bits = 32,
+	.reg_stride = 1,
+	.reg_base = PLX_PEX8311_PCI_LCS_INTCSR,
+	.val_bits = 32,
+	.io_port = true,
+};
 
-/**
- * struct idio_24_gpio_reg - GPIO device registers structure
- * @out0_7:	Read: FET Outputs 0-7
- *		Write: FET Outputs 0-7
- * @out8_15:	Read: FET Outputs 8-15
- *		Write: FET Outputs 8-15
- * @out16_23:	Read: FET Outputs 16-23
- *		Write: FET Outputs 16-23
- * @ttl_out0_7:	Read: TTL/CMOS Outputs 0-7
- *		Write: TTL/CMOS Outputs 0-7
- * @in0_7:	Read: Isolated Inputs 0-7
- *		Write: Reserved
- * @in8_15:	Read: Isolated Inputs 8-15
- *		Write: Reserved
- * @in16_23:	Read: Isolated Inputs 16-23
- *		Write: Reserved
- * @ttl_in0_7:	Read: TTL/CMOS Inputs 0-7
- *		Write: Reserved
- * @cos0_7:	Read: COS Status Inputs 0-7
- *		Write: COS Clear Inputs 0-7
- * @cos8_15:	Read: COS Status Inputs 8-15
- *		Write: COS Clear Inputs 8-15
- * @cos16_23:	Read: COS Status Inputs 16-23
- *		Write: COS Clear Inputs 16-23
- * @cos_ttl0_7:	Read: COS Status TTL/CMOS 0-7
- *		Write: COS Clear TTL/CMOS 0-7
- * @ctl:	Read: Control Register
- *		Write: Control Register
- * @reserved:	Read: Reserved
- *		Write: Reserved
- * @cos_enable:	Read: COS Enable
- *		Write: COS Enable
- * @soft_reset:	Read: IRQ Output Pin Status
- *		Write: Software Board Reset
- */
-struct idio_24_gpio_reg {
-	u8 out0_7;
-	u8 out8_15;
-	u8 out16_23;
-	u8 ttl_out0_7;
-	u8 in0_7;
-	u8 in8_15;
-	u8 in16_23;
-	u8 ttl_in0_7;
-	u8 cos0_7;
-	u8 cos8_15;
-	u8 cos16_23;
-	u8 cos_ttl0_7;
-	u8 ctl;
-	u8 reserved;
-	u8 cos_enable;
-	u8 soft_reset;
+static const struct regmap_range idio_24_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x3), regmap_reg_range(0x8, 0xC),
+	regmap_reg_range(0xE, 0xF),
+};
+static const struct regmap_range idio_24_rd_ranges[] = {
+	regmap_reg_range(0x0, 0xC), regmap_reg_range(0xE, 0xF),
+};
+static const struct regmap_range idio_24_volatile_ranges[] = {
+	regmap_reg_range(0x4, 0xB), regmap_reg_range(0xF, 0xF),
+};
+static const struct regmap_access_table idio_24_wr_table = {
+	.yes_ranges = idio_24_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_24_wr_ranges),
+};
+static const struct regmap_access_table idio_24_rd_table = {
+	.yes_ranges = idio_24_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_24_rd_ranges),
+};
+static const struct regmap_access_table idio_24_volatile_table = {
+	.yes_ranges = idio_24_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(idio_24_volatile_ranges),
+};
+
+static const struct regmap_config idio_24_regmap_config = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.wr_table = &idio_24_wr_table,
+	.rd_table = &idio_24_rd_table,
+	.volatile_table = &idio_24_volatile_table,
+	.cache_type = REGCACHE_FLAT,
+	.use_raw_spinlock = true,
+};
+
+#define IDIO_24_NGPIO_PER_REG 8
+#define IDIO_24_REGMAP_IRQ(_id)						\
+	[24 + _id] = {							\
+		.reg_offset = (_id) / IDIO_24_NGPIO_PER_REG,		\
+		.mask = BIT((_id) % IDIO_24_NGPIO_PER_REG),		\
+		.type = { .types_supported = IRQ_TYPE_EDGE_BOTH },	\
+	}
+#define IDIO_24_IIN_IRQ(_id) IDIO_24_REGMAP_IRQ(_id)
+#define IDIO_24_TTL_IRQ(_id) IDIO_24_REGMAP_IRQ(24 + _id)
+
+static const struct regmap_irq idio_24_regmap_irqs[] = {
+	IDIO_24_IIN_IRQ(0), IDIO_24_IIN_IRQ(1), IDIO_24_IIN_IRQ(2), /* IIN 0-2 */
+	IDIO_24_IIN_IRQ(3), IDIO_24_IIN_IRQ(4), IDIO_24_IIN_IRQ(5), /* IIN 3-5 */
+	IDIO_24_IIN_IRQ(6), IDIO_24_IIN_IRQ(7), IDIO_24_IIN_IRQ(8), /* IIN 6-8 */
+	IDIO_24_IIN_IRQ(9), IDIO_24_IIN_IRQ(10), IDIO_24_IIN_IRQ(11), /* IIN 9-11 */
+	IDIO_24_IIN_IRQ(12), IDIO_24_IIN_IRQ(13), IDIO_24_IIN_IRQ(14), /* IIN 12-14 */
+	IDIO_24_IIN_IRQ(15), IDIO_24_IIN_IRQ(16), IDIO_24_IIN_IRQ(17), /* IIN 15-17 */
+	IDIO_24_IIN_IRQ(18), IDIO_24_IIN_IRQ(19), IDIO_24_IIN_IRQ(20), /* IIN 18-20 */
+	IDIO_24_IIN_IRQ(21), IDIO_24_IIN_IRQ(22), IDIO_24_IIN_IRQ(23), /* IIN 21-23 */
+	IDIO_24_TTL_IRQ(0), IDIO_24_TTL_IRQ(1), IDIO_24_TTL_IRQ(2), /* TTL 0-2 */
+	IDIO_24_TTL_IRQ(3), IDIO_24_TTL_IRQ(4), IDIO_24_TTL_IRQ(5), /* TTL 3-5 */
+	IDIO_24_TTL_IRQ(6), IDIO_24_TTL_IRQ(7), /* TTL 6-7 */
 };
 
 /**
  * struct idio_24_gpio - GPIO device private data structure
- * @chip:	instance of the gpio_chip
+ * @map:	regmap for the device
  * @lock:	synchronization lock to prevent I/O race conditions
- * @reg:	I/O address offset for the GPIO device registers
- * @irq_mask:	I/O bits affected by interrupts
+ * @irq_type:	type configuration for IRQs
  */
 struct idio_24_gpio {
-	struct gpio_chip chip;
+	struct regmap *map;
 	raw_spinlock_t lock;
-	__u8 __iomem *plx;
-	struct idio_24_gpio_reg __iomem *reg;
-	unsigned long irq_mask;
+	u8 irq_type;
 };
 
-static int idio_24_gpio_get_direction(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	const unsigned long out_mode_mask = BIT(1);
-
-	/* FET Outputs */
-	if (offset < 24)
-		return GPIO_LINE_DIRECTION_OUT;
-
-	/* Isolated Inputs */
-	if (offset < 48)
-		return GPIO_LINE_DIRECTION_IN;
-
-	/* TTL/CMOS I/O */
-	/* OUT MODE = 1 when TTL/CMOS Output Mode is set */
-	if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask)
-		return GPIO_LINE_DIRECTION_OUT;
-
-	return GPIO_LINE_DIRECTION_IN;
-}
-
-static int idio_24_gpio_direction_input(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	unsigned long flags;
-	unsigned int ctl_state;
-	const unsigned long out_mode_mask = BIT(1);
-
-	/* TTL/CMOS I/O */
-	if (offset > 47) {
-		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
-
-		/* Clear TTL/CMOS Output Mode */
-		ctl_state = ioread8(&idio24gpio->reg->ctl) & ~out_mode_mask;
-		iowrite8(ctl_state, &idio24gpio->reg->ctl);
-
-		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-	}
-
-	return 0;
-}
-
-static int idio_24_gpio_direction_output(struct gpio_chip *chip,
-	unsigned int offset, int value)
-{
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	unsigned long flags;
-	unsigned int ctl_state;
-	const unsigned long out_mode_mask = BIT(1);
-
-	/* TTL/CMOS I/O */
-	if (offset > 47) {
-		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
-
-		/* Set TTL/CMOS Output Mode */
-		ctl_state = ioread8(&idio24gpio->reg->ctl) | out_mode_mask;
-		iowrite8(ctl_state, &idio24gpio->reg->ctl);
-
-		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-	}
-
-	chip->set(chip, offset, value);
-	return 0;
-}
-
-static int idio_24_gpio_get(struct gpio_chip *chip, unsigned int offset)
+static int idio_24_handle_mask_sync(const int index, const unsigned int mask_buf_def,
+				    const unsigned int mask_buf, void *const irq_drv_data)
 {
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	const unsigned long offset_mask = BIT(offset % 8);
-	const unsigned long out_mode_mask = BIT(1);
-
-	/* FET Outputs */
-	if (offset < 8)
-		return !!(ioread8(&idio24gpio->reg->out0_7) & offset_mask);
+	const unsigned int type_mask = COS_ENABLE_BOTH << index;
+	struct idio_24_gpio *const idio24gpio = irq_drv_data;
+	u8 type;
+	int ret;
 
-	if (offset < 16)
-		return !!(ioread8(&idio24gpio->reg->out8_15) & offset_mask);
-
-	if (offset < 24)
-		return !!(ioread8(&idio24gpio->reg->out16_23) & offset_mask);
-
-	/* Isolated Inputs */
-	if (offset < 32)
-		return !!(ioread8(&idio24gpio->reg->in0_7) & offset_mask);
-
-	if (offset < 40)
-		return !!(ioread8(&idio24gpio->reg->in8_15) & offset_mask);
-
-	if (offset < 48)
-		return !!(ioread8(&idio24gpio->reg->in16_23) & offset_mask);
+	raw_spin_lock(&idio24gpio->lock);
 
-	/* TTL/CMOS Outputs */
-	if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask)
-		return !!(ioread8(&idio24gpio->reg->ttl_out0_7) & offset_mask);
+	/* if all are masked, then disable interrupts, else set to type */
+	type = (mask_buf == mask_buf_def) ? ~type_mask : idio24gpio->irq_type;
 
-	/* TTL/CMOS Inputs */
-	return !!(ioread8(&idio24gpio->reg->ttl_in0_7) & offset_mask);
-}
+	ret = regmap_update_bits(idio24gpio->map, IDIO_24_COS_ENABLE, type_mask, type);
 
-static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	void __iomem *ports[] = {
-		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
-		&idio24gpio->reg->out16_23, &idio24gpio->reg->in0_7,
-		&idio24gpio->reg->in8_15, &idio24gpio->reg->in16_23,
-	};
-	size_t index;
-	unsigned long port_state;
-	const unsigned long out_mode_mask = BIT(1);
-
-	/* clear bits array to a clean slate */
-	bitmap_zero(bits, chip->ngpio);
-
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		index = offset / 8;
-
-		/* read bits from current gpio port (port 6 is TTL GPIO) */
-		if (index < 6)
-			port_state = ioread8(ports[index]);
-		else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask)
-			port_state = ioread8(&idio24gpio->reg->ttl_out0_7);
-		else
-			port_state = ioread8(&idio24gpio->reg->ttl_in0_7);
-
-		port_state &= gpio_mask;
-
-		bitmap_set_value8(bits, port_state, offset);
-	}
+	raw_spin_unlock(&idio24gpio->lock);
 
-	return 0;
+	return ret;
 }
 
-static void idio_24_gpio_set(struct gpio_chip *chip, unsigned int offset,
-	int value)
+static int idio_24_set_type_config(unsigned int **const buf, const unsigned int type,
+				   const struct regmap_irq *const irq_data, const int idx,
+				   void *const irq_drv_data)
 {
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	const unsigned long out_mode_mask = BIT(1);
-	void __iomem *base;
-	const unsigned int mask = BIT(offset % 8);
-	unsigned long flags;
-	unsigned int out_state;
-
-	/* Isolated Inputs */
-	if (offset > 23 && offset < 48)
-		return;
-
-	/* TTL/CMOS Inputs */
-	if (offset > 47 && !(ioread8(&idio24gpio->reg->ctl) & out_mode_mask))
-		return;
-
-	/* TTL/CMOS Outputs */
-	if (offset > 47)
-		base = &idio24gpio->reg->ttl_out0_7;
-	/* FET Outputs */
-	else if (offset > 15)
-		base = &idio24gpio->reg->out16_23;
-	else if (offset > 7)
-		base = &idio24gpio->reg->out8_15;
-	else
-		base = &idio24gpio->reg->out0_7;
-
-	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
-
-	if (value)
-		out_state = ioread8(base) | mask;
-	else
-		out_state = ioread8(base) & ~mask;
-
-	iowrite8(out_state, base);
-
-	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-}
-
-static void idio_24_gpio_set_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	void __iomem *ports[] = {
-		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
-		&idio24gpio->reg->out16_23
-	};
-	size_t index;
-	unsigned long bitmask;
-	unsigned long flags;
-	unsigned long out_state;
-	const unsigned long out_mode_mask = BIT(1);
-
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		index = offset / 8;
-
-		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
-
-		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
-
-		/* read bits from current gpio port (port 6 is TTL GPIO) */
-		if (index < 6) {
-			out_state = ioread8(ports[index]);
-		} else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask) {
-			out_state = ioread8(&idio24gpio->reg->ttl_out0_7);
-		} else {
-			/* skip TTL GPIO if set for input */
-			raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-			continue;
-		}
-
-		/* set requested bit states */
-		out_state &= ~gpio_mask;
-		out_state |= bitmask;
-
-		/* write bits for current gpio port (port 6 is TTL GPIO) */
-		if (index < 6)
-			iowrite8(out_state, ports[index]);
-		else
-			iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
-
-		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+	const unsigned int offset = irq_data->reg_offset;
+	const unsigned int rising = COS_ENABLE_RISING << offset;
+	const unsigned int falling = COS_ENABLE_FALLING << offset;
+	const unsigned int mask = COS_ENABLE_BOTH << offset;
+	struct idio_24_gpio *const idio24gpio = irq_drv_data;
+	unsigned int new;
+	unsigned int cos_enable;
+	int ret;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		new = rising;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		new = falling;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		new = mask;
+		break;
+	default:
+		return -EINVAL;
 	}
-}
-
-static void idio_24_irq_ack(struct irq_data *data)
-{
-}
 
-static void idio_24_irq_mask(struct irq_data *data)
-{
-	struct gpio_chip *const chip = irq_data_get_irq_chip_data(data);
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	unsigned long flags;
-	const unsigned long bit_offset = irqd_to_hwirq(data) - 24;
-	unsigned char new_irq_mask;
-	const unsigned long bank_offset = bit_offset / 8;
-	unsigned char cos_enable_state;
-
-	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
-
-	idio24gpio->irq_mask &= ~BIT(bit_offset);
-	new_irq_mask = idio24gpio->irq_mask >> bank_offset * 8;
+	raw_spin_lock(&idio24gpio->lock);
 
-	if (!new_irq_mask) {
-		cos_enable_state = ioread8(&idio24gpio->reg->cos_enable);
+	/* replace old bitmap with new bitmap */
+	idio24gpio->irq_type = (idio24gpio->irq_type & ~mask) | (new & mask);
 
-		/* Disable Rising Edge detection */
-		cos_enable_state &= ~BIT(bank_offset);
-		/* Disable Falling Edge detection */
-		cos_enable_state &= ~BIT(bank_offset + 4);
+	ret = regmap_read(idio24gpio->map, IDIO_24_COS_ENABLE, &cos_enable);
+	if (ret)
+		goto exit_unlock;
 
-		iowrite8(cos_enable_state, &idio24gpio->reg->cos_enable);
+	/* if COS is currently enabled then update the edge type */
+	if (cos_enable & mask) {
+		ret = regmap_update_bits(idio24gpio->map, IDIO_24_COS_ENABLE, mask,
+					 idio24gpio->irq_type);
+		if (ret)
+			goto exit_unlock;
 	}
 
-	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+exit_unlock:
+	raw_spin_unlock(&idio24gpio->lock);
 
-	gpiochip_disable_irq(chip, irqd_to_hwirq(data));
+	return ret;
 }
 
-static void idio_24_irq_unmask(struct irq_data *data)
+static int idio_24_reg_mask_xlate(struct gpio_regmap *const gpio, const unsigned int base,
+				  const unsigned int offset, unsigned int *const reg,
+				  unsigned int *const mask)
 {
-	struct gpio_chip *const chip = irq_data_get_irq_chip_data(data);
-	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	unsigned long flags;
-	unsigned char prev_irq_mask;
-	const unsigned long bit_offset = irqd_to_hwirq(data) - 24;
-	const unsigned long bank_offset = bit_offset / 8;
-	unsigned char cos_enable_state;
-
-	gpiochip_enable_irq(chip, irqd_to_hwirq(data));
-
-	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+	const unsigned int out_stride = offset / IDIO_24_NGPIO_PER_REG;
+	const unsigned int in_stride = (offset - 24) / IDIO_24_NGPIO_PER_REG;
+	struct regmap *const map = gpio_regmap_get_drvdata(gpio);
+	int err;
+	unsigned int ctrl_reg;
 
-	prev_irq_mask = idio24gpio->irq_mask >> bank_offset * 8;
-	idio24gpio->irq_mask |= BIT(bit_offset);
+	switch (base) {
+	case IDIO_24_OUT_BASE:
+		*mask = BIT(offset % IDIO_24_NGPIO_PER_REG);
 
-	if (!prev_irq_mask) {
-		cos_enable_state = ioread8(&idio24gpio->reg->cos_enable);
+		/* FET Outputs */
+		if (offset < 24) {
+			*reg = IDIO_24_OUT_BASE + out_stride;
+			return 0;
+		}
 
-		/* Enable Rising Edge detection */
-		cos_enable_state |= BIT(bank_offset);
-		/* Enable Falling Edge detection */
-		cos_enable_state |= BIT(bank_offset + 4);
+		/* Isolated Inputs */
+		if (offset < 48) {
+			*reg = IDIO_24_IN_BASE + in_stride;
+			return 0;
+		}
 
-		iowrite8(cos_enable_state, &idio24gpio->reg->cos_enable);
-	}
+		err = regmap_read(map, IDIO_24_CONTROL_REG, &ctrl_reg);
+		if (err)
+			return err;
 
-	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-}
+		/* TTL/CMOS Outputs */
+		if (ctrl_reg & CONTROL_REG_OUT_MODE) {
+			*reg = IDIO_24_TTLCMOS_OUT_REG;
+			return 0;
+		}
 
-static int idio_24_irq_set_type(struct irq_data *data, unsigned int flow_type)
-{
-	/* The only valid irq types are none and both-edges */
-	if (flow_type != IRQ_TYPE_NONE &&
-		(flow_type & IRQ_TYPE_EDGE_BOTH) != IRQ_TYPE_EDGE_BOTH)
+		/* TTL/CMOS Inputs */
+		*reg = IDIO_24_TTLCMOS_IN_REG;
+		return 0;
+	case IDIO_24_CONTROL_REG:
+		/* We can only set direction for TTL/CMOS lines */
+		if (offset < 48)
+			return -EOPNOTSUPP;
+
+		*reg = IDIO_24_CONTROL_REG;
+		*mask = CONTROL_REG_OUT_MODE;
+		return 0;
+	default:
+		/* Should never reach this path */
 		return -EINVAL;
-
-	return 0;
-}
-
-static const struct irq_chip idio_24_irqchip = {
-	.name = "pcie-idio-24",
-	.irq_ack = idio_24_irq_ack,
-	.irq_mask = idio_24_irq_mask,
-	.irq_unmask = idio_24_irq_unmask,
-	.irq_set_type = idio_24_irq_set_type,
-	.flags = IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
-};
-
-static irqreturn_t idio_24_irq_handler(int irq, void *dev_id)
-{
-	struct idio_24_gpio *const idio24gpio = dev_id;
-	unsigned long irq_status;
-	struct gpio_chip *const chip = &idio24gpio->chip;
-	unsigned long irq_mask;
-	int gpio;
-
-	raw_spin_lock(&idio24gpio->lock);
-
-	/* Read Change-Of-State status */
-	irq_status = ioread32(&idio24gpio->reg->cos0_7);
-
-	raw_spin_unlock(&idio24gpio->lock);
-
-	/* Make sure our device generated IRQ */
-	if (!irq_status)
-		return IRQ_NONE;
-
-	/* Handle only unmasked IRQ */
-	irq_mask = idio24gpio->irq_mask & irq_status;
-
-	for_each_set_bit(gpio, &irq_mask, chip->ngpio - 24)
-		generic_handle_domain_irq(chip->irq.domain, gpio + 24);
-
-	raw_spin_lock(&idio24gpio->lock);
-
-	/* Clear Change-Of-State status */
-	iowrite32(irq_status, &idio24gpio->reg->cos0_7);
-
-	raw_spin_unlock(&idio24gpio->lock);
-
-	return IRQ_HANDLED;
+	}
 }
 
 #define IDIO_24_NGPIO 56
@@ -496,11 +297,12 @@ static int idio_24_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	const size_t pci_plx_bar_index = 1;
 	const size_t pci_bar_index = 2;
 	const char *const name = pci_name(pdev);
-	struct gpio_irq_chip *girq;
-
-	idio24gpio = devm_kzalloc(dev, sizeof(*idio24gpio), GFP_KERNEL);
-	if (!idio24gpio)
-		return -ENOMEM;
+	struct gpio_regmap_config gpio_config = {};
+	void __iomem *pex8311_regs;
+	void __iomem *idio_24_regs;
+	struct regmap *intcsr_map;
+	struct regmap_irq_chip *chip;
+	struct regmap_irq_chip_data *chip_data;
 
 	err = pcim_enable_device(pdev);
 	if (err) {
@@ -514,57 +316,72 @@ static int idio_24_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return err;
 	}
 
-	idio24gpio->plx = pcim_iomap_table(pdev)[pci_plx_bar_index];
-	idio24gpio->reg = pcim_iomap_table(pdev)[pci_bar_index];
-
-	idio24gpio->chip.label = name;
-	idio24gpio->chip.parent = dev;
-	idio24gpio->chip.owner = THIS_MODULE;
-	idio24gpio->chip.base = -1;
-	idio24gpio->chip.ngpio = IDIO_24_NGPIO;
-	idio24gpio->chip.names = idio_24_names;
-	idio24gpio->chip.get_direction = idio_24_gpio_get_direction;
-	idio24gpio->chip.direction_input = idio_24_gpio_direction_input;
-	idio24gpio->chip.direction_output = idio_24_gpio_direction_output;
-	idio24gpio->chip.get = idio_24_gpio_get;
-	idio24gpio->chip.get_multiple = idio_24_gpio_get_multiple;
-	idio24gpio->chip.set = idio_24_gpio_set;
-	idio24gpio->chip.set_multiple = idio_24_gpio_set_multiple;
-
-	girq = &idio24gpio->chip.irq;
-	gpio_irq_chip_set_chip(girq, &idio_24_irqchip);
-	/* This will let us handle the parent IRQ in the driver */
-	girq->parent_handler = NULL;
-	girq->num_parents = 0;
-	girq->parents = NULL;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_edge_irq;
+	pex8311_regs = pcim_iomap_table(pdev)[pci_plx_bar_index];
+	idio_24_regs = pcim_iomap_table(pdev)[pci_bar_index];
+
+	intcsr_map = devm_regmap_init_mmio(dev, pex8311_regs, &pex8311_intcsr_regmap_config);
+	if (IS_ERR(intcsr_map))
+		return dev_err_probe(dev, PTR_ERR(intcsr_map),
+				     "Unable to initialize PEX8311 register map\n");
+
+	idio24gpio = devm_kzalloc(dev, sizeof(*idio24gpio), GFP_KERNEL);
+	if (!idio24gpio)
+		return -ENOMEM;
+
+	idio24gpio->map = devm_regmap_init_mmio(dev, idio_24_regs, &idio_24_regmap_config);
+	if (IS_ERR(idio24gpio->map))
+		return dev_err_probe(dev, PTR_ERR(idio24gpio->map),
+				     "Unable to initialize register map\n");
 
 	raw_spin_lock_init(&idio24gpio->lock);
 
+	/* Initialize all IRQ type configuration to IRQ_TYPE_EDGE_BOTH */
+	idio24gpio->irq_type = GENMASK(7, 0);
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->name = name;
+	chip->status_base = IDIO_24_COS_STATUS_BASE;
+	chip->mask_base = IDIO_24_COS_ENABLE;
+	chip->ack_base = IDIO_24_COS_STATUS_BASE;
+	chip->num_regs = 4;
+	chip->irqs = idio_24_regmap_irqs;
+	chip->num_irqs = ARRAY_SIZE(idio_24_regmap_irqs);
+	chip->handle_mask_sync = idio_24_handle_mask_sync;
+	chip->set_type_config = idio_24_set_type_config;
+	chip->irq_drv_data = idio24gpio;
+
 	/* Software board reset */
-	iowrite8(0, &idio24gpio->reg->soft_reset);
+	err = regmap_write(idio24gpio->map, IDIO_24_SOFT_RESET, 0);
+	if (err)
+		return err;
 	/*
 	 * enable PLX PEX8311 internal PCI wire interrupt and local interrupt
 	 * input
 	 */
-	iowrite8((INTCSR_INTERNAL_PCI_WIRE | INTCSR_LOCAL_INPUT) >> 8,
-		 idio24gpio->plx + PLX_PEX8311_PCI_LCS_INTCSR + 1);
-
-	err = devm_gpiochip_add_data(dev, &idio24gpio->chip, idio24gpio);
-	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
+	err = regmap_update_bits(intcsr_map, 0x0, IDIO_24_ENABLE_IRQ, IDIO_24_ENABLE_IRQ);
+	if (err)
 		return err;
-	}
-
-	err = devm_request_irq(dev, pdev->irq, idio_24_irq_handler, IRQF_SHARED,
-		name, idio24gpio);
-	if (err) {
-		dev_err(dev, "IRQ handler registering failed (%d)\n", err);
-		return err;
-	}
 
-	return 0;
+	err = devm_regmap_add_irq_chip(dev, idio24gpio->map, pdev->irq, 0, 0, chip, &chip_data);
+	if (err)
+		return dev_err_probe(dev, err, "IRQ registration failed\n");
+
+	gpio_config.parent = dev;
+	gpio_config.regmap = idio24gpio->map;
+	gpio_config.ngpio = IDIO_24_NGPIO;
+	gpio_config.names = idio_24_names;
+	gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(IDIO_24_OUT_BASE);
+	gpio_config.reg_set_base = GPIO_REGMAP_ADDR(IDIO_24_OUT_BASE);
+	gpio_config.reg_dir_out_base = GPIO_REGMAP_ADDR(IDIO_24_CONTROL_REG);
+	gpio_config.ngpio_per_reg = IDIO_24_NGPIO_PER_REG;
+	gpio_config.irq_domain = regmap_irq_get_domain(chip_data);
+	gpio_config.reg_mask_xlate = idio_24_reg_mask_xlate;
+	gpio_config.drvdata = idio24gpio->map;
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
 }
 
 static const struct pci_device_id idio_24_pci_dev_id[] = {
-- 
2.41.0

