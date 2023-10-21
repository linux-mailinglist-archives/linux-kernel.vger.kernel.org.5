Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D310B7D1C1D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjJUJ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjJUJ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:28:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A881ABE
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:28:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39L5umZ4013323;
        Sat, 21 Oct 2023 09:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=skmGb7hKKnErqpG+lHQDSGA29puJ5ukFE+3MADBv/Lo=;
 b=yEiJv3tgorshhSyDaT+icDCwsvVj+/hoMPuNi0wg0rX7/OuxEn/AAnXZEEtarMyBNi3J
 68FSi/AzFEwmkJ4FCtmRLZ0qPBZwyke/Go5rYHlCIJkSh85r77S4xtpT8wKTQF0X5Hr5
 8miShdQl5yQkOWwhRkHV784ps7LWOKBiVU3AJsLlK9hPQ3Du6yf/5uyrcrYAYDh/JbcZ
 sfZ/PF4cb+PNzKlGPxs539b2Qc+xIl9dN1HjxNeEHx8sO8Yd5ZMv98SG3ZIa5mqv+4Mk
 6j7mBOybq01NmwSO3SPx6bg3SHs9uIVr1Gu1KSv/pgAbvlrUKVQhrnG0QfsTMu4Eec6m Kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv76u0cee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Oct 2023 09:28:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39L6FU6J019120;
        Sat, 21 Oct 2023 09:28:22 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv532gf44-8;
        Sat, 21 Oct 2023 09:28:22 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        sgarzare@redhat.com, dtatulea@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] vdpa_sim: implement .reset_map support
Date:   Sat, 21 Oct 2023 02:25:19 -0700
Message-Id: <1697880319-4937-8-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310210086
X-Proofpoint-GUID: NhuQWq1f6ymX69vLWFl4nFEn1poWRKDt
X-Proofpoint-ORIG-GUID: NhuQWq1f6ymX69vLWFl4nFEn1poWRKDt
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce excessive memory mapping cost in live migration and
VM reboot, it is desirable to decouple the vhost-vdpa IOTLB abstraction
from the virtio device life cycle, i.e. mappings can be kept intact
across virtio device reset. Leverage the .reset_map callback, which is
meant to destroy the iotlb on the given ASID and recreate the 1:1
passthrough/identity mapping. To be consistent, the mapping on device
creation is initiailized to passthrough/identity with PA 1:1 mapped as
IOVA. With this the device .reset op doesn't have to maintain and clean
up memory mappings by itself.

Additionally, implement .compat_reset to cater for older userspace,
which may wish to see mapping to be cleared during reset.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 52 ++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 76d41058add9..be2925d0d283 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -139,7 +139,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
 	vq->vring.notify = NULL;
 }
 
-static void vdpasim_do_reset(struct vdpasim *vdpasim)
+static void vdpasim_do_reset(struct vdpasim *vdpasim, u32 flags)
 {
 	int i;
 
@@ -151,11 +151,13 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
 				 &vdpasim->iommu_lock);
 	}
 
-	for (i = 0; i < vdpasim->dev_attr.nas; i++) {
-		vhost_iotlb_reset(&vdpasim->iommu[i]);
-		vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX,
-				      0, VHOST_MAP_RW);
-		vdpasim->iommu_pt[i] = true;
+	if (flags & VDPA_RESET_F_CLEAN_MAP) {
+		for (i = 0; i < vdpasim->dev_attr.nas; i++) {
+			vhost_iotlb_reset(&vdpasim->iommu[i]);
+			vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX,
+					      0, VHOST_MAP_RW);
+			vdpasim->iommu_pt[i] = true;
+		}
 	}
 
 	vdpasim->running = true;
@@ -259,8 +261,12 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	if (!vdpasim->iommu_pt)
 		goto err_iommu;
 
-	for (i = 0; i < vdpasim->dev_attr.nas; i++)
+	for (i = 0; i < vdpasim->dev_attr.nas; i++) {
 		vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
+		vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX, 0,
+				      VHOST_MAP_RW);
+		vdpasim->iommu_pt[i] = true;
+	}
 
 	for (i = 0; i < dev_attr->nvqs; i++)
 		vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
@@ -480,18 +486,23 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
 	mutex_unlock(&vdpasim->mutex);
 }
 
-static int vdpasim_reset(struct vdpa_device *vdpa)
+static int vdpasim_compat_reset(struct vdpa_device *vdpa, u32 flags)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
 	mutex_lock(&vdpasim->mutex);
 	vdpasim->status = 0;
-	vdpasim_do_reset(vdpasim);
+	vdpasim_do_reset(vdpasim, flags);
 	mutex_unlock(&vdpasim->mutex);
 
 	return 0;
 }
 
+static int vdpasim_reset(struct vdpa_device *vdpa)
+{
+	return vdpasim_compat_reset(vdpa, 0);
+}
+
 static int vdpasim_suspend(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -637,6 +648,25 @@ static int vdpasim_set_map(struct vdpa_device *vdpa, unsigned int asid,
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
@@ -749,6 +779,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.get_status             = vdpasim_get_status,
 	.set_status             = vdpasim_set_status,
 	.reset			= vdpasim_reset,
+	.compat_reset		= vdpasim_compat_reset,
 	.suspend		= vdpasim_suspend,
 	.resume			= vdpasim_resume,
 	.get_config_size        = vdpasim_get_config_size,
@@ -759,6 +790,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_group_asid         = vdpasim_set_group_asid,
 	.dma_map                = vdpasim_dma_map,
 	.dma_unmap              = vdpasim_dma_unmap,
+	.reset_map              = vdpasim_reset_map,
 	.bind_mm		= vdpasim_bind_mm,
 	.unbind_mm		= vdpasim_unbind_mm,
 	.free                   = vdpasim_free,
@@ -787,6 +819,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.get_status             = vdpasim_get_status,
 	.set_status             = vdpasim_set_status,
 	.reset			= vdpasim_reset,
+	.compat_reset		= vdpasim_compat_reset,
 	.suspend		= vdpasim_suspend,
 	.resume			= vdpasim_resume,
 	.get_config_size        = vdpasim_get_config_size,
@@ -796,6 +829,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.get_iova_range         = vdpasim_get_iova_range,
 	.set_group_asid         = vdpasim_set_group_asid,
 	.set_map                = vdpasim_set_map,
+	.reset_map              = vdpasim_reset_map,
 	.bind_mm		= vdpasim_bind_mm,
 	.unbind_mm		= vdpasim_unbind_mm,
 	.free                   = vdpasim_free,
-- 
2.39.3

