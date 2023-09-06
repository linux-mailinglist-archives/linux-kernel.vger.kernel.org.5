Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FABD793F7D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbjIFOuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIFOuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:50:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBFA172E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:50:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c7912416bso3518558f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694011849; x=1694616649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVthb6ZN5GYct/SSdnLN79qXHbRJTph85wddKtPDZCE=;
        b=VZ4RKZHBsRJIqffQ+z3m5dFiNflLcKJh/toyiuWSPIq9Bj4pRtqZBy/GHm7aBt8WeZ
         3gHH2NdGz91TrHVXqYJvRPTPX88O4MeN8+QnLnenAk2FEfOg2iWsfcmqRE5JCuCCRdkq
         Ze/QG/kyQT2eWlZnRXWlKjBkPBXTD2q58Xm8akViP8SsvusU9NFju9TUW51jkMRh7rMc
         W0J+NJNw7xSAZtQ2s91sxkgE3zD+2cyHS9WseZsdPeGG/w04wolyvvNjvfltkEjwYb6H
         W0ySMsVC+Ds2Xl/jxn8h9Ja3Pxq/rcYmvZgF/BW7xab7L655LiswkmfqkUW2/1ew1YaV
         wPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694011849; x=1694616649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVthb6ZN5GYct/SSdnLN79qXHbRJTph85wddKtPDZCE=;
        b=GytfwghN6ypW3Sv7GT3FfqYWQmAEOBh6dPy5eyjiAySDo1a3EsVpYvx1nprNcGlufV
         MjVK6mMY+NvSmTcyKwlR6MrObalLFgNjQqgHXqkUT8sgevgYV+dWK+HfMTOKolnl7Yg5
         YQMDgJhi+wSlWFsQz0EFdl1Dp2CMUvhuNhuOKqIrrA/k0lUXWw/LAB3bKmXsw0avOJy4
         g5m+OyeKXrU1MfFg2TRgShaPdP0d0yEjpcffSpjYYawyd68qIN7OgNWj4Ny/r3nJRq7j
         HbYIdg4pmc6VZ6NWVWtEqFA0sG8CDULW6Te2GumSvI4E7JmCUIgQVh5SWZmPWtszQAjr
         eK0g==
X-Gm-Message-State: AOJu0Ywi7r4VRgrovNrTOQDKQGRPc8rw/4pXbVzp1PMfYwicLTd9MvZS
        BLYhbdJlixLitAUK7ZExgFRTxg==
X-Google-Smtp-Source: AGHT+IEJC0W51QkBL5cmqxw81ARfsV+dHb2q9U4TW9NoExSfFJ2TRR28GrLY4rwFF/Z8nLmRL2Tv+w==
X-Received: by 2002:a5d:4105:0:b0:314:3740:7f69 with SMTP id l5-20020a5d4105000000b0031437407f69mr2311960wrp.37.1694011848468;
        Wed, 06 Sep 2023 07:50:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:9866:d0f3:fca8:33c9])
        by smtp.gmail.com with ESMTPSA id p9-20020a1c7409000000b003fee53feab5sm20325433wmc.10.2023.09.06.07.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:50:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: dwapb: don't include gpiolib.h
Date:   Wed,  6 Sep 2023 16:50:45 +0200
Message-Id: <20230906145045.139657-1-brgl@bgdev.pl>
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
 drivers/gpio/gpio-dwapb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index c22fcaa44a61..4a4f61bf6c58 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
-#include "gpiolib.h"
 #include "gpiolib-acpi.h"
 
 #define GPIO_SWPORTA_DR		0x00
-- 
2.39.2

