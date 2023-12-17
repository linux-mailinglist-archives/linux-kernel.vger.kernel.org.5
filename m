Return-Path: <linux-kernel+bounces-2860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F398162F2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BDF1F21B49
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1747749F98;
	Sun, 17 Dec 2023 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kifrvNde"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288349F7A;
	Sun, 17 Dec 2023 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71F9760004;
	Sun, 17 Dec 2023 22:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702853924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IQbh91Xrwj+XG2jTq6iRDOWVcyvbuHgrs5HvatgUSrc=;
	b=kifrvNde1i9hU4dFxuMgi3J68tZjl0w+EDtS+r3gkeQib1fNBg4aB9MiEgyYciX0wwDJO/
	s6iZbG/YqmCSSv05N8ycNST70qJNOimGJngBNtXtwlgdSZYRTi495rzjiJRKPiEUiHhCKj
	FGYYmYMIldfQa9ofSTLAwa1ps2hTwlafU8wwvg6U8kDSoZrdFQ5sPTQyKMX8uiiXvsEDQV
	F041+y/4yeFBxBvMuB3xvU2YQZjteTO543LG94evexntcqfVzEGYTMRnArZQp6nMLJEvGJ
	nRE9bnqVRsBxYhKX7m/OOod4+6orcABZW69UDXb6sw7uA4sGkDj71+3tB8VMKw==
From: alexandre.belloni@bootlin.com
To: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: ma35d1: remove hardcoded UIE support
Date: Sun, 17 Dec 2023 23:58:31 +0100
Message-ID: <20231217225831.48581-1-alexandre.belloni@bootlin.com>
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

Let the core handle UIE instead of enabling it forcefully at probe which
means the RTC will generate an interrupt every second even when nobody
cares.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ma35d1.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/rtc/rtc-ma35d1.c b/drivers/rtc/rtc-ma35d1.c
index 07c9a083a9d5..cfcfc28060f6 100644
--- a/drivers/rtc/rtc-ma35d1.c
+++ b/drivers/rtc/rtc-ma35d1.c
@@ -79,11 +79,6 @@ static irqreturn_t ma35d1_rtc_interrupt(int irq, void *data)
 		events |= RTC_AF | RTC_IRQF;
 	}
 
-	if (rtc_irq & RTC_INTSTS_UIF) {
-		rtc_reg_write(rtc, MA35_REG_RTC_INTSTS, RTC_INTSTS_UIF);
-		events |= RTC_UF | RTC_IRQF;
-	}
-
 	rtc_update_irq(rtc->rtcdev, 1, events);
 
 	return IRQ_HANDLED;
@@ -216,7 +211,6 @@ static int ma35d1_rtc_probe(struct platform_device *pdev)
 {
 	struct ma35_rtc *rtc;
 	struct clk *clk;
-	u32 regval;
 	int ret;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
@@ -264,40 +258,26 @@ static int ma35d1_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register rtc device\n");
 
-	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
-	regval |= RTC_INTEN_UIEN;
-	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
-
 	return 0;
 }
 
 static int ma35d1_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
-	u32 regval;
 
 	if (device_may_wakeup(&pdev->dev))
 		enable_irq_wake(rtc->irq_num);
 
-	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
-	regval &= ~RTC_INTEN_UIEN;
-	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
-
 	return 0;
 }
 
 static int ma35d1_rtc_resume(struct platform_device *pdev)
 {
 	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
-	u32 regval;
 
 	if (device_may_wakeup(&pdev->dev))
 		disable_irq_wake(rtc->irq_num);
 
-	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
-	regval |= RTC_INTEN_UIEN;
-	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
-
 	return 0;
 }
 
-- 
2.43.0


