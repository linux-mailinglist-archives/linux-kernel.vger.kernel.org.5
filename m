Return-Path: <linux-kernel+bounces-138049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B089EB83
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E49B25587
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BFA13CA88;
	Wed, 10 Apr 2024 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KUhBgg2x"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A1713C905;
	Wed, 10 Apr 2024 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733062; cv=none; b=lESTFVwj+89yExskVQv+qFKzn4Bz5CDtBOPhq0QoiVCowVgJhv21idJv8xGe3+SMfrM/5UDWkXLSNCW+nGT3azKDbLKtzyOmKaGYqcRsn/+KaHkCi7dhozEYbW7/33XY+bC2mXz0ecGr06lNSpqBLPMJI4EPoPGV9GCezpq7Hvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733062; c=relaxed/simple;
	bh=iIhTqQKGFYGbMX+0WhDDRmnoQ6sHNC2UxWsKCD/mCsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kiVANZmEmYaRnI3DObWc/KKrDi8Crd95BjIZ3LvHLoetB//YEfxuoZnVAEKt2NRzJ4lgHMeV6wBC521Bjnqcx31BQFjWa9xx7xt5TsvubdXpH9eXqplHSrkh8y5BTtNl3oMKxtwbvVk4z+djB2MRHQs+lXYIqDdEPVPVyC/r88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KUhBgg2x; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 309DCE0003;
	Wed, 10 Apr 2024 07:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712733058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uM2ai5Wl9STzyxfvvo0m0/G2zlemCl8YkRDBrWtIT1c=;
	b=KUhBgg2xeu8HecQD265ZFSEj8IsuJDB4A3PRy6hzw3htLxdT5CP4DbBC8p1JRB7K5dRUC/
	hlGWF/L2sMJIRrgM4cks6tYqz9pQnWcJIcW658fcpp419b+ARUwn+4O0KTsYCe/fMacVBc
	+k5Ju6zHy/zzHZOTRLo+V314A8W8iSbrl1+xTECrylw17QoPe9OTTWBtID9lo52Vt9axol
	1gfLSzMo+HiFH2qk1EN3g79N18BHBArqfNzLaMwWUGbsotvn4t2ssBDHrHtOvOkN4mvNB1
	yjKyvR0m9CYnotu6532JqAIbzFCEsVlUIMNPy0bijbxbRzJzOckKJp86c83EqQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 10 Apr 2024 09:10:34 +0200
Subject: [PATCH 2/2] wifi: wilc1000: convert list management to RCU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-wilc_srcu_to_rcu-v1-2-a9ff5b10feaa@bootlin.com>
References: <20240410-wilc_srcu_to_rcu-v1-0-a9ff5b10feaa@bootlin.com>
In-Reply-To: <20240410-wilc_srcu_to_rcu-v1-0-a9ff5b10feaa@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

wilc1000 driver currently uses SRCU API to manage vif list. There is no
real reason to use SRCU API here, and it makes things slightly more
complicated (we need to handle a SRCU index as well as a srcu_struct) than
classical RCU.

Switch SRCU APIs to RCU APIs.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 41 +++++++++------------
 drivers/net/wireless/microchip/wilc1000/hif.c      | 15 +++-----
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 43 +++++++++-------------
 drivers/net/wireless/microchip/wilc1000/netdev.h   |  5 +--
 drivers/net/wireless/microchip/wilc1000/wlan.c     |  5 +--
 5 files changed, 45 insertions(+), 64 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 089102ed9ae5..7d9fb9f2d527 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -237,12 +237,11 @@ static int set_channel(struct wiphy *wiphy,
 	struct wilc_vif *vif;
 	u32 channelnum;
 	int result;
-	int srcu_idx;
 
-	srcu_idx = srcu_read_lock(&wl->srcu);
+	rcu_read_lock();
 	vif = wilc_get_wl_to_vif(wl);
 	if (IS_ERR(vif)) {
-		srcu_read_unlock(&wl->srcu, srcu_idx);
+		rcu_read_unlock();
 		return PTR_ERR(vif);
 	}
 
@@ -253,7 +252,7 @@ static int set_channel(struct wiphy *wiphy,
 	if (result)
 		netdev_err(vif->ndev, "Error in setting channel\n");
 
-	srcu_read_unlock(&wl->srcu, srcu_idx);
+	rcu_read_unlock();
 	return result;
 }
 
@@ -806,9 +805,8 @@ static int set_wiphy_params(struct wiphy *wiphy, u32 changed)
 	struct wilc *wl = wiphy_priv(wiphy);
 	struct wilc_vif *vif;
 	struct wilc_priv *priv;
-	int srcu_idx;
 
-	srcu_idx = srcu_read_lock(&wl->srcu);
+	rcu_read_lock();
 	vif = wilc_get_wl_to_vif(wl);
 	if (IS_ERR(vif))
 		goto out;
@@ -863,7 +861,7 @@ static int set_wiphy_params(struct wiphy *wiphy, u32 changed)
 		netdev_err(priv->dev, "Error in setting WIPHY PARAMS\n");
 
 out:
-	srcu_read_unlock(&wl->srcu, srcu_idx);
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -1539,20 +1537,19 @@ static struct wireless_dev *add_virtual_intf(struct wiphy *wiphy,
 
 	if (type == NL80211_IFTYPE_MONITOR) {
 		struct net_device *ndev;
-		int srcu_idx;
 
-		srcu_idx = srcu_read_lock(&wl->srcu);
+		rcu_read_lock();
 		vif = wilc_get_vif_from_type(wl, WILC_AP_MODE);
 		if (!vif) {
 			vif = wilc_get_vif_from_type(wl, WILC_GO_MODE);
 			if (!vif) {
-				srcu_read_unlock(&wl->srcu, srcu_idx);
+				rcu_read_unlock();
 				goto validate_interface;
 			}
 		}
 
 		if (vif->monitor_flag) {
-			srcu_read_unlock(&wl->srcu, srcu_idx);
+			rcu_read_unlock();
 			goto validate_interface;
 		}
 
@@ -1560,12 +1557,12 @@ static struct wireless_dev *add_virtual_intf(struct wiphy *wiphy,
 		if (ndev) {
 			vif->monitor_flag = 1;
 		} else {
-			srcu_read_unlock(&wl->srcu, srcu_idx);
+			rcu_read_unlock();
 			return ERR_PTR(-EINVAL);
 		}
 
 		wdev = &vif->priv.wdev;
-		srcu_read_unlock(&wl->srcu, srcu_idx);
+		rcu_read_unlock();
 		return wdev;
 	}
 
@@ -1613,7 +1610,7 @@ static int del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 	list_del_rcu(&vif->list);
 	wl->vif_num--;
 	mutex_unlock(&wl->vif_mutex);
-	synchronize_srcu(&wl->srcu);
+	synchronize_rcu();
 	return 0;
 }
 
@@ -1638,25 +1635,23 @@ static void wilc_set_wakeup(struct wiphy *wiphy, bool enabled)
 {
 	struct wilc *wl = wiphy_priv(wiphy);
 	struct wilc_vif *vif;
-	int srcu_idx;
 
-	srcu_idx = srcu_read_lock(&wl->srcu);
+	rcu_read_lock();
 	vif = wilc_get_wl_to_vif(wl);
 	if (IS_ERR(vif)) {
-		srcu_read_unlock(&wl->srcu, srcu_idx);
+		rcu_read_unlock();
 		return;
 	}
 
 	netdev_info(vif->ndev, "cfg set wake up = %d\n", enabled);
 	wilc_set_wowlan_trigger(vif, enabled);
-	srcu_read_unlock(&wl->srcu, srcu_idx);
+	rcu_read_unlock();
 }
 
 static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 			enum nl80211_tx_power_setting type, int mbm)
 {
 	int ret;
-	int srcu_idx;
 	s32 tx_power = MBM_TO_DBM(mbm);
 	struct wilc *wl = wiphy_priv(wiphy);
 	struct wilc_vif *vif;
@@ -1664,10 +1659,10 @@ static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 	if (!wl->initialized)
 		return -EIO;
 
-	srcu_idx = srcu_read_lock(&wl->srcu);
+	rcu_read_lock();
 	vif = wilc_get_wl_to_vif(wl);
 	if (IS_ERR(vif)) {
-		srcu_read_unlock(&wl->srcu, srcu_idx);
+		rcu_read_unlock();
 		return -EINVAL;
 	}
 
@@ -1679,7 +1674,7 @@ static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 	ret = wilc_set_tx_power(vif, tx_power);
 	if (ret)
 		netdev_err(vif->ndev, "Failed to set tx power\n");
-	srcu_read_unlock(&wl->srcu, srcu_idx);
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -1762,7 +1757,6 @@ static void wlan_init_locks(struct wilc *wl)
 	init_completion(&wl->cfg_event);
 	init_completion(&wl->sync_event);
 	init_completion(&wl->txq_thread_started);
-	init_srcu_struct(&wl->srcu);
 }
 
 void wlan_deinit_locks(struct wilc *wilc)
@@ -1773,7 +1767,6 @@ void wlan_deinit_locks(struct wilc *wilc)
 	mutex_destroy(&wilc->txq_add_to_head_cs);
 	mutex_destroy(&wilc->vif_mutex);
 	mutex_destroy(&wilc->deinit_lock);
-	cleanup_srcu_struct(&wilc->srcu);
 }
 
 int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 3925ca653e80..919de6ffb821 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1570,12 +1570,11 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	struct host_if_drv *hif_drv;
 	struct host_if_msg *msg;
 	struct wilc_vif *vif;
-	int srcu_idx;
 	int result;
 	int id;
 
 	id = get_unaligned_le32(&buffer[length - 4]);
-	srcu_idx = srcu_read_lock(&wilc->srcu);
+	rcu_read_lock();
 	vif = wilc_get_vif_from_idx(wilc, id);
 	if (!vif)
 		goto out;
@@ -1607,7 +1606,7 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 		kfree(msg);
 	}
 out:
-	srcu_read_unlock(&wilc->srcu, srcu_idx);
+	rcu_read_unlock();
 }
 
 void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 length)
@@ -1615,14 +1614,13 @@ void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	struct host_if_drv *hif_drv;
 	struct host_if_msg *msg;
 	struct wilc_vif *vif;
-	int srcu_idx;
 	int result;
 	int id;
 
 	mutex_lock(&wilc->deinit_lock);
 
 	id = get_unaligned_le32(&buffer[length - 4]);
-	srcu_idx = srcu_read_lock(&wilc->srcu);
+	rcu_read_lock();
 	vif = wilc_get_vif_from_idx(wilc, id);
 	if (!vif)
 		goto out;
@@ -1649,7 +1647,7 @@ void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 		kfree(msg);
 	}
 out:
-	srcu_read_unlock(&wilc->srcu, srcu_idx);
+	rcu_read_unlock();
 	mutex_unlock(&wilc->deinit_lock);
 }
 
@@ -1657,12 +1655,11 @@ void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length)
 {
 	struct host_if_drv *hif_drv;
 	struct wilc_vif *vif;
-	int srcu_idx;
 	int result;
 	int id;
 
 	id = get_unaligned_le32(&buffer[length - 4]);
-	srcu_idx = srcu_read_lock(&wilc->srcu);
+	rcu_read_lock();
 	vif = wilc_get_vif_from_idx(wilc, id);
 	if (!vif)
 		goto out;
@@ -1687,7 +1684,7 @@ void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length)
 		}
 	}
 out:
-	srcu_read_unlock(&wilc->srcu, srcu_idx);
+	rcu_read_unlock();
 }
 
 int wilc_remain_on_channel(struct wilc_vif *vif, u64 cookie, u16 chan,
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 710e29bea560..73f56f7b002b 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -127,30 +127,28 @@ void wilc_wlan_set_bssid(struct net_device *wilc_netdev, const u8 *bssid,
 
 int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc)
 {
-	int srcu_idx;
 	u8 ret_val = 0;
 	struct wilc_vif *vif;
 
-	srcu_idx = srcu_read_lock(&wilc->srcu);
+	rcu_read_lock();
 	wilc_for_each_vif(wilc, vif) {
 		if (!is_zero_ether_addr(vif->bssid))
 			ret_val++;
 	}
-	srcu_read_unlock(&wilc->srcu, srcu_idx);
+	rcu_read_unlock();
 	return ret_val;
 }
 
 static void wilc_wake_tx_queues(struct wilc *wl)
 {
-	int srcu_idx;
 	struct wilc_vif *ifc;
 
-	srcu_idx = srcu_read_lock(&wl->srcu);
+	rcu_read_lock();
 	wilc_for_each_vif(wl, ifc) {
 		if (ifc->mac_opened && netif_queue_stopped(ifc->ndev))
 			netif_wake_queue(ifc->ndev);
 	}
-	srcu_read_unlock(&wl->srcu, srcu_idx);
+	rcu_read_unlock();
 }
 
 static int wilc_txq_task(void *vp)
@@ -655,7 +653,6 @@ static int wilc_set_mac_addr(struct net_device *dev, void *p)
 	struct sockaddr *addr = (struct sockaddr *)p;
 	unsigned char mac_addr[ETH_ALEN];
 	struct wilc_vif *tmp_vif;
-	int srcu_idx;
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
@@ -667,19 +664,19 @@ static int wilc_set_mac_addr(struct net_device *dev, void *p)
 
 	/* Verify MAC Address is not already in use: */
 
-	srcu_idx = srcu_read_lock(&wilc->srcu);
+	rcu_read_lock();
 	wilc_for_each_vif(wilc, tmp_vif) {
 		wilc_get_mac_address(tmp_vif, mac_addr);
 		if (ether_addr_equal(addr->sa_data, mac_addr)) {
 			if (vif != tmp_vif) {
-				srcu_read_unlock(&wilc->srcu, srcu_idx);
+				rcu_read_unlock();
 				return -EADDRNOTAVAIL;
 			}
-			srcu_read_unlock(&wilc->srcu, srcu_idx);
+			rcu_read_unlock();
 			return 0;
 		}
 	}
-	srcu_read_unlock(&wilc->srcu, srcu_idx);
+	rcu_read_unlock();
 
 	result = wilc_set_mac_address(vif, (u8 *)addr->sa_data);
 	if (result)
@@ -767,15 +764,14 @@ netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
 						wilc_tx_complete);
 
 	if (queue_count > FLOW_CONTROL_UPPER_THRESHOLD) {
-		int srcu_idx;
 		struct wilc_vif *vif;
 
-		srcu_idx = srcu_read_lock(&wilc->srcu);
+		rcu_read_lock();
 		wilc_for_each_vif(wilc, vif) {
 			if (vif->mac_opened)
 				netif_stop_queue(vif->ndev);
 		}
-		srcu_read_unlock(&wilc->srcu, srcu_idx);
+		rcu_read_unlock();
 	}
 
 	return NETDEV_TX_OK;
@@ -819,13 +815,12 @@ void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size,
 	unsigned int frame_len = 0;
 	struct wilc_vif *vif;
 	struct sk_buff *skb;
-	int srcu_idx;
 	int stats;
 
 	if (!wilc)
 		return;
 
-	srcu_idx = srcu_read_lock(&wilc->srcu);
+	rcu_read_lock();
 	wilc_netdev = get_if_handler(wilc, buff);
 	if (!wilc_netdev)
 		goto out;
@@ -853,15 +848,14 @@ void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size,
 		netdev_dbg(wilc_netdev, "netif_rx ret value is: %d\n", stats);
 	}
 out:
-	srcu_read_unlock(&wilc->srcu, srcu_idx);
+	rcu_read_unlock();
 }
 
 void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size, bool is_auth)
 {
-	int srcu_idx;
 	struct wilc_vif *vif;
 
-	srcu_idx = srcu_read_lock(&wilc->srcu);
+	rcu_read_lock();
 	wilc_for_each_vif(wilc, vif) {
 		struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)buff;
 		u16 type = le16_to_cpup((__le16 *)buff);
@@ -882,7 +876,7 @@ void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size, bool is_auth)
 		if (vif->monitor_flag)
 			wilc_wfi_monitor_rx(wilc->monitor_dev, buff, size);
 	}
-	srcu_read_unlock(&wilc->srcu, srcu_idx);
+	rcu_read_unlock();
 }
 
 static const struct net_device_ops wilc_netdev_ops = {
@@ -912,7 +906,7 @@ void wilc_netdev_cleanup(struct wilc *wilc)
 		list_del_rcu(&vif->list);
 		wilc->vif_num--;
 		mutex_unlock(&wilc->vif_mutex);
-		synchronize_srcu(&wilc->srcu);
+		synchronize_rcu();
 		if (vif->ndev)
 			unregister_netdev(vif->ndev);
 	}
@@ -931,16 +925,15 @@ static u8 wilc_get_available_idx(struct wilc *wl)
 {
 	int idx = 0;
 	struct wilc_vif *vif;
-	int srcu_idx;
 
-	srcu_idx = srcu_read_lock(&wl->srcu);
+	rcu_read_lock();
 	wilc_for_each_vif(wl, vif) {
 		if (vif->idx == 0)
 			idx = 1;
 		else
 			idx = 0;
 	}
-	srcu_read_unlock(&wl->srcu, srcu_idx);
+	rcu_read_unlock();
 	return idx;
 }
 
@@ -990,7 +983,7 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 	list_add_tail_rcu(&vif->list, &wl->vif_list);
 	wl->vif_num += 1;
 	mutex_unlock(&wl->vif_mutex);
-	synchronize_srcu(&wl->srcu);
+	synchronize_rcu();
 
 	return vif;
 
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index 5937d6d45695..eecee3973d6a 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -32,8 +32,8 @@
 
 #define wilc_for_each_vif(w, v) \
 	struct wilc *_w = w; \
-	list_for_each_entry_srcu(v, &_w->vif_list, list, \
-				 srcu_read_lock_held(&_w->srcu))
+	list_for_each_entry_rcu(v, &_w->vif_list, list, \
+				 rcu_read_lock_held())
 
 struct wilc_wfi_stats {
 	unsigned long rx_packets;
@@ -220,7 +220,6 @@ struct wilc {
 
 	/* protect vif list */
 	struct mutex vif_mutex;
-	struct srcu_struct srcu;
 	u8 open_ifcs;
 
 	/* protect head of transmit queue */
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index a9e872a7b2c3..37c32d17856e 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -712,7 +712,6 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 	u32 *vmm_table = wilc->vmm_table;
 	u8 ac_pkt_num_to_chip[NQUEUES] = {0, 0, 0, 0};
 	const struct wilc_hif_func *func;
-	int srcu_idx;
 	u8 *txb = wilc->tx_buffer;
 	struct wilc_vif *vif;
 
@@ -724,10 +723,10 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 
 	mutex_lock(&wilc->txq_add_to_head_cs);
 
-	srcu_idx = srcu_read_lock(&wilc->srcu);
+	rcu_read_lock();
 	wilc_for_each_vif(wilc, vif)
 		wilc_wlan_txq_filter_dup_tcp_ack(vif->ndev);
-	srcu_read_unlock(&wilc->srcu, srcu_idx);
+	rcu_read_unlock();
 
 	for (ac = 0; ac < NQUEUES; ac++)
 		tqe_q[ac] = wilc_wlan_txq_get_first(wilc, ac);

-- 
2.44.0


