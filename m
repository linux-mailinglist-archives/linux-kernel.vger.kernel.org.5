Return-Path: <linux-kernel+bounces-37769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493FC83B4E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95F3DB25C62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2502F1386A2;
	Wed, 24 Jan 2024 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="ROKoc41Z"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F7D13664F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136302; cv=none; b=qzB3VNC1dkp2PEyD7HK0V5SpPDC8IqcB/dMJWs5c7UTne3zUWsWlIbEWqGeXotjkB/cVRKpwBhlEb/DdiohkhX/B1qzpEWDPf9ujQLbjSHDoIv5zju6qmfT2KZgF3TiLVFgU4aNnqAAME38dWO778qP/A23jVGp1Ur7/6MAATBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136302; c=relaxed/simple;
	bh=J/YJ1L2U7MOhyvgl74ECxlPzLA74B580IQn9Bn3ngTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDC6+qYkCj6XL5nEVfpOFDv9acp85SZvqKaVF1EnV/B1UkeGAZqoK7VByWmAGAmh3yi8SHHXIBjtfQHedxeQKlna4gQROwyOAPMmEtRoyYV/EZmRqygx9KubHJWaK/7tPfttkGJ0N8a0o3B7Hhu7eSiYe1mKdgp+rPOG/7WT3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=ROKoc41Z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d71cb97937so38780935ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136299; x=1706741099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n891Aa14yCHagKfV0zzWF+pMBWwCfZl9aAjaNjmbXMs=;
        b=ROKoc41Z/sV9R8kinmtgQEky+aF3Ux0/B9MU2I4TaOJ9xKcUoQ2FFX9UFndu4FOvgX
         3HslavBXnqGl+Z/E2zacQ7rzqXayClUPLkb2/74d0fPSTLO/DvED/o6NdTA5Nviepy/z
         ErSIk2BNn+rzkyPQ6Oj4X8zmmjPREX3u+tJkCNvDkHyAPdWapBfH/qXrNJ6FBb7GDFoR
         TBxeffGpk1o+b/xFE+I5bmR4b5Je2qEovrBlb2Jrb3vsu6STszOIpEU4PR/xXUEEU08I
         3mVHP6Y9eCeFraz8ytvof60jiX6o5/2VzMtnwBSdkrDzHmaYHld9GDbMpk7/zc1t7nhg
         6vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136299; x=1706741099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n891Aa14yCHagKfV0zzWF+pMBWwCfZl9aAjaNjmbXMs=;
        b=D0nlrLEf2gL+2ieVovTwJqlOgKD3Ih88OB8PwayAQRLBksbCCCZfCm2Zou129TWhIK
         E3vw2dRDcN5cfJUoyMFNwSkrGFaOjTnxXBjnCeS19Kp55K1GljhA0e3+CQt61SITvy2E
         J+fd+hb8J/JeSuLPy6v6sTq2OAJEReRnHMalLWhZ27sKnRicSTfSXV29kONmSIQ6TDCg
         KG9276Y81kqCR30s7iy9VFL3hpHl+WGyg/626SXKP0A3HU3SAlZXSvRrQbmXTqQ/2EdT
         CTxIxp6PmJxJ6JFOfU/KNg+U0JzsDfhQzD2uGVhHVlrTXYhvlUejPHMLWdytiSJ14jUy
         KVTA==
X-Gm-Message-State: AOJu0YxMGnanR+O3Kh/fh6SE1zlY1vhZGPDDcQD0+JZTPFDrH8Oxvd7c
	DYJjZIR5Lm4NyB8H8tH8/0pLzu+8cQek3KSPF0qYw4K5/JmVc3YhiwwV3N5+A3V5xeAGmEKy2/w
	p
X-Google-Smtp-Source: AGHT+IHoy77vjPyfWBism+TfdISx1bBbLBC7s1uych+VJs8/75LV7TSdwA7Cw+CKtr0FqAU5jUy1NQ==
X-Received: by 2002:a17:902:d4d0:b0:1d7:8816:a816 with SMTP id o16-20020a170902d4d000b001d78816a816mr94166plg.3.1706136299513;
        Wed, 24 Jan 2024 14:44:59 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:44:59 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 04/18] Staging: rtl8192e: Rename variable LPSDelayCnt
Date: Wed, 24 Jan 2024 14:44:38 -0800
Message-Id: <20240124224452.968724-5-tdavies@darkphysics.net>
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

Rename variable LPSDelayCnt to lps_delay_cnt to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
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


