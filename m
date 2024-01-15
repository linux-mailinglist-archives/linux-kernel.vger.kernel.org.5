Return-Path: <linux-kernel+bounces-25737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B8482D51F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508961C21366
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B0D323C;
	Mon, 15 Jan 2024 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlNlgewH"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBCCEC5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso14166505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705307689; x=1705912489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zsLZp5AjgU2ikojusqifaSf7hD6PKOOj66CfoLC/Lys=;
        b=JlNlgewHBMNABfPMXhM72s2ehuT4otVUTLG3gt8o+St8eOQHB9MTTmXc69eXJb1+2y
         QI0W+PFz9YkRCavNdyQr6mvCMjshh9HjOwjdFRpeDEfKIeZCcUeVcwzfQmH9Uw7okGBK
         9699Qtaj98Q0TmwG1w+2awsJXaL4l64Bxoyfi2o0C2KJq8TeV/UAcVsotgKtIBnf/L87
         4dGFE4OxTQfnV8y32W6CZo1BUKasrV1/v379a0cXRnjt17nJdJWJ18AMpHceyohScqK1
         fDPSNDiQ288q146idO8Seypc2JcwcMniQhPiHWLW5LpPmVBadyP0XNEdHCWHKahbz/Zk
         TniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705307689; x=1705912489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsLZp5AjgU2ikojusqifaSf7hD6PKOOj66CfoLC/Lys=;
        b=Cpa1P1r2lzyZYjPa/cNXadO6BJ3MSIJ2MP9lCm8qzb4R+f5ZamCXjKxfPvYhRv8Xr1
         ttDZbn23dzDjaJceo+RaftEDi53McVfftXD+Z9293pNXCmhRScqlbCfgOydfE6rRfccx
         CwDWc5M3XctE3+M9WYlejG+NtEyeY36UbYugSNukOU0m5rxf92uycZtcKthw4oN76wuO
         jC2eXRpAKZSdFQ6GAZWWpsygjkM8nhDjbhbHQmJLxcTwpf2vgK1OgIxOGi5tPY7MiHZP
         u8AP/eIVbM948Rtjm4JtbPNQExLH5Plkr2e0QvveWNDJUZl8BVqQpwz67XPC/EeC2evo
         Aqjw==
X-Gm-Message-State: AOJu0YxlwYEPiCNX9VZRyyAOhyYXqE8yFBZU++dXaTrtKllACbCPJg0G
	ACnpgzc8fbZ9Ty6DLuJ5CGg=
X-Google-Smtp-Source: AGHT+IE4tfUXqymNsgq59LGKZ5TuuZttpDPsYe30flbY31bsQuShVGOXM7XhNIcSthIy8RBdZdt+lQ==
X-Received: by 2002:a05:600c:2101:b0:40e:3796:8cdc with SMTP id u1-20020a05600c210100b0040e37968cdcmr1563040wml.135.1705307689276;
        Mon, 15 Jan 2024 00:34:49 -0800 (PST)
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.32])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d65d0000000b003365951cef9sm11164596wrw.55.2024.01.15.00.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 00:34:48 -0800 (PST)
From: Meir Elisha <meir6264@gmail.com>
X-Google-Original-From: Meir Elisha <meir6264@Gmail.com>
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Mon, 15 Jan 2024 10:34:46 +0200
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@Gmail.com>
Subject: [PATCH v2] Staging: rtl8723bs: rtw_ieee80211: Remove extra space
Date: Mon, 15 Jan 2024 10:34:38 +0200
Message-Id: <20240115083438.108901-1-meir6264@Gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch warning: please, no space before tabs

Signed-off-by: Meir Elisha <meir6264@Gmail.com>
---
Changes in v2:
- remove additional extra space in rtw_get_bcn_info()
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 30e7457a9c31..b89e88d6a82d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1035,8 +1035,8 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 	u16 wpa_len = 0, rsn_len = 0;
 	struct HT_info_element *pht_info = NULL;
 	struct ieee80211_ht_cap *pht_cap = NULL;
-	unsigned int		len;
-	unsigned char 	*p;
+	unsigned int len;
+	unsigned char *p;
 	__le16 le_cap;
 
 	memcpy((u8 *)&le_cap, rtw_get_capability_from_ie(pnetwork->network.ies), 2);
-- 
2.34.1


