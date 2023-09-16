Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751BF7A303C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbjIPMj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239249AbjIPMjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:39:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C598CED;
        Sat, 16 Sep 2023 05:39:18 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50300e9e75bso814641e87.1;
        Sat, 16 Sep 2023 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694867957; x=1695472757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIvTR78Gg1PPgLqvHiZjf3eT74tJdHxgcaMgCqHD5ZQ=;
        b=LUqzYOP7iWo4jQaexwNhai/82mCOjX3eaaT7F7aWMPWMKcnXPU5IWYGjr9SkQsQeOm
         Au0cuppgS99E2/Gd1LKfDVdwW2I6gSabeDWtRPu2zZdbULh2eymqiv8EOFhyCEc6AQnQ
         qNErfbq1exUHV2g0C6w2YAoj/eoGmnkUx/LBujPsV+vwIAt+NiTafoteDh4uW1djZKKH
         J3PHDlUv1aS1T+w/fVEGcmX1D4BQzM/K43tXP+8Il1hz5PjpPsAe6Rerv26F8ykS/Rmb
         /BhA5G2VfD5cq5Gxwd526ustAeCtOlM5pr+q9qvQ5LiKA0nnWFiYkzpKPpqmURUcgLLS
         1Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694867957; x=1695472757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIvTR78Gg1PPgLqvHiZjf3eT74tJdHxgcaMgCqHD5ZQ=;
        b=exkclOyk2GyeBBR+MYKKAOn3CyLnNp0QfBqJrIAmzK0faRmWfG1BfUk1jWcHUkC0z1
         U0y/JDDdf6JUoBD29A9d1ZF1onbAxyU9W/g117OJfI3TVcURM9nf1bQFe2t2E32ZwGZS
         qcZHtH8kQHxpc6wEnJFfAY2T3o1mmv5FttCzg8MbQBmbxz/QdSFpO/Q5KOVHnv804Mi2
         8fa9i4kXH3H/NDqA7uCIWJiN+dri29zfLOg9XXSPSmazv/m7NPtIhscBa114hDlbP/nS
         5GX/zFOSxYf+mNjuKntXUC1u1Uh3TCMIcbiTlui+p+riAdKNJrFcY5Fpp62esEvVD40O
         RmIQ==
X-Gm-Message-State: AOJu0YzUHiUzH5IBkHFJwWgcsPolHPT0ot0uk8/I4UbDV5c6cvEzzR+p
        6E7VND73i9qDULrZpD6c80c=
X-Google-Smtp-Source: AGHT+IEOrN+Mdy8FrNcz0c64QEmsn51oPhGTtsO4HS+iNdvWM4WM2gQA7tgvINN8ADEQMaCh1kNz/A==
X-Received: by 2002:a19:6714:0:b0:500:b8a3:1bf1 with SMTP id b20-20020a196714000000b00500b8a31bf1mr3521460lfc.43.1694867956622;
        Sat, 16 Sep 2023 05:39:16 -0700 (PDT)
Received: from localhost.localdomain ([77.134.181.150])
        by smtp.gmail.com with ESMTPSA id bo6-20020a0564020b2600b0052284228e3bsm3474064edb.8.2023.09.16.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 05:39:16 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v9 7/7] iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer
Date:   Sat, 16 Sep 2023 14:38:53 +0200
Message-Id: <389a7d6100ff2e71b1c5d60bebe662d09435996a.1694867379.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1694867379.git.mehdi.djait.k@gmail.com>
References: <cover.1694867379.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
ranges from ±2G to ±16G, digital output through I²C/SPI.
Add support for basic accelerometer features such as reading acceleration
via IIO using raw reads, triggered buffer (data-ready), or the WMI IRQ.

Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 drivers/iio/accel/Kconfig             |  10 +-
 drivers/iio/accel/kionix-kx022a-i2c.c |   2 +
 drivers/iio/accel/kionix-kx022a-spi.c |   2 +
 drivers/iio/accel/kionix-kx022a.c     | 164 ++++++++++++++++++++++++++
 drivers/iio/accel/kionix-kx022a.h     |  54 +++++++++
 5 files changed, 228 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index b6b45d359f28..373257d64a7e 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -418,8 +418,9 @@ config IIO_KX022A_SPI
 	select IIO_KX022A
 	select REGMAP_SPI
 	help
-	  Enable support for the Kionix KX022A digital tri-axis
-	  accelerometer connected to I2C interface.
+	  Enable support for the Kionix digital tri-axis accelerometers
+	  connected to SPI interface. Supported devices are:
+	    KX022A, KX132-1211
 
 config IIO_KX022A_I2C
 	tristate "Kionix KX022A tri-axis digital accelerometer I2C interface"
@@ -427,8 +428,9 @@ config IIO_KX022A_I2C
 	select IIO_KX022A
 	select REGMAP_I2C
 	help
-	  Enable support for the Kionix KX022A digital tri-axis
-	  accelerometer connected to I2C interface.
+	  Enable support for the Kionix digital tri-axis accelerometers
+	  connected to I2C interface. Supported devices are:
+	    KX022A, KX132-1211
 
 config KXSD9
 	tristate "Kionix KXSD9 Accelerometer Driver"
diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index 2fdc4c1ab93f..fc53e527cae0 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -37,12 +37,14 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 
 static const struct i2c_device_id kx022a_i2c_id[] = {
 	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
+	{ .name = "kx132-1211", .driver_data = (kernel_ulong_t)&kx132_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
 
 static const struct of_device_id kx022a_of_match[] = {
 	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
+	{ .compatible = "kionix,kx132-1211", .data = &kx132_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
index c21494ade157..e7878ba67827 100644
--- a/drivers/iio/accel/kionix-kx022a-spi.c
+++ b/drivers/iio/accel/kionix-kx022a-spi.c
@@ -37,12 +37,14 @@ static int kx022a_spi_probe(struct spi_device *spi)
 
 static const struct spi_device_id kx022a_id[] = {
 	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
+	{ .name = "kx132-1211", .driver_data = (kernel_ulong_t)&kx132_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, kx022a_id);
 
 static const struct of_device_id kx022a_of_match[] = {
 	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
+	{ .compatible = "kionix,kx132-1211", .data = &kx132_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index cc7134b1183b..c5b555094e60 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -150,6 +150,117 @@ static const struct regmap_config kx022a_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+/* Regmap configs kx132 */
+static const struct regmap_range kx132_volatile_ranges[] = {
+	{
+		.range_min = KX132_REG_XADP_L,
+		.range_max = KX132_REG_COTR,
+	}, {
+		.range_min = KX132_REG_TSCP,
+		.range_max = KX132_REG_INT_REL,
+	}, {
+		/* The reset bit will be cleared by sensor */
+		.range_min = KX132_REG_CNTL2,
+		.range_max = KX132_REG_CNTL2,
+	}, {
+		.range_min = KX132_REG_CNTL5,
+		.range_max = KX132_REG_CNTL5,
+	}, {
+		.range_min = KX132_REG_BUF_STATUS_1,
+		.range_max = KX132_REG_BUF_READ,
+	},
+};
+
+static const struct regmap_access_table kx132_volatile_regs = {
+	.yes_ranges = &kx132_volatile_ranges[0],
+	.n_yes_ranges = ARRAY_SIZE(kx132_volatile_ranges),
+};
+
+static const struct regmap_range kx132_precious_ranges[] = {
+	{
+		.range_min = KX132_REG_INT_REL,
+		.range_max = KX132_REG_INT_REL,
+	},
+};
+
+static const struct regmap_access_table kx132_precious_regs = {
+	.yes_ranges = &kx132_precious_ranges[0],
+	.n_yes_ranges = ARRAY_SIZE(kx132_precious_ranges),
+};
+
+static const struct regmap_range kx132_read_only_ranges[] = {
+	{
+		.range_min = KX132_REG_XADP_L,
+		.range_max = KX132_REG_INT_REL,
+	}, {
+		.range_min = KX132_REG_BUF_STATUS_1,
+		.range_max = KX132_REG_BUF_STATUS_2,
+	}, {
+		.range_min = KX132_REG_BUF_READ,
+		.range_max = KX132_REG_BUF_READ,
+	}, {
+		/* Kionix reserved registers: should not be written */
+		.range_min = 0x28,
+		.range_max = 0x28,
+	}, {
+		.range_min = 0x35,
+		.range_max = 0x36,
+	}, {
+		.range_min = 0x3c,
+		.range_max = 0x48,
+	}, {
+		.range_min = 0x4e,
+		.range_max = 0x5c,
+	}, {
+		.range_min = 0x77,
+		.range_max = 0x7f,
+	},
+};
+
+static const struct regmap_access_table kx132_ro_regs = {
+	.no_ranges = &kx132_read_only_ranges[0],
+	.n_no_ranges = ARRAY_SIZE(kx132_read_only_ranges),
+};
+
+static const struct regmap_range kx132_write_only_ranges[] = {
+	{
+		.range_min = KX132_REG_SELF_TEST,
+		.range_max = KX132_REG_SELF_TEST,
+	}, {
+		.range_min = KX132_REG_BUF_CLEAR,
+		.range_max = KX132_REG_BUF_CLEAR,
+	},
+};
+
+static const struct regmap_access_table kx132_wo_regs = {
+	.no_ranges = &kx132_write_only_ranges[0],
+	.n_no_ranges = ARRAY_SIZE(kx132_write_only_ranges),
+};
+
+static const struct regmap_range kx132_noinc_read_ranges[] = {
+	{
+		.range_min = KX132_REG_BUF_READ,
+		.range_max = KX132_REG_BUF_READ,
+	},
+};
+
+static const struct regmap_access_table kx132_nir_regs = {
+	.yes_ranges = &kx132_noinc_read_ranges[0],
+	.n_yes_ranges = ARRAY_SIZE(kx132_noinc_read_ranges),
+};
+
+static const struct regmap_config kx132_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_table = &kx132_volatile_regs,
+	.rd_table = &kx132_wo_regs,
+	.wr_table = &kx132_ro_regs,
+	.rd_noinc_table = &kx132_nir_regs,
+	.precious_table = &kx132_precious_regs,
+	.max_register = KX132_MAX_REGISTER,
+	.cache_type = REGCACHE_RBTREE,
+};
+
 struct kx022a_data {
 	struct regmap *regmap;
 	const struct kx022a_chip_info *chip_info;
@@ -239,6 +350,13 @@ static const struct iio_chan_spec kx022a_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec kx132_channels[] = {
+	KX022A_ACCEL_CHAN(X, KX132_REG_XOUT_L, 0),
+	KX022A_ACCEL_CHAN(Y, KX132_REG_YOUT_L, 1),
+	KX022A_ACCEL_CHAN(Z, KX132_REG_ZOUT_L, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
 /*
  * The sensor HW can support ODR up to 1600 Hz, which is beyond what most of the
  * Linux CPUs can handle without dropping samples. Also, the low power mode is
@@ -601,6 +719,26 @@ static int kx022a_get_fifo_bytes_available(struct kx022a_data *data)
 	return fifo_bytes;
 }
 
+static int kx132_get_fifo_bytes_available(struct kx022a_data *data)
+{
+	__le16 buf_status;
+	int ret, fifo_bytes;
+
+	ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
+			       &buf_status, sizeof(buf_status));
+	if (ret) {
+		dev_err(data->dev, "Error reading buffer status\n");
+		return ret;
+	}
+
+	fifo_bytes = le16_to_cpu(buf_status);
+	fifo_bytes &= data->chip_info->buf_smp_lvl_mask;
+	fifo_bytes = min((unsigned int)fifo_bytes, data->chip_info->fifo_length *
+			 KX022A_FIFO_SAMPLES_SIZE_BYTES);
+
+	return fifo_bytes;
+}
+
 static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 			       bool irq)
 {
@@ -1024,6 +1162,32 @@ const struct kx022a_chip_info kx022a_chip_info = {
 };
 EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
 
+const struct kx022a_chip_info kx132_chip_info = {
+	.name			  = "kx132-1211",
+	.regmap_config		  = &kx132_regmap_config,
+	.channels		  = kx132_channels,
+	.num_channels		  = ARRAY_SIZE(kx132_channels),
+	.fifo_length		  = KX132_FIFO_LENGTH,
+	.who			  = KX132_REG_WHO,
+	.id			  = KX132_ID,
+	.cntl			  = KX132_REG_CNTL,
+	.cntl2			  = KX132_REG_CNTL2,
+	.odcntl			  = KX132_REG_ODCNTL,
+	.buf_cntl1		  = KX132_REG_BUF_CNTL1,
+	.buf_cntl2		  = KX132_REG_BUF_CNTL2,
+	.buf_clear		  = KX132_REG_BUF_CLEAR,
+	.buf_status1		  = KX132_REG_BUF_STATUS_1,
+	.buf_smp_lvl_mask	  = KX132_MASK_BUF_SMP_LVL,
+	.buf_read		  = KX132_REG_BUF_READ,
+	.inc1			  = KX132_REG_INC1,
+	.inc4			  = KX132_REG_INC4,
+	.inc5			  = KX132_REG_INC5,
+	.inc6			  = KX132_REG_INC6,
+	.xout_l			  = KX132_REG_XOUT_L,
+	.get_fifo_bytes_available = kx132_get_fifo_bytes_available,
+};
+EXPORT_SYMBOL_NS_GPL(kx132_chip_info, IIO_KX022A);
+
 int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info)
 {
 	static const char * const regulator_names[] = {"io-vdd", "vdd"};
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index 7ca48e6f2c49..35c548ae7eff 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -74,6 +74,57 @@
 #define KX022A_REG_SELF_TEST	0x60
 #define KX022A_MAX_REGISTER	0x60
 
+#define KX132_REG_WHO		0x13
+#define KX132_ID		0x3d
+
+#define KX132_FIFO_LENGTH	86
+
+#define KX132_REG_CNTL		0x1b
+#define KX132_REG_CNTL2		0x1c
+#define KX132_REG_CNTL5		0x1f
+#define KX132_MASK_RES		BIT(6)
+#define KX132_GSEL_2		0x0
+#define KX132_GSEL_4		BIT(3)
+#define KX132_GSEL_8		BIT(4)
+#define KX132_GSEL_16		GENMASK(4, 3)
+
+#define KX132_REG_INS2		0x17
+#define KX132_MASK_INS2_WMI	BIT(5)
+
+#define KX132_REG_XADP_L	0x02
+#define KX132_REG_XOUT_L	0x08
+#define KX132_REG_YOUT_L	0x0a
+#define KX132_REG_ZOUT_L	0x0c
+#define KX132_REG_COTR		0x12
+#define KX132_REG_TSCP		0x14
+#define KX132_REG_INT_REL	0x1a
+
+#define KX132_REG_ODCNTL	0x21
+
+#define KX132_REG_BTS_WUF_TH	0x4a
+
+#define KX132_REG_BUF_CNTL1	0x5e
+#define KX132_REG_BUF_CNTL2	0x5f
+#define KX132_REG_BUF_STATUS_1	0x60
+#define KX132_REG_BUF_STATUS_2	0x61
+#define KX132_MASK_BUF_SMP_LVL	GENMASK(9, 0)
+#define KX132_REG_BUF_CLEAR	0x62
+#define KX132_REG_BUF_READ	0x63
+#define KX132_ODR_SHIFT		3
+#define KX132_FIFO_MAX_WMI_TH	86
+
+#define KX132_REG_INC1		0x22
+#define KX132_REG_INC5		0x26
+#define KX132_REG_INC6		0x27
+#define KX132_IPOL_LOW		0
+#define KX132_IPOL_HIGH		KX022A_MASK_IPOL
+#define KX132_ITYP_PULSE	KX022A_MASK_ITYP
+
+#define KX132_REG_INC4		0x25
+
+#define KX132_REG_SELF_TEST	0x5d
+#define KX132_MAX_REGISTER	0x76
+
 struct device;
 
 struct kx022a_data;
@@ -86,6 +137,7 @@ struct kx022a_data;
  * @channels:			pointer to iio_chan_spec array
  * @num_channels:		number of iio_chan_spec channels
  * @fifo_length:		number of 16-bit samples in a full buffer
+ * @buf_smp_lvl_mask:		buffer sample level mask
  * @who:			WHO_AM_I register
  * @id:				WHO_AM_I register value
  * @cntl:			control register 1
@@ -111,6 +163,7 @@ struct kx022a_chip_info {
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
 	unsigned int fifo_length;
+	u16 buf_smp_lvl_mask;
 	u8 who;
 	u8 id;
 	u8 cntl;
@@ -132,5 +185,6 @@ struct kx022a_chip_info {
 int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
 
 extern const struct kx022a_chip_info kx022a_chip_info;
+extern const struct kx022a_chip_info kx132_chip_info;
 
 #endif
-- 
2.30.2

