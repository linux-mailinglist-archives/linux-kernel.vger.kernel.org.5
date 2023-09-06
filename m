Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACAA793F86
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbjIFOvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbjIFOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:51:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC845198A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:51:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40078c4855fso36868455e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694011882; x=1694616682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KDOVmtH5V5na1fD7fuYCzll8sgI6SU6vTPQBBFOI8xU=;
        b=bdVzi54ySHHaM+iJlyTGSvlM8M1eMKO8W4K+/Q6JrQyNS9ggfwOXHJiiXTKhiniDDp
         KLjoVSMEIVbz4jIyF+gvV6nRhlgmvLWlBS1fsAgZI9itGwgaeREYvbCjFOuJKM31VMku
         MHWvIIGBFP8AsvSNGK0Aszd9WvpZnMUaZZfTHRM65GDyWHY/8IOMOYJf1L4/qtstxyeI
         YmrAP8/2mAJqCoWLfd9iTAu18FTTCxNDVnztU+7NsBNyFU9BxcfypNKFDI/Fx5xo291j
         HK2pz/Qb/IhZIc32STS/LtQH0q2wkySYfTUUZ+s75z553t9c7PkDchVvxgdbxelLafis
         NECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694011882; x=1694616682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDOVmtH5V5na1fD7fuYCzll8sgI6SU6vTPQBBFOI8xU=;
        b=NaIG2XBDqcA838aWLJ8eZZX6gufWs2ax94llCbb6bHEZgjtHVp3ghZVcrBmqSUzK6z
         lTW2CEBhlat6oDDWkpjsWOitlFWGoYhTBqChAOkresHTHaYKs7jdP2knfdeoTX5aPfmc
         1DEe7goAqEn9QP/9b+mAHw6VPgHLzAqpM3fo7uoXN9qpbKoCmejuGA8L8Yqf959VnyR5
         XxWlR3V6y1dsCoLOTq2fPDwPOxiBcvFY057uJcijaNAAMOIMh3+luLspLl95o09NuFcH
         Ezl/fZINB4WoIK6q3eUEEzK75P4ZYkL3JJERhCGrzkzt2TkQWokZecL+Bm2ScHem+pgn
         +RuA==
X-Gm-Message-State: AOJu0Yxl2j2eEymfBDcNPbeTY1a0RDkjm9pBGWg9TPoDs6u8m7JJnpcE
        9q5Urde8aymLrlLSvgytmfJIrr0NQxHyt57QuIA=
X-Google-Smtp-Source: AGHT+IFwBB/UwPs+Fde43SNlv+WtDjxYU8FeOqKMZS6eOUypfkOHxWPTUmVAImNI/wSgof9CMLfKpg==
X-Received: by 2002:a05:600c:a388:b0:402:95a0:b2ae with SMTP id hn8-20020a05600ca38800b0040295a0b2aemr2672775wmb.32.1694011882079;
        Wed, 06 Sep 2023 07:51:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:9866:d0f3:fca8:33c9])
        by smtp.gmail.com with ESMTPSA id x12-20020a5d54cc000000b00315af025098sm20696485wrv.46.2023.09.06.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:51:21 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: mb86s7x: don't include gpiolib.h
Date:   Wed,  6 Sep 2023 16:51:18 +0200
Message-Id: <20230906145118.139678-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The gpiolib.h is unnecessarily included in the driver. None of its
symbols are used so drop it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mb86s7x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-mb86s7x.c b/drivers/gpio/gpio-mb86s7x.c
index ca7eb5e8bfaa..248df657c38e 100644
--- a/drivers/gpio/gpio-mb86s7x.c
+++ b/drivers/gpio/gpio-mb86s7x.c
@@ -20,7 +20,6 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 
-#include "gpiolib.h"
 #include "gpiolib-acpi.h"
 
 /*
-- 
2.39.2

