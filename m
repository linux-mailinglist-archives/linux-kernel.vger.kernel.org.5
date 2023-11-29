Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD92F7FD936
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjK2OYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjK2OYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:24:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960FA197
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:24 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b479ec4a3so25776285e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701267863; x=1701872663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2vlGJhIze8sK7FhkyHeBLiiHYWZ044RLoNjc90UYtQ=;
        b=crqE15JIivDRD7HPz9UTlXpZe8y6b3M0VcIyqiQVPCgE+EgTIuWAAjCRr8hdm5pIg5
         LHoZXe1ssMuLx7Ib1ksYYzD+7ipHUTZ5LLmpuHpWIPkRiHs8g37qiPeMtNq7RHJBCPKw
         tPR08+j7Do9gwDUkDi811MWKlE8nHUteE6W4Ge5vzYAqz4oq6wYHQ/72e10JG3Sct41s
         ldeGuzNoJcUmac9UgntzSZyvTGFoAAnluth+IO8yOUd9DSWbog4GOJ8EGEruztwtgDYl
         Vip9o8zX5WiBDZzdVkzV9cE1wouOKid3FvHM7Gikn4WG3gvPx5xhrdR5IjBsHxxofJb0
         IXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267863; x=1701872663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2vlGJhIze8sK7FhkyHeBLiiHYWZ044RLoNjc90UYtQ=;
        b=mPjt7YxcMJFAgsnpa8WHvt20YBfiaPW2LiGjA30BRfvtg2xND8Cbe5BArXXCw1OOlM
         Rq8ahAt83fcFVH57c0InYsS5oVtRZ/HRm3iBlEbNWrx7v8M3HDFwr4e67VAAOfntm6AF
         NKOoNQggJ+SwYvbI52e8oa2Tc/2vHtQh1isp2PjxQiqWLlbMAbMZf30iK7M/22kNE16k
         R1XZBixD+pmdIInv09a1WjqkII2I2RzQI62AjcHvS4bI68DZtWczEruaqhge6ixEmTOL
         B/LJDYN3BvjDLHMYLGaDhZhZXpSUtL7zP3zpOC2GQs38A8MLXS/OH4V/F6CtOEPRZgeP
         o0bQ==
X-Gm-Message-State: AOJu0YyglRKwzznNLgwXsgwUCzDD3RbyLSKKVAR0vC5CCCgz3kIqcl6v
        mFRgvj4lyjwahZ7A5HWerm1iig==
X-Google-Smtp-Source: AGHT+IF+n+Bguen0U7DsO4xPBjVSnhr/bzmyaozCPrrt3u3QTE29we1fJcSv4k6cx5guAABEETFQtA==
X-Received: by 2002:a05:600c:3510:b0:40b:45e2:1f56 with SMTP id h16-20020a05600c351000b0040b45e21f56mr6396343wmq.39.1701267862985;
        Wed, 29 Nov 2023 06:24:22 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4520:2f25:4d3a:4adf])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b0040b34720206sm2406848wms.12.2023.11.29.06.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:24:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 01/10] gpiolib: provide gpiochip_dup_line_label()
Date:   Wed, 29 Nov 2023 15:24:02 +0100
Message-Id: <20231129142411.76863-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129142411.76863-1-brgl@bgdev.pl>
References: <20231129142411.76863-1-brgl@bgdev.pl>
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

