Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1C27645C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjG0Fia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjG0FiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:38:01 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B962D5F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:12 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1bba7717d3bso469779fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436153; x=1691040953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xp28KzPE+ieFfhPUt9Jo6e3yDprwJgBDl/Tw7iUm9QY=;
        b=l/wz+kw1GJMRBj7tsp/sNDXv0czPU+bDH78cW2IpD0LbCvy5qy5joTEc9WIdlIY6Gu
         lFKHVnKW+Q5XNjpyLx6wSaIA6o2HFfv3AXsTThRRubOhxNWOvBy6wCEaXsMZ3cvK69Lq
         h/Q1XGjpLy6hJ0A2Unz0Hc7e2oPT9Qp+9yd5RBN2KxQk82BIt5BB/FLHUVJKWEWdfJnY
         N7wTns67f6gHWF83hOnmvr9weAGtquUqGSd6c4dq01r+ZJylJZcPXoouZ3FQxgNW0nmL
         3ZocZsftwM8BMXRduAJn5W9c2sby7WUB8k8zHcLkEo9XxBWoNUqUO90p6Y9lSS7LKoZB
         FNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436153; x=1691040953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xp28KzPE+ieFfhPUt9Jo6e3yDprwJgBDl/Tw7iUm9QY=;
        b=i/wvts9Piy9H93ThLf2IG42sSEliUlk7xdPWM4RFEgjzVI7N/G1HoOHnkfb2zIkfcq
         RqHuNNYIghUtmoJtSO+9yPx+mepJfkOvUlqrrTDRX8LekH9u+A96ZnBxMlTXgDCguhgX
         w+tp1I5boqHN5SoA6862XDN5ZC9B6Bp1ATvz7hNFnbIiGg+amn9C5XFyGr3i/at5SwHy
         o5qK17ClbWEisfyimab7rQES/zdVj43rRhla2J2hgRzDNcnZfKMmAu2az0RjsD9O26RC
         vGOSRjcQzy0H48PbvCaItY2ZUHC9iWPSNhNJ5tNEEd9sNeZF4QhHmlh4l6jgXrp58IGb
         5zww==
X-Gm-Message-State: ABy/qLaF7znDD/VFWDnPx+3+SnSoCo3LK6YYeFMemi7Di3SapNiw8ysM
        KthrqcAnj4a/CVNK16i7yWMvNA==
X-Google-Smtp-Source: APBJJlGFr3EU/A5Eka8jw779q9ZR6uM8cgVvTe3C2t7dO4LjZxg11yMbDuHGcm0iPCelU8t20dYJdQ==
X-Received: by 2002:a05:6871:68a:b0:1b7:6039:4c97 with SMTP id l10-20020a056871068a00b001b760394c97mr1923408oao.16.1690436152911;
        Wed, 26 Jul 2023 22:35:52 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:35:52 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 28/42] clk: at91: clk-generated: remove parent_names support
Date:   Thu, 27 Jul 2023 08:31:42 +0300
Message-Id: <20230727053156.13587-29-claudiu.beznea@tuxon.dev>
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
platforms using clk-generated driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/clk-generated.c | 10 +++-------
 drivers/clk/at91/dt-compat.c     |  2 +-
 drivers/clk/at91/pmc.h           |  3 +--
 drivers/clk/at91/sam9x60.c       |  2 +-
 drivers/clk/at91/sama5d2.c       |  2 +-
 drivers/clk/at91/sama7g5.c       |  2 +-
 6 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 4b4edeecc889..042553c7118a 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -318,8 +318,7 @@ static void clk_generated_startup(struct clk_generated *gck)
 struct clk_hw * __init
 at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 			    const struct clk_pcr_layout *layout,
-			    const char *name, const char **parent_names,
-			    struct clk_hw **parent_hws,
+			    const char *name, struct clk_hw **parent_hws,
 			    u32 *mux_table, u8 num_parents, u8 id,
 			    const struct clk_range *range,
 			    int chg_pid)
@@ -329,7 +328,7 @@ at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 	struct clk_hw *hw;
 	int ret;
 
-	if (!(parent_names || parent_hws))
+	if (!parent_hws)
 		return ERR_PTR(-ENOMEM);
 
 	gck = kzalloc(sizeof(*gck), GFP_KERNEL);
@@ -338,10 +337,7 @@ at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 
 	init.name = name;
 	init.ops = &generated_ops;
-	if (parent_hws)
-		init.parent_hws = (const struct clk_hw **)parent_hws;
-	else
-		init.parent_names = parent_names;
+	init.parent_hws = (const struct clk_hw **)parent_hws;
 	init.num_parents = num_parents;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
 	if (chg_pid >= 0)
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 91bc2fada6ec..816a7ee353d6 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -198,7 +198,7 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &dt_pcr_layout, name,
-						 NULL, parent_hws, NULL,
+						 parent_hws, NULL,
 						 num_parents, id, &range,
 						 chg_pid);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 711b55a6b0ab..87ba2586d5e5 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -143,8 +143,7 @@ at91_clk_register_audio_pll_pmc(struct regmap *regmap, const char *name,
 struct clk_hw * __init
 at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 			    const struct clk_pcr_layout *layout,
-			    const char *name, const char **parent_names,
-			    struct clk_hw **parent_hws, u32 *mux_table,
+			    const char *name, struct clk_hw **parent_hws, u32 *mux_table,
 			    u8 num_parents, u8 id,
 			    const struct clk_range *range, int chg_pid);
 
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 930b4515a1dd..43997f686b87 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -363,7 +363,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &sam9x60_pcr_layout,
 						 sam9x60_gck[i].n,
-						 NULL, parent_hws, NULL, 6,
+						 parent_hws, NULL, 6,
 						 sam9x60_gck[i].id,
 						 &sam9x60_gck[i].r, INT_MIN);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 3920de445eca..2d4bf9e1a79c 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -371,7 +371,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &sama5d2_pcr_layout,
 						 sama5d2_gck[i].n,
-						 NULL, parent_hws, NULL, 6,
+						 parent_hws, NULL, 6,
 						 sama5d2_gck[i].id,
 						 &sama5d2_gck[i].r,
 						 sama5d2_gck[i].chg_pid);
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 16e458be8304..b2d27193741b 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1235,7 +1235,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &sama7g5_pcr_layout,
-						 sama7g5_gck[i].n, NULL,
+						 sama7g5_gck[i].n,
 						 parent_hws, mux_table,
 						 num_parents,
 						 sama7g5_gck[i].id,
-- 
2.39.2

