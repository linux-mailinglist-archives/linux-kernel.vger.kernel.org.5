Return-Path: <linux-kernel+bounces-22524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09997829F01
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C281C22920
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CCA4D13F;
	Wed, 10 Jan 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="kKvFcFA3"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9524D106;
	Wed, 10 Jan 2024 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id AB2922997D9;
	Wed, 10 Jan 2024 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1704907393;
	bh=bJudPKqGqIgjI+/dfFvGjSd/B1+nwirpU35vJKxcnno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kKvFcFA3eZvR+v7AAVF3GVhKcJ4nwkwV2mITWr5yoMkiG6rY85LirBHnhI+6ZBIcv
	 DfNDVroWA1rbSo46zNcPIbkK1lpxOTAl9rT23mqMifDKNoYvmVKHdaG81cr+qboRiv
	 lajI+0PWd7QOUvHVO8PWNW5Z3rP5kgLiigxWvKKc=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/6] iio: pressure: hsc030pa add mandatory delay
Date: Wed, 10 Jan 2024 19:22:39 +0200
Message-ID: <20240110172306.31273-5-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110172306.31273-1-petre.rodan@subdimension.ro>
References: <20240110172306.31273-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a mandatory 2ms delay between consecutive chip reads.

I found a new Technical Note pdf that specifies that the measurement cycle
in these chips takes around 1.26ms. By adding this 2ms delay we make sure
that we never get stale measurements.

This feature is also needed by the "iio: pressure: hsc030pa add sleep mode"
patch below.

For more details, please see "Figure 1" in the pdf below:

https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/hsc030pa.h     | 1 +
 drivers/iio/pressure/hsc030pa_i2c.c | 3 +++
 drivers/iio/pressure/hsc030pa_spi.c | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
index f1079a70799f..56dc8e88194b 100644
--- a/drivers/iio/pressure/hsc030pa.h
+++ b/drivers/iio/pressure/hsc030pa.h
@@ -13,6 +13,7 @@
 #include <linux/iio/iio.h>

 #define HSC_REG_MEASUREMENT_RD_SIZE 4
+#define HSC_RESP_TIME_MS            2

 struct device;

diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
index b5810bafef40..b3fd230e71da 100644
--- a/drivers/iio/pressure/hsc030pa_i2c.c
+++ b/drivers/iio/pressure/hsc030pa_i2c.c
@@ -8,6 +8,7 @@
  * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf
  */

+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
@@ -25,6 +26,8 @@ static int hsc_i2c_recv(struct hsc_data *data)
 	struct i2c_msg msg;
 	int ret;

+	msleep_interruptible(HSC_RESP_TIME_MS);
+
 	msg.addr = client->addr;
 	msg.flags = client->flags | I2C_M_RD;
 	msg.len = HSC_REG_MEASUREMENT_RD_SIZE;
diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
index 8d3441f1dcf9..737197eddff0 100644
--- a/drivers/iio/pressure/hsc030pa_spi.c
+++ b/drivers/iio/pressure/hsc030pa_spi.c
@@ -8,6 +8,7 @@
  * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf
  */

+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -28,6 +29,8 @@ static int hsc_spi_recv(struct hsc_data *data)
 		.len = HSC_REG_MEASUREMENT_RD_SIZE,
 	};

+	msleep_interruptible(HSC_RESP_TIME_MS);
+
 	return spi_sync_transfer(spi, &xfer, 1);
 }

--
2.41.0


