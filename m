Return-Path: <linux-kernel+bounces-134374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE6E89B0CA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7380281D76
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D0B2BAE4;
	Sun,  7 Apr 2024 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPRqB56S"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283228DA6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493526; cv=none; b=hWlqald6+uuzFlc18phmk+ak7KBT0W/PpsYZNWSyAQWZIv/W7EJ8m1Mm7OzhnZTBRargyQHOTxW715wicbtEpmAwta0j7Pnwdp986VQuTN8oP2AY3FmlNx+lmMMHZ3HQRbmUHdLRgr0HWjotivQeFPne/8/FCoEBR3WgDUTg2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493526; c=relaxed/simple;
	bh=5BJLAbozZzx7B/WepK5nkabWltTm5TkVKHiSaZ06yqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rQ/Ny4NJcAeVZzprLH4mHiSvGe/fqYMuKIRGMdttpWM7OcndOPrsRXp8MqwY0xHj26djl79oabOWEV6vfYCuYoN9/J2wlnTejEnnKa/8hciyABy5iIy2mZmwmOByjDAlZR6LC6rV0KIdoc2uOaeHyGAz+CqAQLM7foohZhWHLT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPRqB56S; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ddd1624beso1986356f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712493523; x=1713098323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2rJIfOiUkLeGWUcSZoGUOFuPkPUO8rduwy2DfTTrWaA=;
        b=FPRqB56SPIfaZTvAPIzMlsNn82ScnwBRxgT19BCtzbl4QP82NvA/szFec8zFMzi694
         gWomTg9gk0cLSs7ASSPMZ//pRf417YsrvILtXz2XnelL0IKGnFAwyHrfdm6nwobnZpvc
         7QY2N8cdi50h1MIwWIjH2hJldE4Vz9dSCDQXoPuU8KbbqD0BRvzzML2tzK+i7I3pW0YK
         6MIpWRIqjZA6zlaqc8Mup8b1cugDea3NDMcU8rJifolsgq8VG7NbBC2emfFw1pugGYM0
         HypsiuXK6ypuD4crHZDqnvM3yk5kR68ijvvoK2CtduhtAoDaMvzNgWAalyjwjB8kiXAu
         L16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712493523; x=1713098323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rJIfOiUkLeGWUcSZoGUOFuPkPUO8rduwy2DfTTrWaA=;
        b=jUFtfBk0qq4/jgu8enAR9utpBWombFe2ub/XKYWHGtcbouyszew1F4DugJULt1hFXs
         UKnpsrol1V9mFiMPzdZshTBRfZgy4l7y3zFIQaAwhVmDZgp2WxDi77J9hyy0Npjrov89
         aAdXtI4UN1iCTpVAaoaNCV+1C7W+RYfdh8QKM1Gb5NNEercp4BPZRhdg+eIcuNhIKL7V
         /28srpNoIX7n3DmezVLTH93Ww/RaM9xknZiSy0PkZwhBWJ8tpNuR+32rb1VqKrY60sNY
         ea0Hib1z3Lajc3v3azRAkUJWyC2U5NU7EswLsggfCYm3sFQlzqm+d3iDZu2IFl3CKpZ+
         /2bA==
X-Forwarded-Encrypted: i=1; AJvYcCVJoaMzPjKuBN7o1MbEwJ24J87hGtjieWemmKYKZPXmKmmBpJe/TQn4gS7ydJzbOdLWP6/pNURTwr9M8hjwIXPPRwhN65m4ogubO+uj
X-Gm-Message-State: AOJu0Yyd5t99AeEVtjBCcggQHkTthWbXGGEPobND+U+4m/icsaPcAwwV
	8qNvAI24c3kxTvVjZV6FROIyC3xFQey1Y1sOz3jwARb0DvWiesnlEk/Snk9C7Ac=
X-Google-Smtp-Source: AGHT+IG/ywgXA7WQjb+jOiNZDticfofkxYLmPcWQwu28aMGlxHVri84TFKZmtYymVepPC9LiJ8OUpA==
X-Received: by 2002:a5d:45d0:0:b0:341:b5ca:9e9c with SMTP id b16-20020a5d45d0000000b00341b5ca9e9cmr5099509wrs.25.1712493522612;
        Sun, 07 Apr 2024 05:38:42 -0700 (PDT)
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.155])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d4145000000b00343dc6a0019sm6597302wrq.68.2024.04.07.05.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 05:38:42 -0700 (PDT)
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Sun, 07 Apr 2024 15:38:39 +0300
From: Meir Elisha <meir6264@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@gmail.com>
Subject: [PATCH] Staging: rtl8723bs: Delete dead code from update_current_network()
Date: Sun,  7 Apr 2024 15:38:36 +0300
Message-Id: <20240407123836.115055-1-meir6264@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove dead code from rtw_mlme.c in order to improve code readability.

Signed-off-by: Meir Elisha <meir6264@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 92 ++---------------------
 1 file changed, 5 insertions(+), 87 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index bfb27f902753..8c487b7b7a40 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -22,7 +22,6 @@ int	rtw_init_mlme_priv(struct adapter *padapter)
 
 	pmlmepriv->pscanned = NULL;
 	pmlmepriv->fw_state = WIFI_STATION_STATE; /*  Must sync with rtw_wdev_alloc() */
-	/*  wdev->iftype = NL80211_IFTYPE_STATION */
 	pmlmepriv->cur_network.network.infrastructure_mode = Ndis802_11AutoUnknown;
 	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: passive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
 
@@ -109,32 +108,6 @@ void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 	}
 }
 
-/*
-struct	wlan_network *_rtw_dequeue_network(struct __queue *queue)
-{
-	_irqL irqL;
-
-	struct wlan_network *pnetwork;
-
-	spin_lock_bh(&queue->lock);
-
-	if (list_empty(&queue->queue))
-
-		pnetwork = NULL;
-
-	else
-	{
-		pnetwork = container_of(get_next(&queue->queue), struct wlan_network, list);
-
-		list_del_init(&(pnetwork->list));
-	}
-
-	spin_unlock_bh(&queue->lock);
-
-	return pnetwork;
-}
-*/
-
 struct	wlan_network *rtw_alloc_network(struct	mlme_priv *pmlmepriv)
 {
 	struct	wlan_network	*pnetwork;
@@ -207,13 +180,9 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 	if (pnetwork->fixed)
 		return;
 
-	/* spin_lock_irqsave(&free_queue->lock, irqL); */
-
 	list_del_init(&(pnetwork->list));
 
 	list_add_tail(&(pnetwork->list), get_list_head(free_queue));
-
-	/* spin_unlock_irqrestore(&free_queue->lock, irqL); */
 }
 
 /*
@@ -231,8 +200,6 @@ struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 		goto exit;
 	}
 
-	/* spin_lock_bh(&scanned_queue->lock); */
-
 	phead = get_list_head(scanned_queue);
 	list_for_each(plist, phead) {
 		pnetwork = list_entry(plist, struct wlan_network, list);
@@ -244,8 +211,6 @@ struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 	if (plist == phead)
 		pnetwork = NULL;
 
-	/* spin_unlock_bh(&scanned_queue->lock); */
-
 exit:
 	return pnetwork;
 }
@@ -320,16 +285,6 @@ void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 	_rtw_free_mlme_priv(pmlmepriv);
 }
 
-/*
-static struct	wlan_network *rtw_dequeue_network(struct __queue *queue)
-{
-	struct wlan_network *pnetwork;
-
-	pnetwork = _rtw_dequeue_network(queue);
-	return pnetwork;
-}
-*/
-
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork);
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork)
 {
@@ -494,12 +449,9 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 		&(pmlmepriv->cur_network.network));
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) && (is_same_network(&(pmlmepriv->cur_network.network), pnetwork, 0))) {
-		/* if (pmlmepriv->cur_network.network.ie_length<= pnetwork->ie_length) */
-		{
-			update_network(&(pmlmepriv->cur_network.network), pnetwork, adapter, true);
-			rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fix_ie),
-									pmlmepriv->cur_network.network.ie_length);
-		}
+		update_network(&(pmlmepriv->cur_network.network), pnetwork, adapter, true);
+		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fix_ie),
+								pmlmepriv->cur_network.network.ie_length);
 	}
 }
 
@@ -540,7 +492,6 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 	/* If we didn't find a match, then get a new network slot to initialize
 	 * with this beacon's information */
-	/* if (phead == plist) { */
 	if (!target_find) {
 		if (list_empty(&pmlmepriv->free_bss_pool.queue)) {
 			/* If there are no more slots, expire the oldest */
@@ -613,15 +564,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 void rtw_add_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork);
 void rtw_add_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
 {
-	/* struct __queue	*queue	= &(pmlmepriv->scanned_queue); */
-
-	/* spin_lock_bh(&queue->lock); */
-
 	update_current_network(adapter, pnetwork);
-
 	rtw_update_scanned_network(adapter, pnetwork);
-
-	/* spin_unlock_bh(&queue->lock); */
 }
 
 /* select the desired network based on the capability of the (i)bss. */
@@ -637,10 +581,7 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	u32 desired_encmode;
 	u32 privacy;
-
-	/* u8 wps_ie[512]; */
 	uint wps_ielen;
-
 	int bselected = true;
 
 	desired_encmode = psecuritypriv->ndisencryptstatus;
@@ -1052,9 +993,8 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			memset((u8 *)&psta->dot11rxpn, 0, sizeof(union pn48));
 		}
 
-		/* 	Commented by Albert 2012/07/21 */
-		/* 	When doing the WPS, the wps_ie_len won't equal to 0 */
-		/* 	And the Wi-Fi driver shouldn't allow the data packet to be transmitted. */
+		/* When doing the WPS, the wps_ie_len won't equal to 0 */
+		/* And the Wi-Fi driver shouldn't allow the data packet to be transmitted. */
 		if (padapter->securitypriv.wps_ie_len != 0) {
 			psta->ieee8021x_blocked = true;
 			padapter->securitypriv.wps_ie_len = 0;
@@ -1064,7 +1004,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 		/* if A-MPDU Rx is enabled, resetting  rx_ordering_ctrl wstart_b(indicate_seq) to default value = 0xffff */
 		/* todo: check if AP can send A-MPDU packets */
 		for (i = 0; i < 16 ; i++) {
-			/* preorder_ctrl = &precvpriv->recvreorder_ctrl[i]; */
 			preorder_ctrl = &psta->recvreorder_ctrl[i];
 			preorder_ctrl->enable = false;
 			preorder_ctrl->indicate_seq = 0xffff;
@@ -1075,7 +1014,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 		bmc_sta = rtw_get_bcmc_stainfo(padapter);
 		if (bmc_sta) {
 			for (i = 0; i < 16 ; i++) {
-				/* preorder_ctrl = &precvpriv->recvreorder_ctrl[i]; */
 				preorder_ctrl = &bmc_sta->recvreorder_ctrl[i];
 				preorder_ctrl->enable = false;
 				preorder_ctrl->indicate_seq = 0xffff;
@@ -1239,8 +1177,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 		rtw_reset_securitypriv(adapter);
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 
-		/* rtw_free_assoc_resources(adapter, 1); */
-
 		if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == true)
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 
@@ -1262,7 +1198,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 		#endif
 
 			_set_timer(&pmlmepriv->assoc_timer, 1);
-			/* rtw_free_assoc_resources(adapter, 1); */
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 
 		#ifdef REJOIN
@@ -1357,7 +1292,6 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	/* to do : init sta_info variable */
 	psta->qos_option = 0;
 	psta->mac_id = (uint)pstassoc->cam_id;
-	/* psta->aid = (uint)pstassoc->cam_id; */
 
 	/* for ad-hoc mode */
 	rtw_hal_set_odm_var(adapter, HAL_ODM_STA_INFO, psta, true);
@@ -1472,10 +1406,8 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 		if (adapter->stapriv.asoc_sta_count == 1) {/* a sta + bc/mc_stainfo (not Ibss_stainfo) */
 			u8 ret = _SUCCESS;
-			/* rtw_indicate_disconnect(adapter);removed@20091105 */
 			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
 			/* free old ibss network */
-			/* pwlan = rtw_find_network(&pmlmepriv->scanned_queue, pstadel->macaddr); */
 			pwlan = rtw_find_network(&pmlmepriv->scanned_queue, tgt_network->network.mac_address);
 			if (pwlan) {
 				pwlan->fixed = false;
@@ -2088,14 +2020,6 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
 	} else if ((authmode == WLAN_EID_VENDOR_SPECIFIC) || (authmode == WLAN_EID_RSN)) {
 		/* copy RSN or SSN */
 		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0], psecuritypriv->supplicant_ie[1]+2);
-		/* debug for CONFIG_IEEE80211W
-		{
-			int jj;
-			printk("supplicant_ie_length =%d &&&&&&&&&&&&&&&&&&&\n", psecuritypriv->supplicant_ie[1]+2);
-			for (jj = 0; jj < psecuritypriv->supplicant_ie[1]+2; jj++)
-				printk(" %02x ", psecuritypriv->supplicant_ie[jj]);
-			printk("\n");
-		}*/
 		ielength += psecuritypriv->supplicant_ie[1]+2;
 		rtw_report_sec_ie(adapter, authmode, psecuritypriv->supplicant_ie);
 	}
@@ -2132,7 +2056,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	struct wlan_bssid_ex    *pdev_network = &pregistrypriv->dev_network;
 	struct	security_priv *psecuritypriv = &adapter->securitypriv;
 	struct	wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
-	/* struct	xmit_priv *pxmitpriv = &adapter->xmitpriv; */
 
 	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ; /*  adhoc no 802.1x */
 
@@ -2381,7 +2304,6 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		rtw_hal_get_def_var(padapter, HW_VAR_MAX_RX_AMPDU_FACTOR,
 				    &max_rx_ampdu_factor);
 
-	/* rtw_hal_get_def_var(padapter, HW_VAR_MAX_RX_AMPDU_FACTOR, &max_rx_ampdu_factor); */
 	ht_capie.ampdu_params_info = (max_rx_ampdu_factor&0x03);
 
 	if (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
@@ -2411,14 +2333,10 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 {
 	u8 *p, max_ampdu_sz;
 	int len;
-	/* struct sta_info *bmc_sta, *psta; */
 	struct ieee80211_ht_cap *pht_capie;
-	/* struct recv_reorder_ctrl *preorder_ctrl; */
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
-	/* struct recv_priv *precvpriv = &padapter->recvpriv; */
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	/* struct wlan_network *pcur_network = &(pmlmepriv->cur_network);; */
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 cbw40_enable = 0;
-- 
2.34.1


