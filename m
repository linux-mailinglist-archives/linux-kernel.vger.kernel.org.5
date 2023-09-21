Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4722D7A9D30
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjIUT32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjIUT3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632BE5FCB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:09:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3214cdb4b27so1214881f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316146; x=1695920946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWgDNsrrXF5syWEsVgdKbxr1ASE09oFAZQly/Ty6i74=;
        b=wNowJkgm6tzUaoI+x4w+v7mhL0Je6UPMVV6SPamP70hGNqS0OdnuM0NLABwqkn2TJJ
         yk3G6DPz+bdazgIQky6vh+hEwV1xjvjKf5RIE8NISFIc8BF8wZDyaLUcFn2JAOBdimAw
         p7YWei25EKwHnkVr9+a3FMTN9Ee7GMdfm6qTHxrAvUI4GmYNiQVODhCgYGfr83JlIZMz
         vMV5eQolyO9fSEiGA/ioNpaCwdudGyWJlxkKxwjspVnC97WRgijnLLjsgbHRfd0COs4Z
         Y6NdBRdCiFGj53RBKP8jo/wdyZlR1vBXPnam7C1UOi2x0XCRi7diNnXxry0UXrmrwDYJ
         a9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316146; x=1695920946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWgDNsrrXF5syWEsVgdKbxr1ASE09oFAZQly/Ty6i74=;
        b=EiKDgDzVTnsdiKjgIQzgr+WpnBhKJD0iMBxE7MYztnHgjga5/xsTCGCS/2kg6RD8oI
         jHOX3YU49Jcfr3MsnhS1fM099GdvtOlSLBWBnDku58W4rQCqa3YGixWDhh0UjRQnyyjH
         e3UxaMaepT9jR6M8hwNox7iEIhT7M/7feK9lRY4GtVjCbcDQw40o1r93rALTJg6vQ8B6
         PKuUzwWOtnNeJKmw76jZJoVYJqpzJmvbz59q2hss2JnB3Aa+VuD8qp5JohKkVWx7j6HZ
         e5s7HUZ4x/WOxqvCmTrjFBQpfLpKIVfkLFaWtbwxB11UcAAqRQ16ycdbO24FyMupsT1P
         u3mQ==
X-Gm-Message-State: AOJu0YzLQt7cF2eJOU+kL0Oa7NRBKKBkgPTPq3+KIHc3ju/+LR/UW+7K
        HDTlEDt6xQoKw7gZ8+SSSc/0VxFdLQUy58Ay4+Q0Tgzz
X-Google-Smtp-Source: AGHT+IGRjZhp2R5sxkFWDdwbOa90jJSgYK4eOmJzrC4HUjAJ3wveQwXoDeexC2vjkJhYZNOJkJ9DkA==
X-Received: by 2002:a5d:5192:0:b0:320:9e2:b3a2 with SMTP id k18-20020a5d5192000000b0032009e2b3a2mr4841480wrv.33.1695306164753;
        Thu, 21 Sep 2023 07:22:44 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:44 -0700 (PDT)
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
Subject: [v2 14/19] staging: iio: resolver: ad2s1210: refactor setting excitation frequency
Date:   Thu, 21 Sep 2023 09:19:42 -0500
Message-Id: <20230921141947.57784-17-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
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

This combines the ad2s1210_update_frequency_control_word() and
ad2s1210_soft_reset() functions into a single function since they
both have to be called together.

Also clean up a few things while touching this:
- move AD2S1210_DEF_EXCIT macro with similar macros
- remove unnecessary dev_err() calls

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 63 ++++++++++++-------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index fe413759deb9..f1ffee34ebbc 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -53,12 +53,11 @@
 #define AD2S1210_MIN_CLKIN	6144000
 #define AD2S1210_MAX_CLKIN	10240000
 #define AD2S1210_MIN_EXCIT	2000
+#define AD2S1210_DEF_EXCIT	10000
 #define AD2S1210_MAX_EXCIT	20000
 #define AD2S1210_MIN_FCW	0x4
 #define AD2S1210_MAX_FCW	0x50
 
-#define AD2S1210_DEF_EXCIT	10000
-
 enum ad2s1210_mode {
 	MOD_POS = 0b00,
 	MOD_VEL = 0b01,
@@ -184,18 +183,29 @@ static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
 	return 0;
 }
 
-static inline
-int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
+/*
+ * Sets the excitation frequency and performs software reset.
+ *
+ * Must be called with lock held.
+ */
+static int ad2s1210_set_excitation_frequency(struct ad2s1210_state *st,
+					     u16 fexcit)
 {
-	unsigned char fcw;
+	int ret;
+	u8 fcw;
 
-	fcw = (unsigned char)(st->fexcit * (1 << 15) / st->fclkin);
-	if (fcw < AD2S1210_MIN_FCW || fcw > AD2S1210_MAX_FCW) {
-		dev_err(&st->sdev->dev, "ad2s1210: FCW out of range\n");
+	fcw = fexcit * (1 << 15) / st->fclkin;
+	if (fcw < AD2S1210_MIN_FCW || fcw > AD2S1210_MAX_FCW)
 		return -ERANGE;
-	}
 
-	return regmap_write(st->regmap, AD2S1210_REG_EXCIT_FREQ, fcw);
+	ret = regmap_write(st->regmap, AD2S1210_REG_EXCIT_FREQ, fcw);
+	if (ret < 0)
+		return ret;
+
+	st->fexcit = fexcit;
+
+	/* software reset reinitializes the excitation frequency output */
+	return regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
 }
 
 static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
@@ -210,11 +220,6 @@ static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
 				     bitmap);
 }
 
-static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
-{
-	return regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
-}
-
 static ssize_t ad2s1210_show_fexcit(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -229,27 +234,24 @@ static ssize_t ad2s1210_store_fexcit(struct device *dev,
 				     const char *buf, size_t len)
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned int fexcit;
+	u16 fexcit;
 	int ret;
 
-	ret = kstrtouint(buf, 10, &fexcit);
-	if (ret < 0)
-		return ret;
-	if (fexcit < AD2S1210_MIN_EXCIT || fexcit > AD2S1210_MAX_EXCIT) {
-		dev_err(dev,
-			"ad2s1210: excitation frequency out of range\n");
+	ret = kstrtou16(buf, 10, &fexcit);
+	if (ret < 0 || fexcit < AD2S1210_MIN_EXCIT || fexcit > AD2S1210_MAX_EXCIT)
 		return -EINVAL;
-	}
+
 	mutex_lock(&st->lock);
-	st->fexcit = fexcit;
-	ret = ad2s1210_update_frequency_control_word(st);
+	ret = ad2s1210_set_excitation_frequency(st, fexcit);
 	if (ret < 0)
 		goto error_ret;
-	ret = ad2s1210_soft_reset(st);
+
+	ret = len;
+
 error_ret:
 	mutex_unlock(&st->lock);
 
-	return ret < 0 ? ret : len;
+	return ret;
 }
 
 static ssize_t ad2s1210_show_resolution(struct device *dev,
@@ -624,10 +626,8 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	if (ret < 0)
 		goto error_ret;
 
-	ret = ad2s1210_update_frequency_control_word(st);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_soft_reset(st);
+	ret = ad2s1210_set_excitation_frequency(st, AD2S1210_DEF_EXCIT);
+
 error_ret:
 	mutex_unlock(&st->lock);
 	return ret;
@@ -773,7 +773,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 	st->sdev = spi;
 	st->resolution = 12;
-	st->fexcit = AD2S1210_DEF_EXCIT;
 
 	ret = ad2s1210_setup_clocks(st);
 	if (ret < 0)
-- 
2.34.1

