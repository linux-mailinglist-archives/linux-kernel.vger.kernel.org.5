Return-Path: <linux-kernel+bounces-38151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A383BB98
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D27B288EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927E31A58B;
	Thu, 25 Jan 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFzjg4ew"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5D1759D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170570; cv=none; b=d5AU7pGqSyK1Cx75wZ0KbBpDGjF6u7OHy7S2h79ZnIpkIrtOE5XnXI93hN37lICFKrYLp7oXrSotF3xRHVjN+7EprdrY1+dhgMF5qBhwUaoq6dQi36fGo3elJvBxaFifxoQl2vzS9mYkd7bosZhtF7+EBSGafm4KwysffkB71z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170570; c=relaxed/simple;
	bh=jaCgGOlshk2nOQ0HEUZD7VFYGGtzHGKiLMGwEMepQWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oPdSlokJ1rkF6zksmm1G5/QtTzRrN0MhCMC8/uDEO32Vm3Ie0T9kINX2tYla3jiAr8xFz/u2DW97PUfHHxSWg3mP6wUvMCzvdVQuidFiQIBJJMQTMPFlHXQGGCFjO4KnGcW4UaOXGh6e7lcFVKE8qCI2mfsx7d/OTl/jMGIWIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFzjg4ew; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a354a65afso5626817a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706170567; x=1706775367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yokV3KsZTLtR361FMJ3GYZw7aKtxmjchO95DV9+f45k=;
        b=VFzjg4ewYsvCIbtOR68R7mS8Bs5iXNZniys8SPrtfw5rKF9nEZw5bKlWICe1dl+Iww
         Cbm0mgVudul0cRA8VkNUf1unJj61sXYe4cRmhqfAzpAETPyZcHENWiNE+8hielh576bD
         3l4ZRVe511R0hmC/BoiiBI+jVIM+YCirsI9vAz6ccAGbfvprftZY8yJBS2Kgakq7gZH2
         80DbrwK8JsYtkm9K3HOIXuNOParrClx/rKuz7gyHoxj8mTuUIoCinsH3bBIwMda9Pix/
         /PXdAcusxwlly+rveUr0QjclAFArGb69qJC7kuvUVF59cmX1IkqtOf0VQ/arxFd7ssGm
         eKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706170567; x=1706775367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yokV3KsZTLtR361FMJ3GYZw7aKtxmjchO95DV9+f45k=;
        b=nyzhHpotZDV0msEsyMaU9wBRP35eMtiD77xkqyTThA3xkmwlxNS8HmQ/9WxvFw9iWl
         NPS5PkOKOh77j3wR42w08hL9BWzjMUQbH8brnU2t+uKqJOELmNJZumAZqvad4TXV/bCV
         WWvtMtE1yqw9tuEM68rUmALpdEi0LX9VkOkCNd/5fNdfL/IHvo7PrUoq/KZHe1ttIYgt
         xcC9ytauLBF4tFe+Mi3C/bQEoDaBSOeGXPLN0JqXGlXG1Seg2v62dZjVlYPiuRJsC9Po
         nbdJaVFmM+a5cY6crspf8f4XCYHnVkzNPeIENHf3zEVVKLh4SrOTWxkLEXZTQYuyVQ2W
         momg==
X-Gm-Message-State: AOJu0YyywyMtRFPuwC0YV3L+xeyX5mSCOHCa5/CvjnVaDVU1ohF+AzMc
	TfVOoGhU3/wTaphVqdpXiRB6eALjtnLt6dyBrOzaIDnNuqiazvaVLEEESvgnyuk=
X-Google-Smtp-Source: AGHT+IEG26rh2+JjBMSIa5yNNaPofjUDUvnStFMwaZzRZP98kED/r9+kUzFCNZFiLYA1/W/RRAF91Q==
X-Received: by 2002:a05:6402:1d55:b0:55c:661b:7fd3 with SMTP id dz21-20020a0564021d5500b0055c661b7fd3mr379652edb.70.1706170567639;
        Thu, 25 Jan 2024 00:16:07 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id f21-20020a056402195500b0055c63205052sm3410210edz.37.2024.01.25.00.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 00:16:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Peter Rosin <peda@axentia.se>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 3/3] gpiolib: add gpio_device_get_label() stub for !GPIOLIB
Date: Thu, 25 Jan 2024 09:16:01 +0100
Message-Id: <20240125081601.118051-3-krzysztof.kozlowski@linaro.org>
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

Add empty stub of gpio_device_get_label() when GPIOLIB is not enabled.

Cc: <stable@vger.kernel.org>
Fixes: d1f7728259ef ("gpiolib: provide gpio_device_get_label()")
Suggested-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Philipp Zabel <p.zabel@pengutronix.de>

Reset framework will need it:
https://lore.kernel.org/oe-kbuild-all/202401250958.YksQmnWj-lkp@intel.com/
---
 include/linux/gpio/driver.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index c1df7698edb0..7f75c9a51874 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -831,6 +831,12 @@ static inline int gpio_device_get_base(struct gpio_device *gdev)
 	return -ENODEV;
 }
 
+static inline const char *gpio_device_get_label(struct gpio_device *gdev)
+{
+	WARN_ON(1);
+	return NULL;
+}
+
 static inline int gpiochip_lock_as_irq(struct gpio_chip *gc,
 				       unsigned int offset)
 {
-- 
2.34.1


