Return-Path: <linux-kernel+bounces-16799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D828A824400
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694D2B236FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674FC23767;
	Thu,  4 Jan 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WUz6nIe+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5CB2374C;
	Thu,  4 Jan 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C4341BF208;
	Thu,  4 Jan 2024 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704379284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vETB9SCIDuVDGSrkQ9WlcAEcxXERlPRayBqSURjaHwE=;
	b=WUz6nIe+LTvvnMRfN1dUYBhXPnaR1o206wRcdTUR5NRqcDiLrUiSMSqjSxX5UBZYEgB44c
	AxtlyM0tw+JXDInOgA/YPjixckOIMm1Si99EeYoj83fXEdQbwFE1NwLk3jr7Wm9n1c0iFw
	aYP/vDi5SAplm1PZtbOf8vBU87pnIZTSG6NgcLTJSvNRDJGHHR3ppH9nEQovuIGs4B8y+i
	JHZzSqf2YDgrNBhCo94+f87q86DmolX6mrsX2Du4l2erwT2uMK0Z6f8MnmCYzwdX55HLjG
	CU+ICUFAdGO29haBqaA+hNe3o/m935uMjxJNQ8k1Xkjb/0nHRbXpCivdFEQ9Lw==
From: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kalle Valo <kvalo@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] wifi: wilc1000: fix declarations ordering
Date: Thu,  4 Jan 2024 15:39:24 +0100
Message-ID: <20240104143925.194295-2-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240104143925.194295-1-alexis.lothore@bootlin.com>
References: <20240104143925.194295-1-alexis.lothore@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

From: Alexis Lothoré <alexis.lothore@bootlin.com>

Reorder parameters declaration in wilc_parse_join_bss_param to enforce
reverse christmas tree

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 839f142663e8..6f1218a51061 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -377,13 +377,13 @@ struct wilc_join_bss_param *
 wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 			  struct cfg80211_crypto_settings *crypto)
 {
-	struct wilc_join_bss_param *param;
-	struct ieee80211_p2p_noa_attr noa_attr;
-	u8 rates_len = 0;
+	const struct cfg80211_bss_ies *ies = rcu_dereference(bss->ies);
 	const u8 *tim_elm, *ssid_elm, *rates_ie, *supp_rates_ie;
 	const u8 *ht_ie, *wpa_ie, *wmm_ie, *rsn_ie;
+	struct ieee80211_p2p_noa_attr noa_attr;
+	struct wilc_join_bss_param *param;
+	u8 rates_len = 0;
 	int ret;
-	const struct cfg80211_bss_ies *ies = rcu_dereference(bss->ies);
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
 	if (!param)
-- 
2.42.1


