Return-Path: <linux-kernel+bounces-48288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B009284599E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5E6B23C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2A262179;
	Thu,  1 Feb 2024 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU4kvFll"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024DF62168
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796322; cv=none; b=GdpHlpxHie+sUx+0pAjWeC1TqEyvbWuJEIH09NIBmurbJsF6AA15PVIoAUIM47kckppp7XhyKUnZwFF9n/uxlomDBcMnTt32BQDux2sGdJRoIFqf+gvxPBSMLIp3swVpsrbEhE3bt9+UtJDVxQHReYrdABU8bGvhnOxcS291nik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796322; c=relaxed/simple;
	bh=dUpEwtl6HrWQwmNRsfssIbEHclysv218wLdB+QE1DWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jk05YjESouB18sDzLjoUY4SXCyC+UKETDjqHjT2sYZD4wb1AqZk0jum5EnGZ8zz+aKIuq2Jju5eO79/kYqfPEmr/vEDtRLFYWVQ3qW3sIz4979V9NcR7jQ/HlajA443HNn2yJ4iD3FsWmbu4fFmVt+Bg5oqsxewYC0mjj453H+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cU4kvFll; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fc2a6f8b6so1927905e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706796318; x=1707401118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdXU5rj7eakY5p27mKvfYSeW9QV6FkZ4NSs0xJtV3vw=;
        b=cU4kvFllJeNSQHkFTb/uosGoV06aqDnHpdE1rQqEfmGb5AR8apLwsNarzMQhXOoa2g
         aWK6qLeAQszkf0MlZy0LKOT0wC7tqcrZ35c1bfde1ftJLZmikLuQgqmczI5YX37gmDp6
         SSykZidl62EP9zaigmJ/LUzayrntmu9vuCUaiOKPQ2P2AsLdTjzmehLKc3EampI8xKAY
         qzA5wbr/sDiSZjrLRo54Ch+NSDVphKcwwVGiUkj1PssMN+/EcZ9iTu65Qn4LPHgr688a
         P2Z010IMc669K1qVJ15869969Opw+2uZUyhbR79/bA5/oGimgkRapWnLaQEfRFlkvyDL
         xK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796318; x=1707401118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdXU5rj7eakY5p27mKvfYSeW9QV6FkZ4NSs0xJtV3vw=;
        b=lvH54APqK5OVL72a5BRdXBUInuUKE7rzm5pp+25q+2xil15Zj3HP38lnowEZe4Xg5a
         Xfx3H88ensNnKR5DbCwRuGstWUqL5VLIWK7cU4dtTPJLHd73dUsMw7HxyKXTOcExx/OV
         QAPxIkQO7WceAd/FqHnVh0wgfqBneharfluQBlPhY+khG0/2T95MMpxmR9ijfbULPER0
         AL3HYzmSS9bYjA7mu7HZGPE8556RxPAfSh0k20L7pGI8twzbSxtxSR7eeR13Ip9P0kvl
         Qxrbh7QaAXdOURtwyL0FfyPEM5TpG90siLAOTCaCmv8vp7gp6F0PeA0lYdEWFdwUiriW
         hVqQ==
X-Gm-Message-State: AOJu0Yy+vp3hnK2DiQ9NXUsICVWNyuu1Qoim0b8vImrIEQhL454uzzOy
	E6coP1yk6Si3JSZ+NrlkIUlR+AQM/D46Yh5rsbjyDtBdqP253466
X-Google-Smtp-Source: AGHT+IFxA1ogf/virsIXTJ/ZtZ86nDJzZNd+ZydaO5BklUltbf9SJS/NkIfszYgY8bLVS1VThYs9MA==
X-Received: by 2002:a5d:548d:0:b0:33b:1bb9:af19 with SMTP id h13-20020a5d548d000000b0033b1bb9af19mr104050wrv.54.1706796318130;
        Thu, 01 Feb 2024 06:05:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUzk7AUvEJhqoe8POG+VzWLqYmptGvNd08BPjkPQ1kmC8OFA9WF9m1GHxCGXGlIBVWAqGx17N/Fd1KJzwdO2T+vJgu+spml0jKpInVNXFRlL9zpSLqAdiHbP7Yx59I3NMA8kBtzWXxqfrIO+kw53JWVXH5JywfjfCy8x4luRyad1jhX8ynqFvvEoOQV6Xhve7i6kZ/mxhNySsZqiMgrUVxys67LWO0I
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.152])
        by smtp.gmail.com with ESMTPSA id ci10-20020a5d5d8a000000b00339281d98c9sm16522227wrb.72.2024.02.01.06.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:05:17 -0800 (PST)
From: Meir Elisha <meir6264@gmail.com>
X-Google-Original-From: Meir Elisha <meir6264@Gmail.com>
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Thu, 01 Feb 2024 16:05:14 +0200
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@Gmail.com>
Subject: [PATCH v2 4/4] Staging: rtl8723bs: fix else after break warning
Date: Thu,  1 Feb 2024 16:04:59 +0200
Message-Id: <20240201140459.438479-5-meir6264@Gmail.com>
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

Fix checkpatch warning:
else is not generally useful after a break or return

Signed-off-by: Meir Elisha <meir6264@Gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 40 +++++++++--------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 13bc0ebca247..6a9b57fd1a97 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1498,30 +1498,25 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	if (rtw_to_roam(adapter) > 0) { /* join timeout caused by roaming */
+	if (rtw_to_roam(adapter) == 0) {
+		rtw_indicate_disconnect(adapter);
+		free_scanqueue(pmlmepriv);
+		/* indicate disconnect for the case that join_timeout
+		 * and check_fwstate != FW_LINKED
+		 */
+		rtw_cfg80211_indicate_disconnect(adapter);
+	} else { /* join timeout caused by roaming */
 		while (1) {
 			rtw_dec_to_roam(adapter);
-			if (rtw_to_roam(adapter) != 0) { /* try another */
-				int do_join_r;
-
-				do_join_r = rtw_do_join(adapter);
-				if (do_join_r != _SUCCESS)
-					continue;
-
-				break;
-			} else {
+			if (rtw_to_roam(adapter) == 0) {
 				rtw_indicate_disconnect(adapter);
 				break;
+			} else if (rtw_do_join(adapter) != _SUCCESS) { /* try another */
+				continue;
 			}
-		}
-
-	} else {
-		rtw_indicate_disconnect(adapter);
-		free_scanqueue(pmlmepriv);/*  */
-
-		/* indicate disconnect for the case that join_timeout and check_fwstate != FW_LINKED */
-		rtw_cfg80211_indicate_disconnect(adapter);
 
+			break;
+		}
 	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
@@ -2052,12 +2047,9 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
 	}
 
 	iEntry = SecIsInPMKIDList(adapter, pmlmepriv->assoc_bssid);
-	if (iEntry < 0) {
-		return ielength;
-	} else {
-		if (authmode == WLAN_EID_RSN)
-			ielength = rtw_append_pmkid(adapter, iEntry, out_ie, ielength);
-	}
+	if (iEntry > 0 && authmode == WLAN_EID_RSN)
+		ielength = rtw_append_pmkid(adapter, iEntry, out_ie, ielength);
+
 	return ielength;
 }
 
-- 
2.34.1


