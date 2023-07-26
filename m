Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB64C763F39
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGZTIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGZTIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:08:15 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED641FF0;
        Wed, 26 Jul 2023 12:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBDyq0TjnmIfThT6UhQ+Qv1hQqygu8ANF7n7vnog9+j4soG4u/e0l2Zk4vKRGOkKTQLvrbrS0wU5tROb0Vh3dLYGpvB/vcqyzOEZcL0GgobCffq6GaNlVLc5ECostv+H36S0jCF7zVWAytYm1hpwAupbeOKPy3ex4SCjwWqoA0D95mfCMvIpytPaNavtaOBQOJu24yUPfLUld+dWGOe/32wDO1b58Ndx4dFmpcs2TzXGaKgsFjzo0lAC59HyEFxsjtJ9oSbpiGO7l6ikczn8mPZlIkBYicFQEMDRLu0NvaCmntUD4eTZsTRq172x4xKP0kOZrouXVGw8GGgsFwvhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctEMJQXxU1YrxWfZTVorFppZOOwOBONb1ZOX+88AcMQ=;
 b=CspYoJ3waTBklWNt+Zj9PMOCv3sqR+OnavuSBsa8pva8dEiwxK7nyztVrjRYD2Cu5k+Yy/WULRf6HTKWClFCQwhqABCMWSynoh+YKY/Y65PtdC7ePZclfZ+k/byw3ogQGx2jWuu/vRYtJEx2apkrLbNvfbjOvq81Cadx10rSYdqE9rOjxqigajRt1NfqfDfku0MOzd4FUlDuvt6mgkg98UAjOaJwLkeFKbcpGBdppAjY6ErgLl3yGw9+Vna/FF24+ZKxdUmKsoyNtjEEtefv+g0BBS6H5NldkA+f5WK+EZy+OedYew1H2nx4pcRbUOY2xkyU0AuZfjU2zSOMAojsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctEMJQXxU1YrxWfZTVorFppZOOwOBONb1ZOX+88AcMQ=;
 b=Fj4CfkdqX1OIq2PaKval0Z+t9EulsV7QiZri8692MAO66vA8MFTLuc772c1Qdtk2faqyultzyGpBgBtD+/E3HZTgGEKQG8pnxP2Jxft8/xOLkl8wmAB0etwuCpksbT9n6XvoMYw/MDw+oj0KnaLKWJ/MdlXfaMOsKTi2fiVmZ1Y+Z41EMED0kQYtSG+2bXJrZn3nZLCRc+YSsw4WrbUkzWLLL/y0ccgk1Y/r7XjTDF3z6P7T9+epN+LXtoPmDgxPmZmW7+jUE8+c0pR3pOKbPPGyhL+5UH0pGYzwmmO/FUvhI1ggaBjW32+9UeHES8j1zf6PPBC2SdMYPXas4wPF+Q==
Received: from BN9PR03CA0383.namprd03.prod.outlook.com (2603:10b6:408:f7::28)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 19:08:10 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::6d) by BN9PR03CA0383.outlook.office365.com
 (2603:10b6:408:f7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 19:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 19:08:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Jul 2023
 12:07:57 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 26 Jul
 2023 12:07:57 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Wed, 26 Jul 2023 12:07:54 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Saeed Mahameed <saeedm@nvidia.com>
CC:     <stable@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
Date:   Wed, 26 Jul 2023 22:07:38 +0300
Message-ID: <20230726190744.14143-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a8a75c-3857-44d1-730f-08db8e0ba694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9n/XBiwLxQw2+W7Q8I7UUhXXf/plb7vV/KdZ0uAjRkQiabQ3YygWaQuVC5DTeRr3GHWZai93N77LJcrLks6jmlpev3oUATANDsAcnZY6oHERF/xfPYScrfzBhUb18CogO0K5NyQlSaHyI+wdCw4U8Gh3V21QGXV7gH+cf1xpM7dS2lpvLH22BsYZONxzN/Uo4EH/kajkVcctn/8+lcrr0jU2HIvmnYv54Wn9Gcmlb66tqjON094HAEZzdGjHtDhclAfCC+AQte5pKGs7vCKANBF6Fm6HN6rhzuBSfje5IftOMJoV/FVEe8QMlXlzLOTvWyo1kmRHgtYy/ZO8YUl+ZmDE2D3S4ifh8ZnUaxNxc6cY95lWPA3K8EUPtSbv9bLGFJk6PzvVKd8H1Ci5cdsAIxr8ZDtIi7mXW5LG0Nu9X1XxRXaHfWR0mkCqZGJTqDOnLsIafiB3T78keZZB9jjj1LbWTD4Ex8ApwBI5Zf6WVv35mzTAv4tbs98rajTT6kkfM1513bcs0psvG39bJTgRpfr2ZHX7XLs3U/19eZfWeYPckXRMRjmFhDdc1MJdQTETxI63eFGdPsgdN0jDNRvbYr383No62ofJMDhTO0pNQXq0jMc+/gSrele5aiBMDMMN4yFGWnCw0iaDp1XpCrCgIv7uVl+DULgELe1h4g2EBHkc48kr/nFuCTQwAeEwVDlEa6iUHttEC+dRdUesk9nO66kHCZhRa3ektwiM8cmExs=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(26005)(1076003)(336012)(186003)(2906002)(4326008)(7636003)(356005)(36860700001)(5660300002)(47076005)(426003)(2616005)(40480700001)(316002)(83380400001)(40460700003)(41300700001)(70206006)(70586007)(36756003)(8676002)(8936002)(82740400003)(86362001)(54906003)(6636002)(110136005)(6666004)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 19:08:09.1713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a8a75c-3857-44d1-730f-08db8e0ba694
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ndev was accessed on shutdown without a check if it actually exists.
This triggered the crash pasted below. This patch simply adds a check
before using ndev.

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
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 9138ef2fb2c8..e2e7ebd71798 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3556,7 +3556,8 @@ static void mlx5v_shutdown(struct auxiliary_device *auxdev)
 	mgtdev = auxiliary_get_drvdata(auxdev);
 	ndev = mgtdev->ndev;
 
-	free_irqs(ndev);
+	if (ndev)
+		free_irqs(ndev);
 }
 
 static const struct auxiliary_device_id mlx5v_id_table[] = {
-- 
2.41.0

