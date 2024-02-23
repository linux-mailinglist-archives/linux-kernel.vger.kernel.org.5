Return-Path: <linux-kernel+bounces-78500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237A4861434
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03E7282433
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0B683CC3;
	Fri, 23 Feb 2024 14:37:53 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB0D82871;
	Fri, 23 Feb 2024 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699072; cv=none; b=OEX5OHqRNueLtMvOifRYStVaAxEiaT+lro3MzRFnazHkUNJj+bNpYYG69L1AZE/H4ztAs/0DnfNEQx3x6wWfQTP63qHHVdML9IVOpMtF93yzCblis8AptD814ITxbhAI82rBrkpLV7dDwmTu/9utYa7S3AVVMeIgnox1yUVq8l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699072; c=relaxed/simple;
	bh=raPgUodaldD9KuFpvmwyvYiVBzI0yurRJQDZ5oEOQ7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vp4w78HU2ebm/aVoVqUpABPskFDNk9MeM2VaXyb30FvQOdGKSEwbPosM+MLQJa3bG3r/MJiNaRD1NB+nRhOO79eMmIM/2gfqU7TOhFtGmQYYKNk/R6DiwFU06YnIdvU+VNJiwinqlkZXqGYy4IgEWLiWqC9A3dk+O5O09DQLE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThCDg2Jg0z6K5ts;
	Fri, 23 Feb 2024 22:33:39 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id A19ED140D26;
	Fri, 23 Feb 2024 22:37:48 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:37:47 +0000
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v7 11/12] ACPI:RAS2: Add driver for ACPI RAS2 feature table (RAS2)
Date: Fri, 23 Feb 2024 22:37:22 +0800
Message-ID: <20240223143723.1574-12-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240223143723.1574-1-shiju.jose@huawei.com>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

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
index b12fba9cff06..e3fd6feb3e54 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -105,7 +105,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
-obj-$(CONFIG_ACPI_RAS2)		+= ras2_acpi_common.o
+obj-$(CONFIG_ACPI_RAS2)		+= ras2_acpi_common.o ras2_acpi.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
diff --git a/drivers/acpi/ras2_acpi.c b/drivers/acpi/ras2_acpi.c
new file mode 100755
index 000000000000..cd2e8f5ad253
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
+#include <acpi/ras2_acpi.h>
+#include <acpi/acpixf.h>
+
+#define RAS2_FEATURE_TYPE_MEMORY        0x00
+
+static int __init ras2_acpi_init(void)
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
+		return RAS2_FAILURE;
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
+			pdev = ras2_add_platform_device("ras2", &pcc_subspace_idx,
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
+	return RAS2_SUCCESS;
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
+	return RAS2_FAILURE;
+}
+late_initcall(ras2_acpi_init)
-- 
2.34.1


