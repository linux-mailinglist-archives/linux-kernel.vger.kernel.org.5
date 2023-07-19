Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21BA758CED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGSFQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGSFQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:16:22 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F0D01BF2;
        Tue, 18 Jul 2023 22:16:21 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 3501B80AA;
        Wed, 19 Jul 2023 05:16:19 +0000 (UTC)
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
Subject: [PATCH] serial: core: Add sysfs links for serial core port instances for ttys
Date:   Wed, 19 Jul 2023 08:16:11 +0300
Message-ID: <20230719051613.46569-1-tony@atomide.com>
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

Let's allow the userspace to find out the tty name for a serial core
controller id if a tty exists. This can be done with:

$ grep DEVNAME /sys/bus/serial-base/devices/port*/tty/uevent
/sys/bus/serial-base/devices/port.00:04.0/tty/uevent:DEVNAME=ttyS0
/sys/bus/serial-base/devices/port.serial8250.1/tty/uevent:DEVNAME=ttyS1
/sys/bus/serial-base/devices/port.serial8250.2/tty/uevent:DEVNAME=ttyS2
/sys/bus/serial-base/devices/port.serial8250.3/tty/uevent:DEVNAME=ttyS3

And with this, we can add /dev/serial/by-id symlinks to the serial port
device instances so we can start using serial core port addressing in
addition to the legacy ttyS naming.

The naming we can use is dev_name:0.0 where 0.0 are the serial core
controller id and port id, so for the ttyS0 example above the naming
would be 00:04.0:0.0.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Note that this depends on fix for serial core port ids patch
"[PATCH] serial: core: Fix serial core port id to not use port->line"

---
 drivers/tty/serial/serial_core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3371,6 +3371,8 @@ static int serial_core_add_preferred_console(struct uart_driver *drv,
 int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 {
 	struct serial_ctrl_device *ctrl_dev, *new_ctrl_dev = NULL;
+	struct uart_match match = {port, drv};
+	struct device *tty_dev;
 	int ret;
 
 	mutex_lock(&port_mutex);
@@ -3411,10 +3413,21 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 
 	port->flags &= ~UPF_DEAD;
 
+	tty_dev = device_find_child(port->dev, &match, serial_match_port);
+	if (tty_dev) {
+		ret = sysfs_create_link(&port->port_dev->dev.kobj, &tty_dev->kobj,
+					"tty");
+		if (ret)
+			goto err_remove_port;
+	}
+
 	mutex_unlock(&port_mutex);
 
 	return 0;
 
+err_remove_port:
+	serial_core_remove_one_port(drv, port);
+
 err_unregister_port_dev:
 	serial_base_port_device_remove(port->port_dev);
 
@@ -3436,12 +3449,18 @@ void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port
 	struct device *phys_dev = port->dev;
 	struct serial_port_device *port_dev = port->port_dev;
 	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
+	struct uart_match match = {port, drv};
 	int ctrl_id = port->ctrl_id;
+	struct device *tty_dev;
 
 	mutex_lock(&port_mutex);
 
 	port->flags |= UPF_DEAD;
 
+	tty_dev = device_find_child(port->dev, &match, serial_match_port);
+	if (tty_dev)
+		sysfs_remove_link(&port->port_dev->dev.kobj, "tty");
+
 	serial_core_remove_one_port(drv, port);
 
 	/* Note that struct uart_port *port is no longer valid at this point */
-- 
2.41.0
