Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1F17B22EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjI1Quo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjI1QuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:50:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9FC10FE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/l+9K8LvaoNXa39odT++g3nvrsV22QC/feAI65h2Z6BbbMdu+vYttBu5fpcXvBAOMj8/bmuG3iUW1dlmiO4eFtQQs54lVk2SLjfDmMkXkTmVQIoPIrcTmo22CARgkN/KXg1xb2HQEOuIWkYbRUjoshcBZBl59TCskGYZCEOEuy/2eAT6HQ2WKz7VQgRNI9YJO9pF6esjB9eEKn+20GvYHSvgAK7ORj5HGoFzG9o7l7T5IyIAqxJPCAAp0VMVPYByMuGg7sfDG24F8n85m1wQtEDTay0C4zJI48TkrTN0s8GO7y/3VsHDDn+udSVeLexUEtnQkn12SpDwZqplMKNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2mTBNgSWLtaFjwqt2Roqjc72lDAUiHhmvP2L+fzVOU=;
 b=LGExCxPgfyrY/hZVlkXn5Xh7MfiZsrWBiJ7ZCtCCYQLSKzWYza0eZhwTlmYEasjTpawoqPd5zq0s7LeZ7qkAyCMgo6B59plQ7ePe4To+cp8ob+lyIV4OSIHf68hQb1OkMlihDU9gKhCHFzYVmmalUfhvMTeaNY4JeOrDDJ7vbDP3WwWLypOYkv1LXg3fKZzJzjrr3Vgvk4ko+4lkcgqdb5v33ZykCaM43HI/THzBgWVOjp+vby3T6d3EAUU4XcFFT2Lm9MV/FVoX0mYB22c/gi4TTrHNP9M/t5ynw9foD2zQi+VUU1HNj0oz4l7bZpgXjD8ZE7Cexe2ERlK+hNY8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2mTBNgSWLtaFjwqt2Roqjc72lDAUiHhmvP2L+fzVOU=;
 b=cajw7OMGyJcw8Egp8GFuBj+K45Xlrw9CMTNjxVF7wjMNvpL9V2PIScbIC8w9aGEy2inbleDNzrJ0VKpeSbAJjC/8EK+5VR+w8Kinl5YgibPRYMCgnHtuCAjiX/nSohKX7msWCDZ3YM7fuskyBs4fH9P+Q5xbPiJb5bEkttfixE7WK2F3Rp/EDWPCJHm7Ph4WDya/r2dpDx9Br3+AYTZUqIfanDaMCs4MdXKFTHnU1ArxXyXtFvjCrcwuRhyK6ztOSm5i3GjaY0l/BNZhX2wHVxjmPY322kaI9Z4O0z4SDkQ0SUb1/ylwpZgYT1oXLeu+fufaNf4zpTLkpukeQ6eD7A==
Received: from CY5PR15CA0114.namprd15.prod.outlook.com (2603:10b6:930:7::28)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 16:50:06 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::19) by CY5PR15CA0114.outlook.office365.com
 (2603:10b6:930:7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.19 via Frontend Transport; Thu, 28 Sep 2023 16:50:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:50:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:50:01 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:49:59 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     <eperezma@redhat.com>, <gal@nvidia.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     <virtualization@lists.linux-foundation.org>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 12/16] vdpa/mlx5: Improve mr update flow
Date:   Thu, 28 Sep 2023 19:45:23 +0300
Message-ID: <20230928164550.980832-14-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: b9abee80-1ca4-40df-4775-08dbc042f838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNrjvrGhpT/gMATDE0GN9mANWhx5b2aIejWVHDFTm3I0Xe2FPFc0hhLd/IDNo50OusdaDiJ4VakyN4krypz50RsEAKEL+h5i0CMgaczWc6WGer5q5LWUtxDPliteFNNC1a14TSeF1XmJ6qST3uvO2AXjnqTOU4wIq4qYMnTXjQcILybs5cgKr4JUA5iSDnAMAu+gR6T7NpVRWYu0BLYzGzVwpRR4pVIg4vzSlxtMuI7MIDITS5beqcusKpZGIrSGeOgAkILapjhxZXbkrtkcihqEq7QlfPf++pDYTpQxOSX0xhRGea1IlyWYwb1Fsv0qofx9pEXkqHh1gNlTNhoReNbxrwyHsn6xPrdZHfk8q4tx+B8qaBSlukwKfLgvolUM5XCWOWXmDEEAwZLi79YcY2kA3YInJtLnA+K8A2rt6IIZv5TrnARUT7kad06V9BEg5xfYPBFQeB6GhtHUa0mpre1dabEI5nq8QVnL4CZoJjH3dE62tmA6dq2Wau9YxF96cGt6bPWGnWLtKtY98H2Q4tVNftbYEZBHPVc/EymQBSllDFJZVuBO9apOEOxjhDjMdFXUAebV54UfRl0ReoVcrHasvr0uYbXm5781nK0yBcn//01Kg0n6OWMJXXdWcKgK7XNyc5Q+UoWVp4CtDHteo1XikozE41483zjQ0BAfTwd7YD8AkYhVgzSmC+jLCVtHOEFjcr94qFIWKLKtogwuWOTkcXmDeaSFg/2tWLf33X3gx8vUuZwWekqdPitok0ZuLNBm3HR4XnpwhIoi8Ilmig==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(6666004)(2616005)(1076003)(478600001)(86362001)(70586007)(110136005)(54906003)(70206006)(83380400001)(36860700001)(47076005)(426003)(336012)(26005)(82740400003)(356005)(7636003)(5660300002)(36756003)(4326008)(40480700001)(316002)(41300700001)(8936002)(15650500001)(8676002)(334744004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:50:06.6932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9abee80-1ca4-40df-4775-08dbc042f838
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current flow for updating an mr works directly on mvdev->mr which
makes it cumbersome to handle multiple new mr structs.

This patch makes the flow more straightforward by having
mlx5_vdpa_create_mr return a new mr which will update the old mr (if
any). The old mr will be deleted and unlinked from mvdev.

This change paves the way for adding mrs for different ASIDs.

The initialized bool is no longer needed as mr is now a pointer in the
mlx5_vdpa_dev struct which will be NULL when not initialized.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h | 14 +++--
 drivers/vdpa/mlx5/core/mr.c        | 87 ++++++++++++++++--------------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 46 ++++++++--------
 3 files changed, 76 insertions(+), 71 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 9c6ac42c21e1..bbe4335106bd 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -31,8 +31,6 @@ struct mlx5_vdpa_mr {
 	struct list_head head;
 	unsigned long num_directs;
 	unsigned long num_klms;
-	/* state of dvq mr */
-	bool initialized;
 
 	bool user_mr;
 };
@@ -91,7 +89,7 @@ struct mlx5_vdpa_dev {
 	u16 max_idx;
 	u32 generation;
 
-	struct mlx5_vdpa_mr mr;
+	struct mlx5_vdpa_mr *mr;
 	/* serialize mr access */
 	struct mutex mr_mtx;
 	struct mlx5_control_vq cvq;
@@ -114,14 +112,14 @@ void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *mvdev);
 int mlx5_vdpa_create_mkey(struct mlx5_vdpa_dev *mvdev, u32 *mkey, u32 *in,
 			  int inlen);
 int mlx5_vdpa_destroy_mkey(struct mlx5_vdpa_dev *mvdev, u32 mkey);
-int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
-			     bool *change_map, unsigned int asid);
-int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
-			struct mlx5_vdpa_mr *mr,
-			struct vhost_iotlb *iotlb);
+struct mlx5_vdpa_mr *mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
+					 struct vhost_iotlb *iotlb);
 void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev);
 void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
 			  struct mlx5_vdpa_mr *mr);
+void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev,
+			 struct mlx5_vdpa_mr *mr,
+			 unsigned int asid);
 int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
 				struct vhost_iotlb *iotlb,
 				unsigned int asid);
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index abd6a6fb122f..00eff5a07152 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -495,30 +495,51 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr
 
 static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
 {
-	if (!mr->initialized)
-		return;
-
 	if (mr->user_mr)
 		destroy_user_mr(mvdev, mr);
 	else
 		destroy_dma_mr(mvdev, mr);
-
-	mr->initialized = false;
 }
 
 void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
 			  struct mlx5_vdpa_mr *mr)
 {
+	if (!mr)
+		return;
+
 	mutex_lock(&mvdev->mr_mtx);
 
 	_mlx5_vdpa_destroy_mr(mvdev, mr);
 
+	if (mvdev->mr == mr)
+		mvdev->mr = NULL;
+
+	mutex_unlock(&mvdev->mr_mtx);
+
+	kfree(mr);
+}
+
+void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev,
+			 struct mlx5_vdpa_mr *new_mr,
+			 unsigned int asid)
+{
+	struct mlx5_vdpa_mr *old_mr = mvdev->mr;
+
+	mutex_lock(&mvdev->mr_mtx);
+
+	mvdev->mr = new_mr;
+	if (old_mr) {
+		_mlx5_vdpa_destroy_mr(mvdev, old_mr);
+		kfree(old_mr);
+	}
+
 	mutex_unlock(&mvdev->mr_mtx);
+
 }
 
 void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
 {
-	mlx5_vdpa_destroy_mr(mvdev, &mvdev->mr);
+	mlx5_vdpa_destroy_mr(mvdev, mvdev->mr);
 	prune_iotlb(mvdev);
 }
 
@@ -528,52 +549,36 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
 {
 	int err;
 
-	if (mr->initialized)
-		return 0;
-
 	if (iotlb)
 		err = create_user_mr(mvdev, mr, iotlb);
 	else
 		err = create_dma_mr(mvdev, mr);
 
-	if (err)
-		return err;
-
-	mr->initialized = true;
-
-	return 0;
+	return err;
 }
 
-int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
-			struct mlx5_vdpa_mr *mr,
-			struct vhost_iotlb *iotlb)
+struct mlx5_vdpa_mr *mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
+					 struct vhost_iotlb *iotlb)
 {
+	struct mlx5_vdpa_mr *mr;
 	int err;
 
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
 	mutex_lock(&mvdev->mr_mtx);
 	err = _mlx5_vdpa_create_mr(mvdev, mr, iotlb);
 	mutex_unlock(&mvdev->mr_mtx);
 
-	return err;
-}
-
-int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
-			     bool *change_map, unsigned int asid)
-{
-	struct mlx5_vdpa_mr *mr = &mvdev->mr;
-	int err = 0;
+	if (err)
+		goto out_err;
 
-	*change_map = false;
-	mutex_lock(&mvdev->mr_mtx);
-	if (mr->initialized) {
-		mlx5_vdpa_info(mvdev, "memory map update\n");
-		*change_map = true;
-	}
-	if (!*change_map)
-		err = _mlx5_vdpa_create_mr(mvdev, mr, iotlb);
-	mutex_unlock(&mvdev->mr_mtx);
+	return mr;
 
-	return err;
+out_err:
+	kfree(mr);
+	return ERR_PTR(err);
 }
 
 int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
@@ -597,11 +602,13 @@ int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
 
 int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev)
 {
-	int err;
+	struct mlx5_vdpa_mr *mr;
 
-	err = mlx5_vdpa_create_mr(mvdev, &mvdev->mr, NULL);
-	if (err)
-		return err;
+	mr = mlx5_vdpa_create_mr(mvdev, NULL);
+	if (IS_ERR(mr))
+		return PTR_ERR(mr);
+
+	mlx5_vdpa_update_mr(mvdev, mr, 0);
 
 	return mlx5_vdpa_update_cvq_iotlb(mvdev, NULL, 0);
 }
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 256fdd80c321..4a87f9119fca 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -873,7 +873,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
 	MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr);
 	MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_addr);
-	MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, ndev->mvdev.mr.mkey);
+	MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, ndev->mvdev.mr->mkey);
 	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
 	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
 	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
@@ -2633,7 +2633,7 @@ static void restore_channels_info(struct mlx5_vdpa_net *ndev)
 }
 
 static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
-				struct vhost_iotlb *iotlb, unsigned int asid)
+				struct mlx5_vdpa_mr *new_mr, unsigned int asid)
 {
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	int err;
@@ -2641,27 +2641,18 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 	suspend_vqs(ndev);
 	err = save_channels_info(ndev);
 	if (err)
-		goto err_mr;
+		return err;
 
 	teardown_driver(ndev);
-	mlx5_vdpa_destroy_mr(mvdev, &mvdev->mr);
-	err = mlx5_vdpa_create_mr(mvdev, &mvdev->mr, iotlb);
-	if (err)
-		goto err_mr;
+
+	mlx5_vdpa_update_mr(mvdev, new_mr, asid);
 
 	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || mvdev->suspended)
-		goto err_mr;
+		return 0;
 
 	restore_channels_info(ndev);
 	err = setup_driver(mvdev);
-	if (err)
-		goto err_setup;
-
-	return 0;
 
-err_setup:
-	mlx5_vdpa_destroy_mr(mvdev, &mvdev->mr);
-err_mr:
 	return err;
 }
 
@@ -2875,26 +2866,35 @@ static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
 static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 			unsigned int asid)
 {
-	bool change_map;
+	struct mlx5_vdpa_mr *new_mr;
 	int err;
 
 	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
 		goto end;
 
-	err = mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map, asid);
-	if (err) {
-		mlx5_vdpa_warn(mvdev, "set map failed(%d)\n", err);
+	new_mr = mlx5_vdpa_create_mr(mvdev, iotlb);
+	if (IS_ERR(new_mr)) {
+		err = PTR_ERR(new_mr);
+		mlx5_vdpa_warn(mvdev, "create map failed(%d)\n", err);
 		return err;
 	}
 
-	if (change_map) {
-		err = mlx5_vdpa_change_map(mvdev, iotlb, asid);
-		if (err)
-			return err;
+	if (!mvdev->mr) {
+		mlx5_vdpa_update_mr(mvdev, new_mr, asid);
+	} else {
+		err = mlx5_vdpa_change_map(mvdev, new_mr, asid);
+		if (err) {
+			mlx5_vdpa_warn(mvdev, "change map failed(%d)\n", err);
+			goto out_err;
+		}
 	}
 
 end:
 	return mlx5_vdpa_update_cvq_iotlb(mvdev, iotlb, asid);
+
+out_err:
+	mlx5_vdpa_destroy_mr(mvdev, new_mr);
+	return err;
 }
 
 static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
-- 
2.41.0

