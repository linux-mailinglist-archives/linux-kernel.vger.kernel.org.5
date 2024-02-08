Return-Path: <linux-kernel+bounces-57792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4205284DD7A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B1A1C26E0C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87C96E2D2;
	Thu,  8 Feb 2024 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UMW0K4MX"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238D6D1BD
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386373; cv=none; b=i55qxRV2Ews+XeWHjXPtpGAM42HtVKpywuEyYrh1XIUwXhZW8x+yVoucP3c3xRPaIrLV29b3Hs0bpPaeGkBleuQrHb+2l9tSTOpYES5M1wJTxTu/jkQplfMmckVqaNWsA5TQmd5OpmlvXwv+uxTOPzyVqzxKx4deMCwWNsRh0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386373; c=relaxed/simple;
	bh=wKoekw2eVVFcj9oxq6vzdf2ok15iXRtTtNq2jliv4lA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUp4nmJ+PJsVBReHHKFAl7+qSXIoGFTGE3m7feoY7QOPjKO/SOEuPeLr9sXwRCRfl6IYBqMRR5WadCvQMLb2iOqMminMgwwWp4veYDFrvUBT0rjIT1+J19UnNIJnpA7lhiqq4nd2m5smNBI5T+9Zjdj+M7pIg5dPFR3d5oETVdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UMW0K4MX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40efcb37373so14659305e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386369; x=1707991169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZDQVAK/m+EwHZp2HJIrHIBUSEbpzq9pOlgL2Kpkkjg=;
        b=UMW0K4MX76FF137+ghy+Pa5MKiqGwWp74uK9iA+NRtO7fimCnUetr2FOrl8E0KLZ53
         5kYrjLW01V2m+K6ZYTpC0bU8kpvrN6+PWh3oBfB85Kjqr4ZbZ0NwnIRB8aHiLANsNi4c
         prQMbbltm6w/ngwq7YUgcMep9fs3yYCpMr6PT09V6ZbMlb6DCIE0Ywmk/aWtmN1N8Kkl
         jZwyBVRfDo0b9Dnt2eZTB/G188g3+Yh3LeFulRFgS3u6PXjQLVMCXh9t1f8EBY2i0emD
         Ctla7mGMN7HaxxGnc4/hUpjajE3hgDNFA9bcEj08rmSfUiFQT1gqJR5lSC1/MfMzmJm7
         W1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386369; x=1707991169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZDQVAK/m+EwHZp2HJIrHIBUSEbpzq9pOlgL2Kpkkjg=;
        b=e1YVBy2yooecb6PJScYyUjP6PFgDDUpa8pyswwqylWXSaA2aGiSb8IBcJKfRqENMok
         dm9BaZYcxo4IGC3IdGNMkBNsyf8g18tbQ7AwsIE2fR9l7ZylS45OLYioItQZjV1ANDHd
         /Lvo5hhvYoN+QZNGVrnHlZwRfWTLTZ5BCtGRlCmgsHywzKJd0KxX8Vwb7F0sKc8v4xSX
         mmDms8TiFdhg8pnWB7xotllIpNt2ET7SNDRl4PDqlEgzzG+O1H70V9Q9zImNXFMxL9FO
         XxqWfpH/01igZrdqG3eGP+P3nFyVXkTHZkSNHBRGTlDnaKezYaUGQxhyenLb56jJhsDc
         ZmIw==
X-Gm-Message-State: AOJu0YxqtUqjwRRq6jwomq+6t7dvkAgDGgHwhQx6HMjpNHgobwoCDrpf
	pXHoTDB3U+pl3/x7OLg0GNOi7i2+hAcPqjBvzBnbaoUXOSnos6YVEvEWts70IUU=
X-Google-Smtp-Source: AGHT+IHpYgYU7LpZVBEQhxULZvRynnzmGlJbp9aR0ZlD9CxSRz8o4AhactP27KD5wlwIMpxoEwxffQ==
X-Received: by 2002:a05:600c:5204:b0:40f:bdf3:3426 with SMTP id fb4-20020a05600c520400b0040fbdf33426mr7424055wmb.31.1707386368785;
        Thu, 08 Feb 2024 01:59:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxd02syAtgcCCVmPOmILiczOck7r4jrJz2J9HCO/q4RHO91hHtAxO4GoOgh8MZ9LDjmrWHSOxtZnsjTvHBKOfBGXFszXpmwEz1jBAorJTRtmXCOaqd4mviRKWe9HoPPxeGuMGuWviDb3I64HE+rb8Brk+eO9lm9h6i/lLQYERHPeYfNnqOXJJr+a/S1dW+ZIocRiWid3Z1h7YOSGFSJMAnY/QSxDu6KY0Ikxrj/GoaRxWLZVjBFYbvGMTIBi55vtMpZD2PfvPg4nEvmHj4TtIK1fKTQ5oZlRAFm3nBXCsEcmLOYg6cdQ6eAILgGjPCLSDGdqtdyIuCkI/4twKEY732giHiZRCx0w==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:28 -0800 (PST)
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
Subject: [PATCH v3 03/24] gpio: remove unused logging helpers
Date: Thu,  8 Feb 2024 10:58:59 +0100
Message-Id: <20240208095920.8035-4-brgl@bgdev.pl>
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

The general rule of the kernel is to not provide symbols that have no
users upstream. Let's remove logging helpers that are not used anywhere.

This will save us work later when we'll be modifying them to use the
upcoming SRCU infrastructure.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index a4a2520b5f31..c3ae5bfa3f2e 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -219,31 +219,18 @@ static inline int gpio_chip_hwgpio(const struct gpio_desc *desc)
 
 /* With descriptor prefix */
 
-#define gpiod_emerg(desc, fmt, ...)					       \
-	pr_emerg("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?",\
-		 ##__VA_ARGS__)
-#define gpiod_crit(desc, fmt, ...)					       \
-	pr_crit("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?", \
-		 ##__VA_ARGS__)
 #define gpiod_err(desc, fmt, ...)					       \
 	pr_err("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?",  \
 		 ##__VA_ARGS__)
 #define gpiod_warn(desc, fmt, ...)					       \
 	pr_warn("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?", \
 		 ##__VA_ARGS__)
-#define gpiod_info(desc, fmt, ...)					       \
-	pr_info("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?", \
-		 ##__VA_ARGS__)
 #define gpiod_dbg(desc, fmt, ...)					       \
 	pr_debug("gpio-%d (%s): " fmt, desc_to_gpio(desc), desc->label ? : "?",\
 		 ##__VA_ARGS__)
 
 /* With chip prefix */
 
-#define chip_emerg(gc, fmt, ...)					\
-	dev_emerg(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
-#define chip_crit(gc, fmt, ...)					\
-	dev_crit(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
 #define chip_err(gc, fmt, ...)					\
 	dev_err(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
 #define chip_warn(gc, fmt, ...)					\
-- 
2.40.1


