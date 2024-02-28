Return-Path: <linux-kernel+bounces-85140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB7286B104
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94411283FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE51586FD;
	Wed, 28 Feb 2024 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBgOTP+8"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1811534ED;
	Wed, 28 Feb 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128549; cv=none; b=am9ppY9Olv+LC5yiF213zjJfBjJ2JXOZjmsVsGfFZ0e63eEv9C9hpcviakB5huRjDT48qiPN0BEKJ3J6llJxISIPjfyutxIQLdIxHtVCG4jaCihdDNhl9yttCKWIUQYYH1ORaibLBFHSzvx3t2k6M6spAMgIWLOo0K887SY6aDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128549; c=relaxed/simple;
	bh=4ookyNkXsRC1w+SX2YFfQ/sHilHozwzGjehD4iaCqbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWE82wbgEu7i2hTHAwxo+j5jvkPDTAAdRsVf1ZhQkz3cfFGamE3nzXM7NJcrdvocJ1CxdwTTB5E66/yWJPlbNt56m6MGUR5dsl9BiQPCOOUBACll7sK84y/NZDb7ZRi/aVtyNc25YrMs9ZLCvQ/WUq2cJ8YtL2opQOBC7eKjTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBgOTP+8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a43488745bcso500820366b.3;
        Wed, 28 Feb 2024 05:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709128546; x=1709733346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYCemFNc1uUqcXulrZM7TUJ6mft8DchA0cSSH48XvI8=;
        b=bBgOTP+8WBwGsy8lEffEiIkJphw7CcvqMKis+oHJzmiSFeBlEhDfgPU5tkse3APjsx
         4XrjEGl8t7ox9rca5ZtY+pyWkdq2qXJnlMCgSZQ3bxrr48fsLL3iEiQRxEETNyS76+jg
         fe0QUn5+yxxoSy8dPAgtTx5xYDhkJbkGHwF4Td6rVvMrKhI2PputaK2EJh5DdBl8jOB5
         J1imRlTgL0X4UgYmMT6+YI5/5iS/oDx8wa3jQTZZdFtVjeEWP+D7DhqfBwKDi0H1N7iA
         OKudl6SXDO11mDUi1Y0s9juhKBa4mD3z86t20U2hLaAgXPoZW+Is3zdVAuevVBcs7O3w
         Vyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128546; x=1709733346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYCemFNc1uUqcXulrZM7TUJ6mft8DchA0cSSH48XvI8=;
        b=s10j2gSIDxp3xrN3GYst0EJ5sJFHaoJA4rvV9D0xzv5gR/CxYxeig6aARlaB7Cvh8J
         ME8G6H8dYB9rOn9sh5S5HcSJSgGzdKh1TA154ETB/eZVXkvvHox4UseNjBt2dq0AlKle
         BSvN/DDDSbNRwoZ2NGyReJCGcV012Pj+AFv4pQ87mZYlNvq+lw6ZChmT2HF0ckXtFQpT
         kn1FsS4eqkjakVQ4yXtmNgtStRrAJCGVvqrvxDgBXP26ODYdf/ek4Swvujs9IhZ9zDFS
         KekuIXuyGZwN07cdK4BlhD7ZQhbDtdwfRN7xZKUiOjQaY0IfkyASVad61b/87CH44nxj
         1iiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfzh1oMHyqwxXqHgBXIwEM32mOMBwLSMqck1PJGdN6WoM7++IxDiOS6LfP6qx7MxVz8NhUp4e5/WgaQ2srgLoNPXWZ4lrwTfPoesuVqu6fSqt9h/60li+8tZdHG9HT3627iXtiHE+fl0/cem2Xuj9k3eSE2FIBkSeJ1yaWo+5cbhOB2A==
X-Gm-Message-State: AOJu0YybFTxVXlJmcyndQ4ORIpSNrJirnawLxmhi+adKtPEyO1wJ5htX
	u8pdzTApHuUqJqjN1hfyrn2VkCrN0s6sZ3YsSLrOUJh3k3kVsQ2h
X-Google-Smtp-Source: AGHT+IHS5En0/YeBTEFnIculf04J0CPaqO9tbUphkDG0su+gcdQ7D4LyQRl/voZgJbPxiNG3LimBkg==
X-Received: by 2002:a17:906:3793:b0:a40:3aa3:9b8a with SMTP id n19-20020a170906379300b00a403aa39b8amr8365405ejc.15.1709128545867;
        Wed, 28 Feb 2024 05:55:45 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id dc6-20020a170906c7c600b00a441674cae4sm312487ejb.222.2024.02.28.05.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:55:45 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v2 2/2] iio: adc: ad7173: add support for additional models
Date: Wed, 28 Feb 2024 15:54:57 +0200
Message-ID: <20240228135532.30761-3-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228135532.30761-1-mitrutzceclan@gmail.com>
References: <20240228135532.30761-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Analog Devices AD7172-2, AD7175-8, AD7177-2.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 drivers/iio/adc/ad7173.c | 82 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index b42fbe28a325..e60ecce20e08 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1,6 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * AD7172-2/AD7173-8/AD7175-2/AD7176-2 SPI ADC driver
+ * AD717x family SPI ADC driver
+ *
+ * Supported devices:
+ *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
+ *  AD7175-8/AD7176-2/AD7177-2
+ *
  * Copyright (C) 2015, 2024 Analog Devices, Inc.
  */
 
@@ -61,10 +66,13 @@
 #define AD7173_AIN_TEMP_POS	17
 #define AD7173_AIN_TEMP_NEG	18
 
-#define AD7172_ID			0x00d0
-#define AD7173_ID			0x30d0
-#define AD7175_ID			0x0cd0
+#define AD7172_2_ID			0x00d0
 #define AD7176_ID			0x0c90
+#define AD7175_2_ID			0x0cd0
+#define AD7172_4_ID			0x2050
+#define AD7173_ID			0x30d0
+#define AD7175_8_ID			0x3cd0
+#define AD7177_ID			0x4fd0
 #define AD7173_ID_MASK			GENMASK(15, 4)
 
 #define AD7173_ADC_MODE_REF_EN		BIT(15)
@@ -110,15 +118,19 @@
 #define AD7173_SETUP_REF_SEL_EXT_REF	0x0
 #define AD7173_VOLTAGE_INT_REF_uV	2500000
 #define AD7173_TEMP_SENSIIVITY_uV_per_C	477
+#define AD7177_ODR_START_VALUE		0x07
 
 #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
 #define AD7173_MAX_CONFIGS		8
 
 enum ad7173_ids {
 	ID_AD7172_2,
+	ID_AD7172_4,
 	ID_AD7173_8,
 	ID_AD7175_2,
+	ID_AD7175_8,
 	ID_AD7176_2,
+	ID_AD7177_2,
 };
 
 struct ad7173_device_info {
@@ -190,7 +202,7 @@ static const unsigned int ad7175_sinc5_data_rates[] = {
 static const struct ad7173_device_info ad7173_device_info[] = {
 	[ID_AD7172_2] = {
 		.name = "ad7172-2",
-		.id = AD7172_ID,
+		.id = AD7172_2_ID,
 		.num_inputs = 5,
 		.num_channels = 4,
 		.num_configs = 4,
@@ -200,6 +212,17 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
 	},
+	[ID_AD7172_4] = {
+		.id = AD7172_4_ID,
+		.num_inputs = 9,
+		.num_channels = 8,
+		.num_configs = 8,
+		.num_gpios = 4,
+		.has_temp = false,
+		.clock = 2 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7173_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+	},
 	[ID_AD7173_8] = {
 		.name = "ad7173-8",
 		.id = AD7173_ID,
@@ -214,7 +237,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 	},
 	[ID_AD7175_2] = {
 		.name = "ad7175-2",
-		.id = AD7175_ID,
+		.id = AD7175_2_ID,
 		.num_inputs = 5,
 		.num_channels = 4,
 		.num_configs = 4,
@@ -224,6 +247,17 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 	},
+	[ID_AD7175_8] = {
+		.id = AD7175_8_ID,
+		.num_inputs = 17,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_gpios = 4,
+		.has_temp = true,
+		.clock = 16 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7175_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+	},
 	[ID_AD7176_2] = {
 		.name = "ad7176-2",
 		.id = AD7176_ID,
@@ -236,6 +270,17 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 	},
+	[ID_AD7177_2] = {
+		.id = AD7177_ID,
+		.num_inputs = 5,
+		.num_channels = 4,
+		.num_configs = 4,
+		.num_gpios = 2,
+		.has_temp = true,
+		.clock = 16 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7175_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+	},
 };
 
 static const char *const ad7173_ref_sel_str[] = {
@@ -656,7 +701,12 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		freq = val * MILLI + val2 / MILLI;
-		for (i = 0; i < st->info->num_sinc5_data_rates - 1; i++)
+		/*
+		 * AD7177-2 has the filter values [0-6] marked as reserved
+		 * datasheet page 58
+		 */
+		i = (st->info->id == AD7177_ID) ? AD7177_ODR_START_VALUE : 0;
+		for (; i < st->info->num_sinc5_data_rates - 1; i++)
 			if (freq >= st->info->sinc5_data_rates[i])
 				break;
 
@@ -908,8 +958,15 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		else
 			ref_sel = ret;
 
+		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF &&
+		    st->info->id == AD7172_2_ID) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, -EINVAL,
+				"Internal reference is not available on ad7172-2\n");
+		}
+
 		if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 &&
-		    st->info->id != AD7173_ID) {
+		    st->info->id != AD7173_ID && st->info->id != AD7172_2_ID) {
 			fwnode_handle_put(child);
 			return dev_err_probe(dev, -EINVAL,
 				"External reference 2 is only available on ad7173-8\n");
@@ -1080,21 +1137,30 @@ static int ad7173_probe(struct spi_device *spi)
 static const struct of_device_id ad7173_of_match[] = {
 	{ .compatible = "adi,ad7172-2",
 	  .data = &ad7173_device_info[ID_AD7172_2]},
+	{ .compatible = "adi,ad7172-4",
+	  .data = &ad7173_device_info[ID_AD7172_4]},
 	{ .compatible = "adi,ad7173-8",
 	  .data = &ad7173_device_info[ID_AD7173_8]},
 	{ .compatible = "adi,ad7175-2",
 	  .data = &ad7173_device_info[ID_AD7175_2]},
+	{ .compatible = "adi,ad7175-8",
+	  .data = &ad7173_device_info[ID_AD7175_8]},
 	{ .compatible = "adi,ad7176-2",
 	  .data = &ad7173_device_info[ID_AD7176_2]},
+	{ .compatible = "adi,ad7177-2",
+	  .data = &ad7173_device_info[ID_AD7177_2]},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7173_of_match);
 
 static const struct spi_device_id ad7173_id_table[] = {
 	{ "ad7172-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_2]},
+	{ "ad7172-4", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_4] },
 	{ "ad7173-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7173_8]},
 	{ "ad7175-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7175_2]},
+	{ "ad7175-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7175_8]},
 	{ "ad7176-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7176_2]},
+	{ "ad7177-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7177_2]},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7173_id_table);
-- 
2.43.0


