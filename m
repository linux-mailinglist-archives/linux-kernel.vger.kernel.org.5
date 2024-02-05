Return-Path: <linux-kernel+bounces-52575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17BF8499D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5728D280E76
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6331D52B;
	Mon,  5 Feb 2024 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/4eaYIu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF71BDE0;
	Mon,  5 Feb 2024 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134974; cv=none; b=ROvhW6XXnVxfB07B1yWOKnB7TfFTCec9AVRtZ7mV4dxzsOaT2mY7UuclLZ/+AerZGjM9tQqiIyMVmhGFUXarpLScszCeE+UUN9qo897moTwt/5k/8qj8Wsp9Sxw+bI1GOv4Ga+U1jbbXovV29HYO6b98gqVAYKoUo3qYhn7nBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134974; c=relaxed/simple;
	bh=HewPtQWo7tWPORgACWT0isq/+RxLYJgNeixGj5Mul8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXVvXk2xzOQKA7+xVm+o0wNwJIpQi4kJ6CskiwvmqA4dz5RZBC+QoMk3p4R0lUomVGd+C+lCNIlxWg7LU5tNTyaXbGlRuYPL5ebqcbDXpb+d8PURjUeEf7nq07FT0rpm6W9b+Cixlo3lbuJnFWFKME7sLRrEyH6v/XcX4A0+6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/4eaYIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C586C43390;
	Mon,  5 Feb 2024 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707134974;
	bh=HewPtQWo7tWPORgACWT0isq/+RxLYJgNeixGj5Mul8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F/4eaYIunF6+IO8ZnDsUSI5qkGmgPLG9wJIOI2d/RnTcXpfPIIJAdcWADdPgx8qoN
	 knAkraTNfKt+W2lrZAvWvf8i2D1LO+Qdk3Q+nMxbzozLw2u6fx9XJi+BuS36DR0HB0
	 Bwjf0TyGIbgi9luqXQOLYSPr8tTv5FhU0orBZxiGP08bhYWue7AZxe3uGy77h7hhhx
	 y/yjnjFbbxkkb0uZEEUbejcc2s+T08/cIoGRrQiYt2RP8/S7O4ZMcmwZwf3lWFQOvt
	 n2NMOVd5IQVE4ptuQS/ZXsZB9Y9D+R8vhyw8tczM0c0oXayGQ6J8pcJyvbFpW7BO5J
	 NpN/T3cMjD+pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A4AC48298;
	Mon,  5 Feb 2024 12:09:34 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 05 Feb 2024 13:09:32 +0100
Subject: [PATCH v2 1/2] driver: core: add dedicated workqueue for devlink
 removal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-fix-device-links-overlays-v2-1-5344f8c79d57@analog.com>
References: <20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
In-Reply-To: <20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707134972; l=3618;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=04lEYRnimMPlgUkTJm2JRaX4KnXuISPMtOvIVrmGT4w=;
 b=lwfkR/KxiRZUJunDSN14CeU4IP626N9hjJ6EcdvfTO3/wwBg6qH6hBZdyr82MOG6KDrEutXuL
 YwtUzVGk2I6DoMF8F9GU7korVSTuKL/kHovORS5XXoFa5y3Tbg+Bjzz
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
 drivers/base/core.c    | 32 ++++++++++++++++++++++++++++----
 include/linux/fwnode.h |  1 +
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..4bb9c10489ed 100644
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
@@ -235,6 +237,12 @@ static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *fwnode,
 		__fw_devlink_pickup_dangling_consumers(child, new_sup);
 }
 
+void fwnode_links_flush_queue(void)
+{
+	if (devlink_release_queue)
+		flush_workqueue(devlink_release_queue);
+}
+
 static DEFINE_MUTEX(device_links_lock);
 DEFINE_STATIC_SRCU(device_links_srcu);
 
@@ -531,9 +539,13 @@ static void devlink_dev_release(struct device *dev)
 	 * It may take a while to complete this work because of the SRCU
 	 * synchronization in device_link_release_fn() and if the consumer or
 	 * supplier devices get deleted when it runs, so put it into the "long"
-	 * workqueue.
+	 * devlink workqueue (in case we could allocate one).
+	 *
 	 */
-	queue_work(system_long_wq, &link->rm_work);
+	if (devlink_release_queue)
+		queue_work(devlink_release_queue, &link->rm_work);
+	else
+		device_link_release_fn(&link->rm_work);
 }
 
 static struct class devlink_class = {
@@ -636,10 +648,22 @@ static int __init devlink_class_init(void)
 		return ret;
 
 	ret = class_interface_register(&devlink_class_intf);
-	if (ret)
+	if (ret) {
 		class_unregister(&devlink_class);
+		return ret;
+	}
 
-	return ret;
+	/*
+	 * Using a dedicated queue for devlinks since releasing a link happens
+	 * asynchronously but some code paths, like DT overlays, have some
+	 * expectations regarding the of_node when being removed (the refcount
+	 * must be 1). Given how devlinks are released that cannot be assured.
+	 * Hence, add a dedicated queue so that it's easy to sync against
+	 * devlinks removal.
+	 */
+	devlink_release_queue = alloc_workqueue("devlink_release", 0, 0);
+
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


