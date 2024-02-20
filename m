Return-Path: <linux-kernel+bounces-72876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 472C985B9FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0430328739A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02F1664B6;
	Tue, 20 Feb 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Klp/Pvd0"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1165BCD;
	Tue, 20 Feb 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427438; cv=none; b=EU4wyPQx1UjfAwAvSX3VAEXvf343vpCc8gVE9jlXz+yON8Iacbb63Ren/Pl77p2xxFKyPLLzfE+k9bZqDkKNmYhNcfrzT3/mE8hZFJnGbjIv6jH3sPGD1oXIZ5Wbs8m/+czbw9rRWv9GHeWAAfVdh3VGgOw0ezhhrXJWA3pVmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427438; c=relaxed/simple;
	bh=ZDvB1WMZuKAfHW9xiHMtijGQ7/PSUaNUsnp1UoCHZp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7cCatztCM9vhMK7V7E/jfeA1TyvTJeJN/d+ku2GzXfLciPtz42NKeR+YD63pRQRI2SqXZw+45xrYYkjuaaRq4xwjP6/imOw4s91+nNYUKZ/zQ9xFrZb35pBcHtt4AjC0tbJxf+oZ+RQ9FoLqMto6L5RxexWOZnQ0blD60IFm8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Klp/Pvd0; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 70DBF1BF214;
	Tue, 20 Feb 2024 11:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708427427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUjOtVqB/hznZUhY9fXEYX8O3hPd38F8oY1TUvnjCBc=;
	b=Klp/Pvd0U6mkLtV4zBX11LCFFxxzp8QPqJ99ea+44bI94VlQ8Ti+5sUpwFrLaveiCiSv8b
	LyWbsoum7pFGT9R57LJxFyKGWmh2NydZ0IWtGhUApl/ti902KmCeHDYXMOAk2/ZUUHJOh3
	DaQdYZw0ms5XykAhIPuv3r20GI18ens0Y7hYIl8Z311pjlwKjBnA+ZsKi/lnNqS0aifXAh
	LepoIeXeegXqv2gkxJ+gSd2BKwrvKXOleHG+aln9OCz1QTyrwpkryvTdh8T28ptPUX2oi4
	/baYn8J9MV4Lfd1/e5yLqtFOIgBaJj/6uFIyashDbVIPJd6r+Yr9H80NP8PvIw==
From: Herve Codina <herve.codina@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/2] gpiolib: call gcdev_unregister() sooner in the removal operations
Date: Tue, 20 Feb 2024 12:10:17 +0100
Message-ID: <20240220111019.133697-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220111019.133697-1-herve.codina@bootlin.com>
References: <20240220111019.133697-1-herve.codina@bootlin.com>
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
 drivers/gpio/gpiolib.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8b3a0f45b574..079181b9daa8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1051,6 +1051,13 @@ void gpiochip_remove(struct gpio_chip *gc)
 
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gdev);
+
+	/*
+	 * Tell gcdev that the device is removing. If any gpio resources are in
+	 * use (irqs for instance), it's time for gcdev to release them.
+	 */
+	gcdev_unregister(gdev);
+
 	gpiochip_free_hogs(gc);
 	/* Numb the device, cancelling all outstanding operations */
 	gdev->chip = NULL;
@@ -1085,7 +1092,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	 * be removed, else it will be dangling until the last user is
 	 * gone.
 	 */
-	gcdev_unregister(gdev);
 	up_write(&gdev->sem);
 	gpio_device_put(gdev);
 }
-- 
2.43.0


