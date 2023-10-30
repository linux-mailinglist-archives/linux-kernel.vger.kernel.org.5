Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539CE7DB3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjJ3HT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjJ3HTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:19:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E32C0;
        Mon, 30 Oct 2023 00:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyS1wfX2uQ05U3gwIBfg+mRv5LUk1PBFUF17e5rd5tzhDCZPXlmRikVHvGo+oaTKHU+RUB88fMp93duAsisHrkMew5HOz3wR7ox2BREJS83WTPFnn32pJ1BB54INpNoc1hE4nOBkLSYg6gNGprxMw7JrupYQ+teXDBVAy4fVIi3b1ENLx+wVXO6PH9OgLwJc7vlu6EeFprvo2pVQNmCM+gVGzEros+9fendm1cVBVWz8sa2PH3JlOjktbgLBecf8VyHeMxDTNWRM1asWR2geNe6rYhmuoul6RyCJZl6vC2WtbSuXqLzB0f6HvGnWaVfXUn8f6W/rBzCc1TaCQ7ftRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ficDW/UdS1g8onjGk6s36wMQbZpacvfUUEiEsh8QtZs=;
 b=JhkvBacrBWCJdTFN5/glVTPQ3RcpHDnqjVDpu0YjjNQ4H+XX4OeP1u9ui5ydsSu9PnnO7z7b8mEwTVrGtyCHklnKFJhQxvw4bfJ9JM9AwYUfLc8gHIs9y6vX07lo3ejWyQ5AaGnWx4X4bY3d2awO9Gq2nrr7TfKoMWARsZYT8ZSCyBkyGAbO62JJ2Obpk8k08xdg6FXCtVf7WjhibR3LtaBm5DG61kMgYhJHCxJbIcQIdpizh7NylwkQpUQPqnuQyjc5khL03/p/d8YywdotY0fUr6LUstO2iaDLSRyfXAIGZleWRLh43xcMDIldwQbTksIteKxbiG+n7cnIqqcYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ficDW/UdS1g8onjGk6s36wMQbZpacvfUUEiEsh8QtZs=;
 b=MJ7IsDv+T40tTRu3BOKb9OXkOUo/bA9RffwNmxggZQVhts6l+hAJZJA3RCLdDa7bzUR1mAhPRHAUeGun8izUrqsWMePqYy18q9WDKUnQtK9DP3ugdCT/HjRZ+kQyG7tdERtrwOHO/Mbs/zEPk/poyqUiVGc+VQTTl5lb5YPrU8c=
Received: from CH2PR05CA0014.namprd05.prod.outlook.com (2603:10b6:610::27) by
 PH7PR12MB6492.namprd12.prod.outlook.com (2603:10b6:510:1f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 07:19:16 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::97) by CH2PR05CA0014.outlook.office365.com
 (2603:10b6:610::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.15 via Frontend
 Transport; Mon, 30 Oct 2023 07:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 07:19:16 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 02:19:11 -0500
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alexander.deucher@amd.com>, <Lijo.Lazar@amd.com>,
        <mario.limonciello@amd.com>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [Patch v13 0/9] Enable Wifi RFI interference mitigation feature support
Date:   Mon, 30 Oct 2023 15:18:23 +0800
Message-ID: <20231030071832.2217118-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|PH7PR12MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: c274aa00-5a4a-4739-698a-08dbd918866f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vm+6UrLZK/6/FnGVDLIxa5as7/B/QeZT9aNGMXhNuM6luTUdddoTGAFzN5ivV6s8+YbMZiLDu+ZZYO+unyIEM5MxJjiA9ZZ5vaetIkQhIUzOMA8h6iO3ixrmvm60u/Bj4GZnz1ctfyqxQNqhprlDKQvByOabtB1GtcXqtiljpkCJ9TC0lyb/Y2h6Oyygg50bBjjqMKH5uR+Fjyv4/yrZ0HEHYX3q9Z/Y44r6zybiNKeZwJTwvpVyDC/G4RkG3CKrl7Zj2Sz+ZfssNgr3HPoif8FwgzruTrTTj4Ah0Xtdktu8PKsPnDwIkGgc/cNHbZVN6xAEF39o8phX0uAewmthgWdLiI/px1snJXiwY128YqgeHM8kQO7vH3NGI95oas+DrlraoI2ZHyL+h4cND5EcP0xORZ5rfjh5VUs+KIsupS5N0b/BlrFZkR3VtZljVbQLgOu8YZgeLXVhrVCpa6ghJXtVcNvKEdzpRF2MJTlFhpRENAK3AHrZTUcWnM9WhqzRysvXUS0Vbph7MSjxmn8CJRvmKKcAssQxFoC9yjlEAj6wZottIx7FM9i9bJ701HVcafSAyrgczAxpPV8AoGiuEFfXl4qH9WLStt+6BmFkSABKRddeHsHI9t3zZrPFiqfYsLJPENF3bVPiS+S/g6ww2xofmDTg8z9b+7/x3ZukoFBeA6qNe5eaKjOKuLkAnnD2y5v89IUF3WvDBhoHCOJ0E84XJI2VZScGDWy+QZBBkecX4kujCCMdfm+vD7sER3CaKo52uouPYmSUNtKqDR/m2GwKQjKKJfVi4iBJPDobcOA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(36860700001)(54906003)(356005)(47076005)(81166007)(82740400003)(316002)(6666004)(7696005)(478600001)(110136005)(83380400001)(70206006)(2616005)(70586007)(336012)(426003)(1076003)(16526019)(26005)(5660300002)(41300700001)(2906002)(7416002)(8676002)(8936002)(4326008)(86362001)(36756003)(921008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 07:19:16.0166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c274aa00-5a4a-4739-698a-08dbd918866f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6492
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to electrical and mechanical constraints in certain platform designs there
may be likely interference of relatively high-powered harmonics of the (G-)DDR
memory clocks with local radio module frequency bands used by Wifi 6/6e/7. To
mitigate possible RFI interference we introuduced WBRF(Wifi Band RFI mitigation Feature).
Producers can advertise the frequencies in use and consumers can use this information
to avoid using these frequencies for sensitive features.

The whole patch set is based on Linux 6.6.0-rc6. With some brief introductions
as below:
Patch1:      Document about WBRF
Patch2:      Core functionality setup for WBRF feature support
Patch3 - 4:  Bring WBRF support to wifi subsystem.
Patch5 - 9:  Bring WBRF support to AMD graphics driver.

Evan Quan (6):
  cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
  wifi: mac80211: Add support for WBRF features
  drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
  drm/amd/pm: setup the framework to support Wifi RFI mitigation feature
  drm/amd/pm: add flood detection for wbrf events
  drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7

Ma Jun (3):
  Documentation/driver-api: Add document about WBRF mechanism
  platform/x86/amd: Add support for AMD ACPI based Wifi band RFI
    mitigation feature
  drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.0

 Documentation/driver-api/wbrf.rst             |  76 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 208 +++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  42 ++
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     |   3 +-
 .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     |   3 +-
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |   5 +-
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   4 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  48 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  22 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  13 +
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
 drivers/platform/x86/amd/Kconfig              |  15 +
 drivers/platform/x86/amd/Makefile             |   1 +
 drivers/platform/x86/amd/wbrf.c               | 413 ++++++++++++++++++
 include/linux/acpi_amd_wbrf.h                 |  94 ++++
 include/net/cfg80211.h                        |   9 +
 net/mac80211/Makefile                         |   2 +
 net/mac80211/chan.c                           |   9 +
 net/mac80211/ieee80211_i.h                    |   7 +
 net/mac80211/main.c                           |   2 +
 net/mac80211/wbrf.c                           |  95 ++++
 net/wireless/chan.c                           |   3 +-
 26 files changed, 1094 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/driver-api/wbrf.rst
 create mode 100644 drivers/platform/x86/amd/wbrf.c
 create mode 100644 include/linux/acpi_amd_wbrf.h
 create mode 100644 net/mac80211/wbrf.c

-- 
2.34.1

