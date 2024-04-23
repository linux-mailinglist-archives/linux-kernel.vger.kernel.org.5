Return-Path: <linux-kernel+bounces-154707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09408ADFF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CF81C21A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D4C54FA3;
	Tue, 23 Apr 2024 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4aP1cVsH"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E505646D;
	Tue, 23 Apr 2024 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861687; cv=fail; b=rUs7VGG7DtV8jnwuxzk8AGfJHzuSanbIEMiNVARYonmPpxrlSSrnmant1YFFmS9Fh3av2D/mw7+qYwxmV6nBTezBANdJDIp3ygZXn2X3URk9hDl523eR90ZID6TtUuLLdoPdMXF2ZYFwg3pGtVcIxTJDyPaOHDw+LaPn2B73fQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861687; c=relaxed/simple;
	bh=FE/sfwHDOGQtH6qM9dG6Cma2RAMyAkVxTa8FUWzm50o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4WDP2/BsBtIZwYVO8OQCT20qDNScBfq+P4H8fH8EZ2No2tZSTlMe1D+/coi+4dMo60HLt9qdVHu2L782TIuBu0L1+7BzemKNJ5HjYdLisPSiL/N+pJgerObhfjgOiFz6ZXl0LEKunYG1e8z5Vf7YSBGBzXa1AEVzgTtU6H9vuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4aP1cVsH; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai4FfJB6gTaHMJwWPDUi6HFwqBKnP5K9M/vX7s9nI5OG4IP6ONTyoqwDqZG4cKWb6/7o3chc7oHayDAINewCGg1bVwTwnsyPb0HcQ8QOTU0uJDBwEobvTOxpDOsGBcyV2BfFdx1kJOAbU9y5NOvxPuD/RtP4vZ5JSl8Ko8jbOCoOZGpaCchRbh6HJh38RwyIt5uRttBbu7y+pDAZH2xN7QKkzUIgeKHNpw4E+wb8ii4u1jEm7glfxfiGktXxGJmvNTRyA0Dv3HVj4Hzi+dztfgsdByLXaCPIFrmqqvaXFvWsFfTW0NTBHp/3dum5+Q7zZpzBYhHwfLcEUVyF9QyA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXVtL5wLz5yZGfvoQ6cbXQnSrZH4mJWVzLmdkkLYfys=;
 b=JhNvh0M8D0OQ8nv7YuTOI5cQRW/zIg41vSWjyFHQynEbwySi1HnK9UgOkypK7tRE3Nwk9srxSHv+yu3yQg1kRoANEOZw+fjhHHwmzYm5O6vDGmCWx+AcWet7+yN6uEkfDcWpGlQVq8Xz0UY+LniaWog5IPtbXFNUvyGa+muTIg0YnG2YIFcr+IQyAqKIh8iul+BR3Kcafur4r/+NDcYSoMMA1WFPYY4A/0rqkoTv/kxUqsd8DbrMv3dzhl6LcdJ+/7PimwjoDlvp/bvzzUzq0djrA2f/1dZX222r6L4dlvJfNdU7z+4ISRtR1S/a9Vr828qD/t5tOoI2MdkwVaQKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXVtL5wLz5yZGfvoQ6cbXQnSrZH4mJWVzLmdkkLYfys=;
 b=4aP1cVsHnebFMfILUUwGnRJPW0e8VrVYfewcs/WK86UXeQWrvyeYAx5aMq/nnKrdMOH6F1Jt/Tz1B8qmNqB8yyW7XjPtFj7VdgNiimOLUSdGb7qT4+LAgFIlpfH/dd357jMOQeeiwryxDjx0F8aGcs6BgMBLLACl3ohv5+FrHBs=
Received: from DM6PR03CA0036.namprd03.prod.outlook.com (2603:10b6:5:40::49) by
 MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:41:22 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::8b) by DM6PR03CA0036.outlook.office365.com
 (2603:10b6:5:40::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 08:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 08:41:22 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 03:41:18 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/6] cpufreq: amd-pstate: initialize new core precision boost state
Date: Tue, 23 Apr 2024 16:40:55 +0800
Message-ID: <5754a2e7a93a048431fa7a745582e62ba67df4e9.1713861200.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713861200.git.perry.yuan@amd.com>
References: <cover.1713861200.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: f346ccd3-6b52-4ea1-206b-08dc63712783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b5jn4gq/KBQ/gK89zx24ZhLD12bJfoLr3cj8hqYjeeiApYjF3iVo1jy2Rmzm?=
 =?us-ascii?Q?+fo5n1/FGyn+uMp6pQwiGpMkEyB+TP6BRuyCnBnDSh1K0fCymhZl3lc17zjY?=
 =?us-ascii?Q?XAcUDzfwwpoM2glD9YInmtVZ84AHKDohiRXjx8UEPoHN4QPR5uCmzbgEpUXd?=
 =?us-ascii?Q?I59mgelSeqjr3FPcF5rW8dLdBgQcuIj7t4SaM+MeFe7jBMz6k9+dciVGDFhD?=
 =?us-ascii?Q?L4rIQ0sOjNVosoa9Sj+q0MSbU9NZtkk+cem8lNQ5+AI/09VazDvWVCYe6RK1?=
 =?us-ascii?Q?uc1saB2bwWApNXPEANdV/poGcYqbOvuEDeDELYY5/RgkH9q0+SOOc+tuoBD9?=
 =?us-ascii?Q?N3IRie+Ehhh1BfvGBifKbzp7dVc9JuHUrMR7drMUYBedNIF89quJTZq5Sg8C?=
 =?us-ascii?Q?s0r7dJtNuf3nwu3vIWeSMO4TBJOa+aM4IfjoJojlOa3cHELTyJjVoBpN3LU3?=
 =?us-ascii?Q?xDa1Mv+qXC25qR3RB2zzAlaD3hHc6KlVPcQmRIhXVPhdZN6D49AZgqTVLcKw?=
 =?us-ascii?Q?y2JSLNw4NDDy0467jTBpH5w0BCJpo1HMOFmrFnsdQ2n9PtnDqVwCwuXDmPwp?=
 =?us-ascii?Q?eq0fajxwOIbuZgtwWYDcsp4sN1uiuQtGpr5F8nsEz4/zDDbOWxfr/T1QRMOx?=
 =?us-ascii?Q?1RfFpivyMsniknEEWCZYrP3YgUfDLqsjI2ONqjTjk6eWCOt3qlhzXoQX18s3?=
 =?us-ascii?Q?PdeARvWsoDe1KsQ5L1jKyCBaG0ovgbzIxJWbIK59VRjVi1YWydivboHKh0bm?=
 =?us-ascii?Q?FziPh06nZWY0vzAkrquuKCcA/rQA4wsgcmJ6pe+DhC7ZZIX9pjFzFU9liNKe?=
 =?us-ascii?Q?8UUuV+kA55xBRCp2xEOAtCfmqklLDCjMeJoBUkxExdM3cb2ti8GZIjvzEBIi?=
 =?us-ascii?Q?7JzCI4sLs7XRrz4UIOLwnjSG+oNeFuNl25AG2qAlEZCWH9xwn8DugSfrmWCs?=
 =?us-ascii?Q?dVq+xQl6ZO4mj2Jvm/mQKna32G+HgASoZlpmsUg9RAxHG7KbY4ZL+sdbWWGg?=
 =?us-ascii?Q?qtyLiadOgO5N8aZo8iSG1MKjtAEhzNKnYrGHNFqAnsPk+LJtk355zaBIFcpY?=
 =?us-ascii?Q?v0gWlMJE+AtBhNft+adsPphvV25G+jFIFReoqjfO7vBfLv44XAR2gz2wKy7R?=
 =?us-ascii?Q?lhG3z7M3BIYhxgyJgplNvhMfTA0Npk0peIt8dfKfeLsmbbs9UdAOPU/vy4AJ?=
 =?us-ascii?Q?HcAUa1PrBk172peoO10pQo3akeITIsR1Z/m6v8RvrvLiA+qf6M2+c3AAKf1/?=
 =?us-ascii?Q?WNmvFsFe6dBLMi07wLBlBg7RRgzA2ERohVcaLP/aqAK8XyiCDpyYEFvydBt+?=
 =?us-ascii?Q?deYsJTzi67qFmIbm7B9wPx2aI+lhGTonh0GwZObAnowmBDAFAlO0TKomDnIK?=
 =?us-ascii?Q?PEjKgw79qSwlssJIE0hB43nV/4lL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:41:22.4189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f346ccd3-6b52-4ea1-206b-08dc63712783
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077

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
 drivers/cpufreq/amd-pstate.c | 39 +++++++++++++++++++++++++++---------
 include/linux/amd-pstate.h   | 13 ++++++++++++
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 83a29b257794..3d86cd7c9073 100644
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
@@ -665,18 +667,27 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
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
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
+	if (ret) {
+		pr_err_once("failed to read initial CPU boost state!\n");
+		return ret;
+	}
 
-	if (highest_perf <= nominal_perf)
-		return;
+	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);
+
+	if (amd_pstate_global_params.cpb_supported) {
+		cpudata->boost_supported = true;
+		current_pstate_driver->boost_enabled = true;
+	}
 
-	cpudata->boost_supported = true;
-	current_pstate_driver->boost_enabled = true;
+	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
+
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -900,6 +911,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	amd_pstate_init_prefcore(cpudata);
 
+	/* initialize cpu cores boot state */
+	ret = amd_pstate_boost_init(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -956,7 +972,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1363,6 +1378,11 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	amd_pstate_init_prefcore(cpudata);
 
+	/* initialize cpu cores boot state */
+	ret = amd_pstate_boost_init(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1417,7 +1437,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 6b832153a126..c5e41de65f70 100644
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


