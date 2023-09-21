Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E936A7A98CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjIURwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjIURwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:52:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC546900D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:30:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50307acd445so2126474e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317412; x=1695922212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYFN9YS9lGoY3Drq+6yfHeUu5PUEzCkva/9j6XN0ZE4=;
        b=qUoTboMIeKzd8421AFwx9laig8g+W6M7oJlWwpXuSZ9YTDaEauUoKdCWO50Ncvt1Me
         IsjlpJAiBAdGcXCOJWUi0lvj+42KZ1hYWzKe8Mu+UtlU8a9MvcZAG7wtmsXFSL1D6hE/
         HJZxq2QPyAuBw4c8XmmQ4YqEqeEgXVqEO2atpgA6carSC/apENn1Cp18V+3VGQZdp/oD
         QrZynGVUf2XNWJEvwPNgwHiKRcIOe9SuSMurvslg3LYWWKSWSJlYO8m+laHb/zE3D392
         134QwMMt46oyz+8RdeBsVgxQzFtMi+o8Ajbjzncru8ouR6+w+eqtVOTpqKOMhRc+O2io
         bdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317412; x=1695922212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYFN9YS9lGoY3Drq+6yfHeUu5PUEzCkva/9j6XN0ZE4=;
        b=qACZ7+CjYpuQbg8bX3dqCP5zmYu+UOp8hPFbXAk2hO/wunMWQLpbwt+YMfdq8CrtMb
         BUzX9TyH0Uj9pXnNAK30BqLobYlXtgDCyZnuI97PRC5iHO0I3xdCgdfL5A2o10fqVSaH
         IRfwwuhDEYv7YUfwwfHq3XhuuHn26x3QMfq816bKOqpdKZBwvWNMt60bmm7nuhvxssq0
         KHN/4TdiRBAJno/s8GJlSDZ3C0pq1ttJPqXqLHTAHj7cH3iurvSnt4G905se4R3hXiei
         D7sftSOAKyhY6EvVR6ppy3X7qvqnc0FjPdx/VorSFyUXdePR9lx8WqQY5FIZNfDFxDIS
         6v3g==
X-Gm-Message-State: AOJu0YxqM/N8Hq+VEe409ZAnr7Jrs/17l4JhnqB6dVH7fVTQAFEdP9Y5
        F4faJOSg3urM75ifGXGb/UXjIxrXAjB2O39q8OujgSKN
X-Google-Smtp-Source: AGHT+IGzi9ygNvTFbE+Q0DTN6Dqq1DY5zH+YbCcxdTub+gBa6RSxhhAqH5GwDY9iR65TpVMFQugkOA==
X-Received: by 2002:a05:600c:478a:b0:405:3955:5872 with SMTP id k10-20020a05600c478a00b0040539555872mr743765wmo.18.1695307466583;
        Thu, 21 Sep 2023 07:44:26 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:26 -0700 (PDT)
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
Subject: [PATCH v2 16/19] staging: iio: resolver: ad2s1210: rename fexcit attribute
Date:   Thu, 21 Sep 2023 09:43:57 -0500
Message-Id: <20230921144400.62380-17-dlechner@baylibre.com>
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

This renames the fexcit attribute to excitation_frequency to be more
human-readable. Since we are already making many breaking changes to
the staging driver, this is a good time to do this.

Also make use of IIO_DEVICE_ATTR_RW while we are touching this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 27294eff99ef..14bec2b20939 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -217,9 +217,9 @@ static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
 				     bitmap);
 }
 
-static ssize_t ad2s1210_show_fexcit(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static ssize_t excitation_frequency_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	unsigned int value;
@@ -240,9 +240,9 @@ static ssize_t ad2s1210_show_fexcit(struct device *dev,
 	return ret;
 }
 
-static ssize_t ad2s1210_store_fexcit(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
+static ssize_t excitation_frequency_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t len)
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	u16 fexcit;
@@ -555,8 +555,7 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(fexcit, 0644,
-		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
+static IIO_DEVICE_ATTR_RW(excitation_frequency, 0);
 static IIO_DEVICE_ATTR(bits, 0644,
 		       ad2s1210_show_resolution, ad2s1210_store_resolution, 0);
 static IIO_DEVICE_ATTR(fault, 0644,
@@ -604,7 +603,7 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 };
 
 static struct attribute *ad2s1210_attributes[] = {
-	&iio_dev_attr_fexcit.dev_attr.attr,
+	&iio_dev_attr_excitation_frequency.dev_attr.attr,
 	&iio_dev_attr_bits.dev_attr.attr,
 	&iio_dev_attr_fault.dev_attr.attr,
 	&iio_dev_attr_los_thrd.dev_attr.attr,
-- 
2.34.1

