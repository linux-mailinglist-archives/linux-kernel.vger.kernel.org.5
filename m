Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911237A8C28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjITS75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjITS7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:59:55 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D82AC9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:59:49 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5738949f62cso123200eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695236388; x=1695841188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eTsWnCm4WBdqltgR3xxPn5PFi60U+G+FBv6+XPeoNEg=;
        b=V5vq+oEAkikwTjjjscIYLkbJcxM9d1PhjozZM1AhYltycpP56KIJbvq8HewYSnU+p9
         VmYbuhY/OjR3HoL7C0PwRHZ144zjzI7t+LrDWX4dEeVHbeB5tAG8ZTlzvyYpQDEiaUEo
         AlwTRa6s7nfUt8BQDcFle5CafWlw/qbDfI7cGXcS2rE4cwPNkeyGwStFgag0qkCPlBam
         ypLATPytWe8eRJMlHYGBDhWvEjXulzpFk9/frZsp5uxf8C8eCCrcKOnPXUJr2tseY5T2
         j1DBXqUiPPjN30ixj+C9fvo+FRwj8uDx0/zJW+3qmWtrD6GVCMOFKFXINbq2r/L9Io5p
         MzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695236388; x=1695841188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTsWnCm4WBdqltgR3xxPn5PFi60U+G+FBv6+XPeoNEg=;
        b=vfPnbpXLVb+SHcdZkGJvTbRMZEbCoPNeiX1JiYpCL6+099kfE+1uUfETlovw+g9ZFO
         zFIRoYno7tQp1+Eg9H6cVRuTnlXekSj+97uCmDYB8tXHAPojYYkQTQcLTr74NlPiy0tW
         g0nKSYDdVybAvW8OQfk6h7djHkiSuAfhQFFp6AENJ7/DlxVKVApGFQJQlaazlpGYKGJA
         Rw1dJHDgo56A+x2MQgyL7hUUsSiVQy9O6NcDYyWl7UrSHV/mEnr07x3MAypcgnugnMGR
         pyhmQfcY7gdPZD2S1GJdtNcGV9XHyInlVeqfQSurr+1DAmgF/kAYhEWFUoQ+rL1sSsuj
         o9Sg==
X-Gm-Message-State: AOJu0YwpH3Zq2guWRuXBg1mjsQYhI2FJWiMP6fP7ZRysmjddrvO6Xvxh
        ZIMQAf2V8iKrEqEBz31RGWNl3AFk4mQ=
X-Google-Smtp-Source: AGHT+IHxThdjq5VAwHR1MahDu+TtHYUMjtei4S4zVhg/HZcxY2tUSlOnDwpkv+ZNuzyuwXKAuGBJ2A==
X-Received: by 2002:a4a:3c54:0:b0:56d:c55b:4792 with SMTP id p20-20020a4a3c54000000b0056dc55b4792mr4070515oof.6.1695236387785;
        Wed, 20 Sep 2023 11:59:47 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id v17-20020a4a9751000000b00573f5173a57sm7022440ooi.23.2023.09.20.11.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 11:59:47 -0700 (PDT)
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
Subject: [PATCH v3] driver core: shut down devices asynchronously
Date:   Wed, 20 Sep 2023 13:59:23 -0500
Message-Id: <20230920185923.3422-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shut down devices asynchronously, ensuring that each device is shut down
before its parents.

This can dramatically reduce system shutdown/reboot time on systems that
have devices that take many seconds to shut down, such as some NVMe drives.
On one system tested, the shutdown time went from 11 minutes without this
patch to 55 seconds with the patch.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
v1->v2: rewritten using kernel async code (suggested by Lukas Wunner)
v2->v3: removed recursive functions to schedule children to be shutdown
        before parents, since existing device_shutdown loop will already
        do this
---
 drivers/base/base.h   |   3 ++
 drivers/base/core.c   | 102 ++++++++++++++++++++++++++----------------
 include/linux/async.h |   6 +++
 3 files changed, 73 insertions(+), 38 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index eb4c0ace9242..9b9d80e575ca 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -11,6 +11,7 @@
  *
  */
 #include <linux/notifier.h>
+#include <linux/async.h>
 
 /**
  * struct subsys_private - structure to hold the private to the driver core portions of the bus_type/class structure.
@@ -97,6 +98,7 @@ struct driver_private {
  *	the device; typically because it depends on another driver getting
  *	probed first.
  * @async_driver - pointer to device driver awaiting probe via async_probe
+ * @child_domain - domain for async shutdown work of children
  * @device - pointer back to the struct device that this structure is
  * associated with.
  * @dead - This device is currently either in the process of or has been
@@ -114,6 +116,7 @@ struct device_private {
 	struct list_head deferred_probe;
 	struct device_driver *async_driver;
 	char *deferred_probe_reason;
+	struct async_domain child_domain;
 	struct device *device;
 	u8 dead:1;
 };
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4d8b315c48a1..b0f71e64125c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/async.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -3473,6 +3474,7 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
+	INIT_ASYNC_DOMAIN_EXCLUSIVE(&dev->p->child_domain);
 	return 0;
 }
 
@@ -4718,11 +4720,68 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
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
+	 * wait for shutdown work of children to finish
+	 */
+	async_synchronize_full_domain(&dev->p->child_domain);
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
+
+	put_device(dev);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
+	ASYNC_DOMAIN_EXCLUSIVE(top_domain);
 	struct device *dev, *parent;
 
 	wait_for_device_probe();
@@ -4732,20 +4791,14 @@ void device_shutdown(void)
 
 	spin_lock(&devices_kset->list_lock);
 	/*
-	 * Walk the devices list backward, shutting down each in turn.
-	 * Beware that device unplug events may also start pulling
+	 * Walk the devices list backward, scheduling shutdown of each in
+	 * turn. Beware that device unplug events may also start pulling
 	 * devices offline, even as the system is shutting down.
 	 */
 	while (!list_empty(&devices_kset->list)) {
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
@@ -4754,40 +4807,13 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
-		device_lock(dev);
-
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
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
-
-		put_device(dev);
-		put_device(parent);
+		async_schedule_domain(shutdown_device, dev,
+			dev->parent ? &parent->p->child_domain : &top_domain);
 
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+	async_synchronize_full_domain(&top_domain);
 }
 
 /*
diff --git a/include/linux/async.h b/include/linux/async.h
index cce4ad31e8fc..ab62402452f8 100644
--- a/include/linux/async.h
+++ b/include/linux/async.h
@@ -35,6 +35,12 @@ struct async_domain {
 	struct async_domain _name = { .pending = LIST_HEAD_INIT(_name.pending), \
 				      .registered = 0 }
 
+static inline void INIT_ASYNC_DOMAIN_EXCLUSIVE(struct async_domain *domain)
+{
+	INIT_LIST_HEAD(&domain->pending);
+	domain->registered = 0;
+}
+
 async_cookie_t async_schedule_node(async_func_t func, void *data,
 				   int node);
 async_cookie_t async_schedule_node_domain(async_func_t func, void *data,
-- 
2.39.3

