Return-Path: <linux-kernel+bounces-104027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764B587C808
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23B0B230F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAC71401B;
	Fri, 15 Mar 2024 03:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V9AcM/3M"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD826DDB3;
	Fri, 15 Mar 2024 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710473979; cv=fail; b=nF9tNG+UzT1ZWUbjs15VaGnEvjYha1YeUICvmz29i7jiDurGWzHhz1ttPq4e25MG+O+l1EVf4nLZNJAiZIkzYXoe+EDpkiu0n5YvSM1rKPQwn3z3gc8mLRaAFrNBl4dWGqsoUT/PK7jIfUGODm+fNj5rbjaacfUptjT1SDENtaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710473979; c=relaxed/simple;
	bh=2YcgaJVGsyo9caWc4TrsJB8zis71XzrpPTnRn55RcPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsqs+Mh3VJN0Iuq5qEH1LZJBl27oEMweTABka3p7pbAnXkCofomHpTMsjyBraHZT2QyEwYQ2nU9xAVG70k6SGHG5jM/BBY5acCBIZOvdhw0afB/g1im+dKGcxT/Xe1LuygWkqtqKg6ZbA4uR70P5to5UIiEDpKwIvoxmNRNvBrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V9AcM/3M; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi2Sd3Xq+zokr+XSNoaXLNBPV/HzCUUvwgHx0dR6f6FVj9/CHxzzBFP//8BnY3ZKLi8JW3dRlSJ2qyxuMR2KK/BKs6srGOqhlZ62X1JipMB/NaBJa1DRwGL2NCz4kGml9p3ggvvKi+qH3/f9i9P4vQE6ra+lNz8hYrcR+HdrNn2JsSRIFP2IjgA1uaX0zD0woLSHZBoNKObNzAy18luSWWIAmfN3/vttt/vezvOa+3Gcj8WeJUMbri/3e5Qre+YsjFFBMcpCoVPGrwmCEuJ9ZSqbHSH/4IEdWN+bWVoau/n5Z+h2cSfbOtzhVVQjsegI8fDO92mX0qTGX7nLvoWq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxCSwl1+rNMyLVw5RpEHbxSBQ6gujOJvaLZW3oLvGwE=;
 b=BJDKRSbIYZXK7e1DsBzwRnZZA7uPC2ZvkZ1jhNy8k8Pt/TbOxXrpk9r9kdiP9IWfKCrgXSxvciVjTIPVChKFC4OyTTGUw+U4ZxUNG5V4TVsK/sP64M/BgI3eOhYF9hg4YY4YuOshMc0cahHvPnYmR9cnYxHd7OylYCaOgbPaChinIJEgid+pmuMKPpS/H+DfLMtDWPU/XOBNikvvdH/TzQR22EO7J+zekseOSrwJLpuiTkDlycHILE3AecWs610vok/H1WeLjaelVZ8CxaKTMXG6FoySCWQPEIhI9Ua9AqRJQk5CLRy2R72zE0C7JF6U+4wMmFR5bcVO3z3JWO2IXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxCSwl1+rNMyLVw5RpEHbxSBQ6gujOJvaLZW3oLvGwE=;
 b=V9AcM/3M5eA9jg92WG6GJx14wk5TSa89wrxvJUZzHpKXOGGplriigINdTl4+mNoayNj5N7JMBCIApgFilGQce2m5YVr3mf/PPBBCPBnyltGIUpB3v0UpmzQz4ffrifQKj3rq74Bo8p003rH6dk5ZR018NPLL0HG/hQO5LG8DXcg=
Received: from CH0PR13CA0005.namprd13.prod.outlook.com (2603:10b6:610:b1::10)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Fri, 15 Mar
 2024 03:39:34 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::2f) by CH0PR13CA0005.outlook.office365.com
 (2603:10b6:610:b1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35 via Frontend
 Transport; Fri, 15 Mar 2024 03:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 03:39:34 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 22:39:30 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/8] cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb boost off
Date: Fri, 15 Mar 2024 11:38:06 +0800
Message-ID: <0a2c227ccd39c8d350289edeb46970eb394b6dd7.1710473712.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710473712.git.perry.yuan@amd.com>
References: <cover.1710473712.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: cf60fefb-9ff1-4420-66c8-08dc44a1880f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kKCkf1lA0fGGVlsvQrhPSoMB2cJC09VamzK+Du+/sDqvQ+wKfxT2IOBGOfhuivVMyT3azRfuWxAl8F82A9tOh1RqL9rlQr4zGrcPnSTdt2lIQmeUnb5nodEycCEQ9eCJ5RN8rJvwaORmYI1JKj8rzcInc2PExAnaTcggKtmwgRIt8nywNq4tkaA7o7pu7BUvKBA06jcu2SU8s3RmiFCu639n1XHTvrHzIZbT3QJIFjpuoSCQcO6vc/zs4Hd1178Va9/N81YSL9kHMDte+K8PmPYXcCTCqTU59ZbKxBSJZ0+K6/ny3Z/5Sj94jz4wCsu5soqjgosshjr6F7EULmJ95QxyIVO0jbAZlW8BpWNwWnTOWq26I9vTd2ZChSkvmKoJazk2dxpAl6jDVpFNzFALbbjXYhM4xgB+W2CxtX05AtR61kUTKrFJCW62DptvolhNX/8fMEJ1dhgB8VPYyS3tG+KFisjdIVKn+3OSD5iaMLSY+GdRiMbN2zerucFufYtj2w1NmXTPS1TX6zQeE58Yg2enuUHlVd7oY5kKLhmvtxI6hxwpGIZuEQYYYXKjTIjfBrSrrYvp2ohe4HCXM2uGGALDPPXCASWgzs1Ak/Qu73hCp+MCfcXQJRApm/Ci47HjpmMm8dNMmWKFkVA4dWSI8RFVzhy6T/zb37ZdDmbIYdbeVikoTnIyrewc8PciXesAEajVElR7X9SXaJ7+rfIfmZiZi9Gyyh1uWzbiW3pED9DGIv7WDutm8t0bH7YU0y0G
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:39:34.2276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf60fefb-9ff1-4420-66c8-08dc44a1880f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424

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
index a4bcac673fdb..1fcb35d5c3fa 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -488,6 +488,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
@@ -507,6 +508,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(des_perf);
 
+	/* limit the max perf when core performance boost feature is disabled */
+	if (!amd_pstate_global_params.cpb_boost)
+		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
-- 
2.34.1


