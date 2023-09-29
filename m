Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD837B2B77
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjI2FkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjI2FkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:40:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212CDCD0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5363227cc80so2032660a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695965973; x=1696570773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWu2NOpEhtT7vu1ptq0dyyGepYPElryMWW3Aiedhw/Y=;
        b=Diq/e86JH4Zvnlnw+82UBFRVFDOYMU/OMRLgnWW5BSc/cpTismvmBxY9ArOHt6WIf+
         iq8ISQi+LyPczOlmUTKbrK7janwPYVw03V8gF5VKuE3bsejbLoon0uODs+wymAKsZWK2
         3pMHX6FdTt4Q+WgY+BL0I/RTsurE3u7Y9R2DqwJKXGAVqnik1JKIJZcmnhvbY47MRr0q
         PSxentyAU2vr/VT4/gMUjhAAkVsB5z6m6rNXFi4lws9JndEfLKMIdT4zKlUukDpJ8D/O
         Ay/3RRDU6r0WBJRHSQT5wB9P9GQ9XyGrKSEl65JHq70RP3khhPogTCvUpZvVQx8Nh+YG
         aXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695965973; x=1696570773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWu2NOpEhtT7vu1ptq0dyyGepYPElryMWW3Aiedhw/Y=;
        b=OUZodPl/duB7UwSrH5k4mvWo/MXCiqm8eO67FcfQWr+9Cm9sCg4Y06gXplf+bxZ0P8
         mMl8bzSwoSwQPCoQQyY0Hf6p4fTDAnQEZYE4V+TijbYqZQznG1eawblOtb4JYjrVxtkK
         MHWV4ClLupT9+6qkOTFnOQ8x5Ygs1rnFEK2dp9j1/PG2PbRw89tAqEJ36ayTQ1z7HDYX
         ia0/HdTjijp44xGCwOrcSzZc3MPqhk9frfMuv+F1eRN+ba1GiJSh4InGR99gOsi/uqqq
         K7Biz1GgdplOiReS3z8/UcGUaXsS23RYC4pH5UunFMtvR4chQAjULqF9eJgxrXbqAqd/
         Cjew==
X-Gm-Message-State: AOJu0Yy9KP4zJCyfHZURWWYZM94GOKxQTTL/SDvXkYfaEhegTFrueyjW
        O39/hBpuK+1XtZbbZgdYPBYfdshvpT0uu4+rAQg=
X-Google-Smtp-Source: AGHT+IHvPByZHCHjh5YJx3lKgABwOn0+a6IQiB+LyPtqP4ZxODN8MzxnUaVLmNw09PCkAR97OX0rXQ==
X-Received: by 2002:a17:906:301a:b0:9a5:d972:af50 with SMTP id 26-20020a170906301a00b009a5d972af50mr3353715ejz.19.1695965973544;
        Thu, 28 Sep 2023 22:39:33 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:39:33 -0700 (PDT)
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
Subject: [PATCH v2 07/28] clk: renesas: rzg2l: add support for RZ/G3S PLL
Date:   Fri, 29 Sep 2023 08:38:54 +0300
Message-Id: <20230929053915.1530607-8-claudiu.beznea@bp.renesas.com>
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

Add support for reading the frequency of PLL1/4/6 available on RZ/G3S.
The computation formula for PLL frequency is as follows:
Fout = (nir + nfr / 4096) * Fin / (mr * pr)

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- added GENMASK() defines for DIV_P, DIV_M, DIV_NI, DIV_NF
- used mul_u64_u32_shr() as suggested by Geert on v1
- s/CLK_TYPE_G3S_SAM_PLL/CLK_TYPE_G3S_PLL/g

 drivers/clk/renesas/rzg2l-cpg.c | 49 ++++++++++++++++++++++++++++++---
 drivers/clk/renesas/rzg2l-cpg.h |  3 ++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index d936832e098f..02058a2d39ca 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -47,6 +47,11 @@
 #define PDIV(val)		FIELD_GET(GENMASK(5, 0), val)
 #define SDIV(val)		FIELD_GET(GENMASK(2, 0), val)
 
+#define RZG3S_DIV_P		GENMASK(28, 26)
+#define RZG3S_DIV_M		GENMASK(25, 22)
+#define RZG3S_DIV_NI		GENMASK(21, 13)
+#define RZG3S_DIV_NF		GENMASK(12, 1)
+
 #define CLK_ON_R(reg)		(reg)
 #define CLK_MON_R(reg)		(0x180 + (reg))
 #define CLK_RST_R(reg)		(reg)
@@ -713,11 +718,43 @@ static const struct clk_ops rzg2l_cpg_pll_ops = {
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
+	if (pll_clk->type != CLK_TYPE_G3S_PLL)
+		return parent_rate;
+
+	val = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
+
+	pr = 1 << FIELD_GET(RZG3S_DIV_P, val);
+	/* Hardware interprets values higher than 8 as p = 16. */
+	if (pr > 8)
+		pr = 16;
+
+	mr  = FIELD_GET(RZG3S_DIV_M, val) + 1;
+	nir = FIELD_GET(RZG3S_DIV_NI, val) + 1;
+	nfr = FIELD_GET(RZG3S_DIV_NF, val);
+
+	rate = mul_u64_u32_shr(parent_rate, 4096 * nir + nfr, 12);
+
+	return DIV_ROUND_CLOSEST_ULL(rate, (mr * pr));
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
@@ -735,7 +772,7 @@ rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
 
 	parent_name = __clk_get_name(parent);
 	init.name = core->name;
-	init.ops = &rzg2l_cpg_pll_ops;
+	init.ops = ops;
 	init.flags = 0;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
@@ -830,8 +867,12 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 						core->mult, div);
 		break;
 	case CLK_TYPE_SAM_PLL:
-		clk = rzg2l_cpg_pll_clk_register(core, priv->clks,
-						 priv->base, priv);
+		clk = rzg2l_cpg_pll_clk_register(core, priv->clks, priv->base, priv,
+						 &rzg2l_cpg_pll_ops);
+		break;
+	case CLK_TYPE_G3S_PLL:
+		clk = rzg2l_cpg_pll_clk_register(core, priv->clks, priv->base, priv,
+						 &rzg3s_cpg_pll_ops);
 		break;
 	case CLK_TYPE_SIPLL5:
 		clk = rzg2l_cpg_sipll5_register(core, priv->clks, priv);
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 097fd8f61680..20da0c620b90 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -102,6 +102,7 @@ enum clk_types {
 	CLK_TYPE_IN,		/* External Clock Input */
 	CLK_TYPE_FF,		/* Fixed Factor Clock */
 	CLK_TYPE_SAM_PLL,
+	CLK_TYPE_G3S_PLL,
 
 	/* Clock with divider */
 	CLK_TYPE_DIV,
@@ -129,6 +130,8 @@ enum clk_types {
 	DEF_TYPE(_name, _id, _type, .parent = _parent)
 #define DEF_SAMPLL(_name, _id, _parent, _conf) \
 	DEF_TYPE(_name, _id, CLK_TYPE_SAM_PLL, .parent = _parent, .conf = _conf)
+#define DEF_G3S_PLL(_name, _id, _parent, _conf) \
+	DEF_TYPE(_name, _id, CLK_TYPE_G3S_PLL, .parent = _parent, .conf = _conf)
 #define DEF_INPUT(_name, _id) \
 	DEF_TYPE(_name, _id, CLK_TYPE_IN)
 #define DEF_FIXED(_name, _id, _parent, _mult, _div) \
-- 
2.39.2

