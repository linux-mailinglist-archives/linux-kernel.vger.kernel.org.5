Return-Path: <linux-kernel+bounces-116435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB52889D42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A865C1F369FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611061788AA;
	Mon, 25 Mar 2024 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MkvlmkHT"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD1F390971;
	Mon, 25 Mar 2024 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335863; cv=fail; b=rUG+LlqDA8W2DwppMuyxfEqSvcEWdc+W/SeJCR6+lnzZ61ru3tGjHcWlZaFvPt3SedaRFlv/dKcSAVFpe/Yau8dKpV30pBKvNLujUbXm7unWvrPHzP6Vbawdw1C3C3/6DwVfr+wbyPXFo+ELwi+fK3oOYcP3j8lg7P10dRkmBR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335863; c=relaxed/simple;
	bh=uzzjkhT9pBH98t4WOmRLcjrnmFo/yJP0trhMkQ6ySY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFiqG/TbZvd7IdvgoO516wl5An212GJpezV+RQt1sDqkxYluT6k2vTC61LtFeIJiS3lkqM/kIStjCtSIoKihpWGCNZ93YPrwr1JSYnAy3xJ9t3F4Txwo7+swx0hi2QV/1b4I6OyE2tI7E45DYn4lVWVbmwWju17sQQLZMhlVamU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MkvlmkHT; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=futdfCtDyZOsGOxlkEJGog5mcwxwNN6j279lGAQ7IoeImf18CNkLTAdJr4kSawNiu1cmB8FAxHTvRMfvVjoVxS2NGQ/TCXXuJQ7WwKOCgkbaMB5RBLpROTrPGQq1/bDr5pBMXzbUKurdHkueAIL8Ls3LP633s2Vnm+WQiojVdirmiQsXHnISmzccvi5wRumNPozCXavk8t05HhhbDtCNCJ9BAfjmkTCYviS/+vXvZtpdhc2Bh7End6E6Y8qFt2R6G7AjsJ1Ln9wAEV5giSE2ADLzfqeuG/ABMgkkX/JxtHqlqCKHSq8tXg5uBY4y0cRAy44GnArl60Nofg1mktKtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzn0Kw16DE0mU2ipdaLQdpGelPAgYDhtB5W9Exa3Wqs=;
 b=cILOGtBc5EmmWVO5roqcpHOFoHz/F2SjtPQF0MM9bNwCeVCQ3GUJSedVM2Qzh1cJoIlYPPGJw8xSTPQDdzqDDMUbP26WhLSiphLLc4uxy3LLLHkFY/+tq/vvqK2tTzN4OXlkHuFx52S3mHhBYcQdHEakUotyRkoXO9htaIAf2VLGNbSMDmjHuDQcObAOJ/G4wK0pMYEFoMEbpfP01NEmOa2THb2abfW8Wt6XEzIEhCLnU4x4KgyDaCWxLOuKRlzNq/YRvvL26oaRJzG+TXlTfE6nyUJ5zuW6UGRnwk/vsfJsNxJWUzWSHQV6XoSdxG7XsoyHobSdCk1sbzObB1uddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzn0Kw16DE0mU2ipdaLQdpGelPAgYDhtB5W9Exa3Wqs=;
 b=MkvlmkHTgTXm9Ml7LZtrPyWjfDH9z2qihKzjMUf5V//Ed0+p9b5cZRbk13M4sLZxEeZtHO0WoVN3jQNlJg7DG7ahBuy+B1jzj5KTVaN7ZvMmKjj6ZyUaePDj+/EleOOg/HcrEUBq8dR+P9DGzTH6gUGbFRH0RmL3ImG+NEwopxo=
Received: from CYXPR02CA0091.namprd02.prod.outlook.com (2603:10b6:930:ce::6)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 03:04:15 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::98) by CYXPR02CA0091.outlook.office365.com
 (2603:10b6:930:ce::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 03:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 03:04:15 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 22:04:11 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 3/8] cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq
Date: Mon, 25 Mar 2024 11:03:23 +0800
Message-ID: <31e4c97f791837c97c0b2caca61bcdfeabc3f97f.1711335714.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711335714.git.perry.yuan@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ce1f02-53ef-4d7b-5535-08dc4c784126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ao1lQ6SJhMf1fsS4ZPUZyXkVSf7ezUj+f6FVBJecXwizi4DHDFtIAxDGhx03M4L9cQ5kZ9VsshxxwV2JjNkLzR39aq3BuwBVS1EYb1XmwqLTJSKDcqnw94ti0tULxvghXxvWuKYFyZgWNY88pEFrGUkjaCfIntmjYZByBHt/NsnXWiJtd3KCALEPi89KG0HRAREivfbI3ZldTtX+2CFTv31RYGPGA61uMePfkxcCmqGhOR2wZXsM2RajiVDPK0N9srcmqbOs6njsq7a7zrlhttSvEpMf2Zef2cTwEv3PBpG6Xo7uugMP6fKTGsnnsm2/ZZuHUfWP1XtQZBuv/3bKw8rB+4aHgNXT9Vx/RFWnMJwrUWNR5SINdwAWIDstrjDuat6u5S2nFJ8CzTKKQBn7YX5H+kQTvYs7aM3pv/cS0RHIk0SVU6qtZ4dXAqdDYEwR9gPIkytOX7Hqyvv2DicpXpue/b3bJEZGVW59d9tabFQEIiFmfmdnFIEJybytTdR/KT9vIX5FKmuwLwCb3Uk3bJ6mzlg7jwnqEi4XisONuEu2eAr3RFut3ErnDyBKyYST2ue9kbknALaKsXBhp89KNN/eRRXvKJVjGQfuBHgk25KouLxG/PekNvSJA+E7hMyTtjhGj9iwXwxflxakjK1ph1GuCMmnZ+VWvUF3KL97SamOQQfi9IWh+n9/Slsrco35TehEjIptm7HgzE3NzZIrxJPmq6BGrlxM/OYSGaPmDTG4075mMbHz1fr8coCmF02K
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 03:04:15.1491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ce1f02-53ef-4d7b-5535-08dc4c784126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180

Currently the amd_get_{min, max, nominal, lowest_nonlinear}_freq()
helpers computes the values of min_freq, max_freq, nominal_freq and
lowest_nominal_freq respectively afresh from
cppc_get_perf_caps(). This is not necessary as there are fields in
cpudata to cache these values.

To simplify this, add a single helper function named
amd_pstate_init_freq() which computes all these frequencies at once, and
caches it in cpudata.

Use the cached values everywhere else in the code.

Reviewed-by: Li Meng <li.meng@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
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


