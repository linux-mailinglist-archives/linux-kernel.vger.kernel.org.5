Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B347F59FB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344926AbjKWI2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKWI2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:28:38 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E73BC;
        Thu, 23 Nov 2023 00:28:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzqzrojzsTUBmHuW2UDZnJPAqUPkzoHhiBq7RdsPMNbGNTwQNkny3Vv+uprat4G8ahR5nc2D3tQoylfQ751+Qlf8JpSF9N9jDeMuZy29LO1YiijY0hjoVT/eQ10JzdoNMUHIMsM8/EROiPWSrRU0okcqUviOM1/PfTXPGDVE32+IcJc7X+2idazBCkif5yANZAUWYWksVWwdIC3NUsPIAAKS+gU6fUrYo8Gtx0WbzYeJrj9fWbeieJtH9CaKJAHSFt8+GSrJrydX+bpO1Ew9ejdN6d8IqUEIT1TXiTX6TaZT3wijWH9SZc6CmolD0dtx+o4OctmkF4W3P3noqWcQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA1DghR5CuUIJAL1SUAdXjQCkegyBdqtzc06cDEKgfc=;
 b=S0xERr80/9KoE2lEBDBff1NYF+ExcVmLzztUvjCfhsWIXdyUrQGqZUFQlJ+0oqIWdRIwn46pjSNYVsEIl69S2JOZVsw8E//p+dG0jtAXacr6LuP6z82Q8B+WjMUk09Zx73Sj2CcaAHqZwz89yH+j/NQ+fknQkBcRKnpiYv4de5AHQ+9lkHxows7T4EbnRyzc6CIbm61f0j/1irlxIHisGxZWXShlI01mYSsoEejEGBDcYrT51XR089d3R1VKVgNWivOBGSeDT+g4goNjl77F1KZCHcsj8juGw9pZPSqqdJ2aQ655hDvyCpQ6OKLM/o9bDEkS1ACRWmFLcVGWJlALww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA1DghR5CuUIJAL1SUAdXjQCkegyBdqtzc06cDEKgfc=;
 b=AZr9VCN1XVGGw/Vw5G4Asz96gVIwIjPoYHaYqG12oHy83bQqTyL707GEC7bRPpzgKfqjiL9BGslQ9YkTQj4g+gRX8DvjwK+6Mb7cMDOnkIvm3JrU6sLL5kLrHmC/jRmkNtxraFCkvkLrdWlAJqooddMcGHsgkroSxd9HSTiE3DA=
Received: from MW4PR03CA0122.namprd03.prod.outlook.com (2603:10b6:303:8c::7)
 by PH7PR12MB9254.namprd12.prod.outlook.com (2603:10b6:510:308::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Thu, 23 Nov
 2023 08:28:40 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::3f) by MW4PR03CA0122.outlook.office365.com
 (2603:10b6:303:8c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Thu, 23 Nov 2023 08:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.3 via Frontend Transport; Thu, 23 Nov 2023 08:28:39 +0000
Received: from BLR-5CG11610CF.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 23 Nov
 2023 02:28:36 -0600
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Wyes Karny <wyes.karny@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Fix the return value of amd_pstate_fast_switch()
Date:   Thu, 23 Nov 2023 13:57:57 +0530
Message-ID: <20231123082757.3527-1-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH7PR12MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 5266be46-8a7f-4570-bd1f-08dbebfe320e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T06tPSAcMb1WSmmJxkRzaYRdzGwG8tKS5aZRAT+t9cGi2cTczzovdIbXDVuZucv/SqgipGwxfHDE+REpTdMWadw2r0EFSiLDBWLjY6egMkg9VqgEoLCFXmzAB9mfyuDHnhFLP3uXVMpiCoXOvaLycn5qcFo19OkfLSwJClfR0wHNVLtVi94W3dzY8I1xvAe0UZVmGg0jelKkAK0ePvHM7M00APIaM1o01NNeCAlSrIDpOzBxFZ55mxCgPTsddO/uyh+mGSRKsWN6gZkQjBctAdehoi1JdrVUU5QndOQsWT3s4tNcHXKuGq1/R/8EeRCuMuciHK99Qm5dH1tU18/lYDVOzsK1D7rNR8ckj27gtw9VJjq0oeElubbgLreTFrCHhd5aFEOJFRLpWyWV1VJi59LS7HHVVHVuI7F0UUmH7jcCuF3N5EHB4KYHPgYKikZpbsxtBqZ7SBafAykN59942zF3R1C1CM/uiIcPvOvZ2PawyJjQQYsTfcPBA1Vi6Jr62nlD5v05aU0+8iaqqveSUAEKbybL/cF4E+lgzC8f/on3jX4MlTUvDrsDwSB1Ef0goutlEPYG/vJBi8MHauXXNk7vekm1mK11YoPKgfM9yqHOXQ+8fa0bKfue6y7SThVzJPzVpC529tabq6ntPBrKHhlJUrxmhaiDD0qpey7083/ZgY5ZlePrAS2YxfzD2UtFN0FukNM/3UnrHvPFhTP+iUjWKwBLAwSGDN1BlY3ht9o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(86362001)(5660300002)(2906002)(316002)(70206006)(70586007)(110136005)(40460700003)(4326008)(8936002)(36756003)(8676002)(54906003)(41300700001)(40480700001)(47076005)(478600001)(356005)(81166007)(36860700001)(26005)(426003)(16526019)(336012)(82740400003)(2616005)(83380400001)(7696005)(1076003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 08:28:39.5698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5266be46-8a7f-4570-bd1f-08dbebfe320e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9254
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq_driver->fast_switch() callback expects a frequency as a return
value. amd_pstate_fast_switch() was returning the return value of
amd_pstate_update_freq(), which only indicates a success or failure.

Fix this by making amd_pstate_fast_switch() return the target_freq
when the call to amd_pstate_update_freq() is successful, and return
the current frequency from policy->cur when the call to
amd_pstate_update_freq() is unsuccessful.

Fixes: 4badf2eb1e98 ("cpufreq: amd-pstate: Add ->fast_switch() callback")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a1e194d5cf8..300f81d36291 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -518,7 +518,9 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
 				  unsigned int target_freq)
 {
-	return amd_pstate_update_freq(policy, target_freq, true);
+	if (!amd_pstate_update_freq(policy, target_freq, true))
+		return target_freq;
+	return policy->cur;
 }
 
 static void amd_pstate_adjust_perf(unsigned int cpu,
-- 
2.25.1

