Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71FA7B176F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjI1Jeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjI1Jeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:34:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E4F12A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:34:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405361bb9cdso129134565e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695893680; x=1696498480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j74A4vI0KKBblKCxokABCgxLXL5wlBxadyPLbbtadyA=;
        b=HOqFV798R8Ak+6skR82ktGXMU08xpnIeWba2T8wm1VnS42y5SWKMtPi5rQ7jmjWFdq
         DUJgyXnfPxeng+OTsmZ8WWMDrDIMQkOedz0wYEUut0uwD/tqNw3DGYTt8NxqKi8EUj7z
         loLdg0E+omw2HxG0/NZpZHUKwOf3vTVHx+bQA/AKbbTkEjyGMtA/2FaOPBGiyF3x236v
         n4J1vIl9jEo21SC2MQKLTIGDuiO2dgFohShYnSJ2Q30wSjqF6x6gF16pu8cSKTmd1+WD
         A0b6mGz+4HjZIMxOFmLBjzYAg+T1k0ZOcqxs9S5oOFiHZwxktCZJ8CKbrjTJH/FuJqnZ
         +dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695893680; x=1696498480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j74A4vI0KKBblKCxokABCgxLXL5wlBxadyPLbbtadyA=;
        b=Mp/JmXC0EkaduS4VT67WdGfD800Zt94RlHp/3Cn8d28rqE+tEEYElz0ZIMBz/Bqwir
         ta9bf/30FJ/ARFoIatEp/6t0PALCLCcSJZxCrA5HE6ieBf5EVp/Nn9i5T8SOsSZPCEk2
         vd1djfFH/zgloS3vulT19ulXA3zk4HpT8rQEwPreg3hgYlhT9E9jXiyhDJiUVgy0HseX
         Bgvf65NIPbGZFvjmMJm+0BJV3Pn1CsrS5bh92i6LZQylBam19sHCiboDal+FPciXXAgI
         NMZVbYj4/9DTozNO0NKUOtCC0UVp/+QxzvvzzGOaDoyosh6pw+vrnnHdeJUEv4ZWNAv+
         Df7Q==
X-Gm-Message-State: AOJu0Yw9LcHlztV4YefAYxO76oChihx4WM1aJq/sQMsllWVUYkxttEQP
        Fgmps/IatGPsAyEYs0TLHQlLig==
X-Google-Smtp-Source: AGHT+IFgw8BaMVSfPcMHwE2/b+WsnRdxHjJqRcGVLyQ6Pt68l6+hziBpbiZYg8wQslctieQxnetBuA==
X-Received: by 2002:a05:600c:2991:b0:405:3f19:fc49 with SMTP id r17-20020a05600c299100b004053f19fc49mr719883wmd.34.1695893679836;
        Thu, 28 Sep 2023 02:34:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6e4c:e3c1:5cb8:b60e])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b004013797efb6sm22829601wmq.9.2023.09.28.02.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:34:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: sim: add missing include
Date:   Thu, 28 Sep 2023 11:34:37 +0200
Message-Id: <20230928093437.13044-1-brgl@bgdev.pl>
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

We use size_t, ssize_t, bool and some other types defined in
linux/types.h so include it in the driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 460389bb8e3f..4314440b693e 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -31,6 +31,7 @@
 #include <linux/string.h>
 #include <linux/string_helpers.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 #define GPIO_SIM_NGPIO_MAX	1024
 #define GPIO_SIM_PROP_MAX	4 /* Max 3 properties + sentinel. */
-- 
2.39.2

