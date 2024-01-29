Return-Path: <linux-kernel+bounces-42883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B806E840818
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD88B262F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EBD6773F;
	Mon, 29 Jan 2024 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWidxyXe"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4EE67721
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537952; cv=none; b=DoamyFyprUL5/yrm5xscakWeoV9szm46D6ROyjiHKEqWkv74ghGSBi02Ivz80M3LGqkghkYUuY7ggGh3Mje/Oc0Sux8aeb7ezYQFAkUMjKb5Q5M83My4w485jZMb20I8kwncigxaZWailQpWszXlZBVgBNuczlU84JjjIwBGGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537952; c=relaxed/simple;
	bh=XCbPnyAJzGYAzDsFRUzS6cYS5hGjC7javOHTswAiMZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dMFk4XrnPnV+EPR/0Hl17l95N3CwKWpUsj0ZE9T6402YPSdSb7HLFCIgQBniPBVbOr6R5XPdfY/+++FmmYPM9HTq3JajpQtrYZLJUf0pnXmAhzR85U/Hzn/F35mcbkIpBvWf2g+gajTjrSnQR+ToY5+68wltENzll7yYTR1KsrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWidxyXe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ef75adf44so7387475e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706537949; x=1707142749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Scr7TGftwiIkVPI6gx3gDcxXozHzo+ihW9CsPi6XS+o=;
        b=RWidxyXeA82zOCx3h6BoQyZ4Wm/z1QdElhy4k2uRTEMzAkVTgTjEH3pH27zJZ43eFY
         EbsJz5V/5Gdkfk+NUUrtXp4pJjOxt6ln6qjPHlajNiEOeXhlUiiBKoPgUbA8atHjN1j6
         e9LFwGgyj521eC4iiSWgcaUxu0iis2RlKfte0Khe2NMYSCESSlhSRia54Yc5qS6vZbrm
         jBrjZHUL9hX01yiqFHAsyWNuP2/BituyoEe9C08pk6T2GRi7nwPmj6XrSrlGgGs1RIb5
         g5Sqr2TmuNpoIG8OEZEIGnqO6mPb+R9WaZFOzTKyL+9Yma8GnvwFCoRXH0+t80pIiP31
         f0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706537949; x=1707142749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Scr7TGftwiIkVPI6gx3gDcxXozHzo+ihW9CsPi6XS+o=;
        b=gZ42a2PNiLAYAtX/ZJ5IXOWkIkfvKoyHQr4p8+pf7wDIE6zBS6jXrqOnKFBb8zSw6c
         pzQBC+AHb2WJxsG+97VbK0m6NVs86vbst7wG4YxmgCBQVAjbOOFCiiUAMssDpU5FpGzM
         iOi22wXcEnAVyD5N3n0WrW6IoMbs9SKcpXHUJaINb1G9b70VrqsUeDcg1DyXrUV5vzyL
         LW2N5EEJvMulFZxk2UnRNO8YBYerxMFVQ6SzzZ+usMFoX8izaPFvAkJQZ0DfHlcnk6AL
         leeq7520MO1YMqlyT187ZhTf1/P9W4ODSXNvqOZQ7UasJUsEyIoDZOiD3gbBSB0prOvK
         w3sg==
X-Gm-Message-State: AOJu0YwDZetZp0f/SiP8MAcd7fRwLRpOpvWXwkLDrvj/mpscgAKr/d9T
	u+bZQWsQbwNqd68nvEfepc3GYKkHClmFROZRe5G/KoE9RY9/MtC4
X-Google-Smtp-Source: AGHT+IHM6lhjJCJ/Q74tXbDJ3B3OD0B1U1r8TRriXvRS0BhrR7YUAO9iH3u/zevBqLuoqmUe8jo1fw==
X-Received: by 2002:a05:600c:a39c:b0:40e:fb76:533f with SMTP id hn28-20020a05600ca39c00b0040efb76533fmr884356wmb.24.1706537949240;
        Mon, 29 Jan 2024 06:19:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVijBtCHHYgzJJt/lbklHEU1wSKwsG1f/+GzK0ooGp5pldsh/GuWoTWXv/3kGzEnZJgb8rjyXr/Kh/9gPAAuI6/MeGnGqCDDNUP1YMQW/jDltjPMJP88zxq/PRKFBbK/NUMU0Z6f4B00IGRES00lV0PXXjNmp+5tJZYb75JAYsGPXNYa+5i8i6Ys8r59cMVVfffqigXKszm8mLzs55v5uoYiLDzu/sW
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.152])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b0040e4914f28dsm14173109wmq.18.2024.01.29.06.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:19:08 -0800 (PST)
From: Meir Elisha <meir6264@gmail.com>
X-Google-Original-From: Meir Elisha <meir6264@Gmail.com>
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Mon, 29 Jan 2024 16:19:06 +0200
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@Gmail.com>
Subject: [PATCH 2/4] Staging: rtl8723bs: Remove extra spaces
Date: Mon, 29 Jan 2024 16:18:54 +0200
Message-Id: <20240129141856.416532-3-meir6264@Gmail.com>
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

Fix checkpatch warning: please, no space before tabs

Signed-off-by: Meir Elisha <meir6264@Gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 48 +++++++++++------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 5568215b35bd..a7c4350e0783 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -169,7 +169,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 {
 	unsigned int delta_time;
 	u32 lifetime = SCANQUEUE_LIFETIME;
-/* 	_irqL irqL; */
+/*	_irqL irqL; */
 	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
 
 	if (!pnetwork)
@@ -389,7 +389,7 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 	d_cap = le16_to_cpu(tmpd);
 
 	return (src->ssid.ssid_length == dst->ssid.ssid_length) &&
-		/* 	(src->configuration.ds_config == dst->configuration.ds_config) && */
+		/*	(src->configuration.ds_config == dst->configuration.ds_config) && */
 			((!memcmp(src->mac_address, dst->mac_address, ETH_ALEN))) &&
 			((!memcmp(src->ssid.ssid, dst->ssid.ssid, src->ssid.ssid_length))) &&
 			((s_cap & WLAN_CAPABILITY_IBSS) ==
@@ -628,10 +628,10 @@ void rtw_add_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
 
 /* select the desired network based on the capability of the (i)bss. */
 /*  check items: (1) security */
-/* 			   (2) network_type */
-/* 			   (3) WMM */
-/* 			   (4) HT */
-/*                      (5) others */
+/* (2) network_type */
+/* (3) WMM */
+/* (4) HT */
+/* (5) others */
 int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork);
 int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork)
 {
@@ -1054,9 +1054,9 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			memset((u8 *)&psta->dot11rxpn, 0, sizeof(union pn48));
 		}
 
-		/* 	Commented by Albert 2012/07/21 */
-		/* 	When doing the WPS, the wps_ie_len won't equal to 0 */
-		/* 	And the Wi-Fi driver shouldn't allow the data packet to be transmitted. */
+		/* Commented by Albert 2012/07/21 */
+		/* When doing the WPS, the wps_ie_len won't equal to 0 */
+		/* And the Wi-Fi driver shouldn't allow the data packet to be transmitted. */
 		if (padapter->securitypriv.wps_ie_len != 0) {
 			psta->ieee8021x_blocked = true;
 			padapter->securitypriv.wps_ie_len = 0;
@@ -1916,10 +1916,10 @@ signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecurity
 signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, signed int keyid, u8 set_tx, bool enqueue)
 {
 	u8 keylen;
-	struct cmd_obj		*pcmd;
-	struct setkey_parm	*psetkeyparm;
-	struct cmd_priv 	*pcmdpriv = &(adapter->cmdpriv);
-	signed int	res = _SUCCESS;
+	struct cmd_obj *pcmd;
+	struct setkey_parm *psetkeyparm;
+	struct cmd_priv *pcmdpriv = &(adapter->cmdpriv);
+	signed int res = _SUCCESS;
 
 	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
 	if (!psetkeyparm) {
@@ -2023,9 +2023,8 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 /*  */
 /*  Search by BSSID, */
 /*  Return Value: */
-/* 		-1		:if there is no pre-auth key in the  table */
-/* 		>= 0		:if there is pre-auth key, and   return the entry id */
-/*  */
+/* -1 :if there is no pre-auth key in the table */
+/* >= 0 :if there is pre-auth key, and return the entry id */
 /*  */
 
 static int SecIsInPMKIDList(struct adapter *Adapter, u8 *bssid)
@@ -2186,8 +2185,7 @@ void rtw_joinbss_reset(struct adapter *padapter)
 {
 	u8 threshold;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	/* todo: if you want to do something io/reg/hw setting before join_bss, please add code here */
 
@@ -2213,11 +2211,11 @@ void rtw_joinbss_reset(struct adapter *padapter)
 
 void rtw_ht_use_default_setting(struct adapter *padapter)
 {
-	struct mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	bool		bHwLDPCSupport = false, bHwSTBCSupport = false;
-	bool		bHwSupportBeamformer = false, bHwSupportBeamformee = false;
+	bool bHwLDPCSupport = false, bHwSTBCSupport = false;
+	bool bHwSupportBeamformer = false, bHwSupportBeamformee = false;
 
 	if (pregistrypriv->wifi_spec)
 		phtpriv->bss_coexist = 1;
@@ -2288,7 +2286,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	u8 cbw40_enable = 0, stbc_rx_enable = 0, operation_bw = 0;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	phtpriv->ht_option = false;
@@ -2417,7 +2415,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	struct ieee80211_ht_cap *pht_capie;
 	/* struct recv_reorder_ctrl *preorder_ctrl; */
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	/* struct recv_priv *precvpriv = &padapter->recvpriv; */
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	/* struct wlan_network *pcur_network = &(pmlmepriv->cur_network);; */
@@ -2546,7 +2544,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 void rtw_append_exented_cap(struct adapter *padapter, u8 *out_ie, uint *pout_len)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	u8 cap_content[8] = {0};
 
 	if (phtpriv->bss_coexist)
-- 
2.34.1


