Return-Path: <linux-kernel+bounces-41264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D3783EE32
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C09E2B223F1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4422D04F;
	Sat, 27 Jan 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="kvDN6o1x"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1C2942C;
	Sat, 27 Jan 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706371463; cv=none; b=VLs2Omsh0o4lVVoNx6kI+H38glOZEm19nH6fCHFDNBBVifQcgGdbmZJOOmXNjmvpEtTeh3Bvhu2rXv77Sbtk0W2uA716c3xyxXXH+iXPNjPZB/EEK3DSkov5lxYJzPsS9a1fLMyZR8MSxkVhL12o1aPla+xb7tmgW4OtrNIWNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706371463; c=relaxed/simple;
	bh=uNZlNH68NOdUs670gUg9HFrHubxtW5W3+AmCbfDPYuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJ6oHeto8cB2SRs9zi0q6nqsdIbFqUFUTuafSYfVoOnuur4WfvMIHs4KFV1BDOfhKL1eAk7sNe7+o16e9pqDLG2uurqjEpfSSCxlBrP9R6Tm8mAmyOp/eeKNxsAwfS1ye6PDviYGVVIxOvhYfuAns1cqTS2mWV57m0TybmiOOho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=kvDN6o1x; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.80.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id F262E293A97;
	Sat, 27 Jan 2024 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1706371453;
	bh=uNZlNH68NOdUs670gUg9HFrHubxtW5W3+AmCbfDPYuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kvDN6o1xB6Wxq1AT7VFZbgxjX5ROejk/V6uzeRrvVQivZDZfpFEhC3jg1pb0bXnR5
	 XV7FPaolSgR14vAT0sgeFOXWfAlKex1BVARPQF1ffJcInh/DDbFS6caoIyUAHQyFdH
	 41UL6EBdeCqVNJWFN5dLJop+eh0+VwD1DMf6kyLY=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 4/4] iio: pressure: hsc030pa add triggered buffer
Date: Sat, 27 Jan 2024 18:03:58 +0200
Message-ID: <20240127160405.19696-5-petre.rodan@subdimension.ro>
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

Add triggered buffer feature.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 add Kconfig select for IIO_*BUFFER
         a few changes based on Jonathan's review
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
index 7e3f74d53b47..f8bddcdf5056 100644
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
+	memcpy(&data->scan.chan[0], &data->buffer, 2);
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


