Return-Path: <linux-kernel+bounces-72883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2FE85BA10
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BB4282061
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C8A66B5D;
	Tue, 20 Feb 2024 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Whoy5WhB"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341F66B32;
	Tue, 20 Feb 2024 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427485; cv=none; b=oOKQws/+EnnswUAIUZP0jqbokGF2LpFmiryftMBaXheoGVXvx8BvvWN4xoBMgw/RehW4TVkmjCfLq8fcJHbDk6Ha9O/frcV6cOIMdqjZvW9sc28lafe5zZsmVx62ULNjIVm1MUKYAHkcpAu69mkYfLiw6oTi4u/m7wHy0TPp1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427485; c=relaxed/simple;
	bh=G5QNoctspJ1RDquSBWI4re9ufm9ecSTNMxVtKdOzPC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8pBBiNmVdKQwUrnG/DgY/Y/PtJak6Ghv0OH/hYp28NK3iWsQjQF3GQGoFLqjuhc2zIcWsLoyAweWbGDeBtVDGC1WxosmSEW/m3TmnHbak9/x3KK+nkeBIi5GAZMDMdkSQ/TD81qhfSjtl7uBPPZtxrz1uA6vNW4xTXtyfjda2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Whoy5WhB; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 02C2420011;
	Tue, 20 Feb 2024 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708427481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THtvQDT+qQLPub8vG8YsD0SpllI5xUKHDkxR4GFPKUc=;
	b=Whoy5WhBb2MER1f/zF9yAgQUCtgtnRPoP4ugCCbfrYr8zzS/xyhAzLcHgksQ4P0KkeJMcx
	Tz3G907QEWnsnRioi84FpY3hRmk7H32clzOj3un89LY4gTQ12/1y5CbxX+oVzu41VjK9/t
	OMQ6nGzecdjUOgxCH1aHpgErBZppwKisPopuwu3QvYo433aS1nOPBrukHiVT2ec0LNLXxh
	csaEmUN0HH7Fzo0LZd9Slpx6rbJx1gazRwsD8/f0JwoOcnSkJxNiOhb/IOLZPa2oU2kzFg
	kdBUXc7CHQ2zl8f6A6o3IPgVulcoVXqyCpDIgM6cIFjqvb+Xtt1exISK5iuhqw==
From: Herve Codina <herve.codina@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 2/2] leds: gpio: Add devlinks between the gpio consumed and the gpio leds device
Date: Tue, 20 Feb 2024 12:11:07 +0100
Message-ID: <20240220111111.133826-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220111111.133826-1-herve.codina@bootlin.com>
References: <20240220111111.133826-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

When a gpio is removed, the gpio leds consumer need to be removed first.
This dependency consumer/supplier can be described by devlink links.
In case of device-tree, even if some devlinks are created due to the
presence of gpio phandles in the gpio leds children, these links do not
help in removing the gpio leds device (i.e. the real consumer) before
the consumed gpio.
We can reach cases where the gpio are no more present and the gpio leds
driver continue to have leds using these gpio.
Further more, when the gpio come back, the gpio leds still use the old
removed one.

Indeed, the gpio are consumed by the parent of the consumer used in the
devlink creation due to phandles. A link is missing between the gpio and
the real gpio consumer, the gpio leds device itself.

Use the newly introduced gpiod_device_add_link() to create this
missing link between the gpio leds devices and the gpios.
With that done, if a gpio is removed, the gpio leds is removed and the
resources are correctly released.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/leds/leds-gpio.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 83fcd7b6afff..b3ec8ecbe5da 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -150,6 +150,7 @@ static struct gpio_leds_priv *gpio_leds_create(struct device *dev)
 {
 	struct fwnode_handle *child;
 	struct gpio_leds_priv *priv;
+	struct device_link *link;
 	int count, ret;
 
 	count = device_get_child_node_count(dev);
@@ -197,6 +198,20 @@ static struct gpio_leds_priv *gpio_leds_create(struct device *dev)
 		/* Set gpiod label to match the corresponding LED name. */
 		gpiod_set_consumer_name(led_dat->gpiod,
 					led_dat->cdev.dev->kobj.name);
+
+		/*
+		 * Create a link between the GPIO and the gpio-leds device.
+		 * This allow to have a relationship between the gpio used and
+		 * the gpio-leds device in order to automatically remove the
+		 * gpio-leds device (consumer) when a GPIO (supplier) is removed.
+		 */
+		link = gpiod_device_add_link(dev, led_dat->gpiod,
+					     DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (IS_ERR(link)) {
+			fwnode_handle_put(child);
+			return ERR_CAST(link);
+		}
+
 		priv->num_leds++;
 	}
 
-- 
2.43.0


