Return-Path: <linux-kernel+bounces-116438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC6F889D43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0351F36A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240E45025;
	Mon, 25 Mar 2024 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jbtkbAki"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895315ADAF;
	Mon, 25 Mar 2024 03:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335870; cv=fail; b=LIQ7KQSH3sNihtPvZoZXz8E9MwNtEt5aij0WIxeKQ3B6uGWX0VIqxM8asYG4wLxz5q8Etr3TlLGtWudB5k9n9vLV62GPaEMXuVanj2POdPUybLb0UIgrdbhHhpLNUe9bSyqvAHjaQiWriyUBqNCL1uVSHcYJIethHlJxit9TxOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335870; c=relaxed/simple;
	bh=u/29lxx6P3jJY06y/MlO0KNSHgH0dFJm/PTw0ln0roQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JR3Eix/1/Kn1q0O9iEMXX+97Q7pXsH2v2DQdLDgi/Apmkc2Z0Y/eDsQM6M5wio1XasZ5Ksrx/IpB7g/6dk9Ye+Fx6Qh8CU4CDcnMgmlccyvltc05HqeOa3SAgrUFW18PAAl8fCTc09DSEfxbBlCCnwqqhk+aYBpMH0He+eQGlS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jbtkbAki; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj1DC4tqH4mUFibRcv6n8epOdpQeFmvwF2XOt2Ld0BDJYPw8kHXZhPSzBzAthJpDprvlKGfy3vOpPNMXRQ6vCAbtPFxHmpVlYjmTv4KPWY6usSWB7vKk2yRQOkeZFV4ESfE0QYsZg4lPp+pB6lEmi8G/DWfEcS6MWzj1VXT4Ep62nN9zUYt5t9GLT3REB5cJHXV+QtyzC+mXETfjQri6hLr39Sie0CXSGogCz/vFr05de589oak10mN/IbYH7bz7//rWlCpbSPVeWRUL7Z7gDU4Qq/IvoArdpc08mxHqjW4BdgaA6mUiGtyK8fCWvt4aG8Q4XBA7G5NS9ZugXHZeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyHZI/NbrFxwgpyH6bobGsGnDM43kezAw9cH+FygoJk=;
 b=iGMJtUCJ9PLZ/4WB9OZJs01Sk6e0T3AH7a7P2AMjs1gGtsmTSgzD2fg7I1NGBDPb+jkiwmempwVWuvlQzM1K+dLlvLWJuqmf1JAVpOAHloy8xeplTVCdwJhM2UqjxPK8oBhe/0oos6VIiUUffP/XA/P1qmm6mFwqSK5hlVNfxlfxJj0wppxCZ4y9wd67zRKbFjqqAyt0Hst18SjLXTKYgCLbMKEGp1GV3lyHF1FM/oxJvlyoIJgDUDsxQGnqKoz6dK4tGfoiigEI426AgypFETlmD84G+ln36uEjwO9vCP09XFe8Wcu47GFZQudYujYjTdiN32hkSK1IKixL3rIKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyHZI/NbrFxwgpyH6bobGsGnDM43kezAw9cH+FygoJk=;
 b=jbtkbAkihW839ZfO6q2Fq1j7mPzTNM5gpKC+LS7ZS+vTLOKG7Z5vavQx61JUBSAS//T5r0q0NqaU3J4i1Pw6O+W/wYzLG15cyou1J6zHwbCcJ93lHGNXE+XrKbJLncdjt+DlssmSiFPRnbIGvQ6DUQEBk6CLF+TEam6Leb61/o8=
Received: from PH8PR20CA0014.namprd20.prod.outlook.com (2603:10b6:510:23c::24)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 03:04:25 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::67) by PH8PR20CA0014.outlook.office365.com
 (2603:10b6:510:23c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 03:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 03:04:24 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 22:04:21 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 6/8] cpufreq: amd-pstate: get transition delay and latency value from ACPI tables
Date: Mon, 25 Mar 2024 11:03:26 +0800
Message-ID: <ee3c290dcdce4a746fbd882d37e9a45504a5ae3d.1711335714.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711335714.git.perry.yuan@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ec493b-dc1f-4f1a-a687-08dc4c784703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZbmnxRJnePZLZPXyN+0W1wzwcFCZa8BxB9pjPL0LEetO5cePw3Tc/W8oNI5c/QYyOEzjFCnvA8/REMtPva8eeG0Wu6G2YAEQm/AjLjL+z1cxz5QywhsGkAmrUkIIO3l3lLlOkjv4FAF0DNfYs3AwmP8Lc6wIsZjz7VZUK9KjuCXrEHxsq7MWRmG6vQBppVyPJdQECeRP9LRMpQmz3C8Xxg/y28kya8a1kYQ6PvaKqLlwrR8X40VnnKsi2LqTH2bRugzGfm5BTX/Hrol086/ttMQAh6noY9Cr8A/ip/JrRB9dm1wURExzVWzXd0SO0DN9hvQVMcmbc9SKVft+nQFhVXNp1qxpg66m+ldICVGcFSRZ2NnW/mWttsPjx6Mo0l/APo9ZSBsYyW2zn0mi8yOafvY9dE71thrVJpY6e5bVqxwvODjqnlz2cJmsWcIJkJl0P/TiDvZPgANDwtnG0JIFysNNX/s0P31jtUqUMmWUsbcmZ9qw13whwaryrZ91g7g+1fukHPHK3ka5cM/pNn+LkhrMM5Qb+98+77PDmNIXcRGolplNdqrEiweVFd5rKnaeb7fh8FxCa9Kuq9W+Iz5b3nRFoGh2UWbyev/HLc7rE0u+YeuQcW87mJTPkB4CzZEVjWz8/GauOVkMcm5gk+KeBCHtqr4BGB5ZoRLg1q2dsaZzRq9T029awsXPKAfkUCfw3/Pk2IOtGc/FOuQxVbReZc5IP6CPIyNRyaB7xTb2MjVfJ8vQZgogDmBu+Ncc/gyr
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 03:04:24.9882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ec493b-dc1f-4f1a-a687-08dc4c784703
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516

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


