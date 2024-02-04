Return-Path: <linux-kernel+bounces-51407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77582848AE1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D716B24342
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646D6FB9;
	Sun,  4 Feb 2024 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4AovvWeC"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2FC2C6;
	Sun,  4 Feb 2024 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707017213; cv=fail; b=SNJMN3GbCXbtBHayzZ9Zhg+EnHUOH5uJuGAyuaRb1QlszMgnaqPQR7JbVVnjAaBSAGFRCy7syPOkcVzQWofMdmCta7T7GsLDNjZidlTV+hb4ckDIpc8qoXXcd1VbI42RdRCVpzQ4XrGAwhcr+15Zw4TKJ8wnIX8F09U7fYRmIWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707017213; c=relaxed/simple;
	bh=8/d83vZJIwG/Ah6LN7jbthuRmrc27iCQ6JniGRvuUxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbvKwFl+187ryO5khPr8rVbH+8uYP4CAfuyWpkIKucv8OAuU/57IH6a9oOsfp7P25n90VMlHAB8AtJVZeyY17kdBdho6wq5o5I5khwVlRVpzjgaqBIwyCxI7ofhBaz3g93cbopyaPjjh50XP98WCQbS85+O0MODM7ONYyURb1U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4AovvWeC; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWSatlBmaruoYrvhTh2efS6Yr1XJzT4g7a5hxvxJ6C5q+N9GJYH0Fxg36g8inOq1aeAbAwp096r70gcm7mP3ELNmzfOiGiK5UxPsXPp0IIOPoaIS1Pa2+uxsIUUvzU/FhGPRiq5bTQR2KAVdyPVqBZ1A/POBTFUM+VfA8EHPTStfImGoMn16lhow35znhasZlMeXO9l3S/AhAnia1T2led558yJhRE8jGuJHpohXaWD1Ay0Je43q+VtYYRE/BssX4e4eRq3H+yzYlz3UMvrre2Sw/5V5vLfTe3jufTUCpXZ8dj86QX9XC7132hZvH44BYsSxD3iAX95fip/I1g6Jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgDQDXio06eWtxQcl9IaFkXxEu+LCwjgiq3JLWZJqZI=;
 b=O10HosJAUGGynDKwcMSMvVi962kSKurT3RNVzvjNzaCRq5IDpznnkvlBCKSDFUM7/rcLovns0XZj7UVRLL1jl3pYLnEwkuZrOmFOxPTZjwHZ6w1nGGxUfd72f4CxunfCti4Rf//0v1DV4WWaou+SFCoINM30YM+7xtVWR35/DQ+i3X7YViRY/W2UMqqOXXrqEK9Yok5ZNzA/jOzFW+uB7ky7Wo5n4JvDgUVac5CGP2JZxTmXnC162LK07lRNCKW3THBk13NZhx2N2JP042sSYu0bexgD77OAA+PrKWd4aTyEUpadb3rNyDzEmu1Emg2mjByMkdWRlllzxb2ZpovRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgDQDXio06eWtxQcl9IaFkXxEu+LCwjgiq3JLWZJqZI=;
 b=4AovvWeCt7SReHOTaymVqQceExrf6Eyd/PFxJ77gj6Tk6WR5kk7Z/IRxHLBvk+b+YZ2Z9UFsBypDVIIZpqSNT1HMFtkHPwDBIAsUAOXpEFgSu1iMWMawx5Ex5RXd+mWqH0204WadSO9yLAh5+MP8Zza3jSzQeKvRHVZrdJgHlb8=
Received: from CYZPR17CA0008.namprd17.prod.outlook.com (2603:10b6:930:8c::17)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Sun, 4 Feb
 2024 03:26:49 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::cf) by CYZPR17CA0008.outlook.office365.com
 (2603:10b6:930:8c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33 via Frontend
 Transport; Sun, 4 Feb 2024 03:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Sun, 4 Feb 2024 03:26:48 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 3 Feb 2024 21:26:45 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC capabilities missing
Date: Sun, 4 Feb 2024 11:26:14 +0800
Message-ID: <dc7fc753b596a4e262b21d2c2e8eec3570e4a97c.1707016927.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707016927.git.perry.yuan@amd.com>
References: <cover.1707016927.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 940d7caa-e9a4-4d7d-099e-08dc25311f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VLkEBqKHAby0NuvvnYPRylK92vLfo78uNDFIZMfB2kRpZowdSM+5SFiIC91H1VFEsq5VI9orxUp0ZM8nf57nAP2nrLppUGpvCOJ25miIbo7S8WnhhTOZmQsJp7ttYpVfBWrtGrO9PrTR9gKfCfZdSQEsDWGJem8ypqM2jgl3Xteyb1Cd5GTm4l9qITggQG9qgz5wdP+H7elAGAAcIR2JL1ABAWXYQ5LYTQ8CTGaaPARF/+XHY6cBX4Wq3tOsbWhkncu10WEcoXK1Q2cIJx+BrC2BePHGsCFVRyaDcCNu/W+bvNziTFof5OTjVOWIdDejisbmzR1Lh9BnAjtG9rkcRyO0ZVraEV32SbhXI/n3C/7YHV1m0cCo8LHNxVknFXsH7v0iKgJ0/PKQsyomXVBlqgq7EmM04vfWuRGEnkIgA/GarLfKEpS6BudgqZVwNr7y1F+QDY9sfFrqyQBdfnR5u+EU+P2RPxmLg6L750rwUfwh5x3SLTaf3URBRGoplaDhzUNO8n7kUet1aOZ7J4bJPYwwxMz+yzt8rS9Jk9fpTf1x7374utESRLX30X1ZRBTxFM+Z1ZLtIlTJMJzyU68iapiqjNkIOJwdQgT7t+9hJFnS91zFprvpuFKKLJEr4OoFMHSMpbXaxbxwUN+pnn4whqAVcpBEwjqI1Oddv2waD58d4QnCMJwJa6gIkXt1cSdaEAqSehqacYZVEPnURFT4wV6IIxbLEh7WhORM+/3FbtiCvIvjvAIcr3c6R5BwSpzvpYKvAV9qDEVp6h4J6npmow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(40470700004)(46966006)(47076005)(83380400001)(26005)(16526019)(2616005)(336012)(426003)(356005)(82740400003)(81166007)(8936002)(7696005)(4326008)(8676002)(110136005)(70586007)(70206006)(316002)(6636002)(5660300002)(2906002)(54906003)(36860700001)(44832011)(6666004)(478600001)(86362001)(36756003)(41300700001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 03:26:48.7376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 940d7caa-e9a4-4d7d-099e-08dc25311f4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379

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
 drivers/cpufreq/amd-pstate.c | 49 ++++++++++++++++++++++++++++++++++--
 include/linux/amd-pstate.h   |  6 +++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 77effc3caf6c..25a6d8a808c4 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
+static struct quirk_entry *quirks;
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -111,6 +112,33 @@ static unsigned int epp_values[] = {
 
 typedef int (*cppc_mode_transition_fn)(int);
 
+static struct quirk_entry quirk_amd_7k62 = {
+	.nominal_freq = 2600,
+	.lowest_freq = 550,
+};
+
+static int __init dmi_matched(const struct dmi_system_id *dmi)
+{
+	quirks = dmi->driver_data;
+	pr_info("hardware type %s found\n", dmi->ident);
+
+	return 1;
+}
+
+static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
+	{
+		.callback = dmi_matched,
+		.ident = "AMD EPYC 7K62",
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VERSION, "5.14"),
+			DMI_MATCH(DMI_BIOS_RELEASE, "12/12/2019");
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
@@ -600,13 +628,19 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
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
@@ -635,12 +669,18 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
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
@@ -1672,6 +1712,11 @@ static int __init amd_pstate_init(void)
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


