Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED496777197
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjHJHkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjHJHka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:40:30 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6966A26BC;
        Thu, 10 Aug 2023 00:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4vnb0fdXjpxS7Qf/amz0SxZk4srAErUFvCEECzNeftAnNMBtRnVofW2tD4/2+6DjjIGK98/vIr3Z1VXPL7EcYVIQcvZpkTx0CLCoZpln8HrZmXPYJs2Tfw+7vkE9SbA+Re35psZIj35OUkD7KQTPCe63ut4w0H6mOL2QbUNId4IkzBWdq4gysYkqFuIKpz013YX5EnoyM61AWSmLmddr+k/G3vPoj/9mNmffaOUiVhUkSP+/s2d957I+v4finTUH+NYnjcqlmNPeSZNs92IrGfIh+dZs9T1oP53Fv/XdOBYdebCbqO8HUsF2O4jCt1ZD9r6FptgWUAKTRe1b0ydVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KVZcsU5wLNmNsZV2fXC998Zi1YeRhJaLYvlo00xQX4=;
 b=gayIus3aHUEOxh9cWZT85mfun0fMP/unDrpc8FeV8Y6mBlblA/EoRwraiPauUbx/8MoI/+o9YdZxVVdzyl3OdIq8k/REfKDCP5AwMdxltBoQaxE79e9MS2jfvEvVy4lnUjjxVlvuxu9fLSkYCrn9FukF2lrX4XIthxZ5W6bRN6A7DICSHXq2SJP/v270N9fPCoYMu7Kn78ZdG2Wxac7RYZ3USMPvZZqJKKuAjopnoCABHWD6+rNzPpFfZb26EWyM67S1BwO8f0oiOOPYc4MAR9ZBh2UwG4+Pn05RsQEUSEQiA3VOL11VER6BcoGsMzYVonWXJZYXsEx0CLz0NhAWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KVZcsU5wLNmNsZV2fXC998Zi1YeRhJaLYvlo00xQX4=;
 b=zvri3StkT/sJOZsgFlTjoBL67EqMlMLwP1LO+I4sq30ZPO2wiHIG0ZwyWPTnGLPmvboFY1RRcB9XiN3TdFm1yxOPmh6IbEJYUta09Z/J7hYQzddX8ilWafOPtqio+briwJhzVoVuRrvVxIOhLGpbSUUj30bl1AaEgAC4acwXDeY=
Received: from MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::16)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Thu, 10 Aug
 2023 07:40:21 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::9a) by MW4P220CA0011.outlook.office365.com
 (2603:10b6:303:115::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Thu, 10 Aug 2023 07:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Thu, 10 Aug 2023 07:40:21 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 02:40:11 -0500
From:   Evan Quan <evan.quan@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>,
        <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
        <Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <Mario.Limonciello@amd.com>, <mdaenzer@redhat.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <hdegoede@redhat.com>, <jingyuwang_vip@163.com>,
        <Lijo.Lazar@amd.com>, <jim.cromie@gmail.com>,
        <bellosilicio@gmail.com>, <andrealmeid@igalia.com>,
        <trix@redhat.com>, <jsg@jsg.id.au>, <arnd@arndb.de>,
        <andrew@lunn.ch>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        Evan Quan <evan.quan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH V8 5/9] drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
Date:   Thu, 10 Aug 2023 15:37:59 +0800
Message-ID: <20230810073803.1643451-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810073803.1643451-1-evan.quan@amd.com>
References: <20230810073803.1643451-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: b5feb5f2-f65c-4ffc-d489-08db99750d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBCpXufreKHvnw3zfSJjxCA+OkQnz0OqWhmpr0+u1NsdDOlp1o2vGiqrmakjBkn27upAgM78GM4soXkSM9HG+1jALdZgX06Yav6OsqFQA9XD56A68sKrHPvE2158p+lhHyDMqoPbRaGUofU+9tKdhL1UZ3JnT10affX99ow32rBF1vahTjwouyqULGPtNXeHQNfKPXmP/eA5pFcYfxl8FozBD12n5i6AS/joN2MuzGJcHu72u0EQFGMgQ1RCOjt0e3K1GsJYpwPk7swCDAfnXHNyNXOuyxGHITGmIXPRFW5Tw1d2ksfymHBidKOO+OddSjr2F7aEpPjbiT3UpyHAiNWTxko1LSY743ML8auzkTaBYjl52UmgpCQVHqMh71WSaERX/i9pNDzjxCn6ssq33Z+bCMoBGtrVOPBvm8dfaU554z26t7zKL9owLG+Q0RKnN3zdT5jGT2+MYDOyzW1xUY4BwIpO3deKCmeffdZMKg7NwekrXFIBP79Z3ZUY/5+EGrm5MXQgBwxe/ftfJcx5WX7KcpH/LF0HGPcanzmwhQOb7XNTiCEGQielUIotvCEa/Me2m3WC49MC/vMNjhzXX8D7pZQwM6TRDb2AXEsVfF/gET3WDAc+CvWdFkMdRXxymLaIuOLW4c3VlzK8YAnV70K8zz/GoX6xULQvetZoaVMU5usMWf32vkpiurSjBDuhd5Lntfs/S4RF+DPKUgD5GS2U8fTshQaqnFeFfRHR8eHDLDdiTdYcJkZJbuSHUzG6F10ZFI9hyUftd3qBGFPtBa5KYlNYcn/ZfEk7dF/MjDT/uy7zWL7NJHiyMVHYueg4swKXu0U+egwyzyU79kw5kA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(1800799006)(82310400008)(186006)(451199021)(40470700004)(36840700001)(46966006)(4326008)(8676002)(8936002)(70586007)(15650500001)(6666004)(316002)(70206006)(5660300002)(2906002)(41300700001)(44832011)(7416002)(110136005)(40460700003)(82740400003)(478600001)(54906003)(40480700001)(1076003)(36756003)(7696005)(336012)(426003)(2616005)(36860700001)(83380400001)(47076005)(26005)(86362001)(921005)(81166007)(356005)(16526019)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 07:40:21.1252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5feb5f2-f65c-4ffc-d489-08db99750d15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add those data structures to support Wifi RFI mitigation feature.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h | 14 +++++++++++++-
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h | 14 +++++++++++++-
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h   |  3 ++-
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h   |  3 ++-
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index 9dd1ed5b8940..e481407b6584 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -391,6 +391,17 @@ typedef struct {
   EccInfo_t  EccInfo[24];
 } EccInfoTable_t;
 
+typedef struct {
+  uint16_t     LowFreq;
+  uint16_t     HighFreq;
+} WifiOneBand_t;
+
+typedef struct {
+  uint32_t         WifiBandEntryNum;
+  WifiOneBand_t    WifiBandEntry[11];
+  uint32_t         MmHubPadding[8];
+} WifiBandEntryTable_t;
+
 //D3HOT sequences
 typedef enum {
   BACO_SEQUENCE,
@@ -1615,7 +1626,8 @@ typedef struct {
 #define TABLE_I2C_COMMANDS            9
 #define TABLE_DRIVER_INFO             10
 #define TABLE_ECCINFO                 11
-#define TABLE_COUNT                   12
+#define TABLE_WIFIBAND                12
+#define TABLE_COUNT                   13
 
 //IH Interupt ID
 #define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
index 62b7c0daff68..1530ca002c6c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
@@ -392,6 +392,17 @@ typedef struct {
   EccInfo_t  EccInfo[24];
 } EccInfoTable_t;
 
+typedef struct {
+  uint16_t     LowFreq;
+  uint16_t     HighFreq;
+} WifiOneBand_t;
+
+typedef struct {
+  uint32_t         WifiBandEntryNum;
+  WifiOneBand_t    WifiBandEntry[11];
+  uint32_t         MmHubPadding[8];
+} WifiBandEntryTable_t;
+
 //D3HOT sequences
 typedef enum {
   BACO_SEQUENCE,
@@ -1605,7 +1616,8 @@ typedef struct {
 #define TABLE_I2C_COMMANDS            9
 #define TABLE_DRIVER_INFO             10
 #define TABLE_ECCINFO                 11
-#define TABLE_COUNT                   12
+#define TABLE_WIFIBAND                12
+#define TABLE_COUNT                   13
 
 //IH Interupt ID
 #define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
index 10cff75b44d5..c98cc32d11bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
@@ -138,7 +138,8 @@
 #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
 #define PPSMC_MSG_SetPriorityDeltaGain           0x4B
 #define PPSMC_MSG_AllowIHHostInterrupt           0x4C
-#define PPSMC_Message_Count                      0x4D
+#define PPSMC_MSG_EnableUCLKShadow               0x51
+#define PPSMC_Message_Count                      0x52
 
 //Debug Dump Message
 #define DEBUGSMC_MSG_TestMessage                    0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
index 6aaefca9b595..a6bf9cdd130e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
@@ -134,6 +134,7 @@
 #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
 #define PPSMC_MSG_SetPriorityDeltaGain           0x4B
 #define PPSMC_MSG_AllowIHHostInterrupt           0x4C
-#define PPSMC_Message_Count                      0x4D
+#define PPSMC_MSG_EnableUCLKShadow               0x51
+#define PPSMC_Message_Count                      0x52
 
 #endif
-- 
2.34.1

