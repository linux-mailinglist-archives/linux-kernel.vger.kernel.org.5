Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C334788C64
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbjHYPWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbjHYPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:22:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9862121
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:22:15 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PFA67r015306;
        Fri, 25 Aug 2023 15:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 content-type : message-id : references : in-reply-to : to : cc :
 content-transfer-encoding : mime-version; s=pp1;
 bh=efLCKGZCR9lDIN/VAOS7Dh5waTAZ2HrUFv8uYRKeG/4=;
 b=TWpAs0DfVaV9GREtarDfBv88uDik+yvX4WUFRYsCMhhxQ9YWBfRFayjZPGDmMNEhx1nO
 aJDyjwItu6L4ClA7Gv45NQ6QI0096xEDhpu1SM0GVus7KiKvJXJ2jwnFhaojcA/JqhjP
 mDZCZX8JyE8u6yeMzE7huAfhxpxp5fZT9Qk0dTkJIb4XZ9jWf9S0Yvo9oHTdvAWkoEcB
 ObO8tWXqmifCPVtEy8i8urIMf0wpLSKys/RyBXi6pwwiK9MNrFwISdIt1mc7CVD9EoIb
 Nau14M9Dhn0aBwYfvBlqboHFY7BYXKDZ7VowUhaRZ+uOzOH+n0VhLmBRY3I5mV2VFa/o hA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spvrmc1qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 15:22:01 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37PFLLQE027323;
        Fri, 25 Aug 2023 15:22:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn20t0kww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 15:22:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37PFLwG020775536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 15:21:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5207420040;
        Fri, 25 Aug 2023 15:21:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06F1720043;
        Fri, 25 Aug 2023 15:21:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 25 Aug 2023 15:21:57 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Fri, 25 Aug 2023 17:21:26 +0200
Subject: [PATCH 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Content-Type: text/plain; charset="utf-8"
Message-Id: <20230825-viommu-sync-map-v1-2-56bdcfaa29ec@linux.ibm.com>
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
In-Reply-To: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=o3fVLj72u2OA+MsG2VQnhGTOnVRyrNfk57kmMnyTq2U=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFJeHOf9zr09kfN83R6vuDVzeBeWbd0+6/7snc0VyxW+L
 mibkLfmfkcpC4MYB4OsmCLLoi5nv3UFU0z3BPV3wMxhZQIZwsDFKQATEbnH8L+uTtjo7Dz5vUrs
 611nvSipim4Idsmx0VS4VabM9Gr99FxGht/ZsXzO7s+PKFVv0LKNu3ZIZnrGBab1B3sVdunvf6f
 cwAUA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SfmiqD5vSiZ6UpayPOG_pJPY3hqn3Vy9
X-Proofpoint-ORIG-GUID: SfmiqD5vSiZ6UpayPOG_pJPY3hqn3Vy9
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 mlxlogscore=870 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250134
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
dma-iommu deferred flush scheme. This results inn a significant increase
in performance in exchange for a window in which devices can still
access previously IOMMU mapped memory. To get back to the prior behavior
iommu.strict=1 may be set on the kernel command line.

Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/virtio-iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index fb73dec5b953..1b7526494490 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -924,6 +924,15 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
 	return viommu_sync_req(vdomain->viommu);
 }
 
+static void viommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct viommu_domain *vdomain = to_viommu_domain(domain);
+
+	if (!vdomain->nr_endpoints)
+		return;
+	viommu_sync_req(vdomain->viommu);
+}
+
 static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 {
 	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
@@ -1049,6 +1058,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
 		return true;
+	case IOMMU_CAP_DEFERRED_FLUSH:
+		return true;
 	default:
 		return false;
 	}
@@ -1069,6 +1080,7 @@ static struct iommu_ops viommu_ops = {
 		.map_pages		= viommu_map_pages,
 		.unmap_pages		= viommu_unmap_pages,
 		.iova_to_phys		= viommu_iova_to_phys,
+		.flush_iotlb_all	= viommu_flush_iotlb_all,
 		.iotlb_sync		= viommu_iotlb_sync,
 		.iotlb_sync_map		= viommu_iotlb_sync_map,
 		.free			= viommu_domain_free,

-- 
2.39.2

