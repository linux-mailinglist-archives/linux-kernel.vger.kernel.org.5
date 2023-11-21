Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053797F2A22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjKUKSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjKUKR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:17:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344C1136
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:17:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C762CC433BB;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700561839;
        bh=2UVrdcO0muwBEBrUxXZmYaeSEgZfw994WYRynIcJKVA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=dC9GOjZcnEOitFG2oxzXOYWAs34uU6YPt7hanAx+69J4nBuZGB45EwXJfsrmsVjyB
         G/gDppEvQD3ZSH+eNjEf0RTcxiuocf8eJ/qBjKnnykD7EtBZL64vqM1Ge7R7Up88k4
         RZfohnHCcGK0aybTjbbcktxeUXiRupiHhbZgVCph/IgOVqXkPMZguklxAdHU2qY/XD
         WiCHdmbiojGwcnxpVgR76wXl6ka3LpmgpKbcp9x2OBsjh241DnXQ6QwNx8EphSuytx
         lTVf4A6rbmreKNQm9R1j95PrTHTGTNB6An2DGF3smQlw3eA93kgXPKQHzSbOSjxl70
         4tdr34hqceI/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id B643CC61D88;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
From:   Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date:   Tue, 21 Nov 2023 11:20:23 +0100
Subject: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700562016; l=15166;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Eq7e4pir873ISYA9fOUXbCVYvPsa2GwjrUl9ExaZa3g=;
 b=/ATgHhaFYBUX/e6U/yJCqqx2Y46Bt36VCEJ0Hp+q+myPbWd5wM37f0pT0DzNowkcEwh1Tkabb
 a8IIXDj2ULAAnvo3IV3Ydra8RsCAKjs8xfi2Oo0Zv5ABFf+vGBVAVVR
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nuno Sa <nuno.sa@analog.com>

Convert the driver to use the new IIO backend framework. The device
functionality is expected to be the same (meaning no added or removed
features).

Also note this patch effectively breaks ABI and that's needed so we can
properly support this device and add needed features making use of the
new IIO framework.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +-
 drivers/iio/adc/ad9467.c | 256 +++++++++++++++++++++++++++++------------------
 2 files changed, 157 insertions(+), 101 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1e2b7a2c67c6..af56df63beff 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -275,7 +275,7 @@ config AD799X
 config AD9467
 	tristate "Analog Devices AD9467 High Speed ADC driver"
 	depends on SPI
-	depends on ADI_AXI_ADC
+	select IIO_BACKEND
 	help
 	  Say yes here to build support for Analog Devices:
 	  * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 5db5690ccee8..8b0402e73ace 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -16,13 +16,13 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 
-
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
 #include <linux/clk.h>
 
-#include <linux/iio/adc/adi-axi-adc.h>
+#include <linux/iio/backend.h>
 
 /*
  * ADI High-Speed ADC common spi interface registers
@@ -102,15 +102,20 @@
 #define AD9467_REG_VREF_MASK		0x0F
 
 struct ad9467_chip_info {
-	struct adi_axi_adc_chip_info	axi_adc_info;
-	unsigned int			default_output_mode;
-	unsigned int			vref_mask;
+	const char		*name;
+	unsigned int		id;
+	const struct		iio_chan_spec *channels;
+	unsigned int		num_channels;
+	const unsigned int	(*scale_table)[2];
+	int			num_scales;
+	unsigned long		max_rate;
+	unsigned int		default_output_mode;
+	unsigned int		vref_mask;
 };
 
-#define to_ad9467_chip_info(_info)	\
-	container_of(_info, struct ad9467_chip_info, axi_adc_info)
-
 struct ad9467_state {
+	const struct ad9467_chip_info	*info;
+	struct iio_backend		*back;
 	struct spi_device		*spi;
 	struct clk			*clk;
 	unsigned int			output_mode;
@@ -151,10 +156,10 @@ static int ad9467_spi_write(struct spi_device *spi, unsigned int reg,
 	return spi_write(spi, buf, ARRAY_SIZE(buf));
 }
 
-static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
+static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	struct ad9467_state *st = iio_priv(indio_dev);
 	struct spi_device *spi = st->spi;
 	int ret;
 
@@ -191,14 +196,13 @@ static const unsigned int ad9467_scale_table[][2] = {
 	{2300, 8}, {2400, 9}, {2500, 10},
 };
 
-static void __ad9467_get_scale(struct adi_axi_adc_conv *conv, int index,
+static void __ad9467_get_scale(struct ad9467_state *st, int index,
 			       unsigned int *val, unsigned int *val2)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
-	const struct iio_chan_spec *chan = &info->channels[0];
+	const struct iio_chan_spec *chan = &st->info->channels[0];
 	unsigned int tmp;
 
-	tmp = (info->scale_table[index][0] * 1000000ULL) >>
+	tmp = (st->info->scale_table[index][0] * 1000000ULL) >>
 			chan->scan_type.realbits;
 	*val = tmp / 1000000;
 	*val2 = tmp % 1000000;
@@ -229,77 +233,66 @@ static const struct iio_chan_spec ad9467_channels[] = {
 };
 
 static const struct ad9467_chip_info ad9467_chip_tbl = {
-	.axi_adc_info = {
-		.name = "ad9467",
-		.id = CHIPID_AD9467,
-		.max_rate = 250000000UL,
-		.scale_table = ad9467_scale_table,
-		.num_scales = ARRAY_SIZE(ad9467_scale_table),
-		.channels = ad9467_channels,
-		.num_channels = ARRAY_SIZE(ad9467_channels),
-	},
+	.name = "ad9467",
+	.id = CHIPID_AD9467,
+	.max_rate = 250000000UL,
+	.scale_table = ad9467_scale_table,
+	.num_scales = ARRAY_SIZE(ad9467_scale_table),
+	.channels = ad9467_channels,
+	.num_channels = ARRAY_SIZE(ad9467_channels),
 	.default_output_mode = AD9467_DEF_OUTPUT_MODE,
 	.vref_mask = AD9467_REG_VREF_MASK,
 };
 
 static const struct ad9467_chip_info ad9434_chip_tbl = {
-	.axi_adc_info = {
-		.name = "ad9434",
-		.id = CHIPID_AD9434,
-		.max_rate = 500000000UL,
-		.scale_table = ad9434_scale_table,
-		.num_scales = ARRAY_SIZE(ad9434_scale_table),
-		.channels = ad9434_channels,
-		.num_channels = ARRAY_SIZE(ad9434_channels),
-	},
+	.name = "ad9434",
+	.id = CHIPID_AD9434,
+	.max_rate = 500000000UL,
+	.scale_table = ad9434_scale_table,
+	.num_scales = ARRAY_SIZE(ad9434_scale_table),
+	.channels = ad9434_channels,
+	.num_channels = ARRAY_SIZE(ad9434_channels),
 	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
 	.vref_mask = AD9434_REG_VREF_MASK,
 };
 
 static const struct ad9467_chip_info ad9265_chip_tbl = {
-	.axi_adc_info = {
-		.name = "ad9265",
-		.id = CHIPID_AD9265,
-		.max_rate = 125000000UL,
-		.scale_table = ad9265_scale_table,
-		.num_scales = ARRAY_SIZE(ad9265_scale_table),
-		.channels = ad9467_channels,
-		.num_channels = ARRAY_SIZE(ad9467_channels),
-	},
+	.name = "ad9265",
+	.id = CHIPID_AD9265,
+	.max_rate = 125000000UL,
+	.scale_table = ad9265_scale_table,
+	.num_scales = ARRAY_SIZE(ad9265_scale_table),
+	.channels = ad9467_channels,
+	.num_channels = ARRAY_SIZE(ad9467_channels),
 	.default_output_mode = AD9265_DEF_OUTPUT_MODE,
 	.vref_mask = AD9265_REG_VREF_MASK,
 };
 
-static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
+static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
-	const struct ad9467_chip_info *info1 = to_ad9467_chip_info(info);
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
 	unsigned int i, vref_val;
 
 	vref_val = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
 	if (vref_val < 0)
 		return vref_val;
 
-	vref_val &= info1->vref_mask;
+	vref_val &= st->info->vref_mask;
 
-	for (i = 0; i < info->num_scales; i++) {
-		if (vref_val == info->scale_table[i][1])
+	for (i = 0; i < st->info->num_scales; i++) {
+		if (vref_val == st->info->scale_table[i][1])
 			break;
 	}
 
-	if (i == info->num_scales)
+	if (i == st->info->num_scales)
 		return -ERANGE;
 
-	__ad9467_get_scale(conv, i, val, val2);
+	__ad9467_get_scale(st, i, val, val2);
 
 	return IIO_VAL_INT_PLUS_MICRO;
 }
 
-static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
+static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
 	unsigned int scale_val[2];
 	unsigned int i;
 	int ret;
@@ -307,14 +300,14 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 	if (val != 0)
 		return -EINVAL;
 
-	for (i = 0; i < info->num_scales; i++) {
-		__ad9467_get_scale(conv, i, &scale_val[0], &scale_val[1]);
+	for (i = 0; i < st->info->num_scales; i++) {
+		__ad9467_get_scale(st, i, &scale_val[0], &scale_val[1]);
 		if (scale_val[0] != val || scale_val[1] != val2)
 			continue;
 
 		guard(mutex)(&st->lock);
 		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
-				       info->scale_table[i][1]);
+				       st->info->scale_table[i][1]);
 		if (ret < 0)
 			return ret;
 
@@ -325,15 +318,15 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 	return -EINVAL;
 }
 
-static int ad9467_read_raw(struct adi_axi_adc_conv *conv,
+static int ad9467_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long m)
 {
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	struct ad9467_state *st = iio_priv(indio_dev);
 
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
-		return ad9467_get_scale(conv, val, val2);
+		return ad9467_get_scale(st, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = clk_get_rate(st->clk);
 
@@ -343,20 +336,19 @@ static int ad9467_read_raw(struct adi_axi_adc_conv *conv,
 	}
 }
 
-static int ad9467_write_raw(struct adi_axi_adc_conv *conv,
+static int ad9467_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	struct ad9467_state *st = iio_priv(indio_dev);
 	long r_clk;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		return ad9467_set_scale(conv, val, val2);
+		return ad9467_set_scale(st, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		r_clk = clk_round_rate(st->clk, val);
-		if (r_clk < 0 || r_clk > info->max_rate) {
+		if (r_clk < 0 || r_clk > st->info->max_rate) {
 			dev_warn(&st->spi->dev,
 				 "Error setting ADC sample rate %ld", r_clk);
 			return -EINVAL;
@@ -368,26 +360,53 @@ static int ad9467_write_raw(struct adi_axi_adc_conv *conv,
 	}
 }
 
-static int ad9467_read_avail(struct adi_axi_adc_conv *conv,
+static int ad9467_read_avail(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     const int **vals, int *type, int *length,
 			     long mask)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	struct ad9467_state *st = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		*vals = (const int *)st->scales;
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		/* Values are stored in a 2D matrix */
-		*length = info->num_scales * 2;
+		*length = st->info->num_scales * 2;
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
 }
 
+static int ad9467_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad9467_state *st = iio_priv(indio_dev);
+	unsigned int c;
+	int ret;
+
+	for (c = 0; c < st->info->num_channels; c++) {
+		if (test_bit(c, scan_mask))
+			ret = iio_backend_chan_enable(st->back, c);
+		else
+			ret = iio_backend_chan_disable(st->back, c);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct iio_info ad9467_info = {
+	.read_raw = ad9467_read_raw,
+	.write_raw = ad9467_write_raw,
+	.update_scan_mode = ad9467_update_scan_mode,
+	.debugfs_reg_access = ad9467_reg_access,
+	.read_avail = ad9467_read_avail,
+};
+
 static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
 {
 	int ret;
@@ -400,19 +419,17 @@ static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
 				AN877_ADC_TRANSFER_SYNC);
 }
 
-static int ad9467_scale_fill(struct adi_axi_adc_conv *conv)
+static int ad9467_scale_fill(struct ad9467_state *st)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
 	unsigned int i, val1, val2;
 
 	st->scales = devm_kcalloc(&st->spi->dev, ARRAY_SIZE(*st->scales),
-				  info->num_scales, GFP_KERNEL);
+				  st->info->num_scales, GFP_KERNEL);
 	if (!st->scales)
 		return -ENOMEM;
 
-	for (i = 0; i < info->num_scales * 2; i++) {
-		__ad9467_get_scale(conv, i, &val1, &val2);
+	for (i = 0; i < st->info->num_scales * 2; i++) {
+		__ad9467_get_scale(st, i, &val1, &val2);
 		st->scales[i][0] = val1;
 		st->scales[i][1] = val2;
 	}
@@ -420,11 +437,27 @@ static int ad9467_scale_fill(struct adi_axi_adc_conv *conv)
 	return 0;
 }
 
-static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
+static int ad9467_setup(struct ad9467_state *st)
 {
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	struct iio_backend_data_fmt data = {
+		.sign_extend = true,
+		.enable = true,
+	};
+	unsigned int c, mode;
+	int ret;
 
-	return ad9467_outputmode_set(st->spi, st->output_mode);
+	mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+	ret = ad9467_outputmode_set(st->spi, mode);
+	if (ret)
+		return ret;
+
+	for (c = 0; c < st->info->num_channels; c++) {
+		ret = iio_backend_data_format_set(st->back, c, &data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int ad9467_reset(struct device *dev)
@@ -444,25 +477,38 @@ static int ad9467_reset(struct device *dev)
 	return 0;
 }
 
+static int ad9467_buffer_get(struct iio_dev *indio_dev)
+{
+	struct device *dev = indio_dev->dev.parent;
+	const char *dma_name;
+
+	if (!device_property_present(dev, "dmas"))
+		return 0;
+
+	if (device_property_read_string(dev, "dma-names", &dma_name))
+		dma_name = "rx";
+
+	return devm_iio_dmaengine_buffer_setup(dev, indio_dev, dma_name);
+}
+
 static int ad9467_probe(struct spi_device *spi)
 {
-	const struct ad9467_chip_info *info;
-	struct adi_axi_adc_conv *conv;
+	struct iio_dev *indio_dev;
 	struct ad9467_state *st;
 	unsigned int id;
 	int ret;
 
-	info = spi_get_device_match_data(spi);
-	if (!info)
-		return -ENODEV;
-
-	conv = devm_adi_axi_adc_conv_register(&spi->dev, sizeof(*st));
-	if (IS_ERR(conv))
-		return PTR_ERR(conv);
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
 
-	st = adi_axi_adc_conv_priv(conv);
+	st = iio_priv(indio_dev);
 	st->spi = spi;
 
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODEV;
+
 	st->clk = devm_clk_get_enabled(&spi->dev, "adc-clk");
 	if (IS_ERR(st->clk))
 		return PTR_ERR(st->clk);
@@ -476,29 +522,39 @@ static int ad9467_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	conv->chip_info = &info->axi_adc_info;
-
-	ret = ad9467_scale_fill(conv);
+	ret = ad9467_scale_fill(st);
 	if (ret)
 		return ret;
 
 	id = ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
-	if (id != conv->chip_info->id) {
+	if (id != st->info->id) {
 		dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
-			id, conv->chip_info->id);
+			id, st->info->id);
 		return -ENODEV;
 	}
 
-	conv->reg_access = ad9467_reg_access;
-	conv->write_raw = ad9467_write_raw;
-	conv->read_raw = ad9467_read_raw;
-	conv->read_avail = ad9467_read_avail;
-	conv->preenable_setup = ad9467_preenable_setup;
+	indio_dev->name = st->info->name;
+	indio_dev->channels = st->info->channels;
+	indio_dev->num_channels = st->info->num_channels;
+	indio_dev->info = &ad9467_info;
+
+	ret = ad9467_buffer_get(indio_dev);
+	if (ret)
+		return ret;
 
-	st->output_mode = info->default_output_mode |
-			  AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+	st->back = devm_iio_backend_get(&spi->dev, NULL);
+	if (IS_ERR(st->back))
+		return PTR_ERR(st->back);
 
-	return 0;
+	ret = iio_backend_enable(st->back);
+	if (ret)
+		return ret;
+
+	ret = ad9467_setup(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id ad9467_of_match[] = {

-- 
2.42.1

