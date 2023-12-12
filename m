Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45E80E97E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjLLKzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLKzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:55:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195B0A0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:55:07 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c236624edso55750655e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702378505; x=1702983305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0Xt7zxPEL8s4LsBKOkLuKnVLrdFFEGGYWcjy48Nb20=;
        b=JVM4mkS1YAMWnOSQTT49O9Bm9F9UWfXqhTQZg8okXqblVsqO0hb+FqrQSrSlh/B1CF
         tcDnaa9LRx7NGGTkdu7xNJnQxq75Kz1uqnkGV5cb8Sdt28zCsYB8OLr3LT1mW3NEdhrR
         rS84w1fqVxeg85NVgqjVhqHI6LKm5CZw/JdM4KFNyC5MAUYiy6H5d3BIgltnbQrjHfIx
         s0ToHjRgCHIx1oWtiiwVTtRF4GWPTz0+EH//kkzZQL+X9A6eZw/HbdUYDStRVrpBbmgj
         am6W/zuBnEIUPyBoMFgEnm0eDgOd7wgG6yj4A5TD1NsS/VA7bGlA5+cGNhfg+g+Z5scs
         Ssmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702378505; x=1702983305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0Xt7zxPEL8s4LsBKOkLuKnVLrdFFEGGYWcjy48Nb20=;
        b=xE0y8+8lH80SsZk1QCFqXDPEIvA9kpBvyTfxdzJAuPwOigRKGH99HzVFg2mclUXUaW
         xPjFHdGRR97YDTSrpN12MBppdzH86AiW5YjMRwXRyN4PM5NeNzANGk4vFJZn0dCDtf6o
         Lrp8cQ45vXgnDUKfKYLsxuJQkV4EIwnzLHGg9kwAKoJZTK7FauB1ZhRSqTtD5RYCDg4S
         xPcvXDm16Hi/5mOP7taFF1Pf71pUvJUWlgmiFrpF69Fac0KOMGXwiT72v+uLs9+nIpjF
         viwUmLlfCR/xkxuyfaVmu9lbM5wiuvzYQRu21YobPXyC2mpBLGpnHXxWMiCQIwOEdlYS
         U93Q==
X-Gm-Message-State: AOJu0YxsHYxudcK9tv2RW82UEeWerXCbmF4yp3V4civBAJZ/LhTR0TIK
        hGe5ELCGrzyaZ6RvWCIfjji6WFG953nqY9fgqaA=
X-Google-Smtp-Source: AGHT+IFXFxG/L09PQonA/L5L/pxR1H1tPqmqy2j9ak7QzMVswR00U4207WU+yB6yLwzwSSQMBQQvTg==
X-Received: by 2002:a05:600c:358c:b0:40c:2a41:4a3c with SMTP id p12-20020a05600c358c00b0040c2a414a3cmr2892381wmq.146.1702378505435;
        Tue, 12 Dec 2023 02:55:05 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1012:9edc:5109:e70f])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb44000000b003362d0eefd3sm1132122wrs.20.2023.12.12.02.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:55:04 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] gpiolib: allocate memory atomically with a spinlock held
Date:   Tue, 12 Dec 2023 11:55:01 +0100
Message-Id: <20231212105501.16347-1-brgl@bgdev.pl>
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

We will eventually switch to protecting the GPIO descriptors with a mutex
but until then, we need to allocate memory for the label copy atomically
while we're holding the global spinlock.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-gpio/62588146-eed6-42f7-ba26-160226b109fe@moroto.mountain/T/#u
Fixes: f8d05e276b45 ("gpiolib: remove gpiochip_is_requested()")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4e190be75dc2..6efe44570333 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2399,7 +2399,15 @@ char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
 	if (!test_bit(FLAG_REQUESTED, &desc->flags))
 		return NULL;
 
-	label = kstrdup(desc->label, GFP_KERNEL);
+	/*
+	 * FIXME: Once we mark gpiod_direction_input/output() and
+	 * gpiod_get_direction() with might_sleep(), we'll be able to protect
+	 * the GPIO descriptors with mutex (while value setting operations will
+	 * become lockless).
+	 *
+	 * Until this happens, this allocation needs to be atomic.
+	 */
+	label = kstrdup(desc->label, GFP_ATOMIC);
 	if (!label)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.40.1

