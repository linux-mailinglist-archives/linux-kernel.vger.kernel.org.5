Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB4D7CB78B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjJQAmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjJQAmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:42:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FC09B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:42:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKO8bX014418;
        Tue, 17 Oct 2023 00:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=KrpapIJ3BkNAXiuqRX7bRQLsn2/RQH2+BsvlPVXHXNA=;
 b=glPMvXzHavU3wJJTbXGlGb60s2ADRLv3I12Yb/1hQXGoSjh88YfThCFrU0jPLObxTdTb
 ZR9KV2ISQvZkCxJXcIy5NxXGbT2WGQZnX3a4ZlG7/WbLd6CqVJAYE3YsuEmTUq5zpSpN
 jCdDZpiTkM3S4/ry17/uCTR6xBTjkaR/IId/4NYNalFV9W8qAgplwjS7+BehB55vHFM2
 QeZ2l7rJdAcvLMjRUxb+ssuDQcH7lCm39mUYluBVbO6WjoX8MuJlx5qn3XDRGZEdEbxH
 LAP6H8E7v07CtmMNZ+Y/y22q0hWdckxF00RiTqEs9Ogft57DkDMX+3VV4EFIgvt3L8xq Zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1bkxsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 00:42:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GNB27K027141;
        Tue, 17 Oct 2023 00:42:39 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3trg535bja-4;
        Tue, 17 Oct 2023 00:42:39 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        sgarzare@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
Date:   Mon, 16 Oct 2023 17:39:56 -0700
Message-Id: <1697503197-15935-4-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697503197-15935-1-git-send-email-si-wei.liu@oracle.com>
References: <1697503197-15935-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170003
X-Proofpoint-GUID: Evj-k7e-lxAQDDNY1nc-XlkIMSEyxO8b
X-Proofpoint-ORIG-GUID: Evj-k7e-lxAQDDNY1nc-XlkIMSEyxO8b
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
iotlb in the kernel can be trusted to persist IOTLB mapping
across vDPA reset. Without it, userspace has no way to tell apart
if it's running on an older kernel, which could silently drop
all iotlb mapping across vDPA reset, especially with broken
parent driver implementation for the .reset driver op. The broken
driver may incorrectly drop all mappings of its own as part of
.reset, which inadvertently ends up with corrupted mapping state
between vhost-vdpa userspace and the kernel. As a workaround, to
make the mapping behaviour predictable across reset, userspace
has to pro-actively remove all mappings before vDPA reset, and
then restore all the mappings afterwards. This workaround is done
unconditionally on top of all parent drivers today, due to the
parent driver implementation issue and no means to differentiate.
This workaround had been utilized in QEMU since day one when the
corresponding vhost-vdpa userspace backend came to the world.

There are 3 cases that backend may claim this feature bit on for:

- parent device that has to work with platform IOMMU
- parent device with on-chip IOMMU that has the expected
  .reset_map support in driver
- parent device with vendor specific IOMMU implementation with
  persistent IOTLB mapping already that has to specifically
  declare this backend feature

The reason why .reset_map is being one of the pre-condition for
persistent iotlb is because without it, vhost-vdpa can't switch
back iotlb to the initial state later on, especially for the
on-chip IOMMU case which starts with identity mapping at device
creation. virtio-vdpa requires on-chip IOMMU to perform 1:1
passthrough translation from PA to IOVA as-is to begin with, and
.reset_map is the only means to turn back iotlb to the identity
mapping mode after vhost-vdpa is gone.

The difference in behavior did not matter as QEMU unmaps all the
memory unregistering the memory listener at vhost_vdpa_dev_start(
started = false), but the backend acknowledging this feature flag
allows QEMU to make sure it is safe to skip this unmap & map in the
case of vhost stop & start cycle.

In that sense, this feature flag is actually a signal for userspace
to know that the driver bug has been solved. Not offering it
indicates that userspace cannot trust the kernel will retain the
maps.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vhost/vdpa.c             | 15 +++++++++++++++
 include/uapi/linux/vhost_types.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a3f8160c9807..9202986a7d81 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -438,6 +438,15 @@ static u64 vhost_vdpa_get_backend_features(const struct vhost_vdpa *v)
 		return ops->get_backend_features(vdpa);
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
 static long vhost_vdpa_set_features(struct vhost_vdpa *v, u64 __user *featurep)
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
index 18ad6ae7ab5c..d7656908f730 100644
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
2.39.3

