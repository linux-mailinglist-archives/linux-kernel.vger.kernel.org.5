Return-Path: <linux-kernel+bounces-37774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2C383B4EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979A71F21189
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B3C13AA2C;
	Wed, 24 Jan 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="bDeZuvlo"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D21386DA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136306; cv=none; b=fxHFj/hU9fj3GJ/qXFZTBjbLz4AUt/smwQpTE0qIgkAL/f3gY0ACZd/Dg2dt6/hdr1ITioeOd+E9GSPSNM3g24GFGmTUxMVR3YWOnSDWRUm9n/85Ljx3DdRkWB+hKMPpYaGS9mjT2Hn0LJ2/fzdJmq789+9Md+5agaAby+2pnWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136306; c=relaxed/simple;
	bh=DJJM8ourMI8YOLSjcnuIiMGG/Ch85Npyxy4IyOv1k2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMCANQnGMUyxO4Qofqw5E/lvhT8DJDKUbmQ0/Zly6u1uHe6PV2JhtiZvq0quGjp/R4kPk1Lj240V7AlSzRVkUSwTSkSNsDkUOKZo26JBBPT2b77TELH8xCzcLKw9RZrbKU1ZE/R8cEzwOix9LYZwK5/7ZvyfO5BOk3nle7U8hCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=bDeZuvlo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d427518d52so1289915ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136304; x=1706741104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa5epUckBwc59OQqx8+WcaToiqilCl96layeKKlW1wA=;
        b=bDeZuvloMEoHT+vF8wOGnbpp3JKEktfYpcSTFswDtTnZQvpiwyRN8oN9sjrg3W2oF6
         +vpyeyzGLSsbOjFwKPEcwTOpru3DOKmtM3gFyMYlMJSGH0ixHBA2DrebVoyDkK92u/YO
         ETNVYZOZ64bJmuCjhAfulNdY0HJ17pfCCf4ulR3aKFBnpK7/s6u6vyCuRqG+GGhHGw/k
         e9xezn1YO7rJw489mTFBj95GT4G7NsAmueqi/UjV2Bfe47F+HIdpP2hPpeSpGIO9t/60
         FGbjpl9cFvTmSPDUILqsSJrYjShXpiySY0NlU25pHAt46GzwMfI98FILdS0pg0+BzM+q
         PFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136304; x=1706741104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa5epUckBwc59OQqx8+WcaToiqilCl96layeKKlW1wA=;
        b=SaAmB+VYw18YzkaDRklllvPPFgk9qwAEMC9Ltl8XVbmGHD6H+sqPKOmpye4WLVDiAW
         KUvEOY5Z/YX6kAXi8yXDtE2Zm3j7g8IQi/xMnQKXAx9E3Ubv8I9cJdAaQ6v6W33ya70s
         3nS8/tFnX51jx2cn9G0OrOlSZrxrBdnutu39SBMcnluByxIFomCeSVtYyuHLU/iUZLmd
         0K2+Y0TSu4Psyzi1F9ZbqcdsQQc47oVMloPv6HX/tEKm3LmCAjyqw/fiyUFOcVaZm5bt
         Qj9EQeQRq+1seuY96TeEeEWKUhOHd6MZoNg+F1YLXNwOZ0u3bEUe4Cc8DLzYFveY/2zL
         ki6Q==
X-Gm-Message-State: AOJu0YzfCQCb4KwlkJ2v5Dhoepa0k3fq6mxJl/lEZ5dannCmAMqNnMVC
	s5RiZxQSa07puuZW30Rky1CVZ3K9DfIccxFMvasNOzADSEGLWGJFv4l8XgJDPXnstQ1VI/lE8rI
	a
X-Google-Smtp-Source: AGHT+IF2Q69nmyZX52NssPpNhs/qhCQwjcYYmyUrjRUIxPp3YDjHXbBnqzIIGgodhF42Xw3+hSfzEA==
X-Received: by 2002:a17:903:24c:b0:1d0:4802:3b6c with SMTP id j12-20020a170903024c00b001d048023b6cmr64614plh.4.1706136304108;
        Wed, 24 Jan 2024 14:45:04 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:45:03 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 09/18] Staging: rtl8192e: Rename variable LPSAwakeIntvl
Date: Wed, 24 Jan 2024 14:44:43 -0800
Message-Id: <20240124224452.968724-10-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124224452.968724-1-tdavies@darkphysics.net>
References: <20240124224452.968724-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable LPSAwakeIntvl to lps_awake_intvl to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 26 +++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c380d1c3e9b6..8de46b61416b 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1072,7 +1072,7 @@ struct rt_pwr_save_ctrl {
 
 	bool				bLeisurePs;
 	u8				LpsIdleCount;
-	u8				LPSAwakeIntvl;
+	u8				lps_awake_intvl;
 
 	u32				CurPsLevel;
 };
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9ee6364f7b00..545f79387991 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1379,15 +1379,15 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 
 	if (time) {
 		if (ieee->awake_pkt_sent) {
-			psc->LPSAwakeIntvl = 1;
+			psc->lps_awake_intvl = 1;
 		} else {
 			u8 max_period = 5;
 
-			if (psc->LPSAwakeIntvl == 0)
-				psc->LPSAwakeIntvl = 1;
-			psc->LPSAwakeIntvl = (psc->LPSAwakeIntvl >=
+			if (psc->lps_awake_intvl == 0)
+				psc->lps_awake_intvl = 1;
+			psc->lps_awake_intvl = (psc->lps_awake_intvl >=
 					       max_period) ? max_period :
-					       (psc->LPSAwakeIntvl + 1);
+					       (psc->lps_awake_intvl + 1);
 		}
 		{
 			u8 lps_awake_intvl_tmp = 0;
@@ -1395,23 +1395,23 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 			u8 count = ieee->current_network.tim.tim_count;
 
 			if (count == 0) {
-				if (psc->LPSAwakeIntvl > period)
+				if (psc->lps_awake_intvl > period)
 					lps_awake_intvl_tmp = period +
-						 (psc->LPSAwakeIntvl -
+						 (psc->lps_awake_intvl -
 						 period) -
-						 ((psc->LPSAwakeIntvl - period) %
+						 ((psc->lps_awake_intvl - period) %
 						 period);
 				else
-					lps_awake_intvl_tmp = psc->LPSAwakeIntvl;
+					lps_awake_intvl_tmp = psc->lps_awake_intvl;
 
 			} else {
-				if (psc->LPSAwakeIntvl >
+				if (psc->lps_awake_intvl >
 				    ieee->current_network.tim.tim_count)
 					lps_awake_intvl_tmp = count +
-					(psc->LPSAwakeIntvl - count) -
-					((psc->LPSAwakeIntvl - count) % period);
+					(psc->lps_awake_intvl - count) -
+					((psc->lps_awake_intvl - count) % period);
 				else
-					lps_awake_intvl_tmp = psc->LPSAwakeIntvl;
+					lps_awake_intvl_tmp = psc->lps_awake_intvl;
 			}
 
 		*time = ieee->current_network.last_dtim_sta_time
-- 
2.39.2


