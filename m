Return-Path: <linux-kernel+bounces-37782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C5583B4F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8352E1F229B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A1313D51A;
	Wed, 24 Jan 2024 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="TIZKQ1hp"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F113D4E7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136313; cv=none; b=ZDRMwRzWoDTmmLey+JyYy19fV4hs/GtosSn/nBWjZLMxRzB/5eUIfjdRNJC41B6JPVIs2jfwe0Z1EM3Clg98l+OxJ9pdK4rsMqUvLiLbPNWFkkZRo+CluAZsm/zc7RcI5jLqnnh6L6wikvK8FkPaMIbVJ/CA9b26+9qdyxhJIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136313; c=relaxed/simple;
	bh=LPmUtH3SPc1v2gg3Rw3RlAoi3PtOhFh9BlCSFSuFjv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kNr8wsuAaDJrrFkLAk46NbJ7R5CJhvcK6F2STl24d22vXgI/w5WT5ED4AmKJzI2WCvZoAmm3hXfmCpRXJ1OVqGFmRixyzyFb5pQ/xP5fXDmA35aK9psb4pXdnDswIMSHN2Z7+vUFUWtxccdI2nkCh/u1r8hRv30EftVbPliZ0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=TIZKQ1hp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71cb97937so38782175ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136311; x=1706741111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfwpbVLw9/878UEFWYnT26awViD4BtFws5hlAMXSCyc=;
        b=TIZKQ1hprM3rtFi07poFvSUv09lu/owdT2OoUcNyRPFomNlXYa7q01U6oZAAwjpEMX
         yxN0iU8KetMYYjySBGXudSlc4GPtAAJDxl6m86pgRq6dbghn+klS+mwnRHx1EeoNIhGW
         fNRmzzL/oWEzkLceRdUgD1AYnjDEamNeQqh/y/TQizErlj7rKfLb8C/S3rrD6MtI/JP3
         WVFF7GArar9rkJZxc+94n8vGWZc0mr2uQkR4bOoM/s9BAw3+pgliMhkDbUx0vCmywYh+
         tDyHZtX+9oGUXg8RRFlezXTfSQ4JUpVecX4FugFJSHE9JdWVufxIXMImsksa6Wq0YJys
         bYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136311; x=1706741111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfwpbVLw9/878UEFWYnT26awViD4BtFws5hlAMXSCyc=;
        b=FaKoeeXhx8J3xTc/IrY/3iSyroTLppIP9MLDbruljO2Mqw20KLMEUsrvLNUAAWG3VU
         OT9bGG5Yc8IhEaaDS97ArtM4n94DApNk+9wlimIElcxKL1iiIBmGklW0tF9ZAAMC3RH/
         Jr5KUX+WuvxPnz0rxCmsUlhd99Iqq2F65ZRYqkljnYhR2A+BicTbGo4kQXX83hVbamaM
         5P1HjPHSuDhGXPfqUaC2AZfe3+4aDpvPq/8yfhzAj6wwe8Ego9cpbtwyndHTPXB+3msy
         uDNbQZ2Vu7JMThUrkXq6Ywr2EkhXICwC4shImm5whBLOkI3owhCCIoZsgf0ba/b48+ZC
         ECUA==
X-Gm-Message-State: AOJu0Yw/VAThH/2MG+yu9uqbTpKKaH/HqDgt6HnaHCId7aNtusCEeYkb
	JWWQmOvY33CVAOvYIWmHyMASGwVFthPriBJzMI7H4Ko4lFgmh4zo8Ng/1JtQM/lx9nDeiBmxArL
	a
X-Google-Smtp-Source: AGHT+IGTgpZY7k8hICdIlRQHzBQxcy1NjJ781Jj+4noURQvHUlB+VgO+G4r4p312AhNP7peY27AxsQ==
X-Received: by 2002:a17:903:444:b0:1d7:562f:67ec with SMTP id iw4-20020a170903044400b001d7562f67ecmr65679plb.102.1706136311722;
        Wed, 24 Jan 2024 14:45:11 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:45:11 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 17/18] Staging: rtl8192e: Rename variable NumRecvBcnInPeriod
Date: Wed, 24 Jan 2024 14:44:51 -0800
Message-Id: <20240124224452.968724-18-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124224452.968724-1-tdavies@darkphysics.net>
References: <20240124224452.968724-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable NumRecvBcnInPeriod to num_recv_bcn_in_period to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
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


