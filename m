Return-Path: <linux-kernel+bounces-101319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6E987A57F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13A1282B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B237C38FA3;
	Wed, 13 Mar 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cUT19cf6"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E4739AF0;
	Wed, 13 Mar 2024 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324313; cv=fail; b=VuatG46PJ7ngdn9yqfCfk3Bfmu9x/iwKKfi2HDhNMSz4u5dWmxlawNHoPjdhZQn8ZT5BdI4M64ZMPiYiONQh3Sl6CSU9rjrBpmb3XMqKRC5vhEOB/tiW5rVlGBoR7pkKqJe1fKvjXPm8PFgdKKySnJwETGcc6ze1U7kY2O1ozxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324313; c=relaxed/simple;
	bh=/CTM8Xm0prsANYr1wqSFW23UKyplFam+FaUCoB4o7Y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6AG+0JAdMKyObHQbWSO9uhOE4ITJWk5ruxoHWLaHaNdPBABKiCO5QHAPoORZmloAyZW6PGMtSf8YWvc2PMX93yf59AiCze2jb1vzy+k5Q1hjukCaDhDKz4xdicnrO8L6LjEQsMcWw625CRc4dJtiWq8nIr1gn7QivbXxHc3UU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cUT19cf6; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vx0rXbyJhQs5SDbSIJUNXP1OCkYcctcph6EkaIcBPq3VGm5ZEbPS/WqrqIARLUmbv4VIbGNsJJA1J9N54C4Eau/8e8s4NH/1jh0iLWuANdV97+go/UEVv2C9SlR+iGe3ZHz1dzSq+PBoDFgmBOJwLrw0cxRP+fAWaxU0box5ugq5NiF0QjXibiYG7rAmH4h556e+m70ZHa5TsAoBJ2H3GiVrqvmHr2gpJ3A0YSsUeBTWBTozW4PsuIzRsRq5Jcsvro9ocsN5CUyNevEjHM+WPu0SASLehnu481AGTaHuvFvPo5gz78QBYwVdrNwqoaEYRiwQyCGm6B2Hk+LWY8rPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gieT9WDW1c2VLj27RibDNaHMMryrA8YB/Onu4d42jPg=;
 b=mW4UA9jrNxdOadkKkXK6K8X/DiyZzOTj2JskkZI1W95TGITxtZNsASi8irjCVaR7+num7ZNYrvvJuZDTRrh6PKOL+gt9ru0HwlwJImivdgwHK9liXxzfiZ8nBRBpoJIXqgFz2/mMX8k7fsbKWnlpudezfApKeW9kU3YPNg86rwRGgZlkcv1DAhfC09v+Y9jI4qhaZKUoxmHOwiVUJChvMEeRQfOxPO8AOI6mDfsdbpEwe/jT7gKOQ9Lm69rvZg3GThTAPusGA1Xh13G61VHTw8qczidDaqiKWZsBou/zUvNcKGtIB+1krKVuTur8lxDMgeEx5fgvTVrCcnGW98ldkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gieT9WDW1c2VLj27RibDNaHMMryrA8YB/Onu4d42jPg=;
 b=cUT19cf66pSI/iqx+dcgSBPcREtXWFhThnznn2iAR1cHF2rOmtSuH77xJMNnfRw1+5QD4FaRoVwKqjEuXycEce5znbejhDzDIBs/Ekg86THlv5exP5h+YOZZBxVCzzmcdQhDeTs0tVhofc1gdznhyYzRAjfdmFmALqLFvRIx4PI=
Received: from MW4PR03CA0212.namprd03.prod.outlook.com (2603:10b6:303:b9::7)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 10:05:05 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::fc) by MW4PR03CA0212.outlook.office365.com
 (2603:10b6:303:b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 13 Mar 2024 10:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:05:04 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:04:58 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/7] cpufreq: amd-pstate: initialize new core precision boost state
Date: Wed, 13 Mar 2024 18:04:38 +0800
Message-ID: <1bd9da56478c07fc2117b7c11f88eb517bd60f0f.1710322310.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710322310.git.perry.yuan@amd.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3cc435-2ea3-448d-7a25-08dc43450dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vOMNB0F3g/dOW6bMNPkhLW+r4vuQj33zqCYQqAo+2Y9f8JiRhCP8GiJn7U7Z27QHuFnSclFyZN4hHPLMh/TeEtndfVX1+8/yVPm1MLEXUUjprx37jLujF0SA5RGjYhOUE+u+MA+8GsCeE+qXoPW1kGeZr51ugaTuGjDzD7cTGFcy2RbVC1XfPr0YdiEMPSiaCkyJ84mxa+1zAFk9zEV+AhNH52Isfd5AHrsr9CGCXSQuBJR/4+vDzo5YKcmiF8j7KM1Ya0IT/P4zwxGeimttO8GUAcfIA4c319LshXgQqsx9uzUDpkc2IuV3zRhafm7h1Elc5oCCDKtfihGERdbUYYFmMefgOY8yo5eVFZFmbMXilL3HxjcSJwIzz06Kci207ZJUAFml97G1rt6d7BmBfD93qaGzszcjaDKJ5RieDJZcUXMbRZKrptRRY2tu6k8J8xyrb1BnqGiDV/DCayh/zCiG7mLYcpMzjU4efUKinTKvWSSqlELOF1H4jPfWpZwLYLP+HstYv5qeRsKnNdBDpKLUmoIXl/TLhcMQfDIUNlVrSx7dtFd2wbxc841p353s6yfrraEyieoIvVcu7RG8SBvYO9ZzY+94umlWhY3SM++5jQrX8owzWJ4xULA+evwvEIgXity6Kz5dLrQRAr8fIwFROevYEHhPAvXVYNA0EAlwP/h2ep9mgEeGeBo3I6ykNvu1mUfWpky1wwuTkWBiCQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:05:04.3919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3cc435-2ea3-448d-7a25-08dc43450dff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773

From: Perry Yuan <Perry.Yuan@amd.com>

Add gloal global_params to represent current CPU Performance Boost(cpb)
state for cpu frequency scaling, both active and passive modes all can
support CPU cores frequency boosting control which is based on the BIOS
setting, while BIOS turn on the "Core Performance Boost", it will
allow OS control each core highest perf limitation from OS side.

If core performance boost is disabled while a core is in a boosted P-state,
the core transitions to the highest performance non-boosted P-state,
that is the same as the nominal frequency limit.

Reported-by: Artem S. Tashkinov" <aros@gmx.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 50 ++++++++++++------------------------
 include/linux/amd-pstate.h   | 14 ++++++++++
 2 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2015c9fcc3c9..ef6381b48e76 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -67,6 +67,8 @@ static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
+struct amd_pstate_global_params amd_pstate_global_params;
+EXPORT_SYMBOL_GPL(amd_pstate_global_params);
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -676,43 +678,21 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
 	return lowest_nonlinear_freq * 1000;
 }
 
-static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
+static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
 {
-	struct amd_cpudata *cpudata = policy->driver_data;
+	u64 boost_val;
 	int ret;
 
-	if (!cpudata->boost_supported) {
-		pr_err("Boost mode is not supported by this processor or SBIOS\n");
-		return -EINVAL;
-	}
-
-	if (state)
-		policy->cpuinfo.max_freq = cpudata->max_freq;
-	else
-		policy->cpuinfo.max_freq = cpudata->nominal_freq;
-
-	policy->max = policy->cpuinfo.max_freq;
-
-	ret = freq_qos_update_request(&cpudata->req[1],
-				      policy->cpuinfo.max_freq);
-	if (ret < 0)
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
+	if (ret) {
+		pr_err_once("failed to read initial CPU boost state!\n");
 		return ret;
+	}
 
-	return 0;
-}
-
-static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
-{
-	u32 highest_perf, nominal_perf;
-
-	highest_perf = READ_ONCE(cpudata->highest_perf);
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
-
-	if (highest_perf <= nominal_perf)
-		return;
+	amd_pstate_global_params.cpb_supported = !((boost_val >> 25) & 0x1);
+	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
 
-	cpudata->boost_supported = true;
-	current_pstate_driver->boost_enabled = true;
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -855,6 +835,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	/* initialize cpu cores boot state */
+	amd_pstate_boost_init(cpudata);
+
 	min_freq = amd_get_min_freq(cpudata);
 	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
@@ -906,7 +889,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1317,6 +1299,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	/* initialize cpu cores boot state */
+	amd_pstate_boost_init(cpudata);
+
 	min_freq = amd_get_min_freq(cpudata);
 	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
@@ -1367,7 +1352,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index d21838835abd..c6e2a97913de 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -124,4 +124,18 @@ static const char * const amd_pstate_mode_string[] = {
 	[AMD_PSTATE_GUIDED]      = "guided",
 	NULL,
 };
+
+/**
+ * struct amd_pstate_global_params - Global parameters, mostly tunable via sysfs.
+ * @cpb_boost:		Whether or not to use boost CPU P-states.
+ * @cpb_supported:	Whether or not CPU boost P-states are available
+ *			based on the MSR_K7_HWCR bit[25] state
+ */
+struct amd_pstate_global_params {
+	bool cpb_boost;
+	bool cpb_supported;
+};
+
+extern struct amd_pstate_global_params amd_pstate_global_params;
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1


