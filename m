Return-Path: <linux-kernel+bounces-105914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F8A87E652
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55571C2186A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7822938396;
	Mon, 18 Mar 2024 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PctefecL"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ACD2D605;
	Mon, 18 Mar 2024 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755357; cv=fail; b=msvWen9u8ZEUi4zVoJHRQfwqojH6DDyzwbz2grdvZU0W7pUW0nRD/ZKLutrU8/ZEMi9TwWXFoQXxr03hBw6beRoJM8bO5ulrgKX5XfsNg+hWEictdhPQZXAa6C7NdcwUMC84qCi96FaWCL8hAfw90uTpkTlS+qDh1H/F0Tr9oDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755357; c=relaxed/simple;
	bh=HxLM1S7chiUDtjTKDjPXsfoeLT5X9ifSO45QSSAeVgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdCJDO0BxF3wXCfiMHXk1+hLeCzlluJVmysZOZ/EVSDENm92u2zuU5oBegFQs0wkV7b6unpFDsuE/MHciTxJB09FcRNMOsQW/hdZ3IlSscLmzurKytQhH+fXOISU4nuveGs2AtO7FFs2MpTuHBmBGCJPOruGG4Mqn+KFYScxpiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PctefecL; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRW/QPoP/tMdU0i05ehv8PVbob2WPN0R2tpvdfEWk+Rv/sQC9GoCJwH+/LIpbbdDsLXKYumcJ8renLpljD4VJrGXPyliTdfHe5k7pGc+9A0sB+nOHdwFmdqDWM7tLQIxxD/qZXqJoHa3Qdj66EdJXN/AkkOBSLd1igNe0Nh+PXJUUe7q1xWAQ/cufGJwytZwE7AVJmTWoRQYcStZNOYfjbIgUNPP8EoW+fA98r/zLJenQGUTd/OqrF2OACRvkVrtqHhLNnOUM+m0f/9uOK72QXT6eRrTqlxzpJMh0Wid/oRoE8S0ptfZo3J4++iU6jgKDuTOkAzXUM/oJpLIc+14NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4AiBn4/w92cQ2LTQGxZyIGJbS8twcjPhgQ1q/aWSzQ=;
 b=jYQgCIXJ6yBsvQdg+Pm9rg1WIrhLjhTAT6pWy+nvgA05FQeP/cqNx7FivzuaghSnAAUzQQO3is3FzNxdpjMiqWTubIWabOQ85ZJ7Icd0Zj3cWlfN+PW8i7qcgpVslSJIfR8wvXtnnfQP7sU3WMy6ULlAeDuwpvOEcJwdss3b5aebcrjNgBKA5r3EguvFSUjm65sefli/RbdD4aGriayN7fpitgtEE+Hd/Jg2BNgSzvOOEOKaLJIKYE8yc+uI7u3X2a7bzNbB/TTvsO+sVrUTKl48ogo1CmbYem2mPXa0sV0mIs1WEUeaQd41fq7pVqpkkGV5IBpkxugKjVssbDp1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4AiBn4/w92cQ2LTQGxZyIGJbS8twcjPhgQ1q/aWSzQ=;
 b=PctefecLT+HXllJO/8vJLM2kdRw9bYhtyKv5QPTZPBtzNqpxLNVMONk99bTRlYt3eEtjaQ/PQdI0c5SuEF1/pHgf0oEvBmAohbJiLjQetGAkw26u7LRny7b2blSrR2WOvhQRGd7PWKqOTWs0vAiJj5eBxRB1COEpR0S88SVcr8U=
Received: from SA9PR10CA0030.namprd10.prod.outlook.com (2603:10b6:806:a7::35)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 09:49:12 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::56) by SA9PR10CA0030.outlook.office365.com
 (2603:10b6:806:a7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 09:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 09:49:12 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 04:49:06 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 6/8] cpufreq: amd-pstate: get transition delay and latency value from ACPI tables
Date: Mon, 18 Mar 2024 17:48:25 +0800
Message-ID: <097b6711995aa16fc55f2688bc5d01fb8e728ce7.1710754409.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710754409.git.perry.yuan@amd.com>
References: <cover.1710754409.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: bbeeb424-b0cf-4828-e50e-08dc4730aa59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PrH0oSLvl0ytpQdDmZzGaHgjxOKwMPW95vtkB62QIPGK++J/PzKIHcEnmRdfwVKkmd8IMjIZNcr2GxNZBQuYKYsrNCeynHvZLrf7/UimqFfRXTQ9dx4Ayq7vhm+s65kFsUnCyiSSughuihtyxP0AKLgj7SaC/4kQevNw4FCJj92qXo5dqOdOelLtv9CSsrDqN+5tHTHRyCzdL07AqMG2Wsx6NVRykR8WTjOvq7KZ86uoXYfeb6CygHNlA9t0+hqXH127vwlDTGiaKKSDKXZE7aYe5vaq1nk4I6zVat4cbRIgUrhuSQwaADMJn5byKRIRzCKcoEPPh/wj5EgZToECcA4OV4w11xysu04Ot5M84bBOCCeQY6sqx/hvD0XPz74lv4i7h28gWKjZJRm9XpMCazdlV6CrBLR4Yy++/wAABV4rnP/CMfhJjEOB5uxbUkfLABI02nk8f0vo8a7hGsGP2BtfA0z4q/HGFTFhortsCWdWpVKO9XvTBdKQIUBDJSMl6MPNCnnbpYQ8ff3IGvxuMjCfT46PbA0nhjFsTsk7oXS5Q9w9qF+JWJ9aWy3d4HuTgxwjgSFTwmUdLQ04vnkPu6syIGWhLTTww1Wjw9WCH7co7LO0PtPn/GW8AxMmnmv9ehi7TPLIEYcD2ruJ5D20K50moI+FjVeLydbAZEnSr+vXHLva6lFloDkL4c7kaO2YeWQBRA1/zV6+JlYhxCAChSyyLfOzUVHATuQbRcRg65fvLyVjXe6+wZEerw4SI44E
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:49:12.1163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbeeb424-b0cf-4828-e50e-08dc4730aa59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990

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

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6708c436e1a2..ec049b62b366 100644
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


