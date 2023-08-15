Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E303E77C560
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjHOBqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjHOBpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:45:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C51B2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:45:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOwWk015360;
        Tue, 15 Aug 2023 01:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=ibbe3IEzpkg/bmF2R++TxgWBCqasnu95SyHMSrDgL+E=;
 b=r/lBNgg4JdrEPjKXss9dB0zS9XP+jNmXTT7BzDmH3v03vvNnu9W1TDM8dKk7yYXdNmLR
 CRQub5Z2yHRhSB119K5HMn7t+ZHbXH5A+d99tJ9jz7SfSXsyG+NRr8vaPFvVke1cRa4/
 pOQJgzPqRtQZ07QzeBtUCRIbM9ohitMorAdgrknqhmpG0YrJWPfftQyFLnBKDoomupMS
 AuNNYjepmkv1PRqgc9EAILirXe62DMKwsetM44UUQL9g4rpSBXzBXPOjE4HfpCY9kGs7
 Jw/8vhU1OeuPeyTGzIXB6WrbTozP+Cnb3zDe2wX9kl+XrP7nH1/Xz583TI/HHDZ9qlry Aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwkw3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:45:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ENwIAI006639;
        Tue, 15 Aug 2023 01:45:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2ckej3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:45:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37F1jTKB011831;
        Tue, 15 Aug 2023 01:45:30 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sey2ckehb-3;
        Tue, 15 Aug 2023 01:45:30 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com
Cc:     eperezma@redhat.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
        mst@redhat.com, si-wei.liu@oracle.com,
        virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
Subject: [PATCH RFC 2/4] vdpa/mlx5: implement .reset_map driver op
Date:   Mon, 14 Aug 2023 18:43:25 -0700
Message-Id: <1692063807-5018-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_01,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150013
X-Proofpoint-ORIG-GUID: Rsj_cxSGT8Sqbjc4kcPZGnM6JlCrM26h
X-Proofpoint-GUID: Rsj_cxSGT8Sqbjc4kcPZGnM6JlCrM26h
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is based on top of the "vdpa/mlx5: Fixes
for ASID handling" series [1].

[1] vdpa/mlx5: Fixes for ASID handling
https://lore.kernel.org/virtualization/20230802171231.11001-1-dtatulea@nvidia.com/

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 72 +++++++++++++++++++++-----------------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 18 +++++++---
 3 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index b53420e..5c9a25a 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -123,6 +123,7 @@ int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 			unsigned int asid);
 void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
 void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
+int mlx5_vdpa_reset_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
 
 #define mlx5_vdpa_warn(__dev, format, ...)                                                         \
 	dev_warn((__dev)->mdev->device, "%s:%d:(pid %d) warning: " format, __func__, __LINE__,     \
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 5a1971fc..c8d64fc 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -489,21 +489,15 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr
 	}
 }
 
-static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev)
 {
-	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
-		return;
-
 	prune_iotlb(mvdev);
 }
 
-static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 
-	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
-		return;
-
 	if (!mr->initialized)
 		return;
 
@@ -521,8 +515,10 @@ void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
 
 	mutex_lock(&mr->mkey_mtx);
 
-	_mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
-	_mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
+	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid)
+		_mlx5_vdpa_destroy_dvq_mr(mvdev);
+	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid)
+		_mlx5_vdpa_destroy_cvq_mr(mvdev);
 
 	mutex_unlock(&mr->mkey_mtx);
 }
@@ -534,25 +530,17 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
 }
 
 static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
-				    struct vhost_iotlb *iotlb,
-				    unsigned int asid)
+				    struct vhost_iotlb *iotlb)
 {
-	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
-		return 0;
-
 	return dup_iotlb(mvdev, iotlb);
 }
 
 static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
-				    struct vhost_iotlb *iotlb,
-				    unsigned int asid)
+				    struct vhost_iotlb *iotlb)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 	int err;
 
-	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
-		return 0;
-
 	if (mr->initialized)
 		return 0;
 
@@ -574,20 +562,18 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
 {
 	int err;
 
-	err = _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
-	if (err)
-		return err;
-
-	err = _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
-	if (err)
-		goto out_err;
+	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
+		err = _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
+		if (err)
+			return err;
+	}
+	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid) {
+		err = _mlx5_vdpa_create_cvq_mr(mvdev, iotlb);
+		if (err)
+			return err;
+	}
 
 	return 0;
-
-out_err:
-	_mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
-
-	return err;
 }
 
 int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
@@ -601,6 +587,28 @@ int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 	return err;
 }
 
+int mlx5_vdpa_reset_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+{
+	struct mlx5_vdpa_mr *mr = &mvdev->mr;
+	int err = 0;
+
+	if (asid != 0)
+		return 0;
+
+	mutex_lock(&mr->mkey_mtx);
+	if (!mr->user_mr)
+		goto out;
+	_mlx5_vdpa_destroy_dvq_mr(mvdev);
+	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
+		err = _mlx5_vdpa_create_dvq_mr(mvdev, NULL, 0);
+		if (err)
+			mlx5_vdpa_warn(mvdev, "create DMA MR failed\n");
+	}
+out:
+	mutex_unlock(&mr->mkey_mtx);
+	return err;
+}
+
 int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 			     bool *change_map, unsigned int asid)
 {
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 61c10ba..399a690 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2816,7 +2816,6 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	unregister_link_notifier(ndev);
 	teardown_driver(ndev);
 	clear_vqs_ready(ndev);
-	mlx5_vdpa_destroy_mr(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->mvdev.suspended = false;
 	ndev->cur_num_vqs = 0;
@@ -2827,10 +2826,6 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	init_group_to_asid_map(mvdev);
 	++mvdev->generation;
 
-	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
-		if (mlx5_vdpa_create_mr(mvdev, NULL, 0))
-			mlx5_vdpa_warn(mvdev, "create MR failed\n");
-	}
 	up_write(&ndev->reslock);
 
 	return 0;
@@ -2895,6 +2890,18 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
 	return err;
 }
 
+static int mlx5_vdpa_reset_map(struct vdpa_device *vdev, unsigned int asid)
+{
+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	int err;
+
+	down_write(&ndev->reslock);
+	err = mlx5_vdpa_reset_mr(mvdev, asid);
+	up_write(&ndev->reslock);
+	return err;
+}
+
 static struct device *mlx5_get_vq_dma_dev(struct vdpa_device *vdev, u16 idx)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
@@ -3154,6 +3161,7 @@ static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
 	.set_config = mlx5_vdpa_set_config,
 	.get_generation = mlx5_vdpa_get_generation,
 	.set_map = mlx5_vdpa_set_map,
+	.reset_map = mlx5_vdpa_reset_map,
 	.set_group_asid = mlx5_set_group_asid,
 	.get_vq_dma_dev = mlx5_get_vq_dma_dev,
 	.free = mlx5_vdpa_free,
-- 
1.8.3.1

