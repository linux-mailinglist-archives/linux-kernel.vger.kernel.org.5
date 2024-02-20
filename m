Return-Path: <linux-kernel+bounces-72877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FF885B9FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1541C24604
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B78A66B2B;
	Tue, 20 Feb 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BVyvJKXa"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C4465BD7;
	Tue, 20 Feb 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427439; cv=none; b=JRUqY9cJ/Sa1Cue5fjF6KnRaZKpUmH9JOYvh2Xq4VFSnmKo1mn3bDnt/0RUZmFma4wd0Zq8iMPh62XhSmKU6x7P5IXI2rH+4ST6vAMJmp9DVqIdM6dK19idPNfT8fQUYtba8k5u/j1yRmizWkX8wyXeENRWl2mC2UACMlP385uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427439; c=relaxed/simple;
	bh=+gtPF82Psk+0scOoKi//Kqv72HSichWCQkcD4dfiT54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nkmalsi8tThYEDQFzZqvPp4IjvTlFLFJ1S3e5b0hFKBCb4kQCZoEJYRF2L2VXIe8AwWtqsYcfftXzvbTg4j0NEqfIcgw5BMO3UcI0LVVZr3mWvehjA1Q1jsveXjyI21jtz/xEUVguUIjAMZbrHC9/9UtxbemkHpX9po7CDmSHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BVyvJKXa; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DF7C51BF216;
	Tue, 20 Feb 2024 11:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708427428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+dSIBMW24B1QEdw+4NnCXt+Ftn4RqDE56kLBoNW620=;
	b=BVyvJKXaQGyrX5QqXRvRovkMd9I52tgnpBvFb8sGJW2ToyYfkTjQSpmRPbC7MWlr87qARC
	UuykfAJ2Gzw/xw5HTJEEqnS9JgcllN4ozixRVIdJYUmaJ03EwrSA/HPHMJ0LyBIfwuFF1T
	Vn1eXzZi+zEtjlgWodDARgePGpWww+XhLl3uCVA3aeN0DFXy7cgyb1C+jG8yyVHnXCLaiV
	irE83aWO1lAbdCOCsco0uZvMOIkdgUuXesKYs7D8/MbzY6shCK+YPobQUfruQ4uRjyYmG/
	JGkV8ouvIR9DZ5KZSudRIcYRPo7yRuxpmIc3uM6rb3FMCWiLekvld3vCTbWM1g==
From: Herve Codina <herve.codina@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 2/2] gpiolib: cdev: release IRQs when the gpio chip device is removed
Date: Tue, 20 Feb 2024 12:10:18 +0100
Message-ID: <20240220111019.133697-3-herve.codina@bootlin.com>
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

Indeed, the gpio cdev uses an IRQ but this IRQ is not released when the
gpio chip device is removed.

Release IRQs used in the device removal notifier functions.
Also move one of these function definition in order to avoid a forward
declaration (move after the edge_detector_stop() definition).

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/gpio/gpiolib-cdev.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 2a88736629ef..aec4a4c8490a 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -688,17 +688,6 @@ static void line_set_debounce_period(struct line *line,
 	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE | \
 	 GPIO_V2_LINE_EDGE_FLAGS)
 
-static int linereq_unregistered_notify(struct notifier_block *nb,
-				       unsigned long action, void *data)
-{
-	struct linereq *lr = container_of(nb, struct linereq,
-					  device_unregistered_nb);
-
-	wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
-
-	return NOTIFY_OK;
-}
-
 static void linereq_put_event(struct linereq *lr,
 			      struct gpio_v2_line_event *le)
 {
@@ -1189,6 +1178,23 @@ static int edge_detector_update(struct line *line,
 	return edge_detector_setup(line, lc, line_idx, edflags);
 }
 
+static int linereq_unregistered_notify(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct linereq *lr = container_of(nb, struct linereq,
+					  device_unregistered_nb);
+	int i;
+
+	for (i = 0; i < lr->num_lines; i++) {
+		if (lr->lines[i].desc)
+			edge_detector_stop(&lr->lines[i]);
+	}
+
+	wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
+
+	return NOTIFY_OK;
+}
+
 static u64 gpio_v2_line_config_flags(struct gpio_v2_line_config *lc,
 				     unsigned int line_idx)
 {
@@ -1898,6 +1904,11 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
+	if (le->irq) {
+		free_irq(le->irq, le);
+		le->irq = 0;
+	}
+
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
 	return NOTIFY_OK;
-- 
2.43.0


