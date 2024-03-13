Return-Path: <linux-kernel+bounces-101314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27D887A573
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8667B21372
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB25039ACE;
	Wed, 13 Mar 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zlghowS+"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B23D571;
	Wed, 13 Mar 2024 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324068; cv=fail; b=oQDA+0eABukBDyFVaI9CeWkt5ggQ4HDtk7eV0cCBdr0QFlc1wYhXohG/wIJIUG1yKeZYQSLUqtXNPzuJDIMXI0NHjNwNFOY2ZmdhLJFM0ygtvd2+25meUpkNElZme7VBTfqNnP7DXmArmkQL8OaLwgpJ+uzMnSIfpZT/3h+PDm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324068; c=relaxed/simple;
	bh=bQhlkKcYhkceLwUzWDfLmD6GX6DT4B6UCe1dUkh3TQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWIBcZLCOKQAlDIJhL9xO7Gs6aydAArgqJuFttxlI0OTV1ZUTm3UoY4qztVBjhWC4/67yTw0h1TqPli6jEEtha+naBdLLW/6cgETE6uZE6M0wimXt5eFG3QezLpLoqAxPZXN2Iy/liEsgnFA265Ux4AUe6t21ojI3MhMW80Ajq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zlghowS+; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2H0FXuiEaZSctbR5XkW8IsCXBVN3X+gSY/7ANDqYRknxhnky6DupvUJsIdo7LDcnQ17zYkL+0ivwkQeGqHnxsnzLi5Ljm8inJSMsWtC/Mes2lN1bX9IFqq+qji7mIzZ93vrlTMqx4e6eq/CbCtZvOsE77STVoJ2L1T3CbYc2BNaJaMqPJ2u/S01bO415/PIhQsbFUgHf0SKjxV0lSzT8c/2QJXUaw9AqwEvSCzEucVXEwZThunXOXdGbhzu6y1kw6JD0cNi1XBzEzqWceIFtOg+wDAx/qehhYahABncBlAcwEtbFBm+hPiEuMbjk30opsVeZ6/HnOKlOcI89qN+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrfKU3COTqI7EOlleWGjCbqooBmav3KdLe2pBzvHwTs=;
 b=McLPLnN/ALUOiRvkzU0l2n3uDrI/ot0JiWDCGdBbDkhRJO6VSejH0rbPx0aXkBWyACRQCUKm4ugYAEDEQoXiq7/TpYWSHUj9Oynr745zejjxOyZJgFC18N3Hb6yPwc68vnLM9AKMUiji8ZRdaf3yhEhDY1UsjhuEaPhG9fDAKXQZsfINRh8rLh5WXmb6nzqdcIChThDgI/SaiSarnbZU0TO8p6FOr/M2jZic6+TmnHnBoIUGt2rU+3QchstrwvebX494NbDBJJbZ0yue5NC3pvfFTvr1I1sKTiE2HaMqWiNyzvuJJu4EiwiXgl3+XzrdNptQmmo7CvsOrtoc+ZVzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrfKU3COTqI7EOlleWGjCbqooBmav3KdLe2pBzvHwTs=;
 b=zlghowS+JrOf7JAa6dhf2YK3V2uzLVJu4RyR4KbhKkFJtwSGfQLqiI1Rzs5UphU8SQ2gMJox8L9a49j1eBCt8z2BXDZDkGOpsDoUMCRrdZBYii/JBtFaXbpGzAFgKh99jbNjXX6RBFJt/EzwwFZE0Vq2pB+FDQqsUqgb6ogksS4=
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 10:01:01 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::ff) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Wed, 13 Mar 2024 10:01:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:01:00 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:00:55 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 6/6] cpufreq:amd-pstate: initialize capabilities in amd_pstate_init_perf
Date: Wed, 13 Mar 2024 17:59:18 +0800
Message-ID: <e450342257c4c80d42245723b273a80a521c00fb.1710323410.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710323410.git.perry.yuan@amd.com>
References: <cover.1710323410.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: c2064b59-b79b-447c-ab1d-08dc43447cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k2lXNNxNuJv70yRHjZhxKyy3wuXTR+iuqPdVyQBr2TqGWx+lG9NZ6Ff8HUIYD9RlCCyqtsSkM3ammMJ4k+YT0WCEW0S8MVI6RiHKOOym35idI5/t6zNQf/a5WtgS9ssxEfMJvQPWBMu6IjCtWxBV6Z4RAogKO2z/6HaxnrOW8Ytbxb8dZOmEZfZGyWraxi0eQWNSTnqyArz6bD2lKkuyQWw3t8MdBDioZ4rhTRGSjVrkVBHz3j3CsImtxNAIip1At4+7z/yQQNv7vIThietSISxsWBx3bEPzGTMo2ZQasVRmObvclPm6jcSpUhbbzJB5iFuay+qUvL2+oNkLiRVuxbfvf3B0L/zcC+Y+PZmaeAVcOxXfXbLScd/HoJZwCN6z9E7gh6ihocwvNz5L+x1nP/tbOpWCbdsArUQ/biJdYMhcrFCPwbqIv+x7YzWzuYc+og3ZqHB41zGMG7bin4yWghNMDCiG0FYV9fvTD4auyV4vsLQdW5knEw33WBLRqgPpglIdeS7LWxczGvRgXbZPD6MBw+dMcLp9PDiay05QY7xOBmPf0PBR4fSWO3kvS9FN0QQmSAdi8xDnzjLlVHCRIJ/hb/3m673Jgt9yRp5E+BewzBaYMrER6TbgkDM84C4KBMBg+9SDEyLaJCScZIsmtdvYyy7ebeCN5z/7tw011zEX7l5txGGHLcUyHpvcB5FIl1+aTVgh83g2pAVfzCMrFcG+4DwYELqE6y5eWvoKiKzNNU6Az+GTDJExJy+DucDo
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:01:00.7978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2064b59-b79b-447c-ab1d-08dc43447cbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813

Moved the initialization of some perf and frequency values related
to cpudata to the amd_pstate_init_perf and cppc_init_perf functions.
It can avoid duplicate calls to cppc_get_perf_caps function.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 43 ++++++++++++++----------------------
 include/linux/amd-pstate.h   |  1 +
 2 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 59bcdf829c93..3877d4ecb5d4 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -330,12 +330,18 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	u64 cap1;
 	u32 highest_perf;
+	struct cppc_perf_caps cppc_perf;
+	int ret;
 
-	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
+	ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
 				     &cap1);
 	if (ret)
 		return ret;
 
+	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
 	/* For platforms that do not support the preferred core feature, the
 	 * highest_pef may be configured with 166 or 255, to avoid max frequency
 	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
@@ -353,6 +359,9 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
 	WRITE_ONCE(cpudata->prefcore_ranking, AMD_CPPC_HIGHEST_PERF(cap1));
 	WRITE_ONCE(cpudata->min_limit_perf, AMD_CPPC_LOWEST_PERF(cap1));
+	WRITE_ONCE(cpudata->lowest_freq, cppc_perf.lowest_freq);
+	WRITE_ONCE(cpudata->nominal_freq, cppc_perf.nominal_freq);
+
 	return 0;
 }
 
@@ -360,8 +369,9 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
 	u32 highest_perf;
+	int ret;
 
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
 
@@ -378,6 +388,8 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
 	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
 	WRITE_ONCE(cpudata->min_limit_perf, cppc_perf.lowest_perf);
+	WRITE_ONCE(cpudata->lowest_freq, cppc_perf.lowest_freq);
+	WRITE_ONCE(cpudata->nominal_freq, cppc_perf.nominal_freq);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
@@ -642,17 +654,12 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_caps cppc_perf;
 	u32 lowest_freq;
 
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
-	if (ret)
-		return ret;
-
 	if (quirks && quirks->lowest_freq)
 		lowest_freq = quirks->lowest_freq;
 	else
-		lowest_freq = cppc_perf.lowest_freq;
+		lowest_freq = READ_ONCE(cpudata->lowest_freq);
 
 	/* Switch to khz */
 	return lowest_freq * 1000;
@@ -660,14 +667,9 @@ static int amd_get_min_freq(struct amd_cpudata *cpudata)
 
 static int amd_get_max_freq(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_caps cppc_perf;
 	u32 max_perf, max_freq, nominal_freq, nominal_perf;
 	u64 boost_ratio;
 
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
-	if (ret)
-		return ret;
-
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	max_perf = READ_ONCE(cpudata->highest_perf);
@@ -683,36 +685,25 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
 
 static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_caps cppc_perf;
 	u32 nominal_freq;
 
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
-	if (ret)
-		return ret;
-
 	if (quirks && quirks->nominal_freq)
 		nominal_freq = quirks->nominal_freq;
 	else
-		nominal_freq = cppc_perf.nominal_freq;
+		nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
 	return nominal_freq;
 }
 
 static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_caps cppc_perf;
 	u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
 	    nominal_freq, nominal_perf;
 	u64 lowest_nonlinear_ratio;
 
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
-	if (ret)
-		return ret;
-
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
-
-	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
+	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
 
 	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
 					 nominal_perf);
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 7b2cbb892fd9..1fbbe75c3dcc 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -88,6 +88,7 @@ struct amd_cpudata {
 	u32	min_freq;
 	u32	nominal_freq;
 	u32	lowest_nonlinear_freq;
+	u32	lowest_freq;
 
 	struct amd_aperf_mperf cur;
 	struct amd_aperf_mperf prev;
-- 
2.34.1


