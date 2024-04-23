Return-Path: <linux-kernel+bounces-154708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A848ADFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9493728324E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D6658105;
	Tue, 23 Apr 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wLuQ+u/7"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB74206B;
	Tue, 23 Apr 2024 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861690; cv=fail; b=p9ar2hGEacBZ6pWRBytCNu2vUNLV1op2wDUnn2KBirqiVqZi8cMqh7VbljsrlgO+JmOf6bfWJtV7os7UHae2tdqQVwad/nBdmUZVSnOCuylFjW5aKmiQ7JyNKR18iI6KisSD0ytqqCJThRhbXTuluZ9+BMdSE/nDKbWmZ7FgMIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861690; c=relaxed/simple;
	bh=p5eHppetK2EKwGHrcAV63rC8nmLrf7pIZQiUWTMRW7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Plj78MkDBD/hvopUNXL9CGBEivOwep5VnnMHeyUfZ9rkWsVaBevIZNRKBmaMi3iEchMupchqs6T5nQUNffJT9anV0gvR4nPv6+Goum2jZPaD/Fzb9FOkdETHKx4Vk6Zlgh1Yz+4sK4H1oeIZzwYCbPpveRohJ0iLyyK/GL6O3Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wLuQ+u/7; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGEePpyTT7cX+YeQG1xZVeNjDpF365POo//QgLQQ3hpaRopAz5YhJoUsSa9sR4RwlUObjmvTaDXiqnC/mkaw/dP+jBZu26Q76945+tlzlF1p1tS8emzHjhChluB5vq4QY7E0bmNdtECKZDtb9/CtEfjUlXHW2NpYB50H5qQ4ZBOZ64fL9nObsAfarHaIbXGJmZLdliTfc0Z4pblEmUOzQlsaYNmKtW+rrq01w9moI9qiupbEXTxJYNjq4mYnYde+tcZCLCcT8GxQwODr9YGqAO60cmIUuq1HsS2MB86mbeVFMsFRc8ObpY2J912wGs419a3W/Y5HBir2HZmfEgJR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/GYXRcJuGbvGSU+cqtUtpParHVWRRBgh1rA2z2WJfY=;
 b=fMxzZ+/eU9xJlwRITo8ikbsHaigmStw0JQKtMWebKWIZcb09ip3NNbULix2fnjzQhrh/MSHrf/QnpFnMeB+23DMHPnDbTgiRMccUPjYTPP4nvQQ+oFNS62DOxaZ1GeVS5c2XJRqITCQPfYYCO1qyQqxvVNfVMP4c0TWbGZBE+boQ2R0uoXnFGMnGc/Q9BO6u2elIHQ1FsFM5+5mU7LFt78FC0MNUDNJoNa/5g77vz4lMcGCieMxqjR9lQoESwANXOQgALfi3ET0u3b4GGbrI4oorxPLqSARNEUtjWT+kRcWbhWSOYw7YTM0hEORPdDeRJ7kwfh/akU2oFF07gjCAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/GYXRcJuGbvGSU+cqtUtpParHVWRRBgh1rA2z2WJfY=;
 b=wLuQ+u/7QEjE2GbPUZ+JsXPptzlHzeMWS8TC4e4FThJqOxw/FiY/rsBQ7VJ52R3aa2fkioG6O6fNhG/1TTFTsoBdSDbcrvZKKq5xVwUTY1+8jMEAW3Htp60r05MMrgmlViyI/RtMniLhOlZ74juQndjmtZS73vw09QltSKFEqiY=
Received: from DM6PR10CA0007.namprd10.prod.outlook.com (2603:10b6:5:60::20) by
 DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 08:41:26 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::c) by DM6PR10CA0007.outlook.office365.com
 (2603:10b6:5:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 08:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 08:41:26 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 03:41:22 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 3/6] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
Date: Tue, 23 Apr 2024 16:40:56 +0800
Message-ID: <5a357c1ac3504f8a69def8834a6d9557b5d592ed.1713861200.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713861200.git.perry.yuan@amd.com>
References: <cover.1713861200.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: b96feac0-a9b5-4458-9b33-08dc637129d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZvUYowubLtZhM4LzK1pAW0yC16672Jf2kcyBSc7nsBqsGgv6CWlmdLtYJpdw?=
 =?us-ascii?Q?Lp24ciFicXWqT7mXu4kZJB3FmwB99tY/WItIpnUrxDRPxV6IwPIy+Vn+xppU?=
 =?us-ascii?Q?W4uKdrxp/Ihe1PDwKU2K7dryqRqHAJgD2Ketd+OLBNkiemyFGVKHwAE92IdM?=
 =?us-ascii?Q?uDowsZ0fQaeUD9FDczkUqHW33Fj9bJIH0prk0zCI1EY0rHXEtAnz7bQlJZ0S?=
 =?us-ascii?Q?rRUlVgerPznGw5CaHBS10Svr96NIDFMTtcPKS7Bz0CIKNzeYJjgDC5j3+c5F?=
 =?us-ascii?Q?pd0aUYx1yHv3yY4LE2+b/3OK27/ZYGLxGs4yDQQ9LccysE0YAqBCPXPBaw+N?=
 =?us-ascii?Q?VLy/vNbZ1YRgscYfgT7Bu9eUG0/C+UumyB1lDjywqQTcfxEL6LdOH7RL1IIi?=
 =?us-ascii?Q?ZBIrrzvTIHfVzmlS09E36tv7AttUx4api5fUOVFljDnIuwbTAzxtXSTtWGAL?=
 =?us-ascii?Q?3NIv/owGVcdLZLngno/QTdLNqZjnWCzh3/cIQR/92D9gS8KfEhfBIZ/zxCRn?=
 =?us-ascii?Q?gzpoG5n4kXuWkOh1nzFchq/m3Hzt5jgjgI0mxqaMGHlxgrAKjrj9Izqgx459?=
 =?us-ascii?Q?SN/ARMkBId3xzMucklbU2Y3QtJS/2pVp2do6NPr0iw/P/qu3uggJH6ziLrgx?=
 =?us-ascii?Q?P3ZlWlshGz+s5VDGx/Gt/V52EEwYd+oZMfv0K1fWgljyFbkICW5I6Moab79t?=
 =?us-ascii?Q?hfmXk2dTz6yrxu4MN/j4GObRMH83fw28Bq8WPamHgS5Jub+VR+GZVn4/mohB?=
 =?us-ascii?Q?W38wTLbPreraQ8YtWdQnVUb3uipdGHYBUP93/kH1fMcp5BtXHxLBnK8ortMR?=
 =?us-ascii?Q?JmEZNq/Qi3+NN4k9bGH7NqzEFDb0D98uT0qRmMF7P7CuJB2BGEwj/9cKutXV?=
 =?us-ascii?Q?L1ctUseh/BVM0OBInfprUq9rt1TnYO/T4pJwQO4D/AohZTPPy4eUF1Re8msm?=
 =?us-ascii?Q?PHp/XOUIzvE3/+qh+JH8x+q2MGzAjnQ3QHD//grhaGtBDIQJ+UCiLTmhaIam?=
 =?us-ascii?Q?dHfBMKXYDSQL3KE8za92JF98g1UkiwK01RaU96UVg2bdYD1SeNLAgRIg8FTW?=
 =?us-ascii?Q?oHDoiE2lhpzQLvJ/nxbZb1bzEP0oDT93OLBybGlBSHGXutP4ekQLbWeRMKSM?=
 =?us-ascii?Q?UCcD5vhL3OE44DAmlCcN46OdO7K7+Co7Q+vHtz906FrxeCfcTFpWs+CaygXJ?=
 =?us-ascii?Q?vaa/Q8w7gHNP2yaYZv+jLDd+yqKg6qLDvglZvQUiEi4oid6/y96Mu98Cw5dD?=
 =?us-ascii?Q?giecMsxDP7RM5bCikYQ4E/G8RNWZrjUwayZrDpZRxaQUoe4wvrm2DM24MjxB?=
 =?us-ascii?Q?CbOISizxpwZ8IVxqxONZsxg97f+/tG+v9AmZxgpymnltW8VzHrKBp7Xui6/L?=
 =?us-ascii?Q?fqH93Fh0XftxoRjQx6dcj+mJrYrp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:41:26.3018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b96feac0-a9b5-4458-9b33-08dc637129d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562

From: Perry Yuan <Perry.Yuan@amd.com>

With this new sysfs entry `cpb_boost`created, user can change CPU boost
state dynamically under `active`, `guided` and `passive` modes.
And the highest perf and frequency will also be updated as the boost
state changing.

0): check current boost state
cat /sys/devices/system/cpu/amd_pstate/cpb_boost

1): disable CPU boost
sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"

2): enable CPU boost
sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217618
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 99 ++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3d86cd7c9073..49eeb38fcf20 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1291,6 +1291,103 @@ static ssize_t prefcore_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
 }
 
+static int amd_cpu_boost_update(struct amd_cpudata *cpudata, u32 on)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpudata->cpu);
+	struct cppc_perf_ctrls perf_ctrls;
+	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
+	int ret;
+
+	if (!policy)
+		return -ENODATA;
+
+	highest_perf = READ_ONCE(cpudata->highest_perf);
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	nominal_freq = READ_ONCE(cpudata->nominal_freq);
+	max_freq = READ_ONCE(cpudata->max_freq);
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		u64 value = READ_ONCE(cpudata->cppc_req_cached);
+
+		value &= ~GENMASK_ULL(7, 0);
+		value |= on ? highest_perf : nominal_perf;
+		WRITE_ONCE(cpudata->cppc_req_cached, value);
+
+		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+
+	} else {
+		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
+		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
+		if (ret) {
+			pr_debug("failed to set energy perf value (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	if (on)
+		policy->cpuinfo.max_freq = max_freq;
+	else
+		policy->cpuinfo.max_freq = nominal_freq;
+
+	policy->max = policy->cpuinfo.max_freq;
+
+	if (cppc_state == AMD_PSTATE_PASSIVE) {
+		ret = freq_qos_update_request(&cpudata->req[1],
+				      policy->cpuinfo.max_freq);
+	}
+
+	cpufreq_cpu_release(policy);
+
+	return ret;
+}
+
+static ssize_t cpb_boost_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", amd_pstate_global_params.cpb_boost);
+}
+
+static ssize_t cpb_boost_store(struct device *dev, struct device_attribute *b,
+			    const char *buf, size_t count)
+{
+	bool new_state;
+	ssize_t ret;
+	int cpu;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	if (!amd_pstate_global_params.cpb_supported) {
+		pr_err("Boost mode is not supported by this processor or SBIOS\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtobool(buf, &new_state);
+	if (ret)
+		return -EINVAL;
+
+	amd_pstate_global_params.cpb_boost = !!new_state;
+
+	for_each_present_cpu(cpu) {
+
+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+		struct amd_cpudata *cpudata = policy->driver_data;
+
+		if (!cpudata) {
+			pr_err("cpudata is NULL\n");
+			ret = -ENODATA;
+			cpufreq_cpu_put(policy);
+			goto err_exit;
+		}
+
+		amd_cpu_boost_update(cpudata, amd_pstate_global_params.cpb_boost);
+		refresh_frequency_limits(policy);
+		cpufreq_cpu_put(policy);
+	}
+
+err_exit:
+	mutex_unlock(&amd_pstate_driver_lock);
+	return ret < 0 ? ret : count;
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -1301,6 +1398,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
+static DEVICE_ATTR_RW(cpb_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1325,6 +1423,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
+	&dev_attr_cpb_boost.attr,
 	NULL
 };
 
-- 
2.34.1


