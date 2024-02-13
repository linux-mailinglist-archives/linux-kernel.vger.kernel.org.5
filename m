Return-Path: <linux-kernel+bounces-63312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E932852D87
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17621C225B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36154225B2;
	Tue, 13 Feb 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bDqkAJ/A"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3122224E0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819019; cv=none; b=Bn4Ss/8i6z0c2gVHH7xDrELajSNf/qNZpFwsCW1IonLYtS7uJCE0qz2GLIID1Ib9oJ+GZagebdc4JgWYOJYbfE2Y/q1N/dqy/w9700q9NYR/aca410MUvCaXtADfjHbbcb0B6HtyxFd70fW6n1ejUPNI/FR6YhBGforxazZBJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819019; c=relaxed/simple;
	bh=V9cYulzfYb7FqDqY0/zGsr+wR7nxlESe3HrJDyaeXPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LNEjegZD9pWFTWrlNaZTgLhazuLU4dLJfbAvA4A3BPVrbEYChmwQDWl++2NoXsB6dYevkwYk72aGi3Wj3fR+bshsVINkm3JLR7TD8rccvhS0C0HCWDUe8zay8x+orkG/f+7oViVXQH/GiN3oN0m8wzOmUf5/BGLHKeMunYUovBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bDqkAJ/A; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ce20635baso34507f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707819015; x=1708423815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44veiaBqGMc5lNCdO5QoQ2ouGyAA43jz0m7IM734+yA=;
        b=bDqkAJ/AsLSjrUQYQ/6OacG8zS2NzmUaf9MZR+iwixyJipGF4pE9bqXDYiuZvvrlEe
         Nvh3/Dy29yPGUFbQlF1pa/xz6x/eJrgN3AinExf2GK05/21Ah9rrQ15VsmV1qqqaY5mH
         41VD90OVwA3OzAOfJriec228hOZqtabAyp8qOiqJDezCyoMacgU7xE2G9uwrCBmy630m
         TbfA/JVzrY2eQqVE+Gj1YXlUfD7QfMnCNQjh1GgOybiX/EIDPpcunOgVyZLTkZYT3Ky3
         rqHnSuVW6JpDCpz6kLhtY/eNfqdm5TChO6afqlenObRU3CAt/kpJujxViuSHOh4nnLKh
         E7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707819015; x=1708423815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44veiaBqGMc5lNCdO5QoQ2ouGyAA43jz0m7IM734+yA=;
        b=d3gwjVvafqbPVXplVu7A/lSxcIX40zzO2/WJdt/QZ3dkPRHGBza9lsrlHC+LCdiBOZ
         IY9mkqlV3BGYtAHvpalsfeUn/iihlde8sdTKh6bpDFKcDsuStOD1csXBVK3etzuvVrmt
         3IuaIQQ+H6Ma8Fybd6YaKP097jYtsrxR3JUwdij3nTQsapAXlApOxZjrRv+pf+TR7d3o
         xeQDK65tW1Dxf4lr1zVV4XHps40fPr7LF9nCJ0I63ZygOTJ6P7WDfPDVkPOCto16nqRH
         GdRVFHOQPUF1AvbL9anKjnNKmGBRq0KFg5FbBraD0nY8feuRYx/iqBsyhD5W3JJkeOyw
         AivQ==
X-Forwarded-Encrypted: i=1; AJvYcCW63eWnPITCqlFJspG1op28BRYVVoFTlpy2s6HZByNO7aRYUjnN1/Hydf0P9Xp3vZVD/LG/1uhfTIqSBuLEPyW8pa9+2z3dvWCJA+ZA
X-Gm-Message-State: AOJu0YzkQ42hoc4yG929JRJkkhLaUBbjU/mhXaXToaM9FhxPsmHvvveJ
	nohK3vOPl92YkEzUeXTZOh02idlPgiGLF5THJdJ3dU5VXo2F0YdpdJ8J789tXtE=
X-Google-Smtp-Source: AGHT+IF48kMd4o6kuMj09jog6IyBi+Fpq6HfXZ4TbeQ6YQ97bupfm6zbfhP0q4ah5kEaehBaGLLu3g==
X-Received: by 2002:adf:f848:0:b0:33c:def5:1802 with SMTP id d8-20020adff848000000b0033cdef51802mr480082wrq.6.1707819015226;
        Tue, 13 Feb 2024 02:10:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8nfdwr1JotIHXrpC1l20SNFZhNapHegZmkgo0W02sYWECeFAPSysM4xhrVCDGsVj36bD3gaPGz2PhaeeGyEZP6ns/cgTrrP/mKZK+TLjBREevGCmfy5hHYluDfV9VpFVGSpNATd5Be3/+es3EvZazOY/d1uupCG7kV9BvM5kCuPWbLb/3Uu2ucFRZl3sSzD2nDiWigZjpQMBq03NfO4W2JUk=
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f634:2e37:58a9:242a])
        by smtp.gmail.com with ESMTPSA id dd18-20020a0560001e9200b0033b3d28ef1fsm9075805wrb.65.2024.02.13.02.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 02:10:14 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: immutable branch with GPIO stubs for the reset subsystem
Date: Tue, 13 Feb 2024 11:10:00 +0100
Message-Id: <20240213101000.16700-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Philipp,

Please pull the following changes from the GPIO tree to accommodate
Krzysztof's reset-gpios patch series.

Thanks,
Bartosz

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-driver-h-stubs-for-v6.8-rc5

for you to fetch changes up to 2df8aa3cad407044f2febdbbdf220c6dae839c79:

  gpiolib: add gpio_device_get_label() stub for !GPIOLIB (2024-02-13 11:02:53 +0100)

----------------------------------------------------------------
Add missing stubs for new GPIO functions

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      gpiolib: add gpiod_to_gpio_device() stub for !GPIOLIB
      gpiolib: add gpio_device_get_base() stub for !GPIOLIB
      gpiolib: add gpio_device_get_label() stub for !GPIOLIB

 include/linux/gpio/driver.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

