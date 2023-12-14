Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD699812F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444252AbjLNLsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572882AbjLNLrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:47:18 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B481702
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:51 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a22ed5f0440so390724566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554410; x=1703159210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14qVcRtLUoxmGTGt0RCexgzno6C/e+ZUicAuIzWdGM8=;
        b=Y+m+p6IKW7np4yvKR3QIsaIFRHZ7BtcGXWxM4p8gan3plrP0UJWam9zMILEllQkOzp
         9nZN8tWs/6VP5hNn3BckBwe7B/eqIQCO7fPH1Oi+aUwC+3Z5UpDue3sPEIHUIi4UfXIw
         opqQIr70z9f/1eoxLlCdkFD6MeuIcs01NdJ02GBfLxJVFCIa4TEQhspGGBKjZS6oQWA5
         M6JYjyYoaPDkaubYLYJa22KQLuhKyqaFSabc7V0+ow5EIAOgEe/tmqj3cObCJPrbHmJc
         u5sf/tc9qqJS8vmUDg0InKcv4zyuaHnqYfJVCYlkQ5nd/cYang+ex3iHP6Igy2DlGDBn
         vMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554410; x=1703159210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14qVcRtLUoxmGTGt0RCexgzno6C/e+ZUicAuIzWdGM8=;
        b=bjSURP9Go5u/8fBPQorB+aLol9zYKaWITFKnS0Fz4IGQTUl8ajy8g9Jkiob8EokUQM
         9MR9WUph2aCodL80si76ZrfRn4Dz10qO0vUnrbd2vIgbMkt3/1mYHCCXTD9KQUvuSRrT
         j/MBkxyA5ZgYsBuD7iuV4/Aa/jPipj6BepZOs4hiUD97On+be8niNGOoRLR4PyCr9kn9
         CJoQ/qxlvZ0hraBk1YDvqE+x6W0iQrRijnxIP/2J6dND6B1GwJ0Ot/BM4F21NRcabhc/
         h3s/MW6AWT+AFT7JaG8d10hpxM/tanbon9HkmFSFcQCsILVnVBk2Kao1JKmoR1fcy0qn
         7ZIQ==
X-Gm-Message-State: AOJu0Yw8eT1em801hvnoZgbgVpi2EqqCLnU2YN2F3d54p5IRDsoG3TrF
        bpCEN0VqD55P8U+LDBXH83YGDA==
X-Google-Smtp-Source: AGHT+IHmclDok0JjLUg0rjrhrqia2ROzMPs6mwFhPJ8AeOdZc7oPAsNAsr5T6UPZrffIVAhz+HTrRA==
X-Received: by 2002:a17:907:7d8b:b0:9e3:f24d:5496 with SMTP id oz11-20020a1709077d8b00b009e3f24d5496mr3578988ejc.28.1702554410066;
        Thu, 14 Dec 2023 03:46:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:49 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 19/21] net: ravb: Do not set promiscuous mode if the interface is down
Date:   Thu, 14 Dec 2023 13:45:58 +0200
Message-Id: <20231214114600.2451162-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Do not allow setting promiscuous mode if the interface is down. In case
runtime PM is enabled, and while interface is down, the IP will be in reset
mode (as for some platforms disabling/enabling the clocks will switch the
IP to standby mode which will lead to losing registers' content).

Commit prepares for the addition of runtime PM.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 1995cf7ff084..633346b6cd7c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2164,6 +2164,9 @@ static void ravb_set_rx_mode(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	unsigned long flags;
 
+	if (!netif_running(ndev))
+		return;
+
 	spin_lock_irqsave(&priv->lock, flags);
 	ravb_modify(ndev, ECMR, ECMR_PRM,
 		    ndev->flags & IFF_PROMISC ? ECMR_PRM : 0);
-- 
2.39.2

