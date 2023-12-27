Return-Path: <linux-kernel+bounces-12124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF481F05A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785941F2104C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19228481B4;
	Wed, 27 Dec 2023 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nIYQQuas"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951245C0B;
	Wed, 27 Dec 2023 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CFA9FF80E;
	Wed, 27 Dec 2023 16:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703694248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKc2jcb0vVk/PJEfdEGvw0jrlfgEi8oM0s4Ck2HdGg8=;
	b=nIYQQuasIzGSK4OatcIT9A1SR0BTWNqvT1HiFtddd7my2yz4xOhy3feHW+SMtvk2Ug2B5a
	O418XHWChzgOnxpD7ECiEFtfDySQ9dqmIKOTva0tN/Ztjzazo8WCNeBgjTrZozcAsT/ldh
	oE5SELhr2DZz2x+H7VP7yJl31sOWiC20Qf31sRuKs2LCxhx9NIvHm5evn+pBe+FGlEot0M
	scPkkpqWXssjU+AkiXXHr39rcI9JtBPxcb8YTIfgYwp+XHppOLUNIUxKFvRl6zQHTtGa/1
	/B7afKoGNJnn6XqqFoyCHkMmQC3aISkOML3+oXf9Dl7xsblm0Lrjj2QMipgnXQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 27 Dec 2023 17:23:55 +0100
Subject: [PATCH v2 5/6] clk: eyeq5: add platform driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231227-mbly-clk-v2-5-a05db63c380f@bootlin.com>
References: <20231227-mbly-clk-v2-0-a05db63c380f@bootlin.com>
In-Reply-To: <20231227-mbly-clk-v2-0-a05db63c380f@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add the Mobileye EyeQ5 clock controller driver. It is specific to this
platform but might grow to add support of other platforms from
Mobileye.

It handles 10 read-only PLLs derived from the main crystal on board. It
exposes a table-based divider clock used for OSPI. Other platform
clocks are not configurable and therefore kept as fixed-factor
devicetree nodes.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 MAINTAINERS             |   1 +
 drivers/clk/Kconfig     |  11 ++
 drivers/clk/Makefile    |   1 +
 drivers/clk/clk-eyeq5.c | 348 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 361 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 280892bdb5de..de6f348e8c0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14558,6 +14558,7 @@ F:	Documentation/devicetree/bindings/soc/mobileye/
 F:	arch/mips/boot/dts/mobileye/
 F:	arch/mips/configs/generic/board-eyeq5.config
 F:	arch/mips/generic/board-epm5.its.S
+F:	drivers/clk/clk-eyeq5.c
 F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 F:	include/dt-bindings/soc/mobileye,eyeq5.h
 
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c30d0d396f7a..673439289d48 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -218,6 +218,17 @@ config COMMON_CLK_EN7523
 	  This driver provides the fixed clocks and gates present on Airoha
 	  ARM silicon.
 
+config COMMON_CLK_EYEQ5
+	bool "Clock driver for the Mobileye EyeQ5 platform"
+	depends on OF
+	depends on SOC_EYEQ5 || COMPILE_TEST
+	default SOC_EYEQ5
+	help
+		This driver provides the fixed clocks found on the Mobileye EyeQ5
+		SoC. Its registers live in a shared register region called OLB.
+		It provides 10 read-only PLLs derived from the main crystal clock which
+		must be constant and one divider clock based on one PLLs.
+
 config COMMON_CLK_FSL_FLEXSPI
 	tristate "Clock driver for FlexSPI on Layerscape SoCs"
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index ed71f2e0ee36..0df0dc6dbcae 100644
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
index 000000000000..4a75fc113fdf
--- /dev/null
+++ b/drivers/clk/clk-eyeq5.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PLL clock driver for the Mobileye EyeQ5 platform.
+ *
+ * This controller handles 10 read-only PLLs, all derived from the same main
+ * crystal clock. It also exposes one divider clock, a child of one of the
+ * PLLs. The parent clock is expected to be constant. This driver is custom to
+ * this platform, its registers live in a shared region called OLB.
+ *
+ * We use eq5c_ as prefix, as-in "EyeQ5 Clock", but way shorter.
+ *
+ * Copyright (C) 2023 Mobileye Vision Technologies Ltd.
+ */
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
+static const struct eq5c_pll {
+	const char *name;
+	u32 reg;
+} eq5c_plls[] = {
+	[EQ5C_PLL_CPU] =  { .name = "pll-cpu",  .reg = OLB_PCSR_CPU(0),  },
+	[EQ5C_PLL_VMP] =  { .name = "pll-vmp",  .reg = OLB_PCSR_VMP(0),  },
+	[EQ5C_PLL_PMA] =  { .name = "pll-pma",  .reg = OLB_PCSR_PMA(0),  },
+	[EQ5C_PLL_VDI] =  { .name = "pll-vdi",  .reg = OLB_PCSR_VDI(0),  },
+	[EQ5C_PLL_DDR0] = { .name = "pll-ddr0", .reg = OLB_PCSR_DDR0(0), },
+	[EQ5C_PLL_PCI] =  { .name = "pll-pci",  .reg = OLB_PCSR_PCI(0),  },
+	[EQ5C_PLL_PER] =  { .name = "pll-per",  .reg = OLB_PCSR_PER(0),  },
+	[EQ5C_PLL_PMAC] = { .name = "pll-pmac", .reg = OLB_PCSR_PMAC(0), },
+	[EQ5C_PLL_MPC] =  { .name = "pll-mpc",  .reg = OLB_PCSR_MPC(0),  },
+	[EQ5C_PLL_DDR1] = { .name = "pll-ddr1", .reg = OLB_PCSR_DDR1(0), },
+};
+
+#define EQ5C_OSPI_DIV_CLK_NAME	"div-ospi"
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
+static struct clk_hw *eq5c_init_ospi_div(struct device *dev,
+					 const struct clk_hw *parent,
+					 struct regmap *olb)
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
+	div->hw.init = CLK_HW_INIT_HW(EQ5C_OSPI_DIV_CLK_NAME, parent,
+				      &eq5c_ospi_div_ops, 0);
+
+	ret = clk_hw_register(dev, &div->hw);
+	if (ret) {
+		dev_err(dev, "failed registering div_ospi: %d\n", ret);
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
+	struct device_node *parent_np = of_get_parent(np);
+	struct clk_hw_onecell_data *data;
+	struct regmap *olb;
+	size_t nb_clks;
+	int i, ret;
+
+	nb_clks = ARRAY_SIZE(eq5c_plls) + 1;
+	data = kzalloc(struct_size(data, hws, nb_clks), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->num = nb_clks;
+
+	/*
+	 * TODO: currently, if OLB is not available, we log an error and early
+	 * return. We might want to change this behavior and assume all clocks
+	 * are in bypass mode; that is what is being done in the vendor driver.
+	 *
+	 * It is still unclear if there are valid situations where the OLB
+	 * region would be inaccessible.
+	 */
+	olb = ERR_PTR(-ENODEV);
+	if (parent_np)
+		olb = syscon_node_to_regmap(parent_np);
+	if (IS_ERR(olb)) {
+		dev_err(dev, "failed getting regmap: %ld\n", PTR_ERR(olb));
+		return PTR_ERR(olb);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(eq5c_plls); i++) {
+		const struct eq5c_pll *pll = &eq5c_plls[i];
+		unsigned long mult, div, acc;
+		u32 r0, r1;
+		int ret;
+
+		regmap_read(olb, pll->reg, &r0);
+		regmap_read(olb, pll->reg + sizeof(r0), &r1);
+
+		ret = eq5c_pll_parse_registers(r0, r1, &mult, &div, &acc);
+		if (ret) {
+			dev_warn(dev, "failed parsing state of %s\n", pll->name);
+			continue;
+		}
+
+		data->hws[i] = devm_clk_hw_register_fixed_factor_with_accuracy_fwname(
+				dev, np, pll->name, "ref", 0, mult, div, acc);
+		if (IS_ERR(data->hws[i])) {
+			dev_err(dev, "failed registering %s: %ld\n",
+			        pll->name, PTR_ERR(data->hws[i]));
+			data->hws[i] = ERR_PTR(-ENOENT);
+		}
+	}
+
+	/*
+	 * Register the OSPI table-based divider clock manually. This is
+	 * equivalent to drivers/clk/clk-divider.c, but using regmap to access
+	 * its register.
+	 */
+	i = ARRAY_SIZE(eq5c_plls);
+	data->hws[i] = eq5c_init_ospi_div(dev, data->hws[EQ5C_PLL_PER], olb);
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, data);
+	if (ret < 0) {
+		pr_err("failed registering clock provider: %d\n", ret);
+		return ret;
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
+static int __init eq5c_init(void)
+{
+	return platform_driver_register(&eq5c_driver);
+}
+arch_initcall(eq5c_init);

-- 
2.43.0


