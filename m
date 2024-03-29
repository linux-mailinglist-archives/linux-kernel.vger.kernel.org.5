Return-Path: <linux-kernel+bounces-125114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E31E892047
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8921288BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A980312A144;
	Fri, 29 Mar 2024 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIMDfDbC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AAF1386A1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725006; cv=none; b=FZLbIyMX2JrlheJ2j/ZPec2MS1XMDrXPitJ664YOm02vNPmEbcoMa3AIF5/dZFx2CBwLtT/ybMxdS2iXIp1bwpmLaiNsywdkCFaoEi9fQGW4yzd7Ru3Ijr10dsIoogl/VDEXRSLjYjM/Gnl/XRlQMHK2iJwQd0tPPUPVQRBPzMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725006; c=relaxed/simple;
	bh=2kwUzZaleVi4irMr+7mqtW4x9kUarWBZ7VVgzKi+2FI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PC9RZXVbSRU5oIvUJAaveIJ++4omKPr9WYY7GKsO3G3UVA/D0m+MZDtoqQx6twL32kjcLfmA5GDOl1KBEi4FA4z7FuJnPNk4AnO3lD+D8Hp+shPp96TFy2mUTOZMxEGLYIwRegG3+drvbFgV+blmUol7fs4ljX5GLbzSpsyLFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIMDfDbC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41551526477so2889185e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711725002; x=1712329802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Or9w9ducubbXE9C/BqcF7Qe9s/HO90e2lprYdz4vT8I=;
        b=GIMDfDbCu8q4xMXijTEOjgPgeidos3TTA8qnyOPgURqrxW4+r46QRxXE53HcYcjR53
         qC57HSxez8yELNOPZX14zZaZccRL91Rsv1rTRkv8yLkGOawI6au9D+2cHKQKu1IUBFNJ
         rc8gW6bD8KSex000Gprnd8UBFlLyGK7SuNh39TgmpQM3J7bgl9Rzu+qFf/WVJxVYXhMQ
         FtfhZP6wFX0pNPX4ViLhhFNcdFMBjNzHFYP4fLU+EGmC2NMjIxUxSZcIuoqsc8uvUQAD
         fyCWSL+TbvNBSmGW1AIrOQ2mSNS1Vp2xtt0JKQm1UokYCGxTYNJWkUIPVPaP8LjoNVzV
         vDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711725002; x=1712329802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Or9w9ducubbXE9C/BqcF7Qe9s/HO90e2lprYdz4vT8I=;
        b=eg44LmLHPpd8SlA/CfW/AjUlZ+UMNM6RA0r94swV+z1PLGbrYVJ5XuYCt7NgtyuaYf
         lEXxgwZNmEITpR9lWzJ3WiVLi8cNk7VyECHwKvmhx/OwUJLsRwUfekAfvFZ7Wevgv8xp
         11rPdQ0irFs8kz0aN+DEdMtlefPUETlWIWSNBCfvFGQWuq2i8mtMcQpZoR19AGVis/bu
         FMjLtObKpQSjVezCT5s52fwex3gUx1pTJEtaou7ycO6TnI0nIOHRit7jJuWIEM55HG5t
         XVs8f0yLYCaM+1GzdZXfLb6tigylSNZzK9NtgwKSrrXaAlJyng82qorbZ/CvwGR8Q2iF
         A/5w==
X-Forwarded-Encrypted: i=1; AJvYcCUTaYaJQqfw3Rv3pMffs9GAzqZWC3BLXfaH9qfjOUM03Zn+aAvRLuH+i0waOgBIyC5irYGZCnkT7ZJey3RV95uC43o44mIDd/VA+Cnx
X-Gm-Message-State: AOJu0YxxOT+d8h6f5nCKxfl3awZy4XPtOqcZCBtEUEwqFCD6EZreYcNr
	gPg8ptNHWWt/RU4hNrzpfF/Fx242Obl1rqaACkkfWljzykzCY3W/
X-Google-Smtp-Source: AGHT+IHuMC4sVFso4VNqXePgoGlZMY+Ed21pqVrrWKGmFN37nMB4X3X5h0nh03dOPTLhcDQSNy1HXQ==
X-Received: by 2002:a05:600c:5246:b0:414:69be:54b0 with SMTP id fc6-20020a05600c524600b0041469be54b0mr1780800wmb.22.1711725002019;
        Fri, 29 Mar 2024 08:10:02 -0700 (PDT)
Received: from Ubuntu22.myguest.virtualbox.org (bzq-84-108-64-153.cablep.bezeqint.net. [84.108.64.153])
        by smtp.gmail.com with ESMTPSA id d8-20020adfef88000000b0033ed7181fd1sm4381514wro.62.2024.03.29.08.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 08:10:01 -0700 (PDT)
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Fri, 29 Mar 2024 18:09:59 +0300
From: Meir Elisha <meir6264@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@gmail.com>
Subject: [PATCH] Staging: rtl8723bs: remove spaces before tabs in rtw_set_key()
Date: Fri, 29 Mar 2024 18:09:53 +0300
Message-Id: <20240329150953.17350-1-meir6264@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove spaces before tabs in order to improve coding style.

Signed-off-by: Meir Elisha <meir6264@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 36 +++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index bfb27f902753..5a506fe4698b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -626,10 +626,10 @@ void rtw_add_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
 
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
@@ -1052,9 +1052,9 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
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
@@ -1916,7 +1916,7 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 	u8 keylen;
 	struct cmd_obj		*pcmd;
 	struct setkey_parm	*psetkeyparm;
-	struct cmd_priv 	*pcmdpriv = &(adapter->cmdpriv);
+	struct cmd_priv *pcmdpriv = &(adapter->cmdpriv);
 	signed int	res = _SUCCESS;
 
 	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
@@ -2021,8 +2021,8 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 /*  */
 /*  Search by BSSID, */
 /*  Return Value: */
-/* 		-1		:if there is no pre-auth key in the  table */
-/* 		>= 0		:if there is pre-auth key, and   return the entry id */
+/* -1: if there is no pre-auth key in the  table */
+/* >= 0: if there is pre-auth key, and   return the entry id */
 /*  */
 /*  */
 
@@ -2185,7 +2185,7 @@ void rtw_joinbss_reset(struct adapter *padapter)
 	u8 threshold;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	/* todo: if you want to do something io/reg/hw setting before join_bss, please add code here */
 
@@ -2211,11 +2211,11 @@ void rtw_joinbss_reset(struct adapter *padapter)
 
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
@@ -2286,7 +2286,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	u8 cbw40_enable = 0, stbc_rx_enable = 0, operation_bw = 0;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	phtpriv->ht_option = false;
@@ -2415,7 +2415,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	struct ieee80211_ht_cap *pht_capie;
 	/* struct recv_reorder_ctrl *preorder_ctrl; */
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	/* struct recv_priv *precvpriv = &padapter->recvpriv; */
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	/* struct wlan_network *pcur_network = &(pmlmepriv->cur_network);; */
@@ -2544,7 +2544,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 void rtw_append_exented_cap(struct adapter *padapter, u8 *out_ie, uint *pout_len)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	u8 cap_content[8] = {0};
 
 	if (phtpriv->bss_coexist)
-- 
2.34.1


