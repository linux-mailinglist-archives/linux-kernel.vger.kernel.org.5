Return-Path: <linux-kernel+bounces-84164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B9486A344
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D181C25CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D51E5810C;
	Tue, 27 Feb 2024 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fbcqfqeO"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9157888;
	Tue, 27 Feb 2024 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075097; cv=none; b=Z19m7hlAL6RPuguWjxZCt9Bsrol+pC6qLRLtfhLu90Sdhsa/uo5qTRfUxLFyUzgUqZsdJGhJBdKfa2X/89YglJfmGKp6M/Lg8g8LI9mldGwNEQ1x88qpfeTZ34ccGZQD9ZXw/VqoR1n3cbHVdnNtdMbCi9svxu1Rp190pihJTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075097; c=relaxed/simple;
	bh=Z5TKAsNiHmdmVINp1aOXSgDG6r+4tRJgppAteMXtRe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioltzSjTksyHoILriCSu88dWjGn/NrkRqk1nx0xTT+xWeeVHRU3cWrc7vxnN7X5qBkzexUqRsVLxdWcx6WwuiMT46AnYKgvfqotA5BVZdueekFyiBsxiJ2WeAsEpLyfQuxu122QWW8ryodH5eoykvzYfl/IvuxnFleumpa7XILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fbcqfqeO; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D496BE0002;
	Tue, 27 Feb 2024 23:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVL6nQVxi6BF3G6V5+OIAknkxYVXO9rdhZjmxMpGBcQ=;
	b=fbcqfqeO4Ziiu/q2ew83aC5CrrErZN1FgUxtM3bJasOYtUJ1FdBPHKs2JilbcuGPVG/Bvr
	PTwFe5suTSSsTNzyjIHOIBhR1XLEUk5hwvE0wmxZT9CNAIxCRzdUVG1yhDfXQOG7XZbGdo
	vYDxgCuYDX+YJqoElvOivuag/K7UsTQAU5Z7fobxqNFmH8WHPqRUypEjv9LQuFLYqWk+3O
	xh4VPmshZXlsdFhXjysbgHL8xV6GvG9CEAAn8OUzwAHCHgwuf3CzXt4w3T5VM871A+b5vi
	Zy2i6jcAX7zCT9Z7O8jvuvNtVRlHxq/WlLQHfz4qJS0qOvSzPRpEQaHtEfdmjw==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] rtc: ds1511: remove incomplete UIE support
Date: Wed, 28 Feb 2024 00:04:21 +0100
Message-ID: <20240227230431.1837717-6-alexandre.belloni@bootlin.com>
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

There is no way to enable UIE in the driver, drop RTC_UF support.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 1765f76dda58..4ac8988d4124 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -191,17 +191,13 @@ static void ds1511_rtc_update_alarm(struct rtc_plat_data *pdata)
 	unsigned long flags;
 
 	spin_lock_irqsave(&pdata->lock, flags);
-	rtc_write(pdata->alrm_mday < 0 || (pdata->irqen & RTC_UF) ?
-	       0x80 : bin2bcd(pdata->alrm_mday) & 0x3f,
+	rtc_write(pdata->alrm_mday < 0 ? 0x80 : bin2bcd(pdata->alrm_mday) & 0x3f,
 	       DS1511_AM4_DATE);
-	rtc_write(pdata->alrm_hour < 0 || (pdata->irqen & RTC_UF) ?
-	       0x80 : bin2bcd(pdata->alrm_hour) & 0x3f,
+	rtc_write(pdata->alrm_hour < 0 ? 0x80 : bin2bcd(pdata->alrm_hour) & 0x3f,
 	       DS1511_AM3_HOUR);
-	rtc_write(pdata->alrm_min < 0 || (pdata->irqen & RTC_UF) ?
-	       0x80 : bin2bcd(pdata->alrm_min) & 0x7f,
+	rtc_write(pdata->alrm_min < 0 ? 0x80 : bin2bcd(pdata->alrm_min) & 0x7f,
 	       DS1511_AM2_MIN);
-	rtc_write(pdata->alrm_sec < 0 || (pdata->irqen & RTC_UF) ?
-	       0x80 : bin2bcd(pdata->alrm_sec) & 0x7f,
+	rtc_write(pdata->alrm_sec < 0 ? 0x80 : bin2bcd(pdata->alrm_sec) & 0x7f,
 	       DS1511_AM1_SEC);
 	rtc_write(rtc_read(DS1511_CONTROL_B) | (pdata->irqen ? DS1511_TIE : 0), DS1511_CONTROL_B);
 	rtc_read(DS1511_CONTROL_A);	/* clear interrupts */
@@ -252,11 +248,7 @@ static irqreturn_t ds1511_interrupt(int irq, void *dev_id)
 	 * read and clear interrupt
 	 */
 	if (rtc_read(DS1511_CONTROL_A) & DS1511_IRQF) {
-		events = RTC_IRQF;
-		if (rtc_read(DS1511_AM1_SEC) & 0x80)
-			events |= RTC_UF;
-		else
-			events |= RTC_AF;
+		events = RTC_IRQF | RTC_AF;
 		rtc_update_irq(pdata->rtc, 1, events);
 	}
 	spin_unlock(&pdata->lock);
-- 
2.43.0


