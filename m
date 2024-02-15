Return-Path: <linux-kernel+bounces-67205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FA4856803
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2471C23AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D3313475D;
	Thu, 15 Feb 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GNgUuo3p"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4C13342D;
	Thu, 15 Feb 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011409; cv=none; b=pcNy8dIkfPztYupzhG0hkbd2HgcLec62TgMfIq5g46LGoMw8JznShWGpDmtkHEl3H3M6ipnygfh1qzECG3O3ah/fGMEiv/rLsitbNxgJkWrGauhqpAoOfl27SFxnI5Clj2/3KamRWeZh4wlFN442HQOpCLoHSbUDe9s+gDyx5WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011409; c=relaxed/simple;
	bh=BxAOFkUP4iRL98GQdrV6/DMrbxQl1cxReGxdIfRstag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qd2cq+hVjJ0Kh4L/IUJsX8uQC7ZZs2NEoDlv2UVNXBnzfHGP8SVZ1zjYX1CZHmkE3GZkrB7QdUqRXUVWXUcfbWMoSH7cmIJhnZ98Q3dn9jIzjpV87nlvwesicWGHTiWOzynexCfzvd11LL9s9hNy6J65eqori59c/acer6s5qkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GNgUuo3p; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 6168AC876A;
	Thu, 15 Feb 2024 15:36:39 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A095FF80B;
	Thu, 15 Feb 2024 15:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708011391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CatHaPHO4AUyx9Hizn0RVmrF6aR/HcBdRVPvFBw9m6U=;
	b=GNgUuo3pbQo0YO+AL4XWiGwUSpOr7QimMeED7GZH2WvB4YD2TcBvP5oaLQWcbdEnMIQ0DJ
	gLfnwi5isGwwbredB5yjBrRmBZ45PmoTbfXMe06n6Emb7UaJZjxlEKG7dtu0XKs9LPKsLt
	oWaWQsQMHKwOrbU8BfDrk0WmR9hQkbxkTM0LdXZclNthVoqo9m/lfkMvy4605uHJ2QcJjD
	SV5CBaxI+TS3jSAf3bC97fc8tzgeVn2owNUPqTANrmelhD8qjhlROXqVoGlSGI+yb9Tv0Y
	TkHubf6KrMPzqn3n9DZNkI8iWoZGae4zdbjsrPR2fP5GaIoKyNVrTNaa/gckjQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 15 Feb 2024 16:36:19 +0100
Subject: [PATCH 2/4] wifi: wilc1000: use SRCU instead of RCU for vif list
 traversal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240215-wilc_fix_rcu_usage-v1-2-f610e46c6f82@bootlin.com>
References: <20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com>
In-Reply-To: <20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

Enabling CONFIG_PROVE_RCU_LIST raises many warnings in wilc driver, even on
some places already protected by a read critical section. An example of
such case is in wilc_get_available_idx:

=============================
WARNING: suspicious RCU usage
6.8.0-rc1+ #32 Not tainted
-----------------------------
drivers/net/wireless/microchip/wilc1000/netdev.c:944 RCU-list traversed in non-reader section!!
[...]
stack backtrace:
CPU: 0 PID: 26 Comm: kworker/0:3 Not tainted 6.8.0-rc1+ #32
Hardware name: Atmel SAMA5
Workqueue: events_freezable mmc_rescan
 unwind_backtrace from show_stack+0x18/0x1c
 show_stack from dump_stack_lvl+0x34/0x58
 dump_stack_lvl from wilc_netdev_ifc_init+0x788/0x8ec
 wilc_netdev_ifc_init from wilc_cfg80211_init+0x690/0x910
 wilc_cfg80211_init from wilc_sdio_probe+0x168/0x490
 wilc_sdio_probe from sdio_bus_probe+0x230/0x3f4
 sdio_bus_probe from really_probe+0x270/0xdf4
 really_probe from __driver_probe_device+0x1dc/0x580
 __driver_probe_device from driver_probe_device+0x60/0x140
 driver_probe_device from __device_attach_driver+0x268/0x364
 __device_attach_driver from bus_for_each_drv+0x15c/0x1cc
 bus_for_each_drv from __device_attach+0x1ec/0x3e8
 __device_attach from bus_probe_device+0x190/0x1c0
 bus_probe_device from device_add+0x10dc/0x18e4
 device_add from sdio_add_func+0x1c0/0x2c0
 sdio_add_func from mmc_attach_sdio+0xa08/0xe1c
 mmc_attach_sdio from mmc_rescan+0xa00/0xfe0
 mmc_rescan from process_one_work+0x8d4/0x169c
 process_one_work from worker_thread+0x8cc/0x1340
 worker_thread from kthread+0x448/0x510
 kthread from ret_from_fork+0x14/0x28

This warning is due to the section being protected by a srcu critical read
section, but the list traversal being done with classic RCU API. Fix the
warning by using corresponding SRCU read lock/unlock APIs. While doing so,
since we always manipulate the same list (managed through a pointer
embedded in struct_wilc), add a macro to reduce the corresponding
boilerplate in each call site.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  2 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |  2 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 14 +++++++-------
 drivers/net/wireless/microchip/wilc1000/netdev.h   |  6 ++++++
 drivers/net/wireless/microchip/wilc1000/wlan.c     |  2 +-
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index f03fd15c0c97..33f8e3a41937 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1518,7 +1518,7 @@ static struct wilc_vif *wilc_get_vif_from_type(struct wilc *wl, int type)
 {
 	struct wilc_vif *vif;
 
-	list_for_each_entry_rcu(vif, &wl->vif_list, list) {
+	wilc_for_each_vif(wl, vif) {
 		if (vif->iftype == type)
 			return vif;
 	}
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index d2b8c2630819..f3800aa9e9f8 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -107,7 +107,7 @@ static struct wilc_vif *wilc_get_vif_from_idx(struct wilc *wilc, int idx)
 	if (index < 0 || index >= WILC_NUM_CONCURRENT_IFC)
 		return NULL;
 
-	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+	wilc_for_each_vif(wilc, vif) {
 		if (vif->idx == index)
 			return vif;
 	}
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 62414ab8846e..96f239adc078 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -96,7 +96,7 @@ static struct net_device *get_if_handler(struct wilc *wilc, u8 *mac_header)
 	struct wilc_vif *vif;
 	struct ieee80211_hdr *h = (struct ieee80211_hdr *)mac_header;
 
-	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+	wilc_for_each_vif(wilc, vif) {
 		if (vif->iftype == WILC_STATION_MODE)
 			if (ether_addr_equal_unaligned(h->addr2, vif->bssid)) {
 				ndev = vif->ndev;
@@ -132,7 +132,7 @@ int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc)
 	struct wilc_vif *vif;
 
 	srcu_idx = srcu_read_lock(&wilc->srcu);
-	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+	wilc_for_each_vif(wilc, vif) {
 		if (!is_zero_ether_addr(vif->bssid))
 			ret_val++;
 	}
@@ -146,7 +146,7 @@ static void wilc_wake_tx_queues(struct wilc *wl)
 	struct wilc_vif *ifc;
 
 	srcu_idx = srcu_read_lock(&wl->srcu);
-	list_for_each_entry_rcu(ifc, &wl->vif_list, list) {
+	wilc_for_each_vif(wl, ifc) {
 		if (ifc->mac_opened && netif_queue_stopped(ifc->ndev))
 			netif_wake_queue(ifc->ndev);
 	}
@@ -668,7 +668,7 @@ static int wilc_set_mac_addr(struct net_device *dev, void *p)
 	/* Verify MAC Address is not already in use: */
 
 	srcu_idx = srcu_read_lock(&wilc->srcu);
-	list_for_each_entry_rcu(tmp_vif, &wilc->vif_list, list) {
+	wilc_for_each_vif(wilc, tmp_vif) {
 		wilc_get_mac_address(tmp_vif, mac_addr);
 		if (ether_addr_equal(addr->sa_data, mac_addr)) {
 			if (vif != tmp_vif) {
@@ -771,7 +771,7 @@ netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
 		struct wilc_vif *vif;
 
 		srcu_idx = srcu_read_lock(&wilc->srcu);
-		list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+		wilc_for_each_vif(wilc, vif) {
 			if (vif->mac_opened)
 				netif_stop_queue(vif->ndev);
 		}
@@ -858,7 +858,7 @@ void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size, bool is_auth)
 	struct wilc_vif *vif;
 
 	srcu_idx = srcu_read_lock(&wilc->srcu);
-	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
+	wilc_for_each_vif(wilc, vif) {
 		struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)buff;
 		u16 type = le16_to_cpup((__le16 *)buff);
 		u32 type_bit = BIT(type >> 4);
@@ -930,7 +930,7 @@ static u8 wilc_get_available_idx(struct wilc *wl)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&wl->srcu);
-	list_for_each_entry_rcu(vif, &wl->vif_list, list) {
+	wilc_for_each_vif(wl, vif) {
 		if (vif->idx == 0)
 			idx = 1;
 		else
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index aafe3dc44ac6..5937d6d45695 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -13,6 +13,7 @@
 #include <net/ieee80211_radiotap.h>
 #include <linux/if_arp.h>
 #include <linux/gpio/consumer.h>
+#include <linux/rculist.h>
 
 #include "hif.h"
 #include "wlan.h"
@@ -29,6 +30,11 @@
 
 #define TX_BACKOFF_WEIGHT_MS			1
 
+#define wilc_for_each_vif(w, v) \
+	struct wilc *_w = w; \
+	list_for_each_entry_srcu(v, &_w->vif_list, list, \
+				 srcu_read_lock_held(&_w->srcu))
+
 struct wilc_wfi_stats {
 	unsigned long rx_packets;
 	unsigned long tx_packets;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 68be233c36ce..a9e872a7b2c3 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -725,7 +725,7 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 	mutex_lock(&wilc->txq_add_to_head_cs);
 
 	srcu_idx = srcu_read_lock(&wilc->srcu);
-	list_for_each_entry_rcu(vif, &wilc->vif_list, list)
+	wilc_for_each_vif(wilc, vif)
 		wilc_wlan_txq_filter_dup_tcp_ack(vif->ndev);
 	srcu_read_unlock(&wilc->srcu, srcu_idx);
 

-- 
2.43.0


