Return-Path: <linux-kernel+bounces-148241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCBF8A7FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B75283EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199D813BAE4;
	Wed, 17 Apr 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mMvunL/u"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462213328A;
	Wed, 17 Apr 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346464; cv=none; b=oD2eid9jXCki6HwWYLvoYrblog5Fq2PpE6rPknrOUjqqSVkm2/q+XMlIaa48TXzNcIxUaA0m+44HJMK23giyHxlL+aYRgINH2g8CBxHsCja0jd8E7Eas4Sxn7ZRYSfzF9zA1FSkPpR+DfGAHFA7yh62viaAJpWAKjP7vqSmnpFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346464; c=relaxed/simple;
	bh=OPIN8Oscgip6y7sWgfOIst8fCpHSWskiwXQR9mF0fbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eii8i7tmsvt7zNVeF3Y5EWjVoqHcECLKw2gkLMSoTeySSjjyIjJhmW4Z6TrNSAO/VAA/sDDWD4elOx2sHIV5oejSLFhBHyGQtMvQGuuJuiLPKw3T2rpfXopUjfk+RhC+oATACZov9BQo8OD0vjNA0NLHWkPc5NeBEiCBV9XKRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mMvunL/u; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E79DEFF80A;
	Wed, 17 Apr 2024 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713346455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2HMxMyBUkocSmEwLbQzJ8wYnRk7I7+CeeaeUnX21Gg=;
	b=mMvunL/uLZ3ybm/BwSxNaOAGaljDD6RHCijtR0UXA8ivFIykX99BI9ke6/qKnm+86oa8LG
	Wg5S1FeG5Lh74597eIhLHTzSfKuBI1W6WGkKb9LYO95qpIcTlXOmVQOvtuex0SGNZ2Cgoc
	7juxQ7/tMLqVudE0jip3p5guC6MQbAwCadOnOKFbeboKSuMt+vM8mvBZPxGzSwlFcMyaxf
	0uwdeWbT4vPDGlphPdsJUMK09XOVyL34FuXG8uC07Cp1pGp0CK1fzKjOLoIbIHUj4du5y7
	lvujVuul4+6hvo8S3G2BjPcs1SLsU5IqYgJGg7k1/07T5/kGC6C6SsRbWokFwQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 17 Apr 2024 11:34:09 +0200
Subject: [PATCH 2/6] wifi: wilc1000: register net device only after bus
 being fully initialized
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240417-mac_addr_at_probe-v1-2-67d6c9b3bc2b@bootlin.com>
References: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com>
In-Reply-To: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

SDIO/SPI probes functions automatically add a default wlan interface on top
of registered wiphy, through wilc_cfg80211_init which in turn calls
wilc_netdev_ifc_init. However, bus is still not fully initialized when we
register corresponding net device (for example we still miss some private
driver data pointers), which for example makes it impossible to
retrieve MAC address from chip (which is supposed to be set on net device
before its registration) before registering net device. More generally, net
device registration should not be done until driver has fully initialized
everything and is ready to handle any operation  on the net device.

Prevent net device from being registered so early by doing it at the end of
probe functions. Apply this logic to both sdio and spi buses.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 10 ----------
 drivers/net/wireless/microchip/wilc1000/sdio.c     | 14 ++++++++++++--
 drivers/net/wireless/microchip/wilc1000/spi.c      | 11 +++++++++--
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 7d9fb9f2d527..f716981f62ad 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1773,7 +1773,6 @@ int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
 		       const struct wilc_hif_func *ops)
 {
 	struct wilc *wl;
-	struct wilc_vif *vif;
 	int ret, i;
 
 	wl = wilc_create_wiphy(dev);
@@ -1802,18 +1801,9 @@ int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
 		ret = -ENOMEM;
 		goto free_cfg;
 	}
-	vif = wilc_netdev_ifc_init(wl, "wlan%d", WILC_STATION_MODE,
-				   NL80211_IFTYPE_STATION, false);
-	if (IS_ERR(vif)) {
-		ret = PTR_ERR(vif);
-		goto free_hq;
-	}
 
 	return 0;
 
-free_hq:
-	destroy_workqueue(wl->hif_workqueue);
-
 free_cfg:
 	wilc_wlan_cfg_deinit(wl);
 
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 52a770c5e76f..a841dad08410 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -136,9 +136,11 @@ static int wilc_sdio_cmd53(struct wilc *wilc, struct sdio_cmd53 *cmd)
 static int wilc_sdio_probe(struct sdio_func *func,
 			   const struct sdio_device_id *id)
 {
+	struct wilc_sdio *sdio_priv;
+	struct wilc_vif *vif;
 	struct wilc *wilc;
 	int ret;
-	struct wilc_sdio *sdio_priv;
+
 
 	sdio_priv = kzalloc(sizeof(*sdio_priv), GFP_KERNEL);
 	if (!sdio_priv)
@@ -176,9 +178,17 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	}
 	clk_prepare_enable(wilc->rtc_clk);
 
+	vif = wilc_netdev_ifc_init(wilc, "wlan%d", WILC_STATION_MODE,
+				   NL80211_IFTYPE_STATION, false);
+	if (IS_ERR(vif)) {
+		ret = PTR_ERR(vif);
+		goto clk_disable_unprepare;
+	}
+
 	dev_info(&func->dev, "Driver Initializing success\n");
 	return 0;
-
+clk_disable_unprepare:
+	clk_disable_unprepare(wilc->rtc_clk);
 dispose_irq:
 	irq_dispose_mapping(wilc->dev_irq_num);
 	wilc_netdev_cleanup(wilc);
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 61c3572ce321..add0e70a09ea 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -206,9 +206,10 @@ static void wilc_wlan_power(struct wilc *wilc, bool on)
 
 static int wilc_bus_probe(struct spi_device *spi)
 {
-	int ret;
-	struct wilc *wilc;
 	struct wilc_spi *spi_priv;
+	struct wilc_vif *vif;
+	struct wilc *wilc;
+	int ret;
 
 	spi_priv = kzalloc(sizeof(*spi_priv), GFP_KERNEL);
 	if (!spi_priv)
@@ -250,6 +251,12 @@ static int wilc_bus_probe(struct spi_device *spi)
 		goto power_down;
 
 	wilc_wlan_power(wilc, false);
+	vif = wilc_netdev_ifc_init(wilc, "wlan%d", WILC_STATION_MODE,
+				   NL80211_IFTYPE_STATION, false);
+	if (IS_ERR(vif)) {
+		ret = PTR_ERR(vif);
+		goto power_down;
+	}
 	return 0;
 
 power_down:

-- 
2.44.0


