Return-Path: <linux-kernel+bounces-44638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7073484255E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E4AB27C53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AF37E568;
	Tue, 30 Jan 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pJ+juR9B"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39076043
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618932; cv=none; b=Pn5bp8Sv2vogPxoT5ra3sHT2RuMZwLL5fLhNfO2FmnfsazMHjPdXwdki7u0Cwn//ZV/L9CUB1bLvg5e2+8oVZEDkOpjihiWaxJQFCWCWB6kEfXFvBh5HDc7ud2Z/zRFlNuzdoogaR3fdZx3ykWeLuEj4VIK9CSSA6WZDJJaBtsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618932; c=relaxed/simple;
	bh=a77Z1wLtdi6HLoxovZ74UkubCjuphhC0bzLiTPATleI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5C70jEnkx3z1nNosPzWOXLuUV8qGqP/HhRrl6Bzw6J37xE9vGxHgi5RqPJYUM6KnjEZn3JRUc/NsBSJmIR300/PnupIyk2lCQMVRrvTCKvSLDBVIp4qTp5QtTyFUsQV0hHS/WsXbMT4RZmKBMStMpyBaNLRyh9A9jnQGQiVjp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pJ+juR9B; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3394ca0c874so3295646f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618929; x=1707223729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9G7eHGhPK2p3/OACj21UoYDs98sUi0sEn+7lptLodw=;
        b=pJ+juR9Ba1ldEWviwCpWWQjN315R7Ig+u+yKJOqHDDpxblx+nid8APhIhyvKe2wIwl
         ahcjTx2F9zdYwwB13N8rPUq4mOuTQMR6fpZe6t6jiG96cZ5h5ibx22o6C3WO2ZXEoDFs
         hKSCkIr8sgeG/Gs22vfLLT6i9yoLlXHs/W1WGTeC4EUDaxrl/ovLNTAhJ5ilq8E7C/u3
         4fPlybeE3ww7g/g58JmCvZRj9k07T8ygI55bSobazreoMfCc/FhWHJDLTZHjuXLrhvz9
         owdwIXG6fFTdH7zSM087iBLflkLjwHBaqEQ3oujO9+JNrIjRuE+fQV7mMcOooowyL30m
         J1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618929; x=1707223729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9G7eHGhPK2p3/OACj21UoYDs98sUi0sEn+7lptLodw=;
        b=ELZN4QPzGcn0mgGVUNltFOn+dPd7tiJH1fIVpoBX/on1kVOulVA+mfSGmGjV1TxlSB
         yFwmjk7mZrn35v8OoqeKMQXP14J8LjPtjWJcXPKKfEFKnjJuFd3JiPgi7AtQEBV8JbA4
         Gyyw88F4e9h6p/GirRsCbwCLWnZ8k2Nwj5GUq6LKQXPdH5aBkJSnG8zXH0cQyrJfwrDe
         oG22FGrijBQFDf7tsJlBg0D+mruDTHiv3vH+aQRRKozS88wcB6hM2KO0RVrN6UIG/30y
         zXFYss7tf9bDFt8Aq/tVfzFhqhrG7bj1P3T9YbbXmCXE13sbdwyvqD0JZZ8rOgqS6QNM
         1R+A==
X-Gm-Message-State: AOJu0YxBegQK+fgVVjq0x3W9UtCLJJh5V7dVI1Ixe1LH2A+IiGMPlenW
	yJzXjNX8vPIiqCWudDut8A+jgIoOVlZKJPV7mHqhRs2jsiOmAQ3KoxX80p8+0x8=
X-Google-Smtp-Source: AGHT+IGYhVhdXvI0t2Yl9zELAaar3O0DzUsAkjzfptkbA/XB2Y8mn9JGci7qzVzwwXbLZwLax8+wLQ==
X-Received: by 2002:a05:6000:4208:b0:33a:e7b4:7a75 with SMTP id en8-20020a056000420800b0033ae7b47a75mr7422555wrb.34.1706618929674;
        Tue, 30 Jan 2024 04:48:49 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:49 -0800 (PST)
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
Subject: [PATCH 11/22] gpio: remove unneeded code from gpio_device_get_desc()
Date: Tue, 30 Jan 2024 13:48:17 +0100
Message-Id: <20240130124828.14678-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130124828.14678-1-brgl@bgdev.pl>
References: <20240130124828.14678-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The GPIO chip pointer is unused. Let's remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f15b854bbcb2..ddf7d93f8b76 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -184,16 +184,6 @@ EXPORT_SYMBOL_GPL(gpiochip_get_desc);
 struct gpio_desc *
 gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum)
 {
-	struct gpio_chip *gc;
-
-	/*
-	 * FIXME: This will be locked once we protect gdev->chip everywhere
-	 * with SRCU.
-	 */
-	gc = gdev->chip;
-	if (!gc)
-		return ERR_PTR(-ENODEV);
-
 	if (hwnum >= gdev->ngpio)
 		return ERR_PTR(-EINVAL);
 
-- 
2.40.1


