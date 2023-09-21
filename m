Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C15B7A9773
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjIURYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIURXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:23:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C3642C3A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:13:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso12646275e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316409; x=1695921209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYFN9YS9lGoY3Drq+6yfHeUu5PUEzCkva/9j6XN0ZE4=;
        b=2efiOwzUDnc3Jd61Owi4Ga0h1S17k2rrXV2JoGVfTkXAtgxfVhKhYWLM/OXdtsqXCU
         luiAXiWMjKr7uv5z0QduzOvqBawRLsuX8h7BjV0D+QLYbUFwsPwcZlEDmKPcQyluzhff
         JsTV6TxWIvdlf7HAzQAIhUvLsIKBJoqA7AnXMtflGBMooCfkcPYxZx+T0+f49wS51JIU
         uJTLBAxaVUWmqHAXcgkqL4+C7k+rjy7Z/1FuRlPaYbOLPuVqyLbZ8aZwGgzrUZdEjodg
         TpQ6VnbE4D2t4SpnE6JzNBlS5iHoH5RHt3rS7TsIISA4kWZcPecGIy3kb9F3GfIvJ1S0
         jjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316409; x=1695921209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYFN9YS9lGoY3Drq+6yfHeUu5PUEzCkva/9j6XN0ZE4=;
        b=MsaR840LW0G/ZKX5crRRzroQ8IAMbQBG2DUI7UFqFa8poeq+zZO8/P+RcYZGw9NL5/
         FDzEQSJdU0xgA50U/1TouKQspWQoeTu+kXu2OMCb21wqcF4Ze1/nET6mpV+bV9x6ZQrF
         MmiQfFXa/SAj0mSsrwX4i7PAxOtirYyQQTFg/GHlLpAoDnmBpc8P4+ovyclK451Fa/4O
         c4uMbuyoIW813WxlzutUoAxGczzkygo8fflowsOpvW8rwnuqYfES71bsKM1nsIH1is2h
         qsLpvcxcjvkewJ6ISoC9Do6/roeCV0rscfZVRJ94HSQCuy3rJpnXRnom+87qh/QYb7q2
         1nTw==
X-Gm-Message-State: AOJu0YxysCAaztIyLe1xdIjL7P1ANBNIIZugS/rT0IMQPfkxGsUmJy0c
        UD7yA4Dds2MlBFoLHxwEvBKm1tjcWbSG1ivQxONOU9jI
X-Google-Smtp-Source: AGHT+IFu1F25pmyaAgzXYF1qsHUDXBwQ437AiaWnWjMjwmw80fpRWTPc2ECeCGljKdTfsMbdgIq1Yg==
X-Received: by 2002:a1c:ed08:0:b0:405:1bbd:aa9c with SMTP id l8-20020a1ced08000000b004051bbdaa9cmr5515593wmh.34.1695306166581;
        Thu, 21 Sep 2023 07:22:46 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:46 -0700 (PDT)
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
Subject: [v2 16/19] staging: iio: resolver: ad2s1210: rename fexcit attribute
Date:   Thu, 21 Sep 2023 09:19:44 -0500
Message-Id: <20230921141947.57784-19-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
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

