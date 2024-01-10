Return-Path: <linux-kernel+bounces-22767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1F482A29F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A091F23E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF4557318;
	Wed, 10 Jan 2024 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z4I/SpWy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D8524D0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AHu6Er013238;
	Wed, 10 Jan 2024 20:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=UhQmkXl9GVu7w+z1TCplSHMQcWUnpv9XttZYc9CaLWI=;
 b=Z4I/SpWyGdRErY15n9ByLfWec96Ujkt4wHnw7OGouauwqVVHz9v5a0lCcNadOlUEwkPy
 VmE1a7/3INCEp0XRVfi0mkK7zbU9mlnAS192WkBv/rmo3IcLK9UrXzPCCSqso0+iAHTl
 BN800/wBesdL58Gj4O+WnEJ9f9EDSyiVxIUd6twX1VLHmN7XZFnCKd0FDkWDUkLgzcnT
 gUb8Kd6ZrMsHfVAk4W6Ig7qtcejv1x5M8F3Az7TOVOXDrMe4oEHgZ0jVj60bndwqAkEu
 iBkrBhq31myp2UPqP5GfFQOPPDHLN5cDua9iPNWwdHvD/Qy+I5HZx/++JYrkadO6u6dr aA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhs1x1b3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AK51Ds030094;
	Wed, 10 Jan 2024 20:40:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutp5xdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:27 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AKeGrp005067;
	Wed, 10 Jan 2024 20:40:26 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vfutp5x5e-14;
	Wed, 10 Jan 2024 20:40:26 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 13/13] vduse: new owner capability
Date: Wed, 10 Jan 2024 12:40:15 -0800
Message-Id: <1704919215-91319-14-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_10,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100163
X-Proofpoint-ORIG-GUID: qAWOh5yp6HJp_t3u4k72qvHhZf-98H8a
X-Proofpoint-GUID: qAWOh5yp6HJp_t3u4k72qvHhZf-98H8a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The vduse device supports ownership transfer to a new process, so
advertise VHOST_BACKEND_F_NEW_OWNER.  User virtual addresses are used
by the software iommu, so VHOST_IOTLB_REMAP is required after
VHOST_NEW_OWNER, so advertise VHOST_BACKEND_F_IOTLB_REMAP.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 6b25457a037d..67815f6391db 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -25,6 +25,7 @@
 #include <linux/sched/mm.h>
 #include <uapi/linux/vduse.h>
 #include <uapi/linux/vdpa.h>
+#include <uapi/linux/vhost_types.h>
 #include <uapi/linux/virtio_config.h>
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_blk.h>
@@ -608,6 +609,12 @@ static u32 vduse_vdpa_get_vq_align(struct vdpa_device *vdpa)
 	return dev->vq_align;
 }
 
+static u64 vduse_vdpa_get_backend_features(const struct vdpa_device *vdpa)
+{
+	return BIT_ULL(VHOST_BACKEND_F_IOTLB_REMAP) |
+	       BIT_ULL(VHOST_BACKEND_F_NEW_OWNER);
+}
+
 static u64 vduse_vdpa_get_device_features(struct vdpa_device *vdpa)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
@@ -801,6 +808,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_vq_state		= vduse_vdpa_set_vq_state,
 	.get_vq_state		= vduse_vdpa_get_vq_state,
 	.get_vq_align		= vduse_vdpa_get_vq_align,
+	.get_backend_features	= vduse_vdpa_get_backend_features,
 	.get_device_features	= vduse_vdpa_get_device_features,
 	.set_driver_features	= vduse_vdpa_set_driver_features,
 	.get_driver_features	= vduse_vdpa_get_driver_features,
-- 
2.39.3


