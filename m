Return-Path: <linux-kernel+bounces-158177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9A68B1C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09C53B24527
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082BC78281;
	Thu, 25 Apr 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e97G4rAE"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473558594A;
	Thu, 25 Apr 2024 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032529; cv=fail; b=OAdWr+j2fHom5d6NgbFUmrfImgxD+/cuU2agQFOy1QNfrMql/0ydjgwUC5cbFjPAtYNqmxSrSAIpbdvOpwgniqOx6ddlMgS9gsnqluyFPvGv5F9KkiwjAYbBuxc9JSW0HrChr7gdvTxuhTqVwDJAUrJfuFQYzza2+slEZp9Q4ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032529; c=relaxed/simple;
	bh=j1q+E9ZnXMZIXc7Rjt6nP1CRdVKAvNz289xKqrJcwlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIWrMZ2SXoZy+Y9iPd8/pGWPJXb+xJ4cat8FnH9lV74aLL6IPJZnR93SHuMvvdDOIoMNB9BCAV/AXyTVACtviUg8eflcElHXz1uSTL50EDSYweoQ4APVpHo7yzx7Ga6K8KZinbGy2SfZPhOgSkifDwWuND2sjYkD39OHMrMnbuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e97G4rAE; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktCCX3PDiTftR5apwmlsp9EgU6rvw/zUvzNMPDLQM6FmLLgyBfZ3LGJM5ZBnvNw5gGfNGX53WMCdiscb4IaHOJP6antHCgpJT7oZn+LbEc6B3SaOfLdzQcR+OIF6CfqUr/2W94Ru4jf1fKrQkadeNps3UeA3280CKD3Qd9HsY8VVCtVpDZcfr+EAFkWV6cSaUzR0ke08S8hcvZHMS5S/3aOCMpHsLZCyPOR5pabZlTrukAGT4oAHUWAxeLK2SBZMRrdwW37/wpD7/59mrCsAK22eIObSEEyk0FVHIQ3/BXD38+TK+/qc0w39tGnpM2W/xHAkGF0jzl2fYUyUVc5YOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhQBkfB3VaHGzUKuG77r2R9IZtcd5OBo3sxYU0IV5xg=;
 b=Ce5llNB6BcaoA1PtFeDjpBR/gfu9MIc18rPt0vx89QG+R+pO6SX1Q7+7pYnRN8/TaqS5Uq5dyjF4vipqVquwD8Vmcr+Yv7IxjXRz1Ic7K27bqQ1TkRtFebZ3dBz7epXsZ+r1DKMQtiQhZPlH+wkL35jgQxMzRwz2Pts7xeG1WuzffIdHlQhRZ6Lilijk2rYzCjpqrsV/W3Pdndg0qYoOAIf4onbyj+5W4Ksqpa9GhJ2RwrfSghzhs9sW1qGnLelgMS++1goZQR8JcmHsLu2hSOQOF25A8vG2uFyzE416wiCVQVnG1ep57X5nuccWZs/1cZ6QuUiw2A3Cm2lA8S1f+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhQBkfB3VaHGzUKuG77r2R9IZtcd5OBo3sxYU0IV5xg=;
 b=e97G4rAEv2i2X8NxPDY5YHtAQAGSwiJOQEiHkPsA4s2ZoS+qREszhtk8mDvy4fIGJNxK5HeVYn8fdedC+KW7GXh7PPULTGEUIW+6NqkjNAI7F5Ool5BbqXGRiKtm5utaJufytQfEhvCxahpr4XQExLyMqidMPrX4dPJP+AZxC84=
Received: from CH0PR13CA0051.namprd13.prod.outlook.com (2603:10b6:610:b2::26)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 08:08:44 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:b2:cafe::f0) by CH0PR13CA0051.outlook.office365.com
 (2603:10b6:610:b2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.10 via Frontend
 Transport; Thu, 25 Apr 2024 08:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 25 Apr 2024 08:08:44 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 03:08:40 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 8/8] cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing
Date: Thu, 25 Apr 2024 16:07:58 +0800
Message-ID: <f5af41e30f957a1a08d56f309da7d51ebe228576.1714032153.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714032153.git.perry.yuan@amd.com>
References: <cover.1714032153.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 59abe25e-e866-4f36-8c58-08dc64feed4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400014|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o8pcCFzltJh33gYqlzzPM8iMnTeLiBn/9bHOVRQAqZ17zxdHbz13fX/EuRFX?=
 =?us-ascii?Q?wzJEByzpLYuB5Nw2QfhtUMN3K83m92iu9bigjsc/Mt2E7eWlNyO53j8fi2CW?=
 =?us-ascii?Q?QVNE+igY2ckFZP7pCKvoo3CpzitQkXhbWtL0OJLymMzTW4FZH+E6kt5n3tTb?=
 =?us-ascii?Q?2xcGJ7RcT7EU3JLvwlMDVJAysDjyVFMkDOI9N8swon8aEb9pmF6VZxvYTuM3?=
 =?us-ascii?Q?BfWoawFWBr7gPZt/h/pwsn8mbeItL2WDJ2wrH5E/wb9h3VIpkFzLJVsX7iTg?=
 =?us-ascii?Q?tsbkx0zjkVXf/Qxt4ebI5AesMvUSAwCa3mUUV7QrCGbZu7YUP7YeHmb2PDSq?=
 =?us-ascii?Q?YRlwtgVVhY5VjtKkO7MSTqsR56yJC7+zYP0Y9Ts60b6PNz+JMr0eekl/JhIx?=
 =?us-ascii?Q?MpdbfDZbIH3HxHa3gVnu2vwaFpFPFJ1+upSCf/bEw8TATM7yxw+w1IrVjF2m?=
 =?us-ascii?Q?VEMRYJ7K91NHpsteRWUrOOfwTFcsjy8tNFL8emc7YLL6fL++0efZAvTfL0gp?=
 =?us-ascii?Q?QvDlLaa/Tgw7JYuYuaFBCmcqO8oPppXmJAPfgwohsSmI49OFy3avINwcYrSp?=
 =?us-ascii?Q?ykbvcBlZ4jALDwHf5EvhibMuinoGpdtvshEWqG9p/XdF/ktWdx5lszuizMa7?=
 =?us-ascii?Q?+1Kvz7ng52T1YRiSsPWOIU4jTpjm4u4R8fyPjeIV1+da8RMgbD2/72n75IsU?=
 =?us-ascii?Q?Kxx/8eQEvFjPrntMUXWcUm3zd4slgUFnE5TukhJFM9UG/d3YtiJC/1+ka2W2?=
 =?us-ascii?Q?tlP7PgysTbaHFCuH/8yRK54A2iStdO2hRx1IucVIFhwGigSHhPa4MrZzQEYO?=
 =?us-ascii?Q?Cw1w9gc87Z+tUxGi+dj/21o+54s8FBmmMHT2q/oSYa9SwfgmvPt2Ml9VPvle?=
 =?us-ascii?Q?G3h69hsKHRqWiwr+zlEKmP6TaX3NuAXIZp4+kaj5zHUNtdIqbBTVHYg2sQ4M?=
 =?us-ascii?Q?C0hWgXnXoJ8lvhX2njG1bzwl98XA1AjoPxRLtw1pCDmLjdFg6TmLWEMQWuth?=
 =?us-ascii?Q?I0WsddSRVChjn8GDJxMOuGfAy3Le0lsWJwWEZLeo/JA2MjjQaZAVtMoMEpg2?=
 =?us-ascii?Q?GNAx8vTuBs/faWsSRl9BX819CWflSWAw8V8XbZ5TMC6uvPJkImCE+AR6Fdz+?=
 =?us-ascii?Q?3owUXWjNqj/U8ACCHdJofl1wytW0z6VmOinUPLQ8aTb01XNZbMNiS24vMF5z?=
 =?us-ascii?Q?dmLSY8Apnz2vRjM50IjDjLsz1Ja9N9qd4CZBT4DWGBpy9smvZ0jNqxGENizZ?=
 =?us-ascii?Q?WVG5ablr8SdR3J8xmU1aOc6/NsR6yaUs3Rk+MfAkYyRJnVCf5Byvy5OMtv/U?=
 =?us-ascii?Q?lToCxNfdNLb42mPVlrrU/C8TmlaQnk73TQlhszzynlwRtJ31+wu+Hru18COT?=
 =?us-ascii?Q?rE7PxXgfhhfNLiHjX68I+IrHNF/Q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:08:44.4896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59abe25e-e866-4f36-8c58-08dc64feed4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871

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

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 53 ++++++++++++++++++++++++++++++++++--
 include/linux/amd-pstate.h   |  6 ++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 510b5aec42ea..83a29b257794 100644
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
-	nominal_freq = cppc_perf.nominal_freq;
+	if (quirks && quirks->lowest_freq)
+		min_freq = quirks->lowest_freq * 1000;
+	else
+		min_freq = cppc_perf.lowest_freq * 1000;
+
+	if (quirks && quirks->nominal_freq)
+		nominal_freq = quirks->nominal_freq ;
+	else
+		nominal_freq = cppc_perf.nominal_freq;
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
index ec0b0fa3e9bb..d58fc022ec46 100644
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


