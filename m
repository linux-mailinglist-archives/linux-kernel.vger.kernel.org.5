Return-Path: <linux-kernel+bounces-57804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D153184DD9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FECF1C27B77
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDC4763F5;
	Thu,  8 Feb 2024 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VpKDgCwX"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA473181
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386385; cv=none; b=tjLXKJb1g2C7fejZMGGBmw7FmYcgwVPLg1dUDsvaaJm1noCupBskj8N4/iki+uiPZcGlmD15xfyKCU6fQT6TiSiHmtA6f/QUSWzPmm9Z57KrGXEQ6e5LQmqb0b4ssN1P9T7V+HNtUxru6QvOS2AnBcz11ZA6jl+XSAqhD3A/Bbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386385; c=relaxed/simple;
	bh=uoIIVRHu2uJkO9SDw8JuUKRoDUO7ImNaDoq5Rnmn41o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qvVKAHFPeG5jV1ODtW2n9ryFNo/HZX4CJUy/DYLlIJFt8oaUEt8n6sUJQc5yzkbzHzCcyQJzSmHotdKsVO+5MsLpWKv/GSW8lwn1QYCZdjGGpLRe4LHqK1l8ZLvSmIZVPjI6NF1iAN5ennnFjEGlRl40vl25od+8Xl4UQHVU/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VpKDgCwX; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51171c9f4c0so149412e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386381; x=1707991181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7MTTS1PPnO0o443gYifMTGiFsAoLhFBJ+RUlJK1fWQ=;
        b=VpKDgCwX+M4IUPcwf2nQjfRyJJcu1cazURmoDWk1mMnZHQ2rpjSoT3j/8MaeVLRzI6
         wuuJGz//079pwkH+IaIIGmGkvXEFvuUTO3mgCEDo5WENUffd8Q1lB1Bfr6jLIlepgryE
         hpPkhHZipoRb+nC+7jhB2A4biHaJPoDm9ce2W9DwpE37Ci+bJDnfqDIkV9Czf+clY7ei
         hLGYVCbRJoj8moCqPp4zTJB436EUBRc97+9Kk3qGaM4sYz8+xx7wEJG5sRYsna9kI1Kg
         X2qDvzJPfmxfssmjsMGbDCofQR5DcRbOkhzSUP6aJJC1KOnOl7uJ8CcfjUUqsGSG/SUd
         9Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386381; x=1707991181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7MTTS1PPnO0o443gYifMTGiFsAoLhFBJ+RUlJK1fWQ=;
        b=Cv0ImSr7yhGtiNkGxFAyDrwvYs+VniKXs8YvVjkxWkyCub2rlOO8tQEiKe9gUAVB/2
         IECd+CfTVMTeco7TQ0MgBwRkgY7RHXYBN2uHyRuTngwcAR/DU8ZNZIEk5I9kqF51T7bV
         bLIJfpmOd3jznn+wHMZehMR6ulkKbQ02aKNoT/p5emN5CpucyW+Y6SxKMMFzQBkX0QSM
         hgFkHICljAdEEeOvAePZFwSeuHGwd7sdOKSaFZMSneomrmCFauL8Y3k0IFCenqLBATp1
         4YWdMK2irhDtIiN1D0wd3w6Uc+3GGfEOkwi7BHXWzmmI+SKPGdEcdyzJF6dYW9wfyXum
         Bhew==
X-Gm-Message-State: AOJu0YzVAmtMbqjapVYkAljwnv0kTz27DfG7F6PclkpoQGUQZwjYF9M4
	BUKvLC4rIlsC30k4EevD2cwb0bcreusYRVpo2JD/VqqNjD+twvHry0int5Eluws=
X-Google-Smtp-Source: AGHT+IHNTKOLEHtsygIf2IrvhbWXAtgHLghUVOVCI/1G3Nr6yFdQZvPMiH4x1NBVHikMTpuFF9OBug==
X-Received: by 2002:ac2:5ec4:0:b0:511:4f19:f45b with SMTP id d4-20020ac25ec4000000b005114f19f45bmr5806486lfq.41.1707386381267;
        Thu, 08 Feb 2024 01:59:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfobfX7jRLlpRS5c8qTily6lghNl4/F63UQYOHOIcnviy1d/ZvQ/8OGvHJqPFMyPUow7ZFPnk8g+HphKSds9wHgBuzdhRM7MQjIs+njTpKknGNHf2oeBr3QOFySE717hxvdonMRtXJEAn2AK5sQSkm1b7iy9S2r8r+Wmb2AMrrLw+qZhEuhvWa9ztdg1y1vlK1TP2IH2NcRyaF7PNGeiQ+toPF/uFuc13tJxPSAh6+9o5XF6d3nqNSMDUawV4VDZFYNyGNWaZ3+nbEhDzJBLvCvUrA22nM27PNLb35j+E8m1neG9pEK539SYo+Fys3xAFh1YUxQ3D6ppt8gqG/HIWvmPM43pb3tQ==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:40 -0800 (PST)
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
Subject: [PATCH v3 15/24] gpio: cdev: don't access gdev->chip if it's not needed
Date: Thu,  8 Feb 2024 10:59:11 +0100
Message-Id: <20240208095920.8035-16-brgl@bgdev.pl>
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


