Return-Path: <linux-kernel+bounces-48286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5DB84599C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389341C29E59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B16214F;
	Thu,  1 Feb 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd6k5Bo4"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D1862147
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796315; cv=none; b=jfBPZthznQsXnZVchEuu0tFkZP8zl/k5+xgVCzlu7E9E0ooX1s/ki5z8xuCt5cNqc+rOA4ljUyvoc7DT7tudz19gZwh7XqjTXkqhawO3XFtJpkFEGjFhtQzdUrfo2XBI4EsBIwlSvnUOVI6r4V+VRb8bDQUcTzcYAD/P021HQF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796315; c=relaxed/simple;
	bh=doqVg32v7vIXscJEiFexLeEzcj2vJg0MBtuXG8tbG6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqX4LzJjcf+i8LV+uH0+R5rVzESui2mfsEPLsJH8ORjCq7eSfHLlhuQ8QqVKz35tjoKzvUPHXgK9c0am9XUcPGgLaYuLx3xunmrUL9RGNA3Pndr2LrQy0os4gI020J5I94jf2MxB5UqHvgOrELXkGq/HEvGLxf2Vkh2o/fd8t1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nd6k5Bo4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51109060d6aso1334521e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706796312; x=1707401112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgOtegluLN4loNFZ9r7TiOQHnc8n5M4kjeOTEoBqU5s=;
        b=nd6k5Bo4o8KZKQeDXUj0HBNObRsG3z0SPeCDjT/UXYHeSJ/HO38QF1ZowLIszVm9JS
         b2+mWuCdI+BJYb7ioju9E/XloIfOlCnfPBV0v7WFksf4X0jb8FpkMZtg7HKMvebRwddw
         idSHDgN5GD7zGgPj4OkYJ6p9KpaPS1eGMFPGWg+XKZI8kSIzLtBnqdZX9KamSx4WH6ey
         all42A4MlvKmofEsrG1yOVWoLcKZoi/OLqW2njHbfxGVyH3vLS9QeU1+n19nE/nHOnF3
         F/CshCIc3+wCVJKQPGhvNBz1GRdn9PSanmLN4rIXewirt+RFcycsu9AbyGnLjRhkHm3m
         7YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796312; x=1707401112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgOtegluLN4loNFZ9r7TiOQHnc8n5M4kjeOTEoBqU5s=;
        b=sxGKWMhMFcgFOtJ+o8MRGhNwQMV0qw3sBlz9E+IgM45T5u2aOxM9QQQFDOIV4JS5fQ
         JSSR2s5JYvFzalpEyyXDQ4WKa7uE1Jx6n2LQI2oqPuV8twyXGJcgHCXQPwSTWDeHca0G
         UdfcyOqslyiPz5GrpsQ13A0zP2DNel2Ei33CYIDqpIf305hUHhVN/G2oEar2floIjh2g
         bNPZFRUp1mKAyPWUD32GHzZZeTrhE4IakPPrEH6c0J7B23jq3bml+alvMx8UCJggh9Py
         KmsvetDN/r23zqqoadugEWKh7JYRH1qXbRjd4c9Kx3GNzO/yLIXmrinIZiVMf5581Bag
         uiNA==
X-Gm-Message-State: AOJu0YzYCpHrFm4YBU0B5jrvucqFjguUFA45CK/GJZQEdtX+egHVqxCz
	nDu+/di3z9vCHC1wAfNo17MerqwdHGmThH2smMQ8bBB4R83LV7ee
X-Google-Smtp-Source: AGHT+IHe/3kqoQJs4/u8mvWD0cFsSLHHz9cTu4GGuhj+0Kg2XHv89D2LrOESMlVhukJ2cjyWl0CCMg==
X-Received: by 2002:a05:6512:3b85:b0:511:3130:de30 with SMTP id g5-20020a0565123b8500b005113130de30mr1353871lfv.16.1706796311474;
        Thu, 01 Feb 2024 06:05:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWHaEXzNaHUnLxzhM+aUgsLCOJSSJs50h7aZGHZKw2L+U6VEgUkiF86W1ctqtpR1dx9a6tFkBQUG3a5avXaVDgvK5LCBzpCCYYtsZP/7whP3TD5i8e40QigOb2NQlw7NSuE1O1jJqSSkwORaz1S9P/UYvZy7f00BlhKcbVxmzAHyDEHrroV5RF4kNwgMTBcsU9EstNzbws6FeDUyPk8RR73fZdtjioL
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.152])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b0040d4e1393dcsm4567869wmj.20.2024.02.01.06.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:05:10 -0800 (PST)
From: Meir Elisha <meir6264@gmail.com>
X-Google-Original-From: Meir Elisha <meir6264@Gmail.com>
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Thu, 01 Feb 2024 16:05:07 +0200
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@Gmail.com>
Subject: [PATCH v2 2/4] Staging: rtl8723bs: Remove extra spaces
Date: Thu,  1 Feb 2024 16:04:57 +0200
Message-Id: <20240201140459.438479-3-meir6264@Gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201140459.438479-1-meir6264@Gmail.com>
References: <20240201140459.438479-1-meir6264@Gmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 63 ++++++++++-------------
 1 file changed, 26 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 5568215b35bd..44b77c1ba992 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -169,7 +169,6 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 {
 	unsigned int delta_time;
 	u32 lifetime = SCANQUEUE_LIFETIME;
-/* 	_irqL irqL; */
 	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
 
 	if (!pnetwork)
@@ -389,14 +388,10 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 	d_cap = le16_to_cpu(tmpd);
 
 	return (src->ssid.ssid_length == dst->ssid.ssid_length) &&
-		/* 	(src->configuration.ds_config == dst->configuration.ds_config) && */
-			((!memcmp(src->mac_address, dst->mac_address, ETH_ALEN))) &&
-			((!memcmp(src->ssid.ssid, dst->ssid.ssid, src->ssid.ssid_length))) &&
-			((s_cap & WLAN_CAPABILITY_IBSS) ==
-			(d_cap & WLAN_CAPABILITY_IBSS)) &&
-			((s_cap & WLAN_CAPABILITY_ESS) ==
-			(d_cap & WLAN_CAPABILITY_ESS));
-
+		((!memcmp(src->mac_address, dst->mac_address, ETH_ALEN))) &&
+		((!memcmp(src->ssid.ssid, dst->ssid.ssid, src->ssid.ssid_length))) &&
+		((s_cap & WLAN_CAPABILITY_IBSS) == (d_cap & WLAN_CAPABILITY_IBSS)) &&
+		((s_cap & WLAN_CAPABILITY_ESS) == (d_cap & WLAN_CAPABILITY_ESS));
 }
 
 struct wlan_network *_rtw_find_same_network(struct __queue *scanned_queue, struct wlan_network *network)
@@ -627,11 +622,11 @@ void rtw_add_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
 }
 
 /* select the desired network based on the capability of the (i)bss. */
-/*  check items: (1) security */
-/* 			   (2) network_type */
-/* 			   (3) WMM */
-/* 			   (4) HT */
-/*                      (5) others */
+/* check items: (1) security */
+/* (2) network_type */
+/* (3) WMM */
+/* (4) HT */
+/* (5) others */
 int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork);
 int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork)
 {
@@ -1054,9 +1049,9 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
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
@@ -1916,10 +1911,10 @@ signed int rtw_set_auth(struct adapter *adapter, struct security_priv *psecurity
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
@@ -2023,9 +2018,8 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 /*  */
 /*  Search by BSSID, */
 /*  Return Value: */
-/* 		-1		:if there is no pre-auth key in the  table */
-/* 		>= 0		:if there is pre-auth key, and   return the entry id */
-/*  */
+/* -1 :if there is no pre-auth key in the  table */
+/* >= 0 :if there is pre-auth key, and   return the entry id */
 /*  */
 
 static int SecIsInPMKIDList(struct adapter *Adapter, u8 *bssid)
@@ -2186,8 +2180,7 @@ void rtw_joinbss_reset(struct adapter *padapter)
 {
 	u8 threshold;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	/* todo: if you want to do something io/reg/hw setting before join_bss, please add code here */
 
@@ -2213,11 +2206,11 @@ void rtw_joinbss_reset(struct adapter *padapter)
 
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
@@ -2288,7 +2281,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	u8 cbw40_enable = 0, stbc_rx_enable = 0, operation_bw = 0;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	phtpriv->ht_option = false;
@@ -2413,14 +2406,10 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 {
 	u8 *p, max_ampdu_sz;
 	int len;
-	/* struct sta_info *bmc_sta, *psta; */
 	struct ieee80211_ht_cap *pht_capie;
-	/* struct recv_reorder_ctrl *preorder_ctrl; */
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
-	/* struct recv_priv *precvpriv = &padapter->recvpriv; */
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	/* struct wlan_network *pcur_network = &(pmlmepriv->cur_network);; */
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 cbw40_enable = 0;
@@ -2546,7 +2535,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 void rtw_append_exented_cap(struct adapter *padapter, u8 *out_ie, uint *pout_len)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	u8 cap_content[8] = {0};
 
 	if (phtpriv->bss_coexist)
-- 
2.34.1


