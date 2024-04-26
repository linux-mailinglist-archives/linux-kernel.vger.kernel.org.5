Return-Path: <linux-kernel+bounces-159574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D6D8B307F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5239287307
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D7713A88B;
	Fri, 26 Apr 2024 06:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NeemyQZv"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A78F7E76D;
	Fri, 26 Apr 2024 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113321; cv=fail; b=nyN2Ve4xRWF+XiIPADXGMxU1Hutj0Z8QVRmLYn5ulko3LN0vmsPO97GbXzMf9tU2L6bIx7kC1rMMAZMTwjJZrJ+/3zC5j/p2jj562Ym+bZHlp3rhNEM+M2qwvCR9hlFW83cXoct52XlmOn+i71BAtEZo3MCWTEEj6GvPS06q6bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113321; c=relaxed/simple;
	bh=YCHE/TWKVrCFOmBjjgcl9Lf9KXhWih7TRrH3EKYFVpw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lL4EoRzcRJB+njZSj/m4Pl8D54wliktd15P1o0iA8WF5kFJZxhwHYfUnCqPTFkfGnZo1Xjmg6PU0ygMCvjVKigw1/QL3YfDKE6Uyts8zDQkH69I8bvnOo+ViacQ0GIaNxMW130qJTj1KsouzxsYJZIQm5GUZ6TtNramWdLiWAo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NeemyQZv; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3xd3RQruugW/G5R1mxCDOFzBbUnfDikR53dBo+/g3OntHxjFLXqR98Kqp5dCW7g9oMgLevK5MxEhcLtzD+uomPp8fXq4nUVTZg2TPd+h/zAmSkCjG+xSHgtXBDhHFnu94/kndeAyhElDQW5QttWeyiPNmjSHddykfQUrvaBJPYotzopf5envnZVJq8Ku6arAwGmExWpMJgFpVCukgStD+6FYvOyBND2iPowYkXj4n97jL2gyZjgCVD9VAuon50ReVjHWg2y926XUwf6ngdlHmkRBC1/idnSxofRxkapORnfmw0R1ZI0Vuih7lUpfeATEqZlu4PSkUCyf72lZirg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIpVWn8iYWUVoQSgn0dyTF1QK6B+spoV/5q+gOBzVZE=;
 b=YZz3YwkWdTbraN6qkQbhFUL53TdFVtq5FMyH+MzWa7gV1cSD/ZusT2cQQnLHJhXXyiw80ySiqPf6nwFk5j0GZ1bb+0GdDlz2WKVV1Q+BdeOcyjV2k7zcR+sZDrysLqgNHoU0dT52T8gaFSr5mhpwKs8OVSgAOGWRW7JLSNBLLmQE7Z906E0bwZSAb1ATCl1zF4mZXDIBOs6wmRw/3z79CONefP9BX6wunK/6MSxZTcAmlbor00b3RvSi6bhwynEwjnf0d+8ot9H5kARfJY17kJgLqhHRLvs/vU3h1aSkOYTOXcn82JgoXebOz6Vev9FCwbPiAuqARbbdSHRgoc2CUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIpVWn8iYWUVoQSgn0dyTF1QK6B+spoV/5q+gOBzVZE=;
 b=NeemyQZv0Ja+AAU/1Sl3JoGRJBZtP/UtBtN1SApApZAqxYVVKxEuxp7y0xPbo/JW4gS81sTCItWuW7zjwse5uTzaGAtgb8lY2lP2xwyYNbaFBaXC4wPAvSIbxyTlub1hjzX/G6W2gmGwj8DpG+bGljVvDlaJ6FaXJMroJg1Kj7E=
Received: from CH0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:610:b0::33)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 06:35:16 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::1e) by CH0PR03CA0028.outlook.office365.com
 (2603:10b6:610:b0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Fri, 26 Apr 2024 06:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 06:35:15 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 01:35:12 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 2/6] cpufreq: amd-pstate: initialize new core precision boost state
Date: Fri, 26 Apr 2024 14:34:45 +0800
Message-ID: <6ea9dc722218a8498e60612cdcd26e99305c16a8.1714112854.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714112854.git.perry.yuan@amd.com>
References: <cover.1714112854.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 68664464-8b21-40d5-53e8-08dc65bb08b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ndo38DojKcGrrUPsHn6o9tlCxgYWdadCHZ9tvzRw8uEgC0UgR1ayMF5XjU/q?=
 =?us-ascii?Q?Y3dYrdUz1BbZJjX51v5+D7neu2BHIdcnnVPSnIZkF2EnwoLNEeiChyYp7+zJ?=
 =?us-ascii?Q?APctI3a8hisNSzOZl3Se3wQvlPmAXUJjqigFmd/TDIO0+1rg//Sadvq034An?=
 =?us-ascii?Q?jEsgzvCBoQuk8BArKatLr63swUZzk8AvgcZ68VIjjaxr08TIskby4F4j2DmI?=
 =?us-ascii?Q?CWxZUr09/5qaoBrDMM9hyM6VUE/AYQigsVkOMsuK839uIQaE3ushZUkHxFpJ?=
 =?us-ascii?Q?q0e5Hwns6ndKciTmAiprqO86rNx4n0fS0tEPKRVfpkRgk4LsMd17kXf5qA0Y?=
 =?us-ascii?Q?n2sAk+LEKcxD1GCOof8JS0ab1+SUuw5XxKX2o8B+anXmA8StGX1WrixUiRYG?=
 =?us-ascii?Q?JOUoGPAi7PV4IEi/llFF7x4IDduFkbqxy7H4O/qt7Diq1d/b+aii7VmtesCZ?=
 =?us-ascii?Q?xzhAT52+gp/pQsR3W7EvqhFu9zSOsblt9tRvuTfbc4nZGoFcB7n9kQjf3qjx?=
 =?us-ascii?Q?tqJBPE3QxPwfAXt8DhspXJT/e49opljo7gDUma3wBtU2nrE4GEgpbAViiWB3?=
 =?us-ascii?Q?xsuiNLuuAlvrJb2RAXx49x+PzhK3Kz0SfvgkprX+MVf4iemcLQG7bf44aoGo?=
 =?us-ascii?Q?ekIRrhTXshfCHMNWw1bF8MNETrgDVgBvL79h3fVhKSEeFewK5FjIatKRoNDo?=
 =?us-ascii?Q?7PjfD7KmHy5vj0E0+Na2SGJ9nxQTkX3AIDQ7r5Ff3fuP2/vC8gvDOeKOHWEW?=
 =?us-ascii?Q?eCwfqkSXfh58SlcXoYE1Y75a6wV/gTzDeYzZohr6pyjMKOZ6HtSWDaCSvDyS?=
 =?us-ascii?Q?6VRZPaxjVWYfp2IA9+gpEJkUxYhXHNnz7CmaXmDeZUHe5StYAj4zApPZDlJc?=
 =?us-ascii?Q?vI944KBHzPJs1TKcQ90B7J8+mb5wMBc+C0Y3tnB3mbKunf1E1Erbto911yXk?=
 =?us-ascii?Q?qqwa2eixwfBgdGn44pXrFd68AWYpdd7LfMG0vEnhb6KcvZK8AMT1hFsAdGXe?=
 =?us-ascii?Q?v7q5HAG7yZ05ykhudWK580MO3e1vUs8r0YLnIclBJimTAdvh8do9OFNk2STE?=
 =?us-ascii?Q?bgpqJQl4rxrU3j9lVrLzjR8Z30r9ZVwFlAAEoXHGLYcJIw06RinCPu4/MJEA?=
 =?us-ascii?Q?k1EE2wLgjtpSPbuhJ+O5PfWjxBcQxo5ifeOgbE2D2aESb3tzLOwKTtzPmWr2?=
 =?us-ascii?Q?ByKprvZ7TbJqGYVYBoh+duNENhScodINYctdAlFznZRP6QIG6PLbLqSmW1a9?=
 =?us-ascii?Q?FnLXDqUz1JJKsXuLK4J3bjuJrndXQaH4ECXv6snKJ/o2oTnkoXarJXUXPZAG?=
 =?us-ascii?Q?N8Wfw9/AFMZ2xaFyPD5BSPol1JLNBFTgnhVDlufTh0H30TledfwsW2LKAj64?=
 =?us-ascii?Q?ZhhJVqihmd1z0IHEhBJqVJU9Q3XW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 06:35:15.8402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68664464-8b21-40d5-53e8-08dc65bb08b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198

From: Perry Yuan <Perry.Yuan@amd.com>

Add one global `global_params` to represent CPU Performance Boost(cpb)
state for cpu frequency scaling, both active and passive modes all can
support CPU cores frequency boosting control which is based on the BIOS
setting, while BIOS turn on the "Core Performance Boost", it will
allow OS control each core highest perf limitation from OS side.

The active, guided and passive modes of the amd-pstate driver can
support frequency boost control when the "Core Performance Boost"
(CPB) feature is enabled in the BIOS.  When enabled in BIOS, the user
has an option at runtime to allow/disallow the cores from operating in
the boost frequency range.

Add an amd_pstate_global_params object to record whether CPB is
enabled in BIOS, and if it has been activated by the user

Reported-by: Artem S. Tashkinov" <aros@gmx.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 45 +++++++++++++++++++++++++++---------
 include/linux/amd-pstate.h   | 13 +++++++++++
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 83a29b257794..aa17a3134497 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -68,6 +68,8 @@ static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
+struct amd_pstate_global_params amd_pstate_global_params;
+EXPORT_SYMBOL_GPL(amd_pstate_global_params);
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -647,7 +649,7 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 
 	if (!cpudata->boost_supported) {
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 
 	if (state)
@@ -665,18 +667,31 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
-static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
+static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
 {
-	u32 highest_perf, nominal_perf;
+	u64 boost_val;
+	int ret;
 
-	highest_perf = READ_ONCE(cpudata->highest_perf);
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	if (!boot_cpu_has(X86_FEATURE_CPB)) {
+		cpudata->boost_supported = false;
+		current_pstate_driver->boost_enabled = false;
+		pr_debug_once("Boost CPB capabilities not present in the processor\n");
+		return -ENOTSUPP;
+	}
 
-	if (highest_perf <= nominal_perf)
-		return;
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
+	if (ret) {
+		pr_err_once("failed to read initial CPU boost state!\n");
+		return ret;
+	}
 
-	cpudata->boost_supported = true;
-	current_pstate_driver->boost_enabled = true;
+	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);
+	if (amd_pstate_global_params.cpb_supported)
+		current_pstate_driver->boost_enabled = true;
+
+	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
+
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -900,6 +915,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	amd_pstate_init_prefcore(cpudata);
 
+	/* initialize cpu cores boot state */
+	ret = amd_pstate_boost_init(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -956,7 +976,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1363,6 +1382,11 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	amd_pstate_init_prefcore(cpudata);
 
+	/* initialize cpu cores boot state */
+	ret = amd_pstate_boost_init(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1417,7 +1441,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index d58fc022ec46..8ba5dd4d3405 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -134,4 +134,17 @@ struct quirk_entry {
 	u32 lowest_freq;
 };
 
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


