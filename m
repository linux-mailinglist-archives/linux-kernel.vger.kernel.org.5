Return-Path: <linux-kernel+bounces-82701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E26786885B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5961C219EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9105810C;
	Tue, 27 Feb 2024 04:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="FVeiR97e"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AC56B68
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008944; cv=none; b=oc25TRQDo67P1Yj7mkUtZwHWGCWzqhXTht1KghgW7giZHhzvYcr0rybEzotaB7yjoOaPuvFt4faCsgaGCAB+4Xt0QcHqBGOzgValcbQzsaklBn2ippQSjZ2uxk+L8fMBWgVL8dtxW8vKJArXJCh/WD3yu++gN1+XQLQ6sIcpIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008944; c=relaxed/simple;
	bh=bNKFW16BidmmMvctJ8NyRmFBNLMdol6sf4IGgmQJVQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GVdceawo7VN9sONRmjOqOltdNgTBg+DCadFm2q0LgF1OwLrdVOXlCl28E7yRDlh28p4IDKUu9zBjMdwMgdf8wJNeMmVeniMF4JoP2HR2qeO8F719oE1eaxZR9LyU6kGDgUp+mIW26q2x2hj/y1uEaecs7IbJ7bmbWz4CtR4gqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=FVeiR97e; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e4f3cbb518so1153776b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008942; x=1709613742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqBZMfc9TcWxWN2N6/CKR72slOlM+2jmQfdd8IyQ3bE=;
        b=FVeiR97eQa3bQVJCgEcIcoxtWB9AmNsvlZTlhMzxq//igB/Ax4aqytCQIfXfDxzztP
         vp8560T/9c4oMcTVOGogTagim4+FwDhMDqp/lZvguqacc60us5HlQ0r7RlKVYopAy+TZ
         o0HzKiBYHf+AtyqxaWxA0J73chFCouUlMkMYdVuHL86fBRtZPT3l7f7TpGAG0mw1+pSh
         87WY8V1ko57B1fuIhgPybiMbpp9Sj7Mr9Qw6UHRaR81xLWdV6+YWzWids8bvhw4rmeSF
         9B3kJ0IsiCjgOS/MX14DnlXmJ+tl/e/FFZRe9b2ULh0bXqnp0j9i8rihaZ+UPNvfN6PT
         FG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008942; x=1709613742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqBZMfc9TcWxWN2N6/CKR72slOlM+2jmQfdd8IyQ3bE=;
        b=DUEwIcvxNzOvOsZABuH60TfAP+CLdGJXyH6igb5GtWi0FRFccbjVfv6Mg6PaUbUw7b
         7817b2HaaghmAikyqjVbdxIZBRpQ2/QOrContcnnUTqvszpTbk3wY+ESE+M+P44eBvOL
         JOX6tbTtwwJP+Hlfmg48FMpbmQm97XEZ/sM8W7G7NMofdZqJ1xshNDS0Nn3wlsBD2igB
         A3SHgFd8PXX3zDMuf00MBnaPVBVayKwF8tCLYFTKlMYO17DkyjZXvPFm2aK3+LdF6dAO
         kgmqLMvAqoUfglq5Q7y/g3gRelhBu2yg0/B8W2NKEqWmTUqkyFdfzwwr9mfUF96G7bwR
         Bl+w==
X-Forwarded-Encrypted: i=1; AJvYcCWNLKwVAbhYMkC/tvxZt5eyV0Zlj5+ZZ1drlESw8wELm57tiLrVVsGm+1OdhnIz5SisBvSpNZaZOBEKwPAF9mpHBOy269TdnOnlOu5Y
X-Gm-Message-State: AOJu0Yx6U0wHvoI26CRVu8lxx0CdFJ0egqjFUePnFsqllJjL8FZ42sFV
	PD/5rFkhEgVATbxExxad+eZKUMKxgutvThgqDv5WrDh6BIVNhPKRkA4L41W2wIk=
X-Google-Smtp-Source: AGHT+IHPCfzBYlJq3/M3PZeubuEqm6AM4bbV4VXYgcRmyWF20MODxPVC8i20oXf1F+ZCrvFpJtHMhQ==
X-Received: by 2002:a05:6a00:1a86:b0:6e4:6ca5:30b7 with SMTP id e6-20020a056a001a8600b006e46ca530b7mr9827765pfv.34.1709008942466;
        Mon, 26 Feb 2024 20:42:22 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:22 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 19/20] Staging: rtl8192e: Rename boolean variable bHalfWirelessN24GMode
Date: Mon, 26 Feb 2024 20:41:56 -0800
Message-Id: <20240227044157.407379-20-tdavies@darkphysics.net>
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

Rename boolean variable bHalfWirelessN24GMode to half_wireless_n24g_mode
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 59110da6c4f3..cc7764707e61 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1937,5 +1937,5 @@ bool rtl92e_is_halfn_supported_by_ap(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rtllib_device *ieee = priv->rtllib;
 
-	return ieee->bHalfWirelessN24GMode;
+	return ieee->half_wireless_n24g_mode;
 }
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d2f192fa9304..8e2f27b98f30 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1264,7 +1264,7 @@ struct rtllib_device {
 	int ieee802_1x; /* is IEEE 802.1X used */
 
 	/* WPA data */
-	bool bHalfWirelessN24GMode;
+	bool half_wireless_n24g_mode;
 	int wpa_enabled;
 	int drop_unencrypted;
 	int tkip_countermeasures;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index c335b24fa08b..afa789fd1266 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1684,9 +1684,9 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 		if ((ieee->current_network.mode == WIRELESS_MODE_N_24G) &&
 		    half_support_nmode) {
 			netdev_info(ieee->dev, "======>enter half N mode\n");
-			ieee->bHalfWirelessN24GMode = true;
+			ieee->half_wireless_n24g_mode = true;
 		} else {
-			ieee->bHalfWirelessN24GMode = false;
+			ieee->half_wireless_n24g_mode = false;
 		}
 		rtllib_associate_step2(ieee);
 	} else {
-- 
2.39.2


