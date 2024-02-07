Return-Path: <linux-kernel+bounces-55870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3113784C2AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566D41C24C07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325FFBF7;
	Wed,  7 Feb 2024 02:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X+ZUbVvo"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD6A10798;
	Wed,  7 Feb 2024 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274043; cv=fail; b=kK16pzzFM3cSrWL9BTJVxr8L3PvCWMFeOL7zlKziKCW8F9Vmp+hgR+puu/UhwHdkJjoHyg1115MnMiU+sbtVGYbCMQfpM/Ak29gHywZWNl0e4WSs4H+K4d2RJmjwGcG6E2QaAcQlIWsTx8QSnh2ptETUrsY1bustSsTZxHbZ10w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274043; c=relaxed/simple;
	bh=vVLH9Y4avtMqsLpbArkJNPGM2pGlxgMd8pmaoIg1fvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1+nel/35XDYCd5Sy6Bff9nvbLXMY2Vxi0L5/WCDHyfsbJMYFKsoRTA/iOngPaDc5HotNCktM/9EuQXAYtptBHyNtY1bXexDiyzNnbm4MZvsrjNmFnhAw0B1fCDMq8/ym8Yh6f0SuCheimJ24C16H8GJuFVM0zD47lMwLAv23A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X+ZUbVvo; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0xI5ki0DCoBOiUJXn6fjeVBoqt2IJfIT9rJW8/K8Bbh1fWaGarpK6wWFS+YdwkoDAbPhIgk5pJ7Z/EI7gtCgCYLPIt56IAd4HIjuH1euwYCrGhm36kzDM+7SWfban8dNQTZV+YUmfzf8Ph4b2cad5AsoZyGGn3MIOKL4AN9m86DZOEtnMwp+p3OrJjtAsYFsVuU4KknyrwBQAzvKnJ619wUX6YSS4gykrb7UlAB3elEHL15Fa19gqNDd0RxHMGBzZZcGc9boNbyNIdbR0Wcp5pycFMDbQEE4qZQtZx54RYiDO3LGU+fHldBjWl4Ht0Sp4fcE0UQC8+fq7GWXyUjLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3wv2RIN1TAIAbuNVlpm5LnwJYzqinFJq8BTtbH0cP0=;
 b=DMagc/bWV5RfgizDNnJSAB507s557tq6ouLa9dlgDHzeVOcJLGZk4BR5bgx/cQm6vG0qXyJ6y+M8P2SOb/n3odjSg4IKPKdDypR1PuJc8vSN8UbsO8v4iQycarogkxt2tcmucG0yZlKv4NUPOgq5XV5epk7kLUSmmfKGMQXrzR3ADzW9J3GGA8tVi8rRqPegDvuc5nHE/ABvLW/ISc8acMll+pSFt4UPmCCocJhBR7DuXliARWd0V7Sc0QGUiF9/v/QjIQKvmuo5U6jQG909/Gbz7CIp7n6FK1ElpHWoTqmBxFTolbikmDwm9A55EWCYdiI3IKlzWQjlzAu/nlp9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3wv2RIN1TAIAbuNVlpm5LnwJYzqinFJq8BTtbH0cP0=;
 b=X+ZUbVvo7wtqmf61jzrba5jClfwQqgz8kWpUSkF30ooZiNXXO4rd84mpUUuivcpkv6uwLBqyrafLFTAd/b5HVG0bBi1qNXwduQ++VabiXfIXW/b/ib8WBxBihEUoWdX9/0pphYoeBBNdBJkvQEEpsO87KYlNO/Llmr+xLdGQN50=
Received: from DS7PR07CA0024.namprd07.prod.outlook.com (2603:10b6:5:3af::6) by
 LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.23; Wed, 7 Feb 2024 02:47:20 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::cc) by DS7PR07CA0024.outlook.office365.com
 (2603:10b6:5:3af::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 02:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 02:47:19 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 6 Feb 2024 20:47:14 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC capabilities missing
Date: Wed, 7 Feb 2024 10:46:15 +0800
Message-ID: <ea6a2fcf27703d40957a53608d48813cb07f094c.1707273526.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707273526.git.perry.yuan@amd.com>
References: <cover.1707273526.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 627705a4-749d-43b0-6a81-08dc27871a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	niTCSLM0UbMFOhkurTIO1HsG13qaLziPkVOjZao1P2X1bKQAAQ8zWZqBQWrFuSHRZWEwCL4r+oSX82DFW1wA/xwxCt/J0eCD3Lfzp7uInBnbcuPQ8pFu5jbye7xu7tR5w7WIXjmf79ZR8nVwKZDsUesboiUWoO0qPW01kHISOEkPq3jLm3wvUmXAb0zBG4+OpDvrjoEBcXEtQm0Bhe64iRZbnMyYBNug37aD2dqDEttqQXYQU2YcasqwXWtWP1WxkBcW3w8THh6Ajkg46U1cLjhri36E36rMvetz/F5Ey6Nje5iuf3sdyJ1DfO17IyfyohQ/Bva+lxmrzrdE1KTC08aSyu5dsdbPDY1RbpPBb4LfCfLGm6on7oi79Frb+uukOeuHC1S47ooNlL0D2Mofei5w8QGBzvHkPD126lH19as/qpNWoezxnePv1lr2Hd0UqcVu2YMhWu5DL+uHoFrAOzZKDAUQcU3cvFhMWLbgbeDu+oabV7TIpacasusU+Fj+AyWSc4weBGoyDNgpnPRDOXLLCXmglloTlTBXkpXjOGLMHTccFC35JRDlTOWRunUyTuuKCO43tYNrMtSHHdJ3xsANL4bhU3WA8+0zhSmo2dKWavCxHxvPFQjlwH1gIrlfHOhvQzuHY5ZK3/KTf+q+2HZ8ITR4gvKAKh+C8jpoz9MhdSL3yCF4UQ/yZ4pNHHnyXZqLdaqaYIS/c0utuaxx6P4Eimg+St5NDKTnt8Er0OvUDetQspokXaqkbDQoU4PwZoZaA6KBJU3BRF2IH2iJQA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(41300700001)(83380400001)(82740400003)(86362001)(16526019)(36756003)(70206006)(356005)(26005)(81166007)(2616005)(5660300002)(2906002)(47076005)(6636002)(336012)(54906003)(478600001)(426003)(36860700001)(4326008)(8676002)(70586007)(7696005)(316002)(44832011)(8936002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 02:47:19.7355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 627705a4-749d-43b0-6a81-08dc27871a87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822

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
 drivers/cpufreq/amd-pstate.c | 57 ++++++++++++++++++++++++++++++++++--
 include/linux/amd-pstate.h   |  6 ++++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 77effc3caf6c..ff4727c22dce 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
+static struct quirk_entry *quirks;
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -111,6 +112,41 @@ static unsigned int epp_values[] = {
 
 typedef int (*cppc_mode_transition_fn)(int);
 
+static struct quirk_entry quirk_amd_7k62 = {
+	.nominal_freq = 2600,
+	.lowest_freq = 550,
+};
+
+static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
+{
+	/**
+	 * match the broken bios for family 17h processor support CPPC V2
+	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
+	 * definition in ACPI tables
+	 */
+	if (boot_cpu_has(X86_FEATURE_ZEN2)) {
+		quirks = dmi->driver_data;
+		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
+		return 1;
+	}
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
@@ -600,13 +636,19 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
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
@@ -635,12 +677,18 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
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
@@ -1672,6 +1720,11 @@ static int __init amd_pstate_init(void)
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


