Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2067679C525
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjILExU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjILEwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:52:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4A810D2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso6517105a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494351; x=1695099151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFiTlxos31mZKN8Uh6c4oVvz/fRV7ovmoFQ3Pg95qP4=;
        b=a8Genb1MMo9qnGJ4Ia2WF9rrOMdGv0Y8euUsUcaWXO8u/1QnMH/XreECwc2fn5cCPm
         altGNez9WJo8c3oexiPJfaqw9v9YiFUU4QsQwLDxDG7NnhjvKu7GqEnKsboEJiElmZ2Z
         TwfZc6gnfHKtJdsoMgq4V2fmsv2bSJVmZHGbbtYwIm0W3GIOu0GGBKugDTttmFmCjltI
         jPIUqYeafaOVQFf1oj5llZnM/xgMxZU1/1ArM9dwnQbldPk1to08sUA84Mrr7P4dQ3vp
         Loe1oGDHSeRrvYN/xvzMdjTXoLlDob1mkqmfuQrzB5Zei5DgCXxczMbHZldiQFfrjNT+
         4XpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494351; x=1695099151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFiTlxos31mZKN8Uh6c4oVvz/fRV7ovmoFQ3Pg95qP4=;
        b=CMbarkSAF5GiwupvBOLPuiA2S2SwIZbgL9X1DvSRRRWEivUScwVHmpoLeADuut62g1
         xCDicGi+ssAwj8MDwnndUFty0C0+pHHohROR/7EcKKdTeLvL3RyO9ETNP9B1kpm4wGnX
         BTz0hKmOBvCoYFjsVWbROqfjFzW12zimvAJyy7LTryHj3JP8chbsZZjkHn1ofpvvs3El
         AHEx9jh3jDyj0akbtVeh/A5KiWkhFnsDgs5rJF4NFExqr1UOlEs3QnOWAez8wXrIlJCJ
         1vCT6khgbHPRb5DZjSR3sxkc05wVhCMF4mNBcL8M30dVG/8vwi2DY4COdWLwz83jHHPc
         btRg==
X-Gm-Message-State: AOJu0YzBMc3sRT0mI0szdjPvpopizJrJit2Sm+sVZG/FgLVI9LAxTUcD
        GxvrM8AvHER1JjKLEKFq1drxOQ==
X-Google-Smtp-Source: AGHT+IHvXYlpSeIl2bJTyCpJyr22692xyTHOLLmpYrZKXA9nSCycNWCzrlEZbFMAFY3iFGTOCaQSgw==
X-Received: by 2002:a05:6402:1619:b0:523:3e5d:8aa2 with SMTP id f25-20020a056402161900b005233e5d8aa2mr8652712edv.14.1694494351322;
        Mon, 11 Sep 2023 21:52:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:31 -0700 (PDT)
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
Subject: [PATCH 07/37] clk: renesas: rzg2l: lock around writes to mux register
Date:   Tue, 12 Sep 2023 07:51:27 +0300
Message-Id: <20230912045157.177966-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

SD MUX output (SD0) is further divided by 4 in G2{L, UL}. The divided
clock is SD0_DIV4. SD0_DIV4 is registered with CLK_SET_RATE_PARENT which
means a rate request for it is propagated to the MUX and could reach
rzg2l_cpg_sd_clk_mux_set_parent() concurrently with the users of SD0.
Add proper locking to avoid concurrent access on SD MUX set rate
registers.

Fixes: eaff33646f4cb ("clk: renesas: rzg2l: Add SDHI clk mux support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 70d1c28ba088..1195d4b1f545 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -189,6 +189,7 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	u32 shift = GET_SHIFT(hwdata->conf);
 	const u32 clk_src_266 = 2;
 	u32 msk, val, bitmask;
+	unsigned long flags;
 	int ret;
 
 	/*
@@ -203,25 +204,27 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	 * the index to value mapping is done by adding 1 to the index.
 	 */
 	bitmask = (GENMASK(GET_WIDTH(hwdata->conf) - 1, 0) << shift) << 16;
+	spin_lock_irqsave(&priv->rmw_lock, flags);
 	if (index != clk_src_266) {
 		writel(bitmask | ((clk_src_266 + 1) << shift), priv->base + off);
 
 		msk = off ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
 
-		ret = readl_poll_timeout(priv->base + CPG_CLKSTATUS, val,
-					 !(val & msk), 100,
-					 CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
-		if (ret) {
-			dev_err(priv->dev, "failed to switch clk source\n");
-			return ret;
-		}
+		ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
+						!(val & msk), 100,
+						CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
+		if (ret)
+			goto unlock;
 	}
 
 	writel(bitmask | ((index + 1) << shift), priv->base + off);
 
-	ret = readl_poll_timeout(priv->base + CPG_CLKSTATUS, val,
-				 !(val & msk), 100,
-				 CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
+	ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
+					!(val & msk), 100,
+					CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
+unlock:
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+
 	if (ret)
 		dev_err(priv->dev, "failed to switch clk source\n");
 
-- 
2.39.2

