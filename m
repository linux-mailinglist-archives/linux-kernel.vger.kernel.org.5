Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473047BA9C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjJETJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjJETI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:08:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97405E7;
        Thu,  5 Oct 2023 12:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guAZ9Fk/tqpF7OlArAfrOJqYURhojkYhvefRLxB5gD7dXPRjfT2w+Gd3Wb5JA1p0RWCtpmqeOcZDOnV7dJVy+C04jXDOWdARVTNCPdi3s6AsmyEW8G4uYl4rnBmLhb6E9cLxZXWvpFJNSCbiU4uPRHVM8bHeJImadmMGVMgaomICygfkfdcnOlicJHuHHHtcVK+P5CUynDyvcNRcpO3nhW+vwAqwbGYUG57rh31SfkJHZAD/I/G5O8vAus+Mdqk6uUGyb9RtotSsFsFArTVdOk7bI+Ru36M9TAvoI8aRDcGXnHu3p3B8vyuIKxid2NURWaZ4GtQcg3De2YRTIEDYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/XMCJxftJEDKpTeT04yXzq+yXfO/JwuB/WNJvDBs74=;
 b=KTMW12DcOnJtSsOIkNq7idVLF+Jr+OGNoCJs8YUjxC7lj52zh0NMo2Chr/PdJuTEW9Uhiq/aUGrjqN200QIY82ps0D0i20r/jkJtda/DIgsOsRuCCFpgMTAPVLYMC25pVS0BpQi4HCahrz1StkBnqxumNN7AWqSdk6PTlc12Rs5YMbWQiv75PXbpkRyxJXTSx5hgluPkaYH/+MZVWaTqAUHt8gLRPbf+nY3vXimVkvxroG1ndIc8nIc0xRXTb1e2ST8GQa64bI2ZL2KPy9tTF1N10cCeQk03EtYDe2EKXJTLRoX3PCZxjClbehPxeGg5gR184wJFTd0a4KEs4SD6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/XMCJxftJEDKpTeT04yXzq+yXfO/JwuB/WNJvDBs74=;
 b=BdJvYhO7N0oLJ61rGSnLmooHqrCBOerS6dSdHfM1bVMSeXvQX6jAVj8Xjd5ElqgRL5Ol9Iyg2idQ01BvQsRi6lXuPLGvTLmUfnA1iKtGx/f9JyeymlbWpvOMb0Cy3XBxfO/DAsSv4kSJUhvXc0y5AEdyvUGr4sOqqPxnjGqs2fA=
Received: from SA1PR04CA0017.namprd04.prod.outlook.com (2603:10b6:806:2ce::22)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Thu, 5 Oct
 2023 19:08:55 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::18) by SA1PR04CA0017.outlook.office365.com
 (2603:10b6:806:2ce::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Thu, 5 Oct 2023 19:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 19:08:55 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 14:08:54 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@kernel.org>,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v2 2/2] Revert "drm/amd/pm: workaround for the wrong ac power detection on smu 13.0.0"
Date:   Thu, 5 Oct 2023 12:52:30 -0500
Message-ID: <20231005175230.232764-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005175230.232764-1-mario.limonciello@amd.com>
References: <20231005175230.232764-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f382354-9212-4671-dd41-08dbc5d68591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CxaP7d9V6q3cCkN3wGWaW3MEz/835PtXNagTveR+cnkTBJbB2MzzkKsVLd9tMUHXdEjzSsAV2s8MUZT1/hzcNNsV5rGOlfLAs5NhSd7Wta5KubBHWFpcIPxiUuqwK2uM1BkHUZhhQ/o07r1uYWqtrsLAbZ0a85DBI3Ph2k7O74WX6i64lw9cxGlpmRAy2TQukJ575ih1jnz29B8lD4qxiq1GBntIm5yzuOvb1h2VKN+r1Ou6Gul5ICUx43Fw1lUSZHusSICj+go3mlX0Ok+WN0amRYnjdcZ8X+oBfzZi6wwJpiNokdUASRJnLaZHTBvUxxGq0qKJaOmrxaTe9Cz9zJ2+A58DEH9JC7UEs9Y6QFU6mzdoKu7tsi+Rw+/EF4ltZIbiI22p4F/YoHvSJgX9orn+17UbMEIWXDsw7oaZirz3hludJk0gTU9d588JtwROGrGQK+JeKplVYpqJ/M4hrOUj54X/9HIzDnXrNK9RhSKH5Lw67zDuK7Oug9MoVbnl5GsU76MIahLHfHtzJxf9H2k378QCeKOfvQrq5ZYx1AalqEW4C8+n7BCV6CrFX2vBzokadFYVjEXREXHcj4p1+jUWMvshKKWRNdQY3d7VQma3qatQaISAFLgVoZTZWh+0ehNzi8yWUmtBvBX+yCUNoVnixl2H9qi+iOwGA0tQ+RN1tioHozixkLpVGmegRr5n2zWu4OgjKVH7f7p3BWDj10eLaVMNDz/0tT6JOvPXLxagbYP8fVutODHSzDlRYHt2KAJg8x9qQnS+U9dp9/9xng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(82310400011)(1800799009)(64100799003)(186009)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(40480700001)(6666004)(82740400003)(81166007)(356005)(478600001)(8676002)(70586007)(5660300002)(44832011)(4326008)(54906003)(316002)(110136005)(8936002)(70206006)(83380400001)(7696005)(41300700001)(16526019)(1076003)(26005)(336012)(426003)(36756003)(2616005)(66574015)(2906002)(47076005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:08:55.7034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f382354-9212-4671-dd41-08dbc5d68591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0e5e1a84f0b8c814d502a135824244127fed8f23.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 08cb9f8ce64e..9b62b45ebb7f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1026,7 +1026,8 @@ static int smu_v13_0_process_pending_interrupt(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
+	if (smu->dc_controlled_by_gpio &&
+	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
 		ret = smu_v13_0_allow_ih_interrupt(smu);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 07df5be063e2..0fb6be11a0cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2662,6 +2662,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.enable_mgpu_fan_boost = smu_v13_0_0_enable_mgpu_fan_boost,
 	.get_power_limit = smu_v13_0_0_get_power_limit,
 	.set_power_limit = smu_v13_0_set_power_limit,
+	.set_power_source = smu_v13_0_set_power_source,
 	.get_power_profile_mode = smu_v13_0_0_get_power_profile_mode,
 	.set_power_profile_mode = smu_v13_0_0_set_power_profile_mode,
 	.run_btc = smu_v13_0_run_btc,
-- 
2.34.1

