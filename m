Return-Path: <linux-kernel+bounces-41263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6107683EE2F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC9D283FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142152C6AE;
	Sat, 27 Jan 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="qK4V5e6B"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87E2942A;
	Sat, 27 Jan 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706371462; cv=none; b=rbkr5JiLyN58PSWfhQgl7WvJ3QXZSPl5Gcih+PFIUFH0mGRj8lXEcnR428OUZSBHs4UUPfHcT4St9TtcyLlb1S3Mzt2N1z/zMQBCEYbsIWh4WE/pxa0r/0LltAbO9uYWh6+AZjmMEKezqRB05H7fy+7SEw5/dwnEcblQNrqmIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706371462; c=relaxed/simple;
	bh=NgaXfya/JmF4HV+b44clhdfGVtTwdg0qDzOTzyoDzpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWPznftksGL0frf2NhcgG0Y9zl2MJggCZBVYmCSjixe/v+5BBIMRsD8AdPsHcDmhQZxor9Xr0yII6iTNbHWu42ElmNThYh8RLsHY0NsFGAc/94BxgALhLoo1Hil64PwIsuP9ThshgbxNZq9l8kLLiIRRIXiBpwdlEUPRyS0y8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=qK4V5e6B; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.80.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 8319E293A95;
	Sat, 27 Jan 2024 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1706371452;
	bh=NgaXfya/JmF4HV+b44clhdfGVtTwdg0qDzOTzyoDzpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qK4V5e6B1GzGIg/zRvhY19ikQPVxBJL0Otg8VOdr6xnv1x8p4NDwqa8UruJGQtHKv
	 Tc/8elnxNODXzvWqqzofpsHYskEO4pFj5aSZWdyXXnBj2caqMUK4GZYK8V0OKEqeSZ
	 yweUdNwIOhWvvac2mLoGtca13e8hE5iv3EnFO0+E=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 2/4] iio: pressure: hsc030pa cleanup
Date: Sat, 27 Jan 2024 18:03:56 +0200
Message-ID: <20240127160405.19696-3-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127160405.19696-1-petre.rodan@subdimension.ro>
References: <20240127160405.19696-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use signed type to variable holding the result given by div_s64().

Add includes based on prior reviews from Andy.

Provide bus-specific technical datasheet in the _i2c.c _spi.c headers
instead of the generic one.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 no change
 drivers/iio/pressure/hsc030pa.c     | 2 +-
 drivers/iio/pressure/hsc030pa.h     | 2 ++
 drivers/iio/pressure/hsc030pa_i2c.c | 6 ++++--
 drivers/iio/pressure/hsc030pa_spi.c | 5 ++++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
index d6a51f0c335f..7e3f74d53b47 100644
--- a/drivers/iio/pressure/hsc030pa.c
+++ b/drivers/iio/pressure/hsc030pa.c
@@ -406,7 +406,7 @@ int hsc_common_probe(struct device *dev, hsc_recv_fn recv)
 	struct hsc_data *hsc;
 	struct iio_dev *indio_dev;
 	const char *triplet;
-	u64 tmp;
+	s64 tmp;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
index d20420dba4f6..f1079a70799f 100644
--- a/drivers/iio/pressure/hsc030pa.h
+++ b/drivers/iio/pressure/hsc030pa.h
@@ -10,6 +10,8 @@
 
 #include <linux/types.h>
 
+#include <linux/iio/iio.h>
+
 #define HSC_REG_MEASUREMENT_RD_SIZE 4
 
 struct device;
diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
index e2b524b36417..b5810bafef40 100644
--- a/drivers/iio/pressure/hsc030pa_i2c.c
+++ b/drivers/iio/pressure/hsc030pa_i2c.c
@@ -4,14 +4,16 @@
  *
  * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
  *
- * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [hsc]
- * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/common/documents/sps-siot-i2c-comms-digital-output-pressure-sensors-tn-008201-3-en-ciid-45841.pdf [i2c related]
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/common/documents/sps-siot-i2c-comms-digital-output-pressure-sensors-tn-008201-3-en-ciid-45841.pdf
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf
  */
 
+#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 
diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
index a719bade8326..8d3441f1dcf9 100644
--- a/drivers/iio/pressure/hsc030pa_spi.c
+++ b/drivers/iio/pressure/hsc030pa_spi.c
@@ -4,13 +4,16 @@
  *
  * Copyright (c) 2023 Petre Rodan <petre.rodan@subdimension.ro>
  *
- * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-spi-comms-digital-ouptu-pressure-sensors-tn-008202-3-en-ciid-45843.pdf
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf
  */
 
+#include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <linux/stddef.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 
-- 
2.43.0


