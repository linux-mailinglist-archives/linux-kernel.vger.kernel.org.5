Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC5A763F07
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjGZSwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjGZSwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:52:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ACA30E1;
        Wed, 26 Jul 2023 11:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CymFOL+xyVi/V35jVe7QFDic8ETkT5/koHwxTVzbVW3GEYfqwdW0iMjHKOHd2970rEVffVpuJc/Tat9de1V3enSkAdtHRQC6okW65bi05e5IlEojZ2UQEr6/kWxlKgqmuFJiboMCoShauJzjMPLCc5ettvkTjesE63sR4ENjCjVABM+M3drdxImpeU1vlLACJziTHZ+vIAD//jbF1hCzGXIgIFuWf6rFUv6orcK+BHe8SMJ5wnBsKBlLvsI5za3/+A2+RQF6VJRhN3S4aD0fahYnW5ZeUQhdy6fPNi9LOIl4pBx2A71fSz3qGYF1bqfAYFnjiv821gko2LSaEkDyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NesKOVXikCLA4XF5mUs58QdvbPAAsWL7QAypABjWcLU=;
 b=ggFjt6WZLSlydDC6+1I2CmhdTStg3pZn6w6myNWpJIkbfi1jWDhXAWPoFjZfR2FxFG1uGUbEl1loWkwS7x1tugrD9i8KNL2Mp7q76zNUUxk5ztZDCTw/c8AppgdVOvEbdXWMja+4AERLWP8UaeercUqjyGhBtv38gYpBf7ITCBNZEaVvG6kbR52kA7NumcYHPzkFOz+BIu9Manq4PyI1sWCwRHUG+B7piP6HdCkRO1R5l+xPD0D+APDyPkkxtRcjLukj1ueFhC+oMC+5bF0qpZqpVTfD7vbEMkZQE9FTyYM1GdoGJTnQKUapWUb0+DD8kUCJdtWw+APE1A6bLNFADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NesKOVXikCLA4XF5mUs58QdvbPAAsWL7QAypABjWcLU=;
 b=QTY4s8UsOHxnzKZtSfE4/NFtzVU+IpyG2bugPR3KCFWvuAfPAh5EFDY8XXm6/aSpX+Np5T1dSH6U2pTy6g7bdQUuwN5YgTjq5QxAhJYpZWWMT0b7fYZ7fCCuPkstmd2kBUDjzD9599mM+wyu52N7kTIlHI82wU1njNigKhVp8ZMUhllVpSDK/8M/P5mDHtCTQgCbdNzDx922XeWS8MOa2gfpAn7dgNJhgzqHfXfFY6S9cO+o7u8Bv/cm0v1aCKIOCvnzRpNnY2/h/SOr3SQwTqrljT9wA6sHCPjz+VjsbGwDuWDvHjyRWfaqtoxXX+2cgAl6Dl3k5+FS0snXYMGbcQ==
Received: from BN8PR04CA0033.namprd04.prod.outlook.com (2603:10b6:408:70::46)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 18:51:43 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::2a) by BN8PR04CA0033.outlook.office365.com
 (2603:10b6:408:70::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31 via Frontend
 Transport; Wed, 26 Jul 2023 18:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 18:51:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Jul 2023
 11:51:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 26 Jul
 2023 11:51:27 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Wed, 26 Jul 2023 11:51:25 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>, Lin Ma <linma@zju.edu.cn>,
        "Jason Wang" <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Parav Pandit" <parav@nvidia.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH 2/2] vdpa: Enable strict validation for netlinks ops
Date:   Wed, 26 Jul 2023 21:49:44 +0300
Message-ID: <20230726185104.12479-3-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726185104.12479-1-dtatulea@nvidia.com>
References: <20230726185104.12479-1-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 90135bd9-2844-4ad3-5cf3-08db8e095af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7Hr9EnvY5vtRoXYMeaXnR9qJ429uzpiIGLoeSJJn85Y94Tlbd6jY3mHuuXUUlMIQq0RS1tDA9o9SNVHKTOl0StFP2pjkCTwDg0PtK16Zlu8y5SHr8r4Z4QqP65ogRKd3+K9qrs09OxC1vr68ZwzJk2qvIJnxwiAm7WLYTXshZ7H36HkBZN7DiA6ab5ho5qVI2X0oMZkGBvLJWvePf6d97Oz7vN68ZhAFkODRnoBUE06aCUpyYvHZTSeRR17SKnY3/WpysZ3A6GvGgJPPGXjjftYvxPBEVxgGG02hRG3hZ9aB2lWDBwBJwMV0xxwu/hKIx/rSc4BOwW5h8N8N6SPuLg2yhdnyaioGcUmaCvQGqmZt4wafrczFzaxcv19Zt6ea0veCF3CXyDFNm0P0+X6OM/5W6UU3bXe44KXUOooWT0LCPlilt6uhnUsXBrUUbyyjf8S2Juz1/LhFvLcQC3camlwxLTuvZjFSwWUXdcfQuVark5tu0/jor6hVjOwEA2Bl1aQEhkNi6idb0ZuM4LCt+0qF8t1UCjLILVQRy2K0mhZoz5vf5njay8MyBOsKHeyyK8udqdyDlkGtvMkO9GJNLnUN4azdHjR++8mMwTCREDzCJAxJC1P666txbZ6xUG/abCl7scQrvnkkY4XCdNOX3o9xs7nThymvVaQ4mG8nBbuKoTP1dBij39vOu5Zl3wN4tj/Zm1J+x0X1WdVCapkun6bZE/wpv9JPGbe1ls7eONaJEmsMcW/LZ8WkT1WMuKF
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(336012)(2906002)(1076003)(26005)(186003)(356005)(7636003)(107886003)(36860700001)(47076005)(2616005)(426003)(6636002)(316002)(86362001)(40480700001)(5660300002)(41300700001)(83380400001)(40460700003)(70206006)(70586007)(4326008)(8936002)(36756003)(8676002)(54906003)(82740400003)(110136005)(6666004)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 18:51:43.2643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90135bd9-2844-4ad3-5cf3-08db8e095af1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
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

The previous patch added the missing nla policies that were required for
validation to work.

Now strict validation on netlink ops can be enabled. This patch does it.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/vdpa.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index f2f654fd84e5..a7612e0783b3 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1257,37 +1257,31 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 static const struct genl_ops vdpa_nl_ops[] = {
 	{
 		.cmd = VDPA_CMD_MGMTDEV_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_mgmtdev_get_doit,
 		.dumpit = vdpa_nl_cmd_mgmtdev_get_dumpit,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_NEW,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_add_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_DEL,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_del_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_get_doit,
 		.dumpit = vdpa_nl_cmd_dev_get_dumpit,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_CONFIG_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_config_get_doit,
 		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_VSTATS_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_stats_get_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
-- 
2.41.0

