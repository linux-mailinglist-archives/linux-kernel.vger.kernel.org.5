Return-Path: <linux-kernel+bounces-80501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D7C8668F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4F6B22A50
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9FB2C869;
	Mon, 26 Feb 2024 03:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="RLzrjzHI"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E20521A0B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919806; cv=none; b=WAmu4BlryCopblpS/GUs0Vu6HCbWk0xoRcaSegZ+SJyQfCExzptrRs2BLo8M+4mfsc0kUjP/fPhbwlZdkWI0KnSzZ0S1w5M9labUyCvwudZafXYIIHDPELkqBuYZUdi+CZZCprWdTnv2KRYE6Yc62b9z3PZV2jTE8f5XMLofbUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919806; c=relaxed/simple;
	bh=+bfyLssgh9QfNNLZN3qPFtAp9PFPZMfPbg+HNh2vzHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AhfTINUys4eejTfblRZvnW2OioHrdq4VWkLf5bOy31ImYKsTAt97wHOPVyZBPrFZEXEC0A12KtGuBiTmavXemAhFWE+7yDdiKzx53edYA6pRcJPEtX3DTfD0RpfJcPfErK8c9NemqSPAc2iO+mMCySzAYolIGxuGQSxPyDTLbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=RLzrjzHI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7232dcb3eso18031555ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919804; x=1709524604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkdpdseH4pwO/YOLWCepBZaFQOdyRtvEOXrnxx5LS6o=;
        b=RLzrjzHI5i3IZqjBLqSYiRJ8dqQb6gLiSnKQnJyYW3Mb/srfyXOBJFJcpA0OnN07rr
         U2z59yAZle/PRRYkl7mvVv3tKf9ftCHZGzj0p2dhx06aFKVF4uKrKFB4j+MAMGok4VlH
         t/mvmhSsThUfvQWAEx7NEOhibpjdLEvFSUEhSo/2w8wsf9tx/H8W79TS7ToPW1hqEVFx
         iXxOanBrFliJEhaaPvfmAnZZQ8D7QDav6h8bfcWo55CnQxB9lOYNw8MPZwfu7hjOdKHi
         DoI5ci4rbc5705g22j+xmDN36G6q0h1ak5EmQWEZf0IjlRbhqarvaqZnRymrxnuMygs3
         QGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919804; x=1709524604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkdpdseH4pwO/YOLWCepBZaFQOdyRtvEOXrnxx5LS6o=;
        b=L984vr7M8rU6BqNlGBdE10qWVBIgOBDlKMoGST+QxO7njUUl2Q78B/LFIidXZmTY1n
         ppaP72VmE9ObdYZERrWCrASFPj11I78MICSXho5BbWeiTTEihBoAIqujj4CIJN9uLXSA
         5f4+weBmMVbHAPjv66Fo16SZBKAsiE/CBzfhCwUB+ZNyBB/GU8RhlJbVWtoS0wkKNfQf
         7Oofoe6wMtSXc/DbkqdiHD2qAn0PQ09/gswNOhczgpBB/xl3+5GKld2HWxxO4GaxTKGm
         E5I5rIolFv54Jz9PVspST6c9yV4jiXlionxFhtKuETuCa+shUPrmCIUVCx91rqt/M20A
         mxfg==
X-Forwarded-Encrypted: i=1; AJvYcCVcFVE7ONubD6EiMKIRePGC2nLRRt/dr0zdY5Yrx+fTsJM5rVWn9qbTYRwtMDLOwMCJzIf2uaL3V2ypeLBh+ezORdq0w0vKTwbABg04
X-Gm-Message-State: AOJu0Yxj1bCaiAGCpi9k3I0Z4yFff8jx4ziHa3iNf2+EggJimDjdbYy4
	i3UtJoM05uzAsd43DeDDi6apHyODhtRM/BLsW+4VJECXXT4+mETS8ks0JzMuMgo=
X-Google-Smtp-Source: AGHT+IEv9idbaaVYCs7tgHpClaiYjJNxPXY5PTCLFn/aVX6S4iK4WrRGGTIS1z6mGpwnlINElDWn+w==
X-Received: by 2002:a17:903:2cd:b0:1db:b09c:6d0 with SMTP id s13-20020a17090302cd00b001dbb09c06d0mr6487932plk.64.1708919804656;
        Sun, 25 Feb 2024 19:56:44 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:44 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 19/20] Staging: rtl8192e: Rename boolean variable bHalfWirelessN24GMode
Date: Sun, 25 Feb 2024 19:56:23 -0800
Message-Id: <20240226035624.370443-20-tdavies@darkphysics.net>
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

Rename boolean variable bHalfWirelessN24GMode to half_wireless_n24g_mode
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
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
index 7ad8bab23224..aa915d09bd63 100644
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
index b32c190f0113..933672ac8546 100644
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


