Return-Path: <linux-kernel+bounces-114958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25834888C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AC71F2852A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E4D2DD9F5;
	Mon, 25 Mar 2024 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNBjB5fD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE05A7A8;
	Sun, 24 Mar 2024 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323694; cv=none; b=BfHHS95IonJZFbOFF0cYP2QrS0YbnbDZ9lU1s8eW1bc+W8MbF3pIumHg18a55QLpA0hU9OtSiqhQTdQ60rFsnMeVQlpnWoV0Nhd3m0EeDq/oVKxsWKcJITz1+UcfsV9a9Ttnp8w7gyqU04ftFt7xXTi3NpQPjuOkBDHF6/XhpeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323694; c=relaxed/simple;
	bh=L7J2W61y/kZ4llxw1sQsqpzpY5VckUHNs+De/7aHmLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnTl+MyP6FD4kwcPpFG2egPrxJllxa6tHgP7u2q/HM9m0yKiGCGyi85HijvzKRPVWgOFcyAP5JllvCYNChEenIIZUfoXzKM+e+VnIDWlTx5ptnNnPKwA9v/cRXjNocX1kpDESexry8qLoHYxoqn0NnSI8Crljfk/iFuAefWuPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNBjB5fD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4260CC433C7;
	Sun, 24 Mar 2024 23:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323692;
	bh=L7J2W61y/kZ4llxw1sQsqpzpY5VckUHNs+De/7aHmLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNBjB5fDmSJQAFR/M3ClUTW4WaXCTCpiMyZMEwhNm7QQZy3GK94v9UOb3XQcTtaRc
	 s5myuOMYt7fxrHbb/AFuGZqoWyEmBoIeJZ1p4kJSToQlpAU0Rme8ol/csx4mo5sTHA
	 HR7O0emRXU0BeSizTGUGtcq1oN4Sizbun2f5LJGe7ROVLHgESOFXYM6i/aCPhW4Pki
	 bRcQejxqv87LFVlWMRxwEUpGwiC5HQ4QxzFup3OIpjDhlB1w2SC012XTouq3Z9aoM0
	 GdWuywunBZjT6sAS+23UHVW67rq69xtnpSYe/SF+gQRHfe1FXnUa9Zz2JvRQ4NckjJ
	 Wzm1RwtdCyL5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 065/238] wireless: Remove redundant 'flush_workqueue()' calls
Date: Sun, 24 Mar 2024 19:37:33 -0400
Message-ID: <20240324234027.1354210-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index d0967bb1f3871..57ac80997319b 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -3381,13 +3381,10 @@ EXPORT_SYMBOL(ath10k_core_create);
 
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
index 0fe639710a8bb..9d1b0890f3105 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2651,7 +2651,6 @@ static void ath10k_sdio_remove(struct sdio_func *func)
 
 	ath10k_core_destroy(ar);
 
-	flush_workqueue(ar_sdio->workqueue);
 	destroy_workqueue(ar_sdio->workqueue);
 }
 
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index ef0ac42a55a2a..55c00a07bc4d3 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3831,7 +3831,6 @@ il3945_pci_remove(struct pci_dev *pdev)
 	il3945_unset_hw_params(il);
 
 	/*netif_stop_queue(dev); */
-	flush_workqueue(il->workqueue);
 
 	/* ieee80211_unregister_hw calls il3945_mac_stop, which flushes
 	 * il->workqueue... so we can't take down the workqueue
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 12cf22d0e9949..2549902552e1d 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -6745,7 +6745,6 @@ il4965_pci_remove(struct pci_dev *pdev)
 	il_eeprom_free(il);
 
 	/*netif_stop_queue(dev); */
-	flush_workqueue(il->workqueue);
 
 	/* ieee80211_unregister_hw calls il_mac_stop, which flushes
 	 * il->workqueue... so we can't take down the workqueue
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 461af58311561..6a19fc4c68604 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1526,7 +1526,6 @@ static void iwl_op_mode_dvm_stop(struct iwl_op_mode *op_mode)
 	kfree(priv->nvm_data);
 
 	/*netif_stop_queue(dev); */
-	flush_workqueue(priv->workqueue);
 
 	/* ieee80211_unregister_hw calls iwlagn_mac_stop, which flushes
 	 * priv->workqueue... so we can't take down the workqueue
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 2f5f1ff22a601..e1196c565a62f 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3155,13 +3155,11 @@ int mwifiex_del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 		unregister_netdevice(wdev->netdev);
 
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
index 6283df5aaaf8b..b8b79fe50dbc2 100644
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
index c508f429984ab..463f3bfc3064d 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -840,7 +840,6 @@ void wilc_netdev_cleanup(struct wilc *wilc)
 	srcu_read_unlock(&wilc->srcu, srcu_idx);
 
 	wilc_wfi_deinit_mon_interface(wilc, false);
-	flush_workqueue(wilc->hif_workqueue);
 	destroy_workqueue(wilc->hif_workqueue);
 
 	while (ifc_cnt < WILC_NUM_CONCURRENT_IFC) {
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index bf6dbeb618423..d39c210da68e2 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -816,13 +816,11 @@ void qtnf_core_detach(struct qtnf_bus *bus)
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
index 0f328ce47fee3..f65eb6e5b8d59 100644
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
index dc076d8448680..75c78e1c924b0 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -3497,7 +3497,6 @@ static int rndis_wlan_bind(struct usbnet *usbdev, struct usb_interface *intf)
 	cancel_delayed_work_sync(&priv->dev_poller_work);
 	cancel_delayed_work_sync(&priv->scan_work);
 	cancel_work_sync(&priv->work);
-	flush_workqueue(priv->workqueue);
 	destroy_workqueue(priv->workqueue);
 
 	wiphy_free(wiphy);
@@ -3514,7 +3513,6 @@ static void rndis_wlan_unbind(struct usbnet *usbdev, struct usb_interface *intf)
 	cancel_delayed_work_sync(&priv->dev_poller_work);
 	cancel_delayed_work_sync(&priv->scan_work);
 	cancel_work_sync(&priv->work);
-	flush_workqueue(priv->workqueue);
 	destroy_workqueue(priv->workqueue);
 
 	rndis_unbind(usbdev, intf);
diff --git a/drivers/net/wireless/st/cw1200/bh.c b/drivers/net/wireless/st/cw1200/bh.c
index 02efe8483cba6..361fef6e1eeaa 100644
--- a/drivers/net/wireless/st/cw1200/bh.c
+++ b/drivers/net/wireless/st/cw1200/bh.c
@@ -88,8 +88,6 @@ void cw1200_unregister_bh(struct cw1200_common *priv)
 	atomic_add(1, &priv->bh_term);
 	wake_up(&priv->bh_wq);
 
-	flush_workqueue(priv->bh_workqueue);
-
 	destroy_workqueue(priv->bh_workqueue);
 	priv->bh_workqueue = NULL;
 
-- 
2.43.0


