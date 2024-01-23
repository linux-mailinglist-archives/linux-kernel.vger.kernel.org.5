Return-Path: <linux-kernel+bounces-35303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F9838F44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8EA1C21F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7594060EFD;
	Tue, 23 Jan 2024 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CtHGy/51"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5DB60B98
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014792; cv=none; b=Ul10xBjdWKNBfq0UxyM9Nh36w5nI62HZr9htA/I4+R720iCliOmy44CbmJ3BE6EKQ6RGXwJ23jVgIiK7xV/VQyx/WhiwA8qEKB5uREGDGtz5/H3dMDRPP0HAtx/RxKv45Ujqm4h8jxM0iWEkjffONVZfQ2+xAYWh/tedsUavofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014792; c=relaxed/simple;
	bh=YyFbvj9rdXELCvEQMZ8EGmmYEN4CbHMx8owffqm1P7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sRKaJps4hUBPH4Tkmjcxs3s8PgZKIUwpQDa3NeDMNtlQ74Kv4DtROX+u8soOv3ERnSE7pBjbkoalpgBcgFWrn+Bvs70TfTR2Im5Vz5ZZw30GC2eKz5M/b8v/2CBg5peeGbFFBy1zBh+lyz4GfdjiDqW3zUFkbwubQvqRAA8X9Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=CtHGy/51; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so19464175e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706014789; x=1706619589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M40Sq12XPx3AN5HTBgz2AHvalMLyn45DfI68COiA/50=;
        b=CtHGy/51RBgi3MM7UN3y/SmnEkofLiHRTp7Obz+suaEwI0/np9H9r9UL+sNjIKlQLk
         Hj5ELlucRqFkS8OwfGRIQv6S+EXmIu3QoK5fX+ODdcJd4vLRrDP3M467zFUKq3BYMa8K
         J2HKYxO4+G7SViteolAydH90x9kr1T8ZMhjvwho+HQtQ+3UveBJb94dV22xqrrQTNYBw
         hNh1QOCsgBiDu1fLa1H2WHuR9CHpkst5qB0SOrK5rP5P2JWzySXUM8T8K09wkCa4ePuY
         pZl6Zwith1Z/Vq78359PFW1yuSDoyIuPwc700X38MKmKFn2SSvtZwYYMgaon5ef1e1Su
         3MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014789; x=1706619589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M40Sq12XPx3AN5HTBgz2AHvalMLyn45DfI68COiA/50=;
        b=S5yERW9+DxgNtxyzAH8PqgYzPinQnjyKISZIpY3N1lhzUQIHyKz3mv7VQ2wW1/Dh0q
         o3d7imfElqTzDPQ92iSj3Pu22Ocqytub4InzwmM9ZULroe7ZOmOYKaJ5UYpZw1RvLIb9
         AR4cBefj4ThHGd5MXJHfxQ74iRhwrJYR6ESJC3/FONs3Z6IaclFhkfZb9lIebUe32tVn
         A/6qY2LgjrrKW6RKxeIL/xQwpddxYAczt6VCul4oLjht9T8IBfYONWpDKOCX4vlB3i1z
         j8TF6sWao79XSleEqtYDOajmMb8iY4K3FZOpz1JCE4a5jh0bD3us+7wPqlNl2+IU98F9
         BhTA==
X-Gm-Message-State: AOJu0YwtGjYpZxWtizbRFI5l6K6/XD84RGilhesVd6l02cmcDNoTEXQ9
	RS/AnI6qc7Ig1YIa4pVKOGqmlhCPxlAX8OOI5llV+HS0YYrTgvVUmUABd/srQTs=
X-Google-Smtp-Source: AGHT+IHL5CzTKszbIGhdxCBwuomUA2c+d3a2P8nrAU3xRsiQA2witEAkf4dDlCyglNacwbc6ktnI2Q==
X-Received: by 2002:a05:600c:4f4d:b0:40e:b161:78d with SMTP id m13-20020a05600c4f4d00b0040eb161078dmr129471wmq.113.1706014788969;
        Tue, 23 Jan 2024 04:59:48 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id s4-20020a05600c45c400b0040e6ff60057sm33655711wmo.48.2024.01.23.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:59:48 -0800 (PST)
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
Subject: [PATCH net-next v4 13/15] net: ravb: Set config mode in ndo_open and reset mode in ndo_close
Date: Tue, 23 Jan 2024 14:58:27 +0200
Message-Id: <20240123125829.3970325-14-claudiu.beznea.uj@bp.renesas.com>
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

As some IP variants switch to reset mode (and thus registers content is
lost) when setting clocks (due to module standby functionality) to be able
to implement runtime PM and save more power, set the IP's operating mode to
reset at the end of the probe. Along with it, in the ndo_open API the IP
will be switched to configuration, then operation mode. In the ndo_close
API, the IP will be switched back to reset mode. This allows implementing
runtime PM and, along with it, save more power when the IP is not used.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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
index 91cabe098cc2..e22760b91a97 100644
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


