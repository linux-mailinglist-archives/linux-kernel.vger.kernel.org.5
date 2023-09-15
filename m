Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90297A21DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbjIOPEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbjIOPDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:03:44 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCC22718
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:03:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-403012f276dso24530555e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694790217; x=1695395017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7cnFQaXE5hgNGVsFuhD31Dbn34C6HVkTSPK79EhhMo=;
        b=Ev5euDCkEcMyo0Vi4HTUYVTfW9nuMoInIT+a1zskafF66mHsZ0IliYQHDC/CbYvCHv
         SgIa37TovU2rkGI02FnKLad5qhkl8OUkK1AQL6Gr2/1zsSjyQINW+r/yaRKMaaNQUdk1
         NCCvfu2U2YdQXT4+QqX0uoRFEdcUqYaiKB9RyXDP670KYo5hA7GLgXZBzYKPCCULqkQX
         aGgzxcPj92fuZphAJyL5lRwpzkka1yEGmCVay1cjte1PCM561o74LNYhJkpsBE985je+
         wEeGy24lDjysXDfmGJ36yYCVi3VTTgtMi1Exb27xcTYDNbNi14i74owlbvYPX9UwIptD
         aP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790217; x=1695395017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7cnFQaXE5hgNGVsFuhD31Dbn34C6HVkTSPK79EhhMo=;
        b=cZ+HIyV9ArGaX/rJXWatZ0WpsFk0ucksnkQzioBp8AwQig2TpZ/TIDomsGukb5PUKC
         f0sLEYH0yIXr/B9RFWWNrgbCDbTeLLb7t7gjRthjRYQxZTD82d1+lct/D31aAa626qKI
         L+H6xSXDo7eIoRW15J5fD4qvsP01hXWwIoIdk956neXIqJSWHCfKbXUgs2plFrbFUEzv
         pUC6hPcNN8btXWPjAYh425e+VqWFZyyyZ7HiTZtU8IG9LKQH3BkmxqwE8VVQ0ugLy0Fh
         nJDTz18PkyTuFnzN+ofqpFsyfjIOScF7frimEpps92iquTeg4AmiDcUedhOmQUB6JgCf
         2w0w==
X-Gm-Message-State: AOJu0Yzi/hrSdPiZtAWwL4UMi+XLCh2/oQwjBQWMdNJ5I9inFIjK2gfJ
        PccZeb9XcpokQWF1gMFgoETmSSCPdey5FKgS/6A=
X-Google-Smtp-Source: AGHT+IEorh4sO+fT8YcWE2co/gViak4l34nxlE1iLrbUtDPxiVwO0HapW2pbE+TLh0BrG3WzweMY4g==
X-Received: by 2002:a05:600c:203:b0:3fe:3004:1ffd with SMTP id 3-20020a05600c020300b003fe30041ffdmr1735651wmi.4.1694790216912;
        Fri, 15 Sep 2023 08:03:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fef19bb55csm4853369wmb.34.2023.09.15.08.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 06/11] gpiolib: reluctantly provide gpio_device_get_chip()
Date:   Fri, 15 Sep 2023 17:03:21 +0200
Message-Id: <20230915150327.81918-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150327.81918-1-brgl@bgdev.pl>
References: <20230915150327.81918-1-brgl@bgdev.pl>
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

The process of converting all unauthorized users of struct gpio_chip to
using dedicated struct gpio_device function will be long so in the
meantime we must provide a way of retrieving the pointer to struct
gpio_chip from a GPIO device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c      | 21 +++++++++++++++++++++
 include/linux/gpio/driver.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7d2574b3dbe5..e26cbd10a246 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -220,6 +220,27 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_to_chip);
 
+/**
+ * gpio_device_get_chip() - Get the gpio_chip implementation of this GPIO device
+ * @gdev: GPIO device
+ *
+ * Returns:
+ * Address of the GPIO chip backing this device.
+ *
+ * Until we can get rid of all non-driver users of struct gpio_chip, we must
+ * provide a way of retrieving the pointer to it from struct gpio_device. This
+ * is *NOT* safe as the GPIO API is considered to be hot-unpluggable and the
+ * chip can dissapear at any moment (unlike reference-counted struct
+ * gpio_device).
+ *
+ * Use at your own risk.
+ */
+struct gpio_chip *gpio_device_get_chip(struct gpio_device *gdev)
+{
+	return gdev->chip;
+}
+EXPORT_SYMBOL_GPL(gpio_device_get_chip);
+
 /* dynamic allocation of GPIOs, e.g. on a hotplugged device */
 static int gpiochip_find_base(int ngpio)
 {
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 3fdf3f14bb13..f8ad7f40100c 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -773,6 +773,8 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
 struct gpio_desc *
 gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum);
 
+struct gpio_chip *gpio_device_get_chip(struct gpio_device *gdev);
+
 #ifdef CONFIG_GPIOLIB
 
 /* lock/unlock as IRQ */
-- 
2.39.2

