Return-Path: <linux-kernel+bounces-105915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB7287E654
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54E428278A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD4239AF0;
	Mon, 18 Mar 2024 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P194mdFU"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F2383A3;
	Mon, 18 Mar 2024 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755360; cv=fail; b=Kc6ZvtjYdR/S/Y19g1w2m5S7lfXbbO5wJVbVQu7O1lfKHAGAeJF2Q6+mEueU8DoDfvMXFm6wLTiUkzYrJwU60JqfRNcKutCFq6nYsE1Cw4Rlf55iEKoTJ/31Bz0oyo1lNREPQZMIT5xgH/E+pnw/D8nL+2NulbmGcg1OxlbqsCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755360; c=relaxed/simple;
	bh=CfC8Dtdej8Bs2obErQD2thPXyALKckCC+ZpjubXph5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mftpQCbx4dI1BycdejebCjYtkK3jEaVXycPeZAkpeJIj/MWkEWwJUiSCKJ21JcnANUZ6JsarwfJwQkj303K2XekSeQuiqrkGlDmcXuiwUqw+0XvBQo7pqZUhkgXUcS6veJSb66UvgucaR3/SVR+QrH6s2KxLixnKYYgyuVVRy90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P194mdFU; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3xbfMED2D3QOalQx6YzdwduoXcaLzocdTT7Q7TMSxBWMBeTT6Iqr5cMpOTqLQppiGTGWU+lY2rjZv840W+cn8dlm3i8AsOuBXZNnxJrH0RaRT8e/ZW2CbZtxuR8H47sNrBVJcciRHs/UJtUceSSCirqrOAZMPOh3U31YBiHySIwzgiFFEbR31H/J3tksWo/fcpt5jJqbP+0Ml4DxAyE/Uab4tUlv9rESQH7ncPY2RhR8baYDJ2sQSU/cuze54OGzbCAmxnUACINxZeRybvdeTEZa6qAYDvrcEt+BTk8s2ixKZg9X6SD8J3/iN4FzfH3dhr7s4jlSqT4tWkkzwLsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dq3+SeUoyG/XIVatEuBb4Cc9u8W4ZcJ68xS0opsXjc=;
 b=kvbL23WLeVZ1NgqTsCc4i4CtJZnLs/IWSlzYj2AA29/YzG+48KH9KEhMczU/O5bLJaPs+R+hpc8RUi/ju2BvbSy2j908wmXzQYzzkwChEbj9BjVjQ8xHeriz3himwOb1NEjp0acvUXQOCuuYVYUskpn0eum7fc8gapTFynd4SPiBAO9EJX8M28iL9N7eUBj1Y/oUGH7teCFkidmEQ4Lit1S/KZJzB8+skGHxaLS94iroZzJa8ofPthA2HU/VyDLr0PVIFV3j7IgtiOGr5hFo9neSpBU+ixPwP0wOj80OHrQ/FZ8OmU4MRQ1bnYvdqZd8GmgVcldedEkzMLLtmK5R/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dq3+SeUoyG/XIVatEuBb4Cc9u8W4ZcJ68xS0opsXjc=;
 b=P194mdFUZc8+xQIViHck7z8CP7Q5PhXOerWjG6u+sLGUcRMqIo9HHiqztXszN23PW3h69gUjy/Twb5vF8Jpb7bqhnVvRqveJF+DZA0RRFqnzRAwQoAheCrEBe/OnQmEjsjd8T2RsPn9nur8Og+x/sJ2dErHetNhfrTRhK/2deUs=
Received: from SN1PR12CA0070.namprd12.prod.outlook.com (2603:10b6:802:20::41)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Mon, 18 Mar
 2024 09:49:16 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::e9) by SN1PR12CA0070.outlook.office365.com
 (2603:10b6:802:20::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Mon, 18 Mar 2024 09:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 09:49:15 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 04:49:13 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 8/8] cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing
Date: Mon, 18 Mar 2024 17:48:27 +0800
Message-ID: <b8fc02f3c7ba4515bea4def3b006dab54ecc594d.1710754409.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710754409.git.perry.yuan@amd.com>
References: <cover.1710754409.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8e6009-2341-47de-40ac-08dc4730aca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G6YT1YglgkrqZ7KXhL8AvJCu1eGBi2/tyKiyVhKtNvmrZrMaIslAUC6nmPJGeB3KP38u2vcf4b4aT9MjzBTIsSVg7zv0vP/MB6h5s+E6e8PW8er1O1TzMOaM9CX16UXRou3I8CzB2whPlZlV+lcy11CLaic1iJYos7uUl3cFzGbIqk/KMnKlLghhgWzw4X6yQgyCeTPTz9S3WjZWhHYyzInqGlZhBzRDlxsaJ1iBIp2yoAVBIDnsGj+OVng0BYwsnDPXy9vOyMtXqOur9x4H9q2s81Wy19QZWeUAA8VLYNijKavJIxJbctlpz2ivLnE8CJ691ol6qxt3EIk/JsF969MsOnqU6SuTMG2W4BJUxB3sffuQEWegEnxOJikZnuC/eC19AqMOaHIYmvvFbnPNo9LJa2b6uwnl1ebXUBpJvydFTlqBmRcQTrX0d/71iHBuA/k8ser6Z7U5TnrlZP1lwcdIbQ7esXTUfoGe5OAvmpxEpOtF4xsM+I1Cd8fbLxSLHWkoVCa+Imne7rkdDxYSeW7JEtuN5Q8lpsgAMcQUvjwgjrsYLPTrXoD927UzBfObSL41u6sEazOADjHvq5i0O3e03vHyvR30y1gUvQ2nxlicMkgOfwYyg1yuJYB2eZccWfuuIJmtyhzNOM4ocAOjW5VFhg+nPzgoR1tqaC3HEn1EjIQNUF2Cu6UyR63dIhJmyZ52uMYTQdv/WnVsgRHowZrxFm1oxKzZqdN8EDeZ4VNnTLapzMimBBR/GXKoSjmj
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:49:15.9459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8e6009-2341-47de-40ac-08dc4730aca2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335

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


