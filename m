Return-Path: <linux-kernel+bounces-26527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F7282E33C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B581C221FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401001B7F5;
	Mon, 15 Jan 2024 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oKaeMWgN"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AAE1B7E0;
	Mon, 15 Jan 2024 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1229E240004;
	Mon, 15 Jan 2024 23:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705360941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZoQRbudR0nr1ST4F7AMUIQKL7EqS+GqfmQTeUc6QIo=;
	b=oKaeMWgN2U9zyL8KCCc6vNlnMxv6Ju6RPulN0NB8l9Nsu92PSH/kHAmc+22HC0HS7Hxi2H
	wgQkaV3Z5wdSetHfxSe+g/+2xXpUin7PdoQgFBtSVWkHfj7Askk+orH8qG5rvzl4UKUcQy
	DB329L8FadlEF8APxitAWWg1ez5B+U8k6eVkLJyaTThatErwF36Lg5G+ffy3JEjV4PBK/t
	J1Q9W8qnLVR3oc4GQ4r/IE1NPCkEaSWb0uGq9/8sDO892d/5G9u/k+aVdjapdyzIn4RV7k
	9n6PKgmmQHZZLewFiAuvpdt+xXFb8RtDuQ0awGXuKPGtkR2yRIK3948p3u2qKw==
From: alexandre.belloni@bootlin.com
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtc: max31335: use regmap_update_bits_check
Date: Tue, 16 Jan 2024 00:22:14 +0100
Message-ID: <20240115232215.273374-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232215.273374-1-alexandre.belloni@bootlin.com>
References: <20240115232215.273374-1-alexandre.belloni@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Simplify the IRQ handler by using regmap_update_bits_check.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-max31335.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
index 2ce23f60a7f3..a38d303d9df4 100644
--- a/drivers/rtc/rtc-max31335.c
+++ b/drivers/rtc/rtc-max31335.c
@@ -348,18 +348,16 @@ static int max31335_alarm_irq_enable(struct device *dev, unsigned int enabled)
 static irqreturn_t max31335_handle_irq(int irq, void *dev_id)
 {
 	struct max31335_data *max31335 = dev_id;
-	int ret, status;
+	bool status;
+	int ret;
 
-	ret = regmap_read(max31335->regmap, MAX31335_STATUS1, &status);
+	ret = regmap_update_bits_check(max31335->regmap, MAX31335_STATUS1,
+				       MAX31335_STATUS1_A1F, 0, &status);
 	if (ret)
 		return IRQ_HANDLED;
 
-	if (FIELD_GET(MAX31335_STATUS1_A1F, status)) {
-		regmap_update_bits(max31335->regmap, MAX31335_STATUS1,
-				   MAX31335_STATUS1_A1F, 0);
-
+	if (status)
 		rtc_update_irq(max31335->rtc, 1, RTC_AF | RTC_IRQF);
-	}
 
 	return IRQ_HANDLED;
 }
-- 
2.43.0


