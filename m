Return-Path: <linux-kernel+bounces-104025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAAE87C804
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF9E1F22D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92F112B77;
	Fri, 15 Mar 2024 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ptw98Llb"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB2D52A;
	Fri, 15 Mar 2024 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710473971; cv=fail; b=BCQHBQYI5NbzKd5ZFrbmj8DK4ZeaDEtMEC3dSizDm49x8FfXJUF4FlJIiBZJto/IaE3dwDjWMbUDJ1UwxGEIriCrd6kzaQIBItanYRjdYpT3KtlcBZIDNtIPBmoxDBdWjWMgDX/e9EZ2uanFfBG+YVemwigdO66VqWV+kVspSPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710473971; c=relaxed/simple;
	bh=N2G8uH8/vhXB25ngc2NsVER2dgxrzzuxHwILKz+YtFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIx+G0dXshFk/JwaAYGhhZ+nwXrq6TwUz68GFRvgbsOnk2RzdQtnJL+/hy0cGhNN3n4K5EcZTNcEYO7VeAy/M3huranoIJQHtso792EqvqzVv3Wfs86nRTdb0EDsaREwPl14ZaON5uvqd7hw9UZgnAx+Fhv7BDBoRWtzFMwtKoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ptw98Llb; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmmWFLcJlF36CbBKQ7iPlqJoDFfvymDYmsvEbI5ytdakBkT2zm/ozJrBvYG8lSQ7kGtTjtx+SvyBaplGiMtPu4paeV+UHhqZXG8rwjjhoBh8Y6YIGtMdGnQWNK1tQkoZPGZA0h4tWcO3PAiL1eu7jMhJATFQSVYWxUxKvjoLaGkX2WDtcQsEMr7Egde1Fki8CVIx61NbDjKB6153Z/LnLVXLeg+Be4GcL+TwlZd/IAJHW6CPM/2KLm7Zwhq1WPOh4rZUUyACZ1mQPXKtwjgxSKsIf1+eBpMl07zpwy1coNZ5nVfyrG1BpcSz9PTNn/cRfh59gSVlCiXMbBNcUy6f1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrasiwfP2K2/k40S1xZcI0oX0AKyW0N1V3XTQ3Qg+sY=;
 b=cb6FLQ+U28exi1DN7hLQ4mEcV3N5QRxwhuxlOy49pzGOgjQtzaBIWMHtw2Hwcqq+tQiDNZkIKjOEbL9GXd8PWCFNoMkC3Ya6BKrR/z0QIRkar+NjXdrcyo1fD6BcufjiO/pQ8zqd+7wf/mrVO7a+HVfPtFMa3SJN/qE5OIuwIEbog3adngl0o45aFQLmdCXS/zNelO5FSlcmJUw2cqeb5/8ZQfMSvZ6NYjdTu7IwsbKA3y+KxUhMs0McnI47xPN3c/+3J1WBbKMWBRnG+gHuTa+JZZYDQCu8giRspZhZHXf2THAH4TpXdP1gqwJKWj4BD3B1zeUELFKbcLo6dW92kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrasiwfP2K2/k40S1xZcI0oX0AKyW0N1V3XTQ3Qg+sY=;
 b=Ptw98LlbNPRZOeJ+pKKSEDsnIpCKo2sUOuIRH9Nh8HkR4K0ryoqd0lN1YC97q5FXOvwmvQYY/pICz5OqIbHEvJFaGW/txVwJXBtuQ6UQUPa0nVE33Pax2s/FNhBeX1qUSxsunzZlSkBtHljfgCc6dUuQstAs3yI2XJJQ5tJQWRk=
Received: from CH5PR05CA0023.namprd05.prod.outlook.com (2603:10b6:610:1f0::25)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 03:39:28 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::2d) by CH5PR05CA0023.outlook.office365.com
 (2603:10b6:610:1f0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.8 via Frontend
 Transport; Fri, 15 Mar 2024 03:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 03:39:27 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 22:39:24 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/8] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
Date: Fri, 15 Mar 2024 11:38:04 +0800
Message-ID: <44b62d7415b9c6cfa7467ff82e88566131f4bb9a.1710473712.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710473712.git.perry.yuan@amd.com>
References: <cover.1710473712.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|MW4PR12MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a63c1a2-44d7-4429-4c75-08dc44a18431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t6i8rsZOJT5uvjglUS0arcM7bzN7Iewi30CA+tigpnpc33ubg9vidU9U4ujb0PCgUXZVmfSqb4FgGh3fGPuGfDufD1S7mDFIolthZfs5PZju1PdNi+rJreTxZLTtzAdgCxIYX1Ffzm6cdmJ3y7fgEH0cZnSUmVwIr9Qu8j3j/s5GW04EpZ3fXCuPS+XH+TTbNC3JPAXA95KEuukpA6IxtIoBE6U3wd1KMl1fjkRNDa4OuYvRO+UweJTH4JUT3ddFgXr4INnTFZoaMi/zPrIMyEvm+9XyXBU7/kGRELu503UiAuF5ng9WzYB3836nEuBTTzli6dQzs5MvenI+koVaiwDA2q3x/1pxSDEQ5vz5XdCFThj6T9XfH464BhgZedhpm6CI8CqkZICNJykJOv/R5BmpFnAJt1RluOIPQ4eijf8rbCynglWkOU/n7o+gduB81nNijzs3k/7A9AJSdREul62kdCkk7Tu9dx5EGYrOMPnf+n9bctuoAfDPlr2iXOA149p4Xu5+CRUANyubCl1ZtGkZ5lh9GCVbqlq2P7WcOc/7fdt6NPTC3/FTqQl9ajsH5A7Y/1CHJJQWrf7Yv0hJ7G4sOFgUD5XB/IOsU13Ma3NVDQd+S+HOiOEZOp6HD9v6s9CzN5yDzqH44YIPDmXriq57RLhhghJouk8NEqWigLklzzXRLiWCGXnel7WDZ4RDb7d0ZoWaj0VlU7AHXNn+Qg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:39:27.7390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a63c1a2-44d7-4429-4c75-08dc44a18431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897

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
index e5eb09f874ba..025f35bd3b01 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1276,6 +1276,101 @@ static ssize_t prefcore_show(struct device *dev,
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
 
@@ -1286,6 +1381,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
+static DEVICE_ATTR_RW(cpb_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1310,6 +1406,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
+	&dev_attr_cpb_boost.attr,
 	NULL
 };
 
-- 
2.34.1


