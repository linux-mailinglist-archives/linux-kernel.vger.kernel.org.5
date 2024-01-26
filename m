Return-Path: <linux-kernel+bounces-40763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DAB83E577
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9405B1F24DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D11450A74;
	Fri, 26 Jan 2024 22:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="e3/+SJVg"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28013B1A9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308302; cv=none; b=fYROMWk4xpB1PhrhLHxZv5R0U8HVSYlNo6cZ179JEBM+b6oR9VVBHHlv1z9horgkE8SfMGIkmrYFFu8m7W9dzdWwaKh6rHHepYQfCAAwbeV+gpEYMlBXdSWxk6AhgZEm9dj69iqfLIF8vKyscIl6h35l5G5RpWIbISEaIL+SIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308302; c=relaxed/simple;
	bh=F30tm/e3g8v+2w4H9XqzdHYCd4VIxN5NuiWrZe5HNFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hT+hZV/lmKJO8DSR2ov5b2ynFIyqLefm5w3Jf0IqS1eHdqenNbe4pIgGNzGRtvkJYaZzF8IZheyetqwVv/qdSQ+wqbcUJk+6S98+wGuis66pA4w5qkUcpQZWPyGFm+mzA6O3Ellv7jTefklDf5x/3PDUtimcoikydGXnxjz+FrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=e3/+SJVg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7393de183so6278175ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308300; x=1706913100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmD7njZV+9GeCGUWgd9hXwhxj2qbFui5fbBAr2B6Sn0=;
        b=e3/+SJVgILOsN6bjSgVWjInC2ENon17d0aASRNHE5XP2P8/jHdKU65VkjfFzoVwEFg
         h/88hut/8miV0MYcfBFQlSmRq3nFY5r0eeuUK5JipZirh2xn8Krzl8SfmQeYyip7FhFY
         aQoJc4ZA6m7++fuSDa7rwMPACTkHdpETynJRphUQD+oJoFWEw8tCARkJ2YFl1AdUvn8a
         gBePwWZjYEHquKqwwxHd5EfTScoHKPDDyIdFYj2Pcd1HC49IPSaQxBKObkU1ocp0/Nhr
         d0gpAnWM1QIKmlp54AZwAfxSonjmfQY0gfH1svfMlRWOTN5yGE9Mevh+1XPIme4hk8lv
         o2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308300; x=1706913100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmD7njZV+9GeCGUWgd9hXwhxj2qbFui5fbBAr2B6Sn0=;
        b=vP7N/aanTiKbtjBZ3cAJvAPO2Q6EXRzeRafYed4OdlTEP5jyg9qszWDamd7kAB8LgU
         82U741XXB6qV/6EJrp9BO0xU6NTAJH4AUCyV+3RRuII1oH8HApOT6NI2Af98P3YGumn1
         bSiVQXyxXsFpQ/qyUb/6PbCaMBOn+AAqow/yKhp9eDLBEsMFKFEqv7u66tyhB+IpQSiY
         S2zBbSO/fv+mVasWafXozTMEHzS0WJyusn2FvjIqD3X49Trp0JvlA5sB/kWANTGxkoH/
         R+KQXeoAYFlHTEqQtq0Eti8Wz6pLKZE1EdgEBWHyoOcYObNjPuDbdgjYwjXO0YX8OJ6c
         b81g==
X-Gm-Message-State: AOJu0YzPHN7HdVk3IgBIj4SHg+I6yuc5JSh1Fvws8xaPb1ADM/p7HCY/
	rZMrLD2Sy3T86h8aF3I2WUynMv1tYWdilcek4cTkhbHLxNTe75bHu7h8kxjYHQI=
X-Google-Smtp-Source: AGHT+IGTnNV9dHo4NBiNkbq1PjrzoehYksQ+F5SIYChl3o0QydO1XSBR/FR8v8az3FEiAO2Pu3FloA==
X-Received: by 2002:a17:902:7485:b0:1d7:4cda:bea1 with SMTP id h5-20020a170902748500b001d74cdabea1mr459256pll.73.1706308300375;
        Fri, 26 Jan 2024 14:31:40 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:39 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 04/18] Staging: rtl8192e: Rename variable LPSDelayCnt
Date: Fri, 26 Jan 2024 14:30:52 -0800
Message-Id: <20240126223106.986093-5-tdavies@darkphysics.net>
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

Rename variable LPSDelayCnt to lps_delay_cnt to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No changes.
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 4 ++--
 drivers/staging/rtl8192e/rtllib_tx.c         | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 76aacd27e157..f986dbb215e4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -705,7 +705,7 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->hw_rf_off_action = 0;
 	priv->set_rf_pwr_state_in_progress = false;
 	priv->rtllib->pwr_save_ctrl.bLeisurePs = true;
-	priv->rtllib->LPSDelayCnt = 0;
+	priv->rtllib->lps_delay_cnt = 0;
 	priv->rtllib->sta_sleep = LPS_IS_WAKE;
 	priv->rtllib->rf_power_state = rf_on;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 94f370b40378..0a366874a827 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1375,7 +1375,7 @@ struct rtllib_device {
 	/* for PS mode */
 	unsigned long last_rx_ps_time;
 	bool			awake_pkt_sent;
-	u8			LPSDelayCnt;
+	u8			lps_delay_cnt;
 
 	/* used if IEEE_SOFTMAC_SINGLE_QUEUE is set */
 	struct sk_buff *mgmt_queue_ring[MGMT_QUEUE_NUM];
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 8a60bf3b7079..b5cd030f28c8 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1351,8 +1351,8 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 	u8 dtim;
 	struct rt_pwr_save_ctrl *psc = &ieee->pwr_save_ctrl;
 
-	if (ieee->LPSDelayCnt) {
-		ieee->LPSDelayCnt--;
+	if (ieee->lps_delay_cnt) {
+		ieee->lps_delay_cnt--;
 		return 0;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index b82f3415085b..e61eb6e87ab4 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -595,14 +595,14 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				   ((((u8 *)udp)[1] == 67) &&
 				   (((u8 *)udp)[3] == 68))) {
 					bdhcp = true;
-					ieee->LPSDelayCnt = 200;
+					ieee->lps_delay_cnt = 200;
 				}
 			}
 		} else if (ether_type == ETH_P_ARP) {
 			netdev_info(ieee->dev,
 				    "=================>DHCP Protocol start tx ARP pkt!!\n");
 			bdhcp = true;
-			ieee->LPSDelayCnt =
+			ieee->lps_delay_cnt =
 				 ieee->current_network.tim.tim_count;
 		}
 	}
-- 
2.39.2


