Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D07C80AA3A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574070AbjLHRND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjLHRNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:13:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641E81712
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:13:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBEDC433C8;
        Fri,  8 Dec 2023 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702055586;
        bh=k641xO4S6rZ07oG/ZPMOg0OdXInn1b9tfMjVyJWM8hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nVnI1uxNwOzJvHfVd2al8nVTX1RK3HdlLC1QcltVR0AUaFSGUjJFP5CHRcQDo7hwq
         oHWX0oswDsCJ5tbxseGg3Ol8oi7ZvW9lj5euq6yYHuejTEild9LPFvgI8rYwszI980
         AgUZOkLKIT4FMb9eXrQvBlYlT12V2a+zDjqKaPrSktom/YLLSmOiue+XyEtg+QAFEc
         qjdZwGYTDDeTk2dRdxkCn94wrz8JP4VMyRzJ7eF4pmZZBNdvq0raiPPRJxinCaTR13
         G1SxWSuQvMPIh5donNcOg1UImvSHBwceabGwT3p3qi7plaYZxQcwHbJfJkzPE1YZ0+
         FxcTdEPc7pBBw==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH RESEND v1 3/7] clk: microchip: mpfs: split MSSPLL in two
Date:   Fri,  8 Dec 2023 17:12:25 +0000
Message-Id: <20231208-grab-conjuror-3ced7f366d70@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231208-reenter-ajar-b6223e5134b3@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10024; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=NRUa1qYUK0JELxAGivzxtKy665djDR3m4OsIk9VTjD8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnFfuVf5sjUml/U+cl268rVfXf+Z1/yP2YTtiq2a+asM JGQyCmJHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjI/JOMDA8Xaeg9jb9zbFq1 +1xHS854gzm7Dgi/X5V24VwQy/nly9UYGfbrJgkGTijR/vuCyZZZae9/hrgLsjFtZ56IyS4WklM zYgIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The MSSPLL is really two stages - there's the PLL itself and 4 outputs,
each with their own divider. The current driver models this as a single
entity, outputting a single clock, used for both the CPU and AHB/AXI
buses. The other 3 outputs are used for the eMMC, "user crypto" and CAN
controller. Split the MSSPLL in two, as a precursor to adding support
for the other 3 outputs, with the PLL itself as one "hw" clock and the
output divider stage as another.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 188 ++++++++++++++++++++-----------
 1 file changed, 123 insertions(+), 65 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index c8ffa755b58d..b05bdab10cdc 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -30,6 +30,13 @@
 #define MSSPLL_POSTDIV_WIDTH	0x07u
 #define MSSPLL_FIXED_DIV	4u
 
+/*
+ * This clock ID is defined here, rather than the binding headers, as it is an
+ * internal clock only, and therefore has no consumers in other peripheral
+ * blocks.
+ */
+#define CLK_MSSPLL_INTERNAL	38u
+
 struct mpfs_clock_data {
 	struct device *dev;
 	void __iomem *base;
@@ -39,17 +46,27 @@ struct mpfs_clock_data {
 
 struct mpfs_msspll_hw_clock {
 	void __iomem *base;
+	struct clk_hw hw;
+	struct clk_init_data init;
 	unsigned int id;
 	u32 reg_offset;
 	u32 shift;
 	u32 width;
 	u32 flags;
-	struct clk_hw hw;
-	struct clk_init_data init;
 };
 
 #define to_mpfs_msspll_clk(_hw) container_of(_hw, struct mpfs_msspll_hw_clock, hw)
 
+struct mpfs_msspll_out_hw_clock {
+	void __iomem *base;
+	struct clk_hw hw;
+	struct clk_init_data init;
+	unsigned int id;
+	u32 flags;
+};
+
+#define to_mpfs_msspll_out_clk(_hw) container_of(_hw, struct mpfs_msspll_out_hw_clock, hw)
+
 struct mpfs_cfg_hw_clock {
 	struct clk_divider cfg;
 	struct clk_init_data init;
@@ -93,93 +110,40 @@ static const struct clk_div_table mpfs_div_rtcref_table[] = {
 	{ 0, 0 }
 };
 
+/*
+ * MSS PLL internal clock
+ */
+
 static unsigned long mpfs_clk_msspll_recalc_rate(struct clk_hw *hw, unsigned long prate)
-{
-	struct mpfs_msspll_hw_clock *msspll_hw = to_mpfs_msspll_clk(hw);
-	void __iomem *mult_addr = msspll_hw->base + msspll_hw->reg_offset;
-	void __iomem *ref_div_addr = msspll_hw->base + REG_MSSPLL_REF_CR;
-	void __iomem *postdiv_addr = msspll_hw->base + REG_MSSPLL_POSTDIV_CR;
-	u32 mult, ref_div, postdiv;
-
-	mult = readl_relaxed(mult_addr) >> MSSPLL_FBDIV_SHIFT;
-	mult &= clk_div_mask(MSSPLL_FBDIV_WIDTH);
-	ref_div = readl_relaxed(ref_div_addr) >> MSSPLL_REFDIV_SHIFT;
-	ref_div &= clk_div_mask(MSSPLL_REFDIV_WIDTH);
-	postdiv = readl_relaxed(postdiv_addr) >> MSSPLL_POSTDIV_SHIFT;
-	postdiv &= clk_div_mask(MSSPLL_POSTDIV_WIDTH);
-
-	return prate * mult / (ref_div * MSSPLL_FIXED_DIV * postdiv);
-}
-
-static long mpfs_clk_msspll_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *prate)
 {
 	struct mpfs_msspll_hw_clock *msspll_hw = to_mpfs_msspll_clk(hw);
 	void __iomem *mult_addr = msspll_hw->base + msspll_hw->reg_offset;
 	void __iomem *ref_div_addr = msspll_hw->base + REG_MSSPLL_REF_CR;
 	u32 mult, ref_div;
-	unsigned long rate_before_ctrl;
 
 	mult = readl_relaxed(mult_addr) >> MSSPLL_FBDIV_SHIFT;
 	mult &= clk_div_mask(MSSPLL_FBDIV_WIDTH);
 	ref_div = readl_relaxed(ref_div_addr) >> MSSPLL_REFDIV_SHIFT;
 	ref_div &= clk_div_mask(MSSPLL_REFDIV_WIDTH);
 
-	rate_before_ctrl = rate * (ref_div * MSSPLL_FIXED_DIV) / mult;
-
-	return divider_round_rate(hw, rate_before_ctrl, prate, NULL, MSSPLL_POSTDIV_WIDTH,
-				  msspll_hw->flags);
-}
-
-static int mpfs_clk_msspll_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long prate)
-{
-	struct mpfs_msspll_hw_clock *msspll_hw = to_mpfs_msspll_clk(hw);
-	void __iomem *mult_addr = msspll_hw->base + msspll_hw->reg_offset;
-	void __iomem *ref_div_addr = msspll_hw->base + REG_MSSPLL_REF_CR;
-	void __iomem *postdiv_addr = msspll_hw->base + REG_MSSPLL_POSTDIV_CR;
-	u32 mult, ref_div, postdiv;
-	int divider_setting;
-	unsigned long rate_before_ctrl, flags;
-
-	mult = readl_relaxed(mult_addr) >> MSSPLL_FBDIV_SHIFT;
-	mult &= clk_div_mask(MSSPLL_FBDIV_WIDTH);
-	ref_div = readl_relaxed(ref_div_addr) >> MSSPLL_REFDIV_SHIFT;
-	ref_div &= clk_div_mask(MSSPLL_REFDIV_WIDTH);
-
-	rate_before_ctrl = rate * (ref_div * MSSPLL_FIXED_DIV) / mult;
-	divider_setting = divider_get_val(rate_before_ctrl, prate, NULL, MSSPLL_POSTDIV_WIDTH,
-					  msspll_hw->flags);
-
-	if (divider_setting < 0)
-		return divider_setting;
-
-	spin_lock_irqsave(&mpfs_clk_lock, flags);
-
-	postdiv = readl_relaxed(postdiv_addr);
-	postdiv &= ~(clk_div_mask(MSSPLL_POSTDIV_WIDTH) << MSSPLL_POSTDIV_SHIFT);
-	writel_relaxed(postdiv, postdiv_addr);
-
-	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
-
-	return 0;
+	return prate * mult / (ref_div * MSSPLL_FIXED_DIV);
 }
 
 static const struct clk_ops mpfs_clk_msspll_ops = {
 	.recalc_rate = mpfs_clk_msspll_recalc_rate,
-	.round_rate = mpfs_clk_msspll_round_rate,
-	.set_rate = mpfs_clk_msspll_set_rate,
 };
 
 #define CLK_PLL(_id, _name, _parent, _shift, _width, _flags, _offset) {			\
 	.id = _id,									\
+	.flags = _flags,								\
 	.shift = _shift,								\
 	.width = _width,								\
 	.reg_offset = _offset,								\
-	.flags = _flags,								\
 	.hw.init = CLK_HW_INIT_PARENTS_DATA(_name, _parent, &mpfs_clk_msspll_ops, 0),	\
 }
 
 static struct mpfs_msspll_hw_clock mpfs_msspll_clks[] = {
-	CLK_PLL(CLK_MSSPLL, "clk_msspll", mpfs_ext_ref, MSSPLL_FBDIV_SHIFT,
+	CLK_PLL(CLK_MSSPLL_INTERNAL, "clk_msspll_internal", mpfs_ext_ref, MSSPLL_FBDIV_SHIFT,
 		MSSPLL_FBDIV_WIDTH, 0, REG_MSSPLL_SSCG_2_CR),
 };
 
@@ -196,7 +160,7 @@ static int mpfs_clk_register_mssplls(struct device *dev, struct mpfs_msspll_hw_c
 		ret = devm_clk_hw_register(dev, &msspll_hw->hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register msspll id: %d\n",
-					     CLK_MSSPLL);
+					     CLK_MSSPLL_INTERNAL);
 
 		data->hw_data.hws[msspll_hw->id] = &msspll_hw->hw;
 	}
@@ -204,6 +168,94 @@ static int mpfs_clk_register_mssplls(struct device *dev, struct mpfs_msspll_hw_c
 	return 0;
 }
 
+/*
+ * MSS PLL output clocks
+ */
+
+static unsigned long mpfs_clk_msspll_out_recalc_rate(struct clk_hw *hw, unsigned long prate)
+{
+	struct mpfs_msspll_out_hw_clock *msspll_out_hw = to_mpfs_msspll_out_clk(hw);
+	void __iomem *postdiv_addr = msspll_out_hw->base + REG_MSSPLL_POSTDIV_CR;
+	u32 postdiv;
+
+	postdiv = readl_relaxed(postdiv_addr) >> MSSPLL_POSTDIV_SHIFT;
+	postdiv &= clk_div_mask(MSSPLL_POSTDIV_WIDTH);
+
+	return prate / postdiv;
+}
+
+static long mpfs_clk_msspll_out_round_rate(struct clk_hw *hw, unsigned long rate,
+					   unsigned long *prate)
+{
+	struct mpfs_msspll_out_hw_clock *msspll_out_hw = to_mpfs_msspll_out_clk(hw);
+
+	return divider_round_rate(hw, rate, prate, NULL, MSSPLL_POSTDIV_WIDTH,
+				  msspll_out_hw->flags);
+}
+
+static int mpfs_clk_msspll_out_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long prate)
+{
+	struct mpfs_msspll_out_hw_clock *msspll_out_hw = to_mpfs_msspll_out_clk(hw);
+	void __iomem *postdiv_addr = msspll_out_hw->base + REG_MSSPLL_POSTDIV_CR;
+	u32 postdiv;
+	int divider_setting;
+	unsigned long flags;
+
+	divider_setting = divider_get_val(rate, prate, NULL, MSSPLL_POSTDIV_WIDTH,
+					  msspll_out_hw->flags);
+
+	if (divider_setting < 0)
+		return divider_setting;
+
+	spin_lock_irqsave(&mpfs_clk_lock, flags);
+
+	postdiv = readl_relaxed(postdiv_addr);
+	postdiv &= ~(clk_div_mask(MSSPLL_POSTDIV_WIDTH) << MSSPLL_POSTDIV_SHIFT);
+	writel_relaxed(postdiv, postdiv_addr);
+
+	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops mpfs_clk_msspll_out_ops = {
+	.recalc_rate = mpfs_clk_msspll_out_recalc_rate,
+	.round_rate = mpfs_clk_msspll_out_round_rate,
+	.set_rate = mpfs_clk_msspll_out_set_rate,
+};
+
+#define CLK_PLL_OUT(_id, _name, _parent, _flags) {				\
+	.id = _id,								\
+	.flags = _flags,							\
+	.hw.init = CLK_HW_INIT(_name, _parent, &mpfs_clk_msspll_out_ops, 0),	\
+}
+
+static struct mpfs_msspll_out_hw_clock mpfs_msspll_out_clks[] = {
+	CLK_PLL_OUT(CLK_MSSPLL, "clk_msspll", "clk_msspll_internal", 0),
+};
+
+static int mpfs_clk_register_msspll_outs(struct device *dev,
+					 struct mpfs_msspll_out_hw_clock *msspll_out_hws,
+					 unsigned int num_clks, struct mpfs_clock_data *data)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < num_clks; i++) {
+		struct mpfs_msspll_out_hw_clock *msspll_out_hw = &msspll_out_hws[i];
+
+		msspll_out_hw->base = data->msspll_base;
+		ret = devm_clk_hw_register(dev, &msspll_out_hw->hw);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to register msspll out id: %d\n",
+					     msspll_out_hw->id);
+
+		data->hw_data.hws[msspll_out_hw->id] = &msspll_out_hw->hw;
+	}
+
+	return 0;
+}
+
 /*
  * "CFG" clocks
  */
@@ -442,8 +494,8 @@ static int mpfs_clk_probe(struct platform_device *pdev)
 	int ret;
 
 	/* CLK_RESERVED is not part of clock arrays, so add 1 */
-	num_clks = ARRAY_SIZE(mpfs_msspll_clks) + ARRAY_SIZE(mpfs_cfg_clks)
-		   + ARRAY_SIZE(mpfs_periph_clks) + 1;
+	num_clks = ARRAY_SIZE(mpfs_msspll_clks) + ARRAY_SIZE(mpfs_msspll_out_clks)
+		   + ARRAY_SIZE(mpfs_cfg_clks)  + ARRAY_SIZE(mpfs_periph_clks) + 1;
 
 	clk_data = devm_kzalloc(dev, struct_size(clk_data, hw_data.hws, num_clks), GFP_KERNEL);
 	if (!clk_data)
@@ -466,6 +518,12 @@ static int mpfs_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = mpfs_clk_register_msspll_outs(dev, mpfs_msspll_out_clks,
+					    ARRAY_SIZE(mpfs_msspll_out_clks),
+					    clk_data);
+	if (ret)
+		return ret;
+
 	ret = mpfs_clk_register_cfgs(dev, mpfs_cfg_clks, ARRAY_SIZE(mpfs_cfg_clks), clk_data);
 	if (ret)
 		return ret;
-- 
2.39.2

