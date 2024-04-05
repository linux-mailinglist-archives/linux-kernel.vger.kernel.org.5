Return-Path: <linux-kernel+bounces-132947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A21899C57
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AE32839C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BF316C842;
	Fri,  5 Apr 2024 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jUV6/BWI"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7146416ABCE;
	Fri,  5 Apr 2024 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318766; cv=none; b=KeYlA2+yU8P3QNBnxvFxQfv/kNpz+eezSB6u+4RV5YbJS3NbOc4vwVeWgv5IiIgb6ky3jfymZ0Xll0IqO36FdfaQ5kl/A+nqpeaauE7wWkn3CBqeDkR0KIVZ0jWEPPbPKHhFogIVB38050ycbfF5mwaGQkfJxYqSEbRliINvjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318766; c=relaxed/simple;
	bh=3SOawKf7ShxwVuliq6PEQpm/4ZVoz/cacxEBlBkgzko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPCMyYBVbbE+/aw9c6OutP+ep15AL3s9TRXsyujf23pEIQr9aSfWKC5EwARNSB+H26SydkLbbuJHbbOvAThQod4bgjTCuboTx5WsDx60+Pvx1nusMzWlLXmSmoo4HTxqUSccuMmM9rb6aUVNuz3IWf4kMzn4xSKJ8EnCfqsOGYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jUV6/BWI; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id CBB5C60009;
	Fri,  5 Apr 2024 12:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712318755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dLx+yQeXl9X7vSpjKyi2n2Z3bqsnNuxCnQzI/RO3bx4=;
	b=jUV6/BWIzPQt0r3RaYyWkUQFqzRMNk8l0YxD4DVH2/yWPbRsNZ6Bw6J2VKFlY+h96jrT5a
	ns72dPJFsEjb4hK4iauxpCr9U2/n3infaHmdtGnNjqBzOmT3hEU8w9V/u9cG80nt2OzWBi
	sl1HwQnsAKA/kw7w35QYh4xx07m7di2Xi16zneYKgE2FvtXTWMX8v+TmCLhwuujZc4qSMH
	mkudrvXCrgiYVb9ZsQ7//jKwZMmFdBv97JtwBHrMtRzTEXGDC69h2vaY9FmbI1Y0MQbGwd
	H5oknzmopj66WdEHTcuMNz9rs4OR5L+vkx8Ep7+KC44bCuoL+cvwMn1V9ic3BA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: bastien.curutchet@bootlin.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH v2 1/1] serial: 8250_of: Add clock_notifier
Date: Fri,  5 Apr 2024 14:05:52 +0200
Message-ID: <20240405120552.35991-1-bastien.curutchet@bootlin.com>
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
the POST_RATE_CHANGE is used. Not using PRE_RATE_CHANGE notification can
result in a few corrupted bytes during frequency transitions but, IMHO,
it can be acceptable in many use cases.

It has been tested on a DAVINCI/OMAP-L138 processor.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
Change log v1 -> v2:
 * Add details in commit log
 * Drop alphabetic order in #include
 * Drop a useless check in notifier callback

v1 : https://lore.kernel.org/all/20240404074450.42708-1-bastien.curutchet@bootlin.com/
 drivers/tty/serial/8250/8250_of.c | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 5d1dd992d8fb..e14f47ef1172 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
+#include <linux/notifier.h>
 
 #include "8250.h"
 
@@ -26,6 +27,7 @@ struct of_serial_info {
 	struct reset_control *rst;
 	int type;
 	int line;
+	struct notifier_block clk_notifier;
 };
 
 /* Nuvoton NPCM timeout register */
@@ -58,6 +60,26 @@ static int npcm_setup(struct uart_port *port)
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
@@ -218,7 +240,19 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
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
@@ -234,6 +268,9 @@ static void of_platform_serial_remove(struct platform_device *ofdev)
 {
 	struct of_serial_info *info = platform_get_drvdata(ofdev);
 
+	if (info->clk)
+		clk_notifier_unregister(info->clk, &info->clk_notifier);
+
 	serial8250_unregister_port(info->line);
 
 	reset_control_assert(info->rst);
-- 
2.44.0


