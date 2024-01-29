Return-Path: <linux-kernel+bounces-42884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA80D840819
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7DB1C218C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C67965BC3;
	Mon, 29 Jan 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCxmjk03"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AAD67743
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537956; cv=none; b=D4acBkOdFuV4nRG/d1rnTDn3btcl8VnNMR3TJwTGVBXYQRhgX6fCuwvj+KBjiBc0ERld8aWu7cb347WJEf9KiCP/pHQU2gn901VEwKaqHCAsmKrnDqL7srUgjmkcLI4ePfbVw2EfSj7u9Qrx1nEMnchq1PgmPmvZu/NuJj06FAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537956; c=relaxed/simple;
	bh=szqmi1SLSsMcvFAo1ufwEQ9NdM0JkL1850Ai9HDsJbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlge7wINzgEZ1LvcbMDJqEgQrBKc27iPdo/Vl6WRBPc9d/UYv+LN/9K29dBxDna75BoFr/6Zfqy8qZFpg5qf3eCV2Lo8Vx0v4/zTEJkr5034b0RuliNiqnfvtJwapbnY33j6eL85V2UKam6zwoa+ygYmCfR1PYK6VGiTjLNJvK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCxmjk03; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e80046264so39487505e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706537952; x=1707142752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6x2tCWN+qHp2Vb9DmN70O7+q+20TXewO8c18yAWv8w=;
        b=HCxmjk03vgH9Vb7fF2EQ3Rl0Mm9rId2IrFqKgqy53o//u1mFJv/EhgESG7jJX84Ea0
         aOl2kTAyzyvO8Vm9iLBuZF4AFh7L4PhzJAE+SljC+BYJwo2qRFPLSDFducQNjoPYLWxi
         UMUGUD2YZUVLwJtCq+VdM4WXgiMMxQOM2FzN1bONGPQ1Y203Xf07z+T8c8Ry+N4Tgue4
         /Ese760M/ETrz9RlTkGyD+P6i9T7yCOVUtRwtJ33z4qPkUjjmBtiuaA/jvz7CY7TPfjm
         tHmqDFWb/s+q4VgIfLOTSRBnNp+s7JP5Ax/Fq+/C1xi2jMobBc4olQP5tt7pWvmKYSS8
         MNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706537952; x=1707142752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6x2tCWN+qHp2Vb9DmN70O7+q+20TXewO8c18yAWv8w=;
        b=vJn2UXqz7SigBy4D0bbAeRlAcounG2GcOlo2jhcLCGQ+AbF50kvNatqXWUTleQj0VY
         F68OWwONc280wAJPlTqHSa6BG7I7aI78tmO/QDlWWgp+qPG+zHxu3yN+DOCclWMVR69R
         WCvKkDLmpphwxTKRm2FjcHL+69PN4c9cxvj0P6oC1B/E+Y36kqracRnVxy/cQVnZRwL7
         rHCp66og4trUKgeA6GkX2GmLsp9qAwjmZszykW+J79Am7feAqxuFqWWHFYfcYhun8y1s
         8zrOT4/ztTW5A6kzmpK1t3PBVwyFWyWwChhbKdQ8lKbeW8Ff5zlmtY47QJPW+zq2d642
         qVYA==
X-Gm-Message-State: AOJu0YwsXhlTrTZ37Q4Lg3FdCEk8NFD2a4/szykIiVY3aWQBGCx15j6n
	RVUNcJCGT4fxqte16D0BN6HN7SDBuD6e2Qug49Mn8Q0LCQOW4uU042Niwrl6GmKTjw==
X-Google-Smtp-Source: AGHT+IFTNqtdT7jHUmUVX5AbVUyQ9XzW24nUoOUk/M56gFF8kajDybOcEmyJUz3eOeedQ6VbrrMZ+g==
X-Received: by 2002:adf:ff86:0:b0:337:c260:9e6e with SMTP id j6-20020adfff86000000b00337c2609e6emr4175771wrr.16.1706537952558;
        Mon, 29 Jan 2024 06:19:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU2cwiWBfHN4QUECjEE3UlgRKgpPrcnmIbtxgNeIEm258c6qRQWi4VJhDJmBfHGyRDPkrR5i6b9oWL7Kzz7vPisjELtIfXMBsVxH/YbtnJ5BU0hZxdHa1Z/LWNj1h3Tyh9zDdyXSHtEKItvrF3zKzsYFoeXMC/9G1YLFOSEomWgdlbFJvmadlOCTVvjLoFMthsm+nkHcL4wZWcRnanzczL5G3puLgLp
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.152])
        by smtp.gmail.com with ESMTPSA id o1-20020adfe801000000b0033725783839sm8194802wrm.110.2024.01.29.06.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:19:12 -0800 (PST)
From: Meir Elisha <meir6264@gmail.com>
X-Google-Original-From: Meir Elisha <meir6264@Gmail.com>
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Mon, 29 Jan 2024 16:19:09 +0200
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@Gmail.com>
Subject: [PATCH 3/4] Staging: rtl8723bs: Fix block comments warning
Date: Mon, 29 Jan 2024 16:18:55 +0200
Message-Id: <20240129141856.416532-4-meir6264@Gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129141856.416532-1-meir6264@Gmail.com>
References: <20240129141856.416532-1-meir6264@Gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch warning: Block comments use * on subsequent lines

Signed-off-by: Meir Elisha <meir6264@Gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 152 +++++++++++-----------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index a7c4350e0783..044483f3d678 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -110,30 +110,30 @@ void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 }
 
 /*
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
+ *struct wlan_network *_rtw_dequeue_network(struct __queue *queue)
+ *{
+ *	_irqL irqL;
+ *
+ *	struct wlan_network *pnetwork;
+ *
+ *	spin_lock_bh(&queue->lock);
+ *
+ *	if (list_empty(&queue->queue))
+ *
+ *		pnetwork = NULL;
+ *
+ *	else
+ *	{
+ *		pnetwork = container_of(get_next(&queue->queue), struct wlan_network, list);
+ *
+ *		list_del_init(&(pnetwork->list));
+ *	}
+ *
+ *	spin_unlock_bh(&queue->lock);
+ *
+ *	return pnetwork;
+ *}
+ */
 
 struct	wlan_network *rtw_alloc_network(struct	mlme_priv *pmlmepriv)
 {
@@ -218,10 +218,9 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 }
 
 /*
-	return the wlan_network with the matching addr
-
-	Shall be called under atomic context... to avoid possible racing condition...
-*/
+ * return the wlan_network with the matching addr
+ * Shall be called under atomic context... to avoid possible racing condition...
+ */
 struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
 	struct list_head	*phead, *plist;
@@ -322,14 +321,14 @@ void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 }
 
 /*
-static struct	wlan_network *rtw_dequeue_network(struct __queue *queue)
-{
-	struct wlan_network *pnetwork;
-
-	pnetwork = _rtw_dequeue_network(queue);
-	return pnetwork;
-}
-*/
+ *static struct	wlan_network *rtw_dequeue_network(struct __queue *queue)
+ *{
+ *	struct wlan_network *pnetwork;
+ *
+ *	pnetwork = _rtw_dequeue_network(queue);
+ *	return pnetwork;
+ *}
+ */
 
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork);
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork)
@@ -339,10 +338,9 @@ void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnet
 }
 
 /*
-	return the wlan_network with the matching addr
-
-	Shall be called under atomic context... to avoid possible racing condition...
-*/
+ * return the wlan_network with the matching addr
+ * Shall be called under atomic context... to avoid possible racing condition...
+ */
 struct	wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
 	struct	wlan_network *pnetwork = _rtw_find_network(scanned_queue, addr);
@@ -506,8 +504,8 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 }
 
 /*
-Caller must hold pmlmepriv->lock first.
-*/
+ * Caller must hold pmlmepriv->lock first.
+ */
 void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *target)
 {
 	struct list_head	*plist, *phead;
@@ -541,7 +539,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 	}
 
 	/* If we didn't find a match, then get a new network slot to initialize
-	 * with this beacon's information */
+	 * with this beacon's information
+	 */
 	/* if (phead == plist) { */
 	if (!target_find) {
 		if (list_empty(&pmlmepriv->free_bss_pool.queue)) {
@@ -751,7 +750,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
 
 	if (pmlmepriv->to_join) {
-		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
@@ -885,8 +884,8 @@ static void find_network(struct adapter *adapter)
 }
 
 /*
-*rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
-*/
+ *rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
+ */
 void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
@@ -921,8 +920,8 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 }
 
 /*
-*rtw_indicate_connect: the caller has to lock pmlmepriv->lock
-*/
+ *rtw_indicate_connect: the caller has to lock pmlmepriv->lock
+ */
 void rtw_indicate_connect(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -942,8 +941,8 @@ void rtw_indicate_connect(struct adapter *padapter)
 }
 
 /*
-*rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
-*/
+ * rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
+ */
 void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1527,9 +1526,9 @@ void rtw_wmm_event_callback(struct adapter *padapter, u8 *pbuf)
 }
 
 /*
-* _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
-* @adapter: pointer to struct adapter structure
-*/
+ * _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
+ * @adapter: pointer to struct adapter structure
+ */
 void _rtw_join_timeout_handler(struct timer_list *t)
 {
 	struct adapter *adapter = from_timer(adapter, t,
@@ -1571,9 +1570,9 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 }
 
 /*
-* rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
-* @adapter: pointer to struct adapter structure
-*/
+ * rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
+ * @adapter: pointer to struct adapter structure
+ */
 void rtw_scan_timeout_handler(struct timer_list *t)
 {
 	struct adapter *adapter = from_timer(adapter, t,
@@ -1691,10 +1690,10 @@ void rtw_set_scan_deny(struct adapter *adapter, u32 ms)
 }
 
 /*
-* Select a new roaming candidate from the original @param candidate and @param competitor
-* @return true: candidate is updated
-* @return false: candidate is not updated
-*/
+ * Select a new roaming candidate from the original @param candidate and @param competitor
+ * @return true: candidate is updated
+ * @return false: candidate is not updated
+ */
 static int rtw_check_roaming_candidate(struct mlme_priv *mlme
 	, struct wlan_network **candidate, struct wlan_network *competitor)
 {
@@ -1774,10 +1773,10 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 }
 
 /*
-* Select a new join candidate from the original @param candidate and @param competitor
-* @return true: candidate is updated
-* @return false: candidate is not updated
-*/
+ * Select a new join candidate from the original @param candidate and @param competitor
+ * @return true: candidate is updated
+ * @return false: candidate is not updated
+ */
 static int rtw_check_join_candidate(struct mlme_priv *mlme
 	, struct wlan_network **candidate, struct wlan_network *competitor)
 {
@@ -1818,11 +1817,11 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 }
 
 /*
-Calling context:
-The caller of the sub-routine will be in critical section...
-The caller must hold the following spinlock
-pmlmepriv->lock
-*/
+ * Calling context:
+ * The caller of the sub-routine will be in critical section...
+ * The caller must hold the following spinlock
+ * pmlmepriv->lock
+ */
 
 int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 {
@@ -2090,13 +2089,14 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
 		/* copy RSN or SSN */
 		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0], psecuritypriv->supplicant_ie[1]+2);
 		/* debug for CONFIG_IEEE80211W
-		{
-			int jj;
-			printk("supplicant_ie_length =%d &&&&&&&&&&&&&&&&&&&\n", psecuritypriv->supplicant_ie[1]+2);
-			for (jj = 0; jj < psecuritypriv->supplicant_ie[1]+2; jj++)
-				printk(" %02x ", psecuritypriv->supplicant_ie[jj]);
-			printk("\n");
-		}*/
+		 *{
+		 *	int jj;
+		 *	printk("supplicant_ie_length =%d &&&&&&&&&&&&&&&&&&&\n", psecuritypriv->supplicant_ie[1]+2);
+		 *	for (jj = 0; jj < psecuritypriv->supplicant_ie[1]+2; jj++)
+		 *		printk(" %02x ", psecuritypriv->supplicant_ie[jj]);
+		 *	printk("\n");
+		 *}
+		 */
 		ielength += psecuritypriv->supplicant_ie[1]+2;
 		rtw_report_sec_ie(adapter, authmode, psecuritypriv->supplicant_ie);
 	}
-- 
2.34.1


