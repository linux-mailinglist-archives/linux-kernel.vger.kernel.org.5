Return-Path: <linux-kernel+bounces-71384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0712085A46D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3441C2255C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E784B3613C;
	Mon, 19 Feb 2024 13:11:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56034CDE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348292; cv=none; b=p3vDRi7izu4cRHL4a9P632/R9T29cfqL4S9RiCerM5zLEVLOtMbVybgCHf4cn86v4FScR0aVl0InBkThwJ0bRLdB70SglndDoCjXz5VVJAqhyk1NuHYTO27EOjBsa96zL1tesO0J5E1u0SJ2D5MxjWR6kPet93QS81eEd5XENME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348292; c=relaxed/simple;
	bh=UGeUyFN19bQZCVUzkNSWfD9kVi6j0pXHg2utyZmuIao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=knQ2pc4fOkAeyljNSjs0qKks+tXkuBNzMyDi0+CZb0wefQmU+Nx/XblXmmDQk7Uky0OJif9Z1khQ47mj/wyVYnt9k+7fhNEaEL7zhKuOvW4Xum+iHMT2WLYNdpNlSDiDlSEAe95mFy08/oSWEyUEhK2j7F3kJBWRBn4TvqHgEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rc3QT-0005bN-NU; Mon, 19 Feb 2024 14:11:17 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: puranjay12@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v2 2/2] iio: temperature: tmp117: add support for vcc-supply
Date: Mon, 19 Feb 2024 14:11:14 +0100
Message-Id: <20240219131114.134607-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219131114.134607-1-m.felsch@pengutronix.de>
References: <20240219131114.134607-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>

Add support to specify the VCC supply which is required to power the
device. According the datasheet 7.3.1 Power Up, the device needs 1.5ms
after the supply voltage reaches the operating range before the
communcation can begin.

Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v2:
- add fsleep() after powering the device

 drivers/iio/temperature/tmp117.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 059953015ae7..8972083d903a 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -9,6 +9,7 @@
  * Note: This driver assumes that the sensor has been calibrated beforehand.
  */
 
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -17,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
 
@@ -148,10 +150,17 @@ static int tmp117_probe(struct i2c_client *client)
 	struct tmp117_data *data;
 	struct iio_dev *indio_dev;
 	int dev_id;
+	int ret;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EOPNOTSUPP;
 
+	ret = devm_regulator_get_enable(&client->dev, "vcc");
+	if (ret)
+		return ret;
+
+	fsleep(1500);
+
 	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
 	if (dev_id < 0)
 		return dev_id;
-- 
2.39.2


