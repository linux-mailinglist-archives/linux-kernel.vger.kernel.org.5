Return-Path: <linux-kernel+bounces-119155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A3488C4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF531F3B27E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C610132813;
	Tue, 26 Mar 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UJX0sduR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC0E1327E0;
	Tue, 26 Mar 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462421; cv=none; b=sMzFE33hiSqoYJafl2QZagIvIAFwsM0r0P7jS92kVLnwOlQsQRMDHuHilJewKyTDklCwDoJVOE3yjWXz34OY3B6J5H44ZhKUS2ymi9x22tfXhFfbEXOQhm1bm1fUXHJGaH0wu7l8MgFldswu4HtzxOyEv/oIDYBCay+qCn/Kd3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462421; c=relaxed/simple;
	bh=Re1PH2hCu1e07IWF+1MrHP4Y/fqaSYonRixS5qqGasI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llaxJYBMwXrVJIfML1+oqvUK35t9Sfn51LxEK2VNrNa8tq83Gi8R4JsemmfMysoXcO342vr3eosYGyBFS0TufQ12XD2M3r7t+ZIWNiBbMdPOz9oyiD78uilLXeWQhneoefvy3kc4q+ODLiSChe/IxqBC95Vcm9NLQ/f3pfHzdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UJX0sduR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QDEBtp013826;
	Tue, 26 Mar 2024 14:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=83+4yrRZKKSRLAx7hjbP
	3gzxe9Itr1K1moV9W4DXC3A=; b=UJX0sduRpA29fP2y4HK3VkCVfRYq6p98TU8A
	WWEB9G+Sc69LV6K4Y51UXw1eezTeMxSIw2sMNR+CAlikulaMRTGyUJvDHxGUokb8
	9cI+40LnsY55mCLsRCI2MAkwkc/p1piI+761mYkNVKspsdbAC8bOLA8xF4wt7NFz
	5iaqL0G42sNgcAwEtRviO5U8WGaTJsG5IQomT74k6CcObLJUdBVcP0Oxs4N3CDdI
	QiL4Nhd2pygmtmUtpB77Hy6QtW/vHvk1T5YmrtT5hcGYwd8hbhpZQtpVc5Gr+2yj
	AxHPOk/uusi5KB4oKIPFGD8nywe8reLCoqt8h9Fa3O3Llql1zQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3q0n1phh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 14:13:35 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QEDYPm027930
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 14:13:34 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 07:13:32 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mathieu.poirier@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v9 3/3] remoteproc: qcom: Remove minidump related data from qcom_common.c
Date: Tue, 26 Mar 2024 19:43:14 +0530
Message-ID: <1711462394-21540-3-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711462394-21540-1-git-send-email-quic_mojha@quicinc.com>
References: <1711462394-21540-1-git-send-email-quic_mojha@quicinc.com>
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
X-Proofpoint-GUID: SmugVgATPULnEJy2gWCt7LJX01_ezQRk
X-Proofpoint-ORIG-GUID: SmugVgATPULnEJy2gWCt7LJX01_ezQRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403260099

As minidump specific data structure and functions move under
config QCOM_RPROC_MINIDUMP, so remove minidump specific data
from driver/remoteproc/qcom_common.c .

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v9:
 - Change in patch order.
 - rebased it.

v8: https://lore.kernel.org/lkml/20240131105734.13090-1-quic_mojha@quicinc.com/
v7: https://lore.kernel.org/lkml/20240109153200.12848-1-quic_mojha@quicinc.com/
v6: https://lore.kernel.org/lkml/1700864395-1479-1-git-send-email-quic_mojha@quicinc.com/
v5: https://lore.kernel.org/lkml/1694429639-21484-1-git-send-email-quic_mojha@quicinc.com/
v4: https://lore.kernel.org/lkml/1687955688-20809-1-git-send-email-quic_mojha@quicinc.com/

 drivers/remoteproc/qcom_common.c | 160 ---------------------------------------
 1 file changed, 160 deletions(-)

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
-- 
2.7.4


