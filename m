Return-Path: <linux-kernel+bounces-44629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CC6842549
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F40287BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C056BB3C;
	Tue, 30 Jan 2024 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LIyswGDQ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F06A32C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618924; cv=none; b=WWp3Nr1aFN7+pLzl+Qa5SWhq+craoOKmzc7wivi1JnFrl2APMvYDXR8sNZMXQyS74PGzc/c+y0pXASYwrtM6/JXOoenJg00ka3uC+Bbp03o6lrqMSOK0amIYRZ99CcSIMxAI0JhutUoFYdVYEBvsYfFrVtXkhW/hxhHTxUBT4p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618924; c=relaxed/simple;
	bh=HTY0/2MFXdU9HmBazmc+2XEskfSidj9LYVSAtlFVBY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NT5lvafNTeStyVmH0KOuJmOa5vr4wS+rtc+hNy03lEX3HGWjsc2GCwCMsNY91q8ieqxYPSIsuHTQ7uAGkCuJbeMGYfwBF9B8su3ZAtdnPtGzGASB4ujANVneprtpeKVyjDrX+PHex/D5DE3I8clW0xVZq24EqmsHF3cj8IVtBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LIyswGDQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ef6da20feso12016685e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618921; x=1707223721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojJhTYdk1V3InZFc5SwkU5Oow/t8kOsaTzvFKL9m9DI=;
        b=LIyswGDQ1e/3DBupL0fWGbu2Q7irtNixSgrrHwe/BTcW0HG7dUW/oxFyvWdAUKKPpx
         u/whBbprgvBLZOAR2aZCD8U7Umj8yA7tW0y0Uj6j13fboWJhofxxexy+RYGSXQzMRxQS
         IJ2bmrYE8ij6pDMnCAwFOEUmsWoX47hFOladnQqwIw8Auly+WhCLf4/HCaOK0avcApXp
         zilqkRLcmz22g8/Kk2uyAty6sBWgZXgc2o12LOU2OnktGM2qXUjJYEbm2M2bSz0QS15F
         D33M1XrLYKLqiragXxjnTmdIKXqm1mGqS9RjhrgLgicr+qUFCPEaDFhdqVl2C40JTTCl
         pJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618921; x=1707223721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojJhTYdk1V3InZFc5SwkU5Oow/t8kOsaTzvFKL9m9DI=;
        b=lmIp7v0SBacQMHyLZ1G+cSBRh1m0PvqCnfwlDmcdx9/NVREE4+6WHOMmyf4w34WSoE
         qIiNykngRdKyd4zHjCy4xcWRenuAhPg7DR/2r5Ce98LouUG6H2ek6tQowQET+Sy2eSum
         iOwQJ4VF+YcviZrPR13PoxOqgHaltfqxEPcfhQauuG6z8WUuYtsfVLeXSP+fioIr5xzf
         1Jr9mFAlXudsdHsxlUJVyF6/517Z2Mi7eSLAnjQVtBh1HFnP81RphacGWCz2Xt8aRVtD
         TV6qen/9FdO+7bCqxQTDomInxxrzGD1+nVFnrKjL2b2lYesKHtJ4/V9jMVTMDATse4bE
         xvZQ==
X-Gm-Message-State: AOJu0YwULY3sp6n1WDxmY1cESQZpMue8cTUMIvC+LkwZpFtlkB6CvBeI
	/cdDnAO5V4WkGvWMPmf8vkU16aHe81yZ9FAf7vn5o6XgsU7J6SWrJ9U9E0T35hM=
X-Google-Smtp-Source: AGHT+IHQTdf8jrcXRgcHGhv9scvWD4c8aiukjG9VFVOZFY5S15DLQ6GpF1scNPJG0nRMaFK2DHqmUw==
X-Received: by 2002:a05:600c:524f:b0:40e:8655:d48f with SMTP id fc15-20020a05600c524f00b0040e8655d48fmr1435047wmb.11.1706618921592;
        Tue, 30 Jan 2024 04:48:41 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:41 -0800 (PST)
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
Subject: [PATCH 02/22] gpio: of: assign and read the hog pointer atomically
Date: Tue, 30 Jan 2024 13:48:08 +0100
Message-Id: <20240130124828.14678-3-brgl@bgdev.pl>
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

The device nodes representing GPIO hogs cannot be deleted without
unregistering the GPIO chip so there's no need to serialize their access.
However we must ensure that users can get the right address so write and
read it atomically.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 4 ++--
 drivers/gpio/gpiolib.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 77509aa19900..bd6b8702c790 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -800,7 +800,7 @@ static int of_gpiochip_add_hog(struct gpio_chip *chip, struct device_node *hog)
 			return ret;
 
 #ifdef CONFIG_OF_DYNAMIC
-		desc->hog = hog;
+		WRITE_ONCE(desc->hog, hog);
 #endif
 	}
 
@@ -848,7 +848,7 @@ static void of_gpiochip_remove_hog(struct gpio_chip *chip,
 	struct gpio_desc *desc;
 
 	for_each_gpio_desc_with_flag(chip, desc, FLAG_IS_HOGGED)
-		if (desc->hog == hog)
+		if (READ_ONCE(desc->hog) == hog)
 			gpiochip_free_own_desc(desc);
 }
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 69979de76485..543d80457647 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2321,7 +2321,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 		clear_bit(FLAG_EDGE_FALLING, &desc->flags);
 		clear_bit(FLAG_IS_HOGGED, &desc->flags);
 #ifdef CONFIG_OF_DYNAMIC
-		desc->hog = NULL;
+		WRITE_ONCE(desc->hog, NULL);
 #endif
 		ret = true;
 	}
-- 
2.40.1


