Return-Path: <linux-kernel+bounces-133443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C396189A3C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C251C21C10
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAAC171E60;
	Fri,  5 Apr 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pedXjZ2M"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228217109C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339889; cv=none; b=IQOYsTAIQRoCGFAJP+IVnBCVcKfARt+LKai+kTHUajtx5j5IA79N14m0xj237gcgYAJVeq+cED2Me5ninBWvGFKHMqzbgEl1U5MWAG/zPDmX8vFR3V2CZEQqTn1rdi81WRROrkhNXhvWC+f9W8IXJFWEk+IbLMBVtLLV0tXzAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339889; c=relaxed/simple;
	bh=H5myzdzWlAUjMb0ryKASPnq9blH7D7/mKRGJPIfwGpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u2ksVbYCE88BBwc/OoRRDWzAABC8iluqKh1jV37BrOrAw3VorQueRuZs99suzIouE6C7B+r5NqVPc8DzdmA7zrCapr4nO0LE0MKSv5I2fmSl0jCuMqitHRxR39Nlz0rpRH27FDvg4XrPCjFfL/YgdSuw6Rm34d3jPTaz3tUyNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pedXjZ2M; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3436b096690so2700181f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712339886; x=1712944686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ztjXdzKTe7iNLjYo+NbZK1lY+kuiMYYFbOMFrJcZmo=;
        b=pedXjZ2MdLWhv7xbCIKiDIX8vsqkgiTSbg7GqCfdXh2ObZTwYxtr3e6iEBXt33jSoM
         UOrVSU9PN17FvAkFt0pL8ndDIcQ0d5lWqEMaIzjhoPVNWUzdwA81tidNzI0C2P3V1Fdb
         +m+SuIZvbNE5DlpVmGJh+viX42Xi4u4wemVAErJZnJqoopyU/wB3POYqgMHBbFBWnTEf
         Yc/j3CHzvkDIns3AQIRwwDHk7WOjEUqnTjxHKAf1KyvhkZpdQpbb5nPVzLKIXCVgrvHO
         dW/XI912r9fNGEDHblxb7waLNqyDe/dSfl206YombG+1W1y1nf6sP9VnThaDVLBC+8ey
         qc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712339886; x=1712944686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ztjXdzKTe7iNLjYo+NbZK1lY+kuiMYYFbOMFrJcZmo=;
        b=pbDtcDOxIqi0sHRar67Oy35WT8Jg7TZRURBbhsuCdZAVd1GFkAWHscsWTmc7lDRAiT
         OteZSpZDlooKcwJVoZy637BBATazdYXVYuE5+5BITa6T7lIn1AznXWHSs/10XvYbsudh
         fZD+jmbqvKvx4qXJap8mVUWbbsOykiiofvASlIiUrB96usbscGMw4FcicUDWk1j92F6j
         AbqZoaJXpxHhWG9G4cKCwkKHfQyd4vIPkZbIKvvzm1Do/OyT/FymAtJPPFUh+MaR2oMy
         2mgw7zDAa8NkqX778f2bTTQiF+9sTpR5knpBlj9V5pFE9x1g7fdaMtHpCDdGraxzqiRI
         Iz6w==
X-Forwarded-Encrypted: i=1; AJvYcCWBg08S0wWGZWDIFmkNVLKTcIFHpL/xAt5Pkl7FOm3/8DSsIQUnmhnEhA1WyYOVpE2fJ9eRWFm7qlS09h/kMcjZHVksTg61sxRG64r1
X-Gm-Message-State: AOJu0Yy0GXhOVEfmY5lgDmJuF4lap0tQOsmbB6QdMPq9FPKHW3Lc0GeW
	7ocSbw7kBMFOEUIqjbbDhBesZjuvKISSbXgOXOUHeLB2eVwm9vSK/ejWjzlJls4=
X-Google-Smtp-Source: AGHT+IHaJgnTg1DBtlEDDj3TVd5kmqS8br+lAv+XxhzDWvToD9+k2Q+EpCTODpJ+VbsAPWrNjfmrZw==
X-Received: by 2002:adf:e9c4:0:b0:343:dde1:2ef6 with SMTP id l4-20020adfe9c4000000b00343dde12ef6mr2790199wrn.27.1712339885553;
        Fri, 05 Apr 2024 10:58:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:1a1:8979:15bd:93f0])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d4c8f000000b00343daeddcb2sm2534668wrs.45.2024.04.05.10.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 10:58:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.9-rc3
Date: Fri,  5 Apr 2024 19:58:03 +0200
Message-Id: <20240405175803.299328-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of fixes for the next RC. Details are in
the signed tag as usual.

Thanks,
Bartosz

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.9-rc3

for you to fetch changes up to 83092341e15d0dfee1caa8dc502f66c815ccd78a:

  gpio: cdev: fix missed label sanitizing in debounce_setup() (2024-04-04 18:57:08 +0200)

----------------------------------------------------------------
gpio fixes for v6.9-rc3

- make sure GPIO devices are registered with the subsystem before trying
  to return them to a caller of gpio_device_find()
- fix two issues with incorrect sanitization of the interrupt labels

----------------------------------------------------------------
Bartosz Golaszewski (1):
      gpio: cdev: check for NULL labels when sanitizing them for irqs

Hans de Goede (1):
      gpiolib: Fix triggering "kobject: 'gpiochipX' is not initialized, yet" kobject_get() errors

Kent Gibson (1):
      gpio: cdev: fix missed label sanitizing in debounce_setup()

 drivers/gpio/gpiolib-cdev.c | 48 ++++++++++++++++++++++++++++++---------------
 drivers/gpio/gpiolib.c      |  3 +++
 2 files changed, 35 insertions(+), 16 deletions(-)

