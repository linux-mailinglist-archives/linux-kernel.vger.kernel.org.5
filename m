Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551277F0DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjKTIq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjKTIqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:46:24 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6CBE5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:20 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso7951555e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469978; x=1701074778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/Q1YDzSiSuqzbLh5eHVltDp4epdTy0gP5JRv4NY97M=;
        b=WXJyXxq69lQKY0+sRMGanqJ6zHo+duWpMv5PPux7HPsPyOTuf6eKj+P8QwF67lBNa/
         dn06P7rsXm6xvqBmJIyBF2cDU/K+3aQumTm9Jlbnjw1dl9fXAGVgpSAwqbfRRBoi5+3H
         y85zUXqX0ox9OtA74y7CmAOw/5SJEjdinYMRj7UsOZBlJIeqHZRqXS2fU5exQiBPfftz
         dSGZaZAJfZ3X8+yHu3Ule7Wbxpl4sVJWlON1/fzsA0R/v/Nct6KXRsFk/fUVgf9cfJE5
         U2vi7G8gPNnT9WOU+7eVEkJp2NCiaKEEvLI1R7xadTyr4NK6ViWoim2xIOPb0J6ORFDa
         0lHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469978; x=1701074778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/Q1YDzSiSuqzbLh5eHVltDp4epdTy0gP5JRv4NY97M=;
        b=cLOyfoZMGxH0gJAmpF6UDIMaSHMPL2OdZdaZfP1XL3H9qtR/fkkJ5CgIgLNU0nxCO5
         +9Bs85k5mnNa1JlMu9YNiBqjnGvlzb8EV865fvE3/wMMQ7T988Qqlz+th6OI+G7bjTDU
         XIBxnA//ZGw0yJhVY7EVPztHDTm1YUwC8fz6nZ8Nj9QEON9mMy7nimTQach6hVyaI5RO
         sPn6xmUccGfyJIGHDyz6J7EtH0hAgQ4Vgcr9RiylakjU14eBb4yCxPNv+7LU+p7oMv8a
         aSj6qHN0bi2cb9g5orIERuQdDUklbl48XHJOpObkImwH2ORRvAiVflYkT+MkEGLR1sG6
         7w0g==
X-Gm-Message-State: AOJu0YxpxnzzuOLwbkAn82ArPXQxbZJk1Tsxu2MEDCtHJRwaQhcfdT9C
        OlB6U7A7kjuDZouuaN18/A4Xxw==
X-Google-Smtp-Source: AGHT+IGguzzps8WTXHQDOz4RLWoYc1q9Kn2P1FSlhPOyUbpQ66wry2laGEFnLXjuLpuT8sqFntGuUw==
X-Received: by 2002:adf:e7c9:0:b0:32d:d2aa:ed21 with SMTP id e9-20020adfe7c9000000b0032dd2aaed21mr8616747wrn.28.1700469978402;
        Mon, 20 Nov 2023 00:46:18 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:18 -0800 (PST)
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
Subject: [PATCH 01/13] net: ravb: Check return value of reset_control_deassert()
Date:   Mon, 20 Nov 2023 10:45:54 +0200
Message-Id: <20231120084606.4083194-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
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

Fixes: 0d13a1a464a0 ("ravb: Add reset support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c70cff80cc99..342978bdbd7e 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2645,7 +2645,12 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
 
-	reset_control_deassert(rstc);
+	error = reset_control_deassert(rstc);
+	if (error) {
+		free_netdev(ndev);
+		return error;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-- 
2.39.2

