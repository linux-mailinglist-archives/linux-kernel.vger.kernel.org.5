Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A25765B14
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjG0R7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjG0R7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:59:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312F935AB;
        Thu, 27 Jul 2023 10:59:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLBHt4hPKbCinSugMWxH95Cy41Mzg+gc041xHc2BPc6DpUiBgCN24p7atMrrfRDnDVBNqNJKMEqxcvPvGd0Id4qtQNipw8KFWUiC3NVnLAm6mLqzzK9cldID+ZNiOJ2Z/obWKdO3nxYUxL/qpGEuEE6ZUoYrhxWs/maXGqtfjPcIyTHCh2ARVjIynhoGaJ1eB7fh8bBr9eHm69kjE58Z4pEA5t2p0gfVaYvcOJzgq5TlK98hBKRy7CX0OqEnBFs7NH5kjsw/MG5vEWo5qo5DQnCf8oXvdgk5oFtNgTRGe1dbMK4fd2ITk4vilLpcA9s2LI8lHMMldq/A14qL0HpPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWZ4yQYXvfaU6H77EQjQMAfKQF5C9n/gZM5EhbTLcqc=;
 b=GmHjzlLJBqVV7LzeznmMyAwqI96bnafTX17cbbAQnxjbsY7XtZs0+mrVGTznrmi73htFekNIMfd+ykjYqflljRXkee/8eZCcbxlVQHWfk8aSKoZhWlEVbUHdQbr8mxonchMHFMz8iQg4HUyTUMlxUbbAetHYHTxDanU7XPwEGq4BrxbzwOzJVvlkIGaCO/7AROb/JqN8SwgLX9wwKvrrfe8yfrjsFy0u6lhAV9NUQSDxcwRHrtsHoOB+hA86dDz1E3xyyxLFo1jEa5WdA2vXcmCFhtnK4HrgXHZpjGdYg9qSFCsxk7iFX1AMLEuCZx/LSbMHEXV7Vh65R0aloZlkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWZ4yQYXvfaU6H77EQjQMAfKQF5C9n/gZM5EhbTLcqc=;
 b=D2mACUu93L9Qnx/6UXi8Pnmj/hO+ZSzaM0JkZJX4x0J+zCXISXFdVyJ6AaNuZ1bZB9jA/ttDS6UnDQUbuG+0ZfXGXEctlYIyjR22/VUW8Os9uzQBI8sfZa8JjxJ6pWRdkbdlH+dUIU0S9iAGi6fdwIEEakQHrWDcRV8xdWVgLh64i8E32XnJirhn1rJUMPcGsTfmmDLs3cVfz4Fbg1yH4OnMgskEbUb9+u4EE9JnpJUgTfJ/NSR4jB7sCMKhAbdtu/RHYq8k886rfZS9wi69xCr8rbYbFC8L7WDJHfhdFsExKtdT0y4Z+rJQ0jRdOTMjfS80JwksQ1dJ3rNDfFqfoQ==
Received: from DS7PR06CA0034.namprd06.prod.outlook.com (2603:10b6:8:54::18) by
 DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 17:58:58 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::c3) by DS7PR06CA0034.outlook.office365.com
 (2603:10b6:8:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 17:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 17:58:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 10:58:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 10:58:43 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37
 via Frontend Transport; Thu, 27 Jul 2023 10:58:40 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>, Lin Ma <linma@zju.edu.cn>,
        "Jason Wang" <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Parav Pandit" <parav@nvidia.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Dragos Tatulea <dtatulea@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH 4/4] vdpa: Enable strict validation for netlinks ops
Date:   Thu, 27 Jul 2023 20:57:54 +0300
Message-ID: <20230727175757.73988-9-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727175757.73988-1-dtatulea@nvidia.com>
References: <20230727175757.73988-1-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 8538c0bd-97b6-4a3e-103e-08db8ecb269c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LBrs3yQ3ouZULM0fesYh6lwNEi2hqv5uXSP1pbGSWJ2VIKGU+rNKSqBdDD9TZLc1D1HgOKzYTu22jTHObw8Ucqxkl9pfJTD++ofIRtKDjgRNGUwNzLO9OUzC20plowtqr+/D1+1wC0bFiDfdoKQtJMkb140ToEjlRf1CZxGJ4AAdZOaJ6HUv5KMXp8YpuUUBNlyyBMh6n/f9eKfYH9M+RmN9LCKUulCCKgoa9+WtRcP7DSqJVa2cp80CptRTc5itIHDyXqV3Zn/ulgrtZEkJFLoX2xPHmX5R8KDd3olLY043sEf/8N18ZZ9i99FH11/Xg3M+pAjHvMccwEDGMFcLlzchWK1C9WE73zv0OtqA6N+O6RDj9cim6ju0PZRZXVruKlGLbQKMJuw2rXSfghGT5EnQyAUyTbRg1r7sPaBs9nppbIQct8GOCOwgbvPeIP4WNnkiwb7qTjrQmp46F8YeJYDg1V9LQgDiGFbtcYzxb927dJptO5PWmeIRgDWoFwBTwtXTFzTfVSV0XEF/z/YvI/MeRbW7PsTN+Yqf8vTjcH8apb4eUQ9bXWFrsh2kSi9u0oeuJoriK0jEC9z6T8hkguNKJlE5DMXXC9KsN9XSnGwNIxcSEKul14qlKSVF8JnEYaKkuAzSfYUwz0SnfKEXxTexr2CjXKj5B/CO5bHA0GYPVCNR1F+0VqybzvkWjNJidw3+/tv7lKfxZdLGWwu2ypgjVzVrXRVib0DGcqpEsRM7avHnClsJfdQ/F5oxjVUn
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(54906003)(110136005)(6666004)(2906002)(7636003)(40460700003)(478600001)(82740400003)(316002)(8936002)(5660300002)(8676002)(41300700001)(36756003)(356005)(40480700001)(4326008)(70206006)(6636002)(70586007)(336012)(1076003)(186003)(86362001)(26005)(36860700001)(2616005)(47076005)(426003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 17:58:57.8449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8538c0bd-97b6-4a3e-103e-08db8ecb269c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patches added the missing nla policies that were required for
validation to work.

Now strict validation on netlink ops can be enabled. This patch does it.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Cc: stable@vger.kernel.org
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

