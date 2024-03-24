Return-Path: <linux-kernel+bounces-114798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563A889254
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F7D1C2DFF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844E245908;
	Mon, 25 Mar 2024 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORwZ98Ca"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C89276C7F;
	Sun, 24 Mar 2024 23:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323402; cv=none; b=V42S4jO07gJ0VLQTtCd9f3G61kN/FieAmBCfOqYTLPgCA/bWSuc2jPO9CJJsMq9vLyDqpkelaC+6w1X9ruZbrF4hU+wIS/rUkkttVcRuxgxD/pN0VB3L3LvohYTbQaAmqRGn0xSHRyp48gx30reCbdQ3yQay8bsnPgI8NHS3UtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323402; c=relaxed/simple;
	bh=Fj4RZVYN42SS7tkI0d9ziQCF24UjPm7Cxt1hwEcWJlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtYekrsXJgVi7OD4Fg1Fq1Dj8HGs4CAhPYJgmawXIi8PeiJbsqj81+PPa5BHa0/TB0dkWfBnGGpwlMQ2/2o2vkrpAA1p33mYPFPn2pl/SJzxdi/rTlRzfB/kGtKATve/QYN2hrm8lNmFsWtXPEx8ifUq9FM3a61QHy04h/BKPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORwZ98Ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D737FC433C7;
	Sun, 24 Mar 2024 23:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323401;
	bh=Fj4RZVYN42SS7tkI0d9ziQCF24UjPm7Cxt1hwEcWJlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORwZ98Ca3VrjT7MCFyMe1X7RVI2YSQzIQGiyfDa2nt1oQvrG8U+lI53G1fmgIORuG
	 R6r6PC9I01vPXR4PvgITnH1Krqn/DRkAy/68xHXWx7HjpAyPBolV7WsXtEXorMfD1h
	 cpggdyvlVD08C+pgduoaCZek8Gf23Mxp+0Np+f5LnadBc5gF0eOXRTJ7543duwhR2M
	 EsJ6azz5J1V3PiIV3iLgXhTF0vkSFdwRJkYn62kJQOr/lU8BAOLJew+PKlCuxAgjDs
	 y2OSYk6KI9LDxH7tIEwxZUZi1FXGspPbOcLAMloV+NSJt6Jnh6tG4NPXaj5xD9VG9n
	 UfcWbw/YvXiSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 102/317] wireless: Remove redundant 'flush_workqueue()' calls
Date: Sun, 24 Mar 2024 19:31:22 -0400
Message-ID: <20240324233458.1352854-103-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ff1cc2fa3055ee4c83839f38b74b4ee370a2291c ]

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- 	flush_workqueue(E);
	destroy_workqueue(E);

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/0855d51423578ad019c0264dad3fe47a2e8af9c7.1633849511.git.christophe.jaillet@wanadoo.fr
Stable-dep-of: cb5942b77c05 ("wifi: wilc1000: prevent use-after-free on vif when cleaning up all interfaces")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/core.c             | 3 ---
 drivers/net/wireless/ath/ath10k/sdio.c             | 1 -
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     | 1 -
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     | 1 -
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      | 1 -
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    | 2 --
 drivers/net/wireless/marvell/mwifiex/main.c        | 2 --
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 1 -
 drivers/net/wireless/quantenna/qtnfmac/core.c      | 2 --
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c | 2 --
 drivers/net/wireless/realtek/rtlwifi/pci.c         | 1 -
 drivers/net/wireless/rndis_wlan.c                  | 2 --
 drivers/net/wireless/st/cw1200/bh.c                | 2 --
 13 files changed, 21 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 58e86e662ab83..eca24a61165ee 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -3544,13 +3544,10 @@ EXPORT_SYMBOL(ath10k_core_create);
 
 void ath10k_core_destroy(struct ath10k *ar)
 {
-	flush_workqueue(ar->workqueue);
 	destroy_workqueue(ar->workqueue);
 
-	flush_workqueue(ar->workqueue_aux);
 	destroy_workqueue(ar->workqueue_aux);
 
-	flush_workqueue(ar->workqueue_tx_complete);
 	destroy_workqueue(ar->workqueue_tx_complete);
 
 	ath10k_debug_destroy(ar);
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index eb705214f3f0a..63e1c2d783c5f 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2650,7 +2650,6 @@ static void ath10k_sdio_remove(struct sdio_func *func)
 
 	ath10k_core_destroy(ar);
 
-	flush_workqueue(ar_sdio->workqueue);
 	destroy_workqueue(ar_sdio->workqueue);
 }
 
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 04c149ff745e9..dea0012fcdc79 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3827,7 +3827,6 @@ il3945_pci_remove(struct pci_dev *pdev)
 	il3945_unset_hw_params(il);
 
 	/*netif_stop_queue(dev); */
-	flush_workqueue(il->workqueue);
 
 	/* ieee80211_unregister_hw calls il3945_mac_stop, which flushes
 	 * il->workqueue... so we can't take down the workqueue
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index ff04282e3db03..ceab7704897de 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -6739,7 +6739,6 @@ il4965_pci_remove(struct pci_dev *pdev)
 	il_eeprom_free(il);
 
 	/*netif_stop_queue(dev); */
-	flush_workqueue(il->workqueue);
 
 	/* ieee80211_unregister_hw calls il_mac_stop, which flushes
 	 * il->workqueue... so we can't take down the workqueue
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index cc7b69fd14d37..69d1aae96bbb4 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1525,7 +1525,6 @@ static void iwl_op_mode_dvm_stop(struct iwl_op_mode *op_mode)
 	kfree(priv->nvm_data);
 
 	/*netif_stop_queue(dev); */
-	flush_workqueue(priv->workqueue);
 
 	/* ieee80211_unregister_hw calls iwlagn_mac_stop, which flushes
 	 * priv->workqueue... so we can't take down the workqueue
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 109b1bef4c707..017d9e03d652d 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3169,13 +3169,11 @@ int mwifiex_del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 		cfg80211_unregister_netdevice(wdev->netdev);
 
 	if (priv->dfs_cac_workqueue) {
-		flush_workqueue(priv->dfs_cac_workqueue);
 		destroy_workqueue(priv->dfs_cac_workqueue);
 		priv->dfs_cac_workqueue = NULL;
 	}
 
 	if (priv->dfs_chan_sw_workqueue) {
-		flush_workqueue(priv->dfs_chan_sw_workqueue);
 		destroy_workqueue(priv->dfs_chan_sw_workqueue);
 		priv->dfs_chan_sw_workqueue = NULL;
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 17399d4aa1290..7943fd3b3058d 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -498,13 +498,11 @@ static void mwifiex_free_adapter(struct mwifiex_adapter *adapter)
 static void mwifiex_terminate_workqueue(struct mwifiex_adapter *adapter)
 {
 	if (adapter->workqueue) {
-		flush_workqueue(adapter->workqueue);
 		destroy_workqueue(adapter->workqueue);
 		adapter->workqueue = NULL;
 	}
 
 	if (adapter->rx_workqueue) {
-		flush_workqueue(adapter->rx_workqueue);
 		destroy_workqueue(adapter->rx_workqueue);
 		adapter->rx_workqueue = NULL;
 	}
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 5e3ec20e24dad..dc91739eff8c6 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -881,7 +881,6 @@ void wilc_netdev_cleanup(struct wilc *wilc)
 	srcu_read_unlock(&wilc->srcu, srcu_idx);
 
 	wilc_wfi_deinit_mon_interface(wilc, false);
-	flush_workqueue(wilc->hif_workqueue);
 	destroy_workqueue(wilc->hif_workqueue);
 
 	while (ifc_cnt < WILC_NUM_CONCURRENT_IFC) {
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index b4dd60b2ebc90..01725237836e8 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -811,13 +811,11 @@ void qtnf_core_detach(struct qtnf_bus *bus)
 	bus->fw_state = QTNF_FW_STATE_DETACHED;
 
 	if (bus->workqueue) {
-		flush_workqueue(bus->workqueue);
 		destroy_workqueue(bus->workqueue);
 		bus->workqueue = NULL;
 	}
 
 	if (bus->hprio_workqueue) {
-		flush_workqueue(bus->hprio_workqueue);
 		destroy_workqueue(bus->hprio_workqueue);
 		bus->hprio_workqueue = NULL;
 	}
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
index 5d93c874d6669..9ad4c120fa287 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -387,7 +387,6 @@ static int qtnf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 error:
-	flush_workqueue(pcie_priv->workqueue);
 	destroy_workqueue(pcie_priv->workqueue);
 	pci_set_drvdata(pdev, NULL);
 	return ret;
@@ -416,7 +415,6 @@ static void qtnf_pcie_remove(struct pci_dev *dev)
 		qtnf_core_detach(bus);
 
 	netif_napi_del(&bus->mux_napi);
-	flush_workqueue(priv->workqueue);
 	destroy_workqueue(priv->workqueue);
 	tasklet_kill(&priv->reclaim_tq);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 679ae786cf450..6d9f2a6233a21 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1704,7 +1704,6 @@ static void rtl_pci_deinit(struct ieee80211_hw *hw)
 	tasklet_kill(&rtlpriv->works.irq_tasklet);
 	cancel_work_sync(&rtlpriv->works.lps_change_work);
 
-	flush_workqueue(rtlpriv->works.rtl_wq);
 	destroy_workqueue(rtlpriv->works.rtl_wq);
 }
 
diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis_wlan.c
index 70841d131d724..c35e9f5c2897e 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -3494,7 +3494,6 @@ static int rndis_wlan_bind(struct usbnet *usbdev, struct usb_interface *intf)
 	cancel_delayed_work_sync(&priv->dev_poller_work);
 	cancel_delayed_work_sync(&priv->scan_work);
 	cancel_work_sync(&priv->work);
-	flush_workqueue(priv->workqueue);
 	destroy_workqueue(priv->workqueue);
 
 	wiphy_free(wiphy);
@@ -3511,7 +3510,6 @@ static void rndis_wlan_unbind(struct usbnet *usbdev, struct usb_interface *intf)
 	cancel_delayed_work_sync(&priv->dev_poller_work);
 	cancel_delayed_work_sync(&priv->scan_work);
 	cancel_work_sync(&priv->work);
-	flush_workqueue(priv->workqueue);
 	destroy_workqueue(priv->workqueue);
 
 	rndis_unbind(usbdev, intf);
diff --git a/drivers/net/wireless/st/cw1200/bh.c b/drivers/net/wireless/st/cw1200/bh.c
index 8bade5d89f12f..10e019cddcc65 100644
--- a/drivers/net/wireless/st/cw1200/bh.c
+++ b/drivers/net/wireless/st/cw1200/bh.c
@@ -85,8 +85,6 @@ void cw1200_unregister_bh(struct cw1200_common *priv)
 	atomic_inc(&priv->bh_term);
 	wake_up(&priv->bh_wq);
 
-	flush_workqueue(priv->bh_workqueue);
-
 	destroy_workqueue(priv->bh_workqueue);
 	priv->bh_workqueue = NULL;
 
-- 
2.43.0


