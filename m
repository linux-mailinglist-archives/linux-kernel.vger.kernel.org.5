Return-Path: <linux-kernel+bounces-41262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EF983EE30
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BECB220A1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011AC2C6AC;
	Sat, 27 Jan 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="CUh9o+uT"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA529429;
	Sat, 27 Jan 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706371462; cv=none; b=d3S2jN2SOU5djUCVXAibu93A2MnEChmmoUwlK8O2LkDNdkLexgUWr6nDoU+se3LP+EySAuGdWVX2W9Me3UPsuoE578onkG61u7WHcianQRmBL5VgoyTMW9TsZYlDr1JZOAdT90P7ehArKssbOc3aKao3wE3/UYU7Aheqjz6it5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706371462; c=relaxed/simple;
	bh=ckgGjldfa/QMe8AawYQJb7Zfb90P85Y8WeoWJuvHEos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trCappT2L07M7Wk1hAEWbAchWiHi6nsWtDlGuUt2+4kcBc6HCoaam2B++HtgACean1+VmVfTWnqlAd8DA/B8mTwfTrcBHTOBNumpzekVAWfxXzuBiLydm9rCWnfWCUoHljRq6q+FLD4mdJAhl+vHhMcRSTQ/eY9ISVzOr1zKPvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=CUh9o+uT; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.80.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id BACDD293A96;
	Sat, 27 Jan 2024 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1706371452;
	bh=ckgGjldfa/QMe8AawYQJb7Zfb90P85Y8WeoWJuvHEos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CUh9o+uTnmUJoufQ0WYAnwhjJmT6Hp05pQRZm8wnKawzLSpzmpxHiAsRRLS7S8r/E
	 ndUqY5XHQo+bERBUbmOfr95NPFfJYJ6wKBoHgR4sLH8WJjv4e5/oCB18fiGxZGJesL
	 LxfbLN3cg0gHeDKw0y0d8GqtzzP/v3mlWfz3hLqc=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/4] iio: pressure: hsc030pa add mandatory delay
Date: Sat, 27 Jan 2024 18:03:57 +0200
Message-ID: <20240127160405.19696-4-petre.rodan@subdimension.ro>
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

Add a mandatory 2ms delay between consecutive chip reads.

I found a new Technical Note pdf that specifies that the measurement cycle
in these chips takes around 1.26ms. By adding this 2ms delay we make sure
that we never get stale measurements.

For more details, please see "Figure 1" in the pdf below:

https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 no change
 drivers/iio/pressure/hsc030pa.h     | 1 +
 drivers/iio/pressure/hsc030pa_i2c.c | 3 +++
 drivers/iio/pressure/hsc030pa_spi.c | 2 ++
 3 files changed, 6 insertions(+)

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
index 8d3441f1dcf9..818fa6303454 100644
--- a/drivers/iio/pressure/hsc030pa_spi.c
+++ b/drivers/iio/pressure/hsc030pa_spi.c
@@ -8,6 +8,7 @@
  * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/common/documents/sps-siot-sleep-mode-technical-note-008286-1-en-ciid-155793.pdf
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -28,6 +29,7 @@ static int hsc_spi_recv(struct hsc_data *data)
 		.len = HSC_REG_MEASUREMENT_RD_SIZE,
 	};
 
+	msleep_interruptible(HSC_RESP_TIME_MS);
 	return spi_sync_transfer(spi, &xfer, 1);
 }
 
-- 
2.43.0


