Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6407B2B93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjI2Fku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjI2FkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:40:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26BC1708
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c3c8adb27so1842039266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695965981; x=1696570781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leKCcZqsCboMLWPanRiy7/qmakA94ODI6OnWA588/lI=;
        b=Z7cMXwuIHXlCPLH3ZoEi0W01k2BOBubySutV2Sk++hjqQub3fzF5oAUeFk9NiYx9or
         8Tl7pNLpEZs7OuEwZENqbCuNPe0CeYNkeW3A3DEEf8AowWrdyTERD/Y3iaYCQCMvYfHZ
         A9u1pYYGnUIVuWlaZnDUiLyKVm8s/UeSBZISi8dC8W+YRnEt4c6KF8vjrWTieZxsrdkQ
         y2uNmeJi4jsbTPhynzkk0bLYsOv6zWSMYyYGOK7Iar/9NWs3eU1zDB/mdplIB7CIqRW3
         8QC5LGrHolBWkU5gMVDytoI48KaKmxsueaSnBwafIiwTzlPjBZ1DiiTL1SGx1h5NlZ2m
         m9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695965981; x=1696570781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leKCcZqsCboMLWPanRiy7/qmakA94ODI6OnWA588/lI=;
        b=L7rxWYApXB8FHgIsybwxeazNhhsUzLG0kWlsJ86uFlkyGTFFoEGAMX7IDaZY6LKRol
         vArafiGWi74/197n5hL+oJgK/8+8EpqSRBI2Y1jwvnST2mvgEsfeM0Uz6S2Vm/v6j85V
         3eZi6ECPEvxWipKUdwEVTzueU/9Nep8oUbD/kGwLe7UcTXmmFYICkAYLYhHb2GPCsfvo
         DyxdSojwKMfJ+GVKt/8cwPLOAQkOdQoWDkQHKWyp0PVzJVCSk5TNrUIrNv0LvSvwpT+n
         eT6Y+p2Q1opVEPwviG6ZyUCJ8BRM6i5Dr4K1E0+qNi5drwR1022o5EK8+L/UEFfaJDfi
         Lqvg==
X-Gm-Message-State: AOJu0Yz1IeMczmKrlQsiC1goVwyLOJE/zBv3Ds4KW16zET2MheahU2rW
        ZnRa88hHHTzUT/r6onY0vbfnAQ==
X-Google-Smtp-Source: AGHT+IEE9eYbGpvj47F7/wYbj9qK0t713Ontk+F9kt8f3cVT39BJFjgA+vKAbla1mFXs3JmiA7GbWw==
X-Received: by 2002:a17:906:3041:b0:9b1:aa5d:5d1f with SMTP id d1-20020a170906304100b009b1aa5d5d1fmr2875399ejd.73.1695965981754;
        Thu, 28 Sep 2023 22:39:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:39:41 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 11/28] clk: renesas: rzg2l: add a divider clock for RZ/G3S
Date:   Fri, 29 Sep 2023 08:38:58 +0300
Message-Id: <20230929053915.1530607-12-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add a divider clock driver for RZ/G3S. This will be used in RZ/G3S
by SDHI, SPI, OCTA, I, I2, I3, P0, P1, P2, P3 core clocks.
The divider has some limitation for SDHI and OCTA clocks:
- SD div cannot be 1 if parent rate is 800MHz
- OCTA div cannot be 1 if parent rate is 400MHz
For these clocks a notifier could be registered from platform specific
clock driver and proper actions are taken before clock rate is changed,
if needed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- removed DIV_NOTIF macro

 drivers/clk/renesas/rzg2l-cpg.c | 207 ++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h |   9 ++
 2 files changed, 216 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index f4b70e07b9c6..3080e9391f71 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -91,6 +91,22 @@ struct sd_mux_hw_data {
 
 #define to_sd_mux_hw_data(_hw)	container_of(_hw, struct sd_mux_hw_data, hw_data)
 
+/**
+ * struct div_hw_data - divider clock hardware data
+ * @hw_data: clock hw data
+ * @dtable: pointer to divider table
+ * @invalid_rate: invalid rate for divider
+ * @width: divider width
+ */
+struct div_hw_data {
+	struct clk_hw_data hw_data;
+	const struct clk_div_table *dtable;
+	unsigned long invalid_rate;
+	u32 width;
+};
+
+#define to_div_hw_data(_hw)	container_of(_hw, struct div_hw_data, hw_data)
+
 struct rzg2l_pll5_param {
 	u32 pl5_fracin;
 	u8 pl5_refdiv;
@@ -200,6 +216,54 @@ int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event
 	return ret;
 }
 
+int rzg3s_cpg_div_clk_notifier(struct notifier_block *nb, unsigned long event,
+			       void *data)
+{
+	struct clk_notifier_data *cnd = data;
+	struct clk_hw *hw = __clk_get_hw(cnd->clk);
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 off = GET_REG_OFFSET(clk_hw_data->conf);
+	u32 shift = GET_SHIFT(clk_hw_data->conf);
+	u32 bitmask = GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
+	unsigned long flags;
+	int ret = 0;
+	u32 val;
+
+	if (event != PRE_RATE_CHANGE || !div_hw_data->invalid_rate ||
+	    div_hw_data->invalid_rate % cnd->new_rate)
+		return 0;
+
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+
+	val = readl(priv->base + off);
+	val >>= shift;
+	val &= bitmask;
+
+	/*
+	 * There are different constraints for the user of this notifiers as follows:
+	 * 1/ SD div cannot be 1 (val == 0) if parent rate is 800MHz
+	 * 2/ OCTA div cannot be 1 (val == 0) if parent rate is 400MHz
+	 * As SD can have only one parent having 800MHz and OCTA div can have
+	 * only one parent having 400MHz we took into account the parent rate
+	 * at the beginning of function (by checking invalid_rate % new_rate).
+	 * Now it is time to check the hardware divider and update it accordingly.
+	 */
+	if (!val) {
+		writel(((bitmask << shift) << 16) | BIT(shift), priv->base + off);
+		/* Wait for the update done. */
+		ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
+	}
+
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+
+	if (ret)
+		dev_err(priv->dev, "Failed to downgrade the div\n");
+
+	return ret;
+}
+
 static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk *core,
 				   struct rzg2l_cpg_priv *priv)
 {
@@ -217,6 +281,146 @@ static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk
 	return clk_notifier_register(hw->clk, nb);
 }
 
+static unsigned long rzg3s_div_clk_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 val;
+
+	val = readl(priv->base + GET_REG_OFFSET(clk_hw_data->conf));
+	val >>= GET_SHIFT(clk_hw_data->conf);
+	val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
+
+	return divider_recalc_rate(hw, parent_rate, val, div_hw_data->dtable,
+				   CLK_DIVIDER_ROUND_CLOSEST, div_hw_data->width);
+}
+
+static bool rzg3s_div_clk_is_rate_valid(const unsigned long invalid_rate, unsigned long rate)
+{
+	if (invalid_rate && rate >= invalid_rate)
+		return false;
+
+	return true;
+}
+
+static long rzg3s_div_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *parent_rate)
+{
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
+	long round_rate;
+
+	round_rate = divider_round_rate(hw, rate, parent_rate, div_hw_data->dtable,
+					div_hw_data->width, CLK_DIVIDER_ROUND_CLOSEST);
+
+	if (!rzg3s_div_clk_is_rate_valid(div_hw_data->invalid_rate, round_rate))
+		return -EINVAL;
+
+	return round_rate;
+}
+
+static int rzg3s_div_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long parent_rate)
+{
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 off = GET_REG_OFFSET(clk_hw_data->conf);
+	u32 shift = GET_SHIFT(clk_hw_data->conf);
+	unsigned long flags;
+	u32 bitmask, val;
+	int ret;
+
+	/*
+	 * Some dividers cannot support some rates:
+	 * - SD div cannot support 800 MHz when parent is @800MHz and div = 1
+	 * - OCTA div cannot support 400 MHz when parent is @400MHz and div = 1
+	 * Check these scenarios.
+	 */
+	if (!rzg3s_div_clk_is_rate_valid(div_hw_data->invalid_rate, rate))
+		return -EINVAL;
+
+	val = divider_get_val(rate, parent_rate, div_hw_data->dtable, div_hw_data->width,
+			      CLK_DIVIDER_ROUND_CLOSEST);
+
+	bitmask = (GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0) << shift) << 16;
+
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+	writel(bitmask | (val << shift), priv->base + off);
+	/* Wait for the update done. */
+	ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+
+	return ret;
+}
+
+static const struct clk_ops rzg3s_div_clk_ops = {
+	.recalc_rate = rzg3s_div_clk_recalc_rate,
+	.round_rate = rzg3s_div_clk_round_rate,
+	.set_rate = rzg3s_div_clk_set_rate,
+};
+
+static struct clk * __init
+rzg3s_cpg_div_clk_register(const struct cpg_core_clk *core, struct clk **clks,
+			   void __iomem *base, struct rzg2l_cpg_priv *priv)
+{
+	struct div_hw_data *div_hw_data;
+	struct clk_init_data init = {};
+	const struct clk_div_table *clkt;
+	struct clk_hw *clk_hw;
+	const struct clk *parent;
+	const char *parent_name;
+	u32 max;
+	int ret;
+
+	parent = clks[core->parent & 0xffff];
+	if (IS_ERR(parent))
+		return ERR_CAST(parent);
+
+	parent_name = __clk_get_name(parent);
+
+	div_hw_data = devm_kzalloc(priv->dev, sizeof(*div_hw_data), GFP_KERNEL);
+	if (!div_hw_data)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = core->name;
+	init.flags = core->flag;
+	init.ops = &rzg3s_div_clk_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	/* Get the maximum divider to retrieve div width. */
+	for (clkt = core->dtable; clkt->div; clkt++) {
+		if (max < clkt->div)
+			max = clkt->div;
+	}
+
+	div_hw_data->hw_data.priv = priv;
+	div_hw_data->hw_data.conf = core->conf;
+	div_hw_data->hw_data.sconf = core->sconf;
+	div_hw_data->dtable = core->dtable;
+	div_hw_data->invalid_rate = core->invalid_rate;
+	div_hw_data->width = fls(max) - 1;
+
+	clk_hw = &div_hw_data->hw_data.hw;
+	clk_hw->init = &init;
+
+	ret = devm_clk_hw_register(priv->dev, clk_hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = rzg2l_register_notifier(clk_hw, core, priv);
+	if (ret) {
+		dev_err(priv->dev, "Failed to register notifier for %s\n",
+			core->name);
+		return ERR_PTR(ret);
+	}
+
+	return clk_hw->clk;
+}
+
 static struct clk * __init
 rzg2l_cpg_div_clk_register(const struct cpg_core_clk *core,
 			   struct clk **clks,
@@ -964,6 +1168,9 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 		clk = rzg2l_cpg_div_clk_register(core, priv->clks,
 						 priv->base, priv);
 		break;
+	case CLK_TYPE_G3S_DIV:
+		clk = rzg3s_cpg_div_clk_register(core, priv->clks, priv->base, priv);
+		break;
 	case CLK_TYPE_MUX:
 		clk = rzg2l_cpg_mux_clk_register(core, priv->base, priv);
 		break;
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index edac34037cf0..8312972cc496 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -89,6 +89,7 @@ struct cpg_core_clk {
 	unsigned int sconf;
 	const struct clk_div_table *dtable;
 	const u32 *mtable;
+	const unsigned long invalid_rate;
 	const char * const *parent_names;
 	notifier_fn_t notifier;
 	u32 flag;
@@ -105,6 +106,7 @@ enum clk_types {
 
 	/* Clock with divider */
 	CLK_TYPE_DIV,
+	CLK_TYPE_G3S_DIV,
 
 	/* Clock with clock source selector */
 	CLK_TYPE_MUX,
@@ -143,6 +145,12 @@ enum clk_types {
 	DEF_TYPE(_name, _id, CLK_TYPE_DIV, .conf = _conf, \
 		 .parent = _parent, .dtable = _dtable, \
 		 .flag = CLK_DIVIDER_READ_ONLY)
+#define DEF_G3S_DIV(_name, _id, _parent, _conf, _sconf, _dtable, _invalid_rate, \
+		    _clk_flags, _notif) \
+	DEF_TYPE(_name, _id, CLK_TYPE_G3S_DIV, .conf = _conf, .sconf = _sconf, \
+		 .parent = _parent, .dtable = _dtable, \
+		 .invalid_rate = _invalid_rate, .flag = (_clk_flags), \
+		 .notifier = _notif)
 #define DEF_MUX(_name, _id, _conf, _parent_names) \
 	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
 		 .parent_names = _parent_names, \
@@ -277,5 +285,6 @@ extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
 extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
 
 int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event, void *data);
+int rzg3s_cpg_div_clk_notifier(struct notifier_block *nb, unsigned long event, void *data);
 
 #endif
-- 
2.39.2

