Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507BA7F0DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjKTIqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjKTIqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:46:37 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168CFD51
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332c7d4a6a7so360372f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469989; x=1701074789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X03fkvD/NmOk7FgJvVd2vA4cAoE3eXt5JBylRkbge34=;
        b=VUQPU/G8li7LV8UImVQnl6eH1YdsTdMPeMdYKJFo06tj0MIQ0ripS076wB4txtetXw
         TskECWtfuId9X3jmcv7W+L11HIKCBGLliELgDLtxVYcqOgTXq1VLI1WrPBIXL0hmN6Mm
         dX9unbFe9YucMGpq+IEyScGLAL3EwyA4R+OtpaQnMzvUxG9tNk0yJGsVAyHiSL469+fE
         e2ghgQg2Rv8GxDKF0SGfGm8ifO0wNdjKpcCdHSobf5a0l/z0z/nMGFMmV0Qx2gyJJs1D
         jdq4LeyVC73uu5a6gnPmYMPaynCaBDvScNaNlERMv00c7UnH/82n83dpr+k+4Y84fNFM
         8/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469989; x=1701074789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X03fkvD/NmOk7FgJvVd2vA4cAoE3eXt5JBylRkbge34=;
        b=uhYdOK9FJAKiUo5PIAlffh0pYfaa9O7oSGKe8ll50vR1jQb17pfRV8OrZilu01a4Pm
         Yovn3odZLF0u99ZR5PeUDSS/Z4vvR0WxSZNdYa7d/h+lFavaIHsELvWgyZj4pNach3/M
         n7WYnIpnG7DMLZE5k+wPvxBV1ULp7pS0FDu7IKBw23k3zqYJP5uy8Apq2Q4xk4Mc7ShD
         uiKymH2gjmgtMXnTqLn2xP36SZr5zBXhgrNX6r0hg9QWPBD/VjufuvpgYnLU/ewcSVNS
         wstI9eOZU1sCmI/hSro+DkhwyMPXv5VpH+wrIwhEwJM0r2M86IY7hPiJ0JfNMfC3ROWM
         bmgA==
X-Gm-Message-State: AOJu0YzMsJ2/ab0d5XmhRLkB1AlEZcLGXYnXbYKyWngDFAvU+XW/OR+w
        +GHX6VQZnzKm1Kv7Pyf+W3J07TcqOM/zL0R7PH8=
X-Google-Smtp-Source: AGHT+IFSlGhbc9YVoJY/Cj/t9l8QVKfrxCMhnLQGLI4Mxl0wHVZMEMgDMtkKoth9oaA89rn5KUGRJw==
X-Received: by 2002:a5d:5b8c:0:b0:32d:96a7:9551 with SMTP id df12-20020a5d5b8c000000b0032d96a79551mr3771027wrb.36.1700469989563;
        Mon, 20 Nov 2023 00:46:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:29 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, p.zabel@pengutronix.de,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        wsa+renesas@sang-engineering.com, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 06/13] net: ravb: Let IP specific receive function to interrogate descriptors
Date:   Mon, 20 Nov 2023 10:45:59 +0200
Message-Id: <20231120084606.4083194-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
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

ravb_poll() initial code used to interrogate the first descriptor of the
RX queue in case gptp is false to know if ravb_rx() should be called.
This is done for non GPTP IPs. For GPTP IPs the driver PTP specific
information was used to know if receive function should be called. As
every IP has it's own receive function that interrogates the RX descriptor
list in the same way the ravb_poll() was doing there is no need to double
check this in ravb_poll(). Removing the code form ravb_poll() and
adjusting ravb_rx_gbeth() leads to a cleaner code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 588e3be692d3..0fc9810c5e78 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -771,12 +771,15 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	int limit;
 
 	entry = priv->cur_rx[q] % priv->num_rx_ring[q];
+	desc = &priv->gbeth_rx_ring[entry];
+	if (desc->die_dt == DT_FEMPTY)
+		return false;
+
 	boguscnt = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	stats = &priv->stats[q];
 
 	boguscnt = min(boguscnt, *quota);
 	limit = boguscnt;
-	desc = &priv->gbeth_rx_ring[entry];
 	while (desc->die_dt != DT_FEMPTY) {
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
@@ -1279,25 +1282,16 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	struct net_device *ndev = napi->dev;
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	bool gptp = info->gptp || info->ccc_gac;
-	struct ravb_rx_desc *desc;
 	unsigned long flags;
 	int q = napi - priv->napi;
 	int mask = BIT(q);
 	int quota = budget;
-	unsigned int entry;
 
-	if (!gptp) {
-		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
-		desc = &priv->gbeth_rx_ring[entry];
-	}
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	if (gptp || desc->die_dt != DT_FEMPTY) {
-		if (ravb_rx(ndev, &quota, q))
-			goto out;
-	}
+	if (ravb_rx(ndev, &quota, q))
+		goto out;
 
 	/* Processing TX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
-- 
2.39.2

