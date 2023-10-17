Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99A47CB78C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjJQAnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjJQAmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:42:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842EC92
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:42:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKO4BI011132;
        Tue, 17 Oct 2023 00:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=WEr4JGhEt6neFXoJwZaO0Xs8r8Ued1/sBS5Auy1yR+s=;
 b=tbhvgKGsUaqzEyNd9PBKXWXchCJVKq2RvEbxJvZRgB2VhRbhVDiaW+rmfJzcPoTqnYyk
 4fz9RZ22UFZnnY7vIZDJNAdFOaMX7CLNky/wNnrbiqxe65Nlood4CuvmmzCQLS/vxrVX
 qLotEBJwDW4BArKR6p8ZQdr8fWseSXRYOd8bp3rwNzZZSswJUMKraze1ErLs31q+4e/3
 /b9IBT2RpvIj5lvIGcCUTxPN9SGHU9YFRACv69hkL4/zp4dFJ8SaysoAhWUWeDSrrN7i
 4dOfe8y6xbJ21zGeU8Sxtkc508O6XmBxgzheEHShTiIMrL68tPAiRhkl7ZMvpUstsQ9A Bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjync01u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 00:42:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GNB27L027141;
        Tue, 17 Oct 2023 00:42:40 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3trg535bja-5;
        Tue, 17 Oct 2023 00:42:40 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        sgarzare@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] vdpa/mlx5: implement .reset_map driver op
Date:   Mon, 16 Oct 2023 17:39:57 -0700
Message-Id: <1697503197-15935-5-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697503197-15935-1-git-send-email-si-wei.liu@oracle.com>
References: <1697503197-15935-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170003
X-Proofpoint-GUID: -pbDF6oNQ7-PqtuDB7Ak_yjYkgTYxiAW
X-Proofpoint-ORIG-GUID: -pbDF6oNQ7-PqtuDB7Ak_yjYkgTYxiAW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6f5312f80183 ("vdpa/mlx5: Add support for running with
virtio_vdpa"), mlx5_vdpa starts with preallocate 1:1 DMA MR at device
creation time. This 1:1 DMA MR will be implicitly destroyed while
the first .set_map call is invoked, in which case callers like
vhost-vdpa will start to set up custom mappings. When the .reset
callback is invoked, the custom mappings will be cleared and the 1:1
DMA MR will be re-created.

In order to reduce excessive memory mapping cost in live migration,
it is desirable to decouple the vhost-vdpa IOTLB abstraction from
the virtio device life cycle, i.e. mappings can be kept around intact
across virtio device reset. Leverage the .reset_map callback, which
is meant to destroy the regular MR on the given ASID and recreate the
initial DMA mapping. That way, the device .reset op can run free from
having to maintain and clean up memory mappings by itself.

The cvq mapping also needs to be cleared if is in the given ASID.

Co-developed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 17 +++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 18 +++++++++++++-----
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index db988ced5a5d..84547d998bcf 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -127,6 +127,7 @@ int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
 				struct vhost_iotlb *iotlb,
 				unsigned int asid);
 int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev);
+int mlx5_vdpa_reset_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
 
 #define mlx5_vdpa_warn(__dev, format, ...)                                                         \
 	dev_warn((__dev)->mdev->device, "%s:%d:(pid %d) warning: " format, __func__, __LINE__,     \
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 66530e28f327..2197c46e563a 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -645,3 +645,20 @@ int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev)
 
 	return mlx5_vdpa_update_cvq_iotlb(mvdev, NULL, 0);
 }
+
+int mlx5_vdpa_reset_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+{
+	if (asid >= MLX5_VDPA_NUM_AS)
+		return -EINVAL;
+
+	mlx5_vdpa_destroy_mr(mvdev, mvdev->mr[asid]);
+
+	if (asid == 0 && MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
+		if (mlx5_vdpa_create_dma_mr(mvdev))
+			mlx5_vdpa_warn(mvdev, "create DMA MR failed\n");
+	} else {
+		mlx5_vdpa_update_cvq_iotlb(mvdev, NULL, asid);
+	}
+
+	return 0;
+}
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 6abe02310f2b..928e71bc5571 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2838,7 +2838,6 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	unregister_link_notifier(ndev);
 	teardown_driver(ndev);
 	clear_vqs_ready(ndev);
-	mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->mvdev.suspended = false;
 	ndev->cur_num_vqs = 0;
@@ -2849,10 +2848,6 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	init_group_to_asid_map(mvdev);
 	++mvdev->generation;
 
-	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
-		if (mlx5_vdpa_create_dma_mr(mvdev))
-			mlx5_vdpa_warn(mvdev, "create MR failed\n");
-	}
 	up_write(&ndev->reslock);
 
 	return 0;
@@ -2932,6 +2927,18 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
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
@@ -3199,6 +3206,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_config = mlx5_vdpa_set_config,
 	.get_generation = mlx5_vdpa_get_generation,
 	.set_map = mlx5_vdpa_set_map,
+	.reset_map = mlx5_vdpa_reset_map,
 	.set_group_asid = mlx5_set_group_asid,
 	.get_vq_dma_dev = mlx5_get_vq_dma_dev,
 	.free = mlx5_vdpa_free,
-- 
2.39.3

