Return-Path: <linux-kernel+bounces-49522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6003F846B67
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852291C26C62
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E34169D39;
	Fri,  2 Feb 2024 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0qNr3K8s"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1125657B1;
	Fri,  2 Feb 2024 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864217; cv=fail; b=i8ckWjG7SU68grzDMiKvunuzi60YRior8t5r4GI86KwtxigT/yhksAuFGEV2zMAjJ01Bx4ZZZUxMa2QKzzuhKmDvcO3uumeUTycC5ZCRd3z/xw08bFl3kwKIGmJiS0hwOhnp3S6Y1wz1HXhfs4+6aXQaTvfND8XfeANLkrlTHfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864217; c=relaxed/simple;
	bh=yOCCQCTpnvj3nuPvtfIDTm8RQEtbzParytfcTSnGX50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YycW68okn2kjJTLDs3FVQ61cbr8Kt6Tt+Y3aRx6q6jtzGwa5b8kK6BKszOOGi0LSrU2kvLhxYs1VSuEvuD0cH9ZGHQdrEqw+aUVvU4BR58dn6C4ebU+x6c+31x9q6KP9ld3PoAj7J10EdxNVMF3tTWiB//fOh4CYzs/HlTRCkjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0qNr3K8s; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQhxX6fE073OqirTWeLLcW52ZA3+2RQYKnfjc59vHxGoSW0oDozQwjenTtUaTEeb/HLi1//eMcdiu/KJe6lZ8qAg8vZgMyyXAW+GcP5C/C2y14ICcIf4q1/RTsVlhAfJ8AqVAiLOH+nejkHcml/hTRhapis+Ez4dy+F7wyUUvOe06gE9dRtiw38Ec+27KHT5RM89wAZuNHSiBVWcLS89zM5/VQ+cpM5Cjvb1xF+l61lRRqUmLq8z7nd1ZnFfFvDTM24/DiAoEnUuSlZc5TmyusIwafsGuD2MaOWt7SlyQ/LheJNtFdxRsMnUKgKlhRcCNXGslOk5XBzA8D2TUq2uyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVC3pcPs/FaQC/14DB2xXYtV3fcl6BaZNqt81QTVQw4=;
 b=lMs787alIZZqS4BNoqDZ+tdiF9sVMcfDSyPKBY3gC81nYHg1WvKTpESPEJEYIlurGZ1ZpRrNfWe05Sj5fgHX/LFIYQlie8yu40iLsH6Kuq3m7DqbIVKJwoXAq8yd/KrcNMzGD0EHdMiwt1AQjDctxhslxJSmtsBBAgktknl/qw5WQsh64HnuqwllS8gOtv7pRx426WwAYoBsEmk6WlDLNCPMffEW2PVi8351jUP1w73ViALbI51mprlR1yiQcshk1Y7a36up8s1vfpCncOf8bLO3tTWSZvvWsBcyFqyPBdbNtVxk/MzyP7s/1sev/9EcmRC/fHWYRs/V+t/93S8ryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVC3pcPs/FaQC/14DB2xXYtV3fcl6BaZNqt81QTVQw4=;
 b=0qNr3K8sGBwmc8lwp2X390Q6cwp0GyXn+eYCRcJKdQ/unk1BW0ph6ukbFpYMotwhw+w1gDTDNfTvSHBwNlL3cvuv6XvnaqEMrXFvNCkM4WOmj5JoiXlYPGqPjl/l3cEDEcghp8iEDOGtAZXrXkWCgY5k6CCGFAy3Ux6patKqChQ=
Received: from CYZPR05CA0001.namprd05.prod.outlook.com (2603:10b6:930:89::7)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Fri, 2 Feb
 2024 08:56:53 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:89:cafe::8d) by CYZPR05CA0001.outlook.office365.com
 (2603:10b6:930:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11 via Frontend
 Transport; Fri, 2 Feb 2024 08:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 08:56:53 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 2 Feb 2024 02:56:49 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC capabilities missing
Date: Fri, 2 Feb 2024 16:55:38 +0800
Message-ID: <8a55135d10cfc906616d3cd4530f9aac487c5034.1706863981.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706863981.git.perry.yuan@amd.com>
References: <cover.1706863981.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: eb53f080-838f-4a73-966b-08dc23cce6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fQv1Jme2ylK3lkuX8U4V7fZgftaSSmoGQIpa1NVTCz8Ay1xq7aB6/31zuTY+tTdDfh7wtvu94ciRSLbsKUQrOL7gYm/evJNLQoOLeU1JT/fq36JlZpBE5/rPn+N0OFkHNt7bjq7naaQtJm6G7iekMpiA6FU5iM/frfwJnhEmKA0P4sCFsZcjUs/I4gdYUkYPLY2Nm/7SjG8zVLX3O3XzfcX9EQNdVJY2GIPA5xaUqmOH8qcSKVNrEJLVZd6XWSvOVFpHaFCkuuSJzsQf68+41PDfVPworCnGvmp7oClLkIzdMxUK9mCmhpkbJfkzhyqYtXwD5zY3pLuJl3WgC1FQdnvUapowl5kCTRFZxA7FFKx2jySDfO2vERZDMWrr46Auqhif5FM4V3A2seWyXxPE4Uu8O32niv4vdw+yg/25sASDOG6hLda0ccNVP4+pYU0G74BvTuz6Aq3QXvNqDrnO/PHF+/PoFFnAGIAMS92hBtKCLiwL2Rqeekk+YshYHkA1gczDMoWt+TqaMv74Wxee63DRhiiRcOSWA4vhSyVX82yqUAFEe5sJL0bXCPyXKUh6ybH0zbhEcsIkaJ2ZrDxmgm5ZVZnFjWNIJC2Fl389bAP9q2i0QzUIzmJlbPQ3Vz3qzMUoBuUVGf8NvqIhj+Z3PBH7sHBwqv6yf9SH/MTfYmxmLYN91ShlnXhQbrU8fpOCcX4WYSwnbtXgBvyhqcj9kYXcJmQlfVjLEWi8HhaJxSbJd+xD03mVBNXOq9vaNCh/bBoMvh1qJYRS90u2JVDp1A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(8676002)(4326008)(8936002)(356005)(82740400003)(40460700003)(2906002)(40480700001)(47076005)(81166007)(478600001)(36860700001)(86362001)(44832011)(36756003)(6636002)(316002)(83380400001)(5660300002)(70206006)(110136005)(70586007)(54906003)(26005)(16526019)(2616005)(426003)(336012)(7696005)(41300700001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 08:56:53.0184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb53f080-838f-4a73-966b-08dc23cce6bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788

Add quirk table to get CPPC capabilities issue fixed by providing
correct perf or frequency values while driver loading.

If CPPC capabilities are not defined in the ACPI tables or wrongly
defined by platform firmware, it needs to use quick to get those
issues fixed with correct workaround values to make pstate driver
can be loaded even though there are CPPC capabilities errors.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 49 ++++++++++++++++++++++++++++++++++--
 include/linux/amd-pstate.h   |  6 +++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 77effc3caf6c..4d426516abb9 100644
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


