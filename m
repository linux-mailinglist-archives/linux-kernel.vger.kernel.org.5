Return-Path: <linux-kernel+bounces-155703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAE18AF5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900202850D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B133613E02B;
	Tue, 23 Apr 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEUyRBFE"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7E13CA96;
	Tue, 23 Apr 2024 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894663; cv=none; b=KcvrDigRzJO+ViXqiim4/Zc6tgZxHbquZf6DDtAmthuaq1TFPU84yQEXtF9I+8DMwEAVRUIX2f3eUDuH1nI9hj7XMG+qeihVrm6SRPpC8mO7V7uq9cVtZf29KKUj+rQog8IZy/RNHJrKRzKYVWr92tKIr1OenjOQt8ITYHsK8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894663; c=relaxed/simple;
	bh=2Gml0mSQEDS7SIh4LPkgQh0yD6ZHVRRTxkFAe8Fd+yk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P864DNLHgK6USYco8dCgEk97ferdJcUErInwi+ACdeb1oKTlQxKsWXXQ73TSc9uE8ELGGy0x1CBcoFwYbcb60baGWhp9k6fXNURK2v/niKOvnqK5JksjVY7rgyi0puHdw7D5dHMe9m9ISLbAqN7dq2xdSOMNFwuyzsUG/th8BuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEUyRBFE; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b40061bbeso30894926d6.1;
        Tue, 23 Apr 2024 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713894660; x=1714499460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mq3/dOubMwzkxAEhuwZmQ8xTgTsTEEG+7iq9Q2Hjw3A=;
        b=HEUyRBFEFMHLMJ4nGMuL5DWzgh26wR6XL5puZ9DDKYbzxa9lN1ctFqsiel0u/+cfld
         //SiDJ4+GWeBk0qD9flxMTI8+iSxPtC80UQehq0JzqBCXRHdK/3McTbcxNwM+88y/KFV
         4Bd++fm1tfEb/6y4DFJ7jYLjSvZTE8Z7dXSGgTMVDC9XIBip2dQ77UuSkPS1Oi16DKxb
         5usi9RqAmPVxCM4M/osK0SVoccq+FI1mBdYchNghn3FPx1eLH0PM2sP6okUoHuiFh/4a
         t2GJNCLzXmtI7GARZ7w3Ec6wAF2j9XxLj0pdkS7rK/UbZUxhwkMt1yhqBEeqw8O2v8Qv
         b5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713894660; x=1714499460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mq3/dOubMwzkxAEhuwZmQ8xTgTsTEEG+7iq9Q2Hjw3A=;
        b=ROJTPGjAYOJcLzb3EglGEN/L3MAi0ltFYzEdFp4BrpQ8bvSjqwdaHYkR9Wp5+KB4eJ
         1v47hNnnAXL7+paJd96DtuLKYbEfWIy/EdNkktficVUouMv2DZC5TmOHfdUKnL62GDIK
         14STL6YX5AtiHCq9t++PIhpIRXVRsdSJWW/SxoJ4ElrDoryZtGhLzbPBKX6xwh5W9rpY
         X5/CmrO0jPdFTPgolyFZvr0CBLCW7cJ5ImA2CF+YPmqy6mZNgHP3n6xUP456jZZ/rnNf
         gGUROUVHT1FGI0H/r6bQ+FYn4Cjp+G0dXBqwppkE1LGcfZKaWSKGQunzWVn897V7s9Ks
         Cfuw==
X-Forwarded-Encrypted: i=1; AJvYcCUkg/sMH7UqfmxrRK5cXGl+z8puW3kFhSkWxvlBgeR30CyXC7bmHsjxuwZ+pfOAtoZMnlUG6NtogX3WgpI5plrz+C4pdhofuYhH8rxwqRGWswfMdxv7+qqnaEb6vzi3VcJU57Lmgwd4bA==
X-Gm-Message-State: AOJu0YwOwPGCwHORbSDY+YQqtSlammTqI4S4InA7yUhjfO1hw18Lt3Fx
	FuJn+zbjvu3mUjU3agvh6JuxWAProzH2sQ/LJXKY934Nl4k5MqbB
X-Google-Smtp-Source: AGHT+IFRYtQrNtQjtshOLSGV5N3sax3zO2noXWjyyB+SGvQ46sxMyNLuuDPmIbzrQiIw9G51RFuuSg==
X-Received: by 2002:a05:6214:328c:b0:691:8b3a:5acb with SMTP id mu12-20020a056214328c00b006918b3a5acbmr174177qvb.13.1713894660340;
        Tue, 23 Apr 2024 10:51:00 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id js7-20020a05622a808700b0043936ed09bfsm3859808qtb.27.2024.04.23.10.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:50:59 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH] gpio: brcmstb: Use dynamic GPIO base numbers
Date: Tue, 23 Apr 2024 10:50:25 -0700
Message-Id: <20240423175025.1490171-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forcing a gpiochip to have a fixed base number now leads to a warning
message. Remove the need to do so by using the offset value of the
gpiochip.

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index a789af4a5c85..a9d5697349d3 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -50,7 +50,6 @@ struct brcmstb_gpio_priv {
 	struct irq_domain *irq_domain;
 	struct irq_chip irq_chip;
 	int parent_irq;
-	int gpio_base;
 	int num_gpios;
 	int parent_wake_irq;
 };
@@ -92,7 +91,7 @@ brcmstb_gpio_get_active_irqs(struct brcmstb_gpio_bank *bank)
 static int brcmstb_gpio_hwirq_to_offset(irq_hw_number_t hwirq,
 					struct brcmstb_gpio_bank *bank)
 {
-	return hwirq - (bank->gc.base - bank->parent_priv->gpio_base);
+	return hwirq - bank->gc.offset;
 }
 
 static void brcmstb_gpio_set_imask(struct brcmstb_gpio_bank *bank,
@@ -118,7 +117,7 @@ static int brcmstb_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 {
 	struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
 	/* gc_offset is relative to this gpio_chip; want real offset */
-	int hwirq = offset + (gc->base - priv->gpio_base);
+	int hwirq = offset + gc->offset;
 
 	if (hwirq >= priv->num_gpios)
 		return -ENXIO;
@@ -263,7 +262,7 @@ static void brcmstb_gpio_irq_bank_handler(struct brcmstb_gpio_bank *bank)
 {
 	struct brcmstb_gpio_priv *priv = bank->parent_priv;
 	struct irq_domain *domain = priv->irq_domain;
-	int hwbase = bank->gc.base - priv->gpio_base;
+	int hwbase = bank->gc.offset;
 	unsigned long status;
 
 	while ((status = brcmstb_gpio_get_active_irqs(bank))) {
@@ -412,7 +411,7 @@ static int brcmstb_gpio_of_xlate(struct gpio_chip *gc,
 	if (WARN_ON(gpiospec->args_count < gc->of_gpio_n_cells))
 		return -EINVAL;
 
-	offset = gpiospec->args[0] - (gc->base - priv->gpio_base);
+	offset = gpiospec->args[0] - bank->gc.offset;
 	if (offset >= gc->ngpio || offset < 0)
 		return -EINVAL;
 
@@ -596,8 +595,8 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	const __be32 *p;
 	u32 bank_width;
 	int num_banks = 0;
+	int num_gpios = 0;
 	int err;
-	static int gpio_base;
 	unsigned long flags = 0;
 	bool need_wakeup_event = false;
 
@@ -611,7 +610,6 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
 
-	priv->gpio_base = gpio_base;
 	priv->reg_base = reg_base;
 	priv->pdev = pdev;
 
@@ -651,7 +649,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 			dev_dbg(dev, "Width 0 found: Empty bank @ %d\n",
 				num_banks);
 			num_banks++;
-			gpio_base += MAX_GPIO_PER_BANK;
+			num_gpios += MAX_GPIO_PER_BANK;
 			continue;
 		}
 
@@ -691,7 +689,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 			err = -ENOMEM;
 			goto fail;
 		}
-		gc->base = gpio_base;
+		gc->base = -1;
 		gc->of_gpio_n_cells = 2;
 		gc->of_xlate = brcmstb_gpio_of_xlate;
 		/* not all ngpio lines are valid, will use bank width later */
@@ -713,7 +711,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 					bank->id);
 			goto fail;
 		}
-		gpio_base += gc->ngpio;
+		num_gpios += gc->ngpio;
 
 		dev_dbg(dev, "bank=%d, base=%d, ngpio=%d, width=%d\n", bank->id,
 			gc->base, gc->ngpio, bank->width);
@@ -724,7 +722,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		num_banks++;
 	}
 
-	priv->num_gpios = gpio_base - priv->gpio_base;
+	priv->num_gpios = num_gpios;
 	if (priv->parent_irq > 0) {
 		err = brcmstb_gpio_irq_setup(pdev, priv);
 		if (err)
-- 
2.34.1


