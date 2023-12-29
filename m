Return-Path: <linux-kernel+bounces-13035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12D81FEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FA628179E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9A712B98;
	Fri, 29 Dec 2023 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="jVcZo+Kq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E2811736;
	Fri, 29 Dec 2023 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id BB45A28B596;
	Fri, 29 Dec 2023 09:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703841909;
	bh=akQy0eNST9HQO0Ptl17uHVfMO9+tHIXtxlAzCJyC6XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jVcZo+KqlVWn4jUf1spWjrk4er3QmBucmlqknHhIaONBIFQHrbOnmZ2wf45mGvXrV
	 +inYKmz+DsCGtryl1liB3MxbryGg/7I7OFhax+u4hNev7ygpjz2S6A8ITP93w7OZfu
	 DraSC1ZwPVloqutACRzq+w53XmSVqli8sg6QkP/k=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v3 09/10] iio: pressure: mprls0025pa add triplet property
Date: Fri, 29 Dec 2023 11:24:37 +0200
Message-ID: <20231229092445.30180-10-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231229092445.30180-1-petre.rodan@subdimension.ro>
References: <20231229092445.30180-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add honeywell,pressure-triplet property that automatically initializes
pmin-pascal, pmax-pascal so that the user is not required to look-up
the chip in the datasheet and convert various units to pascals himself.

Co-developed-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2 -> v3 no changes

 drivers/iio/pressure/mprls0025pa.c | 105 ++++++++++++++++++++++++++---
 1 file changed, 97 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index ce20cf362fac..33a15d4c642c 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -80,6 +80,78 @@ static const struct mpr_func_spec mpr_func_spec[] = {
 	[MPR_FUNCTION_C] = { .output_min = 3355443, .output_max = 13421773 },
 };

+enum mpr_variants {
+	MPR0001BA = 0x00, MPR01_6BA = 0x01, MPR02_5BA = 0x02, MPR0060MG = 0x03,
+	MPR0100MG = 0x04, MPR0160MG = 0x05, MPR0250MG = 0x06, MPR0400MG = 0x07,
+	MPR0600MG = 0x08, MPR0001BG = 0x09, MPR01_6BG = 0x0a, MPR02_5BG = 0x0b,
+	MPR0100KA = 0x0c, MPR0160KA = 0x0d, MPR0250KA = 0x0e, MPR0006KG = 0x0f,
+	MPR0010KG = 0x10, MPR0016KG = 0x11, MPR0025KG = 0x12, MPR0040KG = 0x13,
+	MPR0060KG = 0x14, MPR0100KG = 0x15, MPR0160KG = 0x16, MPR0250KG = 0x17,
+	MPR0015PA = 0x18, MPR0025PA = 0x19, MPR0030PA = 0x1a, MPR0001PG = 0x1b,
+	MPR0005PG = 0x1c, MPR0015PG = 0x1d, MPR0030PG = 0x1e, MPR0300YG = 0x1f,
+	MPR_VARIANTS_MAX
+};
+
+static const char * const mpr_triplet_variants[MPR_VARIANTS_MAX] = {
+	[MPR0001BA] = "0001BA", [MPR01_6BA] = "01.6BA", [MPR02_5BA] = "02.5BA",
+	[MPR0060MG] = "0060MG", [MPR0100MG] = "0100MG", [MPR0160MG] = "0160MG",
+	[MPR0250MG] = "0250MG", [MPR0400MG] = "0400MG", [MPR0600MG] = "0600MG",
+	[MPR0001BG] = "0001BG", [MPR01_6BG] = "01.6BG", [MPR02_5BG] = "02.5BG",
+	[MPR0100KA] = "0100KA", [MPR0160KA] = "0160KA", [MPR0250KA] = "0250KA",
+	[MPR0006KG] = "0006KG", [MPR0010KG] = "0010KG", [MPR0016KG] = "0016KG",
+	[MPR0025KG] = "0025KG", [MPR0040KG] = "0040KG", [MPR0060KG] = "0060KG",
+	[MPR0100KG] = "0100KG", [MPR0160KG] = "0160KG", [MPR0250KG] = "0250KG",
+	[MPR0015PA] = "0015PA", [MPR0025PA] = "0025PA", [MPR0030PA] = "0030PA",
+	[MPR0001PG] = "0001PG", [MPR0005PG] = "0005PG", [MPR0015PG] = "0015PG",
+	[MPR0030PG] = "0030PG", [MPR0300YG] = "0300YG"
+};
+
+/**
+ * struct mpr_range_config - list of pressure ranges based on nomenclature
+ * @pmin: lowest pressure that can be measured
+ * @pmax: highest pressure that can be measured
+ */
+struct mpr_range_config {
+	const s32 pmin;
+	const s32 pmax;
+};
+
+/* All min max limits have been converted to pascals */
+static const struct mpr_range_config mpr_range_config[MPR_VARIANTS_MAX] = {
+	[MPR0001BA] = { .pmin = 0, .pmax = 100000 },
+	[MPR01_6BA] = { .pmin = 0, .pmax = 160000 },
+	[MPR02_5BA] = { .pmin = 0, .pmax = 250000 },
+	[MPR0060MG] = { .pmin = 0, .pmax =   6000 },
+	[MPR0100MG] = { .pmin = 0, .pmax =  10000 },
+	[MPR0160MG] = { .pmin = 0, .pmax =  16000 },
+	[MPR0250MG] = { .pmin = 0, .pmax =  25000 },
+	[MPR0400MG] = { .pmin = 0, .pmax =  40000 },
+	[MPR0600MG] = { .pmin = 0, .pmax =  60000 },
+	[MPR0001BG] = { .pmin = 0, .pmax = 100000 },
+	[MPR01_6BG] = { .pmin = 0, .pmax = 160000 },
+	[MPR02_5BG] = { .pmin = 0, .pmax = 250000 },
+	[MPR0100KA] = { .pmin = 0, .pmax = 100000 },
+	[MPR0160KA] = { .pmin = 0, .pmax = 160000 },
+	[MPR0250KA] = { .pmin = 0, .pmax = 250000 },
+	[MPR0006KG] = { .pmin = 0, .pmax =   6000 },
+	[MPR0010KG] = { .pmin = 0, .pmax =  10000 },
+	[MPR0016KG] = { .pmin = 0, .pmax =  16000 },
+	[MPR0025KG] = { .pmin = 0, .pmax =  25000 },
+	[MPR0040KG] = { .pmin = 0, .pmax =  40000 },
+	[MPR0060KG] = { .pmin = 0, .pmax =  60000 },
+	[MPR0100KG] = { .pmin = 0, .pmax = 100000 },
+	[MPR0160KG] = { .pmin = 0, .pmax = 160000 },
+	[MPR0250KG] = { .pmin = 0, .pmax = 250000 },
+	[MPR0015PA] = { .pmin = 0, .pmax = 103421 },
+	[MPR0025PA] = { .pmin = 0, .pmax = 172369 },
+	[MPR0030PA] = { .pmin = 0, .pmax = 206843 },
+	[MPR0001PG] = { .pmin = 0, .pmax =   6895 },
+	[MPR0005PG] = { .pmin = 0, .pmax =  34474 },
+	[MPR0015PG] = { .pmin = 0, .pmax = 103421 },
+	[MPR0030PG] = { .pmin = 0, .pmax = 206843 },
+	[MPR0300YG] = { .pmin = 0, .pmax =  39997 }
+};
+
 static const struct iio_chan_spec mpr_channels[] = {
 	{
 		.type = IIO_PRESSURE,
@@ -257,6 +329,7 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 	int ret;
 	struct mpr_data *data;
 	struct iio_dev *indio_dev;
+	const char *triplet;
 	s64 scale, offset;
 	u32 func;

@@ -298,16 +371,32 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 				     "honeywell,transfer-function %d invalid\n",
 				     data->function);

-	ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
-				       &data->pmin);
-	if (ret)
-		return dev_err_probe(dev, ret,
+	ret = device_property_read_string(dev, "honeywell,pressure-triplet",
+					  &triplet);
+	if (ret) {
+		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
+					       &data->pmin);
+		if (ret)
+			return dev_err_probe(dev, ret,
 				   "honeywell,pmin-pascal could not be read\n");
-	ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
-				       &data->pmax);
-	if (ret)
-		return dev_err_probe(dev, ret,
+
+		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
+					       &data->pmax);
+		if (ret)
+			return dev_err_probe(dev, ret,
 				   "honeywell,pmax-pascal could not be read\n");
+	} else {
+		ret = device_property_match_property_string(dev,
+						   "honeywell,pressure-triplet",
+						   mpr_triplet_variants,
+						   MPR_VARIANTS_MAX);
+		if (ret < 0)
+			return dev_err_probe(dev, -EINVAL,
+				     "honeywell,pressure-triplet is invalid\n");
+
+		data->pmin = mpr_range_config[ret].pmin;
+		data->pmax = mpr_range_config[ret].pmax;
+	}

 	if (data->pmin >= data->pmax)
 		return dev_err_probe(dev, -EINVAL,
--
2.41.0


