Return-Path: <linux-kernel+bounces-84163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A995386A342
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC581F298D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4561B5788B;
	Tue, 27 Feb 2024 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k82xjWHa"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C89855E4A;
	Tue, 27 Feb 2024 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075096; cv=none; b=mkNPT2RA2w07vjbA7q2AjxoN2yuoDy9y3wASTPoCuPrsd35JgiiyR2KKGWpGDcSHj7lHT3YEJcLjRNqVYUpxvzQM2PrYTKxaklKP7yRjUwfBZvm+C9vwoPSHyonHTzMthizF73yoGEMSowCVeSMVpfxbkuC5YsLaG60DPF136YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075096; c=relaxed/simple;
	bh=pMzSdaErP8NPLXtz6xhrVDn4qQePKxsiyZ6Ly0n1m5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rysy3s9m6G4IuIyfjN9ZEEAmQF360x2RJn+nwC2+nhfOVvwqzkMlM6NVlkUdFSh7CAfeV+n0oJkt01sMBHmTYAwH8lvjKpBS+kgcBlH1z18cNDicrOWV021geo7WZS+2BviGXTmfdkAZRW2oFSZZJWNtGv8hNQm7b1ijFpSrWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k82xjWHa; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F6A02000A;
	Tue, 27 Feb 2024 23:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0oCCqgbDNckwzzWB2/8wbNi9Lkx4ZYUoUR+aHvjFFc=;
	b=k82xjWHaT+/rIHOsPxPVhSnXY1SokLqybMCDM+ttcFdUbA/GXp0tDgWncwdPbANCQB5muX
	S3TkXNXhUgAa1/xdFDYv+QDJJFAfSQlcDJn1oYyP3mc4XVjjAq+6JYugmOHNl00NqPkc3J
	yheoA2QCgsZa+lh0flN6nI7h3k9m/50RBkeAjBXLZct830U/vKc2U25qTuxViZ0y6pkIz5
	vEIGzgkwGVSuytlK+mUwTOcsgtGo/fYfIOHUV29XbiOO1dSu/1abKd8w45eADXmVib69gm
	daU7B62MCtS/kCB0pTfG/weNQWJ7wqZ2LsogHH5i4SvQkE1+puRaANWQI8wC6g==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] rtc: ds1511: fix function definition
Date: Wed, 28 Feb 2024 00:04:20 +0100
Message-ID: <20240227230431.1837717-5-alexandre.belloni@bootlin.com>
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

Use proper style for function definition.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 8e57c1395cf3..1765f76dda58 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -76,26 +76,22 @@ static DEFINE_SPINLOCK(ds1511_lock);
 static __iomem char *ds1511_base;
 static u32 reg_spacing = 1;
 
-static noinline void
-rtc_write(uint8_t val, uint32_t reg)
+static noinline void rtc_write(uint8_t val, uint32_t reg)
 {
 	writeb(val, ds1511_base + (reg * reg_spacing));
 }
 
-static noinline uint8_t
-rtc_read(uint32_t reg)
+static noinline uint8_t rtc_read(uint32_t reg)
 {
 	return readb(ds1511_base + (reg * reg_spacing));
 }
 
-static inline void
-rtc_disable_update(void)
+static inline void rtc_disable_update(void)
 {
 	rtc_write((rtc_read(DS1511_CONTROL_B) & ~DS1511_TE), DS1511_CONTROL_B);
 }
 
-static void
-rtc_enable_update(void)
+static void rtc_enable_update(void)
 {
 	rtc_write((rtc_read(DS1511_CONTROL_B) | DS1511_TE), DS1511_CONTROL_B);
 }
@@ -190,8 +186,7 @@ static int ds1511_rtc_read_time(struct device *dev, struct rtc_time *rtc_tm)
  * date/hours/mins/secs matches.  the ds1511 has many more
  * permutations, but the kernel doesn't.
  */
-static void
-ds1511_rtc_update_alarm(struct rtc_plat_data *pdata)
+static void ds1511_rtc_update_alarm(struct rtc_plat_data *pdata)
 {
 	unsigned long flags;
 
@@ -213,8 +208,7 @@ ds1511_rtc_update_alarm(struct rtc_plat_data *pdata)
 	spin_unlock_irqrestore(&pdata->lock, flags);
 }
 
-static int
-ds1511_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+static int ds1511_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
@@ -232,8 +226,7 @@ ds1511_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	return 0;
 }
 
-static int
-ds1511_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+static int ds1511_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
@@ -248,8 +241,7 @@ ds1511_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	return 0;
 }
 
-static irqreturn_t
-ds1511_interrupt(int irq, void *dev_id)
+static irqreturn_t ds1511_interrupt(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-- 
2.43.0


