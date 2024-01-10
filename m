Return-Path: <linux-kernel+bounces-22528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D1829F08
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6355B1C22A68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBF64E1D1;
	Wed, 10 Jan 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="BOkdNBYH"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5068C4D12A;
	Wed, 10 Jan 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 273BF2997DB;
	Wed, 10 Jan 2024 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1704907394;
	bh=a99HJeBqxKiszZ3/n26SSt4qM8aVMV+50WhhkOqCi0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BOkdNBYHOJICY6O7CLE5FWgbRm02PGZiB9dKdc4xzY06u7BpPRPFO0NSeo7IMFhGW
	 1Php8euSF1ZNsjtzupz34EU1I2SVGL6SEwB4QZnrdPf/tHSSAVw+MmDvfPf6PzX+4m
	 EQk3C9MddhP/o+iyRsF1Z33LMeUt34wRF5XP0+0Y=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] iio: pressure: hsc030pa add sleep mode
Date: Wed, 10 Jan 2024 19:22:41 +0200
Message-ID: <20240110172306.31273-7-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110172306.31273-1-petre.rodan@subdimension.ro>
References: <20240110172306.31273-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some custom chips from this series require a wakeup sequence before the
measurement cycle is started.

Quote from the product datasheet:
"Optional sleep mode available upon special request."

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/hsc030pa.c     |  4 ++++
 drivers/iio/pressure/hsc030pa.h     |  4 ++++
 drivers/iio/pressure/hsc030pa_i2c.c | 19 +++++++++++++++++
 drivers/iio/pressure/hsc030pa_spi.c | 32 +++++++++++++++++++++++++++--
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
index 3faa0fd42201..9e66fd561801 100644
--- a/drivers/iio/pressure/hsc030pa.c
+++ b/drivers/iio/pressure/hsc030pa.c
@@ -501,6 +501,10 @@ int hsc_common_probe(struct device *dev, hsc_recv_fn recv)
 		return dev_err_probe(dev, -EINVAL,
 				     "pressure limits are invalid\n");

+	ret = device_property_read_bool(dev, "honeywell,sleep-mode");
+	if (ret)
+		hsc->capabilities |= HSC_CAP_SLEEP;
+
 	ret = devm_regulator_get_enable(dev, "vdd");
 	if (ret)
 		return dev_err_probe(dev, ret, "can't get vdd supply\n");
diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
index 6c635c42d85d..4e356944d67d 100644
--- a/drivers/iio/pressure/hsc030pa.h
+++ b/drivers/iio/pressure/hsc030pa.h
@@ -15,6 +15,8 @@
 #define HSC_REG_MEASUREMENT_RD_SIZE 4
 #define HSC_RESP_TIME_MS            2

+#define HSC_CAP_SLEEP               0x1
+
 struct device;

 struct iio_chan_spec;
@@ -29,6 +31,7 @@ typedef int (*hsc_recv_fn)(struct hsc_data *);
  * struct hsc_data
  * @dev: current device structure
  * @chip: structure containing chip's channel properties
+ * @capabilities: chip specific attributes
  * @recv_cb: function that implements the chip reads
  * @is_valid: true if last transfer has been validated
  * @pmin: minimum measurable pressure limit
@@ -45,6 +48,7 @@ typedef int (*hsc_recv_fn)(struct hsc_data *);
 struct hsc_data {
 	struct device *dev;
 	const struct hsc_chip_data *chip;
+	u32 capabilities;
 	hsc_recv_fn recv_cb;
 	bool is_valid;
 	s32 pmin;
diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
index b3fd230e71da..62bdae272012 100644
--- a/drivers/iio/pressure/hsc030pa_i2c.c
+++ b/drivers/iio/pressure/hsc030pa_i2c.c
@@ -24,8 +24,27 @@ static int hsc_i2c_recv(struct hsc_data *data)
 {
 	struct i2c_client *client = to_i2c_client(data->dev);
 	struct i2c_msg msg;
+	u8 buf;
 	int ret;

+	if (data->capabilities & HSC_CAP_SLEEP) {
+		/*
+		 * Send the Full Measurement Request (FMR) command on the CS
+		 * line in order to wake up the sensor as per
+		 * "Sleep Mode for Use with Honeywell Digital Pressure Sensors"
+		 * technical note (consult the datasheet link in the header).
+		 *
+		 * These specifications require a dummy packet comprised only by
+		 * a single byte that contains the 7bit slave address and the
+		 * READ bit followed by a STOP.
+		 * Because the i2c API does not allow packets without a payload,
+		 * the driver sends two bytes in this implementation.
+		 */
+		ret = i2c_master_recv(client, &buf, 1);
+		if (ret < 0)
+			return ret;
+	}
+
 	msleep_interruptible(HSC_RESP_TIME_MS);

 	msg.addr = client->addr;
diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
index 737197eddff0..1c139cdfe856 100644
--- a/drivers/iio/pressure/hsc030pa_spi.c
+++ b/drivers/iio/pressure/hsc030pa_spi.c
@@ -25,12 +25,40 @@ static int hsc_spi_recv(struct hsc_data *data)
 	struct spi_device *spi = to_spi_device(data->dev);
 	struct spi_transfer xfer = {
 		.tx_buf = NULL,
-		.rx_buf = data->buffer,
-		.len = HSC_REG_MEASUREMENT_RD_SIZE,
+		.rx_buf = NULL,
+		.len = 0,
 	};
+	u16 orig_cs_setup_value;
+	u8 orig_cs_setup_unit;
+
+	if (data->capabilities & HSC_CAP_SLEEP) {
+		/*
+		 * Send the Full Measurement Request (FMR) command on the CS
+		 * line in order to wake up the sensor as per
+		 * "Sleep Mode for Use with Honeywell Digital Pressure Sensors"
+		 * technical note (consult the datasheet link in the header).
+		 *
+		 * These specifications require the CS line to be held asserted
+		 * for at least 8µs without any payload being generated.
+		 */
+		orig_cs_setup_value = spi->cs_setup.value;
+		orig_cs_setup_unit = spi->cs_setup.unit;
+		spi->cs_setup.value = 8;
+		spi->cs_setup.unit = SPI_DELAY_UNIT_USECS;
+		/*
+		 * Send a dummy 0-size packet so that CS gets toggled.
+		 * Trying to manually call spi->controller->set_cs() instead
+		 * does not work as expected during the second call.
+		 */
+		spi_sync_transfer(spi, &xfer, 1);
+		spi->cs_setup.value = orig_cs_setup_value;
+		spi->cs_setup.unit = orig_cs_setup_unit;
+	}

 	msleep_interruptible(HSC_RESP_TIME_MS);

+	xfer.rx_buf = data->buffer;
+	xfer.len = HSC_REG_MEASUREMENT_RD_SIZE;
 	return spi_sync_transfer(spi, &xfer, 1);
 }

--
2.41.0


