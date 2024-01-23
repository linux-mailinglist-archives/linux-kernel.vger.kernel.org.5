Return-Path: <linux-kernel+bounces-35424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC948390DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4F01F2A31A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B7C5FB8E;
	Tue, 23 Jan 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="grcZOfGb"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707995F876;
	Tue, 23 Jan 2024 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018979; cv=none; b=MQiXwhcUmIuJhCbOUpchOXi4ttpFKPeEeduudxM+lDjcq2Evf+HIFpP8OrV+Q7YabgDpUQxk56QSnt9+7hS/3qR7erKEGVAATmG9E0Zl8FLm6kp2mepmzHeYklcv98KDbEz5dWzw+qo/U6DIzLyXTIQJKfDT8Lw+Tnu3eKM2biY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018979; c=relaxed/simple;
	bh=sLTwqP6WOMgR7XzrnZkXzjHudMd77AdlbaqN5zI3ijY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OmjSCFfCDytfh6uIKA5mMBSitofqNzAet8YYlJeeYmhZou+7+iCB4D6Lo2qIZKIkfdaJbPIb27cqmz/GYpwBJZNsutTOT9xPdWMdu8FrImeZUnIPMxbsSkRBw+ro7xtHCp5FRwcEUMhgjzEAFKnySBdJBCTTq4rinGuV0M2eEWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=grcZOfGb; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NE9JiH008636;
	Tue, 23 Jan 2024 08:09:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706018959;
	bh=Uufh4LvwbcbKCe08o0Fuz8M3j4+oEw0vRnDhHEVz7kg=;
	h=From:To:CC:Subject:Date;
	b=grcZOfGbSp2KvxaMyvuZ79xSFHRVR3zLX3SmMgqxlxVjgI3ovF4L/YiYb9mP6wCRj
	 c7VFJ8ebdWov5jBVjvDfqWEZIpOsRrjtyK903XXyi38+3kYi5sPTcu8QTUWuRXFyYa
	 xDe7PVeE0PsusebGNCObqGSkoE8S6PERp6nT7rfc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NE9JpE003059
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 08:09:19 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 08:09:19 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 08:09:19 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NE9Iur034990;
	Tue, 23 Jan 2024 08:09:19 -0600
From: Andrew Davis <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 1/4] iio: health: afe4403: Use devm action helper for regulator disable
Date: Tue, 23 Jan 2024 08:09:15 -0600
Message-ID: <20240123140918.215818-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use a device lifecycle managed action for regulator disable function.
This helps prevent mistakes like unregistering out of order in cleanup
functions and forgetting to unregister on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/iio/health/afe4403.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index df3bc5c3d3786..9e9d6de2a7c83 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -346,6 +346,13 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static void afe4403_regulator_disable(void *data)
+{
+	struct regulator *regulator = data;
+
+	regulator_disable(regulator);
+}
+
 #define AFE4403_TIMING_PAIRS			\
 	{ AFE440X_LED2STC,	0x000050 },	\
 	{ AFE440X_LED2ENDC,	0x0003e7 },	\
@@ -495,19 +502,24 @@ static int afe4403_probe(struct spi_device *spi)
 		dev_err(afe->dev, "Unable to enable regulator\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(afe->dev, afe4403_regulator_disable, afe->regulator);
+	if (ret) {
+		dev_err(afe->dev, "Unable to add regulator disable action\n");
+		return ret;
+	}
 
 	ret = regmap_write(afe->regmap, AFE440X_CONTROL0,
 			   AFE440X_CONTROL0_SW_RESET);
 	if (ret) {
 		dev_err(afe->dev, "Unable to reset device\n");
-		goto err_disable_reg;
+		return ret;
 	}
 
 	ret = regmap_multi_reg_write(afe->regmap, afe4403_reg_sequences,
 				     ARRAY_SIZE(afe4403_reg_sequences));
 	if (ret) {
 		dev_err(afe->dev, "Unable to set register defaults\n");
-		goto err_disable_reg;
+		return ret;
 	}
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -523,8 +535,7 @@ static int afe4403_probe(struct spi_device *spi)
 						   iio_device_id(indio_dev));
 		if (!afe->trig) {
 			dev_err(afe->dev, "Unable to allocate IIO trigger\n");
-			ret = -ENOMEM;
-			goto err_disable_reg;
+			return -ENOMEM;
 		}
 
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
@@ -532,7 +543,7 @@ static int afe4403_probe(struct spi_device *spi)
 		ret = iio_trigger_register(afe->trig);
 		if (ret) {
 			dev_err(afe->dev, "Unable to register IIO trigger\n");
-			goto err_disable_reg;
+			return ret;
 		}
 
 		ret = devm_request_threaded_irq(afe->dev, afe->irq,
@@ -566,8 +577,6 @@ static int afe4403_probe(struct spi_device *spi)
 err_trig:
 	if (afe->irq > 0)
 		iio_trigger_unregister(afe->trig);
-err_disable_reg:
-	regulator_disable(afe->regulator);
 
 	return ret;
 }
@@ -584,10 +593,6 @@ static void afe4403_remove(struct spi_device *spi)
 
 	if (afe->irq > 0)
 		iio_trigger_unregister(afe->trig);
-
-	ret = regulator_disable(afe->regulator);
-	if (ret)
-		dev_warn(afe->dev, "Unable to disable regulator\n");
 }
 
 static const struct spi_device_id afe4403_ids[] = {
-- 
2.39.2


