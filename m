Return-Path: <linux-kernel+bounces-49824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E47D847010
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB110B24559
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2A41419A4;
	Fri,  2 Feb 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoZV5JNv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F414076C;
	Fri,  2 Feb 2024 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876302; cv=none; b=puxDza5FWsxvOWletooWE9YMncnk1vS3Vow11lfhwa+jZr+WK6v1GLiRS0we1ahNMcMW2L6v83M/CccW4MlensUkufQjGJ2Y2N9V26H9Nzi9FhflfD4qBSkRSjCGfnMeOYZgDuO92364X1FS+lvnqlJ4kbCccrBhgFVrOaYb7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876302; c=relaxed/simple;
	bh=cDD6zWE+hIAQdurFS+rSICTH3h1uOHnIQoJ80Fb5RoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V67XxXrdhOUzjM6Nh7uPFmirMGl8KoynGVPexnGs7Vrl/tul+JUXnQtsiQFV2ranqt/BuOXI1PgSmbYtMYUW4uhwz0XgWf00PB4fTEUcuHDLe7R3kjQ3n8ejJSmXRWafxpItVphd2L0g6Ju5OALN3JTBRJw4WmppKUA9sS7bZAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoZV5JNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA050C433F1;
	Fri,  2 Feb 2024 12:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706876302;
	bh=cDD6zWE+hIAQdurFS+rSICTH3h1uOHnIQoJ80Fb5RoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AoZV5JNv3oQO7IebuQ+al5XeD5XyLhj9FV4qgqVMmvTc2AHrq8seQEQec6+vns13S
	 OrpsotHKZ8p6k3UUVmjMRo0L1vf9jImRW5GKfWBVLWQqeVnREKuq5NUqqPPGRWBuUC
	 6gAk26wDcIBcK1RJKZ9SgkZN/DDQDEr8nosZSfDiYjZ/sMIjSXWriLB2eFyV540KOD
	 OAYg/toV4ky+RxvYujwYSPD1cW0ktLyVirTOqE1Y7fPjLySH3qT90i7qs33HsVV01i
	 eOU0dq2xTSNKEpMorLGyzPfWh/xkPxTS6eQkwNrkYgepL1hK5GeTbz0B1Zf6D9xhQp
	 HqvAhUU9KW2NA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC173C48291;
	Fri,  2 Feb 2024 12:18:21 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Feb 2024 13:18:16 +0100
Subject: [PATCH 1/2] driver: core: add dedicated workqueue for devlink
 removal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-fix-device-links-overlays-v1-1-f9fd1404c8e2@analog.com>
References: <20240202-fix-device-links-overlays-v1-0-f9fd1404c8e2@analog.com>
In-Reply-To: <20240202-fix-device-links-overlays-v1-0-f9fd1404c8e2@analog.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706876300; l=3622;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ByQW6bRhqckZ/DlDF0eHD/SVHr3IYmtWZF3VkOkvgCw=;
 b=WICzQqU/L3gsEQRCsjjuaAvWQHaT7MtrCBmtTUWoXIlARhre7lov5EEkAoHQ++K02ag0qs27w
 lA2lR3S4/yjDPZnECukErBUw0XqUC3wNoIIEI7o9or9qJo1hbLkniV6
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Let's use a dedicated queue for devlinks since releasing a link happens
asynchronously but some code paths, like DT overlays, have some
expectations regarding the of_node when being removed (the refcount must
be 1). Given how devlinks are released that cannot be assured. Hence, add a
dedicated queue so that it's easy to sync against devlinks removal.

While at it, make sure to explicitly include <linux/workqueue.h>.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/base/core.c    | 33 +++++++++++++++++++++++++++++----
 include/linux/fwnode.h |  1 +
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..06e7766b5227 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -31,6 +31,7 @@
 #include <linux/swiotlb.h>
 #include <linux/sysfs.h>
 #include <linux/dma-map-ops.h> /* for dma_default_coherent */
+#include <linux/workqueue.h>
 
 #include "base.h"
 #include "physical_location.h"
@@ -44,6 +45,7 @@ static bool fw_devlink_is_permissive(void);
 static void __fw_devlink_link_to_consumers(struct device *dev);
 static bool fw_devlink_drv_reg_done;
 static bool fw_devlink_best_effort;
+static struct workqueue_struct *devlink_release_queue __ro_after_init;
 
 /**
  * __fwnode_link_add - Create a link between two fwnode_handles.
@@ -235,6 +237,11 @@ static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *fwnode,
 		__fw_devlink_pickup_dangling_consumers(child, new_sup);
 }
 
+void fwnode_links_flush_queue(void)
+{
+	flush_workqueue(devlink_release_queue);
+}
+
 static DEFINE_MUTEX(device_links_lock);
 DEFINE_STATIC_SRCU(device_links_srcu);
 
@@ -531,9 +538,10 @@ static void devlink_dev_release(struct device *dev)
 	 * It may take a while to complete this work because of the SRCU
 	 * synchronization in device_link_release_fn() and if the consumer or
 	 * supplier devices get deleted when it runs, so put it into the "long"
-	 * workqueue.
+	 * devlink workqueue.
+	 *
 	 */
-	queue_work(system_long_wq, &link->rm_work);
+	queue_work(devlink_release_queue, &link->rm_work);
 }
 
 static struct class devlink_class = {
@@ -636,10 +644,27 @@ static int __init devlink_class_init(void)
 		return ret;
 
 	ret = class_interface_register(&devlink_class_intf);
-	if (ret)
+	if (ret) {
+		class_unregister(&devlink_class);
+		return ret;
+	}
+
+	/*
+	 * Using a dedicated queue for devlinks since releasing a link happens
+	 * asynchronously but some code paths, like DT overlays, have some
+	 * expectations regarding the of_node when being removed (the refcount
+	 * must be 1). Given how devlinks are released that cannot be assured.
+	 * Hence, add a dedicated queue so that it's easy to sync against
+	 * devlinks removal.
+	 */
+	devlink_release_queue = alloc_workqueue("devlink_release", 0, 0);
+	if (!devlink_release_queue) {
+		class_interface_unregister(&devlink_class_intf);
 		class_unregister(&devlink_class);
+		return -ENODEV;
+	}
 
-	return ret;
+	return 0;
 }
 postcore_initcall(devlink_class_init);
 
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 2a72f55d26eb..017b170e9903 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -213,5 +213,6 @@ extern bool fw_devlink_is_strict(void);
 int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
 void fwnode_links_purge(struct fwnode_handle *fwnode);
 void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
+void fwnode_links_flush_queue(void);
 
 #endif

-- 
2.43.0


