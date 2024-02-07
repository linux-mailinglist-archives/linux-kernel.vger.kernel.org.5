Return-Path: <linux-kernel+bounces-56917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A2F84D15B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491291C22813
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B1D84051;
	Wed,  7 Feb 2024 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iETjnd9T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D1484FC7
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331345; cv=none; b=jqNaH6GUl+C5uOt99VO0nh5ItSIekY+7TpD1g5jOx7Y+mkOD6moDg05pDycdIk+anvi/U5a0+oYe8I1nJnMhQi6y0omhm2YuLA76BUzz1iD4ZN0ho+Pw/P6HyqEVPsEvpK8S/hxQVoHN9bvfUiFp6vV7ri1KBnIgKhLgLylMa04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331345; c=relaxed/simple;
	bh=ZCRVA2mffIeaQus1dOlcK54spGmEXo1fw7BGH0JkEM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrSTbkX+9HQ2YEVwCYSwbT8R/qEyTZWa8QLFTdNvkOX0KnR8gWEcJ/PP2NTqaLiv/NmsEYSAmi00W9h3eORErxtR/EWgVUkedc33WAxdGD0DCiCTcVDhh9rJzcblXlx7zb/biJ7wKJXTgIL9XkdVUuA2oAuwWqQOEomJgWxbmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iETjnd9T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707331343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxUXCNijSG3JpoO3vioYJ7kD0cZUoEnLjl7wb2EW6H8=;
	b=iETjnd9TLpN8WIYM74+NocBWhY59Ra7SXCVdn0B5OwvbQPpgZLpUJTqAbqsP12rT0cHVmp
	AmYB8jtRVYTQTYk2IK8K/lHG2j9H7Lrix4oy+cO4bIOtNTboGhZC4Gd8Sr1Y6Z8oM8UWvz
	aGcDdjoNo/X2jFKZL3v4iFfzFbYMWAY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-l26M5vl5PByd4fVcW48V4g-1; Wed, 07 Feb 2024 13:42:20 -0500
X-MC-Unique: l26M5vl5PByd4fVcW48V4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2579483B86B;
	Wed,  7 Feb 2024 18:42:19 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.32.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9C76C4011FF1;
	Wed,  7 Feb 2024 18:42:18 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: [RFC PATCH 1/6] minimal async shutdown infrastructure
Date: Wed,  7 Feb 2024 13:40:55 -0500
Message-ID: <20240207184100.18066-2-djeffery@redhat.com>
In-Reply-To: <20240207184100.18066-1-djeffery@redhat.com>
References: <20240207184100.18066-1-djeffery@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Adds the async_shutdown_start and async_shutdown_end calls to perform async
shutdown. Implements a very minimalist method of async shutdown support
within device_shutdown(). The device at the head of the shutdown list is
checked against a list of devices under async shutdown. If the head is a
parent of a device on the async list, all active async shutdown operations
are completed before the parent's shutdown call is performed.

The number of async operations also has a max limit to prevent the list being
checked for a child from getting overly large.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by:     Laurence Oberman <loberman@redhat.com>

---
 drivers/base/core.c           | 116 +++++++++++++++++++++++++++++++++-
 include/linux/device/bus.h    |   8 ++-
 include/linux/device/driver.h |   7 ++
 3 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..5bc2282c00cd 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4719,12 +4719,92 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+
+#define MAX_ASYNC_SHUTDOWNS 32
+static int async_shutdown_count;
+static LIST_HEAD(async_shutdown_list);
+
+/**
+ * If a device has a child busy with an async shutdown or there are too many
+ * async shutdowns active, the device may not be shut down at this time.
+ */
+static bool may_shutdown_device(struct device *dev)
+{
+	struct device *tmp;
+
+	if (async_shutdown_count >= MAX_ASYNC_SHUTDOWNS)
+		return false;
+
+	list_for_each_entry(tmp, &async_shutdown_list, kobj.entry) {
+		if (tmp->parent == dev)
+			return false;
+	}
+	return true;
+}
+
+/**
+ * Call and track each async shutdown call
+ */
+static void async_shutdown_start(struct device *dev, void (*callback) (struct device *))
+{
+	if (initcall_debug)
+		dev_info(dev, "async_shutdown_start\n");
+
+	(*callback)(dev);
+	list_add_tail(&dev->kobj.entry, &async_shutdown_list);
+	async_shutdown_count++;
+}
+
+/**
+ * Wait for all async shutdown operations currently active to complete
+ */
+static void wait_for_active_async_shutdown(void)
+{
+	struct device *dev, *parent;
+
+        while (!list_empty(&async_shutdown_list)) {
+                dev = list_entry(async_shutdown_list.next, struct device,
+                                kobj.entry);
+
+                parent = dev->parent;
+
+                /*
+                 * Make sure the device is off the list
+                 */
+                list_del_init(&dev->kobj.entry);
+                if (parent)
+                        device_lock(parent);
+                device_lock(dev);
+                if (dev->bus && dev->bus->async_shutdown_end) {
+                        if (initcall_debug)
+                                dev_info(dev,
+                                "async_shutdown_end called\n");
+                        dev->bus->async_shutdown_end(dev);
+                } else if (dev->driver && dev->driver->async_shutdown_end) {
+			if (initcall_debug)
+				dev_info(dev,
+				"async_shutdown_end called\n");
+			dev->driver->async_shutdown_end(dev);
+		}
+                device_unlock(dev);
+                if (parent)
+                        device_unlock(parent);
+
+                put_device(dev);
+                put_device(parent);
+        }
+	if (initcall_debug)
+		printk(KERN_INFO "device shutdown: waited for %d async shutdown callbacks\n", async_shutdown_count);
+	async_shutdown_count = 0;
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	bool async_busy;
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4741,6 +4821,8 @@ void device_shutdown(void)
 		dev = list_entry(devices_kset->list.prev, struct device,
 				kobj.entry);
 
+		async_busy = false;
+
 		/*
 		 * hold reference count of device's parent to
 		 * prevent it from being freed because parent's
@@ -4748,6 +4830,17 @@ void device_shutdown(void)
 		 */
 		parent = get_device(dev->parent);
 		get_device(dev);
+
+                if (!may_shutdown_device(dev)) {
+			put_device(dev);
+			put_device(parent);
+
+			spin_unlock(&devices_kset->list_lock);
+			wait_for_active_async_shutdown();
+			spin_lock(&devices_kset->list_lock);
+			continue;
+		}
+
 		/*
 		 * Make sure the device is off the kset list, in the
 		 * event that dev->*->shutdown() doesn't remove it.
@@ -4769,26 +4862,43 @@ void device_shutdown(void)
 				dev_info(dev, "shutdown_pre\n");
 			dev->class->shutdown_pre(dev);
 		}
-		if (dev->bus && dev->bus->shutdown) {
+		if (dev->bus && dev->bus->async_shutdown_start) {
+			async_shutdown_start(dev, dev->bus->async_shutdown_start);
+			async_busy = true;
+		} else if (dev->bus && dev->bus->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
 			dev->bus->shutdown(dev);
+		} else if (dev->driver && dev->driver->async_shutdown_start) {
+			async_shutdown_start(dev, dev->driver->async_shutdown_start);
+			async_busy = true;
 		} else if (dev->driver && dev->driver->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
 			dev->driver->shutdown(dev);
+		} else {
+			if (initcall_debug)
+				dev_info(dev, "no shutdown callback\n");
 		}
 
 		device_unlock(dev);
 		if (parent)
 			device_unlock(parent);
 
-		put_device(dev);
-		put_device(parent);
+		/* if device has an async shutdown, drop the ref when done */
+		if (!async_busy) {
+			put_device(dev);
+			put_device(parent);
+		}
 
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+	/*
+	 * Wait for any async shutdown still running.
+	 */
+	if (!list_empty(&async_shutdown_list))
+		wait_for_active_async_shutdown();
 }
 
 /*
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 5ef4ec1c36c3..7a4a2ff0bc23 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -48,7 +48,11 @@ struct fwnode_handle;
  *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
- *
+ * @async_shutdown_start:	Optional call to support and begin the shutdown
+ *				process on the device in an asynchronous manner.
+ * @async_shutdown_end:	        Optional call to complete an asynchronous
+ *				shutdown of the device. Must be provided if a
+ *				sync_shutdown_start call is provided.
  * @online:	Called to put the device back online (after offlining it).
  * @offline:	Called to put the device offline for hot-removal. May fail.
  *
@@ -87,6 +91,8 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	void (*async_shutdown_start)(struct device *dev);
+	void (*async_shutdown_end)(struct device *dev);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 7738f458995f..af0ad2d3687a 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -71,6 +71,11 @@ enum probe_type {
  * @remove:	Called when the device is removed from the system to
  *		unbind a device from this driver.
  * @shutdown:	Called at shut-down time to quiesce the device.
+ * @async_shutdown_start:	Optional call to support and begin the shutdown
+ *				process on the device in an asynchronous manner.
+ * @async_shutdown_end:		Optional call to complete an asynchronous
+ *				shutdown of the device. Must be provided if a
+ *				sync_shutdown_start call is provided.
  * @suspend:	Called to put the device to sleep mode. Usually to a
  *		low power state.
  * @resume:	Called to bring a device from sleep mode.
@@ -110,6 +115,8 @@ struct device_driver {
 	void (*sync_state)(struct device *dev);
 	int (*remove) (struct device *dev);
 	void (*shutdown) (struct device *dev);
+	void (*async_shutdown_start) (struct device *dev);
+	void (*async_shutdown_end) (struct device *dev);
 	int (*suspend) (struct device *dev, pm_message_t state);
 	int (*resume) (struct device *dev);
 	const struct attribute_group **groups;
-- 
2.43.0


