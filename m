Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C612A79C584
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjILEzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjILEy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:54:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319071FEF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so6729341a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494375; x=1695099175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTRTr+Y9jw349w76qtHWB73iP6xAmLB1by7bT2E70UE=;
        b=PWLkg63Lh4n+vPlpcXH4AV/2ns5gUH+l/cjtbPbbKZJevusLJ9VyPgr2k+xrIg7DSv
         AZKUvJz+aOErj4zTTYvRXvHdDAOm6MMgCaN4NhL9cxxdIml7hxbT41UgevoqGIjI9kxy
         MoJ3xbgPR0snurp51GkRdQqIGzMTIv/2RNAdkH/mWwrK4EnUkyXj+hYoAJtSpiFrdD8R
         CoiISwHu1lOnqEDO3T3B4nGEfxuf6t1EvG+fxcy8POjnvG3JlZhmD99hF6O0yY6OsoTG
         VyDVxmJTi4ceOqMJVQfkQD78pXX71t8/y3vLwKQexbeBLdbDsM6LHyxvKXUytiYAijwt
         05jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494375; x=1695099175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTRTr+Y9jw349w76qtHWB73iP6xAmLB1by7bT2E70UE=;
        b=JEKgDjVFgRgcdPnFVT8mWGkAc0Kj6NgUT/nMCPfnlHz+e/rEUtyefomqJYs3NILVtO
         /8DtYGnTa8Ea9+SwFO9cotMkWhxr03MgPMsi84ayxo9S7d8caGVvK+PN71NlY731I7Lc
         jHuXO3HiHrdcbjAztg0yVuSpii+r34StY9Z2EqRIB+QrDcTV9SZ66QmoU4HBWygEVHG7
         s8B9PJkOgt3FuiIU4vDFSXHGHMYYhznxMS1cwX0g5Bqvr5lwUaj6kxOnmuUNv4ScQpIq
         IkdrTQbvJ82GviS2QXwNp/KUbl+GBss5zRE2uFPKj2IrHo2eLXpdsBZzdQCgWylBysJk
         hS2Q==
X-Gm-Message-State: AOJu0YyG9vswDyUdZBDcn/5VQL4+u1jmFpDeptUwUdcl6bBTrEq97S5m
        dyFeieKhHd2sdpj7vA4is/EaIg==
X-Google-Smtp-Source: AGHT+IEsLs3SkRgJGWnId8GQnsQLmsRxNX2j2ThM/rdGJPDWCd2Tfz2ZbhHh2W6HJqHBcw2I4Zp57w==
X-Received: by 2002:a05:6402:882:b0:52e:1a29:98a with SMTP id e2-20020a056402088200b0052e1a29098amr7952533edy.40.1694494375718;
        Mon, 11 Sep 2023 21:52:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:55 -0700 (PDT)
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
Subject: [PATCH 19/37] clk: renesas: rzg2l: add a divider clock for RZ/G3S
Date:   Tue, 12 Sep 2023 07:51:39 +0300
Message-Id: <20230912045157.177966-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/clk/renesas/rzg2l-cpg.c | 207 ++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h |  10 ++
 2 files changed, 217 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index dd9229f0be7d..c8a8833650ee 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -86,6 +86,22 @@ struct sd_mux_hw_data {
 
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
@@ -195,6 +211,54 @@ int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event
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
@@ -212,6 +276,146 @@ static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk
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
@@ -963,6 +1167,9 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
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
index 140b6b04a091..164da1dd7212 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -91,6 +91,7 @@ struct cpg_core_clk {
 	unsigned int sconf;
 	const struct clk_div_table *dtable;
 	const u32 *mtable;
+	const unsigned long invalid_rate;
 	const char * const *parent_names;
 	notifier_fn_t notifier;
 	u32 flag;
@@ -107,6 +108,7 @@ enum clk_types {
 
 	/* Clock with divider */
 	CLK_TYPE_DIV,
+	CLK_TYPE_G3S_DIV,
 
 	/* Clock with clock source selector */
 	CLK_TYPE_MUX,
@@ -145,6 +147,12 @@ enum clk_types {
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
@@ -279,8 +287,10 @@ extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
 extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
 
 int rzg2l_cpg_sd_mux_clk_notifier(struct notifier_block *nb, unsigned long event, void *data);
+int rzg3s_cpg_div_clk_notifier(struct notifier_block *nb, unsigned long event, void *data);
 
 /* Macros to be used in platform specific initialization code. */
 #define SD_MUX_NOTIF		(&rzg2l_cpg_sd_mux_clk_notifier)
+#define DIV_NOTIF		(&rzg3s_cpg_div_clk_notifier)
 
 #endif
-- 
2.39.2

