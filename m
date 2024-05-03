Return-Path: <linux-kernel+bounces-167372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0FC8BA890
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDFA7B2304F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1392148FE9;
	Fri,  3 May 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VPDl76kF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00D14882E;
	Fri,  3 May 2024 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724308; cv=none; b=q7VacqiXl5Wfv/o24bHQeiaPlyvl7QZ4WK5iH01J/0cUFQULWyXc5E0xiSDgzzK3V9LKOc3RN6KnHQ/vyHODpH7Sh4Kdgp+qj6WIVkc+6Si6TM2AgPQLln4LOGKsSexTsG6LONZ3oJtijuimfbwoRFAA2/HeAxxdCmMViwiLCC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724308; c=relaxed/simple;
	bh=SiIcFuRazaEs0jvJDpEmCANpU8UJM+zhB0RisWWFIeo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ercGGVpR0JYyqytA1nns4Fhf8XgNglZNJbaXzSWEneOOuFWP/j4PbB8LLu+bBqIxn75LpDMsJXgRge2D7G6xdq8AC6EuWG8evTrG1U7b2c9IzyNRJ9SNLK0yx/LbmlHkVQnFbJbcYPzoxItFlJquLl+UBAvaFNeaq04tl8kC8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VPDl76kF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4437TKdT002962;
	Fri, 3 May 2024 08:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=jIEYjPbHLqtdgTOM5q/0/KC9z4FSIgaaRckuPHZAohg=; b=VP
	Dl76kFSusXZmTKWKSfsesDaK4ksw0+IuXrVFhchO5HhLKwbloubhe3N7L/hl0sWw
	E2dawlaB81piBGLU65orHhmJ1hRL2LeysIfrKrR1oXNaZ2ePdbp5ohRLPZ74dTPM
	PiRA5nHNw+P0HpFxEM7X5/NFAeQVZUuX7pt2neBUTKa1/x5xZYPcW46F49vvj5lX
	ZKiN2X2tuGY/nySBG1kfF1SiLBoEXdyC5gyZbLMKxkYlz/2qbbDBBKZU79UY4ZQ4
	E9EY9Tc9eLubuQ6LYQESJDAHvV4JXMh4K5ncN73NR7YjmzljH8VZwNRPDekejaYf
	QLTcffR5n01QHsiIpRHA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvmxyrpj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 08:18:19 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4438II5l006690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 08:18:18 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 3 May 2024 01:18:15 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v10] remoteproc: qcom: Move minidump related layout and API to soc/qcom directory
Date: Fri, 3 May 2024 13:48:07 +0530
Message-ID: <1714724287-12518-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lKFzRi7PufLAbSk4uW-l8Yu0KcZhPbbj
X-Proofpoint-ORIG-GUID: lKFzRi7PufLAbSk4uW-l8Yu0KcZhPbbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_04,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030058

Currently, Qualcomm Minidump is being used to collect mini version of
remoteproc coredump with the help of boot firmware however, Minidump
as a feature is not limited to be used only for remote processor and
can also be used for Application processors. So, in preparation of
using it move the Minidump related data structure and its function
to its own file under drivers/soc/qcom with qcom_rproc_minidump.c
which clearly says it is only for remoteproc minidump.

Extra changes made apart from the movement is,
1. Adds new config, kernel headers and module macros to get this
   module compiled.
2. Guards the qcom_minidump() with CONFIG_QCOM_RPROC_MINIDUMP.
3. Selects this QCOM_RPROC_MINIDUMP config when QCOM_RPROC_COMMON
   enabled.
4. Added new header qcom_minidump.h .

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v10:
 - Converted all 3 changes sent in v9 to a single to properly
   reflect the movement in git history as per suggestion made by [Bjorn.A]

 - Described the reason of the change in commit text.

Changes in v9: https://lore.kernel.org/lkml/1711462394-21540-1-git-send-email-quic_mojha@quicinc.com/
 - Added source file driver/remoteproc/qcom_common.c copyright
   to qcom_rproc_minidump.c
 - Dissociated it from minidump series as this can go separately
   and minidump can put it dependency for the data structure files.

Nothing much changed in these three patches from previous version,
However, giving the link of their older versions.

v8: https://lore.kernel.org/lkml/20240131105734.13090-1-quic_mojha@quicinc.com/
v7: https://lore.kernel.org/lkml/20240109153200.12848-1-quic_mojha@quicinc.com/
v6: https://lore.kernel.org/lkml/1700864395-1479-1-git-send-email-quic_mojha@quicinc.com/
v5: https://lore.kernel.org/lkml/1694429639-21484-1-git-send-email-quic_mojha@quicinc.com/
v4: https://lore.kernel.org/lkml/1687955688-20809-1-git-send-email-quic_mojha@quicinc.com/

 drivers/remoteproc/Kconfig             |   1 +
 drivers/remoteproc/qcom_common.c       | 160 -----------------------------
 drivers/remoteproc/qcom_common.h       |   5 -
 drivers/remoteproc/qcom_q6v5_pas.c     |   1 +
 drivers/soc/qcom/Kconfig               |  11 ++
 drivers/soc/qcom/Makefile              |   1 +
 drivers/soc/qcom/qcom_rproc_minidump.c | 177 +++++++++++++++++++++++++++++++++
 include/soc/qcom/qcom_minidump.h       |  23 +++++
 8 files changed, 214 insertions(+), 165 deletions(-)
 create mode 100644 drivers/soc/qcom/qcom_rproc_minidump.c
 create mode 100644 include/soc/qcom/qcom_minidump.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 48845dc8fa85..cea960749e2c 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -166,6 +166,7 @@ config QCOM_PIL_INFO
 
 config QCOM_RPROC_COMMON
 	tristate
+	select QCOM_RPROC_MINIDUMP
 
 config QCOM_Q6V5_COMMON
 	tristate
diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 03e5f5d533eb..085fd73fa23a 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -17,7 +17,6 @@
 #include <linux/rpmsg/qcom_smd.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
-#include <linux/soc/qcom/smem.h>
 
 #include "remoteproc_internal.h"
 #include "qcom_common.h"
@@ -26,61 +25,6 @@
 #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
 #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
 
-#define MAX_NUM_OF_SS           10
-#define MAX_REGION_NAME_LENGTH  16
-#define SBL_MINIDUMP_SMEM_ID	602
-#define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
-#define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
-#define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
-
-/**
- * struct minidump_region - Minidump region
- * @name		: Name of the region to be dumped
- * @seq_num:		: Use to differentiate regions with same name.
- * @valid		: This entry to be dumped (if set to 1)
- * @address		: Physical address of region to be dumped
- * @size		: Size of the region
- */
-struct minidump_region {
-	char	name[MAX_REGION_NAME_LENGTH];
-	__le32	seq_num;
-	__le32	valid;
-	__le64	address;
-	__le64	size;
-};
-
-/**
- * struct minidump_subsystem - Subsystem's SMEM Table of content
- * @status : Subsystem toc init status
- * @enabled : if set to 1, this region would be copied during coredump
- * @encryption_status: Encryption status for this subsystem
- * @encryption_required : Decides to encrypt the subsystem regions or not
- * @region_count : Number of regions added in this subsystem toc
- * @regions_baseptr : regions base pointer of the subsystem
- */
-struct minidump_subsystem {
-	__le32	status;
-	__le32	enabled;
-	__le32	encryption_status;
-	__le32	encryption_required;
-	__le32	region_count;
-	__le64	regions_baseptr;
-};
-
-/**
- * struct minidump_global_toc - Global Table of Content
- * @status : Global Minidump init status
- * @md_revision : Minidump revision
- * @enabled : Minidump enable status
- * @subsystems : Array of subsystems toc
- */
-struct minidump_global_toc {
-	__le32				status;
-	__le32				md_revision;
-	__le32				enabled;
-	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
-};
-
 struct qcom_ssr_subsystem {
 	const char *name;
 	struct srcu_notifier_head notifier_list;
@@ -90,110 +34,6 @@ struct qcom_ssr_subsystem {
 static LIST_HEAD(qcom_ssr_subsystem_list);
 static DEFINE_MUTEX(qcom_ssr_subsys_lock);
 
-static void qcom_minidump_cleanup(struct rproc *rproc)
-{
-	struct rproc_dump_segment *entry, *tmp;
-
-	list_for_each_entry_safe(entry, tmp, &rproc->dump_segments, node) {
-		list_del(&entry->node);
-		kfree(entry->priv);
-		kfree(entry);
-	}
-}
-
-static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem,
-			void (*rproc_dumpfn_t)(struct rproc *rproc, struct rproc_dump_segment *segment,
-				void *dest, size_t offset, size_t size))
-{
-	struct minidump_region __iomem *ptr;
-	struct minidump_region region;
-	int seg_cnt, i;
-	dma_addr_t da;
-	size_t size;
-	char *name;
-
-	if (WARN_ON(!list_empty(&rproc->dump_segments))) {
-		dev_err(&rproc->dev, "dump segment list already populated\n");
-		return -EUCLEAN;
-	}
-
-	seg_cnt = le32_to_cpu(subsystem->region_count);
-	ptr = ioremap((unsigned long)le64_to_cpu(subsystem->regions_baseptr),
-		      seg_cnt * sizeof(struct minidump_region));
-	if (!ptr)
-		return -EFAULT;
-
-	for (i = 0; i < seg_cnt; i++) {
-		memcpy_fromio(&region, ptr + i, sizeof(region));
-		if (le32_to_cpu(region.valid) == MINIDUMP_REGION_VALID) {
-			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
-			if (!name) {
-				iounmap(ptr);
-				return -ENOMEM;
-			}
-			da = le64_to_cpu(region.address);
-			size = le64_to_cpu(region.size);
-			rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t, name);
-		}
-	}
-
-	iounmap(ptr);
-	return 0;
-}
-
-void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
-		void (*rproc_dumpfn_t)(struct rproc *rproc,
-		struct rproc_dump_segment *segment, void *dest, size_t offset,
-		size_t size))
-{
-	int ret;
-	struct minidump_subsystem *subsystem;
-	struct minidump_global_toc *toc;
-
-	/* Get Global minidump ToC*/
-	toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, NULL);
-
-	/* check if global table pointer exists and init is set */
-	if (IS_ERR(toc) || !toc->status) {
-		dev_err(&rproc->dev, "Minidump TOC not found in SMEM\n");
-		return;
-	}
-
-	/* Get subsystem table of contents using the minidump id */
-	subsystem = &toc->subsystems[minidump_id];
-
-	/**
-	 * Collect minidump if SS ToC is valid and segment table
-	 * is initialized in memory and encryption status is set.
-	 */
-	if (subsystem->regions_baseptr == 0 ||
-	    le32_to_cpu(subsystem->status) != 1 ||
-	    le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED) {
-		return rproc_coredump(rproc);
-	}
-
-	if (le32_to_cpu(subsystem->encryption_status) != MINIDUMP_SS_ENCR_DONE) {
-		dev_err(&rproc->dev, "Minidump not ready, skipping\n");
-		return;
-	}
-
-	/**
-	 * Clear out the dump segments populated by parse_fw before
-	 * re-populating them with minidump segments.
-	 */
-	rproc_coredump_cleanup(rproc);
-
-	ret = qcom_add_minidump_segments(rproc, subsystem, rproc_dumpfn_t);
-	if (ret) {
-		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
-		goto clean_minidump;
-	}
-	rproc_coredump_using_sections(rproc);
-clean_minidump:
-	qcom_minidump_cleanup(rproc);
-}
-EXPORT_SYMBOL_GPL(qcom_minidump);
-
 static int glink_subdev_start(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
index 9ef4449052a9..af3038ae954b 100644
--- a/drivers/remoteproc/qcom_common.h
+++ b/drivers/remoteproc/qcom_common.h
@@ -34,11 +34,6 @@ struct qcom_rproc_ssr {
 	struct qcom_ssr_subsystem *info;
 };
 
-void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
-			void (*rproc_dumpfn_t)(struct rproc *rproc,
-				struct rproc_dump_segment *segment, void *dest, size_t offset,
-				size_t size));
-
 void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink,
 			   const char *ssr_name);
 void qcom_remove_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink);
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 54d8005d40a3..20664426150f 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -25,6 +25,7 @@
 #include <linux/soc/qcom/mdt_loader.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
+#include <soc/qcom/qcom_minidump.h>
 
 #include "qcom_common.h"
 #include "qcom_pil_info.h"
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 5af33b0e3470..7732b9e79ed2 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -277,4 +277,15 @@ config QCOM_PBS
 	  This module provides the APIs to the client drivers that wants to send the
 	  PBS trigger event to the PBS RAM.
 
+config QCOM_RPROC_MINIDUMP
+	tristate "QCOM Remoteproc Minidump Support"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on QCOM_SMEM
+	help
+	  Enablement of core Minidump feature is controlled from boot firmware
+	  side, so if it is enabled from firmware, this config allow Linux to
+	  query predefined Minidump segments associated with the remote processor
+	  and check its validity and end up collecting the dump on remote processor
+	  crash during its recovery.
+
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index ca0bece0dfff..a298552872cd 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
 qcom_ice-objs			+= ice.o
 obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
 obj-$(CONFIG_QCOM_PBS) +=	qcom-pbs.o
+obj-$(CONFIG_QCOM_RPROC_MINIDUMP) += qcom_rproc_minidump.o
diff --git a/drivers/soc/qcom/qcom_rproc_minidump.c b/drivers/soc/qcom/qcom_rproc_minidump.c
new file mode 100644
index 000000000000..29951e99f091
--- /dev/null
+++ b/drivers/soc/qcom/qcom_rproc_minidump.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Remoteproc Minidump helper module
+ *
+ * Copyright (C) 2016 Linaro Ltd
+ * Copyright (C) 2015 Sony Mobile Communications Inc
+ * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/remoteproc.h>
+#include <linux/soc/qcom/smem.h>
+#include <soc/qcom/qcom_minidump.h>
+
+#define MAX_NUM_OF_SS           10
+#define MAX_REGION_NAME_LENGTH  16
+#define SBL_MINIDUMP_SMEM_ID	602
+#define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
+#define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
+#define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
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
+void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
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
+	    le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED) {
+		return rproc_coredump(rproc);
+	}
+
+	if (le32_to_cpu(subsystem->encryption_status) != MINIDUMP_SS_ENCR_DONE) {
+		dev_err(&rproc->dev, "Minidump not ready, skipping\n");
+		return;
+	}
+
+	/**
+	 * Clear out the dump segments populated by parse_fw before
+	 * re-populating them with minidump segments.
+	 */
+	rproc_coredump_cleanup(rproc);
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
+EXPORT_SYMBOL_GPL(qcom_minidump);
+
+MODULE_DESCRIPTION("Qualcomm Remoteproc Minidump helper module");
+MODULE_LICENSE("GPL");
diff --git a/include/soc/qcom/qcom_minidump.h b/include/soc/qcom/qcom_minidump.h
new file mode 100644
index 000000000000..0fe156066bc0
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
+void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
+		   void (*rproc_dumpfn_t)(struct rproc *rproc,
+		   struct rproc_dump_segment *segment, void *dest, size_t offset,
+		   size_t size));
+#else
+static inline void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
+		   void (*rproc_dumpfn_t)(struct rproc *rproc,
+		   struct rproc_dump_segment *segment, void *dest, size_t offset,
+		   size_t size)) { }
+#endif /* CONFIG_QCOM_RPROC_MINIDUMP */
+#endif /* _QCOM_MINIDUMP_H_ */
-- 
2.7.4


