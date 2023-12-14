Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B12812F25
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444218AbjLNLqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444146AbjLNLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:46:27 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A0A132
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:27 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso101502666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554386; x=1703159186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sboPzcqED4l7A2TcVT8TTFqV3DguoQYe1ei2qrslI+E=;
        b=ebcRxg6kZ6cjtU0xL4eBRKIbE+gPxPeJ3BYGM4TCCvSvMaRG5QIqhI63YeGOF41/CL
         2rVetTJdjjOYkFASXmuTSmrvr+9RQlfZhmMfZVMlpF5BHLucnIzNfHwf2FHHk1FPpxrQ
         YGKjwGih8kuKQmzSE9CTUWxOosTTPi7H/phQGFw3MSZ6xP3POdxRkto3YoUZdpu9L6AV
         Sa1O47InUGCYa4vCBfmCYoRGpur9/0GoRQZWOfGZE+wHR2xm4SNnj76jp5UgyA/1kFvl
         ssuQtcoN5pgrz6tJQMnQDXd7UPyhBq9kMtv/4RPGFOQCTQ93AsUxa252ti0YmD3/ZGmC
         3BCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554386; x=1703159186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sboPzcqED4l7A2TcVT8TTFqV3DguoQYe1ei2qrslI+E=;
        b=o1rNz+ci2ye4Z8mjzlsaTt1GlWctfjxpErUyT9z/ZD+pFpz0or6IHvnUUXRuz0p0Ib
         MNMeDRGRIrPqTVV1Jvyw2cyw+mNzjk2lAFeBwjToZvXO7F52NYNYma7RnTu17sK9JEK3
         cXju/+i1zO8b6IhhqawFkGKawNxObPaa9DaZX9kJrod4YgYjIWxotWSm+S1sq+1P25HK
         pQozNCCDk/ihn8xLSihWWCMkI5RfrTYFQs6bct6ex+ceE5qGLuJ7kWoZUKphK9OqMrwF
         KiFMi1QQcAgCHqRKmdTx/uLrmu+g2D6NuAUbLEGIb9FMfQmdHShIrGRGUfiOnxcFq0Qf
         wV/w==
X-Gm-Message-State: AOJu0Yx8tU7HyAbLYYgvZL2UAq3wtbE1/O7jAC292/H0JrIuCdUJFp/I
        yE/Ztn8H0rJmUTusfCmQDog4Ug==
X-Google-Smtp-Source: AGHT+IHl53VNtTjSgWUmsHo7m90haNzQ56Bx9egUjEPl/J+iHBivUUh8qpwlQivBaht+nSz2egnnTQ==
X-Received: by 2002:a17:906:104d:b0:a19:c793:c85c with SMTP id j13-20020a170906104d00b00a19c793c85cmr8063016ejj.6.1702554386392;
        Thu, 14 Dec 2023 03:46:26 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:26 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 05/21] net: ravb: Use tabs instead of spaces
Date:   Thu, 14 Dec 2023 13:45:44 +0200
Message-Id: <20231214114600.2451162-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use tabs instead of spaces in the ravb_set_rate_gbeth() function.
This aligns with the coding style requirements.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v2:
- collected tags

 drivers/net/ethernet/renesas/ravb_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 82085bb9b7a3..5a57383762e7 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -85,13 +85,13 @@ static void ravb_set_rate_gbeth(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 
 	switch (priv->speed) {
-	case 10:                /* 10BASE */
+	case 10:		/* 10BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_10, GECMR);
 		break;
-	case 100:               /* 100BASE */
+	case 100:		/* 100BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_100, GECMR);
 		break;
-	case 1000:              /* 1000BASE */
+	case 1000:		/* 1000BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_1000, GECMR);
 		break;
 	}
-- 
2.39.2

