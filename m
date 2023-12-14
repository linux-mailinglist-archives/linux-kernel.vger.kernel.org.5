Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A57812F27
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444258AbjLNLq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444181AbjLNLqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:46:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4508E197
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:30 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c5ed26cf6so10160414a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554389; x=1703159189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urXQcBC1I2HSJadX/7B8vUlbLmboqpTqecwWwz/bPS4=;
        b=ZuGXB+eSIGZ4T0x03M35t+rn/f90z0mV8KJz/OtKj2skFSxpKG6woHKXRvYr257RXf
         O4D9wFhs9dTFtsakOMBIu4aYV3ZFq6BHhYzP/qRalWr7KeeI7tuHsJdFatmnrex6RWHw
         kq5rlD+8q8DdLJgx6fzPk0Sh9Xq3jCCxuSDqiBOJDhHalVt+tvZE/mp5DoUyYbrKYVMj
         KVw+FX2WMBxogAbAO5WRRTK+COsfQxYC0ab/fI65/Yz1IYsLsnjVkR3sox3PdS6Mmq6s
         Hcl9VHghyTr9PgAMEDfVZFYgedOHQz7db+B3xdeAozAXhl8bCeh/hkZoOpjzYmALnLRv
         kFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554389; x=1703159189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urXQcBC1I2HSJadX/7B8vUlbLmboqpTqecwWwz/bPS4=;
        b=Su1gEz+IQyuzX9WG+ZsyNoK0CgSY+7WKs+GdbKM0dUpgdF5gqINIsRPVe0ZCSnUIzt
         YbYqWmXaUCdToi4QGLetqoGNAE/Un+ZASHOX4W21mprFsDGu7ATIa6BLMyAyAdNxKbJJ
         SCtjyVGsjf5OvH4anmMeyXnKpwb8X/wVqmI2CDk0igEUGIBcRPKBGNp4qHQ/F04x4pvc
         GOlU3ZLzbuXDo1dNWGRq5JAPaicOyjxhJyl9G5R1I3AmuSAr3dRsv4CyqqO3mvj5ovGk
         FiS0Zgzl46F1+oI3Ck7xoekvavHiRjHICss+Cdb+GC4k18FAjYHcYf95/YIsqPefzDLS
         P94Q==
X-Gm-Message-State: AOJu0Yzrr2039+70OhLZod4G3ULJU9OfcqipAcmm9gy0P6NwiHeOnOqJ
        JdMXP+S76RkE7CkA/8ytJcJhmg==
X-Google-Smtp-Source: AGHT+IEqGQoFBiFfzfK3jqMrNe9KA/tUQ/OOWSMGUcII2taRF+pt0OygGdcB8qR+fZU+qYveelsr+w==
X-Received: by 2002:a17:906:5a49:b0:a1e:86c2:dccd with SMTP id my9-20020a1709065a4900b00a1e86c2dccdmr4714486ejc.14.1702554389543;
        Thu, 14 Dec 2023 03:46:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:29 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 07/21] net: ravb: Move reference clock enable/disable on runtime PM APIs
Date:   Thu, 14 Dec 2023 13:45:46 +0200
Message-Id: <20231214114600.2451162-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
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

Reference clock could be or not part of the power domain. If it is part of
the power domain, the power domain takes care of propertly setting it. In
case it is not part of the power domain and full runtime PM support is
available in driver the clock will not be propertly disabled/enabled at
runtime. For this, keep the prepare/unprepare operations in the driver's
probe()/remove() functions and move the enable/disable in runtime PM
functions.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- this patch is new and follows the recommendations proposed in the
  discussion of patch 08/13 ("net: ravb: Rely on PM domain to enable refclk")
  from v2

 drivers/net/ethernet/renesas/ravb_main.c | 88 +++++++++++++-----------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 9a618d8dbfcd..83691a0f0cc2 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2664,11 +2664,6 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		goto out_free_netdev;
 
-	pm_runtime_enable(&pdev->dev);
-	error = pm_runtime_resume_and_get(&pdev->dev);
-	if (error < 0)
-		goto out_rpm_disable;
-
 	if (info->multi_irqs) {
 		if (info->err_mgmt_irqs)
 			irq = platform_get_irq_byname(pdev, "dia");
@@ -2679,7 +2674,7 @@ static int ravb_probe(struct platform_device *pdev)
 	}
 	if (irq < 0) {
 		error = irq;
-		goto out_release;
+		goto out_reset_assert;
 	}
 	ndev->irq = irq;
 
@@ -2697,10 +2692,23 @@ static int ravb_probe(struct platform_device *pdev)
 		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
 	}
 
+	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
+	if (IS_ERR(priv->refclk)) {
+		error = PTR_ERR(priv->refclk);
+		goto out_reset_assert;
+	}
+	clk_prepare(priv->refclk);
+
+	platform_set_drvdata(pdev, ndev);
+	pm_runtime_enable(&pdev->dev);
+	error = pm_runtime_resume_and_get(&pdev->dev);
+	if (error < 0)
+		goto out_rpm_disable;
+
 	priv->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->addr)) {
 		error = PTR_ERR(priv->addr);
-		goto out_release;
+		goto out_rpm_put;
 	}
 
 	/* The Ether-specific entries in the device structure. */
@@ -2711,7 +2719,7 @@ static int ravb_probe(struct platform_device *pdev)
 
 	error = of_get_phy_mode(np, &priv->phy_interface);
 	if (error && error != -ENODEV)
-		goto out_release;
+		goto out_rpm_put;
 
 	priv->no_avb_link = of_property_read_bool(np, "renesas,no-ether-link");
 	priv->avb_link_active_low =
@@ -2724,14 +2732,14 @@ static int ravb_probe(struct platform_device *pdev)
 			irq = platform_get_irq_byname(pdev, "ch24");
 		if (irq < 0) {
 			error = irq;
-			goto out_release;
+			goto out_rpm_put;
 		}
 		priv->emac_irq = irq;
 		for (i = 0; i < NUM_RX_QUEUE; i++) {
 			irq = platform_get_irq_byname(pdev, ravb_rx_irqs[i]);
 			if (irq < 0) {
 				error = irq;
-				goto out_release;
+				goto out_rpm_put;
 			}
 			priv->rx_irqs[i] = irq;
 		}
@@ -2739,7 +2747,7 @@ static int ravb_probe(struct platform_device *pdev)
 			irq = platform_get_irq_byname(pdev, ravb_tx_irqs[i]);
 			if (irq < 0) {
 				error = irq;
-				goto out_release;
+				goto out_rpm_put;
 			}
 			priv->tx_irqs[i] = irq;
 		}
@@ -2748,14 +2756,14 @@ static int ravb_probe(struct platform_device *pdev)
 			irq = platform_get_irq_byname(pdev, "err_a");
 			if (irq < 0) {
 				error = irq;
-				goto out_release;
+				goto out_rpm_put;
 			}
 			priv->erra_irq = irq;
 
 			irq = platform_get_irq_byname(pdev, "mgmt_a");
 			if (irq < 0) {
 				error = irq;
-				goto out_release;
+				goto out_rpm_put;
 			}
 			priv->mgmta_irq = irq;
 		}
@@ -2764,21 +2772,14 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		error = PTR_ERR(priv->clk);
-		goto out_release;
+		goto out_rpm_put;
 	}
 
-	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
-	if (IS_ERR(priv->refclk)) {
-		error = PTR_ERR(priv->refclk);
-		goto out_release;
-	}
-	clk_prepare_enable(priv->refclk);
-
 	if (info->gptp_ref_clk) {
 		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
 		if (IS_ERR(priv->gptp_clk)) {
 			error = PTR_ERR(priv->gptp_clk);
-			goto out_disable_refclk;
+			goto out_rpm_put;
 		}
 	}
 
@@ -2799,20 +2800,20 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Set AVB config mode */
 	error = ravb_set_config_mode(ndev);
 	if (error)
-		goto out_disable_refclk;
+		goto out_rpm_put;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
 		error = ravb_set_gti(ndev);
 		if (error)
-			goto out_disable_refclk;
+			goto out_rpm_put;
 
 		/* Request GTI loading */
 		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
 		/* Check completion status. */
 		error = ravb_wait(ndev, GCCR, GCCR_LTI, 0);
 		if (error)
-			goto out_disable_refclk;
+			goto out_rpm_put;
 	}
 
 	if (info->internal_delay) {
@@ -2829,7 +2830,7 @@ static int ravb_probe(struct platform_device *pdev)
 			"Cannot allocate desc base address table (size %d bytes)\n",
 			priv->desc_bat_size);
 		error = -ENOMEM;
-		goto out_disable_refclk;
+		goto out_rpm_put;
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
@@ -2875,8 +2876,6 @@ static int ravb_probe(struct platform_device *pdev)
 	netdev_info(ndev, "Base address at %#x, %pM, IRQ %d.\n",
 		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
 
-	platform_set_drvdata(pdev, ndev);
-
 	return 0;
 
 out_napi_del:
@@ -2892,12 +2891,12 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
-out_disable_refclk:
-	clk_disable_unprepare(priv->refclk);
-out_release:
+out_rpm_put:
 	pm_runtime_put(&pdev->dev);
 out_rpm_disable:
 	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(priv->refclk);
+out_reset_assert:
 	reset_control_assert(rstc);
 out_free_netdev:
 	free_netdev(ndev);
@@ -2929,10 +2928,9 @@ static void ravb_remove(struct platform_device *pdev)
 	if (error)
 		netdev_err(ndev, "Failed to reset ndev\n");
 
-	clk_disable_unprepare(priv->refclk);
-
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(priv->refclk);
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
 	platform_set_drvdata(pdev, NULL);
@@ -3071,21 +3069,27 @@ static int ravb_resume(struct device *dev)
 	return ret;
 }
 
-static int ravb_runtime_nop(struct device *dev)
+static int ravb_runtime_suspend(struct device *dev)
 {
-	/* Runtime PM callback shared between ->runtime_suspend()
-	 * and ->runtime_resume(). Simply returns success.
-	 *
-	 * This driver re-initializes all registers after
-	 * pm_runtime_get_sync() anyway so there is no need
-	 * to save and restore registers here.
-	 */
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	clk_disable(priv->refclk);
+
 	return 0;
 }
 
+static int ravb_runtime_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	return clk_enable(priv->refclk);
+}
+
 static const struct dev_pm_ops ravb_dev_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
-	RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
+	RUNTIME_PM_OPS(ravb_runtime_suspend, ravb_runtime_resume, NULL)
 };
 
 static struct platform_driver ravb_driver = {
-- 
2.39.2

