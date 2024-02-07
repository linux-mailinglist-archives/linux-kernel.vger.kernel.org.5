Return-Path: <linux-kernel+bounces-56192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB08C84C732
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7072884D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A752B23746;
	Wed,  7 Feb 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cOibHX0N"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023920DD8;
	Wed,  7 Feb 2024 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297762; cv=fail; b=Nf8zL6JL6n2jSlcxdo4FrHndZxNhTxjwJZ3F5lR1gcIAGAmI16h9D+PVXAuI4rHIi8FE3plg4bKBa7P0ykDhWuu+8A6XJXmp9qUHKbLKPXp79TrYa3GTCLMom/dccOJxw0poQ9fAcwx1+pBXLuHsSLOnECx9K7MHaADParBZ99o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297762; c=relaxed/simple;
	bh=Ak9+f1ImxIgmiCcWaGOJrghRlhQB4em9uBqxJIcJATg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWPDfHSw6qA8kPZklM87qVvV+R7Si2STgYIbFYWuGDQA685zlKrep1H+dw9FBEENOj0/SniNUmKEW2TH91wwsacYNhzTwd7ZxzwFrNbA1fORg2zzCoLPO6nHZZl8+lfb8wQpa46oPoCaPST++Ho7lDJUdJ/zvKk2tg94vosG15U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cOibHX0N; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6dc9HHOZIg4T2Og7h2mnratUGZYn4wI9ys8Y9nzPR6nRaOoE+BA1oPDjelrQwK4VEEqZHwME3/apQNQr781UUr7UC0X0P69jC8NEnqzQ0jhMsDYiAM3xSxZvvsHulm/9LK/mzs53ruqnyqRQ7xIupZNVPNWMbb0EGSFjHJfJ3JVJPIufop0m834P/WJhLgnB+0gVUTb+YdzecUQg9C3LW8VeYhsXnckiI+MoKxTEKMg0IWUKl0Ir+SUrOHgDKHj1eWpRQzCWw4yBi73+vwM0lzrull7FouVoyfCNDUzUZt6ezEZKRly5teEr/V7fxiak90RlQcBKZpSdUjqXYRBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mSWjzc1phkK/5cOO9MgCydnoFOD5V0YGb6r7BmpUeA=;
 b=FnpyZF3eNyFHP+igNQbQ5+tewkzZKyND75coTuz66ozf6jqHWc8hpZxmQtAzummiyINf5RY7qUKZhTqi575pp9vQei/V3cyDoeLRdewzOqRmCU/MQrmP8DzGLFzLW/V7gVgV9pB+dWAkHlsalPSGPgIk02MZywHcUJ/crcd/NvmvkI1F11i2xVqH2eAd+sZrHb9XjdXNVji9C0ZkdCTHoJHIpnBjtkDgSG1Xl/lmRDRrwuikM87p9hivZUMpKPqjHkakcTxY3cl45xa/DeYThXuGYdX5CU3MBOKexXS6+0/9bgTDkrK9G79K7+8w4xGQuATo+p5Bd8GbIS8QY1ikrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mSWjzc1phkK/5cOO9MgCydnoFOD5V0YGb6r7BmpUeA=;
 b=cOibHX0NWUjInYkbPP03lQuykhUmjV+WuydkYgNBzaBW8ItABGeCKFXNxYUjcxiD3pRM9BG1C0S3LBrn2Y4ghFfi3e6/goX/Exhc+JpyXujdKyEy826wlRdoWrkGfn+lXSD7aPbbm8sp9TS6AyFQocQ8E1Utl9CWFKFgSpH9rKY=
Received: from BN8PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:70::26)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 09:22:36 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:70:cafe::c7) by BN8PR04CA0013.outlook.office365.com
 (2603:10b6:408:70::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 09:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 09:22:35 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 03:22:32 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/7] cpufreq: amd-pstate: initialize new core precision boost state
Date: Wed, 7 Feb 2024 17:21:52 +0800
Message-ID: <b4d4ced021e608268e87d630de9ed271cf5f3277.1707297581.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|BN9PR12MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: b5baf410-bb00-4052-45a6-08dc27be5268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QYVjvwQLmrSYM/b3GbcK519hACoWK+WdBaa62vfEZKMvQrLEQlDNDl//8oHtNfm+NDKM3opaDEbDDO7nYNwHBQ2Amj+8GRG63kNzbDhSLbekuUz1hXoCKbexiw3FA2x8AgcaB7GiJmnOHnJDokjpugIi11DpE1chkUpc9yREGd8eUWlm8V4iNPIW5ZedwY33hk2NjYxwmkt3cSxx40B9EaXvhn5hAVTnxxXuWD+AqdqzrlEJHjxnta2MDrpksvqx1Wse3zA/IY6X0fDM73hkvuwVH3jeaHvBFtt6aM9Q+nVNbbp1P55+k95QsUi+9kbsaSgiT++PJBFwPj6jEfOHB4YFiIsfvjIX0e4Gt3QBfRccGlmOmkPij2kwzCrDjZzBPjiDfLmPpbJzf8BTt+z0l8FYE6FpM2Jsj2wLTNJOUu42Vfid32rn2RS2cdbsYhAqn5XQ73wKVma+vDNrYS0kdVcqDDeJtoJkbEUm7ay1kx17JGj9gCPbfwZ3NGyGs3gMcMUs2JqKSZmNcgiCnsI61Xz0W0fjdx/1GVFMREV7++JO4uG4dwESMloKvZdeuosA2tHQcEyM33si745NTJ3n+sTqUeYylPfBR4wtbXHaov/lzN/N2vTn46eKrq2mKcbpwQN0Qq0mH6mER4viXxoO0ikdL/JuDlJYVjLm4mW53/yB+G2yVU1YR8NcwW8lMx1Ve4pDUbqKANZpvALSBrjmbhumqmCJM51ahQyHkHCXSDYrbCTvWWicARh+XB9hpNlMVM2Vv7vRN4+uNz8efl18hg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(426003)(2616005)(6636002)(70586007)(54906003)(70206006)(336012)(966005)(36756003)(40480700001)(40460700003)(478600001)(316002)(7696005)(6666004)(26005)(16526019)(356005)(81166007)(41300700001)(8936002)(2906002)(110136005)(86362001)(44832011)(5660300002)(4326008)(83380400001)(8676002)(36860700001)(82740400003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 09:22:35.9290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5baf410-bb00-4052-45a6-08dc27be5268
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226

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
 drivers/cpufreq/amd-pstate.c | 49 ++++++++++++------------------------
 include/linux/amd-pstate.h   | 14 +++++++++++
 2 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 08e112444c27..3772f71f525f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
+struct global_params global;
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -669,43 +670,21 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
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
+	global.cpb_supported = !((boost_val >> 25) & 0x1);
+	global.cpb_boost = global.cpb_supported;
 
-	cpudata->boost_supported = true;
-	current_pstate_driver->boost_enabled = true;
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -848,6 +827,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	/* initialize cpu cores boot state */
+	amd_pstate_boost_init(cpudata);
+
 	min_freq = amd_get_min_freq(cpudata);
 	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
@@ -899,7 +881,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1310,6 +1291,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	/* initialize cpu cores boot state */
+	amd_pstate_boost_init(cpudata);
+
 	min_freq = amd_get_min_freq(cpudata);
 	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
@@ -1360,7 +1344,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index d21838835abd..465e9295a60c 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -124,4 +124,18 @@ static const char * const amd_pstate_mode_string[] = {
 	[AMD_PSTATE_GUIDED]      = "guided",
 	NULL,
 };
+
+/**
+ * struct global_params - Global parameters, mostly tunable via sysfs.
+ * @cpb_boost:		Whether or not to use boost CPU P-states.
+ * @cpb_supported:	Whether or not CPU boost P-states are available
+ *			based on the MSR_K7_HWCR bit[25] state
+ */
+struct global_params {
+	bool cpb_boost;
+	bool cpb_supported;
+};
+
+extern struct global_params global;
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1


