Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A446765DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjG0VKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjG0VKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:10:15 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B3730DE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xi4er+ffr6FETN/zt94X88q4SEjiGGwMXtDEvf2vsO3CDTCQK+VzhhxVDfwhsCK8XcZrGDV/9Emd1IaUgwxBe+TR0As49K1b3spqLTBznjOj/6xpT5GTDumtK4qQhbb199kSQEBR5KxJ5Clotvkg4r48tVAB173jlH6RkScJ6rBdirUhpcI3xkKR4lXd7FbnZotZhENk3KLUlp4iLtvGEOkBLJHVK9m0woyMsYnirHlVUPA7sRj63jrp92slP/itmovK93T4MQhgGdC5pQIlgcfB2eFszteeCHv4dVe6j1Uzr+18W5tq6NhSdkRByJk2V9y1s8FtHIXMFKjgMAc+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0UVPOb5KnoKRuEKA+5tyEBedNW/RZRdu00ROnBn4Mw=;
 b=KIprb+GHjVNbewAMuiT+v0us9KpaHPrD0413wd7GmP2G6gkfr7YsJ3FRTM07Qej6x56RSySVcepHacrtsGPMQ6GddwLeo+19LYRdWpLqEDqQzhW0+vPFQ3u98MT1iV19HEDalxxtS9K43xI7cEh0ZlS9e1yzPKTbH92RIfU1Xqe6zgDdnEN/ei2cK8kDtp1wkSQdUMQX1gLQ6fOzGtIAlT9+FwgfoDRSNg3EA+9+ICX81dPmRVXMhig/Bkcc7A7TkbruWdrkuh68CxaRUJOCOBYjzYVSsLOuQ2YxkCy4pacJfzlOtMmvooCkIroJVDLcUk6zzR92FrjyemMwoWMlQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0UVPOb5KnoKRuEKA+5tyEBedNW/RZRdu00ROnBn4Mw=;
 b=Xv0hTwtD4ZO/eh0+F+B4kiJN6W4pNM6Ijjld9S4GvUMwfp2daeU4+GBOHPzP4UWRl5F6i1dSyH8sLU1wOk7ONS1vQXKxbR/ZOle8sdhwRihyBvr8WvMgnUslY8wQak1l63c+VObyxmLmPqFExQ8caEeIPLA9bxOmo/b3LEwWD2GN3croocRR003sNsuwcl3VKNYJxoOHtn6jWvV3ycNVb+jaycuwVCBG4Z4xYiWaZxocZisye9Qm+0J2NLvupS0rN2AH6PVMY5Yeqoj3oSl2OoJpmrU0WoGvnwuZT+5jRc2hOhT5jCrDBweBV7ASSzATWbePjK/kfXKzwhWZ4Er7UQ==
Received: from DS7PR05CA0095.namprd05.prod.outlook.com (2603:10b6:8:56::29) by
 SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 21:10:12 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::9c) by DS7PR05CA0095.outlook.office365.com
 (2603:10b6:8:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5 via Frontend
 Transport; Thu, 27 Jul 2023 21:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 21:10:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 14:10:00 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 14:09:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 14:09:58 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/4] Add set_dev_data and unset_dev_data support
Date:   Thu, 27 Jul 2023 14:09:39 -0700
Message-ID: <cover.1690487690.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5cade4-430f-420a-4273-08db8ee5dd5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TyA9LsiskkhN/qy84QN6Tchp2XyHDXeOjRwj7MY9/k6rTcE09Civ/UO+px6KrVrKqVQUAMQcKIcm6woHDFkMR83JFtTQrU9GSYI+wlFJFd4YexsLg0C1kYBakKpQNDe/tpyy4yVXr2Zl0teyFAmuBRXIg2p/R1cHzDmIdUP+0HCb1SoVrLTWbUE86MET7SQO2iE+3Si5bsLfMAnjhogjlCzu8mI4Tf/YoieClDbtK+4InuBao0Mc3RcsuKvvbnafniiC0AJ2qz+bvr3fLmuAPFHKclFPIBzt/VCqJWI73NclB9fMJ3VxscELWHvmJzny+pjcC5Rf06eolFyJkWb+MGwZzne72Xh3IsSftpzolbN118aYKcVzfVb5G2YlIZqfUtk2vbFVm/Gjq48UdiZzW7ne74q3Kt4ELfucC/CgGoq2lEwLowcpZiBRl92rAlRJlhff8OWokLMJz63K9sEogxowjQEbs4Wsr1iceHBsTqbAbnLAqN3KMl82wzD9sS/OUUrtfhGu8CMMuVe7t2LdXOVp75k5SnjIJmiqAHEQ18UfBWEEv6KkOmaXxpttreKfUlkZVPswXW2mo5A9sHhWOPlC1NgZKBFBZ8c2aTSVIRrh7TE43Ac6PmRxJifYt23hZiP3LFMcchehJGV1pL/WdApO/uTsoPV4h2AITaec0Jkm4d+SicXvNesELYU2FxeCHc5V0htv1fD8TREmBbFNn/TCJEKXieKOmsA4M5qskBLr9j/xwRbx9eL1LF0vJ4EguzNg5v+3d4bQPSLQsTLDccBqnNYYqELttXzcsyWpsyLdBFS/DNK5UJriBUowu3Y
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(356005)(7636003)(54906003)(110136005)(478600001)(26005)(82740400003)(70586007)(336012)(186003)(7696005)(426003)(6666004)(47076005)(4326008)(83380400001)(2616005)(966005)(36860700001)(70206006)(5660300002)(7416002)(41300700001)(40460700003)(316002)(2906002)(8676002)(8936002)(40480700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 21:10:11.4026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5cade4-430f-420a-4273-08db8ee5dd5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
v5:
 * Renamed ioctls to IOMMU_SET_DEV_DATA and IOMMU_UNSET_DEV_DATA
 * Renamed data structs to iommu_set_dev_data and IOMMU_UNSET_DEV_DATA
 * Added missing TEST_LENGTH for those two new data structures
v4:
 https://lore.kernel.org/all/cover.1683593949.git.nicolinc@nvidia.com/
 * Rebased on top of v6.4-rc1, and iommufd_nesting-v2 (candidate)
 * Dropped WARN_ON in the destroy()
v3:
 https://lore.kernel.org/all/cover.1682234302.git.nicolinc@nvidia.com/
 * Reverted the data in VFIO BIND ioctl to a set of new iommufd ioctls
 * Replaced the iommu_device_data_size array with a dev_user_data_len
   variable in the iommu_ops structure.
 * Added has_dev_data check and locking protection
 * Added selftest coverage
v2:
 https://lore.kernel.org/all/cover.1681976394.git.nicolinc@nvidia.com/
 * Integrated the uAPI into VFIO_DEVICE_BIND_IOMMUFD call
 * Renamed the previous set_rid_user to set_dev_data, to decouple from
   the PCI regime.
v1:
 https://lore.kernel.org/all/cover.1680762112.git.nicolinc@nvidia.com/

This is a pair of new uAPI/ops for user space to set an iommu specific
device data for a passthrough device. This is primarily used by SMMUv3
driver for now, to link the vSID and the pSID of a device that's behind
the SMMU. The link (lookup table) will be used to verify any ATC_INV
command from the user space for that device, and then replace the SID
field (virtual SID) with the corresponding physical SID.

This series is available on Github:
https://github.com/nicolinc/iommufd/commits/set_dev_data-v5

Thanks!
Nicolin

Nicolin Chen (4):
  iommu: Add set/unset_dev_user_data ops
  iommufd: Add IOMMUFD_CMD_SET_DEV_DATA and IOMMUFD_CMD_UNSET_DEV_DATA
  iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_DATA
  iommufd/selftest: Add coverage for IOMMU_SET/UNSET_DEV_DATA

 drivers/iommu/iommufd/device.c                |  2 +
 drivers/iommu/iommufd/iommufd_private.h       |  1 +
 drivers/iommu/iommufd/iommufd_test.h          | 15 ++++
 drivers/iommu/iommufd/main.c                  | 85 +++++++++++++++++++
 drivers/iommu/iommufd/selftest.c              | 42 +++++++++
 include/linux/iommu.h                         | 13 +++
 include/uapi/linux/iommufd.h                  | 32 +++++++
 tools/testing/selftests/iommu/iommufd.c       | 22 +++++
 tools/testing/selftests/iommu/iommufd_utils.h | 59 +++++++++++++
 9 files changed, 271 insertions(+)

-- 
2.41.0

