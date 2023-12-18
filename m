Return-Path: <linux-kernel+bounces-3136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F16F8167DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923121C223A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7014B101C2;
	Mon, 18 Dec 2023 08:13:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17417F9D1;
	Mon, 18 Dec 2023 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3b84173feso1776165ad.1;
        Mon, 18 Dec 2023 00:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702887178; x=1703491978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ezu7kE5Fqyr7u6fL3bLv75SonronEgw3Sg7hagUo9IU=;
        b=La7DLbaw1Olvxdw5yb7qPF9rLrt5BQteyuwnUboktHXPRacK33ydzRup03vlpQTEc8
         YmvFDLe6JUdMgoARC9JXukJRIYPJR5aKWqHKO2/ncoW8xP0HW683xwE7up3aYweK3CAH
         fvh7AFeC2IPOj6cLVA4K7cR4P7X41af9JuvzI6ycSELlK2CYINbJUW3epBawXG+qDz9+
         P5nhIay+o8ijhAd9Qp7XjfBL+8l/RtdCQ3ld1oyTNYw7W3TVzERctwlL3Ttl9OpIW2vv
         x7FQ9i9wQEkaKmaWSoHaXenianOnMLuIFyjfZmN87RkgLcO8M8CiFgfwmznFewUW0n4q
         AxRA==
X-Gm-Message-State: AOJu0Ywv1oDQZWEcuylYwn1wXbNtUX+2ZN9lPJwPGS6ncUl4oPvT9rig
	HA8U1WMjIGju5ZIpEONmRFk=
X-Google-Smtp-Source: AGHT+IEDzZNRFbAMAVqNFpJEclL2hSAh4O2fY8+5lAVyuLynEAZcwzMubX2xIy2QyAa29pq6d1aImw==
X-Received: by 2002:a17:902:d48b:b0:1d0:73ca:660 with SMTP id c11-20020a170902d48b00b001d073ca0660mr32337484plg.4.1702887178245;
        Mon, 18 Dec 2023 00:12:58 -0800 (PST)
Received: from tgsp-ThinkPad-X280.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d21-20020a170902729500b001d3797d6899sm6215725pll.263.2023.12.18.00.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:12:57 -0800 (PST)
From: xiongxin <xiongxin@kylinos.cn>
To: fancer.lancer@gmail.com,
	hoan@os.amperecomputing.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiongxin <xiongxin@kylinos.cn>,
	Riwen Lu <luriwen@kylinos.cn>
Subject: [v2] gpio: dwapb: mask/unmask IRQ when disable/enale it
Date: Mon, 18 Dec 2023 16:12:46 +0800
Message-Id: <20231218081246.1921152-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the hardware implementation of the i2c hid driver based on dwapb gpio
irq, when the user continues to use the i2c hid device in the suspend
process, the i2c hid interrupt will be masked after the resume process
is finished.

This is because the disable_irq()/enable_irq() of the dwapb gpio driver
does not synchronize the irq mask register state. In normal use of the
i2c hid procedure, the gpio irq irq_mask()/irq_unmask() functions are
called in pairs. In case of an exception, i2c_hid_core_suspend() calls
disable_irq() to disable the gpio irq. With low probability, this causes
irq_unmask() to not be called, which causes the gpio irq to be masked
and not unmasked in enable_irq(), raising an exception.

Add synchronization to the masked register state in the
dwapb_irq_enable()/dwapb_irq_disable() function. mask the gpio irq
before disabling it. After enabling the gpio irq, unmask the irq.

Fixes: 7779b3455697 ("gpio: add a driver for the Synopsys DesignWare APB GPIO block")
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
Tested-by: xiongxin <xiongxin@kylinos.cn>
---
 drivers/gpio/gpio-dwapb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 4a4f61bf6c58..8c59332429c2 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -282,13 +282,15 @@ static void dwapb_irq_enable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	unsigned long flags;
 	u32 val;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	val = dwapb_read(gpio, GPIO_INTEN);
-	val |= BIT(irqd_to_hwirq(d));
+	val = dwapb_read(gpio, GPIO_INTEN) | BIT(hwirq);
 	dwapb_write(gpio, GPIO_INTEN, val);
+	val = dwapb_read(gpio, GPIO_INTMASK) & ~BIT(hwirq);
+	dwapb_write(gpio, GPIO_INTMASK, val);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
@@ -296,12 +298,14 @@ static void dwapb_irq_disable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	unsigned long flags;
 	u32 val;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	val = dwapb_read(gpio, GPIO_INTEN);
-	val &= ~BIT(irqd_to_hwirq(d));
+	val = dwapb_read(gpio, GPIO_INTMASK) | BIT(hwirq);
+	dwapb_write(gpio, GPIO_INTMASK, val);
+	val = dwapb_read(gpio, GPIO_INTEN) & ~BIT(hwirq);
 	dwapb_write(gpio, GPIO_INTEN, val);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
-- 
2.34.1


