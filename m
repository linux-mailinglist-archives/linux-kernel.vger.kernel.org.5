Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127AA78087F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359189AbjHRJbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359192AbjHRJbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:31:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB88135A4;
        Fri, 18 Aug 2023 02:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chA4Z6yFxwa9z5XjFLdXhe9vjALcHIK35ecgiHsbgbAJ2LByrez4qnRlSrHF7rL9IJQq3HRcqX4opHd9wVTzw81PK/s6+1Fyocq+qjTdGITygJZS6WgkHjkxihI0j4F6nniNoOQn8EZfO36GmpFY4IEwZ/60kgXQG64EVpaXR9gFyuzVjRAz1kKXSVGfdNTM+od5Gca696oLfcSWsTRPRdRxy2KCpBvx9UQGki4OPD+PYXnawlw1c5vAadEYazq4isQiTq8mucRL9SXBNRSKzWVRK56vwd2EAYYeSoCcXYGPFVyeZyIUUWi9ljZexXEnSPLkxk7oDdC/zKw8WnXY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CmJV1KPTF0L1ePs0VdF8SloT+IzphLKWsZQG4WLaHE=;
 b=R9EFrGHw5afZqLv+ueCb/lujyjdAuTS6VKLiUKhwhRK0ZA8OI02tYOcZw87GTi/bWJUyLn+LhHlrTO6xnefENYGDNT7WU1F1CEqV5k0f8HCms6GIXUftINF1C6gfNihwCbp2PtPwY4F2lsbWgAyhcCpYfQw2fisA6n+rqV/8IWL2cxPWVu6KyvS66uu9+7xBM2bIcOeCzEFce8DrgTg9ZSRKWZ8oWfFOhxXhjW8pQO0RtZmxA8HwlYpKxMI/BIZi8y6BxUWiVE4syr76Exa7f2mLAniQ0ia5gF7LiZRjrAU0AZVXr5t2yOYgem1K1Jz19MIN3JlaAveDxCOUdoxHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CmJV1KPTF0L1ePs0VdF8SloT+IzphLKWsZQG4WLaHE=;
 b=L2/zfLATb8K8TeB1D6eZbzbpsoVy4rbSMgqHLRyQsk24FBCa+/xY2c7mtCM6PaOCnklHPhwNER2UsfbHNqSP/sl6Vl5kt7MFXqknE35ze/JDVwQ8zu7DGtGDLq+hjZSHEQllUdHoXynP4thFVIhZiIhniq5QQD8ogCYBDBgFq/ELigSoqkrCgiULTvDcamWVJuSglxpR+YWv5H2fLYdHXa70dqUqCEWhx/mR1idFJ8QDpsjbVSJZpONYqPSu5RVGS+umTfh281fyX0fSA/BBZ1EHcst3C8u8yXSZaKiElyH8rUrz7VD11H6kI28w5b4p0Q8hz8INjTP0Llo/3dL4LA==
Received: from SJ0PR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:332::35)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 09:30:56 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::41) by SJ0PR05CA0090.outlook.office365.com
 (2603:10b6:a03:332::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Fri, 18 Aug 2023 09:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 09:30:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 02:30:41 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 18 Aug 2023 02:30:40 -0700
Received: from localhost.localdomain (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 18 Aug 2023 02:30:36 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.co>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] soc/tegra: fuse: Add ACPI support
Date:   Fri, 18 Aug 2023 15:00:22 +0530
Message-ID: <20230818093028.7807-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: b27c185a-c766-4836-766c-08db9fcdd34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAbAROL+G57R+K6/+jZSJyVOiYe+XQfxTAVv55vtgMbHC+BHSv6Yep1JjOfCyLVhWd+3D/ciP7BCrjH2KoM/jzRwHtry4glPDOP+ZqadtIj8pU2qgT92QUyj03vrQE9IuZnoc+XQopoNt/rwG1t3OYcBFHQwQWgzAeZiScW3g9r2GrPUGS1Q7te5iI/SnxraIC0iUSArD5hQV9E5b4DoY8v6tyDy1M3gIftRtEei5u64aVqAfavrcWw0u5ntOfMdZd9TsnCx21/W8R36Ch3w8Zf0zv1CycG+wQGRNcyuTrfF5YxlwRl+o+5qBOXpOV8fySfY8EwvbNTQdS+Vh1OwgEoTlvvSRjvkkLtZUZHMtnZa+5z+GQawnHW7BmRwFyfIOwR80cuxuJwJw5MNZyMOVBx6U8e4Z+NXF3dC9tm0NSCEHKsJj3BYGPFomE/Pz0M2IBu+TKXD0WuQ13E84DhicJmPk4TKLr7ZOCJI8wgSyD5gKAOgi8V+ZFcO1Qfi1WIatupFlIb2wWOtxBoV5UA8HMm6/ZkyopHiZlaCcYuuoT7wTuh2T8dRN6/ie3q2TxmeWN2QQAdohX91boytyvZooe1xy/hvyc/8KSShPSlnKK87NioopfjMnGPOjBbtqINkNAy8ru2kQrRRY5gDpHDDU70KfOk/OhU30QbrD7RWWWfH8BhzopYWGrMqZOVMm04wqaCjztLN66xm6OTNqIEtyPUXYRGOeINK+yo9eBGj4XCXMFyM2joDOnTidCeSmPZ40JACQJxBI9WJyf0xIa1cEA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(5660300002)(83380400001)(40480700001)(40460700003)(82740400003)(70586007)(316002)(70206006)(478600001)(110136005)(921005)(356005)(7416002)(7636003)(2906002)(4744005)(41300700001)(8936002)(8676002)(47076005)(2616005)(426003)(6666004)(1076003)(336012)(26005)(36860700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:30:56.4391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b27c185a-c766-4836-766c-08db9fcdd34c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add ACPI support for Tegra194 and Tegra234 in
Tegra fuse and apbmisc drivers. It also adds support for Tegra241
which uses ACPI boot

Kartik (6):
  soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
  soc/tegra: fuse: Add function to register nvmem
  soc/tegra: fuse: Add function to add lookups
  soc/tegra: fuse: Add function to print SKU info
  soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
  soc/tegra: fuse: Add support for Tegra241

 drivers/soc/tegra/Kconfig              |   5 +
 drivers/soc/tegra/fuse/fuse-tegra.c    | 180 +++++++++++++++++++------
 drivers/soc/tegra/fuse/fuse-tegra30.c  |  25 ++++
 drivers/soc/tegra/fuse/fuse.h          |   5 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c |  74 +++++++---
 include/soc/tegra/fuse.h               |   1 +
 6 files changed, 235 insertions(+), 55 deletions(-)

-- 
2.34.1

