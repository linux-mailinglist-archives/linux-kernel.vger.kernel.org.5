Return-Path: <linux-kernel+bounces-86579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FDB86C760
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5DA01F23B72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03097AE74;
	Thu, 29 Feb 2024 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dulW2t5m"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7677AE60;
	Thu, 29 Feb 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203940; cv=none; b=cYx8usXG/LeT/tghb64/WcAVgqyqLkGlkbq8ETstCWxUt2EukhsZCqJXuyW2wuR1XlcXrbQAWDCcOJnpxXjXewbZLBgFphOE7TPtQLOcVueRk3aZDejdsuLZutigbZ8lPOZrNV4wo+cfamSrXoqh457ufPNYKwugdR/NhA+ljFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203940; c=relaxed/simple;
	bh=SSEgSmIjvoB6heog7+gtc8Uy+8npFtBEk7ueeKXKYuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8h0/sokOXWaHHbak05lMsd7P/NBorJ6Gkoefvl37pqpUba7Vl8i3boLIkhkvOCsMv+bMkIMhLCdy8vGYhXU0VRM5qcB9+dEHTEpUWnyueN3DdfvSmYBhRsXBrU3BwmgOs2xi3XzmsHo1ZA9vVCDW3SMZhiSQx7zcjhvNJeqFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dulW2t5m; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 869EDC0005;
	Thu, 29 Feb 2024 10:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709203935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1xdIudFYP++8Jopq2IvnU8pitcTKUx9uYl+U7XwqORA=;
	b=dulW2t5mFd03HHceprIxDApC7CVVcwL4V8q7pTLjivkclLri59bjTCSR61wVmfAHEQmwAf
	jQsMT2Uu/f3RUN0jktqdnHx8Vv1cwxe5uupiVA7DbGIX6cRTagHDDrREil+IpRPM0Flyay
	qlkRefvEDG00hpeoRkOrV9I+mzD4aj4W+yKQxNhmKyThQbmv1yj+1l7yvhWiM6kYCAR3Yq
	hBYdR/jTyaeDvlxA2lOZ8lxn+RXtczGdCNzzNDlIf+U/tqGMYSNXtrz7mqXdupZvHS7w0r
	LGK0NPEhkf5bAYT4yKT822qyX0iix3iUwxkKggI2jlnYfqiW/kQm+z2icq+p/g==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] driver core: Introduce device_link_wait_removal()
Date: Thu, 29 Feb 2024 11:52:02 +0100
Message-ID: <20240229105204.720717-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229105204.720717-1-herve.codina@bootlin.com>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
introduces a workqueue to release the consumer and supplier devices used
in the devlink.
In the job queued, devices are release and in turn, when all the
references to these devices are dropped, the release function of the
device itself is called.

Nothing is present to provide some synchronisation with this workqueue
in order to ensure that all ongoing releasing operations are done and
so, some other operations can be started safely.

For instance, in the following sequence:
  1) of_platform_depopulate()
  2) of_overlay_remove()

During the step 1, devices are released and related devlinks are removed
(jobs pushed in the workqueue).
During the step 2, OF nodes are destroyed but, without any
synchronisation with devlink removal jobs, of_overlay_remove() can raise
warnings related to missing of_node_put():
  ERROR: memory leak, expected refcount 1 instead of 2

Indeed, the missing of_node_put() call is going to be done, too late,
from the workqueue job execution.

Introduce device_link_wait_removal() to offer a way to synchronize
operations waiting for the end of devlink removals (i.e. end of
workqueue jobs).
Also, as a flushing operation is done on the workqueue, the workqueue
used is moved from a system-wide workqueue to a local one.

Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/base/core.c    | 26 +++++++++++++++++++++++---
 include/linux/device.h |  1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d5f4e4aac09b..80d9430856a8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
 static void __fw_devlink_link_to_consumers(struct device *dev);
 static bool fw_devlink_drv_reg_done;
 static bool fw_devlink_best_effort;
+static struct workqueue_struct *device_link_wq;
 
 /**
  * __fwnode_link_add - Create a link between two fwnode_handles.
@@ -532,12 +533,26 @@ static void devlink_dev_release(struct device *dev)
 	/*
 	 * It may take a while to complete this work because of the SRCU
 	 * synchronization in device_link_release_fn() and if the consumer or
-	 * supplier devices get deleted when it runs, so put it into the "long"
-	 * workqueue.
+	 * supplier devices get deleted when it runs, so put it into the
+	 * dedicated workqueue.
 	 */
-	queue_work(system_long_wq, &link->rm_work);
+	queue_work(device_link_wq, &link->rm_work);
 }
 
+/**
+ * device_link_wait_removal - Wait for ongoing devlink removal jobs to terminate
+ */
+void device_link_wait_removal(void)
+{
+	/*
+	 * devlink removal jobs are queued in the dedicated work queue.
+	 * To be sure that all removal jobs are terminated, ensure that any
+	 * scheduled work has run to completion.
+	 */
+	drain_workqueue(device_link_wq);
+}
+EXPORT_SYMBOL_GPL(device_link_wait_removal);
+
 static struct class devlink_class = {
 	.name = "devlink",
 	.dev_groups = devlink_groups,
@@ -4099,9 +4114,14 @@ int __init devices_init(void)
 	sysfs_dev_char_kobj = kobject_create_and_add("char", dev_kobj);
 	if (!sysfs_dev_char_kobj)
 		goto char_kobj_err;
+	device_link_wq = alloc_workqueue("device_link_wq", 0, 0);
+	if (!device_link_wq)
+		goto wq_err;
 
 	return 0;
 
+ wq_err:
+	kobject_put(sysfs_dev_char_kobj);
  char_kobj_err:
 	kobject_put(sysfs_dev_block_kobj);
  block_kobj_err:
diff --git a/include/linux/device.h b/include/linux/device.h
index 1795121dee9a..d7d8305a72e8 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1249,6 +1249,7 @@ void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
+void device_link_wait_removal(void);
 
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
-- 
2.43.0


