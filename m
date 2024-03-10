Return-Path: <linux-kernel+bounces-98378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0866787793F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E47EB21072
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A915340BE2;
	Sun, 10 Mar 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="jVEKdv7+"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4320A3D980
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710114963; cv=none; b=pilc1zeUGqzaifln16lJhO3YyEMKNOOdP8oUYSU9Vk8yjeC/FsPvRat0bLfSmgUoNrXnDyu0X8cXcldMPUlnuXujcnjMNF/Q2t0350Lhe4hpUZn8SSe5kUbMXYj4wxZT6molUGGTt4SWG3iI8nlVUiq+bqYDrjJMysf91gQLBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710114963; c=relaxed/simple;
	bh=HADUIoGNxxZzzQVbd0yS7ovHI657F4f4qpl2PdUmfl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTqMG49depQXV5vz9sqULn7Q1KTDtAlT6TP9dIi+xI5RmBUMQKMK2ezIkfCiIyqA3NPaYNQQmpfSg1+jcuDJ8r5TU88Zms2Dwqg1ETsa8eU1TFmtFaPL5P7dvx2ndT3iQjc/msVRZxQHO+Aa9q+5jIS72VJqMHtiLUwZzRhHpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=jVEKdv7+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e5eaf5bb3eso2836253b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1710114961; x=1710719761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ek+tNEVfANxjTbowDv0K1U1oO/hLiu0/vhpb377ZsU=;
        b=jVEKdv7+AXbtA456K4lLrfhr//Txk9X/9BesUCj1T3MYRgBtcB2MmUVVd5TQvSiGmc
         ZEpQZUm7n8PWrPIP0m9+86COnSEMiFdzvUONwTNQ6ur12BvCItdk0egsW0aLbJ2r0qlL
         KYbET4TJJcVaAgLpzHGW4mh2AqqVJoqo0DDGqagS2cGp8mg6aN+JHU+pE+r560VvP+HY
         YMob6xGZNkmOHVhk3vOaORjXaZZkCHqVp8f703o36RXknmZOtn4sC6YtHxyKnvKLPIVP
         8bfrzxgfsZ2ON73S9YFQPdI1lhgj37Fn/7dACVe2T064fplQQR1GfVkgbCuLk9FRwsd2
         VbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710114961; x=1710719761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ek+tNEVfANxjTbowDv0K1U1oO/hLiu0/vhpb377ZsU=;
        b=O6RUpC8cQMl/mkA8GogOFHAB+1ENyCBMpxwwgffRsa2ASd6xhy7CK995FphdmBk9iJ
         +rhgyHb3h/WP6GOabiTPI3LWIphvFQSOTwmUXNWPp/q0eAPiMvXGKihBM9DF3yGp7StD
         s1eATNdcFtv0c8lXz8F4p9tVRbVOXKagqlVzXCBC7msbZUfU5Vt8MvkM+mypScAQ4oID
         E/p1Y9275zXPJ8S7cUEk2ZzjtravfSBCiWmpSzf6r0xZVPQVuiwVWqbVtg1nN7YUDWzn
         mpdXm62Us6YdApmFCcV/uf9C4F1b0q5HVT9mU26Xa4BJ8Ivg5BefKnsfFIkXwf7XKEiG
         Oohw==
X-Forwarded-Encrypted: i=1; AJvYcCUgLpQg68UMqsjH4gARBZgDVYg/8eFpCmZ/UbTa5K4l0W9mf+rbmY9eg477X8Codc8kzp6vnymZoHIQ/O8lUK3fcbUED9WQq9rGjjkt
X-Gm-Message-State: AOJu0YyIHEUzb4pF0m4PiFdhnUCil7sxEBXnmubJTcS8oZ+PFq5tlLcd
	DThGToKFEoyQEiX5cw8XuXaTdn8JYtahM7GozIynegaCNwlo4eT3vY5CR3Mhgqxa11WO7Ia4m1V
	a
X-Google-Smtp-Source: AGHT+IG7CX8dL1RSwnt03aj3Eop80TAIeNKxlDtk7/JKFUXyCnlK82z7gXgIDqAY8BQmAbDiyH4v0g==
X-Received: by 2002:a05:6a21:1f24:b0:1a1:67fb:924b with SMTP id ry36-20020a056a211f2400b001a167fb924bmr2233425pzb.28.1710114961466;
        Sun, 10 Mar 2024 16:56:01 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ac08700b0029bb29ef41bsm2903439pjs.50.2024.03.10.16.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 16:56:01 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 07/11] Staging: rtl8192e: Rename variable bRTSUseShortPreamble
Date: Sun, 10 Mar 2024 16:55:48 -0700
Message-Id: <20240310235552.4217-8-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240310235552.4217-1-tdavies@darkphysics.net>
References: <20240310235552.4217-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bRTSUseShortPreamble to rts_use_short_preamble
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index dcb78cd2e840..41373c013299 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -900,7 +900,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 	pTxFwInfo->RtsBandwidth = 0;
 	pTxFwInfo->RtsSubcarrier = cb_desc->RTSSC;
 	pTxFwInfo->RtsShort = (pTxFwInfo->RtsHT == 0) ?
-			  (cb_desc->bRTSUseShortPreamble ? 1 : 0) :
+			  (cb_desc->rts_use_short_preamble ? 1 : 0) :
 			  (cb_desc->bRTSUseShortGI ? 1 : 0);
 	if (priv->current_chnl_bw == HT_CHANNEL_WIDTH_20_40) {
 		if (cb_desc->bPacketBW) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 525242b0313f..cf75d1225501 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -121,7 +121,7 @@ struct cb_desc {
 
 	u8 bRTSBW:1;
 	u8 bPacketBW:1;
-	u8 bRTSUseShortPreamble:1;
+	u8 rts_use_short_preamble:1;
 	u8 bRTSUseShortGI:1;
 	u8 multicast:1;
 	u8 bBroadcast:1;
-- 
2.30.2


