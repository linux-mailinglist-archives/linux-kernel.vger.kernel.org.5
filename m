Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2377F0E09
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjKTIrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjKTIrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:47:04 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CB4171F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:47 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50aabfa1b75so1136062e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700470005; x=1701074805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FNYhRa/kTA6OUz1GxKxTdj30g/SDXO/leUXkzzIoxw=;
        b=VO0kq44x/Wrch2l5+Q2+FYZCPkFeiV1TaJFx3HDqz3Qc91dlnm32ICrOeS/za1WGy9
         +cde5RstXHKniIsl87ENRryRktE/DkdZDv5gVDf/oUxRlxZ4YV3tibfOs0KgTv8I4fW0
         nPTG2Tw7uzh5ii5xHD5V8l7XHid40OzAGTtsxetw7v7Ann2CTwcLzLeLYCKwz+AC1IQ7
         TBjrzVz+5tMAQd/rnNKI43ebYbMy9gv/RMR058K0GwBs0kis6Ca9WwFFKLZajunWpuKa
         Q8SliCxbuLzFClSwuu3EYYHqRMdxqCw7Hhn9F7euMV+kTuMCNv2GqKo+Y4sZ39Nv/a6v
         PMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470005; x=1701074805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FNYhRa/kTA6OUz1GxKxTdj30g/SDXO/leUXkzzIoxw=;
        b=pww4xZ286g+EvsJqAQlH9G+ew4HbXNHqWhkwNQ+Mi1mRr6bLCateaRlte0zgH8DcUZ
         jlJluauE4prJUf3oTvK3DT7rUdeB+VawlLEvcI2kkZjQQQzMpij1m+9mXEuWnWF1ztuq
         LaPcgxHN9P4dS8mFi18PhL+egvYCOlU2AP2lc4a8pfYS9vHU39IR4kpbj0IxOo45H/J0
         1N2KbmCIlHwOmqd4J3ZDu/ehDm/ZdcIc9GShSwtG/DglxlcYo/wU4caeDfeOhtdGuA2L
         7WYWooM7R2+VAMdDSeQwPWu7pocw4T8fxUwaszYfIxnxbHZnycwc6krW9h0M2Zjdsvzv
         hl5g==
X-Gm-Message-State: AOJu0YwzSNvCYI+EABe9atUw5wGFCOVI/wnyzq4dK1K4rD/389tAEo8j
        BUIDvU6Pf8XILRc3b3cb7e0il0tMR8LeFRgQgQQ=
X-Google-Smtp-Source: AGHT+IHtxPlpXQ4BayjBdJJbq3iQegNvuqGSMbNIEngr6vOZDv3NmG/e15q/dsXWFZlOZoNSSCnIIQ==
X-Received: by 2002:a05:6512:208:b0:509:75b8:637b with SMTP id a8-20020a056512020800b0050975b8637bmr5013308lfo.30.1700470005365;
        Mon, 20 Nov 2023 00:46:45 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:45 -0800 (PST)
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
Subject: [PATCH 13/13] net: ravb: Add runtime PM support
Date:   Mon, 20 Nov 2023 10:46:06 +0200
Message-Id: <20231120084606.4083194-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

RZ/G3S supports enabling/disabling clocks for its modules (including
Ethernet module). For this commit adds runtime PM support which
relies on PM domain to enable/disable Ethernet clocks.

At the end of probe ravb_pm_runtime_put() is called which will turn
off the Ethernet clocks (if no other request arrives at the driver).
After that if the interface is brought up (though ravb_open()) then
the clocks remain enabled until interface is brought down (operation
done though ravb_close()).

If any request arrives to the driver while the interface is down the
clocks are enabled to serve the request and then disabled.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c | 99 ++++++++++++++++++++++--
 2 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index c2d8d890031f..50f358472aab 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1044,6 +1044,7 @@ struct ravb_hw_info {
 	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
 	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
 	unsigned refclk_in_pd:1;	/* Reference clock is part of a power domain. */
+	unsigned rpm:1;			/* Runtime PM available. */
 };
 
 struct ravb_private {
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index f4634ac0c972..d70ed7e5f7f6 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -145,12 +145,41 @@ static void ravb_read_mac_address(struct device_node *np,
 	}
 }
 
+static int ravb_pm_runtime_get(struct ravb_private *priv)
+{
+	const struct ravb_hw_info *info = priv->info;
+
+	if (!info->rpm)
+		return 0;
+
+	return pm_runtime_resume_and_get(&priv->pdev->dev);
+}
+
+static void ravb_pm_runtime_put(struct ravb_private *priv)
+{
+	const struct ravb_hw_info *info = priv->info;
+	struct device *dev = &priv->pdev->dev;
+
+	if (!info->rpm)
+		return;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+}
+
 static void ravb_mdio_ctrl(struct mdiobb_ctrl *ctrl, u32 mask, int set)
 {
 	struct ravb_private *priv = container_of(ctrl, struct ravb_private,
 						 mdiobb);
+	int ret;
+
+	ret = ravb_pm_runtime_get(priv);
+	if (ret < 0)
+		return;
 
 	ravb_modify(priv->ndev, PIR, mask, set ? mask : 0);
+
+	ravb_pm_runtime_put(priv);
 }
 
 /* MDC pin control */
@@ -176,8 +205,17 @@ static int ravb_get_mdio_data(struct mdiobb_ctrl *ctrl)
 {
 	struct ravb_private *priv = container_of(ctrl, struct ravb_private,
 						 mdiobb);
+	int ret;
 
-	return (ravb_read(priv->ndev, PIR) & PIR_MDI) != 0;
+	ret = ravb_pm_runtime_get(priv);
+	if (ret < 0)
+		return ret;
+
+	ret = (ravb_read(priv->ndev, PIR) & PIR_MDI) != 0;
+
+	ravb_pm_runtime_put(priv);
+
+	return ret;
 }
 
 /* MDIO bus control struct */
@@ -1796,10 +1834,14 @@ static int ravb_open(struct net_device *ndev)
 		}
 	}
 
+	error = ravb_pm_runtime_get(priv);
+	if (error < 0)
+		return error;
+
 	/* Device init */
 	error = ravb_dmac_init(ndev);
 	if (error)
-		goto out_free_irq_mgmta;
+		goto pm_runtime_put;
 	ravb_emac_init(ndev);
 
 	/* Initialise PTP Clock driver */
@@ -1820,7 +1862,8 @@ static int ravb_open(struct net_device *ndev)
 	if (info->gptp)
 		ravb_ptp_stop(ndev);
 	ravb_stop_dma(ndev);
-out_free_irq_mgmta:
+pm_runtime_put:
+	ravb_pm_runtime_put(priv);
 	if (!info->multi_irqs)
 		goto out_free_irq;
 	if (info->err_mgmt_irqs)
@@ -2064,6 +2107,11 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 	struct net_device_stats *nstats, *stats0, *stats1;
+	int ret;
+
+	ret = ravb_pm_runtime_get(priv);
+	if (ret < 0)
+		return NULL;
 
 	nstats = &ndev->stats;
 	stats0 = &priv->stats[RAVB_BE];
@@ -2107,6 +2155,8 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 		nstats->rx_over_errors += stats1->rx_over_errors;
 	}
 
+	ravb_pm_runtime_put(priv);
+
 	return nstats;
 }
 
@@ -2115,11 +2165,18 @@ static void ravb_set_rx_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	unsigned long flags;
+	int ret;
+
+	ret = ravb_pm_runtime_get(priv);
+	if (ret < 0)
+		return;
 
 	spin_lock_irqsave(&priv->lock, flags);
 	ravb_modify(ndev, ECMR, ECMR_PRM,
 		    ndev->flags & IFF_PROMISC ? ECMR_PRM : 0);
 	spin_unlock_irqrestore(&priv->lock, flags);
+
+	ravb_pm_runtime_put(priv);
 }
 
 /* Device close function for Ethernet AVB */
@@ -2187,6 +2244,11 @@ static int ravb_close(struct net_device *ndev)
 	if (info->nc_queues)
 		ravb_ring_free(ndev, RAVB_NC);
 
+	/* Note that if RPM is enabled on plaforms with ccc_gac=1 this needs to be skipped and
+	 * added to suspend function after PTP is stopped.
+	 */
+	ravb_pm_runtime_put(priv);
+
 	return 0;
 }
 
@@ -2503,6 +2565,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.carrier_counters = 1,
 	.half_duplex = 1,
 	.refclk_in_pd = 1,
+	.rpm = 1,
 };
 
 static const struct of_device_id ravb_match_table[] = {
@@ -2636,6 +2699,12 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
+	info = of_device_get_match_data(&pdev->dev);
+
+	if (info->rpm) {
+		pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
+		pm_runtime_use_autosuspend(&pdev->dev);
+	}
 	pm_runtime_enable(&pdev->dev);
 	error = pm_runtime_resume_and_get(&pdev->dev);
 	if (error < 0)
@@ -2647,7 +2716,6 @@ static int ravb_probe(struct platform_device *pdev)
 		error = -ENOMEM;
 		goto pm_runtime_put;
 	}
-	info = of_device_get_match_data(&pdev->dev);
 
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
@@ -2856,6 +2924,8 @@ static int ravb_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ndev);
 
+	ravb_pm_runtime_put(priv);
+
 	return 0;
 
 out_napi_del:
@@ -2880,6 +2950,8 @@ static int ravb_probe(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 pm_runtime_disable:
 	pm_runtime_disable(&pdev->dev);
+	if (info->rpm)
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	reset_control_assert(rstc);
 	return error;
 }
@@ -2889,6 +2961,11 @@ static void ravb_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int error;
+
+	error = ravb_pm_runtime_get(priv);
+	if (error < 0)
+		return;
 
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
@@ -2908,6 +2985,8 @@ static void ravb_remove(struct platform_device *pdev)
 			  priv->desc_bat_dma);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	if (info->rpm)
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
 	platform_set_drvdata(pdev, NULL);
@@ -2989,6 +3068,10 @@ static int ravb_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = ravb_pm_runtime_get(priv);
+	if (ret < 0)
+		return ret;
+
 	/* If WoL is enabled set reset mode to rearm the WoL logic */
 	if (priv->wol_enabled)
 		ravb_write(ndev, CCC_OPC_RESET, CCC);
@@ -3005,7 +3088,7 @@ static int ravb_resume(struct device *dev)
 		/* Set GTI value */
 		ret = ravb_set_gti(ndev);
 		if (ret)
-			return ret;
+			goto pm_runtime_put;
 
 		/* Request GTI loading */
 		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
@@ -3024,15 +3107,17 @@ static int ravb_resume(struct device *dev)
 		if (priv->wol_enabled) {
 			ret = ravb_wol_restore(ndev);
 			if (ret)
-				return ret;
+				goto pm_runtime_put;
 		}
 		ret = ravb_open(ndev);
 		if (ret < 0)
-			return ret;
+			goto pm_runtime_put;
 		ravb_set_rx_mode(ndev);
 		netif_device_attach(ndev);
 	}
 
+pm_runtime_put:
+	ravb_pm_runtime_put(priv);
 	return ret;
 }
 
-- 
2.39.2

