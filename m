Return-Path: <linux-kernel+bounces-84161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B46886A33E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0311C236EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D9256B68;
	Tue, 27 Feb 2024 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ED+AuveV"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669FF55E4A;
	Tue, 27 Feb 2024 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075090; cv=none; b=ly9XGRVwenQlGPrZWbPBZMAy8Itey8Fg7ZmvClI6lBy5buPw+M0j893Bl8EaSX3QBdHEC1rNkOBmNadT+I2nH4yz4Q/+4zZqUJv4pwxMSUzDv0EZMI3adj8dCcECPFiiRW+0bhOp5HP+e3KTWwhEWvjpDFN8pOR9WMuzjxFaREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075090; c=relaxed/simple;
	bh=NWkBxd8gPCr+WPhzY0sd0MvcNJtL1sjwX5jg1KmL/vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoPl8ExSNAJMYkf4ul0hWmrmsIUDVPhQRO1jlgwvdNxlBUSyjTQaGmO8qEunAq54tWU09XTvwUANmp5T1nv0k36BepfwuZdVVikGCIEU+9Fhcgk2y2v7rM83HPybuqWwZEy6WfX4RvMAHBIEqesjK7sQRf9QWpH5Sf+wMGy8HKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ED+AuveV; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B386240002;
	Tue, 27 Feb 2024 23:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YzsgrX6QB8QR/FJbpPrgV15wrjsvOL5YD/IkQ9w8ApU=;
	b=ED+AuveVryI4A5M7J0Ddo1tmKy83fxllXO0YOpK/L+6dqVpXmtCbxAfbleP9mrxhuzoHCC
	kNtcFaNwNlaN2xeTqWSJ6iYJHCOQ/VGC5DzDPcEhRf8aaU1fJ/D6k8a9GAaeaieDMTTuAY
	Jdd/tVfZiDti6nYmrq3nCFjxCiVrrjzOyvIge0VPiJPLTsuJEid9madOh78uSt6+Yv+XVC
	mtlGWAlZMopG8ywGNExzzBoLncNglU9kpXS+n6lf+vjfaikb+9S6sjxVszBqMf81IemOw+
	hKYrHueQUm+SypQH35dnl7wcQsaya/rpWYVYBsW/6+V+qxmgTYDueyjmnOmepA==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] rtc: ds1511: drop dead code
Date: Wed, 28 Feb 2024 00:04:18 +0100
Message-ID: <20240227230431.1837717-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227230431.1837717-1-alexandre.belloni@bootlin.com>
References: <20240227230431.1837717-1-alexandre.belloni@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The watchdog part of the code is not reachable and should be reimplemented
properly as a watchdog driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 44 ----------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index a646bcf9cd56..fe8dbad51c88 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -122,50 +122,6 @@ rtc_enable_update(void)
 	rtc_write((rtc_read(RTC_CMD) | RTC_TE), RTC_CMD);
 }
 
-/*
- * #define DS1511_WDOG_RESET_SUPPORT
- *
- * Uncomment this if you want to use these routines in
- * some platform code.
- */
-#ifdef DS1511_WDOG_RESET_SUPPORT
-/*
- * just enough code to set the watchdog timer so that it
- * will reboot the system
- */
-void
-ds1511_wdog_set(unsigned long deciseconds)
-{
-	/*
-	 * the wdog timer can take 99.99 seconds
-	 */
-	deciseconds %= 10000;
-	/*
-	 * set the wdog values in the wdog registers
-	 */
-	rtc_write(bin2bcd(deciseconds % 100), DS1511_WD_MSEC);
-	rtc_write(bin2bcd(deciseconds / 100), DS1511_WD_SEC);
-	/*
-	 * set wdog enable and wdog 'steering' bit to issue a reset
-	 */
-	rtc_write(rtc_read(RTC_CMD) | DS1511_WDE | DS1511_WDS, RTC_CMD);
-}
-
-void
-ds1511_wdog_disable(void)
-{
-	/*
-	 * clear wdog enable and wdog 'steering' bits
-	 */
-	rtc_write(rtc_read(RTC_CMD) & ~(DS1511_WDE | DS1511_WDS), RTC_CMD);
-	/*
-	 * clear the wdog counter
-	 */
-	rtc_write(0, DS1511_WD_MSEC);
-	rtc_write(0, DS1511_WD_SEC);
-}
-#endif
-
 static int ds1511_rtc_set_time(struct device *dev, struct rtc_time *rtc_tm)
 {
 	u8 mon, day, dow, hrs, min, sec, yrs, cen;
-- 
2.43.0


