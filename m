Return-Path: <linux-kernel+bounces-25698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA3C82D4B6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE8E2819D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55D05233;
	Mon, 15 Jan 2024 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaF2eQyX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CFC4402
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so43193525e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 23:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705305271; x=1705910071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Pv0xl0I8bsyuZAQfNzc0WBFUelC4XXOsiHgb/E75n8=;
        b=AaF2eQyXtrLqkFLNF+K7d286Xh2deBsCtKFIKnJznqn9Z1yu63OdcuaIFn+LU1/Ti3
         tOM+wEhaSc1LXHZ5LV3cuzTNnq6ZyzYowLs9ahpr+rH7l/ouvzoHbxDJtLrXFEQZZizU
         34zzboyXoappNbXaycxo63P2+g5ANsC4MVlFVL9ajO/cAD1nc0U7gYBzMphc4b07IfX2
         rorte1E9F1seJSMZbY5XKOSzLDiSnE8JSNjptOdrNjACL2zkPKjQAiRzOpUcL0XMUWxH
         Uo2ldC1Xyu1nDRkZMfRsS5xx0SoOrk3BB33h3/gcLataLROFSJZzk9xspTJXmPAu9zKA
         wSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705305271; x=1705910071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Pv0xl0I8bsyuZAQfNzc0WBFUelC4XXOsiHgb/E75n8=;
        b=TpE/QXrtlUGkjqDbg5m6QtLJFLb76Wv+UPL2f4PCWwWESTKwjsXS6bdO5B/NZ5XWzf
         1764AmSwTuRGksb2vtgNIYR4lV1antlljuVtweNyv0udnd1wzBXcRH4F+tnnNmgj7gg+
         HuqkoBjQH51cVezW4CpBJw6uz/uzr/XoEAXwNRapfecCMMoQaNgbVrBIrFtmOtHGtAwQ
         a01MkV6GK/iqCn1yH56+0gPa43AWTaA1bx6YZyN+j0mpizIjdmwGZZmULpWHUKuWBfeK
         7yJXhNwCfFMX/wQd1KauybY2wA+ZSb4elUr3QPrevmFXN6SP1+NrR911RLD8ZZ6iafrW
         Qzdg==
X-Gm-Message-State: AOJu0YztqTvmZOqPoFQVT+qDSd3iQQp7FTzTZDz36jS25DRUQ3qlRBde
	IN+yU0yN2Km527NSGmOVqc8=
X-Google-Smtp-Source: AGHT+IEqOmYvE2dB5GpvQhT+CFHYwdWtEAh8jObKO0lz1NUgtLKS6c+9RYfDHC5TVJ6cFY5mQibqNw==
X-Received: by 2002:a05:600c:3b2a:b0:40e:621b:639b with SMTP id m42-20020a05600c3b2a00b0040e621b639bmr2680466wms.116.1705305270713;
        Sun, 14 Jan 2024 23:54:30 -0800 (PST)
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.32])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b0040e549c77a1sm18870472wmq.32.2024.01.14.23.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 23:54:30 -0800 (PST)
From: Meir Elisha <meir6264@gmail.com>
X-Google-Original-From: Meir Elisha <meir6264@Gmail.com>
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Mon, 15 Jan 2024 09:54:27 +0200
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@Gmail.com>
Subject: [PATCH] Staging: rtl8723bs: rtw_ieee80211: Remove extra space
Date: Mon, 15 Jan 2024 09:54:25 +0200
Message-Id: <20240115075425.108134-1-meir6264@Gmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 30e7457a9c31..cfa994835008 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1036,7 +1036,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 	struct HT_info_element *pht_info = NULL;
 	struct ieee80211_ht_cap *pht_cap = NULL;
 	unsigned int		len;
-	unsigned char 	*p;
+	unsigned char *p;
 	__le16 le_cap;
 
 	memcpy((u8 *)&le_cap, rtw_get_capability_from_ie(pnetwork->network.ies), 2);
-- 
2.34.1


