Return-Path: <linux-kernel+bounces-84900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB82286AD59
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0C7B21266
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144315B115;
	Wed, 28 Feb 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kPKLZp1z"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6635F159562;
	Wed, 28 Feb 2024 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119712; cv=none; b=RWvJ5SAmRMa/kYbC/fH9mxe73FwTbJtZ20cRBD8keanY5HLsmJ+JEaPnPQlgBGVfh2p+uQsAuwhxlilro7b1K2KWI2AC22vnYBJ7aD7WDowWOuVpEpXTpc0F0S1OBcnFoB/bDSQOBpL3KXl5Z+PlRUywhuh0nTUXAe+3/qzZ2rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119712; c=relaxed/simple;
	bh=MOoZG7N3FoO3fUI+8Qt09OJ2w6mp91/VEJxL24dr6+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZCWgxbl3yudyuVtCWb9bvG779zGIH8W1x8Z6wVY24WSMCTHzUwn1LW2ibDY+EUA6F9scotjIZ8k9zQdrWZYWNqajntUoQzh28wq6Bpmo3cuUIX1ZZ3/HDDgwSlKLyOpG9HxJdpjalkGn7nSqrSIYZj7bb/zVMYl9jzirdYJOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kPKLZp1z; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69F6A1BF210;
	Wed, 28 Feb 2024 11:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4Gfor6nuolYGIUugrPyNoXIQvvUlt1/WBnyFdZgisA=;
	b=kPKLZp1z3M2JMAD0B+M2oXyWomFPy/uN2VdXu6pHnjc8DuBGZ4xCyAcNrQpFc2BcKAtToz
	+Iez3aYRvdg+rpdkwjQEG+mTpPdRFi8YPtedBtT5hBS49ryhNkjLTWuBc5d4DRikpPHHWF
	ya6l4yz/k7eIIzHxqxT/DjoRuA0/IeYE/GjFtQs3CyOOGpmbvTiJGsrEXmVZ7iqMp4sONW
	lB+N8hLHNnbnmDkYTxmVppd34EQhjTqGtFpJEJM1oaLafET1ETF2gCxx11oKKFHOFx7EPs
	gHhHp1x/TNRkH+mdbmqA+ok8MjtaERMW6yYrfUf/gBk0A4fHXyb/d+YsBuim1A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:21 +0100
Subject: [PATCH v2 23/30] gpio: nomadik: handle variadic GPIO count
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-23-3ba757474006@bootlin.com>
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Read the "ngpios" property to determine the number of GPIOs for a bank.
If not available, fallback to NMK_GPIO_PER_CHIP ie 32 ie the current
behavior.

The IP block always supports 32 GPIOs, but platforms can expose a lesser
amount. The Mobileye EyeQ5 is in this case; one bank is 29 GPIOs and
the other is 23.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index ca5c28965224..19394dc7e34a 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -488,7 +488,7 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	struct gpio_chip *chip;
 	struct clk *clk;
 	void __iomem *base;
-	u32 id;
+	u32 id, ngpio;
 
 	gpio_dev = bus_find_device_by_of_node(&platform_bus_type, np);
 	if (!gpio_dev) {
@@ -518,10 +518,15 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	if (device_property_read_u32(gpio_dev, "ngpios", &ngpio)) {
+		ngpio = NMK_GPIO_PER_CHIP;
+		dev_dbg(&pdev->dev, "populate: using default ngpio (%d)\n", ngpio);
+	}
+
 	nmk_chip->bank = id;
 	chip = &nmk_chip->chip;
 	chip->base = -1;
-	chip->ngpio = NMK_GPIO_PER_CHIP;
+	chip->ngpio = ngpio;
 	chip->label = dev_name(gpio_dev);
 	chip->parent = gpio_dev;
 

-- 
2.44.0


