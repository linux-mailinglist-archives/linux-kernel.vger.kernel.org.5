Return-Path: <linux-kernel+bounces-70466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A820859846
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FD92814AE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFC86F064;
	Sun, 18 Feb 2024 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GkSY2Cbm"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E0E57E
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278543; cv=none; b=fzT8C7hkGN3bhczwt0kuFyUzkQRnWQFsbQJVIinak7o8mBqUvQ7f6MDwSwBGgvTkQg/i94L7IYodxIWXuLMFRUWAJzDT/6VeMsWTMUpv4HAaJIWSy8+juZ36A/w4T8lvF77HKmUVDcpS1IxTyyFMOop9nTSbZrcCBN5sNKzKi2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278543; c=relaxed/simple;
	bh=QGuaoT80lQ197BGscNS2cN+eI7R7Nejl4nSuBMKlWuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zn0/iJTPEqit9Sbx1sPlzO3JcREI1gK81RqEFV/5zTTYWHLAeH/4pPGRiNmZYRY/ZSPBdqU/iybB97MYd/L+v55SjFeGwRwluwxu67lVF7aOVYMjkzjAmc2NRwA2wHUBAQcOrd443rzthcgNpdO3TO/OND5OmVAgh5Q7JMakDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GkSY2Cbm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4125df3c40aso9972865e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 09:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708278540; x=1708883340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jwy9iC4WTKT1uFaADgxrWX3f0a6goqe0ICnE41d6004=;
        b=GkSY2CbmvywlhXby1XK+kkvf/kANn5YccqyYEQBoUVjPkCsjCBBse3Pv6cACvtoNqw
         sbboOtGCP10Czgf4/tSFQgaIvWu21qQdAM6JVJ+uF38tnuoILvWIaYLL9l80nHCrGjQ9
         7ScC442OziK7BzTvTK21fuptCDZZEQIuQB6eW2Kg+A+C+XiztBv7vOStUfAMaSs+eUug
         OEWXTR55H+qt7cTEgWDN3HfQgx0JzF9EPNfP8q2WhIEEi/guS9MK12grJJGuqQAFwJIx
         vM0bN4ekKMEgSaJmaBhZVNegr0OR6kdI0Mpn1vkttThYLYXrtBSxMgoRM7CocJSx2RQ7
         vMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708278540; x=1708883340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwy9iC4WTKT1uFaADgxrWX3f0a6goqe0ICnE41d6004=;
        b=HWH8P9tE6f92Bp446rNhXHxHLJtn0yEAz4jhown3gd1bFT52+Mm+G2hXDEsnja5c5i
         8FqY1Sdjjb1MWKWgqu5UNYmRhBgOzfQQLq+Z7dgRlpTelL1XZX4aKQKz/kduP57ts1fl
         Xdnkhdw7kmdUyfvXbHBvbBnd/+eWmDSsUGvi33tV9dTMUOoJAWsaYRwxWb04ZyEVxSzz
         /uuEWNfGicXm0uifDRYj96nzsYPmTMbMj4rwOXwZ82mweL0rjK+AzJy4ZNoL0kCh9RPf
         hws7/29z/1RHtnORJCNONAJ1zigMbSlxdSirRiMnFiqGM2v037tBnmqIM4XkTLl4HjG7
         bGMg==
X-Forwarded-Encrypted: i=1; AJvYcCUCcltb21S93yarQc+uqOEjim1GUTniYOdJoMft9MY18o9jG74z3HQAoqedilOn4BJlx0vdIIYmJ/RDVN4n8nn3mwnLO9TBewE8DjXD
X-Gm-Message-State: AOJu0Yz3PrCSnzWL4d8CQ6Y/jwNmB93MLG18iDK+q4QCqirfJYP0MADu
	Jp71SbTB6/kw4QIdB0QyXy2Vq9bKj490imW8mwny5AtW3QnOkFil62G7hUAIY50=
X-Google-Smtp-Source: AGHT+IFB91Lh4f0o7uRc9xubnFUFG/XF/elm4IQjsRduQj4H04ei33E53yhoPNkNnzf/mjBeCwgibQ==
X-Received: by 2002:a05:600c:1e01:b0:412:5f1f:fd0e with SMTP id ay1-20020a05600c1e0100b004125f1ffd0emr2287133wmb.0.1708278540414;
        Sun, 18 Feb 2024 09:49:00 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1507:d496:5a75:7a77])
        by smtp.gmail.com with ESMTPSA id d2-20020adfef82000000b0033b75b39aebsm7920699wro.11.2024.02.18.09.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 09:49:00 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Xiaolei Wang <xiaolei.wang@windriver.com>
Subject: [PATCH] gpio: fix memory leak in gpiod_request_commit()
Date: Sun, 18 Feb 2024 18:48:53 +0100
Message-Id: <20240218174853.6492-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We now copy the label string directly in desc_set_label() so it must not
be done a second time in gpiod_request_commit().

Fixes: 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
Reported-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Closes: https://lore.kernel.org/all/20240217135255.1128716-1-xiaolei.wang@windriver.com/T/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e4dd13d81b4d..3c22920bd201 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2250,12 +2250,6 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags))
 		return -EBUSY;
 
-	if (label) {
-		label = kstrdup_const(label, GFP_KERNEL);
-		if (!label)
-			return -ENOMEM;
-	}
-
 	/* NOTE:  gpio_request() can be called in early boot,
 	 * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
 	 */
-- 
2.40.1


