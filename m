Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184337AB2B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjIVNaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjIVNaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:30:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64D61B3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405101a02bcso7332285e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695389395; x=1695994195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mz7vqOg4bSrdsOFL9TDA4eOOpgVt67cGT+nTbiIM2lw=;
        b=cIWNZXbkCYHl3OB+3qZHp9lTDoD4yaxfUatCQPhnE7pRAP7p6IrFTd6xDX+t9/e6RC
         WQDF9qbXf5GNyNugi0d6tma2aLAy+nXuT8/4K53Oa+mYkXC8ZGM2DWIf6P1zTJhbqB0t
         QO4bnYpw/oW8fg5JHbpGYnFpI3LJzSoWheoqH7BJj3Vxzb69VY4Jk0pkKP715Oz2tlLT
         IpuhlHffqmUTQSrGZig6wk/tCPLo6IAuyFEqQDN2YQjj9uyHMmjdOE0Elu/Sq1qdw58k
         S1ZzGN++FcCnEWmcGVgaz/c681CC5KtlgMdPTCEnX1/0xXldqaIny7D3GsZvUqr//mxR
         t0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695389395; x=1695994195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mz7vqOg4bSrdsOFL9TDA4eOOpgVt67cGT+nTbiIM2lw=;
        b=SQHzEcnKMssURnrxKUQay19zimwxNa5zn9DSeUhcQBkk57tpbT9HvcjEHf8UCYSw/l
         S/yedyscdzvzSkrJu6wpyQzSneIxzpq4XZ4tWlMj/Jhxqpn4RSrUsK5y+JFbKl+/Ge46
         ZgMkxt92PbZelurIVs8UdSBgcVdFslwQhiXDTBXS69iFu4y/EhtMGUqWTgIUe4PiHJG8
         jRFev9TsIf3LUMGfECbqJzARJJy2XoDV86YKaW4YOaWBqaO9rwYFQWKiCFYNBE2RATUg
         obXWdmH7jGgULihty2267ByVzdA3YbOhUGqr4NMC1c6UC2q1crfXwl6HwG1yigJrB/Uc
         DwhQ==
X-Gm-Message-State: AOJu0YxVjvQZuyrQE4iq0cwILVsulnz9dGGdnNZbs2Di2Z2b6uBCG+lS
        7IFQjR105+YGKFkCVau8zrY=
X-Google-Smtp-Source: AGHT+IGptNi32yCr5X9X6yGOXvCh0Gp680BJpksdbOqRACWrsfAVHIA7TZq6BEqIhFSfqt6zn2fElA==
X-Received: by 2002:a05:600c:1c20:b0:3fe:21a6:a18 with SMTP id j32-20020a05600c1c2000b003fe21a60a18mr7906722wms.3.1695389395254;
        Fri, 22 Sep 2023 06:29:55 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id ay2-20020a05600c1e0200b003feea62440bsm1161935wmb.43.2023.09.22.06.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 06:29:55 -0700 (PDT)
Date:   Fri, 22 Sep 2023 15:29:53 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] staging: rtl8192e: Remove delayed_work start_ibss_wq
Message-ID: <805447a41feffb9da7d82830868dc1d47f9aa737.1695387832.git.philipp.g.hortmann@gmail.com>
References: <cover.1695387832.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695387832.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove delayed_work start_ibss_wq and the related functions which are not
needed anymore.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  24 ----
 .../staging/rtl8192e/rtl8192e/r8192E_dev.h    |   1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |   1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c     |  32 -----
 drivers/staging/rtl8192e/rtllib.h             |   4 -
 drivers/staging/rtl8192e/rtllib_softmac.c     | 133 ------------------
 6 files changed, 195 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index fe9f6585266b..9ffa9305ff5e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -18,30 +18,6 @@
 static int WDCAPARA_ADD[] = {EDCAPARA_BE, EDCAPARA_BK, EDCAPARA_VI,
 			     EDCAPARA_VO};
 
-void rtl92e_start_beacon(struct net_device *dev)
-{
-	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
-	struct rtllib_network *net = &priv->rtllib->current_network;
-	u16 BcnTimeCfg = 0;
-	u16 BcnCW = 6;
-	u16 BcnIFS = 0xf;
-
-	rtl92e_irq_disable(dev);
-
-	rtl92e_writew(dev, ATIMWND, 2);
-
-	rtl92e_writew(dev, BCN_INTERVAL, net->beacon_interval);
-	rtl92e_writew(dev, BCN_DRV_EARLY_INT, 10);
-	rtl92e_writew(dev, BCN_DMATIME, 256);
-
-	rtl92e_writeb(dev, BCN_ERR_THRESH, 100);
-
-	BcnTimeCfg |= BcnCW << BCN_TCFG_CW_SHIFT;
-	BcnTimeCfg |= BcnIFS << BCN_TCFG_IFS;
-	rtl92e_writew(dev, BCN_TCFG, BcnTimeCfg);
-	rtl92e_irq_enable(dev);
-}
-
 static void _rtl92e_update_msr(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
index 14a091ae1b7d..878c96236824 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
@@ -17,7 +17,6 @@ void rtl92e_ack_irq(struct net_device *dev, u32 *p_inta);
 void rtl92e_enable_rx(struct net_device *dev);
 void rtl92e_enable_tx(struct net_device *dev);
 void rtl92e_init_variables(struct net_device  *dev);
-void rtl92e_start_beacon(struct net_device *dev);
 void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val);
 void rtl92e_get_eeprom_size(struct net_device *dev);
 bool rtl92e_start_adapter(struct net_device *dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 03cabf88ce2b..208c7bfd9bfe 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -700,7 +700,6 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->set_bw_mode_handler	= rtl92e_set_bw_mode;
 	priv->rf_set_chan			= rtl92e_set_channel;
 
-	priv->rtllib->start_send_beacons = rtl92e_start_beacon;
 	priv->rtllib->stop_send_beacons = _rtl92e_stop_beacon;
 
 	priv->rtllib->sta_wake_up = rtl92e_hw_wakeup;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 0f14d9eb4fcd..a7e356e90d0e 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -743,38 +743,6 @@ void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 }
 EXPORT_SYMBOL(HT_update_self_and_peer_setting);
 
-void HTUseDefaultSetting(struct rtllib_device *ieee)
-{
-	struct rt_hi_throughput *ht_info = ieee->ht_info;
-
-	if (ht_info->enable_ht) {
-		ht_info->bCurrentHTSupport = true;
-		ht_info->bCurSuppCCK = ht_info->bRegSuppCCK;
-
-		ht_info->bCurBW40MHz = ht_info->bRegBW40MHz;
-		ht_info->bCurShortGI20MHz = ht_info->bRegShortGI20MHz;
-
-		ht_info->bCurShortGI40MHz = ht_info->bRegShortGI40MHz;
-		ht_info->bCurrent_AMSDU_Support = ht_info->bAMSDU_Support;
-		ht_info->nCurrent_AMSDU_MaxSize = ht_info->nAMSDU_MaxSize;
-
-		ht_info->bCurrentAMPDUEnable = ht_info->bAMPDUEnable;
-		ht_info->CurrentAMPDUFactor = ht_info->AMPDU_Factor;
-
-		ht_info->current_mpdu_density = ht_info->current_mpdu_density;
-
-		HTFilterMCSRate(ieee, ieee->reg_dot11tx_ht_oper_rate_set,
-				ieee->dot11ht_oper_rate_set);
-		ieee->HTHighestOperaRate = HTGetHighestMCSRate(ieee,
-							       ieee->dot11ht_oper_rate_set,
-							       MCS_FILTER_ALL);
-		ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
-
-	} else {
-		ht_info->bCurrentHTSupport = false;
-	}
-}
-
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame)
 {
 	if (ieee->ht_info->bCurrentHTSupport) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d10fddd4f9ad..410401869ebb 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1445,7 +1445,6 @@ struct rtllib_device {
 	struct delayed_work associate_procedure_wq;
 	struct delayed_work softmac_scan_wq;
 	struct delayed_work associate_retry_wq;
-	struct delayed_work start_ibss_wq;
 	struct delayed_work hw_wakeup_wq;
 	struct delayed_work hw_sleep_wq;
 	struct delayed_work link_change_wq;
@@ -1502,7 +1501,6 @@ struct rtllib_device {
 	 * stop_send_bacons is NOT guaranteed to be called only
 	 * after start_send_beacons.
 	 */
-	void (*start_send_beacons)(struct net_device *dev);
 	void (*stop_send_beacons)(struct net_device *dev);
 
 	/* power save mode related */
@@ -1727,7 +1725,6 @@ void rtllib_reset_queue(struct rtllib_device *ieee);
 void rtllib_wake_all_queues(struct rtllib_device *ieee);
 void rtllib_stop_all_queues(struct rtllib_device *ieee);
 struct sk_buff *rtllib_get_beacon(struct rtllib_device *ieee);
-void rtllib_start_send_beacons(struct rtllib_device *ieee);
 void rtllib_stop_send_beacons(struct rtllib_device *ieee);
 
 void notify_wx_assoc_event(struct rtllib_device *ieee);
@@ -1869,7 +1866,6 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 
 void rtllib_indicate_packets(struct rtllib_device *ieee,
 			     struct rtllib_rxb **prxbIndicateArray, u8  index);
-void HTUseDefaultSetting(struct rtllib_device *ieee);
 #define RT_ASOC_RETRY_LIMIT	5
 u8 MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee);
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 434690eeed5c..4551071e9f1b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -607,18 +607,6 @@ static void rtllib_softmac_scan_wq(void *data)
 	mutex_unlock(&ieee->scan_mutex);
 }
 
-static void rtllib_beacons_start(struct rtllib_device *ieee)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ieee->beacon_lock, flags);
-
-	ieee->beacon_txing = 1;
-	rtllib_send_beacon(ieee);
-
-	spin_unlock_irqrestore(&ieee->beacon_lock, flags);
-}
-
 static void rtllib_beacons_stop(struct rtllib_device *ieee)
 {
 	unsigned long flags;
@@ -639,14 +627,6 @@ void rtllib_stop_send_beacons(struct rtllib_device *ieee)
 }
 EXPORT_SYMBOL(rtllib_stop_send_beacons);
 
-void rtllib_start_send_beacons(struct rtllib_device *ieee)
-{
-	ieee->start_send_beacons(ieee->dev);
-	if (ieee->softmac_features & IEEE_SOFTMAC_BEACONS)
-		rtllib_beacons_start(ieee);
-}
-EXPORT_SYMBOL(rtllib_start_send_beacons);
-
 static void rtllib_softmac_stop_scan(struct rtllib_device *ieee)
 {
 	mutex_lock(&ieee->scan_mutex);
@@ -2189,116 +2169,6 @@ static void rtllib_start_monitor_mode(struct rtllib_device *ieee)
 		netif_carrier_on(ieee->dev);
 }
 
-static void rtllib_start_ibss_wq(void *data)
-{
-	struct rtllib_device *ieee = container_of_dwork_rsl(data,
-				     struct rtllib_device, start_ibss_wq);
-	/* iwconfig mode ad-hoc will schedule this and return
-	 * on the other hand this will block further iwconfig SET
-	 * operations because of the wx_mutex hold.
-	 * Anyway some most set operations set a flag to speed-up
-	 * (abort) this wq (when syncro scanning) before sleeping
-	 * on the mutex
-	 */
-	if (!ieee->proto_started) {
-		netdev_info(ieee->dev, "==========oh driver down return\n");
-		return;
-	}
-	mutex_lock(&ieee->wx_mutex);
-
-	if (ieee->current_network.ssid_len == 0) {
-		strscpy(ieee->current_network.ssid, RTLLIB_DEFAULT_TX_ESSID,
-			sizeof(ieee->current_network.ssid));
-		ieee->current_network.ssid_len = strlen(RTLLIB_DEFAULT_TX_ESSID);
-		ieee->ssid_set = 1;
-	}
-
-	ieee->link_state = MAC80211_NOLINK;
-	ieee->mode = WIRELESS_MODE_G;
-	/* check if we have this cell in our network list */
-	rtllib_softmac_check_all_nets(ieee);
-
-	/* if not then the state is not linked. Maybe the user switched to
-	 * ad-hoc mode just after being in monitor mode, or just after
-	 * being very few time in managed mode (so the card have had no
-	 * time to scan all the chans..) or we have just run up the iface
-	 * after setting ad-hoc mode. So we have to give another try..
-	 * Here, in ibss mode, should be safe to do this without extra care
-	 * (in bss mode we had to make sure no-one tried to associate when
-	 * we had just checked the ieee->link_state and we was going to start the
-	 * scan) because in ibss mode the rtllib_new_net function, when
-	 * finds a good net, just set the ieee->link_state to MAC80211_LINKED,
-	 * so, at worst, we waste a bit of time to initiate an unneeded syncro
-	 * scan, that will stop at the first round because it sees the state
-	 * associated.
-	 */
-	if (ieee->link_state == MAC80211_NOLINK)
-		rtllib_start_scan_syncro(ieee);
-
-	/* the network definitively is not here.. create a new cell */
-	if (ieee->link_state == MAC80211_NOLINK) {
-		netdev_info(ieee->dev, "creating new IBSS cell\n");
-		ieee->current_network.channel = ieee->bss_start_channel;
-		if (!ieee->wap_set)
-			eth_random_addr(ieee->current_network.bssid);
-
-		ieee->current_network.rates_len = 4;
-		ieee->current_network.rates[0] =
-			RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_1MB;
-		ieee->current_network.rates[1] =
-			RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_2MB;
-		ieee->current_network.rates[2] =
-			RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_5MB;
-		ieee->current_network.rates[3] =
-			RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_11MB;
-
-		ieee->current_network.rates_ex_len = 8;
-		ieee->current_network.rates_ex[0] =
-			RTLLIB_OFDM_RATE_6MB;
-		ieee->current_network.rates_ex[1] =
-			RTLLIB_OFDM_RATE_9MB;
-		ieee->current_network.rates_ex[2] =
-			RTLLIB_OFDM_RATE_12MB;
-		ieee->current_network.rates_ex[3] =
-			RTLLIB_OFDM_RATE_18MB;
-		ieee->current_network.rates_ex[4] =
-			RTLLIB_OFDM_RATE_24MB;
-		ieee->current_network.rates_ex[5] =
-			RTLLIB_OFDM_RATE_36MB;
-		ieee->current_network.rates_ex[6] =
-			RTLLIB_OFDM_RATE_48MB;
-		ieee->current_network.rates_ex[7] =
-			RTLLIB_OFDM_RATE_54MB;
-		ieee->rate = 108;
-
-		ieee->current_network.qos_data.supported = 0;
-		ieee->set_wireless_mode(ieee->dev, WIRELESS_MODE_G);
-		ieee->current_network.mode = ieee->mode;
-		ieee->current_network.atim_window = 0;
-		ieee->current_network.capability = WLAN_CAPABILITY_IBSS;
-	}
-
-	netdev_info(ieee->dev, "%s(): ieee->mode = %d\n", __func__, ieee->mode);
-	if (ieee->mode == WIRELESS_MODE_N_24G)
-		HTUseDefaultSetting(ieee);
-	else
-		ieee->ht_info->bCurrentHTSupport = false;
-
-	ieee->SetHwRegHandler(ieee->dev, HW_VAR_MEDIA_STATUS,
-			      (u8 *)(&ieee->link_state));
-
-	ieee->link_state = MAC80211_LINKED;
-	ieee->link_change(ieee->dev);
-
-	HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
-	rtllib_start_send_beacons(ieee);
-
-	notify_wx_assoc_event(ieee);
-	netif_carrier_on(ieee->dev);
-
-	mutex_unlock(&ieee->wx_mutex);
-}
-
 /* this is called only in user context, with wx_mutex held */
 static void rtllib_start_bss(struct rtllib_device *ieee)
 {
@@ -2459,7 +2329,6 @@ void rtllib_stop_protocol(struct rtllib_device *ieee, u8 shutdown)
 	rtllib_stop_send_beacons(ieee);
 	del_timer_sync(&ieee->associate_timer);
 	cancel_delayed_work_sync(&ieee->associate_retry_wq);
-	cancel_delayed_work_sync(&ieee->start_ibss_wq);
 	cancel_delayed_work_sync(&ieee->link_change_wq);
 	rtllib_stop_scan(ieee);
 
@@ -2593,7 +2462,6 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	timer_setup(&ieee->beacon_timer, rtllib_send_beacon_cb, 0);
 
 	INIT_DELAYED_WORK(&ieee->link_change_wq, (void *)rtllib_link_change_wq);
-	INIT_DELAYED_WORK(&ieee->start_ibss_wq, (void *)rtllib_start_ibss_wq);
 	INIT_WORK(&ieee->associate_complete_wq, (void *)rtllib_associate_complete_wq);
 	INIT_DELAYED_WORK(&ieee->associate_procedure_wq, (void *)rtllib_associate_procedure_wq);
 	INIT_DELAYED_WORK(&ieee->softmac_scan_wq, (void *)rtllib_softmac_scan_wq);
@@ -2622,7 +2490,6 @@ void rtllib_softmac_free(struct rtllib_device *ieee)
 	cancel_delayed_work_sync(&ieee->associate_retry_wq);
 	cancel_delayed_work_sync(&ieee->associate_procedure_wq);
 	cancel_delayed_work_sync(&ieee->softmac_scan_wq);
-	cancel_delayed_work_sync(&ieee->start_ibss_wq);
 	cancel_delayed_work_sync(&ieee->hw_wakeup_wq);
 	cancel_delayed_work_sync(&ieee->hw_sleep_wq);
 	cancel_delayed_work_sync(&ieee->link_change_wq);
-- 
2.42.0

