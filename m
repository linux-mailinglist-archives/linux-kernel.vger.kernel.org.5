Return-Path: <linux-kernel+bounces-115834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D9A8894C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8B51F3086E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ABE3709C6;
	Mon, 25 Mar 2024 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3X6BvFR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D70145B1F;
	Sun, 24 Mar 2024 23:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322019; cv=none; b=QkbQeW0sUhjbNohCITPKSDF3j3Tk80J+DTaGdXnRIvBqUAZACERJ8XV6s9+DU18C7ZvgJRQiVpsBNL8u5518LI2uXZxLKcakBQee75HTtN1aPVJG0q9t9AUFSFGy1fTcHCeRa43NfA7PJ+vPQP+5sPQkhC2z0KAYVJK6cV3Tj88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322019; c=relaxed/simple;
	bh=rM/a6NXuhaaDJxRNqFU+vOj3znGsfhW1ZP19rBQIkT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVHsIgoTpZZSE26Irhpc9XWEgngTPBkExjOWncxq/B09wgwUFsyiheBWe/THjLxzaXOAejTM4ylf14FRlnG9LYGi3J7vzXE2ajwj7xUhpkFGONw7/PEipx/S5uv0Sqxr9i0IHFw9DsNQRItlyBGjeoI8XZsFU1hqf/feUMY5Kfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3X6BvFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A5EC433F1;
	Sun, 24 Mar 2024 23:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322019;
	bh=rM/a6NXuhaaDJxRNqFU+vOj3znGsfhW1ZP19rBQIkT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3X6BvFRNma5N9snvapp1mpFsCrYaTM0KpTW2ARIUbL3fYLmN/r4lzhdXrx1w6QSm
	 NTr0xpnskSs3TWU5Z3vwGrXBIw9RgiLI8TrhT3cYFjiozHaXJl4B9uFnGC/movicf7
	 WNFV8qLqHuVYqQrAC45CzxIT9H2cpmEoOfs0OvBRXLLM9agVuSMV9tczVEGB3uwuVu
	 YrI7GKGRvaL3xeFViCnDlNPF8NosItKuE4NKZa+a38Vp5kb2amM3DAnrcJiEgboKb6
	 J6I2k+awl5s5tBoXhQCCAJO69JLU1TXXmIsLeSy8gPXZ/dwVotx88DbbHkig/MRnbw
	 ytZJLP4XISpHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 091/451] wifi: wilc1000: do not realloc workqueue everytime an interface is added
Date: Sun, 24 Mar 2024 19:06:07 -0400
Message-ID: <20240324231207.1351418-92-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ajay Singh <ajay.kathat@microchip.com>

[ Upstream commit 328efda22af81130c2ad981c110518cb29ff2f1d ]

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
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240115-wilc_1000_fixes-v1-3-54d29463a738@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 11 ++++++++++-
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 10 +---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index b545d93c6e374..2f75dc4b47975 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1810,15 +1810,24 @@ int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
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
index e9f59de31b0b9..0e6eeeed2e086 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -977,13 +977,6 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
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
@@ -996,12 +989,11 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 
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
2.43.0


