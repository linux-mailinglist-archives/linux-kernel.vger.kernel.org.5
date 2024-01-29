Return-Path: <linux-kernel+bounces-42885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E30484081A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B14828FD53
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F8D679E9;
	Mon, 29 Jan 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhCTEMQZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816ED67757
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537959; cv=none; b=IWXlNE7YvRmCbHBnLxrnf1IMbNk+m+c+EM9MoEu03YUCtd/wHgwIDP7ErRdVvDCRTMbTtXk1fj3xCDSHWa1s0ASpdIXr4QvqCtDUzV7lKrlNPrS0yn0GO9KnVjQYzflSELRCqgchW6l16DHpX7Esjh9KQX0ScJbssPvkzlTficw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537959; c=relaxed/simple;
	bh=7O6rXoPUceZ5vSfUZs1f50iG4DBaw4PqXEIh8pA+98A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UK3CimCyPSKnqlQjAnBQstP2lbLdZAVowEnlbaAb5LYwpuV+oDo+OBk0TMEjfHsa2W7/WJDXkqJ07oDx54G1TfkZQlLXnvZNU7m8qGQDKZ5Fy+7LVgFKptNo/7ziBvSK5pCd9NSpJI2Gmpp7c1rm3xef+jF5380huPLkm63dVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhCTEMQZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e80046246so15095595e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706537956; x=1707142756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9moHDVvU6z3kwiFZUQJD1fH1NG2dZetKlW8LuOaa3I=;
        b=HhCTEMQZudA/fsp2SxlAFu6ZyNf5oLuM5KVJrNvggTP1Q+5rasL2sMQyQ7Zg0diYIN
         xqwXPelp/+Ijj//sP9B1tbMrK4aYRqt8SaDVmxPDyIaoApbMmsP7XgsKlUo8zTxGyKXA
         Rh1JUyCr8H9zPbBP/fwQ/EpigC3X+jG2dbPAqIDHLYRT81+q15kbMR3xv1x2zeNAzwYk
         P8rmKqgGiZXixnkqqdOay2tSSRyEX9ZsjgFRjTpEVk3D0Xbr86aw2VRO+MIyJddGN83O
         QtLOQJLYqThL5IrqIbEK4Urj/Fq+2X6LcomZkWz1JyW/omaYbuxu/juEKzSWcGk9IRIf
         Ufig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706537956; x=1707142756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9moHDVvU6z3kwiFZUQJD1fH1NG2dZetKlW8LuOaa3I=;
        b=VjLJIRaULEHQyfAoEMXA+DklSGRH39gz+mM/rcXPTjCNvpBsH0CFdNC2acrTAcB+9+
         vP8xnPGRCaU3BbU5fLy1zY2ZKPxLuRI+XAX829PlIP6aXD1DYjMStAE46Y2V+FFbualr
         8Qp5S7eE7akMnwHqBtZCMbXsqIBNVuoDLrE7iAL/ffvYMpUjL73rpBxhIPhe1PkCRYxd
         pXjsAu0kohJWsAbND5KpBexNv4FdHHUuODCI4FZz7/meu9By/pMIX+FY6w5RuQYGT6W/
         eDgMwq2Rzp2aTg4PNnxQEs8+nVnsT+PQ7G0RS5lcIu/vRA3EvpSrLzK71ijeFMsAx2Ke
         jpfQ==
X-Gm-Message-State: AOJu0YyYbsPe0rvFar1NAEfeg3wdfTzrtwUjirmLZN1+V/1sIWj2Iz9f
	4lmk6IHa9hv693RbU5w70cCK9sk3H+AS01KQ7Anifb1SHWJsYs/Z
X-Google-Smtp-Source: AGHT+IHm6388xm/QTCaGEDK1ImPfBbY9GsIXBQvs2+ki3e6r2DjTGCcPGaDAPpKFu3QXHl8Kc/TsKg==
X-Received: by 2002:a05:600c:3b9d:b0:40d:858c:53f6 with SMTP id n29-20020a05600c3b9d00b0040d858c53f6mr5412782wms.2.1706537955755;
        Mon, 29 Jan 2024 06:19:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXdm4wUtSp6rYEMPJ0lKaNsh61o/2lREf5Zq7rC+VWl+F4650XLgIVf07vKJ21/vvbM1453su4X/Q0Qqu3K9HBqHvEh+9g7fXt9yMQHTJFuy9I94ig3FgC47isLk+sRLWAmgRD0i7Yyg+sMzWvtuG1W0v5IbcvaIEnlNz+wqes2FLaQrF+qYdJ1i3SKq5GLjwSMsOE2VcS9PzR4yTGFhJhpv/rH7IkD
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.152])
        by smtp.gmail.com with ESMTPSA id e21-20020a05600c4e5500b0040efb8118e9sm1200186wmq.38.2024.01.29.06.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:19:15 -0800 (PST)
From: Meir Elisha <meir6264@gmail.com>
X-Google-Original-From: Meir Elisha <meir6264@Gmail.com>
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Mon, 29 Jan 2024 16:19:12 +0200
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@Gmail.com>
Subject: [PATCH 4/4] Staging: rtl8723bs: fix else after break warning
Date: Mon, 29 Jan 2024 16:18:56 +0200
Message-Id: <20240129141856.416532-5-meir6264@Gmail.com>
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

Fix checkpatch warning: else is not generally useful after a break or return

Signed-off-by: Meir Elisha <meir6264@Gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 38 +++++++++--------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 044483f3d678..efaac84f22b4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1540,30 +1540,23 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	if (rtw_to_roam(adapter) > 0) { /* join timeout caused by roaming */
+	if (rtw_to_roam(adapter) == 0) { /* join timeout caused by roaming */
+		rtw_indicate_disconnect(adapter);
+		free_scanqueue(pmlmepriv);
+		/* indicate disconnect for the case that join_timeout and check_fwstate != FW_LINKED */
+		rtw_cfg80211_indicate_disconnect(adapter);
+	} else {
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
@@ -2102,12 +2095,9 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
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


