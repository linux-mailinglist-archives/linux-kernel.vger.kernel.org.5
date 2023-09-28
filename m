Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB347B22EA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjI1Qud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjI1QuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:50:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F510F2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwQXQlBTiFxwVkAgE+XtiEpQRYwspaBbRPvoumGu6u2UENjPBnqhF8tH4EcNu4XnbusOxOR6tITy7gDUB50LyPmR+hekA/zc5wie0NPsY1qKPYyrD8fxzm04L55fdOGjsW8urkEUyauTObBEGKR53EIxg8fGGRm2VzTg046vYju7MTX9ouFi7KNVliu/KcdGo/5IUFzYERxd+n6Q9e4tUA5uAzDngNx7vmKQzJwJrebpjiBmhaNYoMy2cZ4lYmY5MpKfi6zuvoiw/bx5uIR4l4XTUGIHTSxgGy/JhBNotx72hGPFrGJO1OwtXD+eFkZ6iiQIvoEMXxfTVr7aYeYWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnJQ5tPt3zRoEBpIfXlFPOb7QvzypqNGxupaS7vWJDc=;
 b=kSmKSsBorHuX8gV+MRk5Nzk6n2Xak+xuiffHEnvh38JRStl7hDg5WRbvoHu0YVG5yaVxdO4CoYg5ztUvoYvIbL/2PA7MEKzwTk94tT5qV3KSraBHzmpJ95Wn8hiEc6GRafBlJ+b8sAYY6FdQuvPfmkrJX4d7LEsFARfinb90FLOMiM1rVZWVcJSmOS+gIZR4B+n2crjRHuTBeN2+hsSi3puS/ekfCzldaobaCWCWoMq5BulNHUyQYxKMWHShaTygKlwLWaSu/scuzUngdMs39i0EgSU8ROShiDzCq9XLQrS1RVOjryz5nxgtMWGS8Ha+n3I4btiEgkcIKjFJslvLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnJQ5tPt3zRoEBpIfXlFPOb7QvzypqNGxupaS7vWJDc=;
 b=Lgtsk/BSTQpGh1geAwyXe/ipNtYrlgXhWQDXY1hDDJFB7qQ/LGHrUvMUAnGh4cb1xteTzx1aErl59mkTxHLVmwdG+vTKd28RHRF/Anfqs/TkcHkT9D/girZe5gGPOOMVFt48NWKiYAeOJiY322tY0XSg5QOlR4G9k+hUipKsZYdHqb73Z2uJk1FgZ0eaSBISeIB7CInj9hwddrUhA++UNWx7nUBcQ9d5BAQwHporcw3ueScWD/UymA52dyDxuTKeiryrVCp9nlq45hs24Toy+POJ+cRl14jjtdkY5XloqBaQcSiCKiXXjcQ+W5I4xBdfyk1LHv+toPYV0PVK6rxmlA==
Received: from MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::23)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 16:49:59 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::d3) by MW4P223CA0018.outlook.office365.com
 (2603:10b6:303:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9 via Frontend Transport; Thu, 28 Sep 2023 16:49:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:49:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:49:46 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:49:44 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     <eperezma@redhat.com>, <gal@nvidia.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     <virtualization@lists.linux-foundation.org>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 07/16] vdpa/mlx5: Take cvq iotlb lock during refresh
Date:   Thu, 28 Sep 2023 19:45:18 +0300
Message-ID: <20230928164550.980832-9-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ea5f04-db78-4564-ceaf-08dbc042f3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NaZ8iRDNrNMysAHH2DSBaK2oVPK/yeQPunLj9MybVEOqzfxuqqhNzzO7QacTJEcOV3/OFzwERfrZSu8cAPTYq9pZuo1lyr3fh7GJ0Ol/PuyprrPDP8EnqW683a6xAiUn6cNIojUVfBeWpNNgMK7JQsTY+TvmrNZDwqo7gE4otx1bluj8Ms4orGgqN3Ps3JljMk6YXdHiuuZySeRD11HXpiWd/wOBFx6KEOeCwbpc0oFohESihouMDkzSPpotFLs6abLS2/V0OAiX4tvIgMZJyHDi2Xrijk5QCZoMOBhRrWoNvewQr0HcpZAGYIC9WSr0Ym/iybpSOIcbghWHtdr4OMQmHo76lGqqYv42OXvYJJHikVQU0zbdjxGgQOR6IyRQDre1AJnduSkEV28rFy/S/mFmt/9npE6cNyhzptAdFKuxMST9WkuDJsmeAb6Rs+naF2tehTITwyHyQzoHfA+mxNN+afdP318rKSk60BJ8PPAojUMRnXiLj1NjXjG0in13niWG2/v2u4Byf0zxURXkWK7Bg4cmwqBnG9u2u4EvPc9gc1uaUWYTpOUK7zdykGN+V2GfZv5wi615VbOQa6xY57eL5MBIK8gPWvRZCWB7qcpcxjE6qEbpfOdBytonK9+FpjnKH8EI9ne6e0hTdavItyrf/0rIHBbNpR6hUjcL4mFByiph2rYVDjCPtSFpd6+Onoll6DUUABj1Lgn+/6nEMSLpGf5aDa3qwi0mgUK/Hsaxtxq/dTEwSYMZjhiEMvzdLC2jgjuFrfE4VqkPYaQU538FubY+h7qZBbjQGyJDhnc=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(83380400001)(2616005)(478600001)(36860700001)(86362001)(36756003)(356005)(7636003)(82740400003)(40480700001)(336012)(26005)(66574015)(2906002)(47076005)(110136005)(966005)(6666004)(40460700003)(1076003)(4326008)(8936002)(8676002)(5660300002)(426003)(41300700001)(316002)(70206006)(54906003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:49:59.5426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ea5f04-db78-4564-ceaf-08dbc042f3f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reslock is taken while refresh is called but iommu_lock is more
specific to this resource. So take the iommu_lock during cvq iotlb
refresh.

Based on Eugenio's patch [0].

[0] https://lore.kernel.org/lkml/20230112142218.725622-4-eperezma@redhat.com/

Acked-by: Jason Wang <jasowang@redhat.com>
Suggested-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/core/mr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index fcb6ae32e9ed..587300e7c18e 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -590,11 +590,19 @@ int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
 				struct vhost_iotlb *iotlb,
 				unsigned int asid)
 {
+	int err;
+
 	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
 		return 0;
 
+	spin_lock(&mvdev->cvq.iommu_lock);
+
 	prune_iotlb(mvdev);
-	return dup_iotlb(mvdev, iotlb);
+	err = dup_iotlb(mvdev, iotlb);
+
+	spin_unlock(&mvdev->cvq.iommu_lock);
+
+	return err;
 }
 
 int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev)
-- 
2.41.0

