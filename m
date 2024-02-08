Return-Path: <linux-kernel+bounces-57809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6784DDA4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230B01F2A54D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D453A78B74;
	Thu,  8 Feb 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Oe2E0bfF"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EBD762ED
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386390; cv=none; b=r/GKvgjha0M5KIFUBQeXkNqFqXbBuhF/xtv//IQbDlybEDs1QqXIV7p5dFk3ldOkCL6IxWo1S4Ib7KErYGcaD4YRRCf02cr08RiQOi9X057wvKw4d/ilKUDUfcIKPfCvqB3lIvB8Sr19Y83O36eSPFrub3bmrzYuqvsZlI5zm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386390; c=relaxed/simple;
	bh=e2jA9sxoxDgk0Yo8yXFHQ5QmaZCOljQMxwcPvDfphck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q0/R37yEE6WtCfTwAowigKKal1rtk0+TuoATqmec/17s4bPMI4goKuJmGoBiQoHGsSQiez3+5oompVteEVTaujW+d01KlJ5bFyLlbnPSu1oiaGOkbpbvCNev77Yx6CDfUTJi+oWVvmCohPxG7lp36JLNFr9d8JV+Jc1sHqM2kFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Oe2E0bfF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5116ec49081so404570e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386385; x=1707991185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSvYY20bsG3YLQLtQqZAj4VIzY9NSOxs1N8eV9mNDzY=;
        b=Oe2E0bfFUX5flHJiOhsQBq0kz475M1E4K5M5ffAe+JKd8BsiRKbrOt/c7uW4B9BRFs
         3lymI8EAoXec+3gMwYB1H8IM88fZkcBoVhVqIL1ouhHhyuXksL26ztZeFqndRwKn752B
         /c64LydeA4e+sj8kVyjb8ZxvOboGrwvIiz7vJ6LV/OFnx18v1gOPQkwPlMvml+mpDrvb
         TPnc6vb8WbM/9Nx/aeZjnPP+5gGL8TcTV6H4Lut70s5OsHlthKFcEjg3RD7uPACSP2si
         lhtqAZAszSFBWgfrpExJyBZBBeS4mmCP4wllcYtKYfnMlQeNwRhBxX1FAr0A87yFThSE
         RmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386385; x=1707991185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSvYY20bsG3YLQLtQqZAj4VIzY9NSOxs1N8eV9mNDzY=;
        b=DP9/DPvMAACPkXhr0LWAwjt5033nLU/PV26vq9WhZjMzimAV/+e8PA4fMF95rhlsib
         feOoDOSL0CTnMIBCLFQy2i0inTfvopBq7C5l3GoA3s9qw+1DbeoRcBgEOJzC1reRpZdi
         1V2XDxVON8fY2s6Pv+b15bo6r4mFWtbmDlBz7zRW07RvQD4m2A+tL/wAMxVxSMGnFW9Z
         PpYVVp+yhTxM431Z1vV5hbRomle+Y/5PwhNcRuXUUCEaINqUtIBcZgViotYAl9YxcNS0
         QH60nld2HJWI8KtTaVL0DIHHP8EDF+L0N3g7k9iU0bz7aHOvH9GKoEfAPkY4PBRzXhJV
         qo4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFCNxdW2aH2dEv+4jS4YcI71irQHD5eT1TNrrWi4eBIT9xGK88NCpOsW3d9iin3O55iq97x2vw5GYr9MLxBN9nu1NUVh2LZ7PhBtsm
X-Gm-Message-State: AOJu0YzMDj2dAaJ3+UWckXqRGh4D5UNdM17l2e4OhkypSLsKvhYcKy0L
	7NXcYbW1I3MolyC7HEWBf5blMh0q3O0VTfo8AsIBhyX3Swkfr0sFA2EW3YzUpzU=
X-Google-Smtp-Source: AGHT+IF8x35m80ZdaG3qrPqZ/C9cTaIubJF0gdb+qsxnQfZwIEe4xWD3obLvRa9ccOLIRwkXcRwTuw==
X-Received: by 2002:ac2:5967:0:b0:511:69f8:c4be with SMTP id h7-20020ac25967000000b0051169f8c4bemr2183961lfp.22.1707386385122;
        Thu, 08 Feb 2024 01:59:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU242FHHxTbD2IudtNlQqDRyZKNE5NLu3La2edstf4JAjElG4i5brk5j01vhvsOtxlzRaTNwry9DNuDAOBPIpyQV9GzycjZHwxrIABamxg4dLG4HEhzKeX1Fof137wrFKN09eCvjvtvrswlI4YZZ+/dR+6Y7yb3Wu/81ZDktnpoAvaLM1TdWnsHR4CCsQJnOqB3Ksd1IMNPHE1DtYxorgZSOZhiQagSQSh3prJFwIdpPw2dk5bRLlUaNxlUGZTnQ2D6L8fl3QXK4Un+H5zlldG9dxOUgx7t0NdszXb5YVGBRGnbpx/y90e6VdiEe+DNPNe7cnhNFVN7W6mjtjmeYL/i4eXulsfHTA==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:44 -0800 (PST)
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
Subject: [PATCH v3 19/24] gpio: remove unnecessary checks from gpiod_to_chip()
Date: Thu,  8 Feb 2024 10:59:15 +0100
Message-Id: <20240208095920.8035-20-brgl@bgdev.pl>
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

We don't need to check the gdev pointer in struct gpio_desc - it's
always assigned and never cleared. It's also pointless to check
gdev->chip before we actually serialize access to it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9be7ec470cc0..140a44dec0be 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -214,7 +214,7 @@ EXPORT_SYMBOL_GPL(desc_to_gpio);
  */
 struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
 {
-	if (!desc || !desc->gdev)
+	if (!desc)
 		return NULL;
 	return desc->gdev->chip;
 }
@@ -3505,7 +3505,7 @@ int gpiod_to_irq(const struct gpio_desc *desc)
 	 * requires this function to not return zero on an invalid descriptor
 	 * but rather a negative error number.
 	 */
-	if (!desc || IS_ERR(desc) || !desc->gdev || !desc->gdev->chip)
+	if (!desc || IS_ERR(desc))
 		return -EINVAL;
 
 	gc = desc->gdev->chip;
-- 
2.40.1


