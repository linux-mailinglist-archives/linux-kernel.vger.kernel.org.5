Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBEF78BC1B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjH2AYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjH2AXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:23:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A6D109;
        Mon, 28 Aug 2023 17:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693268628; x=1724804628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZhHlz5cGwZAVd4NISsCXB1ZJ6sdhqlyJnW1TbQP2/WU=;
  b=AWXJwssHiXRlvife/cpJ0ykJyFKOc/5iYXHZJwNFNGDuCHI6VXBuXwnZ
   DvNxAuqE0KLT/8tppjhNEOHqCMSFSIlKqXn4tu0zr+qVN7UaXWRU+y10a
   Vms8r6sMKaS1pucV4OIYtvAgrNe74KmihFogwLWcN7ToSP3d37r6aowYl
   FOltg/ptuS5ORRVGbuyu4ufcsTXYfO6VUGeYdMj33UcPIsckWZN01PdqQ
   bpnTW3N2d/L2B43ZXvLZ54ygst0xNFpIE7uqnHGFg61Dwtv0vQk//Z3Ga
   7rBQrFFt1av+8G+G3x1KZKMrdFs6bLQ1IRBSUgYRgC1kseVdU6wjuVikU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="354754217"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="354754217"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 17:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="731989681"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="731989681"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2023 17:23:47 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 1/7] thermal: int340x: processor_thermal: Move mailbox code to common module
Date:   Mon, 28 Aug 2023 17:23:40 -0700
Message-Id: <20230829002346.2104251-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829002346.2104251-1-srinivas.pandruvada@linux.intel.com>
References: <20230829002346.2104251-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The processor thermal mailbox is used for workload type request and
also in the processor thermal RFIM module. So, move the workload type
request code to its own module from the current processor thermal
mailbox module.

processor_thermal_mailbox.c contains only mailbox read/write related
source code. The source related to workload_types requests is moved to
a module processor_thermal_wt_req.c.

In addition
-Rename PROC_THERMAL_FEATURE_MBOX to PROC_THERMAL_FEATURE_WT_REQ.
- proc_thermal_mbox_add(), which adds workload type sysfs attribute group
is renamed to proc_thermal_wt_req_add().
-proc_thermal_mbox_remove() is renamed to proc_thermal_wt_req_remove().

While here, resolve check patch warnings for 100 columns for only modified
lines.

No functional changes are expected.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
---
v3:
Use WT|wt for workload files, api and defines for WLT|wlt

v2:
Removed extra blank line at the end of proc_thermal_wlt_req_remove()

 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../processor_thermal_device.c                |   8 +-
 .../processor_thermal_device.h                |  12 +-
 .../processor_thermal_device_pci.c            |  10 +-
 .../processor_thermal_device_pci_legacy.c     |   3 +-
 .../int340x_thermal/processor_thermal_mbox.c  | 130 -----------------
 .../processor_thermal_wt_req.c                | 136 ++++++++++++++++++
 7 files changed, 159 insertions(+), 141 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c

diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
index 4e852ce4a5d5..7e40aebb0556 100644
--- a/drivers/thermal/intel/int340x_thermal/Makefile
+++ b/drivers/thermal/intel/int340x_thermal/Makefile
@@ -10,5 +10,6 @@ obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device_pci.o
 obj-$(CONFIG_PROC_THERMAL_MMIO_RAPL) += processor_thermal_rapl.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_rfim.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_mbox.o
+obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_wt_req.o
 obj-$(CONFIG_INT3406_THERMAL)	+= int3406_thermal.o
 obj-$(CONFIG_ACPI_THERMAL_REL)	+= acpi_thermal_rel.o
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 3ca0a2f5937f..3f0eac6cb4da 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -346,8 +346,8 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
 		}
 	}
 
-	if (feature_mask & PROC_THERMAL_FEATURE_MBOX) {
-		ret = proc_thermal_mbox_add(pdev, proc_priv);
+	if (feature_mask & PROC_THERMAL_FEATURE_WT_REQ) {
+		ret = proc_thermal_wt_req_add(pdev, proc_priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to add MBOX interface\n");
 			goto err_rem_rfim;
@@ -374,8 +374,8 @@ void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *
 	    proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS)
 		proc_thermal_rfim_remove(pdev);
 
-	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_MBOX)
-		proc_thermal_mbox_remove(pdev);
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WT_REQ)
+		proc_thermal_wt_req_remove(pdev);
 }
 EXPORT_SYMBOL_GPL(proc_thermal_mmio_remove);
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 7acaa8f1b896..bae6e3e4e22e 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -59,7 +59,7 @@ struct rapl_mmio_regs {
 #define PROC_THERMAL_FEATURE_RAPL	0x01
 #define PROC_THERMAL_FEATURE_FIVR	0x02
 #define PROC_THERMAL_FEATURE_DVFS	0x04
-#define PROC_THERMAL_FEATURE_MBOX	0x08
+#define PROC_THERMAL_FEATURE_WT_REQ	0x08
 #define PROC_THERMAL_FEATURE_DLVR	0x10
 
 #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
@@ -80,8 +80,14 @@ static void __maybe_unused proc_thermal_rapl_remove(void)
 int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
 void proc_thermal_rfim_remove(struct pci_dev *pdev);
 
-int proc_thermal_mbox_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
-void proc_thermal_mbox_remove(struct pci_dev *pdev);
+int proc_thermal_wt_req_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
+void proc_thermal_wt_req_remove(struct pci_dev *pdev);
+
+#define MBOX_CMD_WORKLOAD_TYPE_READ	0x0E
+#define MBOX_CMD_WORKLOAD_TYPE_WRITE	0x0F
+
+#define MBOX_DATA_BIT_AC_DC		30
+#define MBOX_DATA_BIT_VALID		31
 
 int processor_thermal_send_mbox_read_cmd(struct pci_dev *pdev, u16 id, u64 *resp);
 int processor_thermal_send_mbox_write_cmd(struct pci_dev *pdev, u16 id, u32 data);
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 0d1e98007270..314a726f35c7 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -350,9 +350,13 @@ static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, proc_thermal_pci_suspend,
 			 proc_thermal_pci_resume);
 
 static const struct pci_device_id proc_thermal_pci_ids[] = {
-	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
-	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX | PROC_THERMAL_FEATURE_DLVR) },
-	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
+	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
+	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
+	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
+	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ |
+	  PROC_THERMAL_FEATURE_DLVR) },
+	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
+	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ },
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
index 16fd9df5f36d..ccfdd2f9d973 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
@@ -137,7 +137,8 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ICL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
 	{ PCI_DEVICE_DATA(INTEL, JSL_THERMAL, 0) },
 	{ PCI_DEVICE_DATA(INTEL, SKL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
-	{ PCI_DEVICE_DATA(INTEL, TGL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_MBOX) },
+	{ PCI_DEVICE_DATA(INTEL, TGL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
+	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ },
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
index 0b89a4340ff4..ec766c5615b7 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
@@ -10,18 +10,12 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include "processor_thermal_device.h"
 
-#define MBOX_CMD_WORKLOAD_TYPE_READ	0x0E
-#define MBOX_CMD_WORKLOAD_TYPE_WRITE	0x0F
-
 #define MBOX_OFFSET_DATA		0x5810
 #define MBOX_OFFSET_INTERFACE		0x5818
 
 #define MBOX_BUSY_BIT			31
 #define MBOX_RETRY_COUNT		100
 
-#define MBOX_DATA_BIT_VALID		31
-#define MBOX_DATA_BIT_AC_DC		30
-
 static DEFINE_MUTEX(mbox_lock);
 
 static int wait_for_mbox_ready(struct proc_thermal_device *proc_priv)
@@ -114,128 +108,4 @@ int processor_thermal_send_mbox_write_cmd(struct pci_dev *pdev, u16 id, u32 data
 }
 EXPORT_SYMBOL_NS_GPL(processor_thermal_send_mbox_write_cmd, INT340X_THERMAL);
 
-/* List of workload types */
-static const char * const workload_types[] = {
-	"none",
-	"idle",
-	"semi_active",
-	"bursty",
-	"sustained",
-	"battery_life",
-	NULL
-};
-
-static ssize_t workload_available_types_show(struct device *dev,
-					       struct device_attribute *attr,
-					       char *buf)
-{
-	int i = 0;
-	int ret = 0;
-
-	while (workload_types[i] != NULL)
-		ret += sprintf(&buf[ret], "%s ", workload_types[i++]);
-
-	ret += sprintf(&buf[ret], "\n");
-
-	return ret;
-}
-
-static DEVICE_ATTR_RO(workload_available_types);
-
-static ssize_t workload_type_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	char str_preference[15];
-	u32 data = 0;
-	ssize_t ret;
-
-	ret = sscanf(buf, "%14s", str_preference);
-	if (ret != 1)
-		return -EINVAL;
-
-	ret = match_string(workload_types, -1, str_preference);
-	if (ret < 0)
-		return ret;
-
-	ret &= 0xff;
-
-	if (ret)
-		data = BIT(MBOX_DATA_BIT_VALID) | BIT(MBOX_DATA_BIT_AC_DC);
-
-	data |= ret;
-
-	ret = send_mbox_write_cmd(pdev, MBOX_CMD_WORKLOAD_TYPE_WRITE, data);
-	if (ret)
-		return false;
-
-	return count;
-}
-
-static ssize_t workload_type_show(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	u64 cmd_resp;
-	int ret;
-
-	ret = send_mbox_read_cmd(pdev, MBOX_CMD_WORKLOAD_TYPE_READ, &cmd_resp);
-	if (ret)
-		return false;
-
-	cmd_resp &= 0xff;
-
-	if (cmd_resp > ARRAY_SIZE(workload_types) - 1)
-		return -EINVAL;
-
-	return sprintf(buf, "%s\n", workload_types[cmd_resp]);
-}
-
-static DEVICE_ATTR_RW(workload_type);
-
-static struct attribute *workload_req_attrs[] = {
-	&dev_attr_workload_available_types.attr,
-	&dev_attr_workload_type.attr,
-	NULL
-};
-
-static const struct attribute_group workload_req_attribute_group = {
-	.attrs = workload_req_attrs,
-	.name = "workload_request"
-};
-
-static bool workload_req_created;
-
-int proc_thermal_mbox_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
-{
-	u64 cmd_resp;
-	int ret;
-
-	/* Check if there is a mailbox support, if fails return success */
-	ret = send_mbox_read_cmd(pdev, MBOX_CMD_WORKLOAD_TYPE_READ, &cmd_resp);
-	if (ret)
-		return 0;
-
-	ret = sysfs_create_group(&pdev->dev.kobj, &workload_req_attribute_group);
-	if (ret)
-		return ret;
-
-	workload_req_created = true;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(proc_thermal_mbox_add);
-
-void proc_thermal_mbox_remove(struct pci_dev *pdev)
-{
-	if (workload_req_created)
-		sysfs_remove_group(&pdev->dev.kobj, &workload_req_attribute_group);
-
-	workload_req_created = false;
-
-}
-EXPORT_SYMBOL_GPL(proc_thermal_mbox_remove);
-
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
new file mode 100644
index 000000000000..711c4f761c9a
--- /dev/null
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * processor thermal device for Workload type hints
+ * update from user space
+ *
+ * Copyright (c) 2020-2023, Intel Corporation.
+ */
+
+#include <linux/pci.h>
+#include "processor_thermal_device.h"
+
+/* List of workload types */
+static const char * const workload_types[] = {
+	"none",
+	"idle",
+	"semi_active",
+	"bursty",
+	"sustained",
+	"battery_life",
+	NULL
+};
+
+static ssize_t workload_available_types_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	int i = 0;
+	int ret = 0;
+
+	while (workload_types[i] != NULL)
+		ret += sprintf(&buf[ret], "%s ", workload_types[i++]);
+
+	ret += sprintf(&buf[ret], "\n");
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(workload_available_types);
+
+static ssize_t workload_type_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	char str_preference[15];
+	u32 data = 0;
+	ssize_t ret;
+
+	ret = sscanf(buf, "%14s", str_preference);
+	if (ret != 1)
+		return -EINVAL;
+
+	ret = match_string(workload_types, -1, str_preference);
+	if (ret < 0)
+		return ret;
+
+	ret &= 0xff;
+
+	if (ret)
+		data = BIT(MBOX_DATA_BIT_VALID) | BIT(MBOX_DATA_BIT_AC_DC);
+
+	data |= ret;
+
+	ret = processor_thermal_send_mbox_write_cmd(pdev, MBOX_CMD_WORKLOAD_TYPE_WRITE, data);
+	if (ret)
+		return false;
+
+	return count;
+}
+
+static ssize_t workload_type_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u64 cmd_resp;
+	int ret;
+
+	ret = processor_thermal_send_mbox_read_cmd(pdev, MBOX_CMD_WORKLOAD_TYPE_READ, &cmd_resp);
+	if (ret)
+		return false;
+
+	cmd_resp &= 0xff;
+
+	if (cmd_resp > ARRAY_SIZE(workload_types) - 1)
+		return -EINVAL;
+
+	return sprintf(buf, "%s\n", workload_types[cmd_resp]);
+}
+
+static DEVICE_ATTR_RW(workload_type);
+
+static struct attribute *workload_req_attrs[] = {
+	&dev_attr_workload_available_types.attr,
+	&dev_attr_workload_type.attr,
+	NULL
+};
+
+static const struct attribute_group workload_req_attribute_group = {
+	.attrs = workload_req_attrs,
+	.name = "workload_request"
+};
+
+static bool workload_req_created;
+
+int proc_thermal_wt_req_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
+{
+	u64 cmd_resp;
+	int ret;
+
+	/* Check if there is a mailbox support, if fails return success */
+	ret = processor_thermal_send_mbox_read_cmd(pdev, MBOX_CMD_WORKLOAD_TYPE_READ, &cmd_resp);
+	if (ret)
+		return 0;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &workload_req_attribute_group);
+	if (ret)
+		return ret;
+
+	workload_req_created = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(proc_thermal_wt_req_add);
+
+void proc_thermal_wt_req_remove(struct pci_dev *pdev)
+{
+	if (workload_req_created)
+		sysfs_remove_group(&pdev->dev.kobj, &workload_req_attribute_group);
+
+	workload_req_created = false;
+}
+EXPORT_SYMBOL_GPL(proc_thermal_wt_req_remove);
+
+MODULE_IMPORT_NS(INT340X_THERMAL);
+MODULE_LICENSE("GPL");
-- 
2.40.1

