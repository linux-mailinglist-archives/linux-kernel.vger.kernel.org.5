Return-Path: <linux-kernel+bounces-102665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5497C87B57B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860081C203A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A36C5EE79;
	Wed, 13 Mar 2024 23:55:40 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475135D8F6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374140; cv=none; b=AxbLfND+wSoOKLZf3PR8b05sn/yUOB5Da5B4yrj4EKJSPdU/WMDu1uCwg5oUXf3BDpeT2TFB1dn3HaL0vrhcWms7ivZXx58cdcqtAXeYFf+yOeaTdOu1NRj7gXM6M1u4GeEwSYWczEYIOufMOXh+9odeRA+snODKUFUitwwCH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374140; c=relaxed/simple;
	bh=/2xiYsQiRb+aViv4WHP41Tr0LGskzf2GigCrhrMxVnw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhG8CsP3YWddgefF6V9AHwGr+kCa5olrQAliuKP8drIWpSL05EUCN5iz8RTi7lmqgkR6XPtDLe9KpqIaKvDvrAsGoDAuOJPT0nYgFYdyPkJ2w4k2M5ceZjAHE5KujVLE9//2H4iqYOWEcW1EvA8oe5XJwqYsXQpME8RpAuMV1w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 076695d5-e195-11ee-abf4-005056bdd08f;
	Thu, 14 Mar 2024 01:54:28 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/11] pinctrl: aw9523: Use temporary variable for HW IRQ number
Date: Thu, 14 Mar 2024 01:52:08 +0200
Message-ID: <20240313235422.180075-6-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313235422.180075-1-andy.shevchenko@gmail.com>
References: <20240313235422.180075-1-andy.shevchenko@gmail.com>
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
index 79916e6bf6f4e..118896373844a 100644
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


