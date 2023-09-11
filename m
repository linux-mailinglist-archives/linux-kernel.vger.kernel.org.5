Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4E479B7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346579AbjIKVXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbjIKKzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:55:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D81F1;
        Mon, 11 Sep 2023 03:55:27 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B9fmxc007832;
        Mon, 11 Sep 2023 10:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=t03UP7q891F/c5g/2wfXb+TlibZKK7FwWRcbw5U5eKA=;
 b=Ho4hFkEokMgmCBaW03nkJmxZDwRVhB9HufpTQa42iWofQmsFDaxDVr+dBA8RPXgEvp11
 zOBvKg+gwvLaIo2gnqlqWeUVvjm8TeWs9urt+C1MpYjfL+wfDtpLhbPNZV4ZPgvd/zG7
 Gq7B95RsuuGt4PzpOYqNS1urVCN7ufeKXUdN5UfqOEycb+Y7IQ/nsG6DNYjty+oPlKB4
 cy1KxXI9dUSuyK0qw8Pw4R0/Ju5vrs1GA6qXr7+NI3dreTY4TPiVIBxYwXp43YCmaGBi
 5q1N8UotK7P7FY/SwWwHfb3+zMX7ExbGKZq/opTe/PBT6r3ySC+QZ7Eq6RWeGw1lev51 Nw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t1u3yrs88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 10:55:02 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BAt1uO032425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 10:55:01 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 11 Sep 2023 03:54:44 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_mojha@quicinc.com>
Subject: [REBASE PATCH v5 04/17] remoteproc: qcom: Remove minidump related data from qcom_common.c
Date:   Mon, 11 Sep 2023 16:23:46 +0530
Message-ID: <1694429639-21484-5-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tjFQUm_2yuDC0uqVCtc9PxTbx7sDBJRy
X-Proofpoint-ORIG-GUID: tjFQUm_2yuDC0uqVCtc9PxTbx7sDBJRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110099
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As minidump specific data structure and functions move under
config QCOM_RPROC_MINIDUMP, so remove minidump specific data
from driver/remoteproc/qcom_common.c .

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
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

