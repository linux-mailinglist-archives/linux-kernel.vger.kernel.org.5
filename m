Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF21A7B22E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjI1QuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjI1Qty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:49:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC42E1A3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROC8YYVy3V8XPbi6MMBmzvJmexM3i4kMKUjUuVkkSI8zLKuCHrqR7Uzq4FHG9PanFvRFwR77ftSJ7jdeJaGp3ki8wykv1mjmSl/VgVXcHi9sPVKFyV1kpSi9/coZcXZzMQXO0/zV0V333kBwgDmuinonyisrXMOdwhWJO6uVHufcrPasevhAA5hm/b5rnB4h4q7ZJWjzshKeBrW/OSearrWeaNfGfdyBvvEg2hcD42TY84xIcOhTlN1guBy/MkezyORxh0+5TYi28I6UtaYBdzY9poliZL7Ef/yMGDa33sm/KcTN6p4eBD3YDue9kc1i8JNi7OjKY64wuI3ann5fTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k7vZDkq8HIAIRoAeeLZ+cqnJ3LV329QdGvZjtWRFo4=;
 b=iS5Q1DIfsN0bjsm1v35ekfry3RVWfRMhn8BLaZp2I3rwFsMWXZXryxWflAkmuJEUhiQJzXBDc3g+nwB/2GH7nHszbsFgrVTSr+CSvyKhYKopuN9tED6hJJwc5fT1MAyL/3u7PSQkW63+XcfBUkSNOHIOKpcRWKcaUhq6M5r+hEWpEQzraf/SVAF0qvptpowbXrbfEdBfW/S11NV59uZWFjwh3FZE6RUbLD3cWbJf5H8Vp8r4Z5cMvKw2WBb0uFVsG6w9M2N212p4wlR6D0oxKPFZ1xI7SVh2tUuLI7pr1+kgMzConzJ6YW7TioQLVfwfxz4Xhs8XBcVpm9d0coyDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k7vZDkq8HIAIRoAeeLZ+cqnJ3LV329QdGvZjtWRFo4=;
 b=Nb0CTbILKnOWIZ9V2U19RVsBEKNqwlGeP787rjibv+YVcXPzdv7QGaj47oXCOuJMDEQapyGAxdF35xfG6Zh0D2mRb4o0sD91DBCa2rr59rhNSfo3c1bCzStHGwiWIpffBLYpPCMJgaiP84fOCI0TieVZkBJMHR/VA8E5XvnCRDrWgFl++jy8dUsTYvIOwrjca9c40X8UfiMepRETSIiGHj698pxjDQwY2RC0PqzvZx37PUny1MZwC3n1g4FSvc4sfK0ipE3lk0ixHFJX3S8Bm/VxOYxSO5L7gK2l+6XVU92BRN0XcJ203acji2DcZoxofCcE+56jJVg7ydx2BMORqA==
Received: from CY5PR15CA0100.namprd15.prod.outlook.com (2603:10b6:930:7::20)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 16:49:48 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::10) by CY5PR15CA0100.outlook.office365.com
 (2603:10b6:930:7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.19 via Frontend Transport; Thu, 28 Sep 2023 16:49:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:49:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:49:40 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:49:38 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     <eperezma@redhat.com>, <gal@nvidia.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     <virtualization@lists.linux-foundation.org>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 05/16] vdpa/mlx5: Create helper function for dma mappings
Date:   Thu, 28 Sep 2023 19:45:16 +0300
Message-ID: <20230928164550.980832-7-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d590aa-c920-40b0-f163-08dbc042ecfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/EyXN0uODAIzxJckL/PfSBec4e/irrVH4zNspuRSowCxdefpCeT+kowxMJ3qZrxdro/HaJz73dodKJXa8fYhsavtIbUSuIuwTWwIMTwMsYBeZOJg96NKReic407pqIrkN4kTmRVmh3mlKKGz6KfbsHUbIG9fCUbIZHa3EaYttG+/iS9h8IDYPKHMXdyfs5uVr7A2KPd5zh/P2SAvQjAhqoJnSb+G9n3f1JUZUCQG0N5+3MBVKWUIjACu2L1/EAU+IMBKOEZXoYZFHpXR+q7qwj+nT5e1OS0MnMAiQuMclb6LbnIO9Fo6m/oiRd4GHAMnp9oVJM7bQvY2yPCF093OPeUunJ2APbUcH81T5ZNTjWu+bV5gs/ISpyzSjSdreB4MJ18DDmkgWmiCmH+YTyv2BU0vE7V25wVrCXSj8SL18PN6xFiTk+4FntTiTUyZkj213BDTIds1fneGx4tJ5/DWE05IS99tDFHwr43YEbW1o6/B3oEwdULd4tBXlaDsVZ6ZKTS4t/Zaohklp3bffFpils1suw5+dUm3erC12k1LS/9BfvlmV7LcAlyb7CPD/LEDXLPw9qDE8At2smehoY3FEkP+8/JqbZkLMaZzBlvMG8gVb9lwLksVjbLZGKgVYnY+qiD9kFTf/gzXLB6N7n4rTqjOpMZr9CXhfwxCUKxqS/qWE4xOG/4TE1n+TgHMav8F9FrBmFcJPEehHse9Z2pQTmqJsBhVuM7Y11BHqQCt2Y=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(4326008)(1076003)(70586007)(110136005)(70206006)(36860700001)(26005)(47076005)(8676002)(5660300002)(8936002)(2906002)(41300700001)(40480700001)(426003)(336012)(478600001)(6666004)(54906003)(40460700003)(82740400003)(36756003)(7636003)(356005)(2616005)(83380400001)(316002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:49:47.8337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d590aa-c920-40b0-f163-08dbc042ecfc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Necessary for upcoming cvq separation from mr allocation.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
 drivers/vdpa/mlx5/core/mr.c        | 5 +++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 4 ++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index ca56242972b3..3748f027cfe9 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -120,6 +120,7 @@ int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 			unsigned int asid);
 void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
 void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
+int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev);
 
 #define mlx5_vdpa_warn(__dev, format, ...)                                                         \
 	dev_warn((__dev)->mdev->device, "%s:%d:(pid %d) warning: " format, __func__, __LINE__,     \
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 5a1971fcd87b..7bd0883b8b25 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -619,3 +619,8 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
 
 	return err;
 }
+
+int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev)
+{
+	return mlx5_vdpa_create_mr(mvdev, NULL, 0);
+}
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 40a03b08d7cf..65b6a54ad344 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2836,7 +2836,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	++mvdev->generation;
 
 	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
-		if (mlx5_vdpa_create_mr(mvdev, NULL, 0))
+		if (mlx5_vdpa_create_dma_mr(mvdev))
 			mlx5_vdpa_warn(mvdev, "create MR failed\n");
 	}
 	up_write(&ndev->reslock);
@@ -3441,7 +3441,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		goto err_mpfs;
 
 	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
-		err = mlx5_vdpa_create_mr(mvdev, NULL, 0);
+		err = mlx5_vdpa_create_dma_mr(mvdev);
 		if (err)
 			goto err_res;
 	}
-- 
2.41.0

