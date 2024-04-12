Return-Path: <linux-kernel+bounces-143430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066078A38E3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F796286197
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D2315252B;
	Fri, 12 Apr 2024 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dqw/ELXu"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A815251A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712964310; cv=none; b=OU9WX0oC94C5j5TjlX0gpNMTWIZOYDYBAi1nyD+xgbiDfkrumIPda15wXzeiBq6Hntbo6G+KRaiN3Nj9fe5npcCAUUW3HpAoc2mgmU7NWebK7rb1WyEXhz0vGCUyuX02WqEhwnOecIeRdZgPsUu2AeRtx8OcPwOzOjjluD55ZIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712964310; c=relaxed/simple;
	bh=KGyMekWTlazKBqS5Mf0nI0xFELlChiDJZMmvQrG+A+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H+ME9IWFmmtFYqaYX9pSBzDmXhFEDx8RAshXRq7FDMzvbcsz0evegSVjRYLLDGJ1YzP49w74gsQoKIMFZPCLPIFfELSK/2snQHKLQHVof++TgAy1c+w8sJFCkVVVgEkbEdB8cki0k9yke8IuGJ98c+bamnEzGFubHSA4UNTUcyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dqw/ELXu; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ea128e4079so909351a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712964306; x=1713569106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lmhooQqIc2chRcc2CAcdYrKYNFL3maDSCzi5ZTdPPdo=;
        b=dqw/ELXuyY+mPMEQBBcaMcuPrESkGoJJ/exIivvVmKpijjq04YOuqVln0osFb45XP5
         cQJFN7ylI099jWf8BromQLiovz4H9j/5gZyI7wgwX6PGI20vypXx7PxKDStG7gN5N0Fg
         YPzsdO+MvgZDHidM1dt4IuqrdtWLKW8noMUyNq0zRybmNZs+Fl1mbymbzqKT1sIRA1pq
         VuTivesSBuvTZxO5185cJ8R8pP84vp2acDNN9UgBL0MEEzrpt6sN/0IhA4hqG993vBz6
         jhWK9MgxFZ4ssNltWt/2SOWiVL0eDmp1MT3FZnEovyNg4fWaACuCcyPmF9xn3yOfTT2S
         tQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712964306; x=1713569106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmhooQqIc2chRcc2CAcdYrKYNFL3maDSCzi5ZTdPPdo=;
        b=CD5k3d67G0U4JBUqBL/VeebPCO+Wg1rEU7I1X+mHKnw3amqxxUqqWVCVrJvo8A+8nn
         MzZG3+aAnZ+5Ln0Np9Xp13jSBuMdlUz2DDZuKBlvaoaaJDV31gZDUZ9bRhkid8+IYEw4
         /ETwCRPsHScOUfObB7kvNqp9903E8s0cB/uJY0J9lG1WcGvUfO3bvxqo936n1qcSoTKH
         tUDchH6liO5BR/yHCFrIQiNZqA43KyYhl+aXDx40GwiQAUhzFq1kYAWia3DtvtKu61O2
         JJI6OVnOIa9WQnME+gr9RgPXvcQGZtT6rnzdhXiSEtoOKQpA7LmuJ7+bU1mooi37UW59
         6bkw==
X-Forwarded-Encrypted: i=1; AJvYcCWnLy0EVdLSnmHAgS/nCvrNdaFRs3tS8uxie2sebJGl0dPmVVNpAMn5UVcnagBmps7+AOE6B0aywT9lsYLnhuc3nCNqPtncZcelon55
X-Gm-Message-State: AOJu0YyUykUFQe1GrpyThV9UWCbSpsYzQO7EzGsarn2gCVam0JNY8MD0
	lExdrwwAOrByY5zYSN5GmKOPitX4pXlPv2B6FCtC0XYNuiWuGPQ5UUa4xaITzPK6k+5TijidvYT
	l
X-Google-Smtp-Source: AGHT+IFKhbeDy09RPmweEEU2kr604GNlIZ6syKQfPoxLifZv0u4Qu3LWVrmTGfIVSOd1G+fOG0HqtA==
X-Received: by 2002:aca:1107:0:b0:3c5:e03a:8f51 with SMTP id 7-20020aca1107000000b003c5e03a8f51mr3716220oir.48.1712964306530;
        Fri, 12 Apr 2024 16:25:06 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5-20020aca2805000000b003c5f72e5a6asm751372oix.58.2024.04.12.16.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 16:25:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad7944: Consolidate spi_sync() wrapper
Date: Fri, 12 Apr 2024 18:25:02 -0500
Message-ID: <20240412-ad7944-consolidate-msg-v1-1-7fdeff89172f@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Since commit 6020ca4de8e5 ("iio: adc: ad7944: use spi_optimize_message()"),
The helper functions wrapping spi_sync() for 3-wire and 4-wire modes are
virtually identical. Since gpiod_set_value_cansleep() does a NULL check
internally, we can consolidate the two functions into one and avoid
switch statements at the call sites.

The default cases of the removed switch statement were just to make the
compiler happy and are not reachable since the mode is validated in the
probe function. So removing those should be safe.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 67 ++++++++++--------------------------------------
 1 file changed, 13 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 9dc86ec23c36..4af574ffa864 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -214,40 +214,26 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
 }
 
-/*
- * ad7944_3wire_cs_mode_conversion - Perform a 3-wire CS mode conversion and
- *                                   acquisition
+/**
+ * ad7944_convert_and_acquire - Perform a single conversion and acquisition
  * @adc: The ADC device structure
  * @chan: The channel specification
  * Return: 0 on success, a negative error code on failure
  *
- * This performs a conversion and reads data when the chip is wired in 3-wire
- * mode with the CNV line on the ADC tied to the CS line on the SPI controller.
- *
- * Upon successful return adc->sample.raw will contain the conversion result.
- */
-static int ad7944_3wire_cs_mode_conversion(struct ad7944_adc *adc,
-					   const struct iio_chan_spec *chan)
-{
-	return spi_sync(adc->spi, &adc->msg);
-}
-
-/*
- * ad7944_4wire_mode_conversion - Perform a 4-wire mode conversion and acquisition
- * @adc: The ADC device structure
- * @chan: The channel specification
- * Return: 0 on success, a negative error code on failure
+ * Perform a conversion and acquisition of a single sample using the
+ * pre-optimized adc->msg.
  *
  * Upon successful return adc->sample.raw will contain the conversion result.
  */
-static int ad7944_4wire_mode_conversion(struct ad7944_adc *adc,
-					const struct iio_chan_spec *chan)
+static int ad7944_convert_and_acquire(struct ad7944_adc *adc,
+				      const struct iio_chan_spec *chan)
 {
 	int ret;
 
 	/*
 	 * In 4-wire mode, the CNV line is held high for the entire conversion
-	 * and acquisition process.
+	 * and acquisition process. In other modes adc->cnv is NULL and is
+	 * ignored (CS is wired to CNV in those cases).
 	 */
 	gpiod_set_value_cansleep(adc->cnv, 1);
 	ret = spi_sync(adc->spi, &adc->msg);
@@ -262,22 +248,9 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 {
 	int ret;
 
-	switch (adc->spi_mode) {
-	case AD7944_SPI_MODE_DEFAULT:
-		ret = ad7944_4wire_mode_conversion(adc, chan);
-		if (ret)
-			return ret;
-
-		break;
-	case AD7944_SPI_MODE_SINGLE:
-		ret = ad7944_3wire_cs_mode_conversion(adc, chan);
-		if (ret)
-			return ret;
-
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
+	ret = ad7944_convert_and_acquire(adc, chan);
+	if (ret)
+		return ret;
 
 	if (chan->scan_type.storagebits > 16)
 		*val = adc->sample.raw.u32;
@@ -338,23 +311,9 @@ static irqreturn_t ad7944_trigger_handler(int irq, void *p)
 	struct ad7944_adc *adc = iio_priv(indio_dev);
 	int ret;
 
-	switch (adc->spi_mode) {
-	case AD7944_SPI_MODE_DEFAULT:
-		ret = ad7944_4wire_mode_conversion(adc, &indio_dev->channels[0]);
-		if (ret)
-			goto out;
-
-		break;
-	case AD7944_SPI_MODE_SINGLE:
-		ret = ad7944_3wire_cs_mode_conversion(adc, &indio_dev->channels[0]);
-		if (ret)
-			goto out;
-
-		break;
-	default:
-		/* not supported */
+	ret = ad7944_convert_and_acquire(adc, &indio_dev->channels[0]);
+	if (ret)
 		goto out;
-	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &adc->sample.raw,
 					   pf->timestamp);

---
base-commit: aabc0aa90c927a03d509d0b592720d9897894ce4
change-id: 20240412-ad7944-consolidate-msg-378515e51628

