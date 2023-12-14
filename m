Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED00812F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444167AbjLNLre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444270AbjLNLq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:46:56 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E650D5D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:44 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54bf9a54fe3so11086101a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554403; x=1703159203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33vAc5ck7zdvdX0qktOXfLvJPjpSeplyQvjMFmFH8tY=;
        b=LoFzQstsVKFmbpptn1HQVy1NiqC8PnygBJJAhNpM54Cr8k0uT/Vih+aw8BmqUvYG1s
         EmtYhdKoEu5Bx7nQjjjFz57MaOu3btxYEAL27cxVYnQs9nlShDo1qCPTa1rs9ItTDPd8
         YhKcm9Y+N+6qhI/v6YrD5lcXVw6R0SQkt/0F3g0B2cHPmoSqa2mfIunH8xMLg4oScPg5
         MhhTqOlDK1ZuzZaBz73QeBDTkHJ1BE/O/o651PQj3iZBnLpCKAXAuSjMTWHFWTnBC9jd
         5SS/rqPuhQOjRyd5tPH7a8r8/1WsVVzxJtOocpoHunTqKJYMWoThAAniuWb2dVtrEAPt
         Ne7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554403; x=1703159203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33vAc5ck7zdvdX0qktOXfLvJPjpSeplyQvjMFmFH8tY=;
        b=kKvep7p5g9kQEERFbPEKyNtw4UcW/qnZYlVB6gZeUyWXCpF4BH/Ci0x1V8KyMrK+Dd
         6/HPl6S2JCj4RqHaIGObgoLlZOaN9MNYUcWgVLDAhyr2bArXXZHDCZNeUumzM3UF82D8
         8HlVPw5kC8wFD7UMdPmrLePo+Ou04nxveVkZjPzVHzt0XCwnGlxMUVW4uQ55zX0abn+/
         4V9wqEGk58mga8eZFK9ewO7Cwhp4bxMHem5P6xwmdDxzAfF/b5U6Alpm4HKvXfxWOFmo
         xIFhma2wsiGNa8jHEL8TuUyjE/vNvxpj2cJSFT24TzabwNsUASYl3NLBhmZBI1rUkIoO
         g8Kg==
X-Gm-Message-State: AOJu0Yy6jIWoPkimvt/lkCHX8w5q1+KAlHRLnK9DEN9LrEFR8ubX6q5r
        mp49t1dlgp0K0bAiwonI5lupaA==
X-Google-Smtp-Source: AGHT+IFyLlweizU3HmYYgch4IUmSBXQSbhxj3U8dxHcyuNzp7kt/p9z7G0OxdVq+g4jtagb4Wh3qWg==
X-Received: by 2002:a17:907:c715:b0:a1d:551f:a197 with SMTP id ty21-20020a170907c71500b00a1d551fa197mr5941372ejc.82.1702554403005;
        Thu, 14 Dec 2023 03:46:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:42 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 15/21] net: ravb: Simplify ravb_resume()
Date:   Thu, 14 Dec 2023 13:45:54 +0200
Message-Id: <20231214114600.2451162-16-claudiu.beznea.uj@bp.renesas.com>
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

Remove explicit calls to functions that are called ravb_open(). There is
no need to have them doubled now that the ravb_open() already contains
what is needed for the interface configuration. Along with it, PTP needed
configurations were moved to ravb_wol_restore(). With this, code in
ravb_resume() is simpler.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 60 ++++++++++--------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 16450bf241cd..b581666e341f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2978,6 +2978,20 @@ static int ravb_wol_restore(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int error;
+
+	/* Set reset mode to rearm the WoL logic. */
+	error = ravb_set_reset_mode(ndev);
+	if (error)
+		return error;
+
+	/* Set AVB config mode. */
+	error = ravb_set_config_mode(ndev);
+	if (error)
+		return error;
+
+	if (priv->info->ccc_gac)
+		ravb_ptp_init(ndev, priv->pdev);
 
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
@@ -3017,55 +3031,29 @@ static int ravb_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
 	int ret;
 
 	ret = reset_control_deassert(priv->rstc);
 	if (ret)
 		return ret;
 
-	/* If WoL is enabled set reset mode to rearm the WoL logic */
+	if (!netif_running(ndev))
+		return 0;
+
+	/* If WoL is enabled restore the interface. */
 	if (priv->wol_enabled) {
-		ret = ravb_set_reset_mode(ndev);
+		ret = ravb_wol_restore(ndev);
 		if (ret)
 			return ret;
 	}
 
-	/* All register have been reset to default values.
-	 * Restore all registers which where setup at probe time and
-	 * reopen device if it was running before system suspended.
-	 */
-
-	/* Set AVB config mode */
-	ret = ravb_set_config_mode(ndev);
-	if (ret)
+	/* Reopening the interface will restore the device to the working state. */
+	ret = ravb_open(ndev);
+	if (ret < 0)
 		return ret;
 
-	ret = ravb_set_gti(ndev);
-	if (ret)
-		return ret;
-
-	if (info->internal_delay)
-		ravb_set_delay_mode(ndev);
-
-	/* Restore descriptor base address table */
-	ravb_write(ndev, priv->desc_bat_dma, DBAT);
-
-	if (priv->info->ccc_gac)
-		ravb_ptp_init(ndev, priv->pdev);
-
-	if (netif_running(ndev)) {
-		if (priv->wol_enabled) {
-			ret = ravb_wol_restore(ndev);
-			if (ret)
-				return ret;
-		}
-		ret = ravb_open(ndev);
-		if (ret < 0)
-			return ret;
-		ravb_set_rx_mode(ndev);
-		netif_device_attach(ndev);
-	}
+	ravb_set_rx_mode(ndev);
+	netif_device_attach(ndev);
 
 	return ret;
 }
-- 
2.39.2

