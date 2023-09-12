Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3C279C55F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjILEyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjILEyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:54:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC9919A6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so6199991a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494367; x=1695099167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAKzNTbLzgfAHRXdnsKRKe+RoiapOo2jvnyugHXTYOc=;
        b=A5zJQYN52UqoLxmSRjZAee6WWzlfF1olKju9k+NXO4cDdTUbJ0COqMbBxaZVv9gOCr
         ARUPt/bB/czYWIe+BVgRNocGNq7iTWfpOWg64aMhhSZYUGlrZ9LqmdpU4spXkVNvf1bz
         5k+pB+HcbmFJgahiPtKiqEMROGCDctaE8YZ7s0E9DDk15Zu7W7y0fxKNPcAg6gWF0EFz
         YOOS9XvQce9X52zJw25o1yyz+57HsAsm+hAZwDKO5fwjwxH1bB3xeMNgdYNBw1Nri041
         YG1q4NKPxeqm/2nmaR2j5FoMxTXXoJsZUFTYi3HK3AaZLgh+vtS49ZSY1SA2dTEUd7lx
         espg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494367; x=1695099167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAKzNTbLzgfAHRXdnsKRKe+RoiapOo2jvnyugHXTYOc=;
        b=qno+MuR3CQxkmsHZqIGrL2S8KBVkzi0GaV4JLheIlOB/tu+oUoC04jdGiJzOi1k0xQ
         1mAz0UTYVWRuqyuO1PXhJFXAByp0EbkMqs0s84ScKOAFtklftCeUt4UTGl6XwXuDEhuO
         zyadRsXeP9xFDvoVHvfTzbOmOK5ksehDEceBtfd7WcW4EmTzSKIy9D2myxMAOcISuORi
         jchks+bhPcbdh2q13V2mADOe0CXpkST/Jv+3X0mlIUEP6eHgV3HTDt3m4SVXzc0B1GEH
         D9q5tLVeh3SPNsRoWKupM9KyLQWAvdKxbLJs6MGMneWT2NiSuHEAVEkXVJipJqddMJWU
         sIrA==
X-Gm-Message-State: AOJu0YyHb2349QRmhV47AzrS6+xoI7BiU60mqnQkvyZISf8CVT/3eYaW
        MYXrQYLdYkW6BnBNRDQgIyD9Uw==
X-Google-Smtp-Source: AGHT+IHbBiCW5+2oyUrY79stp2q5q5fLR4ZrMDANH3Hb0eBVLnJv5YMHustdDuw874VCDX2s8efWsA==
X-Received: by 2002:a50:fa8e:0:b0:52e:585a:e94 with SMTP id w14-20020a50fa8e000000b0052e585a0e94mr8790647edr.2.1694494367488;
        Mon, 11 Sep 2023 21:52:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:47 -0700 (PDT)
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
Subject: [PATCH 15/37] clk: renesas: rzg2l: add support for RZ/G3S PLL
Date:   Tue, 12 Sep 2023 07:51:35 +0300
Message-Id: <20230912045157.177966-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add support for reading the frequency of PLL1/4/6 available on RZ/G3S.
The computation formula for PLL frequency is as follows:
Fout = (nir + nfr / 4096) * Fin / (mr * pr)

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 44 ++++++++++++++++++++++++++++++---
 drivers/clk/renesas/rzg2l-cpg.h |  3 +++
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 50f69bbe1a6e..638501e493e2 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -718,11 +718,43 @@ static const struct clk_ops rzg2l_cpg_pll_ops = {
 	.recalc_rate = rzg2l_cpg_pll_clk_recalc_rate,
 };
 
+static unsigned long rzg3s_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate)
+{
+	struct pll_clk *pll_clk = to_pll(hw);
+	struct rzg2l_cpg_priv *priv = pll_clk->priv;
+	u32 nir, nfr, mr, pr, val;
+	u64 rate;
+
+	if (pll_clk->type != CLK_TYPE_G3S_SAM_PLL)
+		return parent_rate;
+
+	val = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
+
+	pr = 1 << FIELD_GET(GENMASK(28, 26), val);
+	/* Hardware interprets values higher than 8 as p = 16. */
+	if (pr > 8)
+		pr = 16;
+
+	mr  = FIELD_GET(GENMASK(25, 22), val) + 1;
+	nir = FIELD_GET(GENMASK(21, 13), val) + 1;
+	nfr = FIELD_GET(GENMASK(12, 1), val);
+
+	rate = DIV_ROUND_CLOSEST_ULL((u64)parent_rate * nfr, 4096);
+	rate += (u64)parent_rate * nir;
+	return DIV_ROUND_CLOSEST_ULL(rate, (mr + pr));
+}
+
+static const struct clk_ops rzg3s_cpg_pll_ops = {
+	.recalc_rate = rzg3s_cpg_pll_clk_recalc_rate,
+};
+
 static struct clk * __init
 rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
 			   struct clk **clks,
 			   void __iomem *base,
-			   struct rzg2l_cpg_priv *priv)
+			   struct rzg2l_cpg_priv *priv,
+			   const struct clk_ops *ops)
 {
 	struct device *dev = priv->dev;
 	const struct clk *parent;
@@ -740,7 +772,7 @@ rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
 
 	parent_name = __clk_get_name(parent);
 	init.name = core->name;
-	init.ops = &rzg2l_cpg_pll_ops;
+	init.ops = ops;
 	init.flags = 0;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
@@ -835,8 +867,12 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 						core->mult, div);
 		break;
 	case CLK_TYPE_SAM_PLL:
-		clk = rzg2l_cpg_pll_clk_register(core, priv->clks,
-						 priv->base, priv);
+		clk = rzg2l_cpg_pll_clk_register(core, priv->clks, priv->base, priv,
+						 &rzg2l_cpg_pll_ops);
+		break;
+	case CLK_TYPE_G3S_SAM_PLL:
+		clk = rzg2l_cpg_pll_clk_register(core, priv->clks, priv->base, priv,
+						 &rzg3s_cpg_pll_ops);
 		break;
 	case CLK_TYPE_SIPLL5:
 		clk = rzg2l_cpg_sipll5_register(core, priv->clks, priv);
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 0b28870a6f9d..16f7a1872814 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -102,6 +102,7 @@ enum clk_types {
 	CLK_TYPE_IN,		/* External Clock Input */
 	CLK_TYPE_FF,		/* Fixed Factor Clock */
 	CLK_TYPE_SAM_PLL,
+	CLK_TYPE_G3S_SAM_PLL,
 
 	/* Clock with divider */
 	CLK_TYPE_DIV,
@@ -129,6 +130,8 @@ enum clk_types {
 	DEF_TYPE(_name, _id, _type, .parent = _parent)
 #define DEF_SAMPLL(_name, _id, _parent, _conf) \
 	DEF_TYPE(_name, _id, CLK_TYPE_SAM_PLL, .parent = _parent, .conf = _conf)
+#define DEF_G3S_SAMPLL(_name, _id, _parent, _conf) \
+	DEF_TYPE(_name, _id, CLK_TYPE_G3S_SAM_PLL, .parent = _parent, .conf = _conf)
 #define DEF_INPUT(_name, _id) \
 	DEF_TYPE(_name, _id, CLK_TYPE_IN)
 #define DEF_FIXED(_name, _id, _parent, _mult, _div) \
-- 
2.39.2

