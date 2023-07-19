Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18CE758CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjGSFPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGSFPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:15:35 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEDA01BF2;
        Tue, 18 Jul 2023 22:15:33 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 98A9280AA;
        Wed, 19 Jul 2023 05:15:31 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: core: Add support for dev_name:0.0 naming for kernel console
Date:   Wed, 19 Jul 2023 08:15:23 +0300
Message-ID: <20230719051525.46494-1-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the serial core controller related changes we can now start
addressing serial ports with dev_name:0.0 naming. The names are something
like 00:04.0:0.0 on qemu, and 2800000.serial.0:0.0 on ARM for example.

The dev_name is unique serial port hardware controller device name, also
known as port->dev, and 0.0 are the serial core controller id and port id.

Typically 0.0 are used for each controller and port instance unless the
serial port hardware controller has multiple controllers or ports.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Note that this depends on fix for serial core port ids patch
"[PATCH] serial: core: Fix serial core port id to not use port->line"

---
 drivers/tty/serial/serial_core.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3322,6 +3322,49 @@ static int serial_core_port_device_add(struct serial_ctrl_device *ctrl_dev,
 	return 0;
 }
 
+/*
+ * Add preferred console if configured on kernel command line with naming
+ * "console=dev_name:0.0".
+ */
+static int serial_core_add_preferred_console(struct uart_driver *drv,
+					     struct uart_port *port)
+{
+	char *port_match, *opt, *name;
+	int len, ret = 0;
+
+	port_match = kasprintf(GFP_KERNEL, "console=%s:%i.%i",
+			       dev_name(port->dev), port->ctrl_id,
+			       port->port_id);
+	if (!port_match)
+		return -ENOMEM;
+
+	opt = strstr(saved_command_line, port_match);
+	if (!opt)
+		goto free_port_match;
+
+	len = strlen(port_match);
+
+	if (strlen(opt) > len + 1 && opt[len] == ',')
+		opt += len + 1;
+	else
+		opt = NULL;
+
+	name = kstrdup(drv->dev_name, GFP_KERNEL);
+	if (!name) {
+		ret = -ENOMEM;
+		goto free_port_match;
+	}
+
+	add_preferred_console(name, port->line, opt);
+
+	kfree(name);
+
+free_port_match:
+	kfree(port_match);
+
+	return ret;
+}
+
 /*
  * Initialize a serial core port device, and a controller device if needed.
  */
@@ -3358,6 +3401,10 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 	if (ret)
 		goto err_unregister_ctrl_dev;
 
+	ret = serial_core_add_preferred_console(drv, port);
+	if (ret)
+		goto err_unregister_port_dev;
+
 	ret = serial_core_add_one_port(drv, port);
 	if (ret)
 		goto err_unregister_port_dev;
-- 
2.41.0
