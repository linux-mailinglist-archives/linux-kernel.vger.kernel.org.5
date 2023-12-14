Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783DC812F34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444311AbjLNLrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444234AbjLNLqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:46:45 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F9A121
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:37 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso967649866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554396; x=1703159196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR5Cjb3g5JwSTu3j/K8ArNRp5NJou/sw/M1aYXvPkhE=;
        b=gryyX4Y6UY59iIdoIvoVNQbrEJ94YU9HfU3wjgLIP/OpjCse6cSY9v0Q1yvikxxU58
         AtAFQJ78WRBndmjC0tLCBLt71fUZTVcODl9BRyM2CSNgYw6NkT1x7WhTssQMH9S0pvXw
         xXG4Z56d79I9g5kGyBJXgwN5T3LxmQUi2ROk8n4y3JgH0Xbl4kGIAdqMnP8QEhOSwbal
         xmiN77e4n1g19FI3SRkPV0ZNB9pAY6IlhTj2vxoOTb4RKeLOY1qccznWHhQ1IZ+h1dwZ
         7GldsMsUw9wHI1lgQ9mpbgCO8LA1HiBnRr+8yclOH2tqNbUcq+haASEVPTu0OHeAZWZy
         f87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554396; x=1703159196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR5Cjb3g5JwSTu3j/K8ArNRp5NJou/sw/M1aYXvPkhE=;
        b=lX9TFSorpA71C84pqRpKoqxASSHk9DblEL1sq/jrMfRyzgqUdp045soKksGSU5QDho
         F2dSjBJxj8SOm6Vyr528JJY3TOROktqcvuWlUe0VUxmf2+NdqQHWak08QNhj8ekTA3l5
         lvzU4feJ6nEESEBbN2lnEov9Ndut/iaJX5MWuwcRGBRm3WPvciRhO3xMYDCXZlI+jDNJ
         FkF0q/kUpOxW0wWeMxwFwF5Vs1JEUFLseWRva4jOEsPTlqSc9stFP6kuWknEz63YoYgU
         RN1UfHs+O3e7RqU389bZNvuLtnw3gLmufCUDi1vlZa+YlaEqzPMoaOoXbWxW2qt0Ljus
         y+Rg==
X-Gm-Message-State: AOJu0Yw7OmZ7e+b3nw7nEyYvuPMXQ5QXLD5iuhNak4ZnwfGgjafAZRZX
        MpYrUl1EIqgrBUrwc8nPtNXk0g==
X-Google-Smtp-Source: AGHT+IGTEA8XdvK5DIgTXUJDZNcrpoxh+EdMHgeULkwRzquHNIZ6hTg2ARSBoQED7sSDbafP7bbF/g==
X-Received: by 2002:a17:906:53:b0:a22:fc0f:9878 with SMTP id 19-20020a170906005300b00a22fc0f9878mr1424003ejg.16.1702554396449;
        Thu, 14 Dec 2023 03:46:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:36 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 11/21] net: ravb: Move DBAT configuration to the driver's ndo_open API
Date:   Thu, 14 Dec 2023 13:45:50 +0200
Message-Id: <20231214114600.2451162-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
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

DBAT setup was done in the driver's probe API. As some IP variants switch
to reset mode (and thus registers' content is lost) when setting clocks
(due to module standby functionality) to be able to implement runtime PM
move the DBAT configuration in the driver's ndo_open API.

This commit prepares the code for the addition of runtime PM.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 04eaa1967651..6b8ca08be35e 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1822,6 +1822,7 @@ static int ravb_open(struct net_device *ndev)
 		napi_enable(&priv->napi[RAVB_NC]);
 
 	ravb_set_delay_mode(ndev);
+	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Device init */
 	error = ravb_dmac_init(ndev);
@@ -2841,7 +2842,6 @@ static int ravb_probe(struct platform_device *pdev)
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
-	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Initialise HW timestamp list */
 	INIT_LIST_HEAD(&priv->ts_skb_list);
-- 
2.39.2

