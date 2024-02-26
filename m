Return-Path: <linux-kernel+bounces-80487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8E78668E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9A31F21BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4381BF47;
	Mon, 26 Feb 2024 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="S1TSjmTZ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D41B813
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919794; cv=none; b=j2R505N+ik4k+hq0yafPt7dW6cWCpa6Jzom2JfJpHtBLG7PHRvUCo1Gp8NVgJ7cuOrupr5u9XH4AZRnGJX7pZvyPjCnnZGhLXgrSODxNbfej4vuBZffXzjCNAt6Q/9+F6+DK/iKdiNGhRmh8U+vL4fRWxXw9bNqa4+yjjrQiYPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919794; c=relaxed/simple;
	bh=CLi8IS8xGuGU9xH7A8Wvoe3szP7KMICcCgkeF8YxUvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K6WVGg6qheJUs6uhWlLb4zhX/gJAY5BER8p60W+MUHFxoNCvWVTAQtp97bs9teyalxgjnu2meTasixMCc2M54E358sA8/l/CZPd1TDQKYBot6vE0zO6NJ5xQDDmY67geR3ellOEZw1t8iOctHX+iqVxXyLpDbIiw38oqVoluxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=S1TSjmTZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc49b00bdbso21804385ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919792; x=1709524592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2Lxf+xJWEEwOIryXh19zDkpZp/Hag7/7AWBHeT10qs=;
        b=S1TSjmTZwKk6vURHHDzmYBP+VhERc0lQ5vSNtXaT+ONbqEeNs/kM/6OnJRcNP2yFG0
         T64lyj8yzPBPtSW6ycy1NX8y286NC3xlKHJWYNHp7PXSdOIUWl3InjRQIOoSJUd5ppLj
         I3sldM8cyMaUnl1Cy3z2Rx7OU11T6dhYRsVunvKwmgtc5PxT6gg3QCwH/bI1QSQQx85t
         +tyWrG9ll0qDIMdQTKQHQwQCrP3hg4n15RQA0KGUHAVUHtGWWiU4isy5e2Wo7enZ6kKg
         /kPbIwhZLTxiovaWpo0d5SOQTRtvEVSVCOzrBDUF9sfVW+yT3PJpkyTfRCuOxzPXBZTw
         fqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919792; x=1709524592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2Lxf+xJWEEwOIryXh19zDkpZp/Hag7/7AWBHeT10qs=;
        b=E+HgX23vNuwpXbp/49EjnWwYfIArH6KQRcYe8lUPUgeTAjuPrgOM3K3bouEshoPXXj
         kglFODzqw9SXo4L+t1b8PcS8cpynd9SsWNYgYLknJbfwCUD9KEefl7CC+X/CDOW1dHnQ
         yiQZqbEH6y43IC2Fk0/1ZXVVV1CsYL151LDLuqJzZG+DAAOv1q39GDy3G6OJ0U1ig6DF
         vvwa+J4kzxe1NjvU/I9zkkg1aS5wr+zQIPsru+AA7v1aGfpmlzoFrbCS2fGDHee8xp8v
         Rv94hn8BRJ5Fe5tA+uw766TwuBmL/rpB6VMCGVQ0L6bV5xjtukCIx5QrwLJeRSriK4Kh
         kYEg==
X-Forwarded-Encrypted: i=1; AJvYcCUBM1tPBwDxD8bQrjaNnucMsSHYRyw1SjoNFJR1aNMaulJZxYEMvArc9tF5kOQmEs7mD2UawInZz5g58oOz2cXen/uNqdhihwmfvLI5
X-Gm-Message-State: AOJu0Yw4BOT3Cayxz47idDliAiQIWSkyHShC7TfI+KkqA8rfLBDnRk8M
	ax52EdsP9ffGdKsW4oJu9TeNw4uZmdmDzex57t2z6nR0XB88bFycrv7WVOoewEg=
X-Google-Smtp-Source: AGHT+IFLW2hfMswZSY+cOqHvt5BixJnuYMocBOHiUoOmW0ZmgJUm5s1Q/dCgqpOczCMHjSOQHb/Tuw==
X-Received: by 2002:a17:902:6e10:b0:1db:def5:17f8 with SMTP id u16-20020a1709026e1000b001dbdef517f8mr4465771plk.9.1708919792166;
        Sun, 25 Feb 2024 19:56:32 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:31 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 05/20] Staging: rtl8192e: Rename variable Turbo_Enable
Date: Sun, 25 Feb 2024 19:56:09 -0800
Message-Id: <20240226035624.370443-6-tdavies@darkphysics.net>
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

Rename variable Turbo_Enable to turbo_enable to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 6 +++---
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index a00db0d153da..ea08ac058421 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -965,7 +965,7 @@ struct rtllib_network {
 
 	u8 wmm_info;
 	struct rtllib_wmm_ac_param wmm_param[4];
-	u8 Turbo_Enable;
+	u8 turbo_enable;
 	u16 CountryIeLen;
 	u8 CountryIeBuf[MAX_IE_LEN];
 	struct bss_ht bssht;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 526d5969399c..63e3b655e4ee 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1688,7 +1688,7 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 	    info_element->data[2] == 0x4c &&
 	    info_element->data[3] == 0x01 &&
 	    info_element->data[4] == 0x02)
-		network->Turbo_Enable = 1;
+		network->turbo_enable = 1;
 
 	if (*tmp_htcap_len == 0) {
 		if (info_element->len >= 4 &&
@@ -2183,7 +2183,7 @@ static inline int rtllib_network_init(
 	network->realtek_cap_exit = false;
 	network->marvell_cap_exist = false;
 	network->airgo_cap_exist = false;
-	network->Turbo_Enable = 0;
+	network->turbo_enable = 0;
 	network->SignalStrength = stats->SignalStrength;
 	network->RSSI = stats->SignalStrength;
 	network->CountryIeLen = 0;
@@ -2343,7 +2343,7 @@ static inline void update_network(struct rtllib_device *ieee,
 
 	dst->SignalStrength = src->SignalStrength;
 	dst->RSSI = src->RSSI;
-	dst->Turbo_Enable = src->Turbo_Enable;
+	dst->turbo_enable = src->turbo_enable;
 
 	dst->CountryIeLen = src->CountryIeLen;
 	memcpy(dst->CountryIeBuf, src->CountryIeBuf, src->CountryIeLen);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 239ed95982ac..9255eed85141 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -707,7 +707,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 				2 : 0);
 
 	unsigned int wmm_info_len = beacon->qos_data.supported ? 9 : 0;
-	unsigned int turbo_info_len = beacon->Turbo_Enable ? 9 : 0;
+	unsigned int turbo_info_len = beacon->turbo_enable ? 9 : 0;
 
 	int len = 0;
 
-- 
2.39.2


