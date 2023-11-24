Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B337F76F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345489AbjKXOxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345401AbjKXOxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:53:42 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD92319A8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:53:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r6XYp-0006o7-QN; Fri, 24 Nov 2023 15:53:39 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r6XYp-00BI0z-6Z; Fri, 24 Nov 2023 15:53:39 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1r6XYp-00D3m4-0G;
        Fri, 24 Nov 2023 15:53:39 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v1 2/3] driver core: introduce prioritized device shutdown sequence
Date:   Fri, 24 Nov 2023 15:53:37 +0100
Message-Id: <20231124145338.3112416-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231124145338.3112416-1-o.rempel@pengutronix.de>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit revises the device shutdown mechanism to implement a
prioritized shutdown sequence. The new function,
prioritized_device_shutdown, ensures devices are shut down in reverse
order, mirroring the system construction order. Within this process,
devices are shut down based on their assigned priority levels.
Additionally, this patch ensures that a device inherits its shutdown
priority from its parent, maintaining hierarchy integrity. This is
crucial to prevent child nodes of high-priority parents from being
orphaned in the shutdown sequence.

This change is vital in scenarios like power drops with limited backup
energy, where shutdown time is constrained. By prioritizing critical
devices, particularly storage, the focus is on maintaining device
integrity by ensuring they are properly shut down. This approach reduces
the risk of hardware damage and enhances system resilience during
emergency shutdowns.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/base/core.c    | 53 ++++++++++++++++++++++++++++++++++--------
 include/linux/device.h | 51 +++++++++++++++++++++++++++++++++++++++-
 kernel/reboot.c        |  4 ++--
 3 files changed, 95 insertions(+), 13 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0f5646a097d3..5b6989e9ae4d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3554,9 +3554,13 @@ int device_add(struct device *dev)
 	if (kobj)
 		dev->kobj.parent = kobj;
 
-	/* use parent numa_node */
-	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
-		set_dev_node(dev, dev_to_node(parent));
+	if (parent) {
+		/* use parent numa_node */
+		if (dev_to_node(dev) == NUMA_NO_NODE)
+			set_dev_node(dev, dev_to_node(parent));
+
+		dev_inherit_shutdown_priority(dev, parent);
+	}
 
 	/* first, register with generic layer. */
 	/* we require the name to be set before, and pass NULL */
@@ -4553,6 +4557,8 @@ int device_move(struct device *dev, struct device *new_parent,
 		klist_add_tail(&dev->p->knode_parent,
 			       &new_parent->p->klist_children);
 		set_dev_node(dev, dev_to_node(new_parent));
+
+		dev_inherit_shutdown_priority(dev, new_parent);
 	}
 
 	if (dev->class) {
@@ -4568,6 +4574,8 @@ int device_move(struct device *dev, struct device *new_parent,
 					klist_add_tail(&dev->p->knode_parent,
 						       &old_parent->p->klist_children);
 					set_dev_node(dev, dev_to_node(old_parent));
+
+					dev_inherit_shutdown_priority(dev, old_parent);
 				}
 			}
 			cleanup_glue_dir(dev, new_parent_kobj);
@@ -4781,28 +4789,53 @@ static void device_shutdown_one_locked(struct device *dev)
 }
 
 /**
- * device_shutdown - call ->shutdown() on each device to shutdown.
+ * prioritized_device_shutdown - shut down devices in reverse and priority order
+ *
+ * This function is designed to shut down devices in a manner that mirrors the
+ * reverse order of system construction. It iterates over the devices in
+ * reverse, ensuring that the system is torn down in a similar order to how it
+ * was set up. Importantly, within this reverse order, the function also employs
+ * a device shutdown priority mechanism. This prioritization ensures that
+ * critical devices are shut down in an orderly and safe manner before less
+ * critical devices.
+ *
+ * This prioritized and reverse order shutdown is particularly crucial in
+ * emergency scenarios where there is a limited time window for shutdown, such
+ * as in the event of a power drop backed by limited energy source like
+ * capacitors. It ensures that essential systems and data are secured first,
+ * reducing the risk of data loss and system instability.
  */
-void device_shutdown(void)
+void prioritized_device_shutdown(void)
 {
-	struct device *dev;
+	enum device_shutdown_priority current_prio = DEVICE_SHUTDOWN_PRIO_MAX;
 
 	wait_for_device_probe();
 	device_block_probing();
 
 	cpufreq_suspend();
 
-	spin_lock(&devices_kset->list_lock);
 	/*
 	 * Walk the devices list backward, shutting down each in turn.
 	 * Beware that device unplug events may also start pulling
 	 * devices offline, even as the system is shutting down.
 	 */
+	spin_lock(&devices_kset->list_lock);
 	while (!list_empty(&devices_kset->list)) {
-		dev = list_entry(devices_kset->list.prev, struct device,
-				kobj.entry);
+		struct device *dev, *n;
+		enum device_shutdown_priority next_prio = 0;
+
+		list_for_each_entry_safe_reverse(dev, n, &devices_kset->list,
+						 kobj.entry) {
+			enum device_shutdown_priority dev_prio;
+
+			dev_prio = dev_get_shutdown_priority(dev);
+			if (dev_prio >= current_prio)
+				device_shutdown_one_locked(dev);
+			else if (dev_prio > next_prio)
+				next_prio = dev_prio;
+		}
 
-		device_shutdown_one_locked(dev);
+		current_prio = next_prio;
 	}
 	spin_unlock(&devices_kset->list_lock);
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index d7a72a8749ea..1c43a6326417 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -580,6 +580,33 @@ enum device_physical_location_horizontal_position {
 	DEVICE_HORI_POS_RIGHT,
 };
 
+/**
+ * enum device_shutdown_priority - Defines device shutdown priorities
+ *
+ * This enum defines different priority levels for device shutdown
+ * during a system power-off sequence. The priorities ensure that critical
+ * devices are shut down in an orderly and safe manner before less critical
+ * devices. Each device in the system is assigned a priority level, which
+ * determines the order in which it is shut down.
+ *
+ * @DEVICE_SHUTDOWN_PRIO_DEFAULT: The default shutdown priority for devices
+ * that do not require special handling or have no specific shutdown order.
+ * This is the lowest priority level.
+ *
+ * @DEVICE_SHUTDOWN_PRIO_STORAGE: Priority level for storage devices such as
+ * hard drives, SSDs, and SD cards. These devices often need to be shut down
+ * early to ensure data integrity and prevent corruption.
+ *
+ * @DEVICE_SHUTDOWN_PRIO_MAX: Represents the highest possible priority level
+ * for device shutdown. This is used as an upper bound for the priority range
+ * and typically not assigned to actual devices.
+ */
+enum device_shutdown_priority {
+	DEVICE_SHUTDOWN_PRIO_DEFAULT = 0,
+	DEVICE_SHUTDOWN_PRIO_STORAGE,
+	DEVICE_SHUTDOWN_PRIO_MAX,
+};
+
 /**
  * struct device_physical_location - Device data related to physical location
  * of the device connection point.
@@ -693,6 +720,8 @@ struct device_physical_location {
  *		and optionall (if the coherent mask is large enough) also
  *		for dma allocations.  This flag is managed by the dma ops
  *		instance from ->dma_supported.
+ * @shutdown_priority: Shutdown ordering priority for the device.
+ * @inher_shutdown_priority: Inherited shutdown ordering priority from parent.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -805,6 +834,8 @@ struct device {
 #ifdef CONFIG_DMA_OPS_BYPASS
 	bool			dma_ops_bypass : 1;
 #endif
+	enum device_shutdown_priority	shutdown_priority;
+	enum device_shutdown_priority	inher_shutdown_priority;
 };
 
 /**
@@ -1046,6 +1077,24 @@ static inline bool dev_removable_is_valid(struct device *dev)
 	return dev->removable != DEVICE_REMOVABLE_NOT_SUPPORTED;
 }
 
+static inline void dev_set_shutdown_priority(struct device *dev,
+					enum device_shutdown_priority priority)
+{
+	dev->shutdown_priority = priority;
+}
+
+static inline enum device_shutdown_priority
+dev_get_shutdown_priority(struct device *dev)
+{
+	return max(dev->shutdown_priority, dev->inher_shutdown_priority);
+}
+
+static inline void dev_inherit_shutdown_priority(struct device *dev,
+						 struct device *parent)
+{
+	dev->inher_shutdown_priority = dev_get_shutdown_priority(parent);
+}
+
 /*
  * High level routines for use by the bus drivers
  */
@@ -1236,7 +1285,7 @@ static inline int devtmpfs_mount(void) { return 0; }
 #endif
 
 /* drivers/base/power/shutdown.c */
-void device_shutdown(void);
+void prioritized_device_shutdown(void);
 
 /* debugging and troubleshooting/diagnostic helpers. */
 const char *dev_driver_string(const struct device *dev);
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 395a0ea3c7a8..ac5820020c6a 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -85,7 +85,7 @@ void kernel_restart_prepare(char *cmd)
 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
 	usermodehelper_disable();
-	device_shutdown();
+	prioritized_device_shutdown();
 }
 
 /**
@@ -285,7 +285,7 @@ static void kernel_shutdown_prepare(enum system_states state)
 		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
 	system_state = state;
 	usermodehelper_disable();
-	device_shutdown();
+	prioritized_device_shutdown();
 }
 /**
  *	kernel_halt - halt the system
-- 
2.39.2

