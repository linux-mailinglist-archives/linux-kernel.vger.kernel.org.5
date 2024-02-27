Return-Path: <linux-kernel+bounces-84168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C975E86A351
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93AAAB261F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EE658ACB;
	Tue, 27 Feb 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NR7gD8u7"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFFF58AB9;
	Tue, 27 Feb 2024 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075107; cv=none; b=OWRfMpgWb2WAC9LEMvLFQ2rLmGcElzTFWWffrnC0HuLpsNQQcnc2/276rvAlMYRTnkx9xyCVqXMklxDRslxu7s0dPrmZPFTzo8XeL7dXXNTkUrV9JBWJIWyMMvK7Of+VcTv/x39tvnMc9M7P7Lp2cLjMGOmDfVENx8Iz7CcuE34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075107; c=relaxed/simple;
	bh=gEa1QXDhcqfFS34hD+AU6YBCOa3UzXEwA23LdIpq4Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6DwJD4VlnzAK+YEFoCjDHR7wjVVnxvQ0QTQZkCC/Cd7Zpbl8D8qbfZu47blRtscGwHSjCopOXO7aIsy9PMYOhFneedYFHEaOROxJ7E6H/dcxvn47VKkwRVmZFV2A8Yuay3dTeY7Z6Qsq7p2hNwOsCEktZZA9Ly0v6tD3TmsjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NR7gD8u7; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0199FFF802;
	Tue, 27 Feb 2024 23:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYoZhGgebEeKeaaUKnQEZonlz+9SDLCeUb72d1lfySo=;
	b=NR7gD8u7Kgxy0hk2plrkquMxvTLfqlRBnz5w4eSjMJRpYAH9fGp7Kg/ET7VwFVugVYxDUt
	f0NihIVlAsgb+kjttkQa2DYwddMIybEtyOiFvUAQVXYhpa4ipGYX3yxq2MVTUXqd7zU9Vw
	rQ+yem4e3dZk1Pv/G/gxR2dXHetSCdolm0me6BpHqkDC2IXB/FMwDGEHf8zkJo1JGqUm9+
	iKX+7jA4qSUR+5d0Kdl61SDs84nDLymO9TLfC22pVL2oGRnJ7yU+HPIoQGQPWQyPUvzVn6
	eEDABVenWsc7bipXX1kexZ2hEgAmsGVwpnhgXWTSPXStWm7Fmpf5zXTLQ+4LKA==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] rtc: ds1511: implement ds1511_rtc_read_alarm properly
Date: Wed, 28 Feb 2024 00:04:25 +0100
Message-ID: <20240227230431.1837717-10-alexandre.belloni@bootlin.com>
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

ds1511_rtc_read_alarm was useless as it is only called at boot time so
the alarm members of pdata have not yet been set. Read the actual registers
so there is a chance to get a meaningful value.

Then, drop the alarm related members of pdata as they are not used anymore.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index d5d59a948c59..c3b1376b731f 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -63,11 +63,6 @@ struct rtc_plat_data {
 	struct rtc_device *rtc;
 	void __iomem *ioaddr;		/* virtual base address */
 	int irq;
-	unsigned int irqen;
-	int alrm_sec;
-	int alrm_min;
-	int alrm_hour;
-	int alrm_mday;
 	spinlock_t lock;
 };
 
@@ -188,18 +183,11 @@ static int ds1511_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	pdata->alrm_mday = alrm->time.tm_mday;
-	pdata->alrm_hour = alrm->time.tm_hour;
-	pdata->alrm_min = alrm->time.tm_min;
-	pdata->alrm_sec = alrm->time.tm_sec;
-	if (alrm->enabled)
-		pdata->irqen |= RTC_AF;
-
 	spin_lock_irqsave(&pdata->lock, flags);
-	rtc_write(bin2bcd(pdata->alrm_mday) & 0x3f, DS1511_AM4_DATE);
-	rtc_write(bin2bcd(pdata->alrm_hour) & 0x3f, DS1511_AM3_HOUR);
-	rtc_write(bin2bcd(pdata->alrm_min) & 0x7f, DS1511_AM2_MIN);
-	rtc_write(bin2bcd(pdata->alrm_sec) & 0x7f, DS1511_AM1_SEC);
+	rtc_write(bin2bcd(alrm->time.tm_mday) & 0x3f, DS1511_AM4_DATE);
+	rtc_write(bin2bcd(alrm->time.tm_hour) & 0x3f, DS1511_AM3_HOUR);
+	rtc_write(bin2bcd(alrm->time.tm_min) & 0x7f, DS1511_AM2_MIN);
+	rtc_write(bin2bcd(alrm->time.tm_sec) & 0x7f, DS1511_AM1_SEC);
 	ds1511_rtc_alarm_enable(alrm->enabled);
 
 	rtc_read(DS1511_CONTROL_A);	/* clear interrupts */
@@ -210,13 +198,12 @@ static int ds1511_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int ds1511_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
+	alrm->time.tm_mday = bcd2bin(rtc_read(DS1511_AM4_DATE) & 0x3f);
+	alrm->time.tm_hour = bcd2bin(rtc_read(DS1511_AM3_HOUR) & 0x3f);
+	alrm->time.tm_min = bcd2bin(rtc_read(DS1511_AM2_MIN) & 0x7f);
+	alrm->time.tm_sec = bcd2bin(rtc_read(DS1511_AM1_SEC) & 0x7f);
+	alrm->enabled = !!(rtc_read(DS1511_CONTROL_B) & DS1511_TIE);
 
-	alrm->time.tm_mday = pdata->alrm_mday < 0 ? 0 : pdata->alrm_mday;
-	alrm->time.tm_hour = pdata->alrm_hour < 0 ? 0 : pdata->alrm_hour;
-	alrm->time.tm_min = pdata->alrm_min < 0 ? 0 : pdata->alrm_min;
-	alrm->time.tm_sec = pdata->alrm_sec < 0 ? 0 : pdata->alrm_sec;
-	alrm->enabled = (pdata->irqen & RTC_AF) ? 1 : 0;
 	return 0;
 }
 
-- 
2.43.0


