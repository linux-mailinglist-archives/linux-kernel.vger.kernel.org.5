Return-Path: <linux-kernel+bounces-60111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C9A84FFFC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7596B286A5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812CF3A8DF;
	Fri,  9 Feb 2024 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qym7PzMa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E63FDF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517815; cv=none; b=CyBwDQJOkQClMU9UmrU0H+rj1fenqV7myD6aFVFHekm94VxnDaBDawDozZM36xm+niwLoXSDmx63a+2Hzeyq2E4a4str/4VX9ZtcT1HWmRp8DAsVydUX4UHn0TzvoDIG24ewmbJzblr7eVkUyfALj92VCSO9oMcXo4nlV0Ae34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517815; c=relaxed/simple;
	bh=L73hoB9xUTAeRKc4fnAAeVp0lZYHqGJZyHoGKniDhmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pHoNKpyP7+F+XfvIhHISdab1YGEKqbe6wzPYVzc08l8SIDdfMIgkM9MWtbOIv2w9oy63XUaE5teR+q5mSzYOhRdsemmJXA2wYLqfjSRvGqCfaWjrKG9UBKYWvovLUHSW3nabadcbOqkvjvy068ke1EMMhVGhCxxlps0VbhtDBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qym7PzMa; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419LnGM0016710;
	Fri, 9 Feb 2024 22:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=moCCEpVANRkasMFH/GJCYekintrcdpGWHgEyFAi8gvs=;
 b=Qym7PzMa1tGuMCW/Yoafv234yADh7GieVk3eHZ9VPjYEDcONmXZmvu8B/hvW5o0txYrO
 qo9y/IthY45OFI276HpHzlYH6boSQLkFK602+sIKu4FpbYlutbm9M19RM8kbZmfQB7eV
 t76dR+G8uYmjvkHMiB1w9WGRPw88wUvKlUAA/CJUKFbsuQyEe8u/VEiRR/XeKQXm1ZkG
 lJ+tNACnKTYfJAxwE7tsfVtKKLK78eihkMyqC6qyEq3IN6W3K579osKYpssOExt4puGT
 AP9wsAygaVyC/zP/+tnvNteGBYTSLqLpoCTMbrOYSh12j7lG/zOObPhV65Tt1rBPEusu dA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w5uuxg3vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 22:30:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419LhasU039427;
	Fri, 9 Feb 2024 22:30:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxcgj2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 22:30:08 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 419MU83E031940;
	Fri, 9 Feb 2024 22:30:08 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w1bxcgj29-1;
	Fri, 09 Feb 2024 22:30:08 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2] vdpa_sim: reset must not run
Date: Fri,  9 Feb 2024 14:30:07 -0800
Message-Id: <1707517807-137331-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
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
 definitions=2024-02-09_18,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402090165
X-Proofpoint-GUID: BwBz77vBQK_ta7s46YbOE02rI5hx-ukT
X-Proofpoint-ORIG-GUID: BwBz77vBQK_ta7s46YbOE02rI5hx-ukT

vdpasim_do_reset sets running to true, which is wrong, as it allows
vdpasim_kick_vq to post work requests before the device has been
configured.  To fix, do not set running until VIRTIO_CONFIG_S_DRIVER_OK
is set.

Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index be2925d0d283..18584ce70bf0 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -160,7 +160,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim, u32 flags)
 		}
 	}
 
-	vdpasim->running = true;
+	vdpasim->running = false;
 	spin_unlock(&vdpasim->iommu_lock);
 
 	vdpasim->features = 0;
@@ -483,6 +483,7 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
 
 	mutex_lock(&vdpasim->mutex);
 	vdpasim->status = status;
+	vdpasim->running = (status & VIRTIO_CONFIG_S_DRIVER_OK) != 0;
 	mutex_unlock(&vdpasim->mutex);
 }
 
-- 
2.39.3


