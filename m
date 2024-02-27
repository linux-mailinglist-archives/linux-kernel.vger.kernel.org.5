Return-Path: <linux-kernel+bounces-84021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD8386A175
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD4D1C21147
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2363714EFF8;
	Tue, 27 Feb 2024 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mPzYVbWF"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B038DE7;
	Tue, 27 Feb 2024 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068726; cv=none; b=gW/SZM3urE8h2SE+56BS3mwHF8Nh+dU3fcq+TRhsaP21HfJDUpIXui9PMZmkq8087cRrwAiQsCVHnDuSLzGhHA6Q8Nvy9v5G7Xzo9Ytq4lO7iPmkOnU7lSD2iiXDGJs9Rg7cuLV2Y+VHPdMkzTwQ1J5/bLrIgwrqaY1ZJ8GufWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068726; c=relaxed/simple;
	bh=Ok728L3hHJA0zGGTLXQ6pyu51bOeCtQqVFNe1uXUOpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOUYGMXe+VpOKStf4zpuLXKgVJRVKJO4O/yB9TUzxIEkH5n5fdGZF4fi/jAvX6eZSZwSCYCvF+bxP20rQbDTKX+ESLe6qBUC7wgmWkCk5Shxi42uEYr51+d7C68xfulEVUXokNnZD3rjSgf30CwkXabrDwmbuzvfG0Oiq3SpOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mPzYVbWF; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A02F4FF80B;
	Tue, 27 Feb 2024 21:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709068721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v0Q7f5YZOavW5gvORY5KlMV7Hgztn8PzK/Piadt892c=;
	b=mPzYVbWFqPXV/lzJRm1RIScu3Zt2fgRv6UKCaDHGoGy9c+zJNHmkLD+RVNg3UvhMv2V4xY
	O32jZdx5aJ2kWdy/DPpDdHaO37kcMmH0uKBA017iUwusmGN29cQF+gkFcUxitTzE/H+z9S
	yo3B1X3E5t5sbf4k/tv0mC79iJawQlPr/Q40kC4Z+qZaqX+NQm0PtlifmcUC3SE0rdHqOX
	MlsV8tPXWiNMTOEAj2GiYXP2c/dtxISV9NyL4CUfpdqTcqU95+Sa9L8iaPnxNitHLG5WA7
	dX+TzNkoB68GD/2cR7skgm6xQCNyqq4/9iTVJ3VVutt8ndm+xz7DG9NhRIDAnQ==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: pcf8523: add suspend handlers for alarm IRQ
Date: Tue, 27 Feb 2024 22:18:32 +0100
Message-ID: <20240227211833.1820800-1-alexandre.belloni@bootlin.com>
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

Ensure the RTC is able to wake up the system from suspend.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf8523.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index d1efde3e7a80..98b77f790b0c 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -370,6 +370,30 @@ static int pcf8523_rtc_set_offset(struct device *dev, long offset)
 	return regmap_write(pcf8523->regmap, PCF8523_REG_OFFSET, value);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int pcf8523_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (client->irq > 0 && device_may_wakeup(dev))
+		enable_irq_wake(client->irq);
+
+	return 0;
+}
+
+static int pcf8523_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (client->irq > 0 && device_may_wakeup(dev))
+		disable_irq_wake(client->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(pcf8523_pm, pcf8523_suspend, pcf8523_resume);
+
 static const struct rtc_class_ops pcf8523_rtc_ops = {
 	.read_time = pcf8523_rtc_read_time,
 	.set_time = pcf8523_rtc_set_time,
@@ -487,6 +511,7 @@ static struct i2c_driver pcf8523_driver = {
 	.driver = {
 		.name = "rtc-pcf8523",
 		.of_match_table = pcf8523_of_match,
+		.pm = &pcf8523_pm,
 	},
 	.probe = pcf8523_probe,
 	.id_table = pcf8523_id,
-- 
2.43.0


