Return-Path: <linux-kernel+bounces-26158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7565E82DC18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5201C21B70
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151AA182D8;
	Mon, 15 Jan 2024 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VRCkCtrQ"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15894182BF;
	Mon, 15 Jan 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A4CDAC6470;
	Mon, 15 Jan 2024 14:59:21 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1246BFF80F;
	Mon, 15 Jan 2024 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705330754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbYOaOM3QGrDC1DK3YRlyfVFVMs9CV5+vSCXqg6nHbs=;
	b=VRCkCtrQqelHjj9OS2DN1LwBbCx7PMCRs/YxKZgFM45s4k16/w4/tqPmVdhmB6mBRdqK7m
	w/tICl/5UzYHjurWgXpQEbZKaojMyY5YCK4zS/BZriki33p+OWdmYJzkc8+nVhzN7IPqSj
	7LCtL1qxF73Aic6UJK3UKZibxvsWBSYCJpBUmSHZTi623MUVspF+jmfI8A/qd0xVyCA6hF
	x8zabXhn/jvtAc+A+XjfZWwDumDlVBqZh2gbWCfjYMPBxDWnC3AEBVma96Aco/2pR/cjgK
	sgWzh/wj+byWJcrlUlHLe2wPpYy6QXCNNi6Pa4h4kui9XF3wr3EgroA+9eStrQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Mon, 15 Jan 2024 15:56:33 +0100
Subject: [PATCH 4/5] wifi: wilc1000: fix incorrect power down sequence
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240115-wilc_1000_fixes-v1-4-54d29463a738@bootlin.com>
References: <20240115-wilc_1000_fixes-v1-0-54d29463a738@bootlin.com>
In-Reply-To: <20240115-wilc_1000_fixes-v1-0-54d29463a738@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 David Mosberger-Tang <davidm@egauge.net>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Michael Walle <mwalle@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

From: Ajay Singh <ajay.kathat@microchip.com>

Use the correct register configuration when the WILC chip is down so the
successive interface up operation is successful. The modified registers
values during chip down helps to avoid the "FW not responding" debug
message which sometimes occurs because of temporary bus communication
failure during the next start. Also, make sure on first communication with
the chip that it is indeed woken up.

Reported-by: Michael Walle <mwalle@kernel.org>
Closes: https://lore.kernel.org/linux-wireless/20221026085415.6jgwrhq4sunqaypm@0002.3ffe.de/
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 33 +++++++++++++++-----------
 drivers/net/wireless/microchip/wilc1000/wlan.h |  6 +++++
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 9eb115c79c90..6b2f2269ddf8 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1198,27 +1198,32 @@ int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif *vif)
 
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 
-	ret = wilc->hif_func->hif_read_reg(wilc, WILC_GP_REG_0, &reg);
-	if (ret) {
-		netdev_err(vif->ndev, "Error while reading reg\n");
+	ret = wilc->hif_func->hif_read_reg(wilc, GLOBAL_MODE_CONTROL, &reg);
+	if (ret)
 		goto release;
-	}
 
-	ret = wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_0,
-					(reg | WILC_ABORT_REQ_BIT));
-	if (ret) {
-		netdev_err(vif->ndev, "Error while writing reg\n");
+	reg &= ~WILC_GLOBAL_MODE_ENABLE_WIFI;
+	ret = wilc->hif_func->hif_write_reg(wilc, GLOBAL_MODE_CONTROL, reg);
+	if (ret)
+		goto release;
+
+	ret = wilc->hif_func->hif_read_reg(wilc, PWR_SEQ_MISC_CTRL, &reg);
+	if (ret)
+		goto release;
+
+	reg &= ~WILC_PWR_SEQ_ENABLE_WIFI_SLEEP;
+	ret = wilc->hif_func->hif_write_reg(wilc, PWR_SEQ_MISC_CTRL, reg);
+	if (ret)
 		goto release;
-	}
 
-	ret = wilc->hif_func->hif_read_reg(wilc, WILC_FW_HOST_COMM, &reg);
+	ret = wilc->hif_func->hif_read_reg(wilc, WILC_GP_REG_0, &reg);
 	if (ret) {
 		netdev_err(vif->ndev, "Error while reading reg\n");
 		goto release;
 	}
-	reg = BIT(0);
 
-	ret = wilc->hif_func->hif_write_reg(wilc, WILC_FW_HOST_COMM, reg);
+	ret = wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_0,
+					(reg | WILC_ABORT_REQ_BIT));
 	if (ret) {
 		netdev_err(vif->ndev, "Error while writing reg\n");
 		goto release;
@@ -1410,7 +1415,7 @@ static int init_chip(struct net_device *dev)
 	struct wilc_vif *vif = netdev_priv(dev);
 	struct wilc *wilc = vif->wilc;
 
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 
 	chipid = wilc_get_chipid(wilc, true);
 
@@ -1440,7 +1445,7 @@ static int init_chip(struct net_device *dev)
 	}
 
 release:
-	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index a72cd5cac81d..f02775f7e41f 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -156,6 +156,12 @@
 #define WILC_GP_REG_0			0x149c
 #define WILC_GP_REG_1			0x14a0
 
+#define GLOBAL_MODE_CONTROL		0x1614
+#define PWR_SEQ_MISC_CTRL		0x3008
+
+#define WILC_GLOBAL_MODE_ENABLE_WIFI	BIT(0)
+#define WILC_PWR_SEQ_ENABLE_WIFI_SLEEP	BIT(28)
+
 #define WILC_HAVE_SDIO_IRQ_GPIO		BIT(0)
 #define WILC_HAVE_USE_PMU		BIT(1)
 #define WILC_HAVE_SLEEP_CLK_SRC_RTC	BIT(2)

-- 
2.42.1


