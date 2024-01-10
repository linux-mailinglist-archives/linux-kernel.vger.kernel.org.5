Return-Path: <linux-kernel+bounces-22765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5893E82A29D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2BE1C22B88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B97F537FA;
	Wed, 10 Jan 2024 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DNlXjkqM"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE5A5024C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AIEKYd001460;
	Wed, 10 Jan 2024 20:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=dMCCREUha/f4rs7C2GyYgBNQR+v/C2SrOcmk5JSsA44=;
 b=DNlXjkqMufFKyp/XRiG5Cp55JWfT76/fidbY873HI1BSxR9/lufWuRag0DQmM+V2JRHi
 cb+i+vPqrtKD444hrvpvdFbJ6mXPSaV0iSvloT1L1WG+lsdfEe2VYmjiANU3Ram94ZHj
 X/plyFlaVNoyjFeRBolYwaCPQYZ2I0TI90JEmu95t9EIA2+5ITdVsXy25L5X11j55jkE
 s8/5V2OXGz/paaYrtwKlFJs4gBoTnxxt/Gtom54weKJnHNZtw0qKHZt60tZBxznl+4aw
 ppeX+nPvHlFBa2Ob9L7ydSXuQdFiMVJf6mBjWNOq/r5ef0B+KIqYeCChL1AECg799rF8 vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhvgm8x6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AJ29e8030110;
	Wed, 10 Jan 2024 20:40:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutp5x98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AKeGrZ005067;
	Wed, 10 Jan 2024 20:40:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vfutp5x5e-6;
	Wed, 10 Jan 2024 20:40:20 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 05/13] vhost-vdpa: VHOST_IOTLB_REMAP
Date: Wed, 10 Jan 2024 12:40:07 -0800
Message-Id: <1704919215-91319-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: F5HIFZ2cDW3w2vviq-JwN_fv0su8Y40M
X-Proofpoint-ORIG-GUID: F5HIFZ2cDW3w2vviq-JwN_fv0su8Y40M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When device ownership is passed to a new process via VHOST_NEW_OWNER,
some devices need to know the new userland addresses of the dma mappings.
Define the new iotlb message type VHOST_IOTLB_REMAP to update the uaddr
of a mapping.  The new uaddr must address the same memory object as
originally mapped.

The user must suspend the device before the old address is invalidated,
and cannot resume it until after VHOST_IOTLB_REMAP is called, but this
requirement is not enforced by the API.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c             | 34 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost_types.h | 11 ++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index faed6471934a..ec5ca20bd47d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1219,6 +1219,37 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 }
 
+static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
+					  struct vhost_iotlb *iotlb,
+					  struct vhost_iotlb_msg *msg)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+	u32 asid = iotlb_to_asid(iotlb);
+	u64 start = msg->iova;
+	u64 last = start + msg->size - 1;
+	struct vhost_iotlb_map *map;
+	int r = 0;
+
+	if (msg->perm || !msg->size)
+		return -EINVAL;
+
+	map = vhost_iotlb_itree_first(iotlb, start, last);
+	if (!map)
+		return -ENOENT;
+
+	if (map->start != start || map->last != last)
+		return -EINVAL;
+
+	/* batch will finish with remap.  non-batch must do it now. */
+	if (!v->in_batch)
+		r = ops->set_map(vdpa, asid, iotlb);
+	if (!r)
+		map->addr = msg->uaddr;
+
+	return r;
+}
+
 static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 					   struct vhost_iotlb *iotlb,
 					   struct vhost_iotlb_msg *msg)
@@ -1298,6 +1329,9 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
 			ops->set_map(vdpa, asid, iotlb);
 		v->in_batch = false;
 		break;
+	case VHOST_IOTLB_REMAP:
+		r = vhost_vdpa_process_iotlb_remap(v, iotlb, msg);
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 9177843951e9..35908315ff55 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -79,7 +79,7 @@ struct vhost_iotlb_msg {
 /*
  * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
  * multiple mappings in one go: beginning with
- * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
+ * VHOST_IOTLB_BATCH_BEGIN, followed by any number of VHOST_IOTLB_REMAP or
  * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END.
  * When one of these two values is used as the message type, the rest
  * of the fields in the message are ignored. There's no guarantee that
@@ -87,6 +87,15 @@ struct vhost_iotlb_msg {
  */
 #define VHOST_IOTLB_BATCH_BEGIN    5
 #define VHOST_IOTLB_BATCH_END      6
+
+/*
+ * VHOST_IOTLB_REMAP registers a new uaddr for the existing mapping at iova.
+ * The new uaddr must address the same memory object as originally mapped.
+ * Failure to do so will result in user memory corruption and/or device
+ * misbehavior.  iova and size must match the arguments used to create the
+ * an existing mapping.  Protection is not changed, and perm must be 0.
+ */
+#define VHOST_IOTLB_REMAP          7
 	__u8 type;
 };
 
-- 
2.39.3


