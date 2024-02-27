Return-Path: <linux-kernel+bounces-83132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5B1868EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDAD1C20BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E8A13A868;
	Tue, 27 Feb 2024 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RNSH9eQ+"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC0F139568;
	Tue, 27 Feb 2024 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033684; cv=none; b=Wjf5uWpF9YxolDCHsFmu68wv79hcZnBwuPal5gs7u5Y2Zb8g8B8yIYGH42X1YfsMDXyyGg//vYyzS2pcP0O/4jrYKzETvRlWEYl1pgrtqPCrDLOuJO1yIZiT5rAdzHyY7A/pvxU5NWSe8rvYZ3dexZeFvyCXxgJP2CQk/OlPYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033684; c=relaxed/simple;
	bh=kvF+KDgzeivY+RAQ8/BHt2sd41hOYzWE/MAHOlgwnpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hF5EUpSK9UtWUFX4qy6wX3NFLdw8yfl/1K+FapfgJlSP28SFzc1fb0/2rqQBRF+nzkLr5ltKc2Xn62357sbGGJLbykhd32ua5/t5AkN2sjBuWGkeiW23kKYctTukReYyyUhtv0n7eYyYMijE7JoOkJb7joilqtigX2t7en3YTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RNSH9eQ+; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 04A831C000B;
	Tue, 27 Feb 2024 11:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709033674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEy1WKZu79JY8RBIlDzPDmv8Cqag9mXrU8thTH54FTE=;
	b=RNSH9eQ+4yWnHnVtlpUJNgnp4s9B6XVqsh6exUAL1s6CqvR6ygkEsOH/dQOX/tE6eC/qFr
	LNMoKg7wTEhXQgA4XChpkYqs+LILCghDtZdR83mOjk0GJAyKs6FgHEotEEFASaW3bLUAmD
	aJgjIGeDSNCg8VI1xSF/d829mDK+ju2dP4dWYyNTVZZDI2NvMTxooFd4HzclQmz5NruFX6
	/i1j+sL46YdFwwEp1uC8/ubaWfZIYGtNc4rsIE+Gp4L8tiBO0+N9dsE7OpgQOEybfKxPFS
	xn7hxpTDY5ob9FqApPkD8EIyUvSAbYM0pn9bDipErxQNZeUBLz5mybDXpbksiw==
From: Herve Codina <herve.codina@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 1/2] gpiolib: call gcdev_unregister() sooner in the removal operations
Date: Tue, 27 Feb 2024 12:34:24 +0100
Message-ID: <20240227113426.253232-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227113426.253232-1-herve.codina@bootlin.com>
References: <20240227113426.253232-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

When gpio chip device is removed while some related gpio are used by the
user-space, the following warning can appear:
  remove_proc_entry: removing non-empty directory 'irq/233', leaking at least 'gpiomon'
  WARNING: CPU: 2 PID: 72 at fs/proc/generic.c:717 remove_proc_entry+0x190/0x19c
  ...
  Call trace:
    remove_proc_entry+0x190/0x19c
    unregister_irq_proc+0xd0/0x104
    free_desc+0x4c/0xc4
    irq_free_descs+0x6c/0x90
    irq_dispose_mapping+0x104/0x14c
    gpiochip_irqchip_remove+0xcc/0x1a4
    gpiochip_remove+0x48/0x100
  ...

Indeed, the gpio cdev uses an IRQ but this IRQ is not released
(irq_free() call) before the call to gpiochip_irqchip_remove().

In order to give a chance to the gpio dev driver to release this
irq before removing the IRQ mapping, notify the cdev driver about
the gpio device removal before the gpiochip_irqchip_remove() call.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/gpio/gpiolib.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 63e793a410e3..4ad3e260dec2 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1118,6 +1118,11 @@ void gpiochip_remove(struct gpio_chip *gc)
 	/* Numb the device, cancelling all outstanding operations */
 	rcu_assign_pointer(gdev->chip, NULL);
 	synchronize_srcu(&gdev->srcu);
+	/*
+	 * Tell gcdev that the device is removing. If any gpio resources are in
+	 * use (irqs for instance), it's time for gcdev to release them.
+	 */
+	gcdev_unregister(gdev);
 	gpiochip_irqchip_remove(gc);
 	acpi_gpiochip_remove(gc);
 	of_gpiochip_remove(gc);
@@ -1135,7 +1140,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	 * be removed, else it will be dangling until the last user is
 	 * gone.
 	 */
-	gcdev_unregister(gdev);
 	gpio_device_put(gdev);
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
-- 
2.43.0


