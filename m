Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660467A303A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbjIPMjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbjIPMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:39:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FCCCEF;
        Sat, 16 Sep 2023 05:39:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502fd1e1dd8so1166168e87.1;
        Sat, 16 Sep 2023 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694867947; x=1695472747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYNQU7FPTvydILSwaK5s6AQY8aSIkTxjQ7ZIxHmCX18=;
        b=U80BwZbCz5EV1V9Vf6yjraZPBoQCrty40RaH1ZfCj0PxEginJT2U74Ss4+yb21eSgT
         Z5BR27haIXf4BeQiJUHSk6T+bAMT4LW/WC0XKqwzgvAOTMAH41NrFbIFvbMpX3KTsYfk
         imFTCUVNEQL3mXVbQ84owb7Kkhb+p4e5x6dPdfy8btIk44wkVjIm4gnqjPvEPLy2awVn
         87jom8j/UwXxQWmSGbJc0mo1zR3jBPMGZfqxsZCrustfU/zqKHWe5mtOP9a8eKY9NZ5c
         Kff3l5Azz77Q0qzcicUPDhRfzXY/PqtlXa8eTG+cRxRuZsx08SgFe5lTT2Sns9AgKdsD
         QJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694867947; x=1695472747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYNQU7FPTvydILSwaK5s6AQY8aSIkTxjQ7ZIxHmCX18=;
        b=BbsT7kAKBVQp4klRbBR7JCGenDcK6WNuOLJP0aczMUwHzKsnr0lbZuvwcTzKhsBpAa
         Wz/odZ1ykhIMvBp/O7e5wowhvpjcmPlz1+Oj4BDJiTzwYClxb3l2CYl2KNOqmKMh4QJt
         5MaBUrhr845sLT+lzZJzytSevaNYSo4senPoDD852f2NoFfBybJLEvBgb5RZenzuzTtC
         R7SSVmkGMh3mAtbkcrQKz6YjwlFnnj9E4NUqBqiWrcv+mXHhRIt8yzpRI7gL4wkMwMQy
         LtDQTrHPOJM8pL4yt2qfCmhNjijEepJdjfx6f5V7nv0ar9YeF/eqj8WE9YOmYUoZW8Xv
         AOjg==
X-Gm-Message-State: AOJu0YzkhZk5sS7yBrObu2vckia/upXMpdilDp0J6eSJ+U4+EG9Fmedd
        N3n23LJF031SjCT4jiANG3o=
X-Google-Smtp-Source: AGHT+IGJ6r1XVtdmzsBBFUnIUyW7I4dm3Ai02tPH6LrH/oRvJKGpCOaHvoH8GnNDrSR1/tw4IXZwmg==
X-Received: by 2002:a05:6512:3b27:b0:502:ff3b:766f with SMTP id f39-20020a0565123b2700b00502ff3b766fmr2027243lfv.6.1694867947453;
        Sat, 16 Sep 2023 05:39:07 -0700 (PDT)
Received: from localhost.localdomain ([77.134.181.150])
        by smtp.gmail.com with ESMTPSA id bo6-20020a0564020b2600b0052284228e3bsm3474064edb.8.2023.09.16.05.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 05:39:07 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v9 4/7] iio: accel: kionix-kx022a: Add an i2c_device_id table
Date:   Sat, 16 Sep 2023 14:38:50 +0200
Message-Id: <61b43bbf35d602eac34b6d81b4d1b2d7ba39786f.1694867379.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1694867379.git.mehdi.djait.k@gmail.com>
References: <cover.1694867379.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing i2c device id.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 drivers/iio/accel/kionix-kx022a-i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index b0ac78e85dad..c0d0b69680f9 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -30,6 +30,12 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 	return kx022a_probe_internal(dev);
 }
 
+static const struct i2c_device_id kx022a_i2c_id[] = {
+	{ .name = "kx022a" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
+
 static const struct of_device_id kx022a_of_match[] = {
 	{ .compatible = "kionix,kx022a", },
 	{ }
@@ -43,6 +49,7 @@ static struct i2c_driver kx022a_i2c_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	  },
 	.probe        = kx022a_i2c_probe,
+	.id_table     = kx022a_i2c_id,
 };
 module_i2c_driver(kx022a_i2c_driver);
 
-- 
2.30.2

