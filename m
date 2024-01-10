Return-Path: <linux-kernel+bounces-22762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF18E82A298
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A086C1F22674
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B09751000;
	Wed, 10 Jan 2024 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gYMmM0Pm"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F424F887
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AK3w0s029998;
	Wed, 10 Jan 2024 20:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=FpiZoHvSUlbsgeuYSF8i9bTFE5kjVtx0H07bVgfyAlU=;
 b=gYMmM0PmVOwVx3w4/XFZ8XbmGCKfA8vKeDYw9pbl2jHzMrerwU0XgleXNGZ1ki/XRR5z
 mu7Htr+2rlg9o/8m/AcEDLoYzB05SIbiy48bxTvogj7Heta/SaGVY5SHWPzsIl7pRfaz
 V5ekQR1koWy8rmp+TBxlOBUoUGVCgAMlO8nF01trnp0nXmtOu1VbXAL/V3uC0+crMZBB
 WmewGFAATsknj20g3g9uFqHhzPfiOHyt5OsNJ0FLRUyT8At2K6irxU+Xi2hhlpttMMep
 YcJRsJEOZ8y27mMzUNe8zvfVfLS6Tu5LG9KDOhtnH7JGWlwr7ryOi64CMOS8RzL7sNUh Pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhpg7hn7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AKO3M9030351;
	Wed, 10 Jan 2024 20:40:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutp5x8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:20 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AKeGrX005067;
	Wed, 10 Jan 2024 20:40:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vfutp5x5e-5;
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
Subject: [RFC V1 04/13] vhost-vdpa: VHOST_BACKEND_F_NEW_OWNER
Date: Wed, 10 Jan 2024 12:40:06 -0800
Message-Id: <1704919215-91319-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: a7Axpk9an_Q3GVL_3g0hV04yn0LVxpTx
X-Proofpoint-GUID: a7Axpk9an_Q3GVL_3g0hV04yn0LVxpTx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add the VHOST_BACKEND_F_NEW_OWNER backend capability, which indicates that
VHOST_NEW_OWNER is supported.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c             | 7 ++++++-
 include/uapi/linux/vhost_types.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index eb3a95e703b0..faed6471934a 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -621,6 +621,10 @@ static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
 	struct mm_struct *mm_new = current->mm;
 	long pinned_vm = v->pinned_vm;
 	unsigned long lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
+	u64 features = vhost_vdpa_get_backend_features(v);
+
+	if (!(features & BIT_ULL(VHOST_BACKEND_F_NEW_OWNER)))
+		return -EOPNOTSUPP;
 
 	if (!mm_old)
 		return -EINVAL;
@@ -784,7 +788,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 				 BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST) |
 				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
 				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
-				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
+				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
+				 BIT_ULL(VHOST_BACKEND_F_NEW_OWNER)))
 			return -EOPNOTSUPP;
 		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
 		     !vhost_vdpa_can_suspend(v))
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index d7656908f730..9177843951e9 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -192,5 +192,7 @@ struct vhost_vdpa_iova_range {
 #define VHOST_BACKEND_F_DESC_ASID    0x7
 /* IOTLB don't flush memory mapping across device reset */
 #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
+/* Supports VHOST_NEW_OWNER */
+#define VHOST_BACKEND_F_NEW_OWNER  0x9
 
 #endif
-- 
2.39.3


