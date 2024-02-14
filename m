Return-Path: <linux-kernel+bounces-64877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C5A85442A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A86F1C2435D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFED879E1;
	Wed, 14 Feb 2024 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jenTWXeo"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4CC6119
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900267; cv=none; b=kH216RVWgXLku6DNy2JvpjP9yMdvSWfLMfGrSVKYxCjYXa5kbt84/784GM8/jQn1oX5cphVe0dIQeHAfhpBcTDlRrZuN8/ZivFXig4DiUNmQlzEAry8unBajADPELOYsR40XhoY2xhpOlZ5C8dHuVVX7FSoLmN4nAubsg01AXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900267; c=relaxed/simple;
	bh=vke7f3mLqY80iPgnYphdJxXUsg/yewlt1JSSwQTi6Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LK3MouA7TMK/Mruooldci89CVlRjTPZ6ttE0hzGdRZ80Md6CdAJiF9ZHP75HltdAzRmZtNu6NEEcjXjtPuBPpn4YFWdk7x0xWSOsazfSeBOxw67UVVmkFZjaximXQtPT8aWkbn7TEZUq8yDhoCwHUmWNv1Ij4xlVxG8CoMpXpOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jenTWXeo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ce55ab993so385614f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707900264; x=1708505064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFhXojJ7DlXYIGKFbQSUazUJNMfgGXQm2JYyxUYo77w=;
        b=jenTWXeo4DV9oaCUaaRKp2pzLkc+cHEacyh+YR7k9vSvAkYxVTCsEzfKTudo17CyHk
         B8f9shbC8/4/4L8KrzwMFQ8txCwXR05zy67Dv7BQ/vnReROPyys3Hr62erj7kdNDPIfZ
         MNxEvS8OreD95VxRgSTOqtgEiV69xMEEgTb5gKqvtGobY0izqorqdNMuA6Iwu14ZzJbL
         LOlmvGGdEc5svoV3VETX66XRa+PMjn6CZW8ZqqAVxykjjg16H1esDpBQgL6yn8UJpp1k
         24AyIOrLY9DvJdnlZPmnx4TjRUcD5OkwLASF9LZI/ew1ACo80tLBNcbk6095pWGEe2XI
         Bx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900264; x=1708505064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFhXojJ7DlXYIGKFbQSUazUJNMfgGXQm2JYyxUYo77w=;
        b=V2Y+d0OO5CdFOiyf9mx0HKzLtRA27PNogxGlf+WC3S/rLkTT50uS4gXRjt7oeeJ/2D
         ZAp3GZwYVrV63Vd1gQBIACsL3bHei3khUbfIalB81j8kAj5kBdOze18skaGPo5W0Sr8Q
         UjJJ9rL1pbenk3jJ5tFkgVxJpbi5D/drSVb2n8EJ/6/WH+1umuzDyk5CPZwQfbXcA4IW
         9gUffqJ4ig4ugsLjQnNYLBKK1IblisCUYxIPoWGni0fW5xalmauh1PfOhV+UAYB0m+o2
         9OYK2dKgpdCsfzHugiRLGEGMya9csaZW52qVPMa0MJEqWgIfTiurBnhFs/8ul0XCty6Q
         cm9A==
X-Forwarded-Encrypted: i=1; AJvYcCVLBResVIoCseWFo3Lb/3Zwi6RBL9x+eznGrZjNzAwJ6nyoVVT8eSUNj/DczUxwSTnTcfQAI6J0BJLeT4M0eujZ2R0hkr65ieRy0tHd
X-Gm-Message-State: AOJu0Yznt+XYm9EUFw1Jxj1ZQTk5s9hX/Bxd+KmCvQSKG/PtN7747rwG
	Jo+6Y5R3rLevMdPvNE8426Ao3j59qwhlrQVuvy5zo1QIui1jKTx4pkftU++thI4=
X-Google-Smtp-Source: AGHT+IFxVOr2z8lh02p1KypI83zJK641TmMZKxXM0gQR0S7z8ej1eJxPwM4bGrmcDVHicTcjK0kCgQ==
X-Received: by 2002:adf:f3c5:0:b0:33c:cfc5:5ff1 with SMTP id g5-20020adff3c5000000b0033ccfc55ff1mr1185222wrp.65.1707900263847;
        Wed, 14 Feb 2024 00:44:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdJ4z9AjPLf2LNcKSfUHNX/4gUscA5BP0k1QLWWNrl4ulc4N73hAaTqVofvZt6sKOB1BXOp39wp7SKvB0yt8pt6aFxV+Y3ztAMSHp89eA8tzlPacuKog7KxkLe2kIIn3leLdMfNrToRVM8w5xp4cqMZq4ow7l7cyC6TtBKB2uL9DoRLmG2VwMHSOuyW36eEsdoM3sgUMAE9io4i7h7Mzoh2zmVz3D1ZRJYZI/HARByZoM+ZJdC3e3tZB3NaCSnusFYiiOuhMCXBl7gLIQp/gZ1y7XCZswK/dbRxCBCCKS7ULEVT3b1d/kDGvqH5XeUPfx1zzLrD7hejdDOcdSGw3TvwoTnrKFdN3vX1EmKtsqOI0aQdiwRN5f2S6ClCH+0fC290UK8gKuBjMxlMVSsgsTCGxVb8mQ13IfCeIA7
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:cfee:a5b6:1f9b:9c9b])
        by smtp.gmail.com with ESMTPSA id fa1-20020a056000258100b0033b79d385f6sm9494731wrb.47.2024.02.14.00.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:44:23 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Mark Brown <broonie@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 1/4] gpio: take the SRCU read lock in gpiod_hog()
Date: Wed, 14 Feb 2024 09:44:16 +0100
Message-Id: <20240214084419.6194-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240214084419.6194-1-brgl@bgdev.pl>
References: <20240214084419.6194-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

gpiod_hog() may be called without the gpio_device SRCU read lock taken
so we need to do it here as well. It's alright if someone else is
already holding the lock as SRCU read critical sections can be nested.

Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202402122234.d85cca9b-lkp@intel.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f5434e559382..439d32d5aa38 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4492,24 +4492,27 @@ EXPORT_SYMBOL_GPL(gpiod_get_index_optional);
 int gpiod_hog(struct gpio_desc *desc, const char *name,
 	      unsigned long lflags, enum gpiod_flags dflags)
 {
-	struct gpio_chip *gc;
+	struct gpio_device *gdev = desc->gdev;
 	struct gpio_desc *local_desc;
 	int hwnum;
 	int ret;
 
+	CLASS(gpio_chip_guard, guard)(desc);
+	if (!guard.gc)
+		return -ENODEV;
+
 	if (test_and_set_bit(FLAG_IS_HOGGED, &desc->flags))
 		return 0;
 
-	gc = gpiod_to_chip(desc);
 	hwnum = gpio_chip_hwgpio(desc);
 
-	local_desc = gpiochip_request_own_desc(gc, hwnum, name,
+	local_desc = gpiochip_request_own_desc(guard.gc, hwnum, name,
 					       lflags, dflags);
 	if (IS_ERR(local_desc)) {
 		clear_bit(FLAG_IS_HOGGED, &desc->flags);
 		ret = PTR_ERR(local_desc);
 		pr_err("requesting hog GPIO %s (chip %s, offset %d) failed, %d\n",
-		       name, gc->label, hwnum, ret);
+		       name, gdev->label, hwnum, ret);
 		return ret;
 	}
 
-- 
2.40.1


