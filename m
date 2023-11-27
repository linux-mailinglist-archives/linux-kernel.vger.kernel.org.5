Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D8C7F9C45
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjK0JEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjK0JEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:04:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3033D188
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:04:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso9457756a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701075883; x=1701680683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY105oJjqBLJjrNiZ881NJwgu30bKrulY2ZruFXx9EI=;
        b=Cy84VwcD08LovmdeluY81pY4hAxrPC/7PtZXICdWX86mK7rGn5tzGvr/0Dixx9M34c
         PrRrOJPAVkN53uadZIHupv8vw8QrB2kHVuEzz4+QiAqiBGrTLo1Eb/XsNircAQ5wcuTK
         VIaJhxKj5MlCGXgy/5d9FF4SIvYNmyd3Qo7ihEGVwgZCNkhMPEAXtSHgJsfEAyiSeGBB
         9kAvls/FfeXBq00H6X2HYiBiDZYCvjNk3oyG8ytiw0pudB9Ajc0ifHIUIOBBnz6+ofdh
         /3KkXn8vCe8fKYN8w1iFlmaWVSYMof2tr+Ht1Jm9Fs0aflYkcDfB2iO1y5ssYiMI0BGV
         w6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701075883; x=1701680683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SY105oJjqBLJjrNiZ881NJwgu30bKrulY2ZruFXx9EI=;
        b=DFP8fwlhAcjsOeLoT7pnLb39O/RVoWcBGvsjv+ZgH7h9KfyLKVvzY+6SE0sHam/XZc
         bIVNZZRawClWwFW2GWNy+/4avpkxmYFlv8ycrRWGjsKTGGGAgs5YDfqB8gZKYAxt64fW
         YfnRCpYONMk2aN2CT2NP+DqWk0uEUeNt+0KpsjXO5wQoeVt6ve9jEbtiDSMW01ZKzJQp
         U3dLPbJj9qT8W03SxfOU3z9PPkK7rQsq6Q8j+TKiRKwCstHb7sGEOvU1waLg75q8VoWc
         0cEbUX3fvvJ/Bv/xlCJfnAxhSAswZSPAyORUl41opUY3UvSHADcjsqUpNCnNhRfxhgNQ
         hDCA==
X-Gm-Message-State: AOJu0YxYrOUBWOnO0UhaUC1iyBYJhDi8RqOanEt9WWBBHOmyynJ4XteG
        7wERxZ2qVoMF71B+G7LousvnCw==
X-Google-Smtp-Source: AGHT+IE8VvNviNCZfHfu2FY1K+dZrQy6vqtZ9sx52MzgYilOK6puI7wCb7uyJ3cx0P9Jel53TArD0A==
X-Received: by 2002:a17:906:c44:b0:9ff:889c:c2ff with SMTP id t4-20020a1709060c4400b009ff889cc2ffmr12596865ejf.22.1701075883737;
        Mon, 27 Nov 2023 01:04:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id ay14-20020a170906d28e00b009fad1dfe472sm5456539ejb.153.2023.11.27.01.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:04:43 -0800 (PST)
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
Subject: [PATCH 2/6] net: ravb: Use pm_runtime_resume_and_get()
Date:   Mon, 27 Nov 2023 11:04:22 +0200
Message-Id: <20231127090426.3761729-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127090426.3761729-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231127090426.3761729-1-claudiu.beznea.uj@bp.renesas.com>
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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes since [1]:
- added goto label for pm_runtime_disable(); with this innecessary
  changes were removed

[1] https://lore.kernel.org/all/20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 50c4c79be035..cd3474168452 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2650,7 +2650,9 @@ static int ravb_probe(struct platform_device *pdev)
 		goto out_free_netdev;
 
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
+	error = pm_runtime_resume_and_get(&pdev->dev);
+	if (error < 0)
+		goto out_runtime_disable;
 
 	if (info->multi_irqs) {
 		if (info->err_mgmt_irqs)
@@ -2876,6 +2878,7 @@ static int ravb_probe(struct platform_device *pdev)
 	clk_disable_unprepare(priv->refclk);
 out_release:
 	pm_runtime_put(&pdev->dev);
+out_runtime_disable:
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(rstc);
 out_free_netdev:
-- 
2.39.2

