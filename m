Return-Path: <linux-kernel+bounces-112516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1F7887B13
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6481F21686
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A65D73A;
	Sat, 23 Mar 2024 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dN/fE9Ut"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285C5C60D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711235606; cv=none; b=PQU0UBZKSgrs3bPZTPqY4heg688kzYVe8yIMPq8KlV18TuwAjjjvUBeR1DoTK0m7YDQKRqyb/YSdf0QEvLsRfBpSGYWJZcbp/PbLUQcjon+2KBVHLqYGKSvUvW1RcpzQFoOewbxTX+3aYE4keTJ3l5P6eNLs5ZglXFaSavD4g+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711235606; c=relaxed/simple;
	bh=MRGCY4Jg7QfK8V7QflvA9iWC6dBAvCc23rZx6if+6xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzWkm85bRv4zfwB+6rn28roO9FlXfTvn6l+VlU27V/K2wirQ2VOxX+Y8TKwlTpn7l68LuZn1E+G71TnkICnOIXwN2Tca+s7Zga1/7O6nGBWJzHtjdfm07c1NLhOj4hxsyDm6rBzxK1NyE4ld8lhEWjLVTySkFd+++qaTir/2m1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dN/fE9Ut; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-341950a6c9aso2790856f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1711235603; x=1711840403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+wkttBX+iSKjpPSrwwLyAmpLqj+dv8BQ9EiIlhtH+A=;
        b=dN/fE9UtXmo1EncSINdiz7juTiGae0qRCZgTSjVIpsLmiGbV1gaMXLtiozkrmJak7I
         IGKfW3JWfeCd8w6jCaf0C5PH3J5W0fnLkKtmTXP3aEzIG1WWXa+2V/OpqaY/E67tSrLD
         gmBQO+A4tHRuL8AuAAFWUbb4s0V62e+aadnOsEzMoA/fey/EqRPP5fi7TAm4oaiRv3gO
         EOGDAb90Rx8ibZFA2kZWurudEP0OCno/bKLX9g2bm27RXG2iRGlGs/VIVF5Ukr+3xdUq
         HUKTRnUa/0NegdK1G1j/60ECmxcxntyvcdeXHaSjEeI/t5b63oaaWgUL2n+nhYOijl1u
         JyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711235603; x=1711840403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+wkttBX+iSKjpPSrwwLyAmpLqj+dv8BQ9EiIlhtH+A=;
        b=KuMekoU1tZ5f2g8i7aJof2wh7YpOrbQthiQjFniHr4D0K2JhzKQf9KJAfhz6KndfeE
         M6j5sSRsso15aqBf1lKE0R5CjNF0q9i4T/Ccei5679krNsGTuvn9ghZosFQAXHs/EnJ3
         ggW8EZgLI1VFZHr1p+5oB+CcQ3LtMBG1t2ARGT2rBWGM8FrugICCEUihsAAy+lru9F9T
         YY91K0TPrsS4U224VzlpjX63cMTPxeBqpzs7mhXGSnFvO01hk/3U5gJ4PRoH/VV0v53T
         8c03Ds1JYaLzRIIl4R1xTbSnpLLcT6RUBXgA4JCP5VyQgzHa6z0IZPSb5Q4WOvdDju6d
         5IwA==
X-Forwarded-Encrypted: i=1; AJvYcCXwVhSrNXZZwU4bt6UDGguU2e82mI+f0Y2mit//zRE4I0hsenTA9ZcBLDRlOqXRYyn+bCB4BnQztjm4NwTT3TQ66Zd5fNQmvTfu0ELy
X-Gm-Message-State: AOJu0YzuxdipX+RX7N97kcaz1oDaWlEKtI4yyHB8PjxBSvhBidU+qpAJ
	Ub1Z3JcT1gsYLjAdhOslWEXAmoxRhArlTchiNV2wIvjYmfpIA6+Y
X-Google-Smtp-Source: AGHT+IGaGiJGJBEwz2g/fX8DIOJst2hHZiYa664cIHZgdBzahgfTDnPlGG/I/2i3Ze0ExnTcmGWGJw==
X-Received: by 2002:a05:6000:1185:b0:33e:7a7c:a058 with SMTP id g5-20020a056000118500b0033e7a7ca058mr2551774wrx.18.1711235602417;
        Sat, 23 Mar 2024 16:13:22 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-6fc3-1a00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:6fc3:1a00::e63])
        by smtp.googlemail.com with ESMTPSA id h10-20020a170906590a00b00a46196a7faesm1375116ejq.57.2024.03.23.16.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 16:13:21 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gnstark@salutedevices.com,
	neil.armstrong@linaro.org,
	lars@metafoo.de,
	jic23@kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 3/3] iio: adc: meson: simplify MESON_SAR_ADC_REG11 register access
Date: Sun, 24 Mar 2024 00:13:09 +0100
Message-ID: <20240323231309.415425-4-martin.blumenstingl@googlemail.com>
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

Simply check the max_register value to decide whether
MESON_SAR_ADC_REG11 is present on the current IP revision. This allows
dropping two additional bool fields from struct meson_sar_adc_param
which previously had to be manually kept in sync. No functional changes
intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 6b2af0c2bbc7..8c1e542c0ab7 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -320,14 +320,12 @@ static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
 struct meson_sar_adc_param {
 	bool					has_bl30_integration;
 	unsigned long				clock_rate;
-	u32					bandgap_reg;
 	unsigned int				resolution;
 	const struct regmap_config		*regmap_config;
 	u8					temperature_trimming_bits;
 	unsigned int				temperature_multiplier;
 	unsigned int				temperature_divider;
 	bool					disable_ring_counter;
-	bool					has_reg11;
 	bool					has_vref_select;
 	bool					cmv_select;
 	bool					adc_eoc;
@@ -995,7 +993,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 			   MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN,
 			   regval);
 
-	if (priv->param->has_reg11) {
+	if (priv->param->regmap_config->max_register >= MESON_SAR_ADC_REG11) {
 		regval = priv->param->adc_eoc ? MESON_SAR_ADC_REG11_EOC : 0;
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
 				   MESON_SAR_ADC_REG11_EOC, regval);
@@ -1031,16 +1029,15 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 static void meson_sar_adc_set_bandgap(struct iio_dev *indio_dev, bool on_off)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
-	const struct meson_sar_adc_param *param = priv->param;
-	u32 enable_mask;
 
-	if (param->bandgap_reg == MESON_SAR_ADC_REG11)
-		enable_mask = MESON_SAR_ADC_REG11_BANDGAP_EN;
+	if (priv->param->regmap_config->max_register >= MESON_SAR_ADC_REG11)
+		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
+				   MESON_SAR_ADC_REG11_BANDGAP_EN,
+				   on_off ? MESON_SAR_ADC_REG11_BANDGAP_EN : 0);
 	else
-		enable_mask = MESON_SAR_ADC_DELTA_10_TS_VBG_EN;
-
-	regmap_update_bits(priv->regmap, param->bandgap_reg, enable_mask,
-			   on_off ? enable_mask : 0);
+		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
+				   MESON_SAR_ADC_DELTA_10_TS_VBG_EN,
+				   on_off ? MESON_SAR_ADC_DELTA_10_TS_VBG_EN : 0);
 }
 
 static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
@@ -1205,7 +1202,6 @@ static const struct iio_info meson_sar_adc_iio_info = {
 static const struct meson_sar_adc_param meson_sar_adc_meson8_param = {
 	.has_bl30_integration = false,
 	.clock_rate = 1150000,
-	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
 	.regmap_config = &meson_sar_adc_regmap_config_meson8,
 	.resolution = 10,
 	.temperature_trimming_bits = 4,
@@ -1216,7 +1212,6 @@ static const struct meson_sar_adc_param meson_sar_adc_meson8_param = {
 static const struct meson_sar_adc_param meson_sar_adc_meson8b_param = {
 	.has_bl30_integration = false,
 	.clock_rate = 1150000,
-	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
 	.regmap_config = &meson_sar_adc_regmap_config_meson8,
 	.resolution = 10,
 	.temperature_trimming_bits = 5,
@@ -1227,10 +1222,8 @@ static const struct meson_sar_adc_param meson_sar_adc_meson8b_param = {
 static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {
 	.has_bl30_integration = true,
 	.clock_rate = 1200000,
-	.bandgap_reg = MESON_SAR_ADC_REG11,
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 10,
-	.has_reg11 = true,
 	.vref_voltage = VREF_VOLTAGE_1V8,
 	.cmv_select = true,
 };
@@ -1238,11 +1231,9 @@ static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {
 static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
 	.has_bl30_integration = true,
 	.clock_rate = 1200000,
-	.bandgap_reg = MESON_SAR_ADC_REG11,
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 12,
 	.disable_ring_counter = 1,
-	.has_reg11 = true,
 	.vref_voltage = VREF_VOLTAGE_1V8,
 	.cmv_select = true,
 };
@@ -1250,11 +1241,9 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
 static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
 	.has_bl30_integration = true,
 	.clock_rate = 1200000,
-	.bandgap_reg = MESON_SAR_ADC_REG11,
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 12,
 	.disable_ring_counter = 1,
-	.has_reg11 = true,
 	.vref_voltage = VREF_VOLTAGE_1V8,
 	.has_vref_select = true,
 	.vref_select = VREF_VDDA,
@@ -1264,11 +1253,9 @@ static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
 static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
 	.has_bl30_integration = false,
 	.clock_rate = 1200000,
-	.bandgap_reg = MESON_SAR_ADC_REG11,
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 12,
 	.disable_ring_counter = 1,
-	.has_reg11 = true,
 	.vref_voltage = VREF_VOLTAGE_0V9,
 	.adc_eoc = true,
 	.has_vref_select = true,
-- 
2.44.0


