Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F5F79C566
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjILEy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjILEyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:54:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F167619B7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso6793834a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494369; x=1695099169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO1m8klgdJ3la3lwA5G1PIBkW+KdOrEMqx0TRLTuKy4=;
        b=q4QUpu00UTPi2SSD1eKD0v8/A3VpSSioZaomc9F/xbIydk1ltU9QVD+Jt/8ISEEizG
         mYBmepDPujKgqN3IujODaWkcH2uQnk+DkaEG9n8m06jhFTQlJaz8Ia8O/5S8jnwJuw8s
         u8frzRruc0SrIkeiKagM1yOZikOeNgoCy5FOeAVXVOjV6UH/60DyierzigvVnYq4hH+4
         9Shn13rLUIvOCZN5CxkW+3FrDR/74ElzoJ8QOKnMpsWB/oAzeDmYRk3fWwcG9KxANER6
         7QKP6MUiFDkxuVBWJR7/UW58Ul/GC3bcnP61JQbtVGff7EkcKpxH1+NJvsPCyvtIrhyF
         cMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494369; x=1695099169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NO1m8klgdJ3la3lwA5G1PIBkW+KdOrEMqx0TRLTuKy4=;
        b=n2BL2fzSwDJSCT8qyxEsWZ4bz6iBesU/G3/ODfdyWAN4i7Xw/OBXt7lRWM65ZO76Us
         6ymue2w9ySl2zpdjuWcMJQEc5wBkcZy8ZAUO/vgXCbeLybIPw23ZusK+kJG2upE3m4E6
         a6vkmfqiRZaW8bTOZkJ/e9F+k0PxPsB8rIv9aHbrpGDFwnKUZkyrbdgQR9ev/IbxXx3f
         8DWhZrexYPq44Aug5aU9qLR63Ae67npYCS4HW5pJt08Ewd6qyD0bIM0d+lfOuiIJR0GL
         Pro4Jp05F920nOy+z/eamKECxQT78ruJMfpLRzUz9sQC5CikY5ZWSS/oTbhPp0qsU3Vq
         F9IQ==
X-Gm-Message-State: AOJu0YwzPlJDhXN+f+iu5AZV7u3XWptXBnebbedwSqqa7Lz3kwexxgqO
        mOuajWqjOOMaJk/PWy4IrLdoAg==
X-Google-Smtp-Source: AGHT+IECyDtEVHdzRuPaavxSRzCV7z3HcaRShxw/H814fY1bi7YeoyBypsCYMgK7dkybwGKvBN6iOw==
X-Received: by 2002:aa7:d343:0:b0:522:2711:873 with SMTP id m3-20020aa7d343000000b0052227110873mr10392454edr.1.1694494369479;
        Mon, 11 Sep 2023 21:52:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:49 -0700 (PDT)
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
Subject: [PATCH 16/37] clk: renesas: rzg2l: add struct clk_hw_data
Date:   Tue, 12 Sep 2023 07:51:36 +0300
Message-Id: <20230912045157.177966-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add clk_hw_data struct that keeps the core part of a clock data. The
sd_hw_data embeds a member of type struct clk_hw_data along with other
members (in the next commits). This commit prepares the field for
refactoring the SD MUX clock driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 52 +++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 638501e493e2..120bc8d51691 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -58,13 +58,29 @@
 
 #define MAX_VCLK_FREQ		(148500000)
 
-struct sd_hw_data {
+/**
+ * struct clk_hw_data - clock hardware data
+ * @hw: clock hw
+ * @conf: clock configuration (register offset, shift, width)
+ * @priv: CPG private data structure
+ */
+struct clk_hw_data {
 	struct clk_hw hw;
 	u32 conf;
 	struct rzg2l_cpg_priv *priv;
 };
 
-#define to_sd_hw_data(_hw)	container_of(_hw, struct sd_hw_data, hw)
+#define to_clk_hw_data(_hw)	container_of(_hw, struct clk_hw_data, hw)
+
+/**
+ * struct sd_hw_data - SD clock hardware data
+ * @hw_data: clock hw data
+ */
+struct sd_hw_data {
+	struct clk_hw_data hw_data;
+};
+
+#define to_sd_hw_data(_hw)	container_of(_hw, struct sd_hw_data, hw_data)
 
 struct rzg2l_pll5_param {
 	u32 pl5_fracin;
@@ -183,10 +199,10 @@ rzg2l_cpg_mux_clk_register(const struct cpg_core_clk *core,
 
 static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
-	struct sd_hw_data *hwdata = to_sd_hw_data(hw);
-	struct rzg2l_cpg_priv *priv = hwdata->priv;
-	u32 off = GET_REG_OFFSET(hwdata->conf);
-	u32 shift = GET_SHIFT(hwdata->conf);
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 off = GET_REG_OFFSET(clk_hw_data->conf);
+	u32 shift = GET_SHIFT(clk_hw_data->conf);
 	const u32 clk_src_266 = 2;
 	u32 msk, val, bitmask;
 	unsigned long flags;
@@ -203,7 +219,7 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	 * The clock mux has 3 input clocks(533 MHz, 400 MHz, and 266 MHz), and
 	 * the index to value mapping is done by adding 1 to the index.
 	 */
-	bitmask = (GENMASK(GET_WIDTH(hwdata->conf) - 1, 0) << shift) << 16;
+	bitmask = (GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0) << shift) << 16;
 	spin_lock_irqsave(&priv->rmw_lock, flags);
 	if (index != clk_src_266) {
 		writel(bitmask | ((clk_src_266 + 1) << shift), priv->base + off);
@@ -233,12 +249,12 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 
 static u8 rzg2l_cpg_sd_clk_mux_get_parent(struct clk_hw *hw)
 {
-	struct sd_hw_data *hwdata = to_sd_hw_data(hw);
-	struct rzg2l_cpg_priv *priv = hwdata->priv;
-	u32 val = readl(priv->base + GET_REG_OFFSET(hwdata->conf));
+	struct clk_hw_data *clk_hw_data = to_clk_hw_data(hw);
+	struct rzg2l_cpg_priv *priv = clk_hw_data->priv;
+	u32 val = readl(priv->base + GET_REG_OFFSET(clk_hw_data->conf));
 
-	val >>= GET_SHIFT(hwdata->conf);
-	val &= GENMASK(GET_WIDTH(hwdata->conf) - 1, 0);
+	val >>= GET_SHIFT(clk_hw_data->conf);
+	val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
 
 	return val ? --val : val;
 }
@@ -254,17 +270,17 @@ rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
 			      void __iomem *base,
 			      struct rzg2l_cpg_priv *priv)
 {
-	struct sd_hw_data *clk_hw_data;
+	struct sd_hw_data *sd_hw_data;
 	struct clk_init_data init;
 	struct clk_hw *clk_hw;
 	int ret;
 
-	clk_hw_data = devm_kzalloc(priv->dev, sizeof(*clk_hw_data), GFP_KERNEL);
-	if (!clk_hw_data)
+	sd_hw_data = devm_kzalloc(priv->dev, sizeof(*sd_hw_data), GFP_KERNEL);
+	if (!sd_hw_data)
 		return ERR_PTR(-ENOMEM);
 
-	clk_hw_data->priv = priv;
-	clk_hw_data->conf = core->conf;
+	sd_hw_data->hw_data.priv = priv;
+	sd_hw_data->hw_data.conf = core->conf;
 
 	init.name = core->name;
 	init.ops = &rzg2l_cpg_sd_clk_mux_ops;
@@ -272,7 +288,7 @@ rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
 	init.num_parents = core->num_parents;
 	init.parent_names = core->parent_names;
 
-	clk_hw = &clk_hw_data->hw;
+	clk_hw = &sd_hw_data->hw_data.hw;
 	clk_hw->init = &init;
 
 	ret = devm_clk_hw_register(priv->dev, clk_hw);
-- 
2.39.2

