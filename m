Return-Path: <linux-kernel+bounces-22760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B61482A296
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72F31F233BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3119750267;
	Wed, 10 Jan 2024 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FW3HzgVP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC484F60F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AJgBcx024051;
	Wed, 10 Jan 2024 20:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=ozrzwgDgje72Ak3YBhfPtWMph3qwJiDzAJ5pWQvnhwU=;
 b=FW3HzgVPCn/KF8o9W0qOaX8hff+KWsWzT6rhTE2jPd/COIYCzZ4fsWBMW/3cKMx/npvu
 HXSKmq/CQ7/f2VV0jIt0h+hqZxNsdq5OQRFgl0ihxbXrFq75A34ycjX95nLjP3IUknuU
 go/AaQ9fKn/zb+QK2hodsUaqJP3DcIiJRo3mBwaTIg08fpS3YIXIROXZXzENs7YkovCw
 gcW17hRYWOub6l7dPbMi76badfMeHh+iDoky3+HSwIVZwtLh+lQ0FAv0s5EyTmrJw56e
 Fd5puGnq9KT0r80rDpvt5dffZg+tAoDn0+kmt3e9jEm4L735AGJn/bNLJVBSehMi6RUA 0w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vj1m5r493-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AKbb9b030303;
	Wed, 10 Jan 2024 20:40:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutp5x9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:22 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AKeGrb005067;
	Wed, 10 Jan 2024 20:40:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vfutp5x5e-7;
	Wed, 10 Jan 2024 20:40:21 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 06/13] vhost-vdpa: VHOST_BACKEND_F_IOTLB_REMAP
Date: Wed, 10 Jan 2024 12:40:08 -0800
Message-Id: <1704919215-91319-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: -Vu2mJH_2nflUo3UQH3FAAxeRLutXKmC
X-Proofpoint-GUID: -Vu2mJH_2nflUo3UQH3FAAxeRLutXKmC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add the VHOST_BACKEND_F_IOTLB_REMAP backend capability, which indicates
that VHOST_IOTLB_REMAP is supported.

If VHOST_BACKEND_F_IOTLB_REMAP is advertised, then the user must call
VHOST_IOTLB_REMAP after ownership of a device is transferred to a new
process via VHOST_NEW_OWNER.  Disabling the feature during negotiation
does not negate this requirement.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c             | 8 +++++++-
 include/uapi/linux/vhost_types.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ec5ca20bd47d..8fe1562d24af 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -789,7 +789,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
 				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
 				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
-				 BIT_ULL(VHOST_BACKEND_F_NEW_OWNER)))
+				 BIT_ULL(VHOST_BACKEND_F_NEW_OWNER) |
+				 BIT_ULL(VHOST_BACKEND_F_IOTLB_REMAP)))
 			return -EOPNOTSUPP;
 		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
 		     !vhost_vdpa_can_suspend(v))
@@ -1229,11 +1230,16 @@ static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
 	u64 start = msg->iova;
 	u64 last = start + msg->size - 1;
 	struct vhost_iotlb_map *map;
+	u64 features;
 	int r = 0;
 
 	if (msg->perm || !msg->size)
 		return -EINVAL;
 
+	features = ops->get_backend_features(vdpa);
+	if (!(features & BIT_ULL(VHOST_BACKEND_F_IOTLB_REMAP)))
+		return -EOPNOTSUPP;
+
 	map = vhost_iotlb_itree_first(iotlb, start, last);
 	if (!map)
 		return -ENOENT;
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 35908315ff55..7e79e9bd0f7b 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -203,5 +203,7 @@ struct vhost_vdpa_iova_range {
 #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
 /* Supports VHOST_NEW_OWNER */
 #define VHOST_BACKEND_F_NEW_OWNER  0x9
+/* Supports VHOST_IOTLB_REMAP */
+#define VHOST_BACKEND_F_IOTLB_REMAP  0xa
 
 #endif
-- 
2.39.3


