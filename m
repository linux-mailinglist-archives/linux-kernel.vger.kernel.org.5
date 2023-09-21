Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA767A9ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjIUUMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjIUULs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:11:48 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F145AA83
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:21:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c007d6159aso21441401fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316882; x=1695921682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDg1sZsypbtmVZl9501Jvjfjp7cqgNO2wWu9eDz+bAo=;
        b=PgHTlmA9ZZBPsUHkRek3QR07IKwzAo5DleHlDtwQe9dKPw9bk3uzFx6mC3JiqzAoe5
         o2z9GDYDukAmISUOdBTofle92Q1pQ+2aIwlvIcgtu0E0wHXLDYrTmqmD2VUPmxkX2gZq
         uiBqm13rY++vFrNGu02o7SsNFLl3HFjhtYjr7sxDlYuuW+6eFH0el3wFrIhP6+2G569J
         EuqaNytOhFE+uIcSqbELz7GGluAHNTqJuNzRLIn0qRJSskyyltFj/xPV11uHDfWhE67S
         hOVm1tI/NayaubkwTnN29OaoEW2C3V0rIoD/hEs/jHnEXT2Y3h5wlFVrMK8N+5uX6oK7
         cI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316882; x=1695921682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDg1sZsypbtmVZl9501Jvjfjp7cqgNO2wWu9eDz+bAo=;
        b=jI0po5fbAWubTedurd+iLlsUKT582kQeAlHVMM9fpj6t00tsg7EPORknerV7kStJKi
         Z9FQXaiLJzMwAa0CTZleNmmnb0QLluv61BPHfFJTB4ykApDPTZ4IErI4fUhMkZwU/axY
         ov6I+QfYsgIr+ybU2FLk4S/iMsQkY6jKTnplaoBSi6n+ACFRai0mS8wTspTXV0Qr+ooK
         I+ZdoXl9zFTAYxghOSv9YlGrat7q7EOU7hQoYXqUmyoJ9+wGKDzip/Z+osSl+uHOchp9
         e8ZiMTo6HNmXKGX8Vr3UQJJhfa+/S9NFL66nLte3dgmdLlFPjckNHGU+NshVKoE9jFyk
         kCBg==
X-Gm-Message-State: AOJu0YxnqHjnD8GhrWEKFt1MdFjQDqoorpcqvbuuYolRifhP6JWHvDbC
        ASkSQaXvZyDl8QSI7NhDO5ErntATBxvBuehmCRODYCWR
X-Google-Smtp-Source: AGHT+IGgYCYV4RIyluC952QS15xlxGsYiHuw3JJvkpeLNvHhq4UFPDC/C6dReCQO1m30NxXKsPt5kw==
X-Received: by 2002:a5d:4c85:0:b0:31f:a259:733 with SMTP id z5-20020a5d4c85000000b0031fa2590733mr5275304wrs.20.1695306161138;
        Thu, 21 Sep 2023 07:22:41 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:40 -0700 (PDT)
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
Subject: [v2 10/19] staging: iio: resolver: ad2s1210: add debugfs reg access
Date:   Thu, 21 Sep 2023 09:19:38 -0500
Message-Id: <20230921141947.57784-13-dlechner@baylibre.com>
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

