Return-Path: <linux-kernel+bounces-104024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8935787C802
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BDFB21048
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567BEFC1C;
	Fri, 15 Mar 2024 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hdsm0hur"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3DC8F6D;
	Fri, 15 Mar 2024 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710473969; cv=fail; b=UQ5kFVlM6slYL6K4TUjl782qxWFQYV1E7mZr4eyB9xlf1oyoMBkkfJHfpWyia3ixksr+RMJ4YPl1zjNWCTu8Wpi9FRJDgq0qPBdgq4+YJQTrTPuWsd7Zb11FJjbDFVX0vJk646uPUoWwUhvF5QI+3Y2gJRBgbeG4DmkI54eEtYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710473969; c=relaxed/simple;
	bh=myJtL7eVAV+4yD+ImS+bI48DqHfbyv/Vj3k84fTTcuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CppL4IB5/Q97Ka8krVDXyPj/MUfiUYd8GzOUu79dfjDpadTzJFCOFEBVBS7OGkD/I/190OcYJ6HM7tdWdchr7fCKm0aXzd8IIUFTi/EEreshw2bosMaFdMjL99wx/oT/9HGv2BZcu50h8OPTv1qG7Xs2PQKFnXwGz7JUuWl5Qrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hdsm0hur; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=My/ZV3LUGF2ZzgOHKPxC/fEIYfPPl8+7sDlh/ywGb/4QzMYYiDwwEsR9yb3wSm5e6voGuagedcspgL+6MBs1h+DVt+WxkvPjuG8y+KWyDj4LaqwZ8M8CNYLeMX2qv4l9QxpHlE958ed17bPsaUN+aRVGWTekW0dirJOb0Fb1FumFV8xwZEiDb/b1FgF8VkzAF4MXLmmHzc7kHLxid3Wfz/eIco7nZu29gPx20q3r0trexmaRvHXKS35eM/1vXeojKENdecxcYjccp4FroJelFbBCWoKty5xPS4CM/F/jcbxhu86+T5widik77O2QvglU2CrI30feZlyVdxvL4whfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2CUmmbWWiTBviynVZojda1E6sD0YWvwzT88KdFIIbU=;
 b=bBle/lgHeov41zSZFIo/eyIlc0k0jnvG6Mx1Obv3RC8zZBk5QVd9g/TTewse/5ApIq2769ZKU0Amd5s+W+CcrHQlAo3oufopPSuruVVYYIJNC6m3NC1Ja4GiuiYUXvepC8DMzm2p/z27f1f57RT/yRO1xVCJe236OZO+xL2zLR8hu0Fh7fQCXxzYSkHf8YEtu5QG8icJ9kmh89Ytd/tXgkwB4bvbSJILqNYN/QFIFM3jnRvZV7OZX+bqSHwai510GaFc1j1rZRxMVvFNSJgTMBd5PH6y6mLikfl/CL0SH49End9C5zqz7RgQ7v35V++5f8lrF1ifkEen3l75lcfKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2CUmmbWWiTBviynVZojda1E6sD0YWvwzT88KdFIIbU=;
 b=Hdsm0hur1IFbUUizmVbSM6O5gfqor4cFugoMZU7pD0HKKWewg5lXQdAXXXsw7Vi4mRX/zBkKVxOxrcYny9Wjo4oQmIi/vD8c1cLA/aEpxu94gAv8LaYWTChkpaLPxI+GrkxlpOWD8LRZwRsvolz+WddDxPSUXbDVuIf+TGsdoLE=
Received: from CH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::29)
 by SA3PR12MB7877.namprd12.prod.outlook.com (2603:10b6:806:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 03:39:25 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::59) by CH0P220CA0014.outlook.office365.com
 (2603:10b6:610:ef::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.37 via Frontend
 Transport; Fri, 15 Mar 2024 03:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 03:39:24 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 22:39:21 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/8] cpufreq: amd-pstate: initialize new core precision boost state
Date: Fri, 15 Mar 2024 11:38:03 +0800
Message-ID: <11aa1b6bba983cd5b2d07e797df657c9317a6624.1710473712.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SA3PR12MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e6120d-6d7e-4fb5-f6e5-08dc44a18244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AAwAPL7wT2jcVEWYC09MdLhYwtZ5yqTv4oSwFe5ve9d0KmABn8wz0nlq1XMjvlReUbDaC8iUNuqSgKfVTtAoSBhuCZ6qddln4vgMDmyqXz1jwTIluHBzjSW5eOiFJrAUc7sIaJj1ylAp8p/CkrKsxkcvCg1cA4r8kLw+By4gSxK6EdScOig2LPRgv0wmRhh5GOt8q1tFI/SPnKZAjhLf0a9EA3OJKkg0hrvQFly5evna9L0rC6XlvmVAMpErYgVNobOfl0bYwjMQZ+btW3V0aoqh73n+ddmcgaHCJyoKebulBofWF5ld2MPo/x8ra/0GrVvZfTaDCQ5UcFgz7D5YZ6XsIh4qfxOxOTCyzPuqXGyunIaLF+Sis8nNFY6Xiglt928R3h21MRM2tKnxkt9uOEtA9XjpOsiOQOVlki/AuyW7ifTGLMiKW38FhGzHnYZxi56jiG+5FGAn9A7gH+BimhnFExdIhSHgrOK6JyvxTDq6nnc7ieWnF87EhDjq47vGcCQFPnafp4FZ75gWTjOgCqsiYfByj40hvFRn43lhVXbjpCmPlCXacC5EC1vTv2ZlR6byT5a6q3l+oyZJd6Q2Ck6Xf6IeZuvedavY4AS+2eHzarbsd23CjOmqDlndiHNwn4DDY9cjStH7cIiAR5ED/Do1xFe+BBd3fa3N9k+1Of9NxXHWzq7EupUUPmdhiGxLaUUhpVnaWEnEN6ZnH3IrOg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:39:24.5123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e6120d-6d7e-4fb5-f6e5-08dc44a18244
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7877

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
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 50 ++++++++++++------------------------
 include/linux/amd-pstate.h   | 13 ++++++++++
 2 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3877d4ecb5d4..e5eb09f874ba 100644
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
@@ -714,43 +716,21 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
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
+	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);
+	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
 
-	cpudata->boost_supported = true;
-	current_pstate_driver->boost_enabled = true;
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -923,6 +903,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	/* initialize cpu cores boot state */
+	amd_pstate_boost_init(cpudata);
+
 	min_freq = amd_get_min_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
 	cpudata->nominal_freq = nominal_freq;
@@ -974,7 +957,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1385,6 +1367,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_cpudata1;
 
+	/* initialize cpu cores boot state */
+	amd_pstate_boost_init(cpudata);
+
 	min_freq = amd_get_min_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
 	cpudata->nominal_freq = nominal_freq;
@@ -1435,7 +1420,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 1fbbe75c3dcc..383359f9cd6f 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -131,4 +131,17 @@ struct quirk_entry {
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


