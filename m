Return-Path: <linux-kernel+bounces-168494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15738BB93F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4D02823DA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E1612B72;
	Sat,  4 May 2024 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="oFWSmhjR"
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4C66AC0;
	Sat,  4 May 2024 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714788923; cv=none; b=D3T6CFhz6ydunx2+hSC9bgoG4nqgAEcoT7uSTRKnCIkqaeF3ww1VP4AXM5DEM94rWc4FxOHai5bTEzwYEaV7SRsmmmhBdFpbQGCRmi8llxVIkg1uI0kRlVmQZ6zKwlKLbLavBNI6XUAJ5silNQMeikKVT5HmQial1m12bRnKvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714788923; c=relaxed/simple;
	bh=xIMubRPsKcK6KDKMCglr9VJplkobSOyIGHpSONrXlIU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TA1/YDEwEVwawsF7UPogj6X2CB08aCHJRbM6p0VPuuneYOcltRV3ImgYv8/+zMUoYUp+n6UOuYGJB7+o6SKYRpBIBFX88ViarNrA9/MhO10PSqGZmzk1FzXjGkpssL3PuFIhp0ehWi6TQYt1BGPP+3k3JHL6NdJi7U/b/LQ/Pfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=oFWSmhjR; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30460C006E;
	Fri,  3 May 2024 22:08:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1714788489; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=iT3udjGB19kjB5NF7BrwrjkqYtlnB7WlfhROoMGd5BA=;
	b=oFWSmhjRH++upK+uMJ0WW9cvi74ewzT32BtIulnQ374abgVXVEu9qyXNvw9F807RIKTVU7
	p6XO+FxGvXnBFaJuCbow+1Ex4NQvx21HlEmywP+y2hk+Vi5uj9WUv0++tPrgniIu4kNVuD
	BAHKjqRFI96kxvzujN/aVMpUvsmeO8w=
From: Felix Kaechele <felix@kaechele.ca>
To: Job Noorman <job@noorman.info>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] input: himax_hx83112b: add regulator handling
Date: Fri,  3 May 2024 22:04:41 -0400
Message-ID: <20240504020745.68525-3-felix@kaechele.ca>
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

Handle regulators used on this chip family, namely AVDD and VDD. These
definitions are taken from the GPLv2 licensed vendor driver.

Signed-off-by: Felix Kaechele <felix@kaechele.ca>
Link: https://github.com/HimaxSoftware/HX83112_Android_Driver
---
 drivers/input/touchscreen/himax_hx83112b.c | 48 ++++++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/touchscreen/himax_hx83112b.c
index 4f6609dcdef3..0a797789e548 100644
--- a/drivers/input/touchscreen/himax_hx83112b.c
+++ b/drivers/input/touchscreen/himax_hx83112b.c
@@ -19,10 +19,12 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #define HIMAX_ID_83112B			0x83112b
 
 #define HIMAX_MAX_POINTS		10
+#define HIMAX_MAX_SUPPLIES		2
 
 #define HIMAX_REG_CFG_SET_ADDR		0x00
 #define HIMAX_REG_CFG_INIT_READ		0x0c
@@ -50,6 +52,7 @@ struct himax_event {
 static_assert(sizeof(struct himax_event) == 56);
 
 struct himax_ts_data {
+	struct regulator_bulk_data supplies[HIMAX_MAX_SUPPLIES];
 	struct gpio_desc *gpiod_rst;
 	struct input_dev *input_dev;
 	struct i2c_client *client;
@@ -63,6 +66,11 @@ static const struct regmap_config himax_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
+static const char *const himax_supply_names[] = {
+	"avdd",
+	"vdd",
+};
+
 static int himax_read_config(struct himax_ts_data *ts, u32 address, u32 *dst)
 {
 	int error;
@@ -267,7 +275,7 @@ static irqreturn_t himax_irq_handler(int irq, void *dev_id)
 
 static int himax_probe(struct i2c_client *client)
 {
-	int error;
+	int error, i;
 	struct device *dev = &client->dev;
 	struct himax_ts_data *ts;
 
@@ -290,11 +298,31 @@ static int himax_probe(struct i2c_client *client)
 		return error;
 	}
 
+	int num_supplies = ARRAY_SIZE(himax_supply_names);
+
+	for (i = 0; i < num_supplies; i++)
+		ts->supplies[i].supply = himax_supply_names[i];
+
+	error = devm_regulator_bulk_get(dev,
+					num_supplies,
+					ts->supplies);
+	if (error) {
+		dev_err(dev, "Failed to get supplies: %d\n", error);
+		return error;
+	}
+
+	error = regulator_bulk_enable(num_supplies,
+				      ts->supplies);
+	if (error) {
+		dev_err(dev, "Failed to enable supplies: %d\n", error);
+		goto error_out;
+	}
+
 	ts->gpiod_rst = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	error = PTR_ERR_OR_ZERO(ts->gpiod_rst);
 	if (error) {
 		dev_err(dev, "Failed to get reset GPIO: %d\n", error);
-		return error;
+		goto error_out;
 	}
 
 	himax_reset(ts);
@@ -305,15 +333,26 @@ static int himax_probe(struct i2c_client *client)
 
 	error = himax_input_register(ts);
 	if (error)
-		return error;
+		goto error_out;
 
 	error = devm_request_threaded_irq(dev, client->irq, NULL,
 					  himax_irq_handler, IRQF_ONESHOT,
 					  client->name, ts);
 	if (error)
-		return error;
+		goto error_out;
 
 	return 0;
+
+error_out:
+	regulator_bulk_disable(num_supplies, ts->supplies);
+	return error;
+}
+
+static void himax_remove(struct i2c_client *client)
+{
+	struct himax_ts_data *ts = i2c_get_clientdata(client);
+
+	regulator_bulk_disable(ARRAY_SIZE(himax_supply_names), ts->supplies);
 }
 
 static int himax_suspend(struct device *dev)
@@ -350,6 +389,7 @@ MODULE_DEVICE_TABLE(of, himax_of_match);
 
 static struct i2c_driver himax_ts_driver = {
 	.probe = himax_probe,
+	.remove = himax_remove,
 	.id_table = himax_ts_id,
 	.driver = {
 		.name = "Himax-hx83112b-TS",
-- 
2.44.0


