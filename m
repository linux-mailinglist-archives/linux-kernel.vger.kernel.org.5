Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE56A7B2B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjI2FkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjI2Fj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:39:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749C9CC7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a64619d8fbso1846652066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695965971; x=1696570771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tx8IsOEvb8qkvUy2Or6MBahI0OwwMce9fHoVPFho48=;
        b=C4lp08O6yska7znKdYMmclZfGa3X6+zuJBT3DJfQ5oFKoe9K9y7j8LuAzgRiYdNfmh
         5hzYKxAleR/W+F4qeYhKDx7HWinwO/whkxrbHVI84w6dN9Qxh8shf/x62wyy5g3zPsCa
         N1xq1GjBB50q7BwpUN8RchxaYfphycRls3aHGCMsN6VgFjWAV3CozP37FGuU4/UTU3DO
         kyeR1VNOoMj2Lsxg085moJky6ahF+z7OABVZtHX1No3Cx6kOPD8g2YcOCdTgXJ/JV+GT
         EhyqUJC8cET6tgiAFt3jBN2SCqRgCIBNp2WEeDqwpwcBUuhJcyKyymOgsL6y79be6J/l
         3mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695965971; x=1696570771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Tx8IsOEvb8qkvUy2Or6MBahI0OwwMce9fHoVPFho48=;
        b=KGtNL5UFlzFWWd+iMssfWK6X2a+Ppcm9cqRyre+Cl6WeFKCfs3M+LsyHnb9SPLHBy3
         iHHc415PQaMY2jW9ZHf/7XK/zfy0iLw/xQnNUxLasE9G38ELegWAjuP6mYzcfWJETtWy
         lvYK2VfRwWMCITLk2BsE15wjzXJSa1H8+OmyoDCqHABILjUD0T+sGNVJbjL8p9TRqlDf
         /gyMpZt8DMWW1INs/Fhrt5j2/aRWjFtvfM0DxwYdBhbx0pZNFaUgLOJtfHJHcRy6GIZA
         /aIY7tiV4khgUPey87O579YRW+05UmRlLQYuW1LCMde9YxOJbpSie4Awh16qb15+0zQL
         GEnA==
X-Gm-Message-State: AOJu0Yx/Y7LhlBOCvNH1rMW3bnZXwYQxJdXKJJSWJy0itUNVwYWO21iA
        DcUc+xn/R7alrv1MGnNSfVpE5ZWxyYEu57wCsG8=
X-Google-Smtp-Source: AGHT+IFssgixc+IrMTS/V7svcvYp3mqrtz9kBpFjxlgOV+eCYx41PSPSVkMAV0EmJXCg9RRV7OOD1A==
X-Received: by 2002:a17:906:845b:b0:9ae:695a:fed1 with SMTP id e27-20020a170906845b00b009ae695afed1mr2909592ejy.1.1695965971645;
        Thu, 28 Sep 2023 22:39:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:39:31 -0700 (PDT)
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
Subject: [PATCH v2 06/28] clk: renesas: rzg2l: remove critical area
Date:   Fri, 29 Sep 2023 08:38:53 +0300
Message-Id: <20230929053915.1530607-7-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

spinlock in rzg2l_mod_clock_endisable() is intended to protect the accesses
to hardware register. There is no need to protect the instructions that set
temporary variable which will be then written to register. With this only
one write to one clock register is executed thus locking/unlocking rmw_lock
is removed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- removed also the spinlock
- s/reduce/remove in patch title

 drivers/clk/renesas/rzg2l-cpg.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index f411e428196c..d936832e098f 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -895,7 +895,6 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	struct rzg2l_cpg_priv *priv = clock->priv;
 	unsigned int reg = clock->off;
 	struct device *dev = priv->dev;
-	unsigned long flags;
 	u32 bitmask = BIT(clock->bit);
 	u32 value;
 	int error;
@@ -907,14 +906,12 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 
 	dev_dbg(dev, "CLK_ON %u/%pC %s\n", CLK_ON_R(reg), hw->clk,
 		enable ? "ON" : "OFF");
-	spin_lock_irqsave(&priv->rmw_lock, flags);
 
 	value = bitmask << 16;
 	if (enable)
 		value |= bitmask;
-	writel(value, priv->base + CLK_ON_R(reg));
 
-	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+	writel(value, priv->base + CLK_ON_R(reg));
 
 	if (!enable)
 		return 0;
-- 
2.39.2

