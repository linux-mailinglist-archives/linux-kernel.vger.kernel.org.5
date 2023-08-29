Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AE878CB7A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbjH2Rmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbjH2Rm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:42:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8255AFD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc3b9PylXmJaXPyi4LStTf/AAu+9IAsnnu1g6B3aoTzVxieST6s2on2w6VITlKc8y18dj0Uc7HxWoNUvjTYcZ/j/atYy6BsAH+CbhbEbzwXOTXIVIyOQfrd9iJZPssLA6zD63bxI8dW1JRNnt2I10RmybfoxxoP6zkMnMFcsKjULRO0VtIPnf/J5CvJy6bhzXMV0RvJ5e8hMKurKJgzZGDpfSFqZBhgCkRYAzmX75zaCRJnP8ODAvATaE1Q1uMtv/CoI9JhVPOKwW0NQXMYQ/d5vFFgrBCfVVDFGMIX8kxzMsB2ltC1K9wX4jQtYCBIN8h7Jx54JvULswRxvld6g/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxNcm2VeB2Q2mD9IW3svqtT7NZTlNBYvfIUDIS6K5cE=;
 b=lmJM7wY4//5nAWLitqyqw3BNGdamQ5uoMkt8vLV78c0Ad2dhb9dXj6CykGnVx96GLvUhYO1gKg3hnT3hfUIvzSNkyH9Un0aHQa5Bn41jeYBwdT1IOj3Hix4Idhtid23ndfEPr1/MDuXYTNm/ehbgr5A0komYWOuqBtf7fad/czGOzEFx8pdpX1b9GGaA+3QBoLXqrL/G/DHXz/z8ymkvCA1QVU/qbTpEtSy78w8Vz2XLGNq1R8HBV3PYRks4qnnu49zDJOe3GhEF6Hu8kAQIo73cks+wwzdk2C4eMJ1c50wP0RbSn7P9ps3byLprQva23KBNvwOEBqUxmV+HMu2Jag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxNcm2VeB2Q2mD9IW3svqtT7NZTlNBYvfIUDIS6K5cE=;
 b=fbFEARWhMRmaTuAwtalrhBSADmdVifAChKLzs/pv2XJN0MSrHGN4L+iHDni9yJhKW72ZkNVa6IOlcS8vZqf/Rjnsjb+A0p23Jsh5q5ki2mQzh4R/GSD9zGLy6S0qBde8flrQIA43K4kVq9dHc48b89JfNTd2yv8Q4um8ScOdL4slZL/hybavB6C8HGvg7kceqt5wetCUiVZqHeN1oKFdNSwsTMdXzH89YeRezM+j4PAMowHkmVNPqWzOPi/sMho7kU2X5cmzsNcdVpYiNfknt1I9lOVN4T+utJqhqxQlArpKAPHIUvIF84sWfQCxwur/KPVgzhPdTpYlQ0wVnAWvtA==
Received: from DS7PR03CA0295.namprd03.prod.outlook.com (2603:10b6:5:3ad::30)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Tue, 29 Aug 2023 17:42:24 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::c7) by DS7PR03CA0295.outlook.office365.com
 (2603:10b6:5:3ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 17:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 17:42:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 29 Aug 2023
 10:42:14 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 29 Aug
 2023 10:42:13 -0700
Received: from c-237-113-200-209.mtl.labs.mlnx (10.127.8.14) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Tue, 29 Aug 2023 10:42:11 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Parav Pandit <parav@mellanox.com>
CC:     Dragos Tatulea <dtatulea@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] vdpa/mlx5: Fix firmware error on creation of 1k VQs
Date:   Tue, 29 Aug 2023 20:41:46 +0300
Message-ID: <20230829174219.928343-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: e28adb6f-87c9-4f03-1109-08dba8b74e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvMTR0yOlabUoXmQiwD9ZcLeptWNRKf+eBrLq2TkruOu02yqR8bm4/IhCz/y8jgToRqhAGrRJqhuX+PFRU3MwVwBdWreLa9dmkmfMZz+cPyvymek9FqDwcSZ9PGJ+Ex0mnXU7semrxqPe2zkaPbOSDHSxBkfopZmb4kKY2Om/RGhWn+9Exng+5y+XS6/p5qjCGUGDFljoGO+9M8/l9V5BIVgxOLHPAXfGIKr5I30KrjBKX+5MFuOIImqdEsJ0Vy6VmO1nhGBNzX+FuOF1zJxWNrKhxYVONURWXQ+V0iVDsjYOCPTm/h7Z/828TYi4vgDd8K4DnbUocJEt1NUTguHxaxrKP4ARPrgazIoX9hLB8PaxnzSpJDk5b4ouaAHt7Yk5qQXDcIk63YchaCLRhUF3SdWM3p1ztEoQt7nLCWdKyOd6iQPW8jtoHfZOgi5LK2Zq7ukE+6DD1XpVGQyIvauckZS98Orh+v5jKxIKwb3LPUhIIHRN5bhwOlrTUXCDzzvqHu0ZE8ybGRq5FBBo2SabkrakSoCeUpcwrcBjbLsDhcPb7mgCKKfbrpovazTSAnfuLpyUftJQAQSBL69bdVqnPhSI1c0huP0fz+E03NmtLxxbCA5B/G5VqJfyzm/w2e9kn/GJL0vJzW1Z19lqM1BIri6LD1qqZjTVu5/tWeTmNueWmgw5PbHq5iR1eXoM4C5R+xUE+ylzMKq0jGlneigNSvM/suH66q3Nx1Zj9YZHACgXOYVTM+/i+4OdwEZ3dTl
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(1800799009)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(83380400001)(478600001)(7636003)(356005)(82740400003)(426003)(336012)(36860700001)(47076005)(26005)(1076003)(2616005)(40480700001)(6666004)(5660300002)(2906002)(54906003)(8936002)(316002)(110136005)(70586007)(8676002)(4326008)(36756003)(41300700001)(86362001)(70206006)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:42:24.3399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e28adb6f-87c9-4f03-1109-08dba8b74e05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A firmware error is triggered when configuring a 9k MTU on the PF after
switching to switchdev mode and then using a vdpa device with larger
(1k) rings:
mlx5_cmd_out_err: CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status bad resource(0x5), syndrome (0xf6db90), err(-22)

This is due to the fact that the hw VQ size parameters are computed
based on the umem_1/2/3_buffer_param_a/b capabilities and all
device capabilities are read only when the driver is moved to switchdev mode.

The problematic configuration flow looks like this:
1) Create VF
2) Unbind VF
3) Switch PF to switchdev mode.
4) Bind VF
5) Set PF MTU to 9k
6) create vDPA device
7) Start VM with vDPA device and 1K queue size

Note that setting the MTU before step 3) doesn't trigger this issue.

This patch reads the forementioned umem parameters at the latest point
possible before the VQs of the device are created.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 55 ++++++++++++++++++++++++++-----
 drivers/vdpa/mlx5/net/mlx5_vnet.h |  9 +++++
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 37be945a0230..85855680b24c 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -625,30 +625,62 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
 	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
 }
 
+static int read_umem_params(struct mlx5_vdpa_net *ndev)
+{
+	u32 out[MLX5_ST_SZ_DW(query_hca_cap_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(query_hca_cap_in)] = {};
+	u16 opmod = (MLX5_CAP_VDPA_EMULATION << 1) | (HCA_CAP_OPMOD_GET_CUR & 0x01);
+	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
+	void *caps;
+	int err;
+
+	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
+	MLX5_SET(query_hca_cap_in, in, op_mod, opmod);
+	err = mlx5_cmd_exec_inout(mdev, query_hca_cap, in, out);
+	if (err) {
+		mlx5_vdpa_warn(&ndev->mvdev,
+			"Failed reading vdpa umem capabilities with err %d\n", err);
+		return err;
+	}
+
+	caps =  MLX5_ADDR_OF(query_hca_cap_out, out, capability);
+
+	ndev->umem_1_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_1_buffer_param_a);
+	ndev->umem_1_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_1_buffer_param_b);
+
+	ndev->umem_2_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_2_buffer_param_a);
+	ndev->umem_2_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_2_buffer_param_b);
+
+	ndev->umem_3_buffer_param_a = MLX5_GET(virtio_emulation_cap, caps, umem_3_buffer_param_a);
+	ndev->umem_3_buffer_param_b = MLX5_GET(virtio_emulation_cap, caps, umem_3_buffer_param_b);
+
+	return 0;
+}
+
 static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
 			  struct mlx5_vdpa_umem **umemp)
 {
-	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
-	int p_a;
-	int p_b;
+	u32 p_a;
+	u32 p_b;
 
 	switch (num) {
 	case 1:
-		p_a = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_1_buffer_param_a);
-		p_b = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_1_buffer_param_b);
+		p_a = ndev->umem_1_buffer_param_a;
+		p_b = ndev->umem_1_buffer_param_b;
 		*umemp = &mvq->umem1;
 		break;
 	case 2:
-		p_a = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_2_buffer_param_a);
-		p_b = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_2_buffer_param_b);
+		p_a = ndev->umem_2_buffer_param_a;
+		p_b = ndev->umem_2_buffer_param_b;
 		*umemp = &mvq->umem2;
 		break;
 	case 3:
-		p_a = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_3_buffer_param_a);
-		p_b = MLX5_CAP_DEV_VDPA_EMULATION(mdev, umem_3_buffer_param_b);
+		p_a = ndev->umem_3_buffer_param_a;
+		p_b = ndev->umem_3_buffer_param_b;
 		*umemp = &mvq->umem3;
 		break;
 	}
+
 	(*umemp)->size = p_a * mvq->num_ent + p_b;
 }
 
@@ -2679,6 +2711,11 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 		goto out;
 	}
 	mlx5_vdpa_add_debugfs(ndev);
+
+	err = read_umem_params(ndev);
+	if (err)
+		goto err_setup;
+
 	err = setup_virtqueues(mvdev);
 	if (err) {
 		mlx5_vdpa_warn(mvdev, "setup_virtqueues\n");
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
index 36c44d9fdd16..65ebbba20662 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -65,6 +65,15 @@ struct mlx5_vdpa_net {
 	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
 	struct mlx5_vdpa_irq_pool irqp;
 	struct dentry *debugfs;
+
+	u32 umem_1_buffer_param_a;
+	u32 umem_1_buffer_param_b;
+
+	u32 umem_2_buffer_param_a;
+	u32 umem_2_buffer_param_b;
+
+	u32 umem_3_buffer_param_a;
+	u32 umem_3_buffer_param_b;
 };
 
 struct mlx5_vdpa_counter {
-- 
2.41.0

