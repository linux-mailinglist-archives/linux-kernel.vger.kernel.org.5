Return-Path: <linux-kernel+bounces-57813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376A984DDAA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF41DB2573F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C567AE52;
	Thu,  8 Feb 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lZyJUMJh"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB236D1C0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386394; cv=none; b=s0HHwVavK963WBDQDb9C4xBYJ/0o/v702s63iTqEPIm/7xVdNqaSusrzINeqyzoMGW80Z+6xht5gaOrgKcyEPgE42hcF95LeSjbES4zp0hOpviHFTDvNmxhqrwgj+F2O96c5Os8B2S0QnYPwfrDWasxws950QmVJB2E4SG8KHAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386394; c=relaxed/simple;
	bh=CtfJea0llJCBLvTJBTUKy6/8afj286rr8HrvBr31xBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OYSZZgOSnRCXnSvYgpQC5/R+Zu5dCu7X3ySh4FiWqAFCpMsFh43BnEWrj9z9NdskZRYd7tnekFZoYxX8GGP9dqlWwIv0h9OlwmIqqIriASRY60bcQGMGd+mpmI5aGMcdaoGdybsbqbrOCnNciaIQ9BHmi45Rwwdv1OW/1yBFFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lZyJUMJh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3392b045e0aso1005405f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386390; x=1707991190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQkXxgYTerhoxLqWK4A1mYLklWfm7Kp5H6fCKOtV4ow=;
        b=lZyJUMJhcFnOaL0i6TGu+B1up7B8tzncMZ/E0NKuoAY2P3obkhn9L4JdPrXwfXjG0i
         iIITJhIcpsNMeVE3wXB5MQQOMfPVprUHYsleuYHnTIcPHbKsSM2LsbUdrw2x04oAgMQo
         DZ27XBdKMQGF3Gq6aAoeRAm87FYEInaR4KzQt7NsiwEg8XqWYCl8mE5pw4gZ8KciCGn0
         bYjNwY9NbPi4UbfGEQ4SBjEyoK7Xn1/8WjmWt60nIFcfqGBq4GvGU3TIYC1QDTgomMPd
         shsSKgx5rueSYTGF4foCW80h2GoxWoccYpEnwEv3gQ6X1Xs+LdkBubo63HSo0bJ15se5
         anXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386390; x=1707991190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQkXxgYTerhoxLqWK4A1mYLklWfm7Kp5H6fCKOtV4ow=;
        b=aXec5MrHV1woFYm1wlh1cqkGo0W4s6HpGz9vdX+nIUkUBhBQB8wV96r53+OpVn0Vz9
         Kc23OZeiRZF+ve7r72YzlP7GKVtXIPY+nNbplE0QAgTXPDiOR/inoiO1pJuRpGh0ZGfO
         I6l5KwVnA8CeOLmd1C5jz5iQNQd95i3DnWFLxTP+QlfZyPqKz8XHNthALNvAye5eitJl
         1NWcFngbtg5Aqt6v9+VqbrXKpD38ZPswICxG4AvwmTGO3ZEyHGd189fCgXyN1/LvqpBQ
         o5S/Ix5gGWnNm8hZBLCHqbRXz4R6tXBtDigpQ9gPFClDJVWi0aqfsiSbsM0L8fey9Rno
         jnNA==
X-Forwarded-Encrypted: i=1; AJvYcCUE4IrT3Y4FOR33T9GD+M6RzeyysJp2/EoODQvV0p8UbUSK9hF0OmzEkykTYnii62NZLTRyGf1Gc6iw0sRJZCwnC56W+eS2yZEeMtB0
X-Gm-Message-State: AOJu0YwCs2kSMP+ktPNX035Icox04SdM8HQbX2T9iCXlhtapQxba0t+O
	PsVN35nQLvm5b1D4XkHR3T8alzTUuZOjxvlxkOLwPXN9hNv8J4vKyfE2hwi7Wzc=
X-Google-Smtp-Source: AGHT+IGq3e298KVnbRyWWqb8ismpBx3ut4qdYui+oTCRp3zXsE+6izxgvQ0scMCLcwxnS3lYbIGtHQ==
X-Received: by 2002:a5d:6da2:0:b0:33b:48ee:8a35 with SMTP id u2-20020a5d6da2000000b0033b48ee8a35mr6663999wrs.3.1707386390500;
        Thu, 08 Feb 2024 01:59:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxrRfrkwx9pQNCPSexFg8gEuiisVSgdZDXYZemOfQu32vyLwfYaTiNTWin3thqJL+dyhNvivFtPGRwobRpYoMfOn/mOUrzvMwHWbE6NjArsDWPDj4OMDcqwqB9En/dv16KW1hPfl2a99JOlnRckxpb4NoPxIfoP70RZyn2foTURzqaYHLxASUq+yMbgrTnBtzAPmHYhmwoNe0Kw7gVS/VgP/KrVYH6qTiKaxO19iAA+Thbb9Mhojx3bDeJZx9iNgvhW2zWGv8ZCzw7JUcuFax3lDLrTk70sfGNQ6UPieT+NHJEDS0sGb240hUf5pzrDJec68rpd1DcsoAl5WTrL/k1lpWMaHhSmg==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:50 -0800 (PST)
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
Subject: [PATCH v3 24/24] gpio: mark unsafe gpio_chip manipulators as deprecated
Date: Thu,  8 Feb 2024 10:59:20 +0100
Message-Id: <20240208095920.8035-25-brgl@bgdev.pl>
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

We still have some functions that return the address of the GPIO chip
associated with the GPIO device. This is dangerous and the users should
find a better solution. Let's add appropriate comments to the kernel
docs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 97829f0c8487..9f8cf064002d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -211,6 +211,11 @@ EXPORT_SYMBOL_GPL(desc_to_gpio);
 /**
  * gpiod_to_chip - Return the GPIO chip to which a GPIO descriptor belongs
  * @desc:	descriptor to return the chip of
+ *
+ * *DEPRECATED*
+ * This function is unsafe and should not be used. Using the chip address
+ * without taking the SRCU read lock may result in dereferencing a dangling
+ * pointer.
  */
 struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
 {
@@ -275,6 +280,7 @@ EXPORT_SYMBOL(gpio_device_get_label);
  * Returns:
  * Address of the GPIO chip backing this device.
  *
+ * *DEPRECATED*
  * Until we can get rid of all non-driver users of struct gpio_chip, we must
  * provide a way of retrieving the pointer to it from struct gpio_device. This
  * is *NOT* safe as the GPIO API is considered to be hot-unpluggable and the
-- 
2.40.1


