Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF77D20D3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 05:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjJVDMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 23:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjJVDMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 23:12:20 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4CA126;
        Sat, 21 Oct 2023 20:12:18 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6b709048f32so1656978b3a.0;
        Sat, 21 Oct 2023 20:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697944337; x=1698549137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzbV6n5FMSqzKY14jdbBPxtAS0oUis2FQ9UO1ljggKk=;
        b=mzISRJylVKLnmJoa15YboZTy8f/qHsHGVJVCUKupWBD5oySrEzsS6lHEqv7afO2tlO
         jXWJDC2jEfMTAJs6CXe0o37BIpoE+L3nwlMGAJGQKgeOqdn9obLmafZhe5v7DXTp+i7f
         ed7oPPaN4TmwJc0vz/4caJzk8VZcOb5W0swwaLdfGigtyX3e2S1Lxym6FJpc0WrM4Gyb
         iLK50oR1TkwuPLVR7hUWWtB8hE0Pc0+T0Z7Nq7OWQRAxisOQWy+wRnbotdod9bUCOKPO
         xq49O/i0whkzn0cGRa2FvyPYcZD4UAJngFkr60RzSe5U0nxkSurs8YnAYM/vGHBMg+vw
         3L9g==
X-Gm-Message-State: AOJu0Yzg9f4yGK9rikXf9ZbbY/S0tydtLdygd8Oc4GLyhqwCiIKPUL2T
        TEwIHxF5Cf0UxCY0QiqSH0A=
X-Google-Smtp-Source: AGHT+IGn1rdEcDNwpcTXBcAeDQHrRijrN5j3sC4fgHBSRQcw/DGa0ruWU3RPC712akl1Q8o3z+lAQg==
X-Received: by 2002:a17:902:ce92:b0:1c9:e774:58e1 with SMTP id f18-20020a170902ce9200b001c9e77458e1mr5089702plg.8.1697944337344;
        Sat, 21 Oct 2023 20:12:17 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001c9c879ee4asm3789589plf.17.2023.10.21.20.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 20:12:16 -0700 (PDT)
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Nishanth Menon <nm@ti.com>
Cc:     Sukrut Bellary <sukrut.bellary@linux.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: adc: ti-adc128s052: Add lower resolution devices support
Date:   Sat, 21 Oct 2023 20:12:03 -0700
Message-Id: <20231022031203.632153-3-sukrut.bellary@linux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022031203.632153-1-sukrut.bellary@linux.com>
References: <20231022031203.632153-1-sukrut.bellary@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adcxx4s communicates with a host processor via an SPI/Microwire Bus
interface. The device family responds with 12-bit data, of which the LSB
bits are transmitted by the lower resolution devices as 0.
The unavailable bits are 0 in LSB.
Shift is calculated per resolution and used in scaling and
raw data read.

Lets reuse the driver to support the family of devices with name
ADC<bb><c>S<sss>, where
* bb is the resolution in number of bits (8, 10, 12)
* c is the number of channels (1, 2, 4, 8)
* sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
and 101 for 1 MSPS)

Complete datasheets are available at TI's website here:
https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf

Tested only with ti-adc102s051 on BegalePlay SBC.
https://www.beagleboard.org/boards/beagleplay

arm64: dts: ti: k3-am625-beagleplay: Add adc102s051
Add adc102s051 support.
Tested on beaglePlay SBC
https://www.beagleboard.org/boards/beagleplay

Co-developed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
---
Changes in v2:
        - Arranged of_device_id and spi_device_id in numeric order.
        - Used enum to index into adc128_config.
        - Reorder adc128_config in alphabetical.
        - Include channel resolution information.
        - Shift is calculated per resolution and used in scaling and 
          raw data read.
- Link to v1: https://lore.kernel.org/all/20220701042919.18180-3-nm@ti.com/
---
 drivers/iio/adc/ti-adc128s052.c | 131 +++++++++++++++++++++++---------
 1 file changed, 96 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index a456ea78462f..61e3181b8daf 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -7,6 +7,22 @@
  * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
  * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
  * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
+ *
+ * The adcxx4s communicates with a host processor via an SPI/Microwire Bus
+ * interface. This driver supports the whole family of devices with a name
+ * ADC<bb><c>S<sss>, where
+ * bb is the resolution in number of bits (8, 10, 12)
+ * c is the number of channels (1, 2, 4, 8)
+ * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
+ * and 101 for 1 MSPS)
+ *
+ * Complete datasheets are available at TI's website here:
+ *   https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
+ *
+ * 8, 10, and 12 bits converters send 12-bit data with
+ * unavailable bits set to 0 in LSB.
+ * Shift is calculated per resolution and used in scaling and
+ * raw data read.
  */
 
 #include <linux/err.h>
@@ -53,7 +69,7 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
 	if (ret < 0)
 		return ret;
 
-	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
+	return (adc->buffer[0] << 8 | adc->buffer[1]);
 }
 
 static int adc128_read_raw(struct iio_dev *indio_dev,
@@ -70,7 +86,8 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		*val = ret;
+		*val = (ret >> channel->scan_type.shift) &
+			GENMASK(channel->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -80,7 +97,7 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		*val = ret / 1000;
-		*val2 = 12;
+		*val2 = channel->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 
 	default:
@@ -89,24 +106,34 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
 
 }
 
-#define ADC128_VOLTAGE_CHANNEL(num)	\
-	{ \
-		.type = IIO_VOLTAGE, \
-		.indexed = 1, \
-		.channel = (num), \
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
+#define _ADC128_VOLTAGE_CHANNEL(num, real_bits, store_bits)		\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = (num),					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.scan_index = (num),					\
+		.scan_type = {						\
+			.sign = 'u',					\
+			.realbits = (real_bits),			\
+			.storagebits = (store_bits),			\
+			.shift = (12 - real_bits),			\
+		},							\
 	}
 
-static const struct iio_chan_spec adc128s052_channels[] = {
-	ADC128_VOLTAGE_CHANNEL(0),
-	ADC128_VOLTAGE_CHANNEL(1),
-	ADC128_VOLTAGE_CHANNEL(2),
-	ADC128_VOLTAGE_CHANNEL(3),
-	ADC128_VOLTAGE_CHANNEL(4),
-	ADC128_VOLTAGE_CHANNEL(5),
-	ADC128_VOLTAGE_CHANNEL(6),
-	ADC128_VOLTAGE_CHANNEL(7),
+#define ADC082_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 8, 16)
+#define ADC102_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 10, 16)
+#define ADC128_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 12, 16)
+
+static const struct iio_chan_spec adc082s021_channels[] = {
+	ADC082_VOLTAGE_CHANNEL(0),
+	ADC082_VOLTAGE_CHANNEL(1),
+};
+
+static const struct iio_chan_spec adc102s021_channels[] = {
+	ADC102_VOLTAGE_CHANNEL(0),
+	ADC102_VOLTAGE_CHANNEL(1),
 };
 
 static const struct iio_chan_spec adc122s021_channels[] = {
@@ -121,10 +148,32 @@ static const struct iio_chan_spec adc124s021_channels[] = {
 	ADC128_VOLTAGE_CHANNEL(3),
 };
 
+static const struct iio_chan_spec adc128s052_channels[] = {
+	ADC128_VOLTAGE_CHANNEL(0),
+	ADC128_VOLTAGE_CHANNEL(1),
+	ADC128_VOLTAGE_CHANNEL(2),
+	ADC128_VOLTAGE_CHANNEL(3),
+	ADC128_VOLTAGE_CHANNEL(4),
+	ADC128_VOLTAGE_CHANNEL(5),
+	ADC128_VOLTAGE_CHANNEL(6),
+	ADC128_VOLTAGE_CHANNEL(7),
+};
+
 static const struct adc128_configuration adc128_config[] = {
-	{ adc128s052_channels, ARRAY_SIZE(adc128s052_channels) },
+	{ adc082s021_channels, ARRAY_SIZE(adc082s021_channels) },
+	{ adc102s021_channels, ARRAY_SIZE(adc102s021_channels) },
 	{ adc122s021_channels, ARRAY_SIZE(adc122s021_channels) },
 	{ adc124s021_channels, ARRAY_SIZE(adc124s021_channels) },
+	{ adc128s052_channels, ARRAY_SIZE(adc128s052_channels) },
+};
+
+/* Ensure match with adc128_config indices */
+enum adc128_configuration_index {
+	ADC128_CONFIG_INDEX_082S,
+	ADC128_CONFIG_INDEX_102S,
+	ADC128_CONFIG_INDEX_122S,
+	ADC128_CONFIG_INDEX_124S,
+	ADC128_CONFIG_INDEX_128S,
 };
 
 static const struct iio_info adc128_info = {
@@ -177,31 +226,43 @@ static int adc128_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id adc128_of_match[] = {
-	{ .compatible = "ti,adc128s052", .data = &adc128_config[0] },
-	{ .compatible = "ti,adc122s021", .data = &adc128_config[1] },
-	{ .compatible = "ti,adc122s051", .data = &adc128_config[1] },
-	{ .compatible = "ti,adc122s101", .data = &adc128_config[1] },
-	{ .compatible = "ti,adc124s021", .data = &adc128_config[2] },
-	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
-	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
+	{ .compatible = "ti,adc082s021", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
+	{ .compatible = "ti,adc082s051", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
+	{ .compatible = "ti,adc082s101", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
+	{ .compatible = "ti,adc102s021", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
+	{ .compatible = "ti,adc102s051", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
+	{ .compatible = "ti,adc102s101", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
+	{ .compatible = "ti,adc122s021", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
+	{ .compatible = "ti,adc122s051", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
+	{ .compatible = "ti,adc122s101", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
+	{ .compatible = "ti,adc124s021", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
+	{ .compatible = "ti,adc124s051", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
+	{ .compatible = "ti,adc124s101", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
+	{ .compatible = "ti,adc128s052", .data = &adc128_config[ADC128_CONFIG_INDEX_128S] },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
 
 static const struct spi_device_id adc128_id[] = {
-	{ "adc128s052", (kernel_ulong_t)&adc128_config[0] },
-	{ "adc122s021",	(kernel_ulong_t)&adc128_config[1] },
-	{ "adc122s051",	(kernel_ulong_t)&adc128_config[1] },
-	{ "adc122s101",	(kernel_ulong_t)&adc128_config[1] },
-	{ "adc124s021", (kernel_ulong_t)&adc128_config[2] },
-	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
-	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
+	{ "adc082s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
+	{ "adc082s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
+	{ "adc082s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
+	{ "adc102s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
+	{ "adc102s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
+	{ "adc102s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
+	{ "adc122s021",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
+	{ "adc122s051",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
+	{ "adc122s101",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
+	{ "adc124s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
+	{ "adc124s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
+	{ "adc124s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
+	{ "adc128s052", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_128S] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
 
 static const struct acpi_device_id adc128_acpi_match[] = {
-	{ "AANT1280", (kernel_ulong_t)&adc128_config[2] },
+	{ "AANT1280", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
-- 
2.34.1

