Return-Path: <linux-kernel+bounces-6289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC668196D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1F71F25436
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4173CBE5E;
	Wed, 20 Dec 2023 02:29:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75B68801;
	Wed, 20 Dec 2023 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3d3f0afc4so4615925ad.1;
        Tue, 19 Dec 2023 18:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703039357; x=1703644157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/s6nh+OnT95rk67Vq0CX7/pjmy4zN7W5jm/vs3FA464=;
        b=Nggtw0vAtj5Kza0eInQ4fb8EU80aOd14DxSKFF/YUXyawDwENqNbDhg0A7DF3QPqS9
         38fim5PRoD8KcyHdbOo7zyPxUC9PQBMRE3iVLyNvQUj0SVbPLkdm+04D6+kpORMK7KCk
         fN2RD195nFmHOeJPTLJ4mxR/1vot7YC6ZIYiRLNiFsZcLcnIUOUidVkbECywmTugb1N8
         Vx0LtWIslhF2Ad/Je2rzdeWKyXBsezNzEAnwiG3y55yzqXZFHSA+gTXl77VdzYdELN56
         mbLjO7UVkXbRNb7UnIAKLpnYWdNSNvtJfyAg6NHAUfUHnC4moB9vmnQAJSqS64NPqcMC
         ZBcg==
X-Gm-Message-State: AOJu0YxqepK2bFBXiF+xy5S8aTkqKp9X4+yYZiiQsUTJl6x8CIHugufa
	+HszXOc1SFeLn5sc+xp3bgc=
X-Google-Smtp-Source: AGHT+IGos0PDCWC8ruYbF/agSpJZbToAMxgPnG0vQFuSL/lSS57+y3tqUUJ2tGKCaNFXQZxlV9A60A==
X-Received: by 2002:a17:902:d2ca:b0:1d0:61a0:9844 with SMTP id n10-20020a170902d2ca00b001d061a09844mr38471639plc.4.1703039356931;
        Tue, 19 Dec 2023 18:29:16 -0800 (PST)
Received: from tgsp-ThinkPad-X280.. ([223.148.26.128])
        by smtp.gmail.com with ESMTPSA id l3-20020a170903244300b001d3d81c795bsm2112654pls.271.2023.12.19.18.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 18:29:16 -0800 (PST)
From: xiongxin <xiongxin@kylinos.cn>
To: fancer.lancer@gmail.com,
	hoan@os.amperecomputing.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiongxin <xiongxin@kylinos.cn>,
	stable@kernel.org,
	Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v5] gpio: dwapb: mask/unmask IRQ when disable/enale it
Date: Wed, 20 Dec 2023 10:29:01 +0800
Message-Id: <20231220022901.29158-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219101620.4617-1-xiongxin@kylinos.cn>
References: <20231219101620.4617-1-xiongxin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the hardware implementation of the I2C HID driver based on DesignWare
GPIO IRQ chip, when the user continues to use the I2C HID device in the
suspend process, the I2C HID interrupt will be masked after the resume
process is finished.

This is because the disable_irq()/enable_irq() of the DesignWare GPIO
driver does not synchronize the IRQ mask register state. In normal use
of the I2C HID procedure, the GPIO IRQ irq_mask()/irq_unmask() functions
are called in pairs. In case of an exception, i2c_hid_core_suspend()
calls disable_irq() to disable the GPIO IRQ. With low probability, this
causes irq_unmask() to not be called, which causes the GPIO IRQ to be
masked and not unmasked in enable_irq(), raising an exception.

Add synchronization to the masked register state in the
dwapb_irq_enable()/dwapb_irq_disable() function. mask the GPIO IRQ
before disabling it. After enabling the GPIO IRQ, unmask the IRQ.

Fixes: 7779b3455697 ("gpio: add a driver for the Synopsys DesignWare APB GPIO block")
Cc: stable@kernel.org
Co-developed-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
Acked-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
v5:
	* fix typo in patch description
v4:
	* Add patch tag information
v3:
	* Modify the submitter's information
v2:
	* Resubmit the patch to fix this exception from the DesignWare
	  GPIO driver side
v1:
	* Resolve the exception from the IRQ core layer. (key point not
	  found correctly)
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


