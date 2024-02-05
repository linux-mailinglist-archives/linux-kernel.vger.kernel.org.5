Return-Path: <linux-kernel+bounces-52320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3DF8496B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902F81F2139E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940A18057;
	Mon,  5 Feb 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eRPX0c9M"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65E175BD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125682; cv=none; b=nb0rmzFLieFFSifOz+vZ1bLFzyzrqYiwd+zOYJKjXPcFpNB4wc0VBgC0qh69JGiXCgwqXyzWGfrKTNCcv3ptTNo6KNhXA8ddhemullRmuh3P9xKOlAStIkzhHKpJBTHu1vyjtuVIWgtza2s3sts7r/S4MPsnJoawskeBbeH/GXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125682; c=relaxed/simple;
	bh=uoIIVRHu2uJkO9SDw8JuUKRoDUO7ImNaDoq5Rnmn41o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O0gwnn05Yr2Cd0VMi9u4dq4C6FnYG0GsNbf0SjzNfLUanKYwzLQKQFvsXsI9FV9NKTibbrGCNWx4GA5bF3YG3nW8ywAm2wlT0pb5ZdpsN3P9webGKuBTQJ4Mwn8spj8eGJ3ppnP6Seyq0I+fMf/17eVKJPBiex0qeK/1Oz1y40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eRPX0c9M; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fdddbb8b1so1367895e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707125679; x=1707730479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7MTTS1PPnO0o443gYifMTGiFsAoLhFBJ+RUlJK1fWQ=;
        b=eRPX0c9MNcy97yyAx1T3uuLCXlNIgW9umvNP3JhanCUCB1ORc6hZmoE4j4VBXHBl61
         QfTTY0QSEZk1sZo04yahG682FzVsHoYDCTUDYaLN+D5OD2vwPIiNhJZ9ehaAfr1mzyiS
         +9JeBPn4dsLYfjl3l1FeXi7MzJIhiAyLgg3WG87xJC+DIBDkbSobelhLhDVuqq6RMt2Y
         LTb8y2UJxm6U+fA2Kp2ZWHCGMUTZZvb5JV9PIIws4DQUYqsoczTHGRW+wse8JdUea2Rp
         r52zpDBL1zCO5O7rIRbEQIKeGjXVvZbBCc54eF+3VSrD/R+N4TErYzBd0GDNQt4nlec9
         qDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125679; x=1707730479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7MTTS1PPnO0o443gYifMTGiFsAoLhFBJ+RUlJK1fWQ=;
        b=a0EiU7LnZ/YIOs5O/xU6As7Vf7NfsMJ90R0TgC41Ldqlk7NZzrnyPzXAepTP9heAqf
         W07hy5G9+UvWf6IAtxgQINTYyCqqvD0uai8B/N2r0rzwbTT6r1Y/qw4e2OFAuTmhb9Md
         mfB5oQr2336ioMctW9NwGnPHXRJoAp2mOUGKwLuIMBCPBHCHsNRd3Q6Atz/bPgpBYDaS
         1+Ta32Ef16DIkUo+ZHQULczx8l61Ko9Vh1KZ3a8UQ7zqd6q8rP27mMG60YWPeTFUZH43
         WjNivfLwK7i4M2xWPhHbm/jT7uQldzdeUBTL8FJFLPkRDiSJv+s9lY26Xqb/Bt0gS95y
         UUaA==
X-Gm-Message-State: AOJu0YyBTAIaUAYk6MdOcuqEPnzTtJhrF+OhPQT1I49cqiS1UYya7qTe
	nTzfkEfdmmH3fzrBRjCwihfnq/GWO02tCewRP3m2YbGy4fwRmMqutTxRyrix7PM=
X-Google-Smtp-Source: AGHT+IHKLS0m+gznRf7m4ewPz3qFdhpDGi5EcMyBvF51DPL4JncZsFuDNPywxKAWz7AcWuaFKKPy5Q==
X-Received: by 2002:a05:600c:3b8f:b0:40f:d300:eaee with SMTP id n15-20020a05600c3b8f00b0040fd300eaeemr3235595wms.18.1707125679171;
        Mon, 05 Feb 2024 01:34:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXk7jaHjyRYsWkas0qWxQz/p3VQlAB7wKkG3+H6aFffc0ZmUGc1mt2/MfkUsz8Rf2/Q8fg+IP+u+KOSZFVjcbZd41sFlOvG/LFG7+IfiSfCYl136RixMsIEjs7hx1WuZjlzS0mdKqu/Skua9azLfhDNsYG3ELAcIYsMjJ2F1OOh4JkFDM8RdYuCCTLN9RErlSNBrAFviOMuYXWHMQntIGUGsdAPanN+Z7YECyg6jof8/C3OeiGS+O0I1WZaysma0zL4OWC6t5OOyOoWiCMKccl0fu2F//eExMctaZdRs7oZzE0+7UFn5sZzqFFS2xjmWPUpLUG0cuH459GqklTK/HP1n2aOpI9vjQ==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b0040fc771c864sm7980397wmg.14.2024.02.05.01.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:34:38 -0800 (PST)
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
Subject: [PATCH v2 15/23] gpio: cdev: don't access gdev->chip if it's not needed
Date: Mon,  5 Feb 2024 10:34:10 +0100
Message-Id: <20240205093418.39755-16-brgl@bgdev.pl>
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

The variable holding the number of GPIO lines is duplicated in GPIO
device so read it instead of unnecessarily dereferencing the chip
pointer.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 8e37e3befa08..e993c6a7215a 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2701,7 +2701,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	if (!cdev)
 		return -ENODEV;
 
-	cdev->watched_lines = bitmap_zalloc(gdev->chip->ngpio, GFP_KERNEL);
+	cdev->watched_lines = bitmap_zalloc(gdev->ngpio, GFP_KERNEL);
 	if (!cdev->watched_lines)
 		goto out_free_cdev;
 
-- 
2.40.1


