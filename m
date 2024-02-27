Return-Path: <linux-kernel+bounces-83131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 390AA868EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92193B22CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A5113A255;
	Tue, 27 Feb 2024 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MzHA2jzs"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744E0130ADF;
	Tue, 27 Feb 2024 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033683; cv=none; b=NFeIgETMa2T3esTzYSq6yrgttcBiO0bINfbplsWly0G2IHVd/LsZch7Gr23/vgHv21x73cYmYHOn6nuMu88i9N4p8dQePS8YnsJJGmtdszgUWZGfNPVD5MrVTtTs4x1oAUfuOO0rahfcEvn2AfX2+jQvwt1aMMjqszNG6a+hDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033683; c=relaxed/simple;
	bh=Bg7CrCHk8qTVzw8D5kTnaxr6RqBt1zINI31UQ7JKYi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyUViIAaolpYHxK7FlW9l6OLO/dtDt3q28HZ2bl0mqBakhQrhMrBkxw6u58yH9mJv9WswRW7aLXXj9cKUnCt6OVdH9gfeFoHZjW/88Nd9CT7WJzjSUpxhfLRHprtuwcTJL2WNyIihPRR/WHMWf4mI9tk5CXUSmV2fPtQV9Icj+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MzHA2jzs; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4176E1C0010;
	Tue, 27 Feb 2024 11:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709033678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7WNC75978u3FnRvqua2g0x3X53QY3+13gx9/jOUJyE=;
	b=MzHA2jzsWuaKvAoMqzuVbPeM/fg/szQ9gQSyJdwcwimmuGWmR9iiA6pg8/A3bd7GP6HlqA
	FT7ofzCj8Dy9vRPQ2o2fKZjt4iYuuyEFn68ulBj9uvc/upMmhJwF7u7RT3phD9sYdFXHqI
	A0XuAvfXCVefPUH48olX2YcNxAHeo0FKbqE1iBh5fh9H5DUFwwvvlV317/p2+/zm32yb0i
	L/gg+5t2y9vvmGAMXW32BGDOAtuJdrSnBkcyvbchPbbOEfDObKItUXThnX8GAJGHUNOGtv
	R3HuO7IxIZ2U3cHrxGeoo0Y2euPdNvZJSrgf1sKnKkk6a6bsb804KhiIY/eJEg==
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
Subject: [PATCH v2 2/2] gpiolib: cdev: release IRQs when the gpio chip device is removed
Date: Tue, 27 Feb 2024 12:34:25 +0100
Message-ID: <20240227113426.253232-3-herve.codina@bootlin.com>
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
index f384fa278764..96c05bd326d0 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -682,17 +682,6 @@ static void line_set_debounce_period(struct line *line,
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
@@ -1183,6 +1172,23 @@ static int edge_detector_update(struct line *line,
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
@@ -1892,6 +1898,11 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
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


