Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165CD788C62
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbjHYPWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbjHYPWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:22:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2272121
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:22:13 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PEUjCZ001944;
        Fri, 25 Aug 2023 15:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 content-type : message-id : references : in-reply-to : to : cc :
 content-transfer-encoding : mime-version; s=pp1;
 bh=RVHGKh43m6bsvqHBcARmqWobaSe6BzavbepslmYyjzM=;
 b=NnXhNwKxvlHjLlCRFF2V0fpGXi9eWqosjdn8F1LqWDdfuyF2K1PRdI6TUloKyU0F6/Bl
 CB0GlzLixR4nOU+x2u877qD4GgA21CmO4br/1a7EosihB4IG0e0AbXXaFJloAn5z/4r1
 vNWRxkn2YE5v/iWDnc1G4VeYu1AU/Vl29nqYVN1Sa8IRyEJbZG3GRH1frmInddDM09WM
 uH4I8Cy4O/wKrVDAG4sQQz71raTCbVhrM5f79PvmyUDm1U1FHgkd+p5dpYTsT5e8Bolt
 sKcQI1MR1vgX8qIdrPYYfNcb6rHzae7BpyJfSf3ZpRZvbZZ8s15/vjB6DjuDA89LH9Y1 9A== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spwmkjk05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 15:22:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDAJ31010275;
        Fri, 25 Aug 2023 15:21:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sn21t8jwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 15:21:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37PFLwPt20775534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 15:21:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED4FB20040;
        Fri, 25 Aug 2023 15:21:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A22DB2004B;
        Fri, 25 Aug 2023 15:21:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 25 Aug 2023 15:21:57 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Fri, 25 Aug 2023 17:21:25 +0200
Subject: [PATCH 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Content-Type: text/plain; charset="utf-8"
Message-Id: <20230825-viommu-sync-map-v1-1-56bdcfaa29ec@linux.ibm.com>
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
In-Reply-To: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1999;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=MVwlYYIDGwxRAPFmANNVKxk+/T4F66d6kVZCGlprfE8=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFJeHGdbu21rxrFH/EL+ZedmOXw+eT3HdvW81p4vy1SXz
 WebMuu8e0cpC4MYB4OsmCLLoi5nv3UFU0z3BPV3wMxhZQIZwsDFKQATCWxgZFggP//1edPavL9F
 TE2ZXSqfO5b+bz+bGF5Z5cazwXbh09+MDIcjPYV83ebYHjD+/O5u6NzAP8dyX/wN2rlNb6JOXvr
 ldSwA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jeW1GUHfJPRmbrMJaNHM9_rrvtSPZEQi
X-Proofpoint-ORIG-GUID: jeW1GUHfJPRmbrMJaNHM9_rrvtSPZEQi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=433 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull out the sync operation from viommu_map_pages() by implementing
ops->iotlb_sync_map. This allows the common IOMMU code to map multiple
elements of an sg with a single sync (see iommu_map_sg()). Furthermore,
it is also a requirement for IOMMU_CAP_DEFERRED_FLUSH.

Link: https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/virtio-iommu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3551ed057774..fb73dec5b953 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -843,7 +843,7 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			.flags		= cpu_to_le32(flags),
 		};
 
-		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
+		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
 		if (ret) {
 			viommu_del_mappings(vdomain, iova, end);
 			return ret;
@@ -909,9 +909,21 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
 {
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
+	if (!vdomain->nr_endpoints)
+		return;
 	viommu_sync_req(vdomain->viommu);
 }
 
+static int viommu_iotlb_sync_map(struct iommu_domain *domain,
+				 unsigned long iova, size_t size)
+{
+	struct viommu_domain *vdomain = to_viommu_domain(domain);
+
+	if (!vdomain->nr_endpoints)
+		return 0;
+	return viommu_sync_req(vdomain->viommu);
+}
+
 static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 {
 	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
@@ -1058,6 +1070,7 @@ static struct iommu_ops viommu_ops = {
 		.unmap_pages		= viommu_unmap_pages,
 		.iova_to_phys		= viommu_iova_to_phys,
 		.iotlb_sync		= viommu_iotlb_sync,
+		.iotlb_sync_map		= viommu_iotlb_sync_map,
 		.free			= viommu_domain_free,
 	}
 };

-- 
2.39.2

