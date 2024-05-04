Return-Path: <linux-kernel+bounces-168490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E18D38BB932
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5A7B23256
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800DDD26A;
	Sat,  4 May 2024 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="mJ1Zhou+"
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1EF210D;
	Sat,  4 May 2024 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714788484; cv=none; b=F2L0xb3avCttOTBxTfAnWxaDIjvosZgbDf1MbwnVyJIPnCbJ1/rM4zcC9DwqfGBPzGtWLHnBWIT1r+u3PxZ4CKKPeqw4udJdfPPOSASlArM78v3baCZQdEtVhZgPzR04CdLR7MDrhKn0sxg7AObU13V49l9RP86dhDtNOtkNydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714788484; c=relaxed/simple;
	bh=BYyg1SiTgeo3qfXhKZEi1hR0S5PAcTSMT9TliXuH9hY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckx0ujMrUL8VfdRCmEfzwT6aDQGeIP0AYdzLoQKuUSTYDo2FZn4xyG2KohltCLhArvS4ndgtWE6VQ0zF1qRUWYCKPZ7o2p/E6unOUVGsRmOQi+D9hnMiH6lPtfPumSn1QgKJpCmlIeBce3L9tulqLWR1ePoO3kuGG+cVVjLeJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=mJ1Zhou+; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBDD9C0072;
	Fri,  3 May 2024 22:08:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1714788492; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=urS88EVc3Y2DTRlVBr6koQ8c8bKoBQO9OBgP+LpuXV0=;
	b=mJ1Zhou+K7+3qsOhx6ecPzBFInJ/SuPXoVtBpzVFfi7rOLh/vxLkbEWFAHD52SO+KiuPh4
	mlKn13eFDJ4DWwsqpg4jBvyli3JgfP9nnX0L3ePpo+Sv1jb7MPTSHt0p8aE83zXCVQUfxY
	4+IMvNonBRXVB4ZOZmRf1qRSPdp27Lo=
From: Felix Kaechele <felix@kaechele.ca>
To: Job Noorman <job@noorman.info>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] input: himax_hx83112b: add himax_chip struct for multi-chip support
Date: Fri,  3 May 2024 22:04:44 -0400
Message-ID: <20240504020745.68525-6-felix@kaechele.ca>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504020745.68525-1-felix@kaechele.ca>
References: <20240504020745.68525-1-felix@kaechele.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In preparation for HX83100A support allow defining separate functions
for specific chip operations.

Signed-off-by: Felix Kaechele <felix@kaechele.ca>
---
 drivers/input/touchscreen/himax_hx83112b.c | 53 +++++++++++++++-------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/touchscreen/himax_hx83112b.c
index 0173ff394a99..667611c5a018 100644
--- a/drivers/input/touchscreen/himax_hx83112b.c
+++ b/drivers/input/touchscreen/himax_hx83112b.c
@@ -21,8 +21,6 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
-#define HIMAX_ID_83112B			0x83112b
-
 #define HIMAX_MAX_POINTS		10
 #define HIMAX_MAX_SUPPLIES		2
 
@@ -57,7 +55,17 @@ struct himax_event {
 
 static_assert(sizeof(struct himax_event) == 56);
 
+struct himax_ts_data;
+struct himax_chip {
+	u32 id;
+	int (*check_id)(struct himax_ts_data *ts);
+	int (*read_events)(struct himax_ts_data *ts,
+			   struct himax_event *event,
+			   size_t length);
+};
+
 struct himax_ts_data {
+	const struct himax_chip *chip;
 	struct regulator_bulk_data supplies[HIMAX_MAX_SUPPLIES];
 	struct gpio_desc *gpiod_rst;
 	struct input_dev *input_dev;
@@ -176,15 +184,12 @@ static int himax_check_product_id(struct himax_ts_data *ts)
 
 	dev_dbg(&ts->client->dev, "Product id: %x\n", product_id);
 
-	switch (product_id) {
-	case HIMAX_ID_83112B:
+	if (product_id == ts->chip->id)
 		return 0;
 
-	default:
-		dev_err(&ts->client->dev,
-			"Unknown product id: %x\n", product_id);
-		return -EINVAL;
-	}
+	dev_err(&ts->client->dev, "Unknown product id: %x\n",
+		product_id);
+	return -EINVAL;
 }
 
 static int himax_input_register(struct himax_ts_data *ts)
@@ -286,13 +291,20 @@ static bool himax_verify_checksum(struct himax_ts_data *ts,
 	return true;
 }
 
+static int himax_read_events(struct himax_ts_data *ts,
+			     struct himax_event *event,
+			     size_t length)
+{
+	return regmap_raw_read(ts->regmap, HIMAX_AHB_ADDR_EVENT_STACK, event,
+			       length);
+}
+
 static int himax_handle_input(struct himax_ts_data *ts)
 {
 	int error;
 	struct himax_event event;
 
-	error = regmap_raw_read(ts->regmap, HIMAX_AHB_ADDR_EVENT_STACK, &event,
-				sizeof(event));
+	error = ts->chip->read_events(ts, &event, sizeof(event));
 	if (error) {
 		dev_err(&ts->client->dev, "Failed to read input event: %d\n",
 			error);
@@ -338,6 +350,7 @@ static int himax_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, ts);
 	ts->client = client;
+	ts->chip = i2c_get_match_data(client);
 
 	ts->regmap = devm_regmap_init_i2c(client, &himax_regmap_config);
 	error = PTR_ERR_OR_ZERO(ts->regmap);
@@ -375,9 +388,11 @@ static int himax_probe(struct i2c_client *client)
 
 	himax_reset(ts);
 
-	error = himax_check_product_id(ts);
-	if (error)
-		return error;
+	if (ts->chip->check_id) {
+		error = himax_check_product_id(ts);
+		if (error)
+			return error;
+	}
 
 	error = himax_input_register(ts);
 	if (error)
@@ -421,15 +436,21 @@ static int himax_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(himax_pm_ops, himax_suspend, himax_resume);
 
+static const struct himax_chip hx83112b_chip = {
+	.id = 0x83112b,
+	.check_id = himax_check_product_id,
+	.read_events = himax_read_events,
+};
+
 static const struct i2c_device_id himax_ts_id[] = {
-	{ "hx83112b", 0 },
+	{ "hx83112b", (kernel_ulong_t) &hx83112b_chip },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, himax_ts_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id himax_of_match[] = {
-	{ .compatible = "himax,hx83112b" },
+	{ .compatible = "himax,hx83112b", .data = &hx83112b_chip },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, himax_of_match);
-- 
2.44.0


