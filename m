Return-Path: <linux-kernel+bounces-39743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4132583D59F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD6C288571
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2AE67A05;
	Fri, 26 Jan 2024 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="36T7c1Di"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5DB679F1;
	Fri, 26 Jan 2024 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256537; cv=fail; b=a+U0u0D0I810CpoRpM619q8Wh/E72i3PZDKdiArd8wQK/w7iNjSiaJK7wGGNqsJc6gYA4SDg0qt609pA8rEWPKEpUA6FaLW6yXGjRbFLSsy7q4YZUXUpY3gTidAKJNhnJ0HboTWrH/UvKTRJ+JdYaVnIAMLIXXW/uBoJ9rBXmmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256537; c=relaxed/simple;
	bh=2ffpd9uHwBDo2ir+uRhyoRLhZ7P8UjR+V6tHgLibQ3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuwZHwtnIZfhpAPZAKgScdH3oIcF2JsiaX++UQbc6m97eFCdGu6GeAsXL/E+1KO1hVnZt7K7pBOQ5ZJalFATQTx48AvfgJ0PO6T1evR0I/GvKaey1AQUFOgi/W0SEJWK7A9l7KTWDXmsQSZ+60m0VMaOPV8e0hBxVw6Wb5go5SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=36T7c1Di; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEnP3vUUkPdWgKlPVy4Kh5hl/RZNgL111HgID9MMwe9JQJlkjNAVyNlGTlDPSh/kbBs8jVuG5hywvvpr8hXxZY8d6mC6qQbpcyQmG0++kxOLVA0vpl573uYUxkVkRYP4Kfj+U5el9szTUqNJQwfjSeG2c2tSyDBwsf4SpFeU74luviq5mFnHCvHlZqcAtdCwnNzKSmeie/lbj2JU3TS04qPC0OHvRMIxUeCBY34BeqMZwNV2Ww9jnU5ilixGoI29r9n1z8vARiZlXL/tfjW7OaaVtREjKbkwLorGeDLS44pVJ5Y4UsdHwp2H3JFtIVCXincqrn7ib46mAIzr+ooaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o3tOlnVNCRcTkaUjU1dbmZwtDSay+3FKXi89/ZsCrM=;
 b=oIew93UTmYNdX51uyJmazXhbieWd3mRfWEKlr/zrsk/ONX88byL4S9Z2wVLXITc++FZslQHOqUUFkBauDLr2/Ug9OwYPHSDsUrtZQfE7uPkAkzcrEAcQ32SMSb7OjuSeKJJ0vSFVR1XgRY+dB/8ckdQHTySEug0lbU+2S9sG+wPD8M/D/OjoFhXAGFkpYmF8E4BITUQIdu2CKAn+Ges1EKQZVNhTSBOEKGW4x69wcNmBpOl7L2oP10kHgsgmXbThoH0jRLFBDsJpSeM7IsJM3UOqrvq9r6U06k76EIDHA9SrQPVpTSMVErxJuYrLtrdMfKgDNlB/cOZEzfyEjyjH+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o3tOlnVNCRcTkaUjU1dbmZwtDSay+3FKXi89/ZsCrM=;
 b=36T7c1DidgeCumDOzWnWAx09rLg7mEFvxKQbczpNZtvQtr9TcpO6Zs9JcE2YlHO/7rWA+hyEjYlZOPD1psraTiorQkBJzCRGnclbnJGxiVY3WCUcm1YXv+9AH0aXlBy6CvpNzp0Whjh1CgroPuc1BZvuxEkvTUwJsYePRdhjd6c=
Received: from BYAPR01CA0031.prod.exchangelabs.com (2603:10b6:a02:80::44) by
 IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 08:08:52 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::e6) by BYAPR01CA0031.outlook.office365.com
 (2603:10b6:a02:80::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 08:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 08:08:52 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 02:08:48 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
Date: Fri, 26 Jan 2024 16:08:06 +0800
Message-ID: <f94bfc67e95fca54a153e24d828ef27e26ee5c47.1706255676.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706255676.git.perry.yuan@amd.com>
References: <cover.1706255676.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: ef55b06a-48ae-4a8d-bd5a-08dc1e4608f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WxHRKTf+Ts56SZILMpEGu0fPOPdRe7yBAN/RqW5ncqDZ6nyfKz4Kcip26e3mS9oxIVmH71PX17exL8thpKvR8WTLMKkEpk/xg4a9VyaVnKNXUq+5MunhTGFrHtRe32/rLsVVcHXLBmDlHLRXBalCSW4XG1deB+7bOCdsH+R6Lz9h19hh2l1Zlwz5ayRJYgsiUtaXBSmcR6OflksSG6OenxHD/3zsuYgnfwqqb0xS0pV4fziT0wUUp4HFh3RuHJw+iKz/QUHQTuSxBKYReojDAR/dU9asuMWH03LIU8AOX1LUE5uXPaKMKV5K1pJ9hBGOzAoZ51QaDxk6vBf15RLLXMV07dvI6J0+bpYVjR4YvlDpkoyQP9KTWJMs5Igppcpb+xcvxurtnxd4Fzqa2e5ZAsBam5w0W/vrGtKdBoxkhbB+mDLLyV9jrptD05OAtzDVJ4fT0K5qEPiPhOmcrdecIM2crbPIm2GqW7M1kkXXDLu3znz5p/GUy02SRnbyZNsWtDZs9B/ocLRgAxSq+ORo2klDZ/Ae8US7P7pZTQqnv8uZP8VYZHnR0OVre1Hg7ig6mtQMPBv5x4pd87AYzPhSdEki7TGrknj8Oz1aO+XcwewT23DcD9Wk6x2JNe1AoG4nN5X3vZMOiPXowcKuYsECf9hlF5s9X/c3BO/tF0pQwEYq3EtVpp4lP0rqF6IZTiKlao/bJc1cyph0r7Y+AL2jzHARUgLY7D6jIAArjVy51jlyvOMSApyRdzx9xNGXhxZBQ8A9Ny4nV6F7D+hIVinA4yQDPeCt0aRPnZq9Ypd7y9A=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(70206006)(2906002)(44832011)(5660300002)(16526019)(26005)(356005)(81166007)(36860700001)(478600001)(966005)(36756003)(336012)(82740400003)(2616005)(86362001)(426003)(41300700001)(83380400001)(7696005)(6666004)(54906003)(4326008)(8676002)(8936002)(47076005)(316002)(6636002)(110136005)(70586007)(40480700001)(40460700003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 08:08:52.0606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef55b06a-48ae-4a8d-bd5a-08dc1e4608f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747

From: Perry Yuan <Perry.Yuan@amd.com>

With this new sysfs entry `cpb_boost`created, user can change CPU boost
state dynamically under `active` and `passive` modes.
And the highest perf and frequency will also be updated as the boost
state changing.

0: check current boost state
cat /sys/devices/system/cpu/amd_pstate/cpb_boost

1: disable CPU boost
sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"

2: enable CPU boost
sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217618

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 97 ++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 0dc9124140d4..b37bea7440b9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1036,6 +1036,101 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
 	return ret < 0 ? ret : count;
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
 
@@ -1043,6 +1138,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
+static DEVICE_ATTR_RW(cpb_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1062,6 +1158,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
+	&dev_attr_cpb_boost.attr,
 	NULL
 };
 
-- 
2.34.1


