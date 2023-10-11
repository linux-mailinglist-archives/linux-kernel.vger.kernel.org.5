Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210CF7C5645
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjJKODX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347015AbjJKODL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:03:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C43E8;
        Wed, 11 Oct 2023 07:03:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6931FC433C7;
        Wed, 11 Oct 2023 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697032985;
        bh=pBsdQK7MCTzPLcjzg3nWmnN/eYz9+yxpVt8ibNe/wD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GY4SrYYm1sULach12gP79RuJzBdrGKH9urxWH57KQossftjhcRMSTbN8aWZLOJDAn
         oqxDZ4kf2QEJQ7HqeS76VGZoWpZAMmXbpC1tO+jS6KF55JFX+Fre+cI6xZfRUy7hHs
         /DanVd8oBgPOOPiqyrSdwaVcfqnd3XP5IqzvOdOuMvbfSa+QnGNYynYBJWoUFJUG0B
         Ld8YEx8J1Z5vl04grO2Gg5uQ8v4UFNKT/nuuaVciDJWABYjIa2fXEFY5nixlHRHmBj
         Uhx4//0V2RoZ67CS/P1Uo4JhJAiSWXfp5Kdj7rxpOmo4Ijk1sDssGZHT/JBU91F2N2
         qH7bcC+5C6vTw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rodolfo Zitellini <rwz@xhero.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 05/10] staging: rtl8192: remove unused legacy ioctl handlers
Date:   Wed, 11 Oct 2023 16:02:20 +0200
Message-Id: <20231011140225.253106-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011140225.253106-1-arnd@kernel.org>
References: <20231011140225.253106-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The .ndo_do_ioctl functions are never called, and can just be removed,
especially since this is a staging driver.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c   |  41 --
 drivers/staging/rtl8192u/ieee80211/dot11d.h   |   2 -
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  12 -
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 563 ------------------
 drivers/staging/rtl8192u/r8192U.h             |   2 -
 drivers/staging/rtl8192u/r8192U_core.c        | 109 ----
 6 files changed, 729 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index ddaf66fa0f936..8a72c1e9eb1e1 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -97,22 +97,6 @@ void dot11d_update_country_ie(struct ieee80211_device *dev, u8 *pTaddr,
 }
 EXPORT_SYMBOL(dot11d_update_country_ie);
 
-u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 Channel)
-{
-	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(dev);
-	u8 MaxTxPwrInDbm = 255;
-
-	if (Channel > MAX_CHANNEL_NUMBER) {
-		netdev_err(dev->dev, "%s: Invalid Channel\n", __func__);
-		return MaxTxPwrInDbm;
-	}
-	if (dot11d_info->channel_map[Channel])
-		MaxTxPwrInDbm = dot11d_info->max_tx_pwr_dbm_list[Channel];
-
-	return MaxTxPwrInDbm;
-}
-EXPORT_SYMBOL(dot11d_get_max_tx_pwr_in_dbm);
-
 void dot11d_scan_complete(struct ieee80211_device *dev)
 {
 	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(dev);
@@ -147,28 +131,3 @@ int is_legal_channel(struct ieee80211_device *dev, u8 channel)
 	return 0;
 }
 EXPORT_SYMBOL(is_legal_channel);
-
-int to_legal_channel(struct ieee80211_device *dev, u8 channel)
-{
-	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(dev);
-	u8 default_chn = 0;
-	u32 i = 0;
-
-	for (i = 1; i <= MAX_CHANNEL_NUMBER; i++) {
-		if (dot11d_info->channel_map[i] > 0) {
-			default_chn = i;
-			break;
-		}
-	}
-
-	if (channel > MAX_CHANNEL_NUMBER) {
-		netdev_err(dev->dev, "%s: Invalid Channel\n", __func__);
-		return default_chn;
-	}
-
-	if (dot11d_info->channel_map[channel] > 0)
-		return channel;
-
-	return default_chn;
-}
-EXPORT_SYMBOL(to_legal_channel);
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 8b485fa180898..fd774265211a5 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -49,9 +49,7 @@ void dot11d_update_country_ie(struct ieee80211_device *dev,
 			      u8 *addr,
 			      u16 coutry_ie_len,
 			      u8 *coutry_ie);
-u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 channel);
 void dot11d_scan_complete(struct ieee80211_device *dev);
 int is_legal_channel(struct ieee80211_device *dev, u8 channel);
-int to_legal_channel(struct ieee80211_device *dev, u8 channel);
 
 #endif /* #ifndef __INC_DOT11D_H */
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 694d1b18f81c7..fc4201757c408 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -223,11 +223,7 @@ struct cb_desc {
 #define MAX_IE_LEN  0xff
 
 // added for kernel conflict
-#define ieee80211_wake_queue		ieee80211_wake_queue_rsl
-#define ieee80211_stop_queue		ieee80211_stop_queue_rsl
 #define notify_wx_assoc_event		notify_wx_assoc_event_rsl
-#define SendDisassociation		SendDisassociation_rsl
-
 
 struct ieee_param {
 	u32 cmd;
@@ -2152,7 +2148,6 @@ int ieee80211_wx_set_gen_ie(struct ieee80211_device *ieee, u8 *ie, size_t len);
 
 /* ieee80211_softmac.c */
 short ieee80211_is_54g(const struct ieee80211_network *net);
-short ieee80211_is_shortslot(const struct ieee80211_network *net);
 int ieee80211_rx_frame_softmac(struct ieee80211_device *ieee,
 			       struct sk_buff *skb,
 			       struct ieee80211_rx_stats *rx_stats,
@@ -2160,7 +2155,6 @@ int ieee80211_rx_frame_softmac(struct ieee80211_device *ieee,
 void ieee80211_softmac_new_net(struct ieee80211_device *ieee,
 			       struct ieee80211_network *net);
 
-void SendDisassociation(struct ieee80211_device *ieee, u8 *asSta, u8 asRsn);
 void ieee80211_softmac_xmit(struct ieee80211_txb *txb,
 			    struct ieee80211_device *ieee);
 
@@ -2182,13 +2176,7 @@ void ieee80211_stop_protocol(struct ieee80211_device *ieee);
 void ieee80211_softmac_start_protocol(struct ieee80211_device *ieee);
 void ieee80211_softmac_stop_protocol(struct ieee80211_device *ieee);
 void ieee80211_reset_queue(struct ieee80211_device *ieee);
-void ieee80211_wake_queue(struct ieee80211_device *ieee);
-void ieee80211_stop_queue(struct ieee80211_device *ieee);
-struct sk_buff *ieee80211_get_beacon(struct ieee80211_device *ieee);
 void ieee80211_start_send_beacons(struct ieee80211_device *ieee);
-int ieee80211_wpa_supplicant_ioctl(struct ieee80211_device *ieee,
-				   struct iw_point *p);
-void ieee80211_ps_tx_ack(struct ieee80211_device *ieee, short success);
 
 void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee);
 
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 92001cb36730b..8cb2f48dbefec 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -27,12 +27,6 @@ short ieee80211_is_54g(const struct ieee80211_network *net)
 }
 EXPORT_SYMBOL(ieee80211_is_54g);
 
-short ieee80211_is_shortslot(const struct ieee80211_network *net)
-{
-	return net->capability & WLAN_CAPABILITY_SHORT_SLOT;
-}
-EXPORT_SYMBOL(ieee80211_is_shortslot);
-
 /* returns the total length needed for placing the RATE MFIE
  * tag and the EXTENDED RATE MFIE tag if needed.
  * It includes two bytes per tag for the tag itself and its len
@@ -154,21 +148,6 @@ static void enqueue_mgmt(struct ieee80211_device *ieee, struct sk_buff *skb)
 	//return 0;
 }
 
-static struct sk_buff *dequeue_mgmt(struct ieee80211_device *ieee)
-{
-	struct sk_buff *ret;
-
-	if (ieee->mgmt_queue_tail == ieee->mgmt_queue_head)
-		return NULL;
-
-	ret = ieee->mgmt_queue_ring[ieee->mgmt_queue_tail];
-
-	ieee->mgmt_queue_tail =
-		(ieee->mgmt_queue_tail + 1) % MGMT_QUEUE_NUM;
-
-	return ret;
-}
-
 static void init_mgmt_queue(struct ieee80211_device *ieee)
 {
 	ieee->mgmt_queue_tail = ieee->mgmt_queue_head = 0;
@@ -1772,33 +1751,6 @@ void ieee80211_sta_wakeup(struct ieee80211_device *ieee, short nl)
 	}
 }
 
-void ieee80211_ps_tx_ack(struct ieee80211_device *ieee, short success)
-{
-	unsigned long flags, flags2;
-
-	spin_lock_irqsave(&ieee->lock, flags);
-
-	if (ieee->sta_sleep == 2) {
-		/* Null frame with PS bit set */
-		if (success) {
-			ieee->sta_sleep = 1;
-			ieee->enter_sleep_state(ieee->dev, ieee->ps_th, ieee->ps_tl);
-		}
-		/* if the card report not success we can't be sure the AP
-		 * has not RXed so we can't assume the AP believe us awake
-		 */
-	} else {
-		/* 21112005 - tx again null without PS bit if lost */
-		if ((ieee->sta_sleep == 0) && !success) {
-			spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
-			ieee80211_sta_ps_send_null_frame(ieee, 0);
-			spin_unlock_irqrestore(&ieee->mgmt_tx_lock, flags2);
-		}
-	}
-	spin_unlock_irqrestore(&ieee->lock, flags);
-}
-EXPORT_SYMBOL(ieee80211_ps_tx_ack);
-
 static void ieee80211_process_action(struct ieee80211_device *ieee,
 				     struct sk_buff *skb)
 {
@@ -2068,7 +2020,6 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 			 * to check it any more.
 			 * */
 			//printk("error:no descriptor left@queue_index %d\n", queue_index);
-			//ieee80211_stop_queue(ieee);
 #ifdef USB_TX_DRIVER_AGGREGATION_ENABLE
 			skb_queue_tail(&ieee->skb_drv_aggQ[queue_index], txb->fragments[i]);
 #else
@@ -2089,27 +2040,6 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 }
 EXPORT_SYMBOL(ieee80211_softmac_xmit);
 
-/* called with ieee->lock acquired */
-static void ieee80211_resume_tx(struct ieee80211_device *ieee)
-{
-	int i;
-	for (i = ieee->tx_pending.frag; i < ieee->tx_pending.txb->nr_frags; i++) {
-		if (ieee->queue_stop) {
-			ieee->tx_pending.frag = i;
-			return;
-		} else {
-			ieee->softmac_data_hard_start_xmit(ieee->tx_pending.txb->fragments[i],
-							   ieee->dev, ieee->rate);
-			//(i+1)<ieee->tx_pending.txb->nr_frags);
-			ieee->stats.tx_packets++;
-			netif_trans_update(ieee->dev);
-		}
-	}
-
-	ieee80211_txb_free(ieee->tx_pending.txb);
-	ieee->tx_pending.txb = NULL;
-}
-
 void ieee80211_reset_queue(struct ieee80211_device *ieee)
 {
 	unsigned long flags;
@@ -2125,59 +2055,6 @@ void ieee80211_reset_queue(struct ieee80211_device *ieee)
 }
 EXPORT_SYMBOL(ieee80211_reset_queue);
 
-void ieee80211_wake_queue(struct ieee80211_device *ieee)
-{
-	unsigned long flags;
-	struct sk_buff *skb;
-	struct rtl_80211_hdr_3addr  *header;
-
-	spin_lock_irqsave(&ieee->lock, flags);
-	if (!ieee->queue_stop)
-		goto exit;
-
-	ieee->queue_stop = 0;
-
-	if (ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE) {
-		while (!ieee->queue_stop && (skb = dequeue_mgmt(ieee))) {
-			header = (struct rtl_80211_hdr_3addr  *)skb->data;
-
-			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
-
-			if (ieee->seq_ctrl[0] == 0xFFF)
-				ieee->seq_ctrl[0] = 0;
-			else
-				ieee->seq_ctrl[0]++;
-
-			ieee->softmac_data_hard_start_xmit(skb, ieee->dev, ieee->basic_rate);
-			//dev_kfree_skb_any(skb);//edit by thomas
-		}
-	}
-	if (!ieee->queue_stop && ieee->tx_pending.txb)
-		ieee80211_resume_tx(ieee);
-
-	if (!ieee->queue_stop && netif_queue_stopped(ieee->dev)) {
-		ieee->softmac_stats.swtxawake++;
-		netif_wake_queue(ieee->dev);
-	}
-exit:
-	spin_unlock_irqrestore(&ieee->lock, flags);
-}
-EXPORT_SYMBOL(ieee80211_wake_queue);
-
-void ieee80211_stop_queue(struct ieee80211_device *ieee)
-{
-	//unsigned long flags;
-	//spin_lock_irqsave(&ieee->lock,flags);
-
-	if (!netif_queue_stopped(ieee->dev)) {
-		netif_stop_queue(ieee->dev);
-		ieee->softmac_stats.swtxstop++;
-	}
-	ieee->queue_stop = 1;
-	//spin_unlock_irqrestore(&ieee->lock,flags);
-}
-EXPORT_SYMBOL(ieee80211_stop_queue);
-
 /* called in user context only */
 void ieee80211_start_master_bss(struct ieee80211_device *ieee)
 {
@@ -2438,27 +2315,6 @@ struct sk_buff *ieee80211_get_beacon_(struct ieee80211_device *ieee)
 	return skb;
 }
 
-struct sk_buff *ieee80211_get_beacon(struct ieee80211_device *ieee)
-{
-	struct sk_buff *skb;
-	struct ieee80211_probe_response *b;
-
-	skb = ieee80211_get_beacon_(ieee);
-	if (!skb)
-		return NULL;
-
-	b = (struct ieee80211_probe_response *)skb->data;
-	b->header.seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
-
-	if (ieee->seq_ctrl[0] == 0xFFF)
-		ieee->seq_ctrl[0] = 0;
-	else
-		ieee->seq_ctrl[0]++;
-
-	return skb;
-}
-EXPORT_SYMBOL(ieee80211_get_beacon);
-
 void ieee80211_softmac_stop_protocol(struct ieee80211_device *ieee)
 {
 	ieee->sync_scan_hurryup = 1;
@@ -2623,425 +2479,6 @@ void ieee80211_softmac_free(struct ieee80211_device *ieee)
 	mutex_unlock(&ieee->wx_mutex);
 }
 
-/********************************************************
- * Start of WPA code.                                   *
- * this is stolen from the ipw2200 driver               *
- ********************************************************/
-static int ieee80211_wpa_enable(struct ieee80211_device *ieee, int value)
-{
-	/* This is called when wpa_supplicant loads and closes the driver
-	 * interface. */
-	printk("%s WPA\n", value ? "enabling" : "disabling");
-	ieee->wpa_enabled = value;
-	return 0;
-}
-
-static void ieee80211_wpa_assoc_frame(struct ieee80211_device *ieee,
-				      char *wpa_ie, int wpa_ie_len)
-{
-	/* make sure WPA is enabled */
-	ieee80211_wpa_enable(ieee, 1);
-
-	ieee80211_disassociate(ieee);
-}
-
-static int ieee80211_wpa_mlme(struct ieee80211_device *ieee, int command, int reason)
-{
-	int ret = 0;
-
-	switch (command) {
-	case IEEE_MLME_STA_DEAUTH:
-		// silently ignore
-		break;
-
-	case IEEE_MLME_STA_DISASSOC:
-		ieee80211_disassociate(ieee);
-		break;
-
-	default:
-		printk("Unknown MLME request: %d\n", command);
-		ret = -EOPNOTSUPP;
-	}
-
-	return ret;
-}
-
-static int ieee80211_wpa_set_wpa_ie(struct ieee80211_device *ieee,
-			      struct ieee_param *param, int plen)
-{
-	u8 *buf;
-
-	if (param->u.wpa_ie.len > MAX_WPA_IE_LEN)
-		return -EINVAL;
-
-	if (param->u.wpa_ie.len) {
-		buf = kmemdup(param->u.wpa_ie.data, param->u.wpa_ie.len,
-			      GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-
-		kfree(ieee->wpa_ie);
-		ieee->wpa_ie = buf;
-		ieee->wpa_ie_len = param->u.wpa_ie.len;
-	} else {
-		kfree(ieee->wpa_ie);
-		ieee->wpa_ie = NULL;
-		ieee->wpa_ie_len = 0;
-	}
-
-	ieee80211_wpa_assoc_frame(ieee, ieee->wpa_ie, ieee->wpa_ie_len);
-	return 0;
-}
-
-#define AUTH_ALG_OPEN_SYSTEM			0x1
-#define AUTH_ALG_SHARED_KEY			0x2
-
-static int ieee80211_wpa_set_auth_algs(struct ieee80211_device *ieee, int value)
-{
-	struct ieee80211_security sec = {
-		.flags = SEC_AUTH_MODE,
-	};
-
-	if (value & AUTH_ALG_SHARED_KEY) {
-		sec.auth_mode = WLAN_AUTH_SHARED_KEY;
-		ieee->open_wep = 0;
-		ieee->auth_mode = 1;
-	} else if (value & AUTH_ALG_OPEN_SYSTEM) {
-		sec.auth_mode = WLAN_AUTH_OPEN;
-		ieee->open_wep = 1;
-		ieee->auth_mode = 0;
-	} else if (value & IW_AUTH_ALG_LEAP) {
-		sec.auth_mode = WLAN_AUTH_LEAP;
-		ieee->open_wep = 1;
-		ieee->auth_mode = 2;
-	}
-
-	if (ieee->set_security)
-		ieee->set_security(ieee->dev, &sec);
-	//else
-	//	ret = -EOPNOTSUPP;
-
-	return 0;
-}
-
-static int ieee80211_wpa_set_param(struct ieee80211_device *ieee, u8 name, u32 value)
-{
-	int ret = 0;
-	unsigned long flags;
-
-	switch (name) {
-	case IEEE_PARAM_WPA_ENABLED:
-		ret = ieee80211_wpa_enable(ieee, value);
-		break;
-
-	case IEEE_PARAM_TKIP_COUNTERMEASURES:
-		ieee->tkip_countermeasures = value;
-		break;
-
-	case IEEE_PARAM_DROP_UNENCRYPTED: {
-		/* HACK:
-		 *
-		 * wpa_supplicant calls set_wpa_enabled when the driver
-		 * is loaded and unloaded, regardless of if WPA is being
-		 * used.  No other calls are made which can be used to
-		 * determine if encryption will be used or not prior to
-		 * association being expected.  If encryption is not being
-		 * used, drop_unencrypted is set to false, else true -- we
-		 * can use this to determine if the CAP_PRIVACY_ON bit should
-		 * be set.
-		 */
-		struct ieee80211_security sec = {
-			.flags = SEC_ENABLED,
-			.enabled = value,
-		};
-		ieee->drop_unencrypted = value;
-		/* We only change SEC_LEVEL for open mode. Others
-		 * are set by ipw_wpa_set_encryption.
-		 */
-		if (!value) {
-			sec.flags |= SEC_LEVEL;
-			sec.level = SEC_LEVEL_0;
-		} else {
-			sec.flags |= SEC_LEVEL;
-			sec.level = SEC_LEVEL_1;
-		}
-		if (ieee->set_security)
-			ieee->set_security(ieee->dev, &sec);
-		break;
-	}
-
-	case IEEE_PARAM_PRIVACY_INVOKED:
-		ieee->privacy_invoked = value;
-		break;
-
-	case IEEE_PARAM_AUTH_ALGS:
-		ret = ieee80211_wpa_set_auth_algs(ieee, value);
-		break;
-
-	case IEEE_PARAM_IEEE_802_1X:
-		ieee->ieee802_1x = value;
-		break;
-	case IEEE_PARAM_WPAX_SELECT:
-		// added for WPA2 mixed mode
-		spin_lock_irqsave(&ieee->wpax_suitlist_lock, flags);
-		ieee->wpax_type_set = 1;
-		ieee->wpax_type_notify = value;
-		spin_unlock_irqrestore(&ieee->wpax_suitlist_lock, flags);
-		break;
-
-	default:
-		printk("Unknown WPA param: %d\n", name);
-		ret = -EOPNOTSUPP;
-	}
-
-	return ret;
-}
-
-/* implementation borrowed from hostap driver */
-static int ieee80211_wpa_set_encryption(struct ieee80211_device *ieee,
-				  struct ieee_param *param, int param_len)
-{
-	int ret = 0;
-	const char *module = NULL;
-
-	struct ieee80211_crypto_ops *ops = NULL;
-	struct ieee80211_crypt_data **crypt;
-
-	struct ieee80211_security sec = {
-		.flags = 0,
-	};
-
-	param->u.crypt.err = 0;
-	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
-
-	if (param_len !=
-	    (int)((char *)param->u.crypt.key - (char *)param) +
-	    param->u.crypt.key_len) {
-		printk("Len mismatch %d, %d\n", param_len,
-			       param->u.crypt.key_len);
-		return -EINVAL;
-	}
-	if (is_broadcast_ether_addr(param->sta_addr)) {
-		if (param->u.crypt.idx >= WEP_KEYS)
-			return -EINVAL;
-		crypt = &ieee->crypt[param->u.crypt.idx];
-	} else {
-		return -EINVAL;
-	}
-
-	if (strcmp(param->u.crypt.alg, "none") == 0) {
-		if (crypt) {
-			sec.enabled = 0;
-			// FIXME FIXME
-			//sec.encrypt = 0;
-			sec.level = SEC_LEVEL_0;
-			sec.flags |= SEC_ENABLED | SEC_LEVEL;
-			ieee80211_crypt_delayed_deinit(ieee, crypt);
-		}
-		goto done;
-	}
-	sec.enabled = 1;
-// FIXME FIXME
-//	sec.encrypt = 1;
-	sec.flags |= SEC_ENABLED;
-
-	/* IPW HW cannot build TKIP MIC, host decryption still needed. */
-	if (!(ieee->host_encrypt || ieee->host_decrypt) &&
-	    strcmp(param->u.crypt.alg, "TKIP"))
-		goto skip_host_crypt;
-
-	//set WEP40 first, it will be modified according to WEP104 or WEP40 at other place
-	if (!strcmp(param->u.crypt.alg, "WEP"))
-		module = "ieee80211_crypt_wep";
-	else if (!strcmp(param->u.crypt.alg, "TKIP"))
-		module = "ieee80211_crypt_tkip";
-	else if (!strcmp(param->u.crypt.alg, "CCMP"))
-		module = "ieee80211_crypt_ccmp";
-	if (module)
-		ops = try_then_request_module(ieee80211_get_crypto_ops(param->u.crypt.alg),
-					      module);
-	if (!ops) {
-		printk("unknown crypto alg '%s'\n", param->u.crypt.alg);
-		param->u.crypt.err = IEEE_CRYPT_ERR_UNKNOWN_ALG;
-		ret = -EINVAL;
-		goto done;
-	}
-
-	if (!*crypt || (*crypt)->ops != ops) {
-		struct ieee80211_crypt_data *new_crypt;
-
-		ieee80211_crypt_delayed_deinit(ieee, crypt);
-
-		new_crypt = kzalloc(sizeof(*new_crypt), GFP_KERNEL);
-		if (!new_crypt) {
-			ret = -ENOMEM;
-			goto done;
-		}
-		new_crypt->ops = ops;
-		if (new_crypt->ops && try_module_get(new_crypt->ops->owner))
-			new_crypt->priv =
-				new_crypt->ops->init(param->u.crypt.idx);
-
-		if (!new_crypt->priv) {
-			kfree(new_crypt);
-			param->u.crypt.err = IEEE_CRYPT_ERR_CRYPT_INIT_FAILED;
-			ret = -EINVAL;
-			goto done;
-		}
-
-		*crypt = new_crypt;
-	}
-
-	if (param->u.crypt.key_len > 0 && (*crypt)->ops->set_key &&
-	    (*crypt)->ops->set_key(param->u.crypt.key,
-				   param->u.crypt.key_len, param->u.crypt.seq,
-				   (*crypt)->priv) < 0) {
-		printk("key setting failed\n");
-		param->u.crypt.err = IEEE_CRYPT_ERR_KEY_SET_FAILED;
-		ret = -EINVAL;
-		goto done;
-	}
-
- skip_host_crypt:
-	if (param->u.crypt.set_tx) {
-		ieee->tx_keyidx = param->u.crypt.idx;
-		sec.active_key = param->u.crypt.idx;
-		sec.flags |= SEC_ACTIVE_KEY;
-	} else {
-		sec.flags &= ~SEC_ACTIVE_KEY;
-	}
-	memcpy(sec.keys[param->u.crypt.idx],
-	       param->u.crypt.key,
-	       param->u.crypt.key_len);
-	sec.key_sizes[param->u.crypt.idx] = param->u.crypt.key_len;
-	sec.flags |= (1 << param->u.crypt.idx);
-
-	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-		sec.flags |= SEC_LEVEL;
-		sec.level = SEC_LEVEL_1;
-	} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
-		sec.flags |= SEC_LEVEL;
-		sec.level = SEC_LEVEL_2;
-	} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-		sec.flags |= SEC_LEVEL;
-		sec.level = SEC_LEVEL_3;
-	}
- done:
-	if (ieee->set_security)
-		ieee->set_security(ieee->dev, &sec);
-
-	/* Do not reset port if card is in Managed mode since resetting will
-	 * generate new IEEE 802.11 authentication which may end up in looping
-	 * with IEEE 802.1X.  If your hardware requires a reset after WEP
-	 * configuration (for example... Prism2), implement the reset_port in
-	 * the callbacks structures used to initialize the 802.11 stack. */
-	if (ieee->reset_on_keychange &&
-	    ieee->iw_mode != IW_MODE_INFRA &&
-	    ieee->reset_port &&
-	    ieee->reset_port(ieee->dev)) {
-		printk("reset_port failed\n");
-		param->u.crypt.err = IEEE_CRYPT_ERR_CARD_CONF_FAILED;
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-static inline struct sk_buff *ieee80211_disassociate_skb(struct ieee80211_network *beacon,
-							 struct ieee80211_device *ieee,
-							 u8	asRsn)
-{
-	struct sk_buff *skb;
-	struct ieee80211_disassoc *disass;
-
-	skb = dev_alloc_skb(sizeof(struct ieee80211_disassoc));
-	if (!skb)
-		return NULL;
-
-	disass = skb_put(skb, sizeof(struct ieee80211_disassoc));
-	disass->header.frame_ctl = cpu_to_le16(IEEE80211_STYPE_DISASSOC);
-	disass->header.duration_id = 0;
-
-	memcpy(disass->header.addr1, beacon->bssid, ETH_ALEN);
-	memcpy(disass->header.addr2, ieee->dev->dev_addr, ETH_ALEN);
-	memcpy(disass->header.addr3, beacon->bssid, ETH_ALEN);
-
-	disass->reason = cpu_to_le16(asRsn);
-	return skb;
-}
-
-void
-SendDisassociation(struct ieee80211_device *ieee,
-		   u8			   *asSta,
-		   u8			    asRsn
-)
-{
-	struct ieee80211_network *beacon = &ieee->current_network;
-	struct sk_buff *skb;
-
-	skb = ieee80211_disassociate_skb(beacon, ieee, asRsn);
-	if (skb) {
-		softmac_mgmt_xmit(skb, ieee);
-		//dev_kfree_skb_any(skb);//edit by thomas
-	}
-}
-EXPORT_SYMBOL(SendDisassociation);
-
-int ieee80211_wpa_supplicant_ioctl(struct ieee80211_device *ieee, struct iw_point *p)
-{
-	struct ieee_param *param;
-	int ret = 0;
-
-	mutex_lock(&ieee->wx_mutex);
-	//IEEE_DEBUG_INFO("wpa_supplicant: len=%d\n", p->length);
-
-	if (p->length < sizeof(struct ieee_param) || !p->pointer) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	param = memdup_user(p->pointer, p->length);
-	if (IS_ERR(param)) {
-		ret = PTR_ERR(param);
-		goto out;
-	}
-
-	switch (param->cmd) {
-	case IEEE_CMD_SET_WPA_PARAM:
-		ret = ieee80211_wpa_set_param(ieee, param->u.wpa_param.name,
-					param->u.wpa_param.value);
-		break;
-
-	case IEEE_CMD_SET_WPA_IE:
-		ret = ieee80211_wpa_set_wpa_ie(ieee, param, p->length);
-		break;
-
-	case IEEE_CMD_SET_ENCRYPTION:
-		ret = ieee80211_wpa_set_encryption(ieee, param, p->length);
-		break;
-
-	case IEEE_CMD_MLME:
-		ret = ieee80211_wpa_mlme(ieee, param->u.mlme.command,
-				   param->u.mlme.reason_code);
-		break;
-
-	default:
-		printk("Unknown WPA supplicant request: %d\n", param->cmd);
-		ret = -EOPNOTSUPP;
-		break;
-	}
-
-	if (ret == 0 && copy_to_user(p->pointer, param, p->length))
-		ret = -EFAULT;
-
-	kfree(param);
-out:
-	mutex_unlock(&ieee->wx_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL(ieee80211_wpa_supplicant_ioctl);
-
 void notify_wx_assoc_event(struct ieee80211_device *ieee)
 {
 	union iwreq_data wrqu;
diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index ff0ada00bf414..ef59c785f950a 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -453,8 +453,6 @@ typedef enum _WIRELESS_MODE {
 	WIRELESS_MODE_N_5G = 0x20
 } WIRELESS_MODE;
 
-#define RTL_IOCTL_WPA_SUPPLICANT		(SIOCIWFIRSTPRIV + 30)
-
 typedef struct buffer {
 	struct buffer *next;
 	u32 *buf;
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 0a60ef20107c4..295b514043336 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -3284,114 +3284,6 @@ static int r8192_set_mac_adr(struct net_device *dev, void *mac)
 	return 0;
 }
 
-/* based on ipw2200 driver */
-static int rtl8192_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-{
-	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
-	struct iwreq *wrq = (struct iwreq *)rq;
-	int ret = -1;
-	struct ieee80211_device *ieee = priv->ieee80211;
-	u32 key[4];
-	u8 broadcast_addr[6] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-	struct iw_point *p = &wrq->u.data;
-	struct ieee_param *ipw = NULL;
-
-	mutex_lock(&priv->wx_mutex);
-
-	if (p->length < sizeof(struct ieee_param) || !p->pointer) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ipw = memdup_user(p->pointer, p->length);
-	if (IS_ERR(ipw)) {
-		ret = PTR_ERR(ipw);
-		goto out;
-	}
-
-	switch (cmd) {
-	case RTL_IOCTL_WPA_SUPPLICANT:
-		/* parse here for HW security */
-		if (ipw->cmd == IEEE_CMD_SET_ENCRYPTION) {
-			if (ipw->u.crypt.set_tx) {
-				if (strcmp(ipw->u.crypt.alg, "CCMP") == 0) {
-					ieee->pairwise_key_type = KEY_TYPE_CCMP;
-				} else if (strcmp(ipw->u.crypt.alg, "TKIP") == 0) {
-					ieee->pairwise_key_type = KEY_TYPE_TKIP;
-				} else if (strcmp(ipw->u.crypt.alg, "WEP") == 0) {
-					if (ipw->u.crypt.key_len == 13)
-						ieee->pairwise_key_type = KEY_TYPE_WEP104;
-					else if (ipw->u.crypt.key_len == 5)
-						ieee->pairwise_key_type = KEY_TYPE_WEP40;
-				} else {
-					ieee->pairwise_key_type = KEY_TYPE_NA;
-				}
-
-				if (ieee->pairwise_key_type) {
-					memcpy((u8 *)key, ipw->u.crypt.key, 16);
-					EnableHWSecurityConfig8192(dev);
-					/* We fill both index entry and 4th
-					 * entry for pairwise key as in IPW
-					 * interface, adhoc will only get here,
-					 * so we need index entry for its
-					 * default key serching!
-					 */
-					setKey(dev, 4, ipw->u.crypt.idx,
-					       ieee->pairwise_key_type,
-					       (u8 *)ieee->ap_mac_addr,
-					       0, key);
-					if (ieee->auth_mode != 2)
-						setKey(dev, ipw->u.crypt.idx,
-						       ipw->u.crypt.idx,
-						       ieee->pairwise_key_type,
-						       (u8 *)ieee->ap_mac_addr,
-						       0, key);
-				}
-			} else {
-				memcpy((u8 *)key, ipw->u.crypt.key, 16);
-				if (strcmp(ipw->u.crypt.alg, "CCMP") == 0) {
-					ieee->group_key_type = KEY_TYPE_CCMP;
-				} else if (strcmp(ipw->u.crypt.alg, "TKIP") == 0) {
-					ieee->group_key_type = KEY_TYPE_TKIP;
-				} else if (strcmp(ipw->u.crypt.alg, "WEP") == 0) {
-					if (ipw->u.crypt.key_len == 13)
-						ieee->group_key_type = KEY_TYPE_WEP104;
-					else if (ipw->u.crypt.key_len == 5)
-						ieee->group_key_type = KEY_TYPE_WEP40;
-				} else {
-					ieee->group_key_type = KEY_TYPE_NA;
-				}
-
-				if (ieee->group_key_type) {
-					setKey(dev, ipw->u.crypt.idx,
-					       /* KeyIndex */
-					       ipw->u.crypt.idx,
-					       /* KeyType */
-					       ieee->group_key_type,
-					       /* MacAddr */
-					       broadcast_addr,
-					       /* DefaultKey */
-					       0,
-					       /* KeyContent */
-					       key);
-				}
-			}
-		}
-		ret = ieee80211_wpa_supplicant_ioctl(priv->ieee80211,
-						     &wrq->u.data);
-		break;
-
-	default:
-		ret = -EOPNOTSUPP;
-		break;
-	}
-	kfree(ipw);
-	ipw = NULL;
-out:
-	mutex_unlock(&priv->wx_mutex);
-	return ret;
-}
-
 static u8 HwRateToMRate90(bool bIsHT, u8 rate)
 {
 	u8  ret_rate = 0xff;
@@ -4496,7 +4388,6 @@ static const struct net_device_ops rtl8192_netdev_ops = {
 	.ndo_stop               = rtl8192_close,
 	.ndo_get_stats          = rtl8192_stats,
 	.ndo_tx_timeout         = tx_timeout,
-	.ndo_do_ioctl           = rtl8192_ioctl,
 	.ndo_set_rx_mode	= r8192_set_multicast,
 	.ndo_set_mac_address    = r8192_set_mac_adr,
 	.ndo_validate_addr      = eth_validate_addr,
-- 
2.39.2

