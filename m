Return-Path: <linux-kernel+bounces-56919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B325F84D160
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217F01F235EB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BC885952;
	Wed,  7 Feb 2024 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNO4T+9B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B882889
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331348; cv=none; b=cZQv2ypLAAq64lVg9+z12cWkZ2xai0q2HYBOR4dXToR9LAjGF6g3eA7zcYiD9eZ6JkIu+zXYr73FibT6oCufH9rbe3iYAl7l80kd9/oaZDKczGMLc8T1LGd9TICjvwihwaINsqe5fxMzM5pi9g2QFBaWIPIouC8OGWrBB0zNDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331348; c=relaxed/simple;
	bh=IAD5k7mJ5GTdKJh3kH8fpJh/ezNJOFY0mEoN0yEKfYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLfwIDx9L3oE1UcbYlQINGx7nl/NfpmgxtDSh0NEs+/2LWOylAbVcaJNG939P1K1wyDN3RRZCDfxS7Euv8k7XK5ePA3PdxiSQi3Gpfzc9n/l2fA+7jDl5eSZA1hzYzn+ikVLSHdUhK1AJRWmMHPG+SKu5bnxpmENS7hpiXf2BLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNO4T+9B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707331344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTFy4nGaIuyAjRSeWWj3icZv9u9DGODaCpUqVFylGh8=;
	b=FNO4T+9BLt37qyocVqxh7WZpBdhVDEAFm0IXUC8sZJSGsN49OJrj18LRdnCRZWaFnRnLce
	13oni/405hzaelV6/W+S6ZqBGVkVGHzQfIlGZrK7TpyKLPD5/Nwg0eaSh4rzoY87nX6xn3
	hcavhR8CNChjq56FTvPbqM7kdhjlb5A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-K0PNYfJIP2qWNiPNid8kCQ-1; Wed,
 07 Feb 2024 13:42:21 -0500
X-MC-Unique: K0PNYfJIP2qWNiPNid8kCQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2C5338212C5;
	Wed,  7 Feb 2024 18:42:20 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.32.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66FB2400D6D2;
	Wed,  7 Feb 2024 18:42:20 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: [RFC PATCH 2/6] Improve ability to perform async shutdown in parallel
Date: Wed,  7 Feb 2024 13:40:56 -0500
Message-ID: <20240207184100.18066-3-djeffery@redhat.com>
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

Expands the async shutdown implementation to allow more cases of parallel
async shutdown. A field is added so that a device under async shutdown can
mark its parent as busy due to the async shutdown. A busy parent on reaching
the head of the shutdown list gets stored and flags its own parent as busy.

Once the async shutdown operations are completed, the stored parents are
returned to the shutdown list and shut down in an order maintaining their
parent-child ordering. Unlike the minimal implementation, this allows more
end nodes of the device tree to be under async shutdown in parallel.

A cap on the number of async shutdown devices is still enforced, though not
required and could be removed if desired.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by:     Laurence Oberman <loberman@redhat.com>

---
 drivers/base/base.h |  1 +
 drivers/base/core.c | 71 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index eb4c0ace9242..954008bd39e5 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -116,6 +116,7 @@ struct device_private {
 	char *deferred_probe_reason;
 	struct device *device;
 	u8 dead:1;
+	u8 child_shutdown:1;
 };
 #define to_device_private_parent(obj)	\
 	container_of(obj, struct device_private, knode_parent)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5bc2282c00cd..e88d418bf0fd 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4720,9 +4720,10 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 EXPORT_SYMBOL_GPL(device_change_owner);
 
 
-#define MAX_ASYNC_SHUTDOWNS 32
+#define MAX_ASYNC_SHUTDOWNS 256
 static int async_shutdown_count;
 static LIST_HEAD(async_shutdown_list);
+static LIST_HEAD(async_delayed_list);
 
 /**
  * If a device has a child busy with an async shutdown or there are too many
@@ -4730,15 +4731,15 @@ static LIST_HEAD(async_shutdown_list);
  */
 static bool may_shutdown_device(struct device *dev)
 {
-	struct device *tmp;
-
-	if (async_shutdown_count >= MAX_ASYNC_SHUTDOWNS)
+	if (dev->p->child_shutdown) {
+		if (list_empty(&async_shutdown_list)) {
+			dev_err(dev, "child_shutdown set but no children? Clearing\n");
+			dev->p->child_shutdown = 0;
+			return true;
+		}
 		return false;
-
-	list_for_each_entry(tmp, &async_shutdown_list, kobj.entry) {
-		if (tmp->parent == dev)
-			return false;
 	}
+
 	return true;
 }
 
@@ -4753,6 +4754,9 @@ static void async_shutdown_start(struct device *dev, void (*callback) (struct de
 	(*callback)(dev);
 	list_add_tail(&dev->kobj.entry, &async_shutdown_list);
 	async_shutdown_count++;
+
+	if (dev->parent)
+		dev->parent->p->child_shutdown = 1;
 }
 
 /**
@@ -4760,7 +4764,7 @@ static void async_shutdown_start(struct device *dev, void (*callback) (struct de
  */
 static void wait_for_active_async_shutdown(void)
 {
-	struct device *dev, *parent;
+	struct device *dev, *parent, *tmp;
 
         while (!list_empty(&async_shutdown_list)) {
                 dev = list_entry(async_shutdown_list.next, struct device,
@@ -4787,15 +4791,29 @@ static void wait_for_active_async_shutdown(void)
 			dev->driver->async_shutdown_end(dev);
 		}
                 device_unlock(dev);
-                if (parent)
-                        device_unlock(parent);
-
+                if (parent) {
+			tmp = parent;
+			do {
+				tmp->p->child_shutdown = 0;
+				device_unlock(tmp);
+
+				tmp = tmp->parent;
+				if (!tmp || !tmp->p->child_shutdown)
+					break;
+				device_lock(tmp);
+			} while (1);
+		}
                 put_device(dev);
                 put_device(parent);
         }
 	if (initcall_debug)
 		printk(KERN_INFO "device shutdown: waited for %d async shutdown callbacks\n", async_shutdown_count);
+
 	async_shutdown_count = 0;
+	spin_lock(&devices_kset->list_lock);
+	list_splice_tail_init(&async_delayed_list, &devices_kset->list);
+	spin_unlock(&devices_kset->list_lock);
+
 }
 
 /**
@@ -4810,7 +4828,7 @@ void device_shutdown(void)
 	device_block_probing();
 
 	cpufreq_suspend();
-
+restart:
 	spin_lock(&devices_kset->list_lock);
 	/*
 	 * Walk the devices list backward, shutting down each in turn.
@@ -4832,12 +4850,15 @@ void device_shutdown(void)
 		get_device(dev);
 
                 if (!may_shutdown_device(dev)) {
+			list_move(&dev->kobj.entry, &async_delayed_list);
+			if (parent) {
+				device_lock(parent);
+				parent->p->child_shutdown = 1;
+				device_unlock(parent);
+			}
+
 			put_device(dev);
 			put_device(parent);
-
-			spin_unlock(&devices_kset->list_lock);
-			wait_for_active_async_shutdown();
-			spin_lock(&devices_kset->list_lock);
 			continue;
 		}
 
@@ -4863,14 +4884,16 @@ void device_shutdown(void)
 			dev->class->shutdown_pre(dev);
 		}
 		if (dev->bus && dev->bus->async_shutdown_start) {
-			async_shutdown_start(dev, dev->bus->async_shutdown_start);
+			async_shutdown_start(dev,
+					     dev->bus->async_shutdown_start);
 			async_busy = true;
 		} else if (dev->bus && dev->bus->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
 			dev->bus->shutdown(dev);
 		} else if (dev->driver && dev->driver->async_shutdown_start) {
-			async_shutdown_start(dev, dev->driver->async_shutdown_start);
+			async_shutdown_start(dev,
+					     dev->driver->async_shutdown_start);
 			async_busy = true;
 		} else if (dev->driver && dev->driver->shutdown) {
 			if (initcall_debug)
@@ -4891,14 +4914,22 @@ void device_shutdown(void)
 			put_device(parent);
 		}
 
+		if (async_shutdown_count == MAX_ASYNC_SHUTDOWNS)
+			wait_for_active_async_shutdown();
+
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
 	/*
-	 * Wait for any async shutdown still running.
+	 * Wait for any async shutdown still running, then restart the loop
+	 * if the list is no longer empty from delayed entries returning to
+	 * the list.
 	 */
 	if (!list_empty(&async_shutdown_list))
 		wait_for_active_async_shutdown();
+
+	if(!list_empty(&devices_kset->list))
+		goto restart;
 }
 
 /*
-- 
2.43.0


