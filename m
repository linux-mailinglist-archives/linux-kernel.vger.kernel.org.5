Return-Path: <linux-kernel+bounces-57794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083C384DD7F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F3D1F27ABD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17A6F075;
	Thu,  8 Feb 2024 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="srym3g2n"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE3C6DD07
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386374; cv=none; b=IBiQSfkm9oDcnS3dtXsZgASCL/YCWhDq5H11K8EKHGdqkjk1vx8ceKbArefEQTtO+h1JK1q6/Fx6kGbLEmcx3nc/U17AL3XHiaijoI1D32mCGgENLwa8b3/Nr5gaxqDephPpLJiBe1y+OHnLfGvWc7B37w1dmfKWSolGJuGuJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386374; c=relaxed/simple;
	bh=Kuqae0gdXHk5aC8U+Pwv7M6H8BEVB/GtYBC+v8Te/14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lTUbkh23M5TCHeJMO4ZH2dwOSVFY8nQ71nqOOTqa0O/ikyZH6DVvm+z6UwQN/JENiMfxNrgTC1CzLxNmshf4y7lmTz9PEEExFRg/NrIy2WJ0HB2G8O82NF3B0+o7J8D7jYa2d66JNxZAmfokfkJVeuYcCEKfGjxtWYZdtMBjwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=srym3g2n; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b2960ff60so371556f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386371; x=1707991171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6r04RSjl4/daqm6lsDxW2iCDk2nYZSqX3jgNVAZeU4=;
        b=srym3g2n3+ZR/mbPSksrQLBWxf8uVAJOAQu0HxGQQvoJxFUoQEJ+7ty+6nP2s1bup5
         rWA+YITSfpgHbYidrLmMQ9RS4luXy/kDGvEinbGEsyUZUMBBZsgK3iNK0MFgNSiSjJle
         TTnkxtBD2yLFkH2ngeN0lqXh6vwbOjAp1+F9ZF/wqliEkAkYtwf3YZV694mNa2G/0CU2
         81aVPJ37VTAkBNQBN0B6IydtLZnlyS/4J4jAA16ekF4YZIy079WDFFZUEbXbh2m/z968
         FMEB7ZiWKjY0NWhyVrZccemefuwpoPrfDisVOCYLLxQxpx8ojP+Njf8WYYaUD2D5WfOh
         nITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386371; x=1707991171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6r04RSjl4/daqm6lsDxW2iCDk2nYZSqX3jgNVAZeU4=;
        b=EehxUlL4XiYkqAx+cYr1kTkLHoSgr7i+bl42GccihbaffkrODd5f3S5oPsVrSIBtqD
         ug04SADLMxWiHwQwu60h1GY5t1Z7R6HiyCLch9pAHlDL43uccJH5iDJfmq/SM3HC4S/M
         iIsWqHO93yJWTtM+LCCRjMpzXmNitcrtVhBkxFErnptoQrgJ2NQujkXR2nA6elFAqguH
         8P4s+o3U3yHYA0ofI5/Yip3ywU95blaHv7i0yww/+eYJssRxia4Y0XCjph/oOAXieKQa
         Gb+1RnRJbkHaNvE2UHRWOrAIy0shiBP/xwHj+KA9pmSr82Nu9QAlmPsR98zG17LHsUcd
         OUbg==
X-Gm-Message-State: AOJu0YxQyKVJ3fkrckFlpx5FCOJwwqvcqMBI6ATsq2dTJFKTvOMpZ+y2
	rUpGjD35uK4uK4oBJyX7CTMSl3XvbnqVxONetUYtCsSgUV8PlgC4XI7N5YTxVRE=
X-Google-Smtp-Source: AGHT+IFOtHWICKtvyNPMeJ786BFtSWR9xtskxC0gNMqrrtAhNX4cwqS9VXDPoUv5Td1EP0YiZoPuog==
X-Received: by 2002:adf:ab1c:0:b0:33b:5815:d51d with SMTP id q28-20020adfab1c000000b0033b5815d51dmr1158047wrc.18.1707386371124;
        Thu, 08 Feb 2024 01:59:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSULCHDgvyBzEkqouxdHRn0SRlEPfz7l9jMxWvFWI4GSK/eogNZG1gnGUVLx0/9ut57wLF0exIXM7ze4ZWkrBNkKAMxyU1HZ/pAUYzaUo7T2kLXEpuQeJBeCy1oTn/R5Rg0/20zHk/RrCk7jtHSO2aGzzr5/ZRPDnNU9SevVQvk8G3hmJFMaP22iENxUhfCCoy9UaKS7cvK50tZSwG2iZkOgVIMDlZgvo7HjTytT5p0GE1BCZ1qhzWO2ZxJrLLIeJliMyak9r5PApZwJdkGbhwsPQHO7vd1oBIrfdN+GNiqg03YxvLMX/j0evthTdJsTawaKYgo1kDqG+5ouDpyXlwaxK9Auy3Wg==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:30 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 05/24] gpio: don't set label from irq helpers
Date: Thu,  8 Feb 2024 10:59:01 +0100
Message-Id: <20240208095920.8035-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240208095920.8035-1-brgl@bgdev.pl>
References: <20240208095920.8035-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We will soon serialize access to the descriptor label using SRCU. The
write-side of the protection will require calling synchronize_srcu()
which must not be called from atomic context. We have two irq helpers:
gpiochip_lock_as_irq() and gpiochip_unlock_as_irq() that set the label
if the GPIO is not requested but is being used as interrupt. They are
called with a spinlock held from the interrupt subsystem.

They must not do it if we are to use SRCU so instead let's move the
special corner case to a dedicated getter.

Don't actually set the label to "interrupt" in the above case but rather
use the newly added gpiod_get_label() helper to hide the logic that
atomically checks the descriptor flags and returns the address of a
static "interrupt" string.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8331fdbb6faa..fbfddc9860fd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -107,7 +107,14 @@ static bool gpiolib_initialized;
 
 const char *gpiod_get_label(struct gpio_desc *desc)
 {
-	return desc->label;
+	unsigned long flags;
+
+	flags = READ_ONCE(desc->flags);
+	if (test_bit(FLAG_USED_AS_IRQ, &flags) &&
+	    !test_bit(FLAG_REQUESTED, &flags))
+		return "interrupt";
+
+	return test_bit(FLAG_REQUESTED, &flags) ? desc->label : NULL;
 }
 
 static inline void desc_set_label(struct gpio_desc *d, const char *label)
@@ -3599,14 +3606,6 @@ int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset)
 	set_bit(FLAG_USED_AS_IRQ, &desc->flags);
 	set_bit(FLAG_IRQ_IS_ENABLED, &desc->flags);
 
-	/*
-	 * If the consumer has not set up a label (such as when the
-	 * IRQ is referenced from .to_irq()) we set up a label here
-	 * so it is clear this is used as an interrupt.
-	 */
-	if (!desc->label)
-		desc_set_label(desc, "interrupt");
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiochip_lock_as_irq);
@@ -3629,10 +3628,6 @@ void gpiochip_unlock_as_irq(struct gpio_chip *gc, unsigned int offset)
 
 	clear_bit(FLAG_USED_AS_IRQ, &desc->flags);
 	clear_bit(FLAG_IRQ_IS_ENABLED, &desc->flags);
-
-	/* If we only had this marking, erase it */
-	if (desc->label && !strcmp(desc->label, "interrupt"))
-		desc_set_label(desc, NULL);
 }
 EXPORT_SYMBOL_GPL(gpiochip_unlock_as_irq);
 
-- 
2.40.1


