Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FCE7F9C42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjK0JEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjK0JEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:04:37 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC25E184
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:04:43 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a0029289b1bso539135466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701075882; x=1701680682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1Odgh8NQ+ymmAyVzkExaOV4kNSDq/6wv5PLiqzNFYg=;
        b=MPzl9jCxhIUN6DjkTUK94dkPbCkWZ1DjnfDjx6uOOvWT6PjCae5EzmolsWinzmZaDz
         K2Vixs6mgTPcu+u670olQFdDmbWA0nZf3A+wb15aMQc26Ga6DmyI6Yc1617gtHzxCf0o
         0Is6WO1rNR1GkZUxprIeqIGRu8ftoxs3D64nP4hGBzj+S/IcDIOlZp+UEJSPHCdoFdpm
         mttuZ05PnlSdRjjgPNxCtYtOQc/ivHVlSifejBhvbGzOOMMcz880QivPgMcWeACWCYmI
         IeBip2veRpGlkuGCRxiGYxyAFLZ/CjYkq8CzC13J7MlOe+FyIdyu2owObzrm77AuHCXI
         cItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701075882; x=1701680682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1Odgh8NQ+ymmAyVzkExaOV4kNSDq/6wv5PLiqzNFYg=;
        b=K+F9mq6/5/0zSHcggZ6CnoWiE6atJhA3pZLzZl23jcndn1HqyvrMQYgWSZYfZM1D3O
         mpteteueb++SHwHhbdWLWswi0EUQZadCOSSYCYSLQwHHOp0w6Qk2rfbGjCcrUgF9UU7W
         WMxe6QVmIyFHTEj7h6b/a0hAbO4VyEYzp+LXH5N+gDObrcW/sK6bQIO6a5uaZ+PtyQ1f
         RR/t5KCG20BE31GbSu0u0c1Sx7Qfk4LML++xY5Jz0BVubUgOQnDA6Cj8Q/QGfk6A9SDF
         EaeRGZ3192gdaJMrZXydmkamIfQLvUEqdJgqbDvfi47BreA+qX5ecsSqrExZ3wirJ/yN
         zftQ==
X-Gm-Message-State: AOJu0YyG+l6VRCd9QyN26GwFceF2a+ZqTzEZUHmP2kBrozDVIQD0ByP2
        Q4m6Dti7+2bmTZU8N/tLLQhIAg==
X-Google-Smtp-Source: AGHT+IGyVXfUv1sDMUPq/6NZ7GqiTKqXeM9iCEMC+wqTiTcYkSKLXtlJyA2qzpJxPGOMLqTAsDKrKA==
X-Received: by 2002:a17:906:10d:b0:a00:2686:6b40 with SMTP id 13-20020a170906010d00b00a0026866b40mr6513858eje.14.1701075882183;
        Mon, 27 Nov 2023 01:04:42 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id ay14-20020a170906d28e00b009fad1dfe472sm5456539ejb.153.2023.11.27.01.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:04:41 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        geert+renesas@glider.be, wsa+renesas@sang-engineering.com,
        robh@kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/6] net: ravb: Check return value of reset_control_deassert()
Date:   Mon, 27 Nov 2023 11:04:21 +0200
Message-Id: <20231127090426.3761729-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127090426.3761729-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231127090426.3761729-1-claudiu.beznea.uj@bp.renesas.com>
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

reset_control_deassert() could return an error. Some devices cannot work
if reset signal de-assert operation fails. To avoid this check the return
code of reset_control_deassert() in ravb_probe() and take proper action.

Fixes: 0d13a1a464a0 ("ravb: Add reset support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes since [1]:
- added goto label for free_netdev()

[1] https://lore.kernel.org/all/20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c70cff80cc99..50c4c79be035 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2645,7 +2645,10 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
 
-	reset_control_deassert(rstc);
+	error = reset_control_deassert(rstc);
+	if (error)
+		goto out_free_netdev;
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -2872,11 +2875,11 @@ static int ravb_probe(struct platform_device *pdev)
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
-	free_netdev(ndev);
-
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(rstc);
+out_free_netdev:
+	free_netdev(ndev);
 	return error;
 }
 
-- 
2.39.2

