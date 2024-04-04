Return-Path: <linux-kernel+bounces-131047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43DF89825D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CCD1F259C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3984A5C8F4;
	Thu,  4 Apr 2024 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o0LXJNsJ"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D75F433B0;
	Thu,  4 Apr 2024 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216705; cv=none; b=FBN8K/4y08HVX6UkZp1+ssvo/NExA/vtsb8AXOrp/cB+k5M9vIY6sc++ESh2JUisWaYTtiC5siUQOqV0pY/E4VN9/vvZfxTmH+MqKZj4wzLpmZSD8HA0R5+l8RRQ57kTKW/Dq4aeEvAGAaHhmqHq4xoTePx5ni1BerF+dUDQy/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216705; c=relaxed/simple;
	bh=kJNlUmuT+uSoa9cveBbwIGJVle08lX4eiQ8PecQGYf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bd97IVGOxSJiFKD5jxdSmsPTs/eLfqGqbAzp2cAQ2bQDeFBToE+MEFyhN9HfGYp19JbJZC45m2n9kH5/j7SNF6dDmSMfYOfJ60B6FUzkSOO5ERtYVOqMOD4k3SEIkD3h0cmR7NPLsfXoUO5xeypOgK5hEhrYdUKM0vE5Q9ToI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o0LXJNsJ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 93D0B240008;
	Thu,  4 Apr 2024 07:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712216695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iX+0Ymm9a4nCLp3+QhB61amQXiz0tKdtmoelt1SlXa4=;
	b=o0LXJNsJoEqqF7dx0rz2H3P2ma2Rha0X+mhddsUpSHA8W5J14YzTGMicTgIh8DP+UdJQtR
	Kl8kqXrVBZPAUopLTjbTRD8gYj3HIwUzO8VwHiCTPuPT566Lydjbdew/LO/D9/YArNLQQX
	iD3eTNZOBP1yGiY8lEejWLRqvj6260HDUbXdkviYI5K9SJ8OBmKWHYF2bZWkou9CLmU5ob
	YJaoso3ATLZKWyfVAMEXQe/6r/zW7TLbpNMJZfkR1PBtQJUTePOWBpYS/IWcfTTd9/iyPi
	c56rX2dCok85syDHTSQbWtb56h99V7Ilz6mdme2a/P17C/CTv4aR+01qLXf3mA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: bastien.curutchet@bootlin.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH 1/1] serial: 8250_of: Add clock_notifier
Date: Thu,  4 Apr 2024 09:44:50 +0200
Message-ID: <20240404074450.42708-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

The UART's input clock rate can change at runtime but this is not
handled by the driver.

Add a clock_notifier callback that updates the divisors when the input
clock is updated. The serial8250_update_uartclk() is used to do so.
PRE_RATE_CHANGE and ABORT_RATE_CHANGE notifications are ignored, only
the POST_RATE_CHANGE is used.

Reorder the #include to match alphabetic order.

It has been tested on a DAVINCI/OMAP-L138 processor.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/tty/serial/8250/8250_of.c | 48 ++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 5d1dd992d8fb..6d570164d906 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -6,18 +6,19 @@
  */
 
 #include <linux/bits.h>
+#include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/math.h>
 #include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/serial_core.h>
-#include <linux/serial_reg.h>
+#include <linux/notifier.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
-#include <linux/clk.h>
 #include <linux/reset.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/slab.h>
 
 #include "8250.h"
 
@@ -26,6 +27,7 @@ struct of_serial_info {
 	struct reset_control *rst;
 	int type;
 	int line;
+	struct notifier_block clk_notifier;
 };
 
 /* Nuvoton NPCM timeout register */
@@ -58,6 +60,29 @@ static int npcm_setup(struct uart_port *port)
 	return 0;
 }
 
+static inline struct of_serial_info *clk_nb_to_info(struct notifier_block *nb)
+{
+	return container_of(nb, struct of_serial_info, clk_notifier);
+}
+
+static int of_platform_serial_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
+					      void *data)
+{
+	struct of_serial_info *info = clk_nb_to_info(nb);
+	struct uart_8250_port *port8250 = serial8250_get_port(info->line);
+	struct clk_notifier_data *ndata = data;
+
+	if (IS_ERR(info->clk))
+		return NOTIFY_DONE;
+
+	if (event == POST_RATE_CHANGE) {
+		serial8250_update_uartclk(&port8250->port, ndata->new_rate);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
 /*
  * Fill a struct uart_port for a given device node
  */
@@ -218,7 +243,19 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	info->type = port_type;
 	info->line = ret;
 	platform_set_drvdata(ofdev, info);
+
+	if (info->clk) {
+		info->clk_notifier.notifier_call = of_platform_serial_clk_notifier_cb;
+		ret = clk_notifier_register(info->clk, &info->clk_notifier);
+		if (ret) {
+			dev_err_probe(port8250.port.dev, ret, "Failed to set the clock notifier\n");
+			goto err_unregister;
+		}
+	}
+
 	return 0;
+err_unregister:
+	serial8250_unregister_port(info->line);
 err_dispose:
 	pm_runtime_put_sync(&ofdev->dev);
 	pm_runtime_disable(&ofdev->dev);
@@ -234,6 +271,9 @@ static void of_platform_serial_remove(struct platform_device *ofdev)
 {
 	struct of_serial_info *info = platform_get_drvdata(ofdev);
 
+	if (info->clk)
+		clk_notifier_unregister(info->clk, &info->clk_notifier);
+
 	serial8250_unregister_port(info->line);
 
 	reset_control_assert(info->rst);
-- 
2.44.0


