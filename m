Return-Path: <linux-kernel+bounces-40760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EF283E574
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5214528445C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F406BA5E;
	Fri, 26 Jan 2024 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="VCEoE3sB"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F723751
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308299; cv=none; b=nB6MfWm13GDAKtqsDQK3aJ4acUSjsTgTK2wABuDEUMHF7NJ6T11slYm2d2WqAw9rx8SbPR9HR/tMk8wzhCMFtAxERVdYnb2auVISS0iHUSnfP1l8/858N0TwU/Nh0PT3wZRlyR2gX4oypYmoWOIiwiZ/lN7O/HnJ5ufVlF3hU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308299; c=relaxed/simple;
	bh=jOl++2HVJNWtEhnqLNXp11rpLyr2YgETrxZTkmaKRbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=csxiAD0Gp1Q4Zd1nlAX+X0gAMLqePMvMdRkqmsaAxC9GY0Q2rTAxmny9LcXRvV4UslwKgIu8U2vNh3Xx6bGlCzJF7AhDqi4ZHhSlPJGsWUH8spZqfXanWPinq37HBX1jFvgt4BpnbldQGW/wLe0tGTJq91CfYSDS4SYNf2EFgF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=VCEoE3sB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d7393de183so6277835ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308297; x=1706913097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ocy4xNuI1aWxJ9NCP60qvK1mfFV9OPkIlnUlYlr+R78=;
        b=VCEoE3sBBTSvl46NkG6SXqjjGe6fcbnDwu5+eQFO/i+Yc3IjPj8LRWJDwMxFetUv02
         iTd58JtAsV64HFlqujrgR7mUqGf12BzTO3B5kZ76Nw3+jk3Ls4j9QzeNZ324GO6u79of
         L9Q7VGn9j9O1OAaPEnw/P5yMm9pJXpV69byjeFFtufCjzm+vJlzbUQFzOkI8I9x1LYZz
         eqatdt+TrHLdwdTmeLQfu5NF+JzhWxhPN/SMkxiVmpFZAhU4fJJsPhrwGx2g4ZzCLxOD
         8h0AW/IVTuPmTwb4xrd00M2qpD8qyxjMY/971uhNvpw94iWhwWybiKakJB6dli/W0fjp
         7JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308297; x=1706913097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ocy4xNuI1aWxJ9NCP60qvK1mfFV9OPkIlnUlYlr+R78=;
        b=ruH4DoFyXXtRjleYD5PSph5R1UXpQRrZL32/T/Eh/yVVL2ae/MOFyZSJpYyxIIigGa
         hU4t6b2eSj8Co3B22PU/oaFiW9Sw//Rz7s7MBSd8I7tGuw+rskmKFOFFqvfQpN19SqR0
         DYcD2XqLvPlcT1mGKTooxN/C8QoH7/kkJCR2oVzl2F2iLBVyIy+0aJdlnewVO5rLhUNm
         xC2ETcEk7nghKvrhLec1i5PoEl/o1z1u39bF4bobd4tDyZ+LqBPUZ9rnSIgP4JSDpWrR
         nfFWGXw9BeqXvqpesAT8Asu9DVLDkqsJXL5XoyaHJuMMG+RD9f9zJADgpMg8OWAz15Cm
         EXgw==
X-Gm-Message-State: AOJu0Yxm/14UgJYN+8BaQhuJbqyviP9jHdJYyFpPEjaslcPI70ALnEWN
	LbniOnQxaMulyQuttiIAjwBvirpWQSzxS52JULX8LSGnFZQ3eYZ7wckV4puvSH8=
X-Google-Smtp-Source: AGHT+IGJh9eqHFmXfNY1NZO+0TFfkIOqsN/pN2sHET6j9hMFRKbYFc8jUnMfSDZas2N7NUPwntU2nA==
X-Received: by 2002:a17:902:db05:b0:1d5:dfc6:c334 with SMTP id m5-20020a170902db0500b001d5dfc6c334mr455827plx.61.1706308297378;
        Fri, 26 Jan 2024 14:31:37 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:36 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 01/18] Staging: rtl8192e: Rename variable FirstIe_InScan
Date: Fri, 26 Jan 2024 14:30:49 -0800
Message-Id: <20240126223106.986093-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126223106.986093-1-tdavies@darkphysics.net>
References: <20240126223106.986093-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable FirstIe_InScan to first_ie_in_scan to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No changes.
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h          | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 5fd44d0c4b1d..d131ef525f46 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -269,7 +269,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 
 	mutex_lock(&priv->wx_mutex);
 
-	priv->rtllib->FirstIe_InScan = true;
+	priv->rtllib->first_ie_in_scan = true;
 
 	if (priv->rtllib->link_state != MAC80211_LINKED) {
 		if (rt_state == rf_off) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0fdc767d43e0..13a901c0db1d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1201,7 +1201,7 @@ struct rtllib_device {
 	bool cannot_notify;
 	bool bSupportRemoteWakeUp;
 	bool actscanning;
-	bool FirstIe_InScan;
+	bool first_ie_in_scan;
 	bool be_scan_inprogress;
 	bool beinretry;
 	enum rt_rf_power_state rf_power_state;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9d1e9b780bc7..44b36cc867d9 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2101,7 +2101,7 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	ieee->reg_dot11tx_ht_oper_rate_set[1] = 0xff;
 	ieee->reg_dot11tx_ht_oper_rate_set[4] = 0x01;
 
-	ieee->FirstIe_InScan = false;
+	ieee->first_ie_in_scan = false;
 	ieee->actscanning = false;
 	ieee->beinretry = false;
 	ieee->is_set_key = false;
-- 
2.39.2


