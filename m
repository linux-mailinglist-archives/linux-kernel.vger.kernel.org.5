Return-Path: <linux-kernel+bounces-60654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF34A850814
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E4C1F22800
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B505481D0;
	Sun, 11 Feb 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="IFBzVMHE"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F745C12;
	Sun, 11 Feb 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707638221; cv=none; b=iqs7yDEldYezoMbh7kmRgITAB5GWx5sJd8JxcMrs8POs8KEDSDSsCiE/ZZDynsYJXSg+E4tfwrrm6S1Q2TySHEO3x+yK8/eOD3UeJFeRsIe5vOU8WLp4Ql6LDggEu8KEWIJt8ZqD6603NYQPs1WOkIb9PDi0ewLMICnMbBtqiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707638221; c=relaxed/simple;
	bh=UVd7+V2rqSalUQgPUjmz/S3icJ28UTSb6PeWFe4ToSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBiTieuVcos+kpaA1DnqXWscz74FopXtPKS9k8mqFwwl4urtmuktIpJmt98RQcAh06MqyDOVcSzDB3+UAT9nvD7Rs1x9XFMA3GBZ9si34FN7Qfbq9OoF0b7V1iJ1rWTrgwzDpfz+XZXGt0d6CjT+1pu+7EQko8f5YMECDLYhLoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=IFBzVMHE; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.101.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 36CE930FB54;
	Sun, 11 Feb 2024 07:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1707638210;
	bh=UVd7+V2rqSalUQgPUjmz/S3icJ28UTSb6PeWFe4ToSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IFBzVMHE06tdit4VK7X/I3ev870lmPdPY/gKqWI2tW14eW0v12eFf6G/m9at/p4rl
	 l0lPStg+y3r0mHszcO5d0oMOIFVdUY2cYYY0Q4n83xBtLr2P5Cj2ooSGhg5EBRfnX5
	 NI1BvjaUfcK2Ack3Jd8MWQ4Nhaa3rp4cXl4t7p1k=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 6/6] iio: pressure: hsc030pa add triggered buffer
Date: Sun, 11 Feb 2024 09:56:37 +0200
Message-ID: <20240211075645.28777-7-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211075645.28777-1-petre.rodan@subdimension.ro>
References: <20240211075645.28777-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add triggered buffer feature.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 add Kconfig select for IIO_*BUFFER
         a few changes based on Jonathan's review
v2 -> v3 fixed array pointer based on Andy's review
 drivers/iio/pressure/Kconfig    |  2 ++
 drivers/iio/pressure/hsc030pa.c | 47 +++++++++++++++++++++++++++++++++
 drivers/iio/pressure/hsc030pa.h |  4 +++
 3 files changed, 53 insertions(+)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 5da7931dc537..3ad38506028e 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -114,6 +114,8 @@ config HSC030PA
 	depends on (I2C || SPI_MASTER)
 	select HSC030PA_I2C if I2C
 	select HSC030PA_SPI if SPI_MASTER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here to build support for the Honeywell TruStability
 	  HSC and SSC pressure and temperature sensor series.
diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
index 7e3f74d53b47..1682b90d4557 100644
--- a/drivers/iio/pressure/hsc030pa.c
+++ b/drivers/iio/pressure/hsc030pa.c
@@ -22,8 +22,11 @@
 #include <linux/types.h>
 #include <linux/units.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include <asm/unaligned.h>
 
@@ -297,6 +300,29 @@ static int hsc_get_measurement(struct hsc_data *data)
 	return 0;
 }
 
+static irqreturn_t hsc_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct hsc_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = hsc_get_measurement(data);
+	if (ret)
+		goto error;
+
+	memcpy(&data->scan.chan[0], &data->buffer[0], 2);
+	memcpy(&data->scan.chan[1], &data->buffer[2], 2);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+					   iio_get_time_ns(indio_dev));
+
+error:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 /*
  * IIO ABI expects
  * value = (conv + offset) * scale
@@ -382,13 +408,29 @@ static const struct iio_chan_spec hsc_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 14,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
 	},
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 11,
+			.storagebits = 16,
+			.shift = 5,
+			.endianness = IIO_BE,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 static const struct iio_info hsc_info = {
@@ -485,6 +527,11 @@ int hsc_common_probe(struct device *dev, hsc_recv_fn recv)
 	indio_dev->channels = hsc->chip->channels;
 	indio_dev->num_channels = hsc->chip->num_channels;
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      hsc_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS(hsc_common_probe, IIO_HONEYWELL_HSC030PA);
diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
index 56dc8e88194b..9b40f46f575f 100644
--- a/drivers/iio/pressure/hsc030pa.h
+++ b/drivers/iio/pressure/hsc030pa.h
@@ -56,6 +56,10 @@ struct hsc_data {
 	s32 p_scale_dec;
 	s64 p_offset;
 	s32 p_offset_dec;
+	struct {
+		__be16 chan[2];
+		s64 timestamp __aligned(8);
+	} scan;
 	u8 buffer[HSC_REG_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
 };
 
-- 
2.43.0


