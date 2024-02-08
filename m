Return-Path: <linux-kernel+bounces-57806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF1B84DD9C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6591F29C3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D7C76417;
	Thu,  8 Feb 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iSUzhEMF"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD563762F0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386386; cv=none; b=LJY0i9NksGHflG/5L2d1pd0Cv8LmV1xxEnvYpcxYrh9MtJVNsIhMn+NFstry8wvAOowKK3SGAz4vLfvRDru/9cCrR9m5vggYdoHSrVP//yAmX26I96zTjj75u01wVPHmmD80ZURSQqXRkSZWI+p4a4A3VdogRrAiqb/cYOR7qb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386386; c=relaxed/simple;
	bh=+tN3iUBilTm+njqjZxTAfaV9+rTCJ+mPdFLpKDG4Gzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPG5feN0JIAV16g90v9MeUGWmHVoSVsSZIxTg6HepD68JO+h9KbeI336JokrKpoXQ6lgjefw69X7tOF3B/s8SASjryh6hq/PJnHIq1wkxImO6uOqjvQ++7QtcqX+uw2KYkQK0l2iYKKVCEPw0IcEp2TJiiDnMxbQQUKQupt8KGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iSUzhEMF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33929364bdaso1070807f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386383; x=1707991183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2Hw6fcmS4ouu+tfkIaMvbg40PWFYNxx//+VN0hrkes=;
        b=iSUzhEMF+lLRq64cTfL55R5/TKFmWyyM/oe9d7lYqw7/6mMJ1hnqEddpjemv7R5l/s
         k6qB+an6SWre+wGjU0M7y3iFJW2WDOqUXfzwrliTjikA478w1Ib2lqRtMyRzXRz/vaeE
         gTbfvzhIRrPhBZcgITdVjIrp+6+8kVwMhvhbXF/D/rTFqZypw08dGQ0JOYJxdH2ZfX4W
         /VylmwbBoIdoZmhOLPnwR3qJbIYNHYVYqvhMTN61UO5SVY6B33N0QYsPkq5iI4av9+xq
         7Ug29DxPMzBFdkl2MxdGRhK6JHJE2c/ddBBm2/xks6jJRi6SUBt/HbDBuA/ckUftiDiR
         rzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386383; x=1707991183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2Hw6fcmS4ouu+tfkIaMvbg40PWFYNxx//+VN0hrkes=;
        b=DJ6dnXVIUVh94mrIaMirK6GVxc1tws4xAgaGyOL5K10+swmLwLBTD0um1OvZCMm9go
         6hnA0kpVyLiy5GUDvrfAZYKehEWUXye5hKVfa4uDHVWBrf7A0xYsfgaCvz0TAQgg7EN3
         hDrHfFTGXb1/kSlMCI0UoutIlMmW+Z/7is8AHd/GVBZEms3znFTMPff8/dly6Hpdkrmn
         amoOre7C8ZscQYDcOD2TOoXSsZVErREIqU3eHS4iUREHilE9p9FHPTB/BgkJHajnNXAl
         FRURCHnq63FNOTpZCNidrAy8KPoBnHsO4OAJkpK/9mIZ/h01ehQeHthsHaKw7SCDQRM5
         XkDQ==
X-Gm-Message-State: AOJu0YzSkuZn6ZpcLCs1NLJlqBjEtkO9DZjOLbi/o+QtH+BBz5jVVKUn
	3gWHD89d5eE3SlmhgePn8/KkvzAUI1/njVpMz30B6oLX2Ok3A/sy+elEP4MMiIM=
X-Google-Smtp-Source: AGHT+IHxH878oANm8oqm3qNTBZNgrE3JWNCMlIHJgpzSHPGM0IpvkFNHnUnvJvJzcQk8TXWW0xHhRA==
X-Received: by 2002:a5d:638f:0:b0:33a:e77c:89d with SMTP id p15-20020a5d638f000000b0033ae77c089dmr5809877wru.59.1707386383143;
        Thu, 08 Feb 2024 01:59:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrd10VfjCb+wIf2nuv8xBysAgfkYf0EClKNPFjUN8zFiY+AGI6auc9jkw6RNCjMrWpi80HULydspcubuu4ZVfyJvV6JxuPrUe5eb2qZmtVRMqnOxBFMrPWB3vB9vyVUiZzQ180TxTgxNLyGkepmS6+/XMfCOwdoXcr5J+CjsaDv1OdeRxSXtJF1OWJZxEZ1GvTbdbWP4BGx1OWEkYARt/tYDJZ7TvB/oiMPJGWBZmVJGUsBMBAHW+k+ZFu3z/C1NdCPR7zgBj4bmFHYGQYzKju8VA0Km3Rpc2zHtgVji4C8jB/ORbDhXe8QttyJF+EEN/C7LfCTIHzi7tmCrxycOup0tUTEApybw==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:42 -0800 (PST)
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
Subject: [PATCH v3 17/24] gpio: don't dereference gdev->chip in gpiochip_setup_dev()
Date: Thu,  8 Feb 2024 10:59:13 +0100
Message-Id: <20240208095920.8035-18-brgl@bgdev.pl>
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

We don't need to dereference gdev->chip in gpiochip_setup_dev() as at
the time it's called, the label in the associated struct gpio_device is
already set.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 939ae167244c..6598960b29de 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -723,7 +723,7 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
 		goto err_remove_device;
 
 	dev_dbg(&gdev->dev, "registered GPIOs %d to %d on %s\n", gdev->base,
-		gdev->base + gdev->ngpio - 1, gdev->chip->label ? : "generic");
+		gdev->base + gdev->ngpio - 1, gdev->label);
 
 	return 0;
 
-- 
2.40.1


