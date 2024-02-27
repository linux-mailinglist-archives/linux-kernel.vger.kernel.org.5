Return-Path: <linux-kernel+bounces-82687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118DE868848
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7063D285A29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBA453E1B;
	Tue, 27 Feb 2024 04:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="I2L4Rd89"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9035338A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008929; cv=none; b=kSrN1TMB0SzpXWgYBkHirybP9LZnepH+LadjMb7tGIK4BVFIK5kuhE6RRXXG37aM0O/QSU5j1+lJMPsGwBU19A1pj2/vvISzRAEW64UMh7KGyx6MZhEYaKZeYo3BO1CByCwMg2wQnbSVkKKPkXuklIUU/s6JMH9FhJoU7AVECmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008929; c=relaxed/simple;
	bh=S1HpBS0V8SbrWzHD9lIz3Pm1wGEtJ0x8Om/JmBQtkBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMFEkvexM16QHfXzZKkmd6+7ikqNr/uGKkNrVX22hd7B/FfsREo/8MgGm4W4mvq9fHGXCNYQpzv3toaZKYZd9JdR7iahjxP3bMWky8v9s7qxuv9mPkvJ45VjpgPowLl73NOgx4FYnflI7rUbYGz8zpleiLxf4QYvme9AcoUGiyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=I2L4Rd89; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e54b22229cso77001b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008927; x=1709613727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+q+AbEi3C3CZLXbva3ppHujTGDxM/LEcu1siopQo8Y=;
        b=I2L4Rd89wLPNwWpepNDn9Hd0L+q8z6QH8KaHUiwUOaJTZFeoEAXjh6n1V077L/Ahx1
         JsqRjzwghf2TqxylgwAaBSTCYocD5Jyj0M5BnRyTpz95i3bwcxCEQRmJlsxbFgZqJ/Ol
         wSp9E0jGKIGEQLbK1byNiH+zngYAUGr6w+97yJ8pfUPQdEEDT8/ts/kRyCDntCjpQ6QB
         x98RRic6rtCt75eAk5CZ9nI9thXpXoVKrVtGlrlqCg2n+K2ik8l8LHiSmOYrtjTsQu7g
         s/TEO6j0nv3LLeTy2UUKCDIwnj1hkg2y61LE2hosElDkhUV2aQ+FCO7OFVYRxlQCVh1V
         YvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008927; x=1709613727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+q+AbEi3C3CZLXbva3ppHujTGDxM/LEcu1siopQo8Y=;
        b=VePGD/7g/mYQ6B4NwJ92V0G9eYIJzpoAhugKVWbFJMkAEWnOVQCZZQkBDx/Wvm3uMf
         xkbXZUOUV31J2lFYxvDubwR89dm5TVNOLcqr2IsXl9Kr7lDdf770YTvvQ9M+gVzo23kj
         Por/Wm7fqjOezBwANiVELZv/F7IajdsMlFJ1SGqOo7HiKG78OXI2h2QPPAA2ld8dNo8h
         W1HFeKRqtGAutDf6cxN7U2aI7OYfmYgOXIBo1UPiMKaOaSJ7xsOe5Su8EuLtVn0JfH9E
         Jdj1ywRelebZdzlfgQvDuzhbi/sr1V4l946m/lEHFDkeuQbp5ekj9cFtivuMGOXj6tX8
         IR+g==
X-Forwarded-Encrypted: i=1; AJvYcCUAJHhxTUYL6ObWnKIeTCcfSO+JN38ndo9I5G20YImuztXKOCJstBybVcWXbNtf+Jd0/d+fu3/O5hU3qwvW71QLB1H8P9vW18WecpSn
X-Gm-Message-State: AOJu0YxzBx2VSSvV/pkBaqE+9SwFi9A6YoskTTwl7S5mZQbQLwDHBoRX
	L3XipCTMcVP0V06MUGu4GqH52sZpjm7/L7LJIsvnPF5XoZzZaXptSon2IpodF1g=
X-Google-Smtp-Source: AGHT+IEhzMvsHaSkGVqDnE+kjMjN1dvC3pYHwld+X5qjt5uDh6zjNPp0q7dKC2974RgAOMqyIaz/mQ==
X-Received: by 2002:a05:6a00:9287:b0:6e5:2e25:3495 with SMTP id jw7-20020a056a00928700b006e52e253495mr5565787pfb.32.1709008927129;
        Mon, 26 Feb 2024 20:42:07 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:06 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 05/20] Staging: rtl8192e: Rename variable Turbo_Enable
Date: Mon, 26 Feb 2024 20:41:42 -0800
Message-Id: <20240227044157.407379-6-tdavies@darkphysics.net>
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

Rename variable Turbo_Enable to turbo_enable to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
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
index a847b6505c42..b189ba220e22 100644
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


