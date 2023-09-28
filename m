Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA767B22F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjI1QvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjI1Quw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:50:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA55CC7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwQ42FeyZpcmqr4QpH3J3h2hpvWbbbdMi07REVGf/xClGq/sKh7Qpwya9dkPNuPBjC0LKFvP/RviwaWyk2SokC/BFGzXd7bGAOJ8qxw4NETCuqLUUfdTglyiDPFUc7T+EWkf8lEdMSLZf3UooyZkrnlyGs8WSTKTY9qncMcIwQvpHngTt5cJ+NbaMx7xkafNdiWzt8LMgUtQjpvRSvQ/b5DDpG4m4YfNGjzmy67m/PE13Umb35p0uSa+oRiyVhZxxGdhmxcFMBRA04Z39vNwvg6ZolfCAuCqDwCLDr9QSOaexr5gnq84wFWPz0XVBJ+hpqjPAEJeB0j3Z9aMTuVT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqXzNtuzmep7ULt81tvKIba4FBPF+U2bzirjqh6BoMg=;
 b=OMjKggyhn5CLKZ7DDp5DT0DpoAZh8kTLi6BoTzEI1Z//smRrg9ryEsYAJvCC+ciB4cEoG5eMsoKPTOX5tSYe0tKonZgDJqUZWpRAmvNrZ2v71X7q3HlaYsE9cLPThUnF0QA+3FEHx/bMvMfclIGAZbGspJuzToK3aVFNLsapPvifoZPIQlQmelf8waSrT/BSgVTEFstkaojyHeuFy81NJbtHC8X/uhxQA2jq0pX0k6VMRVDO4OwsjGKMkvyOohptNnojmhR0aU+y4RV9M8UGmfDbqxPf5MywgUN1NpSusTunINWudSVIw8TrFMdezhxy3f+bDbjPN8pJcc8DnS58ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqXzNtuzmep7ULt81tvKIba4FBPF+U2bzirjqh6BoMg=;
 b=VGJivgmAX5RifnPykfy9/28ffOOanjqIoILCSuTQOKgjXQpj58vSL44WrekW0SkjZ8UEzTrhZcp1v+PUu6ccI89Hh/jl2eOrzLOIENWgnpR8RdCpEhvuycstWs8UJv6/8bL4nvTtMfWb6LacCQkSOyWE2YmuobuDDpqAFM6UcZm9sJPJzq+7/se0s/HRdLtLA/DODY/X3c4Racamqjk6xkb4mGR4SUxbtCOmXNA9VGcHQDp7tK2pTjxxJcGjtRxI6sGWoeMrkO3UBj6RSy+fXK+x7k6D8Z0LqjX34Ha335w4XJ6aB0AFoKto2ALM4ojuyQdXmUBDtPpbA6fQuZ65XQ==
Received: from MW2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:907::48) by
 DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18; Thu, 28 Sep 2023 16:50:29 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::85) by MW2PR16CA0035.outlook.office365.com
 (2603:10b6:907::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9 via Frontend Transport; Thu, 28 Sep 2023 16:50:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:50:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:50:14 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:50:12 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     <eperezma@redhat.com>, <gal@nvidia.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     <virtualization@lists.linux-foundation.org>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 16/16] vdpa/mlx5: Update cvq iotlb mapping on ASID change
Date:   Thu, 28 Sep 2023 19:45:27 +0300
Message-ID: <20230928164550.980832-18-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df76dc9-3965-44b2-e1bf-08dbc043056d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wiL0Vb8XEAa5WYLQvRQw9gJJryeUhdQE6JegoxvSi/5hDP0lgt1DavRqoEc0RkLjAHhD6dielmyvDtlfKERUUbP+xh+UPyQNendkrfdiuDIXdHlKmXY4NVzSCJW2zyamtNbAyys10pX6wt8+OR7TAqgUs9fw3n7wkgr8Yeh+Q1tfcX8XUbCcmgSH7n8lmElwsYTclayIgbyVav3LMWzVCRKUKqhzEfVWxo1p0H4InZgqn3NOLyNGc8B62qA93cZ//RnUZStZVLgjd2/XBy4ctLqCFmWjYK3/x+2B42QhdtMJ9smrhdbkVsHvMygrqI3dkJHgWG4P7Hqbq6ksQZJxtD8dkBlzfBWahyAW5faau8w9H4TjDl85G+vlSddc9uQgHr59lrxAz9AgjmV7TsNR8lNRk66MdEpZVSvW1Nk66sN6O1HnNrQc1OQlmLqgXR4PcJky9dE+ZjO3EsHo/FyvsUqpLzQD5cbg7fff9cO/507a9N7SKfraCttcM3CdWpNCLF0fquDMGFs4GoFKJvUG7QLOR18L5VncDhK+ftBmLT7OABNY7OwKSzH0nP+9t5telBmvgxWJ3J5cg5VkW/5b5SjD5pB7jAY1jHzPD/M1gYfFpxVr4/0Wiky3wY/paRXh9OX7UDMFpOP97r/PIegTIe2l08FdNJW6Ol/Mbj04e8MF3rRdzzcVQH0IBGyrFAWPqbf5FOuRtjyEfXhXVKGGHudmhNlILMpeY17SSPOwCZVql/OwOdGfOCwuAqq9rsv
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(7636003)(336012)(426003)(47076005)(1076003)(36860700001)(2616005)(86362001)(26005)(41300700001)(36756003)(83380400001)(40460700003)(8936002)(4326008)(40480700001)(356005)(5660300002)(70206006)(8676002)(82740400003)(110136005)(2906002)(6666004)(70586007)(316002)(54906003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:50:28.8548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df76dc9-3965-44b2-e1bf-08dbc043056d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the following sequence:
- cvq group is in ASID 0
- .set_map(1, cvq_iotlb)
- .set_group_asid(cvq_group, 1)

... the cvq mapping from ASID 0 will be used. This is not always correct
behaviour.

This patch adds support for the above mentioned flow by saving the iotlb
on each .set_map and updating the cvq iotlb with it on a cvq group change.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 ++
 drivers/vdpa/mlx5/core/mr.c        | 26 ++++++++++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  |  9 ++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index ae09296f4270..db988ced5a5d 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -32,6 +32,8 @@ struct mlx5_vdpa_mr {
 	unsigned long num_directs;
 	unsigned long num_klms;
 
+	struct vhost_iotlb *iotlb;
+
 	bool user_mr;
 };
 
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index a4135c16b5bf..403c08271489 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -499,6 +499,8 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_
 		destroy_user_mr(mvdev, mr);
 	else
 		destroy_dma_mr(mvdev, mr);
+
+	vhost_iotlb_free(mr->iotlb);
 }
 
 void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
@@ -558,6 +560,30 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
 	else
 		err = create_dma_mr(mvdev, mr);
 
+	if (err)
+		return err;
+
+	mr->iotlb = vhost_iotlb_alloc(0, 0);
+	if (!mr->iotlb) {
+		err = -ENOMEM;
+		goto err_mr;
+	}
+
+	err = dup_iotlb(mr->iotlb, iotlb);
+	if (err)
+		goto err_iotlb;
+
+	return 0;
+
+err_iotlb:
+	vhost_iotlb_free(mr->iotlb);
+
+err_mr:
+	if (iotlb)
+		destroy_user_mr(mvdev, mr);
+	else
+		destroy_dma_mr(mvdev, mr);
+
 	return err;
 }
 
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 46441e41892c..fc5d6b989a5a 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3154,12 +3154,19 @@ static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
 			       unsigned int asid)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+	int err = 0;
 
 	if (group >= MLX5_VDPA_NUMVQ_GROUPS || asid >= MLX5_VDPA_NUM_AS)
 		return -EINVAL;
 
 	mvdev->group2asid[group] = asid;
-	return 0;
+
+	mutex_lock(&mvdev->mr_mtx);
+	if (group == MLX5_VDPA_CVQ_GROUP && mvdev->mr[asid])
+		err = mlx5_vdpa_update_cvq_iotlb(mvdev, mvdev->mr[asid]->iotlb, asid);
+	mutex_unlock(&mvdev->mr_mtx);
+
+	return err;
 }
 
 static const struct vdpa_config_ops mlx5_vdpa_ops = {
-- 
2.41.0

