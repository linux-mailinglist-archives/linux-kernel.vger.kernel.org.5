Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5117C7BB581
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjJFKlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjJFKkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:40:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A79F4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:40:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b6559cbd74so366215866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696588827; x=1697193627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFZzKrd0SxDFJxWhQX1hGTSWdpHLwPYaDFSPP0V7tQQ=;
        b=e/0z08TcMBcMSVcaixVmfgr5s/ZwK3zSMTwjYkprrxIUoEiPQ0A9S63lZtGrSeDHqR
         vfOz/K43ZMsoaK4CAQDE/5Cq2t0mj00+uAugxyGey9srWzOQ83PLg/F9T03civ1cm/Vf
         MKCfAhUlkV2LwwYn4Zo4qI6eoP2nX6U2MSBaWkontP5ZP89etaxr/KroXkq4LIo5QFcn
         CoWB98NOg4yURiVOOLzqoLAv4YRUpWxrfFQwW5SjVrwHr8SoROl7sa53KWey13gS9K2C
         wS8+6udH686HLDTqevYkTLOr6Sp2A9w5SaYpCHtn7CIkgGcZVTJBYreZYLKVb1yTvztU
         nuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696588827; x=1697193627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFZzKrd0SxDFJxWhQX1hGTSWdpHLwPYaDFSPP0V7tQQ=;
        b=sRc9aL9L6NlGtTz7leOQtUlQVxbFliSed25iBtCIx630zrlU/X/o6u8U4u/npceF4e
         oXhhJqf59aBMhss4LAMVRI7WGPrBOMWsT2gdTA9TlFj3lOJ1skV9qRpY0eKwtDBWM7UH
         2BkT99aPmznMdm3yNEVrcJTqyRxTGeTZW1wZYAH/XaTTdsl79V0LR+PGK3cGB+t9wEZI
         VcYVN1C5BHB71QpyK7M4l61Z+HrhoxISUimgkv1so6uItIEt7zGsH1H2uGsTj78mkAkQ
         UacKOQNheE+gqVLqtphWP/xX37tAGmKe6XnqOIBHyeDA8e1WXPxoPhlLMMylupHwlRVN
         LyTw==
X-Gm-Message-State: AOJu0YxrxkxgHL0iXlaC5oHu/BRlYECHx2uvnaJi2WxztPj9sQSmYqSA
        ryJaGgPH7if32DeBJV7d38T5Tg==
X-Google-Smtp-Source: AGHT+IECssdIpEkLpUXej0OJ4JwfgI07gmE8yv89tXVtMMdGAufOU/DDJIfmEPQFOr6O/kKC3YUKhQ==
X-Received: by 2002:a17:907:1de0:b0:9ae:7611:99be with SMTP id og32-20020a1709071de000b009ae761199bemr7080913ejc.66.1696588826534;
        Fri, 06 Oct 2023 03:40:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.24])
        by smtp.gmail.com with ESMTPSA id br13-20020a170906d14d00b0099cb349d570sm2642490ejb.185.2023.10.06.03.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:40:26 -0700 (PDT)
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
Subject: [PATCH v3 3/4] clk: renesas: rzg2l: add a divider clock for RZ/G3S
Date:   Fri,  6 Oct 2023 13:39:58 +0300
Message-Id: <20231006103959.197485-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231006103959.197485-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231006103959.197485-1-claudiu.beznea.uj@bp.renesas.com>
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
The divider has some limitation for SDHI, OCTA and SPI clocks:
- SDHI div cannot be 1 if parent rate is 800MHz
- OCTA, SPI div cannot be 1 if parent rate is 400MHz
For these clocks a notifier could be registered from platform specific
clock driver and proper actions are taken before clock rate is changed,
if needed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- adjusted commit message to specifies that divider has limitations also
  for SPI clock
- s/SD div/SDHI div in commit message
- return proper code from notifier
- used CPG_WEN_BIT where possible notifier and set explicitily 1 in div
  notifier 
- removed rzg3s_div_clk_is_rate_valid() and all its occurencies: it was
  not needed in rzg3s_div_clk_set_rate()
- .round_rate was replaced by .determine_rate for the introduced divider
- initialized max variable in rzg3s_cpg_div_clk_register()
- introduced struct div_hw_data::max_rate to specify from the SoC-specific
  drivers the maximum available rate for divider that will be requested
  when a rate higher than this one is requested
- removed bitmask variable from notifier and rzg3s_div_clk_set_rate()
- added max_rate to DEF_G3S_DIV() macro
- tested on RZ/G2L and RZ/G3S

Changes in v2:
- removed DIV_NOTIF macro

 drivers/clk/renesas/rzg2l-cpg.c | 186 ++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h |  11 ++
 2 files changed, 197 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 8f927568a3c8..49dc6c5c0b0c 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -93,6 +93,24 @@ struct sd_mux_hw_data {
 
 #define to_sd_mux_hw_data(_hw)	container_of(_hw, struct sd_mux_hw_data, hw_data)
 
+/**
+ * struct div_hw_data - divider clock hardware data
+ * @hw_data: clock hw data
+ * @dtable: pointer to divider table
+ * @invalid_rate: invalid rate for divider
+ * @max_rate: maximum rate for divider
+ * @width: divider width
+ */
+struct div_hw_data {
+	struct clk_hw_data hw_data;
+	const struct clk_div_table *dtable;
+	unsigned long invalid_rate;
+	unsigned long max_rate;
+	u32 width;
+};
+
+#define to_div_hw_data(_hw)	container_of(_hw, struct div_hw_data, hw_data)
+
 struct rzg2l_pll5_param {
 	u32 pl5_fracin;
 	u8 pl5_refdiv;
@@ -201,6 +219,53 @@ int rzg2l_cpg_sd_clk_mux_notifier(struct notifier_block *nb, unsigned long event
 	return notifier_from_errno(ret);
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
+	unsigned long flags;
+	int ret = 0;
+	u32 val;
+
+	if (event != PRE_RATE_CHANGE || !div_hw_data->invalid_rate ||
+	    div_hw_data->invalid_rate % cnd->new_rate)
+		return NOTIFY_DONE;
+
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+
+	val = readl(priv->base + off);
+	val >>= shift;
+	val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
+
+	/*
+	 * There are different constraints for the user of this notifiers as follows:
+	 * 1/ SD div cannot be 1 (val == 0) if parent rate is 800MHz
+	 * 2/ OCTA / SPI div cannot be 1 (val == 0) if parent rate is 400MHz
+	 * As SD can have only one parent having 800MHz and OCTA div can have
+	 * only one parent having 400MHz we took into account the parent rate
+	 * at the beginning of function (by checking invalid_rate % new_rate).
+	 * Now it is time to check the hardware divider and update it accordingly.
+	 */
+	if (!val) {
+		writel((CPG_WEN_BIT | 1) << shift, priv->base + off);
+		/* Wait for the update done. */
+		ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
+	}
+
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+
+	if (ret)
+		dev_err(priv->dev, "Failed to downgrade the div\n");
+
+	return notifier_from_errno(ret);
+}
+
 static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk *core,
 				   struct rzg2l_cpg_priv *priv)
 {
@@ -218,6 +283,124 @@ static int rzg2l_register_notifier(struct clk_hw *hw, const struct cpg_core_clk
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
+static int rzg3s_div_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct div_hw_data *div_hw_data = to_div_hw_data(clk_hw_data);
+
+	if (div_hw_data->max_rate && req->rate > div_hw_data->max_rate)
+		req->rate = div_hw_data->max_rate;
+
+	return divider_determine_rate(hw, req, div_hw_data->dtable, div_hw_data->width,
+				      CLK_DIVIDER_ROUND_CLOSEST);
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
+	u32 val;
+	int ret;
+
+	val = divider_get_val(rate, parent_rate, div_hw_data->dtable, div_hw_data->width,
+			      CLK_DIVIDER_ROUND_CLOSEST);
+
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+	writel((CPG_WEN_BIT | val) << shift, priv->base + off);
+	/* Wait for the update done. */
+	ret = rzg2l_cpg_wait_clk_update_done(priv->base, clk_hw_data->sconf);
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+
+	return ret;
+}
+
+static const struct clk_ops rzg3s_div_clk_ops = {
+	.recalc_rate = rzg3s_div_clk_recalc_rate,
+	.determine_rate = rzg3s_div_clk_determine_rate,
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
+	u32 max = 0;
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
+	div_hw_data->max_rate = core->max_rate;
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
@@ -963,6 +1146,9 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
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
index f1910913b29a..4755befaf38e 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -89,6 +89,8 @@ struct cpg_core_clk {
 	unsigned int sconf;
 	const struct clk_div_table *dtable;
 	const u32 *mtable;
+	const unsigned long invalid_rate;
+	const unsigned long max_rate;
 	const char * const *parent_names;
 	notifier_fn_t notifier;
 	u32 flag;
@@ -105,6 +107,7 @@ enum clk_types {
 
 	/* Clock with divider */
 	CLK_TYPE_DIV,
+	CLK_TYPE_G3S_DIV,
 
 	/* Clock with clock source selector */
 	CLK_TYPE_MUX,
@@ -143,6 +146,13 @@ enum clk_types {
 	DEF_TYPE(_name, _id, CLK_TYPE_DIV, .conf = _conf, \
 		 .parent = _parent, .dtable = _dtable, \
 		 .flag = CLK_DIVIDER_READ_ONLY)
+#define DEF_G3S_DIV(_name, _id, _parent, _conf, _sconf, _dtable, _invalid_rate, \
+		    _max_rate, _clk_flags, _notif) \
+	DEF_TYPE(_name, _id, CLK_TYPE_G3S_DIV, .conf = _conf, .sconf = _sconf, \
+		 .parent = _parent, .dtable = _dtable, \
+		 .invalid_rate = _invalid_rate, \
+		 .max_rate = _max_rate, .flag = (_clk_flags), \
+		 .notifier = _notif)
 #define DEF_MUX(_name, _id, _conf, _parent_names) \
 	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
 		 .parent_names = _parent_names, \
@@ -277,5 +287,6 @@ extern const struct rzg2l_cpg_info r9a07g054_cpg_info;
 extern const struct rzg2l_cpg_info r9a09g011_cpg_info;
 
 int rzg2l_cpg_sd_clk_mux_notifier(struct notifier_block *nb, unsigned long event, void *data);
+int rzg3s_cpg_div_clk_notifier(struct notifier_block *nb, unsigned long event, void *data);
 
 #endif
-- 
2.39.2

