Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B26A7D19F4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjJUAht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjJUAhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:37:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AD1D45
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6k6lODsGsDlYaBBjSWXB+Nvct3IX2nfY8QHpNSutw81E07lbX3Z7pywAYZKiAwxLFZO8clpUqk2Vj01uJPj1OWpMGqZR55b/dMpmXVw4EaNaibVWmQIHh2SmDF+HbBOaEAGXT3HJZe0Ohox/sRgFJoksAaMxDidcr/mKyLH3mnKukxkFRiPet/Ad6qQv1rxD7i9vx5ncxSZoW3O1wMJzZzJJzclmZwVPUaXvuVdI3mhsXZ6PY59oZlN+DXQ4Hayg4G+2xN9ESdNIjXy8pyp40HhivEfzM4siVzrRyFyAXm7cdSJAMTLzNjcIAUNw++j5BWGZ1hCYSfL+Eo4bxmXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Hakqt6IbRfl/lD1AMHUh5yWAlGKwVxZJBPoSW8PUCE=;
 b=QTE+WB0faoN0T6DN0RJnz/3VlZKFDo6yYUZJCFV3KPGorhWKurPXqu+L4Ypoa2aJYKgbG23ZjNiPHTe2/xFxcmJlF7N8CaCUt2kw92T2v+Q0Xcu9OPcTiBZZEpFyXROL8Jrqui4rkPSWfPTaHW4wVcpsUjTgROeDTBcrBBSBN4yo2ot9UQ4N2qb0fgaR2MjuQonFBuMQwtswKW9ys42BKNGUlc4dolQJ6M6MN7DkNICI++hAHSNw3QxmNZer7vPSv9xydFB2rHSuOHCuVJh3RaSasqHUXQlfQVq0fkPGOaqhSiixWzuh26akIe/U7lh2rDueZz7HVEB62BjkitBgSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Hakqt6IbRfl/lD1AMHUh5yWAlGKwVxZJBPoSW8PUCE=;
 b=Tlix6x/Ewb8JHO5iFscmv1am8wk0aMVRjATFpznZzgboo6KvxxM3L5Nqy+scpoCr8dvZpaRZNyYrRd/EQIv1c8Ej1W9w6edI3yxOrh+HMOEHDFMBfhAucCi+owyO9xeSYj5RoutVZlHS7tvPjoDOkWcpIAqk8UkX4gqUE//2fWDSVoX4UjhjlRoA1mhHuXAWXze5GraDaIZ+ZUzaULT9B4yX8MMvCYWN+TQp4iEKq1Osb5CaxAgkdpRBjHPzXBfPm8HkDptv8EyDCUrSo0C9D+MmVUXh9jmZuqCM2VNRM5XKylj4FaQi4QhDNVTDyWM4PK96qnjIMAq31jpDGpFL7Q==
Received: from BL0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:2d::36)
 by CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Sat, 21 Oct
 2023 00:37:40 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2d:cafe::7f) by BL0PR03CA0023.outlook.office365.com
 (2603:10b6:208:2d::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Sat, 21 Oct 2023 00:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sat, 21 Oct 2023 00:37:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 20 Oct
 2023 17:37:23 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 20 Oct
 2023 17:37:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Fri, 20 Oct 2023 17:37:22 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>
Subject: [PATCH 0/2] iommufd: Only enforce_cache_coherency when allocating hwpt
Date:   Fri, 20 Oct 2023 17:37:09 -0700
Message-ID: <cover.1697848510.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CYYPR12MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: 1396bd23-b719-4ce0-fd66-08dbd1cdee17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkTSh6gVK5gmH5qlL+5H8Ugr9iBm3myf1wibpzRkXD5oz6kFLE+qzqoTSPcwI0GPE+8ytvZIS5q9PRNHkCSpgh0gvQENo6ens0NIVS0JTAlB15yR+bUXBTN+YFdEktD/qfdArIVqtQXkDujUVatufFghfUfAtRSBJcLXYNbX4H/gzrlRB6YnSM23Gh/2X60ZEcHMRwL4axiZ7dt3k7zjNWB3kZykeDNVA8ogkRtsP8il/CEygXBF49Z3yG9XhRv3Sw1HyMiBdIMEzAn61EoQeRQ1660tnt/4pg80CFFvUb4hSkdmSV5cQZ27jPhkTd+wI93kyBOEaI2in8+X39g1v5tctn9lIu2nkvSmQ/pPd0T52iCCAbSO6d+kg7zkKa21CMEE0nQ33kNqOMM/rrZt380zrpjKBITGu8BhP9R3EXyQ8uHskGFGCLVpcPvx3VWEst42+Ofv04UFJGJh074qRvrf5YJJg4/Gdqcca7m6tK6hU221/PMQ/sZ0pwdEcfaY+LRxumHtkRgcpZP5U3TNtK/SlL0d7b8iKgFMLEQkYcCA80FcP+wWzHbBv6YlqfwmpmR1/JNZJmHtSx3DMGB0a4oK4HVr+AVRMffqxvGS3TInax4nTVLiOFQU+2CgbAOXLySDf+7b0TP3GpP87gzXSm1vt4B37GeHCeFMn3F2ehV4zv6dU0b+G5HKE6Wm051nD+GRnw9ftSNlV604Il9agpnqZaiQh3mt0X5Oj0n/yTpUDoqKauRXwEti3WNjS5py6/kmznyot+i1dS8c8JVZawqh07A7IrRtN9keG9P1RqI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(40470700004)(46966006)(36840700001)(70206006)(70586007)(36756003)(426003)(356005)(54906003)(7636003)(336012)(110136005)(6666004)(316002)(7696005)(4326008)(4744005)(2616005)(2906002)(41300700001)(26005)(83380400001)(478600001)(8936002)(966005)(8676002)(5660300002)(82740400003)(86362001)(40460700003)(47076005)(40480700001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 00:37:39.4076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1396bd23-b719-4ce0-fd66-08dbd1cdee17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://lore.kernel.org/linux-iommu/20231020135501.GG3952@nvidia.com/
The conversation above concluded that a hwpt should only enforce cache
coherency per device at the stage of its allocation, and it should not
be changed or updated in the attach/replace routines.

Add two patches dropping the enforce_cache_coherency calls from attach
and replce routines respectively, since they were introduced with two
different commits.

Nicolin Chen (2):
  iommufd/device: Drop enforce_cache_coherency in
    iommufd_device_do_replace
  iommufd/device: Drop enforce_cache_coherency in
    iommufd_hw_pagetable_attach

 drivers/iommu/iommufd/device.c          | 19 ++-----------------
 drivers/iommu/iommufd/hw_pagetable.c    |  2 +-
 drivers/iommu/iommufd/iommufd_private.h |  1 -
 3 files changed, 3 insertions(+), 19 deletions(-)

-- 
2.42.0

