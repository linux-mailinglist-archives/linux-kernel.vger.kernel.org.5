Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021AD812F47
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444296AbjLNLro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444225AbjLNLrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:47:09 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361E7D7D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:48 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1ef2f5ed01so1006548166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554406; x=1703159206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYBn9/laLzrg7Vdv2MX/5C0b5odhy/gUWFCra0JFpOw=;
        b=W7zLXBgU/MmJZmapmnyy1jmsQHZ7zVFjlgXXG1EsktOvneRpT/IuxMOOMw9WM8K56+
         SWsoyZ7uC+zoDdYkq+Idik3vzN7uxAA/y3GlzqvxcJS8db8iCKB9Z72NfU0ksgPttFIL
         Cm0GvfuA7aEYcqrruZpkgwpb3guc/CFjPMCAh3uGWJ3TUOUtqBLlw0TMjvlbqPlvtSTc
         GteAnq8rhPPTKkTR0IADYOwsJsyrmkouIArwUtjlH4xvHmMM96aRCKb+038EFGSPjpGT
         iNytUewClQt6tYPHSsY1hhEJnRkFKdZ6BvdZcTLjK3FTah9rN8VmniVvN1ZqgP+E6VTr
         2zAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554406; x=1703159206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYBn9/laLzrg7Vdv2MX/5C0b5odhy/gUWFCra0JFpOw=;
        b=gga2nukTSbekk9RqY8KvfxGIOsYtdbMB/jiX0OtUhtxYsxjOskdO3ENAx0Js+zOhkE
         zpU5mpbC9z9oaxve0arLHb12AmNEpzXcbqn75YlECI9miqkc5VGIFp0RGlBKVMdpJf6S
         H4mdUk3FqIFqdR0Q120W5vzEYzNqXzYw3xq98wayN3LfcFWho5xTFkNMmHhOGN3RVmxS
         IONKr2EykkDpVqXwD9tJoZ6aa8DSbjnAStlWDF/bUWmzmnUK5wwbNCgDhnLHmDOV6aGP
         9RCTregQxJkyyZ/O2jwpp0eACsM2uAkfDoqUFyIerEAjkU1FksmKGXbx0jcqLfcIYOFW
         mV5Q==
X-Gm-Message-State: AOJu0YwEiYE+FnXc454LRhwOyDhPA7VXhyY2MEjiPogmAAkb3wPmK3c5
        nvgzUePFvxeP66bFT0fKrnY9VQ==
X-Google-Smtp-Source: AGHT+IELfCBw9NbcKSq88512K3cgJnjQwOtGysv+vOQMfS/g+oF4gHBjkLsL02Q1+qt0DyW+mANwkw==
X-Received: by 2002:a17:906:197:b0:a1b:d7a5:927a with SMTP id 23-20020a170906019700b00a1bd7a5927amr2171533ejb.183.1702554406583;
        Thu, 14 Dec 2023 03:46:46 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:45 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 17/21] net: ravb: Keep clock request operations grouped together
Date:   Thu, 14 Dec 2023 13:45:56 +0200
Message-Id: <20231214114600.2451162-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Keep clock request operations grouped togeter to have all clock-related
code in a single place. This makes the code simpler to follow.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 28 ++++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 38999ef1ea85..a2a64c22ec41 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2768,6 +2768,20 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		goto out_reset_assert;
 
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		error = PTR_ERR(priv->clk);
+		goto out_reset_assert;
+	}
+
+	if (info->gptp_ref_clk) {
+		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
+		if (IS_ERR(priv->gptp_clk)) {
+			error = PTR_ERR(priv->gptp_clk);
+			goto out_reset_assert;
+		}
+	}
+
 	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
 	if (IS_ERR(priv->refclk)) {
 		error = PTR_ERR(priv->refclk);
@@ -2801,20 +2815,6 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->avb_link_active_low =
 		of_property_read_bool(np, "renesas,ether-link-active-low");
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		error = PTR_ERR(priv->clk);
-		goto out_rpm_put;
-	}
-
-	if (info->gptp_ref_clk) {
-		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
-		if (IS_ERR(priv->gptp_clk)) {
-			error = PTR_ERR(priv->gptp_clk);
-			goto out_rpm_put;
-		}
-	}
-
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
 	ndev->min_mtu = ETH_MIN_MTU;
 
-- 
2.39.2

