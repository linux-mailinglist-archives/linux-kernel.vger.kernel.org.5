Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC27A9D45
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjIUTa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjIUT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9141DAC3EB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:01:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so160694866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695319313; x=1695924113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDg1sZsypbtmVZl9501Jvjfjp7cqgNO2wWu9eDz+bAo=;
        b=ui7Ox8IF5Qgem4/I2L5PMc/oxrZj4rgl7jhksURNP1NKFMULGvZ9lf9joLQ3zd4Ss4
         xP5AXsBvZZL3BncL1gcrHAaEGFE4SlQqxc0dhAhk4BJVgp717sb/clppOQWX5xCwWOBa
         DXLA3Y+t+YxHilWupSurJuUFbDbBCKTjS621wPv5Hkfxr4iQrC1jn5yeMyi1RStMIlvH
         IshZtNHhy937YsKTMzaPeralQ1xveBWm+p81vYRCcF6FsJ7PNdvDxQzjQIDlSXrR9V+l
         wL1/Q+ygYrGPoxm4i5LE3G5mJSfZeCdNZiLLAaVBq7B4viZJD3U/WNbKzonWk9uhOCrG
         eOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319313; x=1695924113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDg1sZsypbtmVZl9501Jvjfjp7cqgNO2wWu9eDz+bAo=;
        b=Dj3ccJDQ/ARanJsltTVik/vUvSM//uBM6BnIDG9p3OoDs7/HGqqoux+EVUMpFvXWbq
         buWGb+55AzeJxQNAbjs9iSgbZ/7lfp9dhHZKeZR4KVf+JE85LtKX3kWVct8RerjegMaK
         yWHykYq7UiDOIsNrVwV/PVS8FTFNZbgMjNLI1MPXnpibUMERz7eboJ3qQiSIu5VkW1mj
         X25kvmW/+mOh15ynRRgnKUQ23y6kfD8Nn00s8oRmkCCfgKXHKJbw/SgaPPW1Ix3RaqdY
         LQhB+i4V2wmEFlAj7n6wmnM4SzEk/rPVwIbJRGbC7I6W+mihewrKDU5vQ/A+E7itQkUb
         1OOw==
X-Gm-Message-State: AOJu0YwNZ8EfL/0QfEIBB4hScnvVOO/0ULuIGXnFGZZd4pv+8g0HEr8j
        8y8q55x9mfilm+eulbuHAtm6NBxVC7dwPlvWn1utIR3Z
X-Google-Smtp-Source: AGHT+IHTDD4zYuu6lV9x3Jl/iVplDBdwIifaK9LFet9fL2i2jXEx9floEa+zeO5CPOjwgUdMkMbH9g==
X-Received: by 2002:a05:600c:2245:b0:402:906:1e87 with SMTP id a5-20020a05600c224500b0040209061e87mr5026780wmm.31.1695307461363;
        Thu, 21 Sep 2023 07:44:21 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:21 -0700 (PDT)
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
Subject: [PATCH v2 10/19] staging: iio: resolver: ad2s1210: add debugfs reg access
Date:   Thu, 21 Sep 2023 09:43:51 -0500
Message-Id: <20230921144400.62380-11-dlechner@baylibre.com>
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

This add an implementation of debugfs_reg_access for the AD2S1210
driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 3c81ee61b897..b99928394e3f 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -606,9 +606,29 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	return ret;
 }
 
+static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
+				       unsigned int reg, unsigned int writeval,
+				       unsigned int *readval)
+{
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	if (readval)
+		ret = regmap_read(st->regmap, reg, readval);
+	else
+		ret = regmap_write(st->regmap, reg, writeval);
+
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static const struct iio_info ad2s1210_info = {
 	.read_raw = ad2s1210_read_raw,
 	.attrs = &ad2s1210_attribute_group,
+	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
 };
 
 static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
-- 
2.34.1

