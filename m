Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC717797CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjHKTap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbjHKTan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:30:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FDF30EC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:30:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso21449675e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691782238; x=1692387038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nHAG8ZwFEDy1+22mRF7CGDpzGtcaDo1M+JtJ4MZhhsI=;
        b=Isfkv6zLg3PKRw2CBDcIVio35wCeLiSdiL+Z3RY3FUh4m1FwrSdQUpnYPzQG5cCul9
         PDS2APFvIxVb5L0PkvpuEKcVe/D5eI8UIA2eTRTqHBaEV5Ef1ssMIRdLTFNYC3XoSmKs
         yMDO/dGHH1u0iUrCV0SJD0LBlAxPPu30JArxOjpmfNWk3chdpf9+87UXeIhhx1UJBivw
         Z/y72iBXdFFSy3w10pa8uVeOVCHxnuX0YBv5qM8pZ7zvoEx0iHRI07mwiVYkgU1FtKJm
         F/icL0y1B25TMfmJGTkPHegOBp9VIc3e24aBVuEq6mQpA8UyGJN+NOoKngpQMTh9f1XA
         F1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691782238; x=1692387038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHAG8ZwFEDy1+22mRF7CGDpzGtcaDo1M+JtJ4MZhhsI=;
        b=aZERCoXEumvMskZqMcJZh5D4MG9tu/jxgBWt4hcIdQdVv/MtD0kKL48HqBvhoXV7u3
         70bAwtd27ewrF1ucPSZeGMtE7RMLLzwm5ke6V7Ph/eCQfBiGzru01IEDi10leWIMZYrC
         oqwkccdcpL5m7BBFuNhBZQppPmNDF518FsKo9/ZJ6VJUn4mUzZMavf5J+94NKVuyryUx
         5WOKtUwRp+l0vm8ZQv4Fv8TuBeYwiUIozh7KeSAPpwG0orUO+n9I3z1hhNMlOR2R7tsW
         Ni+jJrwAW3T1TsNDsA0wiKk3yFUOR4aEE7wu9klQhqKchcI8XpCPJYPhma+vwHfkbGhc
         Wgtw==
X-Gm-Message-State: AOJu0YyJQvaIxb5CAjNnqj/urSdim7iE+AXFfhafEKGtU2dzMopezkt4
        3yfF5lg9fZph8piUB/yRlisgmCkyetRWCnem+Fcr9A==
X-Google-Smtp-Source: AGHT+IH5A9/JQ0rF1L7fdoVXQSgXSkFNQe9cGpbOp+YK9mRkQ7ctkK2nA4Kh1vFTqN90OKw0fRtLTw==
X-Received: by 2002:a05:6000:885:b0:315:8f4f:81b8 with SMTP id cs5-20020a056000088500b003158f4f81b8mr2014081wrb.50.1691782238392;
        Fri, 11 Aug 2023 12:30:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d0f3:773f:e87a:3b82])
        by smtp.gmail.com with ESMTPSA id i10-20020a5d438a000000b0031760af2331sm6226130wrq.100.2023.08.11.12.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 12:30:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3] gpiolib: fix reference leaks when removing GPIO chips still in use
Date:   Fri, 11 Aug 2023 21:30:34 +0200
Message-Id: <20230811193034.59124-1-brgl@bgdev.pl>
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

After we remove a GPIO chip that still has some requested descriptors,
gpiod_free_commit() will fail and we will never put the references to the
GPIO device and the owning module in gpiod_free().

Rework this function to:
- not warn on desc == NULL as this is a use-case on which most free
  functions silently return
- put the references to desc->gdev and desc->gdev->owner unconditionally
  so that the release callback actually gets called when the remaining
  references are dropped by external GPIO users

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- add a comment about why we can't use VALIDATE_DESC_VOID()

v2 -> v3:
- we must drop the reference to the owner module before we drop the one
  to the gpio_device as the latter may be removed if this is the last
  reference and we'll end up calling module_put() on freed memory

 drivers/gpio/gpiolib.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 251c875b5c34..76e0c38026c3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2167,12 +2167,18 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 
 void gpiod_free(struct gpio_desc *desc)
 {
-	if (desc && desc->gdev && gpiod_free_commit(desc)) {
-		module_put(desc->gdev->owner);
-		gpio_device_put(desc->gdev);
-	} else {
+	/*
+	 * We must not use VALIDATE_DESC_VOID() as the underlying gdev->chip
+	 * may already be NULL but we still want to put the references.
+	 */
+	if (!desc)
+		return;
+
+	if (!gpiod_free_commit(desc))
 		WARN_ON(extra_checks);
-	}
+
+	module_put(desc->gdev->owner);
+	gpio_device_put(desc->gdev);
 }
 
 /**
-- 
2.39.2

