Return-Path: <linux-kernel+bounces-56195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7799A84C737
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A560D1C2541D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FBF25577;
	Wed,  7 Feb 2024 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kxNodZjW"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BAE25601;
	Wed,  7 Feb 2024 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297769; cv=fail; b=WUaqQ0r95kUv5P26Sl/McQI3a0ykbrn/zW0FFICmcU/STkU6cVyuIOmMeQDR5uGSUOEH23E3JUpM+B9ltF8gvIbJsYluCOT7YLaWnN7FQajzmxfYEg6gP52WzF/tE1ACb5Z7YJqlDZGWygiGQXroC/gNqCJ+SBXSah2i2M9Rang=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297769; c=relaxed/simple;
	bh=rC36B1GI+wsV7gh8AH5WsdiWBLnl6mTXOxOQUxh9oo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trYOVFZD71yIypP7Rqb/A+RyIZePcMeBLhXxHj2r1W56xGm/gLNBYmYB1xPWa43D3fX+m8pCPY4fZeq/PzieBwjxm4zbneAMW9kiho+kqqPqYr2hXXgV5+HPHobTfbSJRxudK/u/2pxsskEpFQ+ysS1YLg+NBsjxCWTN60uASMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kxNodZjW; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwkaV+Ok0qsb1wyK8D3w85f0Otw8dcf6lVinsRssYYNI/wk0oqnHKFsBf07CzeUJc/jJCV/F5pnSD286kclVAlXBgk8h8gSb64O/DYI+JpTQZ99/h3RQNxRYMolk48NvhEsHBhFkfEEpzjHVaDlyZHYS9/MM4WwgYGt7oyzRI+C9P/QMT7itjlLW2Sg4OJeN/lTapQYVWeSXB2FNb/vMzpgcWkwzdwqwqpWYtcyzoSsQ/BfAWBxjwy89drl1ZX8YMZdTOdkg8vlFhgEUeImpQShBMi2aBspPHOd42wY18ynN/GB6RTM+x9LFMh/4dUtbWhjbiNUqVP4+rca5ZtdyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95iDfgdKS1hk422ydF1b0/YxoQufzq+zcBotORbPvEo=;
 b=VWhKAOlAheb36uwYvedgN/nicz70r/6mawc25ZK2KBnWlpNWklFUKsFzyn0WMtCrGOejex70Cc0hi+BHfciDJ34j+3QT22TlyYvb1KpffQ2A0f81+6lURrlAATY1MT2tcf9MBFbz+si0NeElhRKDFWDlBWQOvM5eIS3rMuiPD94OH5z8hSk5Ry9OFqxLx7vm8ikHpVtMcQCSy9jtOcqcbi/xc6lKnd0vlf/Fax5cAEaVUrO5lEA/cGeaxp//xf/nrlPg06RZmp1llHsSIQVGHMBUFvPehE1nSIYva1r++Qxroby7qajpw/5TvFOpGns4aXfsNKFiet4nzCmRFL+Ggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95iDfgdKS1hk422ydF1b0/YxoQufzq+zcBotORbPvEo=;
 b=kxNodZjWKouJVjbqReS0KSlrw5v7QhFvcqCCNs9aOT//+5UO059i4j/iH7V6xp4r/xSKPlglJgpZ8iRTUUh6l078N2684RTgssMEDJzam9DtSPecwup/CDC7N2XT9kNgomIpBgLXxZKSLg0kBbaYsywz6wPqiGc1xwWGCC+sy6o=
Received: from BN9PR03CA0061.namprd03.prod.outlook.com (2603:10b6:408:fc::6)
 by DM6PR12MB4863.namprd12.prod.outlook.com (2603:10b6:5:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 09:22:44 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:fc:cafe::62) by BN9PR03CA0061.outlook.office365.com
 (2603:10b6:408:fc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 09:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 09:22:44 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 03:22:41 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/7] cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb boost off
Date: Wed, 7 Feb 2024 17:21:55 +0800
Message-ID: <b00b652295d60ad9cca8162715c4dea9b266c086.1707297581.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707297581.git.perry.yuan@amd.com>
References: <cover.1707297581.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DM6PR12MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a7a4d2-e88a-402b-e255-08dc27be577a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o8U1uFdCCEOw+zGdPcMUXZ4o3p6cOJ5fheRq5+0RGOq0CKaawhwAVUgR93Oy6emJ6WmlNA/RYGbafTO5U48Xji8moS6LmPcZBp0U4XOccMDc6oPam10r+oj+Q0xzKK7vxh6ceNbNPLCexRa1gK1+EjXsekAaUYSyQevzIQNbFRfkzWkvcnTMTg3lwjcTYikGuES81acOHEt0leXdmwk+4A2FIftdFBw5dKENumpMkfSYftHvVbLDop3lGuxfcKhEo3TAx83Aw5S2QsdYYXn+/jcplYnRA00r8xv79RMbYEZgvnVtbHo6wuk9qJdjY4hxTyqr2fMXeNZswuhuyssjxKskVXBUB8GPYCZJt5KESRjrQ0WXIGtvz+Pf+YlBybmYReFCdxwq3o6DDi8ARrQqGPODCKBvtgbJbFRxYUKiI8va9vbxZeY+AvIiCa8wDSMcLzVoYlXA1hHEAZd6hQK5rOjjSEww8mjoAmBCJaPWLkFsoMQRo7mHwmocDxohvGlblyDD3W0wQ7uU7bVqDPTcKOju2V8rY/m+CcqORtKXCZmE8JIGZHdpYFspN11n72QR1Gs/XU7V8mvY1a7YpsBxBX/3OZxVkVAowHmaJLvMjnBe25Vpv3Ct9M3A3owU0DKtG6BHyBAA8jQh3jXHmHVnr4l97joiU3XZentnXMVOrum+scWznVkcnGCn7CF1vUetuIgTpqnkFASQWKk7bAt0DTx9wrd9E06qn6kHMeKi+wfJVchREvytkB8YPWoQVJKu+xLQEExuRh+U3jaoZz7gcg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(70206006)(40480700001)(40460700003)(316002)(41300700001)(6666004)(6636002)(36860700001)(2616005)(16526019)(26005)(478600001)(54906003)(7696005)(47076005)(426003)(336012)(110136005)(83380400001)(70586007)(44832011)(81166007)(82740400003)(86362001)(8676002)(8936002)(356005)(2906002)(36756003)(5660300002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 09:22:44.4239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a7a4d2-e88a-402b-e255-08dc27be577a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4863

From: Perry Yuan <Perry.Yuan@amd.com>

Select the min perf to fix the highest perf value while update pstate
CPPC request MSR register, here we need to limit the max perf value when
CPU boost is disabled in case of that highest perf value in the MSR will be
reset to original highest perf value which cause the BOOST control
failed.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1f86ce920d6c..35791efc6e88 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -439,6 +439,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
@@ -458,6 +459,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(des_perf);
 
+	/* limit the max perf when core performance boost feature is disabled */
+	if (!global.cpb_boost)
+		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
-- 
2.34.1


