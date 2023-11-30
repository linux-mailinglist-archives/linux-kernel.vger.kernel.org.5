Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192107FF893
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346601AbjK3Rla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjK3Rl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:41:26 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505A410D9;
        Thu, 30 Nov 2023 09:41:32 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 5795A1BF205;
        Thu, 30 Nov 2023 17:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701366091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZYcrZj6HAsVu5Q51awnJk6PzzvhbxN5gePC1mvCY2w=;
        b=GjgAzYp+S5WY4+3ceyC2RNJMwmWxIw618L4lY8z8QTqOz9pD+uZ9aBpDPoBrsdcvOU0m5J
        w//JloZuZgvptd8q9Rr6X91vCPGpNBAVxv0X2u2xu8ZWQVJFYQwCkn3S1m7qdInJ0RDfyI
        jnyLEaj+D6v1EWYM1t7n8AObgK368bdS/ErOiT0v7bGoS0SIo9+FT10iMb1CBBPjPCVmnh
        7BNHoQK8ZHR7u1Y5v6QJIpJ68zX2CdEkBnuiF7o/heEgFwEoVvNKzLnu1FAK0bWdhuvcaq
        htqaaHjA7C7aPSabvrm0+GJWUl4t3uJxGXvs0S7AQBHHHA5YEVhR2Rr+pKqH+g==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/2] driver core: Introduce device_link_wait_removal()
Date:   Thu, 30 Nov 2023 18:41:08 +0100
Message-ID: <20231130174126.688486-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130174126.688486-1-herve.codina@bootlin.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/base/core.c    | 26 +++++++++++++++++++++++---
 include/linux/device.h |  1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index ac026187ac6a..2e102a77758c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(void);
 static void __fw_devlink_link_to_consumers(struct device *dev);
 static bool fw_devlink_drv_reg_done;
 static bool fw_devlink_best_effort;
+static struct workqueue_struct *fw_devlink_wq;
 
 /**
  * __fwnode_link_add - Create a link between two fwnode_handles.
@@ -530,12 +531,26 @@ static void devlink_dev_release(struct device *dev)
 	/*
 	 * It may take a while to complete this work because of the SRCU
 	 * synchronization in device_link_release_fn() and if the consumer or
-	 * supplier devices get deleted when it runs, so put it into the "long"
-	 * workqueue.
+	 * supplier devices get deleted when it runs, so put it into the
+	 * dedicated workqueue.
 	 */
-	queue_work(system_long_wq, &link->rm_work);
+	queue_work(fw_devlink_wq, &link->rm_work);
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
+	drain_workqueue(fw_devlink_wq);
+}
+EXPORT_SYMBOL_GPL(device_link_wait_removal);
+
 static struct class devlink_class = {
 	.name = "devlink",
 	.dev_groups = devlink_groups,
@@ -4085,9 +4100,14 @@ int __init devices_init(void)
 	sysfs_dev_char_kobj = kobject_create_and_add("char", dev_kobj);
 	if (!sysfs_dev_char_kobj)
 		goto char_kobj_err;
+	fw_devlink_wq = alloc_workqueue("fw_devlink_wq", 0, 0);
+	if (!fw_devlink_wq)
+		goto wq_err;
 
 	return 0;
 
+ wq_err:
+	kobject_put(sysfs_dev_char_kobj);
  char_kobj_err:
 	kobject_put(sysfs_dev_block_kobj);
  block_kobj_err:
diff --git a/include/linux/device.h b/include/linux/device.h
index 2b093e62907a..c26f4b3df2bd 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1250,6 +1250,7 @@ void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
+void device_link_wait_removal(void);
 
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
-- 
2.42.0

