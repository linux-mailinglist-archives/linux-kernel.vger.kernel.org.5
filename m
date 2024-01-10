Return-Path: <linux-kernel+bounces-22527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E42829F07
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02861C22A44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45094E1D0;
	Wed, 10 Jan 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Ab8AWGqI"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566DB4D12B;
	Wed, 10 Jan 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id E2D9B2997DA;
	Wed, 10 Jan 2024 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1704907394;
	bh=qsDFAv93tu0XrFFcOWZhPLu9VlWsI+eQCLQ6AKV/vgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ab8AWGqIod2UVn0PU6YsPL9vvuD3qMkhpVANQ0PjIzBItuIfQsorp4ubOErYrvAC3
	 0wJL50jUOR0QJs/SwWeHdzb/KvxBO6Gga97UiN2dPYO4PRoOZKwN3AuGv4oxm+pbLe
	 FdUARi04f1kbMx5AW9Qzv+jbwokEzG41uwbbSzXk=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/6] iio: pressure: hsc030pa add triggered buffer
Date: Wed, 10 Jan 2024 19:22:40 +0200
Message-ID: <20240110172306.31273-6-petre.rodan@subdimension.ro>
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

Add triggered buffer feature.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/hsc030pa.c | 42 +++++++++++++++++++++++++++++++++
 drivers/iio/pressure/hsc030pa.h |  2 +-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
index 7e3f74d53b47..3faa0fd42201 100644
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

@@ -297,6 +300,23 @@ static int hsc_get_measurement(struct hsc_data *data)
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
+	if (!ret) {
+		iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
+						   iio_get_time_ns(indio_dev));
+	}
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 /*
  * IIO ABI expects
  * value = (conv + offset) * scale
@@ -382,13 +402,30 @@ static const struct iio_chan_spec hsc_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 14,
+			.storagebits = 16,
+			.shift = 0,
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
@@ -485,6 +522,11 @@ int hsc_common_probe(struct device *dev, hsc_recv_fn recv)
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
index 56dc8e88194b..6c635c42d85d 100644
--- a/drivers/iio/pressure/hsc030pa.h
+++ b/drivers/iio/pressure/hsc030pa.h
@@ -56,7 +56,7 @@ struct hsc_data {
 	s32 p_scale_dec;
 	s64 p_offset;
 	s32 p_offset_dec;
-	u8 buffer[HSC_REG_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
+	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
 };

 struct hsc_chip_data {
--
2.41.0


