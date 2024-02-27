Return-Path: <linux-kernel+bounces-84166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2B886A348
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A6D1F268CD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA9858230;
	Tue, 27 Feb 2024 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SZHfRTgi"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECDB5812A;
	Tue, 27 Feb 2024 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075102; cv=none; b=RrNVyuX3dnoY3ls8j5mx3EZP/kNxHwIU4admSpSwivjawupR32cw6+smLQp4iVMLbQLag1HGxutSBWyclfeo2u3cE5mP6tdxmjApuj9KZT3M8dw7H9lPgUFwbDaUyYIojIP4GTodeBPdsBmN26Q6f5P943kajasDO5c8iO2Y3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075102; c=relaxed/simple;
	bh=kmIa/7ZyXqprHqUEcR3GU7DrR4potHZgTHFoWWOaR2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rz/4RDSbThoVwbHhTuAvVjfCJACUeGQldhVJKx0IhmMBYrvQMzPu5zUzn3kBxtDunzj4pcS79c8nzdb96Uz6gMYAQCC5XQYLvgyuxt88RS3Sybv9qOitkiC/vSD7Nl0OqNUTwEAEGHs+aivbpMluw4l6Q5xSUsJbJfpYAY+bRp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SZHfRTgi; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A8B5240002;
	Tue, 27 Feb 2024 23:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qy0P0eoIU4XbXDbSBcw570en4VCa8cKPG47nuLjP76M=;
	b=SZHfRTgijYjEX3jiJpI9nV6GBM9BCV9lNcBt4nnks9upNXszaeDgvfyX6A0dKC2EAvwjnn
	ujUuQCTIW3HL9dtcW239WPcfhWSSQRFG2Un7NnkT1LX8tY38JIvqW5nSjY2sr9MI952Luc
	nZ/PVAlm4G7aX8yFBGPEQMDfJDOBqYC9Za1L8lkWseRMT5KmzOzY539h8m6zl4ZF6Dk28I
	mZu06hutJW2o1efSnqag2XZbNj02lssBCXXpZoVyKbaPFh4vvhc/pDJdFEV61HfMDiKoa7
	SknrTNRRfu7z59BEWvZOXSRuTHerOWg7/fKAatZFnB6nRe30in3uT1wnc8AyQw==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] rtc: ds1511: let the core know when alarm are not supported
Date: Wed, 28 Feb 2024 00:04:23 +0100
Message-ID: <20240227230431.1837717-8-alexandre.belloni@bootlin.com>
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

Instead of failing function calls, let the core know alarms are not
supported so it can fail early and avoid unnecessary calls.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index b0dfdda2c8fc..c81f464e6a50 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -188,9 +188,6 @@ static int ds1511_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	if (pdata->irq <= 0)
-		return -EINVAL;
-
 	pdata->alrm_mday = alrm->time.tm_mday;
 	pdata->alrm_hour = alrm->time.tm_hour;
 	pdata->alrm_min = alrm->time.tm_min;
@@ -219,9 +216,6 @@ static int ds1511_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 
-	if (pdata->irq <= 0)
-		return -EINVAL;
-
 	alrm->time.tm_mday = pdata->alrm_mday < 0 ? 0 : pdata->alrm_mday;
 	alrm->time.tm_hour = pdata->alrm_hour < 0 ? 0 : pdata->alrm_hour;
 	alrm->time.tm_min = pdata->alrm_min < 0 ? 0 : pdata->alrm_min;
@@ -253,9 +247,6 @@ static int ds1511_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	if (pdata->irq <= 0)
-		return -EINVAL;
-
 	spin_lock_irqsave(&pdata->lock, flags);
 	ds1511_rtc_alarm_enable(enabled);
 	spin_unlock_irqrestore(&pdata->lock, flags);
@@ -349,12 +340,6 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 
 	pdata->rtc->ops = &ds1511_rtc_ops;
 
-	ret = devm_rtc_register_device(pdata->rtc);
-	if (ret)
-		return ret;
-
-	devm_rtc_nvmem_register(pdata->rtc, &ds1511_nvmem_cfg);
-
 	/*
 	 * if the platform has an interrupt in mind for this device,
 	 * then by all means, set it
@@ -369,6 +354,15 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (pdata->irq == 0)
+		clear_bit(RTC_FEATURE_ALARM, pdata->rtc->features);
+
+	ret = devm_rtc_register_device(pdata->rtc);
+	if (ret)
+		return ret;
+
+	devm_rtc_nvmem_register(pdata->rtc, &ds1511_nvmem_cfg);
+
 	return 0;
 }
 
-- 
2.43.0


