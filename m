Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9AB7FC6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346122AbjK1VEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343838AbjK1VEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:04:46 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028EEDE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:04:52 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1fa22326ad0so2069855fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701205491; x=1701810291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2+az4m4rNbNX28kjrkVuqLIyDrask3+419UkoIJP3s=;
        b=VIZtioMfBotkVuw0RVAF3oYa98vE4fju6I0xdeKejpgv4Aw5dOWe9CVA5cn+MLdmMi
         UWOSxmw1UTpRNuR6hpncrbnkFoEK18wRaSw5EfYRZuaHzIQBQNWcL6zfaw05EXcwVeDU
         m915ro6gXiMzuvWyb+QL1w5mw4BBzP5zPSzfxeWyvgNcuaTfw/ddTfpu8jcQV2xCHQKv
         Q9OpeD2KljRACPrfAeNDo/+z8MopkFfXk47msu5mFJdqJMnCiN1Lgs96NSJNW5jL0iUd
         z0LcWUs1lUROd4uqIhyjkOkDgWvlfco86yjuVZGZbvnfRWONTUwykdsXhK2UVxsHmSxO
         f+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205491; x=1701810291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2+az4m4rNbNX28kjrkVuqLIyDrask3+419UkoIJP3s=;
        b=kMtfw1rnn/BFdjgfYZZ5X01FCn0baXLxeEs4T2H1/GXyjzcsB+mrX8JbNMN9cWCPFa
         dYhj/491aYxFnj2GvWLjmMJcsVpqHBUmJa32wm0VEsIlSFVIQ4DthygZbiPnt+ql3cNL
         pdqgU0Ld3L3ED6jnjbsGQ5OS29WiwQg9U8wU1duqYdsF8lBbG+Qr7tPm2xX1WAtJZPyD
         +A6hgA7m9HEx4Pi0WQIhAk9yZbYKebebamZIwKamVw4yF5jZiXb+sQMhx+2qRao7b34O
         ln2fCrouGS+onb8RvvWqi+t0sgWspiF1TnvmFLjsajn9Zzqs7uvU9imhvCuZ8mDg4N4B
         BJXA==
X-Gm-Message-State: AOJu0YxbRZPlib5jL9REqYrakGE57fbBnmuSSSntPa7Lklg8hZ8u9BEs
        cUWcqrw6lTn+UnHwLR6QvzCgplBrdvU=
X-Google-Smtp-Source: AGHT+IE+jcano+NXVlT5zLyJi002XKm3KQ1V8/gb4fjrkTG+8VRCxqfJGY9cguAp0tdjMwQqrhZArA==
X-Received: by 2002:a05:6870:658b:b0:1fa:3e11:711a with SMTP id fp11-20020a056870658b00b001fa3e11711amr11941878oab.33.1701205490542;
        Tue, 28 Nov 2023 13:04:50 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id pp23-20020a0568709d1700b001fa619a3fd9sm953864oab.52.2023.11.28.13.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:04:49 -0800 (PST)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v5] driver core: shut down devices asynchronously
Date:   Tue, 28 Nov 2023 15:04:36 -0600
Message-Id: <20231128210436.506510-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code to shut down devices asynchronously, while ensuring that each
device is shut down before its parent, and allowing devices that share a
driver to be shutdown one at a time if necessary.

Add /sys/kernel/async_shutdown to allow user control of this feature:

  off:	shut down all devices synchronously (default)
  on:	shut down all devices asynchronously, unless disabled by the driver
	(driver opt-out)
  safe: shut down all devices synchronously, unless driver prefers async
	shutdown, or device has no driver or an unregistered driver (driver
	opt-in)

Add an async_shutdown sysfs attribute to drivers to allow users to see and
change driver opt-in/opt-out, with values:

 async:   driver opt-in to async device shutdown (devices will be shut down
          asynchronously if async_shutdown is "on" or "safe")
 sync:    driver opt-out of async device shutdown (devices will always be
          shut down synchronously)
 default: devices will be shutdown asynchronously if async_shutdown is "on"

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
v1->v2: rewritten using kernel async code (suggested by Lukas Wunner)
v2->v3: removed recursive functions to schedule children to be shutdown
          before parents, since existing device_shutdown loop will already
          do this
v3->v4: bug fix (used "parent" not "dev->parent", in device_shutdown)
v4->v5: change code to use cookies for synchronization rather than async
          domains
        allow async shutdown to be disabled via sysfs, and allow driver
          opt-in or opt-out of async shutdown (when not disabled), with
          ability to control driver opt-in/opt-out via sysfs
---
diff --git a/drivers/base/base.h b/drivers/base/base.h
index eb4c0ace9242..8b87947a79b5 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -11,6 +11,7 @@
  *
  */
 #include <linux/notifier.h>
+#include <linux/async.h>
 
 /**
  * struct subsys_private - structure to hold the private to the driver core portions of the bus_type/class structure.
@@ -75,12 +76,21 @@ static inline void subsys_put(struct subsys_private *sp)
 
 struct subsys_private *class_to_subsys(const struct class *class);
 
+/**
+ * struct driver_private - structure to hold the private to the driver core portions of the driver
+ * structure.
+ *
+ * @shutdown_cookie - cookie used to synchronize shutdown of devices used by this driver, used when
+ *                    async device shutdown is enabled system-wide, but not allowed for devices
+ *                    using this driver
+ */
 struct driver_private {
 	struct kobject kobj;
 	struct klist klist_devices;
 	struct klist_node knode_bus;
 	struct module_kobject *mkobj;
 	struct device_driver *driver;
+	async_cookie_t shutdown_cookie;
 };
 #define to_driver(obj) container_of(obj, struct driver_private, kobj)
 
@@ -97,6 +107,7 @@ struct driver_private {
  *	the device; typically because it depends on another driver getting
  *	probed first.
  * @async_driver - pointer to device driver awaiting probe via async_probe
+ * @shutdown_cookie - cookie used during async shutdown to ensure correct shutdown ordering.
  * @device - pointer back to the struct device that this structure is
  * associated with.
  * @dead - This device is currently either in the process of or has been
@@ -114,6 +125,7 @@ struct device_private {
 	struct list_head deferred_probe;
 	struct device_driver *async_driver;
 	char *deferred_probe_reason;
+	async_cookie_t shutdown_cookie;
 	struct device *device;
 	u8 dead:1;
 };
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 84a21084d67d..7aac9580945d 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/async.h>
+#include <linux/capability.h>
 #include <linux/device/bus.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -635,6 +636,46 @@ static ssize_t uevent_store(struct device_driver *drv, const char *buf,
 }
 static DRIVER_ATTR_WO(uevent);
 
+static ssize_t async_shutdown_show(struct device_driver *drv, char *buf)
+{
+	char *output;
+
+	switch (drv->shutdown_type) {
+	case SHUTDOWN_DEFAULT_STRATEGY:
+		output = "default";
+		break;
+	case SHUTDOWN_PREFER_ASYNCHRONOUS:
+		output = "enabled";
+		break;
+	case SHUTDOWN_FORCE_SYNCHRONOUS:
+		output = "disabled";
+		break;
+	default:
+		output = "unknown";
+	}
+	return sysfs_emit(buf, "%s\n", output);
+}
+
+static ssize_t async_shutdown_store(struct device_driver *drv, const char *buf,
+			      size_t count)
+{
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	if (!strncmp(buf, "disabled", 8))
+		drv->shutdown_type = SHUTDOWN_FORCE_SYNCHRONOUS;
+	else if (!strncmp(buf, "enabled", 2))
+		drv->shutdown_type = SHUTDOWN_PREFER_ASYNCHRONOUS;
+	else if (!strncmp(buf, "default", 4))
+		drv->shutdown_type = SHUTDOWN_DEFAULT_STRATEGY;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static DRIVER_ATTR_RW(async_shutdown);
+
 /**
  * bus_add_driver - Add a driver to the bus.
  * @drv: driver.
@@ -661,6 +702,7 @@ int bus_add_driver(struct device_driver *drv)
 	}
 	klist_init(&priv->klist_devices, NULL, NULL);
 	priv->driver = drv;
+	priv->shutdown_cookie = 0;
 	drv->p = priv;
 	priv->kobj.kset = sp->drivers_kset;
 	error = kobject_init_and_add(&priv->kobj, &driver_ktype, NULL,
@@ -696,6 +738,11 @@ int bus_add_driver(struct device_driver *drv)
 				__func__, drv->name);
 		}
 	}
+	error = driver_create_file(drv, &driver_attr_async_shutdown);
+	if (error) {
+		pr_err("%s: async_shutdown attr (%s) failed\n",
+			__func__, drv->name);
+	}
 
 	return 0;
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67ba592afc77..553d3b8fafd1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/async.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -45,6 +46,64 @@ static void __fw_devlink_link_to_consumers(struct device *dev);
 static bool fw_devlink_drv_reg_done;
 static bool fw_devlink_best_effort;
 
+enum async_device_shutdown_enabled {
+	ASYNC_DEV_SHUTDOWN_DISABLED,
+	ASYNC_DEV_SHUTDOWN_SAFE,
+	ASYNC_DEV_SHUTDOWN_ENABLED,
+};
+
+static enum async_device_shutdown_enabled async_device_shutdown_enabled;
+
+static ssize_t async_device_shutdown_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	const char *output;
+
+	switch (async_device_shutdown_enabled) {
+	case ASYNC_DEV_SHUTDOWN_DISABLED:
+		output = "off";
+		break;
+	case ASYNC_DEV_SHUTDOWN_SAFE:
+		output = "safe";
+		break;
+	case ASYNC_DEV_SHUTDOWN_ENABLED:
+		output = "on";
+		break;
+	default:
+		output = "unknown";
+	}
+
+	return sysfs_emit(buf, "%s\n", output);
+}
+
+static ssize_t async_device_shutdown_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	if (!strncmp(buf, "off", 3))
+		async_device_shutdown_enabled = ASYNC_DEV_SHUTDOWN_DISABLED;
+	else if (!strncmp(buf, "safe", 4))
+		async_device_shutdown_enabled = ASYNC_DEV_SHUTDOWN_SAFE;
+	else if (!strncmp(buf, "on", 2))
+		async_device_shutdown_enabled = ASYNC_DEV_SHUTDOWN_ENABLED;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static struct kobj_attribute async_device_shutdown_attr = __ATTR_RW(async_device_shutdown);
+
+static int __init async_shutdown_sysfs_init(void)
+{
+	return sysfs_create_file(kernel_kobj, &async_device_shutdown_attr.attr);
+}
+
+late_initcall(async_shutdown_sysfs_init);
+
 /**
  * __fwnode_link_add - Create a link between two fwnode_handles.
  * @con: Consumer end of the link.
@@ -3474,6 +3533,7 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
+	dev->p->shutdown_cookie = 0;
 	return 0;
 }
 
@@ -4719,12 +4779,112 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+ASYNC_DOMAIN(sd_domain);
+async_cookie_t big_shutdown_cookie;
+
+static async_cookie_t *dev_shutdown_synchronization_cookie(struct device *dev)
+{
+
+	switch (async_device_shutdown_enabled) {
+	case ASYNC_DEV_SHUTDOWN_ENABLED:
+		if (!dev->driver)
+			return NULL;
+		/*
+		 * async unless the driver forbids it
+		 */
+		if (dev->driver->shutdown_type != SHUTDOWN_FORCE_SYNCHRONOUS)
+			return NULL;
+		break;
+	case ASYNC_DEV_SHUTDOWN_SAFE:
+		if (!dev->driver)
+			return NULL;
+		/*
+		 * async only if the driver prefers it
+		 */
+		if (dev->driver->shutdown_type == SHUTDOWN_PREFER_ASYNCHRONOUS)
+			return NULL;
+		break;
+	case ASYNC_DEV_SHUTDOWN_DISABLED:
+	default:
+		/*
+		 * synchronize everything
+		 */
+		return &big_shutdown_cookie;
+	}
+
+	/*
+	 * synchronize with other devices with this driver
+	 */
+	if (dev->driver->p)
+		return &dev->driver->p->shutdown_cookie;
+
+	/*
+	 * device with unregistered driver
+	 */
+	return &big_shutdown_cookie;
+}
+
+/**
+ * shutdown_device - shutdown one device
+ * @data: the pointer to the struct device to be shutdown
+ * @cookie: not used
+ *
+ * This shuts down one device, after waiting for children to finish
+ * shutdown.  This should be scheduled for any children first.
+ */
+static void shutdown_device(void *data, async_cookie_t cookie)
+{
+	struct device *dev = data;
+
+	/*
+	 * Wait for other devices to finish shutdown if needed
+	 */
+	async_synchronize_cookie_domain(dev->p->shutdown_cookie + 1, &sd_domain);
+
+	/*
+	 * Make sure the device is off the kset list, in the
+	 * event that dev->*->shutdown() doesn't remove it.
+	 */
+	spin_lock(&devices_kset->list_lock);
+	list_del_init(&dev->kobj.entry);
+	spin_unlock(&devices_kset->list_lock);
+
+	/* hold lock to avoid race with probe/release */
+	if (dev->parent)
+		device_lock(dev->parent);
+	device_lock(dev);
+
+	/* Don't allow any more runtime suspends */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	if (dev->class && dev->class->shutdown_pre) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown_pre\n");
+		dev->class->shutdown_pre(dev);
+	}
+	if (dev->bus && dev->bus->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->bus->shutdown(dev);
+	} else if (dev->driver && dev->driver->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->driver->shutdown(dev);
+	}
+
+	device_unlock(dev);
+	if (dev->parent)
+		device_unlock(dev->parent);
+	put_device(dev);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
-	struct device *dev, *parent;
+	struct device *dev;
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4733,20 +4893,16 @@ void device_shutdown(void)
 
 	spin_lock(&devices_kset->list_lock);
 	/*
-	 * Walk the devices list backward, shutting down each in turn.
-	 * Beware that device unplug events may also start pulling
+	 * Walk the devices list backward, scheduling shutdown of each in
+	 * turn. Beware that device unplug events may also start pulling
 	 * devices offline, even as the system is shutting down.
 	 */
 	while (!list_empty(&devices_kset->list)) {
+		async_cookie_t *dev_sdsync_cookie, cookie;
+
 		dev = list_entry(devices_kset->list.prev, struct device,
 				kobj.entry);
 
-		/*
-		 * hold reference count of device's parent to
-		 * prevent it from being freed because parent's
-		 * lock is to be held
-		 */
-		parent = get_device(dev->parent);
 		get_device(dev);
 		/*
 		 * Make sure the device is off the kset list, in the
@@ -4755,40 +4911,28 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
-		device_lock(dev);
+		/*
+		 * set cookie to ensure desired shutdown synchronization
+		 */
+		dev_sdsync_cookie = dev_shutdown_synchronization_cookie(dev);
+		if ((dev_sdsync_cookie) && (*dev_sdsync_cookie > dev->p->shutdown_cookie))
+			dev->p->shutdown_cookie = *dev_sdsync_cookie;
 
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
+		cookie = async_schedule_domain(shutdown_device, dev, &sd_domain);
 
-		if (dev->class && dev->class->shutdown_pre) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown_pre\n");
-			dev->class->shutdown_pre(dev);
-		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
-		}
-
-		device_unlock(dev);
-		if (parent)
-			device_unlock(parent);
+		if (dev_sdsync_cookie)
+			*dev_sdsync_cookie = cookie;
 
-		put_device(dev);
-		put_device(parent);
+		/*
+		 * ensure parent devs don't get shut down before their children
+		 */
+		if (dev->parent)
+			dev->parent->p->shutdown_cookie = cookie;
 
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+	async_synchronize_full_domain(&sd_domain);
 }
 
 /*
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 7738f458995f..f414c8a6f814 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -48,6 +48,12 @@ enum probe_type {
 	PROBE_FORCE_SYNCHRONOUS,
 };
 
+enum shutdown_type {
+	SHUTDOWN_DEFAULT_STRATEGY,
+	SHUTDOWN_PREFER_ASYNCHRONOUS,
+	SHUTDOWN_FORCE_SYNCHRONOUS,
+};
+
 /**
  * struct device_driver - The basic device driver structure
  * @name:	Name of the device driver.
@@ -56,6 +62,7 @@ enum probe_type {
  * @mod_name:	Used for built-in modules.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
+ * @shutdown_type: Type of the shutdown (synchronous or asynchronous) to use.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
  * @probe:	Called to query the existence of a specific device,
@@ -102,6 +109,7 @@ struct device_driver {
 
 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
 	enum probe_type probe_type;
+	enum shutdown_type shutdown_type;
 
 	const struct of_device_id	*of_match_table;
 	const struct acpi_device_id	*acpi_match_table;
-- 
2.39.3

