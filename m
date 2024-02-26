Return-Path: <linux-kernel+bounces-80519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB908866917
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF19E1C209F9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436AE4EB3F;
	Mon, 26 Feb 2024 03:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="EqvS1p03"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE75D4D107
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919969; cv=none; b=T5D9hkL0sgMki9gTbs7kKNuwCJe8cZ4jdrdjjph69NWQ5BRnWYNTz3nRpioXJiviCXSqtT05O1S/BnR/nRJq/FNgJc+sxHDzAWEBTRbHJFT+iTfGFNNVpghpZn379xoUdTVuo0XXWndGDXgnH9UNR5UhKpc97P5e2JoPQnO4a0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919969; c=relaxed/simple;
	bh=Hb2gzq4riFTqoohaJYo7tJV4g6poU6GnyQ7xdS4Myh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Usd2pWu+uOl6s7DIGq41JCWvG6ylZiO6nOq4z8aGDGf+8M2IejHam1GSqG8z6HrH5p6ePFybTCr6X0z1w5RBd3dcX+pG3BaUwyyyfXrWA5J+lcsb8DwOgsDk/4EssqLtES292Plssr8GEKn7G3RWlwXiPJTQRcuYikgoj+ZIgp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=EqvS1p03; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7881b1843so20428725ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919967; x=1709524767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V637UI8jqLYaoLt6Jphn/pSof6w0WRdDGgG+CHcmXrE=;
        b=EqvS1p031+4jtFJeWIl66QeqDR11YRjGxTThKXEOen5d7Ur1D/YVTbvPmR8RcdJk1S
         1+wGvhutNhqwLPYoyKO0wF+d6l7j4/QqbAGkei9kdkGfuS2nLKqb/0ONvE8wsEeJmtMI
         9pdEhrcKRXcUgsv4RIXbX8r1O2IUsU9CrjEqL8tZlMylnA6ajk/5wW6yBhjFyNB1wR1p
         o0r1ZuIfj/iNcfF7f5O4y7Uim0LlcCTPL2QDDemW70catnip3AaUzLuX4I/naTmJ24jF
         eQFPZsuW98T8rZ1/sZgmhEfOU/dhjt5uZ3enIm1GxJhWhaVPRm2BO4P51JF4j0jii7/0
         Edpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919967; x=1709524767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V637UI8jqLYaoLt6Jphn/pSof6w0WRdDGgG+CHcmXrE=;
        b=qvEWqWug3FZFwVkjuSQ+qlm1jj2BSdMaQWTsQ7W8wrwq1TBQqz4Bu54GdCJ2uYXNf7
         yu5qGv5ZfPgUUsXE5r0Ts+pRaUHbgcLLwtxQZ/vzzx/XlC518uGq+TW4qOlB9kmq7lal
         M/OISeKyS6KbODNRGmtucNGV2c91T5wBh/nXAk71wr4+cp2TBk7zfK8hPLOC31qhx4KU
         GFVn9+6RqxT+/SeEXVY/eb7IzrlkNEsyrvrfdzBb/4JEsmj3hbqU+vMidaSTxWBUOmGh
         xoyA8K3slRofHoEOu51QooP5TIFRo8l7O7xQPncjzb84uJC3fREECVT0Ii4rLVWwRlYI
         sQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCWEwaaa6iz35QgeaseNqkCm5gvUjDALj9lCB57vFgmzy7FKonwwJ1e5bc5tPsn9TP217h3xvoI57ITPiTbJHElnK2aDkzuh1+2XESDq
X-Gm-Message-State: AOJu0YxdwJnOEFexF4zYZClRPxROt6+0TqYsmLZwzntEBsI0x0zbbctA
	WqGWXjnVoxLtBIexcfIC+tlwf2mYxUDedaUhaigbWF3qPpnpCAKVZjmY5spxObg=
X-Google-Smtp-Source: AGHT+IENvooUMubg98bMfNVI0RvxJTLd2gooTD4DC84K+k6OwjgQott9+o1MVAglbzqDfP6OG4+szA==
X-Received: by 2002:a17:902:b60d:b0:1db:c71a:5693 with SMTP id b13-20020a170902b60d00b001dbc71a5693mr6408992pls.26.1708919967275;
        Sun, 25 Feb 2024 19:59:27 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id iy13-20020a170903130d00b001da105d6a83sm2893426plb.224.2024.02.25.19.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:59:26 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 8/8] Staging: rtl8192e: Rename function GetHalfNmodeSupportByAPsHandler()
Date: Sun, 25 Feb 2024 19:59:15 -0800
Message-Id: <20240226035915.370478-9-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035915.370478-1-tdavies@darkphysics.net>
References: <20240226035915.370478-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function GetHalfNmodeSupportByAPsHandler to
get_half_nmode_support_by_aps_handler to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   | 2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c    | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index fc5014f719d7..50a4e1cb8c79 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -657,7 +657,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->ps_is_queue_empty = _rtl92e_is_tx_queue_empty;
 
 	priv->rtllib->get_nmode_support_by_sec_cfg = rtl92e_get_nmode_support_by_sec;
-	priv->rtllib->GetHalfNmodeSupportByAPsHandler =
+	priv->rtllib->get_half_nmode_support_by_aps_handler =
 						rtl92e_is_halfn_supported_by_ap;
 
 	priv->rtllib->set_hw_reg_handler = rtl92e_set_reg;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 57e1a361a7c9..047da39f730e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -354,7 +354,7 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 			}
 		}
 
-		if (priv->rtllib->GetHalfNmodeSupportByAPsHandler(dev))
+		if (priv->rtllib->get_half_nmode_support_by_aps_handler(dev))
 			target_ratr &=  0xf00fffff;
 
 		current_ratr = rtl92e_readl(dev, RATR0);
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 04f3fb54d1b7..834329886ea2 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -276,7 +276,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 	ba->ba_timeout_value = *ba_timeout_value;
 	ba->ba_start_seq_ctrl = *ba_start_seq_ctrl;
 
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev) ||
+	if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev) ||
 	    (ieee->ht_info->iot_action & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
 		ba->ba_param_set.field.buffer_size = 1;
 	else
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index abc21ae49ff7..fa96a2c2c916 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -252,7 +252,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	}
 
 	cap_ele->AdvCoding		= 0;
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
+	if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev))
 		cap_ele->ChlWidth = 0;
 	else
 		cap_ele->ChlWidth = 1;
@@ -301,7 +301,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 		if (ht->iot_action & HT_IOT_ACT_DISABLE_RX_40MHZ_SHORT_GI)
 			cap_ele->ShortGI40Mhz		= 0;
 
-		if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
+		if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev)) {
 			cap_ele->ChlWidth = 0;
 			cap_ele->MCS[1] = 0;
 		}
@@ -408,7 +408,7 @@ static u8 ht_filter_mcs_rate(struct rtllib_device *ieee, u8 *pSupportMCS,
 
 	ht_pick_mcs_rate(ieee, pOperateMCS);
 
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
+	if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev))
 		pOperateMCS[1] = 0;
 
 	for (i = 2; i <= 15; i++)
@@ -666,7 +666,7 @@ void ht_set_connect_bw_mode(struct rtllib_device *ieee,
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
+	if (ieee->get_half_nmode_support_by_aps_handler(ieee->dev))
 		bandwidth = HT_CHANNEL_WIDTH_20;
 
 	if (ht_info->sw_bw_in_progress) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index fe850dbeaa02..38ae9d1b24c1 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1486,7 +1486,7 @@ struct rtllib_device {
 				    enum ht_extchnl_offset Offset);
 	bool (*get_nmode_support_by_sec_cfg)(struct net_device *dev);
 	void (*set_wireless_mode)(struct net_device *dev, u8 wireless_mode);
-	bool (*GetHalfNmodeSupportByAPsHandler)(struct net_device *dev);
+	bool (*get_half_nmode_support_by_aps_handler)(struct net_device *dev);
 	u8   (*rtllib_ap_sec_type)(struct rtllib_device *ieee);
 	void (*init_gain_handler)(struct net_device *dev, u8 Operation);
 	void (*ScanOperationBackupHandler)(struct net_device *dev,
-- 
2.39.2


