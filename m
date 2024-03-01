Return-Path: <linux-kernel+bounces-87993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00EB86DBE1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95DCF1F266A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5146931D;
	Fri,  1 Mar 2024 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXZVJOXQ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F08464;
	Fri,  1 Mar 2024 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277174; cv=none; b=ho9iMGl415anYWGD9L1wNB4k1XQqbV4badfm6lkvUyeHEvksPMXRGgbfkvhHYdX55apz4iLz0uK9UQgPbRF4dIw5XV+E+J/RwhmxLU0WJwB9bbSYnWm+TnyEZjNW9Ak2BcubZgAXc6RTZmT3wloz5nAZ/60HXWiUV10wUrZH8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277174; c=relaxed/simple;
	bh=9uiSy4dTTVVKUVtfFIsF/Vt0yKMVRoOUuJZeBj3Ntl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ia2ZTv3Q3mjplMb3iyJGqDr8EjovEtnN3M/kG/zcz62vbgttfFbugzgFicrHaoD1njNKWpAOPrdSEq8aXViDCJSRNbzKp1Aq8wJij/jYAvg6Gu+4DlCs503KuBvmm+lkrXBRXEDC9Rk0+MuzRfCzX0nju06dovhlHxHDKksDNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXZVJOXQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5656e5754ccso2376780a12.0;
        Thu, 29 Feb 2024 23:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709277170; x=1709881970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=daoZc8rNOYjMJp7aYD9N4lshpZj91qtWdsolMknYRzc=;
        b=DXZVJOXQS6vJ1v3uvSt/8NWwK7Jp/do5V4mC2yLp6OG8nNe5OJVYTRAPWOQD3dYhkH
         AbQst7cs33OGXRVhGHrQ5EMP8gHoevZjEbK8OWjMCHpyEOXmFtdQBUcvJLw/TMYfqg2u
         jiCgNR6k3XyIhiuEMO8okdD20wr6vXehl5PUCEX4gxZDM+hQf19X/yc6JjIRGP44rKnw
         DvFJ9i3gXieJe/sYnDe8aAEqG6cTUL100y69ulm7VEnLZTBINx5kKSnPbY+o3qvdHvpQ
         5D5Cg1QuC8buyeV6Sw/S6p+Q6tkIQs7MVOcWuHPC8sjpNN55wAruGBGJbIGcBoPBs0cZ
         aKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709277170; x=1709881970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daoZc8rNOYjMJp7aYD9N4lshpZj91qtWdsolMknYRzc=;
        b=cZaM/kFBH9fAocugfjnKcB6ft2Dnr7uL2PgEUAL77VlDNQJdHRsbyaen6N2LUVhYiJ
         OiytYNZRJgDd1KQs1bzrr1yWdEE1tnjelTlGOllZhiJazCJxXhhaBBIUDSmuAgbI4OD6
         nXSMgNYey5tJGtOiEibPu6JVIFGmzFcrSBnBOYzEdHmPvLtUbS3FCerLtmiceMpDk1/B
         dhyvqcFfyA9Pnrv7PsCpLpO/1Yxkzpu1yeYAkJkPemJZ6d7lRyu3lXhn9LLnd8oQPxdu
         i8mWhhPXp7aozmoAa1UcMIOYwbiHlpvDVWZanPobt0RioUnflXtIvLIfdeDIETOm5yBB
         c3IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFo5Akvs8slpMFoy9TfEidG7E2M8wlE/bw5sO1KLFW0sEZkyBiphudyubVtcR5+HFeQjF7qPwVy4oNmVtmFXm7f4udvlXsxhJdTQ40
X-Gm-Message-State: AOJu0YxbrofG8D5ghNjxoZJfB7n9W+Q7TJDkHM+VhYVWVuEaPUTNncbB
	zlaX35jwmvlsyO+L5j5JXYXA8hxqYiat34fC24mnw9LQqg+3EOoK
X-Google-Smtp-Source: AGHT+IE6uOeQ1kP5AVyLbKm33SDdFx3KDB+Gra10AJJ7ATRZn/o+NR3hkZGtt+cQDqWjwHFVxpJYjA==
X-Received: by 2002:a17:906:1107:b0:a44:4891:44d8 with SMTP id h7-20020a170906110700b00a44489144d8mr665016eja.70.1709277170320;
        Thu, 29 Feb 2024 23:12:50 -0800 (PST)
Received: from localhost.localdomain (IN-84-15-190-167.bitemobile.lt. [84.15.190.167])
        by smtp.gmail.com with ESMTPSA id cw10-20020a170907160a00b00a3e9ea356easm1422442ejd.125.2024.02.29.23.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 23:12:50 -0800 (PST)
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	u.kleine-koenig@pengutronix.de,
	andriy.shevchenko@linux.intel.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arturas Moskvinas <arturas.moskvinas@gmail.com>
Subject: [PATCH v3] gpio: 74x164: Enable output pins after registers are reset
Date: Fri,  1 Mar 2024 09:12:04 +0200
Message-ID: <20240301071203.5170-2-arturas.moskvinas@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chip outputs are enabled[1] before actual reset is performed[2] which might
cause pin output value to flip flop if previous pin value was set to 1.
Fix that behavior by making sure chip is fully reset before all outputs are
enabled.

Flip-flop can be noticed when module is removed and inserted again and one of
the pins was changed to 1 before removal. 100 microsecond flipping is
noticeable on oscilloscope (100khz SPI bus).

For a properly reset chip - output is enabled around 100 microseconds (on 100khz
SPI bus) later during probing process hence should be irrelevant behavioral
change.

Fixes: 7ebc194d0fd4 (gpio: 74x164: Introduce 'enable-gpios' property)
Link: https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74x164.c#L130 [1]
Link: https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74x164.c#L150 [2]
Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>

---
v2 -> v3
* Updated commit message to be imperatively moody
* Converted links to proper tags
* Added Fixes tag

v1 -> v2
* Updated commit message to contain more information why change is made.
---
 drivers/gpio/gpio-74x164.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index e00c33310517..753e7be039e4 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -127,8 +127,6 @@ static int gen_74x164_probe(struct spi_device *spi)
 	if (IS_ERR(chip->gpiod_oe))
 		return PTR_ERR(chip->gpiod_oe);
 
-	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
-
 	spi_set_drvdata(spi, chip);
 
 	chip->gpio_chip.label = spi->modalias;
@@ -153,6 +151,8 @@ static int gen_74x164_probe(struct spi_device *spi)
 		goto exit_destroy;
 	}
 
+	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
+
 	ret = gpiochip_add_data(&chip->gpio_chip, chip);
 	if (!ret)
 		return 0;

base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
-- 
2.44.0


