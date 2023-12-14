Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD1812F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572886AbjLNLrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444206AbjLNLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:46:57 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49951D6D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5526c14b8f8so691150a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554405; x=1703159205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoiORotVHtzab0Z6R5tqUvsar+MHiUXnH/O7lUfaa34=;
        b=VDRP0MYqeIxkNCwLg1+URch3+vUo8qgO7a1B9GIQ9sq8G2Jzn6TEJHo4n/kbNcT0TQ
         UzeoerzztzZ9yt9Jx4oulqrRdu74mLvZQbfL5eT2rsWr8HCLu5BzTj6rk8sHcnFAfTt5
         CwiGIJlGtcWm4pz+N3VmlQ5HTAr9vERm11jB6w2taQDq2DtHbcdR8lIPym5PgMTbGuoe
         FaHH8gDnhn2CmZruZFXLO3lPx1+b3C+KXwogPyZ8IRsBfR2v6NJfy/Tt6j+eSymwZ6Mj
         fCFpOlymA63cxhPLuY1kd5+3o4wS5N9PWYLoXRETnDiSswU4koAfuYFBRutqcZIQRfSV
         +K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554405; x=1703159205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoiORotVHtzab0Z6R5tqUvsar+MHiUXnH/O7lUfaa34=;
        b=SlWUhfQRiJC67INjAvcQ2yykewPj5Nd1ReIU/Oq7p7VfA/h6D+LNKnl14PWWsCsNMI
         tZ+++EOzis5WxK47LwsyAw+9Fky9RZ4EbBb6LgVr2QXZyhd9Lqgl0QbGmcxdlCBu9hPj
         Dh5jQriFhZPwTTl+dFBR6c0sEKq/5zeqPOoPKLiSHOdu1USEf69xJA0aKsRpnKWjEO4f
         WREHZV9LQ/SMR5Kts2vsiEKs5n4VnXhFRzDgaXejdUjleS28neE7sgDkb762Xyb7eRTr
         RLxwVYtBi6Z5kpqeCvUQUSvyD0/cgpiMxUbaGgcEI6oDsUhdt4EdQ6d/sdthokXMIYjC
         mqPA==
X-Gm-Message-State: AOJu0Ywl2cfRuJvvMVNRUuVIt7g2LlVseB68ylTqA0/2uZeDaxaDrv5K
        ddVE9zDkXVK/tdp6fPi5RNZ/dQ==
X-Google-Smtp-Source: AGHT+IEkHkIjbZxyWNnhWgVzwKp1oLjVB6rkXJC6EiXk5LsZBUGVINMSQUgKJqcBBpk9Att/KP854w==
X-Received: by 2002:a17:906:de:b0:a19:a1ba:bada with SMTP id 30-20020a17090600de00b00a19a1babadamr2578053eji.128.1702554404767;
        Thu, 14 Dec 2023 03:46:44 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:44 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 16/21] net: ravb: Keep the reverse order of operations in ravb_close()
Date:   Thu, 14 Dec 2023 13:45:55 +0200
Message-Id: <20231214114600.2451162-17-claudiu.beznea.uj@bp.renesas.com>
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

Keep the reverse order of operations in ravb_close() when comparing with
ravb_open(). This is the recommended configuration sequence.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index b581666e341f..38999ef1ea85 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2182,6 +2182,14 @@ static int ravb_close(struct net_device *ndev)
 	ravb_write(ndev, 0, RIC2);
 	ravb_write(ndev, 0, TIC);
 
+	/* PHY disconnect */
+	if (ndev->phydev) {
+		phy_stop(ndev->phydev);
+		phy_disconnect(ndev->phydev);
+		if (of_phy_is_fixed_link(np))
+			of_phy_deregister_fixed_link(np);
+	}
+
 	/* Stop PTP Clock driver */
 	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
@@ -2200,14 +2208,6 @@ static int ravb_close(struct net_device *ndev)
 		}
 	}
 
-	/* PHY disconnect */
-	if (ndev->phydev) {
-		phy_stop(ndev->phydev);
-		phy_disconnect(ndev->phydev);
-		if (of_phy_is_fixed_link(np))
-			of_phy_deregister_fixed_link(np);
-	}
-
 	cancel_work_sync(&priv->work);
 
 	if (info->nc_queues)
-- 
2.39.2

