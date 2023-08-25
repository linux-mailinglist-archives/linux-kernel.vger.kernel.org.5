Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC57884F6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbjHYKcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240870AbjHYKbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:31:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285ED133
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO394Nnrrp86iqZeqcxZEKZvgWBmeQbgMNLwZXuJDSq7DFwM8AQBRICBQu7j95yEUCuJJHT/xp9AM14/jefsFS9s6FzFOsdMCXm0+rheitqwr7sTrPrEOIisa9Z61FOyM9zhma/oqfx2UsQ0za+6zikObWrimmd+bDOua6UmUtVNLZjq6A1op4LiaDMHBUil/IW143436UWEZ1sYjAaM583B+ayC4UkjOZ8B6Xfi3ayzAIjjdJ/F4lIr1wrenMs7LMgoGCsPEo1Bq9rWdwwgzRz5+tQmgFUYemqu+zGxALqKv/71d0aMaPzTmjdCEbvFypGgKiEHq8o+X78GbIkuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6h2YbO73zwnGZSMmQeMlBUGA6mnH3aAdW7A8+1t4Iw=;
 b=jO08zBInLcD79UPDutUGE0Ah6b2pN4N6BHzEfvHgOMKQ1i3XhpaviiZL0lTo5W4ji+y4xOE+ZHoFxLzHojndLiq9DP1j04cMNEzkk0LKvjknaXWAKFTJyMZVQ3gaoe16cNOJRU0yi6tgPEwPLRsHcKca74OJi7kx032Sf2C/p5LVYcxoBjgn6Z0IBrj0wEe9EAxdxFCUQOOA0yGCKHwj6olNRa0CQlTcvYJ4EqI2qyzZH0/PLEj5aBowu9SWFB87lSwOqri4h2HZq1IUwg1vciP9SO3u02qtn5d5orC+gawVlZ+JoMiWEgmS4DAppaHCZolFKgPY2tmVy4Iei9U5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6h2YbO73zwnGZSMmQeMlBUGA6mnH3aAdW7A8+1t4Iw=;
 b=dD1tCBKQPOoNrnzhy/vqWWFbNqqm+POxFMZCblRFqp7JqhIvN+pXzgRgmVIMW6Bfk++R9rj92VMDCDEgKxeeQi2WJtr6D/WsdHjtsxVQF0CXKRVRrwMS1lt5RQhL9MhcBS7xH9EW57NLTyxOCJVNb2FGr293PaTe6nWvDvPMIat6Y03mEjSdGpY8hqgyJR5XwrGOAqi3V/E/Hy96OyRmQqWJpgN86h8OJM6wEd5uCygiHNpDicJrnMUnlbw+PdPXoKxiaNUqWGfMT/Weo2A2xiLWJ9pAz/muEYkEWyi5j09lxGzNq9HStCg8zl6HfPHycAsrtdjXXLDN1qB517h50A==
Received: from CY5PR16CA0007.namprd16.prod.outlook.com (2603:10b6:930:10::18)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 10:31:48 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::39) by CY5PR16CA0007.outlook.office365.com
 (2603:10b6:930:10::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Fri, 25 Aug 2023 10:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 10:31:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 25 Aug 2023
 03:31:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 25 Aug 2023 03:31:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 25 Aug 2023 03:31:40 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <mshavit@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH v3 0/2] iommu/arm-smmu-v3: Allow default substream bypass with a pasid support
Date:   Fri, 25 Aug 2023 03:31:22 -0700
Message-ID: <cover.1692959239.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: 86df20ba-0c4c-437e-5d17-08dba5567d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4aXnH3WkEilFJ1V2ILSV4eAjIxE0iPHNYqhEREkvEydpYF2bqxJaUpXwqkPv17sRY0xwneeYN3DtTr8THGU2bJKHeakjM/J27+Q/68G8rG7nWOEldaQnJokj+ytPCU5WjxJj1A1byPe20PbGbTaXkmQt+ObP+EdxWTvsx0QaFZcKDLlcaatkbfsUMHuXZBQar+15bhGTr2g+HNjBB2AaosuKQ5GRO66t8atUM7eFdhq/oE3jPd3yTGsqMA9EV/4DXFRqqq6gqza8aRmfbkVVcpn/RAo1ZkPa8x0J7k0WaqfpeXfx795odyNIhC9BYVMuc2zzFq+Ngec/p3n90nEyZPxdXCGF2WP1lR/cCcVOZMDjXhbTjE9TLI40jVkn7TgjeGBIATY0egbYiRclE622wYnXfm16q9CNv0IjW5rgDZz2C5gYBWNDS1eLtgOEWtWNcgXQ9/bRKd/0aTOGxjcNBohI8+jZTUcQKU4qLS/Vkx7bdNCqXOCI9IAGiilksxtd1vwJAWI/HVK6DIMeJOKjz+Bddzrl3Q971PJ+pvpe0ZRWJrrsF5eMwjV7xO7AMmk0iyg3Uk1MfkMp1+ePGxB4sJp7KDmEZTz2Vjccp3pLolaF05WorpliyyW2kRfCl/ak3yLswp0tEnSOIP5XItXCozUFHZ1Q/6xSxXUyiGOckz6pBImOHjOAsv6GViKY5ZzNKmAtjwmTRIX5xMnpm9YOJNlV2pHppc8jBCEh599yo8bun7QUJrxnPv9pkKhX3M5DbEjpARJtHk+t5cduCU31BcEo7CtisKjF7Lah1bPEoY=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(356005)(86362001)(82740400003)(7636003)(36756003)(40460700003)(7696005)(6666004)(478600001)(966005)(5660300002)(70586007)(54906003)(316002)(6636002)(70206006)(2906002)(4326008)(110136005)(8676002)(8936002)(40480700001)(426003)(336012)(83380400001)(26005)(36860700001)(47076005)(41300700001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 10:31:48.5328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86df20ba-0c4c-437e-5d17-08dba5567d04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(This series is rebased on top of Michael's refactor series [1])

When an iommu_domain is set to IOMMU_DOMAIN_IDENTITY, the driver sets the
arm_smmu_domain->stage to ARM_SMMU_DOMAIN_BYPASS and skips the allocation
of a CD table, and then sets STRTAB_STE_0_CFG_BYPASS to the CONFIG field
of the STE. This works well for devices that only have one substream, i.e.
pasid disabled.

With a pasid-capable device, however, there could be a use case where it
allows an IDENTITY domain attachment without disabling its pasid feature.
This requires the driver to allocate a multi-entry CD table to attach the
IDENTITY domain to its default substream and to configure the S1DSS filed
of the STE to STRTAB_STE_1_S1DSS_BYPASS. So, there is a missing link here
between the STE setup and an IDENTITY domain attachment.

This series fills the gap for the use case above. The first patch corrects
the conditions at ats_enabled capability and arm_smmu_alloc_cd_tables() so
that the use case above could set the ats_enabled and allocate a CD table
correctly. The second patch reworks the arm_smmu_write_strtab_ent() in a
fashion of all possible configurations of STE.Config field.

[1]
https://lore.kernel.org/all/20230816131925.2521220-1-mshavit@google.com/
---

Changelog
v3:
 * Replaced ARM_SMMU_DOMAIN_BYPASS_S1DSS with two boolean flags to correct
   conditions of STE bypass and CD table allocation.
 * Reworked arm_smmu_write_strtab_ent() with four helper functions
v2: https://lore.kernel.org/all/20230817042135.32822-1-nicolinc@nvidia.com/
 * Rebased on top of Michael's series reworking CD table ownership [1]
 * Added a new ARM_SMMU_DOMAIN_BYPASS_S1DSS stage to tag the use case
v1: https://lore.kernel.org/all/20230627033326.5236-1-nicolinc@nvidia.com/

Nicolin Chen (2):
  iommu/arm-smmu-v3: Add boolean bypass_ste and skip_cdtab flags
  iommu/arm-smmu-v3: Refactor arm_smmu_write_strtab_ent()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 236 ++++++++++++--------
 1 file changed, 139 insertions(+), 97 deletions(-)


base-commit: acd552d4b3b14d639784ea5ccfd61ba1fa85a16b
-- 
2.42.0

