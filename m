Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92AD80F1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376768AbjLLQCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376736AbjLLQCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:02:03 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073C78E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:02:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGrXVjaYU705kl2CTSqBhbM2vfVbdor+vhbimNGnHMWjRyYW1OnZ7o0cVCbz7jVvUssaSHKKcb5N8QSxyTHDAGOu7DtVMki++bHOpBsDkWu+UrF48JYc9dVavsk5HOILPaW2PB7iPylfKvHyKd1+uetauzEwNBskd5hwIbpJkDzGrvdx851sYqIOksdtRXILwe8uGxSpslyjJN4SR2I8OtFJsu7s9ohhA+y0b31K5QTuSp4uHPT/HlM1AmDCHpzxAmUFCVwYfyYUnZu3jTCSCXiOmtBzQyutqONKliVg2Vw2t7Z4YqDkiMWdCIujrRT9i+S0cIsIl+cjHFZsERUogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWhVOs0udo9c4gf4sTzQa7yVWiKWAKmXM4mC+AOgz50=;
 b=hn0PysZtlRv9z3ssrZB3apzIaHfMfrbBeZM0HsEzeR5ryhykNL0y9RJEbxbhXVANFOHmcfn5rR1rhArT69eR8mcevrwU64kudPOeCSPA9nX4YmCmFmyz9KnZifvuDO3P0B8lrt/62DGvHv633so7Nzts8GevAWAix3+TXCuS8WYEf2JbOTtS0dw8aK6tX96lTBcbSGnbguRhjkURN1Mi7EVPNEtjangTZFzgvQq/tlyEcqUQ8xNdMJ7Q8yE3CLQjkIaWfQVUZtMZl1rEOWJ+48IV55RpphYOQ83xl7KxZoogaEgwgKuow9qRnphNZsRpgW/tMbSWuSxa1U7TygVhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWhVOs0udo9c4gf4sTzQa7yVWiKWAKmXM4mC+AOgz50=;
 b=c2l7caL7B6Bpwp+FOtttzdAwZ63D0QZr9rkmwNa60QabJZsJ2LSZtbb+m53G5rRcJ5ElIoAT5mQCBa3SuLeKebIwBsLLg5ywGm5LJ2rezwjJEjqUGFp1J+4jf7ylu7gf83GnyAW63fK1X3XeJg8cs5chZbVReBtewsSC369Qu58=
Received: from BL0PR02CA0045.namprd02.prod.outlook.com (2603:10b6:207:3d::22)
 by CH2PR12MB4907.namprd12.prod.outlook.com (2603:10b6:610:68::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 16:02:04 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::d) by BL0PR02CA0045.outlook.office365.com
 (2603:10b6:207:3d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 16:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 16:02:04 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 10:02:02 -0600
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <joro@8bytes.org>, <jgg@nvidia.com>
CC:     <yi.l.liu@intel.com>, <kevin.tian@intel.com>,
        <nicolinc@nvidia.com>, <eric.auger@redhat.com>,
        <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
        <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
        <pandoh@google.com>, <loganodell@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [RFC PATCH 0/6] iommu/amd: Introduce hardware info reporting and nested translation support
Date:   Tue, 12 Dec 2023 10:01:33 -0600
Message-ID: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|CH2PR12MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e49e9a-8939-4086-4477-08dbfb2baf2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMzMUM+t2ax4p4GWaO7JGL2VrUovb4PWQL6U4BlNWY9hU+un6G+QKXUPIu3ebzvQJAx9nkxxlw4vorkSAJwRmOTEmD3bZGXXLhqzQz09b0vjhWUDtHh08XaAqSJmLsrMxFYGdxEEuAHEHwJhYjtnsQTkI6O2ijWhiVTAINh4LwLMIRLGnBYUPXqdAmE3fQVjoEripxVEYi2j3BeZVk6T0MMN9zz07mcZ3jCFPU6yGqtVTwrKMYuQd1Vsw/4SAKKuOGinC0bgJYlzbC5R7KibtBkPPDPAaIY5kRYrMtnTYtpVGMIpNNUrJwrKB4XnXn5WquemQ1Ri6A6E6486oJXHR8lAITh8WVge0M5hWFizLwMK9RDXVgYrlk2m5Y0D6S35Ro1lgOxgYVufV33a+dtPTSKin6bk9gmk5wSQi3yYaB38VHcsts9KTbxtuDXnTLiKLWig1Vkk0L11GLTGv86dsYeNSaCRtk1sk7gfn2FccUOnl+H6UjDyq7oHQbw2b5Gutk0nCtqLBV/Y2Mox3l5lPngaztYK3wXD/p8w1fb5jgsKH02D5JjujA1SilNlZmDoVQkaD0uwgoNQ87voHfTw5R9nJk2t/TaNSCUbeIuLPyK7SpnTTs2Qm8l0CbaSV8i4WnHWV8ZyRXNSy3MQT63Wf1Q1qwIoG0YoESobAqoJyCBREeJZz8dq7hAwe+PanoczFqKm1nz3WgAnCwq2VTYFYi0F2kEGCBVeE76fIB9xAfkqmdljbCsJNu5zVsqVu04ovXPewSdkoGhpCKjy94fU9PPyom8MAD8emeaeS4nHMoFvKwXBBWpxnLSSyc5lLZ9E
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(4326008)(8676002)(8936002)(7416002)(2906002)(40480700001)(44832011)(316002)(40460700003)(5660300002)(70586007)(70206006)(54906003)(110136005)(478600001)(36860700001)(966005)(26005)(336012)(426003)(36756003)(7696005)(1076003)(6666004)(41300700001)(2616005)(16526019)(356005)(81166007)(82740400003)(47076005)(83380400001)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:02:04.3733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e49e9a-8939-4086-4477-08dbfb2baf2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4907
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OVERVIEW
--------
This is the first part of multi-part series to introduce the AMD IOMMU
nested translation support with Hardware-virtualized IOMMU (HW-vIOMMU),
which allows user-space to take adventage of hardware accelerated
AMD IOMMU in the guest.

The part 1 introduces AMD IOMMU hardware info reporting support via
the ioctl IOMMU_GET_HW_INFO with enum IOMMU_HW_INFO_TYPE_AMD. This allows
hypervisor to communicate the supported capabilities to user-space.
For example, this information can be used by QEMU to populate EFR and EFR2
field in the guest IVRS table when building guest ACPI table.

In addition, this series introduces nested translation support for the
AMD IOMMU v2 page table (stage-1) via the IOMMUFD nesting infrastructure.
This allows User-space to set up the v2 page table and communicate
information via the struct iommu_hwpt_amd_v2 with enum
IOMMU_HWPT_DATA_AMD_V2.

This series is based on top of:
  * Linux v6.7-rc5
  * Series [PATCH v2 0/9] Improve TLB invalidation logic
    (Currently queued in https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/log/?h=next)
  * Series [PATCH v4 00/16] iommu/amd: SVA Support (part 3) - refactor support for GCR3 table
    (https://lore.kernel.org/all/20231212085224.6985-1-vasant.hegde@amd.com/)

GITHUB
------
[1] https://github.com/AMDESE/linux/tree/iommu_sva_part3_v4_v6.7_rc5-amd_nesting_rfc_v1
    (Complete code for the part 1 of this series)
[2] https://github.com/AMDESE/linux/tree/wip/iommu_sva_part3_v4_v6.7_rc5-amd_viommu_20231212
    (WIP for Linux AMD Hw-vIOMMU support)

HISTORY
-------
* [RFC PATCH 00/21] iommu/amd: Introduce support for HW accelerated vIOMMU w/ nested page table
  (https://lore.kernel.org/lkml/20230621235508.113949-1-suravee.suthikulpanit@amd.com/)

Thank you,
Suravee

Suravee Suthikulpanit (6):
  iommu/amd: Update PASID, GATS, and GLX feature related macros
  iommu/amd: Add support for hw_info for iommu capability query
  iommu/amd: Introduce Guest-ID struct amd_iommu_vminfo
  iommufd: Introduce data struct for AMD nested domain allocation
  iommu/amd: Introduce helper functions to setup GCR3TRPMode
  iommu/amd: Introduce nested translation support

 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  20 +-
 drivers/iommu/amd/amd_iommu_types.h |  26 ++-
 drivers/iommu/amd/init.c            |   8 +-
 drivers/iommu/amd/iommu.c           | 299 +++++++++++++++++++++++++++-
 drivers/iommu/amd/nested.c          | 107 ++++++++++
 include/uapi/linux/iommufd.h        |  36 ++++
 7 files changed, 475 insertions(+), 23 deletions(-)
 create mode 100644 drivers/iommu/amd/nested.c

-- 
2.34.1

