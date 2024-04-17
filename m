Return-Path: <linux-kernel+bounces-148246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5137F8A7FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A763283F25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3313C8FD;
	Wed, 17 Apr 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OpFp70WU"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060B13B2B9;
	Wed, 17 Apr 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346466; cv=none; b=PWIEVZweNHfEmZW0BSd/XvOiP772Kmyt5QKlmDIPbO6qDODV2SOalAVI4v6VZCqXYrt04NlleE06fsb30svB2CbxXRUvDxs3KlTZr7/m6WET0UTVDr08tBXILqo3qX9FsSNhluCmnLAJowpJ5nPYjSdSTJoHRWYD1lB/FIfA5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346466; c=relaxed/simple;
	bh=5AL7sa8E0ZkWSSFYV7dk5rfCS72kkpuULGQcD+SNzMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ekBqRdBgO5+w9sViSlRnT7ulltRmnZoyyhVinOiSKJm0tt3uZpRKoVEpLOKhLdgMflh4e96HRylLSn8cpsz48WbqjC0eNUv1g/FqSrz+x6dhCcHol2PiHsDPM99G3Ws/U6YUb4nN1ZhpxVBDvE3THs9cfQwsD0bx/Jr1WKThmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OpFp70WU; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C4531FF815;
	Wed, 17 Apr 2024 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713346457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qn5kBLS2A7DdgWTR5t2clmRkTCWgVgr24XXxD0C7thk=;
	b=OpFp70WU26jK6dMhlKRDdLzts+pIGuE4+G4tNik08H3Dd7bnDz71eaIofrYkj6h0FUbQpd
	+SyEwQXg1ygJ+JW3aLzK6CxwfgTue+gbRAYIb1ZQU7yGKj0qMVtlqsrzeE/mxqYk/CKXvc
	bFuh3wahEm2E6ywr1UU4yvbr0WT9/3F0GL3+OCuVM147aRRoRhtXLiBPDDmyv39tM0aeoh
	wYFtLieqcISpFdV7n97lTLA9iMfKr4AUf4EeC6cVbQdnmdbqw/TUj9KdvlS28sLN9b0fuM
	L7OVHvifqmui7YXj1oCUpSgdRJxzoO2TuJnGDg3Lj0+qkvBr5Z/Dpt+Lqg+wcw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 17 Apr 2024 11:34:13 +0200
Subject: [PATCH 6/6] wifi: wilc1000: read MAC address from fuse at probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240417-mac_addr_at_probe-v1-6-67d6c9b3bc2b@bootlin.com>
References: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com>
In-Reply-To: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Heiko Thiery <heiko.thiery@gmail.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

From: Ajay Singh <ajay.kathat@microchip.com>

The default netdev interface exposed by WILC1000 is registered at probe,
but the chip mac address is not known until ndo_open, which will load and
start chip firmware and then retrieve stored MAC address from it. As a
consequence, the interface has uninitialized value (00:00:00:00:00) until a
user brings up the interface.

Fix MAC address at probe by setting the following steps:
- at probe, read MAC address directly from fuse
- whenever a new netdevice is created, apply saved mac address (which can
  be a user-provided address, or the eFuse Mac address if no address has
  been passed by user)
- whenever an interface is brought up for the first time (and so the
  firmware is loaded and started), enforce netdevice mac address to the
  chip (in case user has changed it)

Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
Closes: https://lore.kernel.org/netdev/CAEyMn7aV-B4OEhHR4Ad0LM3sKCz1-nDqSb9uZNmRWR-hMZ=z+A@mail.gmail.com/T/
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Co-developed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 38 ++++++++++++++----------
 drivers/net/wireless/microchip/wilc1000/sdio.c   | 14 +++++++++
 drivers/net/wireless/microchip/wilc1000/spi.c    |  6 ++++
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 5ab448d0b643..f1fbc6e8a82a 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -588,7 +588,6 @@ static int wilc_mac_open(struct net_device *ndev)
 	struct wilc *wl = vif->wilc;
 	int ret = 0;
 	struct mgmt_frame_regs mgmt_regs = {};
-	u8 addr[ETH_ALEN] __aligned(2);
 
 	if (!wl || !wl->dev) {
 		netdev_err(ndev, "device not ready\n");
@@ -607,25 +606,19 @@ static int wilc_mac_open(struct net_device *ndev)
 		return ret;
 	}
 
-	wilc_set_operation_mode(vif, wilc_get_vif_idx(vif), vif->iftype,
-				vif->idx);
-
-	if (is_valid_ether_addr(ndev->dev_addr)) {
-		ether_addr_copy(addr, ndev->dev_addr);
-		wilc_set_mac_address(vif, addr);
-	} else {
-		wilc_get_mac_address(vif, addr);
-		eth_hw_addr_set(ndev, addr);
-	}
 	netdev_dbg(ndev, "Mac address: %pM\n", ndev->dev_addr);
-
-	if (!is_valid_ether_addr(ndev->dev_addr)) {
-		netdev_err(ndev, "Wrong MAC address\n");
+	ret = wilc_set_mac_address(vif, ndev->dev_addr);
+	if (ret) {
+		netdev_err(ndev, "Failed to enforce MAC address in chip");
 		wilc_deinit_host_int(ndev);
-		wilc_wlan_deinitialize(ndev);
-		return -EINVAL;
+		if (!wl->open_ifcs)
+			wilc_wlan_deinitialize(ndev);
+		return ret;
 	}
 
+	wilc_set_operation_mode(vif, wilc_get_vif_idx(vif), vif->iftype,
+				vif->idx);
+
 	mgmt_regs.interface_stypes = vif->mgmt_reg_stypes;
 	/* so we detect a change */
 	vif->mgmt_reg_stypes = 0;
@@ -941,6 +934,7 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 				      int vif_type, enum nl80211_iftype type,
 				      bool rtnl_locked)
 {
+	u8 mac_address[ETH_ALEN];
 	struct net_device *ndev;
 	struct wilc_vif *vif;
 	int ret;
@@ -969,6 +963,18 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 	vif->iftype = vif_type;
 	vif->idx = wilc_get_available_idx(wl);
 	vif->mac_opened = 0;
+
+	memcpy(mac_address, wl->nv_mac_address, ETH_ALEN);
+	/* WILC firmware uses locally administered MAC address for the
+	 * second virtual interface (bit 1 of first byte set), but
+	 * since it is possibly not loaded/running yet, reproduce this behavior
+	 * in the driver during interface creation.
+	 */
+	if (vif->idx)
+		mac_address[0] |= 0x2;
+
+	eth_hw_addr_set(vif->ndev, mac_address);
+
 	mutex_lock(&wl->vif_mutex);
 	list_add_tail_rcu(&vif->list, &wl->vif_list);
 	wl->vif_num += 1;
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 04d6565df2cb..e6e20c86b791 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -24,6 +24,9 @@ MODULE_DEVICE_TABLE(sdio, wilc_sdio_ids);
 
 #define WILC_SDIO_BLOCK_SIZE 512
 
+static int wilc_sdio_init(struct wilc *wilc, bool resume);
+static int wilc_sdio_deinit(struct wilc *wilc);
+
 struct wilc_sdio {
 	bool irq_gpio;
 	u32 block_size;
@@ -178,6 +181,16 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	}
 	clk_prepare_enable(wilc->rtc_clk);
 
+	wilc_sdio_init(wilc, false);
+
+	ret = wilc_load_mac_from_nv(wilc);
+	if (ret) {
+		pr_err("Can not retrieve MAC address from chip\n");
+		goto clk_disable_unprepare;
+	}
+
+	wilc_sdio_deinit(wilc);
+
 	vif = wilc_netdev_ifc_init(wilc, "wlan%d", WILC_STATION_MODE,
 				   NL80211_IFTYPE_STATION, false);
 	if (IS_ERR(vif)) {
@@ -187,6 +200,7 @@ static int wilc_sdio_probe(struct sdio_func *func,
 
 	dev_info(&func->dev, "Driver Initializing success\n");
 	return 0;
+
 clk_disable_unprepare:
 	clk_disable_unprepare(wilc->rtc_clk);
 dispose_irq:
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index add0e70a09ea..5ff940c53ad9 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -250,6 +250,12 @@ static int wilc_bus_probe(struct spi_device *spi)
 	if (ret)
 		goto power_down;
 
+	ret = wilc_load_mac_from_nv(wilc);
+	if (ret) {
+		pr_err("Can not retrieve MAC address from chip\n");
+		goto power_down;
+	}
+
 	wilc_wlan_power(wilc, false);
 	vif = wilc_netdev_ifc_init(wilc, "wlan%d", WILC_STATION_MODE,
 				   NL80211_IFTYPE_STATION, false);

-- 
2.44.0


