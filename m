Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D068793EB4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjIFOYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIFOYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:24:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A84010E7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:24:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so35421185e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694010241; x=1694615041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=41ZTY7/y7OIvXkISB89dA5sgcc/Y5ugC5zwJsxzFjbk=;
        b=hKDC2OeoYj2bLt3Y3D0xcPrfc/JKogjc8c93j8juzLdWkZkjhIoiau9HCne5DR+PPX
         tDEBjLtitg0ci32nr+f20ErGUQA8savkGFOvcIHchdgP37KwQC06VQa7eyLuEHomI8wG
         70Bn/aLaemi4vRyYkPdvacwds+4NTjjffAfCbGzW2uUgIZvsyC3vDtK2+/jPxNTzLjLv
         xupVSL+/i2vq71VXBkVElMo76BShKq0k2HE55xdBjH9Z68f+nJZu7Fy4sqzgtE4oH4gm
         8Dlpfb4HmcNjeRxFX2Tz1pAuEBSXVIvv44WQEGMB1VXuZq1MLZKsPXWxRYYGbToBI/4j
         D3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694010241; x=1694615041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41ZTY7/y7OIvXkISB89dA5sgcc/Y5ugC5zwJsxzFjbk=;
        b=W6VeVYWEUzpMkNqEOAAd3LcjJVkbmQDMj+mV+HxidtHVY5SIFzrRr+Z9lE1cHCnwaB
         WH38BAIoXztFmrRd+QIUPWy7XGW7S81R3UEbIJJFzaYuhGvqNYWdSH8twSg26IG0zXYx
         FVbgh5VhFy4jCww85MICF1I4FMZeU4+kP2HpAUUexYAIA1iE5HsJfW4enRW9OgAR2DPh
         p9poB0TzqngR+ZuKGiNJEQjH8qlaSpx9A8P9PYvY3X0EZKIrZNzPQhjrIQfI9TmJPIJY
         nfowyqiaWQCnH/yCUUy5FOxTwVQWywO3k+Mcg58ANrYp++iGx/oS2wZvkb+ZXd9Aru3g
         6prw==
X-Gm-Message-State: AOJu0YxtlHS1kM4eM6CIl78rtDPc2w17ogED123brjFSLCxal+zolBnf
        5a69hoM9qGB5RSA0CkdFRefGxw==
X-Google-Smtp-Source: AGHT+IFSM0p9QWCFZJ6Jdb1/a2f4fbvc7fNq0ww2tLNTTOh/n9DdxwYUCthIyfL9002UmnIVhoNzEQ==
X-Received: by 2002:adf:f38e:0:b0:315:8a13:ef17 with SMTP id m14-20020adff38e000000b003158a13ef17mr2563966wro.65.1694010240666;
        Wed, 06 Sep 2023 07:24:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:9866:d0f3:fca8:33c9])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600011c900b0031c77c010e1sm20481095wrx.96.2023.09.06.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:24:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: xgene-sb: don't include gpiolib.h
Date:   Wed,  6 Sep 2023 16:23:57 +0200
Message-Id: <20230906142357.138846-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
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
 drivers/gpio/gpio-xgene-sb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index a809609ee957..453bf9338ac4 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -15,7 +15,6 @@
 #include <linux/gpio/driver.h>
 #include <linux/acpi.h>
 
-#include "gpiolib.h"
 #include "gpiolib-acpi.h"
 
 /* Common property names */
-- 
2.39.2

