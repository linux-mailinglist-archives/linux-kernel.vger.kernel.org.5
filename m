Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCB97A48C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241633AbjIRLwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241749AbjIRLwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:52:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B13E6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:52:27 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IBbfLK008464;
        Mon, 18 Sep 2023 11:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 content-type : message-id : references : in-reply-to : to : cc :
 content-transfer-encoding : mime-version; s=pp1;
 bh=S7l4oCz3CN9sIQ+C3C1TlbBopkTjD4JFHrUqpeIImB4=;
 b=lJhUXSTs7GRWSbWARv91oH7qiq2PxArNkhxZAvgJA18DQ/jEgpPRyeOYuXayZ7l0PMLq
 MpamHoPfnk5Fp/U0WdEa0cdHvfeS6eYukATvvXh7qlQalC9PLymGKaw0DRQyn1R/6qgX
 ACHwJkOOwnLjUJn582gGeamSnUrF/iHENOUUGbsSOY8ElxGZYFyKEafjdR2QQHq+E99a
 jHzu12yZ6FheiahqHz1fPHkw18zpQw7CFr3/LGlTNc9mAq/k8lfVKNS/NF73I7vDXQQ2
 zK5mjMHxy2FywPwaed9zInaqQEZYRclS/haJY0/E/Yag7spqoEg++Kh1Pppw6KLgZ7SY Xg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6nks8htw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 11:52:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38I9UGNM005625;
        Mon, 18 Sep 2023 11:52:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5q2yajud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 11:52:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38IBq4A913173290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 11:52:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A381520040;
        Mon, 18 Sep 2023 11:52:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7671720043;
        Mon, 18 Sep 2023 11:52:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 18 Sep 2023 11:52:04 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Mon, 18 Sep 2023 13:51:44 +0200
Subject: [PATCH v2 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Content-Type: text/plain; charset="utf-8"
Message-Id: <20230918-viommu-sync-map-v2-2-f33767f6cf7a@linux.ibm.com>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
In-Reply-To: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=upC1g4Fnu/iYtsn6wk97A7klYWVGcSCe9jbIua7krSA=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFI5LO9N22yyT5l1n+BSiQbdi2JFVxW83qxm1BNoyeXZ8
 dDuzKeIjlIWBjEOBlkxRZZFXc5+6wqmmO4J6u+AmcPKBDKEgYtTACai3c7wP/Ki8bV/C28aNB+5
 V2F/+rfCh7fGPoEWnLK7EuZFmFxMdWFkOH7bUn/W4WATr4u9XRZyM054aYmXFR+7ekw6YYNX7M8
 jHAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NQSOylXlbSs1IxTybC6OPNSLWoeCBIxG
X-Proofpoint-ORIG-GUID: NQSOylXlbSs1IxTybC6OPNSLWoeCBIxG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=833 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ops->flush_iotlb_all operation to enable virtio-iommu for the
dma-iommu deferred flush scheme. This results in a significant increase
in performance in exchange for a window in which devices can still
access previously IOMMU mapped memory when running with
CONFIG_IOMMU_DEFAULT_DMA_LAZY. The previous strict behavior can be
achieved with iommu.strict=1 on the kernel command line or
CONFIG_IOMMU_DEFAULT_DMA_STRICT.

Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/virtio-iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3649586f0e5c..4dd330fbcbdd 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -926,6 +926,13 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
 	return viommu_sync_req(vdomain->viommu);
 }
 
+static void viommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct viommu_domain *vdomain = to_viommu_domain(domain);
+
+	viommu_sync_req(vdomain->viommu);
+}
+
 static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 {
 	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
@@ -1051,6 +1058,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
 		return true;
+	case IOMMU_CAP_DEFERRED_FLUSH:
+		return true;
 	default:
 		return false;
 	}
@@ -1071,6 +1080,7 @@ static struct iommu_ops viommu_ops = {
 		.map_pages		= viommu_map_pages,
 		.unmap_pages		= viommu_unmap_pages,
 		.iova_to_phys		= viommu_iova_to_phys,
+		.flush_iotlb_all	= viommu_flush_iotlb_all,
 		.iotlb_sync		= viommu_iotlb_sync,
 		.iotlb_sync_map		= viommu_iotlb_sync_map,
 		.free			= viommu_domain_free,

-- 
2.39.2

