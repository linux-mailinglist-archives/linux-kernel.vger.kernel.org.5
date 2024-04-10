Return-Path: <linux-kernel+bounces-138070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDB089EBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9520B2578C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D313CA8B;
	Wed, 10 Apr 2024 07:21:08 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B213C9C2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733668; cv=none; b=NJE052+kNIru3PqmWmBdsNkxO/8ZrB9co0Mqfgg6Qmo5HtnfVYnF/Rnac+JzcPnBN/hIJHtVyurD9IZglzUp/UQsJv2lSjCtj5yP7dTNYSRMbwElxeT0KUbCcMZRC5+8yxwtC5CJBkyCn3me5OT2e7jqCl33+jzHah5AopdXLgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733668; c=relaxed/simple;
	bh=RcYXIoJyxd2gXsW8US9BPUxd3bMDhT6QDMBF7KlIeNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WruIaEoBdPmJLiI/pHO7pGQ7V3cXdKXD9uHpDaLAQbfuX6+7TE8qLhQujCv4p459TT4c5GhCwYpXJVZmBECylqzttPoX/8OoWZjxe3QrOA+5E98n52lqW8TPWiDHRoEl7zsShQXCDGHW7gi99ZKeAXz6G0TbL7V98npk8HXhU6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id e3ae5b77-f70a-11ee-abf4-005056bdd08f;
	Wed, 10 Apr 2024 10:21:04 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpio: sch: Switch to memory mapped IO accessors
Date: Wed, 10 Apr 2024 10:21:02 +0300
Message-ID: <20240410072102.1200869-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert driver to use memory mapped IO accessors.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpio-sch.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index e48392074e4b8..0c765558d03fc 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -38,8 +38,8 @@
 
 struct sch_gpio {
 	struct gpio_chip chip;
+	void __iomem *regs;
 	spinlock_t lock;
-	unsigned short iobase;
 	unsigned short resume_base;
 
 	/* GPE handling */
@@ -75,7 +75,7 @@ static int sch_gpio_reg_get(struct sch_gpio *sch, unsigned int gpio, unsigned in
 	offset = sch_gpio_offset(sch, gpio, reg);
 	bit = sch_gpio_bit(sch, gpio);
 
-	reg_val = !!(inb(sch->iobase + offset) & BIT(bit));
+	reg_val = !!(ioread8(sch->regs + offset) & BIT(bit));
 
 	return reg_val;
 }
@@ -89,12 +89,14 @@ static void sch_gpio_reg_set(struct sch_gpio *sch, unsigned int gpio, unsigned i
 	offset = sch_gpio_offset(sch, gpio, reg);
 	bit = sch_gpio_bit(sch, gpio);
 
-	reg_val = inb(sch->iobase + offset);
+	reg_val = ioread8(sch->regs + offset);
 
 	if (val)
-		outb(reg_val | BIT(bit), sch->iobase + offset);
+		reg_val |= BIT(bit);
 	else
-		outb((reg_val & ~BIT(bit)), sch->iobase + offset);
+		reg_val &= ~BIT(bit);
+
+	iowrite8(reg_val, sch->regs + offset);
 }
 
 static int sch_gpio_direction_in(struct gpio_chip *gc, unsigned int gpio_num)
@@ -267,8 +269,8 @@ static u32 sch_gpio_gpe_handler(acpi_handle gpe_device, u32 gpe, void *context)
 
 	spin_lock_irqsave(&sch->lock, flags);
 
-	core_status = inl(sch->iobase + CORE_BANK_OFFSET + GTS);
-	resume_status = inl(sch->iobase + RESUME_BANK_OFFSET + GTS);
+	core_status = ioread32(sch->regs + CORE_BANK_OFFSET + GTS);
+	resume_status = ioread32(sch->regs + RESUME_BANK_OFFSET + GTS);
 
 	spin_unlock_irqrestore(&sch->lock, flags);
 
@@ -319,9 +321,11 @@ static int sch_gpio_install_gpe_handler(struct sch_gpio *sch)
 
 static int sch_gpio_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct gpio_irq_chip *girq;
 	struct sch_gpio *sch;
 	struct resource *res;
+	void __iomem *regs;
 	int ret;
 
 	sch = devm_kzalloc(&pdev->dev, sizeof(*sch), GFP_KERNEL);
@@ -332,12 +336,13 @@ static int sch_gpio_probe(struct platform_device *pdev)
 	if (!res)
 		return -EBUSY;
 
-	if (!devm_request_region(&pdev->dev, res->start, resource_size(res),
-				 pdev->name))
+	regs = devm_ioport_map(dev, res->start, resource_size(res));
+	if (!regs)
 		return -EBUSY;
 
+	sch->regs = regs;
+
 	spin_lock_init(&sch->lock);
-	sch->iobase = res->start;
 	sch->chip = sch_gpio_chip;
 	sch->chip.label = dev_name(&pdev->dev);
 	sch->chip.parent = &pdev->dev;
-- 
2.44.0


