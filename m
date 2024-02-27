Return-Path: <linux-kernel+bounces-84165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E205D86A346
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C87C290121
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECF858203;
	Tue, 27 Feb 2024 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PPlYHwQh"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCB758106;
	Tue, 27 Feb 2024 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075100; cv=none; b=YlLYozk42eG0dVBsKZkxgbfWTVaHHIvont/zAXCIEtZOe5XD/6Ym461FugABNY/dcYZn8ttpZTDgUmoxzhMWTzbnxpst9N0LwVOq97zzpDKPq22tZbE5WZnQtCFZ0Zux0sV5lbV23XWaUjjZ/YeW+Z8cBDQHJptlW8IT5hwg+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075100; c=relaxed/simple;
	bh=+TeOoQ8/EabvacRrcZs7lP1c51rVOFxgFfe2Z7f9Dyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXx/rKsPfErbgLWRXISxjwrPwt/D4Fw+LtirxVNgESKOfrzx0gRE1FQyczsF6i3fRePQrdMy2vyu/YWhJJaCzy83R/YCOZCtRHvaQh0dUJArxsLTWB8q5B1+cSiaA6JsJRVjOxPwVC42aZf/qyp6MdP7ja9KakV67PYYdsQ4Lq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PPlYHwQh; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A6F41C0003;
	Tue, 27 Feb 2024 23:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDg0owEF3xlOehCDIXIEw25/GVMd5SHRx8SLPbdFUxk=;
	b=PPlYHwQhknBlH6gzirfTHj3elUM7xQH0GVQfaAYNWr7FoeK2m9wi0qWPeCGdyol0Y8YgPI
	6r5YyfsLd7nlyJLocw/unOcKlu3X9j/FanTf1N6KCZ8bt4/pG0ZV6TB2nGyRAABaxefekR
	WK9h8gzHRovivTIWZ/7FDj9uxN1lnWfngkiVZtAIdvfEMLxuf39GT5LjEdbL2G5EWqqUAv
	Gv9k3XqsDbpr2QO7DWm35/g0zqX9DiLMtwSRAAj2Q/zMYEU1NeMRvt6fsXFzNt7c4yEaFV
	D3OyIbG/rrjbkKUeIYXhdDpryAPEcZqSyDM80RKxFN1/NCvWN8iaDa4moCzvbg==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] rtc: ds1511: remove ds1511_rtc_update_alarm
Date: Wed, 28 Feb 2024 00:04:22 +0100
Message-ID: <20240227230431.1837717-7-alexandre.belloni@bootlin.com>
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

ds1511_rtc_update_alarm is called twice but one of the call is overkill as
it only has to enable or disable the alarm instead of updating all the alarm
registers. Merge it in its main call site and introduce a new finction to
enable or disable the alarm.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 52 ++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 4ac8988d4124..b0dfdda2c8fc 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -178,35 +178,15 @@ static int ds1511_rtc_read_time(struct device *dev, struct rtc_time *rtc_tm)
 	return 0;
 }
 
-/*
- * write the alarm register settings
- *
- * we only have the use to interrupt every second, otherwise
- * known as the update interrupt, or the interrupt if the whole
- * date/hours/mins/secs matches.  the ds1511 has many more
- * permutations, but the kernel doesn't.
- */
-static void ds1511_rtc_update_alarm(struct rtc_plat_data *pdata)
+static void ds1511_rtc_alarm_enable(unsigned int enabled)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&pdata->lock, flags);
-	rtc_write(pdata->alrm_mday < 0 ? 0x80 : bin2bcd(pdata->alrm_mday) & 0x3f,
-	       DS1511_AM4_DATE);
-	rtc_write(pdata->alrm_hour < 0 ? 0x80 : bin2bcd(pdata->alrm_hour) & 0x3f,
-	       DS1511_AM3_HOUR);
-	rtc_write(pdata->alrm_min < 0 ? 0x80 : bin2bcd(pdata->alrm_min) & 0x7f,
-	       DS1511_AM2_MIN);
-	rtc_write(pdata->alrm_sec < 0 ? 0x80 : bin2bcd(pdata->alrm_sec) & 0x7f,
-	       DS1511_AM1_SEC);
-	rtc_write(rtc_read(DS1511_CONTROL_B) | (pdata->irqen ? DS1511_TIE : 0), DS1511_CONTROL_B);
-	rtc_read(DS1511_CONTROL_A);	/* clear interrupts */
-	spin_unlock_irqrestore(&pdata->lock, flags);
+	rtc_write(rtc_read(DS1511_CONTROL_B) | (enabled ? DS1511_TIE : 0), DS1511_CONTROL_B);
 }
 
 static int ds1511_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
+	unsigned long flags;
 
 	if (pdata->irq <= 0)
 		return -EINVAL;
@@ -218,7 +198,20 @@ static int ds1511_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (alrm->enabled)
 		pdata->irqen |= RTC_AF;
 
-	ds1511_rtc_update_alarm(pdata);
+	spin_lock_irqsave(&pdata->lock, flags);
+	rtc_write(pdata->alrm_mday < 0 ? 0x80 : bin2bcd(pdata->alrm_mday) & 0x3f,
+	       DS1511_AM4_DATE);
+	rtc_write(pdata->alrm_hour < 0 ? 0x80 : bin2bcd(pdata->alrm_hour) & 0x3f,
+	       DS1511_AM3_HOUR);
+	rtc_write(pdata->alrm_min < 0 ? 0x80 : bin2bcd(pdata->alrm_min) & 0x7f,
+	       DS1511_AM2_MIN);
+	rtc_write(pdata->alrm_sec < 0 ? 0x80 : bin2bcd(pdata->alrm_sec) & 0x7f,
+	       DS1511_AM1_SEC);
+	ds1511_rtc_alarm_enable(alrm->enabled);
+
+	rtc_read(DS1511_CONTROL_A);	/* clear interrupts */
+	spin_unlock_irqrestore(&pdata->lock, flags);
+
 	return 0;
 }
 
@@ -258,14 +251,15 @@ static irqreturn_t ds1511_interrupt(int irq, void *dev_id)
 static int ds1511_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
+	unsigned long flags;
 
 	if (pdata->irq <= 0)
 		return -EINVAL;
-	if (enabled)
-		pdata->irqen |= RTC_AF;
-	else
-		pdata->irqen &= ~RTC_AF;
-	ds1511_rtc_update_alarm(pdata);
+
+	spin_lock_irqsave(&pdata->lock, flags);
+	ds1511_rtc_alarm_enable(enabled);
+	spin_unlock_irqrestore(&pdata->lock, flags);
+
 	return 0;
 }
 
-- 
2.43.0


