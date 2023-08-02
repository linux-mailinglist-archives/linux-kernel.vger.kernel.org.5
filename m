Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076EA76D4E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjHBROk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjHBROe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:14:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7AC2D70
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dttdudDqvQi2+hQJ3NaHb3YGylDNMZojjRe2U0NPXfIvG2qkANSrM4cbMC4RD2ZrimPa4b9CJtJhfJbn5v9s4GwMlaWJFGPE9E8D6uoD9tovU4N6qiaHMKO4xF/4aZMBGV82A8wYM3aV2wEOmddmDL7ymRSUPWsRmJnbq6WhLVATEKEg1eeqhQHynKNmD75PN5Ck6LWSFHoyYqA8HNvxbhDW+SMIIUuMzeREsuhK7M+TLowFjKHX3M/LgeSSzjUMONdpNWhboacnbKeUfwCNAZggdtdF2uOMWo6D0AGxRPOcju6InimzZKX5zHtagjteWteKIVB+yFl8rlQ3uIuGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UyKQTMFX1mut5/H2U/CfaadEbA4WrB66IyJaD16oIQ=;
 b=i+vd9N1fZ1EQsezdHymW+cek/BKhzeOZRTQurxApvnAbqJfT4msC1q7TiEjai2PEvw9XRV1eLiyomRaGcW1kaIIF1BrbpW1dUtvdXRzZ8+ZqwkrpYyJkL18UOmXff72cxsm7Q6YJLU7jy17H2eJ0AMGpyVqRDc0hZTlbmN7GR0iwsDDpNLyLV34srULRodmwb6KdFfc5AFW48VL2BhSpudmXViWm+U9sXh8Hf7N1H7LEiMZJRHirIUvIsCf1gki8TzpeqP8rLQvrdI5vaXSY1nJbHGHxiO++CsITodUR0eT/kC2rUmDoTNqSPo5EqxelDAFg+j4Y02+A59/s1virTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UyKQTMFX1mut5/H2U/CfaadEbA4WrB66IyJaD16oIQ=;
 b=dcLxT6iex1FoDKFrue6uu8T040Pt884AeBGzzd2BUFR3RaCpcGmQ5sH4+usmjW0G8Y3mUOvgSB5wRMO/iY4x26aqQcddXsSYRXnj/99tt7Gm/Heim41wTa9FuLTK6ojd3i/KqSxze+qloQHUAEJxT2H/E6ZiOOsGCFI+7jJkXmdRViOR/coovt97eWSF2u/1FU0/TAoJkywccnLvjZyHMuYvVIwjfnlTkWKEd6E28UVMIPwSfQAWz42WdVNzC0QRrp6me2e9vZsKrSKSJcl+FgNwX3QrSP3oCK270bQknNq5+SPhMM4gvZqqFvXiZ00kBlsCTruHo6nqk7k7IKd2qg==
Received: from MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::10)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 17:13:18 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::b8) by MW4P220CA0005.outlook.office365.com
 (2603:10b6:303:115::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 17:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 17:13:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 10:13:05 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 10:13:04 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Wed, 2 Aug 2023 10:13:03 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Gal Pressman <gal@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] vdpa/mlx5: Delete control vq iotlb in destroy_mr only when necessary
Date:   Wed, 2 Aug 2023 20:12:20 +0300
Message-ID: <20230802171231.11001-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802171231.11001-1-dtatulea@nvidia.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|BL1PR12MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 0868c003-c92f-467d-cb1b-08db937bc43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdONbFcQg/XDn/bSE8yzrOwELtztIb22l3ZbDOlzuDXq53xarGoMujSj/nHqWWXg/iFrAUAKZuMGNWqfC7OTBl2sw3VUwDjmFpBJf9Ao4+ajmw8J2GRoi+KA4OiSvsGskJ3VxSFuF2BYNj5YEcSmwl+DUNNdAXj5g8p8P0EGIBEJ4Gh3GSOeObrnzxNnrNkxKnndqgqpsnIaYZwzdWwOfnHEGwTDeqKs6/TrVv5Q/UISlITGwhtR6+HZAkZvXEcjqTduZXiebyZPxX+UcHY+yxPdQ6Y1XP2mydC8qfYGOiLXLPXOjnDe9rfKjqMu6+4yGYkyMrl6UxZcVJ73t0UkIOllXTk7EzByLEqWgW4ks7+zFOjtWvKDYlRK0IJzh4gyaZ7byTC5bcgOtA52oXk9BM0WUW2kSmFYZCybMxNFjdMtAlc88Qo0djSLAUTyMTSStXhKrEfJgZO7MDPoqZwOsZ/PXktTtwvYexGq0eP+IFrHKzOr8IKMtQqq3luZcHuKx3ykJ7MQ6GcCcGy1yUIb/NffXlQ8C2lFaNOKhQkAm/4bnCGcQtdJKlT1FdrL4mFCFXVoR+KiCfbbdvH91HXVIt2Fas6gLCdXYeI7dHxU2HzhrRmTsogaYU0xD6VafHyzoiGUHrE9663M9C/70yXAHiX7qLAXKpE1+o+ERXa09aNUXS2pI22HrGDOi9jE4QFbIJ/F0dPzMX68CYra/GFD+xb/gKip5YUMs7KeixYJl4Siz9sPCgMUObX8xFILmEFh
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(4326008)(40460700003)(426003)(66574015)(70206006)(70586007)(186003)(2616005)(356005)(7636003)(82740400003)(336012)(2906002)(26005)(1076003)(83380400001)(36860700001)(47076005)(54906003)(110136005)(40480700001)(86362001)(478600001)(36756003)(6666004)(41300700001)(8676002)(8936002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:13:18.4204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0868c003-c92f-467d-cb1b-08db937bc43e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugenio Pérez <eperezma@redhat.com>

mlx5_vdpa_destroy_mr can be called from .set_map with data ASID after
the control virtqueue ASID iotlb has been populated. The control vq
iotlb must not be cleared, since it will not be populated again.

So call the ASID aware destroy function which makes sure that the
right vq resource is destroyed.

Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for control and data")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
 drivers/vdpa/mlx5/core/mr.c        | 2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index a0420be5059f..b53420e874ac 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -122,6 +122,7 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
 int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 			unsigned int asid);
 void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
+void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
 
 #define mlx5_vdpa_warn(__dev, format, ...)                                                         \
 	dev_warn((__dev)->mdev->device, "%s:%d:(pid %d) warning: " format, __func__, __LINE__,     \
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 4ae14a248a4b..5a1971fcd87b 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -515,7 +515,7 @@ static void _mlx5_vdpa_destroy_dvq_mr(struct mlx5_vdpa_dev *mvdev, unsigned int
 	mr->initialized = false;
 }
 
-static void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 9138ef2fb2c8..61c10ba5e3f5 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2636,7 +2636,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 		goto err_mr;
 
 	teardown_driver(ndev);
-	mlx5_vdpa_destroy_mr(mvdev);
+	mlx5_vdpa_destroy_mr_asid(mvdev, asid);
 	err = mlx5_vdpa_create_mr(mvdev, iotlb, asid);
 	if (err)
 		goto err_mr;
@@ -2652,7 +2652,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 	return 0;
 
 err_setup:
-	mlx5_vdpa_destroy_mr(mvdev);
+	mlx5_vdpa_destroy_mr_asid(mvdev, asid);
 err_mr:
 	return err;
 }
-- 
2.41.0

