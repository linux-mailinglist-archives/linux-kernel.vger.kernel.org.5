Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5963E7645DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjG0Fjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjG0FjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:39:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AE93C0C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbc06f830aso3469555ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436225; x=1691041025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhTcRhK2gQ4jMW+59NMw/SaH7OUANNH6Zo/DOVN6+as=;
        b=DlLGy8hlTRIK/ljo4LGFmrYRfDnd+QvQ7CtqcZrNfjWPSXrFxRQi4Z/7shGMIDLqvK
         QMxlty1Q+Ma232hFEwGF3lSfAQZnxtK75Nl+GkFtlZdyjV9SrCAZ3ISwTHQG+d0kY6Je
         6K23ojczKRZIwqOXOP6JDy0YnX/XKf5gw4HwYQzvozTh8SdcIHYR50rxel58D5NT0z5M
         +nIvynHPLNBsZazi/zhoxTG+w1CTN6hhSm4au62rRvn2iCdeEkKFQYg+zHUO19m/9i0w
         kktYtXExlIRmASejBBzkcI5Rzz+GA+4qm4gj7hKF9obMZeKSDSaWMQQlwCQ+Iyx4BVe+
         YVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436225; x=1691041025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhTcRhK2gQ4jMW+59NMw/SaH7OUANNH6Zo/DOVN6+as=;
        b=SXsOD72GxiV74Vaf7EsHl3gkThL0mCefSzKB47KlPa+HkVdwBJRqaTaF3iUIDv7bFH
         RkALsT7YoFYhVmKq/i14I5AEW3Z/uXQ7gGkbkZHN/WP//cQ+XC7CR3Y4q4VOv4mkzTr1
         0DWhuMYKxZ7OzyzEZ5mU2H7ovjxG71MpGqSLWSmPwc77NrDsrOa+N4Ju+Spi/KaUMl/o
         Yp2AJIVgdicNCOZpfkqK37aD7MRX1BUEvsOAc5qMCZFUSMGt7Ivaa77wKT3zh4f3TN+5
         OqqiFMS9rkTXrSb1LkZkWNMFOmDyR9k5cNqhsJkIG7pdmy0xhjhM3h32+9q8RhtMRZOa
         rGUg==
X-Gm-Message-State: ABy/qLak5h+kzgZtvYgr9vJBsZLVQRTcJE+a5jyEktez1jbe8lVmHEFO
        20/xBdYPrufUUMPoNyMgG9FcyA==
X-Google-Smtp-Source: APBJJlGfluXGrnux48EdeGE9eNFdWvTPEzEfURqjbaC5EvOyWGXSriaNT9nM7vumitgl8/c6QopSTQ==
X-Received: by 2002:a17:903:1d1:b0:1b8:5bca:8256 with SMTP id e17-20020a17090301d100b001b85bca8256mr1971040plh.31.1690436225650;
        Wed, 26 Jul 2023 22:37:05 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:37:05 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 38/42] clk: at91: clk-slow: remove parent_names support
Date:   Thu, 27 Jul 2023 08:31:52 +0300
Message-Id: <20230727053156.13587-39-claudiu.beznea@tuxon.dev>
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
platforms using clk-slow driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91sam9260.c | 2 +-
 drivers/clk/at91/clk-slow.c    | 8 ++------
 drivers/clk/at91/dt-compat.c   | 2 +-
 drivers/clk/at91/pmc.h         | 1 -
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index c118ff23548b..97efc39a7e2b 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -390,7 +390,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 		parent_hws[0] = hw;
 		parent_hws[1] = slow_xtal_hw;
-		hw = at91_clk_register_sam9260_slow(regmap, "slck", NULL, parent_hws, 2);
+		hw = at91_clk_register_sam9260_slow(regmap, "slck", parent_hws, 2);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index bea66216ed82..ee2dfc44d29e 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -38,7 +38,6 @@ static const struct clk_ops sam9260_slow_ops = {
 struct clk_hw * __init
 at91_clk_register_sam9260_slow(struct regmap *regmap,
 			       const char *name,
-			       const char **parent_names,
 			       struct clk_hw **parent_hws,
 			       int num_parents)
 {
@@ -50,7 +49,7 @@ at91_clk_register_sam9260_slow(struct regmap *regmap,
 	if (!name)
 		return ERR_PTR(-EINVAL);
 
-	if (!parent_names || !num_parents)
+	if (!parent_hws || !num_parents)
 		return ERR_PTR(-EINVAL);
 
 	slowck = kzalloc(sizeof(*slowck), GFP_KERNEL);
@@ -59,10 +58,7 @@ at91_clk_register_sam9260_slow(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &sam9260_slow_ops;
-	if (parent_hws)
-		init.parent_hws = (const struct clk_hw **)&parent_hws;
-	else
-		init.parent_names = parent_names;
+	init.parent_hws = (const struct clk_hw **)&parent_hws;
 	init.num_parents = num_parents;
 	init.flags = 0;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 11fdbca8ee83..90d92a410097 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -920,7 +920,7 @@ static void __init of_at91sam9260_clk_slow_setup(struct device_node *np)
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	hw = at91_clk_register_sam9260_slow(regmap, name, NULL, parent_hws,
+	hw = at91_clk_register_sam9260_slow(regmap, name, parent_hws,
 					    num_parents);
 	if (IS_ERR(hw))
 		return;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index fe86cca2776e..a0b49dd3749f 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -232,7 +232,6 @@ at91_clk_register_programmable(struct regmap *regmap, const char *name,
 struct clk_hw * __init
 at91_clk_register_sam9260_slow(struct regmap *regmap,
 			       const char *name,
-			       const char **parent_names,
 			       struct clk_hw **parent_hws,
 			       int num_parents);
 
-- 
2.39.2

