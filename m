Return-Path: <linux-kernel+bounces-52323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD2C8496B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F901C24FE1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1041B5BB;
	Mon,  5 Feb 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yndcTLQ0"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C891864D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125685; cv=none; b=OJNcDYW0+mw2p2iov7BBbGKoojIDxNF3PhygNwrbCdU5sYGD/sp1DSdiY9OMqIQE+Lulqs0nC4dptjfs4dG6gb66r2skHL1Qs0eJ5cpaoLXaYdtKsS2FERegRMX2KOC78rZBp02+Y21ZrPE73Ks3UTecfctO9Bjy0aWChl7kyeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125685; c=relaxed/simple;
	bh=pEGFI4FzSuM9h9FPQ1IrcofNm0GzKPkH6oHp6XPXvQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AawZvSYMZstW6AeXS5GB8f8HReo21XU3U7bao9GUGs8URXU7mx594xGiuNQ7MmPeqciq8ZsE0Ivp/03prEY/6nmw1hhlGBV4MIwQA4D6QBZuBCSjM9BXYkpwoqKgyZxFRGFIKArUAXzKOdI6PVufz2wbH1MUY8BL58AE7h5lYqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yndcTLQ0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fdd65a9cfso2784395e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707125682; x=1707730482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooFRRocehP/GMHGdd997Hq+dPT1Zk15K+dtqhfO9BRA=;
        b=yndcTLQ0J+XMpWeWrTV69r+9Jv7+XpYXtiJ+SizmO2PPad0aPD8ZHtd+SanHbaquam
         fW+EhxZHfBFO9+guedt4pzkoiDJXzOdPlC6Jz1xKRV7MdX7XrYbcNWwwuRKqD3jbGZHn
         WN4mnGLU4Fc7XqGucb/QtVpnghKEQ5oTb46cvharxyDZaBQpt+maLDSsl8CTDTeVvfxQ
         YmIEAHFvKvsFvjJWbCwUJqGSS+Tc6WZ/vug0+IFOB/XAT5MNFUgKRURMEN8acDiTCdLB
         oOcifWTRzVANKBC78/KfXIo0ehGvrapQzeRrG0ACHu0B3qEW1o+GjsguR37W23D+OdHP
         T4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125682; x=1707730482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooFRRocehP/GMHGdd997Hq+dPT1Zk15K+dtqhfO9BRA=;
        b=QWJBvqOrj7cWmkal+Q6zM0c3EBIgwd6ihxrAza6IeWs4yIS+VPt8p36H2Cbj+5ktjG
         7hnZgeB3i2OUIu7ru8/Ju9dXwCZY/cSNzlmU8P9sqQpV/FjFXVBIbcBVIFMNpaIAhmTD
         LNapvn2DnoEPe9X/1elBO2hk6Sds5RjxuTCMDscAAl0L65+YM0SblEsRcFgEqHgym8KN
         b2SGcF1ststMdbDM4lVAkAPo5gqmkAR3pd8Hi8enXs7ZF43ePtGaAGjzc1lr61nqN4fQ
         tFW6uDiT23s8SYWDPgQAn6lIig13vwmS4DIBfJrtyoDd2Sp9zpOVuxPXGX/Y/N2L2oma
         vMdw==
X-Gm-Message-State: AOJu0YxR5NL1Pz1qgG/3EgnCdxSnWqXSxf1C/QLru2d0HuQ6hOCN3Qnr
	TdG8sOwbW7iYnP4F+I8ppQmTxV8dbIzg30DFp71Zq/YHbhsy+EtbuLpJtz1/Cjo=
X-Google-Smtp-Source: AGHT+IFhcLgkx8KHMiKDvuZqNmGC8eNgjwJXoKIcgWEf6Qq0l9U2BDTDNM+uWBEonFwKj2EUg30Mww==
X-Received: by 2002:a05:600c:468a:b0:40f:d738:c213 with SMTP id p10-20020a05600c468a00b0040fd738c213mr2655782wmo.29.1707125681808;
        Mon, 05 Feb 2024 01:34:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVeChOtUDPQKIzjVR3gHFJwm13T5fUfp2EvjfPDa0WJAsGA4ulrpHbHNP3ClsXHPf9p/pjCSdJ9BDfYItHn2ag2YYMH9PdOge/KVOSeui5uWnZJwmduSIulnijzimN6uT1BuwnUCCMSQ/y2CoqN8mmCLI/u0lYAG07zbiYh3EDl/Nz8fOgfDfN89X8ZFGEaX/ykGrIPR2ZBNuQet0yxFq0v+ZJdcSitIRDGmnT2yY7htzxh7T+Yd3N1lFAgjziOo6pBuIkRaVDvaOsoiajQziNN5oSlXXaTn7uqCVCvDm3OXQY51irCEEPyXNBzaaKja7uiftMiFshUuLfqmzXsuoQB4/bd8f8TDg==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b0040fc771c864sm7980397wmg.14.2024.02.05.01.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:34:41 -0800 (PST)
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
Subject: [PATCH v2 18/23] gpio: remove unnecessary checks from gpiod_to_chip()
Date: Mon,  5 Feb 2024 10:34:13 +0100
Message-Id: <20240205093418.39755-19-brgl@bgdev.pl>
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

We don't need to check the gdev pointer in struct gpio_desc - it's
always assigned and never cleared. It's also pointless to check
gdev->chip before we actually serialize access to it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7d897c807e95..95b480f01fca 100644
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
@@ -3499,7 +3499,7 @@ int gpiod_to_irq(const struct gpio_desc *desc)
 	 * requires this function to not return zero on an invalid descriptor
 	 * but rather a negative error number.
 	 */
-	if (!desc || IS_ERR(desc) || !desc->gdev || !desc->gdev->chip)
+	if (!desc || IS_ERR(desc))
 		return -EINVAL;
 
 	gc = desc->gdev->chip;
-- 
2.40.1


