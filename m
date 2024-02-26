Return-Path: <linux-kernel+bounces-80484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FE48668E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B06AB20E24
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670F1B800;
	Mon, 26 Feb 2024 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="L3zFC5/4"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B812DF4D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919791; cv=none; b=EZtZI6RDn+1DN1fsZBq8MmlK0qp6cPJxxl6nq099lZwaZnhPaMUgM2hPGOJsgyiWitCYsO6M6pwDKToeEAZUg0F8xUvOjbFjisvgJmLIZ8ZFH18LN78H9WelHOSEuPPPAuU/Dbag+eujJSGVGQ5pobhrAM8fjM7B5Skuz6Emzyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919791; c=relaxed/simple;
	bh=pzH9HqSMT5M9UesCTtzFnLTUTA76A1sP0BVGraKoTck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pglXbdh//RZDNK/jgbhRhVgB+C5LM4f3dNeAfHRP//DoAw7rqPkF7GO9sEbL+Wh5kwpw2ZXxORDfp/strfLn2CL3sBNcA1Bwc0yg9SgJ+zDwe1g4/20wTck/xoG7RQ2d9h8tLqqSf2EaVqwItRItlzTzui0c7zbUXQ9ihEuCfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=L3zFC5/4; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd72353d9fso1770622b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919789; x=1709524589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiaCZSKfIdq/o1MVm4/hTAeaIfrde7dAuZNqcPv3/F8=;
        b=L3zFC5/4GCbZBJb8/Fbgg5zaxSs0xAsTxUXBqTTXHWVBfatHKJlrVmE+a6eF+9kwEs
         ZxXWINBFfvXjZ+oeVTvl6mOvsFMVYCT3UBMG16gCmvZGq8d27ORROmy+S9gz82IUJh8y
         EHdp6p/tApYhUo2pB6CPQ/U47ScdlMB86rkUPNPMxobJAK3qYu7U0ZeuMc7JyaO8ZAW1
         E/2kEC5Mts9x2JB0SHp3otWQwBiQ01te8KC8rWnUw6MXOD4KWqX1EeYProvtvmktE4aZ
         g0O9LvwKzo2xic73P23QJdej7Yb0d+G5pTdKMxXUCqM3XLDAAlrKughhxgRUThT+ImRQ
         1b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919789; x=1709524589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiaCZSKfIdq/o1MVm4/hTAeaIfrde7dAuZNqcPv3/F8=;
        b=AAPPLPqhPFi5fvCcz5eBDx/kzqAs4VMTtcdjrSVR+noeCA7Tn8ceoeljAHaeEXxKnj
         F+yTDGB3+bIIZI8+nLIeb0Hk2KLdBfDAZghnKd06WvqfgXAw5cN41EKcqBkJuABxB7L8
         Rbx77r55KdOWD75L43p4dn2oyipz4y4Wnq0MpEVxavYmlFT0ESIsFqpMk3b6NBRZuieA
         6hO+Y054T4ywtAeiCEU4tFRwnUwiHQOlBXfwGwRaluE0QKNnLnc5fTloi7BBPhHSYf5E
         6QkwdFi5uO7Ftol0+T9LCSlt9f3Kxl4k0C6jDiUjYc2fNOA7yuUBoXwHGDd9qbOw+dZR
         0/zw==
X-Forwarded-Encrypted: i=1; AJvYcCVcsHLnRSxVreSpkmd/n/hyGwCSxh+l3jBhMViLsMFN77siGgHtBgu1rSuZlRAHBHtrBSowBrz+SCAYJ6k7kOuUXlJ0gNBboLJLXb4z
X-Gm-Message-State: AOJu0YygX+3bUIQgicdCunPT04p/jInAJAgu1CV48prcIdDtrqB8vDZi
	+VTi4ucYSJ+yhS9Lk+eZfvs2q0OuFq4BWzkIJbi8wjYiT+xWMkuvFKVJiSR8qHM=
X-Google-Smtp-Source: AGHT+IHQxkS7aeppkcf4X/ywnhL+VN+NAboDFTdm6tOjhLdgj9x+nwYmd6wwtg0N68HFMOEG5QS9vA==
X-Received: by 2002:a05:6808:14c6:b0:3c1:92e5:2a3 with SMTP id f6-20020a05680814c600b003c192e502a3mr7571893oiw.14.1708919789235;
        Sun, 25 Feb 2024 19:56:29 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:28 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 02/20] Staging: rtl8192e: Rename variable NumRecvDataInPeriod
Date: Sun, 25 Feb 2024 19:56:06 -0800
Message-Id: <20240226035624.370443-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035624.370443-1-tdavies@darkphysics.net>
References: <20240226035624.370443-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable NumRecvDataInPeriod to num_recv_data_in_period to fix checkpatch
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
index 705b94f0911e..f99cc5b639fe 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -925,7 +925,7 @@ static void _rtl92e_update_rxcounts(struct r8192_priv *priv, u32 *TotalRxBcnNum,
 	priv->rtllib->link_detect_info.RxBcnNum[slot_index] =
 			priv->rtllib->link_detect_info.num_recv_bcn_in_period;
 	priv->rtllib->link_detect_info.RxDataNum[slot_index] =
-			priv->rtllib->link_detect_info.NumRecvDataInPeriod;
+			priv->rtllib->link_detect_info.num_recv_data_in_period;
 	for (i = 0; i < priv->rtllib->link_detect_info.slot_num; i++) {
 		*TotalRxBcnNum += priv->rtllib->link_detect_info.RxBcnNum[i];
 		*TotalRxDataNum += priv->rtllib->link_detect_info.RxDataNum[i];
@@ -1045,7 +1045,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 			priv->check_roaming_cnt = 0;
 		}
 		ieee->link_detect_info.num_recv_bcn_in_period = 0;
-		ieee->link_detect_info.NumRecvDataInPeriod = 0;
+		ieee->link_detect_info.num_recv_data_in_period = 0;
 	}
 
 	spin_lock_irqsave(&priv->tx_lock, flags);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 95a8e9416f61..30b9178071ae 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1111,7 +1111,7 @@ enum scan_op_backup_opt {
 #define RT_MAX_LD_SLOT_NUM	10
 struct rt_link_detect {
 	u32				num_recv_bcn_in_period;
-	u32				NumRecvDataInPeriod;
+	u32				num_recv_data_in_period;
 
 	u32				RxBcnNum[RT_MAX_LD_SLOT_NUM];
 	u32				RxDataNum[RT_MAX_LD_SLOT_NUM];
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 29bdaff4cbab..526d5969399c 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1283,7 +1283,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	/* Filter WAPI DATA Frame */
 
 	/* Update statstics for AP roaming */
-	ieee->link_detect_info.NumRecvDataInPeriod++;
+	ieee->link_detect_info.num_recv_data_in_period++;
 	ieee->link_detect_info.num_rx_ok_in_period++;
 
 	/* Data frame - extract src/dst addresses */
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index f12ee685e989..83f337e27209 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1075,9 +1075,9 @@ static void rtllib_associate_complete_wq(void *data)
 				       ieee->current_network.beacon_interval /
 				       500);
 	if (ieee->link_detect_info.num_recv_bcn_in_period == 0 ||
-	    ieee->link_detect_info.NumRecvDataInPeriod == 0) {
+	    ieee->link_detect_info.num_recv_data_in_period == 0) {
 		ieee->link_detect_info.num_recv_bcn_in_period = 1;
-		ieee->link_detect_info.NumRecvDataInPeriod = 1;
+		ieee->link_detect_info.num_recv_data_in_period = 1;
 	}
 	psc->lps_idle_count = 0;
 	ieee->link_change(ieee->dev);
@@ -2071,7 +2071,7 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	ieee->link_detect_info.slot_index = 0;
 	ieee->link_detect_info.slot_num = 2;
 	ieee->link_detect_info.num_recv_bcn_in_period = 0;
-	ieee->link_detect_info.NumRecvDataInPeriod = 0;
+	ieee->link_detect_info.num_recv_data_in_period = 0;
 	ieee->link_detect_info.num_tx_ok_in_period = 0;
 	ieee->link_detect_info.num_rx_ok_in_period = 0;
 	ieee->link_detect_info.num_rx_unicast_ok_in_period = 0;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 4102c2d4f8dd..d6bc74ba9092 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -348,9 +348,9 @@ void rtllib_wx_sync_scan_wq(void *data)
 	rtllib_sta_ps_send_null_frame(ieee, 0);
 
 	if (ieee->link_detect_info.num_recv_bcn_in_period == 0 ||
-	    ieee->link_detect_info.NumRecvDataInPeriod == 0) {
+	    ieee->link_detect_info.num_recv_data_in_period == 0) {
 		ieee->link_detect_info.num_recv_bcn_in_period = 1;
-		ieee->link_detect_info.NumRecvDataInPeriod = 1;
+		ieee->link_detect_info.num_recv_data_in_period = 1;
 	}
 	rtllib_wake_all_queues(ieee);
 
-- 
2.39.2


