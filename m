Return-Path: <linux-kernel+bounces-57799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1251A84DD8B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B5DB27135
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15497317E;
	Thu,  8 Feb 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ahLjFakz"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0348F6F535
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386379; cv=none; b=pKbwo+JSXRRP1eX3X0Q2vQ6hNmpg0IwvzjtphLJo4nnn0h5z5fkE+qNWK7OtdO16wu8raSpn4JkgIWnRKdpBbmkathZqq57kaJz+Tb6/tWlCNzgrKWSpwhT56hFoZfVXMGibRDFA2OZBlnSTQkAs/AVJgMyJTShqjAULAAFAsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386379; c=relaxed/simple;
	bh=zAtmOdNOGRBb31lyhhlsZytG0MEiuyGU1nnHlSqWLMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vAwJ3mgpxX6viujFN/S6mQapg9kT+VXhc03Hl5MNYG8oD/3B53QXkp8r8Dig7iF0ztL2hYfq8Rb4ScnkaiQ2pyg3G8Ozul+qKmDj8fMUjx8ifsddqMaA0HKNzx4oV3vFnbJ+SHDB9eZkQac6ep3yOhO1CtqWhchnz1BFGzg+skg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ahLjFakz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so3844925e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386376; x=1707991176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Psr/S77Ef9/NFyemfTs4Z611NQxBnhaN12nhKTkN8I=;
        b=ahLjFakz228obu5b23OLx+/y4wgLYhtjsZaVH86HdXTyDIBoceweIepDUXU04DLwce
         mih9LqeY4W031x2I4249nZGnDtssRd0BwSfSQRzM0Apwtmc7wgjFEUE92Z0+Jj807FyF
         Tx3XlOt16rwi32YXJ+TBLnV/ax8ec1F/thcAi7dPIMeBz1ERmp4LNv7BCiEMAo1grHGQ
         e0QCuyFgIHTpaKpVN/qXp1uw+E/Ukz9EH8WQKXvHaU+hVkMQsFI+0uAXdpM0/rJcV5+v
         v2YVdnx4HE0GCXH2lhLOceK+CxLVXP1bnrxCKkqZTLnlAWFwzmYisxhaej3Z5kT7awuI
         VDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386376; x=1707991176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Psr/S77Ef9/NFyemfTs4Z611NQxBnhaN12nhKTkN8I=;
        b=DjOiwet07alSEWGgEm6LTDRT39eF6/kWGbN/kFfNWp2BR7azpB4JJw72/ViyQNFVgh
         uTSCtRP2WmVAQsf80UYqdUd84YauO4e8FBzVH7qBjOhSbzNz+mijNF1ocpRgMXoDbpOS
         jnEcvBe8NtIPE9WWyqA+9MdRHae7BlOTWb+ijlG+iDqhhU42G3bGRpSfG3qp3ABvYQQP
         5ZyY/VoOLeU+6hBwqxzkA83WzpEdC6nhExFEDK4Qz9nwIk0Toe5qNJp3brqeSKclS/kT
         c1HvtOCBrkgkWoHQ0F9k/ypGoTjy1t2fISh7zI3j13duq7FqhP2EBDtZS6TRz+GuNxPZ
         2y3Q==
X-Gm-Message-State: AOJu0Yw3H4+rwbegS69GKqiv6n1wHVoUzU3uaeMDkO8+VhN0ELNRq8Ji
	vWYpVFJtlmMhxg4GXqO0vbaH/gFfm0vo9DC7sxaw0HS2SBTQbNLt6PKjyZWfS2c=
X-Google-Smtp-Source: AGHT+IGH7TXtO138rKdtwfptyU3y5eIAD1aH0S2JN39PJx44mURqBCg/VyAPzmgrymKi2Hy4yoWOGQ==
X-Received: by 2002:a5d:59a1:0:b0:33b:4669:4ba with SMTP id p1-20020a5d59a1000000b0033b466904bamr2095371wrr.6.1707386376107;
        Thu, 08 Feb 2024 01:59:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVzg/tGttYcpQQNBU4Wuz+y7v0z8uIClKBtLO/U+Tu/xGRtRGL5SN0jh09A1a9NhYNuAdj5+xSpjSKNhi8vi5bf5LnvvYA96D10zBExK2MLMZvlCg7mVlFxhVDfhD9ZxbHHgNf3U4O1RuktVlXigmJC7+Uz3i6SQL+8EQxSvFCUb7d2FwS8xDOdy+5zwcGJ4FTSpvpIlpwgR+WQwRHYQvkPDU2IK+yMj5hwJXFoKopa+2yYw97aRGF8K02zCDZasmXlA/FYMrEcdSi03DmEZ3ZfkVqFM45r2Zj+4Y+7y/5NQqCI9L6jTI3iU8OGkSP0D1Mgn1zWNeuBY7byAya3WZbe8CgvmBqDQ==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:35 -0800 (PST)
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
Subject: [PATCH v3 10/24] gpio: reinforce desc->flags handling
Date: Thu,  8 Feb 2024 10:59:06 +0100
Message-Id: <20240208095920.8035-11-brgl@bgdev.pl>
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

We now removed the gpio_lock spinlock and modified the places
previously protected by it to handle desc->flags access in a consistent
way. Let's improve other places that were previously unprotected by
reading the flags field of gpio_desc once and using the stored value for
logic consistency. If we need to modify the field, let's also write it
back once with a consistent value resulting from the function's logic.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d0de492acd4c..5e098a7816bd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -336,18 +336,20 @@ static int gpiochip_find_base_unlocked(int ngpio)
 int gpiod_get_direction(struct gpio_desc *desc)
 {
 	struct gpio_chip *gc;
+	unsigned long flags;
 	unsigned int offset;
 	int ret;
 
 	gc = gpiod_to_chip(desc);
 	offset = gpio_chip_hwgpio(desc);
+	flags = READ_ONCE(desc->flags);
 
 	/*
 	 * Open drain emulation using input mode may incorrectly report
 	 * input here, fix that up.
 	 */
-	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags) &&
-	    test_bit(FLAG_IS_OUT, &desc->flags))
+	if (test_bit(FLAG_OPEN_DRAIN, &flags) &&
+	    test_bit(FLAG_IS_OUT, &flags))
 		return 0;
 
 	if (!gc->get_direction)
@@ -361,7 +363,8 @@ int gpiod_get_direction(struct gpio_desc *desc)
 	if (ret > 0)
 		ret = 1;
 
-	assign_bit(FLAG_IS_OUT, &desc->flags, !ret);
+	assign_bit(FLAG_IS_OUT, &flags, !ret);
+	WRITE_ONCE(desc->flags, flags);
 
 	return ret;
 }
@@ -751,9 +754,6 @@ static void gpiochip_machine_hog(struct gpio_chip *gc, struct gpiod_hog *hog)
 		return;
 	}
 
-	if (test_bit(FLAG_IS_HOGGED, &desc->flags))
-		return;
-
 	rv = gpiod_hog(desc, hog->line_name, hog->lflags, hog->dflags);
 	if (rv)
 		gpiod_err(desc, "%s: unable to hog GPIO line (%s:%u): %d\n",
@@ -2528,13 +2528,16 @@ static int gpio_set_config(struct gpio_desc *desc, enum pin_config_param mode)
 static int gpio_set_bias(struct gpio_desc *desc)
 {
 	enum pin_config_param bias;
+	unsigned long flags;
 	unsigned int arg;
 
-	if (test_bit(FLAG_BIAS_DISABLE, &desc->flags))
+	flags = READ_ONCE(desc->flags);
+
+	if (test_bit(FLAG_BIAS_DISABLE, &flags))
 		bias = PIN_CONFIG_BIAS_DISABLE;
-	else if (test_bit(FLAG_PULL_UP, &desc->flags))
+	else if (test_bit(FLAG_PULL_UP, &flags))
 		bias = PIN_CONFIG_BIAS_PULL_UP;
-	else if (test_bit(FLAG_PULL_DOWN, &desc->flags))
+	else if (test_bit(FLAG_PULL_DOWN, &flags))
 		bias = PIN_CONFIG_BIAS_PULL_DOWN;
 	else
 		return 0;
@@ -2700,24 +2703,28 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output_raw);
  */
 int gpiod_direction_output(struct gpio_desc *desc, int value)
 {
+	unsigned long flags;
 	int ret;
 
 	VALIDATE_DESC(desc);
-	if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
+
+	flags = READ_ONCE(desc->flags);
+
+	if (test_bit(FLAG_ACTIVE_LOW, &flags))
 		value = !value;
 	else
 		value = !!value;
 
 	/* GPIOs used for enabled IRQs shall not be set as output */
-	if (test_bit(FLAG_USED_AS_IRQ, &desc->flags) &&
-	    test_bit(FLAG_IRQ_IS_ENABLED, &desc->flags)) {
+	if (test_bit(FLAG_USED_AS_IRQ, &flags) &&
+	    test_bit(FLAG_IRQ_IS_ENABLED, &flags)) {
 		gpiod_err(desc,
 			  "%s: tried to set a GPIO tied to an IRQ as output\n",
 			  __func__);
 		return -EIO;
 	}
 
-	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags)) {
+	if (test_bit(FLAG_OPEN_DRAIN, &flags)) {
 		/* First see if we can enable open drain in hardware */
 		ret = gpio_set_config(desc, PIN_CONFIG_DRIVE_OPEN_DRAIN);
 		if (!ret)
@@ -2727,7 +2734,7 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 			ret = gpiod_direction_input(desc);
 			goto set_output_flag;
 		}
-	} else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags)) {
+	} else if (test_bit(FLAG_OPEN_SOURCE, &flags)) {
 		ret = gpio_set_config(desc, PIN_CONFIG_DRIVE_OPEN_SOURCE);
 		if (!ret)
 			goto set_output_value;
@@ -4424,21 +4431,22 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
 	int hwnum;
 	int ret;
 
+	if (test_and_set_bit(FLAG_IS_HOGGED, &desc->flags))
+		return 0;
+
 	gc = gpiod_to_chip(desc);
 	hwnum = gpio_chip_hwgpio(desc);
 
 	local_desc = gpiochip_request_own_desc(gc, hwnum, name,
 					       lflags, dflags);
 	if (IS_ERR(local_desc)) {
+		clear_bit(FLAG_IS_HOGGED, &desc->flags);
 		ret = PTR_ERR(local_desc);
 		pr_err("requesting hog GPIO %s (chip %s, offset %d) failed, %d\n",
 		       name, gc->label, hwnum, ret);
 		return ret;
 	}
 
-	/* Mark GPIO as hogged so it can be identified and removed later */
-	set_bit(FLAG_IS_HOGGED, &desc->flags);
-
 	gpiod_dbg(desc, "hogged as %s%s\n",
 		(dflags & GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "input",
 		(dflags & GPIOD_FLAGS_BIT_DIR_OUT) ?
-- 
2.40.1


