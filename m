Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F55F7FF0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345899AbjK3NrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345581AbjK3Nql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:46:41 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DDE1715
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:47 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b4c2ef584so7730645e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701352006; x=1701956806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JkcbylM7pAQh/R7rY3XvCoFJsyCRp+V27URZHzTJKg=;
        b=1zTRCSLgTdXz21Tn6xXOIRLL1FQTefqdWPzzetBIrrXOHVet7/oNgmIzaIBVxl3qBX
         Kj3oL0NiDJNwESGPukPK2xH/icTMM5wWoiB0atmwi8clfbVprTI0VtgWUXqodHjwjap2
         xqF2Z2UHBkeb5N/DnI+zWuIhfBZQJXjJF9UXDRkFmW5tPBYAzKRVwuEroL9OucU8WCuS
         mxtcE23Qnwj2fOktg+5XCBwhmsTc5qAwOUOJkOVQiWRzyMNJhO6J5D222fzlW7NIarg+
         n922xRYJYaRlAAR0IXKfVyXrgEdBx49HrnBTFkY206UW9UB2Ae8BvCmtSBK3w3B/ppsR
         CfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352006; x=1701956806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JkcbylM7pAQh/R7rY3XvCoFJsyCRp+V27URZHzTJKg=;
        b=Es2PD6iBlPHmsuo9tV4rgvKBq6JnbnyKx5dYuXfcNZH5OhTAnOYeBfd22u6PP0xF0A
         a+jKtdG1u/5tbQ/ZxNlSVN5qvTyrhqPCreMDxJS6a+TlNaudH/T/xy8B7Cbb8p0fptZ6
         9DV0CSy5OLgqxYnobshOOEp4Tpq6c4D37+1CXCQFYhy//Gsz9kX3zZKuhUp9kU4Cxhvd
         Ub5rmVX5aHvy7acuRnzQ2OwW4LuzsJbwE7SGfl6eXVo94yMM3BM5za+O6pJR9oPrYkzu
         Fyijk9OONKozWu+tTc1Nlz7qgaIQ8IK65hnPrt2MgEkV62IW4csm+gnHQEmrkR4aEib5
         r1OQ==
X-Gm-Message-State: AOJu0Yz3IdCw3+2ltW0+eHok6BzcVEaQmwjnVR4S9cY1UrcFuaXjt9Ih
        InNBYSB3Tb4/Qxer0vjJKnQ0XNJqqkp7NXZn5Xs=
X-Google-Smtp-Source: AGHT+IFrUo2pYjPmikAyxVnU28S07nWrd/CCV9cpK7VFkHjyiiXqIwOTpiNbElhJRnnawaDyhekvAw==
X-Received: by 2002:a5d:4c84:0:b0:32f:b407:5b77 with SMTP id z4-20020a5d4c84000000b0032fb4075b77mr15296007wrs.64.1701352006413;
        Thu, 30 Nov 2023 05:46:46 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae84:904:6602:ec1e])
        by smtp.gmail.com with ESMTPSA id n18-20020adffe12000000b0032d2489a399sm1574824wrr.49.2023.11.30.05.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:46:45 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 09/10] gpiolib: use gpiochip_dup_line_label() in for_each helpers
Date:   Thu, 30 Nov 2023 14:46:29 +0100
Message-Id: <20231130134630.18198-10-brgl@bgdev.pl>
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

Rework for_each_requested_gpio_in_range() to use the new helper to
retrieve a dynamically allocated copy of the descriptor label and free
it at the end of each iteration. We need to leverage the CLASS()'
destructor to make sure that the label is freed even when breaking out
of the loop.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/driver.h | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 9796a34e2fee..b1ed501e9ee0 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -534,17 +534,36 @@ struct gpio_chip {
 const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int offset);
 char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset);
 
+
+struct _gpiochip_for_each_data {
+	const char **label;
+	int *i;
+};
+
+DEFINE_CLASS(_gpiochip_for_each_data,
+	     struct _gpiochip_for_each_data,
+	     if (*_T.label) kfree(*_T.label),
+	     ({ struct _gpiochip_for_each_data _data = { label, i };
+	        *_data.i = 0;
+		_data; }),
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

