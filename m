Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A6D7B22F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjI1QvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjI1Quu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:50:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD63BBF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgWpIvUBTyxteUWy+VA6NKTDWCYwwp1creD3HKqStyUiVGfPj6e1DAq2VV8zncZ9+7KcpDnY0QRAdq0zTfmg1mgNWqabyqX3s0qkFA04JHzDX+SFRnv3aTmXTwsx554q9HmSzFHtGkOBKyrVe+GsMhJ7AXBjie+nOvloNHT5bZP3z0DsePvyhqwLx4cx+v8f+oMYFxmj9xZl5IdiOfjp0tt5hBL0rXv/PfsiEuY/AGwcFtpY80v5TPpJE+ryf9BxhG734AghEYCekMDrKFDusOtl81li/fjdJutEkR3vdyrQ/mjpFNLvQi/eUVZiH4UPtXsUYMJLjPXKtSu8oOpMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNPxs3nbrHeoqWz3cXqfucMTiEexjBAyJD5k6GXMPaE=;
 b=IDLlrPndrfpZWlM5ieyWukfYrmymyW8hSgfwBqrdf18c4t9wbGBACFmQi3j/xU3Jt/3Xe2112g2SGl2wxpJ9qAQtwit5Fe+/tgAemxFgqa9Qe9u9YZmgb8KncV9Gz48Fv2wY1ZJ1fRmzOXv5k+bp7OqGemmrequ8ooHcLpGUNhUkyHpkiDuNfNoLJyxIjfPgm3eEln0YiT8rNaJb9gRyWZkRRc8O4e4kfTdFppsm9lOgpKDczDTJskAC864izPNv0XYcNcJIDTBcz7GXPgZ/lf24Ulzn9C1Ls68lGYPA0qBwHQ1NOX4kCXae04FhiOr/KPcB3cPQOOUAZ49WWSk6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNPxs3nbrHeoqWz3cXqfucMTiEexjBAyJD5k6GXMPaE=;
 b=KNfQt0I+larDqjbytSvXdMSl695UqZ/MKkVlETQQnHB0lA/OG7hK6/c9notNVIFePvdh6dKdEQHEfsX/sq7r+4GACybwa6kQ0qy1NQCFa7XfpXkwOyXlJjh1IpEJxAaGhIr1mM/povfzT5yZnCI9iJUcnhD0loDg0nIPIg8XUfcpgQdR4VbDZW7NsKATZC+obitNI5NVM7H5QmpkdS8h4N30vsVZFaH19JPrEYAHXwVPtrsOAbYYc3aRA/dP+3aY2DNXDP988vxGeUN/QqV+goClIKbK8pBFgVYd04FOiImmYLiAO0HtPNyXUq7suwsc6gAPMb0j3qJJXFyGSUy1AQ==
Received: from CY5PR17CA0056.namprd17.prod.outlook.com (2603:10b6:930:12::10)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 16:50:26 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:12:cafe::6) by CY5PR17CA0056.outlook.office365.com
 (2603:10b6:930:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.19 via Frontend Transport; Thu, 28 Sep 2023 16:50:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:50:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:50:11 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:50:09 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     <eperezma@redhat.com>, <gal@nvidia.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     <virtualization@lists.linux-foundation.org>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 15/16] vdpa/mlx5: Make iotlb helper functions more generic
Date:   Thu, 28 Sep 2023 19:45:26 +0300
Message-ID: <20230928164550.980832-17-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e316bc-4671-4347-5a6d-08dbc04303b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4xhs/AtuERVwoWpggppHkpw4U5o0dBF9K2N0Lwmi55OPZygque8UMt4HNKILQDIbhhbHu/4FvsXqkCXtIhlPkzrjjZGhI1e7PgFX6PrJ+daycqKdmVcQY8rkvXHNr/d5Vxv7twmRyVXjPO0jNvtXjmvTD1iPcfGVL3I9e7JE6vwF/VxQMhqGXIyqhLI6QcNBSRhX5q6VfV8Rf8Vkrw1MWqIWGkSCrc2ZY5u/4IwkeahrN1QAErhMk96274qKPA3nAO+f0uoRzGaqms/5G9bb44tXZ1ayKpImEjFJDTTfcWIM4KbsxLqq9OQXSYNi1wCBu5a4HdMTMuu/U6XZEiudkhI8QyBV/7BOoDZ4R+vtOs8MLwrbF0HQPGHsN/NlYDjK40Khnhc/gow43V3GkyG2ISrrvQDIyUXhsPaOPX95CBz5lqRzWlNZk/tFd1RFQ/jPfQMrDCU713bscVb+VfR8vU7bGBZYp+35JJo03U8WCuWCWYcCXWBFEFd1MMY6U7EYGzz4yknWukmAyWjwpe+Kxv/ctsFnzAc6WruBGVu3T96zGesbdBEJpkKu+DchSLKetEkbEleCX89sBfotzA89DYhRv4gd9GuJvkFX4T+nimIFJGg0FwcrN+z9Wen4LGDWG5rf7rEavGv0ciEGiacVy7ejzZpGicHfOQtPA4xDWDMDlKgNMomXiNtRinSUriJuTFSFvWsVA6zCGJBsJ0k8TrpuT5t9ypsvnziay9M3LalhQOPlq3jhw5nnN0HfiO0WSkjt+oxK1Dn7hFdfWkQBw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(2906002)(110136005)(5660300002)(54906003)(6666004)(70586007)(478600001)(70206006)(1076003)(2616005)(336012)(426003)(26005)(316002)(8676002)(8936002)(40460700003)(4326008)(83380400001)(41300700001)(82740400003)(356005)(7636003)(36756003)(86362001)(40480700001)(36860700001)(47076005)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:50:25.9809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e316bc-4671-4347-5a6d-08dbc04303b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They will be used in a followup patch.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/core/mr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 3dee6d9bed6b..a4135c16b5bf 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -454,20 +454,20 @@ static void destroy_dma_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
 	mlx5_vdpa_destroy_mkey(mvdev, mr->mkey);
 }
 
-static int dup_iotlb(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *src)
+static int dup_iotlb(struct vhost_iotlb *iotlb, struct vhost_iotlb *src)
 {
 	struct vhost_iotlb_map *map;
 	u64 start = 0, last = ULLONG_MAX;
 	int err;
 
 	if (!src) {
-		err = vhost_iotlb_add_range(mvdev->cvq.iotlb, start, last, start, VHOST_ACCESS_RW);
+		err = vhost_iotlb_add_range(iotlb, start, last, start, VHOST_ACCESS_RW);
 		return err;
 	}
 
 	for (map = vhost_iotlb_itree_first(src, start, last); map;
 		map = vhost_iotlb_itree_next(map, start, last)) {
-		err = vhost_iotlb_add_range(mvdev->cvq.iotlb, map->start, map->last,
+		err = vhost_iotlb_add_range(iotlb, map->start, map->last,
 					    map->addr, map->perm);
 		if (err)
 			return err;
@@ -475,9 +475,9 @@ static int dup_iotlb(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *src)
 	return 0;
 }
 
-static void prune_iotlb(struct mlx5_vdpa_dev *mvdev)
+static void prune_iotlb(struct vhost_iotlb *iotlb)
 {
-	vhost_iotlb_del_range(mvdev->cvq.iotlb, 0, ULLONG_MAX);
+	vhost_iotlb_del_range(iotlb, 0, ULLONG_MAX);
 }
 
 static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
@@ -544,7 +544,7 @@ void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
 	for (int i = 0; i < MLX5_VDPA_NUM_AS; i++)
 		mlx5_vdpa_destroy_mr(mvdev, mvdev->mr[i]);
 
-	prune_iotlb(mvdev);
+	prune_iotlb(mvdev->cvq.iotlb);
 }
 
 static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
@@ -596,8 +596,8 @@ int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
 
 	spin_lock(&mvdev->cvq.iommu_lock);
 
-	prune_iotlb(mvdev);
-	err = dup_iotlb(mvdev, iotlb);
+	prune_iotlb(mvdev->cvq.iotlb);
+	err = dup_iotlb(mvdev->cvq.iotlb, iotlb);
 
 	spin_unlock(&mvdev->cvq.iommu_lock);
 
-- 
2.41.0

