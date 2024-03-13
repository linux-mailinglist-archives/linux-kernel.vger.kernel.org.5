Return-Path: <linux-kernel+bounces-101311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA2287A56F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03AC1C20B82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57C23C6AC;
	Wed, 13 Mar 2024 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xSVNStdi"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C43B784;
	Wed, 13 Mar 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324060; cv=fail; b=QArMU538gBgbFAgwX9jH5IX9z0uKghIUxaWl3yG7nGOpereJ0UCu2SgX9XrD3cXswCo6f2PaOnYOqeQYJV1YvlbQsUJFVWjnipZz5JujyVRp9HCAojoZUXOoYH05Po+Nh4wRSt+NybpVPtbobE9v/G70JR2a7jBBtSQmfh3Hux8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324060; c=relaxed/simple;
	bh=tFFUHZSIBy2VAcUx/SHgg8f7JHunBYp+CfzJLV/T/Zc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+YU3ByiePl6DgUS2z+83jeoJ/195arXh0aK9dib5jky1y3BZXFnXKJAO9Z7ObK5zFYWViiAbA3T0uZafXZdH47kbkpM5ftf5lzj6XTYCa6WL2NrX6uew+ZZ3AszdthlR6B3JfO/T13CjMIqkUGN76dBP5QTGPjMp7cdzoaj+yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xSVNStdi; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/CMtI1IR4m7E8suY2Yl8hyn6wwwaiF2zuRSsDdAZ8wFEYK1AfiGBx3cSTp/iLWFPYlmBGPBOxCx3DRGUBMjMsVPe8gWG9dQZLArqa/916XsqBpUoXtK7qR+Rjhu0jzwC2LWvdUscZp+kfOpQ5jg4EW+MhEbe607LrcC1ltQxCh8LZCA1q2U8bwT/QJm2/Qbheaj8kBfrjxHBj4qgwpNJCVMmdQTpubUTJ77vk8M1oq7UHTV5p0U/XSEUAyyqNc08p3W+r23HyD8TbCSRPh2xl7RKy0Oce2zvwUkc6QU+5Xs5D7NJyFN3AyOHFFFCLXsVlcU/1wIyQRdevWDdb2Dzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjCRBnNEShlzlvRtTZXG3+HzhkmrBxfrEeKxtggpS8E=;
 b=WMqtNy9JOd7+UqFxMO/j51nPvQIKAh9nd5OqHr7+8H4pJLG0ESjEXUPXd2v2kJ3zHqwXPcInEkneTTi/BDLN2jXBlkPadwiKOBKbJil5zuyFpR4Tq3DZZxSHsy94a7ey3AV54tkVXJ1Srp1IMoS+JZ7zkzXfcuUwkmaLI3NRbtWdQPgyrHwudAjFlntmx0UZsJ3u9bRAwf7wAinMFGczfNa1bZm60AWK3YWEtBUbGhdbLj/3lcHCWRlGqlV+ccErBBD0rINahgu2D4E5ca1WXUJ+mzQJ3e/M2mPfJJId3Jzb5G3QJoB1WM5xYdmEACJ45MgbFijAe5E45DbgBMLC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjCRBnNEShlzlvRtTZXG3+HzhkmrBxfrEeKxtggpS8E=;
 b=xSVNStdid977QQHqB0YT9CchYeK7uODgnKqA8l2p0wb5zma6n+E3uzA6GfSlYWOuv3ShcAWV/2GFq4O4OcXv+YolqCYUTs2xo56g8qJDFA0S6te8RvaaKf8M9vvc4zj2/mLJk6B072M+QZW20jmCjs4kbS1TraKbBDhX1SMzeRg=
Received: from SJ0PR05CA0079.namprd05.prod.outlook.com (2603:10b6:a03:332::24)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 10:00:50 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::cc) by SJ0PR05CA0079.outlook.office365.com
 (2603:10b6:a03:332::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 13 Mar 2024 10:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:00:49 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:00:45 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 3/6] cpufreq:amd-pstate: get pstate transition delay and latency value from ACPI tables
Date: Wed, 13 Mar 2024 17:59:15 +0800
Message-ID: <705e1a21a6a9d91a7ac67526c55c2961318ad678.1710323410.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710323410.git.perry.yuan@amd.com>
References: <cover.1710323410.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a097344-77e2-4d22-d106-08dc43447625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	08zR98KB39+E92cnN4IDXE02A5MXesiRi1lm4if2h4bbPMCPMiWZsXufTcvdaJ7djiAijithtSqyMkw39QtRaXx8OmFNaQmCxu5dp0ug6v/Rns4E849hUl/TauSMtVxbLY9zkx9fF5hD2DbjYcI6CGHnvU3qyxUVuTejuoTy3YeZa0FKiBDr023FQoTdVELaMxhmlBwEpRAi+1eotGZRb50A/1rzLIwEKaGDQtkmtrUOwuVRVdfbS2PMv5mft50JSL6Ya1KX5KK34fEIAseeX44FGwZ1j/MsGpIawauIP09h/QfPQMY4Dz/MUgQUt9ed4p90Z21iIrx5Jioqx5Ww/9hQ5WKMThOZshaXz8xHoiHgzQa4uAmKh1ZhPn0HnIt5/UfGfxcHGGtJolxdQhodSokqZebnNGU5R8cdz4MvHxpxxS9S+rW/Y5FIcA4fqqT4UlF/UF3q2rPHHyudrXiI7P0Sl2eyYQdgWUhzsNxtO78vHcDg2yVuS4q5Ktwjl49NrsRcbp9oRDRvKTK+d5IC1vRjHbd8Uck9dl0Cw9gO6E4x3UReimcwaSEWeOOAUFMwMmRPqhU/8mIgPKcwQ/y0xx4KMwmR+RZUY3ZsSwBRuHu+j0MkqRgAySzszEQx+CBST4OwLd8PmYzATg+glQiKdiP37pRJf0VDrRdsJV+IPjAXXXefBpqdzAq/X0cRA3gkL3L5vLYdIR6uwbqMO4Llr8TCw1apREs454ncIdLeLhxT6NcBCZuB4gUS6/NYIcEZ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:00:49.7232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a097344-77e2-4d22-d106-08dc43447625
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370

make pstate driver initially retrieve the P-state transition delay and latency
values from the BIOS ACPI tables which has more reasonable delay and latency
values according to the platform design and requirements.

Previously there values were hardcoded at specific value which may
have conflicted with platform and it might not reflect the most accurate or
optimized setting for the processor.

[054h 0084   8]                Preserve Mask : FFFFFFFF00000000
[05Ch 0092   8]                   Write Mask : 0000000000000001
[064h 0100   4]              Command Latency : 00000FA0
[068h 0104   4]          Maximum Access Rate : 0000EA60
[06Ch 0108   2]      Minimum Turnaround Time : 0000

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6db9256f42c0..ec6259957d25 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -827,6 +827,36 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	mutex_unlock(&amd_pstate_driver_lock);
 }
 
+/**
+ * Get pstate transition delay time from ACPI tables that firmware set
+ * instead of using hardcode value directly.
+ */
+static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
+{
+	u32 transition_delay_ns;
+
+	transition_delay_ns = cppc_get_transition_latency(cpu);
+	if (transition_delay_ns == CPUFREQ_ETERNAL)
+		return AMD_PSTATE_TRANSITION_DELAY;
+
+	return transition_delay_ns / NSEC_PER_USEC;
+}
+
+/**
+ * Get pstate transition latency value from ACPI tables that firmware set
+ * instead of using hardcode value directly.
+ */
+static u32 amd_pstate_get_transition_latency(unsigned int cpu)
+{
+	u32 transition_latency;
+
+	transition_latency = cppc_get_transition_latency(cpu);
+	if (transition_latency  == CPUFREQ_ETERNAL)
+		return AMD_PSTATE_TRANSITION_LATENCY;
+
+	return transition_latency;
+}
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -867,8 +897,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata1;
 	}
 
-	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
-	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
+	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
+	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
 
 	policy->min = min_freq;
 	policy->max = max_freq;
-- 
2.34.1


