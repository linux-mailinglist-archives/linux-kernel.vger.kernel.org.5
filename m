Return-Path: <linux-kernel+bounces-68740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE95857F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C8D1F2289D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC3E12CDB3;
	Fri, 16 Feb 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HB6RXLxd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1112CD9A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093519; cv=none; b=XiqEHU7Q16e0uuf0CZitI4zSo/iYkApHX24xevXM9ZUv96meexnkss3A7FTqfM8S5uDqfyeio2EdAjQhPki+980ObgKq5rMq+f13d7IWiaAglvrGYS6wwKomsFJuITvizT3fv2uafL7tsgiTsb6LKrzFSnHOjSfh9auVc+0gRXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093519; c=relaxed/simple;
	bh=IT0RuO8hNrLvcTd49Cl9rAsXLcbRp/10UlV0SgfqJlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fjlfbFjD8QkhlW6Jy34Umgcv9DROv2HZBqTGYpJ7MDKr03QM5b8P66J4hnCAFr1q53qOVurShRtGtyx0sHjsYuN4SvGL1ucxDsyYJFYbSwXNHf46w2dZWnszf7AytpHDTpLbHbW5rcGzJ3rsojz9N7vzhM4yD/wHgsp6JPAltdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HB6RXLxd; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GCteU6016560;
	Fri, 16 Feb 2024 14:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=uBxhZRwg4l5rEnPXjSwnK4GA/Up32KbHN12cZyql8BI=;
 b=HB6RXLxdgdq6PUkoWW2L0HuZG2qbMhrKs/lGartoG0w8GsNZWva5x8msc3RUDxLLz5P+
 3jdzeiSt48EOBmpBuWmpV39WoKpjG7qP8VdS1KEtBN28ZmHXrLkmvXUnq2ZDzOUjZH+g
 xJUUDbwVz5Lse+JvxC48DC48TwSsXYAVvcl/yYQ55kfsnVtxFb13UZT3jJnvzP6bQynO
 QegLtZUC6sF3CEOFQiE4BDmQ0qBk+YK3+HX9ENMOBwkIq3462Xhhl5E1T1UzCb8UlUEw
 fHm+QuWO+LpyZ2sdIl1zCo/jvlFFZlTS+kfPWbSZenaagL6bVRVyLZYzXmLRdUZlx/BA Aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppn76q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 14:25:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GE7SWU031500;
	Fri, 16 Feb 2024 14:25:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykc6ggk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 14:25:05 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GEP58Q006406;
	Fri, 16 Feb 2024 14:25:05 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-191-137.vpn.oracle.com [10.65.191.137])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5ykc6gfn-1;
	Fri, 16 Feb 2024 14:25:05 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, si-wei.liu@oracle.com,
        virtualization@lists.linux-foundation.org, dtatulea@nvidia.com
Cc: jonah.palmer@oracle.com, boris.ostrovsky@oracle.com, leiyang@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] vdpa/mlx5: Allow CVQ size changes
Date: Fri, 16 Feb 2024 09:25:02 -0500
Message-Id: <20240216142502.78095-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160115
X-Proofpoint-ORIG-GUID: 1nyPEBMPUo5MAH0-NT3gFLXUoeJcDjB0
X-Proofpoint-GUID: 1nyPEBMPUo5MAH0-NT3gFLXUoeJcDjB0

The MLX driver was not updating its control virtqueue size at set_vq_num
and instead always initialized to MLX5_CVQ_MAX_ENT (16) at
setup_cvq_vring.

Qemu would try to set the size to 64 by default, however, because the
CVQ size always was initialized to 16, an error would be thrown when
sending >16 control messages (as used-ring entry 17 is initialized to 0).
For example, starting a guest with x-svq=on and then executing the
following command would produce the error below:

 # for i in {1..20}; do ifconfig eth0 hw ether XX:xx:XX:xx:XX:XX; done

 qemu-system-x86_64: Insufficient written data (0)
 [  435.331223] virtio_net virtio0: Failed to set mac address by vq command.
 SIOCSIFHWADDR: Invalid argument

Acked-by: Dragos Tatulea <dtatulea@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 778821bab7d9..ecfc16151d61 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -151,8 +151,6 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev);
 
 static bool mlx5_vdpa_debug;
 
-#define MLX5_CVQ_MAX_ENT 16
-
 #define MLX5_LOG_VIO_FLAG(_feature)                                                                \
 	do {                                                                                       \
 		if (features & BIT_ULL(_feature))                                                  \
@@ -2276,9 +2274,16 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct mlx5_vdpa_virtqueue *mvq;
 
-	if (!is_index_valid(mvdev, idx) || is_ctrl_vq_idx(mvdev, idx))
+	if (!is_index_valid(mvdev, idx))
 		return;
 
+        if (is_ctrl_vq_idx(mvdev, idx)) {
+                struct mlx5_control_vq *cvq = &mvdev->cvq;
+
+                cvq->vring.vring.num = num;
+                return;
+        }
+
 	mvq = &ndev->vqs[idx];
 	mvq->num_ent = num;
 }
@@ -2963,7 +2968,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
 		u16 idx = cvq->vring.last_avail_idx;
 
 		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
-					MLX5_CVQ_MAX_ENT, false,
+					cvq->vring.vring.num, false,
 					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
 					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
 					(struct vring_used *)(uintptr_t)cvq->device_addr);
-- 
2.39.3


