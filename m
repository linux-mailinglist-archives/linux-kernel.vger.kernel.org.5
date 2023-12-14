Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D11812F48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444054AbjLNLru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444299AbjLNLrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:47:12 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA210DF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:49 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bdec453c8so9441273e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554408; x=1703159208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hga+Euca2ffWU8RByuMIoZjdDg4sBJqJ6E8Xj3GqHcU=;
        b=l7aXLowxuHeivrKOLCrOxfXiS1Nkru3oah4VqGlbWzr/wvwFOVe4IafZKyJEBZsLE7
         Q3Kri5ufiU8CX9ITsqdLvbIe3CNkWNKPN7oywmcvoD6u8ulM/EAcowXe7m/MQ1wWkqPT
         DUGDkvyLM2kFAC3xfLE9aSmrOvXmDV+doBJbK9ywwWDTBjp7JAaiUXwpaZWaLgRFbTIt
         i9oSBRGOalagrvRzGbHKOWP3IHnlz/VStR+oT0HpnFUIfc8dv74IbvmTZPgTjzEX1rO2
         A3H5qLN0KnqwO4A1VU4k8Ur8vxNq9ITQv45AIgcPYmfxRMq5g37AzsTfAVm1/ly/9EYJ
         3+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554408; x=1703159208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hga+Euca2ffWU8RByuMIoZjdDg4sBJqJ6E8Xj3GqHcU=;
        b=sSjJotwHTx+hCL6eCwD2Vw6fwczRETTConqNinBEb+B2tT/NcJ0U9bOBJFpcHLhlih
         Y9ri06IasWXmieNwct+gmWaIz9oAYOWn90LWU14oMZLUtlwXYl1iBMaHEBloQvR6pmMq
         9LXySciDAafmbqAKsn/x4MpNFmjnGnojEeTcpv0YENV+VKKu2njVC+6OUVf6TkopMnyM
         dOmlzuTzv5BZrx6s5eVEHojeGkpFkDsv4VvdA+K1xP+2IzMc2U0G0pZjVn0H84E5tWSQ
         afrAzijxQgNZcqCNa2nNZvJWbtBUdl9zh0Wkndj6KeJ+DgueBl2hASj3Ubb8OTCoY1Ze
         8F5g==
X-Gm-Message-State: AOJu0Yyjf94ofNH/f9XsY77tS33QJBJwbq8n5Fw8PfoMpTntgiqWvnNu
        zqp2uUeJMl6h/GFfty/CLp2WPw==
X-Google-Smtp-Source: AGHT+IFnDBljg1qdRWJ1vg6w1v/K2QMbcocaqB1sTTdcbBfsJx37oqwxmTaj3RmyvXHm2M4a86VXcw==
X-Received: by 2002:ac2:554b:0:b0:50b:f09b:e5a6 with SMTP id l11-20020ac2554b000000b0050bf09be5a6mr4073265lfk.112.1702554408129;
        Thu, 14 Dec 2023 03:46:48 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:47 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 18/21] net: ravb: Return cached statistics if the interface is down
Date:   Thu, 14 Dec 2023 13:45:57 +0200
Message-Id: <20231214114600.2451162-19-claudiu.beznea.uj@bp.renesas.com>
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

Return the cached statistics in case the interface is down. There should be
no drawback to this, as most of the statistics are updated on the data path
and if runtime PM is enabled and the interface is down, the registers that
are explicitly read on ravb_get_stats() are zero anyway on most of the IP
variants.

The commit prepares the code for the addition of runtime PM support.

Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a2a64c22ec41..1995cf7ff084 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2110,6 +2110,9 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 	const struct ravb_hw_info *info = priv->info;
 	struct net_device_stats *nstats, *stats0, *stats1;
 
+	if (!netif_running(ndev))
+		return &ndev->stats;
+
 	nstats = &ndev->stats;
 	stats0 = &priv->stats[RAVB_BE];
 
-- 
2.39.2

