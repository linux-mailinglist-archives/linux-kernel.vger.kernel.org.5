Return-Path: <linux-kernel+bounces-49489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B91846B06
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDA41C25A6A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF5F65BDE;
	Fri,  2 Feb 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kfelr1Xa"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC0E63113
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863328; cv=none; b=VpD4n5T5TKIT+ZSsYkWWGWbVAvMyq6knPKvIhRH6BAw+7ivl9H2A1MK8jA+hWk6Dt/v5EeGuwKlMdxzFNZIqxGuqCYKvsRF0UFmxhc79y1BRrIh8gpFHG501hRlrVFsUil7Ou4ndLz4Enn5pjbV26gALHmN9PVrrbeCP/XuwqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863328; c=relaxed/simple;
	bh=DK+aebRHFc2djoDWx6C3/OPosBYtMm2nVYmwfnXH2pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZBQydobxeOlF9+WB5AVb3ZQIAAgXShFEjLn7p+PSQRCRAeJgnuQQkiA7u/hW3zBWKFDlU25YvEPsPafu/gYaEPkjmO6yFj89KqTUy4EsnPrGsEB4g079+6QCWTUXY54ezNbpn1KIFU7EkxDkGUrbKCa4mZAHRjKcez2cVUCOVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kfelr1Xa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a354408e6bfso501196866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706863324; x=1707468124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2Tq0xany9i7GthfvOVG1vhvIi7DmAmdzJEMumk66i0=;
        b=kfelr1XaOM80lyQTyp/q69RW3i2k/Sz37AH7JsdtvGaUhy8jJWGr1ywhtxIuVmC4Li
         Vnd9iwaF6sSqqZaNMqkhp6ULD1MBnisSqx1eH/wXaMK56Za5NE4gGae0eZRxdE3L2FJI
         T0WmYCvzhlbrgrU/gdvfyiiHBZL3uJhJNkKKdd0tO7eW0GyMmffL7G/Rf2sATLSfld2P
         N5XoFe19ij1Esgknf95JJge8ZjOLyo/IYLzjkpnYH6ghI/NMdc847GtB8EEOsRGZbHY3
         Ipkcqg+7dVgYxDG25O/AGK940qbspgzaL/wnSUxJiF9mbtAvc1BAihTvwKaf5mnY8fLI
         8BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863324; x=1707468124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2Tq0xany9i7GthfvOVG1vhvIi7DmAmdzJEMumk66i0=;
        b=YE3PpLdZuAnlfj9W5VTOLVeWNenHLA8VKPX9Z5Js3Rc3x4Xu7SHBNzEbPv5QUhA474
         vrF0X1wjhTawHjti1E+EheDmISm1jhE5yb5nF1/hZHfkzsThstvAWMLcegxdjCaQbzoa
         kIq3yLoDgcGyDTqIFEap3tX18iUovg5ojJ8zs4iTGNk51AkARo+mS28iOgi+YAsWHrEn
         TouHjC0WepTa1FTNqe5HOhoVALEX3qhZv8fdA0RzPPjxDo8NVIoeZjUDOhjEmKLuqR9H
         qKG730cjIe83HFlfDNyVCSWfsasAjVEUondVuDASPHo6iY7faggEO0cSfWPg2gAQn9KP
         XF8Q==
X-Gm-Message-State: AOJu0Yy+lt8LcU33rfgHhE7fsr+/00cf0rOpiCicdn0Qk3CZeeZHlnuD
	eFTOe3aWEEvGmUscre+RVrPwz0HULdQdEt5Q+GZU9aYB/chuu99yZEstwfiRd3c=
X-Google-Smtp-Source: AGHT+IGgORQwf+B8SZkAnda4eDafc9eXIiDw5bDRirPguLcewqDWQaOb7E8l7gUAWE/kf//HZmNMGQ==
X-Received: by 2002:a17:906:3c05:b0:a35:278:1c23 with SMTP id h5-20020a1709063c0500b00a3502781c23mr1053131ejg.35.1706863324517;
        Fri, 02 Feb 2024 00:42:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVk4gsRxArIg1NllHvFeuzJ5O9drz4PYfwdz5GkYCYSiX8HyRl1OHHo5LY1qzLK2G/bDGPHmNa+t44xzpyGl4UB4GZ2LASlODtV2K8rERDarEnKc7f8PXxsruDVta/6lUQluwb2CJYBlVassa9fndHNM7NcJVrs4rEwIGqLoDJYX2ztX7HIhC96Ir0tXxmNdubvGhFMRzZNuZsK0nXl48ZAxNeNM/mdq4X3fXzqtCq7xOjhALnCY9JwrqEBlWnDxWJEyXfkd9C5wr68sLI2LH/NQqENsW0/Nlw56hPQC1hXdgWzPZGiC/ZzpEAv3kHjQ7l+eB8WW12B/i35j1tQNQbDW1B0rLxkvtxgZjHON3ipUmYrZnurz+NGDpnDuQuMUSYlC64tjWl6nITkgg==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id oz35-20020a1709077da300b00a361c1375absm631642ejc.133.2024.02.02.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:42:03 -0800 (PST)
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
Subject: [PATCH net-next v6 07/15] net: ravb: Move reference clock enable/disable on runtime PM APIs
Date: Fri,  2 Feb 2024 10:41:28 +0200
Message-Id: <20240202084136.3426492-8-claudiu.beznea.uj@bp.renesas.com>
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

Reference clock could be or not be part of the power domain. If it is part
of the power domain, the power domain takes care of properly setting it. In
case it is not part of the power domain and full runtime PM support is
available in driver the clock will not be propertly disabled/enabled at
runtime. For this, keep the prepare/unprepare operations in the driver's
probe()/remove() functions and move the enable/disable in runtime PM
functions.

By doing this, the previous ravb_runtime_nop() function was renamed
ravb_runtime_suspend() and the comment was removed. A proper runtime PM
resume function was added (ravb_runtime_resume()). The current driver
still don't need to make any register settings on runtime suspend/resume
(as expressed in the removed comment) because, currently,
pm_runtime_put_sync() is called on the driver remove function. This will be
changed in the next commits (that extends the runtime PM support) such
that proper register settings (along with runtime resume/suspend) will be
done on ravb_open()/ravb_close().

Along with it, the other clock request operations were moved close to
reference clock request and prepare to have all the clock requests
specific code grouped together.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v6:
- re-arranged the tags as my b4 am/shazam placed the Rb tags
  before author's Sob tag

Changes in v5:
- fixed typos in patch description
- improved patch description

Changes in v4:
- dropped tag

Changes in v3:
- squashed with patch 17/21 ("net: ravb: Keep clock request operations grouped
  together") from v2
- collected tags

Changes in v2:
- this patch is new and follows the recommendations proposed in the
  discussion of patch 08/13 ("net: ravb: Rely on PM domain to enable refclk")
  from v2
  
 drivers/net/ethernet/renesas/ravb_main.c | 110 ++++++++++++-----------
 1 file changed, 57 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c2b65bdad13c..e70c930840ce 100644
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
 
@@ -2697,10 +2692,37 @@ static int ravb_probe(struct platform_device *pdev)
 		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
 	}
 
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		error = PTR_ERR(priv->clk);
+		goto out_reset_assert;
+	}
+
+	if (info->gptp_ref_clk) {
+		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
+		if (IS_ERR(priv->gptp_clk)) {
+			error = PTR_ERR(priv->gptp_clk);
+			goto out_reset_assert;
+		}
+	}
+
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
@@ -2711,7 +2733,7 @@ static int ravb_probe(struct platform_device *pdev)
 
 	error = of_get_phy_mode(np, &priv->phy_interface);
 	if (error && error != -ENODEV)
-		goto out_release;
+		goto out_rpm_put;
 
 	priv->no_avb_link = of_property_read_bool(np, "renesas,no-ether-link");
 	priv->avb_link_active_low =
@@ -2724,14 +2746,14 @@ static int ravb_probe(struct platform_device *pdev)
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
@@ -2739,7 +2761,7 @@ static int ravb_probe(struct platform_device *pdev)
 			irq = platform_get_irq_byname(pdev, ravb_tx_irqs[i]);
 			if (irq < 0) {
 				error = irq;
-				goto out_release;
+				goto out_rpm_put;
 			}
 			priv->tx_irqs[i] = irq;
 		}
@@ -2748,40 +2770,19 @@ static int ravb_probe(struct platform_device *pdev)
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
 	}
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		error = PTR_ERR(priv->clk);
-		goto out_release;
-	}
-
-	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
-	if (IS_ERR(priv->refclk)) {
-		error = PTR_ERR(priv->refclk);
-		goto out_release;
-	}
-	clk_prepare_enable(priv->refclk);
-
-	if (info->gptp_ref_clk) {
-		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
-		if (IS_ERR(priv->gptp_clk)) {
-			error = PTR_ERR(priv->gptp_clk);
-			goto out_disable_refclk;
-		}
-	}
-
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
 	ndev->min_mtu = ETH_MIN_MTU;
 
@@ -2799,13 +2800,13 @@ static int ravb_probe(struct platform_device *pdev)
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
@@ -2825,7 +2826,7 @@ static int ravb_probe(struct platform_device *pdev)
 			"Cannot allocate desc base address table (size %d bytes)\n",
 			priv->desc_bat_size);
 		error = -ENOMEM;
-		goto out_disable_refclk;
+		goto out_rpm_put;
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
@@ -2871,8 +2872,6 @@ static int ravb_probe(struct platform_device *pdev)
 	netdev_info(ndev, "Base address at %#x, %pM, IRQ %d.\n",
 		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
 
-	platform_set_drvdata(pdev, ndev);
-
 	return 0;
 
 out_napi_del:
@@ -2888,12 +2887,12 @@ static int ravb_probe(struct platform_device *pdev)
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
@@ -2922,10 +2921,9 @@ static void ravb_remove(struct platform_device *pdev)
 
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
 
-	clk_disable_unprepare(priv->refclk);
-
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(priv->refclk);
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
 	platform_set_drvdata(pdev, NULL);
@@ -3060,21 +3058,27 @@ static int ravb_resume(struct device *dev)
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


