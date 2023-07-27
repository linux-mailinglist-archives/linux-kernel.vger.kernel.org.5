Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945687645E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjG0FkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjG0Fj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:39:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A4F35AA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:38:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b9c368f4b5so11743355ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436247; x=1691041047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0MCABlKnn4W9o3M4XSOlKm6XX3ypG2eLBBMZazV5aU=;
        b=nSsgtq6GND/KRpXTCP6YcWA+uA/ZLZDk70vsMiY9jZtEYLHnW8HOnsHyzGgp9BWYrN
         yG1oLeeKD38YXZfm+r/9OtAajFL8T64g1OdK2SMlGqNymUDHHrmS3dzJdawJpxAE6HD9
         m87dfNdpWlHAa1Lqkl2XtjyslgOQpOdMMfhJwhLyldvDqaaHeAipDf/UW8mImDFT2MoG
         QG86Usv2Dlu4HA+jYw9znLlCCRyH3R0k2AQq9r0bYH+laHUbvmEeq5jHuTAIY/XRZkEX
         Nni5Qo5N9kay+wvtJlQuHVDNH1bSUA3aFm7vK/cVRuXz+BtpjaISH/Q3AVwmlnMG5yo3
         cdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436247; x=1691041047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0MCABlKnn4W9o3M4XSOlKm6XX3ypG2eLBBMZazV5aU=;
        b=UtiHzAbZAh4B3kRMn+gK6EN20j+zoTiw2Hhs4TApiqNb2Zeg4AczxULcM/IB/TCQOt
         o0jSQKLowQ1JD/XuV7WBtqa6Or+aeJvbbykZYg0XE+k+8HyQE1LiJbBH7qQIRnpneA5z
         DmesXm5Bj7r4hqhbdjxBs3zKj4yoEFOypzp7LavIO0bm3nwFXzqKyu2pjBYtU2YYNLwo
         wLY5BytqEkb6wDWZVfZhhxnhQmKv+JTpweYbnjpupEUxaiInlM6R2g5FHw/ATfCmRAFk
         vdM+ndF9zhVgaOQUr+ewVI+pVpWtpY7TzMutSxes8pglkh85EDJJ81PGFw418miHkYGv
         J4fg==
X-Gm-Message-State: ABy/qLYdfJTZgJJ9EerslevyKQMN70fYuED9VRyhvBVpVF/jcuP0o7n3
        Aem9DnhqiSS2qEpTAyAzmU2rWw==
X-Google-Smtp-Source: APBJJlHlq1g/jxGnxtE5kc0Zu6/vUpuzTqsqYM1q0IAdRpnngQGqQf7SqFxL1bbqjNqkdtAbei9jUg==
X-Received: by 2002:a17:902:d50b:b0:1bb:c896:1da3 with SMTP id b11-20020a170902d50b00b001bbc8961da3mr2356971plg.24.1690436247121;
        Wed, 26 Jul 2023 22:37:27 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:37:26 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 41/42] clk: at91: clk-usb: remove parent_names support
Date:   Thu, 27 Jul 2023 08:31:55 +0300
Message-Id: <20230727053156.13587-42-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove parent_names support as parent_hw support is now available on all
platforms using clk-usb driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91rm9200.c  |  2 +-
 drivers/clk/at91/at91sam9260.c |  2 +-
 drivers/clk/at91/at91sam9g45.c |  2 +-
 drivers/clk/at91/at91sam9n12.c |  2 +-
 drivers/clk/at91/at91sam9x5.c  |  2 +-
 drivers/clk/at91/clk-usb.c     | 35 ++++++++++++----------------------
 drivers/clk/at91/dt-compat.c   |  6 +++---
 drivers/clk/at91/pmc.h         |  8 ++++----
 drivers/clk/at91/sam9x60.c     |  2 +-
 drivers/clk/at91/sama5d2.c     |  2 +-
 drivers/clk/at91/sama5d3.c     |  2 +-
 drivers/clk/at91/sama5d4.c     |  2 +-
 12 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 4b8a9c27cc9e..05060b72acab 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -163,7 +163,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	at91rm9200_pmc->chws[PMC_MCK] = hw;
 
-	usbck_hw = at91rm9200_clk_register_usb(regmap, "usbck", NULL,
+	usbck_hw = at91rm9200_clk_register_usb(regmap, "usbck",
 					       at91rm9200_pmc->chws[PMC_PLLBCK], usb_div);
 	if (IS_ERR(usbck_hw))
 		goto err_free;
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 71002ada33dd..2b0ffcee9e40 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -436,7 +436,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	at91sam9260_pmc->chws[PMC_MCK] = hw;
 
-	usbck_hw = at91rm9200_clk_register_usb(regmap, "usbck", NULL,
+	usbck_hw = at91rm9200_clk_register_usb(regmap, "usbck",
 					       at91sam9260_pmc->chws[PMC_PLLBCK], usb_div);
 	if (IS_ERR(usbck_hw))
 		goto err_free;
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index bf5951097fca..1e5262b678f5 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -182,7 +182,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 
 	parent_hws[0] = at91sam9g45_pmc->chws[PMC_PLLACK];
 	parent_hws[1] = at91sam9g45_pmc->chws[PMC_UTMI];
-	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", NULL, parent_hws, 2);
+	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_hws, 2);
 	if (IS_ERR(usbck_hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index fa7daab2793b..9b4e28b9f21b 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -207,7 +207,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 
 	at91sam9n12_pmc->chws[PMC_MCK] = hw;
 
-	usbck_hw = at91sam9n12_clk_register_usb(regmap, "usbck", NULL,
+	usbck_hw = at91sam9n12_clk_register_usb(regmap, "usbck",
 						at91sam9n12_pmc->chws[PMC_PLLBCK]);
 	if (IS_ERR(usbck_hw))
 		goto err_free;
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 994010f1cf03..1968dd69fbf7 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -228,7 +228,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 	parent_hws[0] = at91sam9x5_pmc->chws[PMC_PLLACK];
 	parent_hws[1] = at91sam9x5_pmc->chws[PMC_UTMI];
-	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", NULL, parent_hws, 2);
+	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_hws, 2);
 	if (IS_ERR(usbck_hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 21f50914c63e..37ea588cb534 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -221,7 +221,7 @@ static const struct clk_ops at91sam9n12_usb_ops = {
 
 static struct clk_hw * __init
 _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
-			     const char **parent_names, struct clk_hw **parent_hws,
+			     struct clk_hw **parent_hws,
 			     u8 num_parents, u32 usbs_mask)
 {
 	struct at91sam9x5_clk_usb *usb;
@@ -235,10 +235,7 @@ _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &at91sam9x5_usb_ops;
-	if (parent_hws)
-		init.parent_hws = (const struct clk_hw **)parent_hws;
-	else
-		init.parent_names = parent_names;
+	init.parent_hws = (const struct clk_hw **)parent_hws;
 	init.num_parents = num_parents;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		     CLK_SET_RATE_PARENT;
@@ -260,26 +257,25 @@ _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char **parent_names, struct clk_hw **parent_hws,
+			    struct clk_hw **parent_hws,
 			    u8 num_parents)
 {
-	return _at91sam9x5_clk_register_usb(regmap, name, parent_names,
-					    parent_hws, num_parents, SAM9X5_USBS_MASK);
+	return _at91sam9x5_clk_register_usb(regmap, name, parent_hws,
+					    num_parents, SAM9X5_USBS_MASK);
 }
 
 struct clk_hw * __init
 sam9x60_clk_register_usb(struct regmap *regmap, const char *name,
-			 const char **parent_names, struct clk_hw **parent_hws,
+			 struct clk_hw **parent_hws,
 			 u8 num_parents)
 {
-	return _at91sam9x5_clk_register_usb(regmap, name, parent_names,
-					    parent_hws, num_parents,
-					    SAM9X60_USBS_MASK);
+	return _at91sam9x5_clk_register_usb(regmap, name, parent_hws,
+					    num_parents, SAM9X60_USBS_MASK);
 }
 
 struct clk_hw * __init
 at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
-			     const char *parent_name, struct clk_hw *parent_hw)
+			     struct clk_hw *parent_hw)
 {
 	struct at91sam9x5_clk_usb *usb;
 	struct clk_hw *hw;
@@ -292,10 +288,7 @@ at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &at91sam9n12_usb_ops;
-	if (parent_hw)
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
-	else
-		init.parent_names = &parent_name;
+	init.parent_hws = (const struct clk_hw **)&parent_hw;
 	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT;
 
@@ -399,8 +392,7 @@ static const struct clk_ops at91rm9200_usb_ops = {
 
 struct clk_hw * __init
 at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char *parent_name, struct clk_hw *parent_hw,
-			    const u32 *divisors)
+			    struct clk_hw *parent_hw, const u32 *divisors)
 {
 	struct at91rm9200_clk_usb *usb;
 	struct clk_hw *hw;
@@ -413,10 +405,7 @@ at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &at91rm9200_usb_ops;
-	if (parent_hw)
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
-	else
-		init.parent_names = &parent_name;
+	init.parent_hws = (const struct clk_hw **)&parent_hw;
 	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_PARENT;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index dc8eb6036643..285ede5d6702 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -1065,7 +1065,7 @@ static void __init of_at91sam9x5_clk_usb_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91sam9x5_clk_register_usb(regmap, name, NULL, parent_hws,
+	hw = at91sam9x5_clk_register_usb(regmap, name, parent_hws,
 					 num_parents);
 	if (IS_ERR(hw))
 		return;
@@ -1099,7 +1099,7 @@ static void __init of_at91sam9n12_clk_usb_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91sam9n12_clk_register_usb(regmap, name, NULL, parent_hw);
+	hw = at91sam9n12_clk_register_usb(regmap, name, parent_hw);
 	if (IS_ERR(hw))
 		return;
 
@@ -1136,7 +1136,7 @@ static void __init of_at91rm9200_clk_usb_setup(struct device_node *np)
 	of_node_put(parent_np);
 	if (IS_ERR(regmap))
 		return;
-	hw = at91rm9200_clk_register_usb(regmap, name, NULL, parent_hw, divisors);
+	hw = at91rm9200_clk_register_usb(regmap, name, parent_hw, divisors);
 	if (IS_ERR(hw))
 		return;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index bdb2dfb8fa86..5e65f5b59536 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -247,18 +247,18 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char **parent_names, struct clk_hw **parent_hws,
+			    struct clk_hw **parent_hws,
 			    u8 num_parents);
 struct clk_hw * __init
 at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
-			     const char *parent_name, struct clk_hw *parent_hw);
+			     struct clk_hw *parent_hw);
 struct clk_hw * __init
 sam9x60_clk_register_usb(struct regmap *regmap, const char *name,
-			 const char **parent_names, struct clk_hw **parent_hws,
+			 struct clk_hw **parent_hws,
 			 u8 num_parents);
 struct clk_hw * __init
 at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char *parent_name, struct clk_hw *parent_hw,
+			    struct clk_hw *parent_hw,
 			    const u32 *divisors);
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index f344cbbc9c25..b3dfdcbc950f 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -302,7 +302,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	parent_hws[0] = sam9x60_pmc->chws[PMC_PLLACK];
 	parent_hws[1] = sam9x60_pmc->chws[PMC_UTMI];
 	parent_hws[2] = main_osc_hw;
-	usbck_hw = sam9x60_clk_register_usb(regmap, "usbck", NULL, parent_hws, 3);
+	usbck_hw = sam9x60_clk_register_usb(regmap, "usbck", parent_hws, 3);
 	if (IS_ERR(usbck_hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 0fce17af769e..fa14c6f7d37a 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -288,7 +288,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 	parent_hws[0] = sama5d2_pmc->chws[PMC_PLLACK];
 	parent_hws[1] = sama5d2_pmc->chws[PMC_UTMI];
-	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", NULL, parent_hws, 2);
+	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_hws, 2);
 	if (IS_ERR(usbck_hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index c00380ed0000..0713a6b21c8a 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -207,7 +207,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 
 	parent_hws[0] = sama5d3_pmc->chws[PMC_PLLACK];
 	parent_hws[1] = sama5d3_pmc->chws[PMC_UTMI];
-	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", NULL, parent_hws, 2);
+	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_hws, 2);
 	if (IS_ERR(usbck_hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 0d2a834a5903..d0bd025876ac 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -228,7 +228,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 	parent_hws[0] = sama5d4_pmc->chws[PMC_PLLACK];
 	parent_hws[1] = sama5d4_pmc->chws[PMC_UTMI];
-	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", NULL, parent_hws, 2);
+	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_hws, 2);
 	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-- 
2.39.2

