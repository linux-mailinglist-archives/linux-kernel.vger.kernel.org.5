Return-Path: <linux-kernel+bounces-4136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 891D6817851
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D3BB22CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ABC7144C;
	Mon, 18 Dec 2023 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jwhL4RJf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75975A84B;
	Mon, 18 Dec 2023 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 34B1B1BF204;
	Mon, 18 Dec 2023 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702919667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0UEeHOIXuUz8Ts9qVxo2azVj8UAi0Ell/BQbvhIeVw=;
	b=jwhL4RJfnwbK7ag4+k4WLiVZE+4srTINdHkjBhJ1G9XY/qPY5ZiJ4qMJRCcR7mH6JPDAe6
	HtdLE0SzoyZaa7wCj47LTtTGNZND4bDG1T5Q2/DPWYNhJPiktRI+7HjNqnXDcmIbtmMz9l
	luEIFs96/IW+dCFgVS2GEe3e93uHCTkp9gnee6JvrPU1cW2EFzQGEMQ+UxzsHiKBXF0FQL
	NcGVm+HH3oMEEII6xp3DLOZ1vof+MT8sZUCcavB8H2rBdTmF38IJEOxtzuEzvBx9nEfiKW
	G9pC037H822BcEaTAgCzOZo7jnmZXVTySxG39GTNq4r2Y8+4s82uIJWlawD4hw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 18 Dec 2023 18:14:19 +0100
Subject: [PATCH 4/5] clk: eyeq5: add OSPI table-based divider clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231218-mbly-clk-v1-4-44ce54108f06@bootlin.com>
References: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com>
In-Reply-To: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com>
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

The driver supports PLLs on the platform. Add the single divider clock
of the platform.

Helpers from include/linux/clk-provider.h could have been used if it was
not for the use of regmap to access the register.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/clk/Kconfig     |   2 +-
 drivers/clk/clk-eyeq5.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 140 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 84fe0a89b8df..63cc354f41ab 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -227,7 +227,7 @@ config COMMON_CLK_EYEQ5
 		This drivers provides the fixed clocks found on the Mobileye EyeQ5
 		SoC. Its registers live in a shared register region called OLB.
 		It provides 10 read-only PLLs derived from the main crystal clock which
-		must be constant.
+		must be constant and one divider clock based on one PLLs.
 
 config COMMON_CLK_FSL_FLEXSPI
 	tristate "Clock driver for FlexSPI on Layerscape SoCs"
diff --git a/drivers/clk/clk-eyeq5.c b/drivers/clk/clk-eyeq5.c
index 74bcb8cec5c1..3382f4d870d7 100644
--- a/drivers/clk/clk-eyeq5.c
+++ b/drivers/clk/clk-eyeq5.c
@@ -3,8 +3,9 @@
  * PLL clock driver for the Mobileye EyeQ5 platform.
  *
  * This controller handles 10 read-only PLLs, all derived from the same main
- * crystal clock. The parent clock is expected to be constant. This driver is
- * custom to this platform, its registers live in a shared region called OLB.
+ * crystal clock. It also exposes one divider clock, a child of one of the
+ * PLLs. The parent clock is expected to be constant. This driver is custom to
+ * this platform, its registers live in a shared region called OLB.
  *
  * We use eq5c_ as prefix, as-in "EyeQ5 Clock", but way shorter.
  *
@@ -77,6 +78,8 @@ static const struct eq5c_pll {
 	[EQ5C_PLL_DDR1] = { .name = "pll-ddr1", .reg = OLB_PCSR_DDR1(0), },
 };
 
+#define EQ5C_OSPI_DIV_CLK_NAME	"div-ospi"
+
 static int eq5c_pll_parse_registers(u32 r0, u32 r1, unsigned long *mult,
 				    unsigned long *div, unsigned long *acc)
 {
@@ -131,6 +134,128 @@ static int eq5c_pll_parse_registers(u32 r0, u32 r1, unsigned long *mult,
 	return 0;
 }
 
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
+	struct regmap	*olb;
+};
+
+static struct eq5c_ospi_div *clk_hw_to_ospi_priv(struct clk_hw *hw)
+{
+	return container_of(hw, struct eq5c_ospi_div, hw);
+}
+
+static unsigned long eq5c_ospi_div_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct eq5c_ospi_div *div = clk_hw_to_ospi_priv(hw);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(div->olb, OLB_OSPI_REG, &val);
+
+	if (ret) {
+		pr_err("%s: regmap_read failed: %d\n", __func__, ret);
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
+	struct eq5c_ospi_div *div = clk_hw_to_ospi_priv(hw);
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
+		pr_err("%s: regmap_read failed: %d\n", __func__, ret);
+		return -ret;
+	}
+
+	val &= ~OLB_OSPI_DIV_MASK;
+	val |= FIELD_PREP(OLB_OSPI_DIV_MASK, value);
+
+	ret = regmap_write(div->olb, OLB_OSPI_REG, val);
+	if (ret) {
+		pr_err("%s: regmap_write failed: %d\n", __func__, ret);
+		return -ret;
+	}
+
+	return 0;
+}
+
+const struct clk_ops eq5c_ospi_div_ops = {
+	.recalc_rate = eq5c_ospi_div_recalc_rate,
+	.round_rate = eq5c_ospi_div_round_rate,
+	.determine_rate = eq5c_ospi_div_determine_rate,
+	.set_rate = eq5c_ospi_div_set_rate,
+};
+
+static struct clk_hw *eq5c_init_ospi_div(const struct clk_hw *parent,
+					 struct regmap *olb)
+{
+	struct eq5c_ospi_div *div;
+	int ret;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOENT);
+
+	div->olb = olb;
+	div->hw.init = CLK_HW_INIT_HW(EQ5C_OSPI_DIV_CLK_NAME, parent,
+				      &eq5c_ospi_div_ops, 0);
+
+	ret = clk_hw_register(NULL, &div->hw);
+	if (ret) {
+		pr_err("failed registering div_ospi: %d\n", ret);
+		kfree(div);
+		return ERR_PTR(-ENOENT);
+	}
+
+	return &div->hw;
+}
+
 static void eq5c_init(struct device_node *np)
 {
 	struct device_node *parent_np = of_get_parent(np);
@@ -139,13 +264,15 @@ static void eq5c_init(struct device_node *np)
 	struct clk_hw *parent_clk_hw;
 	struct clk *parent_clk;
 	struct regmap *olb;
+	size_t nb_clks;
 	int i;
 
-	data = kzalloc(struct_size(data, hws, ARRAY_SIZE(eq5c_plls)), GFP_KERNEL);
+	nb_clks = ARRAY_SIZE(eq5c_plls) + 1;
+	data = kzalloc(struct_size(data, hws, nb_clks), GFP_KERNEL);
 	if (!data)
 		return;
 
-	data->num = ARRAY_SIZE(eq5c_plls);
+	data->num = nb_clks;
 
 	/*
 	 * TODO: currently, if OLB is not available, we log an error and early
@@ -205,6 +332,14 @@ static void eq5c_init(struct device_node *np)
 		}
 	}
 
+	/*
+	 * Register the OSPI table-based divider clock manually. This is
+	 * equivalent to drivers/clk/clk-divider.c, but using regmap to access
+	 * its register.
+	 */
+	i = ARRAY_SIZE(eq5c_plls);
+	data->hws[i] = eq5c_init_ospi_div(data->hws[EQ5C_PLL_PER], olb);
+
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, data);
 }
 

-- 
2.43.0


