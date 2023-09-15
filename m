Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199237A24CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbjIORaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjIOR3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:29:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41DF1FF5;
        Fri, 15 Sep 2023 10:29:10 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnLjM58zJz6HJ4Y;
        Sat, 16 Sep 2023 01:27:19 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 18:29:08 +0100
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
Subject: [RFC PATCH 8/9] ACPI:RAS2: Add driver for ACPI RAS2 feature table (RAS2)
Date:   Sat, 16 Sep 2023 01:28:17 +0800
Message-ID: <20230915172818.761-9-shiju.jose@huawei.com>
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

From: Shiju Jose <shiju.jose@huawei.com>

Add support for ACPI RAS2 feature table (RAS2) defined in the ACPI 6.5
Specification, section 5.2.21.
This driver contains RAS2 Init, which extracts the RAS2 table.
Driver adds platform device, for each memory feature, which binds
to the RAS2 memory driver.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/Makefile    |  2 +-
 drivers/acpi/ras2_acpi.c | 97 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100755 drivers/acpi/ras2_acpi.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index dd62d936cbe1..4fbe7ea0be27 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -104,7 +104,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
-obj-$(CONFIG_ACPI_RASF)		+= rasf_acpi_common.o rasf_acpi.o
+obj-$(CONFIG_ACPI_RASF)		+= rasf_acpi_common.o rasf_acpi.o ras2_acpi.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
diff --git a/drivers/acpi/ras2_acpi.c b/drivers/acpi/ras2_acpi.c
new file mode 100755
index 000000000000..b8a7740355a8
--- /dev/null
+++ b/drivers/acpi/ras2_acpi.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ras2_acpi.c - Implementation of ACPI RAS2 feature table processing
+ * functions.
+ *
+ * Copyright (c) 2023 HiSilicon Limited.
+ *
+ * Support for
+ * RAS2 - ACPI 6.5 Specification, section 5.2.21
+ *
+ * Driver contains RAS2 init, which extracts the RAS2 table and
+ * registers the PCC channel for communicating with the ACPI compliant
+ * platform that contains RAS2 command support in hardware.Driver adds
+ * platform device which binds to the RAS2 memory driver.
+ */
+
+#define pr_fmt(fmt)	"ACPI RAS2: " fmt
+
+#include <linux/export.h>
+#include <linux/delay.h>
+#include <linux/ktime.h>
+#include <linux/platform_device.h>
+#include <acpi/rasf_acpi.h>
+#include <acpi/acpixf.h>
+
+#define RAS2_FEATURE_TYPE_MEMORY        0x00
+
+int __init ras2_acpi_init(void)
+{
+	u8 count;
+	acpi_status status;
+	acpi_size ras2_size;
+	int pcc_subspace_idx;
+	struct platform_device *pdev;
+	struct acpi_table_ras2 *pRas2Table;
+	struct acpi_ras2_pcc_desc *pcc_desc_list;
+	struct platform_device **pdev_list = NULL;
+	struct acpi_table_header *pAcpiTable = NULL;
+
+	status = acpi_get_table("RAS2", 0, &pAcpiTable);
+	if (ACPI_FAILURE(status) || !pAcpiTable) {
+		pr_err("ACPI RAS2 driver failed to initialize, get table failed\n");
+		return RASF_FAILURE;
+	}
+
+	ras2_size = pAcpiTable->length;
+	if (ras2_size < sizeof(struct acpi_table_ras2)) {
+		pr_err("ACPI RAS2 table present but broken (too short #1)\n");
+		goto free_ras2_table;
+	}
+
+	pRas2Table = (struct acpi_table_ras2 *)pAcpiTable;
+
+	if (pRas2Table->num_pcc_descs <= 0) {
+		pr_err("ACPI RAS2 table does not contain PCC descriptors\n");
+		goto free_ras2_table;
+	}
+
+	pdev_list = kzalloc((pRas2Table->num_pcc_descs * sizeof(struct platform_device *)),
+			     GFP_KERNEL);
+	if (!pdev_list)
+		goto free_ras2_table;
+
+	pcc_desc_list = (struct acpi_ras2_pcc_desc *)
+				((void *)pRas2Table + sizeof(struct acpi_table_ras2));
+	count = 0;
+	while (count < pRas2Table->num_pcc_descs) {
+		if (pcc_desc_list->feature_type == RAS2_FEATURE_TYPE_MEMORY) {
+			pcc_subspace_idx = pcc_desc_list->channel_id;
+			/* Add the platform device and bind ras2 memory driver */
+			pdev = rasf_add_platform_device("ras2", &pcc_subspace_idx,
+							sizeof(pcc_subspace_idx));
+			if (!pdev)
+				goto free_ras2_pdev;
+			pdev_list[count] = pdev;
+		}
+		count++;
+		pcc_desc_list = pcc_desc_list + sizeof(struct acpi_ras2_pcc_desc);
+	}
+
+	acpi_put_table(pAcpiTable);
+	return RASF_SUCCESS;
+
+free_ras2_pdev:
+	count = 0;
+	while (count < pRas2Table->num_pcc_descs) {
+		if (pcc_desc_list->feature_type ==
+				RAS2_FEATURE_TYPE_MEMORY)
+			platform_device_put(pdev_list[count++]);
+	}
+	kfree(pdev_list);
+
+free_ras2_table:
+	acpi_put_table(pAcpiTable);
+	return RASF_FAILURE;
+}
+late_initcall(ras2_acpi_init)
-- 
2.34.1

