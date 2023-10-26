Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648B27D7D82
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344513AbjJZHR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbjJZHRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:17:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4C518F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:17:39 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q3KF5A006241;
        Thu, 26 Oct 2023 07:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=skmGb7hKKnErqpG+lHQDSGA29puJ5ukFE+3MADBv/Lo=;
 b=vNtC5voFPD1slBfyI+/5kRPU/OhTQ8kmvRWidYw+5SRnFXfKHlNsDXEFLnKhnzZHFW6W
 9v9ntPZVVl/jb2NW1xutTyH72uJQOiazNLUAvsPJ3ZvoBks2DCFlWBSGCl7EVbojijUH
 tQkbyrUJSKR3O3FVRtvT+FeuRfyl/2h6cg2tR/jkO3ginKNW1IgODCcZdqU/VO65hWck
 OPZgsyzEtZZcXAKWr1+qwbDCPUOvQLXcEG9Q9uLMzEWuBLPEl2Eu95BY8AsUTmKnU0B0
 gFhCs3gJpV5TA4EqVe+eDA4eEY6KfTRZ1HeipPmBzw3c11inP7nNqmk2RWA7xKU+uY5C rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6pd2c31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 07:17:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q6tbAM015200;
        Thu, 26 Oct 2023 07:17:34 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tv537t53r-8;
        Thu, 26 Oct 2023 07:17:33 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        sgarzare@redhat.com, dtatulea@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/7] vdpa_sim: implement .reset_map support
Date:   Thu, 26 Oct 2023 00:14:40 -0700
Message-Id: <1698304480-18463-8-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
References: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260060
X-Proofpoint-GUID: ns7Xgnqd1tnkq0TphvnSZV7OgdBphbST
X-Proofpoint-ORIG-GUID: ns7Xgnqd1tnkq0TphvnSZV7OgdBphbST
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

