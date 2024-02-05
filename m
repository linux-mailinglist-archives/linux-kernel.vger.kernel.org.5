Return-Path: <linux-kernel+bounces-52309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD35849697
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D765A28688B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0736F14014;
	Mon,  5 Feb 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EvMogXAG"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3D134A9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125673; cv=none; b=n87fU5y42ATY7EwH1xkmh5scZOf6Lq89DMuT7ofyCBLveeV7M/HUDvz27xEnj2xWJszK3R1h8LjpoSFBUcSdTfl7104uiRepvQ2FBUG4HsKYkAiSkhp3JzhnNOjj9QyCn2wOKC7kCo3Ek1wlyvCcdYfFNOu4JUwMBchvYlXw8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125673; c=relaxed/simple;
	bh=L91BBpikBkHqwcQ57UiFh0/5/PsxnAo8v9+gu/rUrOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQtuqQ22gz99Sc6jXKz6LFBrCZKKXouasw1F3krwChESNuslYAFf5b2/ij199/vwT242w8Kdqffkf+47b4sbWnE+kVLGlSMiVBJNjLiNBSJdyGQLd5s6rwihoZSEuuy2Jk2Y3Bg9/dLpQfBw2Od/JFVAiStVP7HjDFZpZ83p8eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EvMogXAG; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51124d86022so6489913e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707125670; x=1707730470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSEnfVuvu8Q/tNHp1neFQSbtxw3POuiVtvIa5az8diw=;
        b=EvMogXAGlsh8KWLG0umTfCX7vtaABlzwJdWaKMsuxtbJoYfEfi1kL8vzQxMo9Li1nl
         JHEnXPvxJgm2c5W3FrtYOHuvi97i5zs2r9VyhhIBgB/KUfwIBznnq2TRy+SW9sIa7I7X
         4O7qkHbIjkja9QZ4/f7gCvE5/ZEw8LTuS/oZShaSqRWe2B/7xDUqYNTGCfOEfE3gPs26
         EXTpBv2CKYdJZsrupiz1oakh8SQ/9/carta/uD37Om4SNhdrj5O/N8bszHRw7qsnG/MM
         5nK6Sw7lBhWtXPpvAN8xJVyNdhbdw6UCS6fI3Mry+n+WgBGS8Ke2wLNgxhjHRXHeJeCS
         an1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125670; x=1707730470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSEnfVuvu8Q/tNHp1neFQSbtxw3POuiVtvIa5az8diw=;
        b=BXwA1XUKvIABiVEbGpzNBugscSdfEXjBIF+B/Yko5SlCU9IP+2wr8ctn++kggFoOlQ
         2nSvc00uOXTrCNrW2ft8BvPhX9UNKHJhsTikmzjOPuffmzVxG9Dt2/jJEFtHpBFHAiIp
         KDNY54aw+tfQFXWrsq3Wrtnt9k/qljTFW384wcn5B60mu6g+OkM8KAFYNMemhcYS7YWk
         Rd+isTJSKcHn1qlmxwrUsRUvma1qWbANIs48q/a0yMjXNiE5bAgisdYpEAXSGU9CJt3N
         OiOzgaRmTq9IMoRK+NtTBM9y8hH6FIwunP/EPoJKEz8nrcTIYM2yV5+2RDrntbmngjpF
         sICw==
X-Gm-Message-State: AOJu0Yw0BECwhBefPCHBf3ESsX/YV5F/borz6HkaVuVXLpKQDVfdLU5Y
	Th6KEidn7wPwfiJmwlGoCycaFh/qNw0zkzg4F8gYImp9QlVIYH+67oFkyzoStiM=
X-Google-Smtp-Source: AGHT+IEcPafTTkHgGkgn+DFvdWRnWTQwe2o6OEptnHsezn9spoJf9YLIqVdfi0Crff3zOVppi25yBQ==
X-Received: by 2002:a19:f711:0:b0:511:51af:7548 with SMTP id z17-20020a19f711000000b0051151af7548mr1026924lfe.9.1707125670191;
        Mon, 05 Feb 2024 01:34:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXobqsD3Uis6hLjobTZp6XBfCqM+9f4VYj5owOVxKdXHlS2gCu1PCPgofYK23757bJ/XK2ElC26nPRA4h4YtVC/gdKQ4wq4XOjIOmbTYckFQlDJOqPc6AsLuLziM8+0Qyio6nOZmt8AyTrQuDJ+EJfop1t007ahMAjUqU+0A9qQ3eREHCs9wSMC3KjHXY0TEGrQlG9f6P3CakEMHWrkvp0gv9rO0NFnYOjqOkep+YgX9qCyiwo8Bxsf6PzudPDrsZ+MrNRJho9xwCRjRDokEx9AHlLZ42c+XoqwEem2lZAO+yd4LRCowmQWbAnvrsWp/7n1976/gdhfl9QqNOnLRGwgblsF8s3yYg==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b0040fc771c864sm7980397wmg.14.2024.02.05.01.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:34:29 -0800 (PST)
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
Subject: [PATCH v2 05/23] gpio: don't set label from irq helpers
Date: Mon,  5 Feb 2024 10:34:00 +0100
Message-Id: <20240205093418.39755-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205093418.39755-1-brgl@bgdev.pl>
References: <20240205093418.39755-1-brgl@bgdev.pl>
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
index cfd311ec5dda..5c041d57077b 100644
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
@@ -3593,14 +3600,6 @@ int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset)
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
@@ -3623,10 +3622,6 @@ void gpiochip_unlock_as_irq(struct gpio_chip *gc, unsigned int offset)
 
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


