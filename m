Return-Path: <linux-kernel+bounces-38148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAC483BB8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE611F23CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1271758E;
	Thu, 25 Jan 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4C8+O7R"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3F179BE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170568; cv=none; b=tXVH76hVVvlAIWdDyMf6AxZ7hIHwlYG4Y0THwVEFkiwmz00L8PqWAyaTgvB7GgkWsGylIG/H1OPtwBuMNxZ9fQmzmb11bghmpzO7xMRsmOE2ftDxxv3tS32XSOWALgoUZvPUlqmHPBsQiF9ZAnZf2mZOPdxU2iVUEbva8lyHlyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170568; c=relaxed/simple;
	bh=/wTQRLlgn+pDWkE/ztwTjnWGbogoKDM8d6qhGORGwR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qLMTw22mACxQluF8JhshwN4vxOavMnXoAzreo2I/cJEtM9VrqIEKI4HgvWEMPKe/QzYHr6+bNeZGxY/kh8N6CLWis54Tz6v8kksEm3YIMVooudh7SDMAf3YMVNq4h7nVSM+3P35O+SUSd6VFypitoUScdbChAtQf89ErZvYm1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T4C8+O7R; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a684acf92so7288891a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706170565; x=1706775365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VMWJsQKBSlZi8pCKLBY5EvRH/GHYaBZd2IsEfoSOud8=;
        b=T4C8+O7RIWKOO6839HSz0Emp+Y4W/GQcE68NIAA0z3f2/M2SqFVDjzr6K5G4ffa93m
         Dg86t1FPu1cKwA373tMEfz8U5Vloi9zZYvqBlHhkcCvfhtwhdWwHWu2I+rM3vNaPhdeh
         VhOmpFoMTL3goKvM+PlHfj/32x4psOUNzcx3uSaPd22Wgw9o/2OA2YOJIJSQuSyGRDdP
         +4GJHzZZK/Fcbz8Z0Tabtt416c8EysvQ4h6ifysz25hHk1fqau2UJ/cQ/ItrVFXybOUZ
         rqHk8r15cbzAOrysBloE/OB+Gp8+PjD9Qtfgy6zdCWEmGS1rBWJiddPR2pqAEFz0Cfqj
         ZAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706170565; x=1706775365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMWJsQKBSlZi8pCKLBY5EvRH/GHYaBZd2IsEfoSOud8=;
        b=lkSA/rzVGoMTwkO+51P5Ypfs5PUOH4S/8kRDm+w9gCmeC4+dZLum7ojLq0QKuIQkWW
         bJTtnCTPDGHQd1y+jePORzVJIcuYRzx7Unqp0GXEkbrlESTvSIdH83EEWtfMk6yE5ZzW
         WEZ3MzMsqjDZuSpGKoHs//0SY4Gizg4vyvrSiaOFOTVpApgWAsStLYkPIjQIMHXcSjgo
         2iOH0pUbHEiLWMEZGay6gTWjoRM9ih8PUa9eB8m5YFhy6NHynzqlIAvSBs161B5INLCm
         8MecSKY2cjt2VFtU2olO+aQECQCztMNRXsc2OFrlVwNkrzhkx3lo1hMPS3dx9DB3cmg+
         Ci/Q==
X-Gm-Message-State: AOJu0Yyhi5rCmCO+TxTu03MH4ysN6xoXt8oZUqBpq0oK8UgkioHytBql
	GqsPScP12bB4nOPx0th90Hhuu1pKLRN1yrh3lmx6Cx40ORuYoW0laKugsiOdSTdew6xp8yO2q17
	L
X-Google-Smtp-Source: AGHT+IF2XZjfMkUE+zrC/X1j9wgoA8vQcAacVhS0gEX8bTbt73QDcbuwnfLhm6QbipfACJCruff5vw==
X-Received: by 2002:a05:6402:5169:b0:55c:ff50:e2c6 with SMTP id d9-20020a056402516900b0055cff50e2c6mr154062ede.60.1706170565208;
        Thu, 25 Jan 2024 00:16:05 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id f21-20020a056402195500b0055c63205052sm3410210edz.37.2024.01.25.00.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 00:16:04 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Peter Rosin <peda@axentia.se>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 1/3] gpiolib: add gpiod_to_gpio_device() stub for !GPIOLIB
Date: Thu, 25 Jan 2024 09:15:59 +0100
Message-Id: <20240125081601.118051-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add empty stub of gpiod_to_gpio_device() when GPIOLIB is not enabled.

Cc: <stable@vger.kernel.org>
Fixes: 370232d096e3 ("gpiolib: provide gpiod_to_gpio_device()")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 include/linux/gpio/driver.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 9a5c6c76e653..012797e7106d 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -819,6 +819,12 @@ static inline struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct gpio_device *gpiod_to_gpio_device(struct gpio_desc *desc)
+{
+	WARN_ON(1);
+	return ERR_PTR(-ENODEV);
+}
+
 static inline int gpiochip_lock_as_irq(struct gpio_chip *gc,
 				       unsigned int offset)
 {
-- 
2.34.1


