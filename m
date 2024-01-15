Return-Path: <linux-kernel+bounces-26526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FB882E33A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EC2283B59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EB71B7ED;
	Mon, 15 Jan 2024 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RTFGw23B"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2C1AADB;
	Mon, 15 Jan 2024 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6919D240003;
	Mon, 15 Jan 2024 23:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705360940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0t7+FP/+mQFoKBOTbHR2wVStwAOI2dnROp2npalSLyE=;
	b=RTFGw23BA2qfjFX8tCbOVWqGgpdpN3zsi+iD98iSIbyJqySkD8EO7lsw3BRlfTJAAeyCas
	ZuQykBVOy3Su46f//E5L2qV9C6rp+vQh/BM6uSA5mPsFcQPzZ+c4wJSWsqOMLP8D3kO1cr
	MXssSafMCDDjWkqW/J7SkblFWuGI79JCjy5hrMBposskrk+tCP1g9+YY/NKD0qV8FiZA3d
	grUmJC69IsUm82V6c/x1wV2387gqJfrgXdR2mvpXYzplWku4lopntj7tzl9vkqLDVpEQ6m
	EhuFFg9moNssSqG3ThYCwhvl47Gs3bFB668yo0VRxEQGktz1RisEaQkV4VqxWw==
From: alexandre.belloni@bootlin.com
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: max31335: remove unecessary locking
Date: Tue, 16 Jan 2024 00:22:13 +0100
Message-ID: <20240115232215.273374-1-alexandre.belloni@bootlin.com>
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

There is no race condition when accessing MAX31335_STATUS1 because it is
always about clearing the alarm interrupt bit.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-max31335.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
index 3ddfe71bbb56..2ce23f60a7f3 100644
--- a/drivers/rtc/rtc-max31335.c
+++ b/drivers/rtc/rtc-max31335.c
@@ -348,27 +348,19 @@ static int max31335_alarm_irq_enable(struct device *dev, unsigned int enabled)
 static irqreturn_t max31335_handle_irq(int irq, void *dev_id)
 {
 	struct max31335_data *max31335 = dev_id;
-	struct mutex *lock = &max31335->rtc->ops_lock;
 	int ret, status;
 
-	mutex_lock(lock);
-
 	ret = regmap_read(max31335->regmap, MAX31335_STATUS1, &status);
 	if (ret)
-		goto exit;
+		return IRQ_HANDLED;
 
 	if (FIELD_GET(MAX31335_STATUS1_A1F, status)) {
-		ret = regmap_update_bits(max31335->regmap, MAX31335_STATUS1,
-					 MAX31335_STATUS1_A1F, 0);
-		if (ret)
-			goto exit;
+		regmap_update_bits(max31335->regmap, MAX31335_STATUS1,
+				   MAX31335_STATUS1_A1F, 0);
 
 		rtc_update_irq(max31335->rtc, 1, RTC_AF | RTC_IRQF);
 	}
 
-exit:
-	mutex_unlock(lock);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.43.0


