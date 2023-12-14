Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ACE812F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444265AbjLNLra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444198AbjLNLq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:46:56 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDD0D56
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:43 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bfd3a5b54so9071150e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554401; x=1703159201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cT7sZVhk3SPH3qfWzj9p6vjX2dF9hm4OYxHa78CzWQ=;
        b=CDEYaeaE6qduuOmQss6XjTpBXM3l7gS2mus6VDSWgpvsyp5VVU14HtMHCVJG7z5rUX
         YkkdljRVLrtBpLWUoHHqmN73+boOi/tndrwdDrNwO03k5sScGTIoyMZv1EMB9KzhPAdV
         eXXr99nB4SQRzrDPDnMsfLd9I1uVo01hmH1PSXz6sI5ltOtO3eq6pA/gfxEnt6WqZuYj
         GskgPJd7cirHQ9sde+NaB75o769xgmBDu9vcb2MvmzihbVAzZ3NPbsrwmjHek5dOwurS
         Azdv0m4nc37IAPXIyl2lCCV0+9Fl9g/XAyvZ1Y7JV+lGnX9hALmkfZJVJSqAUdHGps5Q
         2UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554401; x=1703159201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cT7sZVhk3SPH3qfWzj9p6vjX2dF9hm4OYxHa78CzWQ=;
        b=UcaXT7xVLVWy+kV5XEIerXBhhORKTMqMaVWxe0om2XNDmwVUiScZqHgfxrR9dXJolj
         1hZw498EYAI5BGam6OuiF3/akItw34C86bDI0W99z0yuPAeqW23dNRcFAt4FMYsAhwsO
         CJvKp8Lh9M2ecdfkKXTz312Nm5KAQEhpQbOxXgzYLMt2Mdfh7I50QcKWGUUtzkDoua0m
         G+hmwRtYsdPxNGoPC0nLYyBnEuv5VTz9FShhIU8axt/objnA26r4vvLWr8KHKvM4QQOU
         ryesMMI/2HJhmFy+3dEBTmk92qcyyVDw/8TsYa2er1T1b46GSxRu1k8IQebVTvv1YjMn
         KZbA==
X-Gm-Message-State: AOJu0Ywh3OeHc7y2/WqceYUGqxwFPhzpJoBNfTbWmUGjRuvYWGB6JCal
        AUY5W9uNeuJlbY60KaPZIlWJvQ==
X-Google-Smtp-Source: AGHT+IG971WfjyERHQhZ0TdR63Dq7y7Fb1xD2Xpc2eRNcB9COcCGSdCFifT0aHwVpfyDHrdNy75McA==
X-Received: by 2002:a19:ad44:0:b0:50c:2fc:cac with SMTP id s4-20020a19ad44000000b0050c02fc0cacmr4070502lfd.126.1702554401526;
        Thu, 14 Dec 2023 03:46:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:40 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 14/21] net: ravb: Simplify ravb_suspend()
Date:   Thu, 14 Dec 2023 13:45:53 +0200
Message-Id: <20231214114600.2451162-15-claudiu.beznea.uj@bp.renesas.com>
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

As ravb_close() contains now the call to ravb_ptp_stop() for both ccc_gac
and gPTP aware platforms, there is no need to keep the separated call in
ravb_suspend(). Instead, move it to ravb_wol_setup(). In this way the
resulting code is cleaner.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 31a1f8a83652..16450bf241cd 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2968,6 +2968,9 @@ static int ravb_wol_setup(struct net_device *ndev)
 	/* Enable MagicPacket */
 	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
 
+	if (priv->info->ccc_gac)
+		ravb_ptp_stop(ndev);
+
 	return enable_irq_wake(priv->emac_irq);
 }
 
@@ -3000,14 +3003,10 @@ static int ravb_suspend(struct device *dev)
 	netif_device_detach(ndev);
 
 	if (priv->wol_enabled)
-		ret = ravb_wol_setup(ndev);
-	else
-		ret = ravb_close(ndev);
+		return ravb_wol_setup(ndev);
 
-	if (priv->info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
-	if (priv->wol_enabled)
+	ret = ravb_close(ndev);
+	if (ret)
 		return ret;
 
 reset_assert:
-- 
2.39.2

