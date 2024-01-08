Return-Path: <linux-kernel+bounces-19024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F08266E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D643FB21081
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DDC1385;
	Mon,  8 Jan 2024 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K2Qf2H++"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47061800;
	Mon,  8 Jan 2024 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2C8040002;
	Mon,  8 Jan 2024 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704673818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qVtt9Z51WVizmklSojDBStset8GLJ3cHfn2WBgUbF8s=;
	b=K2Qf2H++p5e83SaS3+FtQPUoZ2T7TSgu9CIIsD5JfT6IOctItW64LHO2lKuSaVbsG3AXdZ
	63fig7MPtuG6uXeWWlas64brwCg6zynYGuEGI4ud54iRVPmecnBn9pvo0oSa7lHGdv/JHI
	ENgaltFHKzAkGt+C3m4h4tJ6u3PYrxIqcjFzz3lvxHElFvHY+6b2zCbV3MFhiRnwGGPT1T
	vpi+xT6rFrhEeRpQCnvj611vsrfIiwCYnG5Fwf+kcXxt/27qSQBqFeP58bUgmWB3HE8Y1y
	ohML5OE79Zu3KvLrz7xjtL8ciBuAqasIyG8QzNtWmISD2BLfVAmPN30MP/H2fQ==
From: alexandre.belloni@bootlin.com
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: rv8803: add wakeup-source support
Date: Mon,  8 Jan 2024 01:30:10 +0100
Message-ID: <20240108003010.599456-1-alexandre.belloni@bootlin.com>
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

The RV8803 can be wired directly to a PMIC that can wake up an SoC without
the CPU getting interrupts.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv8803.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 11e6b0d31f5d..1327251e527c 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -712,9 +712,12 @@ static int rv8803_probe(struct i2c_client *client)
 			if (err)
 				dev_err(&client->dev, "failed to set wake IRQ\n");
 		}
+	} else {
+		if (device_property_read_bool(&client->dev, "wakeup-source"))
+			device_init_wakeup(&client->dev, true);
+		else
+			clear_bit(RTC_FEATURE_ALARM, rv8803->rtc->features);
 	}
-	if (!client->irq)
-		clear_bit(RTC_FEATURE_ALARM, rv8803->rtc->features);
 
 	if (of_property_read_bool(client->dev.of_node, "epson,vdet-disable"))
 		rv8803->backup |= RX8900_FLAG_VDETOFF;
-- 
2.43.0


