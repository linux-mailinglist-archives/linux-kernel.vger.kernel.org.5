Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AB97B22E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjI1QuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjI1QuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:50:03 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E7ECFF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAGprFBk7gIsbgeslXqe4TpTVWGslgFkoV3zL/bNtbIXUGZDpPbf99VgNZ7/L2g0Z4dt33dwkmqGOFHsLYI3W+8QK168VWT28CpJs6jphxGIYiXwCKKZx2GlwxH048WzEa+m1xEumBiFe4DfRR3na+QBJkETlugKhmfTv13ePXO1Ps8Orgv/JbEZJKNt94KB4GJAEveGThKsvM+Nq/Jct8qMn/yyuFBNDIAro6AJxlzl51IN9ohOnAlBgqt267W2CNGmeAhVqZWYdcbXbnNrJ5qZl1hD/pH8m3u8IOX2I3n7CTNdauSZGJZf5FcP2eISK+dxX1unxc/llzVSO4IlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN7TV4u8UPdAnQNWvbOBZvrtM3lU/XqKcHUxqYYSho4=;
 b=O8RWE98dqA9mgwk4yz3x6glW9iVeEXyrGnMNzhaidw7kM15NTuMNfG22mXRMzxNQnDPwn5tWcT/zpQCHjw0yMxRCkmKXWHGulB9SmbOaWSaHedCyueCMyjRCVZrsGPhOm0pp7r6z87Nv4A7M9ASKkq6FYT/l6MbijNKrNlbxe++INkLSEnSfQjSZLiGsA9RCiHcT7nXv2lKEK+W5e7Pftvd/QkWVbnBRZgEtTC9Tw0QRFjWqgPygn6Y107WQPFQickR2BKnAe28TinLtKRFkphOIFm+aD5SrMvpW4AunOom9WpQqoGnvZ1IydlF0p5NuNLXZhmvxYOgn++rHz3yjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN7TV4u8UPdAnQNWvbOBZvrtM3lU/XqKcHUxqYYSho4=;
 b=nMSevCR5aDBbEgr/MlCByHxD2sVgptoDNK8Tf8I28Ozu0N904Zoe+ZzIwN1juEo48PWiVSO1lxICrxAQ6m8CziWJogPFr0vq6yvbuPaVPLczIhE2bvo6P68/rgjXsY7GRq3OFVQQKXDniXhKQMkyfJlAvvPe/jcxWKJJzPgsz/Yhc+Jb8y1l8M4ckzJzoeATsOE2MJX+kLuG/Pd/l38D8gJQfXTV5ZU2fu3P84rUgVUoNYbFFjTTuzizzajOp76XIZNbQ4nvurj6K+z8woEe3NHl5+Uyu/bXA/qFXgjh6bqgUhXvdBTPMDxQWRK8d9PG/tkckT9ybEA9RynQ8YoqhQ==
Received: from MW3PR06CA0001.namprd06.prod.outlook.com (2603:10b6:303:2a::6)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 16:49:55 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:2a:cafe::47) by MW3PR06CA0001.outlook.office365.com
 (2603:10b6:303:2a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24 via Frontend
 Transport; Thu, 28 Sep 2023 16:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9 via Frontend Transport; Thu, 28 Sep 2023 16:49:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:49:43 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:49:43 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:49:41 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     <eperezma@redhat.com>, <gal@nvidia.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     <virtualization@lists.linux-foundation.org>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 06/16] vdpa/mlx5: Decouple cvq iotlb handling from hw mapping code
Date:   Thu, 28 Sep 2023 19:45:17 +0300
Message-ID: <20230928164550.980832-8-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BL1PR12MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f56862-56c1-4a22-2a92-08dbc042f11c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kt58hLNfr1uvXayMAhZ/vbKcOrLp+xjUPb64DJ7aDEWBDLnHsepY+UZ2PGaHUwg5HRQQ6vDxRyk7btCN3Wjn7lIyBKqsd8eR7XsqCm+CMkZu/3i6n93fd8EuN5/0KtM19ZCC6lLTHnIrPDuyLK7HXTdw9A3J+VqR2LtNsTJpWNcjNojUZNYy16rDXHscVL5Sffzx/bfVj2FDcf2aiA/m4rCVn63+4B55kUHf34lAbcdPsG0nnu4eylnFei33pgMPHHqqez1drp/3aFvGRvKRkc6KGkZE+ZLYtSLnpc+plfE3U3Ck4TpxgttDiygHUPhF7sy0kUmGEvRXw/wa4TjoMokLD12jFEJ7b9ARBQ8l56fB9WtwPQXSko77dHgimlpVuePKfj9zy6nm8GO/iyio7blQPOCKi+M3lp8dYB55grx8ERfKYCzfFksBaoXKrybGRQcnqY2hWD/YT+BEIg2w6tGco67AK5Ou3dAywmHqvIUgEAXTpzMqPvDBYqkfdmJrFaMATFqwSTT9EaVksmY2ktEnyxN+URrUvSL8PBTVQUxbJsQ2A8hfKbs4COadOnm6CYCN6UIZxcj/f6VduryXGCN4SzdakpT82rVjm/665K7hUHFt7VxiVx597Z+EPcAW67dI2hx7StjKlSSYlcZcei8syORp6N1+aqSkIrBijmQxASlaEcEuBsRZjJr2UjsjaH9Bmuapu7W63WBuw5XDyB9umcIHaP3gd1TkS7t8eAA=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(1800799009)(82310400011)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(2616005)(6666004)(478600001)(336012)(426003)(26005)(316002)(1076003)(83380400001)(41300700001)(110136005)(5660300002)(70206006)(70586007)(4326008)(8676002)(8936002)(54906003)(36756003)(2906002)(36860700001)(47076005)(86362001)(7636003)(356005)(82740400003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:49:54.7024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f56862-56c1-4a22-2a92-08dbc042f11c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handling of the cvq iotlb is currently coupled with the creation
and destruction of the hardware mkeys (mr).

This patch moves cvq iotlb handling into its own function and shifts it
to a scope that is not related to mr handling. As cvq handling is just a
prune_iotlb + dup_iotlb cycle, put it all in the same "update" function.
Finally, the destruction path is handled by directly pruning the iotlb.

After this move is done the ASID mr code can be collapsed into a single
function.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  3 ++
 drivers/vdpa/mlx5/core/mr.c        | 57 +++++++++++-------------------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  |  7 ++--
 3 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 3748f027cfe9..554899a80241 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -120,6 +120,9 @@ int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 			unsigned int asid);
 void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
 void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
+int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
+				struct vhost_iotlb *iotlb,
+				unsigned int asid);
 int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev);
 
 #define mlx5_vdpa_warn(__dev, format, ...)                                                         \
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 7bd0883b8b25..fcb6ae32e9ed 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -489,14 +489,6 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr
 	}
 }
 
-static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
-{
-	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
-		return;
-
-	prune_iotlb(mvdev);
-}
-
 static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
@@ -522,25 +514,14 @@ void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
 	mutex_lock(&mr->mkey_mtx);
 
 	_mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
-	_mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
 
 	mutex_unlock(&mr->mkey_mtx);
 }
 
 void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
 {
-	mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_CVQ_GROUP]);
 	mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]);
-}
-
-static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
-				    struct vhost_iotlb *iotlb,
-				    unsigned int asid)
-{
-	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
-		return 0;
-
-	return dup_iotlb(mvdev, iotlb);
+	prune_iotlb(mvdev);
 }
 
 static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
@@ -572,22 +553,7 @@ static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
 static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
 				struct vhost_iotlb *iotlb, unsigned int asid)
 {
-	int err;
-
-	err = _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
-	if (err)
-		return err;
-
-	err = _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
-	if (err)
-		goto out_err;
-
-	return 0;
-
-out_err:
-	_mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
-
-	return err;
+	return _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
 }
 
 int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
@@ -620,7 +586,24 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
 	return err;
 }
 
+int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
+				struct vhost_iotlb *iotlb,
+				unsigned int asid)
+{
+	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
+		return 0;
+
+	prune_iotlb(mvdev);
+	return dup_iotlb(mvdev, iotlb);
+}
+
 int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev)
 {
-	return mlx5_vdpa_create_mr(mvdev, NULL, 0);
+	int err;
+
+	err = mlx5_vdpa_create_mr(mvdev, NULL, 0);
+	if (err)
+		return err;
+
+	return mlx5_vdpa_update_cvq_iotlb(mvdev, NULL, 0);
 }
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 65b6a54ad344..aa4896662699 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2884,10 +2884,13 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 		return err;
 	}
 
-	if (change_map)
+	if (change_map) {
 		err = mlx5_vdpa_change_map(mvdev, iotlb, asid);
+		if (err)
+			return err;
+	}
 
-	return err;
+	return mlx5_vdpa_update_cvq_iotlb(mvdev, iotlb, asid);
 }
 
 static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
-- 
2.41.0

