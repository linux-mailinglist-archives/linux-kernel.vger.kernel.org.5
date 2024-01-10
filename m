Return-Path: <linux-kernel+bounces-22766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842C882A29C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335B428F26D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54053813;
	Wed, 10 Jan 2024 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AMF44scT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E91C50265
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AIEJun001445;
	Wed, 10 Jan 2024 20:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=ikIw1YDf0Rr6UcV7EZ53FO7vqQLcCSbKuHARKKX1+Ec=;
 b=AMF44scTd1h/vOMAg4m/JXSD/W/oS5Br13EfU1SLMwmvZ1YhNVBQrPWsTg91CeLZpoY0
 57HQElys8YxeiMJqOngCkrRj4S4jvpjqdbLWfPSt6scineUafGZmsc27MNEoToEFmDR6
 ZRqXDJoB50Edt79HV1t6JRJMLaA7RrUzNSU/bG059Wcss2gNO4aPLyLJs4yXlXesGppM
 cOSByOs7GLMYBpXr9It70cE9Isv4TZ2VVzp8ywOlORhsJsxbjExVPenblLVdfX4TdyBm
 xvhBM89Ofqarae9dsjZG5Z3Qu9Db4Vvj2ieX5Z8qrHaExrc5zXOBraU12dqr4mZ8PWZp Fg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhvgm8x6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AJa7ar030210;
	Wed, 10 Jan 2024 20:40:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutp5xd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:26 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AKeGrn005067;
	Wed, 10 Jan 2024 20:40:26 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vfutp5x5e-13;
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
Subject: [RFC V1 12/13] vdpa_sim: new owner capability
Date: Wed, 10 Jan 2024 12:40:14 -0800
Message-Id: <1704919215-91319-13-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: 2Hu1AOJmzavdJfK1M9mH4m5SRgKm8PAD
X-Proofpoint-ORIG-GUID: 2Hu1AOJmzavdJfK1M9mH4m5SRgKm8PAD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The vdpa_sim device supports ownership transfer to a new process, so
advertise VHOST_BACKEND_F_NEW_OWNER.  User virtual addresses are used
by the software iommu, so VHOST_IOTLB_REMAP is required after
VHOST_NEW_OWNER, so advertise VHOST_BACKEND_F_IOTLB_REMAP.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 8734834983cb..d037869d8a89 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -430,7 +430,13 @@ static u64 vdpasim_get_device_features(struct vdpa_device *vdpa)
 
 static u64 vdpasim_get_backend_features(const struct vdpa_device *vdpa)
 {
-	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
+	u64 features = BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
+		       BIT_ULL(VHOST_BACKEND_F_NEW_OWNER);
+
+	if (use_va)
+		features += BIT_ULL(VHOST_BACKEND_F_IOTLB_REMAP);
+
+	return features;
 }
 
 static int vdpasim_set_driver_features(struct vdpa_device *vdpa, u64 features)
-- 
2.39.3


