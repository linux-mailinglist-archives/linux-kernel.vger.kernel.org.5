Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3367812F50
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444130AbjLNLsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444262AbjLNLr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:47:29 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC771A8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:53 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5522ba3f94aso1861525a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554411; x=1703159211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+ln7zR2keR4FaUbDItY5t4KbD1y5Hd3PKZ17DhMaKY=;
        b=TiaSZnUy1f20q3/f8xwGn1Qi6rnKrt86Ce8V9TTsaair15PPKDs6lkQpr+olTCGR+v
         LQ+MB5h0jQDfLtv7Ozkf3qASdTWyPguufcwZfMZNPjFJzSzLcvfjQvWCh+IWshEAO5PV
         pVLzxW2OZptgu37/ErZGC6PC6brc4P4htq9akCN6V+ll3ITOBFjjySfGsBXGQdfZKr30
         hUEsAuZsPts/0Wg9GwpxaybMBosf2UC54nHa7mBNL7DwpuG4OPsMJU0HoqC8hGCFbiCl
         ldhk/XGBoBM46ucMMFznXSnU1wgBRyTceDSfpFzV3U0dZ4D/dBuHTabXyshUVElZd5j3
         YzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554411; x=1703159211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+ln7zR2keR4FaUbDItY5t4KbD1y5Hd3PKZ17DhMaKY=;
        b=N884Q/lfZryoG9gznps5MMPLAcpAX3Jrghd7VaFSVGl4OocJWOpEi6cWlfLa1Wgp8L
         M/Xhw563biLVmoyCGrWkKS4Vay1Uz+6jlTMUE7s9sih8QYiYeCjZVti9oCH/gvSbrVp8
         kk9FKkrL/wIx06+PS/RscKn3cbRimsFHD8et3tWtdC+HHyYC2sy+XyMSwpC/icbwUFBc
         IUawS/0R4MlO01cIk5JpG+Q3HvB8WTqR1TUmd+kK0I8C4PjbSZkT3pWylys1+3r1yj/G
         zmJFgtnWixHOL/IQ9XLGjqOskCop+Fo9eN18Zc8lzY470JDihkZSHgB6He5w/xXt5a5H
         kfcg==
X-Gm-Message-State: AOJu0Yw20s6jF9Bpof3d6+7GCk6kc2vhSa82HAQd5OlCVSfpsAy3zKAp
        1lZ813GXJU+CBRhTmIu9omJTQg==
X-Google-Smtp-Source: AGHT+IFgOBx15mU54bAyPdEXoWDrhA2ZoQXpznNb85CQGcD0zg2tnQGKXuJ2ho/Ah2o3YaitijDfqA==
X-Received: by 2002:a17:906:748d:b0:a23:ff8:8528 with SMTP id e13-20020a170906748d00b00a230ff88528mr133043ejl.13.1702554411577;
        Thu, 14 Dec 2023 03:46:51 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:51 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 20/21] net: ravb: Do not apply RX CSUM settings to hardware if the interface is down
Date:   Thu, 14 Dec 2023 13:45:59 +0200
Message-Id: <20231214114600.2451162-21-claudiu.beznea.uj@bp.renesas.com>
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

Do not apply the RX CSUM settings to hardware if the interface is down. In
case runtime PM is enabled, and while the interface is down, the IP will be
in reset mode (as for some platforms disabling/enabling the clocks will
switch the IP to standby mode, which will lead to losing registers'
content) and applying settings in reset mode is not an option. Instead,
cache the RX CSUM settings and apply them in ravb_open().

Commit prepares for the addition of runtime PM.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 633346b6cd7c..9ff943dff522 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1868,6 +1868,15 @@ static int ravb_open(struct net_device *ndev)
 	if (info->gptp || info->ccc_gac)
 		ravb_ptp_init(ndev, priv->pdev);
 
+	/* Apply features that might have been changed while the interface
+	 * was down.
+	 */
+	if (ndev->hw_features & NETIF_F_RXCSUM) {
+		u32 val = (ndev->features & NETIF_F_RXCSUM) ? ECMR_RCSC : 0;
+
+		ravb_modify(ndev, ECMR, ECMR_RCSC, val);
+	}
+
 	/* PHY control start */
 	error = ravb_phy_start(ndev);
 	if (error)
@@ -2337,6 +2346,9 @@ static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
 	struct ravb_private *priv = netdev_priv(ndev);
 	unsigned long flags;
 
+	if (!netif_running(ndev))
+		return;
+
 	spin_lock_irqsave(&priv->lock, flags);
 
 	/* Disable TX and RX */
-- 
2.39.2

