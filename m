Return-Path: <linux-kernel+bounces-124420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E9F891744
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A8E9B24225
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867DB6BB58;
	Fri, 29 Mar 2024 10:57:53 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCD36A355
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709873; cv=none; b=jBlmdlTWJgtFenK+gyglxAPN88oo8veRNaag3+JYs6qyS6vDsCIgmVDvWW+Sklt2TdexJ7EL4TnhT/zNrEGpXeZslUgwV0woQvjzfvDx2WeUCe8FG8lKjBzIxOzGQuV1KrlJDhD/UtdnKPUS3xmX9kG8VmO+D8xNOQyJpBRp0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709873; c=relaxed/simple;
	bh=GI3pmjFDTQrAB0t+CrsgeVXfRQwlTIx8MloFcQOk+1Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXHZmxOH1hqaXafhFUKHJqOhmkjUNCZp2mNj3aEOYB71fzDm+WuxaORFDXVKm93olMB394W+hiZ/jOIoVZz9B4DffremW3JAQ1+uZT0UDj5yN7pH4EPL+sSXfYwNU/9DR2b9rodTGOWsDoUY6zM7fe37ibVlKC7lMjl2APN8vBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 0663c7c8-edbb-11ee-b3cf-005056bd6ce9;
	Fri, 29 Mar 2024 12:56:41 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] pinctrl: aw9523: Use temporary variable for HW IRQ number
Date: Fri, 29 Mar 2024 12:55:19 +0200
Message-ID: <20240329105634.712457-6-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329105634.712457-1-andy.shevchenko@gmail.com>
References: <20240329105634.712457-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two different ways on how to get HW IRQ number in some functions.
Unify that by using temporary variable and irqd_to_hwirq() call.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index 7db901216a94c..0f3361fa9ed88 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -428,12 +428,12 @@ static int aw9523_gpio_irq_type(struct irq_data *d, unsigned int type)
 static void aw9523_irq_mask(struct irq_data *d)
 {
 	struct aw9523 *awi = gpiochip_get_data(irq_data_get_irq_chip_data(d));
-	unsigned int n = d->hwirq % AW9523_PINS_PER_PORT;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned int n = hwirq % AW9523_PINS_PER_PORT;
 
-	regmap_update_bits(awi->regmap,
-			   AW9523_REG_INTR_DIS(d->hwirq),
+	regmap_update_bits(awi->regmap, AW9523_REG_INTR_DIS(hwirq),
 			   BIT(n), BIT(n));
-	gpiochip_disable_irq(&awi->gpio, irqd_to_hwirq(d));
+	gpiochip_disable_irq(&awi->gpio, hwirq);
 }
 
 /*
@@ -446,11 +446,11 @@ static void aw9523_irq_mask(struct irq_data *d)
 static void aw9523_irq_unmask(struct irq_data *d)
 {
 	struct aw9523 *awi = gpiochip_get_data(irq_data_get_irq_chip_data(d));
-	unsigned int n = d->hwirq % AW9523_PINS_PER_PORT;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned int n = hwirq % AW9523_PINS_PER_PORT;
 
-	gpiochip_enable_irq(&awi->gpio, irqd_to_hwirq(d));
-	regmap_update_bits(awi->regmap,
-			   AW9523_REG_INTR_DIS(d->hwirq),
+	gpiochip_enable_irq(&awi->gpio, hwirq);
+	regmap_update_bits(awi->regmap, AW9523_REG_INTR_DIS(hwirq),
 			   BIT(n), 0);
 }
 
-- 
2.44.0


