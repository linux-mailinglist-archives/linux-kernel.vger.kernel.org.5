Return-Path: <linux-kernel+bounces-73084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B304885BD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CE81C21B95
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19BE6A8A7;
	Tue, 20 Feb 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dummO1kT"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4267E63;
	Tue, 20 Feb 2024 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436401; cv=none; b=k8qx1Syhn/oRulatSEpmmHyYRTcYsXJ/S7K52uhZc4AvY5yxISP4MH3Tv7Jqo4pZF556uNVlz6l1apIXydYfxU2nIM4U0AtXSOXaOkK2U1siyLm7BnRFsLDbURiDBw6+dhod5WYsJT/3IZqWSWZq+p4olmjoo29Y0KKeNwsc9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436401; c=relaxed/simple;
	bh=ulweI1Ce0cUyHQQ4Wm/kRBRiyj0VTxmuz/Nzdi2q6FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiBCBixih3x1i/mPp6x2iNjK6dfrFFWVifLDBhkW4k/+cO+Xfa6SUxDjhrDzV17voNq2Nwl91BFbw6YqmmYelbjIb9KDtKSfWPOQX76izXZdbFLAGbVXSwFCzS80p9hY52Cvq1FoCG7OIyPJ/20VuDErDA9WLJZlUp8dIis3zzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dummO1kT; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id AC9E62000B;
	Tue, 20 Feb 2024 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708436397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oc4ohg5LOK/NMkvzmh0zZUOGGe+/Ajs5RSnJ2qJvG0E=;
	b=dummO1kTW7Rvsqc9TVwoXA/SOVTnR/bjg8Q2Hwyhqd890trD1tkru/OyYC/ytGqXsnjKzR
	w9SVt52EE+Wpj8a1Yx/QHnnxQYbIywjBNhnFZuqC431/VhWJRfn0CsEQZWS/WRsU2I4gh1
	x1jSd8qdY3PjrDgaVpSREjnyhcXgw6I44nPysypqWQHKPNTPleOVFXFiHrvfvw5Dgl9yMv
	vPxIsyIbxrGVZFLYKurn8ocQYvZIHsmHuYexKFWba6x5prRXDhczbf6xvnzlJdbfbyFawF
	dyD1SIBFzUXszpAmM53CHcNF0sJBNW1iw7pdVE6P+WFHY3wKT7kqZ8IslPlg4g==
From: Herve Codina <herve.codina@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH RESEND 1/2] gpiolib: Introduce gpiod_device_add_link()
Date: Tue, 20 Feb 2024 14:39:48 +0100
Message-ID: <20240220133950.138452-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220133950.138452-1-herve.codina@bootlin.com>
References: <20240220133950.138452-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

With device-tree, some devlink related to gpios are automatically added
when a consumer device is added and the attached node has phandles
related to GPIOs.
In some cases, the real device used to get the gpio during a probe() can
be related to an of-node parent of the of-node used for the already done
automatically devlink creation.
For instance, a driver can be bound to a device and, during the
probe(), the driver can walk its of-node children to get the GPIO
described in these children nodes.
In that case, an additional devlink between the device attached to the
driver and the gpio consumer need to be created.
Indeed, if the GPIO is removed, the consumer/supplier dependency should
lead to remove first the consuming driver before removing the supplier.

In order to give the possibility to this kind of driver to add additional
devlinks, introduce gpiod_device_add_link().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/gpio/gpiolib.c        | 32 ++++++++++++++++++++++++++++++++
 include/linux/gpio/consumer.h |  5 +++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8b3a0f45b574..416ab334b02d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4195,6 +4195,38 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 	return desc;
 }
 
+/**
+ * gpiod_device_add_link - Add a link between a GPIO consumer and a GPIO.
+ * @consumer: GPIO consumer.
+ * @desc: GPIO consumed.
+ * @flags: Link flags, see device_link_add().
+ *
+ * This function can be used for drivers that need to add an additional
+ * consumer/supplier device link to a GPIO.
+ *
+ * Returns:
+ * On successful, the link created.
+ * NULL if the link was not created due to a missing GPIO parent.
+ *
+ * In case of error an ERR_PTR() is returned.
+ */
+struct device_link *gpiod_device_add_link(struct device *consumer,
+					  struct gpio_desc *desc,
+					  u32 flags)
+{
+	struct device_link *link;
+
+	if (!desc->gdev->dev.parent)
+		return NULL;
+
+	link = device_link_add(consumer, desc->gdev->dev.parent, flags);
+	if (!link)
+		return ERR_PTR(-EINVAL);
+
+	return link;
+}
+EXPORT_SYMBOL_GPL(gpiod_device_add_link);
+
 /**
  * fwnode_gpiod_get_index - obtain a GPIO from firmware node
  * @fwnode:	handle of the firmware node
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index db2dfbae8edb..4feed4e166b0 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -7,6 +7,7 @@
 
 struct acpi_device;
 struct device;
+struct device_link;
 struct fwnode_handle;
 
 struct gpio_array;
@@ -106,6 +107,10 @@ void devm_gpiod_put(struct device *dev, struct gpio_desc *desc);
 void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc);
 void devm_gpiod_put_array(struct device *dev, struct gpio_descs *descs);
 
+struct device_link *gpiod_device_add_link(struct device *consumer,
+					  struct gpio_desc *desc,
+					  u32 flags);
+
 int gpiod_get_direction(struct gpio_desc *desc);
 int gpiod_direction_input(struct gpio_desc *desc);
 int gpiod_direction_output(struct gpio_desc *desc, int value);
-- 
2.43.0


