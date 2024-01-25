Return-Path: <linux-kernel+bounces-38150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3657783BB93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D351C21E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FAC18AF4;
	Thu, 25 Jan 2024 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmlDgATJ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878617BA3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170569; cv=none; b=G2Orlm6JdRrPwVJnfEv+8d9MwfD83la8HyPjxhHokZovCcneX7qWFGdih5Lto7QtXS7EbPWA0wOr8JxEfPMUq/z7y99VD01GqlfzL/Wcdk5ySoai3EwnSK1V+mD6tzFQsImrv2nnr5L7obYJzCZZOtHmxMMzgqdQ7UmBaiD3XQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170569; c=relaxed/simple;
	bh=/g90OGyapLZIgFMzfzoWev7vgtKFk6/jNzgHgg3GQXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EjSElB/ZwpNswmibdMBsDYe/GiemO1ieMGmS1hrbgENTXYGHZZ4+SzPRlKoEDfxQdNBTOFt1km59+WmMhJI7bNdyZDiZ03acx86t3xy6fmXGAlr8AtYJ1laVB4vQbpTxBajvHKSmAvSsb9TCAaKoOqLZLOwF1lMQ8cOYrdodHJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XmlDgATJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso8082142e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706170566; x=1706775366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZhfRAcMkEoSH9uoQJllo0c8c8c3cGnCVOI0jsbLnjU=;
        b=XmlDgATJrRxFgFBPpqU6nztUiq+5UF+B0eUoHbOd80KQOI8xJ/aV1V+ljUjATE5jEp
         WhSQlMDFYzYdC2U38Qufoun5z1x7m6GrVlaIh4Qfnkw5NVc7kQTC7zIIHLVbc6a5LnBO
         /o+EhJNZ9QidomLm5ZXaU6QlbMqbx618IbA76EWlpEqxS5Ssr1q4RMKF2NnF2TcQmSSg
         CckfmBETrUtWF8SKxlz2Ia5Qfhcmf+0iVuiPEJXnFV8E39BU41Fhie6IJQbq/iA1yV9W
         VyIDBKDuhZQcuzI0zEcCjB0yP2MACyC/laf7PU6/c4gD/SsXgnU8TTyaV3abnrwO61kf
         3HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706170566; x=1706775366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZhfRAcMkEoSH9uoQJllo0c8c8c3cGnCVOI0jsbLnjU=;
        b=AgFBlzV3e2wxMDaK5Jy4n60oFs35qZ2db81DEwnfdXn2avoMlVCOQZvzI5EhPw+wF9
         nEX9EsKuTdTMuPbu0gUiQel9LGStYECd/wUoRE2+xvsSCzWmok5OjefSX7DRDxqK+2l/
         PtbOSWBoj5Ptcs9Fu6o2gZLSGD+ZcUPKDrAdbIrBe17xw6m6O9b+9iOn0FUOnbEBIxSu
         8fRyR3TzB0D+9e1G59HRIhKxh3WirSSDMYqVlh+rqp/MEZJmvJVoKL/eTt440vQFuF8g
         DBkIDwNlVIa6xwSwIpGO3cYip7dY/5AbabjWa0/dsOxdqp/K1kqd0J1anZ+7XPG/23uP
         GkUw==
X-Gm-Message-State: AOJu0YxRkzQRNh7sdM7861Vuowd//GAkZnZTKs5jSssguzZ5AWb0A17+
	SlRw4YQcKeAg5b9qANqrqoULaydQH4UJLi+F+amYPIihOSL7DLuo8KZbulNubW8=
X-Google-Smtp-Source: AGHT+IGOU9gXbKIs4yU0ljzrz/Vu+ZXnFptlQJI8jHBBkJLAIA4RsN3yLzDotKbZ0fX+5IAY3p1TQw==
X-Received: by 2002:a19:f509:0:b0:50b:f304:3bed with SMTP id j9-20020a19f509000000b0050bf3043bedmr132659lfb.49.1706170566479;
        Thu, 25 Jan 2024 00:16:06 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id f21-20020a056402195500b0055c63205052sm3410210edz.37.2024.01.25.00.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 00:16:06 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Peter Rosin <peda@axentia.se>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 2/3] gpiolib: add gpio_device_get_base() stub for !GPIOLIB
Date: Thu, 25 Jan 2024 09:16:00 +0100
Message-Id: <20240125081601.118051-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125081601.118051-1-krzysztof.kozlowski@linaro.org>
References: <20240125081601.118051-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add empty stub of gpio_device_get_base() when GPIOLIB is not enabled.

Cc: <stable@vger.kernel.org>
Fixes: 8c85a102fc4e ("gpiolib: provide gpio_device_get_base()")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 include/linux/gpio/driver.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 012797e7106d..c1df7698edb0 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -825,6 +825,12 @@ static inline struct gpio_device *gpiod_to_gpio_device(struct gpio_desc *desc)
 	return ERR_PTR(-ENODEV);
 }
 
+static inline int gpio_device_get_base(struct gpio_device *gdev)
+{
+	WARN_ON(1);
+	return -ENODEV;
+}
+
 static inline int gpiochip_lock_as_irq(struct gpio_chip *gc,
 				       unsigned int offset)
 {
-- 
2.34.1


