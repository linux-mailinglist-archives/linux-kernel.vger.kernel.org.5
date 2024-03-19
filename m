Return-Path: <linux-kernel+bounces-107240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3587F9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1581C21BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C506548F9;
	Tue, 19 Mar 2024 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YQpOWhd7"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB97D084;
	Tue, 19 Mar 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836959; cv=fail; b=CGgEkG7yNotU+aM62BA8QClqPxYkMCmWMyq+im3w3o7zJ+Z/a24bojXEk44KQiyNyHxoGY9cmWbqcVrkOo+aXquRgkBgzT8rvUGj6pZtS9XQS65r8cwZt+peVYOWxbi73uMhhDvCFu44ZcWfVCAvpy1J45/18O8H/3G1NKB75l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836959; c=relaxed/simple;
	bh=LcRr8DeueLzGoEQunzbWIpPZ8jvhiLnpV//9mgZvbOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqdQZi/sZ4izWADJCjwSTlmR/s4uhGQV+mdtbFqdRsQxBi8OLsRWMh/8ES1IkmbspYYLt70QABh2S0FfmD0cmmNJKVecGkFRNLXZpa9Mf9SdaQQVtY7qw+vN/BU0djO+LFtQl6qgB/b8CA8zX4v/yFN2ruEFPCHXdAjJE3HDNzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YQpOWhd7; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5Kpee/US4llG+EDTaX5kO2rBEVn5ysy4QRi0SuXJ+VE0sHxpGpbNqgJS10R49Y2v56ddgf2B8J+J8NlG6gUAdWJbI2LSzb2BMWPYzXAHEPEfaBdw6C3FAqSon7hX0GyC7oyyKHTh5rHCi+ziDChHBf9GkIu0u0dJJSM0Wpwp+Ip+6jCAt7Ukr3sSvrJLZk5HB3WKTSh63JOqzf4LPqDkgJeaDRa+tnkFhrAxy+t0zjsTTOvO/NWMSDy4UoYc89kfqMze8jBSKatdmpaj/f0cFaisPXACqwv11N7nLqRavU72rlc+eIEwv4UxaB+i74gDaxgbieguWI3OvaEsRmE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffIckLzJ0pqOgsKzweNwlnnwjEVsVvO28Yjd1DQCXM8=;
 b=GzOFMbi3VkFYUn2pBW9q57k+Du+xHOECq9PylJEHpyh11/rAlFx1RowYknWtyAPWjIAYnRnyQI8dxXb4XSgbf09ePoaFUBcpp9sogK7Tju7gotoXfdhPwQ0H+KQpqii97rzBBuu/kuwwpaX+NqDhZ53thWuXSwF9UgJ004sgKZk1FotMwBMUxvAce7NI3mgNsuUDJgOMvoKBKpzT2LVtztiIYbv3yxB/lGHFpJ2nYlvAOh39iSEobgeU36fk/3yYev00pVw+gBlyTRSAdG6OyUUN1+5+Q5iHdlpUDJWpUQseF7Hh8+rKtJ8EuoYnQQi5Mg4nnuvmkKGbUChBMW4CHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffIckLzJ0pqOgsKzweNwlnnwjEVsVvO28Yjd1DQCXM8=;
 b=YQpOWhd7KD6ouMl9LwSTc/lEeLLfnLRh2c45hFnnpqB+HYFQbVmxxXOmbCkeQk5jJXchkqEUqnu2ObCOVJ+J4Hl9HGvqh7KUiBotCMIQZAjbO+Jv6WRmOYgygeUDBvKYmjgqGaJKlZZEydGZMLVnxXiocciOrKuJ9vcgEbeUe4k=
Received: from SJ0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:33b::35)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 08:29:14 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::f4) by SJ0PR05CA0030.outlook.office365.com
 (2603:10b6:a03:33b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Tue, 19 Mar 2024 08:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:29:14 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 03:29:10 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 3/8] cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq
Date: Tue, 19 Mar 2024 16:28:38 +0800
Message-ID: <a30932a44090a025c73ea0fc81fe0d998e9b6dae.1710836407.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710836407.git.perry.yuan@amd.com>
References: <cover.1710836407.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4ccc34-d337-4fde-9627-08dc47eea8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wysBNG1Jn5n4cLSEuYzEn0LSJ94TX9sFswfv+3nVXH2TFCF4cJ5Ira8TmrEETTtbq/Agm9+JMnGon4MxLIdYmrLSG4WBtPbBvn7LyaRkRsUl01w8Ym7GdhIpa/o6TuQvt8fHn4yd5o5DgVSY7a+/oBINSxMAVyV3gElU+4leap1eQuS4Gm+vxYgWz59IV35r54daDT9aq3OV1pB6h+HnwtvuNXPWe+MmHrGXrvv4PVp2+Vz2j5PRzlsllDrAeue8xCsuU191MZiOOevCX8nt1Tdd/TJEm9y/OVGX9Pf3DRkUBTg/tTVG8+xf1x8wOpJWo1lJaPoerMQVeUleVVGpF5qb+XnTn/BHctx/3P7Onc9Ni9n/ZYFlzkkiF8iQR04W0jxw3tXS8WQeXXMQoXYo7W7pvXwj5LHESwTqP8lX82BFS/7SXqlVVsL+IGoEVsQ07bzzPK/7b52CetK3tYtNVySSzEibPcGuENvtemjtaPTlBOV3QiR8J2ReiiYS/QXl9PuOYBlk5YVZtNDNvF7w0sE8RXMN0+9kG6dJn2F599B8CZERWfLhXkTgUDsSaMjX81uoCT9GH4lkwAPpg+XongmZ2rWgrPOIAurgjUuqUcgtlL9p44SShvF1JXCp7JYgy0oCn54DBsDz4w1yzY73Ve08KAz/j9iVgFg3hLdLBuoVDcTyswqtMTpXk7ixwSQUYG+N04yuBYsxzBkmwUGvOppjR2UCOEvqPbjdSq0srP+KYK77hBfSdAGBvdU5BIv3
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:29:14.1235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4ccc34-d337-4fde-9627-08dc47eea8f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153

Currently the amd_get_{min, max, nominal, lowest_nonlinear}_freq()
helpers computes the values of min_freq, max_freq, nominal_freq and
lowest_nominal_freq respectively afresh from
cppc_get_perf_caps(). This is not necessary as there are fields in
cpudata to cache these values.

To simplify this, add a single helper function named
amd_pstate_init_freq() which computes all these frequencies at once, and
caches it in cpudata.

Use the cached values everywhere else in the code.

Co-developed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 126 ++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 67 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2015c9fcc3c9..ba1baa6733e6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -606,74 +606,22 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_caps cppc_perf;
-
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
-	if (ret)
-		return ret;
-
-	/* Switch to khz */
-	return cppc_perf.lowest_freq * 1000;
+	return READ_ONCE(cpudata->min_freq);
 }
 
 static int amd_get_max_freq(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_caps cppc_perf;
-	u32 max_perf, max_freq, nominal_freq, nominal_perf;
-	u64 boost_ratio;
-
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
-	if (ret)
-		return ret;
-
-	nominal_freq = cppc_perf.nominal_freq;
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
-	max_perf = READ_ONCE(cpudata->highest_perf);
-
-	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
-			      nominal_perf);
-
-	max_freq = nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
-
-	/* Switch to khz */
-	return max_freq * 1000;
+	return READ_ONCE(cpudata->max_freq);
 }
 
 static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_caps cppc_perf;
-
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
-	if (ret)
-		return ret;
-
-	/* Switch to khz */
-	return cppc_perf.nominal_freq * 1000;
+	return READ_ONCE(cpudata->nominal_freq);
 }
 
 static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_caps cppc_perf;
-	u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
-	    nominal_freq, nominal_perf;
-	u64 lowest_nonlinear_ratio;
-
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
-	if (ret)
-		return ret;
-
-	nominal_freq = cppc_perf.nominal_freq;
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
-
-	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
-
-	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
-					 nominal_perf);
-
-	lowest_nonlinear_freq = nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT;
-
-	/* Switch to khz */
-	return lowest_nonlinear_freq * 1000;
+	return READ_ONCE(cpudata->lowest_nonlinear_freq);
 }
 
 static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
@@ -828,6 +776,53 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	mutex_unlock(&amd_pstate_driver_lock);
 }
 
+/**
+ * amd_pstate_init_freq: Initialize the max_freq, min_freq,
+ *                       nominal_freq and lowest_nonlinear_freq for
+ *                       the @cpudata object.
+ *
+ *  Requires: highest_perf, lowest_perf, nominal_perf and
+ *            lowest_nonlinear_perf members of @cpudata to be
+ *            initialized.
+ *
+ *  Returns 0 on success, non-zero value on failure.
+ */
+static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
+{
+	int ret;
+	u32 min_freq;
+	u32 highest_perf, max_freq;
+	u32 nominal_perf, nominal_freq;
+	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
+	u32 boost_ratio, lowest_nonlinear_ratio;
+	struct cppc_perf_caps cppc_perf;
+
+
+	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	min_freq = cppc_perf.lowest_freq * 1000;
+	nominal_freq = cppc_perf.nominal_freq * 1000;
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+
+	highest_perf = READ_ONCE(cpudata->highest_perf);
+	boost_ratio = div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
+	max_freq = nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
+
+	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
+					 nominal_perf);
+	lowest_nonlinear_freq = nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT;
+
+	WRITE_ONCE(cpudata->min_freq, min_freq);
+	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
+	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
+	WRITE_ONCE(cpudata->max_freq, max_freq);
+
+	return 0;
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -855,6 +850,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	ret = amd_pstate_init_freq(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	min_freq = amd_get_min_freq(cpudata);
 	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
@@ -896,13 +895,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata2;
 	}
 
-	/* Initial processor data capability frequencies */
-	cpudata->max_freq = max_freq;
-	cpudata->min_freq = min_freq;
 	cpudata->max_limit_freq = max_freq;
 	cpudata->min_limit_freq = min_freq;
-	cpudata->nominal_freq = nominal_freq;
-	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
 	policy->driver_data = cpudata;
 
@@ -1317,6 +1311,10 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	ret = amd_pstate_init_freq(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	min_freq = amd_get_min_freq(cpudata);
 	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
@@ -1333,12 +1331,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	/* Initial processor data capability frequencies */
-	cpudata->max_freq = max_freq;
-	cpudata->min_freq = min_freq;
-	cpudata->nominal_freq = nominal_freq;
-	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
-
 	policy->driver_data = cpudata;
 
 	cpudata->epp_cached = amd_pstate_get_epp(cpudata, 0);
-- 
2.34.1


