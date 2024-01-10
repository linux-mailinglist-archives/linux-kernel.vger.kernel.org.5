Return-Path: <linux-kernel+bounces-22761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E81882A297
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544321C22CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495E85025B;
	Wed, 10 Jan 2024 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YBIbjuLQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1294F885
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AJfwkn023889;
	Wed, 10 Jan 2024 20:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=89vnNv40odEsIYEKtdQ3B5jHeyloLMbotUzx7nKsXSE=;
 b=YBIbjuLQ1HpFrExWVf1gyNml6J1/psthAgyOlc2WnbkasD+qrTiK4Z8BD67l9/t/HBFp
 CpKg1vk9w5ut+svEjlcV8etkQY189WX4Ng+I3gjXbf46Tnr0cYIT6eEVYxh4vKYVJaQJ
 EO8OG8eI5eo1SVnuYTxJsM1FI4WS4Cix9PUFr6Hoct1PFVuhIGezEquXgLcYI+Ncx5pO
 W4Duux6rDeJuV+zbb2jgO863ILhxDXuihnU8T8IgfmS2yCM/iytoud+nrO7HZNk9SmZg
 qevvN86FKmIYqzQpvHYhGyq1akBBlD00MBVmwN8u0SxFDPmrXDgIB77dh4C+aoXDHQqV Gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vj1m5r496-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AJW0k8030071;
	Wed, 10 Jan 2024 20:40:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutp5xbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:24 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AKeGrh005067;
	Wed, 10 Jan 2024 20:40:23 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vfutp5x5e-10;
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
Subject: [RFC V1 09/13] vdpa_sim: reset must not run
Date: Wed, 10 Jan 2024 12:40:11 -0800
Message-Id: <1704919215-91319-10-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: q-Rtur_15lquKQ2NCJ_uyoEGBjDEaIDr
X-Proofpoint-GUID: q-Rtur_15lquKQ2NCJ_uyoEGBjDEaIDr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

vdpasim_do_reset sets running to true, which is wrong, as it allows
vdpasim_kick_vq to post work requests before the device has been
configured.  To fix, do not set running until VIRTIO_CONFIG_S_FEATURES_OK
is set.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index be2925d0d283..6304cb0b4770 100644
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
+	vdpasim->running = (status & VIRTIO_CONFIG_S_FEATURES_OK) != 0;
 	mutex_unlock(&vdpasim->mutex);
 }
 
-- 
2.39.3


