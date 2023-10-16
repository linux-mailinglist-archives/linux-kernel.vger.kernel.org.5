Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80F17CA501
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjJPKPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPKPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:15:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238A583;
        Mon, 16 Oct 2023 03:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol7LijPnKdIfV81CZ4RwzPvfnh+0kXWMFpSvMAy2NaNbFvUvT1Mw9/rxuVOeBOn4EFR1mKFdCnLiQm6xUT1WUHDsWw9R5VHiVjuxKq7QIkqKHwESVdruy5YPWiu7Hbj6XPE0VUh5gEvmB9IVU+UbahZgohkSgfcmti8u5PbItl82fSiBfvTSuMUXiJINHv1AEQUM7vOofLNwn3zj1rArZQhfDNCkHHHmzraGiQNCXly7BPYXTWSSpNLoOJBt5n5rXCOK4VDstT/DCBS7hL1wAWyBi+XV5jLTpTHUQl7lI7FcweMszgAhzAmlAacqxPHIp3yMoEIQkAgzjZg0UQKESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUDn0U9Vj5mshxuMLl85ZX5Xfcf22GbNmQ8HrOCMdsU=;
 b=GasdQmIA8o2U4SglhCNhmrxvNwQZFn4LZbF+k9z9I22+RUdtlDA+SwGfER/UmrirBdHMvtki+UxXxJqaUJQFbECT7JAupVZhHaJ/iBhMIU9qeglDc2hkHBke2z90EfLDw+XxQIBViBZYA2s88NnNSNFw7wao5yaytDSiL1htSEkv9nM22uBM29kk/uh8oA9HQtNbSLc6L8viOzJrGRg6xiO1PHB5eZmA5jlv4h1YLqnxijqP3RqmPpLj218qGIOHvZknhIx47Fd+4hnHQxS8DfY0RucsT9squFx2gqyivcOxXHF6a1W7txhzFGx/FeOg6+fNbORpvHb3tn6jiHLsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUDn0U9Vj5mshxuMLl85ZX5Xfcf22GbNmQ8HrOCMdsU=;
 b=UzInEI6yALcYfuadAVOXLJBui28fX/HCBW+ZKDeVfLoJ/TQCcXkHZf/31NKJovfwNBLpMrOvTRanVpJvRZK0LYwnJ71e9GGQY6dhkyS18fBwahDd1H6/r9YHZu+SOcws1JUXFiG0iOLT5IyZtISLOxPz9IH7gL2blEQG4/01SWvuc3vFGIIqg8xLV/9qDJoX7Rbd+4Wwbu55dtaTC1K0LjH51WAbHC74mHGUulCVOlKIUxjapnicxOboqWEa0ewx1oMx4Ty6kfa+PD5qOTPkSwKvVPyBr2akYLGwepuzPjVv3DeBHsI76wkT/1+3zRd3Wt1ffcqAIFEbI2c1uxKZHg==
Received: from PH8PR20CA0013.namprd20.prod.outlook.com (2603:10b6:510:23c::27)
 by SJ0PR12MB5454.namprd12.prod.outlook.com (2603:10b6:a03:304::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Mon, 16 Oct
 2023 10:15:09 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::64) by PH8PR20CA0013.outlook.office365.com
 (2603:10b6:510:23c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47 via Frontend
 Transport; Mon, 16 Oct 2023 10:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:15:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:14:48 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:14:47 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 03:14:42 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <kkartik@nvidia.com>, <pshete@nvidia.com>, <petlozup@nvidia.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH v6 0/8] soc/tegra: fuse: Add ACPI support
Date:   Mon, 16 Oct 2023 15:44:28 +0530
Message-ID: <20231016101436.7146-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SJ0PR12MB5454:EE_
X-MS-Office365-Filtering-Correlation-Id: 595da9c2-5ecd-43fa-2053-08dbce30c6b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XoYF4S1RiNEF6dRbmZ7X3SGpTH39pTgS7BjHBFhNjZwTgMAbRqxS66OTk4lAzE/c94PAJFDm88Tp/e96jLEqLgtZ6K7oqhl3xRZQioc9hlrfb79EZBCdTl62lkmBcQOIj5IisyeUpDgHH5PBsJLddDyuIXT+OsPWoakBdzpLU+QFWoBihGM9YwWDDkQ4wX23KXctc7NarZjarmZGhzmHPdDOEKMLfgRbDJviSXP4gjNvPmE53Cl0LiQx5RR5EYXZZPCir4P2f0fN2Se2sbQanT3BG3dmY8xVaHmmGecdX4SlUXSgHfrSmUe5gaS35pvw2pvDuEoQjEBBHJkNPRpT575RpZU2TNIYpC4I9BUIak7c5AXJOfTWeJXc+txBvfrp0IP1BUzCJZLhFinHiKOPimTpbPzHmneyMF1jn7Lp3drn/7JQALpFv+HNz5w1B9IK4Y6ElbchxQE7q5G7c9rRDEsjWm0HXf+P5G2DFaeMHbf5dxn4k9mLJ4RJfGlSakU4Hsv6sTP1UmZ64sck0byk4wf1Eafj//3ngue9P4ppX+4r81rMpdc3lv0vzxkPaqZGah7IuPcHdhZJM4ZD9nz8HKsViMd8odEgGjlER2IyuV+YFPk2MarbrhqKxak56AVEqEQhGZPIsWjryeoQJXtmzxUmsUkxypwq3fMdkygdG3CSPtySCke77BOrMpuGkmGu2meMD8znfyWoLIZfV3CIkyYecCSOzWXgKfcnJ1/C17blCCceQ+l8oDLc4qS74m9m+8EK1JXJpZWN0Qzl4KnKkNH0FAs+DXeKz2dVpdhtT7hsJUWypZnLN4FrAmjeLaW7
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(6666004)(478600001)(36860700001)(82740400003)(47076005)(86362001)(36756003)(7636003)(356005)(921005)(7416002)(2906002)(83380400001)(2616005)(26005)(336012)(426003)(316002)(1076003)(110136005)(70206006)(8936002)(41300700001)(70586007)(8676002)(5660300002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:15:08.9267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 595da9c2-5ecd-43fa-2053-08dbce30c6b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5454
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add ACPI support for Tegra194 and Tegra234 in
Tegra fuse and apbmisc drivers. It also adds support for Tegra241
which uses ACPI boot.

Kartik (8):
  mm/util: Introduce kmemdup_array()
  soc/tegra: fuse: Use dev_err_probe for probe failures
  soc/tegra: fuse: Refactor resource mapping
  soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
  soc/tegra: fuse: Add function to add lookups
  soc/tegra: fuse: Add function to print SKU info
  soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
  soc/tegra: fuse: Add support for Tegra241

 drivers/soc/tegra/Kconfig              |   5 ++
 drivers/soc/tegra/fuse/fuse-tegra.c    | 112 ++++++++++++++++++-------
 drivers/soc/tegra/fuse/fuse-tegra30.c  |  20 +++++
 drivers/soc/tegra/fuse/fuse.h          |   5 ++
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 110 ++++++++++++++++++++----
 include/linux/string.h                 |   1 +
 include/soc/tegra/fuse.h               |   1 +
 mm/util.c                              |  17 ++++
 8 files changed, 227 insertions(+), 44 deletions(-)

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

