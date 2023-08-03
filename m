Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6EA76EE0E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbjHCP1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbjHCP1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:27:22 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0625F180
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKkLvFY7BqKPLG975lpGagdfqSf1+EhsuCMF0KI29MfeHRYJ20c+Mb39TYhp4yu8DO490DoSppJkiACKjlrtozt/3jasb09GyszUm29qVytP0hoV+Qkky8BhdGg5gyqcQL9blbmrgYQ3XigmOEmPFlhl52iQJ3yH8513HA/WVKKpUHrkEg5Sa0N+wIR4Owz3bGicH5qjr369upfvjlY3h7tmzXfkr11YfmWbr9gXYmGUxZsCq40POHBDz/Dh76St9QAI65RKeO/3iE1uQtVw5s0guL5Ab1ININxX5n/xGJDtxru84qUblmEzua3fFPC/THWxsulfWK3Sfm8i9CcERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AAI0b9+DSICnzsdSKwSKFq0Opbm7ngj3LZFCeufp+E=;
 b=TqajpwwzA1MPsPsVWD989MHFOPmUcVUqRhs8D0kKLm4EyTyTZriBmuhrHzBTwhPnX3Jp/G4OIy04K1NgzplXAdiUS6DFCbBXAuTU1/jo5tIrXQRdWxLJg7fT98im+GNZrPDLzskvTsnGMiKF6+OWrwh3JGKvktqj3Qo5Sw6hemRwaSTFfp+6rckFvmWJXayiHKanlfYybyAGYE1/+mKPjZKxJHkeYWAoyMftFx4dlypsKEhGW5U9GtGPRTgt1tc0Mg//T5FXecUH013Dh8ICW4L29SJ49OgIginPfwoguZwAaVfzso+9c5ni1Ha9mrDJ8LDrhC7L+5t7OYvJ5z1AcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AAI0b9+DSICnzsdSKwSKFq0Opbm7ngj3LZFCeufp+E=;
 b=DG7sptt1h8qq2l/hpHhPL2Id03K5qBefmPnxmbZfQhkpvGqrx86pmCwG/8/iENqKMui6K7gsZ0TyxSTQI9PLupde6j3HIwLkYcxoniJsH9JiGogew0SSzg6S3Z3Mu4vYjk3T2c93nRuwEFqOoxpkBTO7eHzk+6kUg8Nb1c14YOvgpN01jWFkd4vv74jtaNcNb915PzqDZYocKygwSvQDvkCAYESOXViX/kmqNkKWNHVoj7mTDzINRxV6fV97oKpaqEsCRUfgaQN/BcZSFMdZjNnX1OMtIUu/dG0h8yER8EkEdzyVDIDHSYrRnoHzj9PYxz3uljR0U321QcyXrudAIg==
Received: from SN6PR16CA0062.namprd16.prod.outlook.com (2603:10b6:805:ca::39)
 by MW4PR12MB7382.namprd12.prod.outlook.com (2603:10b6:303:22b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 15:27:18 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::8) by SN6PR16CA0062.outlook.office365.com
 (2603:10b6:805:ca::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Thu, 3 Aug 2023 15:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 15:27:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 3 Aug 2023
 08:27:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 3 Aug 2023
 08:27:08 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Thu, 3 Aug 2023 08:27:06 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Saeed Mahameed <saeedm@nvidia.com>
CC:     Dragos Tatulea <dtatulea@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
Date:   Thu, 3 Aug 2023 18:26:33 +0300
Message-ID: <20230803152648.199297-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MW4PR12MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a9d43b-a506-467f-093f-08db94361fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJj8lrvRVfboUsBKGX3gjS/Y7urnTGHA3tvwADSXmP1lNbeWG8Ylieci6wXAQdwY3a9rVYqF/Uys+hUnlWHv9EqJayaslbTtRHY21Db7iT5Xo7+mB0SpsSp2E6pAz0NKEsI7eIHVqRTDH6zpuL9a2vQH+eMFh/BNG+2cxyRH6wtgKYET/ZJzBO/H476LUEfNsPVM1a28IfrYmC3uwy0bUpq60uE+cIBBShPFn6i2tq+NjhD8s+0+KUue5QhbE83t7yGnW76s41pv3WlN8cSpp4oSfYxxF0gDFz4e23n5ZJystW4pAuldGEF75AfjZbHAh4AlpO1ch4rYhp/JpEFtlMUoVkXjdRecBKPuQR7mzQI+eXVsLEWn1Cyq7izTPfskl8VZqOjHrOyLQk+Gb94nn8c86l923TGWCXIv//cgvL3iFhN4iwkcOIpCowgYJ9kYCwIBUGsotBNcexqZr9dUebcbE+a01D6aDj3SRwZjz/kqaXRjDVctKU1m6iCYrBXMNui7s6YtwiAky9q139ijOdseRiwIi+oqjopLsIjxXEyeLHxrSK+XXm5iBP3rWvK8vM3wpaPNmtDTRrr/SyAZgfqkMAe3T5nZaKsAyIbHzqYVvLH4DppabigCKjPVlc9ZS84Km+9SXTMrOTSZe7bma72InbS50+6o6924idfZNuXClGOiad0N+hlCT9L6nvxI72zoUMpjcIE2i8FqPd61FI4bn4z3Te8Ai3wmvcOi4j8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(40460700003)(2616005)(1076003)(426003)(336012)(83380400001)(26005)(186003)(47076005)(41300700001)(8936002)(2906002)(4326008)(70206006)(70586007)(5660300002)(316002)(6636002)(8676002)(6666004)(36860700001)(478600001)(54906003)(110136005)(40480700001)(356005)(7636003)(86362001)(36756003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:27:18.4457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a9d43b-a506-467f-093f-08db94361fcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7382
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ndev was accessed on shutdown without a check if it actually exists.
This triggered the crash pasted below.

Instead of doing the ndev check, delete the shutdown handler altogether.
The irqs will be released at the parent VF level (mlx5_core).

 BUG: kernel NULL pointer dereference, address: 0000000000000300
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP
 CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 6.5.0-rc2_for_upstream_min_debug_2023_07_17_15_05 #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
 RSP: 0018:ffff8881003bfdc0 EFLAGS: 00010286
 RAX: ffff888103befba0 RBX: ffff888109d28008 RCX: 0000000000000017
 RDX: 0000000000000001 RSI: 0000000000000212 RDI: ffff888109d28000
 RBP: 0000000000000000 R08: 0000000d3a3a3882 R09: 0000000000000001
 R10: 0000000000000000 R11: 0000000000000000 R12: ffff888109d28000
 R13: ffff888109d28080 R14: 00000000fee1dead R15: 0000000000000000
 FS:  00007f4969e0be40(0000) GS:ffff88852c800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000300 CR3: 00000001051cd006 CR4: 0000000000370eb0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __die+0x20/0x60
  ? page_fault_oops+0x14c/0x3c0
  ? exc_page_fault+0x75/0x140
  ? asm_exc_page_fault+0x22/0x30
  ? mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
  device_shutdown+0x13e/0x1e0
  kernel_restart+0x36/0x90
  __do_sys_reboot+0x141/0x210
  ? vfs_writev+0xcd/0x140
  ? handle_mm_fault+0x161/0x260
  ? do_writev+0x6b/0x110
  do_syscall_64+0x3d/0x90
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
 RIP: 0033:0x7f496990fb56
 RSP: 002b:00007fffc7bdde88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f496990fb56
 RDX: 0000000001234567 RSI: 0000000028121969 RDI: fffffffffee1dead
 RBP: 00007fffc7bde1d0 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
 R13: 00007fffc7bddf10 R14: 0000000000000000 R15: 00007fffc7bde2b8
  </TASK>
 CR2: 0000000000000300
 ---[ end trace 0000000000000000 ]---

Fixes: bc9a2b3e686e ("vdpa/mlx5: Support interrupt bypassing")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 9138ef2fb2c8..047b069a5622 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3548,17 +3548,6 @@ static void mlx5v_remove(struct auxiliary_device *adev)
 	kfree(mgtdev);
 }
 
-static void mlx5v_shutdown(struct auxiliary_device *auxdev)
-{
-	struct mlx5_vdpa_mgmtdev *mgtdev;
-	struct mlx5_vdpa_net *ndev;
-
-	mgtdev = auxiliary_get_drvdata(auxdev);
-	ndev = mgtdev->ndev;
-
-	free_irqs(ndev);
-}
-
 static const struct auxiliary_device_id mlx5v_id_table[] = {
 	{ .name = MLX5_ADEV_NAME ".vnet", },
 	{},
@@ -3570,7 +3559,6 @@ static struct auxiliary_driver mlx5v_driver = {
 	.name = "vnet",
 	.probe = mlx5v_probe,
 	.remove = mlx5v_remove,
-	.shutdown = mlx5v_shutdown,
 	.id_table = mlx5v_id_table,
 };
 
-- 
2.41.0

