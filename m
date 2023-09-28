Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292BC7B22E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjI1QuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjI1QuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:50:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFCE1B3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kas8/nFuK27ABHt5Kg9sZHisGSgMpSOF6WXjLx1LzkaEWfVw0N2BImzvNZsCAxbcQJlWu8JJYt7wh49vHkS3lf3r8kCIfr/updAVnbBjeYXB6bjuH7wsY5vFMlSfDvYH9zKX+XknZ/bE/sjy3XMQXBqkaoD+0wi2pmaBRFxm6BHo8I/8Qr4ukavY7jdcP0IuDrb9nC6yApVYuqC0UwQ7MA6dh3kBE1TzSNQV3rH23TvMqn9/xGBZs1LqtpMTPiPUW0OEV8xXlr7tZt6Ayhh06NjRSRuJj6KXZttfwtz4JsFEACo3sZ/sZp+AHZ93mP7oGZ5ux1A2LcGACuufbzzSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLEYp8FG8MYA2AcSAX//hEYnU7j56KnewdXwaWn6gPc=;
 b=dYTePof3hdLi57FkxGiJV8pAqZqsy0Mbx1a4fv9f5JjuPexFB5CWCudWQ1zqYvKoNT472n+t8caDmbGdEAiNMjq0hhDdpnjuNmNpVopVu/Ka6n7V6yaaxrco74BBtVtAlDZFtmbUPIfG3fxLyqWVIgDrSAfP7z8grLcrSHRTL8SGqp2xemWe7W64ppIGIJbn8p9maFfUQeMnP69IOAlEoJ0SWvYc8dmSZzTu8REXoLekakMY1Zgz/6kIt2x/wlrTdEyXcwKC8zSWw+meAxrZismv767oXT8sQwmpyCoFxo0AR5i5dyLVIMzFXkKnKRMmUxAdv8uQeNmzUuovvrocGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLEYp8FG8MYA2AcSAX//hEYnU7j56KnewdXwaWn6gPc=;
 b=UEjRnEcqM0y2T+YtWJCBFQQZgSNV/q6Utio6hqf+iKpMloS+oANiEOJpJ/7WdaOknsSVWFdWTbFZ0CrZvMz3Up4EFwlF4pNqHkvt9vj0s4DRsjlrp/UtNGRZvTadSrzZhiQj0/KR//B+pzgsrPKquH2Ikgk3l145eSJd9XkhB72r9uHtnzwQfVEiYqt8hSk29l0gVupII8/wt9hPnGMSHwItNPvYAJLVrNF9lazGqruB0vLEke4rKJgF44eEEB7W5uG/KvsHOorH76z8lq99YpewxbV8x2yJJQw0K/pX3e12cGAkNDpCarramXewUNEKlPKvG8S3lPQ77Pi/mdm3TQ==
Received: from CY5PR17CA0060.namprd17.prod.outlook.com (2603:10b6:930:12::27)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 16:49:57 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:12:cafe::55) by CY5PR17CA0060.outlook.office365.com
 (2603:10b6:930:12::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Thu, 28 Sep 2023 16:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.19 via Frontend Transport; Thu, 28 Sep 2023 16:49:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:49:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:49:52 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:49:50 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     <eperezma@redhat.com>, <gal@nvidia.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     <virtualization@lists.linux-foundation.org>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 09/16] vdpa/mlx5: Rename mr destroy functions
Date:   Thu, 28 Sep 2023 19:45:20 +0300
Message-ID: <20230928164550.980832-11-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 275dd05c-ab6c-4c9c-3364-08dbc042f2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e7o7g7fIWbhi3/hkxirxgCjhmityxNha3ESQQZjsQZUmZgTxECh1deUEjWdH9oul+eilzE0NOy1Pr0QUAynCW3rFLpYl9q6losZdlZLH3lhw4lmVneQtrI2GlRHTtZX1eRI2kAVGk6j/giH3RyMXbrszVs4KKRWwbUZrvihyNoGCBhumDQLB346+vRf5LK16lwGznqs0uGKY5TgkmAocomqa31w1AKcFVM0VIHjsf4bRExqxb2B067N5af08m/7mwdD+2PxpNDkwpFEs/i8MPh1hKStHEIxjQie32J5gnLQCEIYDXz3NWBWZUbry7faSPuogbfPD+dONDLLaxE5gEpsowsZydw620mrgxXH3lYgWKW/riWIGwe/6TJPlpiP4JTudwdU76P4MQtHXyZ4oEfwtTZtfOzalkVDZf674i6Pqt9vnm6TJDWwj7pj2kEwlP0sfNAQn69sTGZW4C627G7roG23azxVdizAVPXHnp1VaKfnPZvbgGIbwGGmFq3gWzEBBumOZSF79ciFsDdX6JWjRLyoZ+v3dhCFMXQQ+0KLbgEwkHdyXmTHI3NIB77FA3b618hWP/ItcLgSn8qD+X3tE0dArNc5SgkCmnhBbjtfR+/QzEf1i4KEYzj9EMnJOFwcedTCSCMDUFvbcB6XL4HNrXvxkRrWczkPp7CppZSV+ZSbHOmq/ax9v5ccoh/Lwf6vp47hEMzOUxa74mpFi4asWn9Mbbx37uO06kSxgGh0DL5Mudv7aNXpN/LKsx8zU
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(26005)(6666004)(1076003)(478600001)(2616005)(36860700001)(7636003)(426003)(36756003)(336012)(86362001)(356005)(5660300002)(83380400001)(82740400003)(47076005)(40460700003)(4326008)(40480700001)(8936002)(2906002)(8676002)(41300700001)(54906003)(316002)(70206006)(110136005)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:49:57.4652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275dd05c-ab6c-4c9c-3364-08dbc042f2b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make mlx5_destroy_mr symmetric to mlx5_create_mr.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  4 ++--
 drivers/vdpa/mlx5/core/mr.c        |  6 +++---
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 554899a80241..e1e6e7aba50e 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -118,8 +118,8 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
 			     bool *change_map, unsigned int asid);
 int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 			unsigned int asid);
-void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
-void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
+void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev);
+void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
 int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
 				struct vhost_iotlb *iotlb,
 				unsigned int asid);
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index fde00497f4ad..00dcce190a1f 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -507,7 +507,7 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid
 	mr->initialized = false;
 }
 
-void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 
@@ -518,9 +518,9 @@ void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
 	mutex_unlock(&mr->mkey_mtx);
 }
 
-void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
+void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
 {
-	mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]);
+	mlx5_vdpa_destroy_mr(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]);
 	prune_iotlb(mvdev);
 }
 
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index aa4896662699..ab196c43694c 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2644,7 +2644,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 		goto err_mr;
 
 	teardown_driver(ndev);
-	mlx5_vdpa_destroy_mr_asid(mvdev, asid);
+	mlx5_vdpa_destroy_mr(mvdev, asid);
 	err = mlx5_vdpa_create_mr(mvdev, iotlb, asid);
 	if (err)
 		goto err_mr;
@@ -2660,7 +2660,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 	return 0;
 
 err_setup:
-	mlx5_vdpa_destroy_mr_asid(mvdev, asid);
+	mlx5_vdpa_destroy_mr(mvdev, asid);
 err_mr:
 	return err;
 }
@@ -2797,7 +2797,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 err_driver:
 	unregister_link_notifier(ndev);
 err_setup:
-	mlx5_vdpa_destroy_mr(&ndev->mvdev);
+	mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
 	ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
 err_clear:
 	up_write(&ndev->reslock);
@@ -2824,7 +2824,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	unregister_link_notifier(ndev);
 	teardown_driver(ndev);
 	clear_vqs_ready(ndev);
-	mlx5_vdpa_destroy_mr(&ndev->mvdev);
+	mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->mvdev.suspended = false;
 	ndev->cur_num_vqs = 0;
@@ -2944,7 +2944,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 
 	free_resources(ndev);
-	mlx5_vdpa_destroy_mr(mvdev);
+	mlx5_vdpa_destroy_mr_resources(mvdev);
 	if (!is_zero_ether_addr(ndev->config.mac)) {
 		pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
 		mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
@@ -3474,7 +3474,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 err_res2:
 	free_resources(ndev);
 err_mr:
-	mlx5_vdpa_destroy_mr(mvdev);
+	mlx5_vdpa_destroy_mr_resources(mvdev);
 err_res:
 	mlx5_vdpa_free_resources(&ndev->mvdev);
 err_mpfs:
-- 
2.41.0

