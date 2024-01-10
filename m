Return-Path: <linux-kernel+bounces-22758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE35682A292
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F0EFB21E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C904F8A0;
	Wed, 10 Jan 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sf5ruoHq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97594F209
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AIEHMj031366;
	Wed, 10 Jan 2024 20:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=p6iyspjvKTXuB4yF6u/9MqWV7tzJix+S8H6uFyg3zco=;
 b=Sf5ruoHqoaMYwd+pyQ8JlItRsJpxnnSA2o3p5B6VlB+6TyiXyyhmzHiKzLDZ0o48L/AP
 a2X8Qq2DBq8rZimMIZSttTNn0+ApZB2yBRyssQfVpKhelQYGFA/p9vtGHpzL8TyhZiTc
 7iWv8xtX9c1kumKCRCh4kV1nwhUOzSOyRZYczAX/+FxHd3SoRi69VktCrFf6HJqTIk8Y
 fagmNpgOGB5T1wEUJnjvjkaMgIkTMRr/Z7W5DGdZb57NA5kQiu5mkNLatcB9563Xb/hV
 Ato41YqNtT3bgHMGZVLVrDbpe+29smUMEyTlAKgLTYucFd+v/gJKvQKRu68mtZmFyREx XA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhx8q0mpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AJCi37030209;
	Wed, 10 Jan 2024 20:40:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutp5x84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:19 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AKeGrV005067;
	Wed, 10 Jan 2024 20:40:19 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vfutp5x5e-4;
	Wed, 10 Jan 2024 20:40:19 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 03/13] vhost-vdpa: VHOST_NEW_OWNER
Date: Wed, 10 Jan 2024 12:40:05 -0800
Message-Id: <1704919215-91319-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: 6HP6DkR9nx9-HSrTDL3w2q_xJtSn1aEZ
X-Proofpoint-ORIG-GUID: 6HP6DkR9nx9-HSrTDL3w2q_xJtSn1aEZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add an ioctl to transfer file descriptor ownership and pinned memory
accounting from one process to another.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c       | 37 +++++++++++++++++++++++++++++++++++++
 drivers/vhost/vhost.c      | 15 +++++++++++++++
 drivers/vhost/vhost.h      |  1 +
 include/uapi/linux/vhost.h | 10 ++++++++++
 4 files changed, 63 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 2269988d6d33..eb3a95e703b0 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -613,6 +613,40 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
 	return ops->resume(vdpa);
 }
 
+static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
+{
+	int r;
+	struct vhost_dev *vdev = &v->vdev;
+	struct mm_struct *mm_old = vdev->mm;
+	struct mm_struct *mm_new = current->mm;
+	long pinned_vm = v->pinned_vm;
+	unsigned long lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
+
+	if (!mm_old)
+		return -EINVAL;
+
+	if (!v->vdpa->use_va &&
+	    pinned_vm + atomic64_read(&mm_new->pinned_vm) > lock_limit)
+		return -ENOMEM;
+
+	r = vhost_vdpa_bind_mm(v, mm_new);
+	if (r)
+		return r;
+
+	r = vhost_dev_new_owner(vdev);
+	if (r) {
+		vhost_vdpa_bind_mm(v, mm_old);
+		return r;
+	}
+
+	if (!v->vdpa->use_va) {
+		atomic64_sub(pinned_vm, &mm_old->pinned_vm);
+		atomic64_add(pinned_vm, &mm_new->pinned_vm);
+	}
+
+	return r;
+}
+
 static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				   void __user *argp)
 {
@@ -843,6 +877,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_VDPA_RESUME:
 		r = vhost_vdpa_resume(v);
 		break;
+	case VHOST_NEW_OWNER:
+		r = vhost_vdpa_new_owner(v);
+		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
 		if (r == -ENOIOCTLCMD)
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index e0c181ad17e3..0ce7ee9834f4 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -907,6 +907,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
 
+/* Caller should have device mutex */
+long vhost_dev_new_owner(struct vhost_dev *dev)
+{
+	if (dev->mm == current->mm)
+		return -EBUSY;
+
+	if (!vhost_dev_has_owner(dev))
+		return -EINVAL;
+
+	vhost_detach_mm(dev);
+	vhost_attach_mm(dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vhost_dev_new_owner);
+
 static struct vhost_iotlb *iotlb_alloc(void)
 {
 	return vhost_iotlb_alloc(max_iotlb_entries,
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index f60d5f7bef94..cd0dab21d99e 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -185,6 +185,7 @@ void vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue **vqs,
 		    int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 				       struct vhost_iotlb_msg *msg));
 long vhost_dev_set_owner(struct vhost_dev *dev);
+long vhost_dev_new_owner(struct vhost_dev *dev);
 bool vhost_dev_has_owner(struct vhost_dev *dev);
 long vhost_dev_check_owner(struct vhost_dev *);
 struct vhost_iotlb *vhost_dev_reset_owner_prepare(void);
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 649560c685f1..5e3cdce4c0cf 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -123,6 +123,16 @@
 #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
 #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
 
+/* Set current process as the new owner of this file descriptor.  The fd must
+ * already be owned, via a prior call to VHOST_SET_OWNER.  The pinned memory
+ * count is transferred from the previous to the new owner.
+ * Errors:
+ *   EINVAL: not owned
+ *   EBUSY:  caller is already the owner
+ *   ENOMEM: RLIMIT_MEMLOCK exceeded
+ */
+#define VHOST_NEW_OWNER _IO(VHOST_VIRTIO, 0x27)
+
 /* VHOST_NET specific defines */
 
 /* Attach virtio net ring to a raw socket, or tap device.
-- 
2.39.3


