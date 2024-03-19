Return-Path: <linux-kernel+bounces-107245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6919287F9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FDF1F22082
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12F77E792;
	Tue, 19 Mar 2024 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YwBElpk3"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437347C0A7;
	Tue, 19 Mar 2024 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836976; cv=fail; b=Q8JUY2Ixwm1HBVHba1CKAzYtWF1VwJnBlWro/WLf98H+0v3F2t7jjKuI51JgtEiN4watiMHMvk3MwFpU4uBmLkmve3y8EiD9LjT7KAxqgB6CCMp44NLy7M1AdLQYsG2Vh0bmRt8/OU2wZxf6LWuAH/VsfGDcqb7wc85oA5ReRck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836976; c=relaxed/simple;
	bh=CfC8Dtdej8Bs2obErQD2thPXyALKckCC+ZpjubXph5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyEXLHsW/2CA+5Pjxdg147YKkB+C6ygcc99d7WqVJCSjmbFKiDW4K56t6soWiILYYLd17JbaEgZMgQD1baz+pGYb6q1ItQ0jYko76Nnv+pl724FV8e2R9kh8++YGGM1OAjZD013oIyGznB05eNO9HbAyzkkMXIiwSeoHLbQAzGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YwBElpk3; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMkvTB8pfeajKPkYIH2Mmg+is9vKkd6fuYIgl4za4i8NyPC4+3Xn/1JjF3YvkMDVKLwOeQAN/lenvRaZEOGcWgj5aMULrVQ/g8rSturnfssIzJ7S2ckbpFAwCxz+nZerg/vPzYxAn0pR3MYg/4gpXmt1lGKs1Du/h2Y5Me06iNJOoT4StFin2tRmBU94V89eoA68aajWl6PuQsOa5WgXSw0EzbQoeEMoqqIZpDgd4Lnb5IGXSpIk5WMcvf1u72jCB75rRp46HzrIA099uHsiGPXvqSqcLcEw62afrjM5hMiBoHofNLyACdl8dVCg1pYi7Qu21Wa45NJjoD3W1RAOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dq3+SeUoyG/XIVatEuBb4Cc9u8W4ZcJ68xS0opsXjc=;
 b=iZarxQj+YXTHb9KyAAGr+RIFvkVxNQ+AseK6yIquShjEWL3Rx46LwHmSlWNOB+lDpi92afQnlBZxNDq3S4Ou1ZxruYWAjQDhQu6jaTBA6PjSzzhj+uKL6BcQhutmPZ9RzgWDaS7Vv5BCp2zoFkHSZutdcW+ELmAC7FdLAIXm2NTZX05ceUt7oKnH3nB0TsRPPY1eb5vTlM2e/FBKghwSrUCkpTjh6bLKb33VNMCf6BvBAylvDusyKb7D3Fm7c/7YlBFueey0J1G36WDl1NCF500xpJB5wE/3CIz2gQ0wirx8ntkf7ae4Ls4PTryvEeu/KWV/Ct+o/mVsUvNZRLB8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dq3+SeUoyG/XIVatEuBb4Cc9u8W4ZcJ68xS0opsXjc=;
 b=YwBElpk3KTJMI7htSF4hHgneSttrPglxJ8lH4FcVQgQbX3TtYQYUfHGo/M+y/0mKGfH9L6B8npdzDshtFiN3UYahmtVk5OUfmaYf+FDj8kepBwtQfPctaI7K105CVf+7WIhSzdtZjlSY2NcSJeSsUu4BDSzry67tIpvxqmAUSCk=
Received: from SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 08:29:31 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::f5) by SJ0PR05CA0007.outlook.office365.com
 (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Tue, 19 Mar 2024 08:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:29:31 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 03:29:27 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 8/8] cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing
Date: Tue, 19 Mar 2024 16:28:43 +0800
Message-ID: <a2966f070294a58bfd318a6fac16423071bdba83.1710836407.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710836407.git.perry.yuan@amd.com>
References: <cover.1710836407.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b7807d-9969-4cd3-10e9-08dc47eeb36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aqxf70//zge2nSEJRuf8J6ZgT15FaYUC9uNZopv/8cDxC1jl3nG8i0UqoWan3rLrTpTg35v2jhAwdc+E/u3x8bWxbBJiKXjBsBQoEkuxssLgk0G8Dzy7bRfFZT5myBi5Op74vVEjJLCdFU4WMbPpEj1MalQIUprTbOjyYqofqysHzKE67YQsi6JcwKKIs86m5/+anL+R/UkvyTyO7Ki/GMFUhal4H7kDIXT8NBxFOpvxCY7WjFYLbk7Pb8wm9x6ej69TTbs0l0Qb8q5ibujzoFW61LoAD+IuePsdjd8n7UNSs6O3BMr+BonKiJLKG1dSrwkCJ3DqYtQCJOkEdO6e/cK5QssnkeoT9XuBsS487uhQd6o0PYam2hKQOIfAxtmSkez4DvJMjbOW+aLosdgsC1cwGDYnYt2y7ruzpQXzOFATuRa5dE588+vbqpHKEOXcTghlta28uvw4b7GFFH5awAFN/fPxODZyQLLmNXqLNuz0OgoWgIRdR0ZmuWnuMa1rZXyXk+P2Zc05J3yjqrRRmR54TsYrPeYtEWvrmfO9LELUmmRWE59zaYKuxPKe6axQbbJ7Z1mfB0P8vHRbXtBg46Pv4FhrYvzOlUjaOt9tk697jz/UPOveym8/OOADvGNxEOsKK3bycy6uvumi21QmjAS8O01fZGgLn0gbzd3E3z+DdTeV75RhyIFDAvlYSpVGsLXJInGdrMM1BM7G2iJfq95QB3bDjwdSUlCrHyIiD5RFXzznQHDWlckVU7rUh7AK
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:29:31.6706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b7807d-9969-4cd3-10e9-08dc47eeb36f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896

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
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 53 ++++++++++++++++++++++++++++++++++--
 include/linux/amd-pstate.h   |  6 ++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ec049b62b366..59a2db225d98 100644
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
@@ -812,8 +848,16 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	min_freq = cppc_perf.lowest_freq * 1000;
-	nominal_freq = cppc_perf.nominal_freq * 1000;
+	if (quirks && quirks->lowest_freq)
+		min_freq = quirks->lowest_freq * 1000;
+	else
+		min_freq = cppc_perf.lowest_freq * 1000;
+
+	if (quirks && quirks->nominal_freq)
+		nominal_freq = quirks->nominal_freq * 1000;
+	else
+		nominal_freq = cppc_perf.nominal_freq * 1000;
+
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
 	highest_perf = READ_ONCE(cpudata->highest_perf);
@@ -1662,6 +1706,11 @@ static int __init amd_pstate_init(void)
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
index ab7e82533718..6b832153a126 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -128,4 +128,10 @@ static const char * const amd_pstate_mode_string[] = {
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


