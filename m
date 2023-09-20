Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3EB7A8E04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjITUxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjITUw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:52:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD02CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0UPufvFBCnDveQdihqOgSXfpypr6O61FAt65/2T1Z//PigeH0FJKnYjateb2bxh2V3kW3DR0RRJXzBCJPm3oe5AOef0RRWqTL+thqswr10sLM3UAZuFAjs5sfDb1a1trwZi9yu55vo/80x8wcceXOzavgsOiQ2O9BuTmyE2sUKHolAcbvKNawllrGZ7sENbtHKhBt36AxQ1k3IMRJKY6Mj94RmomVOEY++shFOz3o7AngaJ8lA0DNPgSO+Y1cm6WXdzqeZ6T5IscqKci8NLGCostSQkQAO/FNMnSq+uu9OK4eanA2VuQnIEnNhB5cCndP4ChDaegR8KmbSFewMyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BiL26q7Ussw2gAXW2RtQEwNrzdQxhI3t5+7gynbRek=;
 b=k2qz1PqSx9JSH1cCRkQUWTTfWUh02gQu/HsK4hXTjHG1TJHRMYqI0UvBIgw5CJOuWmukFIPGmWhXUQkkyG96y0/jgtQTUYASS0eRPWRd2LvM9dbgn9OBWc/VepJRxFyFe+bnlGDTuDJAazC4SM4RfdTM8i8Xj1epjMIfohtxAgf4apakvfY8BCj4sgkjlBmsvWium72SwDHzGUcPxP3K1vXvogqIlZ5lUOU5wZBAxbanSBJ1GhKCfzzYx/XYfPfpi60d9QUmE+ISmGmFmJGCzbWkvO2vbO0X/65Xzkhp5GM5VfOUJwtxAJliuNpYiGCwlz/kcHXMarQEI1KZQOJ7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BiL26q7Ussw2gAXW2RtQEwNrzdQxhI3t5+7gynbRek=;
 b=KOCbkhwAQcldrh9Nktv0jYB9AOhux3oiLXi7jX908HJoE3t4iLnGgonKVjKhFwhN3nj+1Tcm7cJxQe2Vf1K7rwj+1qsmTAdRrd5g1msYuc6iZ31U+1dVkHZyk6Ud5mmj/1LvL5PQWMtpubsr6rKB4103/7wf4WajaLOFtLDBtOaHshsqjYF/UxRzTH98TwiCMbzZicGW/W06jMxzkwXkGVhnpfd0yApsUk/qP9t5wTCmWaA8X2sxDOyQTswb+xYzUfPxHlV+qFEvv5abO9dY08I4RMbWRqKuviz9ddjRrZtFkafxa3tY+6F/rHCwiNk5854ExFNWA/IS+VlrcQe2Ng==
Received: from BL1PR13CA0269.namprd13.prod.outlook.com (2603:10b6:208:2ba::34)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 20:52:50 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::7b) by BL1PR13CA0269.outlook.office365.com
 (2603:10b6:208:2ba::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 20:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 20:52:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Sep
 2023 13:52:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 20 Sep 2023 13:52:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 20 Sep 2023 13:52:37 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <mshavit@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH v4 0/2] iommu/arm-smmu-v3: Allow default substream bypass with a pasid support
Date:   Wed, 20 Sep 2023 13:52:02 -0700
Message-ID: <cover.1695242337.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 601cc50d-ed5a-4738-cce9-08dbba1b8d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4P+3zSto94vySv9gQuQZpSk8sAbszsXgfEAcKNz9soNZS/ldkuiCQFsJZtaQhWJkkHbLOvwISw+/yourRooU2kXoP9YJBNoj9rXWArjtWnfKkRC9DPDTrlFeRtMjpbe0BVgxYz2UrikOtz0RLUYllsgmpBLym1YJ8fcsJEK5mjHP1z+3VMEzfw/V4ohIKw8xdS1x+SxIAXiGnFlLq+vZYma6JmcYiDInp0+TPGoVZY0JtzVQ3Ql+BFLGXcOouepz4uJvW3fhsBSg1RJd8ct7PK2VcSDLgsuVYmKOqsZ7QKx4FzrhH8AJXRLEWr0FXNn7OOx46BZwEyh1GS/pT/uAWpvxW//8keXjspuQlxWCse8gQX7RhPtgNb3hqSkdw/IrEx69ry+EOpedjAKd5g4FJj+pHB7xbT6pLeckXHnx9zZApnrkf8sWZk/eo2z2ZmHnFfgSUADRsyICG2BTtrmB/G+6Zy8XLUB7duFs1nEnOW/n+6oI3j9h7P8Z9PF4Y2dlZnixjKntavMZafQX5x7lN9oI8a4DlMM3YDjs4MCm67DW4smbhu0lTu02wytMHqDOlmomsqcCAKCIAYDHlYA7N4linvnrSlzg7r429hxXO8k8rF1WZNcRnNajOSmYbjjyIxhJmH6rnb3gQA9IAiaQPB8umWLA5N8qt7TOAobkizRqtHJvuCqPv1YFJ5aDhI+TLPrA0h0mGj7dYp5wBnka+avE+LalVPicaEoG465L3A7H5a0xCSxYzTC07OmWnFdCzxWS9DQ6OISe+GE6UHcRIax0Nyfc1BC5GsBg1C3hmNFSdPQarltVZU1fTo6pYPT
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(46966006)(40470700004)(336012)(426003)(478600001)(41300700001)(40480700001)(2906002)(6666004)(356005)(966005)(70206006)(83380400001)(40460700003)(70586007)(54906003)(82740400003)(36756003)(7696005)(7636003)(110136005)(86362001)(2616005)(26005)(6636002)(316002)(4326008)(8676002)(8936002)(36860700001)(5660300002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 20:52:49.8424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 601cc50d-ed5a-4738-cce9-08dbba1b8d48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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
fashion of all possible configurations of STE.Config fields.

[1]
https://lore.kernel.org/all/20230915132051.2646055-1-mshavit@google.com/
---

Changelog
v4:
 * Rebased on top of v6.6-rc2 and Michael's refactor series v8 [1]
v3: https://lore.kernel.org/all/cover.1692959239.git.nicolinc@nvidia.com/
 * Replaced ARM_SMMU_DOMAIN_BYPASS_S1DSS with two boolean flags to correct
   conditions of STE bypass and CD table allocation.
 * Reworked arm_smmu_write_strtab_ent() with four helper functions
v2: https://lore.kernel.org/all/20230817042135.32822-1-nicolinc@nvidia.com/
 * Rebased on top of Michael's series reworking CD table ownership
 * Added a new ARM_SMMU_DOMAIN_BYPASS_S1DSS stage to tag the use case
v1: https://lore.kernel.org/all/20230627033326.5236-1-nicolinc@nvidia.com/

Nicolin Chen (2):
  iommu/arm-smmu-v3: Add boolean bypass_ste and skip_cdtab flags
  iommu/arm-smmu-v3: Refactor arm_smmu_write_strtab_ent()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 232 ++++++++++++--------
 1 file changed, 137 insertions(+), 95 deletions(-)


base-commit: 8bab08e86afa9e0afd25887c0c273c1506d16c0f
-- 
2.42.0

