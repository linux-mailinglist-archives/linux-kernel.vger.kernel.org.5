Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF337F9E38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjK0LLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjK0LLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:11:48 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93B810EC;
        Mon, 27 Nov 2023 03:11:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz/moAwjLIqAGMPY+2wuHYWN86BqxhFZu8Ix5Axe2UjJpwtfeXCqzChCrMVOpwTKbps9RZ0OWJsc40QF2gqjA+yNcyLxF6CwO7shOgjunG2YMH/7TL28wFTn9KXOXbFvYKoMNR9ViooiQZGIqvVGyPGJiJU9nGugCVsTkUKnmwVpK7YA69e6BxowobVy3XgbHAMtua8erimZZS8667o1YJbmW1g+NhV5nefdWfq69ArEu4ZjxOOUf0txepNO4T8AbIi75Os40hMa6Aa/Nvqtl2u2yhn+uv4jZA8HZ53Rz0YYtnsr42fuHJAPuWhwgC7JXbjFTd8DBOydF6zVtr5xJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+xsk5LsYEu45Dc01fxtOf/fnYXI0t3QZGcQYRi+L9s=;
 b=CMZIz9AWI1CqHgSION/G/Mk65rjd6dpFwQ62Jyx0fL5zLsreLd9879uxuahhvd3H+mtkFLgE64ty3kTKzpMNhOzlp2068eqvJSC/3RhlmwiCrAUa+NlloLZSgzBbQZj/+LvKNFXD1fos7t//jRz54ioikRO5pAibgdV7oBDRruVT4KxfwY72XkbYuZHA4eOdwo94t4P+iGPhDF5HGqEjY9blSKzqJpVNNTBQS9Z41IysO56N6xBFR+ruGPrDrbjUfOPipOX3F3e88npOG5otReqgpKFrT956rok03BL/F52+e5XvuAYgObaiaSo6tk59K5Xz8hhrtUlmpzYjkx3U2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+xsk5LsYEu45Dc01fxtOf/fnYXI0t3QZGcQYRi+L9s=;
 b=OSHZvQXGL+m6qN9C5a63VSUr0rTNgLmZozBm7MlsF9rmEGpkWxdhNukJQt4cozL1t4z//DjuD4ZmGEA1/cxeFIvn8SYFZSi4h5VraZ2jgwbz7U8WAKgqwUZsGcL0hUDkInTATWJ0MVjVTQJo4wOW+9ILem+9btxStv+kPwzXFjc=
Received: from MW4PR03CA0272.namprd03.prod.outlook.com (2603:10b6:303:b5::7)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Mon, 27 Nov
 2023 11:11:42 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::50) by MW4PR03CA0272.outlook.office365.com
 (2603:10b6:303:b5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Mon, 27 Nov 2023 11:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 11:11:41 +0000
Received: from BLR-5CG11610CF.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 05:11:38 -0600
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Wyes Karny <wyes.karny@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Perry Yuan <perry.yuan@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] cpufreq/amd-pstate: Fix the return value of amd_pstate_fast_switch()
Date:   Mon, 27 Nov 2023 16:41:21 +0530
Message-ID: <20231127111121.400-1-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 26de8913-8021-40ce-ad03-08dbef39a253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3TW06TE8/NNuY+xM3w8MQPmA4M8O3CRVrDf76ROhS9wpSuzOSTjoFExFc5Rk7fLf6eLSGrXndRUsELwVCIYUdmul+IB5UD9JrC38ay4kP4i34LvFql8bst/kxwimX32Sdr7+TIpRndfEOf0VvWJYVltao9kdtc/A/6CvBg7CJJJhmEAgPLfy35mkP0dew86LNuW7r48OGxrl0EKl0kzdv4pRaC8kNggB0MJJ5ETCRK6zSOxXN31iklZ164cePz8oNcSzqHIspSvteVzB4Z/xWnJtgFsVDW0h63deMzLmcJdNLJ+dtnE9GHkBWj4WPf65ATksGkHgODs47cLs6YSBcg55nCA7pwQo6Y0+A8pDRI/230Pf4hi+g9B9adhDE0xLGAZCm3oN7T4sbyO1I3H2H5ZwABHhkaOWrDPPfx4y+v2G3v1a1VGz9zrtmADjQ5vvX7qzTuiZ4H/TOYnKAErNKJgxzllai5PQvBJafMswuV9Ouis9pzLbe0HtD3rqdFrhtSAgu04waJJr2qT1O6PnOsR11R0e1jTXvxUbCRGnn/hRO5CPD3gxaWWYxkNYRypA5ovD5WePVgOrj6yeOdFFmjQ0N4YYn0aMnIkMBA9s+ZkVYB1+LmFuY6LjiisFJIVK5YdBV242lOeBM/loOSMJ9kMDtHC4ngGHbDUYPDX3LnpPba5bSd6KeBenYgJnM/jhcZJTQyA+DCsFU6P+/rgCJ4rvmJbXmr6HeAv0qEDGVW0K10Bnneqgwm4C3iCTOSMLqLu7WXUK4NW5EPozKHI80g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(36840700001)(46966006)(40470700004)(2906002)(26005)(36860700001)(5660300002)(40460700003)(16526019)(36756003)(478600001)(86362001)(41300700001)(2616005)(82740400003)(81166007)(1076003)(356005)(8936002)(8676002)(6666004)(54906003)(4326008)(40480700001)(7696005)(83380400001)(336012)(110136005)(316002)(426003)(70586007)(70206006)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 11:11:41.7061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26de8913-8021-40ce-ad03-08dbef39a253
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Cc: stable@vger.kernel.org # v6.4+
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

