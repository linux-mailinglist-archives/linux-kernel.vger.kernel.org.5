Return-Path: <linux-kernel+bounces-56193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C6384C733
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472201F25B86
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658A2375A;
	Wed,  7 Feb 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ahdTa15a"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823920DFD;
	Wed,  7 Feb 2024 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297762; cv=fail; b=ar8I4U9fXoaZVumnezpl3wKH+AnPiQX5wEPWd6zZP3ZiygmzDFX2+0CfVaPLh3K6tdlessoPHcTOjxmbrvFB473upRAMKzb4SDKfQPGp+yAjEDaYw3sgNpvloBYclXvgEyr4aqmlue2Rf5XMPYdydoP+nrudMoLmkS7YMd5/heI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297762; c=relaxed/simple;
	bh=gYn3vLSEw45YNi5VzhvqftFh5zZnp41XxP52MEcYofs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0xKRlpkol4+VHBm/mVCVVybb7GDa2f1NLmo60qEjQMfy3L7HMirFIXdYYqvVeItdJZC4gKjez2RpTmhgbfsnln0s1/Za9v+Ao/Hx+IhhXWV1LyFRG22XyBUyegP2M37LLi1sBUmPde1SZnMkoxSl1xx3RbUiC5dT57x49dMwcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ahdTa15a; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/eMGggErz7i9o67QPm0UjUXak3iEzrhCGv3DAdnHr1hGwLNfmiVuFBgbNt2Da0GwQ0AsavGqHhUTnTdHzieiiK/RUjsm4VBzhlVDdxloS/l5R7q8O+OBSsgmXtrJDLZ+/cT0a2lkqZlXl2YhfyKk2vBOYmb3vOGNBIHIpRVd5R5wkNzRO8fg8WvcSR5dACOKrNfMgnahPYz0VwEvoCyPntDIJcSyG9qCMDCA2/FHqTmy223mOo3Ewla5H+UdEITVmsQJMKtqJR3cGkyuSKMW8Luumu/BBL6/s6V4BYBYH8gNSere58vO30mRHRaNpVgoYg5aoY21EqN0fFiflx8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqygMiYOEf/obPIoXwhQkgmgirHieruHayXvzmLAyPo=;
 b=mzUaaPrHaK/chnSztC2T3aUw87HUQ1zpsNcZzSgqLI9+ormQAKN3CQSRpjNIhRJEqTWNd3ygpiJRx5kyAwAInbeWihIP57TChiCrPNoP1ltLr1rhQggtB8BjeV7z97s5MwmOQyDS9Hy08Tu4TSrQYvnuHuCLDEEPlr8YOy9/ZeImTh5LDYIQ9wpsLpoTTb24shOQE/nu76jfsESJ/slRH2tWRIT7xEphgyz8bHHhTa+zyg/T1g26MXPmFtHAQWVdMuX/3qGMrDi34ExjtnmY9uYwjikmfiVmF9OyNydypCznDnppnRlAIuViUY4SInNDUpWQEv3RG7kQgLe5F8hvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqygMiYOEf/obPIoXwhQkgmgirHieruHayXvzmLAyPo=;
 b=ahdTa15a5sRa+PJJQttwEF0yCiwMO8f55jOJfmpCnGMoUFLrt9uxwiXQfoaMGvSFM6j9KtkTP5nhjmskW/a+CI0B6WMhMKNn+HbKhu+4/OQtCPTS7wxmooNs+p6rGlM4XJ8eNi7OEaE4fEv8jsICZICTb4F4YSqfXQywPPU752M=
Received: from BN9PR03CA0586.namprd03.prod.outlook.com (2603:10b6:408:10d::21)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 09:22:38 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::25) by BN9PR03CA0586.outlook.office365.com
 (2603:10b6:408:10d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 09:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 09:22:38 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 03:22:35 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/7] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
Date: Wed, 7 Feb 2024 17:21:53 +0800
Message-ID: <9f20a9175cedb30707d6ed61385a82557d468735.1707297581.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707297581.git.perry.yuan@amd.com>
References: <cover.1707297581.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|LV8PR12MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: df5fe982-7db2-4a9c-1550-08dc27be53c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pni5KosoFCUjnm6OAfHIWFE5M8qeWfeyKbcB7tGZ4T5mU19Qosico2ca4gtAyjFPoRG2uaiQRVdAfcMs6+sJiRATQketN9WTHocqS6QIJFM1dIVqOX6xP87e7s37eGXu3bqkG9UX13XbRmOR++BSU6pil6EK8CkrI2+RSUfkf2MDmvN49x20TjfUV7oGdOJdfnZcengKqBIt0NxdXHjF8rgEBwmiLJA7PZuNYhsxQsYqisWj33xsyaoOrwS7YAm+gbS0iUxJs+xeFBmIc/FqPB4OOJM8VJNmGSF+NyuERWZnwZEQC54mAGImw9HSG4KWbDXSOyEuQzxZId1JZtuWmFlr36fiL7wPOKnXwtEMs0uN4bH6jKAwfRptAR+50PWTG3JpanBQYaT4Vhqo7pBNoVfG6ud+8KKDoviypkeUJjjglFSToe1Tz+z8be4ds8wMoMUWMLGmvVHn1BkDDmalNCx+38pa/ZBgGyfOcXYWAFHYwWa9lLCK4DotWOy+CqQImOpzlcx3zZxlM6D6IZBkLy2XAxkayHxJKjq2tuosHBPRMV9L0W19d7SqArzh/GfpwrY0kzpGvF6Y3HaYv9+3/Damq5yF8PNVi8WabPjb2xrSN0EFS5gv6TCqWbzi+z+4rd9BhZCieDBr9UH59aZnEtMIoyeHRlm0yCDhUdQYSkL7aBVQg3y851oKaRjipbJQYjkJ/k6L4HFlWZu93Hyw8WECBy7ZoXh9l1REaYmn24YaHqFmTmZnXu8EOGOiHX3QVVkD4xKUlI85Dc5Y6NUuo/rg6liQF4z5hxejkFwnJOw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(82740400003)(316002)(110136005)(83380400001)(81166007)(54906003)(6636002)(426003)(356005)(4326008)(16526019)(6666004)(47076005)(70206006)(26005)(7696005)(478600001)(966005)(2906002)(86362001)(70586007)(2616005)(44832011)(336012)(8936002)(5660300002)(8676002)(40480700001)(40460700003)(36860700001)(36756003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 09:22:38.2190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df5fe982-7db2-4a9c-1550-08dc27be53c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420

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
index 3772f71f525f..82b43bb2ab83 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1200,6 +1200,101 @@ static ssize_t prefcore_show(struct device *dev,
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
+		policy->cpuinfo.max_freq = cpudata->nominal_freq;
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
+	return sysfs_emit(buf, "%u\n", global.cpb_boost);
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
+	if (!global.cpb_supported) {
+		pr_err("Boost mode is not supported by this processor or SBIOS\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtobool(buf, &new_state);
+	if (ret)
+		return -EINVAL;
+
+	global.cpb_boost = !!new_state;
+
+	for_each_possible_cpu(cpu) {
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
+		amd_cpu_boost_update(cpudata, global.cpb_boost);
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
 
@@ -1210,6 +1305,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
+static DEVICE_ATTR_RW(cpb_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1234,6 +1330,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
+	&dev_attr_cpb_boost.attr,
 	NULL
 };
 
-- 
2.34.1


