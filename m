Return-Path: <linux-kernel+bounces-46066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69B38439F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7A028D0B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F3D657B8;
	Wed, 31 Jan 2024 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jSORXZlm"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59EB7868C;
	Wed, 31 Jan 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691081; cv=fail; b=Q3Y23buzLN/oT75GYOYwxmQqw6uGvlLhj07Wrzn0hQWTfHRwTB+BRROgz6rqjxhDKvRuWU28RLm7ggn4b8IVv9XtYyx7qnZ653VOhmZ0w7o33QcKt/fXIDrIyhVvcCPfRbPtl2YM5qABd7hxeNB6xkdSgieCwquof3QrViCMfHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691081; c=relaxed/simple;
	bh=ohKKIA4xtcilWBTsPJMITM81BtsZ+V41NnNOonRD80k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaiINkBalu2uD7bRcYkHIKQRQOXG8iOGUCPhwe9+ePyiolaiXdj8C/vSPHlgg5Fh3LhqTNm6RpBuFf3LYlGPZV251Osg4VUh+ORD+7RIOsIKBp3V5vtQBOR57HJzPR5XqtSXuE7AASkRFEPLtR87Zb94+kxiplENE13z/irJo5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jSORXZlm; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMOYUpc19zd0TIDq8AEC/B8K7OFUEXJakORrSM7QW0CZvuW/8AtOYsmd6q5RSLZ3MGh3QojGeeJf+p1cp2xvOmabswEy6I54is3jb2HDZnMDYWWAY1bL1h9NmzSNNFed1gh17vsNJ2VpFow3pXTErXRd+QFoaDrXhXGvXGgw1uy/QLtD3RIABIEF3rk9VBfk/2G6+3YMmmZzjaevFh3Rk1qWwhPXEv8w6CtfZfDCVRT1oJ6C+mnftlFXpMmo17Voh/FqZb1mxMRvXo5+P48qqAv2j9zYYY6wwlc1xNZoFQc2kKbbVCD2dPS4kauA36/5TdLiVcHoKve540cn+Yw7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5umN6pS5J9c+mdomfGoF7jCaiSjpCXfrxOMypz1Laqk=;
 b=brRA8qawXh6pf7wgCb3pH3snK2ZYoStxnMgrtQ8GSMCZsIxsgxVuVpMasECfBDV6cLt9gvzacAC+ZjiKSiaImW3RfsbHlnl7oYo4Jchj+mPfMLje06gSaEOH6WJwiLha63USgEPZkSjeEjiUwT2fnW+evwen65jtx0o96ll/KNg2J/QMzcVb6R7aaLtUXDVIM+WhtSMjaJsXKnciElPdt3q082K0fhf4h4gGH7c3dToES9SIqJ7+KEju4vdj/ob6OBTLOmVIONNWfctxOTPxkvWgQxkKREER1EHJUWHUN4HfmuciumVX2zdj6ogAc3ABNogdGHSHQEKseNA80N1U8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5umN6pS5J9c+mdomfGoF7jCaiSjpCXfrxOMypz1Laqk=;
 b=jSORXZlmYlLubIt+Tih3vyd0ZH07RCCf52jXEE5J1/2RtZkuige/k5nxNkAKcmFoTHXVFNm4t5srNBaHp6+qMGAB5yhY2ogIyYdRgoZJtMI1KhiOOVNQDC7JXz3gkuu3wnadDO0SGEj1JqCYa2irW1aUk4MJbJFLSSrlh6E11A0=
Received: from CY8P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:46::28)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 08:51:17 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:46:cafe::b7) by CY8P220CA0011.outlook.office365.com
 (2603:10b6:930:46::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 08:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:51:17 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 31 Jan 2024 02:51:13 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC capabilities missing
Date: Wed, 31 Jan 2024 16:50:21 +0800
Message-ID: <ab45b5a29507460a63d772a0e4b24b83c9b61aa6.1706690577.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706690577.git.perry.yuan@amd.com>
References: <cover.1706690577.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|BL1PR12MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a7d7c0-b568-43c2-b3d7-08dc2239c9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IZaqXeeXPS1YCvPgMrjMvoX4xSo+JvM4B8yObD++nb0qJXsA6xiWrCAe0p4BlKER65Pm7Ubzmrp5yNCSRotmgGDartRrl9jp9DyOuxQB5KUbbMzMp7SHhCqOFhfPmoJFpq/hvj9Ed3K3GoThE1oJU+bS3PQFF6SOdseHHFbMfXpDudaqOY4szadEHrnDcjUz1vu5Td+LMEFUbpXCGaAtXtGA/rfHVMpVL0lEWGHHRVJ/BujUgp4Mn6BbkPCjX7hduNy2nZwPFC0p7BLVXgeZiqlzRMykrI/xIKvCAqT6iz4LZ702ajUuOktGGJzlcCXY+uaI/GeyrtFL56r4mQIZfRvIFxoH8tPtAOddGam1w9a6FmBjkc7xAPG0zzzTDAPQ/wHTzU4Yr5hsuhVApmTvPV7bsgI/qpwpUUg6JS3GWD2ie2T2MCzC2slhXLLpPoBFNBfIcxWIs2xr9bh10RnKsn09ChzOrEz5pol8GmwQJa9r7cavsVqnmbUE46BfNAhzhDd96JJa/kbM3pqgLq1mRRLn/v1KNLIB1gDiAjtNHesjFfgPH0Bb5M0Yar3xq14QFuE7D+Kw10opWEbqjI0ciMhtyg17VJ6vQvt9SlI/r8cB+5rRxnD6E1bVoLEZjGRjqP6idN3qLDauCw0zy1gU76EdmKXw6epNclL1QPXodN8kz5O+Q+80dsi5M1W78a6WLk5pQ21OSndWfUDdrxwG+3pyYcOsSWJX1rF8SaQ1Hw4IOU4vYHEFfpmHOOu99n5WnDMVJUsHrEoRqTZqaK7XcQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(426003)(16526019)(336012)(26005)(2616005)(41300700001)(40460700003)(40480700001)(36860700001)(316002)(6636002)(36756003)(7696005)(478600001)(83380400001)(6666004)(82740400003)(356005)(47076005)(81166007)(54906003)(5660300002)(110136005)(86362001)(70586007)(70206006)(44832011)(4326008)(8676002)(8936002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:51:17.1111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a7d7c0-b568-43c2-b3d7-08dc2239c9b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255

Add quirk table to get CPPC capabilities issue fixed by providing
correct perf or frequency values while driver loading.

If CPPC capabilities are not defined in the ACPI tables or wrongly
defined by platform firmware, it needs to use quick to get those
issues fixed with correct workaround values to make pstate driver
can be loaded even though there are CPPC capabilities errors.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 51 +++++++++++++++++++++++++++++++-----
 include/linux/amd-pstate.h   |  6 +++++
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index eea2e192d748..cbc415af0f08 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -64,6 +64,7 @@ static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
+static struct quirk_entry *quirks;
 
 /**
  * struct global_params - Global parameters, mostly tunable via sysfs.
@@ -121,6 +122,32 @@ static unsigned int epp_values[] = {
 
 typedef int (*cppc_mode_transition_fn)(int);
 
+static struct quirk_entry quirk_amd_7k62 = {
+	.nominal_freq = 2600,
+	.lowest_freq = 550,
+};
+
+static int __init dmi_matched(const struct dmi_system_id *dmi)
+{
+	quirks = dmi->driver_data;
+
+	return 1;
+}
+
+static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
+	{
+		.callback = dmi_matched,
+		.ident = "AMD EPYC 7K62",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_VERSION, "C1"),
+			DMI_MATCH(DMI_PRODUCT_SERIAL, "FX19911000028"),
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
@@ -581,13 +608,19 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
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
@@ -619,13 +652,14 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
 
 static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
 {
-	struct cppc_perf_caps cppc_perf;
+	u32 nominal_freq;
 
-	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
-	if (ret)
-		return ret;
+	if (quirks && quirks->nominal_freq)
+		nominal_freq = quirks->nominal_freq;
+	else
+		nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
-	return cppc_perf.nominal_freq;
+	return nominal_freq;
 }
 
 static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
@@ -1623,6 +1657,11 @@ static int __init amd_pstate_init(void)
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
index 446394f84606..ea80f961607d 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -110,4 +110,10 @@ static const char * const amd_pstate_mode_string[] = {
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


