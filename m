Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973417F4BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbjKVP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344245AbjKVP7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:59:41 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A306F92
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:59:35 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4079ed65471so35343005e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700668774; x=1701273574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8wkJWpPzXVPRgDS/WddlejSs7PCXn5mUATF2Jmfj7mc=;
        b=sKg//tqh1z9aGk7XKkuZC03JnUdIOOwA4hKRj5RNEIokZ83SxsUQRJ+M9nvkclyR4C
         bFMVMv2wDMQxRClMaS/02ipTiZpaQZ8jZy+tMCvg4Y8611bbB06QJjBY1hHOF2/YVqUg
         tjxI11yJnYYA2LWCeRAR+mN/NerpVCM4ittVvLcXms34QE532XL38EDLk75JziGHYK1j
         dobBgTTeNkEb8k+QRfthGTVlEp8tk7leR8THw00Py6UpSApbBvHMBFKuJOXF3nd5PBwJ
         zMSwK3TSsOvN2kHPlveuZ12lwhO56hMDmzJt8G0+la5ZiK5wZd7kMzolhRwtCxjurlaX
         Lrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668774; x=1701273574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wkJWpPzXVPRgDS/WddlejSs7PCXn5mUATF2Jmfj7mc=;
        b=Iew9M592+R4hHM6WKmWFK3cv+9oF+V7klPq2c7biAHEkWqXAGb3GVuQdQzpl0SE/xR
         wM0C2PFuLwMCEg5+XihPZbwwA55yCQidS6GIiWjvImv8oAnFRV5PagSz2b71oeXJzVp/
         Ye+DKHa6ean2Vv7H3e48GCyLcLNDd1hMU4NTbzXyAc2isasZ5pukqoADXNnovHVks0Hj
         2clrxJNa6USZCUFHh5RE+0YCHb9VTUyKfpS1ZiO8jKUKf+7QShafAPAk87PO5tSoZqQq
         5099x78I76MK7ZnOwYDpwJ29LT5eYoVFzzmlR6Wl0bLfqnFv8VL/F3AluW1K5dkMakmK
         NZBg==
X-Gm-Message-State: AOJu0YynCZnRRJFwEvKcvV3jx4148xM47+znXlJQLG3sf7n6Jj5unLQK
        F0PVv+w3bjwkCwTiXK32Q5tOLQ==
X-Google-Smtp-Source: AGHT+IEfa2urc0vHXWsGVTyp1rNTre0crbZVtzuV+wVShCjSUhwjtJ8mLf33LNBqi7aCq+6Vowt6LA==
X-Received: by 2002:a5d:59a2:0:b0:32d:a495:a9b7 with SMTP id p2-20020a5d59a2000000b0032da495a9b7mr1710247wrr.61.1700668774009;
        Wed, 22 Nov 2023 07:59:34 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bc76:bea6:6d96:7507])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600c199000b0040b1a3c83b6sm2644279wmq.40.2023.11.22.07.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:59:33 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] eeprom: at24: use of_match_ptr()
Date:   Wed, 22 Nov 2023 16:59:16 +0100
Message-Id: <20231122155916.38037-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
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
 drivers/misc/eeprom/at24.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index f61a80597a22..76a0b9b2fcc4 100644
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

