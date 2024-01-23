Return-Path: <linux-kernel+bounces-35899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1D683986C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3CA1C21066
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DCF1292E9;
	Tue, 23 Jan 2024 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K3xTJFA5"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18531292D7;
	Tue, 23 Jan 2024 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035632; cv=none; b=nTPzObhCGrgXq2mDj5jM79TK0XQCT9N60SQgkZK5R+fEYWsNAO2woVuVSoO22M380OclMO9MHFr/x1gtyWheBucAhqfSYxzi1uzHGPIUJZbIIIglcsDcne8NPdvr0c4VS0tgZ4aTqocycPGKNPTrDV0cPClfbxOn+tMT9dlUAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035632; c=relaxed/simple;
	bh=ELskhDIYZ9WC2EpfxObaqRtsncVtWMXymAueQdqtHQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UlDzYwA88T/R7756K+hycXFNJ0Yxa1G4O0e8LMKbuhnj10bZcqbayOUT5DimWwilKnnB4wVWFzXBCyhBHSujPelxjvyK1JFsW5cfaVKqSUylAlvKf1j49929JRQizur/sLNRCkGQO2THyVg76Sx9Zkki21VmN4bJE4Wwl29tCwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K3xTJFA5; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D737C0010;
	Tue, 23 Jan 2024 18:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFztnZwJb4nuocXrYAuSDyqIP3DIuPSlYNDm77ATpRM=;
	b=K3xTJFA5UPlq+tmdp6gHFEDIB5g294U/7ESJk2Jjr3123qfdxJwHUBwQaIcs6KFhFPOakJ
	x4kytkDt1XyhYVaS7YsFpbvl88oEOulasMhK8Ey758TTp/kbpbORZSWwfDxHJmjILPlhII
	ldBQifWSpB8JhTTZfhOk7mss64l4nZ6WPrRG0pD6wpewvRGP3mPnyH8qf+BxW1pB5MzArD
	Z+PZ4MWHxzHT8XnDNE+MbSopRCTNytCvvFnfMwwAujN2peCMsvFNdSTC2H2dfGIa++bmWZ
	DJUWSkGBO/K97ruqLio9jBAjeODh8Z+pbnIGuz7d1Flb78Kf+Q2i17A5sLAUEQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:46:53 +0100
Subject: [PATCH v3 08/17] clk: eyeq5: add platform driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-8-392b010b8281@bootlin.com>
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
In-Reply-To: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add the Mobileye EyeQ5 clock controller driver. It might grow to add
support for other platforms from Mobileye.

It handles 10 read-only PLLs derived from the main crystal on board. It
exposes a table-based divider clock used for OSPI. Other platform
clocks are not configurable and therefore kept as fixed-factor
devicetree nodes.

Two PLLs are required early on and are therefore registered at
of_clk_init(). Those are pll-cpu for the GIC timer and pll-per for the
UARTs.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 MAINTAINERS             |   1 +
 drivers/clk/Kconfig     |  11 ++
 drivers/clk/Makefile    |   1 +
 drivers/clk/clk-eyeq5.c | 414 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 427 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dc4251e1ac2..3ea96ab7d2b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14793,6 +14793,7 @@ F:	Documentation/devicetree/bindings/soc/mobileye/
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/eyeq5_defconfig
 F:	arch/mips/mobileye/board-epm5.its.S
+F:	drivers/clk/clk-eyeq5.c
 F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 F:	include/dt-bindings/soc/mobileye,eyeq5.h
 
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 50af5fc7f570..d5043ce2a75c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -218,6 +218,17 @@ config COMMON_CLK_EN7523
 	  This driver provides the fixed clocks and gates present on Airoha
 	  ARM silicon.
 
+config COMMON_CLK_EYEQ5
+	bool "Clock driver for the Mobileye EyeQ5 platform"
+	depends on OF
+	depends on MACH_EYEQ5 || COMPILE_TEST
+	default MACH_EYEQ5
+	help
+		This driver provides the clocks found on the Mobileye EyeQ5 SoC. Its
+		registers live in a shared register region called OLB. It provides 10
+		read-only PLLs derived from the main crystal clock which must be constant
+		and one divider clock based on one PLL.
+
 config COMMON_CLK_FSL_FLEXSPI
 	tristate "Clock driver for FlexSPI on Layerscape SoCs"
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 14fa8d4ecc1f..81c4d11ca437 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
 obj-$(CONFIG_ARCH_SPARX5)		+= clk-sparx5.o
 obj-$(CONFIG_COMMON_CLK_EN7523)		+= clk-en7523.o
+obj-$(CONFIG_COMMON_CLK_EYEQ5)		+= clk-eyeq5.o
 obj-$(CONFIG_COMMON_CLK_FIXED_MMIO)	+= clk-fixed-mmio.o
 obj-$(CONFIG_COMMON_CLK_FSL_FLEXSPI)	+= clk-fsl-flexspi.o
 obj-$(CONFIG_COMMON_CLK_FSL_SAI)	+= clk-fsl-sai.o
diff --git a/drivers/clk/clk-eyeq5.c b/drivers/clk/clk-eyeq5.c
new file mode 100644
index 000000000000..475dfcdc8af1
--- /dev/null
+++ b/drivers/clk/clk-eyeq5.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PLL clock driver for the Mobileye EyeQ5 platform.
+ *
+ * This controller handles 10 read-only PLLs, all derived from the same main
+ * crystal clock. It also exposes one divider clock, a child of one of the
+ * PLLs. The parent clock is expected to be constant. This driver's registers
+ * live in a shared region called OLB. Two PLLs must be initialized by
+ * of_clk_init().
+ *
+ * We use eq5c_ as prefix, as-in "EyeQ5 Clock", but way shorter.
+ *
+ * Copyright (C) 2024 Mobileye Vision Technologies Ltd.
+ */
+
+#define pr_fmt(fmt) "clk-eyeq5: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/mobileye,eyeq5-clk.h>
+
+/*
+ * PLL control & status registers, n=0..1
+ * 0x02c..0x078
+ */
+#define OLB_PCSR_CPU(n)				(0x02C + (n) * 4) /* CPU */
+#define OLB_PCSR_VMP(n)				(0x034 + (n) * 4) /* VMP */
+#define OLB_PCSR_PMA(n)				(0x03C + (n) * 4) /* PMA */
+#define OLB_PCSR_VDI(n)				(0x044 + (n) * 4) /* VDI */
+#define OLB_PCSR_DDR0(n)			(0x04C + (n) * 4) /* DDR0 */
+#define OLB_PCSR_PCI(n)				(0x054 + (n) * 4) /* PCI */
+#define OLB_PCSR_PER(n)				(0x05C + (n) * 4) /* PER */
+#define OLB_PCSR_PMAC(n)			(0x064 + (n) * 4) /* PMAC */
+#define OLB_PCSR_MPC(n)				(0x06c + (n) * 4) /* MPC */
+#define OLB_PCSR_DDR1(n)			(0x074 + (n) * 4) /* DDR1 */
+
+/* In frac mode, it enables fractional noise canceling DAC. Else, no function. */
+#define OLB_PCSR0_DAC_EN			BIT(0)
+/* Fractional or integer mode */
+#define OLB_PCSR0_DSM_EN			BIT(1)
+#define OLB_PCSR0_PLL_EN			BIT(2)
+/* All clocks output held at 0 */
+#define OLB_PCSR0_FOUTPOSTDIV_EN		BIT(3)
+#define OLB_PCSR0_POST_DIV1			GENMASK(6, 4)
+#define OLB_PCSR0_POST_DIV2			GENMASK(9, 7)
+#define OLB_PCSR0_REF_DIV			GENMASK(15, 10)
+#define OLB_PCSR0_INTIN				GENMASK(27, 16)
+#define OLB_PCSR0_BYPASS			BIT(28)
+/* Bits 30..29 are reserved */
+#define OLB_PCSR0_PLL_LOCKED			BIT(31)
+
+#define OLB_PCSR1_RESET				BIT(0)
+#define OLB_PCSR1_SSGC_DIV			GENMASK(4, 1)
+/* Spread amplitude (% = 0.1 * SPREAD[4:0]) */
+#define OLB_PCSR1_SPREAD			GENMASK(9, 5)
+#define OLB_PCSR1_DIS_SSCG			BIT(10)
+/* Down-spread or center-spread */
+#define OLB_PCSR1_DOWN_SPREAD			BIT(11)
+#define OLB_PCSR1_FRAC_IN			GENMASK(31, 12)
+
+static struct clk_hw_onecell_data *eq5c_clk_data;
+static struct regmap *eq5c_olb;
+
+struct eq5c_pll {
+	int		index;
+	const char	*name;
+	u32		reg;
+};
+
+/* Required early for the GIC timer (pll-cpu) and UARTs (pll-per). */
+static const struct eq5c_pll eq5c_early_plls[] = {
+	{ .index = EQ5C_PLL_CPU, .name = "pll-cpu",  .reg = OLB_PCSR_CPU(0), },
+	{ .index = EQ5C_PLL_PER, .name = "pll-per",  .reg = OLB_PCSR_PER(0), },
+};
+
+static const struct eq5c_pll eq5c_plls[] = {
+	{ .index = EQ5C_PLL_VMP,  .name = "pll-vmp",  .reg = OLB_PCSR_VMP(0),  },
+	{ .index = EQ5C_PLL_PMA,  .name = "pll-pma",  .reg = OLB_PCSR_PMA(0),  },
+	{ .index = EQ5C_PLL_VDI,  .name = "pll-vdi",  .reg = OLB_PCSR_VDI(0),  },
+	{ .index = EQ5C_PLL_DDR0, .name = "pll-ddr0", .reg = OLB_PCSR_DDR0(0), },
+	{ .index = EQ5C_PLL_PCI,  .name = "pll-pci",  .reg = OLB_PCSR_PCI(0),  },
+	{ .index = EQ5C_PLL_PMAC, .name = "pll-pmac", .reg = OLB_PCSR_PMAC(0), },
+	{ .index = EQ5C_PLL_MPC,  .name = "pll-mpc",  .reg = OLB_PCSR_MPC(0),  },
+	{ .index = EQ5C_PLL_DDR1, .name = "pll-ddr1", .reg = OLB_PCSR_DDR1(0), },
+};
+
+#define EQ5C_OSPI_DIV_CLK_NAME	"div-ospi"
+
+#define EQ5C_NB_CLKS	(ARRAY_SIZE(eq5c_early_plls) + ARRAY_SIZE(eq5c_plls) + 1)
+
+static int eq5c_pll_parse_registers(u32 r0, u32 r1, unsigned long *mult,
+				    unsigned long *div, unsigned long *acc)
+{
+	if (r0 & OLB_PCSR0_BYPASS) {
+		*mult = 1;
+		*div = 1;
+		*acc = 0;
+		return 0;
+	}
+
+	if (!(r0 & OLB_PCSR0_PLL_LOCKED))
+		return -EINVAL;
+
+	*mult = FIELD_GET(OLB_PCSR0_INTIN, r0);
+	*div = FIELD_GET(OLB_PCSR0_REF_DIV, r0);
+	if (r0 & OLB_PCSR0_FOUTPOSTDIV_EN)
+		*div *= FIELD_GET(OLB_PCSR0_POST_DIV1, r0) *
+			FIELD_GET(OLB_PCSR0_POST_DIV2, r0);
+
+	/* Fractional mode, in 2^20 (0x100000) parts. */
+	if (r0 & OLB_PCSR0_DSM_EN) {
+		*div *= 0x100000;
+		*mult = *mult * 0x100000 + FIELD_GET(OLB_PCSR1_FRAC_IN, r1);
+	}
+
+	if (!*mult || !*div)
+		return -EINVAL;
+
+	/* Spread spectrum. */
+	if (!(r1 & (OLB_PCSR1_RESET | OLB_PCSR1_DIS_SSCG))) {
+		/*
+		 * Spread is 1/1000 parts of frequency, accuracy is half of
+		 * that. To get accuracy, convert to ppb (parts per billion).
+		 */
+		u32 spread = FIELD_GET(OLB_PCSR1_SPREAD, r1);
+		*acc = spread * 500000;
+		if (r1 & OLB_PCSR1_DOWN_SPREAD) {
+			/*
+			 * Downspreading: the central frequency is half a
+			 * spread lower.
+			 */
+			*mult *= 2000 - spread;
+			*div *= 2000;
+		}
+	} else {
+		*acc = 0;
+	}
+
+	return 0;
+}
+
+#define OLB_OSPI_REG		0x11C
+#define OLB_OSPI_DIV_MASK	GENMASK(3, 0)
+#define OLB_OSPI_DIV_MASK_WIDTH	4
+
+static const struct clk_div_table eq5c_ospi_div_table[] = {
+	{ .val = 0, .div = 2 },
+	{ .val = 1, .div = 4 },
+	{ .val = 2, .div = 6 },
+	{ .val = 3, .div = 8 },
+	{ .val = 4, .div = 10 },
+	{ .val = 5, .div = 12 },
+	{ .val = 6, .div = 14 },
+	{ .val = 7, .div = 16 },
+	{} /* sentinel */
+};
+
+struct eq5c_ospi_div {
+	struct clk_hw	hw;
+	struct device	*dev;
+	struct regmap	*olb;
+};
+
+static struct eq5c_ospi_div *clk_to_priv(struct clk_hw *hw)
+{
+	return container_of(hw, struct eq5c_ospi_div, hw);
+}
+
+static unsigned long eq5c_ospi_div_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct eq5c_ospi_div *div = clk_to_priv(hw);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(div->olb, OLB_OSPI_REG, &val);
+
+	if (ret) {
+		dev_err(div->dev, "regmap_read failed: %d\n", ret);
+		return 0;
+	}
+
+	val = FIELD_GET(OLB_OSPI_DIV_MASK, val);
+
+	return divider_recalc_rate(hw, parent_rate, val,
+				   eq5c_ospi_div_table, 0,
+				   OLB_OSPI_DIV_MASK_WIDTH);
+}
+
+static long eq5c_ospi_div_round_rate(struct clk_hw *hw,
+				     unsigned long rate, unsigned long *prate)
+{
+	return divider_round_rate(hw, rate, prate, eq5c_ospi_div_table,
+				  OLB_OSPI_DIV_MASK_WIDTH, 0);
+}
+
+static int eq5c_ospi_div_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
+{
+	return divider_determine_rate(hw, req, eq5c_ospi_div_table,
+				      OLB_OSPI_DIV_MASK_WIDTH, 0);
+}
+
+static int eq5c_ospi_div_set_rate(struct clk_hw *hw,
+				  unsigned long rate, unsigned long parent_rate)
+{
+	struct eq5c_ospi_div *div = clk_to_priv(hw);
+	unsigned int val;
+	int value, ret;
+
+	value = divider_get_val(rate, parent_rate, eq5c_ospi_div_table,
+				OLB_OSPI_DIV_MASK_WIDTH, 0);
+	if (value < 0)
+		return value;
+
+	ret = regmap_read(div->olb, OLB_OSPI_REG, &val);
+	if (ret) {
+		dev_err(div->dev, "regmap_read failed: %d\n", ret);
+		return ret;
+	}
+
+	val &= ~OLB_OSPI_DIV_MASK;
+	val |= FIELD_PREP(OLB_OSPI_DIV_MASK, value);
+
+	ret = regmap_write(div->olb, OLB_OSPI_REG, val);
+	if (ret) {
+		dev_err(div->dev, "regmap_write failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct clk_ops eq5c_ospi_div_ops = {
+	.recalc_rate = eq5c_ospi_div_recalc_rate,
+	.round_rate = eq5c_ospi_div_round_rate,
+	.determine_rate = eq5c_ospi_div_determine_rate,
+	.set_rate = eq5c_ospi_div_set_rate,
+};
+
+static struct clk_hw *eq5c_init_ospi_div(struct device *dev, const char *name,
+					 struct regmap *olb,
+					 const struct clk_hw *parent)
+{
+	struct eq5c_ospi_div *div;
+	int ret;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOENT);
+
+	div->dev = dev;
+	div->olb = olb;
+	div->hw.init = CLK_HW_INIT_HW(name, parent, &eq5c_ospi_div_ops, 0);
+
+	ret = clk_hw_register(dev, &div->hw);
+	if (ret) {
+		dev_err(dev, "failed registering %s: %d\n", name, ret);
+		kfree(div);
+		return ERR_PTR(ret);
+	}
+
+	return &div->hw;
+}
+
+static int eq5c_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct clk_hw *hw;
+	int i;
+
+	if (IS_ERR(eq5c_clk_data))
+		return PTR_ERR(eq5c_clk_data);
+	else if (!eq5c_clk_data)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(eq5c_plls); i++) {
+		const struct eq5c_pll *pll = &eq5c_plls[i];
+		unsigned long mult, div, acc;
+		u32 r0, r1;
+		int ret;
+
+		regmap_read(eq5c_olb, pll->reg, &r0);
+		regmap_read(eq5c_olb, pll->reg + sizeof(r0), &r1);
+
+		ret = eq5c_pll_parse_registers(r0, r1, &mult, &div, &acc);
+		if (ret) {
+			dev_warn(dev, "failed parsing state of %s\n", pll->name);
+			continue;
+		}
+
+		hw = clk_hw_register_fixed_factor_with_accuracy_fwname(dev, np,
+				pll->name, "ref", 0, mult, div, acc);
+		eq5c_clk_data->hws[pll->index] = hw;
+		if (IS_ERR(hw)) {
+			dev_err(dev, "failed registering %s: %ld\n",
+				pll->name, PTR_ERR(hw));
+		}
+	}
+
+	/*
+	 * Register the OSPI table-based divider clock manually. This is
+	 * equivalent to drivers/clk/clk-divider.c, but using regmap to access
+	 * register.
+	 */
+	hw = eq5c_init_ospi_div(dev, EQ5C_OSPI_DIV_CLK_NAME, eq5c_olb,
+				eq5c_clk_data->hws[EQ5C_PLL_PER]);
+	eq5c_clk_data->hws[EQ5C_DIV_OSPI] = hw;
+
+	return 0;
+}
+
+static const struct of_device_id eq5c_match_table[] = {
+	{ .compatible = "mobileye,eyeq5-clk" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, eq5c_match_table);
+
+static struct platform_driver eq5c_driver = {
+	.probe = eq5c_probe,
+	.driver = {
+		.name = "clk-eyeq5",
+		.of_match_table = eq5c_match_table,
+	},
+};
+
+builtin_platform_driver(eq5c_driver);
+
+static void __init eq5c_init(struct device_node *np)
+{
+	struct device_node *parent_np = of_get_parent(np);
+	int i, ret;
+
+	eq5c_clk_data = kzalloc(struct_size(eq5c_clk_data, hws, EQ5C_NB_CLKS),
+				GFP_KERNEL);
+	if (!eq5c_clk_data) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	eq5c_clk_data->num = EQ5C_NB_CLKS;
+
+	/*
+	 * Mark all clocks as deferred. We register some now and others at
+	 * platform device probe.
+	 */
+	for (i = 0; i < EQ5C_NB_CLKS; i++)
+		eq5c_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
+
+	/*
+	 * Currently, if OLB is not available, we log an error, fail init then
+	 * fail probe. We might want to change this behavior and assume all
+	 * clocks are in bypass mode; this is what is being done in the vendor
+	 * driver.
+	 *
+	 * It is unclear if there are valid situations where the OLB region
+	 * would be inaccessible.
+	 */
+	eq5c_olb = ERR_PTR(-ENODEV);
+	if (parent_np)
+		eq5c_olb = syscon_node_to_regmap(parent_np);
+	if (IS_ERR(eq5c_olb)) {
+		pr_err("failed getting regmap: %ld\n", PTR_ERR(eq5c_olb));
+		ret = PTR_ERR(eq5c_olb);
+		goto err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(eq5c_early_plls); i++) {
+		const struct eq5c_pll *pll = &eq5c_early_plls[i];
+		unsigned long mult, div, acc;
+		struct clk_hw *hw;
+		u32 r0, r1;
+
+		regmap_read(eq5c_olb, pll->reg, &r0);
+		regmap_read(eq5c_olb, pll->reg + sizeof(r0), &r1);
+
+		ret = eq5c_pll_parse_registers(r0, r1, &mult, &div, &acc);
+		if (ret) {
+			pr_warn("failed parsing state of %s\n", pll->name);
+			continue;
+		}
+
+		hw = clk_hw_register_fixed_factor_with_accuracy_fwname(NULL,
+				np, pll->name, "ref", 0, mult, div, acc);
+		eq5c_clk_data->hws[pll->index] = hw;
+		if (IS_ERR(hw)) {
+			pr_err("failed registering %s: %ld\n",
+			       pll->name, PTR_ERR(hw));
+		}
+	}
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, eq5c_clk_data);
+	if (ret) {
+		pr_err("failed registering clk provider: %d\n", ret);
+		goto err;
+	}
+
+	return;
+
+err:
+	kfree(eq5c_clk_data);
+	/* Signal to platform driver probe that we failed init. */
+	eq5c_clk_data = ERR_PTR(ret);
+	eq5c_olb = NULL;
+}
+
+CLK_OF_DECLARE_DRIVER(eq5c, "mobileye,eyeq5-clk", eq5c_init);

-- 
2.43.0


