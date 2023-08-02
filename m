Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFE976D4D7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjHBRNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjHBRNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:13:17 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803C31734
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:13:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IavSKqK64YjUSvBo4hps72Hs1aAbpsJDk2lYlUu5hk1AndYdMQ6CRs9yDTY0KHELrKo1t+dSnJVL+ggH9t7D6Nsbp/J9xWhwWSu+ri0QrnOpy5JaqcqF7uJLqCiAi4JcRXkl+zlj1AwcZd2zMHPJIH9W2Q646LmNe7BNwQkNfe7KsHbm0XHuJ2OsnYVVc6RgaKqOqHa9NQBgrm5llg+0oJrApwNxmbfmqOOcSJqSy30CfoGl0nxwF/PH32Uyh6HgOlbM2OrIWLeqkSUEe2dTzSCaIcyDPC5or5Vi89iDAZaeFBsS4jVi8PwTr6beR1fK7IJ4exlosyxxJoxkkWVd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3o64W6AxgCasG8EB+Q2EH9SyaH2V1AMN/IpgxvfuVs=;
 b=Hb6Dtycl6qkai1ebLP7oi+5Y8Ry0K9NPaqUEujnDgeF9ya7eXREAukAcrmYHIoSKWYtsYFc9DSbuiV4I2e5jDSrMQ4DOTea5B3I9Rg85Z1XCIj3zagLRHNr+khUJmnabkrqO466IQj20ruwulfo45WGHxV1jzbXTvUhTX2bMuinAPVxfiFFUcosB6+36jWp4rceilYwTZeListn+b88/yiZ6poJetYbEwUDDalS6wvQwVmHe8zWUqvIN7RkpXEW+eEVnD3+fJUrl9quYQxAAWdlVvoDlSuXORnPxXnZIOMbfKkBxL1+rF5vqctGLCxgPKo5vS14WE8SwmUUeWBy6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3o64W6AxgCasG8EB+Q2EH9SyaH2V1AMN/IpgxvfuVs=;
 b=cvCPZyaCfaccG4etB2GxvLGzW7+Lk1cgP0eHYtKczFv1vvUb3nmbTvyu7uzU13SfZtOANUMlMnakdDizy2XCgT1/Qdv8POug8z2l2bth8VaG04T85axBquZ2lIMtG2Vv7Ddy1biV8XC0X0CmCWLJ31402wCXzHE8VyFe+LtnbVNn7cIzVdFtLMg1V/VgFI7NM1L3SCCsPmqSM2BdFgieO7WAyQP/QqEZDvZs6pYktlJekU1keoyMtce089clFVEYm5Q3y+3CSf7GHZKpl1lQ17Q4lqzUwoC7JOg1TaKh9tAZ55KZ6rIvcDC846/K63IiyvNVsokEj/6e7pK8zFdsgg==
Received: from MW4PR03CA0096.namprd03.prod.outlook.com (2603:10b6:303:b7::11)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 17:13:08 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::72) by MW4PR03CA0096.outlook.office365.com
 (2603:10b6:303:b7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 17:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Wed, 2 Aug 2023 17:13:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 10:12:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 10:12:53 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Wed, 2 Aug 2023 10:12:50 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     Dragos Tatulea <dtatulea@nvidia.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Gal Pressman <gal@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
Date:   Wed, 2 Aug 2023 20:12:18 +0300
Message-ID: <20230802171231.11001-3-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802171231.11001-1-dtatulea@nvidia.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d91cf9-007c-40ad-25b5-08db937bbddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ebzthq04FOkvko+bkA4hJChFsnc701BWXCqTZ7KAlO+zHhcFSd6zjT0c7euDAf7YyyZkZbY2AErdRGkcRmhtqrB5fBaTEYocUxWobBa69ad2Z4VQIVITWnpBTg3dDznbP5/5wbXfMYruZryzcy6fSKhloN0Qakc4FcXTKBdFKDI2rzW4KYzD9nZY2dXoSzps20Ny7mbSTxTyk2awKssEecvSxdXTMAYKzL4NO78gNn4hgIs0P6zFyUkuQNklqiavplQ7LBMzmEsBbTtXt9p0Lo3HBIet5dlPUf7Nwl/XSgVfxXWjyq8EGS9U7PYS9GzSYiDCU07JQu8ztSn12aajbc4YIagvSftCVQ/Tl4Nyqc2dF6ZV9XfR3OS0O+cKci9SNAbtuYxICn9/++p2ZVazW+Nl6XGxKo4pIcd1PxE0R+u1/12BMcramAWhwHi/GdIO9hiT83lco0Kalo7m5FK88KFkcIy1eHr5SoCAlxqZH8/khWM5zWpodsH/BmltGtmphoGHd7JgKAI0Fe5kCaKwlwCiJ5HKIfnQxG5LgqG6cfqztYEAwPnKe+l82egTF3CBFY0nwx52vnARH4BXv1rxdZDGQvEGu6wZt7q4l1dSMoG6U41LxgIh8k0ADWy55MgekFxjk7LEKKRdnF04J+yEup2KNVzhaNZVOnJ6BdSUF3zkVpcCykTM/Intial52DoSBU2oKMkEAccl9qPr1v28IUL7k0Y1z1pRjRrRZs13e/EAyFbwtlPEwoG8ylPDz2P
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(36756003)(2616005)(66574015)(426003)(5660300002)(8936002)(186003)(36860700001)(8676002)(47076005)(83380400001)(26005)(336012)(478600001)(4326008)(70206006)(54906003)(110136005)(316002)(6666004)(41300700001)(70586007)(86362001)(40480700001)(40460700003)(1076003)(2906002)(356005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:13:07.7010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d91cf9-007c-40ad-25b5-08db937bbddb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mr->initialized flag is shared between the control vq and data vq
part of the mr init/uninit. But if the control vq and data vq get placed
in different ASIDs, it can happen that initializing the control vq will
prevent the data vq mr from being initialized.

This patch consolidates the control and data vq init parts into their
own init functions. The mr->initialized will now be used for the data vq
only. The control vq currently doesn't need a flag.

The uninitializing part is also taken care of: mlx5_vdpa_destroy_mr got
split into data and control vq functions which are now also ASID aware.

Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for control and data")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 97 +++++++++++++++++++++---------
 2 files changed, 71 insertions(+), 27 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 25fc4120b618..a0420be5059f 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -31,6 +31,7 @@ struct mlx5_vdpa_mr {
 	struct list_head head;
 	unsigned long num_directs;
 	unsigned long num_klms;
+	/* state of dvq mr */
 	bool initialized;
 
 	/* serialize mkey creation and destruction */
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 03e543229791..4ae14a248a4b 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -489,60 +489,103 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr
 	}
 }
 
-void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
+static void _mlx5_vdpa_destroy_cvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+{
+	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
+		return;
+
+	prune_iotlb(mvdev);
+}
+
+static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 
-	mutex_lock(&mr->mkey_mtx);
+	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
+		return;
+
 	if (!mr->initialized)
-		goto out;
+		return;
 
-	prune_iotlb(mvdev);
 	if (mr->user_mr)
 		destroy_user_mr(mvdev, mr);
 	else
 		destroy_dma_mr(mvdev, mr);
 
 	mr->initialized = false;
-out:
+}
+
+static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+{
+	struct mlx5_vdpa_mr *mr = &mvdev->mr;
+
+	mutex_lock(&mr->mkey_mtx);
+
+	_mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
+	_mlx5_vdpa_destroy_cvq_mr(mvdev, asid);
+
 	mutex_unlock(&mr->mkey_mtx);
 }
 
-static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
-				struct vhost_iotlb *iotlb, unsigned int asid)
+void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
+{
+	mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_CVQ_GROUP]);
+	mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]);
+}
+
+static int _mlx5_vdpa_create_cvq_mr(struct mlx5_vdpa_dev *mvdev,
+				    struct vhost_iotlb *iotlb,
+				    unsigned int asid)
+{
+	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] != asid)
+		return 0;
+
+	return dup_iotlb(mvdev, iotlb);
+}
+
+static int _mlx5_vdpa_create_dvq_mr(struct mlx5_vdpa_dev *mvdev,
+				    struct vhost_iotlb *iotlb,
+				    unsigned int asid)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 	int err;
 
-	if (mr->initialized)
+	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
 		return 0;
 
-	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
-		if (iotlb)
-			err = create_user_mr(mvdev, iotlb);
-		else
-			err = create_dma_mr(mvdev, mr);
+	if (mr->initialized)
+		return 0;
 
-		if (err)
-			return err;
-	}
+	if (iotlb)
+		err = create_user_mr(mvdev, iotlb);
+	else
+		err = create_dma_mr(mvdev, mr);
 
-	if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid) {
-		err = dup_iotlb(mvdev, iotlb);
-		if (err)
-			goto out_err;
-	}
+	if (err)
+		return err;
 
 	mr->initialized = true;
+
+	return 0;
+}
+
+static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
+				struct vhost_iotlb *iotlb, unsigned int asid)
+{
+	int err;
+
+	err = _mlx5_vdpa_create_dvq_mr(mvdev, iotlb, asid);
+	if (err)
+		return err;
+
+	err = _mlx5_vdpa_create_cvq_mr(mvdev, iotlb, asid);
+	if (err)
+		goto out_err;
+
 	return 0;
 
 out_err:
-	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
-		if (iotlb)
-			destroy_user_mr(mvdev, mr);
-		else
-			destroy_dma_mr(mvdev, mr);
-	}
+	_mlx5_vdpa_destroy_dvq_mr(mvdev, asid);
 
 	return err;
 }
-- 
2.41.0

