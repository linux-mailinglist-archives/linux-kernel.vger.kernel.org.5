Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D039875A560
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjGTFKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGTFKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:10:44 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3137113;
        Wed, 19 Jul 2023 22:10:43 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 3D01780F7;
        Thu, 20 Jul 2023 05:10:41 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] serial: core: Fix serial core port id to not use port->line
Date:   Thu, 20 Jul 2023 08:10:15 +0300
Message-ID: <20230720051021.14961-3-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720051021.14961-1-tony@atomide.com>
References: <20230720051021.14961-1-tony@atomide.com>
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

The serial core port id should be serial core controller specific port
instance, which is not always the port->line index.

For example, 8250 driver maps a number of legacy ports, and when a
hardware specific device driver takes over, we typically have one
driver instance for each port. Let's instead add port->port_id to
keep track serial ports mapped to each serial core controller instance.

Currently this is only a cosmetic issue for the serial core port device
names. The issue can be noticed looking at /sys/bus/serial-base/devices
for example though. Let's fix the issue to avoid port addressing issues
later on.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_core.c  | 2 ++
 drivers/tty/serial/serial_base_bus.c | 2 +-
 include/linux/serial_core.h          | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -497,6 +497,7 @@ static struct uart_8250_port *serial8250_setup_port(int index)
 
 	up = &serial8250_ports[index];
 	up->port.line = index;
+	up->port.port_id = index;
 
 	serial8250_init_port(up);
 	if (!base_ops)
@@ -1040,6 +1041,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 			uart_remove_one_port(&serial8250_reg, &uart->port);
 
 		uart->port.ctrl_id	= up->port.ctrl_id;
+		uart->port.port_id	= up->port.port_id;
 		uart->port.iobase       = up->port.iobase;
 		uart->port.membase      = up->port.membase;
 		uart->port.irq          = up->port.irq;
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -136,7 +136,7 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
 	err = serial_base_device_init(port, &port_dev->dev,
 				      &ctrl_dev->dev, &serial_port_type,
 				      serial_base_port_release,
-				      port->line);
+				      port->port_id);
 	if (err)
 		goto err_put_device;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -460,6 +460,7 @@ struct uart_port {
 	int			(*iso7816_config)(struct uart_port *,
 						  struct serial_iso7816 *iso7816);
 	unsigned int		ctrl_id;		/* optional serial core controller id */
+	unsigned int		port_id;		/* optional serial core port id */
 	unsigned int		irq;			/* irq number */
 	unsigned long		irqflags;		/* irq flags  */
 	unsigned int		uartclk;		/* base uart clock */
-- 
2.41.0
