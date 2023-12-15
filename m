Return-Path: <linux-kernel+bounces-482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA528141D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0A61F2286E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A36DCA6B;
	Fri, 15 Dec 2023 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fpgc5/y6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B98CA66
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702621885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1obWbnJ0026cx1BJ2Tc4JP3qNtZVF/ZnzyVR8LPU+UA=;
	b=fpgc5/y6I7J7V6qJvLR93Re4mWqfdw6gJr66y3fSRwsyC94AJHaJjkhFKc6Q79qE3+tzk+
	ISMGs/uWhboORcLcYggydOSTqoAzczspJBUW3BjpIpSDe8JEIwKVKaMCGPYBcx96B1APjv
	81ci2BoMTKYLNtj8hSrzKsxKKwtl5R0=
From: Yajun Deng <yajun.deng@linux.dev>
To: gregkh@linuxfoundation.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	wg@grandegger.com,
	mkl@pengutronix.de,
	aspriel@gmail.com,
	franky.lin@broadcom.com,
	hante.meuleman@broadcom.com,
	kvalo@kernel.org,
	briannorris@chromium.org,
	mka@chromium.org,
	johan@kernel.org,
	oneukum@suse.com,
	stern@rowland.harvard.edu,
	valentina.manea.m@gmail.com,
	shuah@kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] USB: core: Use device_driver directly in struct usb_driver and usb_device_driver
Date: Fri, 15 Dec 2023 14:31:01 +0800
Message-Id: <20231215063101.792991-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is usbdrv_wrap in struct usb_driver and usb_device_driver,
it contains device_driver and for_devices. for_devices is used to
distinguish between device drivers and interface drivers.

We can compare that if 'drv->probe' is equal to usb_probe_device instead
of using for_devices in is_usb_device_driver().

Remove struct usbdrv_wrap, use device_driver directly in struct usb_driver
and usb_device_driver. This makes the code more concise.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/bluetooth/btusb.c                     |  6 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  2 +-
 .../broadcom/brcm80211/brcmfmac/usb.c         |  2 +-
 drivers/net/wireless/marvell/mwifiex/usb.c    |  2 +-
 drivers/usb/core/driver.c                     | 56 +++++++++----------
 drivers/usb/core/usb.c                        |  2 +-
 drivers/usb/core/usb.h                        |  7 ++-
 drivers/usb/misc/onboard_usb_hub.c            |  2 +-
 drivers/usb/serial/bus.c                      |  2 +-
 drivers/usb/serial/usb-serial.c               |  2 +-
 drivers/usb/storage/uas.c                     |  2 +-
 drivers/usb/usbip/stub_main.c                 |  8 +--
 include/linux/usb.h                           | 24 +++-----
 13 files changed, 52 insertions(+), 65 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0926e4451802..e02839c1764b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4794,10 +4794,8 @@ static struct usb_driver btusb_driver = {
 	.disable_hub_initiated_lpm = 1,
 
 #ifdef CONFIG_DEV_COREDUMP
-	.drvwrap = {
-		.driver = {
-			.coredump = btusb_coredump,
-		},
+	.driver = {
+		.coredump = btusb_coredump,
 	},
 #endif
 };
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 24ad9f593a77..1efa39e134f4 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -1143,7 +1143,7 @@ static void __exit peak_usb_exit(void)
 	int err;
 
 	/* last chance do send any synchronous commands here */
-	err = driver_for_each_device(&peak_usb_driver.drvwrap.driver, NULL,
+	err = driver_for_each_device(&peak_usb_driver.driver, NULL,
 				     NULL, peak_usb_do_device_exit);
 	if (err)
 		pr_err("%s: failed to stop all can devices (err %d)\n",
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 2178675ae1a4..0ccf735316c2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1581,7 +1581,7 @@ static int brcmf_usb_reset_device(struct device *dev, void *notused)
 
 void brcmf_usb_exit(void)
 {
-	struct device_driver *drv = &brcmf_usbdrvr.drvwrap.driver;
+	struct device_driver *drv = &brcmf_usbdrvr.driver;
 	int ret;
 
 	brcmf_dbg(USB, "Enter\n");
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index d3ab9572e711..515e6db410f2 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -687,7 +687,7 @@ static struct usb_driver mwifiex_usb_driver = {
 	.suspend = mwifiex_usb_suspend,
 	.resume = mwifiex_usb_resume,
 	.soft_unbind = 1,
-	.drvwrap.driver = {
+	.driver = {
 		.coredump = mwifiex_usb_coredump,
 	},
 };
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 1dc0c0413043..fa24fe804c91 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -189,13 +189,13 @@ static int usb_create_newid_files(struct usb_driver *usb_drv)
 		goto exit;
 
 	if (usb_drv->probe != NULL) {
-		error = driver_create_file(&usb_drv->drvwrap.driver,
+		error = driver_create_file(&usb_drv->driver,
 					   &driver_attr_new_id);
 		if (error == 0) {
-			error = driver_create_file(&usb_drv->drvwrap.driver,
+			error = driver_create_file(&usb_drv->driver,
 					&driver_attr_remove_id);
 			if (error)
-				driver_remove_file(&usb_drv->drvwrap.driver,
+				driver_remove_file(&usb_drv->driver,
 						&driver_attr_new_id);
 		}
 	}
@@ -209,9 +209,9 @@ static void usb_remove_newid_files(struct usb_driver *usb_drv)
 		return;
 
 	if (usb_drv->probe != NULL) {
-		driver_remove_file(&usb_drv->drvwrap.driver,
+		driver_remove_file(&usb_drv->driver,
 				&driver_attr_remove_id);
-		driver_remove_file(&usb_drv->drvwrap.driver,
+		driver_remove_file(&usb_drv->driver,
 				   &driver_attr_new_id);
 	}
 }
@@ -246,7 +246,7 @@ static const struct usb_device_id *usb_match_dynamic_id(struct usb_interface *in
 
 
 /* called from driver core with dev locked */
-static int usb_probe_device(struct device *dev)
+int usb_probe_device(struct device *dev)
 {
 	struct usb_device_driver *udriver = to_usb_device_driver(dev->driver);
 	struct usb_device *udev = to_usb_device(dev);
@@ -552,7 +552,7 @@ int usb_driver_claim_interface(struct usb_driver *driver,
 	if (!iface->authorized)
 		return -ENODEV;
 
-	dev->driver = &driver->drvwrap.driver;
+	dev->driver = &driver->driver;
 	usb_set_intfdata(iface, data);
 	iface->needs_binding = 0;
 
@@ -615,7 +615,7 @@ void usb_driver_release_interface(struct usb_driver *driver,
 	struct device *dev = &iface->dev;
 
 	/* this should never happen, don't release something that's not ours */
-	if (!dev->driver || dev->driver != &driver->drvwrap.driver)
+	if (!dev->driver || dev->driver != &driver->driver)
 		return;
 
 	/* don't release from within disconnect() */
@@ -950,7 +950,7 @@ static int __usb_bus_reprobe_drivers(struct device *dev, void *data)
 	int ret;
 
 	/* Don't reprobe if current driver isn't usb_generic_driver */
-	if (dev->driver != &usb_generic_driver.drvwrap.driver)
+	if (dev->driver != &usb_generic_driver.driver)
 		return 0;
 
 	udev = to_usb_device(dev);
@@ -983,15 +983,14 @@ int usb_register_device_driver(struct usb_device_driver *new_udriver,
 	if (usb_disabled())
 		return -ENODEV;
 
-	new_udriver->drvwrap.for_devices = 1;
-	new_udriver->drvwrap.driver.name = new_udriver->name;
-	new_udriver->drvwrap.driver.bus = &usb_bus_type;
-	new_udriver->drvwrap.driver.probe = usb_probe_device;
-	new_udriver->drvwrap.driver.remove = usb_unbind_device;
-	new_udriver->drvwrap.driver.owner = owner;
-	new_udriver->drvwrap.driver.dev_groups = new_udriver->dev_groups;
+	new_udriver->driver.name = new_udriver->name;
+	new_udriver->driver.bus = &usb_bus_type;
+	new_udriver->driver.probe = usb_probe_device;
+	new_udriver->driver.remove = usb_unbind_device;
+	new_udriver->driver.owner = owner;
+	new_udriver->driver.dev_groups = new_udriver->dev_groups;
 
-	retval = driver_register(&new_udriver->drvwrap.driver);
+	retval = driver_register(&new_udriver->driver);
 
 	if (!retval) {
 		pr_info("%s: registered new device driver %s\n",
@@ -1023,7 +1022,7 @@ void usb_deregister_device_driver(struct usb_device_driver *udriver)
 	pr_info("%s: deregistering device driver %s\n",
 			usbcore_name, udriver->name);
 
-	driver_unregister(&udriver->drvwrap.driver);
+	driver_unregister(&udriver->driver);
 }
 EXPORT_SYMBOL_GPL(usb_deregister_device_driver);
 
@@ -1051,18 +1050,17 @@ int usb_register_driver(struct usb_driver *new_driver, struct module *owner,
 	if (usb_disabled())
 		return -ENODEV;
 
-	new_driver->drvwrap.for_devices = 0;
-	new_driver->drvwrap.driver.name = new_driver->name;
-	new_driver->drvwrap.driver.bus = &usb_bus_type;
-	new_driver->drvwrap.driver.probe = usb_probe_interface;
-	new_driver->drvwrap.driver.remove = usb_unbind_interface;
-	new_driver->drvwrap.driver.owner = owner;
-	new_driver->drvwrap.driver.mod_name = mod_name;
-	new_driver->drvwrap.driver.dev_groups = new_driver->dev_groups;
+	new_driver->driver.name = new_driver->name;
+	new_driver->driver.bus = &usb_bus_type;
+	new_driver->driver.probe = usb_probe_interface;
+	new_driver->driver.remove = usb_unbind_interface;
+	new_driver->driver.owner = owner;
+	new_driver->driver.mod_name = mod_name;
+	new_driver->driver.dev_groups = new_driver->dev_groups;
 	spin_lock_init(&new_driver->dynids.lock);
 	INIT_LIST_HEAD(&new_driver->dynids.list);
 
-	retval = driver_register(&new_driver->drvwrap.driver);
+	retval = driver_register(&new_driver->driver);
 	if (retval)
 		goto out;
 
@@ -1077,7 +1075,7 @@ int usb_register_driver(struct usb_driver *new_driver, struct module *owner,
 	return retval;
 
 out_newid:
-	driver_unregister(&new_driver->drvwrap.driver);
+	driver_unregister(&new_driver->driver);
 
 	pr_err("%s: error %d registering interface driver %s\n",
 		usbcore_name, retval, new_driver->name);
@@ -1102,7 +1100,7 @@ void usb_deregister(struct usb_driver *driver)
 			usbcore_name, driver->name);
 
 	usb_remove_newid_files(driver);
-	driver_unregister(&driver->drvwrap.driver);
+	driver_unregister(&driver->driver);
 	usb_free_dynids(driver);
 }
 EXPORT_SYMBOL_GPL(usb_deregister);
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 2a938cf47ccd..dc8d9228a5e7 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -431,7 +431,7 @@ struct usb_interface *usb_find_interface(struct usb_driver *drv, int minor)
 	struct device *dev;
 
 	argb.minor = minor;
-	argb.drv = &drv->drvwrap.driver;
+	argb.drv = &drv->driver;
 
 	dev = bus_find_device(&usb_bus_type, NULL, &argb, __find_interface);
 
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 60363153fc3f..9912a7857ad5 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -176,11 +176,12 @@ static inline int is_root_hub(struct usb_device *udev)
 }
 
 /* Do the same for device drivers and interface drivers. */
-
+extern int usb_probe_device(struct device *dev);
 static inline int is_usb_device_driver(struct device_driver *drv)
 {
-	return container_of(drv, struct usbdrv_wrap, driver)->
-			for_devices;
+	if (drv->probe == usb_probe_device)
+		return 1;
+	return 0;
 }
 
 /* for labeling diagnostics */
diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index c09fb6bd7d7d..0dd2b032c90b 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -244,7 +244,7 @@ static void onboard_hub_attach_usb_driver(struct work_struct *work)
 {
 	int err;
 
-	err = driver_attach(&onboard_hub_usbdev_driver.drvwrap.driver);
+	err = driver_attach(&onboard_hub_usbdev_driver.driver);
 	if (err)
 		pr_err("Failed to attach USB driver: %pe\n", ERR_PTR(err));
 }
diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index 3eb8dc3a1a8f..6c812d01b37d 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -113,7 +113,7 @@ static ssize_t new_id_store(struct device_driver *driver,
 	if (retval >= 0 && usb_drv->usb_driver != NULL)
 		retval = usb_store_new_id(&usb_drv->usb_driver->dynids,
 					  usb_drv->usb_driver->id_table,
-					  &usb_drv->usb_driver->drvwrap.driver,
+					  &usb_drv->usb_driver->driver,
 					  buf, count);
 	return retval;
 }
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 17b09f03ef84..f1e91eb7f8a4 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1521,7 +1521,7 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 
 	/* Now set udriver's id_table and look for matches */
 	udriver->id_table = id_table;
-	rc = driver_attach(&udriver->drvwrap.driver);
+	rc = driver_attach(&udriver->driver);
 	return 0;
 
 err_deregister_drivers:
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 696bb0b23599..9707f53cfda9 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -1246,7 +1246,7 @@ static struct usb_driver uas_driver = {
 	.suspend = uas_suspend,
 	.resume = uas_resume,
 	.reset_resume = uas_reset_resume,
-	.drvwrap.driver.shutdown = uas_shutdown,
+	.driver.shutdown = uas_shutdown,
 	.id_table = uas_usb_ids,
 };
 
diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index 0a6624d37929..79110a69d697 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -377,14 +377,14 @@ static int __init usbip_host_init(void)
 		goto err_usb_register;
 	}
 
-	ret = driver_create_file(&stub_driver.drvwrap.driver,
+	ret = driver_create_file(&stub_driver.driver,
 				 &driver_attr_match_busid);
 	if (ret) {
 		pr_err("driver_create_file failed\n");
 		goto err_create_file;
 	}
 
-	ret = driver_create_file(&stub_driver.drvwrap.driver,
+	ret = driver_create_file(&stub_driver.driver,
 				 &driver_attr_rebind);
 	if (ret) {
 		pr_err("driver_create_file failed\n");
@@ -402,10 +402,10 @@ static int __init usbip_host_init(void)
 
 static void __exit usbip_host_exit(void)
 {
-	driver_remove_file(&stub_driver.drvwrap.driver,
+	driver_remove_file(&stub_driver.driver,
 			   &driver_attr_match_busid);
 
-	driver_remove_file(&stub_driver.drvwrap.driver,
+	driver_remove_file(&stub_driver.driver,
 			   &driver_attr_rebind);
 
 	/*
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 618e5a0b1a22..47f1e8c17674 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1144,16 +1144,6 @@ extern ssize_t usb_store_new_id(struct usb_dynids *dynids,
 
 extern ssize_t usb_show_dynids(struct usb_dynids *dynids, char *buf);
 
-/**
- * struct usbdrv_wrap - wrapper for driver-model structure
- * @driver: The driver-model core driver structure.
- * @for_devices: Non-zero for device drivers, 0 for interface drivers.
- */
-struct usbdrv_wrap {
-	struct device_driver driver;
-	int for_devices;
-};
-
 /**
  * struct usb_driver - identifies USB interface driver to usbcore
  * @name: The driver name should be unique among USB drivers,
@@ -1194,7 +1184,7 @@ struct usbdrv_wrap {
  *	is bound to the driver.
  * @dynids: used internally to hold the list of dynamically added device
  *	ids for this driver.
- * @drvwrap: Driver-model core structure wrapper.
+ * @driver: The driver-model core driver structure.
  * @no_dynamic_id: if set to 1, the USB core will not allow dynamic ids to be
  *	added to this driver by preventing the sysfs file from being created.
  * @supports_autosuspend: if set to 0, the USB core will not allow autosuspend
@@ -1242,13 +1232,13 @@ struct usb_driver {
 	const struct attribute_group **dev_groups;
 
 	struct usb_dynids dynids;
-	struct usbdrv_wrap drvwrap;
+	struct device_driver driver;
 	unsigned int no_dynamic_id:1;
 	unsigned int supports_autosuspend:1;
 	unsigned int disable_hub_initiated_lpm:1;
 	unsigned int soft_unbind:1;
 };
-#define	to_usb_driver(d) container_of(d, struct usb_driver, drvwrap.driver)
+#define	to_usb_driver(d) container_of(d, struct usb_driver, driver)
 
 /**
  * struct usb_device_driver - identifies USB device driver to usbcore
@@ -1269,7 +1259,7 @@ struct usb_driver {
  *	on to call the normal usb_choose_configuration().
  * @dev_groups: Attributes attached to the device that will be created once it
  *	is bound to the driver.
- * @drvwrap: Driver-model core structure wrapper.
+ * @driver: The driver-model core driver structure.
  * @id_table: used with @match() to select better matching driver at
  * 	probe() time.
  * @supports_autosuspend: if set to 0, the USB core will not allow autosuspend
@@ -1278,7 +1268,7 @@ struct usb_driver {
  *	resume and suspend functions will be called in addition to the driver's
  *	own, so this part of the setup does not need to be replicated.
  *
- * USB drivers must provide all the fields listed above except drvwrap,
+ * USB drivers must provide all the fields listed above except driver,
  * match, and id_table.
  */
 struct usb_device_driver {
@@ -1294,13 +1284,13 @@ struct usb_device_driver {
 	int (*choose_configuration) (struct usb_device *udev);
 
 	const struct attribute_group **dev_groups;
-	struct usbdrv_wrap drvwrap;
+	struct device_driver driver;
 	const struct usb_device_id *id_table;
 	unsigned int supports_autosuspend:1;
 	unsigned int generic_subclass:1;
 };
 #define	to_usb_device_driver(d) container_of(d, struct usb_device_driver, \
-		drvwrap.driver)
+		driver)
 
 /**
  * struct usb_class_driver - identifies a USB driver that wants to use the USB major number
-- 
2.25.1


