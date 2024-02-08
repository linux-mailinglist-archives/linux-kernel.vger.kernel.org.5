Return-Path: <linux-kernel+bounces-58450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CEC84E6A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12372903C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3120281ACC;
	Thu,  8 Feb 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSmJgwtN"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211476416;
	Thu,  8 Feb 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413136; cv=none; b=K79HGLyGrk8zaiBhzor9qHakI5sbvU40U/sv3CdvxvJjuq52fIQyREhnPA6dR4VcFYRHmVE85T62jEkukZo4+tawab3Gp2/0VQcbgiRZnx7CA712eQzADZhwzn4OW9TWWFHtoovdMnDRplUMb4fGKJbbhsUbdu0VfyHYk5vKsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413136; c=relaxed/simple;
	bh=iJLrsjuGugiPI4q+2gS/5BtUzqq25GGNRWez/6JxRjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3XrZTtlxRfjVGieixWh+N5Z+PPX00Lz8uPDJ2XV6951qjYmUOFLQU+3nVHT52flyaLNtOvl5UGeaG5Tfe8ObZWP7/dB8rkTH3ansENOuy8sv9j4J9Jtkq4zdFDfOyVIQKw/dkH9Rj4y9hFVpVD/pGrXsx/Xk4titheEXizTEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSmJgwtN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ef3f351d2so6958625e9.1;
        Thu, 08 Feb 2024 09:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707413133; x=1708017933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj7lPYpdTz0WzdqaV4TnPrnHLqxxq6rNre4FSWKwvt4=;
        b=RSmJgwtNUWy93iwTLEcB+mc/iZMGTKP1RwLf5qZHwxT0W1Y//P1ibUYvS6N0GChZ9I
         qyTMQX+vnI3STSvkbtS2RM3EXYPiiDWHnTfSTznoTJwmRA4bMc0cyebIgEK2tTzZAwFZ
         4TMXaLTcTnBmwekBPtjIo+TEKIscviUCcIWTPK4G4BYjYZdfyXFV0XhF7fpWAKcM4q5c
         GcW+N3vicf63Fxi0ZkYPZj8Wh/BWcNHEuUG5oTAffuD3eAqM7QkcrYfJgE/+8Y2NiwHA
         HggHJwRuYLvCMq51x06rNIKTNbCNK5V4Lf7F+gkaeCawtt9vVIMzILrXHd7NPlAKgO7M
         Tn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413133; x=1708017933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bj7lPYpdTz0WzdqaV4TnPrnHLqxxq6rNre4FSWKwvt4=;
        b=Y6fY3eNQNCyz7jBsVjcclW7tVTU9ReSgDyDx+IVYpBJpPP/QfeBtI7CLP2lccTGhRp
         +vxX1zqFg71lrGe+/XJPMVeBvmkHw7tRjvfglm083IFtw7Q//rOqSRleoCtOVENPW/J3
         73e1fXa8py/PVCzlXm6olRqj6u21Gs+azWxTp649d80MK2K6QHty2GaK6SBxAev9tusS
         S0/75V2v+NlcO+UztpHtd9HX6+lSoqIsmFwW6wbygi4q6agi1Fo4tycdRVye/srMKeVd
         oyE+OazBejObsoSgAJhN2dp9oV5sUnE8Bqaz4WmSBPiqig4ugBK2/WV3raqWWYg+YD60
         6ELg==
X-Forwarded-Encrypted: i=1; AJvYcCV8pRG+c+5UJYH9oCqjh4kTywv90l2byZPt2yOJtJqzkd2mjGvL2gMLIN0q6K2lk54Je3QwcUt53dNuGPOSgb93bUcSOoEcK4YBMiDerxvM7WBrE2Ue7vTX5b1KIkxtkj5cfKahU1axF0PqDEOBsAOq4t+ub+jq44pRbXvIFrpb+qx+Rw==
X-Gm-Message-State: AOJu0Yxg674aAnFvKUKajWL5AFdazHu94JhqVwQjBQ7HKn/PNyierYU/
	a2Xkc9d84x+m5aSA8OIr8yHn4yjzKJS6iMkNnWhmj3cJwiQ7ODop
X-Google-Smtp-Source: AGHT+IF/01EI+yyl+jqkmrrmzR/zciv2BngE62tHyx0Bq6a/SBKCNdrpzqx9ezgFezAL+97xktG4Wg==
X-Received: by 2002:a05:600c:1c13:b0:40f:de25:f9a9 with SMTP id j19-20020a05600c1c1300b0040fde25f9a9mr2871385wms.15.1707413132545;
        Thu, 08 Feb 2024 09:25:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUf1QzSuv4rdhHqQQ/f+MdgSFcVm3qwpgoaIsn1xyj2/iqw3OWk5JUWTSEpTaKQBuR522cbji1d+mZlrlxjYsRpRUHPzkaThlMQI7ZhYAv0zqq+q9YFJcgL+HlT0NNiykTrF6Yqthz47BYCdzJuFbYyDx0Qw0Z161eFb7kgyPvCbvgclSTGZSdKpouhQF0cJS5ThnSapM4M8ynoTV20PTi7NUceqTVielByHry3Nog+cHMcVVbQB6Ls6EeZyIgCfsjPWCaNdtAR4qY6qbtIaDlrApLHmcCmsH1fQypCHtV8VadXI6nOyGL+R7AGGv8OmhAgOpHUPQ7UAUu6G5fGXD7SbG2jkyHDC/LQMtbW2Nw16MR5AupjXPnXdhJ+pFmNQwGhc289rpsq4pIWmF7hiyPQdA1ta/9GxzgJjO3MKUEsIXrU6p63n4fggNuu0LdkrGEgRMXWvxGkZ58uK6uxtHPz0SSH4Cxv6BwfdgeDjQDNWMOa8UkMfKrPr7jFdVXtMJqDGMiEQcSx9iCYiBPUV86YtEONjhKoh50hi3FlsZ6Gdjcewrl2o0zYzgl2Dg7b
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b004101f27737asm2238214wmo.29.2024.02.08.09.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:25:32 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: 
Cc: alexandru.tachici@analog.com,
	alisa.roman@analog.com,
	alisadariana@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	robh+dt@kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v3 1/5] iio: adc: ad7192: Use device api
Date: Thu,  8 Feb 2024 19:24:55 +0200
Message-Id: <20240208172459.280189-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208172459.280189-1-alisa.roman@analog.com>
References: <20240208172459.280189-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace of.h and corresponding functions with preferred device specific
functions.

Also replace of_device_get_match_data() with
spi_get_device_match_data().

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7192.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index adc3cbe92d6e..48e0357564af 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -17,7 +17,6 @@
 #include <linux/err.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
-#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -364,19 +363,19 @@ static inline bool ad7192_valid_external_frequency(u32 freq)
 		freq <= AD7192_EXT_FREQ_MHZ_MAX);
 }
 
-static int ad7192_of_clock_select(struct ad7192_state *st)
+static int ad7192_device_clock_select(struct ad7192_state *st)
 {
-	struct device_node *np = st->sd.spi->dev.of_node;
+	struct device *dev = &st->sd.spi->dev;
 	unsigned int clock_sel;
 
 	clock_sel = AD7192_CLK_INT;
 
 	/* use internal clock */
 	if (!st->mclk) {
-		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
+		if (device_property_read_bool(dev, "adi,int-clock-output-enable"))
 			clock_sel = AD7192_CLK_INT_CO;
 	} else {
-		if (of_property_read_bool(np, "adi,clock-xtal"))
+		if (device_property_read_bool(dev, "adi,clock-xtal"))
 			clock_sel = AD7192_CLK_EXT_MCLK1_2;
 		else
 			clock_sel = AD7192_CLK_EXT_MCLK2;
@@ -385,9 +384,10 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 	return clock_sel;
 }
 
-static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
+static int ad7192_setup(struct iio_dev *indio_dev)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->sd.spi->dev;
 	bool rej60_en, refin2_en;
 	bool buf_en, bipolar, burnout_curr_en;
 	unsigned long long scale_uv;
@@ -416,26 +416,26 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 
 	st->conf = FIELD_PREP(AD7192_CONF_GAIN_MASK, 0);
 
-	rej60_en = of_property_read_bool(np, "adi,rejection-60-Hz-enable");
+	rej60_en = device_property_read_bool(dev, "adi,rejection-60-Hz-enable");
 	if (rej60_en)
 		st->mode |= AD7192_MODE_REJ60;
 
-	refin2_en = of_property_read_bool(np, "adi,refin2-pins-enable");
+	refin2_en = device_property_read_bool(dev, "adi,refin2-pins-enable");
 	if (refin2_en && st->chip_info->chip_id != CHIPID_AD7195)
 		st->conf |= AD7192_CONF_REFSEL;
 
 	st->conf &= ~AD7192_CONF_CHOP;
 
-	buf_en = of_property_read_bool(np, "adi,buffer-enable");
+	buf_en = device_property_read_bool(dev, "adi,buffer-enable");
 	if (buf_en)
 		st->conf |= AD7192_CONF_BUF;
 
-	bipolar = of_property_read_bool(np, "bipolar");
+	bipolar = device_property_read_bool(dev, "bipolar");
 	if (!bipolar)
 		st->conf |= AD7192_CONF_UNIPOLAR;
 
-	burnout_curr_en = of_property_read_bool(np,
-						"adi,burnout-currents-enable");
+	burnout_curr_en =
+		device_property_read_bool(dev, "adi,burnout-currents-enable");
 	if (burnout_curr_en && buf_en) {
 		st->conf |= AD7192_CONF_BURN;
 	} else if (burnout_curr_en) {
@@ -1117,9 +1117,7 @@ static int ad7192_probe(struct spi_device *spi)
 	}
 	st->int_vref_mv = ret / 1000;
 
-	st->chip_info = of_device_get_match_data(&spi->dev);
-	if (!st->chip_info)
-		st->chip_info = (void *)spi_get_device_id(spi)->driver_data;
+	st->chip_info = spi_get_device_match_data(spi);
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
@@ -1140,7 +1138,7 @@ static int ad7192_probe(struct spi_device *spi)
 	if (IS_ERR(st->mclk))
 		return PTR_ERR(st->mclk);
 
-	st->clock_sel = ad7192_of_clock_select(st);
+	st->clock_sel = ad7192_device_clock_select(st);
 
 	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
 	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
@@ -1152,7 +1150,7 @@ static int ad7192_probe(struct spi_device *spi)
 		}
 	}
 
-	ret = ad7192_setup(indio_dev, spi->dev.of_node);
+	ret = ad7192_setup(indio_dev);
 	if (ret)
 		return ret;
 
-- 
2.34.1


