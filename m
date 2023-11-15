Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0387EC893
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjKOQ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjKOQ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:29:11 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED15CA6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:29:07 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41ccd38eaa5so9488371cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700065747; x=1700670547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWfB6Pfx3SaiRXKdJrtjr1wBtGr3UGnibkVdLL5HdSY=;
        b=uNGX4SLQZ3SqWe0BBeXTLRHw1X5RmIPM2HKEK1heYbj2zMwIZIvST+LKeq6j7zIOph
         iHH06GEb6Jyd/DFIcmIFAHm+599OXeimIYzMouUGPOqXtagZU1GRomDJYd6X2clT9fio
         Fm/CTcOL1Hy/iBp3d5N/EArWppcQlqDaE0/TIH6O84569Q/z5RDb/iqrtNR3PpzexzYA
         i+ISakhpbXEUjeSQ0zsvRUaYGjWlPAQDPm66rLhrjMabYMEq7PZcdzcdlV6IjyP03UJl
         kDYf5fUnqmgVQJadaveruAIqH30wkq2kGys5UNiQADBAG4zkbWNWj4t8TPgg/fyk+S7B
         KwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065747; x=1700670547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWfB6Pfx3SaiRXKdJrtjr1wBtGr3UGnibkVdLL5HdSY=;
        b=UpnkeQv5CIPhQYk40guZfWBSTHjfBneBwtJIFkSdigKXYiMyR6kRnIwW5RM1sg91DQ
         RcaSjyqvtmYK7yKHwsOwVhTVu1rVtVm7HYgvYaGOFabrCrcvFyNx5jDktu92Lzhw2D6v
         QIkIadGSTgtisltydDs2CF1DJVtfcEdP2cw9lOe1sXUFwoabAN4+KxXHMEH7W054AfjJ
         Ilh/luk5GvTSL5jM0PSxq6UqCLQA+QxWR/cCr1iokBjzwJCyFEgCzK3D9EOi6oyZoho/
         QeSgWj+m8M2NWHYcYOFw7UGIpQi8xLOP7NZ9yvv/xEN5X7ExcKIomaUx7tG6BylVYQtX
         Uv2Q==
X-Gm-Message-State: AOJu0Ywnei4eWwuUrAUa+6MtABicMHKK2LjIsIQcwNS+FTbiBBCmlu/+
        0oZJ6KfW6UQdZuQzc4PTo8gicg==
X-Google-Smtp-Source: AGHT+IGbQpcw6KBTm98RikYpu9miHWjOeCRL5OJ7iTqf/uU0fxIkVuFIIbP5+Gm3dZbTwjRb7khCDQ==
X-Received: by 2002:a05:622a:18a9:b0:403:a662:a3c1 with SMTP id v41-20020a05622a18a900b00403a662a3c1mr10578328qtc.29.1700065747040;
        Wed, 15 Nov 2023 08:29:07 -0800 (PST)
Received: from brgl-uxlite.. ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id d22-20020ac86696000000b0041818df8a0dsm3645419qtp.36.2023.11.15.08.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:29:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: mockup: initialize a managed pointer in place
Date:   Wed, 15 Nov 2023 17:29:01 +0100
Message-Id: <20231115162901.2575969-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The preferred pattern for autopointers is to initialize them when they're
declared unless it doesn't make sense. Move the declaration of the
managed device pointer to where it's initialized.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mockup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 4870e267a402..455eecf6380e 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -354,7 +354,6 @@ static const struct file_operations gpio_mockup_debugfs_ops = {
 static void gpio_mockup_debugfs_setup(struct device *dev,
 				      struct gpio_mockup_chip *chip)
 {
-	struct device *child __free(put_device) = NULL;
 	struct gpio_mockup_dbgfs_private *priv;
 	struct gpio_chip *gc;
 	const char *devname;
@@ -367,7 +366,7 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 	 * There can only be a single GPIO device per platform device in
 	 * gpio-mockup so using device_find_any_child() is OK.
 	 */
-	child = device_find_any_child(dev);
+	struct device *child __free(put_device) = device_find_any_child(dev);
 	if (!child)
 		return;
 
-- 
2.40.1

