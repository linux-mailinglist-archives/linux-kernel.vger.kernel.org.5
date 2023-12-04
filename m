Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA07D802EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjLDJgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbjLDJfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:35:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7001F198
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:35:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c09f4814eso12382065e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701682523; x=1702287323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFuMwgQtxRBsqcDwlkNhBzIxKsoLICNRiZ90QrUgNUQ=;
        b=TyF8oO8Zgq6hfxPV1cMsjP9afRhf0hgNUOLbU4Rvb3ogaJCuwo2tbg9pTt3vb/IebM
         AROZcQCsq3zKUJZqkJvA/fEaIxOXKJjcEY6T6tvQg4RfBxMMkWwYrkG/6Y2w7hbESEN7
         su11gsvp3FgytTg3ae+qC+lzENKTTqmjusFlxmrleMq4o8cB5QyzJNBbwlgm/W/MK0bn
         YkdfqaTBpL+zVAZDHpZyRPa5Vtxy7cyP0s5W4jrtvB/m+dZavr+DjeLyyYPbbdryuhXr
         ycGSXUWyqOvVk/mjPpKxnge3EzO6KwRO60THue+HMQ5hInhfNoUIR38bRvw0C15EIHPk
         Th4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682523; x=1702287323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFuMwgQtxRBsqcDwlkNhBzIxKsoLICNRiZ90QrUgNUQ=;
        b=WKHjY75RKiio7Sj0ZBXC6yVU2TA1XKlUeR5gWyHBUHWbE/Pt5VOS1//7BRscMnPqbX
         7MG+SCJ9jutxdhLBz5k9YgjdN3Kp9nGedFdHiuyyHQBIUUntVoP+4G5gDsIVucjr3M52
         SQaomlg058SBE7n6/x771yC0kz9mPLx0vJiHzXVSbsFora+PaeIQ+31TXytvAUGcvw0L
         a3s9qtILSsYFiq9lZrIDvhjo6Xk0Cml0dLxrj2a/wmd+yPQmHAeEHcUMN5hXD/Syb/vE
         LnlJUWQPNvkYGM77Cj67BQEltq3HuoMr6C9zHfOOTwZ0Kkpil9POk8HbuF3s/tmoIIK+
         f5Tw==
X-Gm-Message-State: AOJu0YxPCani+AFql6SeQNyLlgYMymhCb1RO5KOqEwH7Tq0ywDilYGgv
        myBoJYpPSTm1sGM1ewIMIh7r0I26YshUxFZNiS0=
X-Google-Smtp-Source: AGHT+IFKo4W36xXyE4SejxNtVX66lYuHh3b28bjD0alZD+yoHQII9dsGu8t9qenz9PMKxEkEtHV4Yw==
X-Received: by 2002:a7b:c397:0:b0:40b:5e21:dd1e with SMTP id s23-20020a7bc397000000b0040b5e21dd1emr1025046wmj.76.1701682522864;
        Mon, 04 Dec 2023 01:35:22 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4cb1:229e:8c33:122a])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm14266219wmb.6.2023.12.04.01.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:35:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 09/10] gpiolib: use gpiochip_dup_line_label() in for_each helpers
Date:   Mon,  4 Dec 2023 10:35:08 +0100
Message-Id: <20231204093509.19225-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204093509.19225-1-brgl@bgdev.pl>
References: <20231204093509.19225-1-brgl@bgdev.pl>
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

Rework for_each_requested_gpio_in_range() to use the new helper to
retrieve a dynamically allocated copy of the descriptor label and free
it at the end of each iteration. We need to leverage the CLASS()'
destructor to make sure that the label is freed even when breaking out
of the loop.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/driver.h | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 9796a34e2fee..910fc50d3ab5 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -534,17 +534,38 @@ struct gpio_chip {
 const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int offset);
 char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset);
 
+
+struct _gpiochip_for_each_data {
+	const char **label;
+	unsigned int *i;
+};
+
+DEFINE_CLASS(_gpiochip_for_each_data,
+	     struct _gpiochip_for_each_data,
+	     if (*_T.label) kfree(*_T.label),
+	     ({
+		struct _gpiochip_for_each_data _data = { label, i };
+		*_data.i = 0;
+		_data;
+	     }),
+	     const char **label, int *i)
+
 /**
  * for_each_requested_gpio_in_range - iterates over requested GPIOs in a given range
- * @chip:	the chip to query
- * @i:		loop variable
- * @base:	first GPIO in the range
- * @size:	amount of GPIOs to check starting from @base
- * @label:	label of current GPIO
+ * @_chip:	the chip to query
+ * @_i:		loop variable
+ * @_base:	first GPIO in the range
+ * @_size:	amount of GPIOs to check starting from @base
+ * @_label:	label of current GPIO
  */
-#define for_each_requested_gpio_in_range(chip, i, base, size, label)			\
-	for (i = 0; i < size; i++)							\
-		if ((label = gpiochip_is_requested(chip, base + i)) == NULL) {} else
+#define for_each_requested_gpio_in_range(_chip, _i, _base, _size, _label)		\
+	for (CLASS(_gpiochip_for_each_data, _data)(&_label, &_i);			\
+	     *_data.i < _size;								\
+	     (*_data.i)++, kfree(*(_data.label)), *_data.label = NULL)			\
+		if ((*_data.label =							\
+			gpiochip_dup_line_label(_chip, _base + *_data.i)) == NULL) {}	\
+		else if (IS_ERR(*_data.label)) {}					\
+		else
 
 /* Iterates over all requested GPIO of the given @chip */
 #define for_each_requested_gpio(chip, i, label)						\
-- 
2.40.1

