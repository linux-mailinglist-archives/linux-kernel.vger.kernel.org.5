Return-Path: <linux-kernel+bounces-4560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F848817F51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4051285E64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B36D17CF;
	Tue, 19 Dec 2023 01:38:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6048B137C;
	Tue, 19 Dec 2023 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3b84173feso3672385ad.1;
        Mon, 18 Dec 2023 17:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702949893; x=1703554693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itayclm3e2RmB5yfikzI8PTp/jgy3ZG/7OtocXaYqA0=;
        b=a+4RoGOB2c4bwpzfG4Mq3GvkH80RSru5soLc4LAEtUWSxqHREAIrDHSBnzz9e7+wS7
         hj7p797wvbzjh4yxoFHm3XElcaNfD7zBuovKWUmp/5OzJyZFQqU9M7Va771AeaJrjUzF
         9GFLd12qZcEuTlhfisOJ97Mv14vfcixVXqqQsva8qrkXkf3Q+XxX0a37Y1XeAEn+z22b
         Ay0/Nl/1HEtzjCKcAeXJDexSWPIuQoltEjxXPL9zCrDehZdNHno8jf6kSW3U/9CD8VUs
         wH+newox3GnN+yezdJiTMG8sWVIAfchF7HNiIQWgm9pcMPeevrEl57qYa0bwE6jTqChD
         Ao3Q==
X-Gm-Message-State: AOJu0Yxw3BM8kuGSeCuz3/M581sC0jUowCco0ZWuOinANQbNHplAXskb
	w6MUE3BFmzxihcrisHlpqMfYjPn4rOGi4w==
X-Google-Smtp-Source: AGHT+IFtkONIKo5N1dYQhZyWoM9e/m24EtiG3MCP98XI2ClkzZ7S/hyJL6uGptOBcpVtwK//xkweiw==
X-Received: by 2002:a17:902:db12:b0:1d3:dbdc:4c9d with SMTP id m18-20020a170902db1200b001d3dbdc4c9dmr811851plx.3.1702949892590;
        Mon, 18 Dec 2023 17:38:12 -0800 (PST)
Received: from tgsp-ThinkPad-X280.. ([223.148.84.115])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902dad200b001cff026df52sm380900plx.221.2023.12.18.17.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 17:38:12 -0800 (PST)
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
Subject: [PATCH v3] gpio: dwapb: mask/unmask IRQ when disable/enale it
Date: Tue, 19 Dec 2023 09:37:51 +0800
Message-Id: <20231219013751.20386-1-xiongxin@kylinos.cn>
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

v3:
	* Modify the submitter's information
v2:
	* Resubmit the patch to fix this exception from the dwapb gpio
	  driver side.
v1:
	* Resolve the exception from the IRQ core layer. (key point not
	  found correctly)

Fixes: 7779b3455697 ("gpio: add a driver for the Synopsys DesignWare APB GPIO block")
Cc: stable@kernel.org
Co-developed-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
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


