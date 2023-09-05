Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7436792CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbjIERzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjIERyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:54:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69EB1AF26;
        Tue,  5 Sep 2023 09:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7NASV/w5NSdbWS7kgDk8F0Gj/2ZoEOjDUW7Aj8n2jM2hQFCtJRvNuhGCqxfVX5YuPxNiyk9Yos8iaYJ3fED2h/IDeCd1DKpQEhmsA2+7AXikyFetdCxS28hxLCO5TJDXNUkITSSZR/VuJeQI99PRilaXpTcrgKAphnqZPqmoDseLowd3PGubOC9VUTmG5z4e5IrIy2U7NMP6Y0kAKjwJFA67DDIC3MQwJ0wASq1U0dFUWp+GCAFHG0hU0dien0aTsYtwwxsIRvf28TIeg6lq4jefrBBBVs1NsxPIL0IgZb3E0ENziN6xRo02B3IuUZpF/CvZP7QxtgI57GC/VnqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI8APG0wUZ1SB6mw5CSdPBN0ODd1HSks560GZ6JxrVE=;
 b=kEo9hgBkzMDd+GzchLvVPgPxfM7ttqO44SIMls3t1K8N1n27B6IIZga0Hev28bu1o0k49KyrQujttqKXmeGDX44HVzxpbOcNj66u+0qi+Q1uwir+4NhqruoBYHPS74eEt5sW6ZH4tQxZhnzGn/DImjKNjyXQcoSw4OgPqgb2yVT6Eo5xmo+JVqOuZByiOgBT+EwP5GYbuOJppFNs5z7riUBvp6V1/gw+5VhlNArFyjoMaAhScz2rdlKyalOHT6rogGTgstX19DNpKvS8FoqWIKDJQZjp/e45rwzEJmNF0tTa9lH6s2ddfVbK0JMhF2whCEs414Ny8SxWDAcayHn2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI8APG0wUZ1SB6mw5CSdPBN0ODd1HSks560GZ6JxrVE=;
 b=sl7t8Yzpr2f8ily7LGXUY+Jl+BcS9JYVsmKGNEVChi8tJlKCmZUNWkhwSa3lKapJDRX4ZzLzTV20rrHvSClbTtnLQ6ruZ+hiPNOOgJp1RZ6Zo9jERsDsCS3nhGQocqtjtHMB3wle0FfGMCdxyFHbCC4gDRn6zsEDSId7iRPJoiG8HCaxHWQ1TtufEAtV1xArGAa4AY7bPrj6EDW7tvcyPoH/oIU57Qd+Qk2r656PpC7NIzc1fphUSa4p4meng5xsnZNHZjg84C7Xl9ZNH8ExZHyeorVkVFp0LaAKhtSFw1dFews5xpm/Y7snR0IN5nNbPhkX4MbIJRBmwsdskaXdSA==
Received: from SA9PR13CA0006.namprd13.prod.outlook.com (2603:10b6:806:21::11)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 16:36:24 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::21) by SA9PR13CA0006.outlook.office365.com
 (2603:10b6:806:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25 via Frontend
 Transport; Tue, 5 Sep 2023 16:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 16:36:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 09:36:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 5 Sep 2023 09:36:13 -0700
Received: from localhost.localdomain (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 09:36:07 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] soc/tegra: fuse: Add ACPI support
Date:   Tue, 5 Sep 2023 18:28:18 +0530
Message-ID: <20230905125824.2947-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a36c52f-2ab2-4c7c-8ced-08dbae2e3e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMvcC/MRIMmcRJuRSbIgUuNATbJNxRlMRCgGwxADRnOMSpR/Xl7cxWrLxujrxuvBi4Ra0ZOvS+cI70Yn0ysz8gw0/FFZst+vyWlAPFNsjlESkeOwvsUM8ldxhtAUeJEwlYq7p4cww6HdHwn5ig0M4TIw24vyZsNUnPcogVm4p/+fgyQE4xqKP5rd9Tr0AA1tl6wwmvxr0tS6iPAxBtc9aKqjvl60SFecQ4evHZyj8tCKfCPE8JqAKk6u5/RaUVcCk96q7mIWj4tPYx80HQns7pwaUo85zrjobqB+qCPibS5gX0m52FNvubZo6qaabP0HNDOOM3d4HBtHmjxyq5hM9dJIyNOgLtZUiIf5AoLC3rBb86ggIBaqjBZHU+iQYnJrfd2v/YE1bxVDuoYuk1JQoOOQVpUPrS0PnE+w+yyZuqgnD6vbdOMN8rUu2+8bJ9T2NdeW6s8Bo7HeHpjJ+4AbCSurivNog2D+CuDA8f4nBt14XzLvLEpryNQ9XsI6b14sy5VfWrqVOV6augtN9lsmiSqQahCtMjk1dHykEBzmzSya0kXvEL6MPwujAcEn8R1Lf78V0Dscd5tWX+x2WV91+kBn0gBW3lsQI9xwzHB9sa3uHTIT2+r7p7SuyZT1hB89WScf2JBJScCABlu9xd4BbRPsUgUAkKGGTroBXBhiW6OeorIRBSSBLrIeTNly2pK2mx+dsEnba2e2CQrJ32vJexC3Lj0d7OZjWtwv6gNV5tstTcSdhLwJ9T2yh6WahfHgp4ZK2F2hwH13VM1ihtGEUA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(4744005)(41300700001)(83380400001)(40480700001)(8936002)(478600001)(6666004)(2906002)(110136005)(5660300002)(8676002)(316002)(70206006)(70586007)(1076003)(40460700003)(26005)(2616005)(36860700001)(336012)(426003)(7636003)(82740400003)(921005)(36756003)(86362001)(356005)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 16:36:24.1361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a36c52f-2ab2-4c7c-8ced-08dbae2e3e74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add ACPI support for Tegra194 and Tegra234 in
Tegra fuse and apbmisc drivers. It also adds support for Tegra241
which uses ACPI boot.

Kartik (6):
  soc/tegra: fuse: Refactor resource mapping
  soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
  soc/tegra: fuse: Add function to add lookups
  soc/tegra: fuse: Add function to print SKU info
  soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
  soc/tegra: fuse: Add support for Tegra241

 drivers/soc/tegra/Kconfig              |   5 ++
 drivers/soc/tegra/fuse/fuse-tegra.c    | 119 +++++++++++++++++++------
 drivers/soc/tegra/fuse/fuse-tegra30.c  |  21 +++++
 drivers/soc/tegra/fuse/fuse.h          |   5 ++
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 110 +++++++++++++++++++----
 include/soc/tegra/fuse.h               |   1 +
 6 files changed, 217 insertions(+), 44 deletions(-)

-- 
2.34.1

