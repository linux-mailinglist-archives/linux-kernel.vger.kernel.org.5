Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230F5812F32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444232AbjLNLrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444219AbjLNLqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:46:44 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A845133
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:32 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so926823766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554391; x=1703159191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvqstCJTSxpQ0zTFtZeVFyf9XwS489IYbBY9tfQ8I8w=;
        b=YHA90Fx5I0cqQCkOrzTgfef48t0Rv4Tx/CMTl22g7xUdS5+QGJ2zs8USYnHzL5hMBM
         vu2g0DZN9ncR8e8S6jpA3qKCpioPYE12zLka/DrvUkXYbiMBvDaNiFCY0t7BHKb+Qt5O
         dfHm2txXvptwludAcCX57vjrnsXhILUfXg+JPHaIMdyfLGx547mFz9k8nE/S9dhUcQjN
         UjorlfyrVt2G4/ChIrWgQ8y0P9aOfX/i6Uz/SAT9KV/tz7uvHUJUhradi3Hq7HVy9arr
         /Y/NaV2+PmFDlDSNhTjqoRjyBfnHQ+NjJHk16J7hlsdu2U7F4WruPRrJnVuRpCCBRdto
         ZYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554391; x=1703159191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvqstCJTSxpQ0zTFtZeVFyf9XwS489IYbBY9tfQ8I8w=;
        b=o7zYlTpV+lEnCad5BXHaiVdrfSEw9Aoua5lDO/WOhqBuuZKAXQVChyzgdoquZH8uVh
         BHVXFm8hTjyeZDGvgiiMl/iamGQ9aEIzJ6/gK2T8zTKL2ZcPr2OjLciWD8xpDjD6+J7r
         Ozdg14NCdbUjXv/1dsl/DKbE5O6VF28PjBHX0hkuu1pCqMT7Jsv7ju6xwtrKaXGZ1JGT
         RQ/EYZTmmnm4soJWNTiVXUdgft85Gxlz0wuV30rgjWLrtSJCMx7Xidjped3isKAHOOEw
         goZuRwCzAjeg1i+wrBfZVj+O06OJJr6/MN42DkuJNcVo2iGMBv41/6kOQyV9PbGB3zVR
         XVuw==
X-Gm-Message-State: AOJu0Yy0+sLlLzgwJPQXJa+l/FgAjZtnXPaRlaS4epnSr0Kf5yIHluWc
        pJTXsALAiqSTKSPKCBd9UuLRHS13KjlphxoH964=
X-Google-Smtp-Source: AGHT+IFgAP23xaHhWugO0C8DEtcDbctnuWlDzqn1ezvfAwo7Xo5UqKOcKz77/sBDQ6B+eyrxjZz8FQ==
X-Received: by 2002:a17:906:3f5b:b0:a19:a19a:eab5 with SMTP id f27-20020a1709063f5b00b00a19a19aeab5mr4216369ejj.110.1702554391078;
        Thu, 14 Dec 2023 03:46:31 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:30 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 08/21] net: ravb: Move the IRQs get and request in the probe function
Date:   Thu, 14 Dec 2023 13:45:47 +0200
Message-Id: <20231214114600.2451162-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Move the IRQs get and request in the driver's probe function. As some IP
variants switches to reset operation mode as a result of setting module
standby through clock enable/disable APIs, to implement runtime PM the
resource parsing and requests are moved in the probe function and IP
settings are moved in the open functions. This is a preparatory change to
add runtime PM support for all IP variants.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 274 +++++++++++------------
 1 file changed, 132 insertions(+), 142 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 83691a0f0cc2..d7f6e8ea8e79 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1731,7 +1731,7 @@ static inline int ravb_hook_irq(unsigned int irq, irq_handler_t handler,
 	name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
 	if (!name)
 		return -ENOMEM;
-	error = request_irq(irq, handler, 0, name, ndev);
+	error = devm_request_irq(dev, irq, handler, 0, name, ndev);
 	if (error)
 		netdev_err(ndev, "cannot request IRQ %s\n", name);
 
@@ -1755,63 +1755,16 @@ static int ravb_open(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	struct platform_device *pdev = priv->pdev;
-	struct device *dev = &pdev->dev;
 	int error;
 
 	napi_enable(&priv->napi[RAVB_BE]);
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 
-	if (!info->multi_irqs) {
-		error = request_irq(ndev->irq, ravb_interrupt, IRQF_SHARED,
-				    ndev->name, ndev);
-		if (error) {
-			netdev_err(ndev, "cannot request IRQ\n");
-			goto out_napi_off;
-		}
-	} else {
-		error = ravb_hook_irq(ndev->irq, ravb_multi_interrupt, ndev,
-				      dev, "ch22:multi");
-		if (error)
-			goto out_napi_off;
-		error = ravb_hook_irq(priv->emac_irq, ravb_emac_interrupt, ndev,
-				      dev, "ch24:emac");
-		if (error)
-			goto out_free_irq;
-		error = ravb_hook_irq(priv->rx_irqs[RAVB_BE], ravb_be_interrupt,
-				      ndev, dev, "ch0:rx_be");
-		if (error)
-			goto out_free_irq_emac;
-		error = ravb_hook_irq(priv->tx_irqs[RAVB_BE], ravb_be_interrupt,
-				      ndev, dev, "ch18:tx_be");
-		if (error)
-			goto out_free_irq_be_rx;
-		error = ravb_hook_irq(priv->rx_irqs[RAVB_NC], ravb_nc_interrupt,
-				      ndev, dev, "ch1:rx_nc");
-		if (error)
-			goto out_free_irq_be_tx;
-		error = ravb_hook_irq(priv->tx_irqs[RAVB_NC], ravb_nc_interrupt,
-				      ndev, dev, "ch19:tx_nc");
-		if (error)
-			goto out_free_irq_nc_rx;
-
-		if (info->err_mgmt_irqs) {
-			error = ravb_hook_irq(priv->erra_irq, ravb_multi_interrupt,
-					      ndev, dev, "err_a");
-			if (error)
-				goto out_free_irq_nc_tx;
-			error = ravb_hook_irq(priv->mgmta_irq, ravb_multi_interrupt,
-					      ndev, dev, "mgmt_a");
-			if (error)
-				goto out_free_irq_erra;
-		}
-	}
-
 	/* Device init */
 	error = ravb_dmac_init(ndev);
 	if (error)
-		goto out_free_irq_mgmta;
+		goto out_napi_off;
 	ravb_emac_init(ndev);
 
 	/* Initialise PTP Clock driver */
@@ -1832,26 +1785,6 @@ static int ravb_open(struct net_device *ndev)
 	if (info->gptp)
 		ravb_ptp_stop(ndev);
 	ravb_stop_dma(ndev);
-out_free_irq_mgmta:
-	if (!info->multi_irqs)
-		goto out_free_irq;
-	if (info->err_mgmt_irqs)
-		free_irq(priv->mgmta_irq, ndev);
-out_free_irq_erra:
-	if (info->err_mgmt_irqs)
-		free_irq(priv->erra_irq, ndev);
-out_free_irq_nc_tx:
-	free_irq(priv->tx_irqs[RAVB_NC], ndev);
-out_free_irq_nc_rx:
-	free_irq(priv->rx_irqs[RAVB_NC], ndev);
-out_free_irq_be_tx:
-	free_irq(priv->tx_irqs[RAVB_BE], ndev);
-out_free_irq_be_rx:
-	free_irq(priv->rx_irqs[RAVB_BE], ndev);
-out_free_irq_emac:
-	free_irq(priv->emac_irq, ndev);
-out_free_irq:
-	free_irq(ndev->irq, ndev);
 out_napi_off:
 	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
@@ -2177,19 +2110,6 @@ static int ravb_close(struct net_device *ndev)
 
 	cancel_work_sync(&priv->work);
 
-	if (info->multi_irqs) {
-		free_irq(priv->tx_irqs[RAVB_NC], ndev);
-		free_irq(priv->rx_irqs[RAVB_NC], ndev);
-		free_irq(priv->tx_irqs[RAVB_BE], ndev);
-		free_irq(priv->rx_irqs[RAVB_BE], ndev);
-		free_irq(priv->emac_irq, ndev);
-		if (info->err_mgmt_irqs) {
-			free_irq(priv->erra_irq, ndev);
-			free_irq(priv->mgmta_irq, ndev);
-		}
-	}
-	free_irq(ndev->irq, ndev);
-
 	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
 	napi_disable(&priv->napi[RAVB_BE]);
@@ -2616,6 +2536,127 @@ static void ravb_parse_delay_mode(struct device_node *np, struct net_device *nde
 	}
 }
 
+static int ravb_get_irqs(struct ravb_private *priv)
+{
+	const char *err_a_irq_name = NULL, *mgmt_a_irq_name = NULL;
+	const struct ravb_hw_info *info = priv->info;
+	struct platform_device *pdev = priv->pdev;
+	struct net_device *ndev = priv->ndev;
+	const char *irq_name, *emac_irq_name;
+	int i, irq;
+
+	if (!info->multi_irqs) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0)
+			return irq;
+
+		ndev->irq = irq;
+		return 0;
+	}
+
+	if (info->err_mgmt_irqs) {
+		irq_name = "dia";
+		emac_irq_name = "line3";
+		err_a_irq_name = "err_a";
+		mgmt_a_irq_name = "mgmt_a";
+	} else {
+		irq_name = "ch22";
+		emac_irq_name = "ch24";
+	}
+
+	irq = platform_get_irq_byname(pdev, irq_name);
+	if (irq < 0)
+		return irq;
+	ndev->irq = irq;
+
+	irq = platform_get_irq_byname(pdev, emac_irq_name);
+	if (irq < 0)
+		return irq;
+	priv->emac_irq = irq;
+
+	if (err_a_irq_name) {
+		irq = platform_get_irq_byname(pdev, "err_a");
+		if (irq < 0)
+			return irq;
+		priv->erra_irq = irq;
+	}
+
+	if (mgmt_a_irq_name) {
+		irq = platform_get_irq_byname(pdev, "mgmt_a");
+		if (irq < 0)
+			return irq;
+		priv->mgmta_irq = irq;
+	}
+
+	for (i = 0; i < NUM_RX_QUEUE; i++) {
+		irq = platform_get_irq_byname(pdev, ravb_rx_irqs[i]);
+		if (irq < 0)
+			return irq;
+		priv->rx_irqs[i] = irq;
+	}
+	for (i = 0; i < NUM_TX_QUEUE; i++) {
+		irq = platform_get_irq_byname(pdev, ravb_tx_irqs[i]);
+		if (irq < 0)
+			return irq;
+		priv->tx_irqs[i] = irq;
+	}
+
+	return 0;
+}
+
+static int ravb_request_irqs(struct ravb_private *priv)
+{
+	const struct ravb_hw_info *info = priv->info;
+	struct net_device *ndev = priv->ndev;
+	struct device *dev = &priv->pdev->dev;
+	int error;
+
+	if (!info->multi_irqs) {
+		error = devm_request_irq(dev, ndev->irq, ravb_interrupt, IRQF_SHARED,
+					 ndev->name, ndev);
+		if (error)
+			netdev_err(ndev, "cannot request IRQ\n");
+
+		return error;
+	}
+
+	error = ravb_hook_irq(ndev->irq, ravb_multi_interrupt, ndev,
+			      dev, "ch22:multi");
+	if (error)
+		return error;
+	error = ravb_hook_irq(priv->emac_irq, ravb_emac_interrupt, ndev,
+			      dev, "ch24:emac");
+	if (error)
+		return error;
+	error = ravb_hook_irq(priv->rx_irqs[RAVB_BE], ravb_be_interrupt,
+			      ndev, dev, "ch0:rx_be");
+	if (error)
+		return error;
+	error = ravb_hook_irq(priv->tx_irqs[RAVB_BE], ravb_be_interrupt,
+			      ndev, dev, "ch18:tx_be");
+	if (error)
+		return error;
+	error = ravb_hook_irq(priv->rx_irqs[RAVB_NC], ravb_nc_interrupt,
+			      ndev, dev, "ch1:rx_nc");
+	if (error)
+		return error;
+	error = ravb_hook_irq(priv->tx_irqs[RAVB_NC], ravb_nc_interrupt,
+			      ndev, dev, "ch19:tx_nc");
+	if (error)
+		return error;
+
+	if (!info->err_mgmt_irqs)
+		return 0;
+
+	error = ravb_hook_irq(priv->erra_irq, ravb_multi_interrupt,
+			      ndev, dev, "err_a");
+	if (error)
+		return error;
+
+	return ravb_hook_irq(priv->mgmta_irq, ravb_multi_interrupt,
+			     ndev, dev, "mgmt_a");
+}
+
 static void ravb_set_delay_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -2635,9 +2676,8 @@ static int ravb_probe(struct platform_device *pdev)
 	struct reset_control *rstc;
 	struct ravb_private *priv;
 	struct net_device *ndev;
-	int error, irq, q;
 	struct resource *res;
-	int i;
+	int error, q;
 
 	if (!np) {
 		dev_err(&pdev->dev,
@@ -2664,20 +2704,6 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		goto out_free_netdev;
 
-	if (info->multi_irqs) {
-		if (info->err_mgmt_irqs)
-			irq = platform_get_irq_byname(pdev, "dia");
-		else
-			irq = platform_get_irq_byname(pdev, "ch22");
-	} else {
-		irq = platform_get_irq(pdev, 0);
-	}
-	if (irq < 0) {
-		error = irq;
-		goto out_reset_assert;
-	}
-	ndev->irq = irq;
-
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
 	priv = netdev_priv(ndev);
@@ -2692,6 +2718,14 @@ static int ravb_probe(struct platform_device *pdev)
 		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
 	}
 
+	error = ravb_get_irqs(priv);
+	if (error)
+		goto out_reset_assert;
+
+	error = ravb_request_irqs(priv);
+	if (error)
+		goto out_reset_assert;
+
 	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
 	if (IS_ERR(priv->refclk)) {
 		error = PTR_ERR(priv->refclk);
@@ -2725,50 +2759,6 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->avb_link_active_low =
 		of_property_read_bool(np, "renesas,ether-link-active-low");
 
-	if (info->multi_irqs) {
-		if (info->err_mgmt_irqs)
-			irq = platform_get_irq_byname(pdev, "line3");
-		else
-			irq = platform_get_irq_byname(pdev, "ch24");
-		if (irq < 0) {
-			error = irq;
-			goto out_rpm_put;
-		}
-		priv->emac_irq = irq;
-		for (i = 0; i < NUM_RX_QUEUE; i++) {
-			irq = platform_get_irq_byname(pdev, ravb_rx_irqs[i]);
-			if (irq < 0) {
-				error = irq;
-				goto out_rpm_put;
-			}
-			priv->rx_irqs[i] = irq;
-		}
-		for (i = 0; i < NUM_TX_QUEUE; i++) {
-			irq = platform_get_irq_byname(pdev, ravb_tx_irqs[i]);
-			if (irq < 0) {
-				error = irq;
-				goto out_rpm_put;
-			}
-			priv->tx_irqs[i] = irq;
-		}
-
-		if (info->err_mgmt_irqs) {
-			irq = platform_get_irq_byname(pdev, "err_a");
-			if (irq < 0) {
-				error = irq;
-				goto out_rpm_put;
-			}
-			priv->erra_irq = irq;
-
-			irq = platform_get_irq_byname(pdev, "mgmt_a");
-			if (irq < 0) {
-				error = irq;
-				goto out_rpm_put;
-			}
-			priv->mgmta_irq = irq;
-		}
-	}
-
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		error = PTR_ERR(priv->clk);
-- 
2.39.2

