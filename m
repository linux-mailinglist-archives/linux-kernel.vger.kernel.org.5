Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752E876457A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjG0Fck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjG0Fci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:32:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3442721
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:32:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bbc87ded50so3442855ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690435957; x=1691040757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uyw3PNfZIGdqDhQAwksMXr4rBdSDRWmBdpkW/XA90lY=;
        b=drVvjIcn6IwB7Xn0zmy1NP5nq8SSNIQeAYnATBZ8fVrsX3Re7hS8xvzwCPrOOmVYDT
         yvIrdOKnD205U8KOaVniDdHmXe61quc45RJ0Xm894JcBaaGRr4BKabCckcXl5URiQWH0
         OGbAX7YKljP3iTfl/3QanAGlykvZsQi5Y0AYQrXpWJViHwMX+u6xE7IXKi/2Z0Th2JQG
         IBiQCMQdJMO/DQaTOPzXZ1Tq9oT1VWrQk0dSWDwwnMayGY9EoNDPEtcPQjFfsnoaccIx
         5iW8qx8pC5Q4xnmtaK6y7SmD1mHgGXItb87R/AB/rTYXh3OuZAYkoO7kg72q+pYebyVk
         KTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690435957; x=1691040757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uyw3PNfZIGdqDhQAwksMXr4rBdSDRWmBdpkW/XA90lY=;
        b=jHvdPV5Mnbai0Y2qODGWbw2rgXyKOY3zNEzxBxcG+TVDi4SNiSSppzuIoZkfm/Wujj
         2U3cc+Qy3X4+I7cc4RcdQ2GEBuucJxfoKxn+ssgHjGB+kvh/iGZiSCR6J0BuIwB9OkSr
         89OWpB8g87sIh2/Ipi10hf5RniTBQBdVKejUujMH8c7EyPQ3G2jsmsYNcwtw223EmZit
         fpVizec6f6McrPnK+yP5XvR3fWLBZCbxiCT1lBYY5o4243/xEv4y2ap1ChhcM9gx8Glb
         +PG74I7COdTt+pjsdZPXRfDXl8vTTcsCal3wPJKACMkgYbG2sPs75B0ItmEOpvyo42Yu
         t9hw==
X-Gm-Message-State: ABy/qLYcPCWjZ9iZ8CWEG/7IMLmFo2zIGmRq/T9M3pPvWsnCmB773Z2A
        QzyicsPUwHP4RF58xgGFuil7dQ==
X-Google-Smtp-Source: APBJJlFaiXidP9D8t/SlKdr/7PjGHe8B2LxzQ0uXp+qc5AmYStgN8YypNaZm+7pCUSKDHPRfKQtsJw==
X-Received: by 2002:a17:903:2305:b0:1b8:1687:b53 with SMTP id d5-20020a170903230500b001b816870b53mr4574340plh.26.1690435956889;
        Wed, 26 Jul 2023 22:32:36 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:32:36 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 01/42] clk: at91: sama7g5: check __clk_get_hw() argument for errors
Date:   Thu, 27 Jul 2023 08:31:15 +0300
Message-Id: <20230727053156.13587-2-claudiu.beznea@tuxon.dev>
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

__clk_get_hw() argument in sama7g5 is obtained using
of_clk_get_by_name() which might return error. Passing an error casted
pointer to __clk_get_hw() may lead to crashes. Thus, check the pointer
for errors before passing it to __clk_get_hw().

Fixes: de3383e993a5 ("clk: at91: sama7g5: switch to parent_hw and parent_data")
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/sama7g5.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 91b5c6f14819..16e458be8304 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -988,14 +988,27 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	struct clk_hw *td_slck_hw, *md_slck_hw;
 	static struct clk_parent_data parent_data;
 	struct clk_hw *parent_hws[10];
+	struct clk *clk;
 	bool bypass;
 	int i, j;
 
-	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
-	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
-	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
-
-	if (!td_slck_hw || !md_slck_hw || !main_xtal_hw)
+	clk = of_clk_get_by_name(np, "td_slck");
+	if (IS_ERR(clk))
+		return;
+	td_slck_hw = __clk_get_hw(clk);
+	if (!td_slck_hw)
+		return;
+	clk = of_clk_get_by_name(np, "md_slck");
+	if (IS_ERR(clk))
+		return;
+	md_slck_hw = __clk_get_hw(clk);
+	if (!md_slck_hw)
+		return;
+	clk = of_clk_get_by_name(np, main_xtal_name);
+	if (IS_ERR(clk))
+		return;
+	main_xtal_hw = __clk_get_hw(clk);
+	if (!main_xtal_hw)
 		return;
 
 	regmap = device_node_to_regmap(np);
-- 
2.39.2

