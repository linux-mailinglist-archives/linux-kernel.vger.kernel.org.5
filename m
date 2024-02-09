Return-Path: <linux-kernel+bounces-59468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B587884F784
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2F128674B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321027F482;
	Fri,  9 Feb 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iAm+wxVO"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAF74E04;
	Fri,  9 Feb 2024 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489121; cv=none; b=Li/rWdolUut/NYcSqp/lXeJbytI4k5inWxUmUGk5d4E2gGaVCMfaSN/fkQi187A1rUp8rZAioL/Yt29Cen0O3iXun1iOfrKUGN1UF67HEArJOfoueqS8wwhGoaUplS30WMItmzI1Kt9gs04xtgCRHqcXlT/qWtBlFO/thdL8Msg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489121; c=relaxed/simple;
	bh=n18+jYzEERVWw5AynNjOzO2XsdxcjwFyaYmTAn66dEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5QWcwqhDhL3BMBPCr4G/s5l+RY8Mwd0WhJZ2IFOZxG1u/1IbR2QbFgr2PTu1QHdCSjKpOPFDxTJ3kEFBlZ0fgIC/zqB5yQ5RRD2KdYMa6uy6t5fE6UnJ2YS9UZyEraVKrt8MPoc86UCZXKrhXmW/eszj7Cq0SWFI/4Stp78Qik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iAm+wxVO; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F04DE24000C;
	Fri,  9 Feb 2024 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707489116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmFzXlhlDodKDT7mBlpK/IxNrSub2oAmYaM9UNcwyio=;
	b=iAm+wxVOJX/VfAziy3kQmE3xs4mRLByOugziZb3VCIilYL1eDLHX82HY568J4a/2HDhABc
	262Fr7z2W7/0OmPv4CCGKWOTdVHnIpd0PNQDb3dz2BL+nnBzNbSiaAomu2rQy7WV8aYp/W
	LAvG3+vkGcfoLem+dB0+CmulCQ5uTvkG205m0bXfgEX1MmtKyaUQvPIyxsrMqOkuwgDdMt
	gUQrY7EIxOqcJUAdNkKOnBPY3+L2LvB124ndbyy3fBuUGA7ylBIUPKRbeStR24PZBaTBqn
	R4og4NOGel1cMW3r7SWVHiSUJLJ7y+4TilPKGnvKKz29hg0em8LYPvOM271kzA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 15:31:43 +0100
Subject: [PATCH v5 07/13] clk: eyeq5: add platform driver, and init routine
 at of_clk_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-mbly-clk-v5-7-f094ee5e918a@bootlin.com>
References: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
In-Reply-To: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
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
 drivers/clk/clk-eyeq5.c | 289 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 302 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6e1dacf1c84..84ad8c8960a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14797,6 +14797,7 @@ F:	Documentation/devicetree/bindings/soc/mobileye/
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
index 000000000000..9598139e0383
--- /dev/null
+++ b/drivers/clk/clk-eyeq5.c
@@ -0,0 +1,289 @@
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
+#include <linux/mod_devicetable.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/clock/mobileye,eyeq5-clk.h>
+
+/* In frac mode, it enables fractional noise canceling DAC. Else, no function. */
+#define PCSR0_DAC_EN			BIT(0)
+/* Fractional or integer mode */
+#define PCSR0_DSM_EN			BIT(1)
+#define PCSR0_PLL_EN			BIT(2)
+/* All clocks output held at 0 */
+#define PCSR0_FOUTPOSTDIV_EN		BIT(3)
+#define PCSR0_POST_DIV1			GENMASK(6, 4)
+#define PCSR0_POST_DIV2			GENMASK(9, 7)
+#define PCSR0_REF_DIV			GENMASK(15, 10)
+#define PCSR0_INTIN			GENMASK(27, 16)
+#define PCSR0_BYPASS			BIT(28)
+/* Bits 30..29 are reserved */
+#define PCSR0_PLL_LOCKED		BIT(31)
+
+#define PCSR1_RESET			BIT(0)
+#define PCSR1_SSGC_DIV			GENMASK(4, 1)
+/* Spread amplitude (% = 0.1 * SPREAD[4:0]) */
+#define PCSR1_SPREAD			GENMASK(9, 5)
+#define PCSR1_DIS_SSCG			BIT(10)
+/* Down-spread or center-spread */
+#define PCSR1_DOWN_SPREAD		BIT(11)
+#define PCSR1_FRAC_IN			GENMASK(31, 12)
+
+static struct clk_hw_onecell_data *eq5c_clk_data;
+
+struct eq5c_pll {
+	int		index;
+	const char	*name;
+	u32		reg;	/* next 8 bytes are r0 and r1 */
+};
+
+/* Required early for the GIC timer (pll-cpu) and UARTs (pll-per). */
+static const struct eq5c_pll eq5c_early_plls[] = {
+	{ .index = EQ5C_PLL_CPU, .name = "pll-cpu",  .reg = 0x00, },
+	{ .index = EQ5C_PLL_PER, .name = "pll-per",  .reg = 0x30, },
+};
+
+static const struct eq5c_pll eq5c_plls[] = {
+	{ .index = EQ5C_PLL_VMP,  .name = "pll-vmp",  .reg = 0x08, },
+	{ .index = EQ5C_PLL_PMA,  .name = "pll-pma",  .reg = 0x10, },
+	{ .index = EQ5C_PLL_VDI,  .name = "pll-vdi",  .reg = 0x18, },
+	{ .index = EQ5C_PLL_DDR0, .name = "pll-ddr0", .reg = 0x20, },
+	{ .index = EQ5C_PLL_PCI,  .name = "pll-pci",  .reg = 0x28, },
+	{ .index = EQ5C_PLL_PMAC, .name = "pll-pmac", .reg = 0x38, },
+	{ .index = EQ5C_PLL_MPC,  .name = "pll-mpc",  .reg = 0x40, },
+	{ .index = EQ5C_PLL_DDR1, .name = "pll-ddr1", .reg = 0x48, },
+};
+
+#define EQ5C_OSPI_DIV_CLK_NAME	"div-ospi"
+#define EQ5C_OSPI_DIV_WIDTH	4
+
+#define EQ5C_NB_CLKS	(ARRAY_SIZE(eq5c_early_plls) + ARRAY_SIZE(eq5c_plls) + 1)
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
+static int eq5c_pll_parse_registers(u32 r0, u32 r1, unsigned long *mult,
+				    unsigned long *div, unsigned long *acc)
+{
+	if (r0 & PCSR0_BYPASS) {
+		*mult = 1;
+		*div = 1;
+		*acc = 0;
+		return 0;
+	}
+
+	if (!(r0 & PCSR0_PLL_LOCKED))
+		return -EINVAL;
+
+	*mult = FIELD_GET(PCSR0_INTIN, r0);
+	*div = FIELD_GET(PCSR0_REF_DIV, r0);
+	if (r0 & PCSR0_FOUTPOSTDIV_EN)
+		*div *= FIELD_GET(PCSR0_POST_DIV1, r0) *
+			FIELD_GET(PCSR0_POST_DIV2, r0);
+
+	/* Fractional mode, in 2^20 (0x100000) parts. */
+	if (r0 & PCSR0_DSM_EN) {
+		*div *= 0x100000;
+		*mult = *mult * 0x100000 + FIELD_GET(PCSR1_FRAC_IN, r1);
+	}
+
+	if (!*mult || !*div)
+		return -EINVAL;
+
+	/* Spread spectrum. */
+	if (!(r1 & (PCSR1_RESET | PCSR1_DIS_SSCG))) {
+		/*
+		 * Spread is 1/1000 parts of frequency, accuracy is half of
+		 * that. To get accuracy, convert to ppb (parts per billion).
+		 */
+		u32 spread = FIELD_GET(PCSR1_SPREAD, r1);
+		*acc = spread * 500000;
+		if (r1 & PCSR1_DOWN_SPREAD) {
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
+static int eq5c_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	void __iomem *base_plls, *base_ospi;
+	struct clk_hw *hw;
+	int i;
+
+	if (IS_ERR(eq5c_clk_data))
+		return PTR_ERR(eq5c_clk_data);
+	else if (!eq5c_clk_data)
+		return -EINVAL;
+
+	base_plls = devm_platform_ioremap_resource_byname(pdev, "plls");
+	base_ospi = devm_platform_ioremap_resource_byname(pdev, "ospi");
+	if (!base_plls || !base_ospi)
+		return -ENODEV;
+
+	for (i = 0; i < ARRAY_SIZE(eq5c_plls); i++) {
+		const struct eq5c_pll *pll = &eq5c_plls[i];
+		unsigned long mult, div, acc;
+		u32 r0, r1;
+		int ret;
+
+		r0 = readl(base_plls + pll->reg);
+		r1 = readl(base_plls + pll->reg + sizeof(r0));
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
+	hw = clk_hw_register_divider_table_parent_hw(dev, EQ5C_OSPI_DIV_CLK_NAME,
+			eq5c_clk_data->hws[EQ5C_PLL_PER], 0,
+			base_ospi, 0, EQ5C_OSPI_DIV_WIDTH, 0,
+			eq5c_ospi_div_table, NULL);
+	eq5c_clk_data->hws[EQ5C_DIV_OSPI] = hw;
+	if (IS_ERR(hw)) {
+		dev_err(dev, "failed registering %s: %ld\n",
+			EQ5C_OSPI_DIV_CLK_NAME, PTR_ERR(hw));
+	}
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
+	void __iomem *base_plls, *base_ospi;
+	int index_plls, index_ospi;
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
+	index_plls = of_property_match_string(np, "reg-names", "plls");
+	index_ospi = of_property_match_string(np, "reg-names", "ospi");
+	if (index_plls < 0 || index_ospi < 0) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	base_plls = of_iomap(np, index_plls);
+	base_ospi = of_iomap(np, index_ospi);
+	if (!base_plls || !base_ospi) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(eq5c_early_plls); i++) {
+		const struct eq5c_pll *pll = &eq5c_early_plls[i];
+		unsigned long mult, div, acc;
+		struct clk_hw *hw;
+		u32 r0, r1;
+
+		r0 = readl(base_plls + pll->reg);
+		r1 = readl(base_plls + pll->reg + sizeof(r0));
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
+}
+
+CLK_OF_DECLARE_DRIVER(eq5c, "mobileye,eyeq5-clk", eq5c_init);

-- 
2.43.0


