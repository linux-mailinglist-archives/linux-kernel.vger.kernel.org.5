Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A57BB580
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjJFKkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjJFKkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:40:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE6CFE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:40:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9936b3d0286so361892266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696588825; x=1697193625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFxFQ6npoR/Zi60Uj/VQGQ19HPH33kbIj7Y18tuYJQk=;
        b=NGzwopHj9C305jQ5sV50EdB6OT9CqyQwMBDyDZ7LxOEE3AcRQUQlnV2fvORJsCt1i0
         gvj/RvflIYm+CSjrYHQuPI+N4cdWnNiHe1FTVi4kwZU4D8rl60u2v6es5nvt4biRLja+
         WsvwmKIdftxFOAz7PbZxOChSWeJPGqB44tdlu1HhOc6Epkvq+8vz/am2tsZhfq7TXVDx
         T1qlX6KZh1ysOAzT0SDH3jogw8ugmDX2KzdYsdj2KwPiEW3g46KAB/vV817P308sVBGN
         EJCK731SXntMx3IImYJu3OWZiZLN/pKJoMaftQTTGZSZs6+3PRs1L2VYVoXdCQ2Wkfyr
         kEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696588825; x=1697193625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFxFQ6npoR/Zi60Uj/VQGQ19HPH33kbIj7Y18tuYJQk=;
        b=IphRNNyRtVGmxubhiXqERQDkShhFg31PIVaAzgUwsHvhrIZanyz2NmEjfsyI+O4oJS
         GBXsFpLF7fxaeuTyyXRYTzIzVL10ZzZ0LHbz7/oXET9T3qU6cslWmKH+cOy9LsyZh8P6
         T1zBnnbnUnTHG3FmcjHDR8q7LM9mkonrSuRSx1/kFpmCEWw6B019vrub7qmnae2Ikg0l
         4ldXE72UlKF1QrvHHmVM+2XIEmIG5E83Zbg5MEJUFEHa/Izi3IQUtFcoSoOB/zoC2NC5
         zMPA9GcxoJULkQGbr9SQoOafQAKCHZEglud6HqwNT6yl51Ij+gwknSWqkmv2m1FovUPy
         zRiA==
X-Gm-Message-State: AOJu0YwEqsccEhqwKV0W9lwuX4Zf5QIUNzcUVauVD1bqS+TrAwpr8GSM
        jIjowl/civEVKNIwcTXvn+ocMw==
X-Google-Smtp-Source: AGHT+IHBBe2Fb+XZfKR/qZ9UebA52z4fBMY+Upob1EQez9ZqlPMGJU/IRlVAJAnG8ABW8xP/CamAOA==
X-Received: by 2002:a17:907:77cf:b0:9ae:4b25:d89f with SMTP id kz15-20020a17090777cf00b009ae4b25d89fmr8062324ejc.6.1696588825034;
        Fri, 06 Oct 2023 03:40:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.24])
        by smtp.gmail.com with ESMTPSA id br13-20020a170906d14d00b0099cb349d570sm2642490ejb.185.2023.10.06.03.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:40:24 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, magnus.damm@gmail.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 2/4] clk: renesas: rzg2l: refactor sd mux driver
Date:   Fri,  6 Oct 2023 13:39:57 +0300
Message-Id: <20231006103959.197485-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231006103959.197485-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231006103959.197485-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Along with struct cpg_core_clk::sconf the mux table indices are also
passed from platform specific initialization code.

Also, mux flags are now passed to DEF_SD_MUX() as they will be later
used by RZ/G3S.

CPG_WEN_BIT macro has been introduced to select propertly the WEN bit
of various registers.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- return proper value from notifier
- kept old names for members of rzg2l_cpg_sd_clk_mux_ops object
- s/rzg2l_cpg_sd_mux_clk_notifier/rzg2l_cpg_sd_clk_mux_notifier/g
- introduced CPG_WEN_BIT macro to set WEN bits of various registers
  with this functionality
- removed bitmask variable from rzg2l_cpg_sd_clk_mux_notifier() and
  rzg2l_cpg_sd_clk_mux_set_parent() as it is no longer needed
- tested on RZ/G2L and RZ/G3S

Changes in v2:
- s/indexes/indices in commit description
- mentioned in commit description that mux flags can now be passed to
  driver though DEF_SD_MUX() macro
- removed SoC specific names from macros' names
- added spaces after { and before } when initializing arrays
- preserved the order of .[gs]set_parent() API definitions for simpler
  diff b/w versions
- removed SD_MUX_NOTIF macro

 drivers/clk/renesas/r9a07g043-cpg.c |  12 ++-
 drivers/clk/renesas/r9a07g044-cpg.c |  12 ++-
 drivers/clk/renesas/rzg2l-cpg.c     | 150 ++++++++++++++++++++--------
 drivers/clk/renesas/rzg2l-cpg.h     |  16 ++-
 4 files changed, 139 insertions(+), 51 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index e0ae25644e1a..b70bb378ab46 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -21,6 +21,10 @@
 #define SEL_SDHI0		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 0, 2)
 #define SEL_SDHI1		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 4, 2)
 
+/* Clock status configuration. */
+#define SEL_SDHI0_STS		SEL_PLL_PACK(CPG_CLKSTATUS, 28, 1)
+#define SEL_SDHI1_STS		SEL_PLL_PACK(CPG_CLKSTATUS, 29, 1)
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A07G043_CLK_P0_DIV2,
@@ -85,6 +89,8 @@ static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
 static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
 static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
 
+static const u32 mtable_sdhi[] = { 1, 2, 3 };
+
 static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal", CLK_EXTAL),
@@ -130,8 +136,10 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_MUX("HP", R9A07G043_CLK_HP, SEL_PLL6_2, sel_pll6_2),
 	DEF_FIXED("SPI0", R9A07G043_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 	DEF_FIXED("SPI1", R9A07G043_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
-	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, SEL_SDHI0, sel_shdi),
-	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, SEL_SDHI1, sel_shdi),
+	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, SEL_SDHI0, SEL_SDHI0_STS, sel_shdi,
+		   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
+	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, SEL_SDHI1, SEL_SDHI0_STS, sel_shdi,
+		   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
 	DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G043_CLK_SD0, 1, 4),
 	DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G043_CLK_SD1, 1, 4),
 };
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index d4dcf5d896d4..1047278c9079 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -22,6 +22,10 @@
 #define SEL_SDHI0		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 0, 2)
 #define SEL_SDHI1		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 4, 2)
 
+/* Clock status configuration. */
+#define SEL_SDHI0_STS		SEL_PLL_PACK(CPG_CLKSTATUS, 28, 1)
+#define SEL_SDHI1_STS		SEL_PLL_PACK(CPG_CLKSTATUS, 29, 1)
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A07G054_CLK_DRP_A,
@@ -105,6 +109,8 @@ static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
 static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
 static const char * const sel_gpu2[] = { ".pll6", ".pll3_div2_2" };
 
+static const u32 mtable_sdhi[] = { 1, 2, 3 };
+
 static const struct {
 	struct cpg_core_clk common[56];
 #ifdef CONFIG_CLK_R9A07G054
@@ -170,8 +176,10 @@ static const struct {
 		DEF_MUX("HP", R9A07G044_CLK_HP, SEL_PLL6_2, sel_pll6_2),
 		DEF_FIXED("SPI0", R9A07G044_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 		DEF_FIXED("SPI1", R9A07G044_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
-		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0, sel_shdi),
-		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1, sel_shdi),
+		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0, SEL_SDHI0_STS, sel_shdi,
+			   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
+		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1, SEL_SDHI0_STS, sel_shdi,
+			   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
 		DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
 		DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
 		DEF_DIV("G", R9A07G044_CLK_G, CLK_SEL_GPU2, DIVGPU, dtable_1_8),
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 6ca81d22c669..8f927568a3c8 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -61,31 +61,37 @@
 #define GET_REG_SAMPLL_CLK1(val)	((val >> 22) & 0xfff)
 #define GET_REG_SAMPLL_CLK2(val)	((val >> 12) & 0xfff)
 
+#define CPG_WEN_BIT		BIT(16)
+
 #define MAX_VCLK_FREQ		(148500000)
 
 /**
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
@@ -142,6 +148,76 @@ static void rzg2l_cpg_del_clk_provider(void *data)
 	of_clk_del_provider(data);
 }
 
+/* Must be called in atomic context. */
+static int rzg2l_cpg_wait_clk_update_done(void __iomem *base, u32 conf)
+{
+	u32 bitmask = GENMASK(GET_WIDTH(conf) - 1, 0) << GET_SHIFT(conf);
+	u32 off = GET_REG_OFFSET(conf);
+	u32 val;
+
+	return readl_poll_timeout_atomic(base + off, val, !(val & bitmask), 10, 200);
+}
+
+int rzg2l_cpg_sd_clk_mux_notifier(struct notifier_block *nb, unsigned long event,
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
+	int ret;
+
+	if (event != PRE_RATE_CHANGE || (cnd->new_rate / MEGA == 266))
+		return NOTIFY_DONE;
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
+
+	writel((CPG_WEN_BIT | clk_src_266) << shift, priv->base + off);
+
+	/* Wait for the update done. */
+	ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
+
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+
+	if (ret)
+		dev_err(priv->dev, "failed to switch to safe clk source\n");
+
+	return notifier_from_errno(ret);
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
@@ -205,48 +281,27 @@ rzg2l_cpg_mux_clk_register(const struct cpg_core_clk *core,
 static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct sd_mux_hw_data *sd_mux_hw_data = to_sd_mux_hw_data(clk_hw_data);
 	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
 	u32 off = GET_REG_OFFSET(clk_hw_data->conf);
 	u32 shift = GET_SHIFT(clk_hw_data->conf);
-	const u32 clk_src_266 = 2;
-	u32 msk, val, bitmask;
 	unsigned long flags;
+	u32 val;
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
-	bitmask = (GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0) << shift) << 16;
-	msk = off ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
+	val = clk_mux_index_to_val(sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, index);
+
 	spin_lock_irqsave(&priv->rmw_lock, flags);
-	if (index != clk_src_266) {
-		writel(bitmask | ((clk_src_266 + 1) << shift), priv->base + off);
-
-		ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
-						!(val & msk), 10,
-						CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
-		if (ret)
-			goto unlock;
-	}
 
-	writel(bitmask | ((index + 1) << shift), priv->base + off);
+	writel((CPG_WEN_BIT | val) << shift, priv->base + off);
+
+	/* Wait for the update done. */
+	ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
 
-	ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
-					!(val & msk), 10,
-					CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
-unlock:
 	spin_unlock_irqrestore(&priv->rmw_lock, flags);
 
 	if (ret)
-		dev_err(priv->dev, "failed to switch clk source\n");
+		dev_err(priv->dev, "Failed to switch parent\n");
 
 	return ret;
 }
@@ -254,13 +309,15 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 static u8 rzg2l_cpg_sd_clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct sd_mux_hw_data *sd_mux_hw_data = to_sd_mux_hw_data(clk_hw_data);
 	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
-	u32 val = readl(priv->base + GET_REG_OFFSET(clk_hw_data->conf));
+	u32 val;
 
+	val = readl(priv->base + GET_REG_OFFSET(clk_hw_data->conf));
 	val >>= GET_SHIFT(clk_hw_data->conf);
 	val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
 
-	return val ? val - 1 : 0;
+	return clk_mux_val_to_index(hw, sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, val);
 }
 
 static const struct clk_ops rzg2l_cpg_sd_clk_mux_ops = {
@@ -274,31 +331,40 @@ rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
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
index f5382333d327..f1910913b29a 100644
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
@@ -42,8 +44,6 @@
 #define CPG_CLKSTATUS_SELSDHI0_STS	BIT(28)
 #define CPG_CLKSTATUS_SELSDHI1_STS	BIT(29)
 
-#define CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US	200
-
 /* n = 0/1/2 for PLL1/4/6 */
 #define CPG_SAMPLL_CLK1(n)	(0x04 + (16 * n))
 #define CPG_SAMPLL_CLK2(n)	(0x08 + (16 * n))
@@ -86,8 +86,11 @@ struct cpg_core_clk {
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
@@ -150,10 +153,11 @@ enum clk_types {
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
@@ -272,4 +276,6 @@ extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
 extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
 extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
 
+int rzg2l_cpg_sd_clk_mux_notifier(struct notifier_block *nb, unsigned long event, void *data);
+
 #endif
-- 
2.39.2

