Return-Path: <linux-kernel+bounces-35302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A34C8838F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85F41C266D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A554460DC1;
	Tue, 23 Jan 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bI79pg8e"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF46087A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014790; cv=none; b=CZA6BcKRYF5GbYbMxZBpMDKfajH3vb3baWRUWILIbLHsVwNKJRum/yI2Fy3j61O03GL6AJRDtGqeIsu3rPKewXxMIryB//9Ym6Ammd5quROIMUM+sNHgH1/KpwSyeHbERs5IMT+U5jp3UUxrRxE/lEQ0gYv+7wSKmPOjd2VZjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014790; c=relaxed/simple;
	bh=BZKCFAHEpPGNiDq2mJMweBfLlos6yJpODGMDA4g09HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qnjPIAabWjgXWY+SLzdwGk+Waf6vIOyBg9HcSHP0JHnZKGspiEwYpRluWBjA1Yw4VW7mUk0b6vZX6w8Ak3m9TMnGDxOwtiqBskVz8Q8POrhPr/N7UFJ9JLcX0YvF7u/KwvtTmPorRV+JEbGHGf20/Fz3D62rO3C7fu+7CvTU1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bI79pg8e; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so47335565e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706014787; x=1706619587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5Hi7im7B+tHnOXIWlrZSV9yMjAsBTdfdkOa8Wn2LcY=;
        b=bI79pg8eyv+eyP+pQKoea6dazbjG3RrFYVkm8L5du8GJuq/tB8STdfBY72mrUdlSTn
         qwNMDiJwkusUT1kQlLYQ7EEvPBg5ebfbZFSDJ5Z22b9kcinEu+NX2xAd9/pGqIBShXJY
         vsKwu3bGkFTNXwrEldgIhGJ6HNOSfN1uJhCuth8ua0VGvvxao/IRxyRhUN+9ShuDEV28
         w2c/tC96ESTRoXVNs1u5cKllv7LcXjQnvpcosh2V9ZdjF73GVQkFxRJIekDtUtQ2z0cN
         zpivLe/2eAhMmfTbIIR7E/53SUzghF4BinVso69/auqyda3pvnN86HBcbibxCiU8a7fN
         SHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014787; x=1706619587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5Hi7im7B+tHnOXIWlrZSV9yMjAsBTdfdkOa8Wn2LcY=;
        b=uc5Z7qswxo/rdh8hqe1alFNN5MWqc2ICr7uik5PzVqFtHf2oiuPYYMNrPuW11V0Jfh
         DMMRP3sJUiBDEzNm0ex8QXzzJOXv/DxWhBgMDae/IYoLSUmOyhhvdAdLBqgm409f9PsI
         rn06B99HxsyFSBpQmbS2+hPddzkM8elgsW3LUUCSLdyTL8z3eU2eqJwgjcZngfNZsFIB
         I8KO0SZ29SHM2F4XDHCBWNq7p41TEQ4JPZPHDNbT+Bl9cAghPg/jwSfxIb0SAhXnORVt
         pJ5m6sha5J7aVbwSA5igDIduyV4HfHHv9FaMwKVrDJs+iSaxRgL0Z3TIIHYp1+KB0cDk
         d+3g==
X-Gm-Message-State: AOJu0Yzr9KGLThEqAtN7Ds3aYTetHIO6mHJbNhB526ulxXFVgQMiQiHb
	aEM7MCKFTJ1vqhwqOrSX6NhKVCgHSEZW9/9RcTWc+9KZaNczeaYGyUfvDgNNuqc=
X-Google-Smtp-Source: AGHT+IHmWS6UxUNLTfoLE6zCo0djlqDK3KquzridKp2HqToHKG5/sYi4MeJAYZE2Q6jqfnhWPf9EWw==
X-Received: by 2002:a05:600c:4f55:b0:40e:b447:ae7d with SMTP id m21-20020a05600c4f5500b0040eb447ae7dmr502878wmq.33.1706014787628;
        Tue, 23 Jan 2024 04:59:47 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id s4-20020a05600c45c400b0040e6ff60057sm33655711wmo.48.2024.01.23.04.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:59:46 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v4 12/15] net: ravb: Move PTP initialization in the driver's ndo_open API for ccc_gac platorms
Date: Tue, 23 Jan 2024 14:58:26 +0200
Message-Id: <20240123125829.3970325-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123125829.3970325-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240123125829.3970325-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The initialization sequence for PTP is the same for platforms with ccc_gac
and gptp (according to "Figure 50.71 Flow of gPTP Initialization (Normal,
Common to All Modes)" of the R-Car Series, 3rd generation hardware
manual and "Figure 37A.53 Flow of gPTP Initialization (Normal, Common to
All Modes)" of the RZ/G Series hardware manual).

As some IP variants switch to reset mode (and thus the registers content is
lost) when setting clocks (due to module standby functionality) to be able
to implement runtime PM, move the PTP initialization to the driver's
ndo_open API.

This commit prepares the code for the addition of runtime PM.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- fixed typos in patch description
- collected tags

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 3c7748b5e14e..91cabe098cc2 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1876,7 +1876,7 @@ static int ravb_open(struct net_device *ndev)
 	ravb_set_gti(ndev);
 
 	/* Initialise PTP Clock driver */
-	if (info->gptp)
+	if (info->gptp || info->ccc_gac)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	/* PHY control start */
@@ -1890,7 +1890,7 @@ static int ravb_open(struct net_device *ndev)
 
 out_ptp_stop:
 	/* Stop PTP Clock driver */
-	if (info->gptp)
+	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
 	ravb_stop_dma(ndev);
 out_napi_off:
@@ -2200,7 +2200,7 @@ static int ravb_close(struct net_device *ndev)
 	ravb_write(ndev, 0, TIC);
 
 	/* Stop PTP Clock driver */
-	if (info->gptp)
+	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
 
 	/* Set the config mode to stop the AVB-DMAC's processes */
@@ -2813,10 +2813,6 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Initialise HW timestamp list */
 	INIT_LIST_HEAD(&priv->ts_skb_list);
 
-	/* Initialise PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_init(ndev, pdev);
-
 	/* Debug message level */
 	priv->msg_enable = RAVB_DEF_MSG_ENABLE;
 
@@ -2861,10 +2857,6 @@ static int ravb_probe(struct platform_device *pdev)
 out_dma_free:
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
-
-	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
 out_rpm_put:
 	pm_runtime_put(&pdev->dev);
 out_rpm_disable:
@@ -2890,10 +2882,6 @@ static void ravb_remove(struct platform_device *pdev)
 
 	ravb_mdio_release(priv);
 
-	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-- 
2.39.2


