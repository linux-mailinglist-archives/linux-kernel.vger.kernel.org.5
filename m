Return-Path: <linux-kernel+bounces-84159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3225786A33A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9E328EC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3F155E41;
	Tue, 27 Feb 2024 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CzglCkHX"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4C56740;
	Tue, 27 Feb 2024 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075087; cv=none; b=d8oXFUdR9Lhtw/b14SFqIJV07X1cUpQ0XuZocNecAALR67Ibh8198wSrKVCl+PisioR3lnF0xjAVJXSBlpbFxM0VdByLvx4Z6oOIczLpwyQl2P7pmgYsChsJnyV568TBbezR3xVPpD8kX9RftzoP2OuD2DznAvHKzkGadwjsVFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075087; c=relaxed/simple;
	bh=TCLhVR18bPbwPX6om2wj/JmRt9QdCvRZ6Yg+2ueRaVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XaGStI73CcGDstIHCdok8j+s091smINNoFU2h/9DvrF4/UHb4iNh0lo+zr7OGPWXYMb1C50LkQ+UBesz5K5yiSqj6eTP3at4kzKKRuuHpTsg7FdeBElqKEoBF9L0nmDEFkUMl1W//IeySHc8O6MA/pdsgTQPGEXwof2t1Q+2DeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CzglCkHX; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78EA7C0006;
	Tue, 27 Feb 2024 23:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UU5eqek636ykpjvx4kiaBg2YTtRQWsggazZSLPW+0Z8=;
	b=CzglCkHXhbujLFTTJdEzQzJIihM4PRKG92uzg+3pthCgO+Brgk19xYEEb958OoAj4SwHwS
	u1WNMbjlEXPWv//iNUx3vh/XSb+clKK7FcZnSQkkeD8ceLaj0HHW5vYoHFEOcYnqeI0fKg
	5zVv2wFlhLgdpTBOosW9lr9VNctzwdiGyiLVdwxpWMMjqJl1Dx5HpEiqMPrzRcRj0/abtw
	8nmpDQzX7tJBNtSXt2O7cDIrISr+Q6l+YGTNtx5uPM3Y/UPIXo81ijSpRGPl8XOgf8p1LB
	Xa0wRTamMDFf/3rc1unVNkPWAVf8ZkaFx/OR59GUpMba+MplxnAdvyRRMRKBtw==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] rtc: ds1511: drop useless checks
Date: Wed, 28 Feb 2024 00:04:16 +0100
Message-ID: <20240227230431.1837717-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The RTC core will always pass a valid rtc_tm, it is unnecessary to check
the validity of its members, especially with an open coded version of
rtc_valid_tm().

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 1109cad83838..87c52d20d31a 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -182,9 +182,6 @@ static int ds1511_rtc_set_time(struct device *dev, struct rtc_time *rtc_tm)
 	if (rtc_tm->tm_year < 1900)
 		rtc_tm->tm_year += 1900;
 
-	if (rtc_tm->tm_year < 1970)
-		return -EINVAL;
-
 	yrs = rtc_tm->tm_year % 100;
 	cen = rtc_tm->tm_year / 100;
 	mon = rtc_tm->tm_mon + 1;   /* tm_mon starts at zero */
@@ -194,15 +191,6 @@ static int ds1511_rtc_set_time(struct device *dev, struct rtc_time *rtc_tm)
 	min = rtc_tm->tm_min;
 	sec = rtc_tm->tm_sec;
 
-	if ((mon > 12) || (day == 0))
-		return -EINVAL;
-
-	if (day > rtc_month_days(rtc_tm->tm_mon, rtc_tm->tm_year))
-		return -EINVAL;
-
-	if ((hrs >= 24) || (min >= 60) || (sec >= 60))
-		return -EINVAL;
-
 	/*
 	 * each register is a different number of valid bits
 	 */
-- 
2.43.0


