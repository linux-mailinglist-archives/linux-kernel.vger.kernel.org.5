Return-Path: <linux-kernel+bounces-112515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD1E887B12
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59959281FDA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9AC5CDD0;
	Sat, 23 Mar 2024 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ErMz3ejS"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8D5B666
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711235604; cv=none; b=MjB0RSVkJJNDAZeNLYceX4Lb/kOtDvS/Pv3skNUYpHpe02OQRYJ6ewXIOUw8vFzpVqwDGBoOE0WrKZawhT+czP23TRrzrHWtfHMXwbXt5Q3wqMI3wZcpNvhhQ7OnVtpKv1qfpd+7+QlOp5P6rtsFg6nsxxFcuDw3/dc84c51bCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711235604; c=relaxed/simple;
	bh=qz1l88f4ZYFGTNTTkYuVy+gK3kOuL24C4n/HW9H3Gm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIZPFvPOlhaTBGB5ZO4bhaAwllkHlZ+OryC4y5nyufweY/229S8mG5yFLx0jxuRTw+/G9S8zMbN96lL9UpnjyloPrFqzLxOswxfjzcy1JVUXahaUJyVMavuuKBXhr3dxdebuFlCxqjULplR57h778Er9K//8k0I59MzyObxO6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ErMz3ejS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a466fc8fcccso435284666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 16:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1711235601; x=1711840401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl5FSLTmapATQPm5Ns2r32N7hJqg6smdpvXe4R0K3sc=;
        b=ErMz3ejSfPMXtLQQTLI1e2+hrTvcseF80p138SkHFzUsv5tzYUKJ0UqXcT+bSgO8cb
         GC9Q7keOQs9rN+ZUAD3jxZxWSY0F8r7Yjf6uO1OTbN3nY8EZfQWqTMMOuG7Co213AUar
         Y+P2bP3OgEeFZ5qMwht3HGEgv+aGdi7GajOunrooDZD2NGYB+MAh/EYfSiLBpsjc777z
         puexkpu60DHMkMAA0l/za5EoFAMLg5/5+EuD/L1U+SX7OSalA5ZpVMFG2FCsqlJvVRiE
         8T1AxxhCgrSbx9flihUL0pbFHtWfRjmL0uQ/PXcvo+NwKvmgSCAmW7UInk1GTB6WdLlV
         0nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711235601; x=1711840401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pl5FSLTmapATQPm5Ns2r32N7hJqg6smdpvXe4R0K3sc=;
        b=HeS15Hu/wX1HuZdJYp60Yl62g2sr7v9Vm3Io1GlQb2+1/RkE5j7kATCYg4nFfgN24n
         hYm1qI8dj7s67GQzgolxXgqJ4TnYVcRacenPbQr6nuvqmR1ygfQ66nbaoSYW7Y0y5S9p
         e8wH9gqPZDxTJvu6cMXa69xqJPq8+MKIMedqGr1s5vzxtqFx8x/xpSddh3R7+ylSJJll
         so7xD1DlhaqhJ63JP1uVppBgwyPdJJA5AAPW/Sgv4yYz3Mb4ACcwyFikc6crKjzSsniL
         JyHVDfI1fgFTCDElkVDNf84JRuZJ7CSZpshic8ShyNDcr11KwuoN2AdsrNpHe7dni+v1
         sMyA==
X-Forwarded-Encrypted: i=1; AJvYcCV6CIwGzT5kFlP1iYuK2nGjX2UYxPUv1OiDufD9PSBv1zSib/0lfzN94tI8m5kLBdGPTDFXrrWkOrNu7pJIFP6umQXNHwQD7FzJJVzt
X-Gm-Message-State: AOJu0YxIaSkyTZvIrAknWMy8KaKpJKKZKB0iTfD36qCsVzb1D7ZVMKcE
	Y4P4t9HpNYKlhKoS8NFH2Ip1F60wrSf6sbrJeLq7lvswXtlz+uD7
X-Google-Smtp-Source: AGHT+IHkSp+Kp1Rin3dfE++TtJyWaSTFTXA0kMhD7ktC/2pkXCOs/6AXmhSKiWjCvHMi9cpI+ukKjw==
X-Received: by 2002:a17:906:fa14:b0:a46:c8e3:c9b9 with SMTP id lo20-20020a170906fa1400b00a46c8e3c9b9mr2059741ejb.42.1711235601112;
        Sat, 23 Mar 2024 16:13:21 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-6fc3-1a00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:6fc3:1a00::e63])
        by smtp.googlemail.com with ESMTPSA id h10-20020a170906590a00b00a46196a7faesm1375116ejq.57.2024.03.23.16.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 16:13:20 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gnstark@salutedevices.com,
	neil.armstrong@linaro.org,
	lars@metafoo.de,
	jic23@kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 2/3] iio: adc: meson: consistently use bool/enum in struct meson_sar_adc_param
Date: Sun, 24 Mar 2024 00:13:08 +0100
Message-ID: <20240323231309.415425-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240323231309.415425-1-martin.blumenstingl@googlemail.com>
References: <20240323231309.415425-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consistently use bool for any register bit that enables/disables
functionality and enum for register values where there's a choice
between different settings. The aim is to make the code easier to read
and understand by being more consistent. No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 47 +++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 2615d74534df..6b2af0c2bbc7 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -156,9 +156,9 @@
 #define MESON_SAR_ADC_REG11					0x2c
 	#define MESON_SAR_ADC_REG11_BANDGAP_EN			BIT(13)
 	#define MESON_SAR_ADC_REG11_CMV_SEL                     BIT(6)
-	#define MESON_SAR_ADC_REG11_VREF_VOLTAGE                BIT(5)
-	#define MESON_SAR_ADC_REG11_EOC                         BIT(1)
-	#define MESON_SAR_ADC_REG11_VREF_SEL                    BIT(0)
+	#define MESON_SAR_ADC_REG11_VREF_VOLTAGE		BIT(5)
+	#define MESON_SAR_ADC_REG11_EOC				BIT(1)
+	#define MESON_SAR_ADC_REG11_VREF_SEL			BIT(0)
 
 #define MESON_SAR_ADC_REG13					0x34
 	#define MESON_SAR_ADC_REG13_12BIT_CALIBRATION_MASK	GENMASK(13, 8)
@@ -224,6 +224,11 @@ enum meson_sar_adc_vref_sel {
 	VREF_VDDA = 1,
 };
 
+enum meson_sar_adc_vref_voltage {
+	VREF_VOLTAGE_0V9 = 0,
+	VREF_VOLTAGE_1V8 = 1,
+};
+
 enum meson_sar_adc_avg_mode {
 	NO_AVERAGING = 0x0,
 	MEAN_AVERAGING = 0x1,
@@ -321,13 +326,13 @@ struct meson_sar_adc_param {
 	u8					temperature_trimming_bits;
 	unsigned int				temperature_multiplier;
 	unsigned int				temperature_divider;
-	u8					disable_ring_counter;
+	bool					disable_ring_counter;
 	bool					has_reg11;
 	bool					has_vref_select;
-	u8					vref_select;
-	u8					cmv_select;
-	u8					adc_eoc;
-	enum meson_sar_adc_vref_sel		vref_voltage;
+	bool					cmv_select;
+	bool					adc_eoc;
+	enum meson_sar_adc_vref_sel		vref_select;
+	enum meson_sar_adc_vref_voltage		vref_voltage;
 };
 
 struct meson_sar_adc_data {
@@ -982,14 +987,16 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 				   MESON_SAR_ADC_DELTA_10_TS_REVE0, 0);
 	}
 
-	regval = FIELD_PREP(MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN,
-			    priv->param->disable_ring_counter);
+	if (priv->param->disable_ring_counter)
+		regval = MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN;
+	else
+		regval = 0;
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
 			   MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN,
 			   regval);
 
 	if (priv->param->has_reg11) {
-		regval = FIELD_PREP(MESON_SAR_ADC_REG11_EOC, priv->param->adc_eoc);
+		regval = priv->param->adc_eoc ? MESON_SAR_ADC_REG11_EOC : 0;
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
 				   MESON_SAR_ADC_REG11_EOC, regval);
 
@@ -1005,8 +1012,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
 				   MESON_SAR_ADC_REG11_VREF_VOLTAGE, regval);
 
-		regval = FIELD_PREP(MESON_SAR_ADC_REG11_CMV_SEL,
-				    priv->param->cmv_select);
+		regval = priv->param->cmv_select ? MESON_SAR_ADC_REG11_CMV_SEL : 0;
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
 				   MESON_SAR_ADC_REG11_CMV_SEL, regval);
 	}
@@ -1225,8 +1231,8 @@ static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 10,
 	.has_reg11 = true,
-	.vref_voltage = 1,
-	.cmv_select = 1,
+	.vref_voltage = VREF_VOLTAGE_1V8,
+	.cmv_select = true,
 };
 
 static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
@@ -1237,8 +1243,8 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
 	.resolution = 12,
 	.disable_ring_counter = 1,
 	.has_reg11 = true,
-	.vref_voltage = 1,
-	.cmv_select = 1,
+	.vref_voltage = VREF_VOLTAGE_1V8,
+	.cmv_select = true,
 };
 
 static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
@@ -1249,10 +1255,10 @@ static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
 	.resolution = 12,
 	.disable_ring_counter = 1,
 	.has_reg11 = true,
-	.vref_voltage = 1,
+	.vref_voltage = VREF_VOLTAGE_1V8,
 	.has_vref_select = true,
 	.vref_select = VREF_VDDA,
-	.cmv_select = 1,
+	.cmv_select = true,
 };
 
 static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
@@ -1263,7 +1269,8 @@ static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
 	.resolution = 12,
 	.disable_ring_counter = 1,
 	.has_reg11 = true,
-	.adc_eoc = 1,
+	.vref_voltage = VREF_VOLTAGE_0V9,
+	.adc_eoc = true,
 	.has_vref_select = true,
 	.vref_select = VREF_VDDA,
 };
-- 
2.44.0


