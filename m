Return-Path: <linux-kernel+bounces-159575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5841D8B3082
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC01F1F23EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FF013AA4D;
	Fri, 26 Apr 2024 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r0QDHwLj"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3519013A889;
	Fri, 26 Apr 2024 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113323; cv=fail; b=G8erVj5KDyJRsNP7NCO7RC8zOrjxFyTAdEt2GkeqFZymjry3rPndFwADvK2GUEVIhWv4F5f/3hq9hXMfltTw3wYt+d4l8TEoO+ra+UNH1O6Fooz20iZORj+yhku3oHTn6OFnJ+fUcTcpn+XM7s3InOILPfTZb96nSw8b5/v/eNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113323; c=relaxed/simple;
	bh=oLTaIeljtmiT2DDVU7cUHo+5bXL6qoeEo+O1sB4FAwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6y/d0t3RQSc3MDF55utaOe8BcLikxt7nUOspRHUVzASzacpq+FMNwGDus4KTzFxrd2xgSthF9r6zLhcTvBXGw446kboJd395x8QeV8qF9oGS2PnomK/2/FJ5968X8mAfuX+u77zYJ6jV7hYqmdUSo82JIgVEdgSLJgpRmCB6BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r0QDHwLj; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjBZw6Uteeipr8hWi+MjQNTvlnNlfV2Ldxxh31jl5Rum2R3UWvgdpmyFGfZxPzEP2ljqwCv6uXjpyMnG2fv1HgGUT25D9yC/QAoMLsys7QuUakDuIfZ6WrsgA9rm/GdJGlG4ABJEk/vUgnvLLqtXVwonDQ9kqZpTdaAxnRY9JYzrDs9/LYN/HFRx1d/f4F0/ZBS3a/qnGM48mzn56l7/O5KWe5mqu+X8X4u4+spYDJS+83Erjq2mPn2tHa/Tme7KQHD07w0LXvv0uHihYdq05yjbsjpJWrxdjpayBkg08xCyf5lQc0bfJY99EJoaHA9OKlsVYKmEGf9LeB7zTEVCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVl4gSheS3gNrbyefRM1J7xeL25yOTI4/vqbzWj6XIk=;
 b=TpArelsdxksOSh5n5GwyB3f8eeqgniPJ5irhJ2+g4lXMI4NcDTDjD8OhuysUgJF8zrALH2Fmb3qArlWO1GxJGCGBjPytG6wr9hOlPBQrPkBq2c3oCY1DV67fKN04ZCd1fWU0kUgP5RadB+t6uWU1gOdQDgrmpOi+V2oJAYUh76f9KKQHdyWmOcksXt2v+GijcBpPDPBUdYEF1EelITCJVTtw4nklMPP7f/TqrQriMM6c/3EQ+3x3shn0sXV/+0XaF2rPrHl67TsMIfj8yG18USPPZQ5ZvEqencbZTC5cnPM3gdOFQ6LmQVlY8NBwn6QUy+H5lDdar8Nc8PcPyWdT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVl4gSheS3gNrbyefRM1J7xeL25yOTI4/vqbzWj6XIk=;
 b=r0QDHwLjDXQoA90nCWVWL0e+NDQSTbmXEEA2X+XT6BC3P3uWSolTiInaGz44FnYuas168FldKRIdm1LKF64fAVYxD5xa1vOQwxZAJIDNzogwxiZPz7WKOAzG7D/DeyflHiT39uriaTeqregCJjpgR+N6OQ9vzE6EAFZTu/rJsTA=
Received: from CH0PR04CA0059.namprd04.prod.outlook.com (2603:10b6:610:77::34)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Fri, 26 Apr
 2024 06:35:19 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::b) by CH0PR04CA0059.outlook.office365.com
 (2603:10b6:610:77::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Fri, 26 Apr 2024 06:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 06:35:19 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 01:35:15 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 3/6] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
Date: Fri, 26 Apr 2024 14:34:46 +0800
Message-ID: <64eb440fd48d10a55525253bce2e9143db872f67.1714112854.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714112854.git.perry.yuan@amd.com>
References: <cover.1714112854.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: f80683ae-20fe-42b1-04a1-08dc65bb0aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W4AyxeipiLc8BPvRkf0226ehGa+7cfYY/c16iuHJ+g71ykQhUxCKN/vE5ISp?=
 =?us-ascii?Q?VUqSJuW7hkfbDKns3xC/vCtl2QCTHIg53huTfB13pW1OoW/TlTrS9j/ETM0q?=
 =?us-ascii?Q?DQt+NVciRmy6nNGTpuGjHZGrqDq68iIV0XK6RmWGXXy26vRsHt8UC/jgUIyt?=
 =?us-ascii?Q?jZ6cZCOoyHUtQ92n0LoXaZLx397ON98ntuwhHV97Hk3AjDuPm0vKadHxIQfH?=
 =?us-ascii?Q?MEvfAOlr3g6KSGBbm2e7loPzI1B4e7JLGIsR8eih6hNWjifL45eN2HTDqRcB?=
 =?us-ascii?Q?EKmPJr4iQ732bYLws0oxpkgoD/EueNSLOc+B8pdPij1h9oIiz/AqByutyAI3?=
 =?us-ascii?Q?cbodzqAE1Da7xkjo4PoiT1o2gfie4WG7yj+VuZnI3cwPdv7pNigQN2hM5c6/?=
 =?us-ascii?Q?Ks90hrUE25TnN5XKIKnNUAgtyVtchZoLlQal4tdyC+ftMIl+7fYJ6jiv2HOw?=
 =?us-ascii?Q?U6GssBqO2PhOgZA1gmVCqVBBNAOGiEbsKwbKKQP6gybSgfA//IRcl+YrCOPb?=
 =?us-ascii?Q?jFvyM7KFGoVnWqasZW2MDbk6Rh/lmnYa3lXwpRcE5zvxTPqHgSA3nDRDhVWG?=
 =?us-ascii?Q?cF9AC7hG/hkxhSALI8AsvNTM9rijGi+If5SzdbiVWONsdyE/FNrEC60Q2ml3?=
 =?us-ascii?Q?blnn9mMAIfT06FpFbepBwHNR//cH9/awVg1jpea79rf1uzYXbfEWuoV+c2EC?=
 =?us-ascii?Q?yIbS+JOierloAe4UbpvdFER5RvAwrQ1Ht3N9GeDtJFR1i/sAzmG4USnzhrPi?=
 =?us-ascii?Q?L8V38IG7QSGrMZjDw+Tx7zH77DW3BeTo7svhl1ouyukcMPrDqrjnr6fdq8MY?=
 =?us-ascii?Q?Buo7QB0dg9KdAS1YOILP2FEQjEhl1hlIixH+i/ObulFqB5S3XeZyeZmBptVZ?=
 =?us-ascii?Q?zZCE/mEvbCyjUGeJ0GKDJ8DXiNiMVOHL3Wl/t+rFIXa/2z5CABoz/AG51vnV?=
 =?us-ascii?Q?4vN9wCiQWJztoBsuja9dOr34Ehmrv6WbsKos7OCe2Gw566nPFVvUfauGY+p/?=
 =?us-ascii?Q?y88dVXAgu/EGoyVqLJA8TBqmnQ9bb3vOPsQGazoT3ibECD8CiTsqDRv43mRd?=
 =?us-ascii?Q?E1te77owxm9TJqUD/oopzOYsDuxhOftcdQFTpAaG5FKTQJyqIuCOG/WKNSfo?=
 =?us-ascii?Q?SViTwr51oycxvL4Y6Slryzxt10hixOxDxuIc42jiQR0AA1mQgsJ+Ipl5e6Xj?=
 =?us-ascii?Q?w8Xa7hJrf0XV3K78QQZ4ut1UxEOrx3pxmmmncYgQmzexBWuYTA/J3B3kIHCB?=
 =?us-ascii?Q?eQMd9114Bz1K1qe9lEV3ed/jjgCNd7zBFQfHUdTJ++cyCqfx/ldcgpi/MhVq?=
 =?us-ascii?Q?W9SAtVY8KuPZW1AX/hQTMtS6fhwIoUR/BwNW7NdHDk8Dotx4wZvcUVHWa9CX?=
 =?us-ascii?Q?YzSUshIO6Pw5ujNnoWCxoupzx0lb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 06:35:19.1084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80683ae-20fe-42b1-04a1-08dc65bb0aa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948

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
index aa17a3134497..53ef39c6dbfa 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1295,6 +1295,103 @@ static ssize_t prefcore_show(struct device *dev,
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
+	} else {
+		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
+		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
+		if (ret) {
+			cpufreq_cpu_release(policy);
+			pr_debug("failed to set energy perf value (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	if (on)
+		policy->cpuinfo.max_freq = max_freq;
+	else
+		policy->cpuinfo.max_freq = nominal_freq * 1000;
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
+	if (!amd_pstate_global_params.cpb_supported) {
+		pr_err("Boost mode is not supported by this processor or SBIOS\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtobool(buf, &new_state);
+	if (ret)
+		return ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
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
 
@@ -1305,6 +1402,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
+static DEVICE_ATTR_RW(cpb_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1329,6 +1427,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
+	&dev_attr_cpb_boost.attr,
 	NULL
 };
 
-- 
2.34.1


