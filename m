Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7A7645E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjG0FkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjG0Fj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:39:29 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998C93A95
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:38:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb8e45185bso3494685ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436233; x=1691041033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMrH2veSKJpQGvEe5VG+6yf2IP3UM7TTWUkhUdnFvBE=;
        b=m9WxlI86VXkvIJaFZfBm9fikWzK2MXmSLJNO1gZJ2uRq6s8IzrMtlcTgZMgvEj+600
         sSBdKIlxf26m7GzYTWJMR04vM45e48dNkTtVN4IlXE3+FsqLJO67ubZqHx16RGzcOicG
         LP0JtY7a/pKBRoXgfDsPEi5Ny2Y4fbyvDNgxv23T4eqeqKGxXsjfPQcbqZwfsqzR+sp+
         nMdgyVT8zAITbTAZXsml2cdZPeguyd/OIboLKr55+OGZUL9wJOyj2+29lwzL/WuygTsI
         yjONzfNg8PiHWPPCx+Y+We/eE+UysNO0nQoux9GQ4o1VBvfwWopHWj0ILfUmlRRSiRVD
         ZD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436233; x=1691041033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMrH2veSKJpQGvEe5VG+6yf2IP3UM7TTWUkhUdnFvBE=;
        b=WNXioQhz7NmdDzykzlnF3xxwC+Hbj2vwQJkeGtjQ63tOsrFO6VtD9JJwispNdkIndk
         OJHvU4tcCV2OLcUhfq95d4JdgWJ1ZsjVZ5Rwpl1P40GZ0R836k9flpbvJSeakCb689XM
         6xtzA5iahEk2cZipCc+ugNFpln94DrmHs8UuN2bRhI1nSk2T2xXPk1tmW8ssoCvhJtxu
         QIHxzmwbckFJnuDeCuxWUaJ5Dz50L63to75aKvLvYZnGO7iLRR1Me6TMx8ugIDzOYgZX
         ie1CExoUWNRLWrDWQyOeRYhNyVwiDj9oedJxe5sOuYN2mnR2zUpyhOpeDJNyFKzwJBI9
         7trg==
X-Gm-Message-State: ABy/qLbMjI3fNq+A4zsdE4vzqB4b4NIoAY2wXB8Sg8hP3z9Js//x7ZYA
        StrkWiorWVfdmC0v9pdUjy0goQ==
X-Google-Smtp-Source: APBJJlE/b2NsE/TFI2LCOh8FQAgahRyUACaBkgzFTkwLVBYX122bL58KV0FwOFGGcwnKGd+Ib2/Stw==
X-Received: by 2002:a17:902:bcc9:b0:1b1:7362:9a18 with SMTP id o9-20020a170902bcc900b001b173629a18mr3093097pls.27.1690436232704;
        Wed, 26 Jul 2023 22:37:12 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:37:12 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 39/42] clk: at91: clk-smd: remove parent_names support
Date:   Thu, 27 Jul 2023 08:31:53 +0300
Message-Id: <20230727053156.13587-40-claudiu.beznea@tuxon.dev>
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
platforms using clk-smd driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91sam9x5.c | 2 +-
 drivers/clk/at91/clk-smd.c    | 7 ++-----
 drivers/clk/at91/dt-compat.c  | 2 +-
 drivers/clk/at91/pmc.h        | 2 +-
 drivers/clk/at91/sama5d3.c    | 2 +-
 drivers/clk/at91/sama5d4.c    | 2 +-
 6 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index f278bee3417c..93165263502e 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -232,7 +232,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	smdck_hw = at91sam9x5_clk_register_smd(regmap, "smdclk", NULL, parent_hws, 2);
+	smdck_hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_hws, 2);
 	if (IS_ERR(smdck_hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/clk-smd.c b/drivers/clk/at91/clk-smd.c
index 2c8432cc2fe6..b182c11386ea 100644
--- a/drivers/clk/at91/clk-smd.c
+++ b/drivers/clk/at91/clk-smd.c
@@ -111,7 +111,7 @@ static const struct clk_ops at91sam9x5_smd_ops = {
 
 struct clk_hw * __init
 at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
-			    const char **parent_names, struct clk_hw **parent_hws,
+			    struct clk_hw **parent_hws,
 			    u8 num_parents)
 {
 	struct at91sam9x5_clk_smd *smd;
@@ -125,10 +125,7 @@ at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &at91sam9x5_smd_ops;
-	if (parent_hws)
-		init.parent_hws = (const struct clk_hw **)parent_hws;
-	else
-		init.parent_names = parent_names;
+	init.parent_hws = (const struct clk_hw **)parent_hws;
 	init.num_parents = num_parents;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 90d92a410097..294e3b0e8a9d 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -964,7 +964,7 @@ static void __init of_at91sam9x5_clk_smd_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91sam9x5_clk_register_smd(regmap, name, NULL, parent_hws,
+	hw = at91sam9x5_clk_register_smd(regmap, name, parent_hws,
 					 num_parents);
 	if (IS_ERR(hw))
 		return;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index a0b49dd3749f..131ef55d3e47 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -237,7 +237,7 @@ at91_clk_register_sam9260_slow(struct regmap *regmap,
 
 struct clk_hw * __init
 at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
-			    const char **parent_names, struct clk_hw **parent_hws,
+			    struct clk_hw **parent_hws,
 			    u8 num_parents);
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 021e012fe202..239806dcd03d 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -211,7 +211,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	smdck_hw = at91sam9x5_clk_register_smd(regmap, "smdclk", NULL, parent_hws, 2);
+	smdck_hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_hws, 2);
 	if (IS_ERR(smdck_hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index e196ec80570f..f193460495c0 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -234,7 +234,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 	parent_hws[0] = sama5d4_pmc->chws[PMC_PLLACK];
 	parent_hws[1] = sama5d4_pmc->chws[PMC_UTMI];
-	smdck_hw = at91sam9x5_clk_register_smd(regmap, "smdclk", NULL, parent_hws, 2);
+	smdck_hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_hws, 2);
 	if (IS_ERR(smdck_hw))
 		goto err_free;
 
-- 
2.39.2

