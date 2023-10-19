Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4557CED4B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjJSBNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjJSBNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:13:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76E413E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:13:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIoxPl012584;
        Thu, 19 Oct 2023 01:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=uCLg4h3OhGVR2dAL7DV7TetiR50RwE+jQHhbu4th8Aw=;
 b=g31CCEf/47QmT9Nf8H9NE1tMPsXFw1u5UAsqVTZrZBKRHsZldozLeTWExRnrfk7zCKVU
 MMIGKwkDUROqZ9qZZtrzWXTk9ljqY1bM0JUsSHbjtsnFtOPHK1f1nBN1DvFV82r0yqb/
 P/AaH4fdXgjpklxGMJ31m6RsacGH4+HSINkiBlEoQY+LAqPxOqQI2ZWXaBlojd0RIbL0
 tNmZu3uiRhy8Ctry7GPQ4JJS64+MxqLznnyBZDSCkfLfNtH0K7I4jYerR9zjuNctZhTO
 o1OjCSWpCApxKdkhMQIre63oycs/A5r6DKWIrAFv8T/PlC6srI/aQyQg9CR/TrewOi+z cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3js5a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 01:13:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J0UpS3015251;
        Thu, 19 Oct 2023 01:12:59 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3trg1h8w2d-5;
        Thu, 19 Oct 2023 01:12:59 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        sgarzare@redhat.com, dtatulea@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] vdpa/mlx5: implement .reset_map driver op
Date:   Wed, 18 Oct 2023 18:10:17 -0700
Message-Id: <1697677818-11371-5-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697677818-11371-1-git-send-email-si-wei.liu@oracle.com>
References: <1697677818-11371-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_01,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190007
X-Proofpoint-GUID: rMP4d_YVdx43I2M_oAzCMnb7X2CLmUNC
X-Proofpoint-ORIG-GUID: rMP4d_YVdx43I2M_oAzCMnb7X2CLmUNC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
is meant to destroy the regular MR (including cvq mapping) on the
given ASID and recreate the initial DMA mapping. That way, the device
.reset op runs free from having to maintain and clean up memory
mappings by itself.

Add a module paramemter, persist_mapping, to cater for older userspace
which may wish to see mapping to be cleared during reset.

Co-developed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 17 +++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 26 ++++++++++++++++++++++++--
 3 files changed, 42 insertions(+), 2 deletions(-)

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
index f4516a2d5bb0..e809ccec6048 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -25,6 +25,11 @@ MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox VDPA driver");
 MODULE_LICENSE("Dual BSD/GPL");
 
+static bool persist_mapping = true;
+module_param(persist_mapping, bool, 0444);
+MODULE_PARM_DESC(persist_mapping,
+		 "Enable/disable persistent mapping across reset: 1 to keep, 0 to clear");
+
 #define VALID_FEATURES_MASK                                                                        \
 	(BIT_ULL(VIRTIO_NET_F_CSUM) | BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |                                   \
 	 BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT_ULL(VIRTIO_NET_F_MTU) | BIT_ULL(VIRTIO_NET_F_MAC) |   \
@@ -2888,7 +2893,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	unregister_link_notifier(ndev);
 	teardown_driver(ndev);
 	clear_vqs_ready(ndev);
-	mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
+	if (unlikely(!persist_mapping))
+		mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->mvdev.suspended = false;
 	ndev->cur_num_vqs = 0;
@@ -2899,7 +2905,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	init_group_to_asid_map(mvdev);
 	++mvdev->generation;
 
-	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
+	if (unlikely(!persist_mapping) && MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
 		if (mlx5_vdpa_create_dma_mr(mvdev))
 			mlx5_vdpa_warn(mvdev, "create MR failed\n");
 	}
@@ -2987,6 +2993,18 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
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
@@ -3255,6 +3273,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_config = mlx5_vdpa_set_config,
 	.get_generation = mlx5_vdpa_get_generation,
 	.set_map = mlx5_vdpa_set_map,
+	.reset_map = mlx5_vdpa_reset_map, /* Op disabled on !persist_mapping */
 	.set_group_asid = mlx5_set_group_asid,
 	.get_vq_dma_dev = mlx5_get_vq_dma_dev,
 	.free = mlx5_vdpa_free,
@@ -3630,6 +3649,9 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 	if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, desc_group_mkey_supported))
 		mgtdev->vdpa_ops.get_vq_desc_group = NULL;
 
+	if (unlikely(!persist_mapping))
+		mgtdev->vdpa_ops.reset_map = NULL;
+
 	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);
 	if (err)
 		goto reg_err;
-- 
2.39.3

