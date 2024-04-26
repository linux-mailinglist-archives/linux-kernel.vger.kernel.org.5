Return-Path: <linux-kernel+bounces-160759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C19D8B426E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425D61F224F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35BB3A1B7;
	Fri, 26 Apr 2024 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cpHqITMH"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25503987D;
	Fri, 26 Apr 2024 22:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714172317; cv=none; b=WDiQ9CYJa8sXymTBnehNCy8nphF/rTZ+wXmjcBYW2054dfvMINdGEL5geShoEaBZNetjwu8xq52jsR8Kc0K1NbolJ1LDeU65ENqNOMr76OyhW+8/TRAUb2lfAGf99HX9ndY2AwmpLM9ueZrK05RVCeSfxI9nZjNG7+HJKFoDEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714172317; c=relaxed/simple;
	bh=R0PXi5BpxTvbIeMG6WGSdqMAjrlasJh2Yznaym73TCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEWxLQSo4Vvo/NH1qnql+H8NYbekpYvgjtVD5vxlPFY4ZFGRuUIxJym4IdPY/gaOGzxPGG/UWT5jM1jMeB2SQyoVKOlMlZ6eNX2/8MCcE+0TD+HdbqbcetMXNjp7G1MwWopFqv+oyX+xUEwYgAa/LIzCneONCSqEUPW9DCbeC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cpHqITMH; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59D14240002;
	Fri, 26 Apr 2024 22:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714172307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e5EJs5OFkMMXkOQseHxFbsNg9C5+grICpRc78loD/PQ=;
	b=cpHqITMHeOEzVRUDjQbpOXDU6jwoQKHRfmG+uy9dodK8w3hWC6V3XKZoYoDUtr07y5E/53
	Ap9ddkRAofy3uzH2yApsS2SW7Wga5ueYu8SA2JrkBhI0bps/SNk3toDo/F9eRTAUVuYyfS
	1cAjl/guJk864hVWMJNY7HBWXjlTgZ3LXYSldND/tasOJEBCescevt2SSLTuzYcVCTNola
	OGa+9oGe+sVGxKpBZG91a8br97veKyw0BErv6nsiP79LR4bRRwHQ2YaGaxpcJTDiACGuBl
	qViJnWNxUvGOyJLEK15fGLR1sU5wBLkKo1RnBE06S0dgzVR5RLoYM9kjtF8TAQ==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pcf8563: add wakeup-source support
Date: Sat, 27 Apr 2024 00:58:21 +0200
Message-ID: <20240426225821.448963-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

In some platforms, the RTC is able to wake up the system but is not
directly connected to an IRQ. Add wakeup-source property support to be able
to express this in the Device Tree.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf8563.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index ea82b89d8929..1949d7473310 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -527,7 +527,6 @@ static int pcf8563_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, pcf8563);
 	pcf8563->client = client;
-	device_set_wakeup_capable(&client->dev, 1);
 
 	/* Set timer to lowest frequency to save power (ref Haoyu datasheet) */
 	buf = PCF8563_TMRC_1_60;
@@ -553,6 +552,7 @@ static int pcf8563_probe(struct i2c_client *client)
 	/* the pcf8563 alarm only supports a minute accuracy */
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, pcf8563->rtc->features);
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf8563->rtc->features);
+	clear_bit(RTC_FEATURE_ALARM, pcf8563->rtc->features);
 	pcf8563->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf8563->rtc->range_max = RTC_TIMESTAMP_END_2099;
 	pcf8563->rtc->set_start_time = true;
@@ -573,7 +573,12 @@ static int pcf8563_probe(struct i2c_client *client)
 			return err;
 		}
 	} else {
-		clear_bit(RTC_FEATURE_ALARM, pcf8563->rtc->features);
+		client->irq = 0;
+	}
+
+	if (client->irq > 0 || device_property_read_bool(&client->dev, "wakeup-source")) {
+		device_init_wakeup(&client->dev, true);
+		set_bit(RTC_FEATURE_ALARM, pcf8563->rtc->features);
 	}
 
 	err = devm_rtc_register_device(pcf8563->rtc);
-- 
2.44.0


