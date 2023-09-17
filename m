Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944337A34C8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 10:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbjIQI7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 04:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjIQI65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 04:58:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829ADAC
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 01:58:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5031426b626so172477e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694941131; x=1695545931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u66nMfJzlnM3RSBfHLUmO0kR6qeofo6vre+9QbeMy4=;
        b=MRjN2nZ3N9kXUEttWugJSgdUnHBKAdImYPpJagwFYEqKZniY/rVg7Ec7AbdQb3oSkP
         0rLIfuCIFfYIp0lQheUjqvt1Q2cCfUyvf8wfvW+92cYXied55i9nTBWuoHSf7SCLKpaf
         vqw0b0a4kS1Bg/unIR/RPTx+SGs7d/Z84kVhS0cvVDk0/wsrBA85u9NVNsM5a9Myehup
         Y18eNxQEqhkbR3kSMOn2i1E1ptqUTMSMx5bR1sc3qrOF1gJiU0FVY4K4YCVBf1CbOeSw
         Bvooek9BB+yQ9xwEpb4ywc3y0ODoULA7EaKStSPOKFkg5RTCqwNO3JY3eeufBi2Q1y1G
         Kmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694941131; x=1695545931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+u66nMfJzlnM3RSBfHLUmO0kR6qeofo6vre+9QbeMy4=;
        b=aCdLJrAe5ZQDLi21KWwyEhRFh7IpV09n5cudn+KNdCzk/swpUurtdQzGIMnEjI6Gwr
         Liw69ntZIaP1btlLEpMf+YrYTjJ8aRoOSuDefyRp9lpn3WwQfKsAxZfxVvYKYMenVVkJ
         UCBhNj+znKf6hjoYZdaqzqrmdxuyyMkMLBooBYTdPI82cZd1Gh+Bg52ToZivBnh7bYhe
         Tn0Qlqav2UoCWll+UF+X1zhqOkOax167okdDqXWAXzRu5VVI/+QS2/2ZmitYE9XbA87J
         b8up7DrUFSU90x0p86VU1LZnzznGs4WSh16wmFABihKKG3Vd9a/79eWH/KkM3GXsDfnS
         gumg==
X-Gm-Message-State: AOJu0YwjSiNuL+rub5ShQAg9FVATtUE9+0WO/kdR3MDYZOEHftCvU/er
        K6D1j/yfal28IzDiIdg32KyUFA==
X-Google-Smtp-Source: AGHT+IEhRBzkE8VbZxAIUZPx6lM6tkI2XGijQtYW5uVW0Z3/7exPAUPR2ohzsgqOKgxhvbxJGHdBmA==
X-Received: by 2002:ac2:5323:0:b0:503:55c:7999 with SMTP id f3-20020ac25323000000b00503055c7999mr1962964lfh.34.1694941130545;
        Sun, 17 Sep 2023 01:58:50 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4ea0:9945:6800:8739])
        by smtp.gmail.com with ESMTPSA id r10-20020adfdc8a000000b0031aeca90e1fsm9240971wrj.70.2023.09.17.01.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 01:58:50 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 2/2] gpio: sim: initialize a managed pointer when declaring it
Date:   Sun, 17 Sep 2023 10:58:37 +0200
Message-Id: <20230917085837.6199-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230917085837.6199-1-brgl@bgdev.pl>
References: <20230917085837.6199-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Variables managed with __free() should typically be initialized where
they are declared so that the __free() callback is paired with its
counterpart resource allocator. Fix the second instance of using
__free() in gpio-sim to follow this pattern.

Fixes: 3faf89f27aab ("gpio: sim: simplify code with cleanup helpers")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 4d74ea3a4269..24c19c7c50a0 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -1481,10 +1481,10 @@ static const struct config_item_type gpio_sim_device_config_group_type = {
 static struct config_group *
 gpio_sim_config_make_device_group(struct config_group *group, const char *name)
 {
-	struct gpio_sim_device *dev __free(kfree) = NULL;
 	int id;
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	struct gpio_sim_device *dev __free(kfree) = kzalloc(sizeof(*dev),
+							    GFP_KERNEL);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.39.2

