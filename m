Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565667FB391
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343988AbjK1IFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343986AbjK1IEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:04:43 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5033E1A3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:04:49 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40859dee28cso41748885e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701158688; x=1701763488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTVx8N2lyLVeP/GZzmvvrZO4776iEUf9UriNFWs6nw4=;
        b=btPiitC99qPsBgEM94E46UgZB7+GJfKZdtn6J7Gckw3he8kTGnxcUnc6GwqkSf8Dd+
         Rw7WQ9nf7agG9IlppmHfSombhRYKlZw4FWXo+xXPvwKriiJ9xY+qLC6iHF+sG0NuQF01
         Mhyz/R6OvjIsBK1qO0xe3rdQ5I6XK75Ifrp7G2nFrPZKHKuecDtuiod9KMAX0KrWN29/
         3z9JD3TcdzyEoMcrY79WmYjGjqiaBSoJi80veH8iHGcTQcX+6UCWzvkpwLjBapaj0YRb
         zOw18C8BKGHWlrDVTyy+h9V/oKQ5yCKINE6o3i0q3q1YBIPO7GW6uuX7oAg9Ck6WoFuO
         O3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158688; x=1701763488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTVx8N2lyLVeP/GZzmvvrZO4776iEUf9UriNFWs6nw4=;
        b=K6LwQQGy/z0I9oUlavfYJO4fQ98uMNhM2t3DwBRDXNUi5UHUhuXaII9pJ47ExgDY8P
         fu2jvw5tXVIGuQZ9xL3KLrXJHEk9tIMAF1kbqCUnqJAZ6SWv8RgjYbEc3lI9+MGTA79H
         tK2oi8i6oK4OE2s6D8HyklnVamzGYtU/rKS7KGO7VBtqybUWvRG3gyLcfuweAL2zsTjX
         Zy3CPHTomp0RStKJ9/dAIvEERhj6AhKWra4N/+gntX9uvvOZWgd/yL0aFH0sI1FEmOAa
         2XkvA3XgwkaZrJqesDFBNIPs1gVHr7AHhsJf7wu5HbE1UGW52IsBwKoUPdAPxRzOHIVq
         7E+A==
X-Gm-Message-State: AOJu0YxenutgwmeiUqGD9HXvODDKAsMlUEYa3AJAzhQt4EVRufAhWWD3
        46OHRM58Mx+VPBbrUQ/2HTIE7A==
X-Google-Smtp-Source: AGHT+IFyVl5DgTjPU+gokz2yqs2Qa0rEamBDcYdphY/WmgNzjG2BIF2ih2kCDELTlkbG0p0uVZjPbg==
X-Received: by 2002:a05:600c:4e94:b0:40b:4c36:f80 with SMTP id f20-20020a05600c4e9400b0040b4c360f80mr810627wmq.32.1701158687784;
        Tue, 28 Nov 2023 00:04:47 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b0040b4ccdcffbsm1127534wmq.2.2023.11.28.00.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:04:47 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        renesas@sang-engineering.com, robh@kernel.org,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] net: ravb: Start TX queues after HW initialization succeeded
Date:   Tue, 28 Nov 2023 10:04:37 +0200
Message-Id: <20231128080439.852467-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231128080439.852467-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231128080439.852467-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

ravb_phy_start() may fail. If that happens, the TX queues will remain
started. Thus, move the netif_tx_start_all_queues() after PHY is
successfully initialized.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

Changes since [1]:
- collected Rb tag

[1] https://lore.kernel.org/all/20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 62a986b5de41..2ef46c71f2bb 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1812,13 +1812,13 @@ static int ravb_open(struct net_device *ndev)
 	if (info->gptp)
 		ravb_ptp_init(ndev, priv->pdev);
 
-	netif_tx_start_all_queues(ndev);
-
 	/* PHY control start */
 	error = ravb_phy_start(ndev);
 	if (error)
 		goto out_ptp_stop;
 
+	netif_tx_start_all_queues(ndev);
+
 	return 0;
 
 out_ptp_stop:
-- 
2.39.2

