Return-Path: <linux-kernel+bounces-154649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A0E8ADF1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4A11C216EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D43C5A79B;
	Tue, 23 Apr 2024 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fkycmskF"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0EF59147;
	Tue, 23 Apr 2024 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859159; cv=fail; b=BTxjzltA6GuzVhbQXpbvWmwv84JJaMnDKJQPQd9ZFy4d+9LK0lPR+7V/kRrALFUarRIYm50DXh2B4OF1AtxoJgqtIFoJ5I3UQTO8Lx5AuSDK8Gg+Bg0tIc4bzdh8svpY3xn1fDil9Z0MvnZXbGsl6zDhjAi7ubvmLiWktLgb9rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859159; c=relaxed/simple;
	bh=S4gsus1AXJRFAgD2JZ2zQyEthUpzhSrTBjm9MkN9kWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzP9nDbl6vRQyrmekxFK6cB82//GYXV2Y1er5kYw4/w7MjlRBSoa9jWzt0r2mgn5bN3QXxdHbarsfqAqPVF4dI0SmNXLV+zh699K1r7ln2gYgwDQ8Y39qRTIGiwKnV2JuiUiZEJExPAc1NoBqnjfV1E4ZVSQuWAcfb+++mEiYnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fkycmskF; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwxPEGzhZgrWhUYZzMh9x/ZDkCqCoONbl2GGJxEGwvnNqEDO8XUDI72SbXKc16PJ/KOu1+QbAMtcqnxN2drYHojTArAyrgYZVxvtSaALhMkFZNblTxQBk3sxUiSBm5oguts4ftca+Azvx1GSTmZsSI9RgVic3xweTQ/3nwYaYsHw2M8xOWvyjZ5bS4q190Mr/20Pi0hUP46/HZ/a0CYjrrewCcoRBWBeTuW1mmMBqEvohhTqChberoehQkjCfqPpRSmg1IZO9HmxHHuvG+2qHEhNUfjMJTpwKThqQoTEEMBXRB2Tx82RQqTeukPxcHIMW2BLkuzfJNhTtD4Qu2iHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4t0t0fJjgDfNpBvcy1Ndw/c94RTZuz0xnRm36uFwBM=;
 b=fVTFegscXm6JftW4kMstMVICkI8MHF9vyJqWtoDC3r/tldCmjivr7rNoNRRGVPCkAYzbD7dBsjYCnqGxXZTStEgzTrChgdFc4nGppUCgc3ExetOms8Jkm7D66SzKL//f/kMlt5YbW7J5v/R4HdAvmT4cXVP0Fc1Izlp5RlwBrvJgpKSFfTB2F7ii2RzabRfzzW9ZmCAHmQNtpWEs9x7R7r3oO7874kD4DtUq/pUOuJnzp4vxvjvkqnwMBI5IutXnPc/6m6m+35AhQqK03fdtMYWt+z7VWBYFsIvXtcIxhb/Z++tqRj4M1pzWIb8W7urNup/yW9pkkkKfwILNz8qSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4t0t0fJjgDfNpBvcy1Ndw/c94RTZuz0xnRm36uFwBM=;
 b=fkycmskFdsSwwn3zBcYtX3By7F8cGxACJRAI8MQlg/q4YGxvp+ydqPEWt/ZS2MGRtSohDIplN7tKWYzrsnhR1mz/XB5e9NyWVBo9OiKw0L/QWcM4x1N1pokceZCNqMlkWBcprAPyiyIDYn2gegNqKHyV/30fJZv7fzac7xh8wc8=
Received: from CH2PR03CA0028.namprd03.prod.outlook.com (2603:10b6:610:59::38)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 07:59:12 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::55) by CH2PR03CA0028.outlook.office365.com
 (2603:10b6:610:59::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Tue, 23 Apr 2024 07:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 07:59:12 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 02:59:06 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 8/8] cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing
Date: Tue, 23 Apr 2024 15:58:24 +0800
Message-ID: <381226526d045eb70a0d7fddbaff06a5e0592bb0.1713858800.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713858800.git.perry.yuan@amd.com>
References: <cover.1713858800.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: ae941862-a31a-495f-7a38-08dc636b43a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400014|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3q5XP9ZHq1aSyMojBFWz7WLVqc6UblNf7EqOZPLMP/P1pmxo8auxUDOIQ9Ss?=
 =?us-ascii?Q?Mwibrm7v9lrXPZpUtl+ZtwwrSJCmu6jeGzFijBgDu6O1rpwSoP25Ir3Rzmcw?=
 =?us-ascii?Q?A3cbgrA6F2+hGse2t7fM1cJKx+ZW8A9BQJpCciAlTFSF3r0TRZWoir/tRyO5?=
 =?us-ascii?Q?mxsVc9+XN5n8eUwnb0QB9IyHCR8urv/kb1vXGQb4GcabAPCpYMf09UeqU6CP?=
 =?us-ascii?Q?78zoQ2rr33f0eRuTUpJ9zHe3V82uCXWanXmT+0rsg+xX7JQE0IhKbHQKuV0F?=
 =?us-ascii?Q?mVvnhEQbMvmdZM43ArPAeDWV/4JAOlcePLURMujYkRDRRW9iz6uW1MPjjBG5?=
 =?us-ascii?Q?T3G5yuJv+1ARjjvlkULfWNtfNr2oqIyGC2upwb/tawVH6DfyqG6BEhNER7XW?=
 =?us-ascii?Q?QhTmxbmhX2Qqgv0EabPc9S9brqieJbHabm4rux74g5/ZEkPUJZE/K0Bc2dM3?=
 =?us-ascii?Q?mp8IWag1sfwLDTb2ohg4WY+Agjm8hnlmE0N7jtmoDznokspNiF7NxU00Y12r?=
 =?us-ascii?Q?e4uoGSka+Ftlv2sNIlu6DG865SwyUQkfda146ZfhUnGc484dc4LR+clrqQTA?=
 =?us-ascii?Q?/UFNW12coq1RHm1ZjYG+PsukaUMp1ineDxFo6F7z0NWEsMAu81uvAHvNBnIu?=
 =?us-ascii?Q?BrCpkiAQyTbh0yhtUXCNsz0PKPOYnLeQB4gR5MegMIrH1HB5e7ALJFEWKIF5?=
 =?us-ascii?Q?FPReCnYtdkRvrYF34HEeNeT/DQpOJmuoNBWqD+BoXutxlc+0acH+i9IEHYWY?=
 =?us-ascii?Q?rYV40d+6LRYL5hKatuHnLRAepXkY7S5n8h2OfT71qZzntTHZvWoDq8ZcAMLU?=
 =?us-ascii?Q?BaSOaArrmZLzXU3BSI7glTQigRoIaBNmn0RDIJdDCGTZThKkkL3hYqiBXvNB?=
 =?us-ascii?Q?UYAu6c/l/wvU55feJxr0QREQ7Tx0ShJ6gHL6WNU1wUIgH8oDV10SRU+4Sl8E?=
 =?us-ascii?Q?yJzpJrsZhLMCqdNOARjd2OY528BU04uB7b8dT9gou1dSFN1Iy1mzm2BSDcQU?=
 =?us-ascii?Q?HqKRg4E2Pz1Ue4H6jdfL9W9qcfgHoZVjav4LGxXuadC3sVY9lSbBYQQfvQsq?=
 =?us-ascii?Q?tfx1FWWDHHDLqgVQmB7LH5VzWzbOdcy7IXyhXoU1OVdiThI/ANbjLULBfJKH?=
 =?us-ascii?Q?2uVMtrrgZSQaZ+i0rAs2cybMkvqObgqSfVvdyRxXgM/67cVXyrECdGKjUKKt?=
 =?us-ascii?Q?qnnSlggRWUuuie/+90yRfIkDmabPz0h/qLwM030Bzmg0DYo3LUceNinacRYJ?=
 =?us-ascii?Q?SWqvAh8rcJvz54TZc3FAa3eY7dHl+semdMnv4HWddH+w3+d/4LpMa0vRAGlq?=
 =?us-ascii?Q?vNDZnfz70ihNisg7SRAfB9KHmYs3ZiDvKiTkVZl5gIIW7nFuz2kbSVyQ3UIx?=
 =?us-ascii?Q?n6Yh7QwcZh+6oRuSEcV/N4JDNnts?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:59:12.6514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae941862-a31a-495f-7a38-08dc636b43a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062

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


