Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930257FB38F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjK1IEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343955AbjK1IEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:04:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1DEDB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:04:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b4746ae51so12485395e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701158683; x=1701763483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TER/zjgFsQ4zH/M/nBtL41p2wpZGtg22rimu0p57AMs=;
        b=NSH+yIqa5s/ZejJN07Qauf8d3WJ0IEOgE4+CpI5Ssa7gTjJgaJ8SKPO995OfuT9yiT
         ayBU6HqLc35b+YC1Pe9OicLyCOXwsySYl+EVIcsaYZ6H8AHJROjjcYxgh3eIBuAxQR5i
         WI+9CDTAi8vOPIX9u3K5rbkKyovh0twyjTiQdGLGRyP+trLsVOMDekoT7VazH0cra6Nk
         UgFzWAdzI7bN9m7wUyFNUQSbKFLze6KCd8/jzdTqd21+1eAzztQYyWaIQ0q+qqYKgLI6
         UtjVproy8mrqO703i2QqpZmnOhBCmXFbFgMdf06JTPZSmO7asZqVGnAiunDC3+D7OvQD
         KHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158683; x=1701763483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TER/zjgFsQ4zH/M/nBtL41p2wpZGtg22rimu0p57AMs=;
        b=p2IQS3ooY/IT9ULJS0gOu3tRVP824iLT9kD+luQRkrRcRR9HzSPAWiMbg1/ljaKUNn
         pc3miWTxcOZR8QY4i6JHwxSfc6C4kJeEJpn8qfz0Ikfy0so7gH7oRkbFlOGSGtx8m8pt
         cnvvz6i+ulqQGycWx+SUc6e+wUcJYbOEw9pufIxF6IsIP9AZRcNkq3BhH4uEGBO+4li8
         VHBpAK2y6U2sEmCzeQAoRVTPvVtUuOTAAVyJHItidfWPOiGHW4B7Ab/IWlI72Kk4A6KJ
         YiX4xvLWlfeW7LoGsWZOECZ4++v+pa7EpRzbd4ElvPbF7ARWts4fIoOAHpYc0bmTAXIW
         MK8w==
X-Gm-Message-State: AOJu0YxQP8GOoNqktwXnuaY67fTo9vJtnPUYB4kxlv+4MzKQy9LQZ1yG
        kEdfGeOXPyjCzqR5Hpas95DaxA==
X-Google-Smtp-Source: AGHT+IF9kC7vFv0UFd4k0YZm4RaGwXdesZdpw8BOTVxF/2FVztXa95IPMgGc0hCY8Loptjy7Z4wZhQ==
X-Received: by 2002:a05:600c:4f8a:b0:40b:4520:45a6 with SMTP id n10-20020a05600c4f8a00b0040b452045a6mr4460089wmq.8.1701158683147;
        Tue, 28 Nov 2023 00:04:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b0040b4ccdcffbsm1127534wmq.2.2023.11.28.00.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:04:42 -0800 (PST)
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
Subject: [PATCH v2 1/6] net: ravb: Check return value of reset_control_deassert()
Date:   Tue, 28 Nov 2023 10:04:34 +0200
Message-Id: <20231128080439.852467-2-claudiu.beznea.uj@bp.renesas.com>
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

reset_control_deassert() could return an error. Some devices cannot work
if reset signal de-assert operation fails. To avoid this check the return
code of reset_control_deassert() in ravb_probe() and take proper action.

Along with it, the free_netdev() call from the error path was moved after
reset_control_assert() on its own label (out_free_netdev) to free
netdev in case reset_control_deassert() fails.

Fixes: 0d13a1a464a0 ("ravb: Add reset support")
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- documented the addition of out_free_netdev goto label
- collected Rb tags

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

