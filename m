Return-Path: <linux-kernel+bounces-49495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25401846B18
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9518EB23254
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79C79953;
	Fri,  2 Feb 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ERbCg8F9"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024577F3D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863343; cv=none; b=JXhY87oUCkH/voHy9o4PlLiHsNE/CAe9nDgAXU49rmVKf43txhcPA98QbHxIJwtfrC/QbsyEI5XS79UDe2rNk1zu3F7WjKuV50qxDR4J1PTcQaYfeRbYgDn9mgDwipebLwL93mQL+6bkihF78NDsy+T/0u295gsZSQfElIZEoE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863343; c=relaxed/simple;
	bh=jZ/JtSBDk6b8fVvnMb9jcB+g4KQkYzKFaOwQs0N0jOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IKrXHriR+++stNWK7SyO3f/VFBp46u4s8LOFmmvK/HlkxEbDb4VwQnaDJdcjsbrOgnpaMjVKy7/VN+ut63m13suoMfspjzJJEOdgc5rhKVvf7yxhrdE9RtyX4CTG9f2TgmfcpcC5jgjmL9mAoNjOBTv0XLYDBg2R0UqCUDIvAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ERbCg8F9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so226308166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706863340; x=1707468140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdBRN43/f+IaSeAWmmcwymoLpbD8uhnfyRcjVPy2MFQ=;
        b=ERbCg8F9EXn7Cve1sUCsMG/fDAYF79O4Md8grwG6yTI5Y8Dpu1sJW5hUTXJbbgJO9t
         9myZqaomA7ujmqeGb/6gFhEIZb5JkR8VAUSpuaC/jUt3pbmu9f5kjvJNKJyWNR3cJXFN
         tU+DapHqpiR2oxG2IPmVkW3Tb71l5Ocs9dFg9Nug+Z4r6IJVOrL7PM17efRDWfW9oCYW
         PDeXszDKKwyrQQSUyRsjJZw7EieLc9KAnRdSS12yJyr3PW+o5TnwE9UbmwkSvokCWU3t
         8Idk56s+QBk4OGrEmOKZ4EjI2fqN36U56Dcjl7IrwXOjCPICfyj9edgJVH0bzAW9WbCI
         DGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863340; x=1707468140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdBRN43/f+IaSeAWmmcwymoLpbD8uhnfyRcjVPy2MFQ=;
        b=cZJqMhsVaUP/qleko6i1oe974nhdrkovvicRDrUTYk5iPB/bYB3onvnXlM+fGqHhsI
         uGN4tF8M/rrUFl3/97wYplbaXBxRkOEsUGbIVOVzIEEpcguuSBdAXYTBTcV+KgPOEcni
         N7PFscxyiEYMykA//JywV3gI5+q7JtDjW0IXOoqQSynVQEdj0HuOq+AQVXBUjzioRdJM
         oG2OXrKGD0rU8FDKl0Y6MkCEebelvLzKkOJbKjbKXGGTs7iGSUXzj2nFHf1pgCFU3sMQ
         EvSE19lNduupFt82fstipG2vCzRBVRfHoXq7i/LL3hFEwkYv8HLE63RxZVWq8GgGyHKj
         126A==
X-Gm-Message-State: AOJu0Yx6FRlVWhNZuoV4RGI+FiQTu8kqTlvuaQLagVy8BcR+wrBAImam
	yIA2Nulmu/X8PNXE7tAjmuY/Kgr1rGlxxrzQlZGDIvfCInAl6/44KKFE2bSCswA=
X-Google-Smtp-Source: AGHT+IHR2cDV4MQnJeg7q1Vq7RxAkmUq0ihbDA6MWkBVHgUbN+RHXN0c23xoH15dPCKl+J88sRxFOg==
X-Received: by 2002:a17:906:48c7:b0:a35:62a9:a659 with SMTP id d7-20020a17090648c700b00a3562a9a659mr4595883ejt.72.1706863339945;
        Fri, 02 Feb 2024 00:42:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVk4KMSGP5eXxsUW72eskLr15QaB+6MF7/grCx5vZlhpLiedZvbOWbXrupftbIgQwJfTXd4YsHrmATa2dJyUNRFkLSaPARU4vxDROwIuo3yp6B5Ir8qLSG8XsCJf6b3bFQX9TDbVCpDn7jNakLepaAUSnL1ARP20uLuFJnwpUzrDjCO231fArdzLaf1HJsszHB8fJmz41tzXLKRQJG9+ioQN94KJfkFNUomwN9py2GLmoXaOfl40SR43jghyhKNBSNODbTxeY/aKmmIX+ANc0m0UfRo7KjIAwOoNXuR7zG2vWImu4WELECPfXEv0Lhm9k/O9AarJmDDRax/4r57BnXPkVbzxlX6DsUEZTWY2MATxzqGPuMI4LaV+rqDLDS3Ra0ibuCrlcm1SQqSuA==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id oz35-20020a1709077da300b00a361c1375absm631642ejc.133.2024.02.02.00.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:42:17 -0800 (PST)
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
Subject: [PATCH net-next v6 13/15] net: ravb: Set config mode in ndo_open and reset mode in ndo_close
Date: Fri,  2 Feb 2024 10:41:34 +0200
Message-Id: <20240202084136.3426492-14-claudiu.beznea.uj@bp.renesas.com>
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

As some IP variants switch to reset mode (and thus the register contents is
lost) when setting clocks (due to module standby functionality) to be able
to implement runtime PM and save more power, set the IP's operating mode to
reset at the end of the probe. Along with it, in the ndo_open API the IP
will be switched to configuration, then operation mode. In the ndo_close
API, the IP will be switched back to reset mode. This allows implementing
runtime PM and, along with it, save more power when the IP is not used.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v6:
- re-arranged the tags as my b4 am/shazam placed the Rb tags
  before author's Sob tag

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


