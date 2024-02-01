Return-Path: <linux-kernel+bounces-47767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4281284528A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F027728469A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAAE15959F;
	Thu,  1 Feb 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5rMzeja"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F4C43AC0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775526; cv=none; b=kqT0mgF05FWK+6don2oZEbD3fuseLy0dts3QcgRP6aWNNUinLCFEksXFtgShHa4IapsmTZjU59rzSCZoPYcxs9nRJQaamcN3tfIkLtiBUrTdfvKQDWD7hjy6njI7OL0zZQSD1yVWBR0SpUJP42gj3uuNozIH2rcQlVlIZJE5r4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775526; c=relaxed/simple;
	bh=lYzIATM6Ne/sGhUcvtQWKGAMfEC3nM6zrkVczqOJRKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlsY2r/RXPgvwNGdc5rnwqbcBuYH0dW97fqrgV8ggBMe8beJouIjV3yL6PzR/fIvaHYGkoIgFYl3p/IPJ3IgPh2LkXrDPx3SZBd3j01oHv+ToIVIuYANTy3qknqa3YfAyoauSwxM8EfN8/pRo8gkqRZhYUcVfkpdTBtezorG4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5rMzeja; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso794245a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706775522; x=1707380322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFI5dVucRdVTbeql8T1bAFgclvq+0WY1kjSsHUwH7Zs=;
        b=N5rMzejadI61a7vlP5/lMZW8+B7QnNgSWChglo5o++4QUEcV4gk4bShRd3kmZioP5b
         TGnYtPdUT50tV7WApDy7fX6gfa/ni9AZz4JzTn0qUVg8C9l/HJgBAMUSF4FKuEFOwtT3
         7qt5Bll8NSI9edmqdZSgJTp8r6FYUZRrMODiAOw59QEjgXZ7HU5kHPrK+R+1IMDeupWB
         2YArcWBkgjdE1KTvq2BXVLObpPDCKvDZRnVZFbC+kOAuJyaG6543VZcwSztfLBZ/H4YC
         VFIlletAVc2jNWUO+4XIEGs4NP9en/qL7SHORxW3dw02JRN+0a7xzdD0SKjIPvoLE7nv
         Qnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706775522; x=1707380322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFI5dVucRdVTbeql8T1bAFgclvq+0WY1kjSsHUwH7Zs=;
        b=Ap85dgSKNYMyw7KqnYU3Nf+GgsBjlo+Vm9mCIzvE1ZPu58UqqJAaI0/+Z4OHstRusy
         PPf9m7egyUCbdLGTQCJWzgxc0/NLrPk29LdjG22xKzUKba4o3C9TQChJsDP7pCDw5Nr2
         PpGI03FKjQkkn3zEUN7kzu/FoZ6YyJeB9bgz6v7UVzjHiPjyG4RfYv8bo9etEtDW9N2F
         4rANR9c7a+vWUHfYst7kYvAcr90TRoX2iexUMp3x4jt0dqIlTOeWSSXt1CKVJVICEjla
         HAHGjlAS3x11YvUgXaM6N+Ij+2CraMaIgjNfzHo5rKfLTWi0eEtW/52JUz4wMHurk/V1
         6XLw==
X-Gm-Message-State: AOJu0Yyd0mtnAPtPsMhy5U3uN38x9eZKglx7Ty86eZCHTpxruL1OuTI1
	RIyvE77ReKFKegSfot9X0Id67RtQQGvaP0nqIHqs4zvEE7zumRoZ
X-Google-Smtp-Source: AGHT+IFh2lINn1gSQY5SoLQ2pmbnCzXZ+DQTv1t9qPwNqnouKCPs1Gunues1LSWrEZZfFfvy4B7M5Q==
X-Received: by 2002:a17:906:5587:b0:a35:360f:ae69 with SMTP id y7-20020a170906558700b00a35360fae69mr2653121ejp.54.1706775522106;
        Thu, 01 Feb 2024 00:18:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/jyzmzFIxtk+8BSXnVPj2yPP6KtBpQhiZjvXEU/fOdRgbY6luRO/+S3YRVR4fUkldVjT8mOlOlTs/sn1Sghy6eOGphNbwQDyEf8gD5RjtgemRZraX17HJXnmtToT0Zo+GagV3vzM1whHn+Ke3Mp2qgxHex2Q8wUV8aWAvvt6TpjWbBUs=
Received: from localhost.localdomain (ip-77-25-34-59.web.vodafone.de. [77.25.34.59])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906784700b00a310f2b4b91sm6954069ejm.48.2024.02.01.00.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:18:41 -0800 (PST)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8192e: remove braces from single statement blocks
Date: Thu,  1 Feb 2024 09:18:22 +0100
Message-ID: <20240201081824.6998-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201081824.6998-1-straube.linux@gmail.com>
References: <20240201081824.6998-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove braces from single statement blocks to clear some checkpatch
warnings.

WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 5 ++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 3 +--
 drivers/staging/rtl8192e/rtl819x_HTProc.c      | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 9b9d95ba06df..080fe9c4585e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -693,11 +693,10 @@ void rtl92e_link_change(struct net_device *dev)
 		u32 reg;
 
 		reg = rtl92e_readl(dev, RCR);
-		if (priv->rtllib->link_state == MAC80211_LINKED) {
+		if (priv->rtllib->link_state == MAC80211_LINKED)
 			priv->receive_config = reg |= RCR_CBSSID;
-		} else {
+		else
 			priv->receive_config = reg &= ~RCR_CBSSID;
-		}
 
 		rtl92e_writel(dev, RCR, reg);
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 32acba4ce3f7..9b528cf4dbca 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -964,9 +964,8 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		     MAC80211_NOLINK) &&
 		     (ieee->rf_power_state == rf_on) && !ieee->is_set_key &&
 		     (!ieee->proto_stoppping) && !ieee->wx_set_enc) {
-			if (ieee->pwr_save_ctrl.ReturnPoint == IPS_CALLBACK_NONE) {
+			if (ieee->pwr_save_ctrl.ReturnPoint == IPS_CALLBACK_NONE)
 				rtl92e_ips_enter(dev);
-			}
 		}
 	}
 	if ((ieee->link_state == MAC80211_LINKED) && (ieee->iw_mode == IW_MODE_INFRA)) {
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 6d0912f90198..49b882c363bf 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -480,9 +480,9 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	}
 
 	ht_info->current_mpdu_density = pPeerHTCap->MPDUDensity;
-	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
+	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K)
 		ht_info->current_ampdu_enable = false;
-	}
+
 	ht_info->cur_rx_reorder_enable = 1;
 
 	if (pPeerHTCap->MCS[0] == 0)
-- 
2.43.0


