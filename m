Return-Path: <linux-kernel+bounces-57801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B944284DD93
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7682F2895CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CB974E27;
	Thu,  8 Feb 2024 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WyJCJQpv"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713B6F52A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386381; cv=none; b=UFxD1eIKwgxiwmquHXv/gUIpSmoMMyAeNblKNj6HiWi0YQFh9GSm1t5EpanAb4L08Q1ssJABQkcH8LDmdq/A0uHfve2bU1x0QtR2qIJKK4jRVJiF/e1MIkCTm5bSyqXmZEmxPYcyBN7lTcqGg0BPWgdDRHmr4OoXV7/VkhoCIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386381; c=relaxed/simple;
	bh=rpFcXuoa7XEKWGrXP4ohioPaux3+8YRMAEzyUwG0HNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VOsOfk6+hD5GxYMW54dJf58qJxiY4xKfXBYVzz0H7ql5ma3YLVQjYkyNva7oeeLRkbtggfFZkmyIq7gdcvyPLZKFIYXtvhipqg1rOJX90UDpnm/Knoa0/39vP8F2aYIV/RgxvrytZKCRzMWXeRtnkStgXO8NUfXQlGhDuurwFz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WyJCJQpv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b58ddefd3so285535f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386378; x=1707991178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neaBFQruxVCvpnyb2xKS7yjOVX4paD5qlj8wJKLSUU4=;
        b=WyJCJQpveKpvfVnQ5i0/55XAJZn/fJedelS35oAVVgIuawGEpoaOlbBSVGKgV/CbIe
         Vw3tp6uRE0Qb7A0nBU+hiGGb8ScEzRcB9sdxckoufLQETzC/ylA1PS/Nm6aNYvJwNMHd
         yBuM4k0g6p0RHKkMZFnyw9uadXfHkgtL2YtnUYAsSSFQSffTh+qRLUhtr2CaV3NIHFYJ
         gBblmJHbEFyHlg4uwkn1xaxrjr4aRkuhIDuNiwL4pDRLdiQLdegel4g0FED0tuvhwtwf
         Xmj1uSolhprMurv8qBFrPUbXXlmEmvsFRMGCidRP3Z8so/yJSVhSSalWbDQ+XrfYQDcn
         X8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386378; x=1707991178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neaBFQruxVCvpnyb2xKS7yjOVX4paD5qlj8wJKLSUU4=;
        b=C3W2SAw1jtbA33LR6WUJwSImEsR4hDkjUU4X+lL0WQCdLYrHhUAhUA6YrvrBh1BrjB
         xsJDgFvLVMzDs4Ca2g7XuQ1fJmocNPNaUSGduh+Xk7+jr1Z7WfF3QcWe+BTRQQ5PCJIB
         OGMtoIXvzeX5i8RxXlFAAOmo4ycI+UcdZcSbCsKtUOKzYlbVAVext2WcqerCyG2eVa8e
         +FmNtVIO84+P80sp0SNW0T3xY5y1ts6iz4V9q2Mu7vdwZ89h/ixVa3ww00xSjkIswykn
         MVLwCY/17ypEeNTKuKzRl9LF5afZMemeucrs+hINpqXpGPqnCF1dDXJSoWfVh+AFJKDo
         V+cw==
X-Gm-Message-State: AOJu0Yy0zzkXSubFnKtBxxHSAzsdhOa3YYKldTjGU6uIQdujUBfm//d5
	NZieP7nO0JLt2nGpymOWP/jPWGYlocMJrkCEG012NzEgcTLjm9yzxcy3UfejeCM=
X-Google-Smtp-Source: AGHT+IG5jjUfQYqv8znpCpV5fwqXcxf1zcotF07Cq8PbCeS4wyDBbWS19Fu1H0O0M9nxqnNYUZPQ6w==
X-Received: by 2002:a5d:6651:0:b0:33b:1a71:a8ef with SMTP id f17-20020a5d6651000000b0033b1a71a8efmr5180258wrw.26.1707386378172;
        Thu, 08 Feb 2024 01:59:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4ST4VWVARTxh1vhyL+FYq91ffSkWIvf/1bkmhFgsy+vx6xsriKtI97qtYme/BPcerdpi/CirADryYQaFPFVCUhzKmZIgTbsYyJ4pOUDvix5hq2SXz2Cw/DzajqtVLr1ymDaSVkA5ckKgeiAv5Duzjps/gQgpx+TGMSf2qV7/Acx4O8RN0DimP947K085ktak2dW9XXjbzvlKilQnDp7z/TPd1kNQsyGHAI6dwuE/OuwVZ8r7stfYQqu+9abynimPqh2JjR2wxYEeVMp7BdNKVeEMrTYvgnmzqK6VVkNQml0n9QzlRTvGYt6+iNSsbTBYjgxerTdpM7pBPzdNkDgaBxDZ7ae9U4w==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:37 -0800 (PST)
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
Subject: [PATCH v3 12/24] gpio: sysfs: extend the critical section for unregistering sysfs devices
Date: Thu,  8 Feb 2024 10:59:08 +0100
Message-Id: <20240208095920.8035-13-brgl@bgdev.pl>
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

Checking the gdev->mockdev pointer for NULL must be part of the critical
section.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 3fe740b7d84d..fce4ef9754af 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/init.h>
@@ -768,15 +769,15 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 	struct gpio_desc *desc;
 	struct gpio_chip *chip = gdev->chip;
 
-	if (!gdev->mockdev)
-		return;
+	scoped_guard(mutex, &sysfs_lock) {
+		if (!gdev->mockdev)
+			return;
 
-	device_unregister(gdev->mockdev);
+		device_unregister(gdev->mockdev);
 
-	/* prevent further gpiod exports */
-	mutex_lock(&sysfs_lock);
-	gdev->mockdev = NULL;
-	mutex_unlock(&sysfs_lock);
+		/* prevent further gpiod exports */
+		gdev->mockdev = NULL;
+	}
 
 	/* unregister gpiod class devices owned by sysfs */
 	for_each_gpio_desc_with_flag(chip, desc, FLAG_SYSFS) {
-- 
2.40.1


