Return-Path: <linux-kernel+bounces-5005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9BF818529
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24D5B23E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D4C1429C;
	Tue, 19 Dec 2023 10:16:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729414281;
	Tue, 19 Dec 2023 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3ae9d1109so4658255ad.0;
        Tue, 19 Dec 2023 02:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980997; x=1703585797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngNJCfucOduDHyYME8qfNMRkE+l/Nb1B8dGYavE1NeA=;
        b=WN5s2EPI7uLY+S3QMmV7GCW85vKyppu0NUBe5VplsjuDWo+c7hjM4TSe3fDIYlrthw
         T7mpcyAntHR5t5cQs5K9Z6dK68WU0nF7FjMqJtGlO20aBnadFlYP01jCIPhX586g5sim
         0r9BdAKb6KVTRrpQEkUZfEwLj24jqMo2bNwvAMtGsMWcN83pm2RrhN00rWuAxgYV00TW
         oD/HSve8cSaLCmcmU0lnqHe/u23c8pXAwgfITEKqeLS0n0iQZrVQuUnBZ9RRj04himkb
         ocNxQZXLfpAGt3jcmKv3L5J+mJKWscteWjds71q7Tc5T1VMoGFmPjO7IlhUeVG9JmCQu
         mYjw==
X-Gm-Message-State: AOJu0YzLcfLYVcfwOY1ngkTKDvFt/ZuBL0TrI5XUTtXEse7l7K6oDcdi
	PlcQCweeL0ePDDsZ/xq/dBw=
X-Google-Smtp-Source: AGHT+IHJf367osA5rZVKmDTunjNi4k4NkX8jindrXqtBURoopK1U5/ii1OLsL0ObTTsU7obt1NbGnw==
X-Received: by 2002:a17:902:db12:b0:1d3:dbdc:4c9d with SMTP id m18-20020a170902db1200b001d3dbdc4c9dmr1827575plx.3.1702980996630;
        Tue, 19 Dec 2023 02:16:36 -0800 (PST)
Received: from tgsp-ThinkPad-X280.. ([223.148.84.115])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001d08e08003esm20649688plx.174.2023.12.19.02.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:16:36 -0800 (PST)
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
Subject: [PATCH v4] gpio: dwapb: mask/unmask IRQ when disable/enale it
Date: Tue, 19 Dec 2023 18:16:20 +0800
Message-Id: <20231219101620.4617-1-xiongxin@kylinos.cn>
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
Cc: stable@kernel.org
Co-developed-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
Acked-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>

---
v4:
	* Add patch tag information
v3:
	* Modify the submitter's information
v2:
	* Resubmit the patch to fix this exception from the dwapb gpio
	  driver side.
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


