Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E61756DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjGQTzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjGQTy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:54:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D84132;
        Mon, 17 Jul 2023 12:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689623696; x=1721159696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2xbT6EtzugjSRFFrln/TM5wlJ9GWyKvZn6kt6CFH6kc=;
  b=DOVocLHQ2vDxM/4w+zs3+q45L0dFt9VjqfVZL1gwb9CEKpeUXOaTO2I9
   Ps2l89gacoY6C546oHqOcC9R9LQC1TkALqNjFiZ7/vOFIg8HqaqPTKoQF
   XQgRrwtVg78D9UNn8//lnCMlKICe1VXIrI+8IjZT+Qn6VjFfZ7TrXvvGi
   R9HiARlM+TrVMHVMN2kOqPIGDI+k4iLB8bsaN6Dw/WxMBiHjs04NOFHYg
   b/oiPXTZ2k0sidpTlZVBX84CLtDaoTGiz47dcp9v5wqAu4xW+J7sPmA6u
   eAOKCt3uCEapR1Pbn06W2qUGBuFI7X27z3CVC/oQ+PnJgeY+9Yn6dxx++
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366064611"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="366064611"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 12:54:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="788770759"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="788770759"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2023 12:54:55 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 5/7] thermal: int340x: processor_thermal: Add workload type hint
Date:   Mon, 17 Jul 2023 12:54:03 -0700
Message-Id: <20230717195405.730869-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717195405.730869-1-srinivas.pandruvada@linux.intel.com>
References: <20230717195405.730869-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
workload type without user space. To avoid duplicate processing, the user
space can read the same workload type hint from the firmware instead of
implementing its own prediction.

This workload hint is passed from the firmware via a MMIO offset 0x5B18.
Before receiving the hint, firmware needs to be configured via a mailbox
command. This mailbox command enables interrupt and notification delay.
This notification delay can be changed from user space.

This workload hint is passed via sysfs attribute group "workload_hint".

This attribute group contains following attributes:

workload_type_enable: Enables/disables workload type hints from the
firmware.

notification_delay_ms: Notification delay in milli seconds.

workload_type_index: The current workload type index predicted by the
firmware. Refer to the documentation for meaning of each index value.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
Update comments only

 .../driver-api/thermal/intel_dptf.rst         |  38 +++
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../processor_thermal_device.c                |   9 +
 .../processor_thermal_device.h                |   7 +
 .../processor_thermal_device_pci.c            |   3 +-
 .../processor_thermal_wlt_hint.c              | 238 ++++++++++++++++++
 6 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_wlt_hint.c

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index 9ab4316322a1..5cba02c4c308 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -315,3 +315,41 @@ DPTF Fan Control
 ----------------------------------------
 
 Refer to Documentation/admin-guide/acpi/fan_performance_states.rst
+
+Workload Type Hints
+----------------------------------------
+
+The firmware in Meteor Lake processor generation is capable of predicting
+workload type and pass hints to OS. These hints can be enabled and read
+from user space. User space can poll attribute "workload_type_index" for
+the current hint or can get notification when this attribute is changed.
+
+file:`/sys/bus/pci/devices/0000:00:04.0/workload_hint/`
+
+``workload_hint_enable`` (RW)
+	Enable firmware to send workload type hints from user space.
+
+``notification_delay_ms`` (RW)
+	Minimum delay in milli seconds before firmware will notify OS.
+
+``workload_type_index`` (RO)
+	Predicted workload type index.
+	The index and description on Meteor Lake processor:
+
+	0 -  Idle: System performs no tasks, power and residency are consistently
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
+	3 – Bursty: Consumes a relatively constant average amount of power,
+		however, bursts of activity interrupt periods of relative idleness.
+		The bursts are relatively short and spaced with relative idleness
+		which typically do not exhaust RAPL Power Limit 1.
+
+	4 – Unknown: Can't classify.
diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
index 76e053e541f0..ccd0fdd23161 100644
--- a/drivers/thermal/intel/int340x_thermal/Makefile
+++ b/drivers/thermal/intel/int340x_thermal/Makefile
@@ -11,5 +11,6 @@ obj-$(CONFIG_PROC_THERMAL_MMIO_RAPL) += processor_thermal_rapl.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_rfim.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_mbox.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_wlt_req.o
+obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_wlt_hint.o
 obj-$(CONFIG_INT3406_THERMAL)	+= int3406_thermal.o
 obj-$(CONFIG_ACPI_THERMAL_REL)	+= acpi_thermal_rel.o
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 48f6c72b05f6..127deefbb633 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -352,6 +352,12 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
 			dev_err(&pdev->dev, "failed to add MBOX interface\n");
 			goto err_rem_rfim;
 		}
+	} else if (feature_mask & PROC_THERMAL_FEATURE_WLT_HINT) {
+		ret = proc_thermal_wlt_hint_add(pdev, proc_priv);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to add WLT Hint\n");
+			goto err_rem_rfim;
+		}
 	}
 
 	return 0;
@@ -376,10 +382,13 @@ void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *
 
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WLT_REQ)
 		proc_thermal_wlt_req_remove(pdev);
+	else if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WLT_HINT)
+		proc_thermal_wlt_hint_remove(pdev);
 }
 EXPORT_SYMBOL_GPL(proc_thermal_mmio_remove);
 
 MODULE_IMPORT_NS(INTEL_TCC);
+MODULE_IMPORT_NS(INT340X_THERMAL);
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index defc919cb020..bc056712f728 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -61,6 +61,7 @@ struct rapl_mmio_regs {
 #define PROC_THERMAL_FEATURE_DVFS	0x04
 #define PROC_THERMAL_FEATURE_WLT_REQ	0x08
 #define PROC_THERMAL_FEATURE_DLVR	0x10
+#define PROC_THERMAL_FEATURE_WLT_HINT	0x20
 
 #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
 int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
@@ -95,6 +96,12 @@ int processor_thermal_mbox_interrupt_config(struct pci_dev *pdev, bool enable, i
 					    int time_window);
 int proc_thermal_add(struct device *dev, struct proc_thermal_device *priv);
 void proc_thermal_remove(struct proc_thermal_device *proc_priv);
+
+int proc_thermal_wlt_hint_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
+void proc_thermal_wlt_hint_remove(struct pci_dev *pdev);
+void proc_thermal_wlt_intr_callback(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
+bool proc_thermal_check_wlt_intr(struct proc_thermal_device *proc_priv);
+
 int proc_thermal_suspend(struct device *dev);
 int proc_thermal_resume(struct device *dev);
 int proc_thermal_mmio_add(struct pci_dev *pdev,
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 1061d1d8f38d..ee5a4c227d96 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -364,7 +364,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WLT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
-	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR) },
+	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
+	  PROC_THERMAL_FEATURE_WLT_HINT) },
 	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WLT_REQ) },
 	{ },
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_wlt_hint.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_wlt_hint.c
new file mode 100644
index 000000000000..09bd02cf2f7d
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_wlt_hint.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * processor thermal device for reading Workload type hints
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
+ * - proc_thermal_check_wlt_intr(): Check if the interrupt is for
+ * change in workload type. Called from the interrupt context.
+ * - proc_thermal_wlt_intr_callback(): Callback for interrupt processing
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
+#define SOC_WLT_RES_INT_STATUS_OFF	0x5B18
+#define SOC_WLT				GENMASK_ULL(47, 40)
+
+#define SOC_WLT_PREDICTION_INT_ENABLE_BIT	23
+
+#define SOC_WLT_PREDICTION_INT_ACTIVE	BIT(2)
+
+/*
+ * Closest possible to 1 Second is 1024 ms with programmed time delay
+ * of 0x0A.
+ */
+static u8 notify_delay = 0x0A;
+static u16 notify_delay_ms = 1024;
+
+/* Show current predicted workload type index */
+static ssize_t workload_type_index_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct proc_thermal_device *proc_priv;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u64 status = 0;
+	int wlt;
+
+	proc_priv = pci_get_drvdata(pdev);
+
+	status = readq(proc_priv->mmio_base + SOC_WLT_RES_INT_STATUS_OFF);
+	wlt = FIELD_GET(SOC_WLT, status);
+
+	return sysfs_emit(buf, "%d\n", wlt);
+}
+
+static DEVICE_ATTR_RO(workload_type_index);
+
+static u8 wlt_enable;
+
+static ssize_t workload_hint_enable_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%d\n", wlt_enable);
+}
+
+/*
+ * Enable workload type prediction by writing 1 to enable, 0 to
+ * disable
+ */
+static ssize_t workload_hint_enable_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t size)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u8 mode;
+
+	if (kstrtou8(buf, 10, &mode) || mode > 1)
+		return -EINVAL;
+
+	if (mode) {
+		int ret;
+
+		ret = processor_thermal_mbox_interrupt_config(pdev, true,
+							      SOC_WLT_PREDICTION_INT_ENABLE_BIT,
+							      notify_delay);
+		if (ret)
+			return ret;
+	} else {
+		processor_thermal_mbox_interrupt_config(pdev, false,
+							SOC_WLT_PREDICTION_INT_ENABLE_BIT, 0);
+	}
+
+	wlt_enable = mode;
+
+	return size;
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
+	if (new_tw) {
+		u8 tm;
+
+		new_tw = roundup_pow_of_two(new_tw);
+		tm = ilog2(new_tw);
+		if (tm > 31)
+			return -EINVAL;
+
+		ret = processor_thermal_mbox_interrupt_config(pdev, true,
+							      SOC_WLT_PREDICTION_INT_ENABLE_BIT,
+							      tm);
+		if (ret)
+			return ret;
+
+		notify_delay = tm;
+		notify_delay_ms = new_tw;
+	} else {
+		ret = processor_thermal_mbox_interrupt_config(pdev, false,
+							      SOC_WLT_PREDICTION_INT_ENABLE_BIT,
+							      notify_delay);
+		if (ret)
+			return ret;
+	}
+
+	return size;
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
+bool proc_thermal_check_wlt_intr(struct proc_thermal_device *proc_priv)
+{
+	u64 int_status;
+
+	int_status = readq(proc_priv->mmio_base + SOC_WLT_RES_INT_STATUS_OFF);
+	if (int_status & SOC_WLT_PREDICTION_INT_ACTIVE)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_check_wlt_intr, INT340X_THERMAL);
+
+/* Callback to notify user space */
+void proc_thermal_wlt_intr_callback(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
+{
+	u64 status;
+
+	status = readq(proc_priv->mmio_base + SOC_WLT_RES_INT_STATUS_OFF);
+	if (status & SOC_WLT_PREDICTION_INT_ACTIVE) {
+		writeq(status & ~SOC_WLT_PREDICTION_INT_ACTIVE,
+		       proc_priv->mmio_base + SOC_WLT_RES_INT_STATUS_OFF);
+		sysfs_notify(&pdev->dev.kobj, "workload_hint", "workload_type_index");
+	}
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_wlt_intr_callback, INT340X_THERMAL);
+
+static bool workload_hint_created;
+
+int proc_thermal_wlt_hint_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
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
+EXPORT_SYMBOL_NS_GPL(proc_thermal_wlt_hint_add, INT340X_THERMAL);
+
+void proc_thermal_wlt_hint_remove(struct pci_dev *pdev)
+{
+	processor_thermal_mbox_interrupt_config(pdev, false,
+						SOC_WLT_PREDICTION_INT_ENABLE_BIT,
+						notify_delay);
+
+	if (workload_hint_created)
+		sysfs_remove_group(&pdev->dev.kobj, &workload_hint_attribute_group);
+
+	workload_hint_created = false;
+}
+EXPORT_SYMBOL_NS_GPL(proc_thermal_wlt_hint_remove, INT340X_THERMAL);
+
+MODULE_IMPORT_NS(INT340X_THERMAL);
+MODULE_LICENSE("GPL");
-- 
2.38.1

