Return-Path: <linux-kernel+bounces-26157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B20482DC16
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E7B282B50
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E4A18037;
	Mon, 15 Jan 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GweDVpgJ"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9118034;
	Mon, 15 Jan 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 7B6B6C646F;
	Mon, 15 Jan 2024 14:59:21 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92FD7FF806;
	Mon, 15 Jan 2024 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705330754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZkhrW90NftZl3gLX1/zmDX5uMKEyUwGVtpHtaU4N8U=;
	b=GweDVpgJMSSmnHDrqmQBkSgYcuyaENwV0UjwFyxfClxgoiIXeBUkXey1+EA5lKU8L5AtdD
	oP4H8zC3IFSIU225CdWHjaZ1ZqLgE/BTlkAaLWVZFK3nAKOfxQqYUszQfUk1XVwSBFDHFg
	nvpFHkg4WSZQw5ZJZD3sRueewkmqdsBSjzju7oFR0UDvHG+KGqAQTA6RSfMlg3YsNEwzQG
	LILREwXQv1DnrHtulS1cnfgKNiDIc9Eef/M8zrXJGPOHLxCmf12ZCVnhNnBgVMa5GJee0v
	LcjATmebjbgSP6myKf/FgYiUk04w5cjK5EvtQmQspBpf0sUEUC6jQtSec50MfA==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Mon, 15 Jan 2024 15:56:32 +0100
Subject: [PATCH 3/5] wilc: wifi: do not realloc workqueue everytime an
 interface is added
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240115-wilc_1000_fixes-v1-3-54d29463a738@bootlin.com>
References: <20240115-wilc_1000_fixes-v1-0-54d29463a738@bootlin.com>
In-Reply-To: <20240115-wilc_1000_fixes-v1-0-54d29463a738@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 David Mosberger-Tang <davidm@egauge.net>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

From: Ajay Singh <ajay.kathat@microchip.com>

Commit 09ed8bfc5215 ("wilc1000: Rename workqueue from "WILC_wq" to
"NETDEV-wq"") moved workqueue creation in wilc_netdev_ifc_init in order to
set the interface name in the workqueue name. However, while the driver
needs only one workqueue, the wilc_netdev_ifc_init is called each time we
add an interface over a phy, which in turns overwrite the workqueue with a
new one. This can be observed with the following commands:

for i in $(seq 0 10)
do
  iw phy phy0 interface add wlan1 type managed
  iw dev wlan1 del
done
ps -eo pid,comm|grep wlan

 39 kworker/R-wlan0
 98 kworker/R-wlan1
102 kworker/R-wlan1
105 kworker/R-wlan1
108 kworker/R-wlan1
111 kworker/R-wlan1
114 kworker/R-wlan1
117 kworker/R-wlan1
120 kworker/R-wlan1
123 kworker/R-wlan1
126 kworker/R-wlan1
129 kworker/R-wlan1

Fix this leakage by putting back hif_workqueue allocation in
wilc_cfg80211_init. Regarding the workqueue name, it is indeed relevant to
set it lowercase, however it is not  attached to a specific netdev, so
enforcing netdev name in the name is not so relevant. Still, enrich the
name with the wiphy name to make it clear which phy is using the workqueue.

Fixes: 09ed8bfc5215 ("wilc1000: Rename workqueue from "WILC_wq" to "NETDEV-wq"")
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Co-developed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
This patch has initially been done by Ajay, and I slightly reworked it

09ed8bfc5215 ("wilc1000: Rename workqueue from "WILC_wq" to "NETDEV-wq"")
also mentions that this workqueue allocation move has also been done to
make wq alloc/dealloc symmetric: the revert set back the assymetry, and that
remains something to be fixed. Deallocation should likely be moved from
netdev.c to cfg80211, but that would be a dedicated rework topic
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 11 ++++++++++-
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 10 +---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index ad2509d8c99a..2d0474e6404e 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1804,15 +1804,24 @@ int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
 	INIT_LIST_HEAD(&wl->rxq_head.list);
 	INIT_LIST_HEAD(&wl->vif_list);
 
+	wl->hif_workqueue = alloc_ordered_workqueue("%s", WQ_MEM_RECLAIM,
+						    wiphy_name(wl->wiphy));
+	if (!wl->hif_workqueue) {
+		ret = -ENOMEM;
+		goto free_cfg;
+	}
 	vif = wilc_netdev_ifc_init(wl, "wlan%d", WILC_STATION_MODE,
 				   NL80211_IFTYPE_STATION, false);
 	if (IS_ERR(vif)) {
 		ret = PTR_ERR(vif);
-		goto free_cfg;
+		goto free_hq;
 	}
 
 	return 0;
 
+free_hq:
+	destroy_workqueue(wl->hif_workqueue);
+
 free_cfg:
 	wilc_wlan_cfg_deinit(wl);
 
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index f3b9709f8730..da52f4a9c1fe 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -989,13 +989,6 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 		goto error;
 	}
 
-	wl->hif_workqueue = alloc_ordered_workqueue("%s-wq", WQ_MEM_RECLAIM,
-						    ndev->name);
-	if (!wl->hif_workqueue) {
-		ret = -ENOMEM;
-		goto unregister_netdev;
-	}
-
 	ndev->needs_free_netdev = true;
 	vif->iftype = vif_type;
 	vif->idx = wilc_get_available_idx(wl);
@@ -1008,12 +1001,11 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 
 	return vif;
 
-unregister_netdev:
+error:
 	if (rtnl_locked)
 		cfg80211_unregister_netdevice(ndev);
 	else
 		unregister_netdev(ndev);
-  error:
 	free_netdev(ndev);
 	return ERR_PTR(ret);
 }

-- 
2.42.1


