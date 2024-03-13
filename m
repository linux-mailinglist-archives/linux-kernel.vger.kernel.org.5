Return-Path: <linux-kernel+bounces-101310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA1187A569
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B97AB2137F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172038DDA;
	Wed, 13 Mar 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t3J11eM4"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DAE3A1B5;
	Wed, 13 Mar 2024 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324056; cv=fail; b=L9WsRl9v12cNGDdz+bAh1pVPc7lVwMuLIRdPPjffVA3wsU192oXbTZBjmT3g+O6ApCR0QLt0tZU3vJElZBA0Z7QlKn0jjhy/iX6oLj0KrYafhXJgad/s+xGx1p4s6KOiK1pFKv2wkTu9OHenugay9SStUZbJK42LP0RsPESct9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324056; c=relaxed/simple;
	bh=fFaC2eFGT3VvaloNNsoODFmvoI3Kzd31hKTJAA69Odw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oe8gcoIIN6/JluT+yshY0NgTFH8IKQkLuFfo9ejkfTQMMO6V7H2S5pM4VeURmcfVOcyXytrthYZkGVSp8GZIIwnDuFgjGHU/hqUiIByKfktrSKFNVk9xa32wpqdQdWDYUyVVGsjDhy+q95bJNJODzAdM13dlKCyBZr1bnR1CcT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t3J11eM4; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHXS88v3bMV5pub8HLQ/8HKiIm5O+tVhwXXesYGVj0aIWwE9vkA4GkOrJBs9S/amzubH8bBaC26UhUY4NSfEbuSjbQY74sjfQwU1QhaXhFzdZ4iYmf+1KGcyOBloDaiJQox5zQ9/78yD6psbOSfF7R6WfpmHHHHxJfgjgXHfAzSgmOilRoowfZlDZyH3cpS2Pan4Rr3hljwjYGgsM4VvbMs1hWSehVKGqCpCLYX8x9UViFxkcvDwL8fFNDPzf/5zlbxEb7N9kyS4ONMhRe/IOwL9TiNhuSrDYaYTUj2tFbJNgy4gTu8OUb4kARj8fq8IfSygIXsuyRcvkPX8QBk5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/FaF+4lx0lXVkGTv7YAAWX3CSKxQR1KBoBVBpr7wts=;
 b=MJcLpB594vbMKUL/7gHRpW8vDAGwXmBMpcUd7eQ+dqcQDjswLL+i05mRrsCol9kCvtCXVW+ReXxLifK0Dzzr4lyfzByu06Gun+NZkoRSMNh0h/8a9Yr3u8vanP4BFn3fnmaKeQav+WSYPYRyd2JRLuVIbqMDiPtH10OiRFtXpwHaRu2kdAl8P9v8t3AyRfs/kXqwA9YGsSL2ewwtnJXyVFTkAaXZ4MlfNhYSc6TUuS4ODXz1hiEHiWwFKziIhGA/pZNnq0kwFZ9KWhi/yv2aQ8te+K6+7DpFPVIYe02Z8mw5Br8YvIfgyKJ0tYVkRbqnnxWzAKzuNjPkq2T6I6FEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/FaF+4lx0lXVkGTv7YAAWX3CSKxQR1KBoBVBpr7wts=;
 b=t3J11eM4oFwxa82oFrZguAJngQBrQFTNR4SKyY/u5aaiglIOWhXwFFbCEbBi5FLQIo2lIDLVpldqZzOKt+DPdwNF+TiZWcJQ+8PbvZzxXbFgYp+SGG1agwv5EkO3Es5+7ZAyYAdp93vQrYYgLqnGWqmdANbt2GmSiJqOSXYpJnY=
Received: from SJ0PR05CA0071.namprd05.prod.outlook.com (2603:10b6:a03:332::16)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 10:00:49 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::fb) by SJ0PR05CA0071.outlook.office365.com
 (2603:10b6:a03:332::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Wed, 13 Mar 2024 10:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:00:48 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:00:42 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/6] cpufreq:amd-pstate: initialize nominal_freq of each cpudata
Date: Wed, 13 Mar 2024 17:59:14 +0800
Message-ID: <df0c880226fd09947ff83ec8c56a434a506ba3f1.1710323410.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0468f7-8752-4e09-ec55-08dc4344757e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EwsjtZ+MdT6W5U3U8SIPTS6ny5OpjzLJ4FFb8bRIJMhpAeN8l9Y7Nb4h7kUs3xaPXt9EsbneXr2dYHVW4Z5yl5xoSQTsWfsJieY1OafPUz4WRfyScF6PDDY1vK0OzhizjdyCmUem5+W8frt4Wd1RhpVqXLnLtq9T3E16Wki9r8fVw/7rgom6nf0KLpqkzY1XKYsUUjXdYK3tsgLCVUCmvK6ooK2TOrtL+/nzH4M2mNorlEreiyskSwnwMfRR0ZxCZWB16A1VflZ9QvH28+tBBx8B+8i1sT0RWHbRmoVKTxSkn6rRB6MmzvGP31KJKU5LxGNCG00Vuw632fVEsewst/uIYVQ9G99l99WOWG0mwRZVUfG10VzUfZfnr47OXjzCEQfBMQzFnEWmSLK0zAoXp9jfVFpSsecO6vhT1cNWpNh0S5nKjX61J077D1rhfHmTcyucpq6N0PdHRwVOlUnxUsCTpAPFoFcW0sAtndswAtMpQ1a/qtkgtMWmWpD0fZhAcXNgHqml9tM9Prs65ag8pWx1TBRhYtTPMCe6dpYEH67KaHpTSuSBcMPnsaqq8GPHjRPG2a3+UW2q9JeJ9bUroWk29tKf1r/iLpAMO9EXvAaHJ1H8BYuiQrkSn0r1nZxbdcunreOapZMNt7ixEz+o6kpDCzAWhA6cL4BTyLG6FihzgGDQCUxVDQzEvGBQLCdpCH2OhRlNihZf1c401t/JTnlpR6JVS8tPQszGGSZ8rNaTr9scJvUyQsOxfqTfJc/2
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:00:48.5513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0468f7-8752-4e09-ec55-08dc4344757e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299

Optimizes the process of retrieving the nominal frequency by utilizing
'cpudata->nominal_freq' instead of repeatedly accessing the cppc_acpi interface.

To enhance efficiency and reduce the CPU load, shifted to using
'cpudata->nominal_freq'. It allows for the nominal frequency to be accessed
directly from the cached data in 'cpudata' of each CPU.
It will also slightly reduce the frequency change latency while using pstate
driver passive mode.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3faa895b77b7..6db9256f42c0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -626,7 +626,7 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	nominal_freq = cppc_perf.nominal_freq;
+	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
@@ -661,7 +661,7 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	nominal_freq = cppc_perf.nominal_freq;
+	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
 	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
@@ -855,13 +855,14 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata1;
 
 	min_freq = amd_get_min_freq(cpudata);
-	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
+	cpudata->nominal_freq = nominal_freq;
+	max_freq = amd_get_max_freq(cpudata);
 	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
 
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-			min_freq, max_freq);
+	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq || nominal_freq == 0) {
+		dev_err(dev, "min_freq(%d) or max_freq(%d) or nominal_freq(%d) is incorrect\n",
+			min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
@@ -900,7 +901,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	cpudata->min_freq = min_freq;
 	cpudata->max_limit_freq = max_freq;
 	cpudata->min_limit_freq = min_freq;
-	cpudata->nominal_freq = nominal_freq;
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
 	policy->driver_data = cpudata;
@@ -1317,12 +1317,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata1;
 
 	min_freq = amd_get_min_freq(cpudata);
-	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
+	cpudata->nominal_freq = nominal_freq;
+	max_freq = amd_get_max_freq(cpudata);
 	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-				min_freq, max_freq);
+	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq || nominal_freq == 0) {
+		dev_err(dev, "min_freq(%d) or max_freq(%d) or nominal_freq(%d) is incorrect\n",
+				min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
@@ -1335,7 +1336,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	/* Initial processor data capability frequencies */
 	cpudata->max_freq = max_freq;
 	cpudata->min_freq = min_freq;
-	cpudata->nominal_freq = nominal_freq;
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
 	policy->driver_data = cpudata;
-- 
2.34.1


