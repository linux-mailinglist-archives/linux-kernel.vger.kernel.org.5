Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9546D7FF098
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345706AbjK3Nqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345645AbjK3Nqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:46:35 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C1B171F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:38 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b40423df8so7571795e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701351996; x=1701956796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2vlGJhIze8sK7FhkyHeBLiiHYWZ044RLoNjc90UYtQ=;
        b=xnzRGXZHUO536H37aA4aVxzXMn/0jPSSxDsRlZNK/vAbxLQO5k80W3vfoQ6DmXJ5EK
         U21nQmo4ExlJNmJI6uf1m0QPNyqYsl/f20xqsogua6afWtpS0eCMzidIsBDqHDAouXj9
         mlp9NT1kBjOIFpYpevaR6FO6qXu855c0vkxrGqrJTa1eVjjjb645vuKHb/c7QSzkLyLY
         0BOBtKlCZnbatRxvwWlhiCZgRrNaayzu/nJ5bIO3+olDVDntE4TPeGUnB8Ov7dDc8PtZ
         T6oYK/ewnzFAh5Cosmt4nES34/+C3nnsvurq5H6LN7WdNpAchP6jKyWvS6MDyQrSWa0H
         9G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351996; x=1701956796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2vlGJhIze8sK7FhkyHeBLiiHYWZ044RLoNjc90UYtQ=;
        b=lG2lEJGV53ERKAMnSJ04ACOqHUf7Cr9Dvm+ahIwYxmeKAI6+qDY9JVSRa0F4rGuSGt
         S85TSoW8Jdk1YhbY+DvnXvVwyCaLh+jVVnskPILR04/ROYZvmABOgOJ+Aq7IAN5LrYMl
         ctwhsaAAwhqexKiWdXjo6+voAaKg+UAy7vMBAe5nwpIqdM/m/tVvS6WyEMBmg4cBPoFC
         axj30ZXirXTpvlKjpk0k05oFVwt+cxvVE9oawbDdsi74ySLzEzF7W8CzgV8Mr+zHE/5/
         nsUXU5cqY6hROo8xotHB5UJO8ZUNMc2gUAzNhjuu8pYiz4/x4hXep+LL11eW9NJLDPyJ
         gRaQ==
X-Gm-Message-State: AOJu0YwJZPfSI+QPgb+FG3d/obIIrn28kD2o4+n6UJFr1dMLT1xhCujQ
        azo9U0dOe/2NQW2qNHEiryDt6SJG+1OBrR/apmA=
X-Google-Smtp-Source: AGHT+IGtdd0VMXL+p2c6eyqLy6MItc8V4wcu+0Ncauj4wLWwBbw5ot6jZfezOIhzkjhPuljZoeg+Vg==
X-Received: by 2002:adf:f64a:0:b0:333:12f9:d37a with SMTP id x10-20020adff64a000000b0033312f9d37amr5219213wrp.65.1701351996563;
        Thu, 30 Nov 2023 05:46:36 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae84:904:6602:ec1e])
        by smtp.gmail.com with ESMTPSA id n18-20020adffe12000000b0032d2489a399sm1574824wrr.49.2023.11.30.05.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:46:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 01/10] gpiolib: provide gpiochip_dup_line_label()
Date:   Thu, 30 Nov 2023 14:46:21 +0100
Message-Id: <20231130134630.18198-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130134630.18198-1-brgl@bgdev.pl>
References: <20231130134630.18198-1-brgl@bgdev.pl>
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

gpiochip_is_requested() not only has a misleading name but it returns
a pointer to a string that is freed when the descriptor is released.

Provide a new helper meant to replace it, which returns a copy of the
label string instead.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c      | 29 +++++++++++++++++++++++++++++
 include/linux/gpio/driver.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a5faaea6915d..8e932e6a6a8d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2400,6 +2400,35 @@ const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int offset)
 }
 EXPORT_SYMBOL_GPL(gpiochip_is_requested);
 
+/**
+ * gpiochip_dup_line_label - Get a copy of the consumer label.
+ * @gc: GPIO chip controlling this line.
+ * @offset: Hardware offset of the line.
+ *
+ * Returns:
+ * Pointer to a copy of the consumer label if the line is requested or NULL
+ * if it's not. If a valid pointer was returned, it must be freed using
+ * kfree(). In case of a memory allocation error, the function returns %ENOMEM.
+ *
+ * Must not be called from atomic context.
+ */
+char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
+{
+	const char *label;
+	char *cpy;
+
+	label = gpiochip_is_requested(gc, offset);
+	if (!label)
+		return NULL;
+
+	cpy = kstrdup(label, GFP_KERNEL);
+	if (!cpy)
+		return ERR_PTR(-ENOMEM);
+
+	return cpy;
+}
+EXPORT_SYMBOL_GPL(gpiochip_dup_line_label);
+
 /**
  * gpiochip_request_own_desc - Allow GPIO chip to request its own descriptor
  * @gc: GPIO chip
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 100c329dc986..9796a34e2fee 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -532,6 +532,7 @@ struct gpio_chip {
 };
 
 const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int offset);
+char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset);
 
 /**
  * for_each_requested_gpio_in_range - iterates over requested GPIOs in a given range
-- 
2.40.1

