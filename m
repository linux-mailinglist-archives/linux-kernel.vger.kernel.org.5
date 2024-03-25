Return-Path: <linux-kernel+bounces-116448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A61889F05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C829289BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0BA5A0FC;
	Mon, 25 Mar 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ossEOfsx"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED9268034;
	Mon, 25 Mar 2024 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335878; cv=fail; b=Y3KuHERX0LfOkTbCmVW8sH7X5gAbc0bGtkY+o6KJsaTgMJhgrSfNlbUKZKqVg1zbK775KUWKoe9m5H0o2gmzV6dxWRkZNYnm6Sgzs13MWOFQSJ9DUs2U7CaR3j6LryL7hQHkTXli1rcxy/y2O5iCDMqJf3FeBg/0LG8dwtOJ2co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335878; c=relaxed/simple;
	bh=/ORMEDvJlElLdwB05bjjkZ49ZILNK/sXF+PMdCPic2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2EY49tdg587gOFpDK60YAnGVppEUqSBbss7cGRQ4HAtsLd1MWv2Gs36oEoX9jFIZ1KsLF57iMb3xmDc8NwjYIr1rNczSkdMw8jOw3p+lXVXPh41bI3TgU/6B7CiL6KTSEu+wu5O6a37CYpJL0/dpKOZVUkmsY947bTUoOSgpUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ossEOfsx; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxN0QtOEEVcAAHG4Dtgaa8B6vFfZOpM0RsrcZnOK3hAbaR4ZefwowPtxg4wNhKttHVu3Db5621gavaFntj9zHV8kmMNIdrBTgZf2fvqtmp4a0W5vFHCd1OdgOdUkTpffSGgijUEkyWBvU1nJ2utWDjT7BLg5DFX3X2YJli4ISy2PdWVqq0vOS47hOp7nTRY3VwbqSk2BUr2ZjGwoDjvTFDzTiSfaX7lTPhxfLvcRcJZjvV+DI8l+tkh56RKSsgHbyzfCvX2pg6Ndsjty5jVE5r2aYga180VSHubpSnsRW52gNLzv2eL8y99/4aCGMwBlFsbiwseeH8YhWBoIC0dBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJa5bG1XvdZh5o3Op4pc5qeNVIcfvEHxqfawH8yvlgk=;
 b=NYNGr4UWvWuRzfx0EZO57FANYA1PltM2ulikWkpwKs7GGUgjr/Znn+YaWeXO1asECqvqCr3fru4u4++WVOS0GrsdxVpyq+uGUBIV+IIXQnWNS5znlu/96ZUy+AIq1sQO/2+b94QCOcx8AF9hMgFkTg1AOI0A5LZlKhlCcR7jNQ2IYE+o4GIuNZINTmEn+v1fWFfeltg7SP36f8AML/Zrb1HrkJn/Th9wfMoF51yHMAD5VtthA/lyXcmmWFoSR1GowxlKbPlzrepb+ow7XTQ1FmXbTOazTpEjvLzUltbKospLyiN7YfXw3xAXn58LPy8c2X61D5B3WlmYMzAr+sudLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJa5bG1XvdZh5o3Op4pc5qeNVIcfvEHxqfawH8yvlgk=;
 b=ossEOfsxROwf6o+0iMhp8lvzC3+db0CNBY53ggRlGgbSL4GKLEjwHA3PSsDPfvRXtZg4zmBYuqxRVrwpIrfftm1yrzdW9ou4s5/AnZnIfw+Jy1q1Zefe66U0QVH/0mQYzcPvypKGG17N8t5EjvvSujPNn1gBrPC7W1Qzt6E/uyc=
Received: from DM6PR08CA0062.namprd08.prod.outlook.com (2603:10b6:5:1e0::36)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 03:04:32 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::99) by DM6PR08CA0062.outlook.office365.com
 (2603:10b6:5:1e0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 03:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 03:04:31 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 22:04:28 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 8/8] cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing
Date: Mon, 25 Mar 2024 11:03:28 +0800
Message-ID: <31afd5ae23f8b1d7c6a2f0efe593a368dee61224.1711335714.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711335714.git.perry.yuan@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: c72a93e9-aa4b-4e48-f57e-08dc4c784b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fyviQYKepQ+Q/w5GRI4RABCs11GBVLLOl8hwKptTG/Ve6NSpY4+f3Fx29I5GX3AOaL0PYNUtjKC5oF7xA1+Z5mDFA/suP6dhHADmovUsTHnq4DqwzK8uGxB7VbZsFjmxp529MsQbYc5Moc7cw+MFRmekMrnGYMYkZr4kKiq1kkkfjX2ZdCPVp3AEvpB+tnrKt2NBUHkww2ELTV58lOtDzlUbQo/LaUN3lCLyyTURJT50YK/4MWp58uLLvybhADBseZx4mNQVrBp7enkbvrqAtFPqzarBz54WkDN1yN0HPxfeBopalE8bVijFbv1iFsYBPEtIPtfhyDhgGhNkN2SwOzXtrBhQPEoGR66oW7bjqUPe0rWSh6kzetbZgt9Wu4p84/FSAdjHnPe1xSryr9TOBr99lYSS/D3hBMn4S10I1jgdPVT8Vur5P/MVeQvj6SO1mL7psyL8Qe63YHFEQL0o9jDRR2WVvgx/CP4oq/XLBNSBdv8vN6wDqifzVJAxgPlp0+gnHaqSRqdxLJHwJcd0UEi/INgJv/rQLXTnhTZXTNsTHlzvGIcgrAFsuXLiiZf4IoUmr4pqQ4ixHXa7zFu6Op4/RaawMAanMejpa+7evS0b/2GA4TXlQZGum25oVIh0Axutu2jBHhJA149ELpgcJ2CVeNjlIssywQo2slaBH4O9a9JlunDkQnaBWF3v5oGEsfhHQxbyQGTx7s9VZoW5QKL4ajFveCXeJyWr8tkkL/+n5YnKTyLD5ZsSYinDRBUZ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 03:04:31.7444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72a93e9-aa4b-4e48-f57e-08dc4c784b0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585

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
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
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


