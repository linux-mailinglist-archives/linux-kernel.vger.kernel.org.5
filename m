Return-Path: <linux-kernel+bounces-51625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4778F848D71
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF851C20E9D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB31C2260C;
	Sun,  4 Feb 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yD6Xo1Nf"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A4224FB;
	Sun,  4 Feb 2024 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048805; cv=fail; b=U4yBw06pzugY8+/JvNTm0ZGB1POni7rxbaL8vvpbnVmIOrL5FfLzlCvW5MB1hIa7cluJMWGbokzCgHKzDx1nTksSY5egs1XybPOoufKMRLZQdE452TDVPkVCNDy9zj0Z9QrvmghRhCxlgUov/t+co4hog6ZlBQSWpFY95X0ZjZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048805; c=relaxed/simple;
	bh=Bf9NAfnoVQeHWcFTnv7Yw66NpniG2LtdK4UGBjshRNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D75UvCUgOTPxOKsBGJpv5bleQwr1bUeqkY7XqacT9UDllq5wcNh5q07/tZxW9FslhCmGZIDe9Pf8Rd6uH9bjMnwY9aTeut7z2W5yMF5BGY+bLkWSjG78TAnZuCl3RZ2LDfGhlWFXhrls/cqmK207i+C85/qWsJaE5wZsiH59y30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yD6Xo1Nf; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0DeONGm54RRaDTkfHmODZChRTFV8g047kRy0PdV9M8V7J6dGTPM2DagrZ3HxZlNshOxI9qC6DF+n1ujLxbzuP0AB9uWqr3PPJn7B9zumMVXyJbKC+iw5dtCiH4HfDvXOpLgO+7OrNnLNhvi8wE+9jW46GIzqpmT7mqNC8QxYWSbGJXBw1eNvaGfI7EqXKNb9+CLQ1qqBjHNNIFk8b1fKzx5fMvOtGuRtYuHMFeC6rKlePa7l/5ELDuC42qjVB16VDAf4ikmHYCZCLlPxghi4gSL1pYmbIZHdjdL1NhQfFfm/jfxBHjeeXjfYev7C/WdRSetYJRJG/mcKekat1TE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06udwbTp5ntp/oFXoO/P9xr7leCBwd4xSY8+IBn2Mkc=;
 b=Kd5OEToSxkBLq5frOcOF4uP1HmoQnfV/bkLhMZnPNSJGsXZlhUz3iaUrYMpar+uNk88BlEFnIWVZkxSdhYW4M2RruxcuajPsJJ9ICxgvVQiXZiOL2bTyyB28Nl79+gsnlsniES3UVfb8rqU27bWPRDwh7OaDHOr+YRw1NMfbTYHh3glIHthmPb0QrxNX+4f9QNGMaRGrBWstIT7YMo2LyunHiJF2q09G3tOaBZfT7AverpvK0FKiWO2F5PaHCvFD1U3jDuOI4Pphrz28IszgazfzAVUsFRJ7GL1xtnWsdh6tg6BAYyXpkH6XpB/EctfaVuAh/B6KxwE6ePFqpBpbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06udwbTp5ntp/oFXoO/P9xr7leCBwd4xSY8+IBn2Mkc=;
 b=yD6Xo1NfTLTNLTsiMjj4uzVp03iWcrwWKrSrvG+9Rr+wPmyaKMLst7WP3usRVTzoeaZPa/6DAJEzTOWZoVYBbtGauuPMt+h3OwZGokKHUBAyBrPv6I6FqKDUiZcJipkF1ASEerRDLEZwY0IK5gs76OMfLVxRa5cPlV0kgUv1YB0=
Received: from BL0PR0102CA0067.prod.exchangelabs.com (2603:10b6:208:25::44) by
 IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Sun, 4 Feb
 2024 12:13:19 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::e6) by BL0PR0102CA0067.outlook.office365.com
 (2603:10b6:208:25::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33 via Frontend
 Transport; Sun, 4 Feb 2024 12:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sun, 4 Feb 2024 12:13:18 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 4 Feb 2024 06:13:15 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
Date: Sun, 4 Feb 2024 20:12:53 +0800
Message-ID: <20e12e10aac1854507eaf512591694cbc0789c43.1707047943.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707047943.git.perry.yuan@amd.com>
References: <cover.1707047943.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f27dbc5-3b11-43c3-de91-08dc257aac7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gyayu5kmehZFz5a5CBmtka3oL9VdrxU9GBXaPvS5GxIg548qBJVo1lit7PXTcUXuMbuOGLyahO4qKYMPktO9kp+C2bokj9b9LUotvLewhn66GbHgeQi/Wb5dC1ZCpTMq/K69+bTvXwYDiKW3a3Vz0LLFeS5GOBSo/tauslvv78cB26QFBQBxGAYQLj8UnbYnKP5yAVvritjWcQ+f918fBIoDFA0uFl+YrXF09Ky/kGDOC+sD29BQWHOMFDeoMksViHulY+kDyHcPxx9lXwRcqtY9pWIwp79aX117rU7dL1AkxJOQN1o+1GubF21E8+DFp8uWLiWxhZYKz2OVfYV5FZNhihPEOUJFYlV/DCeAcmWJW73OQOhU15QjMjZ3X3QGvhSy3l6zxtJRKKxgPJabOffOlEqr+l8pBl9N0Ye4RIJxy6iAb0f38BZuewm784J7LEI6uS8OJM1U21QzaLqZ+6u1wYx1nDA4Nekf9nbQfCI+lz3CXhK1PZxUobBN3Mn3yi0/kvmO+mv2b7Hj+aKhbwu+SUktFLwLuI/xHuJ/KP5nk1hah0iqQlYRsKZecYN5chj51xUd1L5PpASSzOuUC+n5JPc60SCwtEyb97VUH0qqsoUyQHxn4SEmpzXuGjYfSiWOOspBqu6GdXHaZQwJAaJXrBSGq8ZWpudXidHYDchC19wNrL9BjntdST/ggyYtKfI89BPBZ6xkPsj6lLdbPHdtY800zi14gbFKd7zv11MCIqrCBUwVpbnF5hTnco9FUhkfNL8R5MVRpLCXp+iVT9xxcAuf+Vpl+LBzqYHKpDN6Z4f+R2WQRwzM+eiSsvshfhrMZkNlgasRKeAgr9ibDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(41300700001)(26005)(70206006)(7696005)(6666004)(47076005)(426003)(16526019)(336012)(8936002)(8676002)(44832011)(4326008)(2906002)(86362001)(5660300002)(70586007)(478600001)(966005)(54906003)(110136005)(316002)(83380400001)(6636002)(81166007)(82740400003)(356005)(2616005)(36860700001)(36756003)(40460700003)(40480700001)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 12:13:18.9335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f27dbc5-3b11-43c3-de91-08dc257aac7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577

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
index 921324ab9580..018ea7cdda2b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1030,6 +1030,101 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
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
 
@@ -1037,6 +1132,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
+static DEVICE_ATTR_RW(cpb_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1056,6 +1152,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
+	&dev_attr_cpb_boost.attr,
 	NULL
 };
 
-- 
2.34.1


