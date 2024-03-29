Return-Path: <linux-kernel+bounces-124409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9EF891728
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6341C22907
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A7969E0F;
	Fri, 29 Mar 2024 10:56:47 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E646A34B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709807; cv=none; b=P58x0qhuY646G3nbuQWaHcr10YwjuAnlhQ7c0Maw615xhDYeG7OgRuKVkuP+fRXnmWiugb40OULGwzkldxS4JoyHRvcNf9cmKrsJPzJni2dp6VftY/TPJcOVP3V1BDHi+K5KBntOQ2DLAxrf3sIzcUlFu4JdQmauxh77XSffvMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709807; c=relaxed/simple;
	bh=hR5SmMZRHVc6b1GDrG4uIwUL6+3ig4QW9kTK++2jt+8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhNVRWmF/soCr7Xo0QmHQZGdbpq5KYEsV0lUEGsXC03sNV87S8NdDkvaegcdikR7GGfFskieNKABkFlq/ytQVNc46ZlGsGNb08IzRJ/KzV/qIYKiiJU/S2ulHk4tkmpGU+/WnsRGB0IDfCAlOwdQZJbhZw8jJjXhfmxEI2f0/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 07199218-edbb-11ee-abf4-005056bdd08f;
	Fri, 29 Mar 2024 12:56:43 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] pinctrl: aw9523: Remove unused irqchip field in struct aw9523_irq
Date: Fri, 29 Mar 2024 12:55:21 +0200
Message-ID: <20240329105634.712457-8-andy.shevchenko@gmail.com>
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

The irqchip field is allocated, assigned but never used. Remove it.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index 8c615adb3d578..f084dad5c88f9 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -57,12 +57,10 @@
 /*
  * struct aw9523_irq - Interrupt controller structure
  * @lock: mutex locking for the irq bus
- * @irqchip: structure holding irqchip params
  * @cached_gpio: stores the previous gpio status for bit comparison
  */
 struct aw9523_irq {
 	struct mutex lock;
-	struct irq_chip *irqchip;
 	u16 cached_gpio;
 };
 
@@ -805,21 +803,15 @@ static int aw9523_init_irq(struct aw9523 *awi, int irq)
 {
 	struct device *dev = awi->dev;
 	struct gpio_irq_chip *girq;
-	struct irq_chip *irqchip;
 	int ret;
 
 	if (!device_property_read_bool(dev, "interrupt-controller"))
 		return 0;
 
-	irqchip = devm_kzalloc(dev, sizeof(*irqchip), GFP_KERNEL);
-	if (!irqchip)
-		return -ENOMEM;
-
 	awi->irq = devm_kzalloc(dev, sizeof(*awi->irq), GFP_KERNEL);
 	if (!awi->irq)
 		return -ENOMEM;
 
-	awi->irq->irqchip = irqchip;
 	mutex_init(&awi->irq->lock);
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, aw9523_irq_thread_func,
-- 
2.44.0


