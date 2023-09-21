Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D317A97F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjIUR2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjIUR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:28:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F45A15A1A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:11:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso2090880e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316297; x=1695921097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZybWEnlutF3BnUcq+xH7uoi35RICanW/277eMaA8Sc=;
        b=Wa+0TJfSg/UDK+AC2TyH9GbNsYbpjZ9R1OPFodTI8y/QyRWWKKflfq3FAIij7Fk39H
         HlD3VIUBo49Q01QPS7P4nCvvaX0NaQcIvUqfXg6foGCSs8fOnvx8Me8ErmZaf/B3QEzH
         VlCzRxDgXHwdRhAWapJN76SssJhnTCpnx+DyEe9zGI4qI+E8VxXMx+arIIAKwfMyvyKo
         pMNn59bl63jroONgue0/wSazS2GCfJ65+hRpI3Z7AlgE+6SiYokBM5+IbdQnyzhCP/cz
         F78drs9bMNDlv6VHG9+0rlH4ifkdt1KBWXSybDtMrTk1y3caLuDEMjL+a6jKagNQEbfl
         evhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316297; x=1695921097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZybWEnlutF3BnUcq+xH7uoi35RICanW/277eMaA8Sc=;
        b=oJs47N9d2XnKKjb8vtdf2UUqZ22TQShEzsNH4napJPY2fBhkqtuXgX89EBSs8OV357
         xwSPtIA0SNPV7Pwe+Z+rtk57iGVsxo3qX40bMeK+gipF6U1G7cuTo909ea9INC3+GCQn
         71W3Wkl6HuvvZZmk4fHUTQWh4+wSG3iGW7ZtdT7QK1sKzxk/xIEdP0pl3i2bHRXVbkkh
         l3SGtmJTDLid4vkGQNiZR5UFuo6MvorPQ0sSeVrBgkcc6kKScxuc9/pdgX8l4yaSpoEV
         IpsPjc/IrD6S75Pn2vgn2JxT/ur0plEySR4QIfqbzutCJAsuhUO+hTwtmMmAL389IaLG
         DyPg==
X-Gm-Message-State: AOJu0Yw6CSsJ+XIf/iEcfWLIp4qd05qVtiFD+0oNTZWoOB3aSkpOAHes
        C/g5WVj5e6ofBK+GCsq4wQF3/pxLO6e8gL0e2KhhVDNs
X-Google-Smtp-Source: AGHT+IHJfqFR4DsaCVjmdv+KrypDdY1GIjA81595SeWzOf30lcIqONwMBeav7UdV/0Pikd2g4z/zFw==
X-Received: by 2002:a05:600c:2312:b0:3fe:d71a:d84e with SMTP id 18-20020a05600c231200b003fed71ad84emr5046284wmo.1.1695307464020;
        Thu, 21 Sep 2023 07:44:24 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:23 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 13/19] staging: iio: resolver: ad2s1210: implement hysteresis as channel attr
Date:   Thu, 21 Sep 2023 09:43:54 -0500
Message-Id: <20230921144400.62380-14-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD2S1210 resolver has a hysteresis feature that can be used to
prevent flicker in the LSB of the position register. This can be either
enabled or disabled. Disabling hysteresis is useful for increasing
precision by oversampling.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 88 ++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 7a1069d948eb..fe413759deb9 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -80,7 +80,6 @@ struct ad2s1210_state {
 	/** The external oscillator frequency in Hz. */
 	unsigned long fclkin;
 	unsigned int fexcit;
-	bool hysteresis;
 	u8 resolution;
 	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
 	u8 tx[2];
@@ -456,6 +455,27 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 		}
 		break;
 
+	case IIO_CHAN_INFO_HYSTERESIS:
+		switch (chan->type) {
+		case IIO_ANGL:
+			mutex_lock(&st->lock);
+			ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
+					       AD2S1210_ENABLE_HYSTERESIS);
+			if (ret < 0)
+				goto error_info_hysteresis;
+
+			*val = !!ret;
+			ret = IIO_VAL_INT;
+
+error_info_hysteresis:
+			mutex_unlock(&st->lock);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
@@ -464,6 +484,64 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ad2s1210_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type,
+			       int *length, long mask)
+{
+	static const int available[] = { 0, 1 };
+	int ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HYSTERESIS:
+		switch (chan->type) {
+		case IIO_ANGL:
+			*vals = available;
+			*type = IIO_VAL_INT;
+			*length = ARRAY_SIZE(available);
+			ret = IIO_AVAIL_LIST;
+			break;
+		default:
+			break;
+		}
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int ad2s1210_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HYSTERESIS:
+		switch (chan->type) {
+		case IIO_ANGL:
+			mutex_lock(&st->lock);
+			ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
+						 AD2S1210_ENABLE_HYSTERESIS,
+						 val ? AD2S1210_ENABLE_HYSTERESIS
+						     : 0);
+			mutex_unlock(&st->lock);
+			break;
+
+		default:
+			break;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static IIO_DEVICE_ATTR(fexcit, 0644,
 		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
 static IIO_DEVICE_ATTR(bits, 0644,
@@ -499,7 +577,10 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SCALE),
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.info_mask_separate_available =
+					BIT(IIO_CHAN_INFO_HYSTERESIS),
 	}, {
 		.type = IIO_ANGL_VEL,
 		.indexed = 1,
@@ -573,6 +654,8 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
 
 static const struct iio_info ad2s1210_info = {
 	.read_raw = ad2s1210_read_raw,
+	.read_avail = ad2s1210_read_avail,
+	.write_raw = ad2s1210_write_raw,
 	.attrs = &ad2s1210_attribute_group,
 	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
 };
@@ -689,7 +772,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 	st->sdev = spi;
-	st->hysteresis = true;
 	st->resolution = 12;
 	st->fexcit = AD2S1210_DEF_EXCIT;
 
-- 
2.34.1

