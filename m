Return-Path: <linux-kernel+bounces-62081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9DD851B20
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC401F2B433
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07263405D4;
	Mon, 12 Feb 2024 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BnTgIY95"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F653FB1C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758197; cv=none; b=X6jvWpnRZ4WUMCY1BfCabVLP29oIXCLurGJFWdzT0BhXQWWREJeqSD2tngBZUkCk/pPbXDE3Res0TQBw9Bo4PUlJgNDswIH6dg/HCYSkgEMXi10BHQPJFALLE8oWIjO3o4RTjL6+lgUYH7h+u9qdLT3F7eMSCmRxA+7uMvfiWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758197; c=relaxed/simple;
	bh=Q6Yq07+VdvdKRo4K3In05WZjYT3GiDeEF2bQ46jl/XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sY1LNApNY87P8S0oYLesOnvv7BYR1dV0THLLgP3JRx5tkjQyfFswT4ytUqQJTQSyA9WE6DG0oe3oN6P0ljK1m/a1JQNGfVMJvn9GdcOLI96cU9TGDsRzgqp5dyspoXA/iDtaWPlz8Fa0LnAmFmY3dVO8FTU1mVyVN0O83nrh9Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BnTgIY95; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CFxpIS004867;
	Mon, 12 Feb 2024 17:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=2Q4si0x3nG3VI9xSasdsfLDFx2lasKaM6lvaVLjk0wk=;
 b=BnTgIY95wjHStu21zgmfSgXIo9yUC3WUxQN1MJw0Wc0n4UP5jsS8Y6fsIO6iZhyBIP2m
 hxSVSp6lj5Lsn6OvvMlv88XBEYc0NjBSGTsCgRp7Gqbkgk514Dw0s0Xf/5P9IIRtGx9Y
 lOPyBce85Dok6vo2o7pbmxIH4SZ8W78lvBTqJ/BmvKD5SF5esStfOqWnY4ml73IFvSu/
 oTNgfPA+dk1uydQetedhaLRtKKxkdxJH13DoL34tqugF1hk0q5j7ADSzCo3lUAydyjdA
 XuCdVyy/au597x4y7DX/NgGQLuQMgc8tBUeA/h2c4dtzvTwVYM+ZCnHSwlgoxbWXjz3N 4Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7pf1r6yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:16:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CGZllm031499;
	Mon, 12 Feb 2024 17:16:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk620f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:16:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CHGFCC019216;
	Mon, 12 Feb 2024 17:16:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5yk620cq-3;
	Mon, 12 Feb 2024 17:16:18 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 2/3] vduse: suspend
Date: Mon, 12 Feb 2024 09:16:13 -0800
Message-Id: <1707758174-142161-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120131
X-Proofpoint-ORIG-GUID: 52OpQkWopH_UijR_V1gH72otsGZlCUqw
X-Proofpoint-GUID: 52OpQkWopH_UijR_V1gH72otsGZlCUqw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Support the suspend operation.  There is little to do, except flush to
guarantee no workers are running when suspend returns.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 1d24da79c399..503030f19e52 100644
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


