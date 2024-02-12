Return-Path: <linux-kernel+bounces-62080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B15851B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4463A28A49D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC13F8F7;
	Mon, 12 Feb 2024 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lrk7C3Xm"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACB3F8C2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758193; cv=none; b=nPCgSPWwY1HcJ1wBkOiEbUQ61pg8Jl9Sptq4ddm4F6v/9WVci7H3d9CFQ1/yYtg0j7tZRHTLWSx3jqGpBiGbKMzoTpJjgGm9SPc8y9wvlXXk/GavF/gbhp5piQSddW/f2//qZWG8j8vWvsY13p8wKK6vgkbGhQkRAGe7pIgxk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758193; c=relaxed/simple;
	bh=8YvGJ2ZZyQiC7K2q187z+72Db2SHCfeV/AIbRS4MrO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZY62IuKw0EVxmrL2VqnzVDAE+J+A6iOZh45GWi/JD8eWZVAZ6pykvJtNhCHDefrbgKKiH+Gkvq6oWe2JDzSgxHWt54L5jCEGB8gjS72babX2u8jali25bWULyX8rrCZkLoKS38sZEcbUJ86QpDVcZB+8TL4oOpZjJJK1XEddE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lrk7C3Xm; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CH8lKn017068;
	Mon, 12 Feb 2024 17:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=fhdNJEwldjv6IUUX+AIoeSMZpJt3+JWrlmxQbPSV190=;
 b=lrk7C3XmHpr9hqdFhIHIUkxs3jui7oXu7hf/Y9opTu9qbbHvVKIrGMVpwBodB+cD+S1u
 EvyIsa6q+RhAgu01Omd9xmE9pmh+DJzSnP+TZBqEAtDwGUFvho9FpRCgHD0ZAVALaFWR
 YrrBnZJJLAr7l3AHnCmFZosfelAS5IOkAKkZAJxtJ2qKX+GDA9lh3vK6wBBmDpNgOhTS
 DA+VPhumPPGHkXzmPby1zUpPSqLaw0nLQOs6d/PKR4DS6AXOcJF72FLUDiSg+0zMLE8d
 2Iv6VmKs3AYIUfgJn/2dyv9Z9tLw+0VymDWz2Bmv9i+0V7OFJISVEG2KiBmGg7civ+ZP KA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7mpqggaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:16:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CGHEXh031321;
	Mon, 12 Feb 2024 17:16:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk620g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:16:20 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CHGFCE019216;
	Mon, 12 Feb 2024 17:16:19 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5yk620cq-4;
	Mon, 12 Feb 2024 17:16:19 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 3/3] vdpa_sim: flush workers on suspend
Date: Mon, 12 Feb 2024 09:16:14 -0800
Message-Id: <1707758174-142161-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: djMs8rQaCzFpOPn0bvE4a5muSqxH_YcW
X-Proofpoint-ORIG-GUID: djMs8rQaCzFpOPn0bvE4a5muSqxH_YcW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Flush to guarantee no workers are running when suspend returns.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index be2925d0d283..a662b90357c3 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -74,6 +74,17 @@ static void vdpasim_worker_change_mm_sync(struct vdpasim *vdpasim,
 	kthread_flush_work(work);
 }
 
+static void flush_work_fn(struct kthread_work *work) {}
+
+static void vdpasim_flush_work(struct vdpasim *vdpasim)
+{
+	struct kthread_work work;
+
+	kthread_init_work(&work, flush_work_fn);
+	kthread_queue_work(vdpasim->worker, &work);
+	kthread_flush_work(&work);
+}
+
 static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
 {
 	return container_of(vdpa, struct vdpasim, vdpa);
@@ -511,6 +522,8 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
 	vdpasim->running = false;
 	mutex_unlock(&vdpasim->mutex);
 
+	vdpasim_flush_work(vdpasim);
+
 	return 0;
 }
 
-- 
2.39.3


