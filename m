Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1847D7C8029
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjJMI01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJMI0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:26:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE7B91
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:26:21 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D7Opc1013924;
        Fri, 13 Oct 2023 08:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=/0aZsgxCF4y1JYPEwaC9JYKgoBe2Trmk++npA7bf5y0=;
 b=yIfGRlLEq+0gXPeFyUKwwaRRMbfR0usE+EYMVqFexk3LjdcmdShe7j1u5d1h+7QFnY1I
 6j80BoCGHKU8PEg/oKn55odItYcfccBjT8W2iaKFXjMXl2Tn0J2n4sJ9IveAhZ3bGEk8
 OYI5ESiOOiBX7p1SMHRud+oTp7ZuzHfEucpalu5o27R7Q2UVkvUcS+12ctBf7pEehzHZ
 nSGaJCbqdhBe0c8PoTKkRYi/nqaBPW76+D324nr2lXWwSNCPtw91ssdtFwULOmhe2Pe4
 cALsLGhS8kz7GAugbpNQoIxd+eVXuygipDhZI/9y4HKtdzkigqVSFCvfQnWO4W78uHLH cQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx8cmk76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 08:26:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39D626bD020257;
        Fri, 13 Oct 2023 08:26:17 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tptcj8d2r-1;
        Fri, 13 Oct 2023 08:26:16 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        sgarzare@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] vdpa_sim: implement .reset_map support
Date:   Fri, 13 Oct 2023 01:23:40 -0700
Message-Id: <1697185420-27213-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130069
X-Proofpoint-ORIG-GUID: y_bZp2PgS0bvm98lMFFCMa3cM5HRiHF2
X-Proofpoint-GUID: y_bZp2PgS0bvm98lMFFCMa3cM5HRiHF2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC only. Not tested on vdpa-sim-blk with user virtual address.
Works fine with vdpa-sim-net which uses physical address to map.

This patch is based on top of [1].

[1] https://lore.kernel.org/virtualization/1696928580-7520-1-git-send-email-si-wei.liu@oracle.com/

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 76d4105..a7455f2 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -151,13 +151,6 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
 				 &vdpasim->iommu_lock);
 	}
 
-	for (i = 0; i < vdpasim->dev_attr.nas; i++) {
-		vhost_iotlb_reset(&vdpasim->iommu[i]);
-		vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX,
-				      0, VHOST_MAP_RW);
-		vdpasim->iommu_pt[i] = true;
-	}
-
 	vdpasim->running = true;
 	spin_unlock(&vdpasim->iommu_lock);
 
@@ -637,6 +630,25 @@ static int vdpasim_set_map(struct vdpa_device *vdpa, unsigned int asid,
 	return ret;
 }
 
+static int vdpasim_reset_map(struct vdpa_device *vdpa, unsigned int asid)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	if (asid >= vdpasim->dev_attr.nas)
+		return -EINVAL;
+
+	spin_lock(&vdpasim->iommu_lock);
+	if (vdpasim->iommu_pt[asid])
+		goto out;
+	vhost_iotlb_reset(&vdpasim->iommu[asid]);
+	vhost_iotlb_add_range(&vdpasim->iommu[asid], 0, ULONG_MAX,
+			      0, VHOST_MAP_RW);
+	vdpasim->iommu_pt[asid] = true;
+out:
+	spin_unlock(&vdpasim->iommu_lock);
+	return 0;
+}
+
 static int vdpasim_bind_mm(struct vdpa_device *vdpa, struct mm_struct *mm)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -759,6 +771,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	.set_group_asid         = vdpasim_set_group_asid,
 	.dma_map                = vdpasim_dma_map,
 	.dma_unmap              = vdpasim_dma_unmap,
+	.reset_map              = vdpasim_reset_map,
 	.bind_mm		= vdpasim_bind_mm,
 	.unbind_mm		= vdpasim_unbind_mm,
 	.free                   = vdpasim_free,
@@ -796,6 +809,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	.get_iova_range         = vdpasim_get_iova_range,
 	.set_group_asid         = vdpasim_set_group_asid,
 	.set_map                = vdpasim_set_map,
+	.reset_map              = vdpasim_reset_map,
 	.bind_mm		= vdpasim_bind_mm,
 	.unbind_mm		= vdpasim_unbind_mm,
 	.free                   = vdpasim_free,
-- 
1.8.3.1

