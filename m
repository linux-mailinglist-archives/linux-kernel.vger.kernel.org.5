Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE097645AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjG0FgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjG0Fft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:35:49 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5D13AAE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:35:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb8e45185bso3486635ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436087; x=1691040887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/6KrvhXqa5iLUixbjzuBMiv5UYsjXjQw1Ru7hJmwyo=;
        b=p7tqgkwFoLsNlG4MKl0lVbtVdD+bXOGOQxOh6qFvDVQ71iCs2xwdGom9AGn/uqw8l3
         uo/Ts0xEX36uzQgg8NN28OubEeAM+X41hXn52DW/S/pNFHiIKFKDN1VolkzW0MkY8UHf
         TFVdbFpTVlsPy0vYRQ+qZcQHSONLtM3/qxZ94DiudPxmDxfeUPDw/fbOGW9Z1gavoavn
         E66e3X8MNL2EhipQO5qxbTepxclX8z1Monf/djmATYpDtnCVuYWiwdKfde7LrVuakRsR
         4aNS2WZIqB+hUeYktFBs7F50JstPJzh+HGoH1R9nXSSj8+wd2MqNmN6XdKqG8PWv2tyI
         KVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436087; x=1691040887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/6KrvhXqa5iLUixbjzuBMiv5UYsjXjQw1Ru7hJmwyo=;
        b=fQItVWlpLL0jx/8zf/TOzUT/9CG85QqUcikZkODJUf6q2zzYQOmfNyG/FKPCM2sZA/
         e9Hi/8wZJvzbJGTAwnfLKUpfQYBcsJY8iED4zMHPGkSjh4+BdQc7UMLl/jfsuicIlQnr
         hZuyEvHD25M4gahFUEqBaRf4UuXYMggpi+exZYE8FITAf4DQi9UCyhW7P1YhGBeM3RZo
         WWtqpqaQb3V7pP7ByOnVM/W+B6pQM/NGim3/9T8YVD9GNr2uLJN3MurYrCi0MB3wOMqx
         wpt3uakitQj4grZ0rKY5gn/rcA70WnsQDMeW4AiOBpN9B6HM/pEzByYpkNUorDT8YQmr
         xXiQ==
X-Gm-Message-State: ABy/qLZZtWFQx4YPbxUyF/o+z/WpSUSOuQH25OR+fXWm0+v1hn6ZuQOb
        FcvNWDd+6fgFGPnCvLuyMPiApA==
X-Google-Smtp-Source: APBJJlEVCaNJ7OenwzA/7lBAkzFCqELwzJ48BMLT8HbMb1NI9Bu9mnwabvkhELC4Ad8laFZ98RKiFw==
X-Received: by 2002:a17:902:b60a:b0:1b6:80f0:d969 with SMTP id b10-20020a170902b60a00b001b680f0d969mr2928961pls.11.1690436086872;
        Wed, 26 Jul 2023 22:34:46 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:34:46 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 19/42] clk: at91: clk-slow: add support for parent_hw
Date:   Thu, 27 Jul 2023 08:31:33 +0300
Message-Id: <20230727053156.13587-20-claudiu.beznea@tuxon.dev>
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

Add support for parent_hw in slow clock drivers. With this parent-child
relation is described with pointers rather than strings making
registration a bit faster.

All the SoC based drivers that rely on clk-slow were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91sam9260.c | 2 +-
 drivers/clk/at91/clk-slow.c    | 8 ++++++--
 drivers/clk/at91/dt-compat.c   | 2 +-
 drivers/clk/at91/pmc.h         | 1 +
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index f39deb3ec00a..55350331b07e 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -385,7 +385,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		parent_names[0] = "slow_rc_osc";
 		parent_names[1] = "slow_xtal";
 		hw = at91_clk_register_sam9260_slow(regmap, "slck",
-						    parent_names, 2);
+						    parent_names, NULL, 2);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index ac9f7a48b76e..bea66216ed82 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -39,11 +39,12 @@ struct clk_hw * __init
 at91_clk_register_sam9260_slow(struct regmap *regmap,
 			       const char *name,
 			       const char **parent_names,
+			       struct clk_hw **parent_hws,
 			       int num_parents)
 {
 	struct clk_sam9260_slow *slowck;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	if (!name)
@@ -58,7 +59,10 @@ at91_clk_register_sam9260_slow(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &sam9260_slow_ops;
-	init.parent_names = parent_names;
+	if (parent_hws)
+		init.parent_hws = (const struct clk_hw **)&parent_hws;
+	else
+		init.parent_names = parent_names;
 	init.num_parents = num_parents;
 	init.flags = 0;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index f464e125c9fd..dbc59ac44828 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -822,7 +822,7 @@ static void __init of_at91sam9260_clk_slow_setup(struct device_node *np)
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	hw = at91_clk_register_sam9260_slow(regmap, name, parent_names,
+	hw = at91_clk_register_sam9260_slow(regmap, name, parent_names, NULL,
 					    num_parents);
 	if (IS_ERR(hw))
 		return;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 541d2ba2fea5..6816e350d6d6 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -244,6 +244,7 @@ struct clk_hw * __init
 at91_clk_register_sam9260_slow(struct regmap *regmap,
 			       const char *name,
 			       const char **parent_names,
+			       struct clk_hw **parent_hws,
 			       int num_parents);
 
 struct clk_hw * __init
-- 
2.39.2

