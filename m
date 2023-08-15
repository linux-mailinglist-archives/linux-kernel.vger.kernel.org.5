Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097BB77C96B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjHOIeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbjHOIdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:33:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B91BC9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrnjgRRo6ekO0e/Q0XK1v7Vq9kOrirMCXkBZiE8raTDOTRf5ujIeqXWx5Y9fdwZKKjesHUcW6H8E2JccvpSQLRAX/bHgLpKg2/7sI2XVB6of4jdvT6L3HSMrr9wBP4H9iDPpNF5PS836j+/aiYJt0QpwXutu27KoNAd0+qpxyotPnGYfAX9esr3EuE1HQro4RLKY3q8DUy0ZHedIj/kWW8W8ZI39pfQREu2s3+dNhSp92bARMirm/fwAne1okZMQHTp0PdoW4hRyOb7UcyN8vUSsFt+3Lr0djS5Pl5zHJW7ae+YtZdiIAZCsQgLIVVlGhwHqErnq05xt6SR26W8GlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0dYUZmU9Urz/A4aoUXEWRrUeIC6jdHgJfqpVQ1Pcds=;
 b=g3LIvCSIHIzZ9fQzmouzFAuzT3EBkybParcHHzoTBrtmkU7Vhg/E4h0mqJFn0NGc/oFk/6TeDhyXDbc+O9Zx65PilbtscGPLFUQKwi3iALUV4++eWsoU+X0Vmcw2CDquIsZnVeXHXMUk0/1V0F4f7ko/VCwcVWHk9l5ZlLtGW/zeICUhqpU92kL+bAenaZ/si+zR2fj1vmtg1Tb2ct3EG6TEAqXIkJpaKKY9yNVzjPsBWEuHKhT/E/KRpQZISiUJizZypb7rFzaru6xF+a6wUWVGL7QAB2JxyR/bTqN9O+rhTip8xmXUNweGfxcoR3IsD8+qqfRS3g89ZSGX3l1nOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0dYUZmU9Urz/A4aoUXEWRrUeIC6jdHgJfqpVQ1Pcds=;
 b=Vnld7JAXLHqb5U4gcW5YQijie6CBDYOR8CAo/As9Vjfro2jZtP5axy3JtiKd6r79akKDaS69gk4VnLBKRQO9AoRBRz+braUz0EU9CAvowfFbjHwANiQbpUFtgrIbmzYdbf2mLXkEy93Wo7tpUQoJuhDGo/M275qBX/3GpZ5XmEY81uKkQJ7zFblLindwvgZzA57VMA15w3voxRY00tayggV10szYtm19bkE57thUqTPsS0TaGtjpHCxkN7IjBJrqLdzLDUQiNoaLx7nR2PpLIfCS9mqaJVxw6yggpe3ZzGWQPlrTnlc4r2HF82GvA72EgcCrDs+6gMe7ue72e5FYIA==
Received: from CY5P221CA0070.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::40) by
 BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 08:33:38 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::19) by CY5P221CA0070.outlook.office365.com
 (2603:10b6:930:4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 08:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Tue, 15 Aug 2023 08:33:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 15 Aug 2023
 01:33:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 15 Aug 2023 01:33:29 -0700
Received: from c-237-113-200-209.mtl.labs.mlnx (10.127.8.14) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37
 via Frontend Transport; Tue, 15 Aug 2023 01:33:27 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     Dragos Tatulea <dtatulea@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Add myself as mlx5_vdpa driver
Date:   Tue, 15 Aug 2023 11:33:14 +0300
Message-ID: <20230815083321.533688-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|BL1PR12MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: bae66550-c863-430f-c279-08db9d6a5268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kww8/y0q0lzO78pA/eRTKcSlFJFh4FQ6CBJgHRdovssQyf6zAwOjcsykRroH4YYE3Gh8hFmqOGmNrs3kAr4yoh2UgM0x9VNjWImYZhLHt5CBGvaUbt9FdC5mfzOn9tA4ZqaR8YTkWEDlDUCKy9UV1LvREHHpM/NsrXLmWMSm0UOt5AE+8dqRa7bxdrAjLpQ6VFYDvtSCRSxDQ4TvR6FUOWL874lHLi13GfC711jmoR5bMwujkyPGzy8A6+Y4XMkW0ASDl/7WPmmo8oyDowwLHKvXW5q9XvspQBMyf8Mby5GhCWqkIs0ajdmUAC43tGZwqEu83qcm7JDzxWqyIxfM1yTCL9nHZBYHO5w7kZOP0ZmgT12BbWE0ZMJ3mwxSaNVbY/SojlZ+WdH6Ug5Pm9YfXdaqMyjudLvliKAzM0r0O/AepCl+0dqmLEvj4mLhtqS1X3mXfGy5XtuBKimoXp1tHtAq5nIcj+1So2e+LMPZ2hfz/EcEDlNkZh8DDw52DMIyIZb7odYo7PssMqrFu+Ho3r4+hhzSaTA2K1eOHJa5z2EeUU/XDSWKGFgnvOSE/poAO33rJxu7TlPO+hahlNPdhGVhIBZl9RYECGf/GMy26Pp9gYkUpg3HMVHA2PXOCYHOT2x9SDspJY3VgMvZexIO1k0OUdblre+hH1Uc41SiAFNnx7GoZuHDI8oeVg7bN7KcLKD74/KvUBrYQNCQAnqY08Jr6zhQucVE/MO4/a15o1h1C0oardY91ChzwVenhPJr
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(82310400008)(186006)(1800799006)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(82740400003)(356005)(7636003)(36756003)(86362001)(40460700003)(4744005)(478600001)(6666004)(2906002)(1076003)(2616005)(26005)(70206006)(426003)(336012)(316002)(54906003)(41300700001)(110136005)(70586007)(5660300002)(8676002)(8936002)(4326008)(36860700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 08:33:37.5873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae66550-c863-430f-c279-08db9d6a5268
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Eli Cohen moved to other work, I'll be the contact point for
mlx5_vdpa.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a5863f1b016..c9a9259f4d37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13555,6 +13555,12 @@ F:	Documentation/leds/leds-mlxcpld.rst
 F:	drivers/leds/leds-mlxcpld.c
 F:	drivers/leds/leds-mlxreg.c
 
+MELLANOX MLX5_VDPA DRIVER
+M:	Dragos Tatulea <dtatulea@nvidia.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Supported
+F:	drivers/vdpa/mlx5/
+
 MELLANOX PLATFORM DRIVER
 M:	Vadim Pasternak <vadimp@nvidia.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.41.0

