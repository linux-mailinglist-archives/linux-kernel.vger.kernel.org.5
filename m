Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9154577605A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjHINO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjHINOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:14:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C375E5F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:14:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbea147034so57590215e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691586893; x=1692191693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gMEpKFy6UqkVloE+P0Ccdw0TcVvUrsnSGcQwKKkLpg=;
        b=VEzjKNOWVO2zUSd3wvUmHkJLAB5ce68Q8Q0Y2Xi492oiqKrX3dCss8jwR5iSaqBShW
         QDbIZiX+MCQ7BXMIwQys2a+TXDo/6q72iNc57OnZwG4T6IeJncz8/5xEGTpgwMwA9vLR
         bq/XZKHUBvGnSqPDr0oFXI2Lmn6dqz5kxn0NQm6y6GHIzVl2PfcP9vj9GdJrOkqzoak+
         tsLKExX4t2G4jHTZ+9tew5PZL0s0kCv7X6JelmhVe97npha5JckPjCpxPKvtgKAm5P9z
         2b6mNbvSsVHTkz7P3UPwfnZ7vcEOGkG0y7zIF4NLTMALMDdJhLZUbsQrWEDmSDGYokni
         J3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691586893; x=1692191693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gMEpKFy6UqkVloE+P0Ccdw0TcVvUrsnSGcQwKKkLpg=;
        b=WazDj5ADQKAJBcZ9EtxhI6YACCO+nNWZE7xlyVxVMbssewNL7o8tsC85IvG46Lztzi
         c15HGUh1ichNQlukQW9W9/PWrybxPHWgKorL4BvahLX7xAyIPe4AawI7Qzrsj5JFPCqf
         cxt9fkddtJ6xr0wB3Wu5UaBYw6kTQOJ1+v3JgyeLOdeidfiE6d0X5eRrzrYAamIf1XMv
         q0Q2atH8BVbV2kcg8M7bHUxOBq9iQNS8NDZiu+aJbH0RPiSBv2a4QmtJhu5p5KMo70pK
         u253FgQfsHUbxZ4IKsV5d156ZGTjUi4izUjQYBTzmslC4y8MMqA1/cV+OJTtQjuN7ogi
         GQBQ==
X-Gm-Message-State: AOJu0Yytp108gwTrpkUpsPpuTvUdScDUNMBpbttqlJ3UhNS5eIlDiURt
        z1jQQa8E5d5rAJ6HggkXgAdSMQ==
X-Google-Smtp-Source: AGHT+IHEAqEHBIFleL5T4YlH3dT+QL2r2814K5dKUT5LDQKlhn8fqXBrVNDF10tt/6LrSNaXatiPOw==
X-Received: by 2002:a05:600c:22d8:b0:3fe:3004:1ffd with SMTP id 24-20020a05600c22d800b003fe30041ffdmr2233608wmg.4.1691586893062;
        Wed, 09 Aug 2023 06:14:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bf0d:f784:9c7e:dd22])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b0031134bcdacdsm16741185wrw.42.2023.08.09.06.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:14:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] gpio: sim: use sysfs_streq() and avoid an strdup()
Date:   Wed,  9 Aug 2023 15:14:41 +0200
Message-Id: <20230809131442.25524-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

When comparing strings passed to us from configfs, we can pass the page
argument directly to sysfs_streq() and avoid manual string trimming.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 8b49b0abacd5..dc4097dc0fbc 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -1272,7 +1272,6 @@ gpio_sim_hog_config_direction_store(struct config_item *item,
 {
 	struct gpio_sim_hog *hog = to_gpio_sim_hog(item);
 	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
-	char *trimmed;
 	int dir;
 
 	mutex_lock(&dev->lock);
@@ -1282,23 +1281,15 @@ gpio_sim_hog_config_direction_store(struct config_item *item,
 		return -EBUSY;
 	}
 
-	trimmed = gpio_sim_strdup_trimmed(page, count);
-	if (!trimmed) {
-		mutex_unlock(&dev->lock);
-		return -ENOMEM;
-	}
-
-	if (strcmp(trimmed, "input") == 0)
+	if (sysfs_streq(page, "input"))
 		dir = GPIOD_IN;
-	else if (strcmp(trimmed, "output-high") == 0)
+	else if (sysfs_streq(page, "output-high"))
 		dir = GPIOD_OUT_HIGH;
-	else if (strcmp(trimmed, "output-low") == 0)
+	else if (sysfs_streq(page, "output-low"))
 		dir = GPIOD_OUT_LOW;
 	else
 		dir = -EINVAL;
 
-	kfree(trimmed);
-
 	if (dir < 0) {
 		mutex_unlock(&dev->lock);
 		return dir;
-- 
2.39.2

