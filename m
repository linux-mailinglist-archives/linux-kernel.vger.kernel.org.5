Return-Path: <linux-kernel+bounces-82694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CE286884F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B0B2870F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F9755E78;
	Tue, 27 Feb 2024 04:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="QaF5WZs6"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6855C04
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008937; cv=none; b=c8tGykFBi+Hm0Wt/YZUxGez20ive9U0TOAL4a7aNY2P73zDWb3HDT8PmJHvg1E6pBBTwBT/GMFtJcaGxu2cr4h61INMm6rn4W7HtXGvINz5uSQfyVa5fZ5phFaYhiGDfVOBiD37Hk9C8opQjT4+sxmyMIlYGXHgQXO375HiDyeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008937; c=relaxed/simple;
	bh=KUKleCPj1er4YVGXkt4fS3U/pWPcJ/I422oLZM4HBKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aa4xkAz8xGjnGfQOfRYW5NlXqNc4tf1a//yN8pR1Lgkz8TfYz1jk/7MIk9Fu8hdaAGV9k1/WkznIKtBxoxk8Yp132JcBpJ/RmovZ4yfRe6hxUb2k2cCnFF9fnyx7yM3zr3w7wGDDuM1pYM5AcX9TVBIRslhMy02l7fyi30bloo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=QaF5WZs6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e48eef8be5so2611431b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008935; x=1709613735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/je3PWYehjAFuNbE3yomOBNAD8lj1+LglWASVMRpN/8=;
        b=QaF5WZs6uaBeB6RKRWRIAyNcMEuNQGrdJlV5VP2K0Tt53m9CjsNwAczRvQAMFRYE3F
         h0BC0A8ePFYBXSmMpVvWmvp6zYrI0yzA8Wp4XkLSASq4lBdXJ8Ve3gbo+xXX3FO5ktOx
         5fZR6xzeW1X2/gK/DannRZHjMBEdhKVFZMnh6nSwUxFWz7St4dDtGXs0v+Y0KpVXzDzA
         Twa5qfDW0ynut5tylQaiz0XwAHbBgwV7/k5NF574iOV/Gz9o6M4PmfrbcMYVNnY5hM4p
         8+mdd4MMSbrwRARB8B5TLFoz0TdxolWNBo16o5EIjc4XDjwj9AGKH0Os/bvoj81VY0Hw
         8pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008935; x=1709613735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/je3PWYehjAFuNbE3yomOBNAD8lj1+LglWASVMRpN/8=;
        b=rofSuBTeD8bNs1aJN4kLDjXr61Ucdefs7113GB2nJBadoj8y2M8zWb8RC0MbnvwKUB
         l0XjMkzAob9IGALMWruOPf6+vqbls4+2aflUi/pDSwc7+epT7ZszIi8SJpSM0pG3oR9U
         uzeED49ijQGHcHO5uavEm+W47wFO/mb7PLc6+UDeom7/NIn0Z2w73Wi6j5rJ7M59Z6Kb
         I8vUjDU8rSpXOVxYljas+MVBDP+B0DDF9KuVET/z1RJVhxXz5yNwZXNIEgberBB/hAPi
         hJJIYzb6Med5ZpFl/TaoXRYLbrHw0LmmipobYgsskTP/9VoyX4N7UCACSzvNx20Wczqf
         4XjA==
X-Forwarded-Encrypted: i=1; AJvYcCUGvZbm6zxbD1qo1qQSa2cWxm+Y57aZEWoTXTTq3GycCsKq7xd4D1XdxV75mMQC0Xdd7E/gCuA4p+/7bGa0neHg505KA+sASSWnspTW
X-Gm-Message-State: AOJu0Ywt81TdFOASVokjEjUzRvkMIjtupO9+6GL6aLTAu+qpBgDes85y
	oSeVUJ5Yh5yA+r7D3GWdTi4feqY1+1o5IyLTG2i0RCyrnvjWAcS2ZrFN4J2hfJqMRcMCRdebkcG
	n
X-Google-Smtp-Source: AGHT+IEY8QuGbS9lh/pVcpOIk+41HvwQoIdLn1F9gpEBvw1TfSiz0S6Xq4abC+shplu203kUn2pNHw==
X-Received: by 2002:a05:6a00:8c7:b0:6e4:eee0:57ad with SMTP id s7-20020a056a0008c700b006e4eee057admr10822153pfu.20.1709008935056;
        Mon, 26 Feb 2024 20:42:15 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:14 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 12/20] Staging: rtl8192e: Rename variable asRsn
Date: Mon, 26 Feb 2024 20:41:49 -0800
Message-Id: <20240227044157.407379-13-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227044157.407379-1-tdavies@darkphysics.net>
References: <20240227044157.407379-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable asRsn to rsn to fix checkpatch warning
Avoid CamelCase, and adjust spacing to avoid alignment check.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtllib.h         |  4 ++--
 drivers/staging/rtl8192e/rtllib_softmac.c | 24 +++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c703e6d95fb9..a5925fe75a6a 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1662,7 +1662,7 @@ int rtllib_rx_frame_softmac(struct rtllib_device *ieee, struct sk_buff *skb,
 void rtllib_softmac_new_net(struct rtllib_device *ieee,
 			    struct rtllib_network *net);
 
-void send_disassociation(struct rtllib_device *ieee, bool deauth, u16 asRsn);
+void send_disassociation(struct rtllib_device *ieee, bool deauth, u16 rsn);
 void rtllib_softmac_xmit(struct rtllib_txb *txb, struct rtllib_device *ieee);
 
 int rtllib_softmac_init(struct rtllib_device *ieee);
@@ -1805,7 +1805,7 @@ static inline const char *escape_essid(const char *essid, u8 essid_len)
 }
 
 /* fun with the built-in rtllib stack... */
-bool rtllib_mgnt_disconnect(struct rtllib_device *rtllib, u8 asRsn);
+bool rtllib_mgnt_disconnect(struct rtllib_device *rtllib, u8 rsn);
 
 /* For the function is more related to hardware setting, it's better to use the
  * ieee handler to refer to it.
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 3e26375a5622..880ce2bfd0eb 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2144,7 +2144,7 @@ void rtllib_softmac_free(struct rtllib_device *ieee)
 
 static inline struct sk_buff *
 rtllib_disauth_skb(struct rtllib_network *beacon,
-		   struct rtllib_device *ieee, u16 asRsn)
+		   struct rtllib_device *ieee, u16 rsn)
 {
 	struct sk_buff *skb;
 	struct rtllib_disauth *disauth;
@@ -2164,13 +2164,13 @@ rtllib_disauth_skb(struct rtllib_network *beacon,
 	ether_addr_copy(disauth->header.addr2, ieee->dev->dev_addr);
 	ether_addr_copy(disauth->header.addr3, beacon->bssid);
 
-	disauth->reason = cpu_to_le16(asRsn);
+	disauth->reason = cpu_to_le16(rsn);
 	return skb;
 }
 
 static inline struct sk_buff *
 rtllib_disassociate_skb(struct rtllib_network *beacon,
-			struct rtllib_device *ieee, u16 asRsn)
+			struct rtllib_device *ieee, u16 rsn)
 {
 	struct sk_buff *skb;
 	struct rtllib_disassoc *disass;
@@ -2191,19 +2191,19 @@ rtllib_disassociate_skb(struct rtllib_network *beacon,
 	ether_addr_copy(disass->header.addr2, ieee->dev->dev_addr);
 	ether_addr_copy(disass->header.addr3, beacon->bssid);
 
-	disass->reason = cpu_to_le16(asRsn);
+	disass->reason = cpu_to_le16(rsn);
 	return skb;
 }
 
-void send_disassociation(struct rtllib_device *ieee, bool deauth, u16 asRsn)
+void send_disassociation(struct rtllib_device *ieee, bool deauth, u16 rsn)
 {
 	struct rtllib_network *beacon = &ieee->current_network;
 	struct sk_buff *skb;
 
 	if (deauth)
-		skb = rtllib_disauth_skb(beacon, ieee, asRsn);
+		skb = rtllib_disauth_skb(beacon, ieee, rsn);
 	else
-		skb = rtllib_disassociate_skb(beacon, ieee, asRsn);
+		skb = rtllib_disassociate_skb(beacon, ieee, rsn);
 
 	if (skb)
 		softmac_mgmt_xmit(skb, ieee);
@@ -2238,7 +2238,7 @@ u8 rtllib_ap_sec_type(struct rtllib_device *ieee)
 }
 
 static void rtllib_mlme_disassociate_request(struct rtllib_device *rtllib,
-					   u8 *asSta, u8 asRsn)
+					     u8 *asSta, u8 rsn)
 {
 	u8 i;
 	u8	op_mode;
@@ -2261,7 +2261,7 @@ static void rtllib_mlme_disassociate_request(struct rtllib_device *rtllib,
 	}
 }
 
-static void rtllib_mgnt_disconnect_ap(struct rtllib_device *rtllib, u8 asRsn)
+static void rtllib_mgnt_disconnect_ap(struct rtllib_device *rtllib, u8 rsn)
 {
 	bool filter_out_nonassociated_bssid = false;
 
@@ -2269,19 +2269,19 @@ static void rtllib_mgnt_disconnect_ap(struct rtllib_device *rtllib, u8 asRsn)
 	rtllib->set_hw_reg_handler(rtllib->dev, HW_VAR_CECHK_BSSID,
 				(u8 *)(&filter_out_nonassociated_bssid));
 	rtllib_mlme_disassociate_request(rtllib, rtllib->current_network.bssid,
-				       asRsn);
+					 rsn);
 
 	rtllib->link_state = MAC80211_NOLINK;
 }
 
-bool rtllib_mgnt_disconnect(struct rtllib_device *rtllib, u8 asRsn)
+bool rtllib_mgnt_disconnect(struct rtllib_device *rtllib, u8 rsn)
 {
 	if (rtllib->ps != RTLLIB_PS_DISABLED)
 		rtllib->sta_wake_up(rtllib->dev);
 
 	if (rtllib->link_state == MAC80211_LINKED) {
 		if (rtllib->iw_mode == IW_MODE_INFRA)
-			rtllib_mgnt_disconnect_ap(rtllib, asRsn);
+			rtllib_mgnt_disconnect_ap(rtllib, rsn);
 	}
 
 	return true;
-- 
2.39.2


