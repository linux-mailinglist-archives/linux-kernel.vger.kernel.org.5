Return-Path: <linux-kernel+bounces-76406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F57C85F6CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DA2B2666F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C9B45C1C;
	Thu, 22 Feb 2024 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNuq4QZX"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCD145954
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601271; cv=none; b=eHrJ/RlZh2tmvNsMa34uCUevvNJAsER/VX+yxI7OiWunQAOsCjjq7fkeDiQ6g0aSlw6TtNEKCeGVfzrIwGBHp7tz8xsb9MNEwk6rK2dX54C9gKkfmXLlOyTk6lc3EugkbN7q9Nmg2l0U9IREzQpAxZvBoX5wmBYzDPgmo0hA6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601271; c=relaxed/simple;
	bh=cOOD/LklXxoR0eMhE983UUMMSzNLG37BUxGl/wGbQDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sgeb6+Wh4+amlaCoX8dn4f6QGs/GctoGUbr3Ik4ascr/JVa60wrI/KA0q4XrAwGGz+BGwnap543E2cQDKfdaZhZLHGSzRE2EbNMziy6by0DG1LCrLi2rz0FoPhJCJxLSX7LtIIbkIuo3hygy44rDYbF2CvOZdz01o+30FepWvs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNuq4QZX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so2433676a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601268; x=1709206068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do0TBWnjEnIoXDwl9l+y0DORBcXXcd9fc9eqtcity5g=;
        b=MNuq4QZX9KtakTg87MgeqoWnpxClEL5LlpuhVIWELfe/7c4A8HTufiYeDeMg5KNaM2
         glzTuCoPlSF13BKbQXTJWv3vx+7er0jL/5zJGI9AfintnBWBHeUWOYYSk2EPW06Xujfg
         fhJ+Z4+LVpFBSF3L6qbTvq9hlCbqoUHQj00TN5/qbuoTGvfdLWnQ+SdXbKqqm4zcso/t
         zQViWRj+EXn5X/skukC0a2HamGGFtUWSbT6QOWw8dejveZLhThuDS6Hl/f811nJFKv1O
         guWsx223uzNHXZmrWOXaGdkcDnEslUluLAzcwEqUJe+SKZzF+GiW5OoKPDGhN+qfKAYE
         dhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601268; x=1709206068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Do0TBWnjEnIoXDwl9l+y0DORBcXXcd9fc9eqtcity5g=;
        b=CAhZIkPMMEvfY5TAADZLKHb6NcmpwDy99ptI8zv+inj8RTKJ1AXpk4l/ggF8JlsOKK
         B3wLGGNREzMHW/rwkHXrUySUbs+LQFVnrwgP7ofPJRJOy+gCqZY/ohuqAwbN4IYbZlVh
         QLa7sscJLvTdQBti97kLYf9xR+fnVudELqIQ8MoZ33hN/nFxj+Ez9ZgAVI1GuAwosUIX
         hOcGWGFrEltK7/cGlNGp7xe4ewBUcXjsi3xy8kubk47Wl7+BUQntqUBiLogMOPyGDahf
         JLoJ3i5vngDhlhu25mozHnQvjEO0ZCu6ykuzGrYS8NvJlEuLhAHpSMouktmIk2bwoc9R
         yojA==
X-Forwarded-Encrypted: i=1; AJvYcCWO4nDTrFRYUn6wHc929q1OKXkO9+KMYpzQD/s0JiWijyQNqN+u0Tiz81+1YY4jAcXG+PulryfuUSau8h4gubPKoD0lTp7tye7pPLuB
X-Gm-Message-State: AOJu0Yz3nww3s8B3Zw3efQEaVCx9dknFPpHT28caww1J+1//syDv7b6V
	z72aEal+4WZ7nsQ1qXInbBUw/G1s2yWgjnymnKbe+graERxtt8UC
X-Google-Smtp-Source: AGHT+IE0EJjVMt/9f6FBRlMGPMbshECGhv2n/wrzRJgLMOJuo6Fm0pjmCN/I/RAGwgqsZ63j6sGjSQ==
X-Received: by 2002:aa7:d455:0:b0:564:2519:5a74 with SMTP id q21-20020aa7d455000000b0056425195a74mr9130416edr.11.1708601267734;
        Thu, 22 Feb 2024 03:27:47 -0800 (PST)
Received: from localhost.localdomain ([95.90.186.51])
        by smtp.gmail.com with ESMTPSA id ck8-20020a0564021c0800b0056452477a5esm4338524edb.24.2024.02.22.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:27:47 -0800 (PST)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8192e: rename rateIndex to rate_index
Date: Thu, 22 Feb 2024 12:27:21 +0100
Message-ID: <20240222112723.18428-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240222112723.18428-1-straube.linux@gmail.com>
References: <20240222112723.18428-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the variable rateIndex in the function
_rtl92e_update_received_rate_histogram_stats() to avoid camel case.

rateIndex -> rate_index

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 64 +++++++++----------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b54dbc97d4ba..0a3c81e14951 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1527,7 +1527,7 @@ static void _rtl92e_update_received_rate_histogram_stats(
 {
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 	u32 rcvType = 1;
-	u32 rateIndex;
+	u32 rate_index;
 
 	if (pstats->bCRC)
 		rcvType = 2;
@@ -1536,95 +1536,95 @@ static void _rtl92e_update_received_rate_histogram_stats(
 
 	switch (pstats->rate) {
 	case MGN_1M:
-		rateIndex = 0;
+		rate_index = 0;
 		break;
 	case MGN_2M:
-		rateIndex = 1;
+		rate_index = 1;
 		break;
 	case MGN_5_5M:
-		rateIndex = 2;
+		rate_index = 2;
 		break;
 	case MGN_11M:
-		rateIndex = 3;
+		rate_index = 3;
 		break;
 	case MGN_6M:
-		rateIndex = 4;
+		rate_index = 4;
 		break;
 	case MGN_9M:
-		rateIndex = 5;
+		rate_index = 5;
 		break;
 	case MGN_12M:
-		rateIndex = 6;
+		rate_index = 6;
 		break;
 	case MGN_18M:
-		rateIndex = 7;
+		rate_index = 7;
 		break;
 	case MGN_24M:
-		rateIndex = 8;
+		rate_index = 8;
 		break;
 	case MGN_36M:
-		rateIndex = 9;
+		rate_index = 9;
 		break;
 	case MGN_48M:
-		rateIndex = 10;
+		rate_index = 10;
 		break;
 	case MGN_54M:
-		rateIndex = 11;
+		rate_index = 11;
 		break;
 	case MGN_MCS0:
-		rateIndex = 12;
+		rate_index = 12;
 		break;
 	case MGN_MCS1:
-		rateIndex = 13;
+		rate_index = 13;
 		break;
 	case MGN_MCS2:
-		rateIndex = 14;
+		rate_index = 14;
 		break;
 	case MGN_MCS3:
-		rateIndex = 15;
+		rate_index = 15;
 		break;
 	case MGN_MCS4:
-		rateIndex = 16;
+		rate_index = 16;
 		break;
 	case MGN_MCS5:
-		rateIndex = 17;
+		rate_index = 17;
 		break;
 	case MGN_MCS6:
-		rateIndex = 18;
+		rate_index = 18;
 		break;
 	case MGN_MCS7:
-		rateIndex = 19;
+		rate_index = 19;
 		break;
 	case MGN_MCS8:
-		rateIndex = 20;
+		rate_index = 20;
 		break;
 	case MGN_MCS9:
-		rateIndex = 21;
+		rate_index = 21;
 		break;
 	case MGN_MCS10:
-		rateIndex = 22;
+		rate_index = 22;
 		break;
 	case MGN_MCS11:
-		rateIndex = 23;
+		rate_index = 23;
 		break;
 	case MGN_MCS12:
-		rateIndex = 24;
+		rate_index = 24;
 		break;
 	case MGN_MCS13:
-		rateIndex = 25;
+		rate_index = 25;
 		break;
 	case MGN_MCS14:
-		rateIndex = 26;
+		rate_index = 26;
 		break;
 	case MGN_MCS15:
-		rateIndex = 27;
+		rate_index = 27;
 		break;
 	default:
-		rateIndex = 28;
+		rate_index = 28;
 		break;
 	}
-	priv->stats.received_rate_histogram[0][rateIndex]++;
-	priv->stats.received_rate_histogram[rcvType][rateIndex]++;
+	priv->stats.received_rate_histogram[0][rate_index]++;
+	priv->stats.received_rate_histogram[rcvType][rate_index]++;
 }
 
 bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
-- 
2.43.1


