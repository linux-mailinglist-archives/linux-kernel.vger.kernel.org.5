Return-Path: <linux-kernel+bounces-46035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37046843997
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA771C2738F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71E27E56C;
	Wed, 31 Jan 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bm4NH0oE"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E8779DB5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690529; cv=none; b=ictFAi5eFM29qBlFZ67vFnQ2WUqWOJWHecS/Kmttkxvkq0ViHse6GQsHgmDUZGSrli3RsqbsVyS0uFUOfFAOU453s7H918CmpTtkqodhKUBVwRhzGjVdXlA0fFb0Vdcb36Ceo+bvv3GC+ORXQMrHZDMCShrT9gUIsjFEQG8Rz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690529; c=relaxed/simple;
	bh=SMFD2wooseUV4EjGWpE317D8OQSKSM0pSKR/g7N9T7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iPc4aagCLyrPGBHDet7nkfLTiNTfXjHMqmVTPhni442KyGBHBhfZKf3BMzttRT6MKEiHpvm63EntYLo/XN/+7be+1vlBkA9zEtdMVz3lM2myfMJJQ9imxWmIWXtViFyiajhPO9QAnm94ZZte6mCptWWQQes5xC6lmilUmwZH7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bm4NH0oE; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so58437281fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706690524; x=1707295324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4P3NNUndOj/U3jAxOrkBuhZxASPQ1uf/KZV1iCgPUY=;
        b=bm4NH0oE3y+H9/a12wqU+uye9zHea82rWi2hXLGjmXTE90aKKQGz5iBzMb7Bml1pl7
         8TCnUoR0OZFKI7kOH1sVXf2016yzi9OZQVYG2ZduWATZDLKuGvYgobtzttSDxnGEeUhX
         DWqL1IQLgqyjbZLY4HDr/kZw82rDBJ0GxPCWPCtBaKAGHqwhRRTzCx1j6eZuNFEDyUmG
         6n3XwhNjWUaNHF12LwQucO+ne/gcpTtbOXBpFLehSvbTNNEVYn5nu8QQVZXhENYVjUEL
         ACmNMVKQrVOGcyMX00ZXCTHkNgKqEwvasQK8+BZ6ZNTq9kkBxMQXiV0FiDyoRNeHxs21
         6gIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706690524; x=1707295324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4P3NNUndOj/U3jAxOrkBuhZxASPQ1uf/KZV1iCgPUY=;
        b=dHn4q16qRUgG7oLLAkqwmH3hULJnoXlR2u/jilGh+JhbfYQQJIjhVJOT8M+3LCzTx3
         MmaHPEgw3/JCuMRXBq3GaCqagjgb41BuPAzP23pe9zrfX8y7vqt/W/3MsF9fjXKU/6qt
         uVrY7EaziDjSz09+2lAqwzIdCl6ZDrZSG0g1Yt4UFGrT8pcUyavq+ECQO/+eoJosQ0QX
         bhk+9hgq46D6gKI4/y4iaS/uim7sl2zBfNeG0L0LGJ9TxfAdP5OHoPd6klxeN7EpDPaN
         MTSlkH0BkyrUmP3FnKWsMeu++l6qJ0MnxubKClDtFF3KTTRrL2nc1TK2A6Qnj3+RQGhx
         5PCg==
X-Gm-Message-State: AOJu0YwyQdqCYc8lb34eVpYsrDGQcY/JiCiA8CJDwYx2b6f8C9ByHAxY
	Utr4ckDDn3Y14yUCYQYqeeLxcXzZQarqXTZtxKZ/1nIn1NwOCf+/4qaEVdcSUoU=
X-Google-Smtp-Source: AGHT+IEiL482XuRa8KwAmlwH28GEu/fJYWXxZ+wtgFd+vKtDuH84PyPSa2bjesp31jrgpOFmZFaEcQ==
X-Received: by 2002:a05:651c:221c:b0:2d0:604d:fda6 with SMTP id y28-20020a05651c221c00b002d0604dfda6mr814787ljq.44.1706690523545;
        Wed, 31 Jan 2024 00:42:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXrqLJw9JLWNup24eFLJBtSBvdaq8f/dNVorTAyKDfd5NoIXrdnwnkl6AVlqcBGvNUakV7rbez6nz+Prdy4WZr+QWhdnok1VXiZcPDWFsT1c0QE06g++9XfhA7XqGDqPiGw7SfgxTS6NIP5tjnraa8j3W8I0xeeU2w9K/uYk687RzKWp2OYlhHjBJqCzQ7fE92V4BJJDbTgUYv3YfsvtyXCn3TTElv00VCSgEsDNJDn1fVg2aYLxSDaNWaaeKH8j5Dht2RXCZxYCApPb9LJPU6Utqg9QNwozTFSEJB1kQBdztPmccL4l4x602pGASxZYku8GMg8K6Xuw07THbDX0GK4wb6yqY3/RcxaqxlbsUH+Py4PNDWL5eA18CXk4xZPmylN5quXnNu6tHbrIckKvI7c4tFkvbgGDVVJkEe0XVA80yW4DIw=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0055f02661ae2sm2863630edb.78.2024.01.31.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:42:03 -0800 (PST)
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
Subject: [PATCH net-next v5 13/15] net: ravb: Set config mode in ndo_open and reset mode in ndo_close
Date: Wed, 31 Jan 2024 10:41:31 +0200
Message-Id: <20240131084133.1671440-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

As some IP variants switch to reset mode (and thus the register contents is
lost) when setting clocks (due to module standby functionality) to be able
to implement runtime PM and save more power, set the IP's operating mode to
reset at the end of the probe. Along with it, in the ndo_open API the IP
will be switched to configuration, then operation mode. In the ndo_close
API, the IP will be switched back to reset mode. This allows implementing
runtime PM and, along with it, save more power when the IP is not used.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- fixed typos in patch description
- collected tags

Changes in v4:
- set config mode before reading mac address

Changes in v3:
- fixed typos in patch description
- in ravb_probe() switch the hardware to reset mode just after phy
  initialization

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 78 ++++++++++++++----------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 54099fef946e..0dab98ea615a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1756,6 +1756,27 @@ static const struct ethtool_ops ravb_ethtool_ops = {
 	.set_wol		= ravb_set_wol,
 };
 
+static int ravb_set_config_mode(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+	int error;
+
+	if (info->gptp) {
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+		if (error)
+			return error;
+		/* Set CSEL value */
+		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
+	} else if (info->ccc_gac) {
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
+	} else {
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+	}
+
+	return error;
+}
+
 static void ravb_set_gti(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -1864,13 +1885,19 @@ static int ravb_open(struct net_device *ndev)
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 
+	/* Set AVB config mode */
+	error = ravb_set_config_mode(ndev);
+	if (error)
+		goto out_napi_off;
+
 	ravb_set_delay_mode(ndev);
 	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Device init */
 	error = ravb_dmac_init(ndev);
 	if (error)
-		goto out_napi_off;
+		goto out_set_reset;
+
 	ravb_emac_init(ndev);
 
 	ravb_set_gti(ndev);
@@ -1893,6 +1920,8 @@ static int ravb_open(struct net_device *ndev)
 	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
 	ravb_stop_dma(ndev);
+out_set_reset:
+	ravb_set_opmode(ndev, CCC_OPC_RESET);
 out_napi_off:
 	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
@@ -2236,7 +2265,8 @@ static int ravb_close(struct net_device *ndev)
 	if (info->nc_queues)
 		ravb_ring_free(ndev, RAVB_NC);
 
-	return 0;
+	/* Set reset mode. */
+	return ravb_set_opmode(ndev, CCC_OPC_RESET);
 }
 
 static int ravb_hwtstamp_get(struct net_device *ndev, struct ifreq *req)
@@ -2566,27 +2596,6 @@ static const struct of_device_id ravb_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, ravb_match_table);
 
-static int ravb_set_config_mode(struct net_device *ndev)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
-	int error;
-
-	if (info->gptp) {
-		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
-		if (error)
-			return error;
-		/* Set CSEL value */
-		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
-	} else if (info->ccc_gac) {
-		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
-	} else {
-		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
-	}
-
-	return error;
-}
-
 static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
 			  const char *ch, int *irq, irq_handler_t handler)
 {
@@ -2785,11 +2794,6 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->netdev_ops = &ravb_netdev_ops;
 	ndev->ethtool_ops = &ravb_ethtool_ops;
 
-	/* Set AVB config mode */
-	error = ravb_set_config_mode(ndev);
-	if (error)
-		goto out_rpm_put;
-
 	error = ravb_compute_gti(ndev);
 	if (error)
 		goto out_rpm_put;
@@ -2816,6 +2820,11 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Debug message level */
 	priv->msg_enable = RAVB_DEF_MSG_ENABLE;
 
+	/* Set config mode as this is needed for PHY initialization. */
+	error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+	if (error)
+		goto out_rpm_put;
+
 	/* Read and set MAC address */
 	ravb_read_mac_address(np, ndev);
 	if (!is_valid_ether_addr(ndev->dev_addr)) {
@@ -2828,9 +2837,14 @@ static int ravb_probe(struct platform_device *pdev)
 	error = ravb_mdio_init(priv);
 	if (error) {
 		dev_err(&pdev->dev, "failed to initialize MDIO\n");
-		goto out_dma_free;
+		goto out_reset_mode;
 	}
 
+	/* Undo previous switch to config opmode. */
+	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
+	if (error)
+		goto out_mdio_release;
+
 	netif_napi_add(ndev, &priv->napi[RAVB_BE], ravb_poll);
 	if (info->nc_queues)
 		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll);
@@ -2853,8 +2867,10 @@ static int ravb_probe(struct platform_device *pdev)
 		netif_napi_del(&priv->napi[RAVB_NC]);
 
 	netif_napi_del(&priv->napi[RAVB_BE]);
+out_mdio_release:
 	ravb_mdio_release(priv);
-out_dma_free:
+out_reset_mode:
+	ravb_set_opmode(ndev, CCC_OPC_RESET);
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 out_rpm_put:
@@ -2885,8 +2901,6 @@ static void ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	ravb_set_opmode(ndev, CCC_OPC_RESET);
-
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_unprepare(priv->refclk);
-- 
2.39.2


