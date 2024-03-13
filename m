Return-Path: <linux-kernel+bounces-101320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA1387A580
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BA61C21655
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C455B39FF0;
	Wed, 13 Mar 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dYQ5bE4a"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E113839A;
	Wed, 13 Mar 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324313; cv=fail; b=Lg7Q77dqsn0uypJa12JkVfjm28Bun4K0iABZMPAyItKW3yUMOkOsSsRsqNMmP/obX5fTDbZJyxqtIVqJ9OAmN6UjzTwwAOCFMSuFJjwXDokNTq67yU7El4GAr8sc8iz9jtX1Go8fZIfBKKARgVEYuNwTN9oyZQNkO5iLGpIQZwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324313; c=relaxed/simple;
	bh=TM8pMocKSd7oBtGmwsR1Ysr3PPb+DbjlfvkqkQpwt/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPjAhsmpt0kfz/3mDLNaIUdl4s7+Fa5SuVPR0TaN/feuRgTAo/lXGquPt8iAUxRIJLCaQKle8txjLDSpKZb7AwTuk38DQy4kzZQejkUoIj4a3jjvh77H2kAIIx5+3o9kHM2F0iQEPc3M/QrGTKfI4eMGMhQ1/N4WbCN75qIbDnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dYQ5bE4a; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIwirB4LyHNMshntWXs0iZbkUNaSpsmLB2Mcy4shv4RZnDUHMRD8n8weZLOZ9oIMP/qsMOm9iU7mGtDeyvUmV96DdB37POC4900iXQHrfTgPqhh+qyoDoxZhgQ1/Iw+ugqBNUIGyaMCMNlfxD4wVCmwhi8jARP92YoS+vZUhupFMe1v3z47qulEymIyP+W4RntDX9zx0l2oIUTrHMJHsrkofBLHmupEh0hlHBe3JL7qPh7UcEmlAsv/Oh7SEmX8FAPd+FCFI0wHlN7RSkKffhF4HCTfojJPUF4maSpwZc5V4N55VUu95Vn8BGVanrdIUbAqpcnJoD0h7G7mdewVaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9IbG4In8tSgG/DAcZxwx9Y05nkzeyUUEb/tvcDRp6M=;
 b=DZemsCA4vjU2+I4+6g1VC+cyFNpUfKbBLSsgQp+ylszyQdyi/e+LffIo7i9vPfLj+uIyOVhdnPih1hYqd/E6Bs7BKvJk3agFRVDNcrKeYIzBNCX8UzdfQ2e0lqg8WV0FYq9T7gJHEecSytFGrh+wFI29opRTIscs6955tSXj1pbmBMDCWYh9PUePIiXJQDxOmfxGPjODpCfzm57c5YS59QzrRCQUAjzjKNpidUneCPvtYPrcyRdZK96BjiMk2fymIEM1E4WM9s4YLxK96iw23eJgbCGU82rcmzNJRfsReDpY+pL5MPJ9Psjt7RBEPRgp0U+8ZGL04zAs3uHGDyl+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9IbG4In8tSgG/DAcZxwx9Y05nkzeyUUEb/tvcDRp6M=;
 b=dYQ5bE4auLJisBafP6oSBWxKCbt43dfCNvyMlqXAIAyPuOEIPqZEhNsnuWldIuE6pSucwAUQpgVsxgy6E52creuWRhxA4wynJP4KJVatCBP73IOmuH0LUbI/1C5WykdlDii6A8btDGG2bqCINhb2Q/861R8PjD9bxCBOUsVzLno=
Received: from MW4PR03CA0224.namprd03.prod.outlook.com (2603:10b6:303:b9::19)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 10:05:09 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::5a) by MW4PR03CA0224.outlook.office365.com
 (2603:10b6:303:b9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 13 Mar 2024 10:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:05:09 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:05:01 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/7] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
Date: Wed, 13 Mar 2024 18:04:39 +0800
Message-ID: <42a36c7f788e0fb77d4be7575aab9c937e1773de.1710322310.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710322310.git.perry.yuan@amd.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 63901cb6-0d75-45ed-314c-08dc434510ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JbywOTAvW8I5tJaPLEf0xf2bZLt456+2l2WjmX5wqmOEt0ZO4cACSsnAvf7KKcFMH5xyyK+jeTgYA76ifmbl9SxojUmX0a1YuZGbIgPgeGnr+tFhXMS7ZSIm8MzVSboHDq7AUD0hBF4Ey2Dz5ZG4UBcUSUOzsh9GwNkaID8owbKn14zZgdlaWEZkUE+HyD0NLPGf5T68zCm7D5W4gJKhQ5mxpbSXijQMqmot9sATlmz6ZeTit0+snnA4L+5cgLbB8qjynA2mcMxVzmXj2bCgPoFTO2I6jpmOa+Jtt+U7Cw5/9BdGx1WeXYxC0n5l8O7ZH/HZAAibgLwcqcT+iSr78g9pa0V5vXBITMkOTCc14BnQ+44yxN60mJMd7DKinpR99QZHYkdtrtmVF9hQOmcUDikjMpSiP1iNg9lIoQmOpuOnly207CIVE4U/KfP4kHRTZO1jupj/CDncBtqSxZBdWe17D4OuZrsi0t1iPlUFtRqYbkdLGxaPGbpRVY6rN3f2wE+N3klHkl3utZbwJiunP+JAOV7vFGqEfqVY5IlgNhA5wwjku7HMMyjR1OpqU6b6y24kP80cV0Glwa1+hm1wFUBujuhuxMxTwIJ0fETZ+AcDB0diUDDuUIdqv9in+BmvtxOz8c4YqGPcyY46m1Si/6TixaXOmST57Zgy+A2xE/TGNa3UiY/LSfuxnsD9ZwndjxmTPHCUcn8dvDiPK1GVIQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:05:09.5169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63901cb6-0d75-45ed-314c-08dc434510ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

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
 drivers/cpufreq/amd-pstate.c | 97 ++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ef6381b48e76..d54399ebb758 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1208,6 +1208,101 @@ static ssize_t prefcore_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
 }
 
+static int amd_cpu_boost_update(struct amd_cpudata *cpudata, u32 on)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpudata->cpu);
+	struct cppc_perf_ctrls perf_ctrls;
+	u32 highest_perf, nominal_perf;
+	int ret;
+
+	if (!policy)
+		return -ENODATA;
+
+	highest_perf = READ_ONCE(cpudata->highest_perf);
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
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
+		policy->cpuinfo.max_freq = cpudata->max_freq;
+	else
+		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
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
+	for_each_online_cpu(cpu) {
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
 
@@ -1218,6 +1313,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
+static DEVICE_ATTR_RW(cpb_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1242,6 +1338,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
+	&dev_attr_cpb_boost.attr,
 	NULL
 };
 
-- 
2.34.1


