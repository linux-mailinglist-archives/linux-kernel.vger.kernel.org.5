Return-Path: <linux-kernel+bounces-21069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2CC828950
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62E93B25067
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B353A8CA;
	Tue,  9 Jan 2024 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G46hrEjW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94BA3A1B6;
	Tue,  9 Jan 2024 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409D8mNP017701;
	Tue, 9 Jan 2024 15:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=2v3QDfazX4eyBKkaMk652ercOJKOzQ4uh2xawUw2qLY=; b=G4
	6hrEjWQajaK0ZMaP8LN1a9IaG1Mn7lep6gx3K++oTZdzBDmVmJOmmi95OUZGFwV9
	0kWwNmr+ch+UdEFGE4AmhpadKvxjb7x1AsYzfq8MMO2GDjIGb2HbUMkfU/Tyn+vX
	H9q2c1FjS+t903gnVQQFba7qkVxQQxWzxwM+lWxoeA6utwTimeBvLN4jOiKeUPbW
	upljh6bd7URdM+mgRbxxlSlQRXFZJ58wPyKRMG04yfojAcNEtFo39fUI2bhgyvYP
	EEfMjIqKMcJUgqSFWmXqT+UQRRafl1piCQG/e3wcF9yj25ayMCxtNv4N5/ntSVQ5
	2ttceXxkMK5bmQ8LamYg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgwsjsc8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 15:48:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409FmoQt013151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 15:48:50 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 07:48:45 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <corbet@lwn.net>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <matthias.bgg@gmail.com>, <kgene@kernel.org>,
        <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>
Subject: [PATCH v7 02/12] soc: qcom: Add qcom_rproc_minidump module
Date: Tue, 9 Jan 2024 21:01:50 +0530
Message-ID: <20240109153200.12848-3-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240109153200.12848-1-quic_mojha@quicinc.com>
References: <20240109153200.12848-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sKEQQD_yPO6hYDkuPQpUze0jLpABbV6G
X-Proofpoint-ORIG-GUID: sKEQQD_yPO6hYDkuPQpUze0jLpABbV6G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090128

Add qcom_rproc_minidump module in a preparation to remove
minidump specific code from driver/remoteproc/qcom_common.c
and provide needed exported API, this as well helps to
abstract minidump specific data layout from qualcomm's
remoteproc driver.

It is just a copying of qcom_minidump() functionality from
driver/remoteproc/qcom_common.c into a separate file under
qcom_rproc_minidump().

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/Kconfig                  |  10 ++
 drivers/soc/qcom/Makefile                 |   1 +
 drivers/soc/qcom/qcom_minidump_internal.h |  64 +++++++++++++
 drivers/soc/qcom/qcom_rproc_minidump.c    | 111 ++++++++++++++++++++++
 include/soc/qcom/qcom_minidump.h          |  23 +++++
 5 files changed, 209 insertions(+)
 create mode 100644 drivers/soc/qcom/qcom_minidump_internal.h
 create mode 100644 drivers/soc/qcom/qcom_rproc_minidump.c
 create mode 100644 include/soc/qcom/qcom_minidump.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index c6ca4de42586..1f81746131fc 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -268,4 +268,14 @@ config QCOM_INLINE_CRYPTO_ENGINE
 	tristate
 	select QCOM_SCM
 
+config QCOM_RPROC_MINIDUMP
+	tristate "QCOM Remoteproc Minidump Support"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on QCOM_SMEM
+	help
+	  Enablement of core minidump feature is controlled from boot firmware
+	  side, so if it is enabled from firmware, this config allow linux to
+	  query predefined minidump segments associated with the remote processor
+	  and check its validity and end up collecting the dump on remote processor
+	  crash during its recovery.
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 05b3d54e8dc9..aabb361d4b2e 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
 qcom_ice-objs			+= ice.o
 obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
+obj-$(CONFIG_QCOM_RPROC_MINIDUMP)	+= qcom_rproc_minidump.o
diff --git a/drivers/soc/qcom/qcom_minidump_internal.h b/drivers/soc/qcom/qcom_minidump_internal.h
new file mode 100644
index 000000000000..71709235b196
--- /dev/null
+++ b/drivers/soc/qcom/qcom_minidump_internal.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _QCOM_MINIDUMP_INTERNAL_H_
+#define _QCOM_MINIDUMP_INTERNAL_H_
+
+#define MAX_NUM_OF_SS           10
+#define MAX_REGION_NAME_LENGTH  16
+#define SBL_MINIDUMP_SMEM_ID	602
+#define MINIDUMP_REGION_VALID	   ('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
+#define MINIDUMP_SS_ENCR_DONE	   ('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
+#define MINIDUMP_SS_ENABLED	   ('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
+
+/**
+ * struct minidump_region - Minidump region
+ * @name		: Name of the region to be dumped
+ * @seq_num:		: Use to differentiate regions with same name.
+ * @valid		: This entry to be dumped (if set to 1)
+ * @address		: Physical address of region to be dumped
+ * @size		: Size of the region
+ */
+struct minidump_region {
+	char	name[MAX_REGION_NAME_LENGTH];
+	__le32	seq_num;
+	__le32	valid;
+	__le64	address;
+	__le64	size;
+};
+
+/**
+ * struct minidump_subsystem - Subsystem's SMEM Table of content
+ * @status : Subsystem toc init status
+ * @enabled : if set to 1, this region would be copied during coredump
+ * @encryption_status: Encryption status for this subsystem
+ * @encryption_required : Decides to encrypt the subsystem regions or not
+ * @region_count : Number of regions added in this subsystem toc
+ * @regions_baseptr : regions base pointer of the subsystem
+ */
+struct minidump_subsystem {
+	__le32	status;
+	__le32	enabled;
+	__le32	encryption_status;
+	__le32	encryption_required;
+	__le32	region_count;
+	__le64	regions_baseptr;
+};
+
+/**
+ * struct minidump_global_toc - Global Table of Content
+ * @status : Global Minidump init status
+ * @md_revision : Minidump revision
+ * @enabled : Minidump enable status
+ * @subsystems : Array of subsystems toc
+ */
+struct minidump_global_toc {
+	__le32				status;
+	__le32				md_revision;
+	__le32				enabled;
+	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
+};
+
+#endif /* _QCOM_MINIDUMP_INTERNAL_H_ */
diff --git a/drivers/soc/qcom/qcom_rproc_minidump.c b/drivers/soc/qcom/qcom_rproc_minidump.c
new file mode 100644
index 000000000000..9bc84cc2536f
--- /dev/null
+++ b/drivers/soc/qcom/qcom_rproc_minidump.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/remoteproc.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/string.h>
+#include <soc/qcom/qcom_minidump.h>
+
+#include "qcom_minidump_internal.h"
+
+static void qcom_minidump_cleanup(struct rproc *rproc)
+{
+	struct rproc_dump_segment *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &rproc->dump_segments, node) {
+		list_del(&entry->node);
+		kfree(entry->priv);
+		kfree(entry);
+	}
+}
+
+static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem,
+			void (*rproc_dumpfn_t)(struct rproc *rproc, struct rproc_dump_segment *segment,
+				void *dest, size_t offset, size_t size))
+{
+	struct minidump_region __iomem *ptr;
+	struct minidump_region region;
+	int seg_cnt, i;
+	dma_addr_t da;
+	size_t size;
+	char *name;
+
+	if (WARN_ON(!list_empty(&rproc->dump_segments))) {
+		dev_err(&rproc->dev, "dump segment list already populated\n");
+		return -EUCLEAN;
+	}
+
+	seg_cnt = le32_to_cpu(subsystem->region_count);
+	ptr = ioremap((unsigned long)le64_to_cpu(subsystem->regions_baseptr),
+		      seg_cnt * sizeof(struct minidump_region));
+	if (!ptr)
+		return -EFAULT;
+
+	for (i = 0; i < seg_cnt; i++) {
+		memcpy_fromio(&region, ptr + i, sizeof(region));
+		if (le32_to_cpu(region.valid) == MINIDUMP_REGION_VALID) {
+			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
+			if (!name) {
+				iounmap(ptr);
+				return -ENOMEM;
+			}
+			da = le64_to_cpu(region.address);
+			size = le64_to_cpu(region.size);
+			rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t, name);
+		}
+	}
+
+	iounmap(ptr);
+	return 0;
+}
+
+void qcom_rproc_minidump(struct rproc *rproc, unsigned int minidump_id,
+		void (*rproc_dumpfn_t)(struct rproc *rproc,
+		struct rproc_dump_segment *segment, void *dest, size_t offset,
+		size_t size))
+{
+	int ret;
+	struct minidump_subsystem *subsystem;
+	struct minidump_global_toc *toc;
+
+	/* Get Global minidump ToC*/
+	toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, NULL);
+
+	/* check if global table pointer exists and init is set */
+	if (IS_ERR(toc) || !toc->status) {
+		dev_err(&rproc->dev, "Minidump TOC not found in SMEM\n");
+		return;
+	}
+
+	/* Get subsystem table of contents using the minidump id */
+	subsystem = &toc->subsystems[minidump_id];
+
+	/**
+	 * Collect minidump if SS ToC is valid and segment table
+	 * is initialized in memory and encryption status is set.
+	 */
+	if (subsystem->regions_baseptr == 0 ||
+	    le32_to_cpu(subsystem->status) != 1 ||
+	    le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED ||
+	    le32_to_cpu(subsystem->encryption_status) != MINIDUMP_SS_ENCR_DONE) {
+		dev_err(&rproc->dev, "Minidump not ready, skipping\n");
+		return;
+	}
+
+	ret = qcom_add_minidump_segments(rproc, subsystem, rproc_dumpfn_t);
+	if (ret) {
+		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
+		goto clean_minidump;
+	}
+	rproc_coredump_using_sections(rproc);
+clean_minidump:
+	qcom_minidump_cleanup(rproc);
+}
+EXPORT_SYMBOL_GPL(qcom_rproc_minidump);
+
+MODULE_DESCRIPTION("Qualcomm remoteproc minidump(smem) helper module");
+MODULE_LICENSE("GPL");
diff --git a/include/soc/qcom/qcom_minidump.h b/include/soc/qcom/qcom_minidump.h
new file mode 100644
index 000000000000..cd87caef919d
--- /dev/null
+++ b/include/soc/qcom/qcom_minidump.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _QCOM_MINIDUMP_H_
+#define _QCOM_MINIDUMP_H_
+
+struct rproc;
+struct rproc_dump_segment;
+
+#if IS_ENABLED(CONFIG_QCOM_RPROC_MINIDUMP)
+void qcom_rproc_minidump(struct rproc *rproc, unsigned int minidump_id,
+		   void (*rproc_dumpfn_t)(struct rproc *rproc,
+		   struct rproc_dump_segment *segment, void *dest, size_t offset,
+		   size_t size));
+#else
+static inline void qcom_rproc_minidump(struct rproc *rproc, unsigned int minidump_id,
+		   void (*rproc_dumpfn_t)(struct rproc *rproc,
+		   struct rproc_dump_segment *segment, void *dest, size_t offset,
+		   size_t size)) { }
+#endif /* CONFIG_QCOM_RPROC_MINIDUMP */
+#endif /* _QCOM_MINIDUMP_H_ */
-- 
2.43.0.254.ga26002b62827


