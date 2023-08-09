Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0773776AD5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjHIVO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjHITMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F68213F;
        Wed,  9 Aug 2023 12:11:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3177163aa97so186139f8f.0;
        Wed, 09 Aug 2023 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691608318; x=1692213118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bqzS9h0CgvDS8ZZVemKv+0rs4fFcra0nUU+EHxfMg4=;
        b=ouEQ/dqHXDWQ1ugDrj/OobcwSu+UbyqIw/aLn63KysFu4OKk+bMNS+gD1jzIG0n5dM
         O7IdOlNJtIga7gHjhKjwtP0AvtpN6r61BLMo8+OvlMKD4lFfrAnJhXLvY5C0j3FvqLZv
         KzQ4+6MJrJv2aHwPshJDwF9oRA4Sq9EQ4NKkw7dDv4GYXzmiFU7YXAl0BuoRlzX4F5iN
         NwtU3Ipow8SaDXlHulC/2mN3Tb0KZVAEl7ZIYqd52XCi03PXa/+1Fznm3Gb1F1Ns3PeK
         BuO8pZaZvseYqhD+xlbucFvhN0CHzvwNarrZgiYlHQAFH5RCuKAXzKqFDx6vGCrX1evS
         5CqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608318; x=1692213118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bqzS9h0CgvDS8ZZVemKv+0rs4fFcra0nUU+EHxfMg4=;
        b=BYRU7ob21sF4HPtCRE5/X6csJEzjsgfjhO3KraFDZqhD72QkCMWcUE598NBcEJCqX0
         YGqLC9VX0NX/Cv8NElkjKXg9ZJ5gnnbFdrUUiZ3HXM66XtsGBdDqYkp7VOyinBRckzx4
         6g8zypYM20KISfR8MxRGyHNqdXvht1W4XwmS/zEqZZ+AXfgt7pZa0YAecpqK5WRAmQgA
         y8sz5fT9s7oFhBZ+HxXzeCIHQbmE56zkQTTNH3djiu1/hgejqdu5+XFvicygtbPoppGG
         fZk3OiPtoIqSU6eZfBxK4YmaXSKyCr7077zQJ5FejbPyMHYB1rrXN+d6RFk+9uAIDtHW
         +S1g==
X-Gm-Message-State: AOJu0YxPX/8//0Yc8CsVCAM4LrzeMiCyEC5sWWGwDzE7+qFw48wpfIBK
        GGqVTsUXXQk+E/E/7rSZeNE=
X-Google-Smtp-Source: AGHT+IFz9tcHMBEg8sFq4fSNouhmtztMi6ZfTvgBJZ0KD3V9ve9IlyU/i8QEJC3h5HFTd/cCujKI0Q==
X-Received: by 2002:adf:fad1:0:b0:317:3dff:7189 with SMTP id a17-20020adffad1000000b003173dff7189mr184049wrs.66.1691608318140;
        Wed, 09 Aug 2023 12:11:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:bb2:6df0:64ae:3840:3a64:b26a])
        by smtp.gmail.com with ESMTPSA id f6-20020adfdb46000000b003177074f830sm17582681wrj.59.2023.08.09.12.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:11:57 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v7 5/7] iio: accel: kionix-kx022a: Refactor driver and add chip_info structure
Date:   Wed,  9 Aug 2023 21:11:36 +0200
Message-Id: <8fb74f21bda4949a862bcb4bb1ed4f0acb135948.1691607526.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1691607526.git.mehdi.djait.k@gmail.com>
References: <cover.1691607526.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the chip_info structure to the driver's private data to hold all
the device specific infos.
Refactor the kx022a driver implementation to make it more generic and
extensible.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v7:
- no changes

v6:
- placed chip_info after the regmap elemnt in kx022a_data struct to save
  memory as suggested by Andy
- added a check for the availability of chip_info for the SPI case as 
  suggested by Andy

v5:
- moved the "kfree" call to match the reverse of what happens in 
  kx022a_fifo_enable() as suggested by Matti and Jonathan
- used min_t, checked for availability of chip_info as suggested by Andy

v4:
- allocating and freeing the buffer moved to the kx022a_fifo{enable,
  disable} functions
- used the spi_get_device_match_data helper function

v3:
- added the change of the buffer's allocation in the __kx022a_fifo_flush
  to this patch
- added the chip_info to the struct kx022a_data

 drivers/iio/accel/kionix-kx022a-i2c.c |  17 +++-
 drivers/iio/accel/kionix-kx022a-spi.c |  13 ++-
 drivers/iio/accel/kionix-kx022a.c     | 116 ++++++++++++++++----------
 drivers/iio/accel/kionix-kx022a.h     |  52 +++++++++++-
 4 files changed, 146 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index b5a85ce3a891..c59558fc6493 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -15,6 +15,7 @@
 static int kx022a_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
+	const struct kx022a_chip_info *chip_info;
 	struct regmap *regmap;
 
 	if (!i2c->irq) {
@@ -22,22 +23,30 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 		return -EINVAL;
 	}
 
-	regmap = devm_regmap_init_i2c(i2c, &kx022a_regmap);
+	chip_info = device_get_match_data(&i2c->dev);
+	if (!chip_info) {
+		const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
+		chip_info = (const struct kx022a_chip_info *)id->driver_data;
+		if (!chip_info)
+			return -EINVAL;
+	}
+
+	regmap = devm_regmap_init_i2c(i2c, chip_info->regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to initialize Regmap\n");
 
-	return kx022a_probe_internal(dev);
+	return kx022a_probe_internal(dev, chip_info);
 }
 
 static const struct i2c_device_id kx022a_i2c_id[] = {
-	{ .name = "kx022a" },
+	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
 
 static const struct of_device_id kx022a_of_match[] = {
-	{ .compatible = "kionix,kx022a", },
+	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
index 9cd047f7b346..896b57866fc9 100644
--- a/drivers/iio/accel/kionix-kx022a-spi.c
+++ b/drivers/iio/accel/kionix-kx022a-spi.c
@@ -15,6 +15,7 @@
 static int kx022a_spi_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	const struct kx022a_chip_info *chip_info;
 	struct regmap *regmap;
 
 	if (!spi->irq) {
@@ -22,22 +23,26 @@ static int kx022a_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	regmap = devm_regmap_init_spi(spi, &kx022a_regmap);
+	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return -EINVAL;
+
+	regmap = devm_regmap_init_spi(spi, chip_info->regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to initialize Regmap\n");
 
-	return kx022a_probe_internal(dev);
+	return kx022a_probe_internal(dev, chip_info);
 }
 
 static const struct spi_device_id kx022a_id[] = {
-	{ "kx022a" },
+	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, kx022a_id);
 
 static const struct of_device_id kx022a_of_match[] = {
-	{ .compatible = "kionix,kx022a", },
+	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 494e81ba1da9..0bab3f109e4e 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -48,7 +48,7 @@ enum {
 	KX022A_STATE_FIFO,
 };
 
-/* Regmap configs */
+/* kx022a Regmap configs */
 static const struct regmap_range kx022a_volatile_ranges[] = {
 	{
 		.range_min = KX022A_REG_XHP_L,
@@ -138,7 +138,7 @@ static const struct regmap_access_table kx022a_nir_regs = {
 	.n_yes_ranges = ARRAY_SIZE(kx022a_noinc_read_ranges),
 };
 
-const struct regmap_config kx022a_regmap = {
+static const struct regmap_config kx022a_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.volatile_table = &kx022a_volatile_regs,
@@ -149,10 +149,10 @@ const struct regmap_config kx022a_regmap = {
 	.max_register = KX022A_MAX_REGISTER,
 	.cache_type = REGCACHE_RBTREE,
 };
-EXPORT_SYMBOL_NS_GPL(kx022a_regmap, IIO_KX022A);
 
 struct kx022a_data {
 	struct regmap *regmap;
+	const struct kx022a_chip_info *chip_info;
 	struct iio_trigger *trig;
 	struct device *dev;
 	struct iio_mount_matrix orientation;
@@ -175,6 +175,8 @@ struct kx022a_data {
 	struct mutex mutex;
 	u8 watermark;
 
+	__le16 *fifo_buffer;
+
 	/* 3 x 16bit accel data + timestamp */
 	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
 	struct {
@@ -208,7 +210,7 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
 	{ }
 };
 
-#define KX022A_ACCEL_CHAN(axis, index)				\
+#define KX022A_ACCEL_CHAN(axis, reg, index)			\
 {								\
 	.type = IIO_ACCEL,					\
 	.modified = 1,						\
@@ -220,7 +222,7 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
 				BIT(IIO_CHAN_INFO_SCALE) |	\
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.ext_info = kx022a_ext_info,				\
-	.address = KX022A_REG_##axis##OUT_L,			\
+	.address = reg,						\
 	.scan_index = index,					\
 	.scan_type = {                                          \
 		.sign = 's',					\
@@ -231,9 +233,9 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
 }
 
 static const struct iio_chan_spec kx022a_channels[] = {
-	KX022A_ACCEL_CHAN(X, 0),
-	KX022A_ACCEL_CHAN(Y, 1),
-	KX022A_ACCEL_CHAN(Z, 2),
+	KX022A_ACCEL_CHAN(X, KX022A_REG_XOUT_L, 0),
+	KX022A_ACCEL_CHAN(Y, KX022A_REG_YOUT_L, 1),
+	KX022A_ACCEL_CHAN(Z, KX022A_REG_ZOUT_L, 2),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
@@ -332,10 +334,10 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
 	int ret;
 
 	if (on)
-		ret = regmap_set_bits(data->regmap, KX022A_REG_CNTL,
+		ret = regmap_set_bits(data->regmap, data->chip_info->cntl,
 				      KX022A_MASK_PC1);
 	else
-		ret = regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
+		ret = regmap_clear_bits(data->regmap, data->chip_info->cntl,
 					KX022A_MASK_PC1);
 	if (ret)
 		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
@@ -402,7 +404,7 @@ static int kx022a_write_raw(struct iio_dev *idev,
 			break;
 
 		ret = regmap_update_bits(data->regmap,
-					 KX022A_REG_ODCNTL,
+					 data->chip_info->odcntl,
 					 KX022A_MASK_ODR, n);
 		data->odr_ns = kx022a_odrs[n];
 		kx022a_turn_on_unlock(data);
@@ -423,7 +425,7 @@ static int kx022a_write_raw(struct iio_dev *idev,
 		if (ret)
 			break;
 
-		ret = regmap_update_bits(data->regmap, KX022A_REG_CNTL,
+		ret = regmap_update_bits(data->regmap, data->chip_info->cntl,
 					 KX022A_MASK_GSEL,
 					 n << KX022A_GSEL_SHIFT);
 		kx022a_turn_on_unlock(data);
@@ -445,7 +447,7 @@ static int kx022a_fifo_set_wmi(struct kx022a_data *data)
 
 	threshold = data->watermark;
 
-	return regmap_update_bits(data->regmap, KX022A_REG_BUF_CNTL1,
+	return regmap_update_bits(data->regmap, data->chip_info->buf_cntl1,
 				  KX022A_MASK_WM_TH, threshold);
 }
 
@@ -488,7 +490,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
 		return ret;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = regmap_read(data->regmap, KX022A_REG_ODCNTL, &regval);
+		ret = regmap_read(data->regmap, data->chip_info->odcntl, &regval);
 		if (ret)
 			return ret;
 
@@ -503,7 +505,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
 		return IIO_VAL_INT_PLUS_MICRO;
 
 	case IIO_CHAN_INFO_SCALE:
-		ret = regmap_read(data->regmap, KX022A_REG_CNTL, &regval);
+		ret = regmap_read(data->regmap, data->chip_info->cntl, &regval);
 		if (ret < 0)
 			return ret;
 
@@ -530,8 +532,7 @@ static int kx022a_set_watermark(struct iio_dev *idev, unsigned int val)
 {
 	struct kx022a_data *data = iio_priv(idev);
 
-	if (val > KX022A_FIFO_LENGTH)
-		val = KX022A_FIFO_LENGTH;
+	val = min_t(unsigned int, data->chip_info->fifo_length, val);
 
 	mutex_lock(&data->mutex);
 	data->watermark = val;
@@ -592,7 +593,7 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
 	 */
 	data->timestamp = 0;
 
-	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0x0);
+	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
 }
 
 static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
@@ -600,7 +601,6 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 {
 	struct kx022a_data *data = iio_priv(idev);
 	struct device *dev = regmap_get_device(data->regmap);
-	__le16 buffer[KX022A_FIFO_LENGTH * 3];
 	uint64_t sample_period;
 	int count, fifo_bytes;
 	bool renable = false;
@@ -679,13 +679,13 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 	}
 
 	fifo_bytes = count * KX022A_FIFO_SAMPLES_SIZE_BYTES;
-	ret = regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
-				&buffer[0], fifo_bytes);
+	ret = regmap_noinc_read(data->regmap, data->chip_info->buf_read,
+				data->fifo_buffer, fifo_bytes);
 	if (ret)
 		goto renable_out;
 
 	for (i = 0; i < count; i++) {
-		__le16 *sam = &buffer[i * 3];
+		__le16 *sam = &data->fifo_buffer[i * 3];
 		__le16 *chs;
 		int bit;
 
@@ -732,10 +732,10 @@ static const struct iio_info kx022a_info = {
 static int kx022a_set_drdy_irq(struct kx022a_data *data, bool en)
 {
 	if (en)
-		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
+		return regmap_set_bits(data->regmap, data->chip_info->cntl,
 				       KX022A_MASK_DRDY);
 
-	return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
+	return regmap_clear_bits(data->regmap, data->chip_info->cntl,
 				 KX022A_MASK_DRDY);
 }
 
@@ -770,7 +770,7 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
 	if (ret)
 		goto unlock_out;
 
-	ret = regmap_clear_bits(data->regmap, KX022A_REG_BUF_CNTL2,
+	ret = regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
 				KX022A_MASK_BUF_EN);
 	if (ret)
 		goto unlock_out;
@@ -779,6 +779,8 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
 
 	kx022a_drop_fifo_contents(data);
 
+	kfree(data->fifo_buffer);
+
 	return kx022a_turn_on_unlock(data);
 
 unlock_out:
@@ -801,6 +803,11 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
 {
 	int ret;
 
+	data->fifo_buffer = kmalloc(data->chip_info->fifo_length *
+				    KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);
+	if (!data->fifo_buffer)
+		return -ENOMEM;
+
 	ret = kx022a_turn_off_lock(data);
 	if (ret)
 		return ret;
@@ -811,7 +818,7 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
 		goto unlock_out;
 
 	/* Enable buffer */
-	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
+	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
 			      KX022A_MASK_BUF_EN);
 	if (ret)
 		goto unlock_out;
@@ -857,7 +864,7 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
 	struct kx022a_data *data = iio_priv(idev);
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, KX022A_REG_XOUT_L, data->buffer,
+	ret = regmap_bulk_read(data->regmap, data->chip_info->xout_l, data->buffer,
 			       KX022A_FIFO_SAMPLES_SIZE_BYTES);
 	if (ret < 0)
 		goto err_read;
@@ -905,7 +912,7 @@ static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
 	if (data->state & KX022A_STATE_FIFO) {
 		int ok;
 
-		ok = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
+		ok = __kx022a_fifo_flush(idev, data->chip_info->fifo_length, true);
 		if (ok > 0)
 			ret = IRQ_HANDLED;
 	}
@@ -958,7 +965,7 @@ static int kx022a_chip_init(struct kx022a_data *data)
 	int ret, val;
 
 	/* Reset the senor */
-	ret = regmap_write(data->regmap, KX022A_REG_CNTL2, KX022A_MASK_SRST);
+	ret = regmap_write(data->regmap, data->chip_info->cntl2, KX022A_MASK_SRST);
 	if (ret)
 		return ret;
 
@@ -968,7 +975,7 @@ static int kx022a_chip_init(struct kx022a_data *data)
 	 */
 	msleep(1);
 
-	ret = regmap_read_poll_timeout(data->regmap, KX022A_REG_CNTL2, val,
+	ret = regmap_read_poll_timeout(data->regmap, data->chip_info->cntl2, val,
 				       !(val & KX022A_MASK_SRST),
 				       KX022A_SOFT_RESET_WAIT_TIME_US,
 				       KX022A_SOFT_RESET_TOTAL_WAIT_TIME_US);
@@ -978,14 +985,14 @@ static int kx022a_chip_init(struct kx022a_data *data)
 		return ret;
 	}
 
-	ret = regmap_reinit_cache(data->regmap, &kx022a_regmap);
+	ret = regmap_reinit_cache(data->regmap, data->chip_info->regmap_config);
 	if (ret) {
 		dev_err(data->dev, "Failed to reinit reg cache\n");
 		return ret;
 	}
 
 	/* set data res 16bit */
-	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
+	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
 			      KX022A_MASK_BRES16);
 	if (ret) {
 		dev_err(data->dev, "Failed to set data resolution\n");
@@ -995,7 +1002,31 @@ static int kx022a_chip_init(struct kx022a_data *data)
 	return kx022a_prepare_irq_pin(data);
 }
 
-int kx022a_probe_internal(struct device *dev)
+const struct kx022a_chip_info kx022a_chip_info = {
+	.name		  = "kx022-accel",
+	.regmap_config	  = &kx022a_regmap_config,
+	.channels	  = kx022a_channels,
+	.num_channels	  = ARRAY_SIZE(kx022a_channels),
+	.fifo_length	  = KX022A_FIFO_LENGTH,
+	.who		  = KX022A_REG_WHO,
+	.id		  = KX022A_ID,
+	.cntl		  = KX022A_REG_CNTL,
+	.cntl2		  = KX022A_REG_CNTL2,
+	.odcntl		  = KX022A_REG_ODCNTL,
+	.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
+	.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
+	.buf_clear	  = KX022A_REG_BUF_CLEAR,
+	.buf_status1	  = KX022A_REG_BUF_STATUS_1,
+	.buf_read	  = KX022A_REG_BUF_READ,
+	.inc1		  = KX022A_REG_INC1,
+	.inc4		  = KX022A_REG_INC4,
+	.inc5		  = KX022A_REG_INC5,
+	.inc6		  = KX022A_REG_INC6,
+	.xout_l		  = KX022A_REG_XOUT_L,
+};
+EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
+
+int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info)
 {
 	static const char * const regulator_names[] = {"io-vdd", "vdd"};
 	struct iio_trigger *indio_trig;
@@ -1022,6 +1053,7 @@ int kx022a_probe_internal(struct device *dev)
 		return -ENOMEM;
 
 	data = iio_priv(idev);
+	data->chip_info = chip_info;
 
 	/*
 	 * VDD is the analog and digital domain voltage supply and
@@ -1032,24 +1064,24 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret && ret != -ENODEV)
 		return dev_err_probe(dev, ret, "failed to enable regulator\n");
 
-	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
+	ret = regmap_read(regmap, chip_info->who, &chip_id);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to access sensor\n");
 
-	if (chip_id != KX022A_ID)
+	if (chip_id != chip_info->id)
 		dev_warn(dev, "unknown device 0x%x\n", chip_id);
 
 	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (irq > 0) {
-		data->inc_reg = KX022A_REG_INC1;
-		data->ien_reg = KX022A_REG_INC4;
+		data->inc_reg = chip_info->inc1;
+		data->ien_reg = chip_info->inc4;
 	} else {
 		irq = fwnode_irq_get_byname(fwnode, "INT2");
 		if (irq <= 0)
 			return dev_err_probe(dev, irq, "No suitable IRQ\n");
 
-		data->inc_reg = KX022A_REG_INC5;
-		data->ien_reg = KX022A_REG_INC6;
+		data->inc_reg = chip_info->inc5;
+		data->ien_reg = chip_info->inc6;
 	}
 
 	data->regmap = regmap;
@@ -1058,9 +1090,9 @@ int kx022a_probe_internal(struct device *dev)
 	data->odr_ns = KX022A_DEFAULT_PERIOD_NS;
 	mutex_init(&data->mutex);
 
-	idev->channels = kx022a_channels;
-	idev->num_channels = ARRAY_SIZE(kx022a_channels);
-	idev->name = "kx022-accel";
+	idev->channels = chip_info->channels;
+	idev->num_channels = chip_info->num_channels;
+	idev->name = chip_info->name;
 	idev->info = &kx022a_info;
 	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	idev->available_scan_masks = kx022a_scan_masks;
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index 12424649d438..0e5026019213 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -76,7 +76,55 @@
 
 struct device;
 
-int kx022a_probe_internal(struct device *dev);
-extern const struct regmap_config kx022a_regmap;
+/**
+ * struct kx022a_chip_info - Kionix accelerometer chip specific information
+ *
+ * @name:		name of the device
+ * @regmap_config:	pointer to register map configuration
+ * @channels:		pointer to iio_chan_spec array
+ * @num_channels:	number of iio_chan_spec channels
+ * @fifo_length:	number of 16-bit samples in a full buffer
+ * @who:		WHO_AM_I register
+ * @id:			WHO_AM_I register value
+ * @cntl:		control register 1
+ * @cntl2:		control register 2
+ * @odcntl:		output data control register
+ * @buf_cntl1:		buffer control register 1
+ * @buf_cntl2:		buffer control register 2
+ * @buf_clear:		buffer clear register
+ * @buf_status1:	buffer status register 1
+ * @buf_read:		buffer read register
+ * @inc1:		interrupt control register 1
+ * @inc4:		interrupt control register 4
+ * @inc5:		interrupt control register 5
+ * @inc6:		interrupt control register 6
+ * @xout_l:		x-axis output least significant byte
+ */
+struct kx022a_chip_info {
+	const char *name;
+	const struct regmap_config *regmap_config;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+	unsigned int fifo_length;
+	u8 who;
+	u8 id;
+	u8 cntl;
+	u8 cntl2;
+	u8 odcntl;
+	u8 buf_cntl1;
+	u8 buf_cntl2;
+	u8 buf_clear;
+	u8 buf_status1;
+	u8 buf_read;
+	u8 inc1;
+	u8 inc4;
+	u8 inc5;
+	u8 inc6;
+	u8 xout_l;
+};
+
+int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
+
+extern const struct kx022a_chip_info kx022a_chip_info;
 
 #endif
-- 
2.30.2

