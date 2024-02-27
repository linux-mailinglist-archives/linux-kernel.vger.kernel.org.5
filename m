Return-Path: <linux-kernel+bounces-82689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CDD86884A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306571F2287E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DFE54BCA;
	Tue, 27 Feb 2024 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="NYZeFU3U"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D45B5465B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008931; cv=none; b=p3oQ6LcUeGwGJrG9f/83yPqisPKyJwIYCeznVs4BaaYpAgpUhDJCqWW+oZAt3AmCZObTaqT8Kud0Zsmif2sZNTYKqfavLqV9g1oXN+5q9Np5zpQYf3/5Fop8m3Z/Z65eiU5MFeHbhIQbTvOj06awk68KOEbTWVoRVqc9DiPMM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008931; c=relaxed/simple;
	bh=zqAU5uebjy/mNq/kk4zX8lZQPe0Q31dgLBJ17Bty4Gk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=solsMtE+N16AD5IUpuGQVMENmaCv8gLA3AiYifJxCY+BDHmn4qRq2YsaFsU8X+cVXGUKR/Q09d4gKXgSPKF9tcbYpCxzFDd7v7Wo1rea+iqfIo7Gbcrcz4yTQJe632z2GtIG12gcqHEKd3rgAEDvfmOQAUMlhoDT4FB+p0VuSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=NYZeFU3U; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c19b79535aso1850775b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008929; x=1709613729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=494w9MJdhPcRyE1Ep+x0N4ZDZPcir/0cIQ/GDMguAAI=;
        b=NYZeFU3UkP0yASsKeaYOiwoz3QBOEJ6X+UyxIseKd7Zmp9S0GRNS1pyU0yh6C6staW
         sjcVVMIrHhoFuZoHA0afEOcVy7x9Esr5FIa/tSE1ZioUdUloY8b4B653ajxjhAe9EM6L
         bxk1yHl1gcm0cYiWnfVdbpwOWyOuQtXr2IIYSCl47CsasQ81+wh/g8/7nHKrsQNlqzrB
         TRE7ylbDNvgupX2dNCD4xTM+8O/AHUg+AStVRmzouewEkt4l8m1D6WbwRA/ArxSVhdAL
         1szLXz5DmXCSpAu0jOIyal+nef79yTVpLE1lUB8q6OvqH6SE6TEEk5+3YMg635YrSk+M
         CQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008929; x=1709613729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=494w9MJdhPcRyE1Ep+x0N4ZDZPcir/0cIQ/GDMguAAI=;
        b=LhEcLm7M0/LXC6p2iEHkQoV//Iq2gluZYLD/BR9N+TgLqqm9wW1BgMdjoRhmxcsQ4z
         MMKZDZgRG6ItqkbGXJcl5aD93ha3G7Y5ZCmqs7S1vD34zkCakjL0s/8LIJYKxncgoRDG
         0xT7LcA5KB3MNAruYsc/1D++KkRKEOPz1V3ulR6s3dehpaBx2jR+qG82rncKDJjVkrjX
         FVLQ5MBFZ6rJdrFO/k4KAFzVz4GKWWFN8aC1jDLSOf82jVz+2gXK9aEotbmimAu5WvA0
         GmsbBUNZrREZZ9036YM6noetLfWrv3Egbce0QYs4QBFtJiQnEA7Q3/fC4pilotXL8cAh
         2ijA==
X-Forwarded-Encrypted: i=1; AJvYcCW5lIvHIUprd7imhgyXH/yaZ6VFnVyvTuBmknTFy5VFZiFJxDAcHdUFBgHRO57gUOMuwWqi7atgcYOVpEn1m5o4RxKzYryTuqRewmDc
X-Gm-Message-State: AOJu0YxTSV0unJjtlKICGdbYvZUsqVYm+T4YNUqkd252qFa/OLoEDXHt
	wmdppBhnOmSialGygafP2ttf6GoKgfihAkcdfdkMzbCuikm0emZO1WYpCKGFLG8=
X-Google-Smtp-Source: AGHT+IG4YUhVxaSBnXPsJIULUKt9gS7CBx7x0PLGIkzsVv5hpJ5BSwaLS/B4nsuZ9inxMJ044rQCag==
X-Received: by 2002:a05:6808:2286:b0:3c1:b017:173f with SMTP id bo6-20020a056808228600b003c1b017173fmr100403oib.12.1709008929538;
        Mon, 26 Feb 2024 20:42:09 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:08 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 07/20] Staging: rtl8192e: Rename variable bCkipSupported
Date: Mon, 26 Feb 2024 20:41:44 -0800
Message-Id: <20240227044157.407379-8-tdavies@darkphysics.net>
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

Rename variable bCkipSupported to ckip_supported to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 8 ++++----
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ea08ac058421..6cab19b03f4f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -928,7 +928,7 @@ struct rtllib_network {
 	struct rtllib_qos_data qos_data;
 
 	bool	bWithAironetIE;
-	bool	bCkipSupported;
+	bool	ckip_supported;
 	bool	bCcxRmEnable;
 	u8	CcxRmState[2];
 	bool	bMBssidValid;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 63e3b655e4ee..cdb7e87c0c89 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2099,12 +2099,12 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 				     & SUPPORT_CKIP_MIC) ||
 				     (info_element->data[IE_CISCO_FLAG_POSITION]
 				     & SUPPORT_CKIP_PK))
-					network->bCkipSupported = true;
+					network->ckip_supported = true;
 				else
-					network->bCkipSupported = false;
+					network->ckip_supported = false;
 			} else {
 				network->bWithAironetIE = false;
-				network->bCkipSupported = false;
+				network->ckip_supported = false;
 			}
 			break;
 		case MFIE_TYPE_QOS_PARAMETER:
@@ -2349,7 +2349,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	memcpy(dst->CountryIeBuf, src->CountryIeBuf, src->CountryIeLen);
 
 	dst->bWithAironetIE = src->bWithAironetIE;
-	dst->bCkipSupported = src->bCkipSupported;
+	dst->ckip_supported = src->ckip_supported;
 	memcpy(dst->CcxRmState, src->CcxRmState, 2);
 	dst->bCcxRmEnable = src->bCcxRmEnable;
 	dst->MBssidMask = src->MBssidMask;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index c3f37e71d614..0915f4f8761f 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -740,7 +740,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		}
 	}
 
-	if (beacon->bCkipSupported)
+	if (beacon->ckip_supported)
 		ckip_ie_len = 30 + 2;
 	if (beacon->bCcxRmEnable)
 		ccxrm_ie_len = 6 + 2;
@@ -817,7 +817,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 			*tag++ = beacon->rates_ex[i];
 	}
 
-	if (beacon->bCkipSupported) {
+	if (beacon->ckip_supported) {
 		static const u8 AironetIeOui[] = {0x00, 0x01, 0x66};
 		u8	CcxAironetBuf[30];
 		struct octet_string osCcxAironetIE;
-- 
2.39.2


