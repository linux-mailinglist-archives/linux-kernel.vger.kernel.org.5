Return-Path: <linux-kernel+bounces-54316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 592E284AD9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB8C287780
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716EC7E594;
	Tue,  6 Feb 2024 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QYs2xghh"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E756E7E58D;
	Tue,  6 Feb 2024 04:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194117; cv=fail; b=Ipe2ockk9fRbMkIvlEG+HcDa9etySKXldI3UBaIA9VB1tyemd6jNSjJZXilhfGNu50JuROWYWu/fUMqAihjebbwNn6FoTJEzU+H0YyJpCFJyqAsC1zWWTyE3LC0ZGVN5quM+T6uNX5sorILVf/fvqHZgtriuTxjNyOUhoQbk1GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194117; c=relaxed/simple;
	bh=yFZGkb+nRoq0JoaT8GKqmAGB/Kd+cT88vdHLdm4yW3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3AY430x1sAYHfm7SR59+pLOOSaKuCtMjgiZ0+0Pc4zRv3OeIyE8aQzIkjV7Hn9tuu5aqm3p87WDpebA1hBfUakIDMMr40I3Psf2jMCqDHOHeFxmeDMWsUY0/f6JIdiNiaLEQY4/YafLnoKiquW5LQlmr2P0xL67Wee692d6kZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QYs2xghh; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaCGlJybLIYuG+NoE3KqX5vu0rc3hEorGna4yeywjblvidI1n+jtCJpRuq4igojSBEy9W49PTpC38NPmZ7nUnreJwOmaWCdO92VKfyZknnfDCUEkhdIKsCMexXaBxzfaEB9qnYufta0RbRR9vfvmpHsx2seXFofjaGykyjHgglQyiWYx9NK9lRh2S4Xvj/wt+fSonCNeBOJ9wXbKBn8twnF5I8iS4GLNBUjAxFwWBK3mPSf82J70t5gyowKi1oao+/CISr1HGm73jZq0SfGU5Bt14q0z8g12TDFOZkIzysf7peCnze5qaMMqqwpCnKD7bD91++SmZ3cJ1nhw535dHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d43De3TJ6JcZtU9BWyXSYwH8Lq9zu3gPn5XD/lIBskA=;
 b=oWoTIt3BLnqoMez3c3++0N98wwXVyFH6/qz0wbvfGDZXtruICiSiGRWHjO9U/07tgPXAGkqruHF6wa/Lz+auJsrSd+20IHBPd+hAjDodMIiWVh9IMJMIMWlfZT9lgvJFoqOnZxxJDGzHg6rsYfT5tgxyQ4BpFrSG6WSEftE/dDrABQ3PZ6f+ZzBbScyaeIlNKWvMQDg6+3aZ4wHZI9G1ovfok09DGoj/5sfhkM9okfrTa4LaWN7AEF2+mceSfcvo6I+WwAjbFzmZFeqfjDW0EobngOq6kr+qPDdlC5+Ub98hfCo4Em5hDnD4BkmT8Ol7/Enq/OqJmbYYHPQvtfuBRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d43De3TJ6JcZtU9BWyXSYwH8Lq9zu3gPn5XD/lIBskA=;
 b=QYs2xghho6aAFAgu7YOYg3PUdsEtNjHCrxQ3/B9SNX4sksjv8AFIyyw8E0U/mnk6antR6mgXEesRxvfw9ZYXtoZINjpS7wnNs6rqWVbDKi8T2HTL6hSaHx/wdINKqY9TNmKLsdhG6aWwRLqPRb5LWHKuZ0PgjBnHIQnmk/j8zUY=
Received: from BN9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::23)
 by BN9PR12MB5081.namprd12.prod.outlook.com (2603:10b6:408:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 04:35:12 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::c) by BN9P221CA0024.outlook.office365.com
 (2603:10b6:408:10a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 04:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 04:35:12 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 5 Feb 2024 22:35:09 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC capabilities missing
Date: Tue, 6 Feb 2024 12:33:59 +0800
Message-ID: <4626a4aff50921be3b7a0345ae51e5aa246504d0.1707193566.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707193566.git.perry.yuan@amd.com>
References: <cover.1707193566.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|BN9PR12MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c55f9e-6c1b-4e32-88fd-08dc26cd021a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T/3+VZP7exaBvwMgbHhivHO2Eduj6fp5spj4kgupEXzESj3B+JyEqXErLWc4P/qTObaPES5RLkG/LkLUwK9I7KtZs+QkoKWNi1bWrkdgpFvDydfxc/Q6e7CkOsdOJdQ64o9Ga89F0JQmuzILjc/6yIrsMGtRuSc0CNmC/qI8inOC5oDYDIJTWDe+BX89B+8R7TAKMPnfZ3MmWAfGa95kkUry2PCFSuXI4PcrYTTiHYoIj/+Xvf4Zitvl7iKU/ezIc7r+R0vwJd9/Rq4bwRcW1F/RcMvl6S1jy/MwR2TP49RCo2cGmU2eAW5Iq9c9Bxn9S2VcLYCwWaywmb1Vc4s/CUC61kx9y5PhwdLCe1jvtDdFkIUctXAg4CDD7Uhxgu0MgU2fHeoKYjtJh56cg9JC1VhOdnqkjsb6mZXX6SYQyC4VRuFQkKz9cL1yTamZ+M6a0zvWzWiTZaIvGK/+Ol/CFxngpc9kTyDhlSMWsditPOikunSOCnywXXFudGVzvCUYVbnSH07BdDSR+n81lejtcxcbX9yCiK7+JOMITIn4ID/PazxQ0ZV8sb/yOxnc8JM7LaQyrJ5kBscTxzamikif9Tv2jnFaksgli2yazhU+BWA+Y4+J/nVmR6kHucUjum4PjTvHeYPOu0mxcfKjjUW1PFkTf2u/15DVmk/T+iH3pAPIEYbvWN2A1HdNLGcE870zHvfgXfffnFtBki0TWPHBtUfR6DI4GEYxEfzckUGGcwdPUbMDtnIyOuIAYZAjmuaX7mLyhVw9pptjkhYD4T2ssg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(70206006)(40480700001)(40460700003)(41300700001)(6666004)(2616005)(36860700001)(6636002)(316002)(478600001)(26005)(16526019)(7696005)(54906003)(47076005)(426003)(336012)(70586007)(110136005)(83380400001)(44832011)(82740400003)(81166007)(2906002)(8676002)(8936002)(36756003)(356005)(86362001)(5660300002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 04:35:12.4743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c55f9e-6c1b-4e32-88fd-08dc26cd021a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5081

Add quirks table to get CPPC capabilities issue fixed by providing
correct perf or frequency values while driver loading.

If CPPC capabilities are not defined in the ACPI tables or wrongly
defined by platform firmware, it needs to use quick to get those
issues fixed with correct workaround values to make pstate driver
can be loaded even though there are CPPC capabilities errors.

The workaround will match the broken BIOS which lack of CPPC capabilities
nominal_freq and lowest_freq definition in the ACPI table.

$ cat /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
0
$ cat /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq
0

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 59 ++++++++++++++++++++++++++++++++++--
 include/linux/amd-pstate.h   |  6 ++++
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 77effc3caf6c..874d8b663790 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
+static struct quirk_entry *quirks;
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -111,6 +112,43 @@ static unsigned int epp_values[] = {
 
 typedef int (*cppc_mode_transition_fn)(int);
 
+static struct quirk_entry quirk_amd_7k62 = {
+	.nominal_freq = 2600,
+	.lowest_freq = 550,
+};
+
+static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
+{
+	/**
+	 * match the broken bios for family 17h, model 31h processor
+	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
+	 * definition in ACPI tables
+	 */
+	if (boot_cpu_data.x86 == 0x17 && boot_cpu_data.x86_model == 0x31 &&
+			boot_cpu_has(X86_FEATURE_ZEN2)) {
+		quirks = dmi->driver_data;
+		pr_info("hardware type %s found\n", dmi->ident);
+		return 1;
+	}
+
+
+	return 0;
+}
+
+static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
+	{
+		.callback = dmi_matched_7k62_bios_bug,
+		.ident = "AMD EPYC 7K62",
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VERSION, "5.14"),
+			DMI_MATCH(DMI_BIOS_RELEASE, "12/12/2019"),
+		},
+		.driver_data = &quirk_amd_7k62,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
+
 static inline int get_mode_idx_from_str(const char *str, size_t size)
 {
 	int i;
@@ -600,13 +638,19 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
+	u32 lowest_freq;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
 
+	if (quirks && quirks->lowest_freq)
+		lowest_freq = quirks->lowest_freq;
+	else
+		lowest_freq = cppc_perf.lowest_freq;
+
 	/* Switch to khz */
-	return cppc_perf.lowest_freq * 1000;
+	return lowest_freq * 1000;
 }
 
 static int amd_get_max_freq(struct amd_cpudata *cpudata)
@@ -635,12 +679,18 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
 static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
+	u32 nominal_freq;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
 
-	return cppc_perf.nominal_freq;
+	if (quirks && quirks->nominal_freq)
+		nominal_freq = quirks->nominal_freq;
+	else
+		nominal_freq = cppc_perf.nominal_freq;
+
+	return nominal_freq;
 }
 
 static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
@@ -1672,6 +1722,11 @@ static int __init amd_pstate_init(void)
 	if (cpufreq_get_current_driver())
 		return -EEXIST;
 
+	quirks = NULL;
+
+	/* check if this machine need CPPC quirks */
+	dmi_check_system(amd_pstate_quirks_table);
+
 	switch (cppc_state) {
 	case AMD_PSTATE_UNDEFINED:
 		/* Disable on the following configs by default:
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index d21838835abd..7b2cbb892fd9 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -124,4 +124,10 @@ static const char * const amd_pstate_mode_string[] = {
 	[AMD_PSTATE_GUIDED]      = "guided",
 	NULL,
 };
+
+struct quirk_entry {
+	u32 nominal_freq;
+	u32 lowest_freq;
+};
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1


