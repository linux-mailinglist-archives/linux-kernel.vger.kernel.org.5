Return-Path: <linux-kernel+bounces-47769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BC684528C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266931C25179
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC6215A49C;
	Thu,  1 Feb 2024 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhfT1h/x"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7A1586FA
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775526; cv=none; b=LwsA5+6KH3HX5LbGILOYyRcyU4xeEbrHs1M3fYo/0p0BKyQkGrVoqOD9+/I0NqNax4f9lUdclEjNnoc2DVb7pyA9/cOR+TQJw8sohH2sZyBXgN+ohjS1y8lfwkmiq//rC7z/Q0SlvDJyGg6l/5pEsKZ81AMjJ3poxP1GiC6fsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775526; c=relaxed/simple;
	bh=POYD2X8Sn0xdUyEMVmcSASb32r6ux72G3OFg1ARJVgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BY1M50Pxn4I+s8SweSvri6WAMK1VPKQRtmK/tcchVN701vAeqLDwLdn8t7Hpu+hHkeOiD2G/ny5YQarUVlsxk/+sSELYao76Al5zRe7aXzMDjvEfM+Aw77pUOdMV7NKmEk8dn30xujKtM1fc9y8QJ0eJjlmwzWrIhRBICuxeJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhfT1h/x; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a357cba4a32so74757066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706775523; x=1707380323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyVY24lOJtDz67jI+ohD8RRv2jZxEpdf9sHHgY5otn8=;
        b=KhfT1h/x/YLBoKfELnjsordM00z8eJDixKNGO5gIEOeqNkimhe4PpJOMLRkNBF7A7v
         RN5pxI5uAl7LGcR54XEtzzWpyKKmfqLouv9gVlI04aURsH3HAGd1jEbkvcLqE9g46pVD
         ZeElf5H4GJJhCKdU7j7cvFYInjUHQ2fO8XcGNlErocwfPMHg91+mAeU/I4qVivpf5qbg
         Yh4D9oMmoEq0VquvZfvIjuv/vfelXLfV+pbYT4iSCGavTtBhDgxgIoreKglbM9ZAmdT6
         MzPyJEmpBra+CXVfl8I/fE+XdYSYK2kOXpVH9Ltfrur5zUCRPanuvAVHKyRv07X9APUs
         ynTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706775523; x=1707380323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyVY24lOJtDz67jI+ohD8RRv2jZxEpdf9sHHgY5otn8=;
        b=iWbXYSiumeedRGLwic3fUlqMFDqt74UzrLkIBBVdsvWlamUogIR9tSvwTz6YgM/aRg
         vcz7sf1ear1Z2LITJGSdlU+5Jy4lhQshhwknMbhjfJ8ZisHq06dUPtDOs+2mfxTRpEvH
         NZ7z3tcwnbOMz/beQ/MBnLk9GcrOjRcrX9yKcdtV/t+lx8jal6N8smxpcZIgSrlSaRVH
         Lie3dLGQd+Dr/4HSmg4eTr/9MGbJuMDNOiwgHVCJruWZsdHyuVguET0dOloitUR76Ptr
         mIxImLkMsDdIfjAm69iI6y47ynxAxir8/EEUZRa5sopP8Ug1K50i0N/rHFPwN6h1SHOo
         rtkw==
X-Gm-Message-State: AOJu0YwapROyS5OH68Wk0FrtXPVPxWrNG7Q1F8qow4Axi37w5uWfCzls
	8f7nEvRY0mEEwhg8nn19T3WIfskq65KgEEcAG1/catYWgHg4dfj8
X-Google-Smtp-Source: AGHT+IFjEI+XBZGPNAoXAhBdc3TiBeW/ocx6zElDWvgleHMQYVsAFzjEsbyjPiB+tdHX+hTBv4Bppw==
X-Received: by 2002:a17:906:1397:b0:a36:9041:cdc4 with SMTP id f23-20020a170906139700b00a369041cdc4mr1137713ejc.53.1706775522949;
        Thu, 01 Feb 2024 00:18:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWM4VA2pCElicVrJtpPs1pnoNTgPQ4E9PPC66Ds1TCXsuMzFnfBW7I5W/VfrnKCr/fFzjGXz+XEG9MqPuZZSL1mC1C8rFgPqcYNqA5aW7pxP9MFnesiFRfG4qoM0pJ9ht3roxZbM29i4vUkR2B6acUHqapBt3S+zkqtWAzCoOJ5y8gGt1I=
Received: from localhost.localdomain (ip-77-25-34-59.web.vodafone.de. [77.25.34.59])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906784700b00a310f2b4b91sm6954069ejm.48.2024.02.01.00.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:18:42 -0800 (PST)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8192e: initialize variables at declaration
Date: Thu,  1 Feb 2024 09:18:24 +0100
Message-ID: <20240201081824.6998-4-straube.linux@gmail.com>
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

Initialize two variables at declaration instead of first declare
and then initialize them. This saves a line of code and clears a
checkpatch warning.

WARNING: Missing a blank line after declarations

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index f777febcfe3b..f94fdf27214c 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -943,10 +943,9 @@ static void rtllib_rx_extract_addr(struct rtllib_device *ieee,
 static int rtllib_rx_data_filter(struct rtllib_device *ieee, struct ieee80211_hdr *hdr,
 				 u8 *dst, u8 *src, u8 *bssid, u8 *addr2)
 {
-	u8 type, stype;
 	u16 fc = le16_to_cpu(hdr->frame_control);
-	type = WLAN_FC_GET_TYPE(fc);
-	stype = WLAN_FC_GET_STYPE(fc);
+	u8 type = WLAN_FC_GET_TYPE(fc);
+	u8 stype = WLAN_FC_GET_STYPE(fc);
 
 	/* Filter frames from different BSS */
 	if (ieee80211_has_a4(hdr->frame_control) &&
-- 
2.43.0


