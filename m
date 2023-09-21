Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3937A9E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjIUT6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjIUT6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:58:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23555E0A4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:29:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401da71b83cso12844465e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317375; x=1695922175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5XZRvh5FJ3F9RXkqi8NbBrwtIOGm1RUjmAFGYn0SWM=;
        b=G3Nlc/Nn/wLfLhPbsfjQt9FgtoM0PgvCc6mxXqC+4By9eIxGr9FxJ9FBI/5Q/72r1u
         R2hu3ehA3431xwmKQRLwLZs104RWynFdOtOwpYhcv82J6IIom8p5DT/kENc2B2uEI4Kk
         VgiEVSOCkCvQZZRxAYCYoyDsI9XcNnr1Lk9p+8/pNnpBRzdgTJPL+pfNU5Ngd0H6ls9v
         mr9e0idwX+lTIBHxPE59ofBnm5vjNE4GE2+TxLwWI1MuNIfrHbpZbnFhA7AtmZmrUXVo
         rGNbRxyULeMGS5f2pZuQxMN1mdNk1DKg2GGr2VJlJoNeQmjcRPnCCBH0pqqV9dRA4Rv2
         EODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317375; x=1695922175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5XZRvh5FJ3F9RXkqi8NbBrwtIOGm1RUjmAFGYn0SWM=;
        b=aWuEp68I5iO0s2opKJx7Q217L6n/8Idx7cY8kFXEBmrDOZYWdE0NApqvKy83dzCejp
         AW1IKH2SI72+oCywYK6FNal3eHCGbE/EbhShitqvFzBt3Cd56YAF4zwXWpKPucYq2l4f
         oQQlolIeDxxMWIevg6HoqT/O1JLLZ2p3Bml7EzVrOf9VfQb9YW7ySqwyMlW2z3RJXAOe
         D8x1RxwB+jUBymUmZqsLQpk1oYvUZ9eEH4BKYMgU7/47msIJr8MmcyREmiKM7IPkrdW6
         cxCzESPSWZ1rFn2ZHE+s+NOKdm6TBpI08b5+53axOBaIuSyTSOVc0BCdsz3I2e/eDtR2
         COAA==
X-Gm-Message-State: AOJu0YwpSjAAmjq2ygeAMDqS3HHXLvi/7rysQEtrGNr6scPXMu0xZoGx
        xR4RI5eUm+3/me/vblhkFSUiDeoPhfMgLA54mUBbb7Ah
X-Google-Smtp-Source: AGHT+IH08jq16ad3p4HMe9xcyB8hweATSv5qN9lzeXRVPAWw2aoHMZLAHGaB/1pFA589xCpY6igblA==
X-Received: by 2002:a5d:4289:0:b0:319:7a9f:c63 with SMTP id k9-20020a5d4289000000b003197a9f0c63mr5309192wrq.50.1695307468423;
        Thu, 21 Sep 2023 07:44:28 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:28 -0700 (PDT)
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
Subject: [PATCH v2 18/19] staging: iio: resolver: ad2s1210: add phase_lock_range attributes
Date:   Thu, 21 Sep 2023 09:43:59 -0500
Message-Id: <20230921144400.62380-19-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
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

