Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721B67F5C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjKWKai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjKWKac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:30:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE951BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:30:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b2b3da41eso4443555e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700735436; x=1701340236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDvQiw4cemCoVq0HDRpi4PQAGFKid5h4mEpxV2nsTWE=;
        b=bayoDUzHcPEGup2iGzwEYZIBD2pc+esFdlbzb3OKbGUdjFFEdf8gY0Rk5E0cbkRNDw
         J8Bjy6Ek92rsYl7mWYXft7Sx2iCENinlfK7yAGMVTPxvzLGeMf+Vnjg6XXFNCH1gtYJj
         yLsA0H5e87mxkzvD4Y/Ypea+7pH3bBJ/hKDdNZmlx9lCkzoZSuh9BZ84QIe8uI7etmAp
         aVv833+FmlpR71Tp/5JPZ+Ju6dHDMC/BxlIvBmuXsS7jHmybWBe6xvYPfm+vSQ+c6v+a
         xr8Of/GyTT220axJwGV43i86G/X4W4PmfHbKgt4VE3B81FnvbU+NbdaCWSY83759Erhb
         TM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700735436; x=1701340236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDvQiw4cemCoVq0HDRpi4PQAGFKid5h4mEpxV2nsTWE=;
        b=YK+JfhPt5xrhzBFY0L9HpUhX3e/IT0zMGjm52rAifkJdPSP3qQP4l2Zmvc8WFADLrL
         oW2UB8LM2qJBDf5sD4vJpu2IZNdwQFfM5Y0qZ1CBKfx3joWyJ3CbwiB7wB18JsGpc4+S
         hFApe1VEpVs8AD7OVLgt5FdOPbyMT2WZf+BoELKBCvoaWikhwnLZt2OntgU8GVfcmwRR
         SLwvUSscZzY/usy4A9jx512B6Gq9+YQxGHvDWKp85aVSTGQ1hKSjs5L5YDy3RZQNPksn
         eum27DCoAXiPNViPXyOctflfIFFdSGVr7yXN6I7TmBfYmTnbWIqNTTzVDxzDk4eBVRWs
         4soQ==
X-Gm-Message-State: AOJu0YweXY4mkEyJIOHKaiFiayR6LrhSWNamuWp8OhLN+RXX5xPj0dWN
        JpUK5UYT5pf7cek3cL/C4XPIlw==
X-Google-Smtp-Source: AGHT+IHU7fDCbDaC4fsuwrpKT4bl5Qi/bZUq9jazliF+vOB4RrDB8zsSzqbs9eH1GvvGjjdhMLY2Cw==
X-Received: by 2002:a05:600c:4ed2:b0:40b:35f2:3b42 with SMTP id g18-20020a05600c4ed200b0040b35f23b42mr1022638wmq.22.1700735434977;
        Thu, 23 Nov 2023 02:30:34 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:9abb:eb66:c3a9:102e])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d664c000000b003316be2df7fsm1257834wrw.17.2023.11.23.02.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:30:34 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] eeprom: at24: use of_match_ptr()
Date:   Thu, 23 Nov 2023 11:30:32 +0100
Message-Id: <20231123103032.11396-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver does not depend on CONFIG_OF so using of_match_ptr() makes
sense to reduce the size a bit.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- use __maybe_unused to avoid warnings about at24_of_match not being used

 drivers/misc/eeprom/at24.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index f61a80597a22..8279adade07e 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/nvmem-provider.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -242,7 +243,7 @@ static const struct i2c_device_id at24_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, at24_ids);
 
-static const struct of_device_id at24_of_match[] = {
+static const struct of_device_id __maybe_unused at24_of_match[] = {
 	{ .compatible = "atmel,24c00",		.data = &at24_data_24c00 },
 	{ .compatible = "atmel,24c01",		.data = &at24_data_24c01 },
 	{ .compatible = "atmel,24cs01",		.data = &at24_data_24cs01 },
@@ -812,7 +813,7 @@ static struct i2c_driver at24_driver = {
 	.driver = {
 		.name = "at24",
 		.pm = &at24_pm_ops,
-		.of_match_table = at24_of_match,
+		.of_match_table = of_match_ptr(at24_of_match),
 		.acpi_match_table = ACPI_PTR(at24_acpi_ids),
 	},
 	.probe = at24_probe,
-- 
2.40.1

