Return-Path: <linux-kernel+bounces-22759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D8A82A294
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64DC1C22CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB67C50253;
	Wed, 10 Jan 2024 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YwjuYn2S"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9274F60C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AJfmVP028156;
	Wed, 10 Jan 2024 20:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=h71dZ5JIuyeY4E0yCnqZDDaeoo7HDhGRC726pRtjHQU=;
 b=YwjuYn2SLz0xe5VkayBFoZr9EXJ73Hw0soGv/rlO9PHqsfT3ZC+/skZTteKsregCnTxc
 pXDKZbWiYARJJqsupF57xGDZfzizVwMKpbGN4HK/yWYcaFqa9wwJQbH5wJKrVn+4qDiU
 60uAAh6JkJIhixK8bByD7rNJvApXoYSsU0QRMVO92GbNnERG9tHNT4SWEl6gLrEuyMxQ
 7X+i01WvTBCU0vsEZNVBYLrxO51fZFk2R2REBs6A+xbvKgJk+XwPVOpi6Bhs00YEaTe8
 e9Pqsw04MDdpHCBpfIGuadZGUtXarz9CNigcIyN0A4DjsrsAuFqB/zyi/NwM7BWjg249 ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vj1m404a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AKdD5K030150;
	Wed, 10 Jan 2024 20:40:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutp5xay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:23 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AKeGrf005067;
	Wed, 10 Jan 2024 20:40:23 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vfutp5x5e-9;
	Wed, 10 Jan 2024 20:40:23 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 08/13] vduse: flush workers on suspend
Date: Wed, 10 Jan 2024 12:40:10 -0800
Message-Id: <1704919215-91319-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: 8NpbJVwE_0qX_hcElGpqR-L_JVyvHOtf
X-Proofpoint-GUID: 8NpbJVwE_0qX_hcElGpqR-L_JVyvHOtf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

To pass ownership of a live vdpa device to a new process, the user
suspends the device, calls VHOST_NEW_OWNER to change the mm, and calls
VHOST_IOTLB_REMAP to change the user virtual addresses to match the new
mm.  Flush workers in suspend to guarantee that no worker sees the new
mm and old VA in between.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0ddd4b8abecb..6b25457a037d 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -472,6 +472,18 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 	up_write(&dev->rwsem);
 }
 
+static void vduse_flush_work(struct vduse_dev *dev)
+{
+	flush_work(&dev->inject);
+
+	for (int i = 0; i < dev->vq_num; i++) {
+		struct vduse_virtqueue *vq = dev->vqs[i];
+
+		flush_work(&vq->inject);
+		flush_work(&vq->kick);
+	}
+}
+
 static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
 				u64 desc_area, u64 driver_area,
 				u64 device_area)
@@ -713,6 +725,17 @@ static int vduse_vdpa_reset(struct vdpa_device *vdpa)
 	return ret;
 }
 
+static int vduse_vdpa_suspend(struct vdpa_device *vdpa)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	down_write(&dev->rwsem);
+	vduse_flush_work(dev);
+	up_write(&dev->rwsem);
+
+	return 0;
+}
+
 static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
@@ -794,6 +817,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_vq_affinity	= vduse_vdpa_set_vq_affinity,
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
+	.suspend		= vduse_vdpa_suspend,
 	.set_map		= vduse_vdpa_set_map,
 	.free			= vduse_vdpa_free,
 };
-- 
2.39.3


