Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7457DDD00
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjKAHM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjKAHM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:12:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07517C2;
        Wed,  1 Nov 2023 00:12:21 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A10v8t5017611;
        Wed, 1 Nov 2023 07:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=u0WiOcWNHfMwWfRqvPP6nsbv0vXbk1NskG9lSHmbs30=;
 b=Gji5+oFhVwtSn+I11P2XtxhlfPc4dq7L0JuDqrsZ/ux628fETuhQVRfdWM25e1LRd8l9
 Cb/cKbVmE3Nn7+CAsoOZRSPeRtEl4tmwGOw+Md3bvfy8hCjAZgZgOyQbEyI41C7unIs6
 K4dx/+/6NYo43iRdM3z66kdW/DwL4WKEIGFRbEpSUeaxrilJYFmgQG5ZEZrnzxYAkUNS
 VBFfzbPrzjkNI60/D0teP+r3jAL8tXtTqwN3aR/b+dBukPQ00rBlqt6DNvyfdnvcPhYY
 nKhr8Qz9oRcLCi8amAgz6+pKnN3U7wkGXBkXkmBBhZccU1daFLhb8gpc5k/CYMfvxYYB Jw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3382jfsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 07:12:05 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A17C4fb014825
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Nov 2023 07:12:04 GMT
Received: from hu-gkohli-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 1 Nov 2023 00:12:01 -0700
From:   Gaurav Kohli <quic_gkohli@quicinc.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>,
        <quic_bjorande@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <boris.brezillon@collabora.com>, <iommu@lists.linux.dev>,
        <steven.price@arm.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Gaurav Kohli" <quic_gkohli@quicinc.com>
Subject: [RFC 1/1] arm-smmu: Add iommu support to share pgtable
Date:   Wed, 1 Nov 2023 12:41:44 +0530
Message-ID: <20231101071144.16309-2-quic_gkohli@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231101071144.16309-1-quic_gkohli@quicinc.com>
References: <20231101071144.16309-1-quic_gkohli@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ADVeq-RnhZAFjOWzLz0vuLgJYABnnj_6
X-Proofpoint-ORIG-GUID: ADVeq-RnhZAFjOWzLz0vuLgJYABnnj_6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_04,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HLOS can create s1 pagetable and request firmware to share the same
pgtable to different entity(vmid).

Use arm-smmu vendor implementation call to define custom
alloc/free pgtable callback, And use these callbacks to share
pgtable to different entity while creating pgtable.

Signed-off-by: Gaurav Kohli <quic_gkohli@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 81 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  8 +++
 2 files changed, 89 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index c71afda79d64..e04079988787 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/dev_printk.h>
 #include <linux/adreno-smmu-priv.h>
 #include <linux/delay.h>
 #include <linux/of_device.h>
@@ -258,11 +259,91 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ }
 };
 
+static void *qcom_alloc_pages(void *cookie, size_t size, gfp_t gfp)
+{
+	struct page *p;
+	struct qcom_scm_vmperm perms[2];
+	u64 src  = BIT(QCOM_SCM_VMID_HLOS);
+	int ret;
+
+	struct arm_smmu_domain *domain = (void *)cookie;
+	/*
+	 * qcom_scm_assign_mem call during atomic allocation can sleep, Using GFP flags
+	 * to detect allocation path and return failure for atomic allocations.
+	 */
+	if (!gfpflags_allow_blocking(gfp)) {
+		dev_err(domain->smmu->dev,
+			"qcom_scm_assign_mem call are not allowed during atomic allocations\n");
+		return NULL;
+	}
+	p = alloc_page(gfp);
+	if (!p)
+		return NULL;
+
+	perms[0].vmid = QCOM_SCM_VMID_HLOS;
+	perms[0].perm = QCOM_SCM_PERM_RW;
+	perms[1].vmid = domain->secure_vmid;
+	perms[1].perm = QCOM_SCM_PERM_READ;
+	ret = qcom_scm_assign_mem(page_to_phys(p), PAGE_SIZE,
+				  &src, perms, 2);
+	if (ret < 0) {
+		dev_err(domain->smmu->dev,
+			"assign memory failed for vmid=%x ret=%d\n",
+			domain->secure_vmid, ret);
+		__free_page(p);
+		return NULL;
+	}
+
+	return page_address(p);
+}
+
+static void qcom_free_pages(void *cookie, void *pages, size_t size)
+{
+	struct qcom_scm_vmperm perms;
+	struct page *p;
+	u64 src;
+	int ret;
+
+	struct arm_smmu_domain *domain = (void *)cookie;
+
+	p = virt_to_page(pages);
+
+	perms.vmid = QCOM_SCM_VMID_HLOS;
+	perms.perm = QCOM_SCM_PERM_RWX;
+	src = BIT(domain->secure_vmid) | BIT(QCOM_SCM_VMID_HLOS);
+	ret = qcom_scm_assign_mem(page_to_phys(p), PAGE_SIZE,
+				  &src, &perms, 1);
+	/*
+	 * For assign failure scenario, it is not safe to use these pages by HLOS.
+	 * So returning from here instead of freeing the page.
+	 */
+	if (ret < 0) {
+		dev_err(domain->smmu->dev,
+			"assign memory failed to HLOS for vmid=%x ret=%d\n",
+			domain->secure_vmid, ret);
+		return;
+	}
+
+	__free_page(p);
+}
+
 static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
 {
+	u32 val;
+
 	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
 
+	/*
+	 * For those client where qcom,iommu-vmid is not defined, default arm-smmu pgtable
+	 * alloc/free handler will be used.
+	 */
+	if (of_property_read_u32(dev->of_node, "qcom,iommu-vmid", &val) == 0) {
+		smmu_domain->secure_vmid = val;
+		pgtbl_cfg->alloc = qcom_alloc_pages;
+		pgtbl_cfg->free = qcom_free_pages;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 703fd5817ec1..98e1c5369e58 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -374,6 +374,14 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
+	/*
+	 * Use to store parse vmid value for those clients which want HLOS
+	 * to share pgtable to different entity(VMID).
+	 * Fix Me: Ideally this should be implemented on arm-smmu vendor implementation
+	 * driver, but as per current design of arm_smmu_domain_alloc there is no way
+	 * to call implementation callbacks.
+	 */
+	u32				secure_vmid;
 };
 
 struct arm_smmu_master_cfg {
-- 
2.17.1

