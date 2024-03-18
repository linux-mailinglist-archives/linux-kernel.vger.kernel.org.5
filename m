Return-Path: <linux-kernel+bounces-105969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8256E87E6F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECE71F21247
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913753BB35;
	Mon, 18 Mar 2024 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O1oxg2tu"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84963A1B5;
	Mon, 18 Mar 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756706; cv=fail; b=V7IZGJM7kak47fNXF3yRUNPXOQz+YGMHyKjF32yPQ7nrEcrJxBP+J6TGsCmLfs3+40nTMZh7qBETr4b4WnCpVyjvmPgpi43YlED9pIJA7muM0wVet0vlRKVayuBEvPegLahbMEO3fkaweA67/MWsFF+7Z6nsWFNAYGMP+GMxfz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756706; c=relaxed/simple;
	bh=DNBmTXM5l/5DrfG/4k01NNwh6z/6IKTONCTB19/z2oo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eftJAZyHQ19G9n1ULaB+2Td1shxWBPUARomf4ZfQV07Szl+LUcaUh3Cl5zw/xbAvF7xHgfHC8jIHiw3q5Z2Gu/RpbvfoDWYN9BfbJ/+47928o09Mlw6RmUE7Sl4MUCIwJhaZVxxDmrQfdm+7bfGenIJjIi43cA0eJQhdFdnGPn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O1oxg2tu; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzGb0eILxki4HPVIAYNTtRNr3a+o+NPr9DK4Z+YVX9EakLIVlXrBUzxiWNkRufhTTGLXB4vNpwoa6USLk8Gocxcz9KCCRic08hLHbjiMO0XX/2JzBFKVRrZYxpoy7+3ulbzwkZzHE/Q0dcbkGpDxZ1RVzMltz6t4AB64MGHlIYlm2HNAok2A9W7fuZb3gH+er17urRO59IAB7/VlVlhl6Udsk9VGyvo6OlR777I7rjHiDkGMRI6GP5Coo5RQ73WmqZCYiUV22uiBxSI64g/4Z4V9zddsC736plYr/BehNb+0YUSWYrvxZ/k/ZBjpkFpp4SynvSsS4JAPKOJBksfEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxFRIZkJ1BMDUMNPRaq3S7BZgbAhzFjrrGPocjGB1n8=;
 b=EzBfHfuuUQF3yCEecdQkw7XFE9nQLPKYvyECJYZNfAOaotpnLH1qzSeQF+fFuBAst26UhhocF4l463hZNt8d1/kpJeILt5FBAFRulp1yIkXOZczVhBz+M/wDddayTHcHuXSXVceDmu5/gwu/fLAHvZHYO9ocGEw5i5LJ5ALMRnvXKrBxZZpzLNK6DQgIbOW4D0hCG+MZ2Vf5tNUS0YzSHYgtw/Up0q+6+cjMLq5992wm74uD6WvPgmg9ubgOHuS41B9l3TNkw2dj5i9KzK1EzzyI2TkfCjjT36uXfnuaMUrdnaKODVB7dpB+VsOUp9F3BRWy+F0CxEf+zrkgE5jBGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxFRIZkJ1BMDUMNPRaq3S7BZgbAhzFjrrGPocjGB1n8=;
 b=O1oxg2tu7R2xkmlMahkKtn9mIf0UNeCacjUYwH02rPdTveZ++onX4oA5VO5Q06TjFwl+7WkPRSqG/WBaUQEcKMWmsn/SSqjkNPUIkT1/NZfgmq1LIGIXe3FAkHPq/m6k3zQbGewfXF3ZyHD99EXrkwu42sPfiwQ0N+v2Tt0P+Co=
Received: from CY5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:930:1e::9)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 10:11:41 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::78) by CY5PR04CA0015.outlook.office365.com
 (2603:10b6:930:1e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 10:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 10:11:40 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 05:11:37 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/6] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
Date: Mon, 18 Mar 2024 18:11:10 +0800
Message-ID: <2668b90cb68315c0dea4a098100fd084b013e277.1710754236.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710754236.git.perry.yuan@amd.com>
References: <cover.1710754236.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ff3076-57a2-48d4-4238-08dc4733cde2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S83rk8ahMXqzzbVRTN8zFErp04u6JtJ1XKo2PPKz3hnlBcUM8Z7Bd6O826MWYuhFE2lFwoeOvuqH7Wuo8iXXu00KnnHgVDDUH2qDnam3hdX66hnIKrHJ4ECTrWrCkzomZgSGoSu9wayzXVs46x/CXpI21e3fsw9K46tyVGvCtozM+rbRKyoLY2zxA4xda7VjvgJvLrzfkb4eCxRB6enGfouSZPd4sQFl52H1PgpDqtMK+CTSCeqBAZ4WoyRVOGwvq557bP707jBx5FCyGHrD51HPk9M/35Cd9uyQjD6wH/TuyYdzzDumZpvlFV++hgw1Fu9Ed0vYR15m2Krsv1mQsouxGL0tlHVXeUrrEhnQUqjkzQrW/spkTUtCw3mJIWIbV6V77XH2w/BsILra1BAMtwyZy9zniaiZs3+xVC198yZ/ltNAlIErvstT7zwvuLqZreiUs5t1sfVKAsVnDFzvZxnQl4TB1BliVMqTR405Cjqezf1oFumkhanx68KE+NLnHVuhOHoG3NS3Mss9L2Na0qGTpEXHDNDb7/7TLwYotBaDfsiAsVDcrOJDth5DJSt5uPBBiOfCrnlPiLewvRBo4VTgHdIgs28gm5D63hjNtM2vuo1GCkfwdBAyQCv1w1IsiNQe41JHYtaz97mco4PvcVNfA0cThHIuiOZkJP9hCqh6A16heG7cuhu9f0vsFT9+s/Z8/jDxeyb6ARwFRm7CAw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 10:11:40.1735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ff3076-57a2-48d4-4238-08dc4733cde2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743

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
index 81787f83c906..4cd2818045c7 100644
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


