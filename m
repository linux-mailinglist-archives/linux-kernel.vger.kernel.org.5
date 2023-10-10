Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7887BF6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjJJJFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJJJFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:05:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FBDCA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:05:43 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39A804bs017830;
        Tue, 10 Oct 2023 09:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=OMuWF+ib0rZpZceqxHvEWuT+8aI6hH6IoBKKRKDUxqQ=;
 b=cbcrn05DehNm2FC9NaVjr7SBJLN7aIKRHY/OVM+w8R6Xj9siw6c+h5UFe5234+bR8lf6
 zrskHKjNc5xMqoz7gsyzsxrdDTOrvkvqsNRkg5X8i7cJElPAdhSW84R7SmBT6STDbt1U
 sf02MXbqjLj3yss2lnMvEPlbRAkjV2r7ILw9a9vcFu6Ihvyhl+H61h3UMJXBFoJFQu+1
 dQGcgIwTMhUoks4iNCVk9h1N4wxvJlrccaCrWnoEw3QRxXX1pcM3XYqirxLS2B5g9gqn
 g50FUf1ptXULdekmcjooqqm8jRPIBssvXsyG5IepZ8km/qLuNV/2CKewl2JiMetLSpgc WQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx8cck9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 09:05:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39A6sxrF021395;
        Tue, 10 Oct 2023 09:05:35 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tjwsc5cy2-4;
        Tue, 10 Oct 2023 09:05:35 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
Date:   Tue, 10 Oct 2023 02:02:59 -0700
Message-Id: <1696928580-7520-4-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_04,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100067
X-Proofpoint-ORIG-GUID: tiCYM9t-hsTeWDq1eosaeRopCiPEuEdj
X-Proofpoint-GUID: tiCYM9t-hsTeWDq1eosaeRopCiPEuEdj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace needs this feature flag to distinguish if vhost-vdpa
iotlb in the kernel supports persistent IOTLB mapping across
device reset. Without it, userspace has no way to tell apart
if it's running on an older kernel, which could silently drop
all iotlb mapping across vDPA reset.

There are 3 cases that backend may claim this feature bit on:

- parent device that has to work with platform IOMMU
- parent device with on-chip IOMMU that has the expected
  .reset_map support in driver
- parent device with vendor specific IOMMU implementation
  that explicitly declares the specific backend feature

The reason why .reset_map is being one of the pre-condition for
persistent iotlb is because without it, vhost-vdpa can't switch
back iotlb to the initial state later on, especially for the
on-chip IOMMU case which starts with identity mapping at device
creation. virtio-vdpa requires on-chip IOMMU to perform 1:1
passthrough translation from PA to IOVA as-is to begin with, and
.reset_map is the only means to turn back iotlb to the identity
mapping mode after vhost-vdpa is gone.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vhost/vdpa.c             | 15 +++++++++++++++
 include/uapi/linux/vhost_types.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a3f8160..c92794f 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -413,6 +413,15 @@ static bool vhost_vdpa_has_desc_group(const struct vhost_vdpa *v)
 	return ops->get_vq_desc_group;
 }
 
+static bool vhost_vdpa_has_persistent_map(const struct vhost_vdpa *v)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	return (!ops->set_map && !ops->dma_map) || ops->reset_map ||
+	       vhost_vdpa_get_backend_features(v) & BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST);
+}
+
 static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
 {
 	struct vdpa_device *vdpa = v->vdpa;
@@ -725,6 +734,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 			return -EFAULT;
 		if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
 				 BIT_ULL(VHOST_BACKEND_F_DESC_ASID) |
+				 BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST) |
 				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
 				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
 				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
@@ -741,6 +751,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		if ((features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID)) &&
 		     !vhost_vdpa_has_desc_group(v))
 			return -EOPNOTSUPP;
+		if ((features & BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)) &&
+		     !vhost_vdpa_has_persistent_map(v))
+			return -EOPNOTSUPP;
 		vhost_set_backend_features(&v->vdev, features);
 		return 0;
 	}
@@ -796,6 +809,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 			features |= BIT_ULL(VHOST_BACKEND_F_RESUME);
 		if (vhost_vdpa_has_desc_group(v))
 			features |= BIT_ULL(VHOST_BACKEND_F_DESC_ASID);
+		if (vhost_vdpa_has_persistent_map(v))
+			features |= BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST);
 		features |= vhost_vdpa_get_backend_features(v);
 		if (copy_to_user(featurep, &features, sizeof(features)))
 			r = -EFAULT;
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 18ad6ae..d765690 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -190,5 +190,7 @@ struct vhost_vdpa_iova_range {
  * buffers may reside. Requires VHOST_BACKEND_F_IOTLB_ASID.
  */
 #define VHOST_BACKEND_F_DESC_ASID    0x7
+/* IOTLB don't flush memory mapping across device reset */
+#define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
 
 #endif
-- 
1.8.3.1

