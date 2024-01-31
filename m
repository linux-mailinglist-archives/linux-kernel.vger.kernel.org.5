Return-Path: <linux-kernel+bounces-46027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560F843978
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B96282B56
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D2274E13;
	Wed, 31 Jan 2024 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fZ1HZKrF"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F069DE1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690520; cv=none; b=Fia/nGY0h9zokaO7LHJqQXDx5Dmrt6qxNpRJ5rliKBrDfYpY0q7n6r3SBI0fIiID2WRCLj4Q7Fldr+evRWJRRugWjj2witcm0qKgpbzWmu9nzWKmPoFJU7Ig5+HHDdrQUKKf9BWOIaHO7G5TWTJWABUn/n7LrhEYsuGo2Dd+/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690520; c=relaxed/simple;
	bh=Is0c9bbZxCn+5Ie2CiggMb3E43fx7P0CqT2K/j3UZX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NdSjMT1TPPEjPDarA7Pi6iirA+hftqN81yjo5QroxEMaihlH0ZJZCp8DemkX//fyME00+aO9fQ+wxuPV+D28nUm+nI08eSWUSot46N1hKVbZ5oDW95g26gcv39Pu82amgomsGptMu6CaZhjjD47pwBaYKO5F0H76huiDhISP7tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fZ1HZKrF; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d057003864so23610141fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706690515; x=1707295315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21CiIC3Re4xYSF3pmN76UhVGc5ntYa8GN7cTx6QHvzc=;
        b=fZ1HZKrF6wjrxPmHlDwh8Yu8NQ6C2EOmqwg6TLeBI5gCW7vJSGs7m8jAZ5/mumcxct
         CoXERaBM8qFYaAe7b7yZv3cOnIS1gPewhgA+b/xaqkflqtu3sQ3uhHskQFv+ovsE1ioC
         rzNpYk5S9LGiszOzYjPCR2uCnVOIxBalQBNTj8mzOVfWHQjK8jm790RURKYlklXgIwmJ
         o83ecksGHfPfEneQzp5RHckoOG1xlMsUBkgSUPzqLfTNbNpJ5AmhX7qxi83MfOVUl6Sa
         R5GASdgPfznSaV80yDw4mRMvLm0cRQlzydDuSLp461olZgKlvI8s+jhw0L1rFv1E9g8d
         qnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706690515; x=1707295315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21CiIC3Re4xYSF3pmN76UhVGc5ntYa8GN7cTx6QHvzc=;
        b=JLjHRoblxbM5olWpU1U4tcL3MrUDYAilwHFOO94Xr0DRS/8xHriieJgWUSbX72ZaJ3
         iOcUl3PoXLu4AWxjsl9AfzevHc+UjMENLX9omtDBWvktQmsv/3ghHMskqiOgNDQPnlHn
         JRFPwpTWQ2QBx9yiYywIAaHvlhAZ1nn4vic2qRvTODNaS66y7OHzaI0Ku5K/+QF9KcTN
         YliWxys90kNBJ52wAKPW7lxNsOoHizn6LDZxKffEhxCDDVGxlciYGXU1DpI2xyiF0ifa
         PxkNnVemHemZsUjQjeAjmLFwyY/zaYQ+F4FvgzmS+RXzPejTBswtw3hh7+oId8xHJGXG
         sojw==
X-Gm-Message-State: AOJu0Yy9wSzj9K+OpW0ZrAmna44hj8QPrg8gv4tH/aVTtOsmR+EKecEZ
	kJAf7vpFv1CDrK9g7PsMpXdNlLaML8lNNWsulTy0VUynm6A/tUD/EGRgfrtGkCQ=
X-Google-Smtp-Source: AGHT+IFtQU8M/3t+PU68pmwF9qXrG+6DN+Ca+1ziZ/MUajC/pTFxMvAg1cQRYLPHX8Fg47+RY7XCog==
X-Received: by 2002:a2e:b6cc:0:b0:2d0:55ce:63d5 with SMTP id m12-20020a2eb6cc000000b002d055ce63d5mr610639ljo.26.1706690515351;
        Wed, 31 Jan 2024 00:41:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXwbCelHuuEVd3jkGZb91vi+k/bn3K+Yms81FHit1cGJUnzwVUyxYoq66cNIuG/rUtYFlNfAMKT7n9kknSc4xE6jYnTRyVd75kU6uBLq4Z2Z95QyP31acE5kUc+8JfNHo1GfDHiglw3WbJtxXUjmUTJCemcGldFrzfRUdls+JkT6Gv8lLhIi5S+llfUFuhM9jbbq927RoMqY2ad3dQyAUtw74xrLFS3tNqIA6ApsBi28snEtGohHg7q9d5qwvwiSemZ8ppqEOIsMZbhqviFSk1g/XlO7JvngE7UV29FHolXlF9uOIWKTDpzaaUZPU2Hnnn/s0lj8W8lPSfH9InHfnRJo/BYys8T+4nqrWZ/rpj7wS68n6rJn0KhqzZA7qEBF4dKEgiupZxLtIaFptXTE4VRuRlbQClNLkUYCQBKJymDuaURtxQ=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0055f02661ae2sm2863630edb.78.2024.01.31.00.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:41:55 -0800 (PST)
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
Subject: [PATCH net-next v5 07/15] net: ravb: Move reference clock enable/disable on runtime PM APIs
Date: Wed, 31 Jan 2024 10:41:25 +0200
Message-Id: <20240131084133.1671440-8-claudiu.beznea.uj@bp.renesas.com>
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
---

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


