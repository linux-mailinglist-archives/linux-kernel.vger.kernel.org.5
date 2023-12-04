Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860EF802EB2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjLDJfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjLDJfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:35:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA68D107
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:35:14 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b538d5c4eso37617025e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701682513; x=1702287313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGHp/zivDD4UeGo/O0oZ0YEfeaPi8u0T0sTBfg7Gjaw=;
        b=y7FnlPpajpr8n8nucOvT8HBBlBNAKmKIhme1F3n6heV2mXjpufnCNqo1rMcbi6Jq6l
         PXVyMLf9hJeezi8ATsz7ZhKbe8k6RlTXr5S/ASXktAMyWNBEsYasdrQgrtAUl/K36wco
         UgR443z5q7FqNgUzuarTTq2hqeEVUeOFC1VtztZwMMEYQQrZ5IJIETGJcqlo7t6QEfs3
         SR0Ie0/puufn+o6dSYhb1B36XQR/1T2AOG/ZtEeJbybbSmjJfEyx0RTIpO/km+l7B5I2
         aDfKqtz1TeA8gGfbUPVP+78txBLdJkkvv76++vKGEo/+jW6PkAtdx/R6J8tVFYxTkXkb
         41jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682513; x=1702287313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGHp/zivDD4UeGo/O0oZ0YEfeaPi8u0T0sTBfg7Gjaw=;
        b=v+wWtR4MFktI/eoPtuJ6cmF+YtIagyFNVh3JoTB1b45BxHamdQ/IL52Q4/NC6pfhzL
         FJ/oKeV8Z/TDOVhwV2AtKmYSRQ1swYY31WYhxN3kMTv+L7gQhOi/dG8aOCmMKWiIO+vw
         pG9OAe7nZVoGpraDpLY01SqzkhpJ1tUBd4AV0Q5klOcN3Phzeg2M1B9NaArayKrHqZIX
         AWJDV9bGEbzyrfJcEpfRouTnOuZKwyUluMdaSQ1siv3UcHHjRAn4e1DeMG/79ogCsw+W
         OI0DdSBXWtaSheBS2xLPU49H7AYKr1n/Um6xvRlks5+I/rXwnhZnhQp7InL20ZB+Tsej
         JDug==
X-Gm-Message-State: AOJu0YyNuiiEfzZhF70KBfrkrsAzjgvPRwhuza8Y6qFyYU1BMdk1kAWp
        wO5t7v+l/EC/gP8b9+JrTAHgew==
X-Google-Smtp-Source: AGHT+IHty3BbyOZtDzbcT1aXZLimxuywhqB43xcMqgA6c48GKHsKE4IJgMpVfVz1QHmQAv2GfiPWPg==
X-Received: by 2002:a05:600c:2044:b0:40b:5e59:b7a2 with SMTP id p4-20020a05600c204400b0040b5e59b7a2mr2362002wmg.127.1701682513268;
        Mon, 04 Dec 2023 01:35:13 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4cb1:229e:8c33:122a])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm14266219wmb.6.2023.12.04.01.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:35:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 01/10] gpiolib: provide gpiochip_dup_line_label()
Date:   Mon,  4 Dec 2023 10:35:00 +0100
Message-Id: <20231204093509.19225-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204093509.19225-1-brgl@bgdev.pl>
References: <20231204093509.19225-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index a5faaea6915d..d4b33782cc10 100644
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
+	char *copy;
+
+	label = gpiochip_is_requested(gc, offset);
+	if (!label)
+		return NULL;
+
+	copy = kstrdup(label, GFP_KERNEL);
+	if (!copy)
+		return ERR_PTR(-ENOMEM);
+
+	return copy;
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

