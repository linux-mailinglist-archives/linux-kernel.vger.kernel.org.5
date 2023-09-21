Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D277A9F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjIUUZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjIUUZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:25:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26ED73AD5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:33:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3226b8de467so535317f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317634; x=1695922434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5XZRvh5FJ3F9RXkqi8NbBrwtIOGm1RUjmAFGYn0SWM=;
        b=JLwuvSRq2iI8y1NRhksb7fblxFUXl6RqQPpspzhudgUzafu9rVDcXQCeAvc66wgNR1
         AzhGOdsEO5FEnLigknHA1ahWxzMMWOtebrBA6JiZwAcncrv/u6RDdsrvuDPQ5+P4N/3H
         ES+ZqO2WHd4QGreCSeSNvL1Qeo88sRkXMj3tu8uObkLaTydca/lrDGQIs5HA3yDsKgG5
         Dcdp7QieDh1L3o84/HysbXRTX1deTnhk5oiCymyAcVZrptB3p/zmny84uw75/QFvs5Ao
         GqTBNgbwWZr9jfscfh4ZMb9Z8rnqPL52C5ucyb7gSyywyPtlW3gppwyl8kACaU1o5IJ6
         cSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317634; x=1695922434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5XZRvh5FJ3F9RXkqi8NbBrwtIOGm1RUjmAFGYn0SWM=;
        b=opK+++jSzoFlcN5RlFZBh5VNYO98aCzNKXVC3QywTB3jSJMJI+mNA803tw9uPi7krf
         +jBzEkwA5/XNCCOxREKd5OoPWdi7/68EjlfaPjIN3u+3sWVellVy/bFpDUghfEpavcIt
         YYUl5mVVuIEM2ZhLsS1wcE5vzD1E2/YsupR5x1mbjSIkbGTv07jc9Carl6XAi9+YkGwO
         n947oAvgnKyYd5oYgeUXvlR4n7qcbIaMWuaqFm/LZruXc/7WJIROp36hPvsZt9fihZ96
         7GmJjIUKuh2Ecg4Ytzcz1nOyx0YB6xCd8IYc2SfAltaOj7r+PD2LP6eAeoK//FzAlFhK
         0xFQ==
X-Gm-Message-State: AOJu0YzPn8Quld4GOtRfh54jCRGwQfatuN4HgvkHr9h7fC7ifOq8b8HZ
        msbKbaClbIKXP/Ck2SfW+NYtaYY7SNzo1D9Wzuddrxds
X-Google-Smtp-Source: AGHT+IGc8rbAltPbhW/F+K8m0uCBqxxkmZHh/AgenqhR08Wj+pATxjfsKZe5oZaKwcnGW1CIGp0mkQ==
X-Received: by 2002:adf:fd4f:0:b0:317:636b:fcb1 with SMTP id h15-20020adffd4f000000b00317636bfcb1mr5633352wrs.27.1695306151764;
        Thu, 21 Sep 2023 07:22:31 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:31 -0700 (PDT)
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
Subject: [PATCH 1/2] staging: iio: resolver: ad2s1210: add phase_lock_range attributes
Date:   Thu, 21 Sep 2023 09:19:28 -0500
Message-Id: <20230921141947.57784-3-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds new phase_lock_range and phase_lock_range_available attributes
to the ad2s1210 resolver driver. These attributes allow the user to set
the phase lock range bit in the control register to modify the behavior
of the resolver to digital converter.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 58 +++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 71f0913b7e2e..f5b8b290e860 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -259,6 +259,60 @@ static ssize_t excitation_frequency_store(struct device *dev,
 	return ret;
 }
 
+static ssize_t phase_lock_range_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
+			       AD2S1210_PHASE_LOCK_RANGE_44);
+	if (ret < 0)
+		goto error_ret;
+
+	ret = sprintf(buf, "%d\n", ret ? 44 : 360);
+
+error_ret:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static ssize_t phase_lock_range_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	u16 udata;
+	int ret;
+
+	ret = kstrtou16(buf, 10, &udata);
+	if (ret < 0 || (udata != 44 && udata != 360))
+		return -EINVAL;
+
+	mutex_lock(&st->lock);
+
+	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
+				 AD2S1210_PHASE_LOCK_RANGE_44,
+				 udata == 44 ? AD2S1210_PHASE_LOCK_RANGE_44 : 0);
+	if (ret < 0)
+		goto error_ret;
+
+	ret = len;
+
+error_ret:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static ssize_t phase_lock_range_available_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	return sprintf(buf, "44 360\n");
+}
+
 /* read the fault register since last sample */
 static ssize_t ad2s1210_show_fault(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -506,6 +560,8 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
 }
 
 static IIO_DEVICE_ATTR_RW(excitation_frequency, 0);
+static IIO_DEVICE_ATTR_RW(phase_lock_range, 0);
+static IIO_DEVICE_ATTR_RO(phase_lock_range_available, 0);
 static IIO_DEVICE_ATTR(fault, 0644,
 		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
 
@@ -552,6 +608,8 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 
 static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_excitation_frequency.dev_attr.attr,
+	&iio_dev_attr_phase_lock_range.dev_attr.attr,
+	&iio_dev_attr_phase_lock_range_available.dev_attr.attr,
 	&iio_dev_attr_fault.dev_attr.attr,
 	&iio_dev_attr_los_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
-- 
2.34.1

