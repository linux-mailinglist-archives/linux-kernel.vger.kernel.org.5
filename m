Return-Path: <linux-kernel+bounces-22756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8BA82A28F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA201F2251A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7524F608;
	Wed, 10 Jan 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PIM4LLkY"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D874EB5B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AKYvku003775;
	Wed, 10 Jan 2024 20:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=jh11dyvSQNnKUo1r6jhKPY0j2VffYmGM4O1HGJByISA=;
 b=PIM4LLkYmEQ+tK+uFZ+xx1zuW3yPDNKiMIB0fIViO9BtXcH4rBcThTe0CeSZCTLXghf8
 dSUW3wy/GY1JwW7zIook+oae4XiQS3rcxbvoOk9NLwVwgXuQGJ7wqKo9rxJMgeGSv7G9
 UErJne9l+FHIvEbQTGjbN7CyIoQO1oOkCroTUas8e4kxvqcnm7JQOYT+rPxenWDe9HUv
 H+YJDrkFAJB1i1l9KcrI+LG6Cz/W1ZLXa4pctVLMEOyyVLhyatKyukgZUM5FiIRXwlYN
 FK4c6HaGkbjqTNPEaUm+BO0Yii7OgSMA8NNxZzJox4jCi/RLMWZ+H1/mnULn8QG3EDu+ tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhpg7hn7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AJa7an030210;
	Wed, 10 Jan 2024 20:40:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutp5x7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:19 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AKeGrT005067;
	Wed, 10 Jan 2024 20:40:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vfutp5x5e-3;
	Wed, 10 Jan 2024 20:40:18 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 02/13] vhost-vdpa: pass mm to bind
Date: Wed, 10 Jan 2024 12:40:04 -0800
Message-Id: <1704919215-91319-3-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: Wrwtw6lCuAAEQU4M8EjggS-ALikU6A5v
X-Proofpoint-GUID: Wrwtw6lCuAAEQU4M8EjggS-ALikU6A5v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Pass the target mm to vhost_vdpa_bind_mm.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 10fb95bcca1a..2269988d6d33 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -248,7 +248,7 @@ static int vhost_vdpa_reset(struct vhost_vdpa *v)
 	return _compat_vdpa_reset(v);
 }
 
-static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
+static long vhost_vdpa_bind_mm(struct vhost_vdpa *v, struct mm_struct *mm)
 {
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
@@ -256,7 +256,7 @@ static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
 	if (!vdpa->use_va || !ops->bind_mm)
 		return 0;
 
-	return ops->bind_mm(vdpa, v->vdev.mm);
+	return ops->bind_mm(vdpa, mm);
 }
 
 static void vhost_vdpa_unbind_mm(struct vhost_vdpa *v)
@@ -855,7 +855,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 
 	switch (cmd) {
 	case VHOST_SET_OWNER:
-		r = vhost_vdpa_bind_mm(v);
+		r = vhost_vdpa_bind_mm(v, v->vdev.mm);
 		if (r)
 			vhost_dev_reset_owner(d, NULL);
 		break;
-- 
2.39.3


