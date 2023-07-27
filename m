Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5FD7645C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjG0Fid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjG0FiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:38:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C8A2D4F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-563dae89bc9so282184a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436167; x=1691040967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeeIlCY0YkV9dl6D14N0gEidgFKUnfmPXMsUhAICJi0=;
        b=ccDxRKhV5iS27apESIGTH5S5TCn6nV4keOklEAis81F2zhY4N9inDuLRgxBE5iGomf
         M0bK11YSAQgCFbRKafhDBzlGQX0BvaNJYkD6BOnyHiZ/WMvvw3V4KcDjBrwXCFJaGFWx
         Xx1NdWp/31agRWMwF/Z+AhDx4fRgq38/9Jx+WJaUvb6gR5hJAe5MmTTOyCCdqKeqozpg
         2vh1qSTVe7WumG6hJuoNMchDXuCSmFE8Slb8zUGW6JPmNQKPHtiz76OEnmcdTB0+M/0w
         ktvv0TRJpNio/k249dPGioypgnnd0RFh1H90yCDBkXt1XRIlnXzIvk98ehbvntY/N9mZ
         7flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436167; x=1691040967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeeIlCY0YkV9dl6D14N0gEidgFKUnfmPXMsUhAICJi0=;
        b=UBuwAqvuTsI9ErfvUvMfhgwhmxfJ2ow2R7dNW5L6egAPtJHZpesvqcILlV8e1R3yQm
         Stf7Ipj2524VBT5g2Hxb51m72oKqg3jOrevI2DcYd0GKnzSMI2b/sEfP9zMbw1rGcHr7
         WC4anKMQkA5I9tG9GrPqe7ruGuOBKP1jqEpRu6ZFrv1haU7Ld7jXdffrkA7I6jQD22/J
         KAtEPGYSGtstBSpOGbEYX73Pz241K4SRfIJZXz+OYz1LmuxKeTPSAL5ZumueM2FDGT0F
         gu8WDJqWg2YFAYqCr3HqthTI0YOaJkz0vogzLqqNVTNilgp4toG86SrdPErXKXmY1Xn6
         FySQ==
X-Gm-Message-State: ABy/qLafzfUId0sYMSDzkuZhBovFD7iToRSqrSKgHgKk64awr6vfmpyU
        sAWjAI5efmTDWmh984OQQf6s47o8Pgzns0OZjNFAYO5o
X-Google-Smtp-Source: APBJJlF/XwQZpd1LX1Lt4eTiYkh6jAVDh1H64Ef5bGckyVA4hPgK35Lo58LEqcGOZDq2Sh17vE+m1w==
X-Received: by 2002:a17:902:e5c4:b0:1bb:c87d:756d with SMTP id u4-20020a170902e5c400b001bbc87d756dmr4130989plf.42.1690436167186;
        Wed, 26 Jul 2023 22:36:07 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:36:06 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 30/42] clk: at91: clk-i2s-mux: remove parent_names support
Date:   Thu, 27 Jul 2023 08:31:44 +0300
Message-Id: <20230727053156.13587-31-claudiu.beznea@tuxon.dev>
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

Remove parent_names support as parent_hw support is now available on all
platforms using clk-i2s-mux driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/clk-i2s-mux.c | 8 ++------
 drivers/clk/at91/dt-compat.c   | 2 +-
 drivers/clk/at91/pmc.h         | 3 +--
 drivers/clk/at91/sama5d2.c     | 4 ++--
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/at91/clk-i2s-mux.c b/drivers/clk/at91/clk-i2s-mux.c
index f1981b8ee18d..ea84e8f5becd 100644
--- a/drivers/clk/at91/clk-i2s-mux.c
+++ b/drivers/clk/at91/clk-i2s-mux.c
@@ -50,8 +50,7 @@ static const struct clk_ops clk_i2s_mux_ops = {
 
 struct clk_hw * __init
 at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
-			  const char * const *parent_names, struct clk_hw **parent_hws,
-			  unsigned int num_parents, u8 bus_id)
+			  struct clk_hw **parent_hws, unsigned int num_parents, u8 bus_id)
 {
 	struct clk_init_data init = {};
 	struct clk_i2s_mux *i2s_ck;
@@ -63,10 +62,7 @@ at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &clk_i2s_mux_ops;
-	if (parent_hws)
-		init.parent_hws = (const struct clk_hw **)parent_hws;
-	else
-		init.parent_names = parent_names;
+	init.parent_hws = (const struct clk_hw **)parent_hws;
 	init.num_parents = num_parents;
 
 	i2s_ck->hw.init = &init;
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 058b65c2d88d..7ab116a6e701 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -279,7 +279,7 @@ static void __init of_sama5d2_clk_i2s_mux_setup(struct device_node *np)
 			continue;
 
 		hw = at91_clk_i2s_mux_register(regmap_sfr, i2s_mux_np->name,
-					       NULL, parent_hws, 2, bus_id);
+					       parent_hws, 2, bus_id);
 		if (IS_ERR(hw))
 			continue;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 11f7ab4d1ad8..07f372abcfd0 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -153,8 +153,7 @@ at91_clk_register_h32mx(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
-			  const char * const *parent_names, struct clk_hw **parent_hws,
-			  unsigned int num_parents, u8 bus_id);
+			  struct clk_hw **parent_hws, unsigned int num_parents, u8 bus_id);
 
 struct clk_hw * __init
 at91_clk_register_main_rc_osc(struct regmap *regmap, const char *name,
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 93c646e0b6ef..17a40cedd7fb 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -385,7 +385,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		parent_hws[0] = sama5d2_pmc->phws[54]; /* i2s0_clk */
 		parent_hws[1] = sama5d2_pmc->phws[54]; /* i2s0_gclk */
 		hw = at91_clk_i2s_mux_register(regmap_sfr, "i2s0_muxclk",
-					       NULL, parent_hws, 2, 0);
+					       parent_hws, 2, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -394,7 +394,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		parent_hws[0] = sama5d2_pmc->phws[55]; /* i2s1_clk */
 		parent_hws[1] = sama5d2_pmc->ghws[55]; /* i2s1_gclk */
 		hw = at91_clk_i2s_mux_register(regmap_sfr, "i2s1_muxclk",
-					       NULL, parent_hws, 2, 1);
+					       parent_hws, 2, 1);
 		if (IS_ERR(hw))
 			goto err_free;
 
-- 
2.39.2

