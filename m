Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FAD78BC1C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjH2AYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjH2AXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:23:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422BE124;
        Mon, 28 Aug 2023 17:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693268630; x=1724804630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZWJSYd0mg9dZv7+G/oNIciXDjP80laIwpn7IEGl1G1Y=;
  b=mH68VzZb+46nRcIke7CJgc1Aec+euHdxqcfhBDL5Wy92KNdTlf1e93Mk
   NsPeYnuDC7jzw6qwlfvIgCjGnPqV0LyZYUso3IgX+Lu12CiRVXH5Brjjt
   ppFzcqw9ufJtcZl2BekER+lEZfhGFmCKbwDmj847VcnzuJVibGR/HOzBt
   sMMrKzWDA2PAATzoihbjwKwPM37/WzZ2Pm4apq360s6+4y4rgZTYgypSh
   PEwokso/6ciVBRIdoBv7HPvhh+1l/HS3nslQSMtKTT5qJkoMlNz/sE03R
   dPBezTQ8OyKThRxq9+MuVnPJ5/vWCWciyXWsthpMS4V84IHZy1uiejeAZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="354754229"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="354754229"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 17:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="731989693"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="731989693"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2023 17:23:47 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 5/7] thermal: int340x: processor_thermal: Add workload type hint interface
Date:   Mon, 28 Aug 2023 17:23:44 -0700
Message-Id: <20230829002346.2104251-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829002346.2104251-1-srinivas.pandruvada@linux.intel.com>
References: <20230829002346.2104251-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to Meteor Lake processor generation, user space can pass workload
type request to the firmware. Then firmware can optimize power based on
workload type. User space also uses workload type request to implement
its own heuristics.

The firmware in Meteor Lake processor generation is capable of predicting
workload type without user space help.

To avoid duplicate processing, add a sysfs interface allowing user space
to obtain the workload hint from the firmware instead of trying to
predict the workload type by itself.

This workload hint is passed from the firmware via a MMIO offset 0x5B18
of processor thermal PCI device. Before workload hints can be produced by
the firmware, it needs to be configured via a mailbox command.

This mailbox command turns ON the workload hint. Also allows to program a
notification delay to rate control number of notifications.

This notification delay can be changed from user space vis sysfs.

Attribute group 'workload_hint' in sysfs is used for implementing the
workload hints interface between user space and the kernel.

It contains the following attributes:

workload_type_enable: Enables/disables workload type hints from the
firmware.

notification_delay_ms: Notification delay in milliseconds.

workload_type_index: The current workload type index predicted by the
firmware (see the documentation changes below for supported index
values and their meaning).

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v3:
Updates based on Rafael's review for:
- commit description and header (most of the time copied as is from the suggestions)
- Documentation
	clarify notification_delay_ms
	Other comments copy as is from the suggestions
- Clarify MMIO offset and processor thermal device standard BDF
- Use WT|wt instead of WLT|wlt for file name, defines and function names
- Use *_OFFSET in defines instead of  *_OFF for MMIO offsets 
- Consistantcy on using notification delay as parameter for mailbox during disable
- Remove support for setting 0 notification delay
- Update the feature enable when notification delay is changed when the feature is
already enabled. This will require additional mutex to check the enable status
 
 Others:
- When workload hint feature is not enabled, return -ENODATA instead of default read value of 0


v2:
Update comments only

 .../driver-api/thermal/intel_dptf.rst         |  51 ++++
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../processor_thermal_device.c                |   9 +
 .../processor_thermal_device.h                |   7 +
 .../processor_thermal_device_pci.c            |   3 +-
 .../processor_thermal_wt_hint.c               | 253 ++++++++++++++++++
 6 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index 9ab4316322a1..9a2b31320f10 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -315,3 +315,54 @@ DPTF Fan Control
 ----------------------------------------
 
 Refer to Documentation/admin-guide/acpi/fan_performance_states.rst
+
+Workload Type Hints
+----------------------------------------
+
+The firmware in Meteor Lake processor generation is capable of predicting
+workload type and passing hints regarding it to the OS. A special sysfs
+interface is provided to allow user space to obtain workload type hints from
+the firmware and control the rate at which they are provided.
+
+User space can poll attribute "workload_type_index" for the current hint or
+can receive a notification whenever the value of this attribute is updated.
+
+file:`/sys/bus/pci/devices/0000:00:04.0/workload_hint/`
+The segment 0, bus 0, device 4, function 0 is reserved for the processor thermal
+device on all Intel client processors. So, the above path doesn't change
+based on the processor generation.
+
+``workload_hint_enable`` (RW)
+	Enable firmware to send workload type hints to user space.
+
+``notification_delay_ms`` (RW)
+	Minimum delay in milliseconds before firmware will notify OS. This is for
+	the rate control of notifications. This delay is between changing the workload
+	type prediction in the firmware and notifying the OS about the change.
+	The default delay is 1024 ms. The delay of 0 is invalid. The delay is rounded
+	up to the nearest power of 2 to simplify firmware programming of the delay value.
+	The read of notification_delay_ms attribute shows the effective value used.
+
+``workload_type_index`` (RO)
+	Predicted workload type index. User space can get notification of change via
+	existing sysfs attribute change notification mechanism.
+	The supported index values and their meaning for the Meteor Lake processor
+	generation are as follows:
+
+	0 -  Idle: System performs no tasks, power and idle residency are consistently
+		low for long periods of time.
+
+	1 – Battery Life: Power is relatively low, but the processor may still be
+		actively performing a task, such as video playback for a long period of
+		time.
+
+	2 – Sustained: Power level that is relatively high for a long period
+		of time, with very few to no periods of idleness, which will eventually
+		exhaust RAPL Power Limit 1 and 2.
+
+	3 – Bursty: Consumes a relatively constant average amount of power, but periods
+		of relative idleness are interrupted by bursts of activity. The bursts are
+		relatively short and the periods of relative idleness between them typically
+		prevent RAPL Power Limit 1 from being exhausted.
+
+	4 – Unknown: Can't classify.
diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
index 7e40aebb0556..f33a3ad3bef3 100644
--- a/drivers/thermal/intel/int340x_thermal/Makefile
+++ b/drivers/thermal/intel/int340x_thermal/Makefile
@@ -11,5 +11,6 @@ obj-$(CONFIG_PROC_THERMAL_MMIO_RAPL) += processor_thermal_rapl.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_rfim.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_mbox.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_wt_req.o
+obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_wt_hint.o
 obj-$(CONFIG_INT3406_THERMAL)	+= int3406_thermal.o
 obj-$(CONFIG_ACPI_THERMAL_REL)	+= acpi_thermal_rel.o
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 3f0eac6cb4da..29ed7d0f7022 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -352,6 +352,12 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
 			dev_err(&pdev->dev, "failed to add MBOX interface\n");
 			goto err_rem_rfim;
 		}
+	} else if (feature_mask & PROC_THERMAL_FEATURE_WT_HINT) {
+		ret = proc_thermal_wt_hint_add(pdev, proc_priv);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to add WT Hint\n");
+			goto err_rem_rfim;
+		}
 	}
 
 	return 0;
@@ -376,10 +382,13 @@ void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *
 
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WT_REQ)
 		proc_thermal_wt_req_remove(pdev);
+	else if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WT_HINT)
+		proc_thermal_wt_hint_remove(pdev);
 }
 EXPORT_SYMBOL_GPL(proc_thermal_mmio_remove);
 
 MODULE_IMPORT_NS(INTEL_TCC);
+MODULE_IMPORT_NS(INT340X_THERMAL);
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 0e7725829c24..b974583c5c11 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -61,6 +61,7 @@ struct rapl_mmio_regs {
 #define PROC_THERMAL_FEATURE_DVFS	0x04
 #define PROC_THERMAL_FEATURE_WT_REQ	0x08
 #define PROC_THERMAL_FEATURE_DLVR	0x10
+#define PROC_THERMAL_FEATURE_WT_HINT	0x20
 
 #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
 int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
@@ -95,6 +96,12 @@ int processor_thermal_mbox_interrupt_config(struct pci_dev *pdev, bool enable, i
 					    int time_window);
 int proc_thermal_add(struct device *dev, struct proc_thermal_device *priv);
 void proc_thermal_remove(struct proc_thermal_device *proc_priv);
+
+int proc_thermal_wt_hint_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
+void proc_thermal_wt_hint_remove(struct pci_dev *pdev);
+void proc_thermal_wt_intr_callback(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
+bool proc_thermal_check_wt_intr(struct proc_thermal_device *proc_priv);
+
 int proc_thermal_suspend(struct device *dev);
 int proc_thermal_resume(struct device *dev);
 int proc_thermal_mmio_add(struct pci_dev *pdev,
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index db30c11fd1f7..eed59630fe59 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -365,7 +365,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
-	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR) },
+	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
+	  PROC_THERMAL_FEATURE_WT_HINT) },
 	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ },
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
new file mode 100644
index 000000000000..389fed944c42
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * processor thermal device interface for reading Workload type hints
+ * from the user space. The hints are provided by the firmware.
+ *
+ * Operation:
+ * When user space enables workload type prediction:
+ * - Use mailbox to configure:
+ *	Configure notification delay
+ *	Enable processor thermal device interrupt
+ * - The predicted workload type can be read from MMIO:
+ *	Offset 0x5B18 shows if there was an interrupt
+ *	active for change in workload type and also
+ *	predicted workload type.
+ *
+ * Two interface functions are provided to call when there is a
+ * thermal device interrupt:
+ * - proc_thermal_check_wt_intr(): Check if the interrupt is for
+ * change in workload type. Called from the interrupt context.
+ * - proc_thermal_wt_intr_callback(): Callback for interrupt processing
+ * under thread context. This involves sending notification to user
+ * space that there is a change in the workload type.
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+#include "processor_thermal_device.h"
+
+#define SOC_WT_RES_INT_STATUS_OFFSET	0x5B18
+#define SOC_WT				GENMASK_ULL(47, 40)
+
+#define SOC_WT_PREDICTION_INT_ENABLE_BIT	23
+
+#define SOC_WT_PREDICTION_INT_ACTIVE	BIT(2)
+
+/*
+ * Closest possible to 1 Second is 1024 ms with programmed time delay
+ * of 0x0A.
+ */
+static u8 notify_delay = 0x0A;
+static u16 notify_delay_ms = 1024;
+
+static DEFINE_MUTEX(wt_lock);
+static u8 wt_enable;
+
+/* Show current predicted workload type index */
+static ssize_t workload_type_index_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct proc_thermal_device *proc_priv;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u64 status = 0;
+	int wt;
+
+	mutex_lock(&wt_lock);
+	if (!wt_enable) {
+		mutex_unlock(&wt_lock);
+		return -ENODATA;
+	}
+
+	proc_priv = pci_get_drvdata(pdev);
+
+	status = readq(proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
+
+	mutex_unlock(&wt_lock);
+
+	wt = FIELD_GET(SOC_WT, status);
+
+	return sysfs_emit(buf, "%d\n", wt);
+}
+
+static DEVICE_ATTR_RO(workload_type_index);
+
+static ssize_t workload_hint_enable_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%d\n", wt_enable);
+}
+
+static ssize_t workload_hint_enable_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t size)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u8 mode;
+	int ret;
+
+	if (kstrtou8(buf, 10, &mode) || mode > 1)
+		return -EINVAL;
+
+	mutex_lock(&wt_lock);
+
+	if (mode)
+		ret = processor_thermal_mbox_interrupt_config(pdev, true,
+							      SOC_WT_PREDICTION_INT_ENABLE_BIT,
+							      notify_delay);
+	else
+		ret = processor_thermal_mbox_interrupt_config(pdev, false,
+							      SOC_WT_PREDICTION_INT_ENABLE_BIT, 0);
+
+	if (ret)
+		goto ret_enable_store;
+
+	ret = size;
+	wt_enable = mode;
+
+ret_enable_store:
+	mutex_unlock(&wt_lock);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RW(workload_hint_enable);
+
+static ssize_t notification_delay_ms_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return sysfs_emit(buf, "%u\n", notify_delay_ms);
+}
+
+static ssize_t notification_delay_ms_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t size)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 new_tw;
+	int ret;
+	u8 tm;
+
+	/*
+	 * Time window register value:
+	 * Formula: (1 + x/4) * power(2,y)
+	 * x = 2 msbs, that is [30:29] y = 5 [28:24]
+	 * in INTR_CONFIG register.
+	 * The result will be in milli seconds.
+	 * Here, just keep x = 0, and just change y.
+	 * First round up the user value to power of 2 and
+	 * then take log2, to get "y" value to program.
+	 */
+	ret = kstrtou16(buf, 10, &new_tw);
+	if (ret)
+		return ret;
+
+	if (!new_tw)
+		return -EINVAL;
+
+	new_tw = roundup_pow_of_two(new_tw);
+	tm = ilog2(new_tw);
+	if (tm > 31)
+		return -EINVAL;
+
+	mutex_lock(&wt_lock);
+
+	/* If the workload hint was already enabled, then update with the new delay */
+	if (wt_enable)
+		ret = processor_thermal_mbox_interrupt_config(pdev, true,
+							      SOC_WT_PREDICTION_INT_ENABLE_BIT,
+							      tm);
+	if (!ret) {
+		ret = size;
+		notify_delay = tm;
+		notify_delay_ms = new_tw;
+	}
+
+	mutex_unlock(&wt_lock);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RW(notification_delay_ms);
+
+static struct attribute *workload_hint_attrs[] = {
+	&dev_attr_workload_type_index.attr,
+	&dev_attr_workload_hint_enable.attr,
+	&dev_attr_notification_delay_ms.attr,
+	NULL
+};
+
+static const struct attribute_group workload_hint_attribute_group = {
+	.attrs = workload_hint_attrs,
+	.name = "workload_hint"
+};
+
+/*
+ * Callback to check if the interrupt for prediction is active.
+ * Caution: Called from the interrupt context.
+ */
+bool proc_thermal_check_wt_intr(struct proc_thermal_device *proc_priv)
+{
+	u64 int_status;
+
+	int_status = readq(proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
+	if (int_status & SOC_WT_PREDICTION_INT_ACTIVE)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_check_wt_intr, INT340X_THERMAL);
+
+/* Callback to notify user space */
+void proc_thermal_wt_intr_callback(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
+{
+	u64 status;
+
+	status = readq(proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
+	if (!(status & SOC_WT_PREDICTION_INT_ACTIVE))
+		return;
+
+	writeq(status & ~SOC_WT_PREDICTION_INT_ACTIVE,
+		       proc_priv->mmio_base + SOC_WT_RES_INT_STATUS_OFFSET);
+	sysfs_notify(&pdev->dev.kobj, "workload_hint", "workload_type_index");
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_wt_intr_callback, INT340X_THERMAL);
+
+static bool workload_hint_created;
+
+int proc_thermal_wt_hint_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
+{
+	int ret;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &workload_hint_attribute_group);
+	if (ret)
+		return ret;
+
+	workload_hint_created = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_wt_hint_add, INT340X_THERMAL);
+
+void proc_thermal_wt_hint_remove(struct pci_dev *pdev)
+{
+	mutex_lock(&wt_lock);
+	if (wt_enable)
+		processor_thermal_mbox_interrupt_config(pdev, false,
+							SOC_WT_PREDICTION_INT_ENABLE_BIT,
+							0);
+	mutex_unlock(&wt_lock);
+
+	if (workload_hint_created)
+		sysfs_remove_group(&pdev->dev.kobj, &workload_hint_attribute_group);
+
+	workload_hint_created = false;
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_wt_hint_remove, INT340X_THERMAL);
+
+MODULE_IMPORT_NS(INT340X_THERMAL);
+MODULE_LICENSE("GPL");
-- 
2.40.1

