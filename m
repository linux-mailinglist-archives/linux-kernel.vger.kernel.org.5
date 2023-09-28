Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561E97B22F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjI1Quz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjI1Qud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:50:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6110D9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xw42mUSJNNgVYQ/bi01EsfU7A8j4TKqbyiuEnlYHnYTlu0EZ3duGNA9QJiLlISEixziF+2VtJzt5GRjBxq2+Y157WqkxiOWSZm75HwgJjgYydRy3fBZOgTKymgcjAfAEjLZL/DxZMlfGP4StWwAMAtgzuKPCFBH4nehHfiKTjJ4FkZW76TNOm2LDKPKzzGoQjWj+h+KC2JsGiafGzwyyoduz/ReptUXnuIzMe90qCUmA1qNuVYHguDilCZnekCCvDx8Z/RLbcgigeM5FZEl+nyqVeVX5WbfxySlZP26BS4MUNNd9SC8uHp/S1zmUFJQukAVFlqi51L5Q3WslhP2Inw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxT2lbBZR73KweaHMkpPsjB3qleSM5PAGG5aYNlriAY=;
 b=DaMlR5yyhw3WXMtjejVAm9C2cx5ftyA5GoAjERKze4Ju+7Nm0Z7vF6Y2sjhKUHrndykTGHCe+dXHTSuW8jRNsHAnaRI2L88fnDPpzWjlR1uZfLH1OLGkNxgcqOX7XbxGctKpwgawpe9sU5qqleAn3mk8kk/ncNpW42kFiEdV/sY5ZoErnx0F5t+z+fuoziA59aLPsMui42VTwKi5RCArh7IClX5bM1lxtEyBYb0b2jryC5BQSdeQZKERgiPYdnIv3B7UbGbz0IoxkhhuXIpl4eXYdAdTvLj2V1XHWVHm3kIehV/U3Jw5WUy1EQ6+ItC2GUGOwMgQTQ98bOwsn7At8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxT2lbBZR73KweaHMkpPsjB3qleSM5PAGG5aYNlriAY=;
 b=ihvYW9iv+2FhQqNyOPkQCjkWkX/cg4e1CnLoUw/CDwH1ykldy5dhE13t7De46Wa+Uic6Qhdtm3e+te9EDvhnJq8tmncG2fHTydyx5EoaOTB0jwYkvK3htsltJxvXkfdUsRpiMQr2xoIsxjP+YLdT7Ltg87LirzzZxqNB8b36Kz7HHcnOo7vR2MU3ovKMrJ1MlwqVZ+UgtMfunduTtGHsQyxToTA7Dtb8dOR/MjsMNMiaNNlKKytLbCJUW4JRxlaScVYpMv5+xuNF6EM08xZ+SWy7YsktewNwHCdhPlWVyiyRgyOM66pUJ9+/eBmZMKLT0CyXMrOuHCzDHVPG/2mEzA==
Received: from MW4P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::24)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.35; Thu, 28 Sep
 2023 16:50:14 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::d1) by MW4P223CA0019.outlook.office365.com
 (2603:10b6:303:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9 via Frontend Transport; Thu, 28 Sep 2023 16:50:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:50:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:50:04 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:50:02 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     <eperezma@redhat.com>, <gal@nvidia.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     <virtualization@lists.linux-foundation.org>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 13/16] vdpa/mlx5: Introduce mr for vq descriptor
Date:   Thu, 28 Sep 2023 19:45:24 +0300
Message-ID: <20230928164550.980832-15-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ecf0c06-e719-424a-38b0-08dbc042fce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGfB6kt+n/NBuZZrqQxjQTV1vO90NXoCMEG8REVsg04Pwa23K3yV3SgJ3LfpNBKgTCFauyphR7QIuUnINjWo8YDc67lKTGkny9czrOAKvKEajQ877o808vRIDRcj/4lOiQfITbeG4hajaLi6oicSnI/hK9r1C+6LHELS1ysNo/CdCtANFodqq6UW2nQRGEO99u5yJN4WrOGHS59UOjmOmusY81eF524jwSOsGheKtHRoOz9QFywOdE91ts3EOy0zu3Ei2Heb9J4blc1+7xKIzQFWqgHT3dulAWz/7ir5CORfR+bzO4pcrmsDBzgHcZDkb/LFBPbKzhDFRO/WiQe9WqaU4wOZnNlo9W8+yEyvK6/4UvotTrn9QKo+X0hrgzOZbXRPUK4sRoPakNmsBLeRhRUMmho0Nxca/jBZjgxVfOwS+HH6HUSCwZfoSKF5h2xrBsmaqx1LTn5kt0eZ4KI86ksBEGrh4kPOW+Y+ozUXjbf2Qf2Ej7oE4R8ugxpBCMRot615gDiSVwZrZLCo9qhKnjmQBmccKaKipwTPIY9PdjeXP8avDt/DIpwdmNATOl9OQvVTLd2OzDqrDtJ/lOBV7B0W3S/07TyV8JocNGUVkE0RqW2q27rYluazYVyUvHJLn0X7hIP2ara5l/6vCgqqVdfGE7vO9WsOjzZUIMk5y7QPRQe59l1c6U+yzieuMhiKTk3UBpUVjw72rFM2g5KWxMowCjQ4Zej/qQkxao4nYAY=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(82310400011)(1800799009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(6666004)(478600001)(426003)(336012)(83380400001)(2616005)(26005)(1076003)(2906002)(41300700001)(8936002)(5660300002)(70586007)(316002)(70206006)(54906003)(4326008)(8676002)(110136005)(36756003)(36860700001)(47076005)(356005)(7636003)(86362001)(82740400003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:50:14.5269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecf0c06-e719-424a-38b0-08dbc042fce1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the vq descriptor group and ASID 1. Until now .set_map on ASID
1 was only updating the cvq iotlb. From now on it also creates a mkey
for it. The current patch doesn't use it but follow-up patches will
add hardware support for mapping the vq descriptors.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  5 +++--
 drivers/vdpa/mlx5/core/mr.c        | 14 +++++++++-----
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 20 +++++++++++++-------
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index bbe4335106bd..ae09296f4270 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -70,11 +70,12 @@ struct mlx5_vdpa_wq_ent {
 enum {
 	MLX5_VDPA_DATAVQ_GROUP,
 	MLX5_VDPA_CVQ_GROUP,
+	MLX5_VDPA_DATAVQ_DESC_GROUP,
 	MLX5_VDPA_NUMVQ_GROUPS
 };
 
 enum {
-	MLX5_VDPA_NUM_AS = MLX5_VDPA_NUMVQ_GROUPS
+	MLX5_VDPA_NUM_AS = 2
 };
 
 struct mlx5_vdpa_dev {
@@ -89,7 +90,7 @@ struct mlx5_vdpa_dev {
 	u16 max_idx;
 	u32 generation;
 
-	struct mlx5_vdpa_mr *mr;
+	struct mlx5_vdpa_mr *mr[MLX5_VDPA_NUM_AS];
 	/* serialize mr access */
 	struct mutex mr_mtx;
 	struct mlx5_control_vq cvq;
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 00eff5a07152..3dee6d9bed6b 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -511,8 +511,10 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
 
 	_mlx5_vdpa_destroy_mr(mvdev, mr);
 
-	if (mvdev->mr == mr)
-		mvdev->mr = NULL;
+	for (int i = 0; i < MLX5_VDPA_NUM_AS; i++) {
+		if (mvdev->mr[i] == mr)
+			mvdev->mr[i] = NULL;
+	}
 
 	mutex_unlock(&mvdev->mr_mtx);
 
@@ -523,11 +525,11 @@ void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev,
 			 struct mlx5_vdpa_mr *new_mr,
 			 unsigned int asid)
 {
-	struct mlx5_vdpa_mr *old_mr = mvdev->mr;
+	struct mlx5_vdpa_mr *old_mr = mvdev->mr[asid];
 
 	mutex_lock(&mvdev->mr_mtx);
 
-	mvdev->mr = new_mr;
+	mvdev->mr[asid] = new_mr;
 	if (old_mr) {
 		_mlx5_vdpa_destroy_mr(mvdev, old_mr);
 		kfree(old_mr);
@@ -539,7 +541,9 @@ void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev,
 
 void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
 {
-	mlx5_vdpa_destroy_mr(mvdev, mvdev->mr);
+	for (int i = 0; i < MLX5_VDPA_NUM_AS; i++)
+		mlx5_vdpa_destroy_mr(mvdev, mvdev->mr[i]);
+
 	prune_iotlb(mvdev);
 }
 
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 4a87f9119fca..25bd2c324f5b 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -821,6 +821,8 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
 	u32 out[MLX5_ST_SZ_DW(create_virtio_net_q_out)] = {};
+	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
+	struct mlx5_vdpa_mr *vq_mr;
 	void *obj_context;
 	u16 mlx_features;
 	void *cmd_hdr;
@@ -873,7 +875,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
 	MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr);
 	MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_addr);
-	MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, ndev->mvdev.mr->mkey);
+	vq_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
+	if (vq_mr)
+		MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->mkey);
 	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
 	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
 	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
@@ -2633,7 +2637,8 @@ static void restore_channels_info(struct mlx5_vdpa_net *ndev)
 }
 
 static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
-				struct mlx5_vdpa_mr *new_mr, unsigned int asid)
+				struct mlx5_vdpa_mr *new_mr,
+				unsigned int asid)
 {
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	int err;
@@ -2652,8 +2657,10 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 
 	restore_channels_info(ndev);
 	err = setup_driver(mvdev);
+	if (err)
+		return err;
 
-	return err;
+	return 0;
 }
 
 /* reslock must be held for this function */
@@ -2869,8 +2876,8 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 	struct mlx5_vdpa_mr *new_mr;
 	int err;
 
-	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
-		goto end;
+	if (asid >= MLX5_VDPA_NUM_AS)
+		return -EINVAL;
 
 	new_mr = mlx5_vdpa_create_mr(mvdev, iotlb);
 	if (IS_ERR(new_mr)) {
@@ -2879,7 +2886,7 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 		return err;
 	}
 
-	if (!mvdev->mr) {
+	if (!mvdev->mr[asid]) {
 		mlx5_vdpa_update_mr(mvdev, new_mr, asid);
 	} else {
 		err = mlx5_vdpa_change_map(mvdev, new_mr, asid);
@@ -2889,7 +2896,6 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 		}
 	}
 
-end:
 	return mlx5_vdpa_update_cvq_iotlb(mvdev, iotlb, asid);
 
 out_err:
-- 
2.41.0

