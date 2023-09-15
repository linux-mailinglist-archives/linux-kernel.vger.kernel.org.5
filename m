Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADEF7A24C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjIOR3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbjIOR3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:29:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5931BF2;
        Fri, 15 Sep 2023 10:29:07 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnLdz1rJyz67nfn;
        Sat, 16 Sep 2023 01:24:23 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 18:29:05 +0100
From:   <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <dave.hansen@linux.intel.com>, <david@redhat.com>,
        <jiaqiyan@google.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <pgonda@google.com>, <rientjes@google.com>, <duenwen@google.com>,
        <Vilas.Sridharan@amd.com>, <mike.malvestuto@intel.com>,
        <gthelen@google.com>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
        <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 4/9] ACPI:RASF: Add extract RASF table to register RASF platform devices
Date:   Sat, 16 Sep 2023 01:28:13 +0800
Message-ID: <20230915172818.761-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230915172818.761-1-shiju.jose@huawei.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: A Somasundaram <somasundaram.a@hpe.com>

The driver adds extraction of ACPI RASF table as per ACPI 5.1 & upwards
revision. ACPI specification section 5.2.20 for RASF table is the reference
for this implementation. Driver adds a platform device which binds to the
RASF memory driver.

Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/Kconfig     |  9 ++++
 drivers/acpi/Makefile    |  1 +
 drivers/acpi/rasf_acpi.c | 97 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/rasf_acpi.h | 19 ++++++++
 4 files changed, 126 insertions(+)
 create mode 100755 drivers/acpi/rasf_acpi.c
 create mode 100755 include/acpi/rasf_acpi.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index cee82b473dc5..e5fd8edc5b35 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -279,6 +279,15 @@ config ACPI_CPPC_LIB
 	  If your platform does not support CPPC in firmware,
 	  leave this option disabled.
 
+config ACPI_RASF
+	bool "ACPI RASF driver"
+	depends on ACPI_PROCESSOR
+	select MAILBOX
+	help
+	  The driver adds support for extraction of RASF table from OS
+	  system table. Driver adds platform device which binds to the
+	  RASF memory driver.
+
 config ACPI_PROCESSOR
 	tristate "Processor"
 	depends on X86 || IA64 || ARM64 || LOONGARCH
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index eaa09bf52f17..f8a1263f6128 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
+obj-$(CONFIG_ACPI_RASF)		+= rasf_acpi.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
diff --git a/drivers/acpi/rasf_acpi.c b/drivers/acpi/rasf_acpi.c
new file mode 100755
index 000000000000..b30ba2a5e4ff
--- /dev/null
+++ b/drivers/acpi/rasf_acpi.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * rasf_acpi.c - ACPI RASF table processing functions
+ *
+ * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises.
+ *
+ * Copyright (c) 2023 HiSilicon Limited.
+ *
+ * Support for
+ * RASF - ACPI 6.5 Specification, section 5.2.20
+ *
+ * Code contains RASF init, which extracts the ACPI RASF table and
+ * RASF platform communication channel identifier for communicating
+ * with the ACPI compliant platform that contains RASF command
+ * support in the hardware. Driver adds platform device which
+ * binds to the RASF memory driver.
+ */
+
+#define pr_fmt(fmt)	"ACPI RASF: " fmt
+
+#include <linux/export.h>
+#include <linux/delay.h>
+#include <linux/ktime.h>
+#include <linux/platform_device.h>
+#include <acpi/rasf_acpi.h>
+#include <acpi/acpixf.h>
+
+static struct platform_device *rasf_add_platform_device(char *name, const void *data,
+							size_t size)
+{
+	int ret;
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc(name, PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return NULL;
+
+	ret = platform_device_add_data(pdev, data, size);
+	if (ret)
+		goto dev_put;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto dev_put;
+
+	return pdev;
+
+dev_put:
+	platform_device_put(pdev);
+
+	return NULL;
+}
+
+int __init rasf_acpi_init(void)
+{
+	acpi_status status;
+	acpi_size rasf_size;
+	int pcc_subspace_idx;
+	struct platform_device *pdev;
+	struct acpi_table_rasf *pRasfTable;
+	struct acpi_table_header *pAcpiTable = NULL;
+
+	status = acpi_get_table("RASF", 0, &pAcpiTable);
+	if (ACPI_FAILURE(status) || !pAcpiTable) {
+		pr_err("ACPI RASF driver failed to initialize, get table failed\n");
+		return RASF_FAILURE;
+	}
+
+	rasf_size = pAcpiTable->length;
+	if (rasf_size < sizeof(struct acpi_table_rasf)) {
+		pr_err("ACPI RASF table present but broken (too short #1)\n");
+		goto free_rasf_table;
+	}
+
+	pRasfTable = (struct acpi_table_rasf *)pAcpiTable;
+
+	/* Extract the PCC subspace channel id from the table */
+	memcpy(&pcc_subspace_idx, &pRasfTable->channel_id, sizeof(pcc_subspace_idx));
+	pr_debug("ACPI RASF pcc subspace channel id =%d\n",
+		 pcc_subspace_idx);
+	if (pcc_subspace_idx < 0)
+		goto free_rasf_table;
+
+	/* Add the platform device and bind rasf memory driver */
+	pdev = rasf_add_platform_device("rasf", &pcc_subspace_idx,
+					sizeof(pcc_subspace_idx));
+	if (!pdev)
+		goto free_rasf_table;
+
+	acpi_put_table(pAcpiTable);
+	return RASF_SUCCESS;
+
+free_rasf_table:
+	acpi_put_table(pAcpiTable);
+	return RASF_FAILURE;
+}
+late_initcall(rasf_acpi_init)
diff --git a/include/acpi/rasf_acpi.h b/include/acpi/rasf_acpi.h
new file mode 100755
index 000000000000..1c4c3e94d472
--- /dev/null
+++ b/include/acpi/rasf_acpi.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * RASF Diagnostic driver header file
+ *
+ * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises
+ *
+ * Copyright (c) 2023 HiSilicon Limited
+ */
+
+#ifndef _RASF_ACPI_H
+#define _RASF_ACPI_H
+
+#include <linux/acpi.h>
+#include <linux/types.h>
+
+#define RASF_FAILURE 0
+#define RASF_SUCCESS 1
+
+#endif /* _RASF_ACPI_H */
-- 
2.34.1

