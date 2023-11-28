Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9AA7FB38E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343955AbjK1IEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343962AbjK1IEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:04:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585FAB6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:04:46 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b479b9c35so11959455e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701158685; x=1701763485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tex/f+v5XiThmeQ/1yf1Rnsid+DeltBdSjavRwGvUE0=;
        b=BhSlTlwsDX7EXSCG+VX6B79BvgoXHd3U8a/cpeGFbEjaV2osMCqUhL1pl4XF9LE0bQ
         iPwiKRrjO2grjbrzsg8VG4nqHOJRJGP8BDCO0SuLC0xuWcG/MGsCJrry6FTYGfFBFkQe
         rhCsCs8vcXl7YB+XR+OVZp8Nkz4hPDab+7zPn6DtAlpGmXmseDlEjry+8DyTE3Q0SRDF
         S01ZUwc8WvTwJsfEi6HLvdLa7IxdUoKiMm+gnW1DcEkdwk94w/vERWZyR/S8VCyshEvl
         UuKsydZip5vsibo/rNvTIu6QW2BxwpZd5MSQ4vy2tMxbcx4TDYCDdrLVv/+t7poAAXr/
         bhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158685; x=1701763485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tex/f+v5XiThmeQ/1yf1Rnsid+DeltBdSjavRwGvUE0=;
        b=nmy+s/LV6D//B7W+CQ5tQvXOHy3FD0aztCBQvBDmala4WI25bjub0WuNGL0CxbawMk
         0j6sdA59ZH5z7Rt4hF4JOCQ7sRSgQX1ANeoQ+lzLJsYs5BYfSxqMiuANWJGBpHjY4JEB
         Mzzq+rZe1H8q5ltmR/Olmph4eYB2R0nu3t3OC7riXJGBek7tPaTxvTntfmjfBZ2qZSwx
         L7NUdsYCFFNSWBzAEOMQ7dJz2n0UADl40hLoumzcNxLDApWR78HAMW2hQ9goJSLch5wu
         988ChgauJYUa5nbL4JnW05iNOoJVqDujXBZPPOT33mP6Hd4e2XHLwlMFuU1aLd6TD/SI
         iRAw==
X-Gm-Message-State: AOJu0Yzfg+bI2B45y76eWOb9vC3xYTFK0OiTK/02cfOQ1nvPWOyjEDG4
        CZWb+8h0jPevsEQbbXWplLVmAw==
X-Google-Smtp-Source: AGHT+IFiDsJyWYZmV3dZR43yD6C7sj8hAw5H2KlFm+QwzJszuvuTxrXcIrJdx2qTTyted2pjAXexOQ==
X-Received: by 2002:a05:600c:1381:b0:405:3455:e1a3 with SMTP id u1-20020a05600c138100b004053455e1a3mr9383229wmf.17.1701158684750;
        Tue, 28 Nov 2023 00:04:44 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b0040b4ccdcffbsm1127534wmq.2.2023.11.28.00.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:04:44 -0800 (PST)
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
Subject: [PATCH v2 2/6] net: ravb: Use pm_runtime_resume_and_get()
Date:   Tue, 28 Nov 2023 10:04:35 +0200
Message-Id: <20231128080439.852467-3-claudiu.beznea.uj@bp.renesas.com>
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

pm_runtime_get_sync() may return an error. In case it returns with an error
dev->power.usage_count needs to be decremented. pm_runtime_resume_and_get()
takes care of this. Thus use it.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- s/out_runtime_disable/out_rpm_disable
- collected Rb tag

Changes since [1]:
- added goto label for pm_runtime_disable(); with this innecessary
  changes were removed

[1] https://lore.kernel.org/all/20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 50c4c79be035..0af2ace286be 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2650,7 +2650,9 @@ static int ravb_probe(struct platform_device *pdev)
 		goto out_free_netdev;
 
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
+	error = pm_runtime_resume_and_get(&pdev->dev);
+	if (error < 0)
+		goto out_rpm_disable;
 
 	if (info->multi_irqs) {
 		if (info->err_mgmt_irqs)
@@ -2876,6 +2878,7 @@ static int ravb_probe(struct platform_device *pdev)
 	clk_disable_unprepare(priv->refclk);
 out_release:
 	pm_runtime_put(&pdev->dev);
+out_rpm_disable:
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(rstc);
 out_free_netdev:
-- 
2.39.2

