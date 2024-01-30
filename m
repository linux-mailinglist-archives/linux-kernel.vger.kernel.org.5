Return-Path: <linux-kernel+bounces-44632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE88842551
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0D21C257FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386086E2AB;
	Tue, 30 Jan 2024 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EMQivRYd"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2EB6D1A9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618928; cv=none; b=I4IWo9IbNig9uAOll/MJCfGBEVa5FwLY3TqRpKcmiUTth93zjPT8ekSkf1oq9y99Cs65ZiDzWtXNJt5m0bzsv+WDApfo+rIXtwFp0klGVcbZhShSvJRko3FDgkl2EZFkPc82uC4wI6kdKmFUv1IrJgwzHhJe0tP+zGouM07Rh8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618928; c=relaxed/simple;
	bh=w/6C0LXYSVlAEDD4c7gnkwzsfsPQEwhfaMmHG5iDNI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1//Q1+1UHA6aPwAPKaNOSTL8+N9XBxKSb9ePArg77KKeR/Bmyz+cSUh93TI86Uz0VAhsNOieBFUjha2QrcssGIWaL863FrZ1njiW5mBxKi8C6zRln8MSh9Fu9tpPmx+isbfonrSzRenrAHIc4+iISFTqy7q4u5cUS8OhznJ3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EMQivRYd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e7065b692so42560895e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618924; x=1707223724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJQAPHnGPqj4qq3a7VK5h6sk6j09P7jLPNzWXDjdei0=;
        b=EMQivRYdFIPwinLzRm//CK61LyWLJpzIte7H8LNBS+ANCwrIsVaZ3ENKTWruUqSgHn
         y4zqRNQsrSf5QE9OVYQygu6894D0j9FURmVntQIZPh+atmyNCez/jPpbxbzKTMIEzpK3
         R1RyWSKT2M5kgjCpIuxXp4rqkVFwrm+dmEGagEl9qcs85si2PwT8VZi+fksyOufn8FtX
         asdQhukreKwrjg/gm4pTiFEw2Fzeo2wcmwi4avriNx/X4LYyaPlOMOrbGjI+t8F8Vuya
         AtiiygK22Bd+qp5RrCOQRK2d1yW2smGpDGM4AeKtYg5slnNEivK6J/d2gN2ehiwUTCSm
         S4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618924; x=1707223724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJQAPHnGPqj4qq3a7VK5h6sk6j09P7jLPNzWXDjdei0=;
        b=VpCFxDiQ6HN49sYh53kL1Zgummjc9s/A6RwvWMy5lr/zRH7rxx0U32g9hMdvjNKM0s
         LNaM35JQm3BT+ZEvsYXETrIAzITD8+Gj4aa7kx1jRj9IUW7Xdet3JsZpzUbNxapo4lvL
         ewOf++4MemzcGM6dKqGqGMdRntaI5uo0p+z+MhXad+17bPorV613UJuj70ZEAue264Cf
         MfYWdB3GgQGWZJKqFnTF73nTn24KgLT7QqikiSdeq3Q/DZLsKLBarmUVjMUxwcy2O5Qy
         YWHKlTbzgnXUsGep2IsEOPbgz5ZL0NFojs1SQOydvsmbAGdbfTvYln3vzpaipsn+YQco
         /6iQ==
X-Gm-Message-State: AOJu0Yye5zN/FZsq3pCdpaJZGgPuOfXkI+J07mjsUmDFojltxb+FMdcN
	ocMAiwsGALdUp3GzbjkuCc4HNM9J9/ir5qb4QHvv1gWtfhwN5qpETXRDFpkddpg=
X-Google-Smtp-Source: AGHT+IHzB67OgTxI+fcR3wK5ROr7axGVhmXy3f6vdGpTdqUd1C43aAr+F+w+9hHdNQug5OAu33joOw==
X-Received: by 2002:a05:600c:5123:b0:40e:4806:f436 with SMTP id o35-20020a05600c512300b0040e4806f436mr7277977wms.3.1706618924403;
        Tue, 30 Jan 2024 04:48:44 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:44 -0800 (PST)
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
Subject: [PATCH 05/22] gpio: don't set label from irq helpers
Date: Tue, 30 Jan 2024 13:48:11 +0100
Message-Id: <20240130124828.14678-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130124828.14678-1-brgl@bgdev.pl>
References: <20240130124828.14678-1-brgl@bgdev.pl>
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

Let's use the flags of the descriptor to figure out whether we should
use the special "interrupt" label.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d0a2f014dacd..4e6b26b3febb 100644
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
@@ -3590,14 +3597,6 @@ int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset)
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
@@ -3620,10 +3619,6 @@ void gpiochip_unlock_as_irq(struct gpio_chip *gc, unsigned int offset)
 
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


