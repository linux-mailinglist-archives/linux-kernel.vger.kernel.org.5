Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1911376457C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjG0Fcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjG0Fcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:32:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A582D57
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:32:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bbd2761f1bso4432445ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690435964; x=1691040764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9Gh+k+Ek4/VSm59HjYvHVbU+3yoxdSusT5dev6nYow=;
        b=LC1J1Cspx60GAUJsiTYmriRBilILtB3wnVGXGVwUYiEVkyKZVVj9DrQuqW8vu42JIg
         4TivKz5mquFmDFqUsR5TiW5UglqjyNnMsLOz2tDXc22bg4Qhq0BAHFDxCCBOq9tsSdpd
         bCJ/jO6y7mmwTbLoJnV9tc5LSjHWe7AmJd8arnTdqtnbdo4wUPdoG84Cx/duznARUYob
         Ik6lyEg+Sn2uWDhaGRHUVFwJvX50f69JCqP1xrYoUh48ePMDtgrd5bNX50TxFQ0MaMUp
         anQaywJUrycIpgKEqpfC/ZEEivAk/Ubf8ai5zbUivZGSVNANTZPEvx+qvEWFRr1rx6yR
         HnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690435964; x=1691040764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9Gh+k+Ek4/VSm59HjYvHVbU+3yoxdSusT5dev6nYow=;
        b=U1P6Wj3lfQ5PdgoNHWHT8AlWDpxz/1SuvEdV3b5hEL3Wr5sE9mDsBCNLNwCxjG2Oxb
         E/rcygrp6wsjefb9ESU2Vm5r7OaXCLb/r7u1qnQvxYvtMEDBeB/LbJmHPeA5oDT8Qrnm
         HWorNjaS69laABG/eHdDjT3oUHVhwknVNNBNvH8qDqWUQJOCyGaYPNws3NfvKekJMpau
         MnXux7t18JYlUyvMrxv/LCrlDrBIAf86bNkhtO68ZhyESgTWnXHPTpXwYM7Qnq/sSJIv
         CsuXGLVWo1E8tgHnmoJtToLe9565sszDdMGsV9Y4X8UBi02dtxgqRt+HQ28ocrciP24l
         zvzA==
X-Gm-Message-State: ABy/qLYEIkOdQZOFID8i6xcSASXAztIZBIcsVA69/FpJK2nMXzY9AL3s
        8oJbA9xMVU/QTsY0ChsQM5xxFw==
X-Google-Smtp-Source: APBJJlFrr5ZD5hclfXPll+bVt+fiL3e69OnCXZKnKadyR197MJfhDlT6oGdFH6zBnyDw2HINzYSoug==
X-Received: by 2002:a17:902:d501:b0:1b8:b5f8:c485 with SMTP id b1-20020a170902d50100b001b8b5f8c485mr5337310plg.50.1690435964153;
        Wed, 26 Jul 2023 22:32:44 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:32:43 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 02/42] clk: at91: clk-usb: add support for parent_hw
Date:   Thu, 27 Jul 2023 08:31:16 +0300
Message-Id: <20230727053156.13587-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for parent_hw in usb clock driver. With this parent-child
relation is described with pointers rather than strings making
registration a bit faster.

All the SoC based drivers that rely on clk-usb were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91rm9200.c  |  2 +-
 drivers/clk/at91/at91sam9260.c |  2 +-
 drivers/clk/at91/at91sam9g45.c |  2 +-
 drivers/clk/at91/at91sam9n12.c |  2 +-
 drivers/clk/at91/at91sam9x5.c  |  2 +-
 drivers/clk/at91/clk-usb.c     | 41 ++++++++++++++++++++++------------
 drivers/clk/at91/dt-compat.c   |  6 ++---
 drivers/clk/at91/pmc.h         | 11 +++++----
 drivers/clk/at91/sam9x60.c     |  2 +-
 drivers/clk/at91/sama5d2.c     |  2 +-
 drivers/clk/at91/sama5d3.c     |  2 +-
 drivers/clk/at91/sama5d4.c     |  2 +-
 12 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 3f19e737ae4d..e5a034f208d8 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -157,7 +157,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	at91rm9200_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", usb_div);
+	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", NULL, usb_div);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 0799a13060ea..ae6f126f204a 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -434,7 +434,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	at91sam9260_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", usb_div);
+	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", NULL, usb_div);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index f45a7b80f7d8..684d2bcb36e8 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -176,7 +176,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 
 	parent_names[0] = "plladivck";
 	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
+	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 751786184ae2..9fc20b177b13 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -201,7 +201,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 
 	at91sam9n12_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91sam9n12_clk_register_usb(regmap, "usbck", "pllbck");
+	hw = at91sam9n12_clk_register_usb(regmap, "usbck", "pllbck", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 3b801d12fac0..5728cfb9036f 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -222,7 +222,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 	parent_names[0] = "plladivck";
 	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
+	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index b0696a928aa9..21f50914c63e 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -221,12 +221,12 @@ static const struct clk_ops at91sam9n12_usb_ops = {
 
 static struct clk_hw * __init
 _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
-			     const char **parent_names, u8 num_parents,
-			     u32 usbs_mask)
+			     const char **parent_names, struct clk_hw **parent_hws,
+			     u8 num_parents, u32 usbs_mask)
 {
 	struct at91sam9x5_clk_usb *usb;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
@@ -235,7 +235,10 @@ _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &at91sam9x5_usb_ops;
-	init.parent_names = parent_names;
+	if (parent_hws)
+		init.parent_hws = (const struct clk_hw **)parent_hws;
+	else
+		init.parent_names = parent_names;
 	init.num_parents = num_parents;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		     CLK_SET_RATE_PARENT;
@@ -257,27 +260,30 @@ _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char **parent_names, u8 num_parents)
+			    const char **parent_names, struct clk_hw **parent_hws,
+			    u8 num_parents)
 {
 	return _at91sam9x5_clk_register_usb(regmap, name, parent_names,
-					    num_parents, SAM9X5_USBS_MASK);
+					    parent_hws, num_parents, SAM9X5_USBS_MASK);
 }
 
 struct clk_hw * __init
 sam9x60_clk_register_usb(struct regmap *regmap, const char *name,
-			 const char **parent_names, u8 num_parents)
+			 const char **parent_names, struct clk_hw **parent_hws,
+			 u8 num_parents)
 {
 	return _at91sam9x5_clk_register_usb(regmap, name, parent_names,
-					    num_parents, SAM9X60_USBS_MASK);
+					    parent_hws, num_parents,
+					    SAM9X60_USBS_MASK);
 }
 
 struct clk_hw * __init
 at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
-			     const char *parent_name)
+			     const char *parent_name, struct clk_hw *parent_hw)
 {
 	struct at91sam9x5_clk_usb *usb;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
@@ -286,7 +292,10 @@ at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &at91sam9n12_usb_ops;
-	init.parent_names = &parent_name;
+	if (parent_hw)
+		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT;
 
@@ -390,11 +399,12 @@ static const struct clk_ops at91rm9200_usb_ops = {
 
 struct clk_hw * __init
 at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char *parent_name, const u32 *divisors)
+			    const char *parent_name, struct clk_hw *parent_hw,
+			    const u32 *divisors)
 {
 	struct at91rm9200_clk_usb *usb;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
@@ -403,7 +413,10 @@ at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &at91rm9200_usb_ops;
-	init.parent_names = &parent_name;
+	if (parent_hw)
+		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_PARENT;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index a32dc2111b90..ead99948375b 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -945,7 +945,7 @@ static void __init of_at91sam9x5_clk_usb_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91sam9x5_clk_register_usb(regmap, name, parent_names,
+	hw = at91sam9x5_clk_register_usb(regmap, name, parent_names, NULL,
 					 num_parents);
 	if (IS_ERR(hw))
 		return;
@@ -975,7 +975,7 @@ static void __init of_at91sam9n12_clk_usb_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91sam9n12_clk_register_usb(regmap, name, parent_name);
+	hw = at91sam9n12_clk_register_usb(regmap, name, parent_name, NULL);
 	if (IS_ERR(hw))
 		return;
 
@@ -1008,7 +1008,7 @@ static void __init of_at91rm9200_clk_usb_setup(struct device_node *np)
 	of_node_put(parent_np);
 	if (IS_ERR(regmap))
 		return;
-	hw = at91rm9200_clk_register_usb(regmap, name, parent_name, divisors);
+	hw = at91rm9200_clk_register_usb(regmap, name, parent_name, NULL, divisors);
 	if (IS_ERR(hw))
 		return;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 0f52e80bcd49..515a3c5595b7 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -257,16 +257,19 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char **parent_names, u8 num_parents);
+			    const char **parent_names, struct clk_hw **parent_hws,
+			    u8 num_parents);
 struct clk_hw * __init
 at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
-			     const char *parent_name);
+			     const char *parent_name, struct clk_hw *parent_hw);
 struct clk_hw * __init
 sam9x60_clk_register_usb(struct regmap *regmap, const char *name,
-			 const char **parent_names, u8 num_parents);
+			 const char **parent_names, struct clk_hw **parent_hws,
+			 u8 num_parents);
 struct clk_hw * __init
 at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char *parent_name, const u32 *divisors);
+			    const char *parent_name, struct clk_hw *parent_hw,
+			    const u32 *divisors);
 
 struct clk_hw * __init
 at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index e309cbf3cb9a..ddf993fe391f 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -297,7 +297,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	parent_names[0] = "pllack_divck";
 	parent_names[1] = "upllck_divck";
 	parent_names[2] = "main_osc";
-	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 3);
+	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, NULL, 3);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index c16594fce90c..8bbc34e22cda 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -284,7 +284,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 	parent_names[0] = "plladivck";
 	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
+	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 522ce6031446..05d0cdd22bc4 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -201,7 +201,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 
 	parent_names[0] = "plladivck";
 	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
+	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 160c0bddb6a3..da84b4cef827 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -222,7 +222,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 	parent_names[0] = "plladivck";
 	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
+	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
-- 
2.39.2

