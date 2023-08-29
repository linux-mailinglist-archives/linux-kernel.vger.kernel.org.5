Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89F578CB74
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbjH2RlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbjH2Rkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:40:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CD8D7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cbsr1fpfvlhQuLneI2CTKZqo04t7+HjBcZ3+MCI9I6UjWRONkZNGOby50a/adgFvb/OoUAnIXhmuOasLxiIJF6vtk67/dtp7MzT9CNoWn1uRbMMZrj4JZPedgcqf5CT6jjR6xlIo94EGSfNubuGcqzzzoX1uFpnzBIvUZaWo/uxJMff0BTz6n+xrx36S+ex9AAxfo6XSwgaZAeGzmj655SwxN9WzgcooBvW7xgUo2lKShGZHHJaWF/iml/5FWUHhpjbU3hj2uckVWIurIu0vbS7+epiXbbjW5owNek2sz2QXTviKdcPvETgdqlWfsTYXIK72n0+1cTiex3CuX6ahOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3QO8Dgk30YSEZ8eYY9WDwx9ZRmONu9Eya4rrDQHUI4=;
 b=Z9TPivZF+6sZtZGzcjNZj17VwAUEThs4pBKdLTJTacueM72qA3+DaAJVKGw27+RfPYLkUh5fLUdVw8SxpnwhD1zKEAKDCm6Wp0vj0sCRJDJJuVXY/kuPKUq+oY2tg8pLeS3a5fyHDe+jIUGdrJ9Fi4rhKq+U5kwjsxLCpkd6ezWX+GfAWGfK3wcTvIcMtSnyTwxeEBg4Dd7llYYui1FSWuYy2LW3lUSJehI+c0H6gvunVLUq6BjJY6YJGY+HKu/pI3Prdsc6itbyCY8HwoPHG9jJl6v5lsh8u8RwlhhjrIrEUh2ZZKk9Of73SHNrs25M+LRduN0wuhkV7hcVtMt2Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3QO8Dgk30YSEZ8eYY9WDwx9ZRmONu9Eya4rrDQHUI4=;
 b=bytz/wddO0jDiFYrQkA/TUPIiFepVt5Q/fvZvvZBP/w7Ymv9OZkWB7ybwhxuPvfG+dRcGMUwWh/HWWT5dkm+aweN/C91ff89qoWcd02nTNixrj8SxT6QQO4YqOY8kbNbnjgIdd2lwblhatzDT1X2PV67qYYUxZ/cHg8/aABSAL38S3ZB//lgIs6C+yzERm/SQBOu9+tajqtIksRw9kqSqCA0sAqLgM6MjHQN8Ft3JiMgR5hNl0LH2E1/79X6y6VltmXqFE2qmwNVvDRhoU8siZPwy4B2Gma9K0L5eZwr5/H4SpGG7juwYzzDAXpQgs4KQ7ttfEvcN35ceaeRzTszOw==
Received: from MWH0EPF000554DF.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:4) by PH7PR12MB6883.namprd12.prod.outlook.com
 (2603:10b6:510:1b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 17:40:48 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2a01:111:f403:c903::1) by MWH0EPF000554DF.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.8 via Frontend
 Transport; Tue, 29 Aug 2023 17:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 17:40:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 29 Aug 2023
 10:40:34 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 29 Aug 2023 10:40:34 -0700
Received: from c-237-113-200-209.mtl.labs.mlnx (10.127.8.14) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37
 via Frontend Transport; Tue, 29 Aug 2023 10:40:32 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     Dragos Tatulea <dtatulea@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] vdpa/mlx5: Fix double release of debugfs entry
Date:   Tue, 29 Aug 2023 20:40:09 +0300
Message-ID: <20230829174014.928189-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|PH7PR12MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: a7143deb-05e0-4ff1-3cff-08dba8b714bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEmF+Q2REnJnTPmZmr2NLuH7xb+srq36mPJrx2cDRTyjS8ZFnUY3HGX42T85aOUVKfWeAQRdaj+xElbQWqwWVENWGLsy+brSAkJEwlcecW2KFplBVZI76+f0P0kPwWxEkfxTHiqMYro99dgsd5flR0VRz6a1G5km1BPoZ2+OUFs+JBvmXzNzNskJAP4uE9cuNDfgxKid55LvCukNMYxquMBFyfuj+RoVN6VwKnLKE0mvAv30ZYi66THvHzGFealvek8Sp3GKpR53cY0w9RJvXWJsFeJv/LlxTiEmkWYjqzZPcVQbHshYI/CTcfxHu8r9GKgQmoRU9aB7szizQ1UkXMOhkBU8ozOL1YldAW8cQzCVOAA6rq2iyGPJHfQ4pE2AIvy2y0ffq3qfh/NTEAZKrq0iLLHzfzsjA0pAR64oSsA+qOMMF9IinI28rXyKsN1hsZJiwBetkKVEZAmvbH02+TisGWz4y+1bunm7supadsAXOVXSV2WR/5KwBLsxWjJqpSXFm1TrPQORdnPK3JsP8FBFRpA1mnUmNmGIztC82cw5rRPVCghzLFDxBpXiJssw5mZXqLIq+H3of2mUy/Fv7HsjaXhByDhNHTI1GrW2C0kQ4QiyIf+EVDL6zr/HozyTmtJmEyKIoSDP6zrhFGjpP4nSsYaKTcGVslXcvm82mvTUF2al0W3zA5o7lC5TiKv4e14f8Mk9z/SaW3U6sFA+axw17lwSJVh8vBqwK6rVGRTw98hsX4oAwM4UIHgxoR11
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(40460700003)(316002)(41300700001)(4326008)(336012)(426003)(2906002)(83380400001)(86362001)(47076005)(2616005)(26005)(36756003)(1076003)(5660300002)(8676002)(40480700001)(36860700001)(8936002)(6666004)(356005)(7636003)(82740400003)(54906003)(110136005)(70206006)(70586007)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:40:48.2547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7143deb-05e0-4ff1-3cff-08dba8b714bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error path in setup_driver deletes the debugfs entry but doesn't
clear the pointer. During .dev_del the invalid pointer will be released
again causing a crash.

This patch fixes the issue by always clearing the debugfs entry in
mlx5_vdpa_remove_debugfs. Also, stop removing the debugfs entry in
.dev_del op: the debugfs entry is already handled within the
setup_driver/teardown_driver scope.

Fixes: f0417e72add5 ("vdpa/mlx5: Add and remove debugfs in setup/teardown driver")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 drivers/vdpa/mlx5/net/debug.c     | 5 +++--
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++-----
 drivers/vdpa/mlx5/net/mlx5_vnet.h | 2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/debug.c b/drivers/vdpa/mlx5/net/debug.c
index 60d6ac68cdc4..9c85162c19fc 100644
--- a/drivers/vdpa/mlx5/net/debug.c
+++ b/drivers/vdpa/mlx5/net/debug.c
@@ -146,7 +146,8 @@ void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev)
 		ndev->rx_dent = debugfs_create_dir("rx", ndev->debugfs);
 }
 
-void mlx5_vdpa_remove_debugfs(struct dentry *dbg)
+void mlx5_vdpa_remove_debugfs(struct mlx5_vdpa_net *ndev)
 {
-	debugfs_remove_recursive(dbg);
+	debugfs_remove_recursive(ndev->debugfs);
+	ndev->debugfs = NULL;
 }
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 37be945a0230..f91c938b4be1 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2713,7 +2713,7 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 err_rqt:
 	teardown_virtqueues(ndev);
 err_setup:
-	mlx5_vdpa_remove_debugfs(ndev->debugfs);
+	mlx5_vdpa_remove_debugfs(ndev);
 out:
 	return err;
 }
@@ -2727,8 +2727,7 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev)
 	if (!ndev->setup)
 		return;
 
-	mlx5_vdpa_remove_debugfs(ndev->debugfs);
-	ndev->debugfs = NULL;
+	mlx5_vdpa_remove_debugfs(ndev);
 	teardown_steering(ndev);
 	destroy_tir(ndev);
 	destroy_rqt(ndev);
@@ -3489,8 +3488,6 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct workqueue_struct *wq;
 
-	mlx5_vdpa_remove_debugfs(ndev->debugfs);
-	ndev->debugfs = NULL;
 	unregister_link_notifier(ndev);
 	_vdpa_unregister_device(dev);
 	wq = mvdev->wq;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
index 36c44d9fdd16..60cdbc903037 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -88,7 +88,7 @@ struct macvlan_node {
 };
 
 void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
-void mlx5_vdpa_remove_debugfs(struct dentry *dbg);
+void mlx5_vdpa_remove_debugfs(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
 void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);
-- 
2.41.0

