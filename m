Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1A77D4EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjJXLgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJXLgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:36:35 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74A5F10C2;
        Tue, 24 Oct 2023 04:36:31 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id C621980AA;
        Tue, 24 Oct 2023 11:36:28 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [RFC PATCH 1/2] serial: core: Move tty and serdev to be children of serial core port device
Date:   Tue, 24 Oct 2023 14:36:18 +0300
Message-ID: <20231024113624.54364-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move tty and serdev controller to be children of the serial core port
device. This way the runtime PM usage count of a child device propagates
to the serial hardware device.

The tty and serdev devices are associated with a specific serial port of
a serial hardware controller device, and we now have serial core hierarchy
of controllers and ports.

The tty device moves happily with just a change of the parent device.
The serdev device init needs some changes to separate the serial hardware
controller device from the parent device.

Suggested-by: Johan Hovold <johan@kernel.org>
Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

AFAIK no urgent need to for these, will repost after the merge window

---
 drivers/tty/serdev/core.c           | 15 +++++++++------
 drivers/tty/serdev/serdev-ttyport.c |  3 ++-
 drivers/tty/serial/serial_core.c    |  3 ++-
 drivers/tty/tty_port.c              | 16 +++++++++-------
 include/linux/serdev.h              |  8 +++++++-
 include/linux/tty_port.h            |  4 ++--
 6 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -476,6 +476,7 @@ EXPORT_SYMBOL_GPL(serdev_device_alloc);
 
 /**
  * serdev_controller_alloc() - Allocate a new serdev controller
+ * @host:	serial port hardware controller device
  * @parent:	parent device
  * @size:	size of private data
  *
@@ -484,8 +485,9 @@ EXPORT_SYMBOL_GPL(serdev_device_alloc);
  * The allocated private data region may be accessed via
  * serdev_controller_get_drvdata()
  */
-struct serdev_controller *serdev_controller_alloc(struct device *parent,
-					      size_t size)
+struct serdev_controller *serdev_controller_alloc(struct device *host,
+						  struct device *parent,
+						  size_t size)
 {
 	struct serdev_controller *ctrl;
 	int id;
@@ -510,7 +512,8 @@ struct serdev_controller *serdev_controller_alloc(struct device *parent,
 	ctrl->dev.type = &serdev_ctrl_type;
 	ctrl->dev.bus = &serdev_bus_type;
 	ctrl->dev.parent = parent;
-	ctrl->dev.of_node = parent->of_node;
+	ctrl->host = host;
+	ctrl->dev.of_node = host->of_node;
 	serdev_controller_set_drvdata(ctrl, &ctrl[1]);
 
 	dev_set_name(&ctrl->dev, "serial%d", id);
@@ -673,7 +676,7 @@ static int acpi_serdev_check_resources(struct serdev_controller *ctrl,
 		acpi_get_parent(adev->handle, &lookup.controller_handle);
 
 	/* Make sure controller and ResourceSource handle match */
-	if (ACPI_HANDLE(ctrl->dev.parent) != lookup.controller_handle)
+	if (ACPI_HANDLE(ctrl->host) != lookup.controller_handle)
 		return -ENODEV;
 
 	return 0;
@@ -738,7 +741,7 @@ static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
 	bool skip;
 	int ret;
 
-	if (!has_acpi_companion(ctrl->dev.parent))
+	if (!has_acpi_companion(ctrl->host))
 		return -ENODEV;
 
 	/*
@@ -747,7 +750,7 @@ static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
 	 * succeed in this case, so that the proper serdev devices can be
 	 * added "manually" later.
 	 */
-	ret = acpi_quirk_skip_serdev_enumeration(ctrl->dev.parent, &skip);
+	ret = acpi_quirk_skip_serdev_enumeration(ctrl->host, &skip);
 	if (ret)
 		return ret;
 	if (skip)
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -274,6 +274,7 @@ static const struct serdev_controller_ops ctrl_ops = {
 };
 
 struct device *serdev_tty_port_register(struct tty_port *port,
+					struct device *host,
 					struct device *parent,
 					struct tty_driver *drv, int idx)
 {
@@ -284,7 +285,7 @@ struct device *serdev_tty_port_register(struct tty_port *port,
 	if (!port || !drv || !parent)
 		return ERR_PTR(-ENODEV);
 
-	ctrl = serdev_controller_alloc(parent, sizeof(struct serport));
+	ctrl = serdev_controller_alloc(host, parent, sizeof(struct serport));
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 	serport = serdev_controller_get_drvdata(ctrl);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3153,7 +3153,8 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	 * setserial to be used to alter this port's parameters.
 	 */
 	tty_dev = tty_port_register_device_attr_serdev(port, drv->tty_driver,
-			uport->line, uport->dev, port, uport->tty_groups);
+			uport->line, uport->dev, &uport->port_dev->dev, port,
+			uport->tty_groups);
 	if (!IS_ERR(tty_dev)) {
 		device_set_wakeup_capable(tty_dev, 1);
 	} else {
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -171,7 +171,8 @@ EXPORT_SYMBOL_GPL(tty_port_register_device_attr);
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
- * @device: parent if exists, otherwise NULL
+ * @host: serial port hardware device
+ * @parent: parent if exists, otherwise NULL
  * @drvdata: driver data for the device
  * @attr_grp: attribute group for the device
  *
@@ -180,20 +181,20 @@ EXPORT_SYMBOL_GPL(tty_port_register_device_attr);
  */
 struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
-		struct device *device, void *drvdata,
+		struct device *host, struct device *parent, void *drvdata,
 		const struct attribute_group **attr_grp)
 {
 	struct device *dev;
 
 	tty_port_link_device(port, driver, index);
 
-	dev = serdev_tty_port_register(port, device, driver, index);
+	dev = serdev_tty_port_register(port, host, parent, driver, index);
 	if (PTR_ERR(dev) != -ENODEV) {
 		/* Skip creating cdev if we registered a serdev device */
 		return dev;
 	}
 
-	return tty_register_device_attr(driver, index, device, drvdata,
+	return tty_register_device_attr(driver, index, parent, drvdata,
 			attr_grp);
 }
 EXPORT_SYMBOL_GPL(tty_port_register_device_attr_serdev);
@@ -203,17 +204,18 @@ EXPORT_SYMBOL_GPL(tty_port_register_device_attr_serdev);
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
- * @device: parent if exists, otherwise NULL
+ * @host: serial port hardware controller device
+ * @parent: parent if exists, otherwise NULL
  *
  * Register a serdev or tty device depending on if the parent device has any
  * defined serdev clients or not.
  */
 struct device *tty_port_register_device_serdev(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
-		struct device *device)
+		struct device *host, struct device *parent)
 {
 	return tty_port_register_device_attr_serdev(port, driver, index,
-			device, NULL, NULL);
+			host, parent, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(tty_port_register_device_serdev);
 
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -99,12 +99,14 @@ struct serdev_controller_ops {
 /**
  * struct serdev_controller - interface to the serdev controller
  * @dev:	Driver model representation of the device.
+ * @host:	Serial port hardware controller device
  * @nr:		number identifier for this controller/bus.
  * @serdev:	Pointer to slave device for this controller.
  * @ops:	Controller operations.
  */
 struct serdev_controller {
 	struct device		dev;
+	struct device		*host;
 	unsigned int		nr;
 	struct serdev_device	*serdev;
 	const struct serdev_controller_ops *ops;
@@ -167,7 +169,9 @@ struct serdev_device *serdev_device_alloc(struct serdev_controller *);
 int serdev_device_add(struct serdev_device *);
 void serdev_device_remove(struct serdev_device *);
 
-struct serdev_controller *serdev_controller_alloc(struct device *, size_t);
+struct serdev_controller *serdev_controller_alloc(struct device *host,
+						  struct device *parent,
+						  size_t);
 int serdev_controller_add(struct serdev_controller *);
 void serdev_controller_remove(struct serdev_controller *);
 
@@ -311,11 +315,13 @@ struct tty_driver;
 
 #ifdef CONFIG_SERIAL_DEV_CTRL_TTYPORT
 struct device *serdev_tty_port_register(struct tty_port *port,
+					struct device *host,
 					struct device *parent,
 					struct tty_driver *drv, int idx);
 int serdev_tty_port_unregister(struct tty_port *port);
 #else
 static inline struct device *serdev_tty_port_register(struct tty_port *port,
+					   struct device *host,
 					   struct device *parent,
 					   struct tty_driver *drv, int idx)
 {
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -149,10 +149,10 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
 		const struct attribute_group **attr_grp);
 struct device *tty_port_register_device_serdev(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
-		struct device *device);
+		struct device *host, struct device *parent);
 struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
-		struct device *device, void *drvdata,
+		struct device *host, struct device *parent, void *drvdata,
 		const struct attribute_group **attr_grp);
 void tty_port_unregister_device(struct tty_port *port,
 		struct tty_driver *driver, unsigned index);

base-commit: 6f699743aebf07538e506a46c5965eb8bdd2c716
-- 
2.42.0
