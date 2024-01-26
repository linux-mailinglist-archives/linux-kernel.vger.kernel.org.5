Return-Path: <linux-kernel+bounces-40775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E835883E586
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A54F1F24F42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0805D8EC;
	Fri, 26 Jan 2024 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="jAkIPTXu"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A525B5CF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308313; cv=none; b=UDbgfK8z5UAUt1ag3KtDHTDU4grQwl6qsjsGkUIlFLUuEylVpWA3caXKF8E1dHdzu+W95hV6a+sg26BnTzb6uOPq+A4n23QlrcVonYIMPjZ2M0sY5T4R70XkCwWAa9+z5jzveCFxFjk0ABfjWWqkpHicFpQLcj6CTsmhvefLKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308313; c=relaxed/simple;
	bh=WJNm6B/bx20WS5CTxEEaZHp1YFtjt5JPCFFa10n1LUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IUNauMIFdLDyDbOBHDh/t5Gr2gf8CX2Y8tBU2Kr3bPLLsyYycS3B9fRTdFHGcVDghurTMs1xfx3lP7iJwpRbBwkLX7dam8PK9ftDIjORbh9+mgk7Cc9/Uvx5lTryCzc/xT9WZGKUCBZNLWjIXRf3W07gvXEuJ8eUEJlFonctCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=jAkIPTXu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7354ba334so7401915ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308311; x=1706913111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVgEhtphK9iV5cf+xa25OpN0r057+yWIzXZirMDgj6M=;
        b=jAkIPTXurwmJgpVZDsfEOEW4g0b4ILIIEaPoqM1dHEG7kynD0emfm6w9nw2+kj9Klg
         6Vy6QLL3pAacKBcZXHzOFfItyjB5E1nrBOMXlAZQyQI18iWr1rIdqKKOwcZOY9I87q8M
         T2rUA+CZmunb1O2CCRcefcnlCY3JJvdc9aAB94Q7I32dqLZ1vPoc3mLPMqPFtjCSkIVe
         6uz4pb9nrYlI+sU9xp5hyklwuPy2U/12DDjaqtttTdaH6i7Pn3lV3oKu3vDMA0hS0NO6
         Cc3C+/VTfeTVpbhQQfxFv9oFN1ud3sPleGyYdf82cxrmYz9EG1S2F0q/2cDRuWXC3yIM
         47eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308311; x=1706913111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVgEhtphK9iV5cf+xa25OpN0r057+yWIzXZirMDgj6M=;
        b=UWUl8MDV0Gwp0c+sUwnv/9FAV/Wb4M/spn5lotohFW35Up17Onq7IAnKZs3gB96MD3
         18hLtBfZnyoRinTHSCihsite3N4Jau6sTCrBtxPdO/u1yq9gsY1ZXMnW1dVJYQJVlMRp
         5D5SpVsN1dLMyG3HQ7k8znme1CRafi84yyL1NEL0f+g0ArHjss4qEoSBS3HzjtgCAiex
         r2ctpugrwiKhN9+w0dKBbaRpenUdOfgu8yI7VsxtozdTuxLVxnD01mZU4eQNcBV+HyTD
         nRYRW+urTBPVvUwEcvm8F/zaKxXpdBcIFko0HB9GzHPKHbjf1/+HYNj+QcNAtQXy2WRX
         n5cw==
X-Gm-Message-State: AOJu0Yw9d0vMZ6NtdbRWJGo9oyBp2Olo3FyWux/kTLvz1ZBzWH1Bj/Bv
	6dTat/vzTiHQFVWjyoYIfQfaZsqNbrlqH3FW6P0JV6C+H1ySGuosokUFeWrbt3E=
X-Google-Smtp-Source: AGHT+IHR0XhV7qeEWAZ8HGT9yky5/dKnOALYspJxXUcsQLuf7T2uVc/wEKi+eP+diY/HE5da84nnvQ==
X-Received: by 2002:a17:902:bb86:b0:1d7:587f:3748 with SMTP id m6-20020a170902bb8600b001d7587f3748mr493743pls.63.1706308311410;
        Fri, 26 Jan 2024 14:31:51 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:51 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 17/18] Staging: rtl8192e: Rename variable NumRecvBcnInPeriod
Date: Fri, 26 Jan 2024 14:31:05 -0800
Message-Id: <20240126223106.986093-18-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126223106.986093-1-tdavies@darkphysics.net>
References: <20240126223106.986093-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable NumRecvBcnInPeriod to num_recv_bcn_in_period to fix 
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Update commit message.
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 6 +++---
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 79e66b726b28..cda00efed227 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -924,7 +924,7 @@ static void _rtl92e_update_rxcounts(struct r8192_priv *priv, u32 *TotalRxBcnNum,
 	slot_index = (priv->rtllib->link_detect_info.slot_index++) %
 			(priv->rtllib->link_detect_info.slot_num);
 	priv->rtllib->link_detect_info.RxBcnNum[slot_index] =
-			priv->rtllib->link_detect_info.NumRecvBcnInPeriod;
+			priv->rtllib->link_detect_info.num_recv_bcn_in_period;
 	priv->rtllib->link_detect_info.RxDataNum[slot_index] =
 			priv->rtllib->link_detect_info.NumRecvDataInPeriod;
 	for (i = 0; i < priv->rtllib->link_detect_info.slot_num; i++) {
@@ -1046,7 +1046,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 
 			priv->check_roaming_cnt = 0;
 		}
-		ieee->link_detect_info.NumRecvBcnInPeriod = 0;
+		ieee->link_detect_info.num_recv_bcn_in_period = 0;
 		ieee->link_detect_info.NumRecvDataInPeriod = 0;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0ca38ca4d3af..07a89d1af86d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1110,7 +1110,7 @@ enum scan_op_backup_opt {
 
 #define RT_MAX_LD_SLOT_NUM	10
 struct rt_link_detect {
-	u32				NumRecvBcnInPeriod;
+	u32				num_recv_bcn_in_period;
 	u32				NumRecvDataInPeriod;
 
 	u32				RxBcnNum[RT_MAX_LD_SLOT_NUM];
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index f777febcfe3b..e6be6dbe2bb5 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2470,7 +2470,7 @@ static inline void rtllib_process_probe_response(
 		}
 		if (ieee80211_is_beacon(frame_ctl)) {
 			if (ieee->link_state >= MAC80211_LINKED)
-				ieee->link_detect_info.NumRecvBcnInPeriod++;
+				ieee->link_detect_info.num_recv_bcn_in_period++;
 		}
 	}
 	list_for_each_entry(target, &ieee->network_list, list) {
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index a7e7a0b0214f..ba35714f83af 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1074,9 +1074,9 @@ static void rtllib_associate_complete_wq(void *data)
 	ieee->link_detect_info.slot_num = 2 * (1 +
 				       ieee->current_network.beacon_interval /
 				       500);
-	if (ieee->link_detect_info.NumRecvBcnInPeriod == 0 ||
+	if (ieee->link_detect_info.num_recv_bcn_in_period == 0 ||
 	    ieee->link_detect_info.NumRecvDataInPeriod == 0) {
-		ieee->link_detect_info.NumRecvBcnInPeriod = 1;
+		ieee->link_detect_info.num_recv_bcn_in_period = 1;
 		ieee->link_detect_info.NumRecvDataInPeriod = 1;
 	}
 	psc->lps_idle_count = 0;
@@ -2070,7 +2070,7 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 
 	ieee->link_detect_info.slot_index = 0;
 	ieee->link_detect_info.slot_num = 2;
-	ieee->link_detect_info.NumRecvBcnInPeriod = 0;
+	ieee->link_detect_info.num_recv_bcn_in_period = 0;
 	ieee->link_detect_info.NumRecvDataInPeriod = 0;
 	ieee->link_detect_info.num_tx_ok_in_period = 0;
 	ieee->link_detect_info.num_rx_ok_in_period = 0;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 2afa701e5445..4102c2d4f8dd 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -347,9 +347,9 @@ void rtllib_wx_sync_scan_wq(void *data)
 	/* Notify AP that I wake up again */
 	rtllib_sta_ps_send_null_frame(ieee, 0);
 
-	if (ieee->link_detect_info.NumRecvBcnInPeriod == 0 ||
+	if (ieee->link_detect_info.num_recv_bcn_in_period == 0 ||
 	    ieee->link_detect_info.NumRecvDataInPeriod == 0) {
-		ieee->link_detect_info.NumRecvBcnInPeriod = 1;
+		ieee->link_detect_info.num_recv_bcn_in_period = 1;
 		ieee->link_detect_info.NumRecvDataInPeriod = 1;
 	}
 	rtllib_wake_all_queues(ieee);
-- 
2.39.2


