Return-Path: <linux-kernel+bounces-24162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A7582B872
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C09B23925
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD8B655;
	Fri, 12 Jan 2024 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uDEZYnPq"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B98362
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MduVrMQyRkJVe5NihSjR/ddd/RXn2L/a7aeR2/VxVp1m69aAyjre4e3HXIn3ZdiGKVKuUs/XM8784Gd+bvpMJVtAjEiil9aXgXMLGo+ddpoFD2axg8ictYCM+OFv9emjgyfeTxvH1r0vS79UOo4/ezc58OLi7We4eRscEHbtb7YV1tcX1bZYqZMmOt/sDhZFz4iCIMHVbRjjYl/j4LWeKIxgI23JoPWKdo0wDvJtvNLA9xYvhpVPrtAgkI1sd8Sg3869UXRFW0s3Gm+PgB7gOvw+9Hr++DdaWbBBqt/iyWBx6qR5FTPTVxMcTwtluHPGwFWgfTkpTpaYfNWNMTW5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYAB1PVrzM9TkZaUr+TQPTi09ZuFUcL5M4OlX3rT2Sk=;
 b=ksWz4jjwYBpHHnKOIapB//9bbvLwECsmdxeX/6JsqpYAhNAEyXjaydUoaiPToasbsKBHbz796BszIZGQcZFT0l1HxrSXqSI/ootJXfO9HHQ1+rh4fbJn2LjowwVoVWw4MStUnNiragCyT+y0BzEoQrHqCyYtmnKHTrcFFf6+JlUFDfKKoZ2c5ezFw978n/Rotbr1tCY0NIxPxHFHVrA9VKJP3gsaGiKckEDPzmR5FFy/1DAqaP7G3a9LULeGkjNyHec1TyqhYKYcWv6VCXqY7SdNYnqLyyh7KOqw4NCDg97c0al9NWNpvn297ah80IAoxwbgcaLPabQByetXzZ54UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYAB1PVrzM9TkZaUr+TQPTi09ZuFUcL5M4OlX3rT2Sk=;
 b=uDEZYnPqVjI47ZVtYLX1Zn1H7Cugcpoy1BgjEGyibmQANv2CSU4ke9u1ssKYxM8kaHj7etrabGXnMjg5oMDXfz/Db0jtPdL1fiQyfaMhQQano214DOM17r5quABTnQmVIIykCHzixkrQxEX1E6d5yFsL6av5qSEXYBwwxRhhClI=
Received: from MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::34)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 00:07:03 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::fe) by MW4P223CA0029.outlook.office365.com
 (2603:10b6:303:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Fri, 12 Jan 2024 00:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 00:07:03 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 18:07:00 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<eric.auger@redhat.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>, <pandoh@google.com>,
	<loganodell@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [RFCv2 PATCH 0/7] iommu/amd: Introduce hardware info reporting and nested translation support
Date: Thu, 11 Jan 2024 18:06:39 -0600
Message-ID: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: e526da6d-bc2d-4498-0239-08dc130267ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kaXLygJ6dKK9Ib3IthP/SKi6Jd1ZB/QmaqcI7to65H3ot4YmxZh609h44Nzo2tXANQCZe3IGmnTipddqdN3IeVbPPcQ1LrUbmp5NrywzXyxYbkv/SUO8N2WxrKESzAbDdv3hEompgewDlKCf9O2o7MBcUb0oOU04ZQx2HHqMwL+IuKBv9uVjvQspZ8ZFRUBXvAjADuqujXPBiG8QLdTW9shHXdqMAseV3xNFLNBz34tckchaDs80eIteVN4UmqzfMVlvy3WqZ2JZ/p5TrD3pRG1JOLCn0Rbs2+OoC4qikgsEUv5lb3H9TvHGP+ZSnKlJ0bU/NPIXAWlbXINemJlTjvfokRkaqxn9M55W9juMX2CFFY5hGv+mwIHU32bgdCveNH12p/96nY+yn5oKJHPh7X15IxWV1XvvsM8r0h0j1XLp7cjL1TvYRGPVJXMLYFVwh/6eQRSI54KTyNRwZlUG2wIj929XP+g6Bx3jIHC4yxbybMzu+ZtrTvg4W+PLToE32M5CkEhZYYtkzI69F1W48XtV4m4tN+GYnlZK4B30f/qx2zT59f5nbEXUiggBZ/8VUi/xm5Od6kQdKPOOeCtIoOU9Uw/5/o33943USYXzPWtRt47gl0f5fFg9VncT9ggFXy0L5k1qf75uVvK296otT4kGSArw8vg4xWVhKdmm+0KUZC3m5SFM3/i05l651912iS5vMrA3Ja9ejSO0gi/HLLhNtbt+h8x91s+VtLGtb+ROaT2JGqLVPmyNq8LQLEJi7uFQ3cqdvgHkyHKjU8OybpybZVKem3woJZiCT8GDmmiM1frHkQxN+81gKOgUCmZ0
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(47076005)(110136005)(81166007)(36756003)(356005)(86362001)(36860700001)(8676002)(4326008)(82740400003)(83380400001)(1076003)(2616005)(336012)(26005)(5660300002)(426003)(16526019)(54906003)(478600001)(966005)(6666004)(316002)(70586007)(70206006)(41300700001)(7416002)(2906002)(8936002)(44832011)(7696005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 00:07:03.2456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e526da6d-bc2d-4498-0239-08dc130267ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

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
[1] https://github.com/AMDESE/linux/tree/iommu_sva_part3_v4_v6.7_rc5-amd_nesting_rfc_v2.1
    (Complete code for the part 1 of this series)
[2] https://github.com/AMDESE/linux/tree/wip/iommu_sva_part3_v4_v6.7_rc5-amd_viommu_20240112.1
    (WIP for Linux AMD Hw-vIOMMU support)

CHANGES
-------
* Patch 1 : New
* Patch 2 : New
* Patch 4 : Modifies the amd_iommu_build_efr to also check the advertised capabilities against
            the current hardware (per Kevin)
* Patch 4 : Also add reference to IOMMU spec in the comment (per Jason)
* Patch 5 : Removes gid, iommu_id, gdev_id (per Jason), and introduce the struct flags and giov tracking.
* Patch 6,7 : Separate logic for nested domain allocation and attachment into two patches (per Jason).

HISTORY
-------
* [RFC PATCH 0/6] iommu/amd: Introduce hardware info reporting and nested translation support
  (https://lore.kernel.org/linux-iommu/20231212160139.174229-1-suravee.suthikulpanit@amd.com/)

* [RFC PATCH 00/21] iommu/amd: Introduce support for HW accelerated vIOMMU w/ nested page table
  (https://lore.kernel.org/lkml/20230621235508.113949-1-suravee.suthikulpanit@amd.com/)

Thank you,
Suravee

Suravee Suthikulpanit (7):
  iommu/amd: Introduce struct gcr3_tbl_info.giov
  iommu/amd: Refactor set_dte_entry
  iommu/amd: Update PASID, GATS, and GLX feature related macros
  iommu/amd: Add support for hw_info for iommu capability query
  iommufd: Introduce data struct for AMD nested domain allocation
  iommu/amd: Add nested domain allocation support
  iommu/amd: Add nested domain attach/detach support

 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  14 +-
 drivers/iommu/amd/amd_iommu_types.h |  20 +-
 drivers/iommu/amd/init.c            |   8 +-
 drivers/iommu/amd/iommu.c           | 298 ++++++++++++++++++++++------
 drivers/iommu/amd/nested.c          |  75 +++++++
 include/uapi/linux/iommufd.h        |  45 +++++
 7 files changed, 387 insertions(+), 75 deletions(-)
 create mode 100644 drivers/iommu/amd/nested.c

-- 
2.34.1


