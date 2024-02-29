Return-Path: <linux-kernel+bounces-86058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C123086BF13
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43561C216DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88A9383A9;
	Thu, 29 Feb 2024 02:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="NQaK3Ce5"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46323374F9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174619; cv=none; b=fpI5Vavqbm/8FdfQgUWEyNPnz6XRXwJmipYkhAQmY+0l10vk15+QvKe80y41EAcPt9Cc0QrNJrnOfjUb38Yil2EGcS2fc0GuYj+Z9Z9YOKnqxmLqKnOoZPCjYH3wMlQ+CoxoaBQwtYrmf3B/xpBor6jSKm/QnWooRV+rzXpZELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174619; c=relaxed/simple;
	bh=4I+zA2OHqdaTai+sBYLEWhHGVtuBmrKy4YAOKKQRL/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEsycAkafAWNXmlRAl6w38D+F9FVVJiGkci6wGOxNhqOn5EXR01fXLvPfJADykyKJKub0GDbZ2nUsml6yqGXEpdL0t18ih8j9l/OZo5H7SDxBHKnTDyVDzpLKBQ+z1gUIgHOjDuqFPkYtvGqw675pnEMiFSkg4aaPNwhvHpYzE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=NQaK3Ce5; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c1a172e46bso272405b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709174616; x=1709779416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9egZkWmt+2eeqbBOMS0LFoFIMdDQ6t+XNJEpny2uS4=;
        b=NQaK3Ce5BBiWmskNTWl8B1NCXks5btSoxJyLczEd62ZFiZ2pBsRox0wCMMNWWLZqp/
         MBOzcoc9GMGxlvCAieOeIEhq/uL+/ZP2uj9pc/M/CYyTPJOEYVG0rhxyXqsS+zznxnt8
         NcJt5bQhBKZi0YcV3yXszNX6DFTwjKQZFoq9qsOd9VqozWYMffd06lNcwOvngXoHh6b0
         wvb9uM/OxGvOVuqRyXfyMR5BUJsX4EqddQwiQV4cMaOlIJijdAcmD/VJcmgM8HXECYo9
         NJi44pOV45Oyn7YSsMmSr7297wj2y5reKmkoC5Avt9ktWIvTeKR461BLKAVQ7nbrqSzF
         /PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709174616; x=1709779416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9egZkWmt+2eeqbBOMS0LFoFIMdDQ6t+XNJEpny2uS4=;
        b=uLF04hDVqfIYb3gApcpfALCBHqOVxhpphtNobLyELISCjo421+tIAxevJlBy5Q4h1u
         tMOFnYKiHgOPTUQ8xrFNBqcwHAuc33mlXAkXmci1wKP44OPa7HFHuTP+eVHHOzpMUnIt
         Hl7a9x5IVk/Cu/ZGrXuVF6k1Swc3JmqTcx2KpAhY/Aa3x8KVnLdHBTvTCaAfbao0ACXB
         MnS+KujsLi30JV+IxzF2KRAeux4LcJWtCieWi0YFiBKBLdy28WA/aJottBgVJFRR5Eet
         DrgFIUWV85NoGjSSwZRKKuN50M/zFTBtxSdaW4Zp23vOA+NTMzU5+fHY/0yKAtQMvkU/
         DJig==
X-Forwarded-Encrypted: i=1; AJvYcCU6zEr9f7Lx1M6tYXxH755t/2y/9CxD9mhtM4/yAR9Z5ZFrsK37W7PopQvdkHo/47CPWLiEzrRqUvd+ivbL/ppMxMLUk1XwnWQVEWrz
X-Gm-Message-State: AOJu0YwMGsFliXRJIiiBvq/CcaXlrUuRa7tdf9roFEdJEfPphhuPyYej
	jJqLXYOqyV3SzXCJn85Gju9ghQI25J3f6v8v8D7v1sSbwWcydb46Jr0DJ7Ca+K0wSSHM34Sv+AU
	j
X-Google-Smtp-Source: AGHT+IHIbAPIDs71tFfyDPKjn9ApcIM6xi3nbM6oU0uYbTPHLkzfl7xSSt1LzulqUUWZ2S6mAbAJlQ==
X-Received: by 2002:a05:6808:1302:b0:3c1:c36e:9ed2 with SMTP id y2-20020a056808130200b003c1c36e9ed2mr934199oiv.36.1709174616381;
        Wed, 28 Feb 2024 18:43:36 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b006e5092fb3efsm141504pfn.159.2024.02.28.18.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 18:43:36 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 4/8] Staging: rtl8192e: Rename function rtllib_send_ADDBARsp()
Date: Wed, 28 Feb 2024 18:43:21 -0800
Message-Id: <20240229024325.453374-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229024325.453374-1-tdavies@darkphysics.net>
References: <20240229024325.453374-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function rtllib_send_ADDBARsp to rtllib_send_add_ba_rsp
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 1aa57f654b82..c0006daa75ec 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -186,8 +186,8 @@ static void rtllib_send_add_ba_req(struct rtllib_device *ieee, u8 *dst,
 		netdev_dbg(ieee->dev, "Failed to generate ADDBAReq packet.\n");
 }
 
-static void rtllib_send_ADDBARsp(struct rtllib_device *ieee, u8 *dst,
-				 struct ba_record *ba, u16 status_code)
+static void rtllib_send_add_ba_rsp(struct rtllib_device *ieee, u8 *dst,
+				   struct ba_record *ba, u16 status_code)
 {
 	struct sk_buff *skb;
 
@@ -283,7 +283,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 		ba->ba_param_set.field.buffer_size = 32;
 
 	activate_ba_entry(ba, 0);
-	rtllib_send_ADDBARsp(ieee, dst, ba, ADDBA_STATUS_SUCCESS);
+	rtllib_send_add_ba_rsp(ieee, dst, ba, ADDBA_STATUS_SUCCESS);
 
 	return 0;
 
@@ -295,7 +295,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 		BA.ba_timeout_value = *ba_timeout_value;
 		BA.dialog_token = *dialog_token;
 		BA.ba_param_set.field.ba_policy = BA_POLICY_IMMEDIATE;
-		rtllib_send_ADDBARsp(ieee, dst, &BA, rc);
+		rtllib_send_add_ba_rsp(ieee, dst, &BA, rc);
 		return 0;
 	}
 }
-- 
2.39.2


