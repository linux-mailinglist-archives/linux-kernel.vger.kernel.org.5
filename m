Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C337C516B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjJKLRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjJKLRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:17:05 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151E6101;
        Wed, 11 Oct 2023 04:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2jrPupHPTEZs/km0lIBlzkZ054YAoDlKOSMy1p7oART13QnQ6aZlx7i7s6wb4t4acKfbt9KpTv2N1dqI7IMTvWmz8S0BVz+iDImvg1v/ImaKySFGrgbY/7UwiduWCjPVOANF5iVXrl1JXn+BGj4YfsxSreVTjArqFDHVCUD24U+prHWQHtITVB67djPfhQdjUhrbD0N9I4RV1PELdqPBICPNNYSZeGIydipRPEZa3wKMAiWPf9Y4fct6CJ5BY0nnIl0EP5P+BSJQAi4DO4oLihEGnKn0b+7JnwDgNEVRIP63twyxjPuA4U/UO8ZtaJBIWATFRtyw3/sTJwMDTxfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QaSJSZj67f4rRLWQVMxeNFNpUdr9X7WMvuMIc5Dows=;
 b=IzZeyb/47vo0WzVA96fPvIHOTbYPUfTgl8Fz1XoYtR2+F/BiVu9+WCRP/3u7ovCE+K4Ynl2T2rXE7roajprwCxxWw8oV5j2mBkA8ag7pdfv30+jiQdxbbkjmbj9WsZaFq9NKMfEBDrQYGFEYVdeqNXT30YL4KwN+87kGIEvjdphjI5+c96o0UuGcoulSA5O/JLcnyUEJAvdwYoUQoE7cHh3u3V3sPl6g5LMdQguiYiRfVRhdSyGwgFI2NDmg74Vb5K6sJoHaMmVGG0QaH2hkqG781hYUqk9NR3/GNNTIkM8xyaA3aNXq4zJLEnE8hXDLS1RW5H2pGEG8wzbt/iM24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QaSJSZj67f4rRLWQVMxeNFNpUdr9X7WMvuMIc5Dows=;
 b=JHG2uouWIerbOH2/eW1fR45d/1ah9mzYmZyOATJ4tEBiWNunzWfjMfEtQ3PxqSrfm1QpxHUiskIK9qyt6OiRdvyfvyHQpdvnNY0FCiulVJwmvKYP8+38UPqYnIgehAQcMjsurrf12+uxw/8vcxbpuwZipwjd33DVoXR0obDSB/SJDjD2AFWlDRiw6jIgsWpmxiOu7KAzWzvV6Fl6m4/y7qKYCSfMybmAEVZciA+o4NEVtAL4PgjyLbQkRQmlDtjJ5Xz66HW8y0DgP2mPXqoIpsTf4HlPrSJs0djXEDqNDpF6vfrgFc5xROQDro/sW1bA+I3GVRAqJ8bmStXmiNyG0g==
Received: from CYXPR02CA0050.namprd02.prod.outlook.com (2603:10b6:930:cd::10)
 by DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 11:17:00 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:cd:cafe::bb) by CYXPR02CA0050.outlook.office365.com
 (2603:10b6:930:cd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Wed, 11 Oct 2023 11:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 11:16:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:16:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:16:44 -0700
Received: from localhost.localdomain (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 04:16:39 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <petlozup@nvidia.com>, <pshete@nvidia.com>, <kkartik@nvidia.com>,
        <ulf.hansson@linaro.org>, <frank.li@vivo.com>, <robh@kernel.org>,
        <stefank@nvidia.com>, <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v4 0/8] soc/tegra: fuse: Add ACPI support
Date:   Wed, 11 Oct 2023 15:04:04 +0530
Message-ID: <20231011093412.7994-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: e65d3707-195a-427b-7000-08dbca4b968c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7Gsa09xncfehiajBoGXFh0B71VoyVfmn8mNzkD+9KhVEyLd6Gc/KjNAuvlWkNGZoukgYZLJggh8osIUhpvmJJHKvMrIwHGMnyyOKF5Ln+HMoiAnGnPZxgiv/RiEOmpSDtf0h6wECUlmtHF61vRoBkXeIPaHjZdW+Iwx8oW6qqJU6ULFCtFjM6MRhk7iCJP2O29DQo5q2ptHekJJ3WJMoSCdhxMQsKQuQ+NBJAhuITQtgV3O/8K2lsRruupE/jS1kD4YJTRKLg5rV1hMeVjOQC1jDVys4MyjGpjnMd/HpxT5pxjYNXWF+7lofkLV3nOrqYrHlP75DgyuGzHFcdYrFL6wPeTlyOSgBxBFWjL/ZyINZBDo6htIJmvduxteh5yHy5QPaESVH1nF3ApveSVxiVsYmv861+dmIM6Q/fPViGqG/y2hTQNwBUNHYQ/OtyTSugPRkC0HNk7A7BsZ+HeOJ8h3//9mKn0wF1kVs6SkUMWP1NdI7RaxKV2wZGeac9QF/UZ1DmQ7xtjhKug7DmhIKxmKYRWoijMdBfO9lwP6Bhn+cVi7pT2rqUyzepaSnnlBsqsAsFXx87OGqaL8ZOJuTGJ7SjJUQB1d4BvWDpWL34EhkCqzusKjVcJz05RMd0PhNEBFRh974cRhq7Cj4O+XuSlF2XDEKr+unwAwhKX8Nj7CONwy9EIiFKfGq/utUXWqfU15KWmsjTXU1JBIxhLE+KcBtBPxlpqcT2LDc+YpdWxdadPb9310QqfiyBfw1KvCpUOl2mPJc2Vo/xXkA8Ju5/KdgdE4iWGB3rw09k4oIurIewVGYde7VifZDxVLJNHQ
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(1076003)(40460700003)(921005)(356005)(40480700001)(36756003)(86362001)(7636003)(82740400003)(36860700001)(26005)(336012)(426003)(2906002)(7416002)(47076005)(8676002)(83380400001)(6666004)(478600001)(2616005)(8936002)(316002)(41300700001)(70206006)(70586007)(110136005)(5660300002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 11:16:59.8794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e65d3707-195a-427b-7000-08dbca4b968c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499
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
which uses ACPI boot.

Kartik (8):
  mm/util: Introduce kmemdup_array() to duplicate an array
  soc/tegra: fuse: Use dev_err_probe for probe failures
  soc/tegra: fuse: Refactor resource mapping
  soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
  soc/tegra: fuse: Add function to add lookups
  soc/tegra: fuse: Add function to print SKU info
  soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
  soc/tegra: fuse: Add support for Tegra241

 drivers/soc/tegra/Kconfig              |   5 ++
 drivers/soc/tegra/fuse/fuse-tegra.c    | 117 +++++++++++++++++++------
 drivers/soc/tegra/fuse/fuse-tegra30.c  |  20 +++++
 drivers/soc/tegra/fuse/fuse.h          |   5 ++
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 110 +++++++++++++++++++----
 include/linux/string.h                 |   2 +
 include/soc/tegra/fuse.h               |   1 +
 mm/util.c                              |  34 +++++++
 8 files changed, 249 insertions(+), 45 deletions(-)

---
v3 -> v4:
	* Added following patch to introduce kmemdup_array:
	  "mm/util: Introduce kmemdup_array() to duplicate an array"
	* Add "soc/tegra: fuse: Use dev_err_probe for probe failures".
v2 -> v3:
	* Minor changes in following patches:
	  soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
	  soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234

v1 -> v2:
	* Used '--patience' while formatting patches.
	* Added "soc/tegra: fuse: Refactor resource mapping" to share
	  the common code between tegra_init_apbmisc() and
	  tegra_acpi_init_apbmisc() functions.
	* Dropped "soc/tegra: fuse: Add function to register nvmem"
	  as ACPI and device-tree boot are sharing the same probe.
	  So, no need to refactor the code here.
---
-- 
2.34.1

