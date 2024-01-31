Return-Path: <linux-kernel+bounces-46028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0174B843983
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850991F233A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB0768EE;
	Wed, 31 Jan 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="arSeRwQA"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C666A000
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690520; cv=none; b=f7cL8RNxxWF2pxwlJIpT/n9S55cnlv1Q1oep9quhzck+5R9b1Ur2BRMRbJrVm2j1Mhg4ooFdicT7SUZOUjNw5xaZlCOF/fqPZAiW7AUbEUYp6bM/iSKUI/KHyuZ0W86ebGATZYFOBlhzYQREHTkyZ4vxIHlRY3jQP26MkiP5+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690520; c=relaxed/simple;
	bh=QKsaxl/aFv8oOhCIua/6fEkDbbYuv+jcvdH2AyGnVVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/u5wZtxkrT/cRmtYgykn/Cg28Q2aaw3zJy+9woSOVBeJ8j7MRE4nedDWqGTNWmm+M/JonnppOdP+DsAn1GIAEPNUqdwyxSFT/V7e3cFpgNuJzxreSR8q9Ppf/QNEP+z42NXVjNDKrbDf0Q3zZ0AMuJvsW3SMMuk74zIf9TOce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=arSeRwQA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so3454974a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706690517; x=1707295317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HT91HA0cf438KLXCFqahgOuGomP/5XEuDd167bXOWFI=;
        b=arSeRwQAWDfFBao6dO3MQMv+W5rq13NSIQmlBemDnXlPzudSlNZs7V+fRVDjdJ6+v1
         DSCXVDTyQogmTzmOxQyAYgANWbP5UZrRbI90BUqBJVmpnaycrv3l+hcP3i1cUxTuW21W
         9LOAeIm4bdCNtakdPESr0w3OPNBGngsCrEHbwjO8qrD35qR6ZpsnWWLLNJjP6m+rUnTh
         faIrygzc8UdCxsWzJE8bbzo8HzysLaLw+LO+BS5smgtEBl1GseQxFMGa9WAH+ZlF7Btb
         /ejIe9AGG1ymzyJchx+To8/KMI56qoYcoFIABLtoZbqqx8DuXWGkz+H+6kLjxBAjEmTi
         zwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706690517; x=1707295317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HT91HA0cf438KLXCFqahgOuGomP/5XEuDd167bXOWFI=;
        b=wdRoAq10xrFhf2i66YowC0fbiUaxCREZbusFT0+61A7hleJnsqTUe2GEUYogs2nVG0
         l3tL7XcPTkgGIdEFvxddwlT/qGR+vUXOLoi6zPsjBeuIMEXbYs7/tOzqfOg0Z/yQoa1j
         /8PbJCWItWCSz7LaCRviei2O6/ng20g350NUYmI/krrTOhdjgUj3Ss/nfxBtDeMeqipi
         GfJRCMgjpYAUbqeAsJRcMKRlTgC6F9YkecCVcXZowulSa17XmtZHEq8fYqpLeRJvZ1tm
         rV2no6ix+lyR4pqnVjYvKO8WrezE776t46QdyOhLbsPCo01VYcRBf9fYZGpfDHlV4r9N
         6ctA==
X-Gm-Message-State: AOJu0Yyn+8y5te25RacNIcp/HUz8XFG2xkV2kxZneujMReWT9WnLl6CB
	rRo/uNcB2IOjpQX6VSLG7N99b8FfmYLLBiQXANbq01LwYRIErOCBcbDqd8UghmU=
X-Google-Smtp-Source: AGHT+IHz4jM9YV0tyExIajncKLJJwTdV5FdYPy0I/q8ACdh5o71eFuZDrmPXnfakfk+/XYwqtCi50A==
X-Received: by 2002:a05:6402:3121:b0:55c:8ab7:9446 with SMTP id dd1-20020a056402312100b0055c8ab79446mr590513edb.7.1706690516842;
        Wed, 31 Jan 2024 00:41:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXkU2P0IBC/c0C7IoW0UHDa8fy4NBnUCcmfSDfxp53q4gjMbOhNjOPm5LREng0pRRpFhgilPWF/A465L7k33gucPgATMG3I3TFqXrtTR0JYLCCvOA3zPcLjZv5vseqGTDlrg2RzO4Au0pmZE45w1xEkPuod0MHIIysjTeDjNVku05232cr9Mao6cnkXCUZaTpmCKC2h8JdhO9tiC+k5NF+iYycORtK3CBJ4vHAe0wVGMX4CVcv5c59O1UajY/2Dj+2W44uf2Fryar3+jUdbeVQbrBUCE2n2LGplyqx/wIC6hdoi9PCy8U6mYOBFw238d9Cs43v01jSqj+eKs8NZ+2w1PRunQclGlhnyvNHhj8BeKP9gfvZzULDsNi6KutAF3D+WXwvmvaAOXnmvb05lGDz+rIwyUmrYThGTPT51jX32dzgXYME=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0055f02661ae2sm2863630edb.78.2024.01.31.00.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:41:56 -0800 (PST)
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
Subject: [PATCH net-next v5 08/15] net: ravb: Move the IRQs getting/requesting in the probe() method
Date: Wed, 31 Jan 2024 10:41:26 +0200
Message-Id: <20240131084133.1671440-9-claudiu.beznea.uj@bp.renesas.com>
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

The runtime PM implementation will disable clocks at the end of
ravb_probe(). As some IP variants switch to reset mode as a result of
setting module standby through clock disable APIs, to implement runtime PM
the resource parsing and requesting are moved in the probe function and IP
settings are moved in the open function. This is done because at the end of
the probe some IP variants will switch anyway to reset mode and the
registers content is lost. Also keeping only register settings operations
in the ravb_open()/ravb_close() functions will make them faster.

Commit moves IRQ requests to ravb_probe() to have all the IRQs ready when
the interface is open. As now IRQs getting/requesting are in a single place
there is no need to keep intermediary data (like ravb_rx_irqs[] and
ravb_tx_irqs[] arrays or IRQs in struct ravb_private).

In order to avoid accessing the IP registers while the IP is runtime
suspended (e.g. in the timeframe b/w the probe requests shared IRQs and
IP clocks are enabled) in the interrupt handlers were introduced
pm_runtime_active() checks. The device runtime PM usage counter has been
incremented to avoid disabling the device's clocks while the check is in
progress (if any).

This is a preparatory change to add runtime PM support for all IP variants.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- fixed typos in patch description
- collected tags

Changes in v4:
- use pm_runtime_active() in interrupt handlers
- addressed review comments

Changes in v3:
- fixed typos in patch description
- detailed patch description
- reworked the code to have a single function doing IRQ get and
  request

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb.h      |   4 -
 drivers/net/ethernet/renesas/ravb_main.c | 299 ++++++++++-------------
 2 files changed, 130 insertions(+), 173 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index e0f8276cffed..e3506888cca6 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1089,10 +1089,6 @@ struct ravb_private {
 	int msg_enable;
 	int speed;
 	int emac_irq;
-	int erra_irq;
-	int mgmta_irq;
-	int rx_irqs[NUM_RX_QUEUE];
-	int tx_irqs[NUM_TX_QUEUE];
 
 	unsigned no_avb_link:1;
 	unsigned avb_link_active_low:1;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e70c930840ce..f9297224e527 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -38,16 +38,6 @@
 		 NETIF_MSG_RX_ERR | \
 		 NETIF_MSG_TX_ERR)
 
-static const char *ravb_rx_irqs[NUM_RX_QUEUE] = {
-	"ch0", /* RAVB_BE */
-	"ch1", /* RAVB_NC */
-};
-
-static const char *ravb_tx_irqs[NUM_TX_QUEUE] = {
-	"ch18", /* RAVB_BE */
-	"ch19", /* RAVB_NC */
-};
-
 void ravb_modify(struct net_device *ndev, enum ravb_reg reg, u32 clear,
 		 u32 set)
 {
@@ -1092,11 +1082,23 @@ static irqreturn_t ravb_emac_interrupt(int irq, void *dev_id)
 {
 	struct net_device *ndev = dev_id;
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
+	irqreturn_t result = IRQ_HANDLED;
+
+	pm_runtime_get_noresume(dev);
+
+	if (unlikely(!pm_runtime_active(dev))) {
+		result = IRQ_NONE;
+		goto out_rpm_put;
+	}
 
 	spin_lock(&priv->lock);
 	ravb_emac_interrupt_unlocked(ndev);
 	spin_unlock(&priv->lock);
-	return IRQ_HANDLED;
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
+	return result;
 }
 
 /* Error interrupt handler */
@@ -1176,9 +1178,15 @@ static irqreturn_t ravb_interrupt(int irq, void *dev_id)
 	struct net_device *ndev = dev_id;
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	struct device *dev = &priv->pdev->dev;
 	irqreturn_t result = IRQ_NONE;
 	u32 iss;
 
+	pm_runtime_get_noresume(dev);
+
+	if (unlikely(!pm_runtime_active(dev)))
+		goto out_rpm_put;
+
 	spin_lock(&priv->lock);
 	/* Get interrupt status */
 	iss = ravb_read(ndev, ISS);
@@ -1222,6 +1230,9 @@ static irqreturn_t ravb_interrupt(int irq, void *dev_id)
 	}
 
 	spin_unlock(&priv->lock);
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 	return result;
 }
 
@@ -1230,9 +1241,15 @@ static irqreturn_t ravb_multi_interrupt(int irq, void *dev_id)
 {
 	struct net_device *ndev = dev_id;
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
 	irqreturn_t result = IRQ_NONE;
 	u32 iss;
 
+	pm_runtime_get_noresume(dev);
+
+	if (unlikely(!pm_runtime_active(dev)))
+		goto out_rpm_put;
+
 	spin_lock(&priv->lock);
 	/* Get interrupt status */
 	iss = ravb_read(ndev, ISS);
@@ -1254,6 +1271,9 @@ static irqreturn_t ravb_multi_interrupt(int irq, void *dev_id)
 	}
 
 	spin_unlock(&priv->lock);
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 	return result;
 }
 
@@ -1261,8 +1281,14 @@ static irqreturn_t ravb_dma_interrupt(int irq, void *dev_id, int q)
 {
 	struct net_device *ndev = dev_id;
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
 	irqreturn_t result = IRQ_NONE;
 
+	pm_runtime_get_noresume(dev);
+
+	if (unlikely(!pm_runtime_active(dev)))
+		goto out_rpm_put;
+
 	spin_lock(&priv->lock);
 
 	/* Network control/Best effort queue RX/TX */
@@ -1270,6 +1296,9 @@ static irqreturn_t ravb_dma_interrupt(int irq, void *dev_id, int q)
 		result = IRQ_HANDLED;
 
 	spin_unlock(&priv->lock);
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 	return result;
 }
 
@@ -1727,85 +1756,21 @@ static const struct ethtool_ops ravb_ethtool_ops = {
 	.set_wol		= ravb_set_wol,
 };
 
-static inline int ravb_hook_irq(unsigned int irq, irq_handler_t handler,
-				struct net_device *ndev, struct device *dev,
-				const char *ch)
-{
-	char *name;
-	int error;
-
-	name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
-	if (!name)
-		return -ENOMEM;
-	error = request_irq(irq, handler, 0, name, ndev);
-	if (error)
-		netdev_err(ndev, "cannot request IRQ %s\n", name);
-
-	return error;
-}
-
 /* Network device open function for Ethernet AVB */
 static int ravb_open(struct net_device *ndev)
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
@@ -1826,26 +1791,6 @@ static int ravb_open(struct net_device *ndev)
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
@@ -2180,19 +2125,6 @@ static int ravb_close(struct net_device *ndev)
 
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
@@ -2616,6 +2548,90 @@ static void ravb_parse_delay_mode(struct device_node *np, struct net_device *nde
 	}
 }
 
+static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
+			  const char *ch, int *irq, irq_handler_t handler)
+{
+	struct platform_device *pdev = priv->pdev;
+	struct net_device *ndev = priv->ndev;
+	struct device *dev = &pdev->dev;
+	const char *dev_name;
+	unsigned long flags;
+	int error;
+
+	if (irq_name) {
+		dev_name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
+		if (!dev_name)
+			return -ENOMEM;
+
+		*irq = platform_get_irq_byname(pdev, irq_name);
+		flags = 0;
+	} else {
+		dev_name = ndev->name;
+		*irq = platform_get_irq(pdev, 0);
+		flags = IRQF_SHARED;
+	}
+	if (*irq < 0)
+		return *irq;
+
+	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
+	if (error)
+		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
+
+	return error;
+}
+
+static int ravb_setup_irqs(struct ravb_private *priv)
+{
+	const struct ravb_hw_info *info = priv->info;
+	struct net_device *ndev = priv->ndev;
+	const char *irq_name, *emac_irq_name;
+	int error, irq;
+
+	if (!info->multi_irqs)
+		return ravb_setup_irq(priv, NULL, NULL, &ndev->irq, ravb_interrupt);
+
+	if (info->err_mgmt_irqs) {
+		irq_name = "dia";
+		emac_irq_name = "line3";
+	} else {
+		irq_name = "ch22";
+		emac_irq_name = "ch24";
+	}
+
+	error = ravb_setup_irq(priv, irq_name, "ch22:multi", &ndev->irq, ravb_multi_interrupt);
+	if (error)
+		return error;
+
+	error = ravb_setup_irq(priv, emac_irq_name, "ch24:emac", &priv->emac_irq,
+			       ravb_emac_interrupt);
+	if (error)
+		return error;
+
+	if (info->err_mgmt_irqs) {
+		error = ravb_setup_irq(priv, "err_a", "err_a", &irq, ravb_multi_interrupt);
+		if (error)
+			return error;
+
+		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", &irq, ravb_multi_interrupt);
+		if (error)
+			return error;
+	}
+
+	error = ravb_setup_irq(priv, "ch0", "ch0:rx_be", &irq, ravb_be_interrupt);
+	if (error)
+		return error;
+
+	error = ravb_setup_irq(priv, "ch1", "ch1:rx_nc", &irq, ravb_nc_interrupt);
+	if (error)
+		return error;
+
+	error = ravb_setup_irq(priv, "ch18", "ch18:tx_be", &irq, ravb_be_interrupt);
+	if (error)
+		return error;
+
+	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", &irq, ravb_nc_interrupt);
+}
+
 static void ravb_set_delay_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -2635,9 +2651,8 @@ static int ravb_probe(struct platform_device *pdev)
 	struct reset_control *rstc;
 	struct ravb_private *priv;
 	struct net_device *ndev;
-	int error, irq, q;
 	struct resource *res;
-	int i;
+	int error, q;
 
 	if (!np) {
 		dev_err(&pdev->dev,
@@ -2664,20 +2679,6 @@ static int ravb_probe(struct platform_device *pdev)
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
@@ -2692,6 +2693,10 @@ static int ravb_probe(struct platform_device *pdev)
 		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
 	}
 
+	error = ravb_setup_irqs(priv);
+	if (error)
+		goto out_reset_assert;
+
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		error = PTR_ERR(priv->clk);
@@ -2739,50 +2744,6 @@ static int ravb_probe(struct platform_device *pdev)
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
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
 	ndev->min_mtu = ETH_MIN_MTU;
 
-- 
2.39.2


