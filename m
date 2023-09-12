Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B347579C577
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjILEzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjILEyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:54:24 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C0C1FE3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso6605783a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494373; x=1695099173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfOxPGQfKjXfkNnPuJ/OeSKYAPD/q1dfgqgrBv3kVkw=;
        b=hn23a5cMk5yPYZXXM3LdZgCyW6MUZFBSRwaNyMbkLs5xfdVZDbwH2faKTnRD7q+S9E
         KUESwWd2IjDDJ+XfxJzrZqHxeRs/uQhNoQjhpFTJ/JrX09Bcrz0F0yaZebf34LkNCqr1
         dwUbTvz/qczaxmKN0maEDpTgsbHkf/Ur2Afd9WOcauJ8Td5YeYAGjwdP2Rshr8AtsuHD
         K7dxPYYNBUdanVcyRO7AFtMZ2seQQg+QVRR/L1o7iaQlbTbbodWoxVbrF3E2KZt7ifML
         LHxUr3VACf5MITfkDbxutCMs3YhqyRPq3cFTNg+45gwwQXFf2hCuSiLes+6aP+pdUaTO
         eJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494373; x=1695099173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfOxPGQfKjXfkNnPuJ/OeSKYAPD/q1dfgqgrBv3kVkw=;
        b=Q07gwEiwU4vOojpvSB20zFHxQbpN5i+0GDdXCLx2ZNOj6XmPvxjv5IubwQ17RmUWXW
         f3tnSVD+bPgSkXxrdOab4mnls5/ngsMQbkMgeFq8cuP2yfM6a2XHrl2Y18R9eczLczW2
         Vjn9waJ7bMxK9AC4A9T4UqxDi+iI1h5MZSlG85w1GQRdlP38xqQRVOAsdY2aiABuepFz
         KgHyMLsZhpfEdyoxcROeWvUYkqdLX94DwnhQezUUuIRo3xmMEJ3SDXp26Gqryhg1+5Wo
         ImtUxMliWqhjKtOO6K+vY6QbcgiSPAETQFRFhCyfDiVbTiz8zo5q87/3D3kHJ2z26l/z
         25eg==
X-Gm-Message-State: AOJu0YzM83e/OxFjKyXJN/wMhi2lcX7hjfF0bRdKS9FBdMruy6V7C5ub
        W+mKmFufE03RMGP5MCiFHDL2cg==
X-Google-Smtp-Source: AGHT+IGU1WPHSw0lqm0hTFTrUx5RpW+WGHsgEfDP6cv0MQkK6I+1T2s+UmIrxgg08txYv514E6KABA==
X-Received: by 2002:a50:fa88:0:b0:51e:5251:8f45 with SMTP id w8-20020a50fa88000000b0051e52518f45mr9881933edr.4.1694494373678;
        Mon, 11 Sep 2023 21:52:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:53 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 18/37] clk: renesas: rzg2l: refactor sd mux driver
Date:   Tue, 12 Sep 2023 07:51:38 +0300
Message-Id: <20230912045157.177966-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Refactor SD MUX driver to be able to reuse the same code on RZ/G3S.
RZ/G2{L, UL} has a limitation with regards to switching the clock source
for SD MUX (MUX clock source has to be switched to 266MHz before switching
b/w 533MHz and 400MHz). This limitation has been introduced as a clock
notifier that is registered on platform based initialization data thus the
SD MUX code could be reused on RZ/G3S.

As both RZ/G2{L, UL} and RZ/G3S has specific bits in specific registers
to check if the clock switching has been done, this configuration (register
offset, register bits and bits width) is now passed though
struct cpg_core_clk::sconf (status configuration) from platform specific
initialization code.

Along with struct cpg_core_clk::sconf the mux table indexes is also
passed from platform specific initialization code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c |  12 +-
 drivers/clk/renesas/r9a07g044-cpg.c |  12 +-
 drivers/clk/renesas/rzg2l-cpg.c     | 174 +++++++++++++++++++---------
 drivers/clk/renesas/rzg2l-cpg.h     |  17 ++-
 4 files changed, 154 insertions(+), 61 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index e87cbb54a640..791a38f1d2ec 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -21,6 +21,10 @@
 #define G2UL_SEL_SDHI0		SEL_PLL_PACK(G2UL_CPG_PL2SDHI_DSEL, 0, 2)
 #define G2UL_SEL_SDHI1		SEL_PLL_PACK(G2UL_CPG_PL2SDHI_DSEL, 4, 2)
 
+/* Clock status configuration. */
+#define G2UL_SEL_SDHI0_STS	SEL_PLL_PACK(CPG_CLKSTATUS, 28, 1)
+#define G2UL_SEL_SDHI1_STS	SEL_PLL_PACK(CPG_CLKSTATUS, 29, 1)
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A07G043_CLK_P0_DIV2,
@@ -85,6 +89,8 @@ static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
 static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
 static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
 
+static const u32 mtable_sdhi[] = {1, 2, 3};
+
 static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal", CLK_EXTAL),
@@ -130,8 +136,10 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_MUX("HP", R9A07G043_CLK_HP, SEL_PLL6_2, sel_pll6_2),
 	DEF_FIXED("SPI0", R9A07G043_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 	DEF_FIXED("SPI1", R9A07G043_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
-	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, G2UL_SEL_SDHI0, sel_shdi),
-	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, G2UL_SEL_SDHI1, sel_shdi),
+	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, G2UL_SEL_SDHI0, G2UL_SEL_SDHI0_STS, sel_shdi,
+		   mtable_sdhi, 0, SD_MUX_NOTIF),
+	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, G2UL_SEL_SDHI1, G2UL_SEL_SDHI0_STS, sel_shdi,
+		   mtable_sdhi, 0, SD_MUX_NOTIF),
 	DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G043_CLK_SD0, 1, 4),
 	DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G043_CLK_SD1, 1, 4),
 };
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 8911f6053a9f..ad9059116603 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -22,6 +22,10 @@
 #define G2L_SEL_SDHI0		SEL_PLL_PACK(G2L_CPG_PL2SDHI_DSEL, 0, 2)
 #define G2L_SEL_SDHI1		SEL_PLL_PACK(G2L_CPG_PL2SDHI_DSEL, 4, 2)
 
+/* Clock status configuration. */
+#define G2L_SEL_SDHI0_STS	SEL_PLL_PACK(CPG_CLKSTATUS, 28, 1)
+#define G2L_SEL_SDHI1_STS	SEL_PLL_PACK(CPG_CLKSTATUS, 29, 1)
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A07G054_CLK_DRP_A,
@@ -105,6 +109,8 @@ static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
 static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
 static const char * const sel_gpu2[] = { ".pll6", ".pll3_div2_2" };
 
+static const u32 mtable_sdhi[] = {1, 2, 3};
+
 static const struct {
 	struct cpg_core_clk common[56];
 #ifdef CONFIG_CLK_R9A07G054
@@ -170,8 +176,10 @@ static const struct {
 		DEF_MUX("HP", R9A07G044_CLK_HP, SEL_PLL6_2, sel_pll6_2),
 		DEF_FIXED("SPI0", R9A07G044_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 		DEF_FIXED("SPI1", R9A07G044_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
-		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, G2L_SEL_SDHI0, sel_shdi),
-		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, G2L_SEL_SDHI1, sel_shdi),
+		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, G2L_SEL_SDHI0, G2L_SEL_SDHI0_STS, sel_shdi,
+			   mtable_sdhi, 0, SD_MUX_NOTIF),
+		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, G2L_SEL_SDHI1, G2L_SEL_SDHI0_STS, sel_shdi,
+			   mtable_sdhi, 0, SD_MUX_NOTIF),
 		DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
 		DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
 		DEF_DIV("G", R9A07G044_CLK_G, CLK_SEL_GPU2, DIVGPU, dtable_1_8),
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 120bc8d51691..dd9229f0be7d 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -62,25 +62,29 @@
  * struct clk_hw_data - clock hardware data
  * @hw: clock hw
  * @conf: clock configuration (register offset, shift, width)
+ * @sconf: clock status configuration (register offset, shift, width)
  * @priv: CPG private data structure
  */
 struct clk_hw_data {
 	struct clk_hw hw;
 	u32 conf;
+	u32 sconf;
 	struct rzg2l_cpg_priv *priv;
 };
 
 #define to_clk_hw_data(_hw)	container_of(_hw, struct clk_hw_data, hw)
 
 /**
- * struct sd_hw_data - SD clock hardware data
+ * struct sd_mux_hw_data - SD MUX clock hardware data
  * @hw_data: clock hw data
+ * @mtable: clock mux table
  */
-struct sd_hw_data {
+struct sd_mux_hw_data {
 	struct clk_hw_data hw_data;
+	const u32 *mtable;
 };
 
-#define to_sd_hw_data(_hw)	container_of(_hw, struct sd_hw_data, hw_data)
+#define to_sd_mux_hw_data(_hw)	container_of(_hw, struct sd_mux_hw_data, hw_data)
 
 struct rzg2l_pll5_param {
 	u32 pl5_fracin;
@@ -137,6 +141,77 @@ static void rzg2l_cpg_del_clk_provider(void *data)
 	of_clk_del_provider(data);
 }
 
+/* Must be called in atomic context. */
+static int rzg2l_cpg_wait_clk_update_done(void __iomem *base, u32 conf)
+{
+	u32 bitmask = GENMASK(GET_WIDTH(conf) - 1, 0) << GET_SHIFT(conf);
+	u32 off = GET_REG_OFFSET(conf);
+	u32 val;
+
+	return readl_poll_timeout_atomic(base + off, val, !(val & bitmask), 100, 20000);
+}
+
+int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event,
+				  void *data)
+{
+	struct clk_notifier_data *cnd = data;
+	struct clk_hw *hw = __clk_get_hw(cnd->clk);
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 off = GET_REG_OFFSET(clk_hw_data->conf);
+	u32 shift = GET_SHIFT(clk_hw_data->conf);
+	const u32 clk_src_266 = 3;
+	unsigned long flags;
+	u32 bitmask;
+	int ret;
+
+	if (event != PRE_RATE_CHANGE || (cnd->new_rate / MEGA == 266))
+		return 0;
+
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+
+	/*
+	 * As per the HW manual, we should not directly switch from 533 MHz to
+	 * 400 MHz and vice versa. To change the setting from 2’b01 (533 MHz)
+	 * to 2’b10 (400 MHz) or vice versa, Switch to 2’b11 (266 MHz) first,
+	 * and then switch to the target setting (2’b01 (533 MHz) or 2’b10
+	 * (400 MHz)).
+	 * Setting a value of '0' to the SEL_SDHI0_SET or SEL_SDHI1_SET clock
+	 * switching register is prohibited.
+	 * The clock mux has 3 input clocks(533 MHz, 400 MHz, and 266 MHz), and
+	 * the index to value mapping is done by adding 1 to the index.
+	 */
+	bitmask = (GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0) << shift) << 16;
+	writel(bitmask | (clk_src_266 << shift), priv->base + off);
+
+	/* Wait for the update done. */
+	ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
+
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+
+	if (ret)
+		dev_err(priv->dev, "failed to switch to safe clk source\n");
+
+	return ret;
+}
+
+static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk *core,
+				   struct rzg2l_cpg_priv *priv)
+{
+	struct notifier_block *nb;
+
+	if (!core->notifier)
+		return 0;
+
+	nb = devm_kzalloc(priv->dev, sizeof(*nb), GFP_KERNEL);
+	if (!nb)
+		return -ENOMEM;
+
+	nb->notifier_call = core->notifier;
+
+	return clk_notifier_register(hw->clk, nb);
+}
+
 static struct clk * __init
 rzg2l_cpg_div_clk_register(const struct cpg_core_clk *core,
 			   struct clk **clks,
@@ -197,72 +272,54 @@ rzg2l_cpg_mux_clk_register(const struct cpg_core_clk *core,
 	return clk_hw->clk;
 }
 
-static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+static u8 rzg2l_cpg_sd_mux_clk_get_parent(struct clk_hw *hw)
+{
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct sd_mux_hw_data *sd_mux_hw_data = to_sd_mux_hw_data(clk_hw_data);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 val;
+
+	val = readl(priv->base + GET_REG_OFFSET(clk_hw_data->conf));
+	val >>= GET_SHIFT(clk_hw_data->conf);
+	val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
+
+	return clk_mux_val_to_index(hw, sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, val);
+}
+
+static int rzg2l_cpg_sd_mux_clk_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct sd_mux_hw_data *sd_mux_hw_data = to_sd_mux_hw_data(clk_hw_data);
 	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
 	u32 off = GET_REG_OFFSET(clk_hw_data->conf);
 	u32 shift = GET_SHIFT(clk_hw_data->conf);
-	const u32 clk_src_266 = 2;
-	u32 msk, val, bitmask;
 	unsigned long flags;
+	u32 bitmask, val;
 	int ret;
 
-	/*
-	 * As per the HW manual, we should not directly switch from 533 MHz to
-	 * 400 MHz and vice versa. To change the setting from 2’b01 (533 MHz)
-	 * to 2’b10 (400 MHz) or vice versa, Switch to 2’b11 (266 MHz) first,
-	 * and then switch to the target setting (2’b01 (533 MHz) or 2’b10
-	 * (400 MHz)).
-	 * Setting a value of '0' to the SEL_SDHI0_SET or SEL_SDHI1_SET clock
-	 * switching register is prohibited.
-	 * The clock mux has 3 input clocks(533 MHz, 400 MHz, and 266 MHz), and
-	 * the index to value mapping is done by adding 1 to the index.
-	 */
+	val = clk_mux_index_to_val(sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, index);
+
 	bitmask = (GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0) << shift) << 16;
+
 	spin_lock_irqsave(&priv->rmw_lock, flags);
-	if (index != clk_src_266) {
-		writel(bitmask | ((clk_src_266 + 1) << shift), priv->base + off);
 
-		msk = off ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
+	writel(bitmask | (val << shift), priv->base + off);
 
-		ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
-						!(val & msk), 100,
-						CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
-		if (ret)
-			goto unlock;
-	}
+	/* Wait for the update done. */
+	ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
 
-	writel(bitmask | ((index + 1) << shift), priv->base + off);
-
-	ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
-					!(val & msk), 100,
-					CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
-unlock:
 	spin_unlock_irqrestore(&priv->rmw_lock, flags);
 
 	if (ret)
-		dev_err(priv->dev, "failed to switch clk source\n");
+		dev_err(priv->dev, "Failed to switch parent\n");
 
 	return ret;
 }
 
-static u8 rzg2l_cpg_sd_clk_mux_get_parent(struct clk_hw *hw)
-{
-	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
-	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
-	u32 val = readl(priv->base + GET_REG_OFFSET(clk_hw_data->conf));
-
-	val >>= GET_SHIFT(clk_hw_data->conf);
-	val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
-
-	return val ? --val : val;
-}
-
 static const struct clk_ops rzg2l_cpg_sd_clk_mux_ops = {
 	.determine_rate = __clk_mux_determine_rate_closest,
-	.set_parent	= rzg2l_cpg_sd_clk_mux_set_parent,
-	.get_parent	= rzg2l_cpg_sd_clk_mux_get_parent,
+	.set_parent	= rzg2l_cpg_sd_mux_clk_set_parent,
+	.get_parent	= rzg2l_cpg_sd_mux_clk_get_parent,
 };
 
 static struct clk * __init
@@ -270,31 +327,40 @@ rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
 			      void __iomem *base,
 			      struct rzg2l_cpg_priv *priv)
 {
-	struct sd_hw_data *sd_hw_data;
+	struct sd_mux_hw_data *sd_mux_hw_data;
 	struct clk_init_data init;
 	struct clk_hw *clk_hw;
 	int ret;
 
-	sd_hw_data = devm_kzalloc(priv->dev, sizeof(*sd_hw_data), GFP_KERNEL);
-	if (!sd_hw_data)
+	sd_mux_hw_data = devm_kzalloc(priv->dev, sizeof(*sd_mux_hw_data), GFP_KERNEL);
+	if (!sd_mux_hw_data)
 		return ERR_PTR(-ENOMEM);
 
-	sd_hw_data->hw_data.priv = priv;
-	sd_hw_data->hw_data.conf = core->conf;
+	sd_mux_hw_data->hw_data.priv = priv;
+	sd_mux_hw_data->hw_data.conf = core->conf;
+	sd_mux_hw_data->hw_data.sconf = core->sconf;
+	sd_mux_hw_data->mtable = core->mtable;
 
 	init.name = core->name;
 	init.ops = &rzg2l_cpg_sd_clk_mux_ops;
-	init.flags = 0;
+	init.flags = core->flag;
 	init.num_parents = core->num_parents;
 	init.parent_names = core->parent_names;
 
-	clk_hw = &sd_hw_data->hw_data.hw;
+	clk_hw = &sd_mux_hw_data->hw_data.hw;
 	clk_hw->init = &init;
 
 	ret = devm_clk_hw_register(priv->dev, clk_hw);
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = rzg2l_register_notifier(clk_hw, core, priv);
+	if (ret) {
+		dev_err(priv->dev, "Failed to register notifier for %s\n",
+			core->name);
+		return ERR_PTR(ret);
+	}
+
 	return clk_hw->clk;
 }
 
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 99a82567d1f8..140b6b04a091 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -9,6 +9,8 @@
 #ifndef __RENESAS_RZG2L_CPG_H__
 #define __RENESAS_RZG2L_CPG_H__
 
+#include <linux/notifier.h>
+
 #define CPG_SIPLL5_STBY		(0x140)
 #define CPG_SIPLL5_CLK1		(0x144)
 #define CPG_SIPLL5_CLK3		(0x14C)
@@ -86,8 +88,11 @@ struct cpg_core_clk {
 	unsigned int mult;
 	unsigned int type;
 	unsigned int conf;
+	unsigned int sconf;
 	const struct clk_div_table *dtable;
+	const u32 *mtable;
 	const char * const *parent_names;
+	notifier_fn_t notifier;
 	u32 flag;
 	u32 mux_flags;
 	int num_parents;
@@ -150,10 +155,11 @@ enum clk_types {
 		 .parent_names = _parent_names, \
 		 .num_parents = ARRAY_SIZE(_parent_names), \
 		 .mux_flags = CLK_MUX_READ_ONLY)
-#define DEF_SD_MUX(_name, _id, _conf, _parent_names) \
-	DEF_TYPE(_name, _id, CLK_TYPE_SD_MUX, .conf = _conf, \
+#define DEF_SD_MUX(_name, _id, _conf, _sconf, _parent_names, _mtable, _clk_flags, _notifier) \
+	DEF_TYPE(_name, _id, CLK_TYPE_SD_MUX, .conf = _conf, .sconf = _sconf, \
 		 .parent_names = _parent_names, \
-		 .num_parents = ARRAY_SIZE(_parent_names))
+		 .num_parents = ARRAY_SIZE(_parent_names), \
+		 .mtable = _mtable, .flag = _clk_flags, .notifier = _notifier)
 #define DEF_PLL5_FOUTPOSTDIV(_name, _id, _parent) \
 	DEF_TYPE(_name, _id, CLK_TYPE_SIPLL5, .parent = _parent)
 #define DEF_PLL5_4_MUX(_name, _id, _conf, _parent_names) \
@@ -272,4 +278,9 @@ extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
 extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
 extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
 
+int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event, void *data);
+
+/* Macros to be used in platform specific initialization code. */
+#define SD_MUX_NOTIF		(&rzg2l_cpg_sd_mux_clk_notifier)
+
 #endif
-- 
2.39.2

