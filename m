Return-Path: <linux-kernel+bounces-57448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 840D984D928
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7AEF1C23522
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133F72D05C;
	Thu,  8 Feb 2024 03:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LUJdy2cX"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39F6364A4;
	Thu,  8 Feb 2024 03:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364275; cv=fail; b=u475fyubKA6rmWnCsiP1lGUw9Owl5IJjJpCJ/jRaHDK0WQD4XL4uGniKE5b5b0XP6ZX7XbyAJfCAb/mfI1S6DXe8orOfL9TfR+1JQ9qvebwzS074eSABV5hNwG+XmySkldLaDc+07njQKK3fOeYbe/rOpG2NU4zloua5fYkJKIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364275; c=relaxed/simple;
	bh=uYcidaZwlhpfpt+VPwP8uLNXVvV2easWUfety5JN3zg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLa0jc40wO08LRWmKfTX3NbNO1km8uWFs2+jJjFC6pNJ1mP6CpSutJDZKCVL60Ht1xHIdV+x1cf0Gys0X+JMiOMTxzfq2VAp5cun6pXGqu2VSYK+Ptrq1Lu/Ve5/j0BCv5qkN/XdnfzJ0LJXEgAm9S3/WrV/CXiBHkxR+9lfQq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LUJdy2cX; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxMt3K9a8YTr9OKmZxlM9wCaqc3k5WhzXCdRp0m/zvhO0WSgXL5jnKJOElG06IFeifkQN830AWKcm8L0/+1jA9qMxW0uWHeFvbipvV0Z4/y97NMwGK4XLLkJIikfoGpl+BBjyBEexZd4jFM8guPGNU53vLAlZBpYIWG9GxnKdFsB4F4vE9gf72I9vz2LblhsYtt48GNmk2nWQa7huEA4ve6+1IXepipYX+8CoiYXsNz4p+2n+cIDsfvgYBf82VoJ68NGjgpw7EDaVN6cH8g9A5Fwpa6BYKdiFXquTb/com5xg26/y8k2QfquXM6r9nMKY/oHJm+pi6iqt+zHXwzGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkRyzhP/dfcD3tJL1q+M3Vm/W1hdF1WrwmmigPS8C5Y=;
 b=T73NJWkQmc3I5BVJ/Q+yREHZdODbWAKTdQDyjHHug4eJMhr1s0JNZy0JAvIAjzKXKTp6yFzzYVPFSL5Kj29r9xt1vWeuATvepAcnZgmS+qwPhV0BF0uxSeTiuysT8hzlbE/GnG8uNLbmZkcZ8L41IJAicLaOqXL7O4hgxEEcJ1oe1wf7mKaPCWUlT/FFPSezY50ZC5X6vGfFfh1PYVOMTup0qHri6JHK+bQPOPo2UZ8mKLW9LidMRglF4dc+0BvvfqnVPxZCBr/lVnJjX5aTzi0yNKtJY+L1f9Acd+0IM+gxNYapQUPva/4+D+ceeRjW2BxPMbmtXNkhxbf9pxyZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkRyzhP/dfcD3tJL1q+M3Vm/W1hdF1WrwmmigPS8C5Y=;
 b=LUJdy2cX+4g5AYN2d1q3jVaTot7zw2bk56vvUGPcC3usr4n4vFxbhWCejFEaCdl6eaYMNoM2r41y2W4w7fBtYmIOyTcOeu94KcxLQtzMf9DrNHC0s3kHJAvOArCVBmsZAvTEh0tQPMRi1JWljvdItvY3AnYLwMfoXFoqvd8CTfI=
Received: from BL0PR01CA0027.prod.exchangelabs.com (2603:10b6:208:71::40) by
 PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 03:51:08 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::8) by BL0PR01CA0027.outlook.office365.com
 (2603:10b6:208:71::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Thu, 8 Feb 2024 03:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 03:51:08 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 21:51:05 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC capabilities missing
Date: Thu, 8 Feb 2024 11:46:33 +0800
Message-ID: <f091a19752e21545dabecefb3037b244b344e000.1707363758.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707363758.git.perry.yuan@amd.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 51175bc2-1a45-4096-fd18-08dc28592eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gp+nmYTNTwa8t9JzCJCEYTl68lmXhgR3favNhYO3yb1UukSYvuepiMmRrCYGL6WrIsCrLocHeF9RNjHy5KGJF3pOIdJH35/WbgAWq1aHHXu0FDxGmGMOL9GonXlFFrLPw4HJsNuDd6imV0NuqKgORs8Bg4WozvDA1oCOjiv+v2pVX0eoJOolVyfl64bUgn1eH3K9jsJCv0o0nWYTKALaWAOsDgUJ0Y4GmtF/BM9vWwmlCKtLv0B5fA4Hu87c+SvpT90mKDkpgGe0KhMT+CmchTb2LNDptEXFelIXTVW91vhmZ1TuK9j50aLMAW5w5EDBlIoMJNLRX5H4fURZbXUJ7MmDlGK+QQ5FC+IGIiRLT9H7VMWJAHHL7H5Jk/Us9vZT10uj6SYoR3adqawG9BwoU0i8Rxu+t6mTW5CAUf0804nhs7wvwNSoAs5IdsSlcQBEVsjaM05Ob/Ax2CjeyHpjisPsa5Un06i3BSI17pBmoDBn1k68mbdoGX6qFeKjy97UCKWJDvGRMl0Todo6ypIWFE//CBqm9rSzXeEMnC1+EnXRqmzDCcbf5q7wR6/GotqXrHX8cD1Sd0yY033kMq8fpC5NXkcoyBM2WzOTYI751ug=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(70206006)(41300700001)(2616005)(7696005)(4326008)(16526019)(316002)(81166007)(83380400001)(26005)(8676002)(8936002)(110136005)(6636002)(426003)(336012)(54906003)(6666004)(478600001)(36756003)(356005)(70586007)(82740400003)(5660300002)(86362001)(2906002)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 03:51:08.3913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51175bc2-1a45-4096-fd18-08dc28592eee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814

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

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
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


