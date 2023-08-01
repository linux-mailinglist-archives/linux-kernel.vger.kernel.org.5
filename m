Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C0D76B46F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjHAMKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjHAMKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:10:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2964A1982;
        Tue,  1 Aug 2023 05:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvMgITCZYbfJumqVaQMtjOB9/8RBE/fMxi9Tebzv7jHGGuCuNRsfrFZNQEIoN12w6E3IUCme5YEZaSVIGQ8UmsKSiQlSrsk8IAFnc9OmNZ+fps2HCpppJBhZL/ISP1sjl3bG+f6nsvu+0zqMPJlLTPWfmaOjbFVuJxWiWDqxjJ5PHrntbBLFysNmLGbOFe0MRfG/amBU4xjD4Xpa6kLhTnftY1oNmeJWM6LLqEDneGgOUjg4QboqgXtCZEzSrJlHMF0FnNnAydnlpQ6gwNlo/S+4+Ttrz6SS6z62VetCTqnusqHYlFoHyRnuUE8hG9Sl80vFLV9mGwrXtRt3LfTM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuCuYizUkfvDWba+8DB+ujr9FBfshAf5oPH7He5U1Pw=;
 b=g0PESqrT01teVPTHvu4u0x1XUrKFNbisGgF33H35cfu0EdOSxVGtrwA0MaTLx8EX99nJPXbyJf5Xg/LQ2RHcDc0xYlQKkCRWnIBlTul06vEpm3iI13rqjo8EMEDE2ksa3XmQNY0E0Lp1KzhoXXD4QspwFHcy5FMoajyhOBxAGRke5KUe6zgB8Rk/Q+WJWEPI44vwRGu7sK/VvYNkKf8x7tfSLr8nhIZ3yGf4BJYG5cRj3Tzi7ocKH0fIpU0mns42/qVf/gDuBogTXbv0mx7x84j919+21fcJPGBxF93lF15KNWvnmCPoWRfmvf2V9IpGAHxWkwEb/W70jVyYDCYYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuCuYizUkfvDWba+8DB+ujr9FBfshAf5oPH7He5U1Pw=;
 b=EzIQmohv+21JVnBBe+rfdmJ61+lq6WvjfBa+OL3iJtlsv3uBNvrgKgoCnWxqGdwNGPQljdJtVgAVXrzWeQ8sJXFmPuOriMMBKLNrSPMyI1r1ewAMpP0tW6ki4ODIBO6qpZTnpEPBA7pPJ1hxv+iyQivhH6KhpkdJHoN1MNL0OxL/Ibzn3tOc0xJzio3ic1Zg6iREpf7LHESrMeGJVqaX0CoXo6+04moM+vinGUZi5r1tgBkd5ajwKyvQPsL0qMUsUbb8Q6fjQXKCfjgtj4pFSWsAIT9FNHtu7H8NBTp3G6ThbBqxD/aOX45tHFsGv7PFz/Ls63+oXJRBfZrusBbm9g==
Received: from CY5PR22CA0099.namprd22.prod.outlook.com (2603:10b6:930:65::24)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 12:10:41 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::8a) by CY5PR22CA0099.outlook.office365.com
 (2603:10b6:930:65::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Tue, 1 Aug 2023 12:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Tue, 1 Aug 2023 12:10:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 1 Aug 2023
 05:10:28 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 1 Aug 2023
 05:10:28 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 1 Aug 2023 05:10:26 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch] memory: tegra: add MC client for Tegra234 GPU
Date:   Tue, 1 Aug 2023 17:40:23 +0530
Message-ID: <20230801121023.27841-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: a98d1820-eacb-4ff5-fa9e-08db92885304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUfx6dpO102xxMEVdnoLRr5JezI80InhjL25S7X4RnidhHnnmNKZl/FBjStdIxR0i0yapoHOFMOprpdBIodzFbRKcmkBYexlbAaZQDl1KH4Y3W5eJEa5msuihx61TI7LyCcLURgHbMTYeZzx/kyxbobOiN7Pxi9RhLcx6mt5tORw64MUvTeioIVdb9u55LD9cyjwggg83SEg/oj6mXv3/cI6HeiYDkMqgqNBE4prhPnbh05MrLsbF4VV2U2H2DmK5TZdP76eWfqy1pPjdUNCSPDOJb2qDSlY4U6nSnNyZz03BW/TpN3FrML19MJcVn9O7FJ0FZBUgILVkPZ/nmrivVt95AB+uP+Np/W+yNjfAgX0VHBkMTq8mdzSVyeL8EdbE7Xe9/++1lPDfvlitEvtoys16jICf2lyh9kK30CkVIFXrpxWmb5yld5M2+CVXTtPzf6epqhP/Ajf7kSwCjTJMrgEtFHPI2ZIf4NNnvEYrgNS85UpWRyqj+Zl3mYB7+HphfjnY4vlnwhDEOige6EtZjdpXFYOu8A2AsEeOxU0j9sIwMnJGLABBMpPYs81GnvcFKaZPmMS1mYU9DVHYDpqFLO6WzaLNXtcs+08TcYwUzXQ6h/weY1hW6HhB+aegzBf1dMmOwNYQ1KPY+AwSC99sMXwN1FfQuh/OXuSKtUp5E8LDCB52g1FVmExgdLwe3MBInw3FiOnxJpW4TwcRWudpJ9n9DOvC4oxNdxmgPuvLYgrkwfMiBQkhRn9G3+6nKbi
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(356005)(7636003)(40460700003)(36756003)(36860700001)(40480700001)(70586007)(70206006)(316002)(4326008)(8936002)(8676002)(107886003)(41300700001)(186003)(1076003)(26005)(110136005)(5660300002)(336012)(54906003)(478600001)(7696005)(6666004)(82740400003)(4744005)(2906002)(2616005)(426003)(47076005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 12:10:40.7693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a98d1820-eacb-4ff5-fa9e-08db92885304
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394
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

Add the Non-ISO MC client for the Tegra234 GPU to the
tegra234_mc_clients table.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/tegra234.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 7954f339ca79..9e5b5dbd9c8d 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -916,6 +916,16 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 		.name = "sw_cluster2",
 		.bpmp_id = TEGRA_ICC_BPMP_CPU_CLUSTER2,
 		.type = TEGRA_ICC_NISO,
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVL1R,
+		.name = "nvl1r",
+		.bpmp_id = TEGRA_ICC_BPMP_GPU,
+		.type = TEGRA_ICC_NISO,
+	}, {
+		.id = TEGRA234_MEMORY_CLIENT_NVL1W,
+		.name = "nvl1w",
+		.bpmp_id = TEGRA_ICC_BPMP_GPU,
+		.type = TEGRA_ICC_NISO,
 	},
 };
 
-- 
2.17.1

