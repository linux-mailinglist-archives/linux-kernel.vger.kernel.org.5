Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA32F7F0DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjKTIqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjKTIq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:46:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552E183
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32f737deedfso2655906f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469981; x=1701074781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp/UKHVnA714ikdJHZcbqGoPP5UR9IDH6yqWS6ig3mM=;
        b=pmrFMg4J196kShqfjSh2VBLm0SzHZsKZj+uD7XU4nNdfVg7EJm3DRaouPPq6JE1VV/
         TFBguly6ExckGVq2Z/Ck6g3mXbNXEbSdFFu2+uh1BKNZxYzvB1/WN2yZwwP0SdW9Go+P
         /ehFdaz1+kQRhQmQkQpkg4eBy3/2Y8pRecfE2NMezpOfMS4W1CX+xZwEWfxetxAwjFti
         e4Bz5bwIPGfyCOxJi/9M0rTgU4RjlFdE9Mn/SblEOGyEYinEhWMc9vUhMgePN648KkGn
         i7/AvH0d4dhl4mjV05fl4C4eQr3MEBi0LG/idtAmANe/kJmKb/a0aMYJmCtZv/Th0H+I
         IPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469981; x=1701074781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cp/UKHVnA714ikdJHZcbqGoPP5UR9IDH6yqWS6ig3mM=;
        b=kZCYyRXTzeeOLcKtLIFh851F3WnUXrvYrn3LvAvEipYg4mixd3Jv0l15dW01UJn7kK
         AqBoj9359si+VBdYd881dkTBpnr/ms327tit+Lq7BEAlPzu/tfYfMvFsGV85cGvKdflk
         w9CWFpo+VOt++o3FMEYIDzdze+0+moy9R+f/bWYZgIuULAEgfziHacP9vx1l9eWhbQ/n
         o3H5U1WC900olgqErKqE6/u68bpNFMCZ+jKhITnsIhB2M9d0AlefDaeg3vWPi/EkRxTg
         u9YunMEcUT7pF8bmA51MhkdzJ+tOF8sLd1mmmX8O8EMvOiIDmd7IQXCv0d9dSkPIilnF
         5olg==
X-Gm-Message-State: AOJu0YzXZr0ejCBDf54Y9yabfGDqR+CNAXNPcMlYivKVX6+0vD7hJyLV
        M1Mnr0jPuq8U3/nbjcFZ8nxKug==
X-Google-Smtp-Source: AGHT+IFDUtcL/kItW6Ct8wAYuHmG27hXUs5xVSozigyLzY20qpW+SnjNg8LDtQ8uSwnwos1Zsdc1hA==
X-Received: by 2002:a05:6000:108f:b0:331:6cfd:e2fc with SMTP id y15-20020a056000108f00b003316cfde2fcmr3780250wrw.21.1700469980699;
        Mon, 20 Nov 2023 00:46:20 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:20 -0800 (PST)
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
Subject: [PATCH 02/13] net: ravb: Use pm_runtime_resume_and_get()
Date:   Mon, 20 Nov 2023 10:45:55 +0200
Message-Id: <20231120084606.4083194-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
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

pm_runtime_get_sync() may return with error. In case it returns with error
dev->power.usage_count needs to be decremented. pm_runtime_resume_and_get()
takes care of this. Thus use it.

Along with this pm_runtime_resume_and_get() and reset_control_deassert()
were moved before alloc_etherdev_mqs() to simplify the error path.

Also, in case pm_runtime_resume_and_get() returns error the reset signal
is deasserted and runtime PM is disabled (by jumping to the proper
error handling label).

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 28 +++++++++++++-----------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 342978bdbd7e..0486add302b3 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2635,25 +2635,26 @@ static int ravb_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 				     "failed to get cpg reset\n");
 
+	error = reset_control_deassert(rstc);
+	if (error)
+		return error;
+
+	pm_runtime_enable(&pdev->dev);
+	error = pm_runtime_resume_and_get(&pdev->dev);
+	if (error < 0)
+		goto pm_runtime_disable;
+
 	ndev = alloc_etherdev_mqs(sizeof(struct ravb_private),
 				  NUM_TX_QUEUE, NUM_RX_QUEUE);
-	if (!ndev)
-		return -ENOMEM;
-
+	if (!ndev) {
+		error = -ENOMEM;
+		goto pm_runtime_put;
+	}
 	info = of_device_get_match_data(&pdev->dev);
 
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
 
-	error = reset_control_deassert(rstc);
-	if (error) {
-		free_netdev(ndev);
-		return error;
-	}
-
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
-
 	if (info->multi_irqs) {
 		if (info->err_mgmt_irqs)
 			irq = platform_get_irq_byname(pdev, "dia");
@@ -2878,8 +2879,9 @@ static int ravb_probe(struct platform_device *pdev)
 	clk_disable_unprepare(priv->refclk);
 out_release:
 	free_netdev(ndev);
-
+pm_runtime_put:
 	pm_runtime_put(&pdev->dev);
+pm_runtime_disable:
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(rstc);
 	return error;
-- 
2.39.2

