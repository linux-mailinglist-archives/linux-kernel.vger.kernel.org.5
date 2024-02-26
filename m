Return-Path: <linux-kernel+bounces-80492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE428668EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97DDBB21D84
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148AC1CD3D;
	Mon, 26 Feb 2024 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="a+DdXT2W"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171B1C683
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919799; cv=none; b=C7T8F0vTLdFmeePhnB5hqK9tzN+i6+cYWgG5oVJ5Xnpb9CO0kYp9XqFMqeCxpUPk9UXJ/c6gU0d9yeXrsyYGWpHxvhkmS+mS4gNh+lG1LiZQuuCnrmqzdTG+4CTMz8D9REew0uje6ImMLLVkWQ4pJ7XZu+iCmIua3WvtYjwso4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919799; c=relaxed/simple;
	bh=bNQ2/O7wu3o5m7MuFlv5iXoOaAO8O9TXTwCbCAsXYcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b+FlMt6W+EBGX5LLPKy6MF+JD0k00pSrf86OoU0u9jwc8FekWLKm/dnPf3O/fEjD1wV+HvMes5gpWDYUDbZMeWh6JJcukZ/AUZlaoCNuM7aelfhFfR+K/ViEC3GJ0+XL0QmPe+ntn7McyAFPHYLqnRYX3BSsEVZdMm2nTFIY6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=a+DdXT2W; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e4751b97eeso966311b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919797; x=1709524597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0fnUWxVUdF2Q1hOsPrTA/0ABOihwQKn7K2EOHcfQqU=;
        b=a+DdXT2WoT963cSoswsn/Nd1O4kYN2gbj1JREfTBL2BVfNOW81alTtwmADdEzNtgoN
         zCG0E7+c1M9qVNSNK2qT4YjN5OozU3UsAd/widf4LiS6SWedZ/meEPN5uXjrOQnsuttF
         //XaLqWxBMvyqPtp8TUUwLJTvQTNUH1it9fawkuAPjAOsqqXoJwzg9nDYHJuKuYOmimt
         fdORrBzal/lmONq4SZuF4WHq++9llmzcNXWfMNoGGzx/z6+6WVBB4MwLyVz53W/70+lJ
         8vy3bXeTP1MIQwAGHcAYaRES5ICA3FdCKFx1k04GyFtv+6RGQ0aa0dvarY4eM7b61KHB
         cgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919797; x=1709524597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0fnUWxVUdF2Q1hOsPrTA/0ABOihwQKn7K2EOHcfQqU=;
        b=bRHmPJGbz4+jsR0tXKcJwlF0+qe87IcKSuBbk64/D89H8yzgWs6UypFkYdA9LwL8YT
         vF8N44jYkM6T4smaCFHjBR29DAtlD3IrRLhmHecV2qfaBcI7TsRmRMj/elOSR/XNMqOF
         TSD21sUN9soRekYf9A7ykyNukI6J5ZtIIGuszlbaMVM7AgZznD4D+w/vx9owKNsGsnBJ
         Wtfm8NvVewknn3/JXY8y8loYj2rFnBgBFdZn6NXqi5xDFuFNPJ8vKUklX5cDm5/Yqv2q
         hbOXufR0P5gNtRA16oWUg9psBoLmhRhAS45ESw0NZ3hcLh+zPv4YBXDb5udgyQxhp8tu
         zXDw==
X-Forwarded-Encrypted: i=1; AJvYcCV2oXxvrwFsm19VDA2bzMS8tbSX/pr/5CPNyuwudGubnANmjJ9eHqK7RC4EFUFyJhVdy0DZX9I7HIk4rl/rFMyajN1PkRt32YuKfIlZ
X-Gm-Message-State: AOJu0Ywi3pMIk5n42GYTOwGn342Vbh15UpPICeumq5tFsNHT5JbXkjq9
	JYKksJqMQrAPFxdIaTtT7kYxF/XIdCbVJ0/kPYFHtNKFWY6h8es9abk2UFbjOfM32MxrrbATdna
	E
X-Google-Smtp-Source: AGHT+IE+ZPAgfk0lZ8NbfNibvEsPivHrnZVzj/le7UwC6qGZwD8ws7O+l4l8Lnh1P3zzwfWqiZwU0Q==
X-Received: by 2002:a05:6a20:9f4b:b0:1a0:ce21:7888 with SMTP id ml11-20020a056a209f4b00b001a0ce217888mr5114480pzb.16.1708919797051;
        Sun, 25 Feb 2024 19:56:37 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:36 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 10/20] Staging: rtl8192e: Rename variable BssCcxVerNumber
Date: Sun, 25 Feb 2024 19:56:14 -0800
Message-Id: <20240226035624.370443-11-tdavies@darkphysics.net>
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

Rename variable BssCcxVerNumber to bss_ccx_ver_number to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 6 +++---
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 9ec4a3b8ae3c..c703e6d95fb9 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -935,7 +935,7 @@ struct rtllib_network {
 	u8	MBssidMask;
 	u8	MBssid[ETH_ALEN];
 	bool	bWithCcxVerNum;
-	u8	BssCcxVerNumber;
+	u8	bss_ccx_ver_number;
 	/* These are network statistics */
 	struct rtllib_rx_stats stats;
 	u16 capability;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 103117692a88..051371e0138c 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1843,10 +1843,10 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 	    info_element->data[3] == 0x03) {
 		if (info_element->len == 5) {
 			network->bWithCcxVerNum = true;
-			network->BssCcxVerNumber = info_element->data[4];
+			network->bss_ccx_ver_number = info_element->data[4];
 		} else {
 			network->bWithCcxVerNum = false;
-			network->BssCcxVerNumber = 0;
+			network->bss_ccx_ver_number = 0;
 		}
 	}
 	if (info_element->len > 4  &&
@@ -2356,7 +2356,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->bMBssidValid = src->bMBssidValid;
 	memcpy(dst->MBssid, src->MBssid, 6);
 	dst->bWithCcxVerNum = src->bWithCcxVerNum;
-	dst->BssCcxVerNumber = src->BssCcxVerNumber;
+	dst->bss_ccx_ver_number = src->bss_ccx_ver_number;
 }
 
 static int IsPassiveChannel(struct rtllib_device *rtllib, u8 channel)
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 71583bcd8334..61d4518dcd7b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -744,7 +744,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		ckip_ie_len = 30 + 2;
 	if (beacon->ccx_rm_enable)
 		ccxrm_ie_len = 6 + 2;
-	if (beacon->BssCcxVerNumber >= 2)
+	if (beacon->bss_ccx_ver_number >= 2)
 		cxvernum_ie_len = 5 + 2;
 
 	pmk_cache_idx = sec_is_in_pmkid_list(ieee, ieee->current_network.bssid);
@@ -851,11 +851,11 @@ rtllib_association_req(struct rtllib_network *beacon,
 		tag += os_ccx_rm_cap.Length;
 	}
 
-	if (beacon->BssCcxVerNumber >= 2) {
+	if (beacon->bss_ccx_ver_number >= 2) {
 		u8 CcxVerNumBuf[] = {0x00, 0x40, 0x96, 0x03, 0x00};
 		struct octet_string osCcxVerNum;
 
-		CcxVerNumBuf[4] = beacon->BssCcxVerNumber;
+		CcxVerNumBuf[4] = beacon->bss_ccx_ver_number;
 		osCcxVerNum.octet = CcxVerNumBuf;
 		osCcxVerNum.Length = sizeof(CcxVerNumBuf);
 		tag = skb_put(skb, cxvernum_ie_len);
-- 
2.39.2


