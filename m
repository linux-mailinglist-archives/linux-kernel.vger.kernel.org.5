Return-Path: <linux-kernel+bounces-158175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED878B1C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7751F22DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6092A84A3E;
	Thu, 25 Apr 2024 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uYIC4eTl"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D115F82D9D;
	Thu, 25 Apr 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032522; cv=fail; b=a1TsPn3hmwZx5VNNP/98zsmqrb1/n6JDevHBY6m0hUxkwarpxLxPYnhRGZlPt1Dtwxgtak7eo39ci3xL/+CH4AIORnHAjArzjVswpd791iJ9Nn1kkey2crNz3bdjig1dt26jn7A5LigXPxiUdUF28Ix2Hml30hu4J9XwKuJebWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032522; c=relaxed/simple;
	bh=ckwcOBVNDuF40QHvqaELwzXzB6I9pFsprYsdpq4lBWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgTIF/BUdlD4wxNbDmtnRRBlnhJ6tVeGtLcQg+lbvdqgXUZ+BLdjLjXkSPV4mIZ8UoPXSow3cXkXv0NCVt1P3xRIKtq9F+Y18gC07JE/ML0Tlm21AlQ2KMudITMbyar6+enG4IaoJoBUuwF8lJJ0VFMDyZsl1fh3I1FbMSd7e9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uYIC4eTl; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8dzVek8ZZX4hzAIDsTCd5JylQbJm5ahHKg+2S+xQnWDq1DrcstppitvD9UA25/x9585aA/9F5Bx05ZMxJznzVAVC3XJyLBTqe7HUZLivyC3N3C09vZ11BVvntgS/7ecY+RhN4jxh/TkTsHPKUtSX0Ce0hc/+Z7lGhqn3cGWew+ofkQJM6dZdqYawJ9Xf4UtXlHyew6Q55+lnmknt50hT1Ho6kcHUzLnvcGr5gv+9PhdNXdZRHzplQIMaJWjiWM1bNWXlUGCiJTlR0Q9GTS9whEim4GX2G5ptf7l1l9ynVdM88nJE6rV32xxIdA/DdwfvorTLQHeTmhBfxCUdiHVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7Nnj+wrL8I671SDCrz9Xga9ZXP4NJdoC+h1QNGeU94=;
 b=gyQry7yNei3H4/PycS6aTJvqLpe3HWkTxIFWs//zDBUTAyFTiJqjAqcLkHlXagEwtVHuJEi3WYMCK1noRIgcL3G6DMQwwLpjDRCVGume5hCrRCJSOw5C0QJW2LTiDFq9wXuBKUThyqRKzzOSEiWDYigc038rWxbpVTkWO3jjewPQmVwYSIZ9EfRnmk4cAdiKURFTu7O7hTUPviHlIqVwDWKO77hvdmfY5G3lwE8VYfVU2YaQWSGyb/S66wMP2MPYagCxuwDh469I0+pc6Ne269zoVEJCbHOsVHsRqQFnUB8nqq92nRbRcEYsS5TQG2DmsWQpygSTi8eFIHnDSRJmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7Nnj+wrL8I671SDCrz9Xga9ZXP4NJdoC+h1QNGeU94=;
 b=uYIC4eTlrfufq1l9UsbdQoGRDI7dYGDb0e9qplfGNgrbSxYVs057Crry9C1eHmNzM9SCdjTeydTlb2y5PHhnEd+Ik4ktWoaesPrQc9RMydVu486vddcoStTrJq59wE5cnENkn8dz0hQrCEkwC1F8zZtGipWohWdYGjmTUm6f/wI=
Received: from DM6PR11CA0059.namprd11.prod.outlook.com (2603:10b6:5:14c::36)
 by CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 08:08:37 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:5:14c:cafe::f9) by DM6PR11CA0059.outlook.office365.com
 (2603:10b6:5:14c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 08:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 25 Apr 2024 08:08:37 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 03:08:32 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 6/8] cpufreq: amd-pstate: get transition delay and latency value from ACPI tables
Date: Thu, 25 Apr 2024 16:07:56 +0800
Message-ID: <23d8478a809e39748e140eef898c778a3d378697.1714032153.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714032153.git.perry.yuan@amd.com>
References: <cover.1714032153.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ce337c-274e-4d46-c448-08dc64fee937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a2b+GPSsMxkZoz5exjs0B8qkZUoSlgc8fsH+kuPv/73GUZBVCaIvAe29HvRg?=
 =?us-ascii?Q?lekMnAXTCVs9Grt2Ng0RvTENoxEZfnpGYEFc9JTYJ3L+RnxZa0mJ9msEUNXb?=
 =?us-ascii?Q?o5b5nP5BtsnjQE1Y4GkkHecMWwcmyOxBE+zuZ6FDvUE0YJLrELXM6cP3U6i3?=
 =?us-ascii?Q?FB6sWJPE8ApTM2ri1/J1smGL9FdM23hpjzCfcdLEPMfDnp1l5cGzWrMXRs+6?=
 =?us-ascii?Q?HUI1EorvdrodxSZusQMwICMkZCnUNKG77Hvbm/ah2Ckqt6O5BNSPMxpENH1X?=
 =?us-ascii?Q?qqYUTsRYJC1Xe5Gq2zYP6JG0mkJQVwjAr5z7teBjijsXylbga/oymkJYk24n?=
 =?us-ascii?Q?pGkiD0FRtXldKYgQ0d2FdQpq7swVI8U3q0/BoPZiWB53FVu5KGPGi+uJuvjG?=
 =?us-ascii?Q?kLB6oPWoJs6iyTtQQCkZ4YSwo3G7NERBUqrQDiz0OVZxw5LaF3OmASFKkMGZ?=
 =?us-ascii?Q?iIyjWlB62GFIMgSNUiI/FVmXJ2j2JrLGI+BCkmvNY/eE/Y9UZU2wb/8FGAhv?=
 =?us-ascii?Q?5FSqfI9WaxkujUsO3etuv+IgJqPDBhCA0r4EEMMAw2dccdawMWe/7S/qidsC?=
 =?us-ascii?Q?r+9CJL6oBAFlrmEQPlzhImQvPO7kzP8ujs1NyaQQb7MxlMpGfhoGinzSJp5x?=
 =?us-ascii?Q?ntBxwftXXItR6hicnhK++ZE6Ed7bKrUaHBP2KIx91qwBH9BbvXDsxO8DP7eU?=
 =?us-ascii?Q?xrNgHpkfgNIoFt/L0TThjRiwZbFF0V5LV+hkLOdEYXmOlGt2s4Cf9B1CU2wx?=
 =?us-ascii?Q?d6fmqzqtr3exLz8iQSb4tMKLndS0DDGpF2IlqRAvHKUPDHc0eKMvqei7sp7h?=
 =?us-ascii?Q?ra/9IQeuDglQ+IotQZk+1JxSJkBLMEF0YA7VH4ZKxYcf00IhgYJMBukaILtJ?=
 =?us-ascii?Q?tAbiIXhseXDNgBbNRu42wiEHkJqv9KzW4vycHBJj77RQYm176TJ43Aqqz7ZB?=
 =?us-ascii?Q?wT0xMc9ArXIBFh62Yoeay+CwL8wqiWvBBG7FUCY8v9Di45+4bgljDYX0E2/H?=
 =?us-ascii?Q?EtjZ1byg5gAB+JNHEzFoZi/qyHzuKw6+gJKLDBqerht7aiAtMwd1k0oqW8j2?=
 =?us-ascii?Q?5v0MixAQn3KwqfZm2gZ8gRs85mtO2DKyl0RuMfO0Y6Za1jFJpbU59dWbDPYW?=
 =?us-ascii?Q?tL0piJvjiS0reqpI6Ll0kmlQcbNLs6+OXhWXuAs1E+IkFntdt/YNY5Y/diCd?=
 =?us-ascii?Q?04h3pG7O9Om44NnG5MmxORCbcwupO54SrMIJmh0XBglENlLQEnevWfAJ+WnL?=
 =?us-ascii?Q?AlCZyYb9ivO5efYBxQYCr/e8vepM1uhUtQd6HPvmZk9LOzlbZ2j3umwBFsFe?=
 =?us-ascii?Q?2bA/fIIDWxM4P+Lj2Oqve8aZvzyQaXbmn3F4wAw+uqfMWWPc6F0gSNsBK6Fm?=
 =?us-ascii?Q?n+Ej+fE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:08:37.6359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ce337c-274e-4d46-c448-08dc64fee937
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904

Make pstate driver initially retrieve the P-state transition delay and
latency values from the BIOS ACPI tables which has more reasonable
delay and latency values according to the platform design and
requirements.

Previously there values were hardcoded at specific value which may
have conflicted with platform and it might not reflect the most
accurate or optimized setting for the processor.

[054h 0084   8]                Preserve Mask : FFFFFFFF00000000
[05Ch 0092   8]                   Write Mask : 0000000000000001
[064h 0100   4]              Command Latency : 00000FA0
[068h 0104   4]          Maximum Access Rate : 0000EA60
[06Ch 0108   2]      Minimum Turnaround Time : 0000

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 960fead0b83e..510b5aec42ea 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -756,6 +756,36 @@ static void amd_pstate_update_limits(unsigned int cpu)
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
+ * Get pstate transition latency value from ACPI tables that firmware
+ * set instead of using hardcode value directly.
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
 /**
  * amd_pstate_init_freq: Initialize the max_freq, min_freq,
  *                       nominal_freq and lowest_nonlinear_freq for
@@ -848,8 +878,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
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


