Return-Path: <linux-kernel+bounces-49494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10A2846B15
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81D0295944
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D64277F29;
	Fri,  2 Feb 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="inpPjhzX"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAB077F06
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863341; cv=none; b=YjwrHIiJJuuvGFBmq/d0lPApRw61cVD/b9ZMmeUN4qdvy2kyV2lcqNxdZAwgmVMnVNBf4CDa5xyBkwXMa0udg1Pd9n+hACw8Gib3+RoEYwLn0EOwHJiBdizlPfnNhy48t/EcIpImxpE//Km8j2GtIwYFaRmJyo1okjmeM5edtBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863341; c=relaxed/simple;
	bh=3HIkBLfmG0k2J7i2Q48TrkFvh+JqTUAQoMPHL5/cn7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRI3RL5kYhpI24GrrBHxLgOJeTpQzjrhsAHUS+BvPr5aa7lLlC1Kk1LSkpcBGjvrelUVXhzoRU/CWqdygXX9OEfJffp3uOOQoXwHE2YWjgJLpvUhumsZBtDjUtwzCL2afaH+d/xk9C+xv5QsxGk91c/kjjABNzdZfxxWQuC4dFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=inpPjhzX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so226300966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706863337; x=1707468137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPdGoRi9Q/Z94tgZI+Yh2dsfYo8XG51UXhclzkjwaXI=;
        b=inpPjhzXyY+TgXD+R1nJ66G2gvqrc25riMI0NF2TvG1v97WBF2+Jni7kAL8ZaJupTb
         wq9rjnh6a5S76CaPxlO6xL5RQm1Gp/rzzUdhqohgqpvQo2fyJ7LUzIdOsZXqQXKZzGiN
         X3nFoxBfTNQZ8JGf2cdcf5oQ3Slfww7aRJ9QnJ9LabzoNAC4qISk0kDlUbgPScWbZi2t
         KGsnGLF+1YFadfn20KPV1pxuv/N/EX9LkprRWsgCeGIZUczwkYVvNr+xJj3RBuqdbuT2
         srG3rrrilwj5/Ca6/8bc3VJ4/dXhp9Gdu4jHyImGxMxAuT8ajsKeGkTmEQz1asR23+PT
         F8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863337; x=1707468137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPdGoRi9Q/Z94tgZI+Yh2dsfYo8XG51UXhclzkjwaXI=;
        b=tryDv+KeAmCMFLE4H0jIJVXoqKg0f6m2HCS7J0DeXg8GWpUtsbAYDW+8DOadkwoNAQ
         nEw+5Td/mWkNcXE9cXGJbjzX7ejdmpOg83kRLerwDcceNnnVYXPwftBzAWYnSG4LBXDm
         rC8b3lbm0vlC9maNKQgzdNMwSk433jiYKxaxlc5Ksx/IAP/ftfTwLPFac76QbK4W+8PU
         U3FuSyc+toagrwTp6DotRB90PugE1JKP4E8cmACaVjxdgqzX6SYHU0cGh3yszXN9RpOg
         jOud7T9aBPvE5+KDxwwo34Dp0C10H3vd/vlLj6/GT/C1XRg0gzpkwH6XJVv/2vBMdroO
         MqzA==
X-Gm-Message-State: AOJu0YwDpt4qVDAk8VprWq8NzGfeJGJdCPDRsjp7nTmWwCKx04Ay8RTd
	qGnXhisL5wzLfmZWnb/HQ8mQDDwmDh84Nb/3RtiWbRdd/mWkEa7SWnEKxBzdKo8=
X-Google-Smtp-Source: AGHT+IEdkKMD2YyKIjcbZQJRMEInK5fZvN0HL2AEdTD3QAGNSDQhn3jqRZdGSvnkLfOOYK84zwmGJA==
X-Received: by 2002:a17:906:7158:b0:a36:cd96:4b5d with SMTP id z24-20020a170906715800b00a36cd964b5dmr2660222ejj.45.1706863336919;
        Fri, 02 Feb 2024 00:42:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUkcQo0AGkIAWGrtXqaZ+TEINEoWJ0aPBkGGmtlxzgxbyWn8izca7eLmJs848nuNalvr7t0zZf5NzfJH674q8K+1iv37aWhIq0BrsaAUwWsHZ3CVQFHRzF0IPz0WNsPnWg3XctHTI9xeHRzWScO13EfrL5VJ15RQAdC+ms7nnBnFauz+kZkIC5lRr+ZF1HXgSiATTe7WyQYV605cDGFgXb+YP4YF1Q3/9V20fiOCkuDW0YENrVP/heiJxuke70zembo2EpDEykCLfbToAEDihxje1YyM8j4boUbvpB6sp1t1fkU+CGdT9UHZ/3J7EgJNW6sUr2C1he4kMlXNQWtWqH4sGPrJhH4rZAau+2heezIZ98lyofMLoCjCYH/mxHROf4hwc1assGuf32FBA==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id oz35-20020a1709077da300b00a361c1375absm631642ejc.133.2024.02.02.00.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:42:15 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v6 12/15] net: ravb: Move PTP initialization in the driver's ndo_open API for ccc_gac platorms
Date: Fri,  2 Feb 2024 10:41:33 +0200
Message-Id: <20240202084136.3426492-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com>
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

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v6:
- re-arranged the tags as my b4 am/shazam placed the Rb tags
  before author's Sob tag

Changes in v5:
- none

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
index 318ab27635bb..54099fef946e 100644
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


