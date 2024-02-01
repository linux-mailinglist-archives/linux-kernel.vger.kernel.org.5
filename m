Return-Path: <linux-kernel+bounces-47473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB41D844E6C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2E61C28319
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13A13C49B;
	Thu,  1 Feb 2024 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVvtUTcJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E52EACC;
	Thu,  1 Feb 2024 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749674; cv=none; b=KIsMdZyBAVe8utwY6MEV0NBkbZf4zrxB9HLsT52KKUPlCvza4Qm7d1roljGtdTZQgSGT3utay54myiw8s5E9jYO6MYMSTUep8XI65XpUrTrUViEgYWULF/nSMX0tM35nBy4cLuSlXiqrjXe7zN+hO4VRDn6f5sOsJsTc8OgccwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749674; c=relaxed/simple;
	bh=biQMLZUnkVyV4tyTKSCox8eL77UiNWCAiGVihWRmr6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRjn7kUl+8fVkeYOsGCUMXPq9uYgAejK7RibL7MFOBVQEza/jx3ZGkgxUCVWuZVyAavCcssb9ni4PJ+Kf02Ml5e96BbNhhmFerUsJYqYCE++2vsr539SrR8eZfACz3VN7EvqCRQXN7VxQ457LK+02yiPVfhej0/Vm1K+NWRuK5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVvtUTcJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749672; x=1738285672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=biQMLZUnkVyV4tyTKSCox8eL77UiNWCAiGVihWRmr6Y=;
  b=DVvtUTcJZl48MJjJ1hnTLIuX3kZVZMgBCAxzneE1zuMX3r23OYDA9ocM
   i/HJ+9sLVhzvV0r6RIydMaoHpF7jko1x7Jsv3mfFihkYQQcxDZNfex5x4
   9NhUnV2eEHGmKdomJ9/ne2Dy69Ch/QXkVst2hv9gNevu+Kn5Y5+J3ehue
   pfaR9GEPGuH/W/NYEm+uydsISHxY17OrvvEHQMbsLIyfbHV7MAIkiKH37
   vibfLHLlwye+koWoXO5J67A6N/cjnlP6CEBOZrqTId6UCdz+EyjZgz783
   Cywm6Kf5eJxnNwl+Vw5ap9uhM23LJrwx0YDuzUR/bK4RPg2YfHvapOUam
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="11145822"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="11145822"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="37057413"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:49 -0800
Received: from debox1-desk4.lan (unknown [10.212.205.115])
	by linux.intel.com (Postfix) with ESMTP id E7401580E05;
	Wed, 31 Jan 2024 17:07:48 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: netdev@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 4/8] platform/x86/intel/sdsi: Add netlink SPDM transport
Date: Wed, 31 Jan 2024 17:07:43 -0800
Message-Id: <20240201010747.471141-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201010747.471141-1-david.e.box@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel On Demand adds attestation and firmware measurement retrieval
services through use of the protocols defined the Security Protocols and
Data Measurement (SPDM) specification. SPDM messages exchanges are used to
authenticate On Demand hardware and to retrieve signed measurements of the
NVRAM state used to track feature provisioning and the NVRAM state used for
metering services. These allow software to verify the authenticity of the
On Demand hardware as well as the integrity of the reported silicon
configuration.

Add a netlink SPDM transport for sending SPDM messages through the On
Demand mailbox. Provides commands to get a list of SPDM enabled devices,
get the message size limits for SPDM Requesters and Responders, and perform
an SPDM message exchange.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Tested-by: Wendy Wang <wendy.wang@intel.com>
Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.0.1.pdf [1]
---
 Documentation/netlink/specs/intel_sdsi.yaml |  97 ++++++++
 MAINTAINERS                                 |   2 +
 drivers/platform/x86/intel/Makefile         |   2 +-
 drivers/platform/x86/intel/sdsi.c           | 164 ++++++++++++-
 drivers/platform/x86/intel/sdsi.h           |  14 ++
 drivers/platform/x86/intel/sdsi_genl.c      | 249 ++++++++++++++++++++
 include/uapi/linux/intel-sdsi.h             |  40 ++++
 7 files changed, 565 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/netlink/specs/intel_sdsi.yaml
 create mode 100644 drivers/platform/x86/intel/sdsi_genl.c
 create mode 100644 include/uapi/linux/intel-sdsi.h

diff --git a/Documentation/netlink/specs/intel_sdsi.yaml b/Documentation/netlink/specs/intel_sdsi.yaml
new file mode 100644
index 000000000000..eeeaaffe3e81
--- /dev/null
+++ b/Documentation/netlink/specs/intel_sdsi.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: intel-sdsi
+
+protocol: genetlink
+
+doc:
+  Intel On Demand generic netlink ABI for Attestation servives.
+
+attribute-sets:
+  -
+    name: sdsi
+    name-prefix: sdsi-genl-attr-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: devs
+        doc: List of On Demand entries
+        type: nest
+        multi-attr: true
+        nested-attributes: dev-info
+      -
+        name: dev-id
+        type: u32
+      -
+        name: dev-name
+        type: string
+      -
+        name: spdm-req
+        type: binary
+      -
+        name: spdm-rsp
+        type: binary
+      -
+        name: spdm-rsp-size
+        type: u32
+      -
+        name: spdm-req-size
+        type: u32
+  -
+    name: dev-info
+    subset-of: sdsi
+    attributes:
+      -
+        name: dev-id
+        type: u32
+      -
+        name: dev-name
+        type: string
+
+operations:
+  name-prefix: sdsi-genl-cmd-
+  list:
+    -
+      name: unspec
+      doc: unused
+      value: 0
+    -
+      name: get-devs
+      doc: Returns a list of available On Demand entries
+      attribute-set: sdsi
+      do: &get-devs-op
+        request:
+          attributes:
+            - dev-id
+        reply:
+          attributes:
+            - devs
+      dump: *get-devs-op
+    -
+      name: get-info
+      doc: Returns information about On Demand devices
+      attribute-set: sdsi
+      do:
+        request:
+          attributes:
+            - dev-id
+        reply:
+          attributes:
+            - spdm-req-size
+            - spdm-rsp-size
+    -
+      name: get-spdm
+      doc: Send and receive SPDM messages
+      attribute-set: sdsi
+      do:
+        request:
+          attributes:
+            - dev-id
+            - spdm-req
+        reply:
+          attributes:
+            - dev-id
+            - spdm-rsp
diff --git a/MAINTAINERS b/MAINTAINERS
index 09ef8497e48a..523943140bf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11041,8 +11041,10 @@ F:	drivers/platform/x86/intel_scu_*
 INTEL SDSI DRIVER
 M:	David E. Box <david.e.box@linux.intel.com>
 S:	Supported
+F:	drivers/platform/x86/intel/sdsi_genl.c
 F:	drivers/platform/x86/intel/sdsi.c
 F:	drivers/platform/x86/intel/sdsi.h
+F:	include/uapi/linux/sdsi_nl.h
 F:	tools/arch/x86/intel_sdsi/
 F:	tools/testing/selftests/drivers/sdsi/
 
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index c1d5fe05e3f3..e1408d60d6ea 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -28,7 +28,7 @@ intel_int0002_vgpio-y			:= int0002_vgpio.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 intel_oaktrail-y			:= oaktrail.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
-intel_sdsi-y				:= sdsi.o
+intel_sdsi-y				:= sdsi.o sdsi_genl.o
 obj-$(CONFIG_INTEL_SDSI)		+= intel_sdsi.o
 intel_vsec-y				:= vsec.o
 obj-$(CONFIG_INTEL_VSEC)		+= intel_vsec.o
diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index d48bb648f0b2..14821fee249c 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -11,6 +11,7 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -34,6 +35,7 @@
 
 #define SDSI_ENABLED_FEATURES_OFFSET	16
 #define SDSI_FEATURE_SDSI		BIT(3)
+#define SDSI_FEATURE_ATTESTATION	BIT(12)
 #define SDSI_FEATURE_METERING		BIT(26)
 
 #define SDSI_SOCKET_ID_OFFSET		64
@@ -76,11 +78,15 @@
 #define GUID_V2_CNTRL_SIZE		16
 #define GUID_V2_REGS_SIZE		80
 
+LIST_HEAD(sdsi_list);
+DEFINE_MUTEX(sdsi_list_lock);
+
 enum sdsi_command {
 	SDSI_CMD_PROVISION_AKC		= 0x0004,
 	SDSI_CMD_PROVISION_CAP		= 0x0008,
 	SDSI_CMD_READ_STATE		= 0x0010,
 	SDSI_CMD_READ_METER		= 0x0014,
+	SDSI_CMD_ATTESTATION		= 0x1012,
 };
 
 struct sdsi_mbox_info {
@@ -533,6 +539,99 @@ static const struct attribute_group sdsi_group = {
 };
 __ATTRIBUTE_GROUPS(sdsi);
 
+bool sdsi_supports_attestation(struct sdsi_priv *priv)
+{
+	return priv->features & SDSI_FEATURE_ATTESTATION;
+}
+
+/* SPDM transport  */
+int sdsi_spdm_exchange(void *private, const void *request, size_t request_sz,
+		       void *response, size_t response_sz)
+{
+	struct sdsi_priv *priv = private;
+	struct sdsi_mbox_info info = {};
+	size_t spdm_msg_size, size;
+	int ret;
+	u64 *payload __free(kfree) = NULL;
+
+	/*
+	 * For the attestation command, the mailbox write size is the sum of:
+	 *     Size of the SPDM request payload, padded for qword alignment
+	 *     8 bytes for the mailbox command
+	 *     8 bytes for the actual (non-padded) size of the SPDM request
+	 */
+	if (request_sz > (SDSI_SIZE_WRITE_MSG - (2 * sizeof(u64))))
+		return -EOVERFLOW;
+
+	info.size = round_up(request_sz, sizeof(u64)) + 2 * sizeof(u64);
+
+	payload = kzalloc(info.size, GFP_KERNEL);
+	if (!payload)
+		return -ENOMEM;
+
+	memcpy(payload, request, request_sz);
+
+	/* The non-padded SPDM payload size is the 2nd-to-last qword */
+	payload[(info.size / sizeof(u64)) - 2] = request_sz;
+
+	/* Attestation mailbox command is the last qword of payload buffer */
+	payload[(info.size / sizeof(u64)) - 1] = SDSI_CMD_ATTESTATION;
+
+	info.payload = payload;
+	info.buffer = response;
+
+	ret = mutex_lock_interruptible(&priv->mb_lock);
+	if (ret)
+		return ret;
+	ret = sdsi_mbox_write(priv, &info, &size);
+	mutex_unlock(&priv->mb_lock);
+
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The read size is the sum of:
+	 *     Size of the SPDM response payload, padded for qword alignment
+	 *     8 bytes for the actual (non-padded) size of the SPDM payload
+	 */
+
+	if (size < sizeof(u64)) {
+		dev_err(priv->dev,
+			"Attestation error: Mailbox reply size, %ld, too small\n",
+			size);
+		return -EPROTO;
+	}
+
+	if (!IS_ALIGNED(size, sizeof(u64))) {
+		dev_err(priv->dev,
+			"Attestation error: Mailbox reply size, %ld, is not aligned\n",
+			size);
+		return -EPROTO;
+	}
+
+	/*
+	 * Get the SPDM response size from the last QWORD and check it fits
+	 * with no more than 7 bytes of padding
+	 */
+	spdm_msg_size = ((u64 *)info.buffer)[(size - sizeof(u64)) / sizeof(u64)];
+	if (!in_range(size - spdm_msg_size - sizeof(u64), 0, 8)) {
+		dev_err(priv->dev,
+			"Attestation error: Invalid SPDM response size, %ld\n",
+			spdm_msg_size);
+		return -EPROTO;
+	}
+
+	if (spdm_msg_size > response_sz) {
+		dev_err(priv->dev, "Attestation error: Expected response size %ld, got %ld\n",
+			 response_sz, spdm_msg_size);
+		return -EOVERFLOW;
+	}
+
+	memcpy(response, info.buffer, spdm_msg_size);
+
+	return spdm_msg_size;
+}
+
 static int sdsi_get_layout(struct sdsi_priv *priv, struct disc_table *table)
 {
 	switch (table->guid) {
@@ -614,6 +713,7 @@ static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_de
 		return -ENOMEM;
 
 	priv->dev = &auxdev->dev;
+	priv->id = auxdev->id;
 	mutex_init(&priv->mb_lock);
 	auxiliary_set_drvdata(auxdev, priv);
 
@@ -637,9 +737,36 @@ static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_de
 	if (ret)
 		return ret;
 
+	mutex_lock(&sdsi_list_lock);
+	list_add(&priv->node, &sdsi_list);
+	mutex_unlock(&sdsi_list_lock);
+
 	return 0;
 }
 
+static void sdsi_remove(struct auxiliary_device *auxdev)
+{
+	struct sdsi_priv *priv = auxiliary_get_drvdata(auxdev);
+
+	list_del(&priv->node);
+}
+
+struct sdsi_priv *sdsi_dev_get_by_id(int id)
+{
+	struct sdsi_priv *priv, *match = NULL;
+
+	mutex_lock(&sdsi_list_lock);
+	list_for_each_entry(priv, &sdsi_list, node) {
+		if (priv->id == id) {
+			match = priv;
+			break;
+		}
+	}
+	mutex_unlock(&sdsi_list_lock);
+
+	return match;
+}
+
 static const struct auxiliary_device_id sdsi_aux_id_table[] = {
 	{ .name = "intel_vsec.sdsi" },
 	{}
@@ -652,9 +779,42 @@ static struct auxiliary_driver sdsi_aux_driver = {
 	},
 	.id_table	= sdsi_aux_id_table,
 	.probe		= sdsi_probe,
-	/* No remove. All resources are handled under devm */
+	.remove		= sdsi_remove,
 };
-module_auxiliary_driver(sdsi_aux_driver);
+
+static bool netlink_initialized;
+
+static int __init sdsi_init(void)
+{
+	int ret;
+
+	ret = auxiliary_driver_register(&sdsi_aux_driver);
+	if (ret)
+		goto error;
+
+	if (sdsi_netlink_init())
+		pr_warn("Intel SDSi failed to init netlink\n");
+	else
+		netlink_initialized = true;
+
+	return 0;
+
+error:
+	mutex_destroy(&sdsi_list_lock);
+	return ret;
+}
+module_init(sdsi_init);
+
+static void __exit sdsi_exit(void)
+{
+	if (netlink_initialized)
+		sdsi_netlink_exit();
+
+	auxiliary_driver_unregister(&sdsi_aux_driver);
+
+	mutex_destroy(&sdsi_list_lock);
+}
+module_exit(sdsi_exit);
 
 MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
 MODULE_DESCRIPTION("Intel On Demand (SDSi) driver");
diff --git a/drivers/platform/x86/intel/sdsi.h b/drivers/platform/x86/intel/sdsi.h
index d0d7450c7b2b..256618eb3136 100644
--- a/drivers/platform/x86/intel/sdsi.h
+++ b/drivers/platform/x86/intel/sdsi.h
@@ -19,13 +19,27 @@ struct device;
 struct sdsi_priv {
 	struct mutex			mb_lock;	/* Mailbox access lock */
 	struct device			*dev;
+	struct intel_vsec_device	*ivdev;
+	struct list_head		node;
 	void __iomem			*control_addr;
 	void __iomem			*mbox_addr;
 	void __iomem			*regs_addr;
 	int				control_size;
 	int				maibox_size;
 	int				registers_size;
+	int				id;
 	u32				guid;
 	u32				features;
 };
+
+extern struct list_head sdsi_list;
+extern struct mutex sdsi_list_lock;
+
+extern bool sdsi_supports_attestation(struct sdsi_priv *priv);
+extern int
+sdsi_spdm_exchange(void *private, const void *request, size_t request_sz,
+		   void *response, size_t response_sz);
+extern struct sdsi_priv *sdsi_dev_get_by_id(int id);
+extern int sdsi_netlink_init(void);
+extern int sdsi_netlink_exit(void);
 #endif
diff --git a/drivers/platform/x86/intel/sdsi_genl.c b/drivers/platform/x86/intel/sdsi_genl.c
new file mode 100644
index 000000000000..bca1671eba0d
--- /dev/null
+++ b/drivers/platform/x86/intel/sdsi_genl.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Author: David E. Box <david.e.box@linux.intel.com>
+ *
+ * Netlink ABI for Intel On Demand SPDM transport
+ */
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/intel-sdsi.h>
+#include <net/genetlink.h>
+
+#include "sdsi.h"
+
+static struct genl_family sdsi_nl_family;
+
+static const struct nla_policy sdsi_genl_policy[SDSI_GENL_ATTR_MAX + 1] = {
+	[SDSI_GENL_ATTR_DEVS]			= { .type = NLA_NESTED },
+	[SDSI_GENL_ATTR_DEV_ID]			= { .type = NLA_U32 },
+	[SDSI_GENL_ATTR_DEV_NAME]		= { .type = NLA_STRING },
+	[SDSI_GENL_ATTR_SPDM_REQ]		= { .type = NLA_BINARY },
+	[SDSI_GENL_ATTR_SPDM_RSP]		= { .type = NLA_BINARY },
+	[SDSI_GENL_ATTR_SPDM_REQ_SIZE]		= { .type = NLA_U32 },
+	[SDSI_GENL_ATTR_SPDM_RSP_SIZE]		= { .type = NLA_U32 },
+};
+
+struct param {
+	struct nlattr **attrs;
+	struct sk_buff *msg;
+	struct sdsi_priv *priv;
+};
+
+typedef int (*sdsi_genl_cb_t)(struct param *);
+
+static int sdsi_genl_cmd_spdm(struct param *p)
+{
+	struct sk_buff *msg = p->msg;
+	struct sdsi_priv *priv = p->priv;
+	void *response __free(kfree) = NULL;
+	void *request;
+	int rsp_size, req_size;
+	int ret;
+
+	if (!sdsi_supports_attestation(priv))
+		return -EOPNOTSUPP;
+
+	if (!p->attrs[SDSI_GENL_ATTR_SPDM_REQ])
+		return -EINVAL;
+
+	request = nla_data(p->attrs[SDSI_GENL_ATTR_SPDM_REQ]);
+	req_size = nla_len(p->attrs[SDSI_GENL_ATTR_SPDM_REQ]);
+
+	response = kmalloc(SDSI_SIZE_READ_MSG, GFP_KERNEL);
+	if (!response)
+		return -ENOMEM;
+
+	rsp_size = sdsi_spdm_exchange(priv, request, req_size, response,
+				      SDSI_SIZE_READ_MSG);
+	if (rsp_size < 0)
+		return rsp_size;
+
+	ret = nla_put_u32(msg, SDSI_GENL_ATTR_DEV_ID, priv->id);
+	if (ret)
+		return ret;
+
+	return nla_put(msg, SDSI_GENL_ATTR_SPDM_RSP, rsp_size,
+		       response);
+}
+
+static int sdsi_genl_cmd_get_devs(struct param *p)
+{
+	struct sk_buff *msg = p->msg;
+	struct nlattr *nest_start;
+	struct sdsi_priv *priv = p->priv;
+
+	nest_start = nla_nest_start(msg, SDSI_GENL_ATTR_DEVS);
+	if (!nest_start)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(msg, SDSI_GENL_ATTR_DEV_ID, priv->id) ||
+	    nla_put_string(msg, SDSI_GENL_ATTR_DEV_NAME, dev_name(priv->dev)))
+		goto out_cancel_nest;
+
+	nla_nest_end(msg, nest_start);
+
+	return 0;
+
+out_cancel_nest:
+	nla_nest_cancel(msg, nest_start);
+
+	return -EMSGSIZE;
+}
+
+static int sdsi_genl_cmd_get_info(struct param *p)
+{
+	struct sk_buff *msg = p->msg;
+	int ret;
+
+	ret = nla_put_u32(msg, SDSI_GENL_ATTR_SPDM_REQ_SIZE,
+			  SDSI_SIZE_WRITE_MSG - (2 * sizeof(u64)));
+	if (ret)
+		return ret;
+
+	return nla_put_u32(msg, SDSI_GENL_ATTR_SPDM_RSP_SIZE,
+			   SDSI_SIZE_READ_MSG - (sizeof(u64)));
+}
+
+static sdsi_genl_cb_t sdsi_genl_cmd_cb[] = {
+	[SDSI_GENL_CMD_GET_DEVS]		= sdsi_genl_cmd_get_devs,
+	[SDSI_GENL_CMD_GET_INFO]		= sdsi_genl_cmd_get_info,
+	[SDSI_GENL_CMD_GET_SPDM]		= sdsi_genl_cmd_spdm,
+};
+
+static int sdsi_genl_cmd_dumpit(struct sk_buff *skb,
+				struct netlink_callback *cb)
+{
+	struct param p = { .msg = skb };
+	struct sdsi_priv *entry;
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	int cmd = info->op.cmd;
+	int ret = 0, idx = 0;
+	void *hdr;
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &sdsi_nl_family, NLM_F_MULTI, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	mutex_lock(&sdsi_list_lock);
+	list_for_each_entry(entry, &sdsi_list, node) {
+		p.priv = entry;
+		ret = sdsi_genl_cmd_cb[cmd](&p);
+		if (ret)
+			break;
+		idx++;
+	}
+	mutex_unlock(&sdsi_list_lock);
+
+	if (ret)
+		goto out_cancel_msg;
+
+	genlmsg_end(skb, hdr);
+
+	return 0;
+
+out_cancel_msg:
+	genlmsg_cancel(skb, hdr);
+	return ret;
+}
+
+static int sdsi_genl_cmd_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct param p = { .attrs = info->attrs };
+	struct sdsi_priv *priv, *entry;
+	struct sk_buff *msg;
+	void *hdr;
+	int cmd = info->genlhdr->cmd;
+	int ret = 0;
+	int id;
+
+	if (!p.attrs[SDSI_GENL_ATTR_DEV_ID])
+		return -EINVAL;
+
+	id = nla_get_u32(p.attrs[SDSI_GENL_ATTR_DEV_ID]);
+
+	priv = sdsi_dev_get_by_id(id);
+	if (!priv)
+		return -ENODEV;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	p.msg = msg;
+	p.priv = priv;
+
+	hdr = genlmsg_put_reply(msg, info, &sdsi_nl_family, 0, cmd);
+	if (!hdr)
+		goto out_free_msg;
+
+	mutex_lock(&sdsi_list_lock);
+	list_for_each_entry(entry, &sdsi_list, node) {
+		if (entry == priv) {
+			ret = sdsi_genl_cmd_cb[cmd](&p);
+			if (ret)
+				break;
+			break;
+		}
+	}
+	mutex_unlock(&sdsi_list_lock);
+
+	if (ret)
+		goto out_cancel_msg;
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+
+out_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+out_free_msg:
+	nlmsg_free(msg);
+
+	return ret;
+}
+
+static const struct genl_ops sdsi_genl_ops[] = {
+	{
+		.cmd = SDSI_GENL_CMD_GET_DEVS,
+		.doit = sdsi_genl_cmd_doit,
+		.dumpit = sdsi_genl_cmd_dumpit,
+	},
+	{
+		.cmd = SDSI_GENL_CMD_GET_INFO,
+		.doit = sdsi_genl_cmd_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+	{
+		.cmd = SDSI_GENL_CMD_GET_SPDM,
+		.doit = sdsi_genl_cmd_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
+};
+
+static struct genl_family sdsi_nl_family __ro_after_init = {
+	.hdrsize	= 0,
+	.name		= SDSI_FAMILY_NAME,
+	.version	= SDSI_FAMILY_VERSION,
+	.maxattr	= SDSI_GENL_ATTR_MAX,
+	.policy		= sdsi_genl_policy,
+	.ops		= sdsi_genl_ops,
+	.resv_start_op	= SDSI_GENL_CMD_MAX + 1,
+	.n_ops		= ARRAY_SIZE(sdsi_genl_ops),
+};
+
+int __init sdsi_netlink_init(void)
+{
+	return genl_register_family(&sdsi_nl_family);
+}
+
+int sdsi_netlink_exit(void)
+{
+	return genl_unregister_family(&sdsi_nl_family);
+}
diff --git a/include/uapi/linux/intel-sdsi.h b/include/uapi/linux/intel-sdsi.h
new file mode 100644
index 000000000000..db7c49a66fdd
--- /dev/null
+++ b/include/uapi/linux/intel-sdsi.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Intel On Demand SPDM Interface
+ * Copyright (c) 2023, Intel Corporation.
+ * All rights reserved.
+ *
+ * Author: David E. Box <david.e.box@linux.intel.com>
+ */
+
+#ifndef __SDSI_NL_H
+#define __SDSI_NL_H
+
+#define SDSI_FAMILY_NAME	"intel_sdsi"
+#define SDSI_FAMILY_VERSION	1
+
+enum {
+	SDSI_GENL_ATTR_UNSPEC,
+	SDSI_GENL_ATTR_DEVS,		/* nested */
+	SDSI_GENL_ATTR_DEV_ID,		/* u32, device id */
+	SDSI_GENL_ATTR_DEV_NAME,	/* string, device name */
+	SDSI_GENL_ATTR_SPDM_REQ,	/* binary, SDPM request message */
+	SDSI_GENL_ATTR_SPDM_RSP,	/* binary, SDPM response message */
+	SDSI_GENL_ATTR_SPDM_REQ_SIZE,	/* u32, max SDPM request size */
+	SDSI_GENL_ATTR_SPDM_RSP_SIZE,	/* u32, max SPDM response size */
+
+	__SDSI_GENL_ATTR_MAX,
+	SDSI_GENL_ATTR_MAX = (__SDSI_GENL_ATTR_MAX - 1)
+};
+
+enum {
+	SDSI_GENL_CMD_UNSPEC,
+	SDSI_GENL_CMD_GET_DEVS,		/* Get On Demand device list */
+	SDSI_GENL_CMD_GET_INFO,		/* Get On Demand device info */
+	SDSI_GENL_CMD_GET_SPDM,		/* Get SPDM response to SPDM request */
+
+	__SDSI_GENL_CMD_MAX,
+	SDSI_GENL_CMD_MAX = (__SDSI_GENL_CMD_MAX - 1)
+};
+
+#endif /* __SDSI_NL_H */
-- 
2.34.1


