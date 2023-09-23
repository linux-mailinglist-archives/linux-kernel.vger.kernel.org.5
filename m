Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5E77AC2AD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjIWOcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjIWOcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:32:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1FD113;
        Sat, 23 Sep 2023 07:32:09 -0700 (PDT)
Received: from umang.lan (unknown [IPv6:2001:818:e7d2:8300:2412:6733:7e63:fb46])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AC3EF128D;
        Sat, 23 Sep 2023 16:30:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695479429;
        bh=2+THR7127i+SAsSXZ3cjqcejLvD97dI0zDmJEtXP0y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxiiGB1oPSZEfs0u6urLuJslqXRrx0EPq578Sdx1PUxRhhUGbxk7eA5M4nNEB8vUg
         CgDxpRVzVnGVFHqoj/6W/fDMOCfb89lGPHQITFzKO7BB2j98KscEQba2nBb1Tyag6F
         3rvcYvjT6Xp4+AqFi1nuFjVprXBWdcE7rcqqj0Y4=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v12 3/6] staging: vc04_services: vchiq_arm: Add new bus type and device type
Date:   Sat, 23 Sep 2023 20:01:57 +0530
Message-Id: <20230923143200.268063-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230923143200.268063-1-umang.jain@ideasonboard.com>
References: <20230923143200.268063-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devices that the vchiq interface registers (bcm2835-audio,
bcm2835-camera) are implemented and exposed by the VC04 firmware.
The device tree describes the VC04 itself with the resources required
to communicate with it through a mailbox interface. However, the
vchiq interface registers these devices as platform devices. This
also means the specific drivers for these devices are getting
registered as platform drivers. This is not correct and a blatant
abuse of platform device/driver.

Add a new bus type, vchiq_bus_type and device type (struct vchiq_device)
which will be used to migrate child devices that the vchiq interfaces
creates/registers from the platform device/driver.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/Makefile        |   1 +
 .../interface/vchiq_arm/vchiq_bus.c           | 100 ++++++++++++++++++
 .../interface/vchiq_arm/vchiq_bus.h           |  54 ++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h

diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index 44794bdf6173..e8b897a7b9a6 100644
--- a/drivers/staging/vc04_services/Makefile
+++ b/drivers/staging/vc04_services/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_BCM2835_VCHIQ)	+= vchiq.o
 vchiq-objs := \
    interface/vchiq_arm/vchiq_core.o  \
    interface/vchiq_arm/vchiq_arm.o \
+   interface/vchiq_arm/vchiq_bus.o \
    interface/vchiq_arm/vchiq_debugfs.o \
    interface/vchiq_arm/vchiq_connected.o \
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
new file mode 100644
index 000000000000..4ac3491efe45
--- /dev/null
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * vchiq_device.c - VCHIQ generic device and bus-type
+ *
+ * Copyright (c) 2023 Ideas On Board Oy
+ */
+
+#include <linux/device/bus.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "vchiq_bus.h"
+
+static int vchiq_bus_type_match(struct device *dev, struct device_driver *drv)
+{
+	if (dev->bus == &vchiq_bus_type &&
+	    strcmp(dev_name(dev), drv->name) == 0)
+		return true;
+
+	return false;
+}
+
+static int vchiq_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	const struct vchiq_device *device = container_of_const(dev, struct vchiq_device, dev);
+
+	return add_uevent_var(env, "MODALIAS=%s", dev_name(&device->dev));
+}
+
+static int vchiq_bus_probe(struct device *dev)
+{
+	struct vchiq_device *device = to_vchiq_device(dev);
+	struct vchiq_driver *driver = to_vchiq_driver(dev->driver);
+
+	return driver->probe(device);
+}
+
+struct bus_type vchiq_bus_type = {
+	.name   = "vchiq-bus",
+	.match  = vchiq_bus_type_match,
+	.uevent = vchiq_bus_uevent,
+	.probe  = vchiq_bus_probe,
+};
+
+static void vchiq_device_release(struct device *dev)
+{
+	struct vchiq_device *device = to_vchiq_device(dev);
+
+	kfree(device);
+}
+
+struct vchiq_device *
+vchiq_device_register(struct device *parent, const char *name)
+{
+	struct vchiq_device *device;
+	int ret;
+
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
+	if (!device)
+		return NULL;
+
+	device->dev.init_name = name;
+	device->dev.parent = parent;
+	device->dev.bus = &vchiq_bus_type;
+	device->dev.dma_mask = &device->dev.coherent_dma_mask;
+	device->dev.release = vchiq_device_release;
+
+	of_dma_configure(&device->dev, parent->of_node, true);
+
+	ret = device_register(&device->dev);
+	if (ret) {
+		dev_err(parent, "Cannot register %s: %d\n", name, ret);
+		put_device(&device->dev);
+		kfree(device);
+		return NULL;
+	}
+
+	return device;
+}
+
+void vchiq_device_unregister(struct vchiq_device *vchiq_dev)
+{
+	device_unregister(&vchiq_dev->dev);
+}
+
+int vchiq_driver_register(struct vchiq_driver *vchiq_drv)
+{
+	vchiq_drv->driver.bus = &vchiq_bus_type;
+
+	return driver_register(&vchiq_drv->driver);
+}
+EXPORT_SYMBOL_GPL(vchiq_driver_register);
+
+void vchiq_driver_unregister(struct vchiq_driver *vchiq_drv)
+{
+	driver_unregister(&vchiq_drv->driver);
+}
+EXPORT_SYMBOL_GPL(vchiq_driver_unregister);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
new file mode 100644
index 000000000000..7eaaf9a91cda
--- /dev/null
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Ideas On Board Oy
+ */
+
+#ifndef _VCHIQ_DEVICE_H
+#define _VCHIQ_DEVICE_H
+
+#include <linux/device.h>
+
+struct vchiq_device {
+	struct device dev;
+};
+
+struct vchiq_driver {
+	int		(*probe)(struct vchiq_device *device);
+	void		(*remove)(struct vchiq_device *device);
+	int		(*resume)(struct vchiq_device *device);
+	int		(*suspend)(struct vchiq_device *device,
+				   pm_message_t state);
+	struct device_driver driver;
+};
+
+static inline struct vchiq_device *to_vchiq_device(struct device *d)
+{
+	return container_of(d, struct vchiq_device, dev);
+}
+
+static inline struct vchiq_driver *to_vchiq_driver(struct device_driver *d)
+{
+	return container_of(d, struct vchiq_driver, driver);
+}
+
+extern struct bus_type vchiq_bus_type;
+
+struct vchiq_device *
+vchiq_device_register(struct device *parent, const char *name);
+void vchiq_device_unregister(struct vchiq_device *dev);
+
+int vchiq_driver_register(struct vchiq_driver *vchiq_drv);
+void vchiq_driver_unregister(struct vchiq_driver *vchiq_drv);
+
+/**
+ * module_vchiq_driver() - Helper macro for registering a vchiq driver
+ * @__vchiq_driver: vchiq driver struct
+ *
+ * Helper macro for vchiq drivers which do not do anything special in
+ * module init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_vchiq_driver(__vchiq_driver) \
+	module_driver(__vchiq_driver, vchiq_driver_register, vchiq_driver_unregister)
+
+#endif /* _VCHIQ_DEVICE_H */
-- 
2.40.1

